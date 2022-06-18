Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4908F55071B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiFRVkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiFRVkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3DBB7D6;
        Sat, 18 Jun 2022 14:40:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y19so14586514ejq.6;
        Sat, 18 Jun 2022 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SsvIUi5Mx2lkt+N5FiHvaXdtimrUSlx4XN7ieZ+PNqI=;
        b=Xn6SQ7YDy255jmHCT0Ra/4r1e/4aekKOjNILyMBbGUk603Cz3ZizrIsC/W9WeRI0cr
         BETFFGOVQxLjQTdRyP3MTBnySOBa9s0I19psP0NRv5lGeCvJ3iDm7+ilVikWJkmxsEtw
         eNezxWDw5yUAx6ljIAClJJIvrfoS38iR+B8fzOiU658vHfaBfp59BpOtXF7Q3d4p7iCv
         w92FebCLEjMssuc/uMVhXPN8Mz4vxLMSqjWgFqK8sZyWBnWS4v4aW/OIvf92qCC5bq9F
         1gn1PLAtZsBD/Cqf8yZZ1nhgatLcXz6VA9d+GIfSN0XsJcfo6PEo7gflyAbdy0UgHrqh
         ysFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SsvIUi5Mx2lkt+N5FiHvaXdtimrUSlx4XN7ieZ+PNqI=;
        b=Aj8xXHkwyhVtwc6Ug28mqvnP86KlxqDSbawpZqb1wYoZWEdDBdFZxodvlegKfFjIxR
         XQL0cuyQvdTuBt5ehYB33qiKwohZXrEilE7x/ckTMO/RukDyF8gYvcdgl8+UQQ6Sd9VL
         129hiF5nQPlYykCKZX2SLoAb8+QXPXE/1pwidy+EX9Fhr7Glwu59TA0BMGbyq4TCB3fl
         K2SsiKv3E5EpNte7nNaSYJi54Bij2WFzLZyDuzPZS1Hj3HUiwfw5QJXOD/ZRIw3R4CbX
         D3akM5VY1fearF+lpSTNXyhPEi9+DhRZ34aLKYhgnEOJ2DUSIxzu2CF8NJvKcFVTFEQp
         83cA==
X-Gm-Message-State: AJIora/wuSlPoBDjab3VuNqk83OvMr4oBwe8ZT2u/8xW8vXgQ/HA1TT1
        YgFVlyqM8ZUj+2OnZmyJ31w=
X-Google-Smtp-Source: AGRyM1vmc/SfZVszFum5RYiz7S8VKAtbdVhVZyu8vXNCkghou0XQh1EPjszy7/HU5TQ5sg/8RjKZqA==
X-Received: by 2002:a17:907:d05:b0:6f4:3729:8e36 with SMTP id gn5-20020a1709070d0500b006f437298e36mr14309985ejc.475.1655588401047;
        Sat, 18 Jun 2022 14:40:01 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id ff10-20020a1709069c0a00b006fec69696a0sm3784240ejc.220.2022.06.18.14.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:40:00 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 03/16] dt-bindings: mfd: add bindings for AXP192 MFD device
Date:   Sat, 18 Jun 2022 22:39:56 +0100
Message-Id: <20220618214009.2178567-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192 is another X-Powers PMIC similar to the existing ones.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 3a53bae611bc..33c9b1b3cc04 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -84,6 +84,7 @@ properties:
     oneOf:
       - enum:
           - x-powers,axp152
+          - x-powers,axp192
           - x-powers,axp202
           - x-powers,axp209
           - x-powers,axp221
-- 
2.35.1

