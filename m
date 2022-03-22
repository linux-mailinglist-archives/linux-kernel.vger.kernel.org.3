Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152F64E356A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiCVAYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiCVAYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:24:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65622DF3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647908587; x=1679444587;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOiVnLtmtOaXxc1V56DZer88UbTpxYJfZvguMvjAozA=;
  b=Umqy38rg2URe9i2elChsnVFa0SPtOi4kyI8kEU7/LngfECPLF5JVV6gS
   jajSmqDy5ElB1UK8UoFFf9Eh4KvtaZ4jJwj/kcbq31H1tEmcL4Uuxud5D
   2EXlbLYfTvJIa9x3WLDc9aK1RO0J3vy9YthHmxApOBa2eM35A5Yq2GteN
   XxnNaMPNjqkuHZC6DIhH3ehLjf4dvfupnWKRQhGABuyAt1X/R65UN6Est
   a0A2K2zaQKNpDipafN/RSn1/Q1GAWc71IhRbev+VSHDgq2C7w7PhiIX+5
   /aN2etbMBriBWZH4prKplRCU/blnsPCrxLPKVnhm+B2+PprfjxiWOs4XW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="238287755"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="238287755"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:22:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="518647965"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.227.186])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:22:22 -0700
Message-ID: <2d401a6c591e7fd1711c0db5b28517f7bf1f5adc.camel@linux.intel.com>
Subject: Re: [PATCH 3/6] sched: Allow sched_{get,set}attr to change
 latency_nice of the task
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com
Date:   Mon, 21 Mar 2022 17:22:22 -0700
In-Reply-To: <20220311161406.23497-4-vincent.guittot@linaro.org>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
         <20220311161406.23497-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-11 at 17:14 +0100, Vincent Guittot wrote:
> 
> +static void __setscheduler_latency(struct task_struct *p,
> +		const struct sched_attr *attr)
> +{
> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
> +		p->latency_prio = NICE_TO_LATENCY(attr->sched_latency_nice);

NICE_TO_LATENCY used here but has defined later in patch 5.  This will break
bisect.

> +		set_latency_weight(p);
> +	}
>  }
>  
> 

Tim

