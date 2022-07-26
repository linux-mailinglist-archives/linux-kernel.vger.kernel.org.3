Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E0058127C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiGZL66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiGZL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:58:56 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025C232DBA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:58:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r14so16228104ljp.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXepETNl0t5Eauvg/pczzznTHabsPOjX83tUsTI9GE8=;
        b=VzbgU00OJTByzWkVApH4fK61lobcJqO8iZS+G2mTVOJodHxycA0osaY4ettHZ4yICn
         lg/jJS07mw9kSC50ob3uJ/M7oVakYNcaAfzGvtvHoV/8JfsVxPd/IPwvGvyqkZMBhPYV
         GOed7CSD2Sv3jFq/jwEYtJ+L94QWmGZe1AufILpiI1fnNGtcpobUaVZL823T7vQBmrC5
         /BtytQI7S10FKlI7oLUNV6ixezlr+fvQbrFZJXfu42fjhLRM8PiRAc46jV/juNmv5bQP
         CcgU5m6IqBodoYGm5iht/Ka2Ifgd4h8ZKtnSiTBCk5DliCK6bVu9snz6WHjJhy326JH6
         /ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXepETNl0t5Eauvg/pczzznTHabsPOjX83tUsTI9GE8=;
        b=MkCkJQDLxiaLWmjnJ9akq8RanrQH2sSaH9iVbJg3mEwMtQCwLzaQO5WGHDws2kLqmh
         DOPXLcOqA3R1z5EzSvAHae2yITQMxyVu6icJXJ4QqUzueoQ5vQaQ6jpTSi8/9cbzHk66
         h8SjR94X/1jCXWt4MfY9K3gxSvO8vid2OU+dQOj1IPgePV/XpedRe2J3QoBCqGRS8weL
         L31j81VqszjQmhjZ0izdQylES5FdclgoP6ejDDehlB/dARpiZWljaypbGwi6EU3Y5MOB
         s9Fdg6DBc4KNpRYkw2BVTKt3BvCkVVx7HxJ/O8imhMJHYsSzbISNpsXg71guJxqMa+KA
         ZmIg==
X-Gm-Message-State: AJIora9vPx6+4fmxzd5oOrmpRtzr5bSllizEs/K728ixAUkeDynIFhSD
        c1gH0L2+UonvNasfhB7rcS84yA==
X-Google-Smtp-Source: AGRyM1uL5SU4BU4NU69IWSheCc7WAGNBFPBjyEmFfjOiC9y/qWdPQUqFn4FaEP6qkwKIhx2HV/9BUQ==
X-Received: by 2002:a05:651c:b23:b0:25e:e2d:9e40 with SMTP id b35-20020a05651c0b2300b0025e0e2d9e40mr2328578ljr.38.1658836733335;
        Tue, 26 Jul 2022 04:58:53 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id u5-20020a05651220c500b0048a9526c7d9sm773000lfr.257.2022.07.26.04.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 04:58:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Saenz Julienne <nsaenz@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] dt-bindings: soc: bcm: drop quotes when not needed
Date:   Tue, 26 Jul 2022 13:58:38 +0200
Message-Id: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Id and schema fields do not need quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
index 894786640938..a6e8018084c6 100644
--- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/soc/bcm/brcm,bcm2835-pm.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/soc/bcm/brcm,bcm2835-pm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: BCM2835 PM (Power domains, watchdog)
 
-- 
2.34.1

