Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5628658EFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiHJQDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiHJQDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:03:45 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986A65655;
        Wed, 10 Aug 2022 09:03:44 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id 68so5850154iou.2;
        Wed, 10 Aug 2022 09:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pLszvMp06j4ZdOd51Hbi3XTm/T7L8XdJjW4rKKC5yT0=;
        b=FuHDwaIgZ55vVVz8ajVTNg4w61riGUCOZa+nwo+IAVNGEe55EjztDTrWWpFInKRnEX
         QHaarp7ETsCqk38kzCwMyGJjCOAErIPPOMQzQdzN77fCW4jFGMSIGg04Bk+8Pv+NoIu8
         9gSM4YMHfxo3pfSPQc/8+uF2R1e3lh2SDYt01BfWOp4fXPsd1Air1IQzSeKM534nkJ6q
         8gMYVElW05OpvwDzrfzdpaPgmPx1DRv+EgEu0PNYbcvkC3U/MbxqWavQTW+FvLSIgvUh
         h2DDmMgrT2UT8p/omzpgrqd5PD6HZLu0f/Pw7/Gpik8TwqMePf+QtL97ijkRO0VfsMLl
         kzuQ==
X-Gm-Message-State: ACgBeo2h/88fMxJWhyVfav23vMKkXdCFa/HyR5+OsaEnu68vGV53v6zo
        K6RCb0edy6JWBf4wcUgQOA==
X-Google-Smtp-Source: AA6agR4+T5TZB8tmai+ZHR92K3UgZWu/lvjnSFQjQi9/vetr7i8iQFHeQNJ/h7qEmSMf7JBs7XaLkg==
X-Received: by 2002:a02:6d1f:0:b0:33f:8d28:4d6d with SMTP id m31-20020a026d1f000000b0033f8d284d6dmr13241554jac.16.1660147423297;
        Wed, 10 Aug 2022 09:03:43 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id a27-20020a02735b000000b00341a215d3cesm7617629jae.63.2022.08.10.09.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:03:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Convert arm,versatile-sysreg to DT schema
Date:   Wed, 10 Aug 2022 10:03:39 -0600
Message-Id: <20220810160341.51995-1-robh@kernel.org>
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

This short series converts the arm,versatile-sysreg binding to DT schema.
The binding is already in use in examples which unsurprisingly needs a
fix with the schema added.

This is part of getting rid of the remaining ~40 cases of compatibles
without a schema in the examples.

Rob


Rob Herring (2):
  dt-bindings: display: arm,versatile-tft-panel: Drop erroneous
    properties in example
  dt-bindings: arm,versatile-sysreg: Convert to DT schema format

 .../bindings/arm/arm,versatile-sysreg.yaml    | 35 +++++++++++++++++++
 .../bindings/arm/versatile-sysreg.txt         | 10 ------
 .../panel/arm,versatile-tft-panel.yaml        |  3 --
 3 files changed, 35 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/versatile-sysreg.txt

--
2.34.1
