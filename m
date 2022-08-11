Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6E558F8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiHKHyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiHKHyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:54:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F200513E2E;
        Thu, 11 Aug 2022 00:54:36 -0700 (PDT)
X-UUID: c537b5c587bb409a98dcb065de503d5c-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:CC:To:From:Subject:Message-ID; bh=Pl+MDAa1cNSlme5ohVZ4QGF7+/nE1dHPujEfDH6bqDU=;
        b=JLRMdhdZ20fugIkHP1XpgLOxkA7POauHg5M/uAFqidO+2BZGke2xLp4VGEYAxgd1HlHmPaT4GsBihbZp3y3nDRC1+w3v0+fIq3yzEmL5jZuS5ux5q/ERqoxBwwpXEmytfSW9sag2IT7Fw8juTDD1LBkzFTxBWoy9nbDZLbt2/A8=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:253d8c81-3ec1-4b2a-9e4c-5e265f4190c3,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Relea
        se_Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.9,REQID:253d8c81-3ec1-4b2a-9e4c-5e265f4190c3,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS
        981B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:3d8acc9,CLOUDID:2d0384ae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:f096d32b22bb,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: c537b5c587bb409a98dcb065de503d5c-20220811
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 809153656; Thu, 11 Aug 2022 15:54:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 11 Aug 2022 15:54:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Aug 2022 15:54:28 +0800
Message-ID: <3bcf5d974b98acccde89e8d5567d3ddcdfb44800.camel@mediatek.com>
Subject: [Race condition] Race condition at cpuidle_enter_s2idle &
 __cfi_slowpath_diag
From:   Kuyo Chang <kuyo.chang@mediatek.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>
CC:     <kuyo.chang@mediatek.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <rcu@vger.kernel.org>,
        <llvm@lists.linux.dev>
Date:   Thu, 11 Aug 2022 15:54:28 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

During doing s2idle(Suspend-To-Idle) flow, I found a task will put into
runqueue by __cfi_slowpath_diag.
The code trace about fail case as below:

call_cpuidle_s2idle
->if (current_clr_polling_and_test()) //check resched flag
	return -EBUSY;
->cpuidle_enter_s2idle
->enter_s2idle_proper
->target_state->enter_s2idle(dev, drv, index);

Meanwhile the log shows the __cfi_slowpath_diag function will wake up a
task to CPU, below is the backtrace
__cfi_slowpath_diag
find_check_fn
rcu_irq_enter
rcu_nmi_enter
rcu_cleanup_after_idle
invoke_rcu_core
raise_softirq(RCU_SOFTIRQ)
raise_softirq_irqoff
    if (!in_interrupt() && should_wake_ksoftirqd())
        wakeup_softirqd();
//wake up flow
wake_up_process
try_to_wake_up
ttwu_queue
ttwu_do_activate
ttwu_do_wakeup
check_preempt_curr
resched_curr
set_tsk_need_resched(curr);
 

So It will violate the initial check at call_cpuidle_s2idle(Now it
exists a task at rq  and need reched, so it should not enter
cpuidle_enter_s2idle )
if (current_clr_polling_and_test())
	return -EBUSY;

I look the racing may be related to the following patch

57cd6d1 cfi: Fix __cfi_slowpath_diag RCU usage with cpuidle
https://android.googlesource.com/kernel/common/+/57cd6d1

Do you have any suggestion for this issue?
Thank you.

