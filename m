Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA7558F02F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiHJQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:16:42 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12C3642EE;
        Wed, 10 Aug 2022 09:16:37 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id q124so12542478iod.3;
        Wed, 10 Aug 2022 09:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ZagmBS3RLt2DXFkUdXpb10O2Q5NOyVHzikxsSq4fGZA=;
        b=M4q/YO/6tEPsFQEMOXDgJY+zfEmRW4whGGIt8QEaS/r30E88wyTrPdbxtwJJAkpVLh
         cpTgw8EASQJe/BuVQtP524bL/9Kp8+GAf8JvO2quMhpYolv2vTN6YpoErdqQSnsnjiHV
         dEhflEk5qu+McL6NdZA+JW4wSeJaVb8PmhwjSEkfFtiMZW4obiUHH6W2ZvIZOptb78G/
         Cy5+aYIiBrQb2cb4m7OjoBdzZIw4hlRUdW/gLnLVcWxEsgHkaGGKX5MzI/SVgD3CoYML
         vPzYodHiYngsTLIwQtoZDrlPXbYxCg2JPZN1elR6HRxRUjN+V6UiqM2g9phFnGETdfnD
         ol8Q==
X-Gm-Message-State: ACgBeo1yVHFBhsqyNPPB3g2OTUlfwAK9jTRJKuNJJ1LlsyJMuuv/QQb7
        mj+qk6lJYWXPC55/+eME9w==
X-Google-Smtp-Source: AA6agR4kCFOTWJkv/aLqwv49A93iQlmHKnG0uw1j2GURDbroSYw9a37PQ3f8uQ610PQLJqel4WWV9g==
X-Received: by 2002:a6b:7412:0:b0:67d:1da6:b498 with SMTP id s18-20020a6b7412000000b0067d1da6b498mr11392424iog.14.1660148196881;
        Wed, 10 Aug 2022 09:16:36 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id z17-20020a056602081100b0067885c5fd94sm2496974iow.29.2022.08.10.09.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:16:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Convert Aspeed SCU to DT schema
Date:   Wed, 10 Aug 2022 10:16:33 -0600
Message-Id: <20220810161635.73936-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
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

This short series converts the aspeed,ast2x00-scu binding to DT schema.
The binding is already in use in examples which unsurprisingly need fixes
with the schema added.

If someone wants to convert the remaining child node bindings, that would
be nice.

This is part of getting rid of the remaining ~40 cases of compatibles
without a schema in the examples.

Rob


Rob Herring (2):
  dt-bindings: pinctrl: aspeed: Add missing properties to examples
  dt-bindings: mfd: aspeed,ast2x00-scu: Convert to DT schema format

 .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 110 ++++++++++++++++++
 .../devicetree/bindings/mfd/aspeed-scu.txt    |  48 --------
 .../pinctrl/aspeed,ast2400-pinctrl.yaml       |   6 +
 .../pinctrl/aspeed,ast2500-pinctrl.yaml       |   4 +
 .../pinctrl/aspeed,ast2600-pinctrl.yaml       |   6 +
 5 files changed, 126 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-scu.txt

--
2.34.1
