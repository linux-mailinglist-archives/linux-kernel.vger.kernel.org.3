Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182FF49F8DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348272AbiA1MGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbiA1MGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:06:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F5AC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 04:06:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D44561AB8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E625DC340E0;
        Fri, 28 Jan 2022 12:06:18 +0000 (UTC)
Date:   Fri, 28 Jan 2022 12:06:15 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [arm64] kernel boot slowdown in v5.10.19 -> v5.10.42 update
Message-ID: <YfPcNy3JcnwuJNMx@arm.com>
References: <9a34ee9b-0ede-30a6-0898-d32fe81d5b0c@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a34ee9b-0ede-30a6-0898-d32fe81d5b0c@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:03:48PM -0800, Vijay Balakrishna wrote:
> We noticed 150ms kernel boot slowdown back in June, 2021, when moving from
> v5.10.19 to v5.10.42.  This on a 8GB SoC.  Only recently we investigated
> this issue and found the regression is introduced by a change in map_mem()
> (paging_init() -> map_mem() -> __map_memblock(), in particular "map all the
> memory banks" for loop) by patch
> 
> 2687275a5843d1089687f08fc64eb3f3b026a169
> arm64: Force NO_BLOCK_MAPPINGS if crashkernel reservation is required
> 
> above is a follow up to
> 
> 0a30c53573b07d5561457e41fb0ab046cd857da5
> arm64: mm: Move reserve_crashkernel() into mem_init())
> 
> which deferred crashkernel reservation into mem_init().
> 
> The ~150ms slowdown disappears on booting without "crashkernel=.." on kernel
> command-line.

Is CONFIG_RODATA_FULL_DEFAULT_ENABLED set in your config file? It may
cause the same slowdown. I suspect it's because we end up mapping the
RAM at the page granularity so more loops and slightly higher TLB
pressure. Not sure we can do much about.

-- 
Catalin
