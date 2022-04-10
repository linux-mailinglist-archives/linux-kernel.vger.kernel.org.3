Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF82F4FB0C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 01:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiDJXCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 19:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiDJXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 19:02:37 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940EC18352;
        Sun, 10 Apr 2022 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=aJRncnFPGogcci9EJtlIRk6kkiE8YTvJb5FUaqmBsaQ=; b=UNqKglfVHf9nXXqEcm+xSyRD8Y
        AI6nDI78xyR9QPIjT058FZpb01ltnweaPAA8+9sWpFAgR3EKxB6Tt5mr/E+3M8PXUSp+P40qSJsR+
        T+zGFJ5DD88xUhb0/lZX/thFNOfdLUjwFvnjB30OmTQALV3Q0p6hiNpjpcRJgaopdfaGrDR95QjvT
        IL84JJJ5t12Ei6Gqi2+CmVW4C9soHtsuVx0A7FSWJaSJhwg73B9GRaHi55RxK2cSVeNJBWeyiTM3W
        ouW/mZ09YDuoZZWPkNMGX8en6Hr2vKCm7hnUdtr/oSyDhJ7aFqTO1Ak7BYQWP99gD46I4YULFRNtO
        Rfto70gQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ndgXe-00BKd0-D1; Mon, 11 Apr 2022 01:00:22 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.95)
        (envelope-from <aurelien@aurel32.net>)
        id 1ndgXd-000ZMa-PF;
        Mon, 11 Apr 2022 01:00:21 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-kernel@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, soc@kernel.org
Subject: [PATCH 1/2] arm64: dts: broadcom: Enable device-tree overlay support for RPi devices
Date:   Mon, 11 Apr 2022 00:59:39 +0200
Message-Id: <20220410225940.135744-2-aurelien@aurel32.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220410225940.135744-1-aurelien@aurel32.net>
References: <20220410225940.135744-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the '-@' DTC option for the Raspberry Pi devices. This option
populates the '__symbols__' node that contains all the necessary symbols
for supporting device-tree overlays (for instance from the firmware or
the bootloader) on these devices.

The Rasbperry Pi devices are well known for their GPIO header, that
allow various "HATs" or other modules do be connected and this enables
users to create out-of-tree device-tree overlays for these modules.

Please note that this change does increase the size of the resulting DTB
by ~40%. For example, with v5.17 increase in size is as follows:

  bcm2711-rpi-400.dtb       26481 -> 36830 bytes
  bcm2711-rpi-4-b.dtb       26537 -> 36886 bytes
  bcm2711-rpi-cm4-io.dtb    26426 -> 36945 bytes
  bcm2837-rpi-3-a-plus.dtb  14133 -> 19740 bytes
  bcm2837-rpi-3-b.dtb       14310 -> 20006 bytes
  bcm2837-rpi-3-b-plus.dtb  14670 -> 20474 bytes
  bcm2837-rpi-cm3-io3.dtb   13680 -> 19266 bytes

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/arm64/boot/dts/broadcom/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 5082fcd1fea5..0aa8ee2afdd5 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,4 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Enables support for device-tree overlays
+DTC_FLAGS_bcm2711-rpi-400 := -@
+DTC_FLAGS_bcm2711-rpi-4-b := -@
+DTC_FLAGS_bcm2711-rpi-cm4-io := -@
+DTC_FLAGS_bcm2837-rpi-3-a-plus := -@
+DTC_FLAGS_bcm2837-rpi-3-b := -@
+DTC_FLAGS_bcm2837-rpi-3-b-plus := -@
+DTC_FLAGS_bcm2837-rpi-cm3-io3 := -@
+DTC_FLAGS_bcm2837-rpi-zero-2-w := -@
+
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2711-rpi-4-b.dtb \
 			      bcm2711-rpi-cm4-io.dtb \
-- 
2.34.1

