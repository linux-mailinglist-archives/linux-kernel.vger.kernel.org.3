Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8745150E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379228AbiD2QcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379148AbiD2Qba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B99DA6C7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 129so4941928wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n6UdGjglGGl2o68okNMCWRoHD27qYPYjCIK44vNqbmw=;
        b=mLR8GE0xljfHjRwIpR00IuUH4ajV5rkAbtuzZQWZ9ye1q7WdeOW9nbqXgQgAoD+if1
         2IbJ4TfCWai3QtRKqlIYYyaairHBF0YBL2QcVQdyzoMF5vSLpAA7sQbWvV8+dEsVZglU
         XI5JM4Otl8bKjyR+tQ0H//pa55qrA6RmQjtexbAmmXmSpqb0s8K5dJKnrsX6fIqN4lyY
         KzJ1irL9de3rUIHd4Ltcn7BC7QcWqlqjdZp2d4pVF8b4tA4XgFp5s3TD8VLBcxuBP6sq
         gt7z2MhnLm+Dh90oyaVV7i/EAOo6inFS8FeAUGVkmYnyimYFxHpDhJq8cYhVu6JWRJE5
         ukwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n6UdGjglGGl2o68okNMCWRoHD27qYPYjCIK44vNqbmw=;
        b=Ri+Dzlyt/criczKfNxtJBWcW6x+u6bESUHrYRFLcsPfb2F9UjpH5IytRxZaqhVWgWS
         FmmJJB8gutDmEckrEwNGECuNZ9xNyPiiwLzNDH1BPYa4N8pb5SjdX4ZNCTKaCAuLO/qF
         jM0qud8YnsvCo5DTyhfKvq+7PaYJCcwo9L4gr+JIHkwi+ksa2ufg3AW7U8uo8r4TsiLE
         EEFWfQ+frj3D3eOnxRYNZ9UQ3EEwc3zTL7/H1Q53e5aiDOSqOlK7d+h2YViXyNJzMrvk
         7vOBjk0DtCRzzkO9OTZuFK/5w5eyvnMzagF30AXmGJ5GaugameGH/+5lZtPk5CVY4++S
         y1Nw==
X-Gm-Message-State: AOAM531vsMv+oZ+ZRCAqBrTwNlMDVxVKe7G/3nWQ0E6Yof91pDawunKg
        t+zGqmysZ8VJRunrj1Yq2YAJJw==
X-Google-Smtp-Source: ABdhPJx9EL0kst0SGBzlo9RFppStnRTgrHv9x7iJWPywk+HlWQU3e8LLzGwqzT+lXRRJqXQWhOb8ug==
X-Received: by 2002:a05:600c:a44:b0:38e:3ce3:3148 with SMTP id c4-20020a05600c0a4400b0038e3ce33148mr3956407wmq.26.1651249689799;
        Fri, 29 Apr 2022 09:28:09 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:28:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 14/16] dt-bindings: nvmem: sfp: Add compatible binding for TA 2.1 SFPs
Date:   Fri, 29 Apr 2022 17:26:59 +0100
Message-Id: <20220429162701.2222-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Anderson <sean.anderson@seco.com>

Trust Architecture (TA) 2.1 devices include the LS1012A, LS1021A,
LS1043A, and LS1046A. The SFP device on TA 2.1 devices is very similar
to the SFP on TA 3.0 devices. The primary difference is a few fields in
the control register. Add a compatible string.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index c5d7375b840a..3b4e6e94cb81 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -18,8 +18,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,ls1028a-sfp
+    oneOf:
+      - description: Trust architecture 2.1 SFP
+        items:
+          - const: fsl,ls1021a-sfp
+      - description: Trust architecture 3.0 SFP
+        items:
+          - const: fsl,ls1028a-sfp
 
   reg:
     maxItems: 1
-- 
2.21.0

