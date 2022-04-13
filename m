Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B8A4FF823
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiDMNuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbiDMNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:50:01 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F8E606F3;
        Wed, 13 Apr 2022 06:47:40 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id q189so2089513oia.9;
        Wed, 13 Apr 2022 06:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kY4KD4feZOwNxnJHGRcEBGCcWQX3CZ6tu6DSxlhTaqw=;
        b=cwRKaoaEoAU3WDIa1oeFyIpt4Rck6E4JOKDE/2GOz4Lp/MISMFlNCeMo8RqbMRMaMw
         srOtWFw3u5I3733GXJZd+VJn9bl4YV6rJb23i2C1qMufXmDAq+9Et8jRoQ+Rre+Mx97y
         aJS46Ej8n9l5nXOzaF28GvPQMRPl6q8WwRNpEiKNd1Qy/QgxON7weDuI+fcV6TjvyRsl
         gcQsdyOjy4nii82qNhJkrNALWT3lV3v2FzBX18GCo7HNjhCCeWWjLcBkxXXCbhH3vzKn
         vVxgowISIg5As7SHy4506aGZskpK0yRKO6taiWVwqyOtpZB6e1Q/RzqFbz1H02BR/z11
         3lAA==
X-Gm-Message-State: AOAM530qTS6opEwM9esvab2vLnhxXpYCXnnjKk2edI+E0Rs0Qq7qXu6c
        JzCsCz0OaM2WpC5EoEY7vQ==
X-Google-Smtp-Source: ABdhPJw+4VxmUFfbEyTc8Y5lYXyGX9A5evtVNQy2ZfeY05If1FDbGWEpaoutUHePvPYQLbsVqxbSrg==
X-Received: by 2002:a05:6808:168b:b0:2f7:338b:7a55 with SMTP id bb11-20020a056808168b00b002f7338b7a55mr4181281oib.133.1649857660264;
        Wed, 13 Apr 2022 06:47:40 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id x24-20020a056870a79800b000e2e53716fbsm2850276oao.31.2022.04.13.06.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:47:39 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: hwmon: ti,tmp421: Fix type for 'ti,n-factor'
Date:   Wed, 13 Apr 2022 08:47:29 -0500
Message-Id: <20220413134729.3112190-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ti,n-factor' is read as a 32-bit signed value, so the type and constraints
are wrong. The same property is also defined for ti,tmp464 and is correct.

The constraints should also not be under 'items' as this property is not an
array.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml
index 36f649938fb7..a6f1fa75a67c 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml
@@ -58,10 +58,9 @@ patternProperties:
         description: |
           The value (two's complement) to be programmed in the channel specific N correction register.
           For remote channels only.
-        $ref: /schemas/types.yaml#/definitions/uint32
-        items:
-          minimum: 0
-          maximum: 255
+        $ref: /schemas/types.yaml#/definitions/int32
+        minimum: -128
+        maximum: 127
 
     required:
       - reg
-- 
2.32.0

