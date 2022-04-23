Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6E50CCD5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 20:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiDWSR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiDWSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:17:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63CD75E43
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:14:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w16so880997ejb.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QQpgXi7yWS28IokRF1hZIJc77EkGijmDz0iveaLCb8=;
        b=MC8QUeCbJ8dKf/gHcAYaADzDgZC123Ot+tm6LmaztwhyyXvjFJq03KZCXc8aC9JH2R
         3HlDtxxiXUoC0CUSwyZbppVl3OYQ012IH4wXbrAH04cQGukodp1/2xZQFgCdjWiyvqM5
         c76KJxPnYSLqQYBY6Rnl2KH5bbiDTXY3cmCYK1tTpK63jz/slsERUA3rpls/h2xPlfF1
         ZjvM2RWX6Q7VIZ5hDPn5qgDfMeFyQcffeu9ENyU+kstNFrifZMzSUg2GlCSALhDvtCqH
         Nh0SKgzhZkqatDBFCyfi7bqvVS4ZR+sJsH0SazID+ty2PR4CYGs/vxqQqxA0OGtZTEaz
         lhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QQpgXi7yWS28IokRF1hZIJc77EkGijmDz0iveaLCb8=;
        b=ERfWgkCKk15mhSg0gIyWgbNPrcNp2YiSCyf/5xA9WrgxuVO5cDjcp0QOhlYIpTHiQt
         JiT/20KUxa9gbf/9aEzeKUQMNDmSiKgd/LUDbLxcJBTx/4s7djfY2jN8BqXq74L4NJfc
         weyMud+DfgnKyu1g/xI7kBYBUpJs+0KCJNX/olHMA4p6Q+C3fxP+h28bL9EECXVMshW/
         DN1GXr2bV2P8/hcC4nU5sX2saxSwqMMkOdDjDzczPDtdW9ZhD6WIyXzyfrl07a8JqqE9
         JuO0E5sm1g2qRxJkEUxa+/dc1EMG0f1ZR7o5E/n9BuOUgEhpbhiPvqc8IOQ2AmmxrFtz
         PBWw==
X-Gm-Message-State: AOAM530nFcIOS07I1yKea7zar6CFFR/9N5tTmAHSkMKrSYG2lp7j1A4i
        d8KtY6fYgf9RubWu/v+iI236MdFQW7qdhQ==
X-Google-Smtp-Source: ABdhPJwV4tePH9HR8CVm3pxVP4aoIDT7zFqPWPOdE0SE57Qq/13tim0ldZ8x2mCN2amBKqVA5QtjXA==
X-Received: by 2002:a17:907:3f8f:b0:6f3:80e6:60e1 with SMTP id hr15-20020a1709073f8f00b006f380e660e1mr1432600ejc.89.1650737666294;
        Sat, 23 Apr 2022 11:14:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g24-20020a056402321800b00423e43ebb60sm2399227eda.61.2022.04.23.11.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 11:14:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/2] regulator: richtek,rt4801: use existing ena_gpiod feature
Date:   Sat, 23 Apr 2022 20:14:17 +0200
Message-Id: <20220423181419.19397-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not tested.

Follow up of discussion:
https://lore.kernel.org/all/2d124d53-1f36-5315-3877-af8f8ad5f824@linaro.org/#t

Changes since v1
================
Patch 1: add review tag.
Patch 2: Check for ena_gpio_state before accessing I2C (issue pointed out by
         ChiYuan Huang).

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  regulator: dt-bindings: richtek,rt4801: use existing ena_gpiod feature
  regulator: richtek,rt4801: use existing ena_gpiod feature

 .../regulator/richtek,rt4801-regulator.yaml   | 14 +++-
 drivers/regulator/rt4801-regulator.c          | 68 ++++++++++++++++---
 2 files changed, 71 insertions(+), 11 deletions(-)

-- 
2.32.0

