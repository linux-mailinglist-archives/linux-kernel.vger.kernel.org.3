Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A83657380B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiGMNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiGMNy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:54:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA981240;
        Wed, 13 Jul 2022 06:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 904DAB81F66;
        Wed, 13 Jul 2022 13:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051ECC34114;
        Wed, 13 Jul 2022 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657720463;
        bh=/tvxZwralFJ4cZXdPkXxJEQCgvBw9Ua4U7XdiklwROc=;
        h=From:To:Cc:Subject:Date:From;
        b=NPugggpNWrapctlNOMvCLfTS/6nQRBp4qtBMpShlx6IuKz8VtqvV92KmfK6a055Tb
         LiJm0Itggmfb7TuXYij4Qj6U/BGcO0EHimH0uvGiXoRZJ7NEHvEROtj1fYTQlSfPxK
         R/tWGZ91pxAnfu7R8AQykRLoxbSlFGaVYImN/9d2g5A+SbMhW2DvPn9ogQ/BGfCmR9
         Hvik6QiYCSrsweYDeehsB7cCqGeCVaf5oiWomt2MANb/k699X3JxZDTJXczafFUY/o
         18S9t443e72R5l29VEEe9usJERuwbaF9WLxXASWJNiX/TKwYBa4SMiBkto4yLcAk0N
         udxMjiowqC0vQ==
Received: by pali.im (Postfix)
        id 3B1619D9; Wed, 13 Jul 2022 15:54:20 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: dts: turris1x.dts: Add CPLD reboot node
Date:   Wed, 13 Jul 2022 15:44:29 +0200
Message-Id: <20220713134429.18748-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPLD firmware can reset board by writing value 0x01 at CPLD memory offset
0x0d. Define syscon-reboot node for this reset support.

Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/dts/turris1x.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index c76b628cf026..12e08271e61f 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -332,7 +332,7 @@
 			 * Turris CPLD firmware is open source and available at:
 			 * https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v
 			 */
-			compatible = "cznic,turris1x-cpld", "fsl,p1021rdb-pc-cpld", "simple-bus";
+			compatible = "cznic,turris1x-cpld", "fsl,p1021rdb-pc-cpld", "simple-bus", "syscon";
 			reg = <0x3 0x0 0x30>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -352,6 +352,14 @@
 				gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
 			};
 
+			reboot@d {
+				compatible = "syscon-reboot";
+				reg = <0x0d 0x01>;
+				offset = <0x0d>;
+				mask = <0x01>;
+				value = <0x01>;
+			};
+
 			led-controller@13 {
 				/*
 				 * LEDs are controlled by CPLD firmware.
-- 
2.20.1

