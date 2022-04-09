Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B664FAA9A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiDIUHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiDIUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:07:07 -0400
X-Greylist: delayed 536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Apr 2022 13:04:59 PDT
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18164968A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:04:58 -0700 (PDT)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eaf9:8401:9d41:ea18:e395:a08d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 8AD942C4656;
        Sat,  9 Apr 2022 21:56:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1649534161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lsZorXZYXlyDl5x1CMnRj2fHFtwWcfNYaAsfL8MAYPk=;
        b=4PvsXEwV1luETKxiPwzE0idp+FXUs+RF4rwJQJA4LJz3ajSzf/cgngbcD0A6kRUyQuS6gO
        uzU8OkdacJ/qZwTLs6ZxP5q6HqqzoBr011SVToTdAnmpUWYWleG4zQjaMb83qdhXCCNnjo
        cu/oJajM7IKfeY7Y8EPlh2QUpnTV1F+gMQaYkr3OFes8ZOrYCwMQcT7mugHubThOLzRQtT
        nU0UDN5Z3Oxg7XxHAkaDVWv5Y7utdkb/3TfCojRtMYh/+aEJRsWM+/ykbxHBJBJLIcWJ7g
        wb7ybAwz1Cj+xV27Cjvegd9W/1KFi3rChOCwFT5PKgrRN6BDdrQElNA9Y1tutg==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] gpio: realtek-otto: Add RTL930x support
Date:   Sat,  9 Apr 2022 21:55:49 +0200
Message-Id: <0b8a8a927d998bbdceac7638d812790604f4d810.1649533972.git.sander@svanheule.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649533972.git.sander@svanheule.net>
References: <cover.1649533972.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTL930x SoC series has support for 24 GPIOs, with the port order
reversed compared to RTL838x and RTL839x. The RTL930x series also has
two CPUs (VPEs) and can distribute individual GPIO interrupts between
them.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/gpio/gpio-realtek-otto.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek-otto.c
index dd1b7656d23a..3ddaa17accff 100644
--- a/drivers/gpio/gpio-realtek-otto.c
+++ b/drivers/gpio/gpio-realtek-otto.c
@@ -335,6 +335,10 @@ static const struct of_device_id realtek_gpio_of_match[] = {
 	{
 		.compatible = "realtek,rtl8390-gpio",
 	},
+	{
+		.compatible = "realtek,rtl9300-gpio",
+		.data = (void *)(GPIO_PORTS_REVERSED | GPIO_INTERRUPTS_PER_CPU)
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, realtek_gpio_of_match);
-- 
2.35.1

