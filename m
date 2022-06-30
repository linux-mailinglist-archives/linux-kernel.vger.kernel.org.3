Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09D5618A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiF3LAk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Jun 2022 07:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiF3LAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:00:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB142ECB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:00:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6rtu-0002Pt-Qp; Thu, 30 Jun 2022 12:59:58 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6rtj-003ZXI-17; Thu, 30 Jun 2022 12:59:50 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6rtl-0006A7-Mo; Thu, 30 Jun 2022 12:59:49 +0200
Message-ID: <63f8d70ad9c657890669e9c32775632af4e36995.camel@pengutronix.de>
Subject: Re: [PATCH v6 08/17] reset: npcm: using syscon instead of device
 data
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, gregkh@linuxfoundation.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 30 Jun 2022 12:59:49 +0200
In-Reply-To: <20220630103606.83261-9-tmaimon77@gmail.com>
References: <20220630103606.83261-1-tmaimon77@gmail.com>
         <20220630103606.83261-9-tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

On Do, 2022-06-30 at 13:35 +0300, Tomer Maimon wrote:
Using syscon device tree property instead of device data to handle the
NPCM general control registers.

In case the syscon not found the code still search for nuvoton,npcm750-gcr
to support DTS backward compatibility.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/reset/reset-npcm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index 2ea4d3136e15..431ff2b602c5 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -138,8 +138,7 @@ static int npcm_reset_xlate(struct reset_controller_dev *rcdev,
 }
 

 static const struct of_device_id npcm_rc_match[] = {
-	{ .compatible = "nuvoton,npcm750-reset",
-		.data = (void *)"nuvoton,npcm750-gcr" },
+	{ .compatible = "nuvoton,npcm750-reset"},

Add a space.                                  ^^

 	{ }
 };
 

@@ -155,15 +154,15 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
 	u32 ipsrst1_bits = 0;
 	u32 ipsrst2_bits = NPCM_IPSRST2_USB_HOST;
 	u32 ipsrst3_bits = 0;
-	const char *gcr_dt;
 

-	gcr_dt = (const char *)
-	of_match_device(dev->driver->of_match_table, dev)->data;
-
-	gcr_regmap = syscon_regmap_lookup_by_compatible(gcr_dt);
+	gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "nuvoton,sysgcr");
 	if (IS_ERR(gcr_regmap)) {
-		dev_err(&pdev->dev, "Failed to find %s\n", gcr_dt);
-		return PTR_ERR(gcr_regmap);
+		dev_warn(&pdev->dev, "Failed to find nuvoton,sysgcr search for nuvoton,npcm750-gcr for Poleg backward compatibility");

Is this warning useful to the user? Maybe add suggestion like "please
update the device tree". Also there is no further message if
nuvoton,npcm750-gcr is found and all is well.

regards
Philipp
