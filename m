Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2780F46D1CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhLHLRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhLHLRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:17:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD37EC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:13:45 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D46B1EC052C;
        Wed,  8 Dec 2021 12:13:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638962024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWwZiczUpG+F4aiOu14wZ+otJ/UsdVUjhcOr2x0XFI8=;
        b=GMKhSW7YYDYhZuNfFG3X5lDuAjJ9OmAe+w0AwPL6hwcBImOMFUkhKh1L/tO5zkzXbBEeWP
        iqH6BH1bs0t+TntSiDyh3kfBp+MkMTvnlbuOgEDgQPjho+I0B8QsVmS1l/Bu2iu7osFiZ1
        ey0Bn5NjfA+9sFl9RWMISxzua729ZhI=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 01/12] x86/mce: Do not use memset to clear the banks bitmaps
Date:   Wed,  8 Dec 2021 12:13:32 +0100
Message-Id: <20211208111343.8130-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208111343.8130-1-bp@alien8.de>
References: <20211208111343.8130-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The bitmap is a single unsigned long so no need for the function call.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 30de00fe0d7a..7c264ee18c95 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1336,8 +1336,8 @@ static noinstr void unexpected_machine_check(struct pt_regs *regs)
 noinstr void do_machine_check(struct pt_regs *regs)
 {
 	int worst = 0, order, no_way_out, kill_current_task, lmce;
-	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
-	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
+	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS) = { 0 };
+	DECLARE_BITMAP(toclear, MAX_NR_BANKS) = { 0 };
 	struct mca_config *cfg = &mca_cfg;
 	struct mce m, *final;
 	char *msg = NULL;
@@ -1381,7 +1381,6 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	final = this_cpu_ptr(&mces_seen);
 	*final = m;
 
-	memset(valid_banks, 0, sizeof(valid_banks));
 	no_way_out = mce_no_way_out(&m, &msg, valid_banks, regs);
 
 	barrier();
-- 
2.29.2

