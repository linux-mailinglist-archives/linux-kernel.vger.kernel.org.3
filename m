Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57131511E08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243890AbiD0ROD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbiD0RN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:13:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E5E3EA8E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:10:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFEB5B828A2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6550FC385A7;
        Wed, 27 Apr 2022 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651079441;
        bh=l8saX0DCGAYsIkk1Ixkvp/bP+VE4XtuTAfKwaVWt6eE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zU2f9OU9vNaGvbUQZABYEJIyDv0rbP4jQWq8LFn5FZq7Dw+LFamnG2tnxulkmfuml
         CKaNkOqoROiQdOY9ssBOvhnnTObaTy210EIDPYP7HrkfOYZ0T9VvTB26TOJMzdQh2m
         1P9vBSidPcXS8wUWvWett4r2Tb3DlvNCcpvTz8zI=
Date:   Wed, 27 Apr 2022 10:10:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 1/4] mm: ioremap: Setup phys_addr of struct vm_struct
Message-Id: <20220427101040.bd4532c8ef093b47b3dd9eb5@linux-foundation.org>
In-Reply-To: <20220427121413.168468-2-wangkefeng.wang@huawei.com>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
        <20220427121413.168468-2-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 20:14:10 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Show physical address in /proc/vmallocinfo.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/ioremap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 5fe598ecd9b7..522ef899c35f 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -32,6 +32,7 @@ void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
>  	if (!area)
>  		return NULL;
>  	vaddr = (unsigned long)area->addr;
> +	area->phys_addr = addr;
>  
>  	if (ioremap_page_range(vaddr, vaddr + size, addr, __pgprot(prot))) {
>  		free_vm_area(area);

Acked-by: Andrew Morton <akpm@linux-foundation.org>

I checked a bunch of arch-specific implementations of ioremap_prot()
and they're already doing this.  As far as I can tell, only csky and
riscv actually use this file (CONFIG_GENERIC_IOREMAP=y).  But you're
ARM(?) so I'm wondering how come you're patching it?

Someone should do s/addr/phys_addr/ in this function, like the rest of
the world (sensibly) does.


