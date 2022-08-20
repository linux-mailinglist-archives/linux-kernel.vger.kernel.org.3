Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163B459ABFB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbiHTHRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243618AbiHTHRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:17:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3374C6961;
        Sat, 20 Aug 2022 00:17:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pm17so6475772pjb.3;
        Sat, 20 Aug 2022 00:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3Gj5f3w9OQFfik8UamsqozmpIyn6I4xFDFsJ76lHXeE=;
        b=beY9hzQ6YUEUWP5DZ42FeQ+ndF6ZqgyenaIAFmYDIjoHYOwKcuzsahTH6fxHrzCaWC
         OJ8ACfP7RIoTyjgStccgwCw5jpm1KWlASfPTk4rzRVon3c40j5KXn0S9at3dgNZJEyjq
         yHD56YCaYAmeVzmmKd7r4V90PFWBAHWakrqT1mvfygUsk27GSCcFxGh7dD6m7OHmPghS
         wRPrUo+ALaOq0sa13MDTXJk1BEPCZ97Ay/5K2AJJdHyshCnaq1hVCZTMXLumv2ci5ZN1
         jQI/+J44tPm4gXvu2l1lvMbdBxY4tEvhhws/Lya1xQxvLDeSvYaTaIptr8d/V7JsPDt+
         ZyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3Gj5f3w9OQFfik8UamsqozmpIyn6I4xFDFsJ76lHXeE=;
        b=T07kC3bepUS6WQHp/JymEG21pfrLqdxQrBSylHGgN2BCWH2QfsPIpLWtAC/3osLekU
         0EmPyedRNLxKBn5PzamDmUU2WTUaqE/iYNg21lmE7ibuHuApIVwwsiB0bPohpnDEOO9p
         SyntB0MWdMOX2IiP30xzm2aFFjsw/04yODBCuFOhtQJ6rI3bYf/Bm52B2QSVdrmKXFDJ
         TEn4ORuwOuqsso4pEOWxK3ijk39SdEw7QPbWWfvrT33tjmvhw3nE119R4U0EK2tFHqkr
         JpYi8J3shZFe/bhmOag3G+i+oPwYe92cxtoS9c2G8T+kIMX7wIAuJoJUsM3Zhhmt+tk1
         FUyg==
X-Gm-Message-State: ACgBeo2onTbl+51o1xDLFpgkfrolU+DqsIdj1Dr3Z9ArgCTZNQc77x53
        yB8s/0YnX2JBwXDi3rRKcAimVmKa+XNFFIn7X1Y=
X-Google-Smtp-Source: AA6agR7itwESn5ApNtVpb+4Uh+XQ5oNjUaJSAjTA3UOVyhKqqFoLh3fu31cL6i/zoqelQ4QkPEm0Iw==
X-Received: by 2002:a17:90a:e7cb:b0:1f5:38:cb53 with SMTP id kb11-20020a17090ae7cb00b001f50038cb53mr12578961pjb.110.1660979838970;
        Sat, 20 Aug 2022 00:17:18 -0700 (PDT)
Received: from mithil.localdomain ([103.19.226.223])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a694f00b001faf273e4afsm1459019pjm.35.2022.08.20.00.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 00:17:18 -0700 (PDT)
From:   Mithil Bavishi <bavishimithil@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, bavishimithil@gmail.com,
        contact@paulk.fr
Subject: [PATCH 01/10] power: reset: Move TWL4030 power driver from mfd
Date:   Sat, 20 Aug 2022 12:46:51 +0530
Message-Id: <20220820071659.1215-2-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820071659.1215-1-bavishimithil@gmail.com>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power/reset folder seems like a more appropriate place for
twl4030-power.c

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 drivers/mfd/Kconfig                          | 13 -------------
 drivers/mfd/Makefile                         |  1 -
 drivers/power/reset/Kconfig                  | 12 ++++++++++++
 drivers/power/reset/Makefile                 |  1 +
 drivers/{mfd => power/reset}/twl4030-power.c |  0
 5 files changed, 13 insertions(+), 14 deletions(-)
 rename drivers/{mfd => power/reset}/twl4030-power.c (100%)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index abb58ab1a..6a409bb2a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1643,19 +1643,6 @@ config TWL4030_CORE
 	  high speed USB OTG transceiver, an audio codec (on most
 	  versions) and many other features.
 
-config TWL4030_POWER
-	bool "TI TWL4030 power resources"
-	depends on TWL4030_CORE && ARM
-	help
-	  Say yes here if you want to use the power resources on the
-	  TWL4030 family chips.  Most of these resources are regulators,
-	  which have a separate driver; some are control signals, such
-	  as clock request handshaking.
-
-	  This driver uses board-specific data to initialize the resources
-	  and load scripts controlling which resources are switched off/on
-	  or reset when a sleep, wakeup or warm reset event occurs.
-
 config MFD_TWL4030_AUDIO
 	bool "TI TWL4030 Audio"
 	depends on TWL4030_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf65..bd7bf95e6 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -108,7 +108,6 @@ obj-$(CONFIG_MFD_TPS65912_SPI)  += tps65912-spi.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 
 obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
-obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
 obj-$(CONFIG_MFD_TWL4030_AUDIO)	+= twl4030-audio.o
 obj-$(CONFIG_TWL6040_CORE)	+= twl6040.o
 
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a8c46ba58..39117b697 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -303,4 +303,16 @@ config POWER_MLXBF
 	help
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
+config TWL4030_POWER
+        bool "TI TWL4030 power resources"
+        depends on TWL4030_CORE && ARM
+        help
+          Say yes here if you want to use the power resources on the
+          TWL4030 family chips.  Most of these resources are regulators,
+          which have a separate driver; some are control signals, such
+          as clock request handshaking.
+
+          This driver uses board-specific data to initialize the resources
+          and load scripts controlling which resources are switched off/on
+          or reset when a sleep, wakeup or warm reset event occurs.
 endif
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0a39424fc..e9db25b09 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
+obj-$(CONFIG_TWL4030_POWER) += twl4030-power.o
diff --git a/drivers/mfd/twl4030-power.c b/drivers/power/reset/twl4030-power.c
similarity index 100%
rename from drivers/mfd/twl4030-power.c
rename to drivers/power/reset/twl4030-power.c
-- 
2.25.1

