Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923B857691E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiGOVmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiGOVl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:41:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A90C87215;
        Fri, 15 Jul 2022 14:41:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so12681083pjl.5;
        Fri, 15 Jul 2022 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIdtrkjIXYRsAlXMvpcKhoRTSlAlQo7ARrvd/qC7dvI=;
        b=Fyih3flx8Q80JKoVHVT4iFhGN1fQegbt97eXYwrntP7nkRjBrgkWrrp/aJJ13MmDSC
         q9gtE+8ie8tuIVsBPObPdfxjJgNeYNObrjOOCvAh2OArm9jcrwkjI4MI59vugJHscy9f
         OcTWt3e83pHs+afPpjz9Ry0CNLliRW1c3RFI08P8ROhK0NBi4h/ks+Cd7LISx2BL0mfl
         //i7Df9iGWfKalrvxs+ehJo5jDTb/RhiWwIcJDrKsk642P97dnC0g7INWh3nfjao6N2h
         5UuesPQOdl16ObYjnom61G/I5PTG2lQDQ+24sBqS2hX8nSf9b6YrUmfzvur6SwVy5DEy
         VQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIdtrkjIXYRsAlXMvpcKhoRTSlAlQo7ARrvd/qC7dvI=;
        b=rRlFv0NyBQBPM2aWLtpKSIyQf2KdNXAqZtqQ3NEAlzmYtlRZo3Bk9QbhR+wLLaCbNK
         PwXvek0yRSBh3xpDtiKroZ4Ki/xMiNGdQvxGQjFtSVGPHSFSGYGDcyXeT5wFc4wcPI9x
         RC2gPEblxZ2QwIS+Sh09dyfqC94/4ll9WIsnn+rnnRXHPQmiZyevWQD+EpIu53hhPbGu
         N0DAwC2BCDNBUc3rNQBB8nhNqVXLSu+1CJa2AY94vGQ0YFpd1LcHVR0vSwd+nVGpa/Tj
         cINUPC3onTdLB9RsGeuU7spQXoN7+RCMh6ywtXPaqw7T+UwW3wXvrVZgKxOsNCUYEVOh
         llAg==
X-Gm-Message-State: AJIora/f0CAll54fOWE8dNTXbltAnv4kFCEF+XusoaDauS3ReyNPQRT5
        xhEauefxpXOF9Q+360st0A0LMYVF410=
X-Google-Smtp-Source: AGRyM1sqmsek0U3VpD30xmyoilgquiRsCHkiQ6lRIZhSY+cc/PWz6KafVFwxbLJ9HMMVM/gw7rPsQQ==
X-Received: by 2002:a17:902:c411:b0:16c:28e3:c33d with SMTP id k17-20020a170902c41100b0016c28e3c33dmr15829057plk.126.1657921318418;
        Fri, 15 Jul 2022 14:41:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9-20020aa797a9000000b0052add461d2esm4289975pfq.103.2022.07.15.14.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 14:41:58 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] MIPS: BMIPS: Utilize cfe_die() for invalid DTB
Date:   Fri, 15 Jul 2022 14:37:47 -0700
Message-Id: <20220715213747.111321-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715213747.111321-1-f.fainelli@gmail.com>
References: <20220715213747.111321-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we were not specified a correct DTB, we will not be able to print
anything useful with panic() which requires a working console of some
sort. Utilize cfe_die() to callback into the CFE default UART and print
some useful diagnostics.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/Kconfig       |  1 +
 arch/mips/bmips/setup.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8db38817320b..0c366088b707 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -294,6 +294,7 @@ config BMIPS_GENERIC
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
 	select PCI_DRIVERS_GENERIC
+	select FW_CFE
 	help
 	  Build a generic DT-based kernel image that boots on select
 	  BCM33xx cable modem chips, BCM63xx DSL chips, and BCM7xxx set-top
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 31bcfa4e08b9..e95b3f78e7cd 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -28,6 +28,7 @@
 #include <asm/smp-ops.h>
 #include <asm/time.h>
 #include <asm/traps.h>
+#include <asm/fw/cfe/cfe_api.h>
 
 #define RELO_NORMAL_VEC		BIT(18)
 
@@ -123,8 +124,19 @@ static const struct bmips_quirk bmips_quirk_list[] = {
 	{ },
 };
 
+static void __init bmips_init_cfe(void)
+{
+	cfe_seal = fw_arg3;
+
+	if (cfe_seal != CFE_EPTSEAL)
+		return;
+
+	cfe_init(fw_arg0, fw_arg2);
+}
+
 void __init prom_init(void)
 {
+	bmips_init_cfe();
 	bmips_cpu_setup();
 	register_bmips_smp_ops();
 }
@@ -165,7 +177,7 @@ void __init plat_mem_setup(void)
 		dtb = get_fdt();
 
 	if (!dtb)
-		panic("no dtb found");
+		cfe_die("no dtb found");
 
 	__dt_setup_arch(dtb);
 
-- 
2.25.1

