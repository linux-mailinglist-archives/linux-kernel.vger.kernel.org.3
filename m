Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D922F4E274A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347773AbiCUNO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiCUNO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:14:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CBD55B3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647868412; x=1679404412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/5/f0ZK4WUgeus+d6C/tJWEdzwU3AoK6pdM6y26uJ6A=;
  b=QD6Y58S/PhwBhsfnCe5uo9zEGfa/KA3vKyWLhXKt1SLwBxfFSyJC4gHh
   2QsNSRDE9uCWKbQM1boEjuhVCmALJK524UCnFzN+RTdiDbWaqoCS0mL2i
   U6JFwLe4AX0DaUBdqN6vm78fITCvP/WBhtDz+eHGyuZXlrmKFdj8EYbpN
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Mar 2022 06:13:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 06:13:27 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 06:13:26 -0700
Received: from qian (10.80.80.8) by nalasex01b.na.qualcomm.com (10.47.209.197)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 21 Mar
 2022 06:13:25 -0700
Date:   Mon, 21 Mar 2022 09:13:22 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [GIT PULL] scheduler updates for v5.18
Message-ID: <Yjh58h8cpcPERVZA@qian>
References: <YjhZUezhnamHAl0H@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YjhZUezhnamHAl0H@gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
> Huang Ying (3):
>       sched/numa-balancing: Move some document to make it consistent with the code
>       sched/numa: Fix NUMA topology for systems with CPU-less nodes
>       sched/numa: Avoid migrating task to CPU-less node

Linus, I don't think you want to merge this as-is. This will introduce a
kernel crash on arm64 NUMA as mentioned in this thread,

https://lore.kernel.org/lkml/Yh6H8SPSqpjv1dl7@qian

Ying sent an updated patch to fix the crash but is missing from this pull
request for some reasons.

https://lore.kernel.org/lkml/87y21lkxlv.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
