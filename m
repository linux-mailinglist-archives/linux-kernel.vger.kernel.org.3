Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01D159AC19
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbiHTHSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344074AbiHTHR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:17:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F39C6FFC;
        Sat, 20 Aug 2022 00:17:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so9417516pjj.4;
        Sat, 20 Aug 2022 00:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PEwtldO5Q6Fe+jN6MUYbpoaDfAqWs36K7tLMiCkYHvU=;
        b=JyZk7DOHK9hHwX1eKLIacuxuejIsO5iTGXhrd397iLNDTTtwkuCGABjD0H3dfusyuz
         TQocoo6dr6xm8PCYZaA3k0drDe2/6rhw/f1B5m/ucGSEOSQ3UJXDJIk9nuo2cS4rFStV
         px3yVr+esWbmRj1yZgKB6qMFjuHZ2tukwQR6Q6tF18joNXJYCzF9XkVh66VqbR8qUthz
         GaA3/iJlIQKeXwZAz6qzMbtwv1pC64LTBIXIB0hDqKUWuXPvI0xUAZQdG060TTVFoRMn
         myeYkBVDrwWjIeWwyxBSEU7dcnXoKWCZc06rD7PxhIEDRabR0zPpunh2QUHCoMiRI3Bw
         Rvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PEwtldO5Q6Fe+jN6MUYbpoaDfAqWs36K7tLMiCkYHvU=;
        b=3LlrYpuHi9dzBFQOs7B9flOhpEutja1zFVEu6zcPDYk2U0SnpBHIut7kcFJceoti+A
         Fu1u+2dld20LZ+k1VfMqwaDp9DRXtRxmK/8MkEtVRb/J3IiIhTyPVknu4ZgiGSy97rJx
         qjSUjX1oLjfGDbD861E5iV9rDflOgPBDIs5mVVLkClxnKPE7XkTH50WOJpj4yaWaKMx2
         vlTlDL8vPcv0A7dXRrj16PeTtNwxbNgFWIyuhgQc1jrKjA2R5avcwXW8+vuxESQ4VRpE
         h92HamqBH0wctOvqQUZKGU0FuFNBbDCxuTtrxHrN8hH8fqve/xp47AhbBUqJzyd6OaJW
         P0Ig==
X-Gm-Message-State: ACgBeo32xzN7fKAdEKeke8sxSaNEsrLGUAZ1fsdNBXVqibh6NL5U7uWI
        Nj6LHEhMYNebyvXSJtYc2bCffM/ROfdxAnC4XSI=
X-Google-Smtp-Source: AA6agR6U1kl/AKlq5BqNAR5lkM1hvHTrxu3S8RWyP0wqhr9srdlNTk42u7EJPs4Vpblu6wgiozU4xw==
X-Received: by 2002:a17:90b:1d02:b0:1f5:8526:303 with SMTP id on2-20020a17090b1d0200b001f585260303mr18210394pjb.79.1660979872152;
        Sat, 20 Aug 2022 00:17:52 -0700 (PDT)
Received: from mithil.localdomain ([103.19.226.223])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a694f00b001faf273e4afsm1459019pjm.35.2022.08.20.00.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 00:17:51 -0700 (PDT)
From:   Mithil Bavishi <bavishimithil@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, bavishimithil@gmail.com,
        contact@paulk.fr
Subject: [PATCH 06/10] ARM: OMAP2+: Only select TWL4030_POWER for OMAP3
Date:   Sat, 20 Aug 2022 12:46:56 +0530
Message-Id: <20220820071659.1215-7-bavishimithil@gmail.com>
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

From: Paul Kocialkowski <contact@paulk.fr>

The TWL4030 is generally used with the OMAP3, not with OMAP4.
The TWL6030 is generally used with the OMAP4 instead.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/mach-omap2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3b53dda9e..e4fea50c3 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -143,7 +143,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select REGULATOR
 	select REGULATOR_FIXED_VOLTAGE
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
-	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
+	select TWL4030_POWER if ARCH_OMAP3
 	select VFP
 	help
 	  Compile a kernel suitable for booting most boards
-- 
2.25.1

