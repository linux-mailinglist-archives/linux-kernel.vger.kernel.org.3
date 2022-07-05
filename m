Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3B566FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiGENtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiGENsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:48:47 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4D520BEF;
        Tue,  5 Jul 2022 06:19:59 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9DB962223E;
        Tue,  5 Jul 2022 15:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657027197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3lqEEC/xkItTOFsnReNMLLF51q2VVvTpLLXaoFEIVV4=;
        b=s9oo3vRuXgg9QFfaRK9nBtzUcWYb3DjJTCdaKYa/yIVKpNj2txEwDbwPbxES8FrnPQqayk
        h/vgED82LvsZ2+o3qXnohirS96GWEuIdW7kkFvToPqVlDuIGj1EZl68zrk4ZeSPznFEelS
        dKnmNjFamEjipD74cmDhpGM+S+x+KDE=
From:   Michael Walle <michael@walle.cc>
To:     Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] usb: gadget: udc: atmel: check rc of devm_gpiod_get_optional()
Date:   Tue,  5 Jul 2022 15:19:50 +0200
Message-Id: <20220705131951.1388968-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

devm_gpiod_get_optional() might still return an error code, esp.
EPROBE_DEFER. Return any errors.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index ae2bfbac603e..48355e0cee76 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2165,6 +2165,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 
 	udc->vbus_pin = devm_gpiod_get_optional(&pdev->dev, "atmel,vbus",
 						GPIOD_IN);
+	if (IS_ERR(udc->vbus_pin))
+		return ERR_CAST(udc->vbus_pin);
 
 	if (fifo_mode == 0) {
 		udc->num_ep = udc_config->num_ep;
-- 
2.30.2

