Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7835482CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbiFMJIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiFMJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:08:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F7F1085
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655111316; x=1686647316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/xfr7er5pb9mxRpWgXM+pcGqC+mkTeha9+7hr/drtQI=;
  b=EAVflvIUqux6I1Kkj9r4qxx4Ky4F6JHtx9S1P2t+s3DR9x/RoMUQSPDS
   TQXKX8X3wQRkdvtVvwCtvgzUG15acqpoOaijnXTETSUIDVsjzbNgCmMd0
   qhqH5IvwrNPspsJVDqxe38gWoRnanCQSBpf2GLH8C2/B16lfG0/t6/EqL
   svkAXGtSgCan1etW2oJgli8Wsk8zel0j8U98zo6bkM2apF4viMNnnrrXX
   IoNKDbQQBTHUfB/4wgUacTsCrxpsxa01pSnrniwZgZjDYWsNfqa5mZsXM
   ljcsjpSUzLcExQeXZbGfcxuV+svRq3Vu4FDcHdM4+26SnerRoSE68qSEn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="258662354"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="258662354"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 02:08:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="639627927"
Received: from xiruzha-mobl1.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.169.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 02:08:29 -0700
Date:   Mon, 13 Jun 2022 17:08:26 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mel Gorman <mgorman@suse.de>
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
Message-ID: <20220613090826.GA36036@chenyu5-mobl1>
References: <20220612163428.849378-1-yu.c.chen@intel.com>
 <ca59e113-d5df-7dec-6bab-a8d239b50c0b@huawei.com>
 <20220613080636.GA32587@chenyu5-mobl1>
 <20220613085437.GC3195@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613085437.GC3195@suse.de>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 09:54:37AM +0100, Mel Gorman wrote:
> On Mon, Jun 13, 2022 at 04:06:36PM +0800, Chen Yu wrote:
> > On Mon, Jun 13, 2022 at 03:40:52PM +0800, Yicong Yang wrote:
> > > On 2022/6/13 0:34, Chen Yu wrote:
> > > >  
> > [cut...]
> > > >  #define NUMA_IMBALANCE_MIN 2
> > > > diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> > > > index 1cf435bbcd9c..3334a1b93fc6 100644
> > > > --- a/kernel/sched/features.h
> > > > +++ b/kernel/sched/features.h
> > > > @@ -61,6 +61,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
> > > >   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
> > > >   */
> > > >  SCHED_FEAT(SIS_PROP, true)
> > > > +SCHED_FEAT(SIS_UTIL, true)
> > > >  
> > > 
> > > confused here that shouldn't we have SCHED_FEAT(SIS_PROP, false)? With SIS_UTIL enabled, SIS_PROP will have no
> > > effect since nr is overridden by SIS_UTIL.
> > Yes, no matter what SIS_PROP is set, the result of SIS_UTIL would be used to decide
> > the scan depth. We don't change the default value of SIS_PROP here, as this patch
> > tends to only touch one feature at one time. And the options could be tuned by user via
> > sysfs manually. Besides, the target is to replace SIS_PROP with another search policy,
> > Peter mentioned that "And ideally we're remove SIS_PROP after a few releases if this
> > works out", so I assume that changing the default value of SIS_PROP does not matter
> > in current patch.
> > 
> 
> I had expected it to be disabled given that SIS_PROP does work to
> calculcate nr,
I see, disable SIS_PROP would reduce duplicated nr calculation.
> then discards it, and uses SIS_UTIL. If SIS_UTIL shows a
> regression and reports a bug, the first step would be to disable
> SIS_UTIL and enable SIS_PROP via sched_feat.
OK, I'll change it in next version.

thanks,
Chenyu
> 
> -- 
> Mel Gorman
> SUSE Labs
