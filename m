Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8CF5956EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiHPJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiHPJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:46:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C7BB81FB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:16:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7EDAB81676
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D37C433D6;
        Tue, 16 Aug 2022 09:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660641412;
        bh=RCNCXlx7jOfPAXdgaKKdD1Ixni46vQe72pncfwQwk4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYM/KPVcKBlfC0RZP2E1ThUWz2FAq7nhixhlQIgpBXSHYhmg5kRYc8/6vL1U5EG0u
         GM2F99Xwxi/GRJgsF5auG1EmgSmJy46L6781nVIR5y2hAlMlsWQT2iDRR5lF1XDIKb
         Zd4SCD5Ph79kq6IuXqxeusnXRolJf0rUwYwbZ5/8=
Date:   Tue, 16 Aug 2022 11:16:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
Message-ID: <YvtggZeUF9+xQu7D@kroah.com>
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:44:26PM +0800, Kefeng Wang wrote:
> From: Liu Shixin <liushixin2@huawei.com>
> 
> The page on pcplist could be used, but not counted into memory free or
> avaliable, and pcp_free is only showed by show_mem(). Since commit
> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
> significant decrease in the display of free memory, with a large number
> of cpus and nodes, the number of pages in the percpu list can be very
> large, so it is better to let user to know the pcp count.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/base/node.c | 14 +++++++++++++-
>  fs/proc/meminfo.c   |  9 +++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index eb0f43784c2b..846864e45db6 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -375,6 +375,9 @@ static ssize_t node_read_meminfo(struct device *dev,
>  	struct sysinfo i;
>  	unsigned long sreclaimable, sunreclaimable;
>  	unsigned long swapcached = 0;
> +	unsigned long free_pcp = 0;
> +	struct zone *zone;
> +	int cpu;
>  
>  	si_meminfo_node(&i, nid);
>  	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
> @@ -382,9 +385,17 @@ static ssize_t node_read_meminfo(struct device *dev,
>  #ifdef CONFIG_SWAP
>  	swapcached = node_page_state_pages(pgdat, NR_SWAPCACHE);
>  #endif
> +	for_each_populated_zone(zone) {
> +		if (zone_to_nid(zone) != nid)
> +			continue;
> +		for_each_online_cpu(cpu)
> +			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
> +	}
> +
>  	len = sysfs_emit_at(buf, len,
>  			    "Node %d MemTotal:       %8lu kB\n"
>  			    "Node %d MemFree:        %8lu kB\n"
> +			    "Node %d PcpFree:        %8lu kB\n"

First off, this sysfs file is a huge violation of the normal sysfs
rules, so I will not allow any new entries to be added.  In fact, the
whole thing should just be removed and multiple files created in its
place.

Can you send a patch to do that instead please?

thanks,

greg k-h
