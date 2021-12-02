Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991CB46684A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347943AbhLBQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359770AbhLBQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:30:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0EDC0617A5;
        Thu,  2 Dec 2021 08:25:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bu18so72866915lfb.0;
        Thu, 02 Dec 2021 08:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FxP5tB2iw5BzQOiwdyEyNre1QfPs8oOiaNDQeHGYp/A=;
        b=aAmo87x7MKY0+QkIiV1iYDAGkJpjUtS0nLp1b76Wocjq5LssoGlpY86GAohlboJ8Xx
         PpEV5/ex7E5NW1eoaI3yz6HBQt6qke3IzgiWVpYQOrfDVPLMcWsLt4fZ/SCvocWuWqbP
         kEv+h49CXlKWcQhzjoXBthjasMcdyBUZNY3N4mVCPj707UAa9TToCOvF0yX1+hVoAk1N
         hH7A3ZmokIyA0KxpI/ka5AQp5I8+9P7u3sNOoscPnwd9sk1F1SmALlJkWw4N9Pl//x2T
         yrFfMoKYJGCgMRH4Qh/iOVBKDWY8VdMjsg+kKpjl+HGy0oZblGHVebwNkkG0cLEURfVe
         p3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FxP5tB2iw5BzQOiwdyEyNre1QfPs8oOiaNDQeHGYp/A=;
        b=H1SUZSXNurXxD8W7Y1JdLHvQ3ksdj0+4KUiC5mGl0LyKojpdOHE5q0Cl3njjFa698h
         /jgG+WSqwW5aBZNIGzlvGaggn+Ek2VTxtHn1ADQ9hbsagH4fGpY+yq3fwOrJmdOAAdO4
         BHPcwszL7QkOsSq3T95+GxvCmImr0kRCMnxbTXEsawBUJWkly5bE8Rov9Wi0SgOVneEE
         zKb2/0lz3ZQ595C0OFqnZ8NfZebRxG8kqoHBGpLv/OS0paA6IFLIblWhc8FuYVEURlHv
         91dg89EHQ4GM6ZWNKqCjcQhrWwQchfwRzeQlE+v+Mgio9vwCeYq7XPLTVJBwyhejx1Rq
         ueWQ==
X-Gm-Message-State: AOAM533VzB7CtZxnf3YTEaAR86zEzFYvMNj7CMBNa3hY8J6g9NCsoC2r
        wtdHJu426jzJWKMiwKQjyzU=
X-Google-Smtp-Source: ABdhPJxCY0oVQ8aH83x+4OlvUDxHC37p5YyeIHFpmCbaFqheC4dbnYNMwVyp5NGlNDxLxHNpXrhAQw==
X-Received: by 2002:a05:6512:138a:: with SMTP id p10mr13129433lfa.508.1638462333467;
        Thu, 02 Dec 2021 08:25:33 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:33 -0800 (PST)
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
Subject: [PATCH v3 19/20] ARM: tegra: acer-a500: Enable S/PDIF and HDMI audio
Date:   Thu,  2 Dec 2021 19:23:40 +0300
Message-Id: <20211202162341.1791-20-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
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

