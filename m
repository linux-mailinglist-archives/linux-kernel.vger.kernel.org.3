Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98194D007F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbiCGNyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241359AbiCGNyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:54:53 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B27E344CE;
        Mon,  7 Mar 2022 05:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646661239; x=1678197239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AfhkZU3UC9bKYUCNGyAjLCkAjtrFk65MmiGtIE6ektM=;
  b=Q66L9hZTo9YHPw16kHNFL959VHtG460ePo9mePN5ZhFBh/JUqonoKcaI
   KtKxCoLLRHuTnUUoxEzKroX0jne4nyv91dFYmJgVWmZz9QPdhkYv3WLxE
   4f/+obGKu3CS4QMa6ZgWVBSUF4fA4F+j1fX4AQnFGjH7QIQ3LO0dqO4LC
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Mar 2022 05:53:58 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:53:58 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Mar 2022 05:53:58 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 7 Mar 2022
 05:53:57 -0800
Date:   Mon, 7 Mar 2022 08:53:55 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [tip: sched/core] sched/numa: Avoid migrating task to CPU-less
 node
Message-ID: <YiYOc0NFlzJocYt0@qian>
References: <20220214121553.582248-2-ying.huang@intel.com>
 <164512421264.16921.689831789198253265.tip-bot2@tip-bot2>
 <Yh6H8SPSqpjv1dl7@qian>
 <87v8wx1850.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87wnh648ec.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87wnh648ec.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 01:51:55PM +0800, Huang, Ying wrote:
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a3f0ea216ccb..1fe7a4510cca 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -2405,7 +2405,7 @@ static void task_numa_placement(struct task_struct *p)
> >  	}
> >  
> >  	/* Cannot migrate task to CPU-less node */
> > -	if (!node_state(max_nid, N_CPU)) {
> > +	if (max_nid != NUMA_NO_NODE && !node_state(max_nid, N_CPU)) {
> >  		int near_nid = max_nid;
> >  		int distance, near_distance = INT_MAX;
> 
> Do you have time to give this patch a try?

Ah, I thought I has already replied it a while ago. Anyway, it works fine.
