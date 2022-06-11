Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09745547386
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiFKJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiFKJ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:58:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F61DA57;
        Sat, 11 Jun 2022 02:58:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i29so1974839lfp.3;
        Sat, 11 Jun 2022 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GocDLkOsBawPMPs9zxnh8PppBX+pbvR6afOC4S31yoY=;
        b=doW1z+6hB6tGbJaAuf6+XaOYEYEK6Z4PL2eTxqpdP4QCs5ULJq/efSF+oyq3Kta73a
         RVY49pzTCOeqGp2LS6PbBst7Rm/T4MNaqJL8E3G3mZAAtkp5WzS530bJOiLOSArgenC8
         gHV4237SNtmyRZ7b7r8cDqRJpLkrhoSahvX5QAIoCTISXslz3wYp76JIYw1R6ie3ktDe
         BaGh1hECtRYvyqmJ6kUoCAymsjbX0HnxzyBXrv8AZ7lOvN70LG1lfwzAyycdkyCdmQAS
         pUA9Yh80WnXbf2V/dDnvUiHsU2kkMQXyMVQV7bm+IvSR/YbbQmv3os2P/pnqg+oxjM5x
         9/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GocDLkOsBawPMPs9zxnh8PppBX+pbvR6afOC4S31yoY=;
        b=0SppDqUB/7m23GB/tHzihH01lgZ9tEzQgJwBZ/arZJYPZo2MnEe7BnQfINRt+Shb3M
         zWe80ArrljkcPiGj1/gV+YCdvrWR2WPrslKE4yIcv2DMhRhiGBduazAH/rjf0wBMLoXV
         2GT26iZWUMhnTyJToa01jsz9oI6ewdk0/SQUNbZu2xLRUmwMVJcr2gMnj0FoGvGyg43/
         0l+wmFrXDOWT9SGLCPwf3cj3STdDe4DDSe7+T/Nt+L8XlKTSVTHX5nASEZIp8ggYxRiK
         eqpCiAEnslqFevGmG2IyWapFr/q011CkRrjbVvB+7jZtZKlQxSpGH0is7apgsjtrwbzt
         omVg==
X-Gm-Message-State: AOAM532vxyCz2mh9PkrFgm81sOndAF803H1NnRDN1Uq7MD6BWZ2hjwKy
        6hq60+vZzBsuFd6TKG5f/0A=
X-Google-Smtp-Source: ABdhPJz7uF0meF9LfuCvFt6ei/jXgipBVoJLu6+lz1yX8HSTxLLS96KPAaoJdHDr0fQ15JO+Vjj15g==
X-Received: by 2002:a05:6512:b95:b0:479:65bd:ac2f with SMTP id b21-20020a0565120b9500b0047965bdac2fmr13223105lfv.445.1654941532235;
        Sat, 11 Jun 2022 02:58:52 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-90-154-71-254.ip.moscow.rt.ru. [90.154.71.254])
        by smtp.gmail.com with ESMTPSA id h18-20020a056512055200b004785060bad6sm200634lfl.201.2022.06.11.02.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 02:58:51 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: aspeed: ethanolx: Enable VUART
Date:   Sat, 11 Jun 2022 12:58:28 +0300
Message-Id: <20220611095828.1090-5-aladyshev22@gmail.com>
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

Enable virtual UART for BMC<->Host communication.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 428fa9f673f9..90feac5ec628 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -5,6 +5,7 @@
 
 #include "aspeed-g5.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "AMD EthanolX BMC";
@@ -264,6 +265,12 @@ &lpc_ctrl {
 	status = "okay";
 };
 
+&vuart {
+	status = "okay";
+	aspeed,lpc-io-reg = <0x3f8>;
+	aspeed,lpc-interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1

