Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC575767BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiGOTr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiGOTrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:47:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9AB7C1B9;
        Fri, 15 Jul 2022 12:47:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so7068699pjl.4;
        Fri, 15 Jul 2022 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIdtrkjIXYRsAlXMvpcKhoRTSlAlQo7ARrvd/qC7dvI=;
        b=BQlSWtEUHO57x3mU+CZJjyekwCh7Ff+nJlF84amGwwj4xLenVQy5h7VJ1KI3jkF1aw
         ++HlFz7Gx7fZMdQ1iTxaQnG1TlTt+HGwqvQhGjd1XOUIwzFYB9788xztekMSAhd6Apw1
         4ZcTIT+p1ogigwv4acXW14+I+wVnF0J4q3Fcsshu+Km2z0veWS4uA4CMuVW/kmdmZljz
         Evrdz+RjTGvXPK99jEUXLYIGC4Ng2Ic7lZplbBCRX7EyuuPpxmCk36rqcpTm/n1BjGWr
         W0X6cMXwa1BnxmI8H1zd1RHO6w+kd2aqqkXGGtyrCrWdhvvh8X03n54Pu6lMZOh0prst
         XGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIdtrkjIXYRsAlXMvpcKhoRTSlAlQo7ARrvd/qC7dvI=;
        b=7mR2jZd79YxmKMmcuVrpF2y1xYouYe/fh91tvp3mRV8LyyVnj3nFKbkk7z4mCUY3EZ
         kq/2KpkXoYmPSDouqDOlLj70qFoGRkiTFALWVMS2vpnX2KlPmw8Gc6IJOQUmrArZQcVQ
         HSpuM5eYV6lRDVaAjnRKjzIVPOSIwanBL1rJR72RNypODr5zO97L3sNB/2b6xl+677iz
         +XacEVvn+9Y+GT49/dryT6BCnZaV4o6LTJbwWF5yLdXZ/huv3SP4aiCFO7D9DvaxFY5N
         3ClNag/C33PMfZiv5djDhbDAdQW9a7Q2zMl1mcU201n8NUkbD9CUW8mzkpGYaILUtw1z
         DnmA==
X-Gm-Message-State: AJIora8A4HZWsYkQx6+sH6SF++UZPuiLfIlbdbJmulSbUoif7FAXuVZQ
        gUO1zwRfKKHG3sQFpK9NO+fSqV7WkH4=
X-Google-Smtp-Source: AGRyM1tZYMgGALFYIDPJt2hUTKpcgRkpZIXkLwOhfaPqERH9dQdNBC10gIF1WRGJS/MIfWOzaRYGoA==
X-Received: by 2002:a17:903:3093:b0:16b:deea:4d36 with SMTP id u19-20020a170903309300b0016bdeea4d36mr15125373plc.126.1657914462778;
        Fri, 15 Jul 2022 12:47:42 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d82-20020a621d55000000b0052ab6590290sm4247227pfd.88.2022.07.15.12.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:47:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] MIPS: BMIPS: Utilize cfe_die() for invalid DTB
Date:   Fri, 15 Jul 2022 12:47:37 -0700
Message-Id: <20220715194737.4174717-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715194737.4174717-1-f.fainelli@gmail.com>
References: <20220715194737.4174717-1-f.fainelli@gmail.com>
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

