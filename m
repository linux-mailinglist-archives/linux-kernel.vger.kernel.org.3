Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CAC4716A2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhLKVPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhLKVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:51 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5DC061371;
        Sat, 11 Dec 2021 13:14:49 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id t26so24123526lfk.9;
        Sat, 11 Dec 2021 13:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKt9YnkKlXD514q7tFDbDrGJcN8l4g6hHAMjM2/Z7es=;
        b=Ufo/uyD/7MQAkaRBq1aCIdThdkb9eD/xhxhYeqGBVd5zR4MVNGnjNx3V7NPArCpEas
         vV60tL6etbtCEfucj3MmstWAWhp7PM5yJc1HlU3cTpAM7p1VkhNBWo4rXrO7DdtbPaAv
         xdoXwc8pfkBBk7PtKvPofKwmb7SEyPu8m840WlUsy9Ndij15wxQbKgEztbANsOzPb030
         zJ636g5p/LgefmZmBKxyoxLBXUZoHC0xur554nF6Wcr4y/YwoUrv7PiQVVvY+UPorwHr
         GfyyJdHpHCOawzwmfEWGQk2AtEbPKSmbVgwQrfxnoDJhz0g/b2dB0M8JYIHltqfW9Rv5
         ZmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKt9YnkKlXD514q7tFDbDrGJcN8l4g6hHAMjM2/Z7es=;
        b=F6LWwTgXFWqs6u0dWEVmWnzXLY7OHWyywmWuRjsqxuiD+BBHNbNC6rLWwjf6pValCn
         7w2AA2lRt3OEDclbcGYM0mz07gCIiKjJOPrhh5rCL4kPEymAZF+Sm7dvYuSnXut920U1
         OhrN/ucrWOvVegxTvnZhfEuVxS9uQWq4O3jFSXxXgVnAx3HizLObQwQF8Ubzdgs/o3wl
         nzK4bDC/VmyJJLBl+staYDDCSgJVSEZqdsnH54tqC4bhT2OCvzDQmqLrUGho3l83D7MK
         YI3Tja4tnMwzb4IDvcfQ6r4+PFjhLbua3GVdXxvji87CVwon70tHjKOm+srGf0FUWw32
         b4kg==
X-Gm-Message-State: AOAM533Ks4d3fNH2U0/cgO4dG5gSlNP++aNgsIDL8qC2Q4BjOjwIqi2N
        xzVQvPvEmLitozRqs8eWcmw=
X-Google-Smtp-Source: ABdhPJwkLnozsS6NrjlYv2VXKYKVjLTRvnF/RbHq790CdC4zn+qSXYGmLPUY2wDZf6wyvlr+3DG4oQ==
X-Received: by 2002:a19:614f:: with SMTP id m15mr19852748lfk.187.1639257287302;
        Sat, 11 Dec 2021 13:14:47 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:47 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 25/28] ARM: tegra: Remove stray #reset-cells property
Date:   Sun, 12 Dec 2021 00:14:09 +0300
Message-Id: <20211211211412.10791-26-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The Ouya board specifies the #reset-cells property for the GPIO
controller. Since the GPIO controller doesn't provide reset controls
this is not needed, so they can be dropped.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-ouya.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-ouya.dts b/arch/arm/boot/dts/tegra30-ouya.dts
index 4259871b76c9..fd64aadc472a 100644
--- a/arch/arm/boot/dts/tegra30-ouya.dts
+++ b/arch/arm/boot/dts/tegra30-ouya.dts
@@ -70,7 +70,6 @@ hdmi@54280000 {
 
 	gpio: gpio@6000d000 {
 		gpio-ranges = <&pinmux 0 0 248>;
-		#reset-cells = <1>;
 	};
 
 	pinmux@70000868 {
-- 
2.33.1

