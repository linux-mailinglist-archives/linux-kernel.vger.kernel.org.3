Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5796347FDA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhL0Ngu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:36:50 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54670
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236850AbhL0NgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:36:10 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B447E3FFD2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612168;
        bh=wO5Lw0gsdYf0zU1BO1ZHPdKqK24/sN+p7v+KigV/IZY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ttNYqkFBOtuLXRPcedLp7tdPk+tNAr4e6wJCk8G2Q2AY8ut3D0+EBzDt6bHZjs+F1
         9SUpkgVR9YaRyiMQLgId+Jk44jKWvHY4x9R/d748pVcL0y2+asikIorpSnF+S1U26Q
         JWZMG4jmLxjfyV5Yk71ZYEi+AYPDxuosBxkBa7fy4YC5ZTQZyfqSmmGBW8aw9SjmNB
         ivPdgjqGaz30G4kgHIt21cYSnLONJqzYHHO8DJ3P7N0B35fhMNoFDvoKMP3FpklW7q
         NYlPdEB+mIgXbUzbWF3NNgPLQYFzFpR4fTnOI4M27r00qeS7Sm6H7IQIKbHMbyHvfo
         1Bts4eiMb4Ubg==
Received: by mail-lj1-f200.google.com with SMTP id b20-20020a2e9894000000b0022dc5a5f841so1944177ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wO5Lw0gsdYf0zU1BO1ZHPdKqK24/sN+p7v+KigV/IZY=;
        b=kVgkGBzWcQc0/FMfyM8A9gtMKFG3ErUpOKcbhtL79Kifq/h0gSVzY9TLqnDzDXtMzk
         6S9x29z1MzwRAdFHSWUUiuVyLuv+vrRc/7tCB59dEaY9QWnEa9/eH4XHYcLdgT2lJulZ
         gaZ0JhisXdWCdmC/eIpqAGyNw78hMFYkzeCnNuXpp8WmhopzTcFowtEswJJ/A0eBgjAa
         diy8FmhSjbuFSgI+qilxn1JqnOzFEZFZu9Sm2N/aDOp9dWTXPJi6gk6Objsr/EPJmy/+
         HpcAbGVcm2rMiqGF1JWtuvokGshWD+WVvOPLEdf9xI7E84yISPCI9pgpiScBqHcnFmk1
         NuFQ==
X-Gm-Message-State: AOAM532xCepqUgoiFbuukhjvW1gegjEld5h55eWpQmAvMORYiqUUxQE3
        yc3Ruo6oWEHF+8zOBPST0YrL+FfvchUTCJDag97GHYhZuH8vYkeWJWXpXeo+8OJNDZrdYPHaemS
        CbHinYAadtRJLaxiHrBsvHl1JfvSEsp+UiGBXpSWMYA==
X-Received: by 2002:a05:6512:3a89:: with SMTP id q9mr15222447lfu.99.1640612168015;
        Mon, 27 Dec 2021 05:36:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTp9VeB2R6gEMXKCJDcva9kYSWJaiemwA+YvDBCI/xJcOsEjKjDh0qOS8ieZg+a/fSIiIkcQ==
X-Received: by 2002:a05:6512:3a89:: with SMTP id q9mr15222433lfu.99.1640612167855;
        Mon, 27 Dec 2021 05:36:07 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:07 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 12/19] ARM: dts: arria10: add board compatible for SoCFPGA DK
Date:   Mon, 27 Dec 2021 14:35:51 +0100
Message-Id: <20211227133558.135185-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Altera SoCFPGA Arria 10 SoC Development Kit is a board with Arria 10,
so it needs its own compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 7edebe20e859..ec7365444a3b 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -6,7 +6,7 @@
 
 / {
 	model = "Altera SOCFPGA Arria 10";
-	compatible = "altr,socfpga-arria10", "altr,socfpga";
+	compatible = "altr,socfpga-arria10-socdk", "altr,socfpga-arria10", "altr,socfpga";
 
 	aliases {
 		ethernet0 = &gmac0;
-- 
2.32.0

