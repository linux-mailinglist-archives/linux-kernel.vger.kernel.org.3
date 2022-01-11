Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D973E48B4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbiAKRz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:55:58 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54378
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344990AbiAKRzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:55:16 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B5803FFD9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923715;
        bh=BmB9cazi0hKFnRyUoCMsTBlnp9i8I7ETkGf9B7rE1rY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=S44c47PptfO81kBVgbL9cifo7+YZos/J9DLX/XHsQ6BD/C8qarPVn3EmEW0e3hibw
         4K8Ts0nc1IKQtOLXrVc2aQhavQMYJ8ruAgEQqckZZ9hDvwq03tpYLqFUIpe9hWphIY
         RzMa/O9AqVLcCzeW9RnDrNwQrUfrY2mvy82Z8NHMAKlooP8eMEcDRI8zTSHFdRU/0P
         pdYidDsZQlMaIntvN5aOHw7my+CbiCj8dXsh6ve07SCVFMq+BFU/JAHEM8oWEiC6k0
         bG+1owBR2g3Gaio66E/ti4xPlR5nYAIFavbWEqvy7DYHBu18HsMfybIEel2Ud/fD21
         eIsy6ZEuxu6FA==
Received: by mail-ed1-f71.google.com with SMTP id q15-20020a056402518f00b003f87abf9c37so13992816edd.15
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmB9cazi0hKFnRyUoCMsTBlnp9i8I7ETkGf9B7rE1rY=;
        b=tn1qZYypjsLv3vOUhM/6ugLhosL4OhKL1A3gAYpGTJO8VgygFEroVSsOoOfzxonppE
         gkW1JAo+JR9Vfj6q9uhe8ndvvkS88vhMssICZFh2AT58GPerM89zvt5SmS0mnPP4SsBb
         ojIeiCrF20akFJJLVvHf20ZH5T3ScFwfV9spijqkFhdXxO9/mEP1JTzxvFGzbMBYnGf7
         7a4XZUdVqcjTD5tORpbJ8ZTgjQBhmAc+IhKgt7gsCMRL4DxonTOyy5YIo4eiujFtmqnX
         ArlIp3jExM9TxVKl4emYJZaNcT4CturjTTzdj63e7dQCus9ghIPn2Yk3dn31REsZ6iZx
         bfbA==
X-Gm-Message-State: AOAM532GFKMhDziuYAIbnkcvL5Sk+XGY08sEcECQveou9S5otXfUDc3F
        64rL6336vaNzEe2ov3UHKS0S8pIGux797i2OdnCG/tWNi6h0y+fB3xATVuA71t4GaJ/MP09qu5J
        mjWo7gzUuWzb5HYWXES1g1zu8yJ577r13lQgZIJblPw==
X-Received: by 2002:a17:907:7f05:: with SMTP id qf5mr4531075ejc.597.1641923715344;
        Tue, 11 Jan 2022 09:55:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJCLUIrpEiP8qBwAD5GuOZRfnAaOXhGkc/rX1rQBiOtBHZz62WPoiPD24pySPPRqGLiXonwQ==
X-Received: by 2002:a17:907:7f05:: with SMTP id qf5mr4531069ejc.597.1641923715169;
        Tue, 11 Jan 2022 09:55:15 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 7sm3759949ejh.161.2022.01.11.09.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:55:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: leds: common: fix unit address in max77693 example
Date:   Tue, 11 Jan 2022 18:54:30 +0100
Message-Id: <20220111175430.224421-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max77693 LED device node should not take an unit address, because it
is instantiated from a max77693 I2C parent device node.  This also
splits all examples to separate DTS examples because they are actually
independent.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/leds/common.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 697102707703..328952d7acbb 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -185,9 +185,11 @@ examples:
         };
     };
 
-    led-controller@0 {
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    led-controller {
         compatible = "maxim,max77693-led";
-        reg = <0 0x100>;
 
         led {
             function = LED_FUNCTION_FLASH;
@@ -199,6 +201,9 @@ examples:
         };
     };
 
+  - |
+    #include <dt-bindings/leds/common.h>
+
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
-- 
2.32.0

