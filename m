Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ADE4F5232
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849579AbiDFCjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442091AbiDEWKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:10:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFC128E24;
        Tue,  5 Apr 2022 13:56:20 -0700 (PDT)
Date:   Tue, 05 Apr 2022 20:56:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649192179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csCYSZXs/k/y3JYV+c94UAameL8Wjh0jsXSIlb67K8Q=;
        b=Zr4sKJQNms3Vp7nOKsP72FCqJfO4TRJz7omngb9vSBMDJDAf7n74gXj5GCTRs+ZcvFEuIu
        B5ttCJJzeUrXEtTkG/0L0ajHfAt1bkS/LmBQgbrn3Fo2jDu8phAsjiig+F7HAcAmk3QAlJ
        iHgjnOgiRjvIfz5lBIBaptu6SVyEjAwY4tZ1jUFMaTpMRbsKBAtUsKYlmx/1Qs7xsHWfj6
        vxzbZeF8vBco+5medXHnq5IJLbV2gZuyI2Acnm3Dl+T9x4f9eqwpu+999BZn4vYI2cMwz5
        ZWfp8OL+y3keD/NO2r54CDkk+Q1h4UzF1R813auQG3Reirt/eZtiiVD5RGOW3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649192179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csCYSZXs/k/y3JYV+c94UAameL8Wjh0jsXSIlb67K8Q=;
        b=XzVbtc0PhLoeBULUpsFatERhaBFi0mVkI83ccJvS6jdX6s4U2t3B1GwXQqy3yYn62wiGab
        nPv+KADNT84x3qCg==
From:   "tip-bot2 for Smita Koralahalli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Avoid unnecessary padding in struct mce_bank
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220225193342.215780-2-Smita.KoralahalliChannabasappa@amd.com>
References: <20220225193342.215780-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Message-ID: <164919217791.389.16926889046664512675.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     9f1b19b977ee3cbd3fe9135ff63dbf221eac1d6a
Gitweb:        https://git.kernel.org/tip/9f1b19b977ee3cbd3fe9135ff63dbf221eac1d6a
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Fri, 25 Feb 2022 13:33:40 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 05 Apr 2022 21:23:34 +02:00

x86/mce: Avoid unnecessary padding in struct mce_bank

Convert struct mce_bank member "init" from bool to a bitfield to get rid
of unnecessary padding.

$ pahole -C mce_bank arch/x86/kernel/cpu/mce/core.o

before:

  /* size: 16, cachelines: 1, members: 2 */
  /* padding: 7 */
  /* last cacheline: 16 bytes */

after:

  /* size: 16, cachelines: 1, members: 3 */
  /* last cacheline: 16 bytes */

No functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220225193342.215780-2-Smita.KoralahalliChannabasappa@amd.com
---
 arch/x86/kernel/cpu/mce/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 981496e..d775fcd 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -69,7 +69,9 @@ DEFINE_PER_CPU_READ_MOSTLY(unsigned int, mce_num_banks);
 
 struct mce_bank {
 	u64			ctl;			/* subevents to enable */
-	bool			init;			/* initialise bank? */
+
+	__u64 init			: 1,		/* initialise bank? */
+	      __reserved_1		: 63;
 };
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
 
