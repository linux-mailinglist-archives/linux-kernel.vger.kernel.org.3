Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D958C4FAA92
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiDIUHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiDIUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:07:07 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB447AD7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:04:58 -0700 (PDT)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eaf9:8401:9d41:ea18:e395:a08d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id B80232C4658;
        Sat,  9 Apr 2022 21:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1649534163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+chAUdJiBzKs88jdausmSCxwbTjomag1w6qWW/Hank=;
        b=9ehHVlFq8F/jG3mofWNO7ADtxpJpI5BxrxNHr/PEVNVyorURuUdaAukDEKP20F6t6kEeZp
        1nCrHM9POUVWNFhcuhlKa0AS/iqyu13oRS3xmyN8cZ9zp6VGjyyeSmTbGuVDfrELmJJvth
        WsRP0fcXUjBaGbXQNk4b4t/QDdacI4OYb3vFFTzXHQFDukbiHmnliV/27m0SVj5yVZ6lop
        v8TLHMOCTI/e/ryzyux9G3XSJkPVlWAghJlisz6i71C8e9ej0vWu/9/dJkImumHQkfYAD+
        NTveQZ3Ua+Ej8rdkIkOYfPnCTxpFTee2WB0myyRwzQMjrw74xZ0aKBw2IAc0xg==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] gpio: realtek-otto: Add RTL931x support
Date:   Sat,  9 Apr 2022 21:55:51 +0200
Message-Id: <56ee532f99b197b431ede9a3179b0d6e826d196b.1649533972.git.sander@svanheule.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649533972.git.sander@svanheule.net>
References: <cover.1649533972.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTL931x SoC series has support for 32 GPIOs, although not all lines
may be broken out to a physical pad.

The GPIO bank's parent interrupt can be routed to either or both of the
SoC's CPU cores by the GIC. Line-by-line IRQ balancing is not possible
on these SoCs.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/gpio/gpio-realtek-otto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek-otto.c
index 3ddaa17accff..c52b2cb1acae 100644
--- a/drivers/gpio/gpio-realtek-otto.c
+++ b/drivers/gpio/gpio-realtek-otto.c
@@ -339,6 +339,9 @@ static const struct of_device_id realtek_gpio_of_match[] = {
 		.compatible = "realtek,rtl9300-gpio",
 		.data = (void *)(GPIO_PORTS_REVERSED | GPIO_INTERRUPTS_PER_CPU)
 	},
+	{
+		.compatible = "realtek,rtl9310-gpio",
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, realtek_gpio_of_match);
-- 
2.35.1

