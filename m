Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E67B4E8B70
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiC1BCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbiC1BCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:02:31 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC5CE4ECE0;
        Sun, 27 Mar 2022 18:00:50 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net [81.96.50.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id E46AA140193;
        Mon, 28 Mar 2022 00:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1648428629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CuEcPDB+AlpLfXTqAeWfzXqofQSTcIxpMeVQrjaG4Nk=;
        b=CeL2JT/7rrhCyZeiu6hxNT/c/FpFJCMWOh7V/0uP6zoUQRmcQ2p4+tjczMM49dpdvaRnjW
        2jrWHgYS/bhHVE09b/DHO6AYRO2+C0WYxvhFvAJBsqGhENrvThvD6TouD+oGLqadGDvG4A
        RjursQ4ABdzsZ/liMBNriWXQwHG6Aws=
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
Subject: [PATCH 2/4] pinctrl/rockchip: support setting input-enable param
Date:   Mon, 28 Mar 2022 01:50:03 +0100
Message-Id: <20220328005005.72492-3-kc@postmarketos.org>
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

Handle the PIN_CONFIG_INPUT_ENABLE param for configuring GPIOs as input.

Signed-off-by: Caleb Connolly <kc@postmarketos.org>
---
 drivers/pinctrl/pinctrl-rockchip.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index d54fc1cdf609..9d50d9756bb9 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2129,7 +2129,7 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		param = pinconf_to_config_param(configs[i]);
 		arg = pinconf_to_config_argument(configs[i]);
 
-		if (param == (PIN_CONFIG_OUTPUT | PIN_CONFIG_INPUT_ENABLE)) {
+		if (param == PIN_CONFIG_OUTPUT || param == PIN_CONFIG_INPUT_ENABLE) {
 			/*
 			 * Check for gpio driver not being probed yet.
 			 * The lock makes sure that either gpio-probe has completed
@@ -2181,6 +2181,16 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			if (rc)
 				return rc;
 			break;
+		case PIN_CONFIG_INPUT_ENABLE:
+			rc = rockchip_set_mux(bank, pin - bank->pin_base,
+					      RK_FUNC_GPIO);
+			if (rc != RK_FUNC_GPIO)
+				return -EINVAL;
+
+			rc = gpio->direction_input(gpio, pin - bank->pin_base);
+			if (rc)
+				return rc;
+			break;
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			/* rk3288 is the first with per-pin drive-strength */
 			if (!info->ctrl->drv_calc_reg)
-- 
2.35.1

