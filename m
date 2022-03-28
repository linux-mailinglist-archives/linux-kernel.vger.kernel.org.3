Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9FA4E8B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiC1BCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiC1BCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:02:31 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC3084ECDD;
        Sun, 27 Mar 2022 18:00:50 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net [81.96.50.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id CCA3E140195;
        Mon, 28 Mar 2022 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1648428630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJPO+cvB8mQMll3NzzvYxlnd9zKt1uj4D1+8hbf+ebs=;
        b=QCUmOohgp7Hn9lmS+r5wAkX438yPTC/mINkGBozlm1i//Cp1NiRAtUM3e23zyrgp2VJvQN
        DE+ArD6XUE8FhBU+jPxyGQt2L0qsKA0/nPOTZtLCbc3Fi3aokGFvGdP/S1FV8J1smBuvit
        jFZPfxAXuWy8dGFa+TQ9V7nD04Dswew=
From:   Caleb Connolly <kc@postmarketos.org>
To:     Caleb Connolly <kc@postmarketos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martijn@brixit.nl,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH 3/4] gpio/rockchip: handle deferring input-enable pinconfs
Date:   Mon, 28 Mar 2022 01:50:04 +0100
Message-Id: <20220328005005.72492-4-kc@postmarketos.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328005005.72492-1-kc@postmarketos.org>
References: <20220328005005.72492-1-kc@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for deferred PIN_CONFIG_INPUT_ENABLE handling.

Signed-off-by: Caleb Connolly <kc@postmarketos.org>
---
 drivers/gpio/gpio-rockchip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index bcf5214e3586..e342a6dc4c6c 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -760,6 +760,11 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 				dev_warn(dev, "setting output pin %u to %u failed\n", cfg->pin,
 					 cfg->arg);
 			break;
+		case PIN_CONFIG_INPUT_ENABLE:
+			ret = rockchip_gpio_direction_input(&bank->gpio_chip, cfg->pin);
+			if (ret)
+				dev_warn(dev, "setting input pin %u failed\n", cfg->pin);
+			break;
 		default:
 			dev_warn(dev, "unknown deferred config param %d\n", cfg->param);
 			break;
-- 
2.35.1

