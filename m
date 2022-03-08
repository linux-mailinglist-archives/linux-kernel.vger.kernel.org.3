Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795C94D188F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbiCHNBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbiCHNB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:01:29 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9072BB36;
        Tue,  8 Mar 2022 05:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646744422;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=VtDYvUnQRbgLODj+rX79mLvwKSW8TYtJTAsBlNabCFw=;
    b=rafLf+uUZEtqViDhU6H6lF3wCMqQdZHfkaZ9B3xnaIeBK+1vLLLm3piTpF+rIVy1bB
    QwigEkw39QsCqnackRhQS2N5SAeMEQ7qfu0XmmiDAlPiFC+cnD7iSnuU1rbrHjRLPZgC
    asH/4prv8EySixlwtOT1kZm8oYH9C1P/OhAP0HzGlWyqZBzzbF4qDA1ucxFyFnx1bsUQ
    WFucOqejH0svlG83BoOz9tPGSCvtqIbDxrrK9hcNH78zd4ieEnNQ9DUDgiMQPs7bMQZR
    UuUZ4deah2JueGccJGipdAxJQKxrOmXw9m8Jd0zn5ejfYstnqAWSLaJVycAZIqPjQomE
    zP9Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbpc9Y="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id n729cey28D0LSJD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 8 Mar 2022 14:00:21 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] ARM: dts: Fix mmc order for omap3-gta04
Date:   Tue,  8 Mar 2022 14:00:20 +0100
Message-Id: <dc9173ee3d391d9e92b7ab8ed4f84b29f0a21c83.1646744420.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a1ebdb374199 ("ARM: dts: Fix swapped mmc order for omap3")

introduces general mmc aliases. Let's tailor them to the need
of the GTA04 board which does not make use of mmc2 and mmc3 interfaces.

Fixes: commit a1ebdb374199 ("ARM: dts: Fix swapped mmc order for omap3")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 7e3d8147e2c1..0365f06165e9 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -31,6 +31,8 @@ chosen {
 	aliases {
 		display0 = &lcd;
 		display1 = &tv0;
+		/delete-property/ mmc2;
+		/delete-property/ mmc3;
 	};
 
 	ldo_3v3: fixedregulator {
-- 
2.33.0

