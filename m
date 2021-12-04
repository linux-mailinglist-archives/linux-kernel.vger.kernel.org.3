Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D999B468599
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355380AbhLDOmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245717AbhLDOlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:15 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030D9C061359;
        Sat,  4 Dec 2021 06:37:50 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u3so13844068lfl.2;
        Sat, 04 Dec 2021 06:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FxP5tB2iw5BzQOiwdyEyNre1QfPs8oOiaNDQeHGYp/A=;
        b=UacBb1E5+o5jnYkAbQY/LstAz1dq1wXZlTJ9nXprj0kabeLY0GpeOaoFNI4Ko8bUbb
         I5ijch3w9RajEmDpe38OcdNA0pc89lro9SOPsUnu6kOfQdryIogs1wXkcezKIKRv0lOZ
         n9B7Db5+P+S1m6YptZd1BtdlzEStuOg1aODg0eJRFMTD+zngUlO+EorP9Cj3ohgQUwFi
         6VynchlLIfLkAnoLp+6lh6hwIesEVooX5rBWaNF80T+ryJVaSR7nHVtrnCVcIT9FieEF
         kSmj1ghUOiST/oEcvCBL2XqCkiq89IFYWBapaXu+ZUvPdjsx3vuD/jFZv/VUaHADS77x
         JOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FxP5tB2iw5BzQOiwdyEyNre1QfPs8oOiaNDQeHGYp/A=;
        b=sCkg4P8OIZQddMAt2BzPim389vLXPgIZ7Kqh5SXrv8QHp/UbSzA0NYqYD1kc9GZ/3c
         3LuIaafCbgLNIV6R7fMNFjgr8cDUGF417VTlFqtJNvJFNG7DhZhr9d8P+dgosZvK0ygT
         u8PQffDGtGzgNyTi3ZG48imE3XAyAdAs3qZ9wiwH0FsQTKv3y5Qaubneu7DZcgwKkFrb
         eeXWBpkDPrCIvhvM9FVPu+MBXIdvumeYzwlmwC/poh5/xKQNIC8WQ8IjG7UcpCJU9Mfi
         NruVQ66t0ITDdZUullnK5hCpLHU/oKjEGpzFGDYJfTX3FEtR0rIayAqlNzVKEY8qoRSc
         nDUQ==
X-Gm-Message-State: AOAM532t05HMk9ap27hhAwDEG+cJ5Zc/QbK1X+IdIEfxDlnr7CYWtGST
        WpGdPpForXg5saigixsab+s=
X-Google-Smtp-Source: ABdhPJwNw7tkzPZmngP9ATpz6Aqmnw4XwSr8wqcSLqr4AoEI0Q+9EtWOQ5FopwgNaf1mdEz7Fn1MUA==
X-Received: by 2002:a05:6512:b8f:: with SMTP id b15mr24260516lfv.443.1638628668340;
        Sat, 04 Dec 2021 06:37:48 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.47
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
Subject: [PATCH v4 21/22] ARM: tegra: acer-a500: Enable S/PDIF and HDMI audio
Date:   Sat,  4 Dec 2021 17:37:24 +0300
Message-Id: <20211204143725.31646-22-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable S/PDIF controller to enable HDMI audio support on Acer A500.
Use nvidia,fixed-parent-rate property that prevents audio rate conflict
between S/PDIF and I2S.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index db388ddd062f..f47b946627c3 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -376,8 +376,16 @@ pta {
 		};
 	};
 
+	tegra_spdif: spdif@70002400 {
+		status = "okay";
+
+		nvidia,fixed-parent-rate;
+	};
+
 	tegra_i2s1: i2s@70002800 {
 		status = "okay";
+
+		nvidia,fixed-parent-rate;
 	};
 
 	uartb: serial@70006040 {
-- 
2.33.1

