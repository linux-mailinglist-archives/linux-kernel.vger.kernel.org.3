Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD0C519753
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiEDG21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbiEDG2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:28:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C495119C1E;
        Tue,  3 May 2022 23:24:41 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2445nLTW027207;
        Wed, 4 May 2022 06:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ENsJncblV7MX+tOsDWkM8v9t4vCjK6oV/YooaWFcyWM=;
 b=EcqVQwnlh+Xvkg9h6oy+LK/kN0RnPahkOLT0FmwewsZMqIE1jewqdqec/hz8xl7HoYtN
 cnN4WU4KQZosrXmAX+y4VJAKiaYsgkNfrYgHyX78s9Knj+xr0ei2mEtbsfhNwf8VkIvx
 Q1JWhtWx6+C51TJj0xPH8b9Wf6M3ejVoVXK4TkROJHIFtUfVB7ZmZZLi5ROXOx03sET/
 IX3ig1Z7wUrS2wWIzYije3zHrYrW9tYq0xDoSW7vdzQ3NvmkE0QbOOnvG4eVVstWFAGn
 QSYSeWRoyi1I+kFl3vw8+Pfa5US+ep1PVra0OOecYO0dy8jw9ydWJAHx49HXIfzVQjLo yQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fukp2rhm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 06:24:21 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2446J2Ze005048;
        Wed, 4 May 2022 06:24:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3frvr8v4yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 06:24:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2446OHgK20709878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 May 2022 06:24:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABE8AAE045;
        Wed,  4 May 2022 06:24:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 757FFAE051;
        Wed,  4 May 2022 06:24:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 May 2022 06:24:17 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/2] entry: Rename arch_check_user_regs() to arch_enter_from_user_mode()
Date:   Wed,  4 May 2022 08:23:50 +0200
Message-Id: <20220504062351.2954280-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504062351.2954280-1-tmricht@linux.ibm.com>
References: <20220504062351.2954280-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oXgtngU0IsRhp3xNgxSwBY31uOFlL5JV
X-Proofpoint-ORIG-GUID: oXgtngU0IsRhp3xNgxSwBY31uOFlL5JV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_01,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=977 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

arch_check_user_regs() is used at the moment to verify that struct pt_regs
contains valid values when entering the kernel from userspace. s390 needs
a place in the generic entry code to modify a cpu data structure when
switching from userspace to kernel mode. As arch_check_user_regs() is
exactly this, rename it to arch_enter_from_user_mode().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/include/asm/entry-common.h | 4 ++--
 arch/x86/include/asm/entry-common.h  | 4 ++--
 include/linux/entry-common.h         | 8 ++++----
 kernel/entry/common.c                | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
index 2f0a1cacdf85..99d654ccd3db 100644
--- a/arch/s390/include/asm/entry-common.h
+++ b/arch/s390/include/asm/entry-common.h
@@ -15,12 +15,12 @@
 void do_per_trap(struct pt_regs *regs);
 
 #ifdef CONFIG_DEBUG_ENTRY
-static __always_inline void arch_check_user_regs(struct pt_regs *regs)
+static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 {
 	debug_user_asce(0);
 }
 
-#define arch_check_user_regs arch_check_user_regs
+#define arch_enter_from_user_mode arch_enter_from_user_mode
 #endif /* CONFIG_DEBUG_ENTRY */
 
 static __always_inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 43184640b579..674ed46d3ced 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -10,7 +10,7 @@
 #include <asm/fpu/api.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
-static __always_inline void arch_check_user_regs(struct pt_regs *regs)
+static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
 		/*
@@ -42,7 +42,7 @@ static __always_inline void arch_check_user_regs(struct pt_regs *regs)
 		WARN_ON_ONCE(regs != task_pt_regs(current));
 	}
 }
-#define arch_check_user_regs arch_check_user_regs
+#define arch_enter_from_user_mode arch_enter_from_user_mode
 
 static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 						  unsigned long ti_work)
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ab78bd4c2eb0..c92ac75d6556 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -63,7 +63,7 @@
 	 ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
- * arch_check_user_regs - Architecture specific sanity check for user mode regs
+ * arch_enter_from_user_mode - Architecture specific sanity check for user mode regs
  * @regs:	Pointer to currents pt_regs
  *
  * Defaults to an empty implementation. Can be replaced by architecture
@@ -73,10 +73,10 @@
  * section. Use __always_inline so the compiler cannot push it out of line
  * and make it instrumentable.
  */
-static __always_inline void arch_check_user_regs(struct pt_regs *regs);
+static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs);
 
-#ifndef arch_check_user_regs
-static __always_inline void arch_check_user_regs(struct pt_regs *regs) {}
+#ifndef arch_enter_from_user_mode
+static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) {}
 #endif
 
 /**
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 93c3b86e781c..9e63923c5a0f 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -17,7 +17,7 @@
 /* See comment for enter_from_user_mode() in entry-common.h */
 static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 {
-	arch_check_user_regs(regs);
+	arch_enter_from_user_mode(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 
 	CT_WARN_ON(ct_state() != CONTEXT_USER);
-- 
2.32.0

