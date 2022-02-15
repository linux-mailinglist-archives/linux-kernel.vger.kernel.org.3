Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE414B64CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiBOHyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:54:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBOHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:53:58 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA1ABD2FF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:53:48 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C53C6407BA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644911627;
        bh=vCuOKT3hKq+IjaxM7rehvAm5ceLZmK8BoYMkMG61/oU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=jf2A/YYd0nezH2xm+g4niLo8SRNyEU+ZMZvdeiFnjubTQIB9yrghYBdj95/eqrNBA
         iMvoighHqk0qmLPJjEeMSuWdG4Dw8x6QPPYY8HCIcXBiub6yPN27/62uzGfRpDTjdW
         KQ/GVJv2KYB8Hv7uWYYt82WAjA14Nfw29/n6mt7ZK2CTXl99cNJ6waaN7Iku45mBU1
         GQWlTVQMxw7uhzjaR0rOCbLFzJgGpgTjMPnZDrPypmxFsarJtiIE1SjbnnOkzQogYL
         OkX/YRugA+ytjrlzNM1/eEAVOQ3XgL24eNZsy7th/UEI9jxHzvYDBQe0GrG9BsCcuW
         5QcJnvvBuZMcw==
Received: by mail-ed1-f69.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso11750545edk.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCuOKT3hKq+IjaxM7rehvAm5ceLZmK8BoYMkMG61/oU=;
        b=Rcn/AkeQSpOAwFyhGA7wCqK5l/GkqMH4lzSI8C2bVv3KCIkZ2rBRv2+ee4vBcbd5js
         3Tuz4ivuqYKN0Iad0lf5cntLgs/JXA6Zh+ckb84/P6XuqkpCTVPxkc0+y1Al56OxCJij
         SplKiLtt1ic2dftHeoSOEdrZo73uGqMl6viqju+jXP3tqAeprDDynCguq87Xu0LVOCqT
         hnGbaZUeXqQ9Jg7qvjcdQEVfiaQhJgeZP7Vp0JXqZZXDdObowxz3pnJA6mEkFebbqRCl
         dhHt4+heOQV42tSHIb+TqZlY7kA/XYis1NVG+zaX6s0tfqxkBk5e4iWfVeIi7BRRxuWP
         FPuw==
X-Gm-Message-State: AOAM532TvQoULyyTf4mUyUYpnGPFnC21hjaOX/jbm0ZEAlVtLzD54Jf+
        5maiHKm1gzkc+OdHOr0FrF50fASWPCPj3M9EnFv0UV1M9eize/QZ6sXR4f7UR6PZf04BaGGi6bL
        Y6jduaGUU9mWTdmTcUrluCmkV2/Omp6tnR19fq4qRaw==
X-Received: by 2002:a05:6402:219:: with SMTP id t25mr2684627edv.62.1644911627054;
        Mon, 14 Feb 2022 23:53:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2JhPO02SHEX+eUDb7C/O7z52Cs1JN2EebnK3rICt8fJ58sqKy1PNStxSN7s4LqJO1EZq4kQ==
X-Received: by 2002:a05:6402:219:: with SMTP id t25mr2684621edv.62.1644911626931;
        Mon, 14 Feb 2022 23:53:46 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h11sm4663713edb.68.2022.02.14.23.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 23:53:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] regulator/mfd: dt-bindings: maxim,max77802: convert to dtschema
Date:   Tue, 15 Feb 2022 08:53:42 +0100
Message-Id: <20220215075344.31421-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2
================
1. DTS patch: drop, applied.
2. Regulator: do not require regulator-names.
3. Add tags.

Changes since v1
================
1. MFD: Use absolute path to schemas.
2. Regulator: skip properties.

Dependencies
============
1. DTS patch: nothing depends on it, sending here so Rob's automatic
   checker won't complain about DTS.
   I will take it via Samsung SoC tree.

2. Final MFD patch depends on regulator, so the two last patches could
   go via Rob's, Mark's or Lee's trees.

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  regulator: dt-bindings: maxim,max77802: convert to dtschema
  dt-bindings: mfd: maxim,max77802: convert to dtschema

 .../devicetree/bindings/mfd/max77802.txt      |  25 ---
 .../bindings/mfd/maxim,max77802.yaml          | 194 ++++++++++++++++++
 .../bindings/regulator/max77802.txt           | 111 ----------
 .../bindings/regulator/maxim,max77802.yaml    |  85 ++++++++
 MAINTAINERS                                   |   2 +-
 5 files changed, 280 insertions(+), 137 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77802.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77802.yaml

-- 
2.32.0

