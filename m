Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163B046DA2B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhLHRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbhLHRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:49 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F632C061D76;
        Wed,  8 Dec 2021 09:38:17 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bi37so7050601lfb.5;
        Wed, 08 Dec 2021 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ivl/N40c1tlMrmwTfIX/+o/rKme8fK1843gBC9Fg4bk=;
        b=dcW9gc3Rs/aEtHvNDMO95krTDBxrG3HyYE1JMapnP/o15r9iHGAA+ZzfH+TK1FRD5S
         6kRutW2ACxcJM4fWHWsUjQvwz69ewHiRzOvyBEatnWZ/Q1EAXaNJKrCO78S09vkjcboV
         5hyntJPb6QAKdJneujOnzSQPw23eIjwHsVsUHpuC63OsZqadiev95L5E6rFCeaUPVg1X
         7xK/SUynAKrXegsH2aYDcdxMCsrSCEJplIsAXYByhH9Qz+oJklwolGQJaA3l216qZJ0U
         tu351js9FsFivqTMxoQuK9f2j+8DYU3GWgzf5Iz5FHuEAEXffgRMPOes7vq3RMmzUNpc
         e/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ivl/N40c1tlMrmwTfIX/+o/rKme8fK1843gBC9Fg4bk=;
        b=fFl8Ek6dzJdFoTLUcMb9KZkOJCaRcCTVcHzr8g8azqWfl3RgWZeBbicRGFyCwJD7B5
         z9Aeox5aplj72XERpRP5Km8Lyw8cnIW9C5Pu+rMuUHhOpkQ1RWKHGm6h12H0EOWl9vbI
         OOArYz3E7i5OxLcoJcBjOG6nEnXzAuXc/OtcTx5/dqqGNHXc+nwgXwaZp8s0QHh5IODZ
         kN5KlsBoYEbswAJ6J5nZqBoWpLWlZct1oUxUkmKgoc3wlDSNLPgzVUeFyitrA9SWhb2Y
         cB9HKRS8HdBVwzt+9QptBfr0Ip7inxRQkra1WOri23vYRwpL5f2FKVH8N3up8DHaWcvS
         CFTA==
X-Gm-Message-State: AOAM532n7k7sSNLCWCRtBP5LJILSZFBsmMFyaZoi6oL6xRLY4f3nMNlv
        1dhi0ri3zFk61o36cY40/Ts=
X-Google-Smtp-Source: ABdhPJzaLoNSBA4WKVWJVX1XUp530xMytBHQK6ztvY/iZ0GFsoXgWTDNuD6303T6jvxB+nBslpXYRA==
X-Received: by 2002:ac2:4d19:: with SMTP id r25mr837377lfi.82.1638985095659;
        Wed, 08 Dec 2021 09:38:15 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:15 -0800 (PST)
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
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/24] ARM: tegra: Enable HDMI CEC on Nyan
Date:   Wed,  8 Dec 2021 20:36:01 +0300
Message-Id: <20211208173609.4064-17-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HDMI CEC on Nyan Chromebooks. It allows to control TV over HDMI.

Suggested-by: Thomas Graichen <thomas.graichen@gmail.com>
Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 93a40a84b792..a5dff226831b 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -390,6 +390,10 @@ pmc@7000e400 {
 		nvidia,sys-clock-req-active-high;
 	};
 
+	cec@70015000 {
+		status = "okay";
+	};
+
 	hda@70030000 {
 		status = "okay";
 	};
-- 
2.33.1

