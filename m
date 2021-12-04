Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C73D468597
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385359AbhLDOmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345376AbhLDOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:16 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF11C061A83;
        Sat,  4 Dec 2021 06:37:50 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bi37so13837000lfb.5;
        Sat, 04 Dec 2021 06:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hEN8lxqzB5PkjPszcdUxNpJc6epYJF7n5YUfahDhZts=;
        b=RzfaFRXrQ7CuSKPzd5O+0D9Mbq84hRoijgOs6hXD+7GKiG52l/xbQwHLkkUHWt8wo/
         EruzOPP9GeQjoxbrO3uLPWtZkWT1O3F15sjMxxf35CdGZ0vsxrdKYrmGDRYeoaOTO2EZ
         G7HhLN+0R++d1G7lRodBHCzl9BhdQSEl0bVdOpM9tiRtt8LoSIyvlci8SBbOeKXNCGr8
         rGso9XNmd7XdPBAgwbdctGo9CKcY5gi9hMHF4PHnghRk+mNMYnFG98LIwqfg3/Nb+Quz
         ud0jPN/6fTWgNYWOumT/WxHTQ4hxmxT3s2lkhBaPMqajlFTqRbOi7H03sqNM2A+qFWq2
         4Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEN8lxqzB5PkjPszcdUxNpJc6epYJF7n5YUfahDhZts=;
        b=M1leF4dtMgJKWZWTgXpJbGEySYwWIkrKJlxrS2cfY+VTDkBAxIboNN4SgUb6TdbGJP
         tVolTyq0B8slD/uTjgmiWKMrP7nd9kf3062wqfN9OK+orOnoiDiMbSZTSn3YYNF8M9Ic
         QWFFX50fuSmID3989ACme3kTrTrsHJqIGRzqRbMUPnBXmaNGC3XPoAsNP0MU7Zdg+dDb
         kmhy0TWess3DZuegTQrcDWDFYEqj4AsvtjMvemNE+DbOoC7iaUpB2uY2+4ShVGanRE6V
         4hKLPIqUglr4L3e7QaYM6c/FoxIhYU0+3NuYQtFamAQiX6U/4YP3zyh2bTWJEQDoNFFB
         Pe7Q==
X-Gm-Message-State: AOAM530hXFRW7I/K0LDZfh67R+2UkWnlA1Nh9xgX9FH//Lrm0lJNuXt2
        b2+ASkpaLQHPbDH1btMpQeo=
X-Google-Smtp-Source: ABdhPJwf+GX/2emTs7+L59bwUSAf7ewn6GK+Tt7M5lTMPClzxfZokayjRS6DmCd3RSP5aXksQpYJwA==
X-Received: by 2002:ac2:4c47:: with SMTP id o7mr24822014lfk.558.1638628669123;
        Sat, 04 Dec 2021 06:37:49 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:48 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 22/22] ARM: tegra: paz00: Enable S/PDIF and HDMI audio
Date:   Sat,  4 Dec 2021 17:37:25 +0300
Message-Id: <20211204143725.31646-23-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
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

