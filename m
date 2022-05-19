Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88B952CD91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiESHvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiESHvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:51:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A40B237D3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:51:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h5so4765827wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cyCpX1ZmR/kf8pzgbwKyX7fP0Ivtmtw9DDuTffHF0T4=;
        b=mRbqHyr2HlEx8B9iL3PZn3B6Y/2EcOxqC7Oc10pNva4YC9BpH4UDUlJCXjzUeDYIuj
         ZpwOOGPe3exSHd6UMinRc2gLRx4/Z9ROf1Q3HTj+wc47ub5Vfc76ldTgKnxBc0wS7u7j
         bI1bfWnvn1IYn1pr1W4bAMW+UBN1nm8wBCgRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cyCpX1ZmR/kf8pzgbwKyX7fP0Ivtmtw9DDuTffHF0T4=;
        b=Ee9XhkYrf7Umq74YEhdjb9UHnEYGHCt1HFoceNL+YVYatECHp+XM/nec8kUSSraFF+
         rAQYyS9QS9HvG38gMYsu8GdNi5juX80PY1nekB8ubiCsq3GkURK/WhfsN+orTmoR1fsY
         +yKrGWjvPerGwlsZiKdKgcJ3u9dqbCm+s1SHjLfyy0sQekQhC7Bs7me1w2k3qJ6qRcyM
         o+c1UxqP+E+MqzQ1bTZdCg1tGkPqrpIRcoyDIXA4dirgk39w4HJMGdng4zcdDzZ+9Z/A
         YWlZbPAKTP0bIHV41ULOsvELlU3qxeUv956HEi/Rku08GBPIannL6Ywvruio1FEEuTy8
         MY8w==
X-Gm-Message-State: AOAM533ssJZ3yst6lu0yBHJZ2XAcgIn9EYSJ3XdrQip2iSa2auKTwzgQ
        5fe5V6GIstTBwNMl/Wytn7ffcw==
X-Google-Smtp-Source: ABdhPJzEJ//yF1pX5Q/0fs/Nw2UrvupH4A6Tv5qSwJnPr9e0MfJTTN+XjNenDXGXnNNXvzBojuMQag==
X-Received: by 2002:a05:6000:1a87:b0:20c:687f:6d10 with SMTP id f7-20020a0560001a8700b0020c687f6d10mr2791038wry.574.1652946688579;
        Thu, 19 May 2022 00:51:28 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-53-154.cust.vodafonedsl.it. [188.217.53.154])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c4a0600b003942a244ebfsm3370254wmp.4.2022.05.19.00.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:51:28 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     tommaso.merciai@amarulasolutions.com, linuxfancy@googlegroups.com,
        linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: rockchip: px30: use rk gpio naming convention into reset-gpios
Date:   Thu, 19 May 2022 09:51:17 +0200
Message-Id: <20220519075117.1003520-5-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519075117.1003520-1-tommaso.merciai@amarulasolutions.com>
References: <20220519075117.1003520-1-tommaso.merciai@amarulasolutions.com>
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
index 0d05a1b098bc..07008d84434c 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -450,8 +450,8 @@ ov5695: ov5695@36 {
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

