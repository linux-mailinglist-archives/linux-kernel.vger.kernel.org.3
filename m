Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B729F54826B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiFMIyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240479AbiFMIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:54:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B9B4AD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:54:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3E37821A6F;
        Mon, 13 Jun 2022 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655110481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x6EzP/SNl2aHgcErZAiM07TxOTw9Y5d8zGy4RjavR0s=;
        b=QMpch2e5jylY76PxB3EoaBBinXIXWjTjbQA7eu7c+05/pytcyOkm+9idUrvBHjG2gGWGex
        AEYcaV56kiG1Z6lrPu5y4pETQqS4h3LqYL4W2fr32AhfwRRXhQYk/L9YpOVN5noZcCd0hs
        pDqrImnEdUtcxC1TrOtisSCZFbRDIHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655110481;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x6EzP/SNl2aHgcErZAiM07TxOTw9Y5d8zGy4RjavR0s=;
        b=1YuFBATmhJW1bK2y75DttzqhxcbQXkyi/VytJmVe5YitrqXYgkjI9EQ6IuoUqrRZ21MONL
        nDHAU3OtQNQdIVDg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2CFF52C141;
        Mon, 13 Jun 2022 08:54:38 +0000 (UTC)
Date:   Mon, 13 Jun 2022 09:54:37 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        yangyicong@hisilicon.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <21cnbao@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>
Subject: Re: [PATCH v4] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
Message-ID: <20220613085437.GC3195@suse.de>
References: <20220612163428.849378-1-yu.c.chen@intel.com>
 <ca59e113-d5df-7dec-6bab-a8d239b50c0b@huawei.com>
 <20220613080636.GA32587@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220613080636.GA32587@chenyu5-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:06:36PM +0800, Chen Yu wrote:
> On Mon, Jun 13, 2022 at 03:40:52PM +0800, Yicong Yang wrote:
> > On 2022/6/13 0:34, Chen Yu wrote:
> > >  
> [cut...]
> > >  #define NUMA_IMBALANCE_MIN 2
> > > diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> > > index 1cf435bbcd9c..3334a1b93fc6 100644
> > > --- a/kernel/sched/features.h
> > > +++ b/kernel/sched/features.h
> > > @@ -61,6 +61,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
> > >   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
> > >   */
> > >  SCHED_FEAT(SIS_PROP, true)
> > > +SCHED_FEAT(SIS_UTIL, true)
> > >  
> > 
> > confused here that shouldn't we have SCHED_FEAT(SIS_PROP, false)? With SIS_UTIL enabled, SIS_PROP will have no
> > effect since nr is overridden by SIS_UTIL.
> Yes, no matter what SIS_PROP is set, the result of SIS_UTIL would be used to decide
> the scan depth. We don't change the default value of SIS_PROP here, as this patch
> tends to only touch one feature at one time. And the options could be tuned by user via
> sysfs manually. Besides, the target is to replace SIS_PROP with another search policy,
> Peter mentioned that "And ideally we're remove SIS_PROP after a few releases if this
> works out", so I assume that changing the default value of SIS_PROP does not matter
> in current patch.
> 

I had expected it to be disabled given that SIS_PROP does work to
calculcate nr, then discards it, and uses SIS_UTIL. If SIS_UTIL shows a
regression and reports a bug, the first step would be to disable
SIS_UTIL and enable SIS_PROP via sched_feat.

-- 
Mel Gorman
SUSE Labs
