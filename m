Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA80543B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiFHSRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiFHSQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:16:21 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CCB31DEA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:16:18 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o73so11148790qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c9z+xEgn0cvxJ8Erz7demN5NMhZ6h+sFb/q6v76GQl0=;
        b=fddRxPUuqE8gWzetwxLtNjl49MykwjTpFDUinFEgPSjQFkzdJAt7NY/VtAYr4iwnGl
         z5kPeprOPAav4Fz4E8rMW+LrnKXaMW9aCKGaFPWG5cDv00yAN6NrZxnlxv7RkNK2GKQA
         lP2cLVXK58EXz00aXSKCPZ4VOwIyRID8CMZEvPdqiul3j5ORnsQtmkOicZGWNmwufD5Y
         X05p1hvYzmrGhYagesRNUe6KByYQIwPJQKgfF83DvH8aLGaQvGKKiHEjTropvDB19JZo
         Kq1/Uec1jrT4BJwMFjMd5Z9QWlGJtqg45x86NalFxbFOTxki4VQcC7HkUxn+XTMnMEuj
         I/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c9z+xEgn0cvxJ8Erz7demN5NMhZ6h+sFb/q6v76GQl0=;
        b=rLwEwY2KeDxYSMm7jL3PwbOrwX1QkI69wqz723CGubUJhgbLAs4Zvmew1KAkLvYW2l
         1HCybziDwF720STvHhxCVNM3d/Cc7f4rw0EGZlXQnpkYbiZqBlsb3k6ctYbdM2UYOEBq
         nODNEL2Oed8W4X23FLiEE1vrXBgN9XcPISMGljLWqbnLHmjAuzd6jJ05Nsq3KwBQhs0W
         O8VDdjkxhakuCZMBRbhZvQgPnMSotg3FLLrXPcU56vmndstc/NyT4Mrv4yLOaARj8VuX
         yAtd1SpJ/G+V/0+Dr08VxqrFBPwJnyONQQ1UlxOW02WAkBAM8aW87YJWO28uTn0YH7Sf
         psMA==
X-Gm-Message-State: AOAM530dR1VkNWR0MAHXACd+WnPO3JZIIbUGtvHmiErRWloxZNDlCV3m
        dPGN4OqtNPYt/jo39r5Bjcsfww==
X-Google-Smtp-Source: ABdhPJx67/PgS/fTP5mTmGbXXZzMN8viiztzFKsGtTUDlLt75M8GFJ1/JW1BQmXic0Y5oJ9srgY9Xw==
X-Received: by 2002:a37:4549:0:b0:69f:556c:4e38 with SMTP id s70-20020a374549000000b0069f556c4e38mr24302378qka.202.1654712177788;
        Wed, 08 Jun 2022 11:16:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4759])
        by smtp.gmail.com with ESMTPSA id bm13-20020a05620a198d00b006a6d83fc9efsm4680398qkb.21.2022.06.08.11.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 11:16:17 -0700 (PDT)
Date:   Wed, 8 Jun 2022 14:16:17 -0400
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
Message-ID: <YqDncfLeEeBaosrY@cmpxchg.org>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <YqCuE87gCcrnAiXG@cmpxchg.org>
 <YqDGYjgjcS5OoS3P@cmpxchg.org>
 <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 09:43:52PM +0530, Aneesh Kumar K V wrote:
> On 6/8/22 9:25 PM, Johannes Weiner wrote:
> > Hello,
> > 
> > On Wed, Jun 08, 2022 at 10:11:31AM -0400, Johannes Weiner wrote:
> > > On Fri, Jun 03, 2022 at 07:12:29PM +0530, Aneesh Kumar K.V wrote:
> > > > @@ -0,0 +1,20 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef _LINUX_MEMORY_TIERS_H
> > > > +#define _LINUX_MEMORY_TIERS_H
> > > > +
> > > > +#ifdef CONFIG_TIERED_MEMORY
> > > > +
> > > > +#define MEMORY_TIER_HBM_GPU	0
> > > > +#define MEMORY_TIER_DRAM	1
> > > > +#define MEMORY_TIER_PMEM	2
> > > > +
> > > > +#define MEMORY_RANK_HBM_GPU	300
> > > > +#define MEMORY_RANK_DRAM	200
> > > > +#define MEMORY_RANK_PMEM	100
> > > > +
> > > > +#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
> > > > +#define MAX_MEMORY_TIERS  3
> > > 
> > > I understand the names are somewhat arbitrary, and the tier ID space
> > > can be expanded down the line by bumping MAX_MEMORY_TIERS.
> > > 
> > > But starting out with a packed ID space can get quite awkward for
> > > users when new tiers - especially intermediate tiers - show up in
> > > existing configurations. I mentioned in the other email that DRAM !=
> > > DRAM, so new tiers seem inevitable already.
> > > 
> > > It could make sense to start with a bigger address space and spread
> > > out the list of kernel default tiers a bit within it:
> > > 
> > > MEMORY_TIER_GPU		0
> > > MEMORY_TIER_DRAM	10
> > > MEMORY_TIER_PMEM	20
> > 
> > Forgive me if I'm asking a question that has been answered. I went
> > back to earlier threads and couldn't work it out - maybe there were
> > some off-list discussions? Anyway...
> > 
> > Why is there a distinction between tier ID and rank? I undestand that
> > rank was added because tier IDs were too few. But if rank determines
> > ordering, what is the use of a separate tier ID? IOW, why not make the
> > tier ID space wider and have the kernel pick a few spread out defaults
> > based on known hardware, with plenty of headroom to be future proof.
> > 
> >    $ ls tiers
> >    100				# DEFAULT_TIER
> >    $ cat tiers/100/nodelist
> >    0-1				# conventional numa nodes
> > 
> >    <pmem is onlined>
> > 
> >    $ grep . tiers/*/nodelist
> >    tiers/100/nodelist:0-1	# conventional numa
> >    tiers/200/nodelist:2		# pmem
> > 
> >    $ grep . nodes/*/tier
> >    nodes/0/tier:100
> >    nodes/1/tier:100
> >    nodes/2/tier:200
> > 
> >    <unknown device is online as node 3, defaults to 100>
> > 
> >    $ grep . tiers/*/nodelist
> >    tiers/100/nodelist:0-1,3
> >    tiers/200/nodelist:2
> > 
> >    $ echo 300 >nodes/3/tier
> >    $ grep . tiers/*/nodelist
> >    tiers/100/nodelist:0-1
> >    tiers/200/nodelist:2
> >    tiers/300/nodelist:3
> > 
> >    $ echo 200 >nodes/3/tier
> >    $ grep . tiers/*/nodelist
> >    tiers/100/nodelist:0-1	
> >    tiers/200/nodelist:2-3
> > 
> > etc.
> 
> tier ID is also used as device id memtier.dev.id. It was discussed that we
> would need the ability to change the rank value of a memory tier. If we make
> rank value same as tier ID or tier device id, we will not be able to support
> that.

Is the idea that you could change the rank of a collection of nodes in
one go? Rather than moving the nodes one by one into a new tier?

[ Sorry, I wasn't able to find this discussion. AFAICS the first
  patches in RFC4 already had the struct device { .id = tier }
  logic. Could you point me to it? In general it would be really
  helpful to maintain summarized rationales for such decisions in the
  coverletter to make sure things don't get lost over many, many
  threads, conferences, and video calls. ]
