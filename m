Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89152515F4B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383135AbiD3Ql1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243352AbiD3Ql0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:41:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2727939D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:38:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a11so9304598pff.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cssUa1PptnyyXporPlZQKRCVmt+ClJJZuzi2xpbVVcI=;
        b=J+Nbr3JRIVsU/+U6MPAtC49b20a/h6yK4g3Dpm6zrofx/5SsBlQFlY9Gxc/7IoniK/
         I2aD7lm0ONzBpztp26rBtggbHS5/Jbbsnt0QbkZa0wZCkOP+S8fZ747I1azDDyiVyY3n
         9xbsmLWiQO9pLWoh9putbKm51RfgA8SevSBHbZtyg2Zft9LctTPGDCQ308bV0hOwBig+
         yLlDTsANqrbz6rvzealINFxlO6GjpVxwHIlqxeAx6/AZW6Li22WGKGeV0FKkCKyEzYFb
         ZbEhvzi+C0dd1DHoHA229ZCttMeY/wwzyQol+L3XQ4nu/koAEtHpRQXKLyl2WXFNniu6
         AhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cssUa1PptnyyXporPlZQKRCVmt+ClJJZuzi2xpbVVcI=;
        b=pjRc48bX+7AUzwTPlp+p5emAuDUiCSlD0FCs/CgwAMXRIFYHs4CxcaoJzizN7921+L
         DcbtQZhYmwDXaJMW2U66mGFLpY6CyWpUHbZQevgap5muYGCZ9FBm2qaWXsh6vCmiEeWA
         5PbNO1NA6kd2spIMOyKUumAHe3x2wUAyTrAoYhMMwgqwPSeTYWWGChR+F7V0z1roa+L2
         AIOpGgVKQOmhUK6xg0alnjC2Y44AhZ89bqw1HKKqN1wrfPqD8UfWSSABuhEgRrJ2TWFZ
         H1y+0uXCZZ3JXG2mQZK0tpINVwbjxrH0USeitWoq6d7Dwql3xOiEOcktOgsObKmoUMty
         87BA==
X-Gm-Message-State: AOAM5312Oat//Gdq7hP3xN/54SxGli+2/WtWch+mk0MG4SOQuDGIu6qG
        DZHA2omk6yGiSnn2tbayS+c=
X-Google-Smtp-Source: ABdhPJy/1gYg0IFB0niA3JnP20KZZyd0X5GyA2UCrV+0iC8AkydGJJrvAKPaMA02jDPFxdAacRjZTw==
X-Received: by 2002:a05:6a00:168a:b0:4f7:e161:83cd with SMTP id k10-20020a056a00168a00b004f7e16183cdmr4406653pfc.56.1651336682606;
        Sat, 30 Apr 2022 09:38:02 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:c0f1:53a1:ea79:5d2f])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090341c800b0015e8d4eb27asm1715352ple.196.2022.04.30.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 09:38:02 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        John Crispin <blogic@openwrt.org>,
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] arm: mediatek: select arch timer for mt7623
Date:   Sun,  1 May 2022 00:37:41 +0800
Message-Id: <20220430163742.537420-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

armv7 arch timer is required on this platform for a functional system
clock. Select HAVE_ARM_ARCH_TIMER for MT7623.

Fixes: 31ac0d69a1d4 ("ARM: dts: mediatek: add MT7623 basic support")
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
---
Change since v1:
 fix typo in commit message

 arch/arm/mach-mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 35a3430c7942..8a8d9142260a 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -26,6 +26,7 @@ config MACH_MT6592
 config MACH_MT7623
 	bool "MediaTek MT7623 SoCs support"
 	default ARCH_MEDIATEK
+	select HAVE_ARM_ARCH_TIMER
 
 config MACH_MT7629
 	bool "MediaTek MT7629 SoCs support"
-- 
2.35.1

