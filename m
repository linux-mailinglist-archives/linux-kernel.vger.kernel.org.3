Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83254A5B73
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiBALsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:48:35 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38430
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237425AbiBALse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:48:34 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CF5D33F32B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643716111;
        bh=nPtCkUJvHAiFdwR1aBTRoo7Q3YDQ+MsjF9AD3ZrXCWg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=NhEjWUJDpBJlTAuKIdy1jkMB9/PQROvOFLL4ZE7tFGgh8MvqxfGZXvggj6T33kLLm
         vmhtElgmJkU48+JcSQvCtimmuxoz7fkJ9NH2AkuIqsBCLlaL8PI4ehzcZNs2UYZgb1
         sjIMXf/3n4BIlDpFP6q6fXK+X+OPF6FEqAh+nHUmovOVvfW/+0oSSs6MGxm4QxFJlH
         YQ1+hVnbiu/r4QGiNVF+VpMU9foXr8MqUDcD9IlL7g6xMXhG6AwvGy1Jk9hpXOG2eF
         h7ee9q9lWXPNh/iGjZjWtehb9SH31INr2dC/EjaCGde/+RaBSsgLNnN1ekfds6apYB
         9O7UNIZI3D73Q==
Received: by mail-ed1-f70.google.com with SMTP id q10-20020a5085ca000000b0040e3ecf0ec2so708078edh.14
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 03:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nPtCkUJvHAiFdwR1aBTRoo7Q3YDQ+MsjF9AD3ZrXCWg=;
        b=YjOfoYzSyTT9l1BCYWx4qR1q0lpTrpt2sxjVHmz0OBU2tJQuOVDhL9f+jMnDsfP4Yw
         OlwzVqIehcOjKzKc9rgFyOUrHOivYoM8Ju0NIZbwmS/kpp69qFPxULZCAbZm54JRH6H2
         mqjY4/hKeQqkHGYrXVy6Nyn0aHuehAzU83E2qzqFYyxpVTCaRByB+2vThaKgAy+SGTMr
         P6WdVZfsmgxuugPqd4LHzfK78SKHBo94NdYDluCXhEjX9s5k4Nfpnm8w6E9Re+XVx2r4
         Dw0dvaMX2cqCS3fd7uUs+wBfAque47KEHTxuaI56d2io91U/UrJFkcGUhj2RIPLjWUw3
         dU4w==
X-Gm-Message-State: AOAM5338ZDA934iaQEfRGI885EumKRaQA3I2/9bpkzaBR0BdB6/WzKLL
        vQaKz/cKpEDNxP5XVk2ITp8sR+jKexEH/WCn/1itukMJVUzQvd3ExTihfXy53YxPKDttkU0OggR
        ubtogjw6fY3KdSGR8O5dQ717VSaun02+/Y9gjoLBAxg==
X-Received: by 2002:a17:907:8a24:: with SMTP id sc36mr20350996ejc.318.1643716107290;
        Tue, 01 Feb 2022 03:48:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSB+mTN/eqKVxteQU8ZJe5VpQaVxci/PoYo5bHi9rsjmr1K5CgtZb6C+DyJSPH0xcLZmI3cQ==
X-Received: by 2002:a17:907:8a24:: with SMTP id sc36mr20350984ejc.318.1643716107068;
        Tue, 01 Feb 2022 03:48:27 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bo19sm17954484edb.56.2022.02.01.03.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 03:48:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/6] arm64: dts: exynos: use generic node name for LPDDR3 timings
Date:   Tue,  1 Feb 2022 12:47:44 +0100
Message-Id: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should have generic name, so use "timings" for LPDDR3
timings.  This will also be required by dtschema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 24c428b84192..2f65dcf6ba73 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -358,7 +358,7 @@ samsung_K3QF2F20DB: lpddr3 {
 		tCKESR-min-tck		= <2>;
 		tMRD-min-tck		= <5>;
 
-		timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@800000000 {
+		timings_samsung_K3QF2F20DB_800mhz: timings@800000000 {
 			compatible	= "jedec,lpddr3-timings";
 			/* workaround: 'reg' shows max-freq */
 			reg		= <800000000>;
-- 
2.32.0

