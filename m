Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D14E87B3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiC0MlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 08:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiC0MlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 08:41:03 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB4F1FA59;
        Sun, 27 Mar 2022 05:39:23 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9so8138893ilu.9;
        Sun, 27 Mar 2022 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Db2FgafGdIhiWGFMVMPKe9KlxkIGLYfI01dwnul3AK8=;
        b=UQn1hkvuN4yYBZysacrXMzgOjFCbxMf2DfmKbgjl5Rg8v4ybdjp/JZCc+fvt8GjvyZ
         2vHpbG98OiAAVlGkI3UVwaPBnos7OCeEkPWT51fZA8yRcBmhjfzFXol3md3KSTU2xEqo
         Lj/i/uiPIXKsZTDOsZTK+w0XIFJovcf4MoFn7ESzsm0+sA0s+YqHnY7NX0xTIv0tMOvJ
         TQcJjJFzNrFU0GiNW4T3/wS2YFR5oEajuCQ6B1mzwxKZFYA2go6fnSqZLF+1s8GcpK6p
         1aCOO/qVyUtEag/KFUF2ufErJTUdg+gYJdN3T6Twmp/z0WAn0QYnvwixPE7ddEiT86aJ
         +Szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Db2FgafGdIhiWGFMVMPKe9KlxkIGLYfI01dwnul3AK8=;
        b=pgTjs/0n1uvl1ur6j0zvwH5C/TO5xRuUzo/eXS5EWR/3a8EOUWyOJyXr+bFn7XBnXF
         LOLAm3B5EpMxSbe2fjtcGNoKC1s4I3S/RoD8HZF8QN+kfpnP4J3ouOrFnAGPLjwBh3yq
         DQCnjvweKbFdp/XLVo6D5JIDEcyt/uC/LbZk3ZIlHAIIXGiANGqqu7qqMjuDnccXIQjX
         yqkbLD58xMhdEWi5iLY/YHdBsdcnrbmVdGIMHrWpWEvSKGW+PkSnQaPP7Ak7yn/aIPb7
         cs2iAo4tzxNFpJmFFodCm0TNPA5KmRTBLH7ZabNrSr39PirOtypU4FRPGZf/dicN6+ba
         yq5Q==
X-Gm-Message-State: AOAM530az7Mpix3pKjxfh8Sp7Mzfbiw8oPDpG+7wXNPKDAQHbwCZC2dT
        nedeeROLPYPQxlZy3BhsZvd3zoCd7o8=
X-Google-Smtp-Source: ABdhPJybUAAqFZNNiE14C9c+Svi9NSPW079QGvVzWsq5MFjow7kiB4/68j70romv42SMobrvWhgoqA==
X-Received: by 2002:a05:6e02:783:b0:2c8:4fe9:5e74 with SMTP id q3-20020a056e02078300b002c84fe95e74mr3511131ils.148.1648384762446;
        Sun, 27 Mar 2022 05:39:22 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7073:b368:2f66:5e36])
        by smtp.gmail.com with ESMTPSA id t7-20020a5e9907000000b00649d6bd1ec5sm6134534ioj.31.2022.03.27.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 05:39:21 -0700 (PDT)
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
Subject: [PATCH 4/5] arm64: dts: imx8qxp: Remove imx7d-usdhc compatible fallback
Date:   Sun, 27 Mar 2022 07:38:33 -0500
Message-Id: <20220327123835.28329-4-aford173@gmail.com>
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

Since the compatible flag for fsl,imx8qxp-usdhc directly matches
in the driver, there is no need to fall back on the imx7d-usdhc.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  New to series
---
 arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
index 46da21af3702..75fc951bca25 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
@@ -5,15 +5,15 @@
  */
 
 &usdhc1 {
-	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+	compatible = "fsl,imx8qxp-usdhc";
 };
 
 &usdhc2 {
-	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+	compatible = "fsl,imx8qxp-usdhc";
 };
 
 &usdhc3 {
-	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+	compatible = "fsl,imx8qxp-usdhc";
 };
 
 &fec1 {
-- 
2.34.1

