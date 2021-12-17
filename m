Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5984479532
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbhLQT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbhLQT5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:57:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1399AC061746;
        Fri, 17 Dec 2021 11:57:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t26so6093034wrb.4;
        Fri, 17 Dec 2021 11:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6q77+5UM8ZlyyCHC/ie2KjcIve/mAf7JTnLDOGgmIY=;
        b=Qt5BHOEBZcavrTAAJ+ZVSjoDvN+qCazFSMAAvFPPG9B5sVtc4K9wQ+nwzRyeztHT1J
         r9aFzl45q5oi3nDwZuNz7eAXGs0rCioFhBW+QMuBIynqWVd1vZANe2YIEXkwU6+bOK7m
         Ezz5XwFQkPgUhjTzpxs1KPEayKSKY8YzpN9Zss0barQPeyyTwxyCyKaKalt3igBS1j7J
         pu6s0+hUkD6Sz22ILGF3nFdmNZ0sv370Bwm0j0VGy+vglMV5hgkQOtdfoOOkhcoCGh6A
         IbAR+1ZRJc5/7Bke7WkFCMoX6XS3+ah/8DOFS/gz+yWKv17vR7qQxMxdSYPxCQLy/Zyb
         bnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6q77+5UM8ZlyyCHC/ie2KjcIve/mAf7JTnLDOGgmIY=;
        b=eISTXHKbY3jWDrf63aO8AixM8IMzIbmBoghbDh5Y2zaAiqNIuRKFfy7Dj77DiZjCzM
         AHCef6+esm/x7JO5dYYpcRv42hCzSuuIIaDSmwnfrA1N9+PUT/iQvXFNyHaLyBWlOPfN
         dXfL5SwR3H+iFyw10FLH2f80+I1fYJlGPQcaEUkJ9tmWV3md4Soz3/KbYSDu9ci8wHVn
         VRbugLdvLKEzAR0vFSWcf96dhhyOc3NgMWmNiZ8u94k0RBuXGwQjoGWbX2/hCddjmpiE
         q0Fcop7ob4t3H3TEVcg36VB129CU52Qr+gS7xIDvm/0Z/hGJo9HOHj893TToK8B6Chm/
         Sa2Q==
X-Gm-Message-State: AOAM533objY5ls/eMnaz22j0Qa2TePihFtBz99ubhzzLzPzM5YnyFiTU
        29jh3DiAEDfRWcZx2tAC4XmR3tB3+y8=
X-Google-Smtp-Source: ABdhPJzsgwE6dgUIhbo8IjDc9nszMSuySG0oe80qqQ9FAF6H7181TRhaf7OLKv75Zk/MWo+622wdww==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr3768157wrf.410.1639771062339;
        Fri, 17 Dec 2021 11:57:42 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id d15sm10781590wri.50.2021.12.17.11.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 11:57:41 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] ARM: mstar: Select MSC313E_TIMER
Date:   Fri, 17 Dec 2021 20:57:24 +0100
Message-Id: <20211217195727.8955-4-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217195727.8955-1-romain.perier@gmail.com>
References: <20211217195727.8955-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the ARCH_MSTARV7 have timers that can act as clocksource or
clockevents so select the corresponding driver.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/mach-mstar/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mstar/Kconfig b/arch/arm/mach-mstar/Kconfig
index cd300eeedc20..d079d567bb72 100644
--- a/arch/arm/mach-mstar/Kconfig
+++ b/arch/arm/mach-mstar/Kconfig
@@ -3,6 +3,7 @@ menuconfig ARCH_MSTARV7
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select ARM_HEAVY_MB
+	select MSC313E_TIMER
 	select MST_IRQ
 	select MSTAR_MSC313_MPLL
 	help
-- 
2.34.1

