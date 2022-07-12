Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD8571E62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiGLPJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiGLPJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:09:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF6DBFACE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:02:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r9so6400278lfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0JMsgwrzl53fYOxR7k3ixUiyWik/lqSN3mYqAMfO+L4=;
        b=cNc3pUii//sQxSRcYIYAyZJRYHUkbhLNA2u3lE0QSh7WPwhdaLWUVyCYjjecpeg7Z9
         ar0MXXCBWCplEvVWxpsmXOs5pCbxX0M757/JRcv6dxQRqRqWZHaiubWeg7JSau3rvMpM
         nkFl5hw5/bv87Vx1EOqDL3OTrZTAkbVZYCw6977zUe34x7k9vupJwYKs3gmu1JJuykOd
         nbwNsB72TlqVy3GxadLxd4LBwLwMDZ5RP4ZBPGGTMXuY+jvj0TBKI71SDcDPWFZE1HUW
         NZli0QSGV/rp1O7P+/Q/xIK7/tUR0U0k8uv9+sfHJfAoiDPMhH7VrXDGQ1XQIk+x/jm5
         EdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0JMsgwrzl53fYOxR7k3ixUiyWik/lqSN3mYqAMfO+L4=;
        b=rXCZcmTOjw0SUixDy/hgM2uZUu/K+57FWPMpraPz9XRUvHN+YkRc4xdNpxkDYrOFyp
         /DMBPObU4/9BV7BGq+873I0f8o9HCn7hz12oa6nJVzaniys3Bvswq5Lb0i6v2NTiAyQJ
         AB6XbCKo+cbhsQAnBymbYNiTbkX3EJSexA0ks6h56Rfk4ewrPb2aPjOiUBgEuNY9EcW6
         Mbd8mbri0ImqZUEBLvTaaai2rygIXDQ2+Xmv6gIKQINHkMzsX7oH8ggWjqoAGOc39SeN
         EvT7taJArS7WmIzleHAnZqUt1r52DEJF7148gTQlTALs4NYZR0FMDAHKlI6ePW0Ur+Zp
         rEXQ==
X-Gm-Message-State: AJIora/TmGFxVAfuePomDMyBbtIk7XXoRv9cYG5DIbeEHBstcaKbiHBR
        sUVekSOxuqkvP/mum0AJxY+HgA==
X-Google-Smtp-Source: AGRyM1uQYClJrHrr49xg7PgYrJOapTtgewMRLVYOuZZjrS3Y5zFru+EgawjfaxBRmVgjO0jhiIe5MQ==
X-Received: by 2002:ac2:4e08:0:b0:47f:7b73:c9b9 with SMTP id e8-20020ac24e08000000b0047f7b73c9b9mr15057627lfr.5.1657638161411;
        Tue, 12 Jul 2022 08:02:41 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id 4-20020ac25f44000000b0047f9614203esm2224649lfz.173.2022.07.12.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:02:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 0/3] dt-bindings: mmc: / ARM: qcom: add MSM8998 and cleanup driver of_device_id
Date:   Tue, 12 Jul 2022 17:02:16 +0200
Message-Id: <20220712150219.20539-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
1. Add Rb tags.
2. Rework driver patch (now last in the series), after talk with Doug.

https://lore.kernel.org/linux-devicetree/CAD=FV=WGxQF4vPuRi7kWKoqTpe0RFsgH+J82C=sQbmncK_AFpw@mail.gmail.com/

Best regards,
Krzysztof

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>

Krzysztof Kozlowski (3):
  dt-bindings: mmc: sdhci-msm: add MSM8998
  arm64: dts: qcom: msm8998: add MSM8998 SDCC specific compatible
  mmc: sdhci-msm: drop redundant of_device_id entries

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  2 +-
 drivers/mmc/host/sdhci-msm.c                  | 25 -------------------
 3 files changed, 2 insertions(+), 26 deletions(-)

-- 
2.34.1

