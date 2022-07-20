Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64A57B8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiGTOs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiGTOst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:48:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D15247E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:48:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h9so1389772wrm.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:subject:mime-version:content-transfer-encoding:message-id
         :references:in-reply-to:to:cc;
        bh=EOTw2SZsHwugM+Ez0nEALoToqSbMZWPKVYP438H1mxU=;
        b=oMm7LoJwBASOpcAnoe5ZW0VcoBtpNp4qdQXkxDMqfsYACtq2XOkYP+zDZPKLL4wMBw
         YgIqj4c9bDXecsVxFerVyCof9sXAssTSpDgeyJzMUqvcp5rJryAbqDSHlATe3jt96iHG
         WDtXCJY7Y6NcZXZsGo3/Pww8583CYWbnViwflztE1ocPMbOBgWan5EX/aj1cCeoZuy9i
         9faahOs5YUZNPf85kg/MwQEMmex/wyjlyUCRmxo4MPNf1qV7Ep+U/pgIAQiOYRiTGjQC
         ZBxpaNtME1cHVV7UMwlhbx1u60srMx9Fp1zRqRjrcLpKx1kk1sNzoYkkn7iaHCbpVNRl
         3ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:subject:mime-version
         :content-transfer-encoding:message-id:references:in-reply-to:to:cc;
        bh=EOTw2SZsHwugM+Ez0nEALoToqSbMZWPKVYP438H1mxU=;
        b=eIhd6Mo0nAFRVfG9BslfShY0T9+3detYZh4Br2iaqX+R6yVnn7mUmCvjarhpIjxCuU
         aqZwsgvo5FibNymjqCvwct6j6lQOrKHuEcecSPibw/3EqNXKV8RvzJJflN8gVg4RkTrS
         Scss842a9E19n195S9bSxHJkBXBc47+8wuh1kU8MeNE51CC5CIkoqGadvsrYATDK/YU5
         eghDQV0SnEMn2p1mLj/tyeFVpL+0607lpmer13oPl0XGErgmIfo/n0wkJ93TGrKHhTrB
         d0FC+iSeRPbc6cZXlJTriZj4rNxwsOdR5HkSTpUsA5i8Cl8KmQmVCUWh2QW+w0VWIxH3
         yWJg==
X-Gm-Message-State: AJIora8xqZyUOiqTTwEF1BmieQV4MVmRbX8CXWH1qqXQXBSZx3w9YU6N
        Y6XRCa792LRJlDSRP2+lV/oN317Vum/CCQ==
X-Google-Smtp-Source: AGRyM1vk48vhBISpLi0CcOr9kKDWKs0EqlrNQDdVJdrT6hsTP+HmSTbFh6RCGQZsl1ZBg+vkqVqr/A==
X-Received: by 2002:a05:6000:1789:b0:21d:7279:f455 with SMTP id e9-20020a056000178900b0021d7279f455mr30432550wrg.542.1658328521299;
        Wed, 20 Jul 2022 07:48:41 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb19:85e6:1900:c639:22f8:bed9:44dd])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003a31673515bsm3321121wmq.7.2022.07.20.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:48:41 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date:   Wed, 20 Jul 2022 16:48:39 +0200
Subject: [PATCH v1 3/6] dt-bindings: mediatek,mt6779-keypad: add mediatek,double-keys
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220720-mt8183-keypad-v1-3-ef9fc29dbff4@baylibre.com>
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
In-Reply-To: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.0-dev-54fef
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek keypad has 2 modes of detecting key events:
- single key: each (row, column) can detect one key
- double key: each (row, column) is a group of 2 keys

Currently, only single key detection is supported (by default)
Add an optional property, mediatek,double-keys to support double
key detection.

Double key support exists to minimize cost, since it reduces the number
of pins required for physical keys.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
index ca8ae40a73f7..03c9555849e5 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -49,6 +49,12 @@ properties:
     maximum: 256
     default: 16
 
+  mediatek,double-keys:
+    description: |
+      use double key matrix instead of single key
+      when set, each (row,column) is a group that can detect 2 keys
+    type: boolean
+
 required:
   - compatible
   - reg

-- 
b4 0.10.0-dev-54fef
