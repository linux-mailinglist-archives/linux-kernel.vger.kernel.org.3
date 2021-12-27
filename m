Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02CB47FDA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhL0Ngn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:36:43 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54810
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232261AbhL0NgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:36:21 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 721E3402E5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612179;
        bh=qeUVo4OnQnEXa4nRM+7z4OtDYprQ+PGgnySdBFiipc4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CYea4KZ31hAkjDgt0+PlIfGNFqxFTdF7u3go8iGnUwcceFR/9cLVAdqY0iwkzrlXe
         YkwYi6Rf3GGalqXNy+semRP9yRErp3vGhsrOikBCH3Az54Q4A70qhBtzqQ4LED5cNj
         CrchDmOXmVIoqupF6HMINJIdaRngqNEwltBzZi1uK7tVBRiZThszS5UGNvV7+U7hBE
         8oAIlI4NaBFcGtHDYfMBqMA+3fTeOyX7BaSt3Yznmg7i1lxwXyG8ukB9LPcMbrbS7p
         0NafaxFlhnHCqWNFUqZzQfksiwHAqapSLTQfwstbU5lMSZvieBvl4C/1/LgVjtmYk4
         bZXsBN4ccMzXA==
Received: by mail-lj1-f197.google.com with SMTP id a29-20020a2e7f1d000000b0022d7438b7e4so4932106ljd.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qeUVo4OnQnEXa4nRM+7z4OtDYprQ+PGgnySdBFiipc4=;
        b=FRdxstI++rfzh0LUmWKLXRH6BCLbzpODRLAhwQyf9w/WkKYD+BhDsXCl/fw3DJhgx9
         gOCcsedbphERakiuDt6o2joWOCn1IWHb0wyZv5sfdjqLFeHCwBdzlhGRorwo7PNTn0+B
         RDouLVEHHZL1eV4YAypjJP6Fms0AW02hvlTC48yHiMs2chSxR7YDwIeNkmVfv+RM1s13
         O/WmTSxOYssS5LncVbgRzyG9DeAoeZgzuRwsYDg37xAyCUNBqO3TFNJ+t/S9Xojuz2L9
         Rmkuivw4nOtHpN0q6sbsWKK+ZueksUf2sBJkWKhUDRV64HIVExwqt5/h0Za2vEvlEsdB
         MdkA==
X-Gm-Message-State: AOAM532uWk7ccZuAz78OlANYuq74zOrRpR5hjbblrNw/TnABUqSaQYis
        7cR308jpaPjdsxqzIGBp0JAv2bM7NDTBVpg7wCH7RoDpy8wQxXprQnFoGU6T3QDbgrbdxOelGTa
        HeRqdxWjoZIC1r2yoGkr/Qteo4jQDILWnMSmGv6hSsA==
X-Received: by 2002:a2e:96c2:: with SMTP id d2mr8014833ljj.440.1640612177476;
        Mon, 27 Dec 2021 05:36:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxowczEi1Ufuu3a5uE9n7r+scZ4hrAOHPBdBSBWoRBxEBxNhEbBQq3slkbnAQ2d3v3tOxf9Og==
X-Received: by 2002:a2e:96c2:: with SMTP id d2mr8014815ljj.440.1640612177153;
        Mon, 27 Dec 2021 05:36:17 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 19/19] arm64: dts: agilex: align mmc node names with dtschema
Date:   Mon, 27 Dec 2021 14:35:58 +0100
Message-Id: <20211227133558.135185-13-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys DW MSHC bindings require node name to be 'mmc':

  dwmmc0@ff808000: $nodename:0: 'dwmmc0@ff808000' does not match '^mmc(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 163f33b46e4f..0a37821af9aa 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -300,7 +300,7 @@ i2c4: i2c@ffc02c00 {
 			status = "disabled";
 		};
 
-		mmc: dwmmc0@ff808000 {
+		mmc: mmc@ff808000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "altr,socfpga-dw-mshc";
-- 
2.32.0

