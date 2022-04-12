Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12C04FE450
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354030AbiDLPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiDLPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:07:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C3E5BE53
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:05:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e21so11647642wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AU2XsmDlDNlX0BEIJLBYiWWgvTto/3B9fgEktWGlYes=;
        b=FLvdqRwxsxx8Xo/stue2ji1qIfkqVdTAjxTS4EXVFaBypzDQTGplbAch/Ak2V+kLAO
         1VSMTefrGAQ8MwRJM9lsr/J1AZ5q7x33iM3UKBRn63jlvQSSyuLOCPbubYe8xOPzCY0S
         CZAfT9NJWSAKvXuIZlHOsKDY7zua6SrVtoyS42Ymh5XNMQiUYasLIjio4vYF3T6FUmf+
         DXC7rNP1FKqVsxUMzPoJE3mIANYsQp4U2hnDwClCb0ezUCJSlojSetiiznwCkfsPLoi8
         BQQE+P3W4xSrSR0p7HD4UOCeshOvLd6Yz2oLZqKUZppDnJV3WGLPTPJm7nNzIcMS3piu
         bPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AU2XsmDlDNlX0BEIJLBYiWWgvTto/3B9fgEktWGlYes=;
        b=AkK/yKAg7E9zBbtd8ynyZ+xYflCWvWyXKPLjRZcqahVu3Z3lzqGkZf8e1qhiuSF1zH
         fUkSZnQitCnXPxVabVLkN8xKHzICpyCePzeIsJbiLcc/n77XrD9CZZWpn9zMkd04/XGY
         p5IRBV9ghKv8f7fw9C0hTeaAKzWccwimdo3M5C0tgcD38HmuErFdNIiwwXFLSjqiLiuj
         HtzcGVkx4IjtJJvsPOGMGfOpbycuW0+IVjMO7lVtbicCbL1O5o9HBamnFE/ApkFtbJdM
         TCRUVOPEQFbtP5iZ0nTLJ7RJ9AFEEGrevdr+zdPOUc0OMOiBIOX3nYQToTliDTHicm06
         RPPw==
X-Gm-Message-State: AOAM530slBNQiQ6DE6a4dWyOQmHXSWDe52qbFVkafycaFTVXIvRpzmRT
        gTfM+V6IJAHdbc2FGv2G/7/5bA==
X-Google-Smtp-Source: ABdhPJxd7WjJ9ssivqQBFFzu00/JymmKh7NNpLeijb6Bysb443KvBJi9evGO+J3pEkJBE/id0C1F5Q==
X-Received: by 2002:adf:ee81:0:b0:206:1b32:d6f2 with SMTP id b1-20020adfee81000000b002061b32d6f2mr28536137wro.144.1649775903583;
        Tue, 12 Apr 2022 08:05:03 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 61-20020adf8143000000b002061d8d807esm19685371wrm.87.2022.04.12.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:05:03 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] ASoC: dt-bindings: tas27xx: fix invalid yaml
Date:   Tue, 12 Apr 2022 15:04:44 +0000
Message-Id: <20220412150444.3918829-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word "or" is useless and breaks yaml validation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Change since v1:
- Added reviewed-by
- Fixed subject

 Documentation/devicetree/bindings/sound/tas27xx.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tas27xx.yaml b/Documentation/devicetree/bindings/sound/tas27xx.yaml
index 191f4bceb4ee..66a0df8850ea 100644
--- a/Documentation/devicetree/bindings/sound/tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/tas27xx.yaml
@@ -20,7 +20,6 @@ properties:
   compatible:
     enum:
       - ti,tas2764
-      or
       - ti,tas2780
 
   reg:
-- 
2.35.1

