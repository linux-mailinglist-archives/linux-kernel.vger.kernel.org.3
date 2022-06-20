Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF565521FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbiFTQNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbiFTQNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:13:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A3201A8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:13:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id o10so15811041edi.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJmJdj8nRClod9Z4u/Y8NwaNKFRU93bJiGvbGJuwavU=;
        b=RQlUd87epecEzei0t79oGeBMIiZR0/2tJfN9XXH5QN+MWfxEEJ6fre2RI8xOublN3M
         A5k+kQ3BfQHHLQ/+xDmzKeA1eRBp3+VM3SwU9yix5WkOTOVf25Ppvu+Q64N3wAE1Del2
         UMoEPmd63bBjTdk6Um9vFvIaZX8eJMnYP4Hp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJmJdj8nRClod9Z4u/Y8NwaNKFRU93bJiGvbGJuwavU=;
        b=c0P+pciV9wjYbqiBneK5pDnYPKMKxb6165/7v65HCLTCDoi3xx43GBeZx+MkWIdwNf
         Z1jlQ55iI4j6WiFUBFLAKeB8L6wT+5w+YcNDK50V9GzfwvFEd8HUs66CSlRYFduGRbfz
         JOvdUYzbJGd6Ern9bClB6SP7XCVAIOgUcl3O9Dxnb2LEltOQu9+ArFO4N9+OYhUE4RtK
         sjDPY0yL1Sk+2z+01pNzjBxw3FU5uMiDNu6e3m5FDlLCvpKLq7QWYmqRi4y8nFwF7FcI
         KP9721/6Wk0ZkUQ8fyJt4ZkiiHViAxa0QkpMRCD84PiRUH08QIlIRfxejIEUhzBLSfuj
         6jNA==
X-Gm-Message-State: AJIora+KjmplPYcmXOoV3U3tF9OI2KWjuMQBkayTA2ISU1CvOmDs3lGw
        pp0+hILmfCLbN/n42xBjnt3kOg==
X-Google-Smtp-Source: AGRyM1v2E4EsdSvTyCjiSPb7XU8YdefsrsLd6QxRC9ZwWvG54o42T1cmj7ikK0ag4dtck5lD6BN4eQ==
X-Received: by 2002:aa7:dcc1:0:b0:435:5db1:c749 with SMTP id w1-20020aa7dcc1000000b004355db1c749mr22894260edu.124.1655741613213;
        Mon, 20 Jun 2022 09:13:33 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-55-189.cust.vodafonedsl.it. [188.217.55.189])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090653da00b00706c1327f4bsm6209772ejo.23.2022.06.20.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:13:32 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        jacopo@jmondi.org,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: rockchip: px30: use rk gpio naming convention into reset-gpios
Date:   Mon, 20 Jun 2022 18:13:20 +0200
Message-Id: <20220620161321.1898840-4-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620161321.1898840-1-tommaso.merciai@amarulasolutions.com>
References: <20220620161321.1898840-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rk gpio naming convention into reset-gpios of ov5695 camera

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Tested-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 arch/arm64/boot/dts/rockchip/px30-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index aee7fecdfc15..bc59a5588ea7 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -449,8 +449,8 @@ ov5695: ov5695@36 {
 		dvdd-supply = <&vcc1v5_dvp>;
 		dovdd-supply = <&vcc1v8_dvp>;
 		pinctrl-names = "default";
-		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&cif_clkout_m0 &mipi_pdn>;
+		reset-gpios = <&gpio2 RK_PB6 GPIO_ACTIVE_LOW>;
 
 		port {
 			ucam_out: endpoint {
-- 
2.25.1

