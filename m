Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F4C56C02A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbiGHRph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbiGHRpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:45:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18636D560;
        Fri,  8 Jul 2022 10:45:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 900EF1FD67;
        Fri,  8 Jul 2022 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657302333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTlnG+uuiCfvqn7xrHsgAyoZbypsgvBz1wNoT15Hvoo=;
        b=UA2amvDCQQTEMgc+oMAIWAnW9q6WVAwIa/58NrUhwHFQiUdZ2luhs3NootKMBQGixPTVF7
        JYttU9E5El22ptX+Zp2b5bkCYDiFbH2tZRODI2Pcam6rj1OVXYiuf7vydlAcOTOkVV0Ghr
        M7RKsq80AZmG76a/d0tmGsUehzywJuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657302333;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTlnG+uuiCfvqn7xrHsgAyoZbypsgvBz1wNoT15Hvoo=;
        b=vFAcpZMRjCSWaOrATDI77+P4vwFu5reaOBcx1bD9RQrcv7W4ttE3p6ZLJ4044r1wbkYvwN
        qpOGccqeB4O7c0Bw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id BEE682C141;
        Fri,  8 Jul 2022 17:45:32 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-sunxi@lists.linux.dev
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: sunxi: Fix SPI NOR campatible on Orange Pi Zero
Date:   Fri,  8 Jul 2022 19:45:29 +0200
Message-Id: <20220708174529.3360-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <10106175.nUPlyArG6x@jernej-laptop>
References: <10106175.nUPlyArG6x@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree should include generic "jedec,spi-nor" compatible, and a
manufacturer-specific one.
The macronix part is what is shipped on the boards that come with a
flash chip.

Fixes: 45857ae95478 ("ARM: dts: orange-pi-zero: add node for SPI NOR")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
v2: drop winbond compatible
v3: reword commit message
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index f19ed981da9d..3706216ffb40 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -169,7 +169,7 @@ &spi0 {
 	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "mxicy,mx25l1606e", "winbond,w25q128";
+		compatible = "mxicy,mx25l1606e", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <40000000>;
 	};
-- 
2.35.3

