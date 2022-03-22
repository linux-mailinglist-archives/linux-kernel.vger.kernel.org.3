Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9374E446D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiCVQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiCVQnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:43:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2A6F4B4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647967317; x=1679503317;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L1enrMMeP7A1GNwFPV4khrxuFYhjjyPfKFdlkVvrYpc=;
  b=lgx/ZLmb+r7+5O7OJZd5G9KfJB1y84WATbYTwFxXHbWYwrQUWv5m56oA
   lKOsWs6k1jva/Fqka0uOoAmFKRJqqFwhdLkRFOmvzvQQz7LYWy7sBhLvh
   eUBdjx0/QrUJHXmNfg0z37I/X1pLqUv8x9AoWFX9TBZllL9ZB/c72xHYu
   CVY+wn9c/1p9W82FDKbDu1ZqSIRHzfHAasPBtiW8feEY5xxRCya7OIJSw
   lwYcPporLQM39Al2QQPuuM4XI1KQD/81CbBPLcpg/2Aoll7rHyFEoJ9x+
   iVJOsSlblCHAeD9rE1jEKGPqkg648KsJbV4xs8jHFLG1HFRTXfm38MWo3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="245342758"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="245342758"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 09:41:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="518954584"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.218.224])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 09:41:47 -0700
Message-ID: <3c3a86fb2ead653318ecbaf2c999f6088c6eca4f.camel@linux.intel.com>
Subject: Re: [RFC 6/6] sched/fair: Add sched group latency support
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@google.com
Date:   Tue, 22 Mar 2022 09:41:47 -0700
In-Reply-To: <Yji0twS4N+0b/Rs9@slm.duckdns.org>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
         <20220311161406.23497-7-vincent.guittot@linaro.org>
         <Yji0twS4N+0b/Rs9@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-21 at 07:24 -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Mar 11, 2022 at 05:14:06PM +0100, Vincent Guittot wrote:
> > Tasks can set its latency priority which is then used to decide to preempt
> > the current running entity of the cfs but sched group entities still have
> > the default latency priority.
> > 
> > Add a latency field in task group to set the latency priority of the group
> > which will be used against other entity in the parent cfs.
> 
> One thing that bothers me about this interface is that the configuration
> values aren't well defined. We have the same problems with the nice levels
> but at least have them map to well defined weight values, which likely won't
> change in any foreseeable future. The fact that we have the
> not-too-well-defined nice levels as an interface shouldn't be a reason we
> add another one. Provided that this is something scheduler folks want, it'd
> be really great if the interface can be better thought through. What are the
> numbers actually encoding?
> 
> 

The way I was interpreting the latency_nice number is as follow:
Given runnable tasks that have not exceeded their time slice,
the task with the lowest latency nice number run first.

The current patchset takes care of the
case of tasks within a run queue. I think we also need to
consider which cpu should be selected for a waking
task, if we cannot find an idle CPU.

It seems reasonable that we wake a task on a CPU that is running a task with
a higher latency nice value and lower load than previous CPU the waking task
has run on. That way we can wake latency sensitive tasks faster in a busy system.

Tim

