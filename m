Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F4854307D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbiFHMdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiFHMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:33:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD329E4E2;
        Wed,  8 Jun 2022 05:33:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [186.189.224.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: adalessandro)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 47A026601780;
        Wed,  8 Jun 2022 13:32:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654691577;
        bh=6zZ3JVA8se89xqhPzZ/QyyWi3pmDJIoGZzkI1kPjPWs=;
        h=From:To:Cc:Subject:Date:From;
        b=ChrNavfDiEB7trqMZP2l3apaGDKGiBfsNfVI9+ToKN+VT2mSnJaED05UyAu8+byX6
         802C088qtVbBcKmSQOcKfpIp0EVfAw8lbr894uJ+ItfjXAvYw2d3suXRsC/3GfOfUU
         U1hng2DREUx1gzzBHC8SuAvYLRnaeOok0klz6YuPV62HjV4MytxEW1uFSLXuJxNNJj
         6hKJXrlC3rnR+Ch0qufjd7ffL4aGH0qRLVEReMpco1z9IbZAUZVUXSsWXMvxaK6YLI
         1RFKEnD4mLg9JUMo8w6HDz1p78+9ytOGnW+DwHddkPMQE/ZbB0WZXaQiAMPYTpx5CK
         88V3w6661Z2rg==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Cc:     gbcm-kernel-feedback-list@broadcom.com,
        gkrzysztof.kozlowski+dt@linaro.org, gnsaenz@kernel.org,
        grobh+dt@kernel.org
Subject: [PATCH] ARM: dts: bcm2711-rpi-4-b: Use aliases to set custom MMC device index
Date:   Wed,  8 Jun 2022 09:32:33 -0300
Message-Id: <20220608123233.13439-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MMC aliases to ensure that the /dev/mmcblk ID for SD card won't
change depending on the probe order of the MMC drivers.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 4432412044de..780812542bad 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -14,6 +14,10 @@ chosen {
 		stdout-path = "serial1:115200n8";
 	};
 
+	aliases {
+		mmc0 = &emmc2;	/* mmcblk0 for SD */
+	};
+
 	leds {
 		led-act {
 			gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
-- 
2.34.1

