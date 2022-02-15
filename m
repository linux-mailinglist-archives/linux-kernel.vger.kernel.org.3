Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408BE4B69DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbiBOKzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:55:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbiBOKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:54:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AACD76DA;
        Tue, 15 Feb 2022 02:54:37 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:54:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644922475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/exb0we9AvmagPywoajGH1z+BLIs+h/v7q1Ipl6ITk=;
        b=aLXEYtko55uSr45ctGYEi1XiLDCMF/sGERNFt5akm1kh3EWyd7vV/caF31mEeI8thPy5XZ
        x4LtCLUHArtrojd9PhieSc2ma2NDI4nxIoCVZz7PwuBzcpcnQ/ojOYZ5+M21dLIyawh0fU
        kbUAno1h9GKuEgJkb4+m9w2QTLzYhzXWsuo7jrG0NUE6ZDRbebh2Xjpc2K9ju3Ck9abz/v
        rDzFEHRB7M7uHz102IzBDN+TdigTFQ7RYLw6S67kwxYAJawVk+wp3fzqddV8+Je9hAxRjl
        ptAPLGeikj/yyL4+ffrGqP3+PUi9SPUpwNdNvN6Mo9M87jJi1ds9tWVGoTu6PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644922475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/exb0we9AvmagPywoajGH1z+BLIs+h/v7q1Ipl6ITk=;
        b=q7+SD0ss3Ln/RItMXIuYY7qYbMMZzHCdI9GKBrIHCjynCW7CLacThigs8mWf35g924LHlq
        L8TfABmcSiW3v7Ag==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] mm: Change CONFIG option for mm->pasid field
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207230254.3342514-3-fenghua.yu@intel.com>
References: <20220207230254.3342514-3-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <164492247321.16921.8754359025993339959.tip-bot2@tip-bot2>
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

Commit-ID:     7a853c2d5951419fdf3c1c9d2b6f5a38f6a6857d
Gitweb:        https://git.kernel.org/tip/7a853c2d5951419fdf3c1c9d2b6f5a38f6a6857d
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 07 Feb 2022 15:02:45 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 14 Feb 2022 19:23:50 +01:00

mm: Change CONFIG option for mm->pasid field

This currently depends on CONFIG_IOMMU_SUPPORT. But it is only
needed when CONFIG_IOMMU_SVA option is enabled.

Change the CONFIG guards around definition and initialization
of mm->pasid field.

Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20220207230254.3342514-3-fenghua.yu@intel.com
---
 include/linux/mm_types.h | 2 +-
 kernel/fork.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5140e5f..c5cbfd7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -631,7 +631,7 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
 
-#ifdef CONFIG_IOMMU_SUPPORT
+#ifdef CONFIG_IOMMU_SVA
 		u32 pasid;
 #endif
 	} __randomize_layout;
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528..6ee7551 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1021,7 +1021,7 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
 
 static void mm_init_pasid(struct mm_struct *mm)
 {
-#ifdef CONFIG_IOMMU_SUPPORT
+#ifdef CONFIG_IOMMU_SVA
 	mm->pasid = INIT_PASID;
 #endif
 }
