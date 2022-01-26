Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB36049D102
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbiAZRkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243863AbiAZRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:40:27 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFCAC06173B;
        Wed, 26 Jan 2022 09:40:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso4261169wmj.0;
        Wed, 26 Jan 2022 09:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulig+NgjEE7l6Z+aIp4JTP1x0y637qLlf9qLjv/vjdg=;
        b=bpuP5o068VsJOexNh235XajQKpnybZrnwhxaOVjRclvMkUzJ2rQ+smHnqJqKRuhI0v
         uEOyL84lSGV0VF19yzX7pn610LL1sXY9Te0+t6AqTFL6I8DuwV0kTpDz0IwiC7QKWLHq
         cIiJHlEMozi/OlowMow0yMyQD5Knhod4/QDtVxXYRDgA1GudHOpWCfhPE1pMxiJpDVzc
         ozzIgr1u+pW+OlLRoTiwjs7y1rifMpPMt5utLwpnew/Dd0LXvGAMAqtSWZFRI1lfSeGz
         5+z4Vt2Kys0AdKyma/X+t7TcefuiQNUmNlYB4d9LGeDa3NVXg2AsjhFAGL1nkrasTbiu
         XOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ulig+NgjEE7l6Z+aIp4JTP1x0y637qLlf9qLjv/vjdg=;
        b=BzE2NI3cteJoWlSTRMyrhVds2DE6fbQHEXKpMgeAhVDf2Z9auQ6lxqq+QURvFVPhgP
         uaspfv/p+pWVdV8c9AEXzPLzLzznCrcdndvA4c45Dt81NmuE9PTYazN/1wrf704iVo3m
         TJJ0mhdAqINcM59Y3YRyX2IK0kcD2z6BEFiNSuZOFnMM0BWh2m0gDKDY/fRX5OuVRvF8
         HOqLNMAg9RkCXmHFrWZLdb68KNJLulIFKF42dEAzxvDs/J5zmrn+ZNVBsKvf1fg0vf3J
         icJv32XFtBSnkthz1BNKy7ow9SbA2LbnKcbs/Wbe881vQ4rHqOvbseNS7R9lMrpkgxS+
         fX/w==
X-Gm-Message-State: AOAM530EQB46c2mKu/DLaVYHvmTrA418kgcIzqZtydRa3L+6HybijW4G
        8QSFqirWD5OISSOqqT6XFWHi6UtCkUw=
X-Google-Smtp-Source: ABdhPJzFPZr2Ni2vwhqzNoeD+KTru53+bC5CJg4Qw5w5sFqeisfAm6CpzuhMD307SNKXxZi4TqiFcg==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr8374630wmc.70.1643218825440;
        Wed, 26 Jan 2022 09:40:25 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y2sm3498451wmj.13.2022.01.26.09.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:40:24 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] dt-bindings: clock: Add JH7100 audio clock definitions
Date:   Wed, 26 Jan 2022 18:39:49 +0100
Message-Id: <20220126173953.1016706-4-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126173953.1016706-1-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all clock outputs for the StarFive JH7100 audio clock generator.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 .../dt-bindings/clock/starfive-jh7100-audio.h | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 include/dt-bindings/clock/starfive-jh7100-audio.h

diff --git a/include/dt-bindings/clock/starfive-jh7100-audio.h b/include/dt-bindings/clock/starfive-jh7100-audio.h
new file mode 100644
index 000000000000..fbb4eae6572b
--- /dev/null
+++ b/include/dt-bindings/clock/starfive-jh7100-audio.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7100_AUDIO_H__
+#define __DT_BINDINGS_CLOCK_STARFIVE_JH7100_AUDIO_H__
+
+#define JH7100_AUDCLK_ADC_MCLK		0
+#define JH7100_AUDCLK_I2S1_MCLK		1
+#define JH7100_AUDCLK_I2SADC_APB	2
+#define JH7100_AUDCLK_I2SADC_BCLK	3
+#define JH7100_AUDCLK_I2SADC_BCLK_N	4
+#define JH7100_AUDCLK_I2SADC_LRCLK	5
+#define JH7100_AUDCLK_PDM_APB		6
+#define JH7100_AUDCLK_PDM_MCLK		7
+#define JH7100_AUDCLK_I2SVAD_APB	8
+#define JH7100_AUDCLK_SPDIF		9
+#define JH7100_AUDCLK_SPDIF_APB		10
+#define JH7100_AUDCLK_PWMDAC_APB	11
+#define JH7100_AUDCLK_DAC_MCLK		12
+#define JH7100_AUDCLK_I2SDAC_APB	13
+#define JH7100_AUDCLK_I2SDAC_BCLK	14
+#define JH7100_AUDCLK_I2SDAC_BCLK_N	15
+#define JH7100_AUDCLK_I2SDAC_LRCLK	16
+#define JH7100_AUDCLK_I2S1_APB		17
+#define JH7100_AUDCLK_I2S1_BCLK		18
+#define JH7100_AUDCLK_I2S1_BCLK_N	19
+#define JH7100_AUDCLK_I2S1_LRCLK	20
+#define JH7100_AUDCLK_I2SDAC16K_APB	21
+#define JH7100_AUDCLK_APB0_BUS		22
+#define JH7100_AUDCLK_DMA1P_AHB		23
+#define JH7100_AUDCLK_USB_APB		24
+#define JH7100_AUDCLK_USB_LPM		25
+#define JH7100_AUDCLK_USB_STB		26
+#define JH7100_AUDCLK_APB_EN		27
+#define JH7100_AUDCLK_VAD_MEM		28
+
+#define JH7100_AUDCLK_END		29
+
+#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7100_AUDIO_H__ */
-- 
2.34.1

