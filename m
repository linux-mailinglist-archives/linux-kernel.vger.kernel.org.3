Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF9B53E793
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbiFFQae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241783AbiFFQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:30:28 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ED6331C08;
        Mon,  6 Jun 2022 09:30:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id h18so10530633qvj.11;
        Mon, 06 Jun 2022 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uj9IThCIXw7MmlitWv/kpBQW2fnYrdG6q6L4yRpNXrU=;
        b=WSVHIJ2V4JVxNIpNbF02Y5N3cY/ORPB5W+ELXtMq3RlArA3/Ww9ebxkySarX1fiif+
         7yylsTlypXMbeWEGDFghk6egHH7zdc0OSmIbakyDwbdrr0kSeE3J050dxn/5Kur9zZRt
         y2TsdrprBjIMiRcfbB9oe5yDSxWx4FtJwu5CF0zhY0k+Swv1Aerdlbsv08r3KYZ/yA5f
         IkdhXVaBROswnx1lMCPn1CESZ1ISHWOMpGlGFhA0h7j+pZ63oddoVWlpt77GshKpVGyq
         OMzQfS+8rqs5+2bKTe0vPAGKeToLstintiQMRgdM1yGz+KoP53W4U4LU6gqxghhjkqk7
         kPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uj9IThCIXw7MmlitWv/kpBQW2fnYrdG6q6L4yRpNXrU=;
        b=J2vkMUKMEJFH/+27b6g52Cia3V/weVQY2vs4l9NssBb4rb/ukvZe72giWXA6Xxi/pg
         aeHdlWxi59Js7qgwVkknYMBb1u8j5khb5RH0rXUUK4HwRCbBe/8690A/RRxZ4AMgwC0F
         fhohk1XV71Qaj5VsmiZV+O+4LzCdpIVep4fU/YQseAFCQCgMhd/5dd7EtyeIEcGVs3Ta
         q2h0bcd5nSFbl4xqogy/j6P0le/+lHo9i7a7pOcJZtKgHLNeAvjR0ytv0DrL2pEoMa6I
         Bs2amYUv8TsA4p6432eL9TCWr0lDiddWC2ZGkhvuffAYbi1Gav5Zs5o5oUNdOILNDDPX
         2Cqw==
X-Gm-Message-State: AOAM532kzbJxJlr4tfZ5/laMqlCeg781dO70ONKu+4CemPPlaXeroBvM
        zW2KCsQj9Z9tnDVrl/bMrIM=
X-Google-Smtp-Source: ABdhPJx8DcER+KpdwW/dNyTBFgzXFRCtviHEu5OoAfCgnM6qWGz9mtUpn4YaL1thxkL4dgUTEWOY0g==
X-Received: by 2002:ad4:5fcf:0:b0:467:dc87:82ff with SMTP id jq15-20020ad45fcf000000b00467dc8782ffmr13728091qvb.14.1654533026466;
        Mon, 06 Jun 2022 09:30:26 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id bk3-20020a05620a1a0300b006a6ba92d852sm3329789qkb.83.2022.06.06.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 09:30:25 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Frank Mankel <frank.mankel@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Fix ethernet on production Quartz64-B
Date:   Mon,  6 Jun 2022 12:30:23 -0400
Message-Id: <20220606163023.3677147-1-pgwipeout@gmail.com>
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

The production Quartz64 Model B has compatibility issues when using
rgmii-id mode. Switch to rgmii mode and use the SoC's delays to ensure
full compatibility.

Reported-by: Frank Mankel <frank.mankel@gmail.com>
Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B device
tree")
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Frank Mankel <frank.mankel@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index 7bdcecc0dfe4..02d5f5a8ca03 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -133,7 +133,7 @@ &gmac1 {
 	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>;
 	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>, <&gmac1_clkin>;
 	clock_in_out = "input";
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii";
 	phy-supply = <&vcc_3v3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac1m1_miim
-- 
2.25.1

