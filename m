Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3B04ABA8D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383892AbiBGLYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382194AbiBGLSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:18:38 -0500
X-Greylist: delayed 35936 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 03:18:17 PST
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0B8C0401E3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:18:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JskCR391hz4y3t;
        Mon,  7 Feb 2022 22:18:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1644232691;
        bh=X9pvbvZhC+D5v5AF6gvrofeetIO+1Qb5OeO8MNnQ/RU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aQhuxBf0BKfWLeN4uy1l4VkFHGpMBxba1jePK8Rj1b9VNndhuoDfg6wdxBrMm1uje
         5R3J9RImaYKnS9biR8tpKFiVnTBIOcLhdNAhHq1EPQpOMZipNxXI1279GHbDjhIYY9
         klWVwKLNQEdsIEMmY3ErbVImaSKyPQqI1C3DCEJyOcYPvfbs5oWUWYnXFj8364Bti9
         k5A+eFNCbf79vnsMr390NS5nHpmdKXvNG0wJE9kSyHoYDzBe0cQV0SIu60OOod8R49
         v+pwMSWoimEvOHWDN1vQBQQXItrvs7lDIzcqdCTw7KFBa5+bPrtXhzMIVHLa7as1h8
         aZhJXQmcG48Gw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v1 05/11] powerpc/machdep: Move sys_ctrler_t
 definition into pmac.h
In-Reply-To: <7dd5ead4bbca749e2da089ff6fe2b1878d6bf40e.1630667612.git.christophe.leroy@csgroup.eu>
References: <cover.1630667612.git.christophe.leroy@csgroup.eu>
 <7dd5ead4bbca749e2da089ff6fe2b1878d6bf40e.1630667612.git.christophe.leroy@csgroup.eu>
Date:   Mon, 07 Feb 2022 22:18:06 +1100
Message-ID: <874k5blyc1.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> sys_ctrler_t definitions are tied to pmac. Move it in pmac.h
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/machdep.h     | 15 ---------------
>  arch/powerpc/platforms/powermac/pmac.h | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 15 deletions(-)

This broke a few things in drivers/macintosh and sound/ppc, I fixed it
up with the delta below.

cheers


diff --git a/arch/powerpc/include/asm/pmac_feature.h b/arch/powerpc/include/asm/pmac_feature.h
index e08e829261b6..2495866f2e97 100644
--- a/arch/powerpc/include/asm/pmac_feature.h
+++ b/arch/powerpc/include/asm/pmac_feature.h
@@ -401,5 +401,17 @@ extern u32 __iomem *uninorth_base;
  */
 extern int pmac_get_uninorth_variant(void);
 
+/*
+ * Power macintoshes have either a CUDA, PMU or SMU controlling
+ * system reset, power, NVRAM, RTC.
+ */
+typedef enum sys_ctrler_kind {
+	SYS_CTRLER_UNKNOWN = 0,
+	SYS_CTRLER_CUDA = 1,
+	SYS_CTRLER_PMU = 2,
+	SYS_CTRLER_SMU = 3,
+} sys_ctrler_t;
+extern sys_ctrler_t sys_ctrler;
+
 #endif /* __ASM_POWERPC_PMAC_FEATURE_H */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
index b96d28dd26cf..ba8d4e97095b 100644
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -5,17 +5,7 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 
-/*
- * Power macintoshes have either a CUDA, PMU or SMU controlling
- * system reset, power, NVRAM, RTC.
- */
-typedef enum sys_ctrler_kind {
-	SYS_CTRLER_UNKNOWN = 0,
-	SYS_CTRLER_CUDA = 1,
-	SYS_CTRLER_PMU = 2,
-	SYS_CTRLER_SMU = 3,
-} sys_ctrler_t;
-extern sys_ctrler_t sys_ctrler;
+#include <asm/pmac_feature.h>
 
 /*
  * Declaration for the various functions exported by the
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index cd267392289c..3d0d0b9d471d 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -21,6 +21,7 @@
 #ifdef CONFIG_PPC
 #include <asm/prom.h>
 #include <asm/machdep.h>
+#include <asm/pmac_feature.h>
 #else
 #include <asm/macintosh.h>
 #include <asm/macints.h>
diff --git a/sound/ppc/pmac.h b/sound/ppc/pmac.h
index a758caf689d2..b6f454130463 100644
--- a/sound/ppc/pmac.h
+++ b/sound/ppc/pmac.h
@@ -26,6 +26,7 @@
 #include <asm/dbdma.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
+#include <asm/pmac_feature.h>
 
 /* maximum number of fragments */
 #define PMAC_MAX_FRAGS		32

