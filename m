Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF55599A7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiFXM2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiFXM2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:28:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C2E3AA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656073683; x=1687609683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NDc9vT5IoTosV8G5N/QPmWU33g+WHJMMCUppE1xtYQc=;
  b=n6euJB9tBZ13QNHqqLVnP/qCvM/G0ENgX04a2cq2rhXLqVxhJSeJfK8v
   z2GEkvmganNwyqsL7tlXlDQDffogSMKXQ+Z9+cuvZGh/a9rZPOvor4hlb
   W6HqQGoYbpeooNYq19+Y8XXq02RQme8mZf+K9/FD9XpIg6bQxksAEdMF3
   /XPdIEkzjm2gvy4B++MHw2XwaHu7Y4QMLqf7xau/tmlQ9f0uQ5WuTLRz8
   odQZA1HWbQqYrh0OQjzMp342ATMGnPwgI+7Tpe4sX6j86jewt8O8KxA8L
   ji0FHldSjz3l2qB/+6qztJjfob/6Q21GDgmvZha45RenuUBpKdLavOVLV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367309483"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367309483"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 05:28:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="621703917"
Received: from cma16-mobl1.ccr.corp.intel.com (HELO chenyu5-mobl1.lan) ([10.255.29.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 05:27:57 -0700
Date:   Fri, 24 Jun 2022 20:27:53 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
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
        Yicong Yang <yangyicong@hisilicon.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>
Subject: Re: [PATCH v4] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
Message-ID: <20220624122753.GA6149@chenyu5-mobl1.lan>
References: <20220612163428.849378-1-yu.c.chen@intel.com>
 <76c94a3b-6ca2-e0e2-c618-42b147d2737d@amd.com>
 <20220624020723.GA11803@chenyu5-mobl1>
 <4027cf04-d39e-d8fd-b3af-c1873757bb39@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4027cf04-d39e-d8fd-b3af-c1873757bb39@amd.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 09:34:49AM +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 6/24/2022 7:37 AM, Chen Yu wrote:
> 
> >
> > [..snip..]>
> >> With v4 on the current tip, I don't see any need for
> >> a special case for systems with smaller LLCs with
> >> SIS_PROP disabled and SIS_UITL enable. Even SIS Efficiency
> >> seems to be better with SIS_UTIL for hackbench.
> >>
> >> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > Thanks again. Would you mind if I add this test report link into next patch
> > version?
> 
> Sure.
> I'm assuming the next version will disables SIS_PROP and only
> keep SIS_UTIL enabled which is the same configuration we ran
> during this round of testing. The results should stay the same :)
> --
Yes Peter has helped me change the default value of SIS_PROP and with
the current link in commit log, I assume we can find your data via it.

thanks,
Chenyu
> Thanks and Regards,
> Prateek
