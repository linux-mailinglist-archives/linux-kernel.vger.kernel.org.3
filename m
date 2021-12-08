Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19BD46D1CD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhLHLRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:17:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232240AbhLHLRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:17:19 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 08DF71EC0554;
        Wed,  8 Dec 2021 12:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638962027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EqFXx9zjNHAjfQU7TyJeMPTAflDmvwlN1+7gPj0AWQ=;
        b=WmuiAMXwatntDNwM+7lEVp0bUdTZlC8LSo9Evr5BFBWx5YYqJpV+EatYZGDtQQdilNOnZ6
        /FxBj35WKCSHEr3sW7oyC/q4NBdvYKGYZG+YcoJCfbmmRM/XVM7aBJpNEtzzNbSURI8ox5
        5+ozI+ktxoD0zBCP7VHF69MNtkQ6G2w=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 04/12] x86/mce: Remove noinstr annotation from mce_setup()
Date:   Wed,  8 Dec 2021 12:13:35 +0100
Message-Id: <20211208111343.8130-5-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208111343.8130-1-bp@alien8.de>
References: <20211208111343.8130-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Instead, sandwitch around the call which is done in noinstr context and
mark the caller - mce_gather_info() - as noinstr.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 87a277fc80b4..f61f14faa532 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -127,7 +127,7 @@ static struct irq_work mce_irq_work;
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
 /* Do initial initialization of a struct mce */
-noinstr void mce_setup(struct mce *m)
+void mce_setup(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
 	m->cpu = m->extcpu = smp_processor_id();
@@ -430,9 +430,15 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
  * check into our "mce" struct so that we can use it later to assess
  * the severity of the problem as we read per-bank specific details.
  */
-static inline void mce_gather_info(struct mce *m, struct pt_regs *regs)
+static noinstr void mce_gather_info(struct mce *m, struct pt_regs *regs)
 {
+	/*
+	 * Enable instrumentation around mce_setup() which calls external
+	 * facilities.
+	 */
+	instrumentation_begin();
 	mce_setup(m);
+	instrumentation_end();
 
 	m->mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
 	if (regs) {
-- 
2.29.2

