Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7CE47760E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbhLPPhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:37:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59152 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhLPPhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:37:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40681B82481
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D0AC36AE0;
        Thu, 16 Dec 2021 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639669029;
        bh=WvVICXLY/xfTFTorE0zO17dchnxNqn1KwhY6FGa5Llc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuGKUpe14Xu+K4pjATQPG7NB23O6h5QXfU8SYTFsYAUTucTNRmq0LvS0hTgZ8crrB
         2BbEZ1PHfG+5n9Cz0uF2FccQ2ktGI2cZ2wI+9qSFv9G43O/lHdm8nWum7PJU2+NpXV
         4hhqzQoH7eHQiI9aPT0s+ccTMdV74G/1/M7RBNS4=
Date:   Thu, 16 Dec 2021 16:37:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, rafael@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH 1/2] mm: add MemAvailable to per-node meminfo
Message-ID: <YbtdIpJal3keEWf8@kroah.com>
References: <20211216124655.32247-1-zhengqi.arch@bytedance.com>
 <20211216124655.32247-2-zhengqi.arch@bytedance.com>
 <Ybs8P3WcPtShi15o@kroah.com>
 <34cc2f26-9fba-f7c6-5dae-d21498ccbe2d@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34cc2f26-9fba-f7c6-5dae-d21498ccbe2d@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:31:36PM +0800, Qi Zheng wrote:
> 
> 
> On 12/16/21 9:16 PM, Greg KH wrote:
> > On Thu, Dec 16, 2021 at 08:46:54PM +0800, Qi Zheng wrote:
> > > In /proc/meminfo, we can show the sum of all the available memory
> > > as "MemAvailable". Add the same counter also to per-node meminfo
> > > under /sys.
> > > 
> > > With this counter, some processes that bind nodes can make some
> > > decisions by reading the "MemAvailable" of the corresponding nodes
> > > directly.
> > > 
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > ---
> > >   drivers/base/node.c    |  4 ++++
> > >   include/linux/mm.h     |  1 +
> > >   include/linux/mmzone.h |  5 +++++
> > >   mm/page_alloc.c        | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >   4 files changed, 59 insertions(+)
> > > 
> > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > index 87acc47e8951..deb2a7965ae4 100644
> > > --- a/drivers/base/node.c
> > > +++ b/drivers/base/node.c
> > > @@ -375,8 +375,10 @@ static ssize_t node_read_meminfo(struct device *dev,
> > >   	struct sysinfo i;
> > >   	unsigned long sreclaimable, sunreclaimable;
> > >   	unsigned long swapcached = 0;
> > > +	long available;
> > >   	si_meminfo_node(&i, nid);
> > > +	available = si_mem_available_node(&i, nid);
> > >   	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
> > >   	sunreclaimable = node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B);
> > >   #ifdef CONFIG_SWAP
> > > @@ -386,6 +388,7 @@ static ssize_t node_read_meminfo(struct device *dev,
> > >   			    "Node %d MemTotal:       %8lu kB\n"
> > >   			    "Node %d MemFree:        %8lu kB\n"
> > >   			    "Node %d MemUsed:        %8lu kB\n"
> > > +			    "Node %d MemAvailable:   %8lu kB\n"
> > 
> > You just changed a user/kernel api without documenting it anywhere, or
> > ensuring that you did not just break anything.
> 
> Hi greg k-h,
> 
> The MemAvailable has long existed in the /proc/meminfo, it's meaning
> has been described in the Documentation/filesystems/proc.rst. Since
> the semantics of per-node MemAvailable has not changed, so I did not
> add a new document description.

This is not a proc file, it is in sysfs.

And it violates all of the sysfs rules, and has all of the problems that
proc files have.  So the worst of both worlds :(

> > Also, this api is crazy, and not ok, please never add anything new to
> > it, it is broken as-is.
> 
> The consideration of adding per-node MemAvailable is that some processes
> that bind nodes need this information to do some decisions.
> 
> Now their approach is to read other information in per-node meminfo
> and /proc/sys/vm/watermark_scale_factor, and then approximate this
> value. With this counter, they can directly read
> /sys/devices/system/node/node*/meminfo to get the MemAvailable
> information of each node.
> 
> And MemTotal, MemFree and SReclaimable(etc.) all have corresponding
> per-node versions, so I think that adding per-node MemAvailable might
> also make sense. :)

Please no, I do not want new things added to this file, as you might
break parsers of this file.

Also, again, you did not document this at all in Documentation/ABI/ so
for that reason alone it is not ok.

thanks,

greg k-h
