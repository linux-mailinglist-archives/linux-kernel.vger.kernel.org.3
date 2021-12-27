Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D04847FD95
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhL0Ng2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:36:28 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39684
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236828AbhL0NgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:36:13 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 69B713F32C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612172;
        bh=umuAKwTKb8yE9WwkqLjV1NuEa+crhr+K5jfCriD9wkk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IsjLeVaJpf5cnPlhiNzDbxTAxDi8yJubj+mvpOktplBKttSOJSzpIsrkfkQtmq1R/
         4ZeQ4VLChgK5EI9TnLqRJJqZBrLdB/aXlGTzPIEkdsrhyT8JMbgk8GqoZA8DtRsbIv
         KGHSdhjMbDSuh2o9Mo0Wj0cCs1n5WnTlYzhaVFFbqpFqE/0xvEjs1WSLJhLoFEp4K8
         TUf2LMh56ul+5dIrO0SqJ9O9rZ7d/EGWo9a3P9lig7lPp0w43uyUwC2NBrZ2tKYw3S
         iIZMnyExcFJ5SWFCt4TJlvi3tmgTM/fzGwIkyj9anwZqIxZXGesFG8tyFTR3eFjkzN
         Trdx1xG4QxTBg==
Received: by mail-lj1-f200.google.com with SMTP id n6-20020a2e82c6000000b00221698ffa68so4977102ljh.17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=umuAKwTKb8yE9WwkqLjV1NuEa+crhr+K5jfCriD9wkk=;
        b=O0t9/cmAkces+arBCYnhYr0v70eKQeUWs9khTeWP5b5uv6Zj6ELXsC2pLBD/BnQSPH
         X0C5Cf94RqPNA9QcSC+06n8neap6G+ORgvXhQkmtIhcYXoKmBPcJpRFXey6/RqGvfrBV
         +tt0hKyjvwaUuDmm8n4HkedEhWNWXgkXrVPQmFleiAlRCSAyzTtQNmBu+IiVyIqTRu0j
         951KUTe1coqshfHg+Xg9Zr/Bl9m07VX4bQFRZIRUtp9/wyBppSM+vfe+lc6r4f2wzuhV
         zCTMXG2nLTZVkecOZ5MILARwK6ybpCgtfm/0HFJhSBbQDtkK8pIS3xKXKz3gNCwOAer0
         BLpQ==
X-Gm-Message-State: AOAM532PHn7Lmqb8y7hZqsrX2OFQvMcyRuUfv7ib9I8icGtkfml5KKvD
        9ErlGpShzDDf793paiRrPFEBVbI/Iy8HOWAYj+c/GAxLmDsksJQ/YnG9MIPVV6DAjxE/IUDsXEd
        dGABb2Y5saHKcAUDrmKPtKB7nuBhjYpctrDPsgtLRcg==
X-Received: by 2002:a05:6512:261e:: with SMTP id bt30mr15698662lfb.264.1640612171935;
        Mon, 27 Dec 2021 05:36:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznmc55u25BPLIRmeUc9OTW96YVQXWBrEmbf8C7hA3D8nLWO+K/o8U3VPkvvw7Nyo8EcVLSrA==
X-Received: by 2002:a05:6512:261e:: with SMTP id bt30mr15698647lfb.264.1640612171774;
        Mon, 27 Dec 2021 05:36:11 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 15/19] arm64: dts: stratix10: align mmc node names with dtschema
Date:   Mon, 27 Dec 2021 14:35:54 +0100
Message-Id: <20211227133558.135185-9-krzysztof.kozlowski@canonical.com>
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
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 4a527d614ee5..eadc81dfaa79 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -296,7 +296,7 @@ i2c4: i2c@ffc02c00 {
 			status = "disabled";
 		};
 
-		mmc: dwmmc0@ff808000 {
+		mmc: mmc@ff808000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "altr,socfpga-dw-mshc";
-- 
2.32.0

