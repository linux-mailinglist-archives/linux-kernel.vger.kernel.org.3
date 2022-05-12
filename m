Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1183F5249AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352231AbiELKAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345876AbiELKAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:00:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B545E22EA4C;
        Thu, 12 May 2022 03:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50AA1618C7;
        Thu, 12 May 2022 10:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE2FC34100;
        Thu, 12 May 2022 10:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652349600;
        bh=w1iQpOtJlmC1US6MRv+HaHZPJAJI71Jlklot9VO5VHo=;
        h=From:To:Cc:Subject:Date:From;
        b=AKvcEY7pn+36xERzMkKmC0We2v09vEBYSX5NOrqsAvnzCVkF6I8j7KIySPe0Bpfoh
         KVaO+v0JvtQWpRxxPEwhm6dQuapQ4V7jA+rEixSebzmD0uC1o6OfhVZXQhTtEYJaMj
         nI3NxZS9yRdy6klXZWz94MLJT/pZDcJQZnnxlEYbhtJM6/CVP+he4hdvfRsMV3jK3n
         l12k6nm8fHcjafYSObOpJTA6Jv5DZKhmlzch3AWz0kY0w56ftOHV8ZTY5MrzRwblOB
         3Mw6OPN96J1eysAau4ADJ4TeZgGRDojPZ1z5EhtCNl/bYZXmKmo/lZuwPAjwhSav8d
         N9s65jQOjHjhw==
Received: by pali.im (Postfix)
        id A515D24F5; Thu, 12 May 2022 11:59:57 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: turris-omnia: Add atsha204a node
Date:   Thu, 12 May 2022 11:59:39 +0200
Message-Id: <20220512095939.8595-1-pali@kernel.org>
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

Crypto module atsha204a is available at i2c address 0x64. Module is used
for symmetric cryptography and provides also hardware random number
generator and OTP storage for device serial number and MAC addresses.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index bc778ab8618a..f4eb6898aa6b 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -349,7 +349,11 @@
 			#size-cells = <0>;
 			reg = <5>;
 
-			/* ATSHA204A at address 0x64 */
+			/* ATSHA204A-MAHDA-T crypto module */
+			crypto@64 {
+				compatible = "atmel,atsha204a";
+				reg = <0x64>;
+			};
 		};
 
 		i2c@6 {
-- 
2.20.1

