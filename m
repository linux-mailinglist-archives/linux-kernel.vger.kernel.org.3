Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A059774C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241697AbiHQUED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241680AbiHQUDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:03:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA1C27B05
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:03:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DB56151E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6340CC43470;
        Wed, 17 Aug 2022 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660766631;
        bh=SNZ70vt4bNjbtH48RRhcFsT0HkyKYDhAfV/NNF8Sj9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=taN9Qch78MvSeXbDyWhIPR+suwZFNPzyZmAzLyaR8NSXf4mh7CdyLT7HVxlXTnPNq
         T/i1I8SetYLuOCZkc2llJ3tcbeIPqTr0ehmxYsJOjjVvF0c8+a7ajJ3QjE+b/9e+7f
         r9k6dPFiBV9QJP6TypHRyedePbioXwEtckP3Qdz+fIShsVIIW2fr3W2CxSGN7stVLq
         5BRjY4Te5NT9sd8GO5i4YGbKHiZc/pOGu19BP1yEHJMFNT1LcwPOX82Or3HscGafKt
         bbMEGjFAPBlHqKea0D5eQu6L5hWRWQ1D1nfxltwTKwJPmDm9xuV6BlO/ijoCjxnYzR
         mRB3pVzkAtsrw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, pali@kernel.org,
        josef.schlehofer@nic.cz,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH linux-phy v2 4/4] arm64: dts: armada-3720-turris-mox: Change comphy tx amplitude for 2500base-x mode
Date:   Wed, 17 Aug 2022 22:03:35 +0200
Message-Id: <20220817200335.911-5-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817200335.911-1-kabel@kernel.org>
References: <20220817200335.911-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change comphy transmit amplitude to 1025 mV for 2500base-x mode on
comphy connected to Topaz.

This fixes issue wherein if the 8b/10b encoded packet contains a long
enough alternating sequence of bits (010101... or 101010...), which
happens if the packet contains a sequence of 'J' or '\xb5' bytes, the
packet may be lost when sent from A3720 to Topaz due to FCS error. The
probability of loss grows with the number of 'J's with default transmit
amplitude setting - with 114 'J's the probability is about 50%, with 125
'J's almost 100% of packets  are lost.

Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index ada164d423f3..74a7ac1f8ecb 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -181,6 +181,16 @@ &eth1 {
 	phys = <&comphy0 1>;
 };
 
+&comphy0 {
+	/*
+	 * Set peak to peak transmit amplitude to 1025 mV to fix issue wherein
+	 * a packet may be lost if it contains a long enough sequence of 'J'
+	 * or '\xb5' bytes.
+	 */
+	tx-p2p-microvolt = <1025000>;
+	tx-p2p-microvolt-names = "2500base-x";
+};
+
 &sdhci0 {
 	wp-inverted;
 	bus-width = <4>;
-- 
2.35.1

