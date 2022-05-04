Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C770C51B133
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378763AbiEDVm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiEDVmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:42:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEEA1FCC7;
        Wed,  4 May 2022 14:38:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5EB351F44BA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651700325;
        bh=uyAo5zR8dw2G1PXvLBzX4kEvbmbHh0MqtTGpkAws0D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inO3cIE1rPZA0GCZu1aeQjV6iYnIhJF7h5w1UFxljkHcfOzGjt/6e5AdBubBBgtIM
         ajmxEAcAv39U4TWCq65xRt6fgS3edehSQWe4qaRsOdFO9zh1ashxBv8zRK6Pxuzgfv
         SHFhC5xjcldM/blagI01VYnA/89Kb0LqmEcwP0UVYbWDN4egDfBHNJJlxle7E+B1lB
         9sgE5lUg0g+9o+0F1H4raLBx+AptayB4wW/evyWF101Ccxlh6bEqEaSoMey2HTE++k
         pQsYojZ7YVTxhxQEdIOpTsXGFuvbDOoeTcq93eoRIilIvm0AdFzUhDe9TAjknHu4pj
         x65BHNCyOY8wQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 598FE4819D7; Wed,  4 May 2022 23:32:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 18/21] dt-bindings: pinctrl: rockchip: increase max amount of device functions
Date:   Wed,  4 May 2022 23:32:48 +0200
Message-Id: <20220504213251.264819-19-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504213251.264819-1-sebastian.reichel@collabora.com>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3588 can have 10 different device functions, so increase the maximum
amount appropriately. Considering rockchip uses auto-generated pinmux
files, adding a quite complex if construct to increase the limit just
for rk3588 does not seem to be worth the effort.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
index e62fb5e9db76..68339082571f 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
@@ -130,7 +130,7 @@ additionalProperties:
               description:
                 Pin bank index.
             - minimum: 0
-              maximum: 6
+              maximum: 10
               description:
                 Mux 0 means GPIO and mux 1 to N means
                 the specific device function.
-- 
2.35.1

