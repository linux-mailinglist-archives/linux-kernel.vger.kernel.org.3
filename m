Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6345AE8E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiIFMzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiIFMza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:55:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A54541D1A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:55:06 -0700 (PDT)
X-UUID: 565fc1898ac64b9d9647b38260c8bd04-20220906
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:CC:To:From:Subject:Message-ID; bh=QmYjLs9Asoq2RnmK+JEPLEipTLEMcIgsHAUlvR3DFFY=;
        b=q7gqnjhCjLoQx2aoCeHbyOwF2CLs+GmF4fPzlWNRV1REEKnlkwMz0YpSuoetGVxv8j/wcpOz3U72SmccFCEsTo8/mckSIALNt9H6y8+fpW7bpDXrE1Bd/mXnNex/PYbQ3XiIrfema4kym08Gv8QyMNlQEiAxeLhG4JC7rjZX+DU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:e1ea691a-d27e-4239-99f6-d99bc026798e,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:-25
X-CID-META: VersionHash:84eae18,CLOUDID:e6605e21-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 565fc1898ac64b9d9647b38260c8bd04-20220906
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2069503692; Tue, 06 Sep 2022 20:55:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 6 Sep 2022 20:54:58 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 6 Sep 2022 20:54:58 +0800
Message-ID: <6dab6e564e43c952f63f83ef868da6ed829fc1a8.camel@mediatek.com>
Subject: BUG: list_add corruption while doing migrate_swap -> balance_push
From:   Kuyo Chang <kuyo.chang@mediatek.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <jing-ting.wu@mediatek.com>,
        <yt.chang@mediatek.com>, <jonathan.jmchen@mediatek.com>
Date:   Tue, 6 Sep 2022 20:54:58 +0800
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

Hi,

[Syndrome]
A list_add corruption error at kernel-5.15, the log shows.
list_add corruption. prev->next should be next (ffffff81a6f08ba0), but
was 0000000000000000. (prev=ffffff81a6f05930).

The call trace as below:
ipanic_die
notify_die
die
bug_handler
brk_handler
do_debug_exception
el1_dbg
el1h_64_sync_handler
el1h_64_sync
__list_add_valid
cpu_stop_queue_work
stop_one_cpu_nowait
balance_push
__schedule
schedule
do_sched_yield
__arm64_sys_sched_yield
invoke_syscall
el0_svc_common
do_el0_svc
el0_svc
el0t_64_sync_handler
el0t_64_sync

[Analysis]
By memory dump and analyzing the stopper->works list, the error code
flow as following:

migrate_swap 
->stop_two_cpus
	->cpu_stop_queue_two_works
		->__cpu_stop_queue_work (add work->list to stopper-
>works respectively)	
			->list_add_tail(&work->list, &stopper->works);
	->wake_up_q(&wakeq);	
->wait_for_completion(&done.completion);
->wait_for_common
->schedule_timeout
->schedule

At this point, the cpu hotplug trigged,
It registers balance_callback by below flow:
cpu_down(cpuid)
->_cpu_down
->cpuhp_set_state()
->set_cpu_dying(cpuid, true)
->sched_cpu_deactivate
->balance_push_set(cpuid, true)
	->rq->balance_callback = &balance_push_callback;


Finally, 
->__schedule
->__balance_callbacks
->do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
->balance_push
->stop_one_cpu_nowait
	*work_buf = (struct cpu_stop_work){ .fn = fn, .arg = arg,
.caller = _RET_IP_, };
At this point the list_head *next, *prev is initial to NULL!!
->cpu_stop_queue_work
->__list_add_valid

So it will hit this error 
if (CHECK_DATA_CORRUPTION(next->prev != prev,
	"list_add corruption. next->prev should be prev (%px), but was
%px. (next=%px).\n",
	prev, next->prev, next)

Do you have any suggestion for this issue?
Thank you.

