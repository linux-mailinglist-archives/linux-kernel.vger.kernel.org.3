Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFC04B69D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiBOKyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:54:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiBOKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:54:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B68D76D5;
        Tue, 15 Feb 2022 02:54:30 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644922469;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhZYoxzxfEOvDUt95ytHuaO6UV9sM19sRDFyF/YVt90=;
        b=sNeu7QnwY5exnvr9C+xjfQzHWdBDzcbvrsM1njCep6ly5DCZdZAoeZOddmSGg/8u8IZMHj
        vEvHnQ43JpWiGeEF/Tq+JBnuJk9CSAuUDKiyvCWzVXdjx2DCBuQwrr7zjCXM3/OykzulXe
        smM0u5XR0MViENIgT9GjEMM3/pJ0IqCC7rcvbjWFH/Bn/Mg1UGG55Y7ODXvgMpe810hca6
        uhhI2gI0ilH3yO2TK5cb4Mj1i/pXhqnxIujduirfkqayNffY86nx85G5oS26vXHREdfX9K
        CeMVpUBxhu4r4kv4fg5iR/wQdjn/3/JMoDubdO9OK8DwJM9aROClu1Btl2qxPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644922469;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhZYoxzxfEOvDUt95ytHuaO6UV9sM19sRDFyF/YVt90=;
        b=bGf0KbKKIA5jUjlgAtgNFuSQdYgXascYt/CNPxlC5vKkjUCFxU5B//Y2fJGBBSBnNcJXMB
        QgKsxQPcd+w+54BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] sched: Define and initialize a flag to identify
 valid PASID in the task
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207230254.3342514-8-fenghua.yu@intel.com>
References: <20220207230254.3342514-8-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <164492246835.16921.7907428293330409129.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     a3d29e8291b622780eb6e4e3eeaf2b24ec78fd43
Gitweb:        https://git.kernel.org/tip/a3d29e8291b622780eb6e4e3eeaf2b24ec78fd43
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 07 Feb 2022 15:02:50 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Feb 2022 11:31:43 +01:00

sched: Define and initialize a flag to identify valid PASID in the task

Add a new single bit field to the task structure to track whether this task
has initialized the IA32_PASID MSR to the mm's PASID.

Initialize the field to zero when creating a new task with fork/clone.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220207230254.3342514-8-fenghua.yu@intel.com
---
 include/linux/sched.h | 3 +++
 kernel/fork.c         | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa..4e5de3a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -938,6 +938,9 @@ struct task_struct {
 	/* Recursion prevention for eventfd_signal() */
 	unsigned			in_eventfd_signal:1;
 #endif
+#ifdef CONFIG_IOMMU_SVA
+	unsigned			pasid_activated:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index c03c668..51fd1df 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -968,6 +968,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->use_memdelay = 0;
 #endif
 
+#ifdef CONFIG_IOMMU_SVA
+	tsk->pasid_activated = 0;
+#endif
+
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
