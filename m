Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEBE4E87B5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiC0MlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 08:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiC0MlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 08:41:05 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1CE1FA43;
        Sun, 27 Mar 2022 05:39:25 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id d3so8146421ilr.10;
        Sun, 27 Mar 2022 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOKyTZ0MHbuBrMLYUwj/DaXVPHkzGJ/MdORrc27Sp4c=;
        b=G5i5dsVJBuclAECK6fgs5/2d9WmYJx2BhGGIPWUdWLsVVXQIUKirMMxg0MhIUNRxxT
         WpPRZP5HwlQf2XnpiaGMSsetyB+pG78KbdYjUjvRW4GRfIVV1DAvM+wcAGfRoUyfLGIx
         7nPKbXhOWLk4lmNGrai0T3iDwldkU6T+PetftsM4zkU/kMUbKWb0J9wDUEtXlM4agmf4
         c5jgLEoJhQ4Z0ZpBNbYuXhzQTBE3joBdupHFUJQDxzCTwnsHJGZYJ9zx5tn2zYgYouP+
         EjyGBSurMuzkaxAWdfs89H4zVjr7/CJXiqoRcoG6Jyj2MFlvzSB7zXubkxHsvypQm6dr
         FDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOKyTZ0MHbuBrMLYUwj/DaXVPHkzGJ/MdORrc27Sp4c=;
        b=mJ2Q2SS347K7Iv1BPL1xdxQ/pJSSEu2flZYPqCKkDsPug/QDrCcJ7HuSlTTphP2K1j
         swSHSegSyS+7BdyQsgSjmBQt8WKiMMJnYpAHjnf0Qy9HbKtOeQm/+AuBDFLM4EjzVI3y
         ICkIYACqs1cySRvFMh896Jzvry2gApDO2SyTjDUcp1+9xQtkGS3kuSMduxfMKv2BmGQW
         yizkwzRwYQhbKvMWmLmjuv6Q6u2tTlcL2iur29IGriVfOjEF7YRJAStNkG0KmOVEV+8S
         mftkDq/EISDaedcq09TbeThpCZNyfna6mZKTFvKra4nSSSmnyPXA7eGQw9kpczzzGP9J
         chNw==
X-Gm-Message-State: AOAM5317l/0vyP1APEVyMUz6E2T0sN1obGm5XU71xAPSudeoJWluiG/m
        KNxXMevzOHCW2RVwWRgv9u0/1qddEU0=
X-Google-Smtp-Source: ABdhPJwOgGfZHeF+KeTKAyl5nYTr1kYDkrcxKObLP5Bwz9aT13RyU1bcdXcbD+8aVKW8ijwe+VL2IA==
X-Received: by 2002:a92:cd85:0:b0:2c7:f152:7161 with SMTP id r5-20020a92cd85000000b002c7f1527161mr3380794ilb.265.1648384764282;
        Sun, 27 Mar 2022 05:39:24 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7073:b368:2f66:5e36])
        by smtp.gmail.com with ESMTPSA id t7-20020a5e9907000000b00649d6bd1ec5sm6134534ioj.31.2022.03.27.05.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 05:39:23 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     haibo.chen@nxp.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: imx8qm: Remove fsl,imx7d-usdhc compatible fallback
Date:   Sun, 27 Mar 2022 07:38:34 -0500
Message-Id: <20220327123835.28329-5-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327123835.28329-1-aford173@gmail.com>
References: <20220327123835.28329-1-aford173@gmail.com>
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

The correct fallback for the imx8qm should only be fsl,imx8qxp-usdhc
because fsl,imx8qxp-usdhc is a superset which contains additional
flags not present in fsl,imx7d-usdhc.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
index ec1639174e2e..336f0ea7e7b5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
@@ -13,13 +13,13 @@ &fec2 {
 };
 
 &usdhc1 {
-	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc";
 };
 
 &usdhc2 {
-	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc";
 };
 
 &usdhc3 {
-	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc";
 };
-- 
2.34.1

