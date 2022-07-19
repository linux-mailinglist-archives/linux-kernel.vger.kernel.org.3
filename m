Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2EB57A360
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbiGSPn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiGSPnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:43:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133F6528BC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:43:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BB5AD348B7;
        Tue, 19 Jul 2022 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658245403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NG6X28gAOlRl2/6jzvTSSGutMpFbGaBg493qNWflstQ=;
        b=hZbGdx+QM0rjB17dXa/+05R1GiMe06VCXmh4quE4k+/ZvVqrhY7qpi8ZJM/B3fOBoo7sAw
        JlpCdwR2V0aYiMNKjJ4fgZ3FH0pZNzgFT394CZpC8PLILC4OrfXMOncK5tDd223iwg0hBh
        YNIK8je0xS3HVbjut/EPwqfHgXGuuMI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 339D32C141;
        Tue, 19 Jul 2022 15:43:20 +0000 (UTC)
Date:   Tue, 19 Jul 2022 17:43:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, vbabka@suse.cz,
        david@redhat.com, minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YtbRF9Z1tVxgw+g0@dhcp22.suse.cz>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
 <fca23df7-37b0-f32d-ece3-58317dfad210@quicinc.com>
 <YtV0PSMAGG46Pq0K@dhcp22.suse.cz>
 <aaeec83d-bdf8-280c-b943-ad510f1d8db2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaeec83d-bdf8-280c-b943-ad510f1d8db2@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-07-22 20:42:42, Charan Teja Kalla wrote:
> Thanks Michal!!
> 
> On 7/18/2022 8:24 PM, Michal Hocko wrote:
[...]
> >>>> diff --git a/mm/page_ext.c b/mm/page_ext.c
> >>>> index 3dc715d..5ccd3ee 100644
> >>>> --- a/mm/page_ext.c
> >>>> +++ b/mm/page_ext.c
> >>>> @@ -299,8 +299,9 @@ static void __free_page_ext(unsigned long pfn)
> >>>>  	if (!ms || !ms->page_ext)
> >>>>  		return;
> >>>>  	base = get_entry(ms->page_ext, pfn);
> >>>> -	free_page_ext(base);
> >>>>  	ms->page_ext = NULL;
> >>>> +	synchronize_rcu();
> >>>> +	free_page_ext(base);
> >>>>  }
> >>> So you are imposing the RCU grace period for each page_ext! This can get
> >>> really expensive. Have you tried to measure the effect?
> > I was wrong here! This is for each memory section which is not as
> > terrible as every single page_ext. This can be still quite a lot memory
> > sections in a single memory block (e.g. on ppc memory sections are
> > ridiculously small).
> > 
> 
> On the ARM64, I see that the minimum a section size will go is 128MB. I
> think 16MB is the section size on ppc. Any inputs on how frequently
> offline/online operation is being done on this ppc arch?

I have seen several reports where 16MB sections were used on PPC LPARs
with a non trivial size. My usual answer to that is tha this is mostly a
self inflicted injury but I am told that for some reasons I cannot
udnerstand this is not easy to change. So reasonable or not this is not
all that uncommon in PPC land.

We definitely shouldn't optimize for those setups but we shouldn't make
them suffer even more as well. Besides that it seems that a single
rcu_synchronize per offline operation should be doable.
-- 
Michal Hocko
SUSE Labs
