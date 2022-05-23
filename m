Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AD6530A52
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiEWHfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiEWHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:35:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396692A1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:35:17 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 239383FD85
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653286620;
        bh=YZt0gEcVBsDQZxJXupASTRYjSo4qyOuFuN84SJ8MkVo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=b7QfKCNxCZrKklIEjNlcDfU9RJIUF1EHCFaYilhGN8pEU6WUMRS/dHSEFQY+7mCSF
         GNG7WwZEGCsDqZxHUEMxnk4z1bEoie99icDOJkdG2Y5yIT+QZhvwduInl3gZQ1wWX+
         jbFTArIDiF10Ajnucd+u/I47fTR3jqTChYMQ8tQe1Kh9NIG/V7Uj2zz0Kkha9QaEzR
         EPyu8VukY1dvGty/Q0oa1w8Syo7z3hUBDGQYUblq4Yt5D93/edV8CkuuymHd46VZvN
         g5G1Z2q4+ySmep09BiEAWsyGf/9eOr6r0/Bn9JPBHdGX46VeceKl2txN+PFP1I3EJR
         1GSJSKXGIzPBA==
Received: by mail-ej1-f69.google.com with SMTP id i7-20020a170906850700b006fec53a78c3so693899ejx.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YZt0gEcVBsDQZxJXupASTRYjSo4qyOuFuN84SJ8MkVo=;
        b=MdLvZHPID32bsScKv3hTXcTYS7L4BoPjNDsN0lPWlPuYpVLGlzrd/GyaQuXqPfry+Q
         4lCWmEInhIsMn/tj7+XfJLTTzuPlHB8VloGvQtdIrEVpsqss5+f9ugRdCxfQ6UNJEkr/
         tIwxN9yUYt0yoGst+MqJIMmcpbks+zFIerkyZzNmsupD0StkFkZXBXeksW4R43S8sFUg
         75tBTjUiaqmDv3/rCMWFNIO9dJyC5UMlBqUZa/OoJ7aPnlnvpOictMJ2lnEwqMhG3GCf
         4+5abY4Gb3WAJzd6iYXZVPWhej4ZFNAr/nakwXbYw0dN4BvJFaT4OX+3OBlKz2ZNpvLa
         Gpgg==
X-Gm-Message-State: AOAM533qWoeDlJFB1BImNkCZXu5VYjCn8zSV+oQU9veOUiS1vo14OEGs
        Mj6P3WeZBT+TV0t35crGhewSdJ668/u7s/Iw71BFETmk5FqzKwwINAr7jH9pi4l7dBW8Jtp8nXU
        W6dDnjeJqVbwRM2aRf4XlcaUWhaJadmIKFuKJCFsh0w==
X-Received: by 2002:a17:907:6e15:b0:6fe:f8e8:69de with SMTP id sd21-20020a1709076e1500b006fef8e869demr152751ejc.512.1653286619882;
        Sun, 22 May 2022 23:16:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuBRNxF5Sb309hnzHZzQVoZYxgbW/gKFFlvPa+a0P7VHui/OmYp1mAtjTqMJvslvLV4OtKcQ==
X-Received: by 2002:a17:907:6e15:b0:6fe:f8e8:69de with SMTP id sd21-20020a1709076e1500b006fef8e869demr152743ejc.512.1653286619702;
        Sun, 22 May 2022 23:16:59 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b006fe8c831632sm5359135ejc.73.2022.05.22.23.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:16:59 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     hsweeten@visionengravers.com, alexander.sverdlin@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] ARM: imx: Kconfig: Fix indentation
Date:   Mon, 23 May 2022 08:16:57 +0200
Message-Id: <20220523061657.9374-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While at it, replace separator tabs with whitespaces.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/mach-imx/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c5a59158722b..e27232aa3d34 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -96,7 +96,7 @@ config SOC_IMX5
 	select HAVE_IMX_SRC
 	select MXC_TZIC
 
-config	SOC_IMX50
+config SOC_IMX50
 	bool "i.MX50 support"
 	select PINCTRL_IMX50
 	select SOC_IMX5
@@ -111,7 +111,7 @@ config SOC_IMX51
 	help
 	  This enables support for Freescale i.MX51 processor
 
-config	SOC_IMX53
+config SOC_IMX53
 	bool "i.MX53 support"
 	select PINCTRL_IMX53
 	select SOC_IMX5
@@ -216,7 +216,7 @@ config SOC_IMX7D
 	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
 	select ARM_ERRATA_814220 if ARCH_MULTI_V7
 	help
-		This enables support for Freescale i.MX7 Dual processor.
+	  This enables support for Freescale i.MX7 Dual processor.
 
 config SOC_IMX7ULP
 	bool "i.MX7ULP support"
-- 
2.32.0

