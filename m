Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93D64D6B12
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiCKXyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCKXyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:54:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070982177F7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:53:39 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id e6so11110834lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akqEA3XVlJP6CsHUmH2x+Vl2VjXEwsRfhBeplq7I5js=;
        b=iIoytf8nnej/9EF86kicMlpC0er7+/EfmV6VTPgypAzgfdhlDNa0262L/qfT1XIaKc
         CC4oZ+BrMtEsG9jq8nDvYKx7O4JfGygqOQ4U3DyyK4ZWyPkSd1GaPgcvns7RO6ghbC3P
         L/o2N4kt6kdYNfVJqrbMjzKaaAAWbt2e4u9KoA8gB1RjF+cou0Xkpil2acNZFvPmIann
         nbdVho7g9IerKpa8IYBFHql5bDbJwF2tsKKntC6CsYGjZbw07aJRFy21YsBIhm/C0JBm
         +/MQx6WjfZOoizhTLu2reGHjpPYcgEWiZPnnKFVjBvjJn/tZqyCtX6Udzerx96JG16V2
         vZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akqEA3XVlJP6CsHUmH2x+Vl2VjXEwsRfhBeplq7I5js=;
        b=zKJnW8wZfD/fPzuQxLXV0LcxAE1KMSvZAUUjw5gBTT+AzGhsnJoHc/CrPri7VkmEW3
         ay/L3sUuNHbjdMVJIu9FxBoN9lBoAqxERKLQro/UdZPAfndz/VqmJrPrV/NZ2tCMIv7n
         ZvFW+mxWYfpmOs4XVmo26uBLpCc5uekwysOZFKDkYgrsqxKP/93M5TdnRIW0F+SHZozy
         12N1pBdk1wzA8KCS0X+7ys7QUFWEco+NV1OaQXJ41jxX9gfe86jHbM2KCUQDIrb3fZNS
         vh9TyDZ/Fac9YK+mj5qAs93FTexzSN4K+YEsmCiJ2S/DFNuFs/Sj/3JdIqcsbLElFYe0
         buzg==
X-Gm-Message-State: AOAM533TugmrLKl2s64BJejxVdxYVz7hYhkNbS5xAqpD3bodiK8SWVv9
        q9cg8r4lIudwhQ245GOeiuKbww==
X-Google-Smtp-Source: ABdhPJwKHzo0rcHzciMnNdCUz38zMpoqnBg06OKVULk6PAZBBi+2dKHGOmEH1KBnPwCUlqBNlVm2fw==
X-Received: by 2002:a05:6512:965:b0:447:8cd0:48b9 with SMTP id v5-20020a056512096500b004478cd048b9mr7242634lft.672.1647042817399;
        Fri, 11 Mar 2022 15:53:37 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 8-20020a2e1548000000b002463639d0f2sm1967691ljv.68.2022.03.11.15.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 15:53:37 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: gnss: Modify u-blox to use common bindings
Date:   Sat, 12 Mar 2022 00:51:17 +0100
Message-Id: <20220311235119.523374-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311235119.523374-1-linus.walleij@linaro.org>
References: <20220311235119.523374-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This modifies the existing U-Blox GNSS bindings to reference
the common GNSS YAML bindings.

Fixed an unrelated whitespace error while at it.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/gnss/u-blox,neo-6m.yaml        | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
index 396101a223e7..5dffe722777f 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
+++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
@@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: U-blox GNSS Receiver Device Tree Bindings
 
+allOf:
+  - $ref: gnss-common.yaml#
+
 maintainers:
   - Johan Hovold <johan@kernel.org>
 
@@ -29,16 +32,13 @@ properties:
     description: >
       Main voltage regulator
 
-  timepulse-gpios:
-    maxItems: 1
-    description: >
-      Time pulse GPIO
+  timepulse-gpios: true
 
   u-blox,extint-gpios:
     maxItems: 1
     description: >
       GPIO connected to the "external interrupt" input pin
-  
+
   v-bckp-supply:
     description: >
       Backup voltage regulator
-- 
2.35.1

