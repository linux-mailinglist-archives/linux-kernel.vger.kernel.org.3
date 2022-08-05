Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC92458ABED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbiHEN5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiHEN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:57:43 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8774F183;
        Fri,  5 Aug 2022 06:57:41 -0700 (PDT)
Received: from localhost.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 540B91F9E2;
        Fri,  5 Aug 2022 15:57:38 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 0/5] Add Qcom PM6125 PMIC, and use in Sony Xperia Seine PDX201
Date:   Fri,  5 Aug 2022 15:57:24 +0200
Message-Id: <20220805135729.1037079-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds initial support for the PM6125 PMIC, and its power key
handling and thermal monitoring capabilities are configured for Sony's
PDX201 (Xperia 10II).

One patch for pm660 is included to fix a node address mismatch with its
reg field.

Note that this series has been based on top of:

  https://lore.kernel.org/linux-arm-msm/20220508100336.127176-1-marijn.suijten@somainline.org/T/#u

To prevent conflicts with the moving around of sdc2 nodes, presuming
that series is applied first.

All dts patches are expected to go through the QCOM DTS tree, whereas
the sole iio patch goes through the IIO tree.

Changes since v1:
- Dropped both pinctrl patches that have already been applied;
- Add -us suffix to qcom,hw-settle-time properties on ADC TM5 nodes
  (this suffix is not present on regular ADC5/VADC nodes);
- Add -state suffix to pm6125_gpio pinctrl nodes;
- Use PMIC_GPIO_FUNC_NORMAL instead of the string-literal "normal";
- Removed #address-cells and #size-cells from empty pmic@1 node;
- Removed ADC5_AMUX_THM3 / ADC5_GPIO2_100K_PU channels from the ADC5
  patch, these are unused on my board and hence untested.

v1: https://lore.kernel.org/phone-devel/20220511220613.1015472-1-marijn.suijten@somainline.org/T/#u

Marijn Suijten (5):
  arm64: dts: qcom: pm660: Use unique ADC5_VCOIN address in node name
  iio: adc: qcom-spmi-adc5: Add missing VCOIN/GPIO[134] channels
  arm64: dts: qcom: Add PM6125 PMIC
  arm64: dts: qcom: sm6125-seine: Include PM6125 and configure PON
  arm64: dts: qcom: sm6125-seine: Configure additional trinket
    thermistors

 arch/arm64/boot/dts/qcom/pm6125.dtsi          | 154 +++++++++++++++++
 arch/arm64/boot/dts/qcom/pm660.dtsi           |   2 +-
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 162 +++++++++++++++++-
 drivers/iio/adc/qcom-spmi-adc5.c              |   8 +
 4 files changed, 324 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/pm6125.dtsi

-- 
2.37.1

