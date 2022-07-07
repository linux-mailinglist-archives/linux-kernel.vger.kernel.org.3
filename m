Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9124B56A913
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiGGRHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbiGGRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:07:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D39D5A47C;
        Thu,  7 Jul 2022 10:07:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CD8D21F9B2;
        Thu,  7 Jul 2022 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657213649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Ci4Dep1Zdb2ngukBlBCgO8oicNdK+KrkT4H7UcJ2kQ=;
        b=FUlwb0EqBnGrORmKhwXUa5r6qWXAdWT8tUoyLVl9iw+4GUwO+Cz1kOS5VJg6b4tPJ6KIrI
        AYe4dAVZy3FNjiTyP/nwTzCXgXeRtL41jD2pxajrt/G4sijt294X46OmrRswnqXvrj9a0m
        ncUHTV057vlD2LBZbEFh95qoJdPnDxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657213649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Ci4Dep1Zdb2ngukBlBCgO8oicNdK+KrkT4H7UcJ2kQ=;
        b=anndg+nTRyO4WGTNepgA3Zo5d70jt/982ZGZLCjdZZoo/SBQjlmJzdWiVeecSxUZPUM0du
        WNN6uvly1E584JBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 82C602C141;
        Thu,  7 Jul 2022 17:07:29 +0000 (UTC)
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
Subject: [PATCH v2] sunxi: dts: Fix SPI NOR campatible on Orange Pi Zero
Date:   Thu,  7 Jul 2022 19:07:20 +0200
Message-Id: <20220707170721.20225-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220707174801.36e010da@donnerap.cambridge.arm.com>
References: <20220707174801.36e010da@donnerap.cambridge.arm.com>
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

Without "jedec,spi-nor" compatible the flash memory cannot be probed by
u-boot. The macronix part is what is shipped on the boards that come
with a flash chip.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
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

