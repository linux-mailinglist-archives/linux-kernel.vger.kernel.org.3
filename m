Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3A46D1DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhLHLRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhLHLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:17:26 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230BC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:13:54 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 889DA1EC0537;
        Wed,  8 Dec 2021 12:13:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638962033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OggTDlvVSNjiwy8hyQBq/i5y3pnQCZ+rdKC8rqbtQ2A=;
        b=MdrD+x2duoHzD6rLLNw+ixNTxh09a4DrxAjwI18ysMWFaTp5lZTewJiirYxdJDHAem9t+2
        f9TWjNwyQieXqURqVvXqZj9KTTXCTfejB5D6nTikMXrUS7b+0dwJAz8IbB4cH8o77NlXVl
        EdtnYg28cS/PAxbE3yVnyZRGXd8oeYQ=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 11/12] x86/mce: Mark mce_timed_out() noinstr
Date:   Wed,  8 Dec 2021 12:13:42 +0100
Message-Id: <20211208111343.8130-12-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208111343.8130-1-bp@alien8.de>
References: <20211208111343.8130-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Fixes

  vmlinux.o: warning: objtool: do_machine_check()+0x482: call to mce_timed_out() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 782724b1204f..3fe1d6614c22 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -883,8 +883,13 @@ static cpumask_t mce_missing_cpus = CPU_MASK_ALL;
 /*
  * Check if a timeout waiting for other CPUs happened.
  */
-static int mce_timed_out(u64 *t, const char *msg)
+static noinstr int mce_timed_out(u64 *t, const char *msg)
 {
+	int ret = 0;
+
+	/* Enable instrumentation around calls to external facilities */
+	instrumentation_begin();
+
 	/*
 	 * The others already did panic for some reason.
 	 * Bail out like in a timeout.
@@ -903,12 +908,17 @@ static int mce_timed_out(u64 *t, const char *msg)
 					 cpumask_pr_args(&mce_missing_cpus));
 			mce_panic(msg, NULL, NULL);
 		}
-		return 1;
+		ret = 1;
+		goto out;
 	}
 	*t -= SPINUNIT;
+
 out:
 	touch_nmi_watchdog();
-	return 0;
+
+	instrumentation_end();
+
+	return ret;
 }
 
 /*
-- 
2.29.2

