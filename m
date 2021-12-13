Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA748472B08
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhLMLQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbhLMLQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:16:58 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E0C061574;
        Mon, 13 Dec 2021 03:16:57 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so11322760wmc.2;
        Mon, 13 Dec 2021 03:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tvsq9PQVOB3boi9DaPr6RuQZlSBlTyb22EILAwFlVs=;
        b=o2IdNvYXhNDBUeC44I0ZO8K55z3IbopsKdORLeovJhGS3UnZTVdSab8xraf6Cahvus
         RQ3bY1udAB2PkEDePgrf68cHmHqKK5onLdJ+fuuCigBrk3u/z8oQuWB/9ZZEK6bZXfwk
         bxfRsEDSIhLSpfrBHUflg2X+V+8YC/LFJMUAoxbjOqYDppB8g6uNSgcgAlwaNHc6FXCq
         Qf2170dEjWo7UTDnJiDphJ476BwN5En3i/SHottg1Om2agQpn5mLUwPGW4cDmd1AiDME
         hCHgEp/zxQfqFzYL+Or1zeQijwLiXg0c4k0IxI+/b+ujSQCsby/78PILGwa6iMKnakQR
         jS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tvsq9PQVOB3boi9DaPr6RuQZlSBlTyb22EILAwFlVs=;
        b=JX0imn6D759ASF7XUHYj3LnpwUj1ba8z9l0FNPxa6FHeVygjJJ4V8v5tbc/jm8O0Ve
         LulLuCwjC1ByQKX+PaKjWSDAfPlhRXW/pKOclIUqRIvkWTVu+k9H5CprhZUu0gcjOalu
         hZscYVGS60C3t5vgL7dBhHePmH+WlbIMcCO32wbmk3jC3dS22k9tErb5PnuvlgYHqxgZ
         zrNXY7U8PfRgk85f8H+g8WFq2g6U3YT2aVPp4WRQZxDJQJ/fyQl/iNQJY/2ZY6sgU/Fy
         QJVtfM/XuSc5QAj7x43dpw/jnsh2DlhZs75JK1/8xf+KeO2W2HSlCaFRMDnqh6p20fSJ
         TjrQ==
X-Gm-Message-State: AOAM5309IfVvLvLTWitmfN4z9QthXvhpoLQoNMjMOLSfto3Fo5dwM9xR
        4BvGJApgW/as7vc39ZdxLvA2oO8h/Yo=
X-Google-Smtp-Source: ABdhPJyqBeB+HUzUzBpC05hE5Sxry91dWZ1bJyQl7ITT4MESCZGAtBpminw+dPvAygV03Y/9MziSgw==
X-Received: by 2002:a7b:cbc3:: with SMTP id n3mr36575153wmi.90.1639394216171;
        Mon, 13 Dec 2021 03:16:56 -0800 (PST)
Received: from DEL01603w.ebgroup.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id t17sm7255255wmq.15.2021.12.13.03.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:16:55 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/9] mips: drop selecting the non-existing config SYS_HAS_EARLY_PRINTK_8250
Date:   Mon, 13 Dec 2021 12:16:34 +0100
Message-Id: <20211213111642.11317-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4042147a0cc6 ("MIPS: Add Realtek RTL838x/RTL839x support as generic
MIPS system") introduces config MACH_REALTEK_RTL, which selects the
non-existing config SYS_HAS_EARLY_PRINTK_8250.

As the MACH_REALTEK_RTL config also selects SYS_HAS_EARLY_PRINTK and
USE_GENERIC_EARLY_PRINTK_8250, an early printk with 8250 should be covered.
Probably SYS_HAS_EARLY_PRINTK_8250 is just some left-over from an early
draft version of this commit.

Drop selecting the non-existing config SYS_HAS_EARLY_PRINTK_8250.

Fixes: 4042147a0cc6 ("MIPS: Add Realtek RTL838x/RTL839x support as generic MIPS system")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 00951bfdbab0..c89ce68d9580 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -640,7 +640,6 @@ config MACH_REALTEK_RTL
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_VPE_LOADER
 	select SYS_HAS_EARLY_PRINTK
-	select SYS_HAS_EARLY_PRINTK_8250
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select BOOT_RAW
 	select PINCTRL
-- 
2.26.2

