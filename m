Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20358463A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiG1TIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiG1TIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:08:21 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4F07647C;
        Thu, 28 Jul 2022 12:08:20 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id 125so2094650iou.6;
        Thu, 28 Jul 2022 12:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=v9wHqg56H+uoOIrL9eJ984x2nTDhBoLucd/ILwvblVU=;
        b=T0fc9j0+VxsRROMpe9+vPg9P8OQ7T3PjszvsAVptuQCGyXQpEkheWbEFFc7JybGuS+
         ZR0ie+ga8tVbbzbLunzqYz+5phDgU3o/OyV4M/1rgBZC0rhQMre6ULTRBzTfLZY9mSMY
         57myQI1Lsz4LPFNnKAuAepXshRH+/egr0oOu6LW+fw/kHwrJbjAnF5GJWzfxmDcHWmdb
         I64qJYtgKfOL/CQ3oV4wmknsqfg+Pdl9AxTIvrBGGglEJuefSP8vQOuiBn03cOxLxe7V
         c/Sa5XKdFeeq//vavFAbBL55tFaru8w2Gt9/QQHTl59aV8osfB+biviqmWDnReSBoVN6
         GXWg==
X-Gm-Message-State: AJIora9rN0iC0pJiHf9VhNJ4IXuuAQ3LbOogqtgqqeJnVHwVh5sEMs14
        18M8gIXpjgdHfm8TEdb1Lg==
X-Google-Smtp-Source: AGRyM1sVNmY9MfcHctmxos7tipWmYpxdT/kEnj+TXY/uecZIlKiMd68IQMb2q4jLInK0H3OXwkRL1g==
X-Received: by 2002:a05:6638:3282:b0:33f:6ed0:4c83 with SMTP id f2-20020a056638328200b0033f6ed04c83mr105725jav.96.1659035299715;
        Thu, 28 Jul 2022 12:08:19 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id l16-20020a92d8d0000000b002dd0cb24c16sm626896ilo.17.2022.07.28.12.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 12:08:19 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: mailbox: arm,mhu: Make secure interrupt optional
Date:   Thu, 28 Jul 2022 13:08:10 -0600
Message-Id: <20220728190810.1290857-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secure interrupt is only useful to secure world, therefore for NS
users it shouldn't be required. Make it optional.

This fixes a warning on Arm Juno board:

mhu@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4]] is too short

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
index bd49c201477d..d9a4f4a02d7c 100644
--- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
@@ -57,6 +57,7 @@ properties:
     maxItems: 1
 
   interrupts:
+    minItems: 2
     items:
       - description: low-priority non-secure
       - description: high-priority non-secure
-- 
2.34.1

