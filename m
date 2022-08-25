Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5C5A10D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbiHYMmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241501AbiHYMmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179FEB4418;
        Thu, 25 Aug 2022 05:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3EAF61892;
        Thu, 25 Aug 2022 12:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC609C433C1;
        Thu, 25 Aug 2022 12:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661431357;
        bh=0+OlgcSOrYlIbWJzpjLsDpMOnEDE4sN9uwmn10MNF28=;
        h=From:To:Cc:Subject:Date:From;
        b=CxlnxkN1P/sPdsB6GXDGrMKeLGsDHAuwdnJC5/vcTdN+K65msTE3yRkwUUY6PtfGz
         kNUdtOSmcLQT2r/M+SBvOxzVh6nqjFmGYLIOkB9+W5R1k+oKXpJ3AnI2v9EbkOjpsu
         PCAsav0lzcaRxMCLhfZxbZG93ggA2UpGrnleYcc7Z2I1/sD+U7kAPt/8OATzAUbG/w
         SY32KdrrJjwlwlgYoZ2OAiyoxB978SxNbGh8UlyyJNoG8eGXc9NUJ2s9OjIJPJUiJX
         BjHP3iyAm+QsBjzoIouPH417AQz9M+06ecWd7lt5UhDhfAPMrK5Pa2ygLmWsjP8J5e
         nXAN9S0/OKI5A==
Received: by pali.im (Postfix)
        id CE4F3742; Thu, 25 Aug 2022 14:42:33 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH] ARM: dts: turris-omnia: Add switch port 6 node
Date:   Thu, 25 Aug 2022 14:21:02 +0200
Message-Id: <20220825122102.18634-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Switch port 6 is connected to eth0, so add appropriate device tree node for it.

Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index f655e9229d68..8215ffb6a795 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -463,7 +463,17 @@
 				};
 			};
 
-			/* port 6 is connected to eth0 */
+			ports@6 {
+				reg = <6>;
+				label = "cpu";
+				ethernet = <&eth0>;
+				phy-mode = "rgmii-id";
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
 		};
 	};
 };
-- 
2.20.1

