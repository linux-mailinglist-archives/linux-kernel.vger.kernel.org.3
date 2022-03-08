Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D0F4D0CEA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244201AbiCHAl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244110AbiCHAlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:41:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809203DDF2;
        Mon,  7 Mar 2022 16:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646700027; x=1678236027;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=mLllPTDfXt60Bir+ikPy6cJJ1bK+rUaZ0Sed6I0eCbg=;
  b=NITCLjlm4+dVU0oOfssmBPLhhUP1pVTQcPg1/9c3k8fw6Q7O+Pvd9bI3
   JJ7VyDlh+24pMkLkUsZOQ9IbsqIydQlVpN5vT+dyK3psl09V01RqFbBsT
   u0lkNyOjgKXKh9z7E2O9tp/YWwkPjho+hgwkTUgEhnsnyV9lWSV4o+UKB
   U7MwwtL1Mdp0RqiKUbBUtjX6swDyTQY/d8kz5zPlXHjlOgezQLDw/MfIf
   CRI9IkWT6cLFxAG+Am2HfeZ0ooZ3ZTCykOJ94sK8PoWA+aTl/xDnB5i3c
   CMV9t6sdxOJnc3bX0KnbWUM25ldI8EOLRvURMk2ksMQg6A6ZOEPvk6UW1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="253376521"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="253376521"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 16:40:25 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="553397703"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 16:40:23 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [tip: sched/core] sched/numa: Avoid migrating task to CPU-less
 node
References: <20220214121553.582248-2-ying.huang@intel.com>
        <164512421264.16921.689831789198253265.tip-bot2@tip-bot2>
        <Yh6H8SPSqpjv1dl7@qian>
        <87v8wx1850.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87wnh648ec.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YiYOc0NFlzJocYt0@qian>
Date:   Tue, 08 Mar 2022 08:40:21 +0800
In-Reply-To: <YiYOc0NFlzJocYt0@qian> (Qian Cai's message of "Mon, 7 Mar 2022
        08:53:55 -0500")
Message-ID: <87ee3dmg3u.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <quic_qiancai@quicinc.com> writes:

> On Mon, Mar 07, 2022 at 01:51:55PM +0800, Huang, Ying wrote:
>> > ---
>> >  kernel/sched/fair.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index a3f0ea216ccb..1fe7a4510cca 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -2405,7 +2405,7 @@ static void task_numa_placement(struct task_struct *p)
>> >  	}
>> >  
>> >  	/* Cannot migrate task to CPU-less node */
>> > -	if (!node_state(max_nid, N_CPU)) {
>> > +	if (max_nid != NUMA_NO_NODE && !node_state(max_nid, N_CPU)) {
>> >  		int near_nid = max_nid;
>> >  		int distance, near_distance = INT_MAX;
>> 
>> Do you have time to give this patch a try?
>
> Ah, I thought I has already replied it a while ago. Anyway, it works fine.

Thanks!

Best Regards,
Huang, Ying
