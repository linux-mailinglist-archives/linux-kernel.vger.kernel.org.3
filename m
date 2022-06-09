Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C04D544E3A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245258AbiFIN4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244556AbiFINzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:55:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4C53969A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:55:47 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hf10so17156893qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aYtrdDBwU4yTdQKJkMQVA7gMy9IooF4te3GdXx0ANHQ=;
        b=mji5Zcu8fibQv/E7UoK5eVhMxlLtfyUkPZm4jv1sYUvNbnF8NLo2jlTiIC7uKicDAS
         W3QPzMCZ89ze+yxQ4khvlBtGdgxOPlJ4IRc3IJyI6U/xCTXX1zfwUHpKiwKy0xeG7gbi
         p79oWBTdhp8rokiGPNYfpVwOoDH28YTPZuKGy7PaujamUmjQOCnZMICM7ZVJ5sCmQXg6
         0h0kcqeZgtslqeW0NxrWWer3Yt9ALb9awlQgm9neqCY3LC6AbhUeP/wzAuwpBBedjEbv
         mak+OT3huvyh7+kpD+B7yn1iMOEbonOwkC74FhTU3WFzCQbToUStNxM39T8tBUqx/2f4
         /Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aYtrdDBwU4yTdQKJkMQVA7gMy9IooF4te3GdXx0ANHQ=;
        b=F9d7/OPSlqQVINiUdUSWCL66DgaotFv6RrsItz51UDLP8ID/fuVZSX5/17nRnYUi1w
         mTpK10JaiIfX0kkz/iVD4LAqGNCvM7N6PvP/tcR1HMttBjUyg5XCbinVbrFpA/SW1X1Z
         /c149wKm6wjH2+GQWqYgW/nr2gAMZQyLA8+VJRo1tXu3ZxCc/sPmg0gsPpxqYQac+lRw
         vlyPbFz9lckyEfTa/xw4CGUirqEQmpV5lLCeRqqWVAqwbt/r88FuDuOycuzSgX751D4j
         gYSKXBP9UIvFMTaZMFo4rt4rpr0ld2yiPoihLu5PRRcCoqmVHLoyt9hpY/P/k6EJI2Oi
         X/kg==
X-Gm-Message-State: AOAM531m6Yo5OdX44+H7RxHYSZodjNLiv5TXF4brIdOGV5U4DF9Lr5SV
        L7LjvAZw6r11TRLSFYrVigV3Hg==
X-Google-Smtp-Source: ABdhPJzbxuEQl+LLQ+huSX5fvLkDmsMR4gykA6qcjXUtjkW4T1ruwvvnfUxpcWQTcr1VNfksk4DRRw==
X-Received: by 2002:ac8:4e87:0:b0:304:fedb:e972 with SMTP id 7-20020ac84e87000000b00304fedbe972mr9148182qtp.444.1654782946539;
        Thu, 09 Jun 2022 06:55:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4759])
        by smtp.gmail.com with ESMTPSA id j9-20020ac86649000000b00304ea3d2f62sm9195640qtp.41.2022.06.09.06.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 06:55:45 -0700 (PDT)
Date:   Thu, 9 Jun 2022 09:55:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Message-ID: <YqH74WaUzJlb+smt@cmpxchg.org>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <YqCuE87gCcrnAiXG@cmpxchg.org>
 <YqDGYjgjcS5OoS3P@cmpxchg.org>
 <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
 <YqDncfLeEeBaosrY@cmpxchg.org>
 <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 08:03:26AM +0530, Aneesh Kumar K V wrote:
