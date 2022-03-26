Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D764E806D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiCZK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiCZK3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:29:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143852F008;
        Sat, 26 Mar 2022 03:27:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id pv16so19793609ejb.0;
        Sat, 26 Mar 2022 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJNCNvpGXaKqAIHCO4xhB5jgrMlxJtcGqvg3RJwepb0=;
        b=e5zTOtzJnmdhJkaAaFuUx/AE7i2r+pjg25hvt7Q9BAm0aLXz+Pya5CERaYqqHGe/U4
         m33dcJci2qtdSm06qzqu2A7KnvKd6A3hVj6+orDhWN3ZS3hZ/vhSMy7ZkB/ICDhdYBel
         e54GubObSnz6MFNTiIs7JBh9Tycvf0LKiLvVTn/cPvyM762L6vTf5EOi02nTcy4cb/ys
         qdESkukJXCQjvSWoRkb32/ZQHb6geFATHurqumVCr+iIMUrBbyVOdePlFA17WpUgc2HH
         0FtsX4YWiokgo/+1qArfyU1pdMeMbozO/pOIPV1kB+m3KNfMa71XiBJwMbyYuSRiuo+x
         8lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJNCNvpGXaKqAIHCO4xhB5jgrMlxJtcGqvg3RJwepb0=;
        b=1y69HvImrInVPx3bSAAm9vf3YImotZ8rf151tMNEPykKyfXy39TWde/HI9UWoIp5Vj
         TX1c15IJam6Y2CDJawcjRag4XM2GmIyod6rQhjDZT7LBkSOs5swXgJjOEOpq3o3jFNva
         mCnzYN6JQEGJhXFDAPb9h4kIDHrVM04+WF1zycnOPkMVIdolhQJuuEUAl5+/uyCXWV9p
         5t4hY4QuVWU5ewxydlY2pVQSWOnG2Owj4y9GUpUVz8Bo+F4fB37YsLgWuyfLQKCQe6yP
         VHPb87utV82QwAnsEp83rqtB9a9sWoJjVCsgzJv6aVLdZ+5acxMAIJxJavxAX/u0KPIB
         r8IA==
X-Gm-Message-State: AOAM531Par1vYIxbJYuhcekzrDwg3naTLCsyrrtI4/erwLRt/y8Fb+eB
        yi0k+bdfe2gyPEvK4ANvRos=
X-Google-Smtp-Source: ABdhPJy0S/ltddHS/J3q+F7pW5ZG5TpKypxxoNl0N8StWaIdHuTYgh2FBFDRufdwyts3L1HsOZiD8A==
X-Received: by 2002:a17:907:1c10:b0:6da:6316:d009 with SMTP id nc16-20020a1709071c1000b006da6316d009mr16427209ejc.621.1648290442568;
        Sat, 26 Mar 2022 03:27:22 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g23-20020a17090670d700b006ccfd4163f7sm3209021ejk.206.2022.03.26.03.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 03:27:22 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] arm64: dts: rockchip: add clocks property to cru node rk3399
Date:   Sat, 26 Mar 2022 11:27:12 +0100
Message-Id: <20220326102712.20906-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220326102712.20906-1-jbx6244@gmail.com>
References: <20220326102712.20906-1-jbx6244@gmail.com>
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

Add clocks property to rk3399 cru node to fix warnings like:
'clocks' is a dependency of 'assigned-clocks'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 01c08a2aa..16fc6e5f1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1426,6 +1426,8 @@
 	cru: clock-controller@ff760000 {
 		compatible = "rockchip,rk3399-cru";
 		reg = <0x0 0xff760000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.20.1

