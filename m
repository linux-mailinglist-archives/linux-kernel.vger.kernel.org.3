Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162FF490107
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiAQFKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiAQFKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:10:05 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A48AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:10:05 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id h16so9667816vkp.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VVMSvibBEDQWmTS4Y5AZX2LAQUp1loCiB0WTviYsyCk=;
        b=Wp3wRPz+YyRwJiNCgcQ1UGidIy+Nwa2YffuUNaXCKfkVGDhJCJ5WIu4mHaoh3UXrF9
         41NqRlnXBQfBvfZ7YC8spNt4xR4glQMU1VbvTkl3ovutQZkIIdPh0Dgpti5yo0RlGVFA
         pSGBKuW8baLlQRLOSJSx6mPdj1f90VLiFJWq8UzHGvQVyu/MPmhYt9afH7Ri0S6XrHi7
         DfmNkcZqTJJRyqpXRhsQ+h66uW20gdwqd30U9ZgsmQemyzExhkJcx4ODI+ezcMPyidiF
         SrizIKUgtFFiSWUh2HUn8jBmLZpEiIe1Q522+9PwaCA+txKXMwvnjur8LZAePLhS5egS
         l42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VVMSvibBEDQWmTS4Y5AZX2LAQUp1loCiB0WTviYsyCk=;
        b=gU3f7Us1i1eE7Hvy05H652VJGQZf8shmAxPJ+R4L8DrwLgOQYuCuso8csdkbsSaoOM
         txGbthQaL9O/fXy6GSqJZCn7SxLhzsTrt6pcUrvTSQH6HzZwd5hzuLb6D1Ul/5QUeVFL
         4C0VuTmb/2G2E4b1KL+8SmsdXellnx/p84PpuGF9fThbJ3eL1CEY4t9ACVlsGpsPCIYI
         f39FJ2xPNuQoQLl+fHgFurjCG0FLxU3ViHVm6cBFt6XTVLwE1ZiDbWwlpOw7U8S50QNh
         6cOMGS9paMNqnOu1AqjgNyAS/RUHz9F2NRb4rW+0YRuqvYAE8krkgaGkuw7Ob2oWdyq6
         BqrQ==
X-Gm-Message-State: AOAM532B00CJ6jgjsOObtvIceKJX7GJyzMf6JPPeuS8oYEZb4J4FduBp
        q3D/v3zjdlO/ybk4MTV88CE=
X-Google-Smtp-Source: ABdhPJxsGuOnDKIZ3OkIIR5d038ZKXPOcXRRRKUP/O6Gfk8vqlxZaG0VpNTjIN7SEL/jiT7/HewuUQ==
X-Received: by 2002:a1f:fcc9:: with SMTP id a192mr7446632vki.1.1642396204346;
        Sun, 16 Jan 2022 21:10:04 -0800 (PST)
Received: from kubuntu-desktop.. ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id d124sm3543878vkb.9.2022.01.16.21.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 21:10:03 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     broonie@kernel.org, olivier.moysan@foss.st.com,
        arnaud.pouliquen@foss.st.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: stm32: fix unmet dependency on GPIOLIB for SND_SOC_DMIC
Date:   Mon, 17 Jan 2022 00:10:02 -0500
Message-Id: <20220117051002.70270-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SOC_STM32_DFSDM is selected,
and GPIOLIB is not selected,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for SND_SOC_DMIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_STM32_DFSDM [=y] && SOUND [=y] && !UML && SND [=y] && (ARCH_STM32 || COMPILE_TEST [=y]) && SND_SOC [=y] && STM32_DFSDM_ADC [=y]

This is because SND_SOC_STM32_DFSDM selects
SND_SOC_DMIC without selecting or depending on
GPIOLIB, despite SND_SOC_DMIC depending on GPIOLIB.

This unmet dependency bug was detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/stm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index da1f7a16605b..bfc11b606bbd 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -37,6 +37,7 @@ config SND_SOC_STM32_DFSDM
 	depends on ARCH_STM32 || COMPILE_TEST
 	depends on SND_SOC
 	depends on STM32_DFSDM_ADC
+	depends on GPIOLIB
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select SND_SOC_DMIC
 	select IIO_BUFFER_CB
-- 
2.32.0

