Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA2E466848
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhLBQcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359784AbhLBQaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:30:10 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6112C061396;
        Thu,  2 Dec 2021 08:25:36 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z8so699705ljz.9;
        Thu, 02 Dec 2021 08:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hEN8lxqzB5PkjPszcdUxNpJc6epYJF7n5YUfahDhZts=;
        b=RSdFPmrUI402Dc09tnZNn97E4pEduqTRau2Nw1Et+vXSTSItuWqQ1qQgo5J+1BALkT
         pXeYg8IVZsh7XiyOPcIos4OYMocNv/sdZlmzqs+1PMFo80P1PiaMBMTREakOY97rlIj+
         p3xxiIOjPJznHICXuXtAWMYjNAjHr6j6o2B4QEe22j2cFRFAexLVMLKWAkcu68zI7Q1M
         nKy8m9/kVL9Sx9kILwW7DYiglMqhLFai685lmOyY+Dr588tiOYC0mEUmIsj3T5c3yoiC
         MoulSGSizoR0jg4ycDg4rR4xfpG3PxTpZjMFUyuRkb75Y0WvHCyAW8LcTScBOdBn3AmN
         UvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEN8lxqzB5PkjPszcdUxNpJc6epYJF7n5YUfahDhZts=;
        b=XOe5W9DImBnR7as9/6/aGNrOO2qzLUTKOGkMsK7MFnajl7NzpYCYyoGbqSZOijMu+t
         /UYMNx7KQ7Ie6fvkgQkcBa1mMMglm/BrdCe5U0cMWbRdLZmafx9H/QWmPsB+TH5WKCXJ
         4poULpU1AocIZGFA4Nkb8m/s/qOCnVqJufRtd3mSjGKIFJlh9pVIrA9Lib0qYe1wUD9G
         aHaisOQ093ALN3t4NSy2oLf3G1+/c0BQW5ptfj/ZWzAA+vA8/TvvImTLELLh/TBPnlNh
         v9iqERYNUYoUqMKvMUe8NpaxheOajNQw8W6RrmcicI4Udlshvk/SdUvNexV8Rqn1f+JP
         +QPg==
X-Gm-Message-State: AOAM532SYDOWzrcZtkObf5U5fclo5GLx/UqEjamAVUj1ueIixtgv7VvB
        E19KiYdcUEMWOAraywwmur8=
X-Google-Smtp-Source: ABdhPJwb+aZCkvsM06cfVFDqv3SaV4prBR7wmD5aUJuI1klW3QBgZtBrKJ0ooP/0EW5plBrMNXKWsg==
X-Received: by 2002:a2e:7c16:: with SMTP id x22mr12905096ljc.460.1638462334456;
        Thu, 02 Dec 2021 08:25:34 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:34 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 20/20] ARM: tegra: paz00: Enable S/PDIF and HDMI audio
Date:   Thu,  2 Dec 2021 19:23:41 +0300
Message-Id: <20211202162341.1791-21-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable S/PDIF controller to enable HDMI audio support on Toshiba AC100.
Use nvidia,fixed-parent-rate property that prevents audio rate conflict
between S/PDIF and I2S.

Tested-by: Agneli <poczt@protonmail.ch>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-paz00.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 5b2260f61f05..921a811632a1 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -264,8 +264,16 @@ conf_ld17_0 {
 		};
 	};
 
+	spdif@70002400 {
+		status = "okay";
+
+		nvidia,fixed-parent-rate;
+	};
+
 	i2s@70002800 {
 		status = "okay";
+
+		nvidia,fixed-parent-rate;
 	};
 
 	serial@70006000 {
-- 
2.33.1

