Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33B25A442C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiH2HuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiH2HuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:50:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C84B7CD;
        Mon, 29 Aug 2022 00:50:04 -0700 (PDT)
Date:   Mon, 29 Aug 2022 07:49:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661759400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m83x3rOtBCyxK9jZbtmzHax/B8nwvamRDtYJhJURYnc=;
        b=aRaCIk5bYpwzsSASJLKlOARxAi4NnvA4PLCV+t6ZmViwLPlkDVmNnfsVc1z5UTpCwg/Rc+
        qHW5DFw5E7zzxRBdx6kPXkyACu/ZjtgIf8LIbHXsDlE1ec5F0RK6ZWkT7uz3svBbwj8tLk
        t9YVyCIndnWr8S6NHErYUI+dFhQfNVPKA5yG2W9q2m84IOA7u/QBaDb6nxwr6D9KVMJYKa
        v+fLldkbxqIN+qTqlPPuKR97vHnPm3v+lxQ2yCRwaV+FlSCN91icWSbK9lfAKYx+Pcq/QA
        bMdOEj0HJWTiNW/4TVqsEM3YlgQ+b1czYmjsrX/HkRnUnUzlAb3kDirwlJIMqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661759400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m83x3rOtBCyxK9jZbtmzHax/B8nwvamRDtYJhJURYnc=;
        b=h0K9fU3j+exbFYpKMoxOl98LPPrIQD5U3ArPYzfB4SI4gNOZlspNZXWhWiUaXAxNn+Wl8G
        kcEjur4YB1Ps8hBQ==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64
 platform
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        James Clark <james.clark@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824044822.70230-5-anshuman.khandual@arm.com>
References: <20220824044822.70230-5-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <166175939919.401.15637919286180203926.tip-bot2@tip-bot2>
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

Commit-ID:     f4054e522531038354bea5c924f286fdd8ae77b5
Gitweb:        https://git.kernel.org/tip/f4054e522531038354bea5c924f286fdd8ae77b5
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Wed, 24 Aug 2022 10:18:18 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Aug 2022 09:42:42 +02:00

perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform

BRBE captured branch types will overflow perf_branch_entry.type and generic
branch types in perf_branch_entry.new_type. So override each available arch
specific branch type in the following manner to comprehensively process all
reported branch types in BRBE.

  PERF_BR_ARM64_FIQ            PERF_BR_NEW_ARCH_1
  PERF_BR_ARM64_DEBUG_HALT     PERF_BR_NEW_ARCH_2
  PERF_BR_ARM64_DEBUG_EXIT     PERF_BR_NEW_ARCH_3
  PERF_BR_ARM64_DEBUG_INST     PERF_BR_NEW_ARCH_4
  PERF_BR_ARM64_DEBUG_DATA     PERF_BR_NEW_ARCH_5

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: James Clark <james.clark@arm.com>
Link: https://lkml.kernel.org/r/20220824044822.70230-5-anshuman.khandual@arm.com
---
 include/uapi/linux/perf_event.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 1a258d4..dca1658 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -293,6 +293,12 @@ enum {
 	PERF_BR_PRIV_HV		= 3,
 };
 
+#define PERF_BR_ARM64_FIQ		PERF_BR_NEW_ARCH_1
+#define PERF_BR_ARM64_DEBUG_HALT	PERF_BR_NEW_ARCH_2
+#define PERF_BR_ARM64_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
+#define PERF_BR_ARM64_DEBUG_INST	PERF_BR_NEW_ARCH_4
+#define PERF_BR_ARM64_DEBUG_DATA	PERF_BR_NEW_ARCH_5
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
