Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B558C547385
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiFKJ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiFKJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:58:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E392CE26;
        Sat, 11 Jun 2022 02:58:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id d19so1458357lji.10;
        Sat, 11 Jun 2022 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EvmSxNb00VCJZUQ2SVU+l0KVfBWbEE6iTSA8RECXJz4=;
        b=KL2vg4UZuzy67obhWaTWJBuajSoYfhOQYAY5P4hRszmFJC8cUkSfFCIdFkfOxDwdNX
         z2p6kpn0otvnXicX9hx9BH+SlACWRNzctxinm8fmuus7jwQd5p04Hs7KxDjyKWO+6K+h
         swDNJsxEd1+4+QkaOCSTIV9EvW755XLs/QGVtQvzD/2aI1MmnEL5bFh7qmha+e6L6VG9
         BB9jXUXjbNlOwgw3qAdoV+7NxKVlyiPe2ETe7XGUaq/LyjaqGu1j6J10EvaXGGAmz5ZR
         n/OqlkAMDkcglPYYBzs4QP3xNKgp/AnN/OidWIQFKYZpJkrUC++/ygZ6XpCt3v/y4b9+
         0MPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvmSxNb00VCJZUQ2SVU+l0KVfBWbEE6iTSA8RECXJz4=;
        b=I3QKpWVhlgVl7H8/UHN9x3vpZUYORzF1/4DXnz3w/w84oFQEBerUmkMc/XVCPpKdqx
         knbhEAHxLKoFMcPSf4jvfRpE/pLc4ErNP1d4forT5RTqJB4xRggV3QbZBzxug3oY1EP6
         vnW0PcxCiciehTbr2/RwPK6iJs/P5/euCWnZL+a9HyjtVDNVCSm/3o+c+55cGjCCFlpu
         4bpqAiloXmPHyZOue9OLlJsuZFjNUMXQ+RYNnxy/ycwGZb2pSTfdjxHTu+Ie8+R5TIBO
         eAlMJda1w0Lu0rnRO/xpDwG/h+8Q0wdRUG0ZHe4qIkhqn0h7jLRAebVEjLdVPPnR1aY2
         Y66A==
X-Gm-Message-State: AOAM533Cdb9Rhw+CfKBc5H1XyxDkNiQe2lOvXLmrOl9gCTL6ag7jhUSR
        NiwK8Q1bfWq67nXGoJTIzlU=
X-Google-Smtp-Source: ABdhPJzJ64OHPxj7ndZACeTnIHCmaj+7N9vf4CxAxpRkqiT63+cr41lK9Z7L4j4pQ8QHCZmQ/VIdpw==
X-Received: by 2002:a2e:9587:0:b0:255:6e01:50d with SMTP id w7-20020a2e9587000000b002556e01050dmr26607779ljh.146.1654941529372;
        Sat, 11 Jun 2022 02:58:49 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-90-154-71-254.ip.moscow.rt.ru. [90.154.71.254])
        by smtp.gmail.com with ESMTPSA id h18-20020a056512055200b004785060bad6sm200634lfl.201.2022.06.11.02.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 02:58:49 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: aspeed: ethanolx: Configure RTS/CTS for UART1
Date:   Sat, 11 Jun 2022 12:58:26 +0300
Message-Id: <20220611095828.1090-3-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220611095828.1090-1-aladyshev22@gmail.com>
References: <20220611095828.1090-1-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART1 is used for connection to the main EPYC CPU. Besides the main
TX/RX signals this connection has flow control signals RTS/CTS,
therefore configure this pins on the BMC side.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 889b2fdd19cf..0354a7d8f9f5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -79,7 +79,9 @@ &uart1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_txd1_default
-		     &pinctrl_rxd1_default>;
+		     &pinctrl_rxd1_default
+		     &pinctrl_nrts1_default
+		     &pinctrl_ncts1_default>;
 };
 
 &uart5 {
-- 
2.25.1

