Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5455B4A868A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351509AbiBCOeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351318AbiBCOdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37FFC06175A;
        Thu,  3 Feb 2022 06:33:34 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fv2xrT6sCg1OX/niRBfx/0/7zd87QN/xf0hYX+pZoro=;
        b=yzmW8lycClyjXVeo1Rs2krHU1D3SYR03NQG3Ob2yFXduQp3tq3LGFidms0g5qYcIMmCbX8
        pfWsLXMF1YLvcnQdqE7k8mCY7wLleEvLfzygNEx7wkMwrqLz7uZP0hAHXlneYqf9U48eOz
        vEZvR76TL9RoAdft/AARVA5FBSc3EP/QfsZS/HbwyjHnsupUIER/kjdY3f3pogHUHP6cIw
        3VkS1jKipEKv1bg3rH+uDtNLRCChbShnnlKSRk8GzTSEFjMDFeN+Oz3ucsSG87v/m4Ts/j
        DCjEEqcLe/yk+muFRjuTA2FJ/MSqDuBKvyuY/DK/o9ZwEDRj5ToOJM0+bSCruA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fv2xrT6sCg1OX/niRBfx/0/7zd87QN/xf0hYX+pZoro=;
        b=Uymo9TF28AV99YKc0xB5pba1rA5geg973QxK3WHfX9WatYkTraCQSX/vb8tJ6OQq4Qog+b
        B81ArDyLp31d87DQ==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: uapi: Document perf_event_attr::sig_data
 truncation on 32 bit architectures
Cc:     Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220131103407.1971678-3-elver@google.com>
References: <20220131103407.1971678-3-elver@google.com>
MIME-Version: 1.0
Message-ID: <164389881239.16921.12788730223046077815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ddecd22878601a606d160680fa85802b75d92eb6
Gitweb:        https://git.kernel.org/tip/ddecd22878601a606d160680fa85802b75d92eb6
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 31 Jan 2022 11:34:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:40 +01:00

perf: uapi: Document perf_event_attr::sig_data truncation on 32 bit architectures

Due to the alignment requirements of siginfo_t, as described in
3ddb3fd8cdb0 ("signal, perf: Fix siginfo_t by avoiding u64 on 32-bit
architectures"), siginfo_t::si_perf_data is limited to an unsigned long.

However, perf_event_attr::sig_data is an u64, to avoid having to deal
with compat conversions. Due to being an u64, it may not immediately be
clear to users that sig_data is truncated on 32 bit architectures.

Add a comment to explicitly point this out, and hopefully help some
users save time by not having to deduce themselves what's happening.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/r/20220131103407.1971678-3-elver@google.com
---
 include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 1b65042..82858b6 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -465,6 +465,8 @@ struct perf_event_attr {
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
 	 * siginfo_t::si_perf_data, e.g. to permit user to identify the event.
+	 * Note, siginfo_t::si_perf_data is long-sized, and sig_data will be
+	 * truncated accordingly on 32 bit architectures.
 	 */
 	__u64	sig_data;
 };
