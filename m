Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1459654674D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiFJNZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiFJNZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:25:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73788D69D;
        Fri, 10 Jun 2022 06:25:54 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id p63so2681436qkd.10;
        Fri, 10 Jun 2022 06:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sukDbyEo5xcdDaL583IQTHCCE/whgVyUt9NY9aiWLE=;
        b=UCfkLISXPPSYeSjgGZqDfO+y4Neo+B81CIy6P9OkISnZ5tfbMX1tV5EYKqdjTLq6Ok
         RjXUQnH/Skkm6QY1FK/5Latq0i0AeCYBRql+WgmofSHUA7/ffM4qzOktdTG8PEac04YD
         csjJBUciYDdQ4UqKHkWFXNm7Z8N/Prng/BFNo+iTJ8teVXsHvCqPr5JrP0bqlfbne+ZB
         KQW8Zp0G2x+lK3HPi2ISQv31gP9SF8DO1vadvsYZF2h8rXxO1c7lzAGV389I1YjzB0DR
         i1p3vRetcWlWZOqRu8Yb4Yj+fPbYwkwbsPmqivBBQEDtPG04PQF5M8ub+ZBPgYphWYLI
         Nc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sukDbyEo5xcdDaL583IQTHCCE/whgVyUt9NY9aiWLE=;
        b=zYBD2aEQ623RnZP+x4c9WNAvS9FEgek9sRQosrm0tb2eo+gqnt6Kr3yN1PEtMG567t
         kQov228AiD8wV0TW+dHskmh4bQLEEQgIT9yHwJtbVtrZdP3qwD2Sp9pVi+i6n+MLO4VI
         sPTBH45jkENMfxgbznKJ3e2s/w9Xi5m3Uz3dBM4fRJEsmaqVpIcca1dYL8qrxAojyDxb
         pKKGnNLK2SN2YMZijY224KzbRw3DUT6LFhkLjJsOX/e7WnGVUqOXJBC2TRCRAV4WlnlV
         deIYseXN/NYJu5+BpDQv9D7wSt7w9CN8BNSM/8Rf2rqkPlirATJrdtyerw52Ux8EJNoX
         6NOA==
X-Gm-Message-State: AOAM530JfVu2GWO23z2fGkZg3/CAMoIv350ibq938h2oSw9EfqsZ35FG
        ubrOkV6Xg7uSpjg8htEPUbQ=
X-Google-Smtp-Source: ABdhPJwtF6VIFbozwGhPH9J0MR6+fnBYBm7qIbwqC1jbHL9ckpuXbik1TffFWtfH1rLe1Upf4pRhyQ==
X-Received: by 2002:a05:620a:4107:b0:6a6:deea:ebb2 with SMTP id j7-20020a05620a410700b006a6deeaebb2mr12362586qko.245.1654867553832;
        Fri, 10 Jun 2022 06:25:53 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id ay7-20020a05620a178700b006a73cb957dasm2886594qkb.20.2022.06.10.06.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 06:25:53 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Fix Quartz64-A dwc3 otg port behavior
Date:   Fri, 10 Jun 2022 09:25:42 -0400
Message-Id: <20220610132542.159978-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The otg_id line on the Quartz64 Model A is not connected to anything.
This prevents automatic selection of the dual role usb port. In otg mode
it defaults to device mode. Force it to host mode to retain previous
behavior.

Fixes: bc405bb3eeee ("arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x")

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 1534e11a9ad1..fa953b736642 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -687,6 +687,7 @@ &usb_host1_ohci {
 };
 
 &usb_host0_xhci {
+	dr_mode = "host";
 	status = "okay";
 };
 
-- 
2.25.1

