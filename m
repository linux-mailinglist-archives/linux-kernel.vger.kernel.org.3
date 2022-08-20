Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843CD59B012
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiHTT7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiHTT6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:58:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C73D2A24D
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p9so5961532pfq.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=Sr3mfLjIXUVPt2Cgs2+sTdfLuzfKP+HqrSqTYzV33qM=;
        b=j3vTDZy4p2Le5Jv0g004C6FlSoKi1tbfV1xl1Chcm4rgJmgijjKKbt14lR0SYOgxh/
         qSPHV6lqPVzbAm193b3dSHb8ziy34S7eilhgMrD6XwfUzm4KjF6cGaG1vPr8hH/1FGcn
         GLeAeeydrXgAdYZV+YW1cN/gEkFTE0eYugQZScgx6tnKPrw4e553sr2Gz2P/qQYgWBfX
         xU5mENf9vP/K7HumNytFxQS2VsjDGIpLWu+CsvxYJPyTFff4RyyDM02Fs4a3bFwXjyPR
         JwcEwjhIm4YAdpOQzqWTzKA7JFHreBz96+o4A559dCwvbWGb21vk4dNdMnfW8v9xvPED
         5g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=Sr3mfLjIXUVPt2Cgs2+sTdfLuzfKP+HqrSqTYzV33qM=;
        b=T710SJqnRYvALZ5CRjcOdXy2CGVRWej6r45uPBtj1bPlZMugq8Y63YcBiVqDv3V27k
         Ryte5eDCdQOYuvnjLeNQQWsZAUl3Taa7SMgwCWMUlLvBD99DpSsrFzMq3e87DovFW3as
         LM1Dz74SLYG8a43sX8gN4sh9giuWMuCek4vcG4M7vFqJrMdk6lTZSyPC81NfNM2Eo7ep
         25epM303Iwh10NhdN+RzrvrbQBQeZnQw78w1VviLdM/ejgLmI0sMSKsGBoDHWuA2gjUO
         TOdwf1hQu3oD2q2fJMST3zNrAeihX3dqQPEss6UO6DWhhwi/k5X55icg3GAz093YyFyO
         XHEA==
X-Gm-Message-State: ACgBeo2xC58xr2MaD4NYN8fDvVmIQI9plm/NXY9fslrbOrD98eh5kzjy
        V6vuDb7akUT1TP/qQXOkmDk2yA==
X-Google-Smtp-Source: AA6agR47URWPJSwayd94xotbsO1f46lHE9aar40iSqylb83eDldTVhFKrWac2ORxP6lV9pykall+2A==
X-Received: by 2002:a63:3d1:0:b0:41d:f1e0:c15e with SMTP id 200-20020a6303d1000000b0041df1e0c15emr11326001pgd.156.1661025514879;
        Sat, 20 Aug 2022 12:58:34 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:34 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 08/17] MAINTAINERS: Add entry for AMD PENSANDO
Date:   Sat, 20 Aug 2022 12:57:41 -0700
Message-Id: <20220820195750.70861-9-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add entry for AMD PENSANDO maintainer and files

Signed-off-by: Brad Larson <blarson@amd.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f512b430c7cb..b46379a15a86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1802,6 +1802,15 @@ N:	allwinner
 N:	sun[x456789]i
 N:	sun50i
 
+ARM/AMD PENSANDO ARM64 ARCHITECTURE
+M:	Brad Larson <blarson@amd.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/amd,pensando*
+F:	arch/arm64/boot/dts/amd/elba*
+F:	drivers/mfd/pensando*
+F:	drivers/reset/reset-elbasr.c
+
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <narmstrong@baylibre.com>
 M:	Jerome Brunet <jbrunet@baylibre.com>
-- 
2.17.1

