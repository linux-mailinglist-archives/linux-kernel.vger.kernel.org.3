Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC95200E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbiEIPSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiEIPSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:18:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515AE26551;
        Mon,  9 May 2022 08:14:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id iq10so13445026pjb.0;
        Mon, 09 May 2022 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WgTLqnT/JdnofY2i4XQH1SFV76qGHBZFSCrNzgW1auA=;
        b=c6RjhM+eU+MdKYm1EbTwR/F/uIdwLFMaMafEleB61+8905fo4Ws4/h0DXoTOWn3OlT
         bgiBm2lVrpBki9Afh5UN2CnDirmmlMQvT/YsevMSIvg1uQn1C5DXPi2cf2lldklRwMeK
         tgnADUGNwHQ+IS+VvCHkh/dJP+r7oWLfgk30tUwi4ScP1BoG+Eqv6Qa9n8znn8kh2tt/
         sgCcRdgigUhuFWb6UJJYOO+l6kl7A4FyZajnDevbZBSBg40hEVgba5xqdJTzp8I1kzt/
         f3qTyCTrIMjMO+lUq03M4H9cZiokR+zpnY8NJ0f4K78wVmLvcH1jXD2cQz+zV3kgtrN0
         fyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WgTLqnT/JdnofY2i4XQH1SFV76qGHBZFSCrNzgW1auA=;
        b=43tCON6VeYZWd2A+WXCnVQprN2nzpdlrqmm0N078EFnNKve3vurBrz/fMLvGO7ZBow
         sgDUd36aDhHz6uS0ZJfuw73fQmGNDS3Y9ZX4Xl3ApE/CXD01PJQd83mLea4IAIJanmSt
         GjgEem+kCw/ajSXhJP/NJUk4XWuXbnjseW2gXe6W2nfJdUk80m9FVE78bTPKrVqUmIry
         ZMsm2i56IolTKU6A923EZtPtcKXRfZfqTTIjZkSArOI/4wunsMOXN8rAldbw1icgySq0
         wws3Hv0o6r9HWWxG5E8KoDoaIW+pegbDxliHuG8Oi3NvStulLrV0HuPFe0Rnu4D1woI2
         hNjw==
X-Gm-Message-State: AOAM531aRgXYAge5ow7gQBYWXoF62zee1vcXxVmI+fUh5HDXM6+OVRYp
        dv/bcHRkhenMAv74TImt1zG18AwpdMr7drli
X-Google-Smtp-Source: ABdhPJwebWEyxOLv9FykzklIKPAvvcDSsglFgYv7KURzSwboPnqYQrxbbtnp/S0Flcdwfoxp1wA7pg==
X-Received: by 2002:a17:902:6902:b0:15e:a439:82b6 with SMTP id j2-20020a170902690200b0015ea43982b6mr16604718plk.76.1652109266595;
        Mon, 09 May 2022 08:14:26 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id k7-20020a056a00134700b0050dc76281b6sm9221596pfu.144.2022.05.09.08.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:14:26 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 5/6] ARM: dts: aspeed: bletchley: add pca9536 node on each sled
Date:   Mon,  9 May 2022 23:11:17 +0800
Message-Id: <20220509151118.4899-6-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509151118.4899-1-potin.lai.pt@gmail.com>
References: <20220509151118.4899-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an ioexp node on each sled baseed on DVT schematic, address at 0x41.

P0: SLEDX_SWD_MUX
P1: SLEDX_XRES_SWD_N
P2: SLEDX_CLKREQ_N
P3: SLEDX_PCIE_PWR_EN

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 49e4b9f63a28..b30986e7cb41 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -253,6 +253,17 @@
 		reg = <0x4f>;
 	};
 
+	sled1_ioexp41: pca9536@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED1_SWD_MUX", "SLED1_XRES_SWD_N",
+		"SLED1_CLKREQ_N", "SLED1_PCIE_PWR_EN";
+	};
+
 	sled1_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
@@ -323,6 +334,17 @@
 		reg = <0x4f>;
 	};
 
+	sled2_ioexp41: pca9536@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED2_SWD_MUX", "SLED2_XRES_SWD_N",
+		"SLED2_CLKREQ_N", "SLED2_PCIE_PWR_EN";
+	};
+
 	sled2_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
@@ -393,6 +415,17 @@
 		reg = <0x4f>;
 	};
 
+	sled3_ioexp41: pca9536@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED3_SWD_MUX", "SLED3_XRES_SWD_N",
+		"SLED3_CLKREQ_N", "SLED3_PCIE_PWR_EN";
+	};
+
 	sled3_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
@@ -463,6 +496,17 @@
 		reg = <0x4f>;
 	};
 
+	sled4_ioexp41: pca9536@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED4_SWD_MUX", "SLED4_XRES_SWD_N",
+		"SLED4_CLKREQ_N", "SLED4_PCIE_PWR_EN";
+	};
+
 	sled4_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
@@ -533,6 +577,17 @@
 		reg = <0x4f>;
 	};
 
+	sled5_ioexp41: pca9536@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED5_SWD_MUX", "SLED5_XRES_SWD_N",
+		"SLED5_CLKREQ_N", "SLED5_PCIE_PWR_EN";
+	};
+
 	sled5_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
@@ -603,6 +658,17 @@
 		reg = <0x4f>;
 	};
 
+	sled6_ioexp41: pca9536@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED6_SWD_MUX", "SLED6_XRES_SWD_N",
+		"SLED6_CLKREQ_N", "SLED6_PCIE_PWR_EN";
+	};
+
 	sled6_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-- 
2.17.1

