Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE14FC0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347996AbiDKP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347893AbiDKPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C588B3BFB2;
        Mon, 11 Apr 2022 08:22:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h16so10155720wmd.0;
        Mon, 11 Apr 2022 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=re3M277LHRm1Y3K/5eu8KfJzK0wKPVbeD/Pm6iYG9cI=;
        b=f0Z1mGbKgalb/bPn7kXOqzP57T9dWmWOCTw5Mw1gMjvDwH+f+CPRPZrmrZlakKfwqx
         Fr20tdO3EgeKYV7pep2fHisVO2iPxxYvXQ+WhkHNw/VthGxfcyeVRF7BGDbCFxfIzmrk
         z0K+39+DnRJJEtIUxHT2Kbgqw1ebfJOyl+AcOgMDlgmpaa1bUCAG7CM9ks21AoCXJl6q
         KK7OPoLlq99GT50BuySsDyw1ok5LvhNUB4fC9hd9biol1Xmc8Jw761WrySFdcBruqLbX
         PbrLZFI/WI5Nvr03SOwIEmXjO9YgiRhli/iV/ONz+MU2K2DdKsBqR5Phui6GfWnsjCQq
         dM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=re3M277LHRm1Y3K/5eu8KfJzK0wKPVbeD/Pm6iYG9cI=;
        b=Gf988KCPBU0XUIdGY0tTeHVjshY+wWrttdO2m0hTYK0BZwo3g1pwOERQHt6nWW4MJ8
         HjjXaxqqQ8weje3SVto0TW8/JVnbXBIr0N6ZgfyRtZ1dFB/xSu2Qwf6+U5Rmi+LHE8Km
         BqflJXGEdP6LQNWKY0k09pp/kKEBdQ7tBDqABsrcC0oX0wO/RrEA2rY58zEkx1H5uQes
         YvORawMrwuo/aoQf7+N6XSL39Gd5Gj5Y2BB7lpK4SUl4E5lmzr2xOy09Jl/wFVPTVAqe
         jqwJDWqEPmm+jWa6zSldK7Bkp3gZMBI+uYhIB7exBiE6b0n1aYYMkL9TacskDQVgKZWR
         YVkw==
X-Gm-Message-State: AOAM530qpJTdvUOV8AwxZ4OUhDMBE3uSUdwgLSMG05GnnlDoHbGSpbCP
        aoxQZlCvKErbR4WnCPXNP/E=
X-Google-Smtp-Source: ABdhPJzxf6vpHzOLfqn5HiZBq1u3+YXnX9XrTjGUSD3udbnOGF9qTiA3fF/PCWwG7uzQXVg/72/pZA==
X-Received: by 2002:a05:600c:3847:b0:38e:8c66:fef with SMTP id s7-20020a05600c384700b0038e8c660fefmr21037202wmr.179.1649690574330;
        Mon, 11 Apr 2022 08:22:54 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:53 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/14] ARM: dts: imx6dl-colibri: Command pmic to standby for poweroff
Date:   Mon, 11 Apr 2022 17:22:27 +0200
Message-Id: <20220411152234.12678-8-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411152234.12678-1-max.oss.09@gmail.com>
References: <20220411152234.12678-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

The Colibri iMX6 HW doesn't allow to use the PWR_ON_REQ signal for
poweroff. Use the fsl,pmic-stby-poweroff property to command the PMIC
into a low power mode in poweroff.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index f6243762e918..da52a71bb6e7 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -138,6 +138,10 @@
 	status = "disabled";
 };
 
+&clks {
+	fsl,pmic-stby-poweroff;
+};
+
 /* Colibri SSP */
 &ecspi4 {
 	cs-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
@@ -403,6 +407,7 @@
 
 	pmic: pfuze100@8 {
 		compatible = "fsl,pfuze100";
+		fsl,pmic-stby-poweroff;
 		reg = <0x08>;
 
 		regulators {
-- 
2.20.1

