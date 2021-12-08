Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F57246D1DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhLHLRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:17:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232251AbhLHLR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:17:26 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 757771EC0535;
        Wed,  8 Dec 2021 12:13:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638962034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40UMFJIIWXdHOUjSxB+Y2lR7T3b5fB/FHMQ2wRRUUOU=;
        b=piYKDs4Cgdr0+t6opVFENeBst/ORBsdY5H13vsO0cUVrnCHdDdPUYkdFZni8rPbZbRjYCL
        3BwNg93/8BZSYIRn2Evalxaf/w4j7Yu4EEO9tnJm+EIm5YqszmzVGlIo1NH1TcOLtjYi+o
        /PAur3uho+4GH4KzQQ3tP7CGWu2JHLQ=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 12/12] x86/mce: Mark mce_start() noinstr
Date:   Wed,  8 Dec 2021 12:13:43 +0100
Message-Id: <20211208111343.8130-13-bp@alien8.de>
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

  vmlinux.o: warning: objtool: do_machine_check()+0x4ae: call to __const_udelay() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3fe1d6614c22..aa47ff12100f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1007,13 +1007,13 @@ static atomic_t global_nwo;
  * in the entry order.
  * TBD double check parallel CPU hotunplug
  */
-static int mce_start(int *no_way_out)
+static noinstr int mce_start(int *no_way_out)
 {
-	int order;
 	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
+	int order, ret = -1;
 
 	if (!timeout)
-		return -1;
+		return ret;
 
 	atomic_add(*no_way_out, &global_nwo);
 	/*
@@ -1023,6 +1023,9 @@ static int mce_start(int *no_way_out)
 	order = atomic_inc_return(&mce_callin);
 	cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
 
+	/* Enable instrumentation around calls to external facilities */
+	instrumentation_begin();
+
 	/*
 	 * Wait for everyone.
 	 */
@@ -1030,7 +1033,7 @@ static int mce_start(int *no_way_out)
 		if (mce_timed_out(&timeout,
 				  "Timeout: Not all CPUs entered broadcast exception handler")) {
 			atomic_set(&global_nwo, 0);
-			return -1;
+			goto out;
 		}
 		ndelay(SPINUNIT);
 	}
@@ -1056,7 +1059,7 @@ static int mce_start(int *no_way_out)
 			if (mce_timed_out(&timeout,
 					  "Timeout: Subject CPUs unable to finish machine check processing")) {
 				atomic_set(&global_nwo, 0);
-				return -1;
+				goto out;
 			}
 			ndelay(SPINUNIT);
 		}
@@ -1067,7 +1070,12 @@ static int mce_start(int *no_way_out)
 	 */
 	*no_way_out = atomic_read(&global_nwo);
 
-	return order;
+	ret = order;
+
+out:
+	instrumentation_end();
+
+	return ret;
 }
 
 /*
-- 
2.29.2

