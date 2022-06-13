Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3A548231
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiFMIny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiFMIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:43:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B7125DB;
        Mon, 13 Jun 2022 01:43:28 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:43:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/t8V9RTay6HF+i3ofpS9zCfxlt6ZCxIhUavf3Jtm7aY=;
        b=Dp+y9jTcxp9seTZwXVOS5LzMmdjk16N0IrilTu/58LHxwPi132mmmkuyw+RRN06ky6JvCi
        DiOPBGotb8Y5eSDlMJs83ueblLYRfRopgNZhfr68M7YscSI1JwS5KtUD7plSLDdB3GzKq8
        kH6QUFnqh163Wf3q7w3EEpbNmXAZKMc5h4wqxSIMT2RkigtdNM1eE1J3nnwDwSLjumgYI9
        MIYkGtek6kfC58tiDrqgWpIG/g2R52ng9ymFoch9Rby6Dt8bfdOZCDdpwfv98rmsQbvFrq
        ZeG3+ifPUdRSSwa7eYYO6KuaAa8nl9jdJMoLOLl989CGQkb3zHF3wKnM1VLK7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/t8V9RTay6HF+i3ofpS9zCfxlt6ZCxIhUavf3Jtm7aY=;
        b=D53heMmj1EVPprVANalcaI88XNMlwMJCDyROuFHbIBXiOI7Qwh5EWsOfJn6jFj0T/RJL8b
        VMVY9UFCkRe6wABg==
From:   "tip-bot2 for Yajun Deng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Use proc_douintvec_minmax() limit
 minimum value
Cc:     Yajun Deng <yajun.deng@linux.dev>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220607101807.249965-1-yajun.deng@linux.dev>
References: <20220607101807.249965-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Message-ID: <165510980561.4207.4781637926120496511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2ed81e765417ec2526f901366167a13294ef09ce
Gitweb:        https://git.kernel.org/tip/2ed81e765417ec2526f901366167a13294ef09ce
Author:        Yajun Deng <yajun.deng@linux.dev>
AuthorDate:    Tue, 07 Jun 2022 18:18:07 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:30:00 +02:00

sched/deadline: Use proc_douintvec_minmax() limit minimum value

sysctl_sched_dl_period_max and sysctl_sched_dl_period_min are unsigned
integer, but proc_dointvec() wouldn't return error even if we set a
negative number.

Use proc_douintvec_minmax() instead of proc_dointvec(). Add extra1 for
sysctl_sched_dl_period_max and extra2 for sysctl_sched_dl_period_min.

It's just an optimization for match data and proc_handler in struct
ctl_table. The 'if (period < min || period > max)' in __checkparam_dl()
will work fine even if there hasn't this patch.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Link: https://lore.kernel.org/r/20220607101807.249965-1-yajun.deng@linux.dev
---
 kernel/sched/deadline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b515296..5867e18 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -30,14 +30,16 @@ static struct ctl_table sched_dl_sysctls[] = {
 		.data           = &sysctl_sched_dl_period_max,
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler   = proc_douintvec_minmax,
+		.extra1         = (void *)&sysctl_sched_dl_period_min,
 	},
 	{
 		.procname       = "sched_deadline_period_min_us",
 		.data           = &sysctl_sched_dl_period_min,
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler   = proc_douintvec_minmax,
+		.extra2         = (void *)&sysctl_sched_dl_period_max,
 	},
 	{}
 };
