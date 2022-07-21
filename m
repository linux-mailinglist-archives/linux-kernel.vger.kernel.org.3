Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E7D57C310
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiGUD7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiGUD7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:59:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F60785B6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:59:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pc13so440714pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=FpCN6cuo3wGN8VLDIxaXzrIlxYSpuA2WvWsngU/WjBs=;
        b=6CqRoE2medltiy32wKKnyJ2ik78jFg2j/iZEZksAE7Qos1GB8p7uolj5BDcnaXy/7N
         ZSm4bOiegVKXKqIb1uG2nJrdJmdXbnERqr/YJWm+B/XRQpjaz03MFGu1TLHO44V4/j5Z
         wT2MGPj9stFgw3ESMjiIyzv7+ybZQcFSOpDgv81gjG9JM75H2S+JhmSfqvAZFTboIr97
         JR2SvOxa63Odeq+kEhivfAKdI2S0Vg9QxAKlMZuKkwYBR2ALjiMjb/V1X/OZrq9QxNOx
         r1DL+xySIElAoOIlZOs4GqnIb6b+MAt1x9FPChBpFGjYYiSShdruV7y/4CDaG6+d+DxB
         eNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FpCN6cuo3wGN8VLDIxaXzrIlxYSpuA2WvWsngU/WjBs=;
        b=mwPpmhrFgOEFQNaPwy3KvcOviLyPS1eV387W/naF4wkAGJUIuyr2e/X+5Iqi/tIGnk
         OU9hIrSUy85xkPdqKjiFmTwjr0tpgQiwvYYbNd3Jz/jWeXPYJRirBlQ7xF6IuLW4x/x4
         nhpZenxqwAfcL8l5cYEmstAPzj8Dp7rXPrH/SC3EHmixCP6YerSZRyqKJIwvzXirYj/n
         RHvp/N6m8aM4DgAx8wSrWYs48h87OS//PiG/xNKNy3byo4BduPlz/jEq3os9xX8wkQ1+
         baR09TxJXJozyzRwkBYmzADZRja5FHt9QTY0t5t6CYUBPDqFq7v/1NNLmBkl1jwQMWPk
         2qKA==
X-Gm-Message-State: AJIora96oe2Y1j/1mMHI9aVTRvbJ310djRzo8CBgqYkBa8yeNfZPjMWc
        siFI+Z2fUEgyciuwwJBg/Si4xVsJqFlqVJJw
X-Google-Smtp-Source: AGRyM1uircHRNjCYqcs7yQK4sM72ZtHPGp0hI3pNpMZZnV5gZRIWqdEXHvokxx3aZe7JIYB8oHQlnA==
X-Received: by 2002:a17:90b:1644:b0:1ef:88c6:6e39 with SMTP id il4-20020a17090b164400b001ef88c66e39mr8990491pjb.122.1658375948373;
        Wed, 20 Jul 2022 20:59:08 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.130])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090abd8f00b001f21f7821e0sm299956pjr.2.2022.07.20.20.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 20:59:07 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: qcom: Add SKU6 for sc7180-trogdor-pazquel-lte-parade
Date:   Thu, 21 Jul 2022 03:58:42 +0000
Message-Id: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SKU6 is LTE(w/o eSIM)+WIFI+Parade

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
---

Changes in v3:
- Bindings and dts in the same series.

Changes in v2:
- Put sku6 before sku4.

 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
index 764c451c1a85..767cb7450c0d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Google Pazquel (Parade,LTE)";
-	compatible = "google,pazquel-sku4", "qcom,sc7180";
+	compatible = "google,pazquel-sku6", "google,pazquel-sku4", "qcom,sc7180";
 };
 
 &ap_sar_sensor_i2c {
-- 
2.17.1

