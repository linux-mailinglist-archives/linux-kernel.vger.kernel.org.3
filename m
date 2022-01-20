Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFF14955E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377797AbiATVWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiATVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:22:50 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6EEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:22:50 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id v74so3559012pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CUsY6BC+pXhHFnLSqdEbGSsL6/Agpcnt4z12QyJauGo=;
        b=GN39w31clbNaSPLsttHOH88mpjYQ/o/CpHxIQkhwgZIf/GjIQl4WjNTv8//y4vKEX4
         JqR6xnUDR2n0F/E1LlPW33bp27QDLQMuAOTOZYSwjQ9czM2fUnNSUq1iwLrVGMViMro/
         AqEAF2iI1v3wjYYhpgn3xYG43mW/Qb5Gdm4ppfgma3p7rOISH2mxi0vPDcbi5+OBgPSi
         QweNS1ewJ0jfHkzAMnECivsRGUsnfo5DSZa7kMnbCdK5qiCNVl0a5+RjbnGb+1K4BDqo
         ZqZNemG7ROhUW5yw2r2nA8+ndrPhmoNCqW3XtVeYUe8bnkyj6tQIXwOTL6567XVpX/JY
         EI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CUsY6BC+pXhHFnLSqdEbGSsL6/Agpcnt4z12QyJauGo=;
        b=bz4bM3V+Uwbu82I6Ty1OAoPW6xz+0eyZVRxxqAQvmGYg7M2hqwZLB4V3VKaASAIKMc
         uiPcNZ7VnfDRIpbLcoollb5yTSRRkj6LOGHJyVhpjbdv0G7GwnsEiFAeVCtlrsGwsbFr
         w6QuqFA/jIYodZ94mz9wJhtudAGuDFGWjh12N4CDz5uibB0DVcefaXC5kklcyrntM3Mn
         hOFohOBndb3nOPlFfq4vaGzvEiAzF6dNfeWasAKhGjyWWzY8GF9UylqUzcaNqZexMw6R
         K8U8k3c/bb+2ueAxk87Jj47sp7IzVSqk9cjXUtyuK0zWzC6d5/uLdimJvbrT6R81gsb8
         zoSg==
X-Gm-Message-State: AOAM533lTYsoD2w2tC/tNSzPiAkZLZ9wC12TtnXBfbl7aRyO1Z30ftU6
        5tMx8hiqcMdsW2mt5y5eVVQ=
X-Google-Smtp-Source: ABdhPJwbHyasteQOuzk/p1y7DsTSy0FhnE+g47J549pQmSUM2jPk2xS75YATV8Q24Td6GIIUbzZEww==
X-Received: by 2002:a05:6a00:c92:b0:4c3:d3e:3674 with SMTP id a18-20020a056a000c9200b004c30d3e3674mr658218pfv.16.1642713769827;
        Thu, 20 Jan 2022 13:22:49 -0800 (PST)
Received: from google.com ([2620:15c:211:201:b370:1e12:5bf4:801f])
        by smtp.gmail.com with ESMTPSA id ca12sm3236486pjb.11.2022.01.20.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:22:49 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 20 Jan 2022 13:22:47 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <YenSp5l80kBLijcd@google.com>
References: <20211230193627.495145-1-minchan@kernel.org>
 <YeVzWlrojI1+buQx@dhcp22.suse.cz>
 <YedXhpwURNTkW1Z3@google.com>
 <644356e5-2a85-fcea-2280-ff779ae8d38d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644356e5-2a85-fcea-2280-ff779ae8d38d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:42:23AM +0100, David Hildenbrand wrote:
> On 19.01.22 01:12, Minchan Kim wrote:
> > On Mon, Jan 17, 2022 at 02:47:06PM +0100, Michal Hocko wrote:
> >> On Thu 30-12-21 11:36:27, Minchan Kim wrote:
> >>> lru_cache_disable involves IPIs to drain pagevec of each core,
> >>> which sometimes takes quite long time to complete depending
> >>> on cpu's business, which makes allocation too slow up to
> >>> sveral hundredth milliseconds. Furthermore, the repeated draining
> >>> in the alloc_contig_range makes thing worse considering caller
> >>> of alloc_contig_range usually tries multiple times in the loop.
> >>>
> >>> This patch makes the lru_cache_disable aware of the fact the
> >>> pagevec was already disabled. With that, user of alloc_contig_range
> >>> can disable the lru cache in advance in their context during the
> >>> repeated trial so they can avoid the multiple costly draining
> >>> in cma allocation.
> >>
> >> Do you have any numbers on any improvements?
> > 
> > The LRU draining consumed above 50% overhead for the 20M CMA alloc.
> > 
> >>
> >> Now to the change. I do not like this much to be honest. LRU cache
> >> disabling is a complex synchronization scheme implemented in
> >> __lru_add_drain_all now you are stacking another level on top of that.
> >>
> >> More fundamentally though. I am not sure I understand the problem TBH.
> > 
> > The problem is that kinds of IPI using normal prority workqueue to drain
> > takes much time depending on the system CPU business.
> > 
> >> What prevents you from calling lru_cache_disable at the cma level in the
> >> first place?
> > 
> > You meant moving the call from alloc_contig_range to caller layer?
> > So, virtio_mem_fake_online, too? It could and make sense from
> > performance perspective since upper layer usually calls the
> > alloc_contig_range multiple times on retrial loop.
> > 
> 
> ^ I actually do have something like that on my TODO list.

I'm glad to hear you are also looking the direction.
If we move some information out of alloc_contig_range,
upper layer has higher chance to make it fast. A example,
"failure pfn and why it fails"

> 
> The issue is that we have demanding requirements for
> alloc_contig_range(), discussed in the past for CMA bulk allocations:
> 
> (1) Fast, unreliable allocations
> 
> Fail fast and let caller continue with next allocation instead of
> retrying. Try to not degrade system performance.
> 
> (2) Slow, reliable allocations
> 
> Retry as good as possible. Degrading system performance (e.g., disabling
> lru) is acceptable.

"Fast and unreliable" provides lots of flexibilty for us to design
since it's okay to fail. For "Slow, reliable", "the slow" should be not
too much and we need to keep effort to make it faster.
