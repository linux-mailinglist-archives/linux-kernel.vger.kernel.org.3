Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435A447D085
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbhLVLLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbhLVLLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:11:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BC2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:11:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE8B561987
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 11:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E0CC36AE5;
        Wed, 22 Dec 2021 11:11:10 +0000 (UTC)
Date:   Wed, 22 Dec 2021 11:11:07 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm v4 32/39] kasan, arm64: don't tag executable vmalloc
 allocations
Message-ID: <YcMHyxOIN0LD7Lrt@arm.com>
References: <cover.1640036051.git.andreyknvl@google.com>
 <85ecef50788a3915a9a8fb52e97207901f27b057.1640036051.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ecef50788a3915a9a8fb52e97207901f27b057.1640036051.git.andreyknvl@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:02:04PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Besides asking vmalloc memory to be executable via the prot argument
> of __vmalloc_node_range() (see the previous patch), the kernel can skip
> that bit and instead mark memory as executable via set_memory_x().
> 
> Once tag-based KASAN modes start tagging vmalloc allocations, executing
> code from such allocations will lead to the PC register getting a tag,
> which is not tolerated by the kernel.
> 
> Generic kernel code typically allocates memory via module_alloc() if
> it intends to mark memory as executable. (On arm64 module_alloc()
> uses __vmalloc_node_range() without setting the executable bit).
> 
> Thus, reset pointer tags of pointers returned from module_alloc().
> 
> However, on arm64 there's an exception: the eBPF subsystem. Instead of
> using module_alloc(), it uses vmalloc() (via bpf_jit_alloc_exec())
> to allocate its JIT region.
> 
> Thus, reset pointer tags of pointers returned from bpf_jit_alloc_exec().
> 
> Resetting tags for these pointers results in untagged pointers being
> passed to set_memory_x(). This causes conflicts in arithmetic checks
> in change_memory_common(), as vm_struct->addr pointer returned by
> find_vm_area() is tagged.
> 
> Reset pointer tag of find_vm_area(addr)->addr in change_memory_common().
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
