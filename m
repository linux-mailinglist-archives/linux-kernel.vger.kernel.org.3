Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB72519B92
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347169AbiEDJ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347133AbiEDJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:27:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D351B20BF1;
        Wed,  4 May 2022 02:23:22 -0700 (PDT)
Date:   Wed, 04 May 2022 09:23:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651656200;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFxXL6UDbo3wM6GIRrCU5DaWhDJcIhSj+zUbt+IaJF4=;
        b=qkuR2qJtxR1tYYvSdmoK56ADxAeGgRNdZMHDmbziOVBxfcfDoMrG71AKqC7GP8hMZXJHaY
        o8xh42pf3H2APEt+Mt7qTkSCoQem7WpAtIO4Csxh46Nv5mamg/SJLLlCmHuMf+8fPL2XB1
        1wjFjWsjMX4mvinVQrNtxV3cz0bDP1+30u06XeoUqhTmMViekxBcK+4/6GfxlCh+5C8aPw
        aFlwCpgyt4rDdc1jBxVRMlYDqwjC71T3u2GBdxpUbBD34PppGRaB0pMZwa77f41En3r3Dy
        GR3Hhw9SupkSb1IYpgkD76byfCvuoJmnQsIphVB5siryjUsR2Y2mWnkNSIzlWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651656200;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFxXL6UDbo3wM6GIRrCU5DaWhDJcIhSj+zUbt+IaJF4=;
        b=cvUBzrCQJ1xmIHwgJVcSbD7Qc8RoqBvieRS4k54LSAKYk9Jb0SM/Bj6hwpP8IOS37W5ZXc
        m8TggLxGdj7aK1CA==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Use interrupt regs ip for stack unwinding
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220429051441.14251-1-ravi.bangoria@amd.com>
References: <20220429051441.14251-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <165165619890.4207.17489201858185456103.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bd24325684029a48f20a188b899eb84900d0bc9c
Gitweb:        https://git.kernel.org/tip/bd24325684029a48f20a188b899eb84900d0bc9c
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Fri, 29 Apr 2022 10:44:41 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 May 2022 11:18:27 +02:00

perf/amd/ibs: Use interrupt regs ip for stack unwinding

IbsOpRip is recorded when IBS interrupt is triggered. But there is
a skid from the time IBS interrupt gets triggered to the time the
interrupt is presented to the core. Meanwhile processor would have
moved ahead and thus IbsOpRip will be inconsistent with rsp and rbp
recorded as part of the interrupt regs. This causes issues while
unwinding stack using the ORC unwinder as it needs consistent rip,
rsp and rbp. Fix this by using rip from interrupt regs instead of
IbsOpRip for stack unwinding.

Fixes: ee9f8fce99640 ("x86/unwind: Add the ORC unwinder")
Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220429051441.14251-1-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 9739019..11e8b49 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -304,6 +304,16 @@ static int perf_ibs_init(struct perf_event *event)
 	hwc->config_base = perf_ibs->msr;
 	hwc->config = config;
 
+	/*
+	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
+	 * recorded as part of interrupt regs. Thus we need to use rip from
+	 * interrupt regs while unwinding call stack. Setting _EARLY flag
+	 * makes sure we unwind call-stack before perf sample rip is set to
+	 * IbsOpRip.
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
+
 	return 0;
 }
 
@@ -687,6 +697,14 @@ fail:
 		data.raw = &raw;
 	}
 
+	/*
+	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
+	 * recorded as part of interrupt regs. Thus we need to use rip from
+	 * interrupt regs while unwinding call stack.
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		data.callchain = perf_callchain(event, iregs);
+
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
 	if (throttle) {
