Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1967A5259C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376557AbiEMCli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376539AbiEMCl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:41:28 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D6762BF8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:41:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652409684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4jjnk+QDL8cNXK+XlAhyOlRkhsLJfwm4AuVjS6SIBdU=;
        b=s7h2HIaBh8pyCxOmw32WC4p867WDpAAzQVoO9w/UuKwaNvcveu357EU+wRJIrqXhGFRfkD
        6GZBQcB2uVsqV/M0wkoVlZSErHbNuVu3AUx9vFAEDTbZLc9m0x30RBalLucoydCbO7aspp
        VaGEUMPEvfqtbNDRMKPdTJ0gQsqox14=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] sched/deadline: Use proc_douintvec_minmax() limit minimum value
Date:   Fri, 13 May 2022 10:41:09 +0800
Message-Id: <20220513024109.648471-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc_dointvec() is not applicable for unsigned integer, use
proc_douintvec_minmax() limit minimum value.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/deadline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 85cd62e0dddd..4d2a780c6f73 100644
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
-- 
2.25.1

