Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36FB4A868F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351523AbiBCOe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351246AbiBCOdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7A3C061760;
        Thu,  3 Feb 2022 06:33:37 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898815;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aufiJNeqKbWG5qejECq+w0euY/Y/TTYgy2GYR/nn4yU=;
        b=dAV1ViQYWGcasYUxJM5jFSadY2YKvjU4D71h/ms9ZCJhZkt0chw1aKiEdsKifS2pCp4Gej
        GuEgHdcDL9ITaImdeHo2LZ7NehR+t7pPlNT61ym2n/981VXj39tcMEosP6QIhuq3nHLcaB
        gtUwVvs06Q5KjUWMCpvyGvjD9ugnNJIBijQrUi80yHF6LvfkYYp9LqQ8/XkOQi7a2kUhRO
        4yThg2PRV89/RF7T2wD29Cb8TnvDSlUIG/YMkYcB2GjKnrIAe8SjrYNoobaTeXQp7LVKrG
        j/Mp6a368EV7cCJ7vBBZZSl77nNJdAq0mvVQau4rE5OmBQkLq9MPp+yWfaVS5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898815;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aufiJNeqKbWG5qejECq+w0euY/Y/TTYgy2GYR/nn4yU=;
        b=hsGOaKjDKeZmvolfvytVTjFCj4BIQuDS4f4p449PyyaXsSXkDatYt8kineTvQVzvzcpXVH
        5CjqnSas9IBMsgCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] x86/perf: Default set FREEZE_ON_SMI for all
Cc:     Kyle Huey <me@kylehuey.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YfKChjX61OW4CkYm@hirez.programming.kicks-ass.net>
References: <YfKChjX61OW4CkYm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164389881472.16921.5992719744302822334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a01994f5e5c79d3a35e5e8cf4252c7f2147323c3
Gitweb:        https://git.kernel.org/tip/a01994f5e5c79d3a35e5e8cf4252c7f2147323c3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 27 Jan 2022 12:32:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:39 +01:00

x86/perf: Default set FREEZE_ON_SMI for all

Kyle reported that rr[0] has started to malfunction on Comet Lake and
later CPUs due to EFI starting to make use of CPL3 [1] and the PMU
event filtering not distinguishing between regular CPL3 and SMM CPL3.

Since this is a privilege violation, default disable SMM visibility
where possible.

Administrators wanting to observe SMM cycles can easily change this
using the sysfs attribute while regular users don't have access to
this file.

[0] https://rr-project.org/

[1] See the Intel white paper "Trustworthy SMM on the Intel vPro Platform"
at https://bugzilla.kernel.org/attachment.cgi?id=300300, particularly the
end of page 5.

Reported-by: Kyle Huey <me@kylehuey.com>
Suggested-by: Andrew Cooper <Andrew.Cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
Link: https://lkml.kernel.org/r/YfKChjX61OW4CkYm@hirez.programming.kicks-ass.net
---
 arch/x86/events/intel/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c914340..a3c7ca8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4703,6 +4703,19 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.lbr_read		= intel_pmu_lbr_read_64,
 	.lbr_save		= intel_pmu_lbr_save,
 	.lbr_restore		= intel_pmu_lbr_restore,
+
+	/*
+	 * SMM has access to all 4 rings and while traditionally SMM code only
+	 * ran in CPL0, 2021-era firmware is starting to make use of CPL3 in SMM.
+	 *
+	 * Since the EVENTSEL.{USR,OS} CPL filtering makes no distinction
+	 * between SMM or not, this results in what should be pure userspace
+	 * counters including SMM data.
+	 *
+	 * This is a clear privilege issue, therefore globally disable
+	 * counting SMM by default.
+	 */
+	.attr_freeze_on_smi	= 1,
 };
 
 static __init void intel_clovertown_quirk(void)
