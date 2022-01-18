Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4774913AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244257AbiARBjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244261AbiARBiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:24 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19DCC06161C;
        Mon, 17 Jan 2022 17:38:23 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f21so15809271eds.11;
        Mon, 17 Jan 2022 17:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcDDdaksgsJh2R/SSWza5ev8vdSQuzVQ92v0X8aH2rI=;
        b=RJ0XW74HeFyz/r2PQQBMzBBsmCjfjCYpIZMByJxEdgTe06Hlg6fnTORIAW7EX9Gg5C
         o+pY+spBiQuFHUvxOZ5n6bAnauuUYQADhBQ0/7I+Q7nnIz6rsBbgNAkwgzhKPeNiojXd
         X01Ryi0WGz2nW1XtZoFwxjB90yw+AjFWspH2rc964NfajyTbIq0uDDd8dHVH+d0Uy8G9
         ZX39cc4uYy7KEJGQxJ1r/K4spnEoulP0ym24kIRKFNDVx/ffzUPwKTwjzS5Ke6i9W0Mu
         ekc7JnibNHJ3JePGuWpe1HDkjoXfSXBbMalUUDir3paH/eVlafb07zqlLeZvRfd3eh2c
         EYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcDDdaksgsJh2R/SSWza5ev8vdSQuzVQ92v0X8aH2rI=;
        b=Z1lvKLydFYWgQuocjY2gj7zHpW8G/h9nA5B5gpdTx0ZGbOLBJxMmEdQbHzv51AScjQ
         Gg94oLc/KK7gH7nIZsszENm26hBrAYvJ8T0JncUvi02oe1BNkzpT0CIUmkMhKBC7TzMc
         9sNF+CN0pUjrwdxbFXADj2mg0ClC0KQKLF7wpHjC+ozoDbi4JewvTIdlXCCBHjWaU2DS
         0PI79KVEB8gZ1L1eV2K4wq8QJnwgcHcyzWaC8yrVEaIn8CFStJeC4gLx74FqJqc+zM6N
         MpJTK/1zqX3ZECA1d/SSEdoVz1w9w4AFlenKr/q1UT5Sy/YrHFt5cYuXxdcPwGbQ5/bD
         hAmg==
X-Gm-Message-State: AOAM531BR2biPkjRbESW/QkBsGKn4cpjgm7I25cs8ufwIHRj7rMiYyQT
        UJHLQ9sr00DeNAWQ8zO1gCuSJZftnSU=
X-Google-Smtp-Source: ABdhPJwlpVI6SEP/goCToDRr42/yhnVVYFXwho0s9/eRylQR+pObuXCOWochDOH1XARUXL3MnBBJNQ==
X-Received: by 2002:a05:6402:1cad:: with SMTP id cz13mr15922141edb.216.1642469902450;
        Mon, 17 Jan 2022 17:38:22 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:22 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 13/17] ARM: dts: qcom: add speedbin efuse nvmem binding
Date:   Tue, 18 Jan 2022 02:20:44 +0100
Message-Id: <20220118012051.21691-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add speedbin efuse nvmem binding needed for the opp table for the CPU
freqs.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 1e6297d6f302..a1a809134d9e 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -956,6 +956,9 @@ tsens_calib: calib@400 {
 			tsens_calib_backup: calib_backup@410 {
 				reg = <0x410 0xb>;
 			};
+			speedbin_efuse: speedbin@0c0 {
+				reg = <0x0c0 0x4>;
+			};
 		};
 
 		gcc: clock-controller@900000 {
-- 
2.33.1

