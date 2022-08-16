Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24126595A33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiHPLcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiHPLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:32:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E859C52A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1098461038
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D7DC433C1;
        Tue, 16 Aug 2022 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660647033;
        bh=3Skn3Dxm7mLcgmejceAdOhPccdXPh+grRmHbOhCB8Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R00EOGsCT5xr5Gs01gtbO6VV3r15NkcCu+SgfBkY3+wAUGKEuwXRgT8hBskQeA72z
         4o10IryK0TpATyIe4WTIMd18PNbl6HvDPZ5WYUP0E+Ng3fN2vmEEBNal0Z5Q/50oFr
         Cd7iQ1bc+0eOMHl63e1coLndXnRD+McQQE1R7rEg=
Date:   Tue, 16 Aug 2022 12:50:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
Message-ID: <Yvt2dhNhLX5fH/nH@kroah.com>
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
 <YvtggZeUF9+xQu7D@kroah.com>
 <7bdc252f-15dd-8d92-9e08-1ba7dd8308ad@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bdc252f-15dd-8d92-9e08-1ba7dd8308ad@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 06:11:18PM +0800, Kefeng Wang wrote:
> 
> On 2022/8/16 17:16, Greg Kroah-Hartman wrote:
> > On Tue, Aug 16, 2022 at 04:44:26PM +0800, Kefeng Wang wrote:
> > > From: Liu Shixin <liushixin2@huawei.com>
> > > 
> > > The page on pcplist could be used, but not counted into memory free or
> > > avaliable, and pcp_free is only showed by show_mem(). Since commit
> > > d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
> > > significant decrease in the display of free memory, with a large number
> > > of cpus and nodes, the number of pages in the percpu list can be very
> > > large, so it is better to let user to know the pcp count.
> > > 
> > > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > ---
> > >   drivers/base/node.c | 14 +++++++++++++-
> > >   fs/proc/meminfo.c   |  9 +++++++++
> > >   2 files changed, 22 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > index eb0f43784c2b..846864e45db6 100644
> > > --- a/drivers/base/node.c
> > > +++ b/drivers/base/node.c
> > > @@ -375,6 +375,9 @@ static ssize_t node_read_meminfo(struct device *dev,
> > >   	struct sysinfo i;
> > >   	unsigned long sreclaimable, sunreclaimable;
> > >   	unsigned long swapcached = 0;
> > > +	unsigned long free_pcp = 0;
> > > +	struct zone *zone;
> > > +	int cpu;
> > >   	si_meminfo_node(&i, nid);
> > >   	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
> > > @@ -382,9 +385,17 @@ static ssize_t node_read_meminfo(struct device *dev,
> > >   #ifdef CONFIG_SWAP
> > >   	swapcached = node_page_state_pages(pgdat, NR_SWAPCACHE);
> > >   #endif
> > > +	for_each_populated_zone(zone) {
> > > +		if (zone_to_nid(zone) != nid)
> > > +			continue;
> > > +		for_each_online_cpu(cpu)
> > > +			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
> > > +	}
> > > +
> > >   	len = sysfs_emit_at(buf, len,
> > >   			    "Node %d MemTotal:       %8lu kB\n"
> > >   			    "Node %d MemFree:        %8lu kB\n"
> > > +			    "Node %d PcpFree:        %8lu kB\n"
> > First off, this sysfs file is a huge violation of the normal sysfs
> > rules, so I will not allow any new entries to be added.  In fact, the
> > whole thing should just be removed and multiple files created in its
> > place.
> 
> Hi Greg, do you mean to remove all /sys/devices/system/node/node*/meminfo,
> 
> but this will beak ABI, is it acceptable?

I do not know, what tool relies on this file?  Any userspace tool should
always be able to handle a sysfs file being removed, so you should
probably work with the tool authors to fix this up before removing it.

thanks,

gre gk-h
