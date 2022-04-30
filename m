Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C10515F39
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380585AbiD3Qbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiD3Qbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:31:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D156A014
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:28:10 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v10so8693519pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtiesT3rNW8f1LKH0pEuQ9wbC6Gp2B9BkJ3EwQ8qLEA=;
        b=JwcjZEkIKuiM5zu6bMXRCkxaq3XQ73bGtDt2AJY08SOb1CdEGStySA3S55lcSvZD0i
         47d8ezB5hD51KVBDt5ivhnQ4D6CfKCNeCQmyudC005vEOTqVjMnnbDveTsL59TzLWD9d
         2Bgbf/AHKgNc+5tf6iJIAbAKNBu37MEF424+Dwd4dsGZTFzaGC2kmlVk+CGYmncYpDme
         D0dIAZZkV/oWL9lsbtnel8R0ve6g3iijH/vkh1A7swPvA6YD6AzEnMqkAdLsdpDKrGW2
         7ZmLy5MmjIklw3ovxWTMQz9/nrZrvoDfmEkXmYN4LasgAuTuHbptdYfeKvF7mtpHSPIi
         /LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtiesT3rNW8f1LKH0pEuQ9wbC6Gp2B9BkJ3EwQ8qLEA=;
        b=AwlhXmKVIY5au8vEaIGG+xV4s88MHmd/ZAjiNIapFQfDwE+zcGDMtHl7M5QFOO0leg
         u4FmWCmTVFszolY08f7r5dwn+xzAbGJRORlJ6Xs9bym2rovtVJWplkdKUPopklYboAX5
         GWzL4qaKq/VWYgpaT2dWNUI+Ts5C49J+hb9s6+23AzXYlBA2uOxr0FkYd1bMGowbnoXR
         /cFkTYsri7Exd2JNIi7trCKwbPeOEKyAQU6s1o9JTYZVm5+g2fxNP/8OgfVEgKWqQOLr
         W+pkfjsMVNOxzavWxYLjbI4BBvMPyargVFgwHJplH6uLimknYCJkluotL8kwtBN6XegC
         xUMg==
X-Gm-Message-State: AOAM533clL7lVXF1ij3QCDmV3pIaiKdHbAlXLx8aQXAqs+vg4WpZ5knQ
        gf9qj+Q2HZfHjywqM/AmeDs=
X-Google-Smtp-Source: ABdhPJzuvodcVAmVH/HIe/UOubBc7yHfppAzyer41uKgAnnqbwJfiW8j3wwroPyQpAW8cTx/fPgCvQ==
X-Received: by 2002:a63:515:0:b0:3ab:84c3:3f37 with SMTP id 21-20020a630515000000b003ab84c33f37mr3759690pgf.110.1651336089626;
        Sat, 30 Apr 2022 09:28:09 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:c0f1:53a1:ea79:5d2f])
        by smtp.gmail.com with ESMTPSA id k2-20020aa78202000000b0050dc762816esm1715652pfi.72.2022.04.30.09.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 09:28:09 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        John Crispin <blogic@openwrt.org>,
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm: mediatek: select arch timer for mt7623
Date:   Sun,  1 May 2022 00:27:48 +0800
Message-Id: <20220430162748.535317-1-gch981213@gmail.com>
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
clock. Select HAVA_ARM_ARCH_TIMER for MT7623.

Fixes: 31ac0d69a1d4 ("ARM: dts: mediatek: add MT7623 basic support")
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
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

