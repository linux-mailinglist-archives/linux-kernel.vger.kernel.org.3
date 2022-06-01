Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B424539E19
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348855AbiFAHTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350290AbiFAHTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:19:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E9D4F9DE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:19:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n10so1858756ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nAMM4lRuazejy0EDJVvU8shLpINg8wAqjAlfsJ24pMs=;
        b=MFhEN9UtsamUd6w8K2RVOWB94T0PodLHRCO2sIU63o/34w555v55HCkvO11Lh/RM0a
         3+VPXnzbdjMQd00RL4JJvKoFgTTFha+byS9O5dECxgzSALna9VVe9xpuKCMkIqroIlOc
         BRmibRDM9bpKF7umvnxkOKrL2GzITJwd7DvpKna1ZXHlcyGng4lOaFv0pnJ/5Yeh2+Do
         JNX9kE13mnSKtoZBhPyVniz45n1dqdAr9l1hloDscFsHII4s5xC3OkOSdLsrBJoRGTmU
         3JEquJhaX13Nh7BWl6+zOWV3qoOvXplE1Ezgbi22YtzGmge2p+dcVWRRUKNOIF24MWT4
         dh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nAMM4lRuazejy0EDJVvU8shLpINg8wAqjAlfsJ24pMs=;
        b=jck2mIwkPsZj0gStW2UC6oHxHdqAj1qoBOUoMMeTQQSrP4XDRuE2HzFIJ/UZXqzcLr
         LcmbXFLzbM6+J9fvQIYUMDn/6nTI1mO7g+hlKkAl4T6s6gF1EcO/h9zd/aHbCbzOZ1jw
         FKpKz1LDF/8VwPn7v7Kjj+A2X81MhSY0TEo/sfA+Q4VVjPo1ceg0eEahPyC8bBiU4nZO
         ql5qk5j9MFE/L02wH+D3kMtMVGT41kmGW0ERuOXTgJXHotg0HSW8WzKuR3ZWJDh7pCkj
         nq5DvGn/5HQP+9xqHJG7F9RQsHl7PA0C3LKm9FK/sgbpjGsoJr9HtNenBxt53DvUC82G
         2wUA==
X-Gm-Message-State: AOAM531Vk0tXK+b59kikV8YZyi3Skw34Ib/EDiY9BAEqfjKAGVPbsZSo
        WjA971/uhlArlepNmQ4tO9lRVg==
X-Google-Smtp-Source: ABdhPJx3HWipshhxFlcuIAl26zCYvNK1o9wkgX//LLgCC/LPRIUoXZ26kEjL6jpWBYjstExVcgbU1A==
X-Received: by 2002:a17:907:6d0e:b0:708:3ada:184c with SMTP id sa14-20020a1709076d0e00b007083ada184cmr318627ejc.192.1654067967665;
        Wed, 01 Jun 2022 00:19:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f27-20020a17090624db00b006f3ef214dcdsm358486ejb.51.2022.06.01.00.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 00:19:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] dt-bindings: power: supply: summit,smb347: use absolute path to schema
Date:   Wed,  1 Jun 2022 09:19:11 +0200
Message-Id: <20220601071911.6435-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
References: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference regulator schema by absolute path, as expected by DT schema
coding style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/power/supply/summit,smb347-charger.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
index 20862cdfc116..ce0bca4689f6 100644
--- a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
@@ -82,7 +82,7 @@ properties:
       - 1 # SMB3XX_SYSOK_INOK_ACTIVE_HIGH
 
   usb-vbus:
-    $ref: "../../regulator/regulator.yaml#"
+    $ref: /schemas/regulator/regulator.yaml#
     type: object
 
     properties:
-- 
2.34.1