> On 6/8/22 11:46 PM, Johannes Weiner wrote:
> > On Wed, Jun 08, 2022 at 09:43:52PM +0530, Aneesh Kumar K V wrote:
> > > On 6/8/22 9:25 PM, Johannes Weiner wrote:
> > > > Hello,
> > > > 
> > > > On Wed, Jun 08, 2022 at 10:11:31AM -0400, Johannes Weiner wrote:
> > > > > On Fri, Jun 03, 2022 at 07:12:29PM +0530, Aneesh Kumar K.V wrote:
> > > > > > @@ -0,0 +1,20 @@
> > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > +#ifndef _LINUX_MEMORY_TIERS_H
> > > > > > +#define _LINUX_MEMORY_TIERS_H
> > > > > > +
> > > > > > +#ifdef CONFIG_TIERED_MEMORY
> > > > > > +
> > > > > > +#define MEMORY_TIER_HBM_GPU	0
> > > > > > +#define MEMORY_TIER_DRAM	1
> > > > > > +#define MEMORY_TIER_PMEM	2
> > > > > > +
> > > > > > +#define MEMORY_RANK_HBM_GPU	300
> > > > > > +#define MEMORY_RANK_DRAM	200
> > > > > > +#define MEMORY_RANK_PMEM	100
> > > > > > +
> > > > > > +#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
> > > > > > +#define MAX_MEMORY_TIERS  3
> > > > > 
> > > > > I understand the names are somewhat arbitrary, and the tier ID space
> > > > > can be expanded down the line by bumping MAX_MEMORY_TIERS.
> > > > > 
> > > > > But starting out with a packed ID space can get quite awkward for
> > > > > users when new tiers - especially intermediate tiers - show up in
> > > > > existing configurations. I mentioned in the other email that DRAM !=
> > > > > DRAM, so new tiers seem inevitable already.
> > > > > 
> > > > > It could make sense to start with a bigger address space and spread
> > > > > out the list of kernel default tiers a bit within it:
> > > > > 
> > > > > MEMORY_TIER_GPU		0
> > > > > MEMORY_TIER_DRAM	10
> > > > > MEMORY_TIER_PMEM	20
> > > > 
> > > > Forgive me if I'm asking a question that has been answered. I went
> > > > back to earlier threads and couldn't work it out - maybe there were
> > > > some off-list discussions? Anyway...
> > > > 
> > > > Why is there a distinction between tier ID and rank? I undestand that
> > > > rank was added because tier IDs were too few. But if rank determines
> > > > ordering, what is the use of a separate tier ID? IOW, why not make the
> > > > tier ID space wider and have the kernel pick a few spread out defaults
> > > > based on known hardware, with plenty of headroom to be future proof.
> > > > 
> > > >     $ ls tiers
> > > >     100				# DEFAULT_TIER
> > > >     $ cat tiers/100/nodelist
> > > >     0-1				# conventional numa nodes
> > > > 
> > > >     <pmem is onlined>
> > > > 
> > > >     $ grep . tiers/*/nodelist
> > > >     tiers/100/nodelist:0-1	# conventional numa
> > > >     tiers/200/nodelist:2		# pmem
> > > > 
> > > >     $ grep . nodes/*/tier
> > > >     nodes/0/tier:100
> > > >     nodes/1/tier:100
> > > >     nodes/2/tier:200
> > > > 
> > > >     <unknown device is online as node 3, defaults to 100>
> > > > 
> > > >     $ grep . tiers/*/nodelist
> > > >     tiers/100/nodelist:0-1,3
> > > >     tiers/200/nodelist:2
> > > > 
> > > >     $ echo 300 >nodes/3/tier
> > > >     $ grep . tiers/*/nodelist
> > > >     tiers/100/nodelist:0-1
> > > >     tiers/200/nodelist:2
> > > >     tiers/300/nodelist:3
> > > > 
> > > >     $ echo 200 >nodes/3/tier
> > > >     $ grep . tiers/*/nodelist
> > > >     tiers/100/nodelist:0-1	
> > > >     tiers/200/nodelist:2-3
> > > > 
> > > > etc.
> > > 
> > > tier ID is also used as device id memtier.dev.id. It was discussed that we
> > > would need the ability to change the rank value of a memory tier. If we make
> > > rank value same as tier ID or tier device id, we will not be able to support
> > > that.
> > 
> > Is the idea that you could change the rank of a collection of nodes in
> > one go? Rather than moving the nodes one by one into a new tier?
> > 
> > [ Sorry, I wasn't able to find this discussion. AFAICS the first
> >    patches in RFC4 already had the struct device { .id = tier }
> >    logic. Could you point me to it? In general it would be really
> >    helpful to maintain summarized rationales for such decisions in the
> >    coverletter to make sure things don't get lost over many, many
> >    threads, conferences, and video calls. ]
> 
> Most of the discussion happened not int he patch review email threads.
> 
> RFC: Memory Tiering Kernel Interfaces (v2)
> https://lore.kernel.org/linux-mm/CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com
> 
> RFC: Memory Tiering Kernel Interfaces (v4)
> https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com

I read the RFCs, the discussions and your code. It's still not clear
why the tier/device ID and the rank need to be two separate,
user-visible things. There is only one tier of a given rank, why can't
the rank be the unique device id? dev->id = 100. One number. Or use a
unique device id allocator if large numbers are causing problems
internally. But I don't see an explanation why they need to be two
different things, let alone two different things in the user ABI.
