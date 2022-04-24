Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421AA50D2A1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 17:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiDXPGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 11:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiDXPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:06:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107831632E7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 08:03:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d6so10624471ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZgdjt03EFmKkCkALdaRUu9j5orxJYcBeTCfsLBxk8A=;
        b=e79ORiAutXKpfRKfDI4jXkdPYCMgpBeTvyplaO+1daTM2LEQLNjQDBuki3dPzftEbT
         GeqbES3KlYcCt9jbS8fdgYO84BMtLoYAFxws1eeKquJru9TKMDP7yrYT9BaLthSRO+Aj
         P/JOyv/te+KN67fq/EL8gGk11S21wp5KVo/RgFA7vLNXQcUwMZawImHOtms4IqKdPIRC
         YSYII2ER/jGF0nsTT7f9ba3JDw7PBtP9JfoeOSLC/h/aVBLn1j8e/ntS3A2NKc84EfXx
         VXWJVqVKKBEb6yeaRcj4ws7cKTsq3dXdOoKXkFfqoYbnzN06V/L4a/UOGfF1WBukjaDr
         S0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZgdjt03EFmKkCkALdaRUu9j5orxJYcBeTCfsLBxk8A=;
        b=AAxcetVQ5oaF4uQL6CPSUnuRs5czvcOaSZilF5U84Xy9RCjOnAVb90CA3cJkN/a4tv
         O825D1iDT4DdsTNwySYxwhGmTn1cFu3shO5spCwjp9gLItYIRvtutLjIlZXSGricHC86
         H8ELUNXajJbYwyaBRsXdzcl/BvtGpAnohJ5mQ1B21LlH1zeqPCGC14C24hEHyFEmfJrW
         2biFCgl8u01h9Dzlq4RLBo6GIUFtBD8iqh1sVps7B2XkgLpLFYTfgyni6KmGUXgVxbzE
         2NlDnaaWfdzd2MeUQcOE/CieuarOqOYCmwGu5AZKWw0zSHoYRAF9XPlhe/p+6Wtu4rn+
         4rrQ==
X-Gm-Message-State: AOAM532EfNQPr27SrwsOKmbmusEMZhicpu7BXf27e7PiwgD0DFlsTSE0
        94Cl6IfEARy7Z0Ehf3drypZVKw==
X-Google-Smtp-Source: ABdhPJytUEtWPCyxY1vXwS1p2kyE6foHlshe66Lm72wo7JRHSm6EBgDpEJrg4kT5X1AqveMjrWjE1Q==
X-Received: by 2002:a05:6402:370c:b0:425:a9c4:88c4 with SMTP id ek12-20020a056402370c00b00425a9c488c4mr14454907edb.190.1650812616952;
        Sun, 24 Apr 2022 08:03:36 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y23-20020a170906071700b006e8a19cefa6sm2655165ejb.106.2022.04.24.08.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 08:03:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: timer: cdns,ttc: drop unneeded minItems
Date:   Sun, 24 Apr 2022 17:03:31 +0200
Message-Id: <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to add minItems when it is equal to maxItems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/timer/cdns,ttc.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
index c3386076a98c..7d821fd480f6 100644
--- a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
+++ b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
@@ -17,7 +17,6 @@ properties:
     maxItems: 1
 
   interrupts:
-    minItems: 3
     maxItems: 3
     description: |
       A list of 3 interrupts; one per timer channel.
-- 
2.32.0

