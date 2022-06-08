Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B56C543C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiFHTOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiFHTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:14:09 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928FE3EF22
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:14:07 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o73so11266126qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RsiYEHMzgtofeSbg+NUkK3PrW8Vl8NwFPdNoBD4cGLE=;
        b=ZCKWwyjYMXMvERz1mEuKEwdnIsgZQcWXH/LH7IDAxkbgNWgeq9C1aj8P6prYLO6XIU
         oUTIItWtnoEITNukFot8hM2ff66s4GNgCnI/efoAR3ZJxqhaB6TbOTNXS8DI03qaiB/x
         FStgRZycmEnednA3Tt/LznzmnLMtI6AKrNQIS3PkfA426KT5R5qsuZF/GgPqG3v0dOgN
         OHg1AoUruS19BRSqe0+i3xyYE47z9DklV+qutktr/wVxAWJK5ZXt9MNmKzf9GvX/hYwM
         BV9TH8nK6MlDRJs7v3XTSqcGIp4x5lBMwNeT/R8SuKVjtl+8b4VkvHEZzER82xq2btcb
         l6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RsiYEHMzgtofeSbg+NUkK3PrW8Vl8NwFPdNoBD4cGLE=;
        b=1by136nRoAW95xHkW9zIkRotc9vGVapuf0Wlteu3U1ZsistTvtPai4EX62CGu7taYL
         /ANQMFW22NouoY3ghiu/cDQtEQEiVJdS2OLT3DthbQ4Gx8cQt/lAjah2R9W0bonsitrT
         pU8A+ATMnCayNQHRW9vsOFx0ap3cCZZAqq20iIVf0DCfcJf44W0386KYz43DYkpK3G+7
         y90CRkAz+mkJov0ukn5l6aouPO8yZpUXudTFeCPr/5ZhyM1iWQWZLEjzAma3FDH+CxEL
         qfXcARG5u17Z4vo7zTuPIKV+AdyA7/tTiGtj+ZNYlMpbE6m5BJZ/gSLc5h3u4WVLNa2H
         78zg==
X-Gm-Message-State: AOAM5329wQKz5JWvuXfplaBYxaspgak7laHUhwz0EL2cg+WuOxW+7zQI
        Ug7koKljAA6bcO6OFYAaya+02Q==
X-Google-Smtp-Source: ABdhPJwc8FSCV47a62ziXYcRqDEpzNDsZiYoJN8dY4tp27t6NnpqMNl8YbBm6KS8OWYgWyKHXVNmbQ==
X-Received: by 2002:a37:ad18:0:b0:6a6:1d94:ff50 with SMTP id f24-20020a37ad18000000b006a61d94ff50mr15483096qkm.426.1654715646596;
        Wed, 08 Jun 2022 12:14:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4759])
        by smtp.gmail.com with ESMTPSA id j19-20020a05620a289300b006a6ab259261sm11744690qkp.29.2022.06.08.12.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 12:14:06 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:14:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     linux-mm@kvack.org, Hao Wang <haowang3@fb.com>,
        Abhishek Dhanotia <abhishekd@fb.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Hasan Al Maruf <hasanalmaruf@fb.com>
Subject: Re: [PATCH] mm: mempolicy: N:M interleave policy for tiered memory
 nodes
Message-ID: <YqD0/tzFwXvJ1gK6@cmpxchg.org>
References: <20220607171949.85796-1-hannes@cmpxchg.org>
 <6096c96086187e51706898e58610fc0148b4ca23.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6096c96086187e51706898e58610fc0148b4ca23.camel@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Wed, Jun 08, 2022 at 11:15:27AM -0700, Tim Chen wrote:
> On Tue, 2022-06-07 at 13:19 -0400, Johannes Weiner wrote:
> > 
> >  /* Do dynamic interleaving for a process */
> >  static unsigned interleave_nodes(struct mempolicy *policy)
> >  {
> >  	unsigned next;
> >  	struct task_struct *me = current;
> >  
> > -	next = next_node_in(me->il_prev, policy->nodes);
> > +	if (numa_tier_interleave[0] > 1 || numa_tier_interleave[1] > 1) {
> 
> When we have three memory tiers, do we expect an N:M:K policy?
> Like interleaving between DDR5, DDR4 and PMEM memory.
> Or we expect an N:M policy still by interleaving between two specific tiers?

In the context of the proposed 'explicit tiers' interface, I think it
would make sense to have a per-tier 'interleave_ratio knob. Because
the ratio is configured based on hardware properties, it can be
configured meaningfully for the entire tier hierarchy, even if
individual tasks or vmas interleave over only a subset of nodes.

> The other question is whether we will need multiple interleave policies depending
> on cgroup?
> One policy could be interleave between tier1, tier2, tier3.
> Another could be interleave between tier1 and tier2.

This is a good question.

One thing that has defined cgroup development in recent years is the
concept of "work conservation". Moving away from fixed limits and hard
partitioning, cgroups are increasingly configured with weights,
priorities, and guarantees (cpu.weight, io.latency/io.cost.qos,
memory.low). These weights and priorities are enforced when cgroups
are directly competing over a resource; but if there is no contention,
any active cgroup, regardless of priority, has full access to the
surplus (which could be the entire host if the main load is idle).

With that background, yes, we likely want some way of prioritizing
tier access when multiple cgroups are competing. But we ALSO want the
ability to say that if resources are NOT contended, a cgroup should
interleave memory over all tiers according to optimal bandwidth.

That means that regardless of how the competitive cgroup rules for
tier access end up looking like, it makes sense to have global
interleaving weights based on hardware properties as proposed here.

The effective cgroup IL ratio for each tier could then be something
like cgroup.tier_weight[tier] * tier/interleave_weight.
