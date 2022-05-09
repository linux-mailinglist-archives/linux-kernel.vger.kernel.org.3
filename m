Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6F051FB0F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiEILQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiEILQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:16:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECF21A8DE0;
        Mon,  9 May 2022 04:12:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so15846711edw.6;
        Mon, 09 May 2022 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AY6g/ZhZfipKpiYyh+8cNrhHXBB42b61bndOdnGfSCc=;
        b=pstK1smtSludAPv9C9P0xpgfLTs/lDHKKwVEdJROLAREi4w2AQwVddZiIgA3K83TIM
         pLExQZcTbBY1xPN1hv1wSm9QwdMsEiF+H/nh0WhKJa3WKTVcBZG/OPaecYo+RcExnRPC
         AP0h4UiGw6hwPeYSbET1Zf4+z3vo2xYKDWK9Ei/twt0IHl7NrcSMO3Ry6DJC9prii9EX
         pGiiuLHcYYBtjYqvtBSH7xIpQuX9Jn+ueNUaHqPtXC5UY6+6kGCNPjfRXP3v8hu8C5w0
         +R3YjQEg6pEEMWTPGHfLzBiYTdJVCP8kllR61j9n0u+kzrmLmZO1AUCEflQ1zJHnhei8
         LJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AY6g/ZhZfipKpiYyh+8cNrhHXBB42b61bndOdnGfSCc=;
        b=pQRZuHcPtVhNwbGMDlTE1BJez8vl8mmugd1cB+L3ZbOK+J+W8Mx76ZIB3z8LKas3H+
         DYf3EkB0X/qbo/q6zZoRNso6cbJQPUbJpKYQlZEWRdEAu7BFuue6SM/3QxDlecuapMCN
         c37n4Hbu12dtno8BCgosM1rCE3v4VTUYYetTXsmCjDkQZ8d+519yF/csL2lBb12Tx5v+
         mmsg/Fx1nDEGYX1PU3ZvXiDde6AIEW4c9i/qQBNcihBBTqgzdINUZfmLazlFomryPmEn
         fF6r+iuilS0v8GGrsYe60SSgillGYbs68TqhtOs4QYYTgZQD7epHPBaarP0Wg/BaNe9s
         2taA==
X-Gm-Message-State: AOAM533dgVUkkkrqUaT7Ay2VB4wf3QqYFIbDaQEP5DGTrtVMrR99mDNn
        GHeENfS9oLfmXKoANGR0/VU=
X-Google-Smtp-Source: ABdhPJzeHuJyREYnVpUbP6n06Pp3xusYm/ued/plBy6ui3ChmQrNnOs7xUwMo5iFZczpeL5IeBuBXg==
X-Received: by 2002:aa7:ce87:0:b0:425:d88c:bc92 with SMTP id y7-20020aa7ce87000000b00425d88cbc92mr16991455edv.147.1652094726151;
        Mon, 09 May 2022 04:12:06 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id c24-20020aa7c758000000b0042617ba63b4sm6075672eds.62.2022.05.09.04.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:12:05 -0700 (PDT)
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
Subject: [PATCH v1 1/3] ARM: dts: imx6qdl-colibri: Fix capacitive touch reset polarity
Date:   Mon,  9 May 2022 13:11:24 +0200
Message-Id: <20220509111126.7032-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220509111126.7032-1-max.oss.09@gmail.com>
References: <20220509111126.7032-1-max.oss.09@gmail.com>
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

The commit feedaacdadfc ("Input: atmel_mxt_ts - fix up inverted RESET
handler") requires the reset GPIO to have GPIO_ACTIVE_LOW.

Fixes: 1524b27c94a6 ("ARM: dts: imx6dl-colibri: Move common nodes to SoM dtsi")

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index c383e0e4110c..7df270cea292 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -593,7 +593,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_atmel_conn>;
 		reg = <0x4a>;
-		reset-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;	/* SODIMM 106 */
+		reset-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;	/* SODIMM 106 */
 		status = "disabled";
 	};
 };
-- 
2.20.1

