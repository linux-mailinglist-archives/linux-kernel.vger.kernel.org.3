Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB0554B2D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbiFNOMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiFNOM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:12:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4D625DE;
        Tue, 14 Jun 2022 07:12:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [186.189.224.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: adalessandro)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C41D660169E;
        Tue, 14 Jun 2022 15:12:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655215943;
        bh=XJ82+PJ/mHRvkQU7fkX8lwKDNz9S6xbNChcHXIsp7Lc=;
        h=From:To:Cc:Subject:Date:From;
        b=WkElNX4K7KK5LE/GFsiiNOGsRjB4wV7y00lK/eVYkJKTqilmOyINv20VFbMbjZH2e
         w/8Y0nqzdRoG5um8iV+wQDb/DHSbehvPP1hME6hHHM3Q1xUce1IcWWqCRAK6ftLDfA
         bhCvg0v9G5FCJTLVT6TMa3ddk0P5m665c3MWsqvW9iMPluX5kABObYFhFtXkb7H79A
         bigzGI5/ZU+k9cUGTM/DqG2wnXsU3ZTVCkPIBjm62PbpibDqTvl6MMZLB2iU7sUHs7
         ClCwE/7Pn9mu8jiOFMDHlbhMdY+icnU4cMGiN/WoeBrEcQAKf2Hc0mh9qQ0dvj5Kg5
         ZZUJrLaw4+qyA==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     krzysztof.kozlowski+dt@linaro.org, nsaenz@kernel.org,
        robh+dt@kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pbrobinson@gmail.com, f.fainelli@gmail.com, stefan.wahren@i2se.com
Subject: [PATCH] ARM: dts: bcm2711-rpi: Use aliases to set custom MMC device index
Date:   Tue, 14 Jun 2022 11:12:08 -0300
Message-Id: <20220614141208.15614-1-ariel.dalessandro@collabora.com>
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

Add MMC aliases to ensure that the /dev/mmcblk ID for the first
eMMC/SD card won't change depending on the probe order of the MMC
drivers.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---

Changes in v2:
* Moved alias from bcm2711-rpi-4-b.dts to bcm2711-rpi.dtsi

 arch/arm/boot/dts/bcm2711-rpi.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi.dtsi b/arch/arm/boot/dts/bcm2711-rpi.dtsi
index ca266c5d9f9b..a39b2f68e4cc 100644
--- a/arch/arm/boot/dts/bcm2711-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2711-rpi.dtsi
@@ -13,6 +13,7 @@ memory@0 {
 	aliases {
 		emmc2bus = &emmc2bus;
 		ethernet0 = &genet;
+		mmc0 = &emmc2;	/* mmcblk0 for eMMC/SD */
 		pcie0 = &pcie0;
 		blconfig = &blconfig;
 	};
-- 
2.34.1

