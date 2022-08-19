Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F946599E24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349746AbiHSP3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348832AbiHSP3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:29:18 -0400
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943A5B490;
        Fri, 19 Aug 2022 08:29:15 -0700 (PDT)
Received: from localhost (7of9.are-b.org [127.0.0.1])
        by 7of9.schinagl.nl (Postfix) with ESMTP id DECB518669BC;
        Fri, 19 Aug 2022 17:29:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1660922952; bh=/FXiuNvkl4pKLGDWUjodkCVhdgwIGhKIvcSAns8TLLk=;
        h=From:To:Cc:Subject:Date;
        b=s2TGgG3QmX4tcd8t1qHoVfSkK1UdrtHA6d1iLFCF28f5kLyeTbL5XF5zWkXQqulpc
         cvdnbuRZg5BQQp4HtPE3EO7cyQdhWS9sctRkAO8CxiWjl5IvHsrdQulyqX2a8VBE+u
         6hfigOAJ0ajE4yvyzcDi84I73c0xJrGyQ+zOiANY=
X-Virus-Scanned: amavisd-new at schinagl.nl
Received: from 7of9.schinagl.nl ([127.0.0.1])
        by localhost (7of9.schinagl.nl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id HOiRi6kbe3nz; Fri, 19 Aug 2022 17:29:10 +0200 (CEST)
Received: from valexia.are-b.org (unknown [10.2.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 33B6118669B7;
        Fri, 19 Aug 2022 17:29:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1660922950; bh=/FXiuNvkl4pKLGDWUjodkCVhdgwIGhKIvcSAns8TLLk=;
        h=From:To:Cc:Subject:Date;
        b=ESa6yd7mUZS7Us3Xf/bSq4vZHwODRdUjPkanxxyKAbeG7iuoldk1ZdNEp17PrGY5i
         V+NTOK97q2i5t2y74a8s53fXqFxt3/3JLZ1gBW2eNZm+/YxYBXBm/vmbvMzVpzJzQ0
         wiNr4F68ypdZh5LMUVLTrPsKU4PEIGpf8n0fUXnc=
From:   Olliver Schinagl <oliver@schinagl.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Olliver Schinagl <oliver+list@schinagl.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCHv2 resend] dt-bindings: leds: Expand LED_COLOR_ID definitions
Date:   Fri, 19 Aug 2022 17:29:04 +0200
Message-Id: <20220819152904.433514-1-oliver@schinagl.nl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 853a78a7d6c7 (dt-bindings: leds: Add LED_COLOR_ID definitions,
Sun Jun 9 20:19:04 2019 +0200) the most basic color definitions where
added. However, there's a little more very common LED colors.

While the documentation states 'add what is missing', engineers tend to
be lazy and will just use what currently exists. So this patch will take
(a) list from online retailers [0], [1], [2] and use the common LED colors
from there, this being reasonable as this is what is currently available to
purchase.

Note, that LIME seems to be the modern take to 'Yellow-green' or
'Yellowish-green' from some older datasheets.

[0]: https://www.digikey.com/en/products/filter/led-lighting-color/125
[1]: https://eu.mouser.com/c/optoelectronics/led-lighting/led-emitters/standard-leds-smd
[2]: https://nl.farnell.com/en-NL/c/optoelectronics-displays/led-products/standard-single-colour-leds-under-75ma

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---

Changes since v1: Unbreak existing definitions.


 include/dt-bindings/leds/common.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index 3be89a7c20a9..04bf94523ea3 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -22,18 +22,22 @@
 #define LEDS_BOOST_FIXED	2
 
 /* Standard LED colors */
-#define LED_COLOR_ID_WHITE	0
-#define LED_COLOR_ID_RED	1
-#define LED_COLOR_ID_GREEN	2
-#define LED_COLOR_ID_BLUE	3
-#define LED_COLOR_ID_AMBER	4
-#define LED_COLOR_ID_VIOLET	5
-#define LED_COLOR_ID_YELLOW	6
-#define LED_COLOR_ID_IR		7
-#define LED_COLOR_ID_MULTI	8	/* For multicolor LEDs */
-#define LED_COLOR_ID_RGB	9	/* For multicolor LEDs that can do arbitrary color,
-					   so this would include RGBW and similar */
-#define LED_COLOR_ID_MAX	10
+#define LED_COLOR_ID_WHITE      0
+#define LED_COLOR_ID_RED        1
+#define LED_COLOR_ID_GREEN      2
+#define LED_COLOR_ID_BLUE       3
+#define LED_COLOR_ID_AMBER      4
+#define LED_COLOR_ID_VIOLET     5
+#define LED_COLOR_ID_YELLOW     6
+#define LED_COLOR_ID_IR         7
+#define LED_COLOR_ID_MULTI      8 /* For multicolor LEDs */
+#define LED_COLOR_ID_RGB        9 /* For multicolor LEDs that can do arbitrary color, including RGBW etc. */
+#define LED_COLOR_ID_PUPRPLE   10
+#define LED_COLOR_ID_ORANGE    11
+#define LED_COLOR_ID_PINK      12
+#define LED_COLOR_ID_CYAN      13
+#define LED_COLOR_ID_LIME      14
+#define LED_COLOR_ID_MAX       15
 
 /* Standard LED functions */
 /* Keyboard LEDs, usually it would be input4::capslock etc. */
-- 
2.37.2

