Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0206D4900BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiAQEPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbiAQEPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:15:31 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30842C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:15:31 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id r15so28269269uao.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jrz0bdG4iCzX8XfyvV8meTCqb9+YcvxN13g6lpUSlzE=;
        b=d9ldkTPNkSTz+T7svFprrBD1WZjllUGXGOADq/pmke0uEIsS9A1I66kyYKB2PGT5AJ
         uehCo2noX7bRZiaDd2j3mj5hnmGGbvVNom1pX5EFrIIR59PuDeHFoVKiMn8bG5rzpWJv
         s/xfOS8Xobhmh5qj/ra8DWsDlD5e1w8onpISUoE5z+mbHpiOOZwkee8JPXnpXzJCGq/D
         bs7KgYM+YPltmwI+2G2QY9o7SO6Alf1ZB/YYkOFh6wZowlB75q+dt5ZH8qI8iJ6xJSd3
         9QY5gZ6biIgqWjamqsC8AapsfmV5cWqshxpmJMEOGV0PBkCOlzphuLf65T8psyVN4Zlo
         WbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Jrz0bdG4iCzX8XfyvV8meTCqb9+YcvxN13g6lpUSlzE=;
        b=a6Nn1ytp5w3ef2fCJz1fU9EYvsxRD0rBbCBj82VImnw13VyBx+laNIlYADhevKAGT2
         S8rJycjbOrlNxaei8La6nXM2Oq2rEKIuHEi/P4nCYeRU4UZfQa+7Dbijks4yRBDMgAtG
         QZqbmeOVH+SG1pBEvIDMyqM0EPwy+lfw7fywErwgY+v7a6IE+dynezA9FYylNOVVWm5I
         L6REP0Nv2OywqFYZS4s2fba1ljTxzgBnsbC6LgJklkDiM/kI5rHHj/NFNXa27QSPwduT
         HQWQMk2TxqeaqvW3lC9wUZCavD8QeRq3fYC3qHy9wA7A/D5pUv92nNfPLY5f3BL2q8Nm
         Aazw==
X-Gm-Message-State: AOAM533sJrZIkaFot03U+i62VaRXZR9xHNRYAdmqEI34DuGVU5lwioDM
        /tWDJOzxDp015voGkvLOoTI=
X-Google-Smtp-Source: ABdhPJz4KANYV21BxWjGA0rg4pA9/Ui5A7Fywh8jZw1U7X/Id8un1fH3f2ZOuxMr8eC/L8It5ekOrA==
X-Received: by 2002:ab0:5a46:: with SMTP id m6mr6835835uad.104.1642392930274;
        Sun, 16 Jan 2022 20:15:30 -0800 (PST)
Received: from kubuntu-desktop.. ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id x75sm3708463vkc.36.2022.01.16.20.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 20:15:29 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, Vijendar.Mukunda@amd.com, AjitKumar.Pandey@amd.com,
        pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
        tanureal@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        fazilyildiran@gmail.com
Subject: [PATCH] ASoC: amd: fix unmet dependency on GPIOLIB for SND_SOC_DMIC
Date:   Sun, 16 Jan 2022 23:15:28 -0500
Message-Id: <20220117041528.59958-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SOC_AMD_YC_MACH is selected,
and GPIOLIB is not selected,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for SND_SOC_DMIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_AMD_YC_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_ACP6x [=y]

This is because SND_SOC_AMD_YC_MACH selects SND_SOC_DMIC,
without selecting or depending on GPIOLIB, despite
SND_SOC_DMIC depending on GPIOLIB.

This unmet dependency bug was detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 7a9e45094f37..4aa067c5f054 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -88,7 +88,7 @@ config SND_SOC_AMD_ACP6x
 config SND_SOC_AMD_YC_MACH
 	tristate "AMD YC support for DMIC"
 	select SND_SOC_DMIC
-	depends on SND_SOC_AMD_ACP6x
+	depends on SND_SOC_AMD_ACP6x && GPIOLIB
 	help
 	  This option enables machine driver for Yellow Carp platform
 	  using dmic. ACP IP has PDM Decoder block with DMA controller.
-- 
2.32.0

