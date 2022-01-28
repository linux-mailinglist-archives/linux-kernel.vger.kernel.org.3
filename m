Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB71A4A00DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350940AbiA1T3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiA1T3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:29:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480B6C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:29:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D98EF61D42
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 19:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8977C340E7;
        Fri, 28 Jan 2022 19:29:29 +0000 (UTC)
Date:   Fri, 28 Jan 2022 19:29:26 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lang Yu <lang.yu@amd.com>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/kmemleak: Avoid scanning potential huge holes
Message-ID: <YfREFu1sAJ+Yn6jy@arm.com>
References: <20211108140029.721144-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108140029.721144-1-lang.yu@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 10:00:29PM +0800, Lang Yu wrote:
> When using devm_request_free_mem_region() and devm_memremap_pages()
> to add ZONE_DEVICE memory, if requested free mem region's end pfn
> were huge(e.g., 0x400000000), the node_end_pfn() will be also huge
> (see move_pfn_range_to_zone()). Thus it creates a huge hole between
> node_start_pfn() and node_end_pfn().
> 
> We found on some AMD APUs, amdkfd requested such a free mem region
> and created a huge hole. In such a case, following code snippet was
> just doing busy test_bit() looping on the huge hole.
> 
> for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> 	struct page *page = pfn_to_online_page(pfn);
> 		if (!page)
> 			continue;
> 	...
> }
> 
> So we got a soft lockup:
> 
> watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [bash:1221]
> CPU: 6 PID: 1221 Comm: bash Not tainted 5.15.0-custom #1
> RIP: 0010:pfn_to_online_page+0x5/0xd0
> Call Trace:
>   ? kmemleak_scan+0x16a/0x440
>   kmemleak_write+0x306/0x3a0
>   ? common_file_perm+0x72/0x170
>   full_proxy_write+0x5c/0x90
>   vfs_write+0xb9/0x260
>   ksys_write+0x67/0xe0
>   __x64_sys_write+0x1a/0x20
>   do_syscall_64+0x3b/0xc0
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> I did some tests with the patch.
> 
> (1) amdgpu module unloaded
> 
> before the patch:
> 
> real    0m0.976s
> user    0m0.000s
> sys     0m0.968s
> 
> after the patch:
> 
> real    0m0.981s
> user    0m0.000s
> sys     0m0.973s
> 
> (2) amdgpu module loaded
> 
> before the patch:
> 
> real    0m35.365s
> user    0m0.000s
> sys     0m35.354s
> 
> after the patch:
> 
> real    0m1.049s
> user    0m0.000s
> sys     0m1.042s
> 
> v2:
> - Only scan pages belonging to the zone.(David Hildenbrand)
> - Use __maybe_unused to make compilers happy.
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
