Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC5569586
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiGFWyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiGFWy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:54:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A2E2AE01;
        Wed,  6 Jul 2022 15:54:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d2so29547457ejy.1;
        Wed, 06 Jul 2022 15:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/oAWvKanO4cSeNPe/XMaWgSS54K0jHxPM6w4qmhtko=;
        b=q7SEN/NmDZonxy6H4bNWTGEeJak28goH3x+I/idgjolnE6sb5W3mpodc8EVxz+Kyia
         ijIOEAPx7Qd/Cp6PlxXF2t+D5A51tI0kSRWPw70hl0Mocibu1zqDQJxrJzDp/i1IY20U
         0XrHs94NGXE1JgzSXaqIJ/9iH4eDNfu9QCW0fVIUvWzYLSwFXkaTQRGi2S8E2qVXBVme
         1Z9KgV7eBe/a5GMgH8Dbtc2vByM/GAVxmfxz9oedYy8Man0O8SBI1xswWl8A4zeJt9Zm
         0ycz0gSTsJ5qFkZGXKGTY4Le8Hp8rI/NP+Y7oYYuD3e3Ag8qaOX0w0rOJgIrh+MoOdPD
         cm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/oAWvKanO4cSeNPe/XMaWgSS54K0jHxPM6w4qmhtko=;
        b=YXF/ihq11gC1KKdqtQY85y/EaqE8e62p3sxQSB7RRsa5y4yOk5r6AeJq6JDWuCaiiU
         hb3L686NSEwQvEYUmBWVwTmTtCjY91HGvq637evAoCSt5JY+ndYd/UuaV0vdMuyaBbBE
         iS/lEaUpxcCX7aPW388LLpQe/phj62vQKV6DhAoinfpSzgRw15dq3xOEEtqcwtQcSJuD
         NGnVaCiCsJbWvjnc346d6VQExm7Hrm+Ax8250uImFzj4S+JaF2BUTzz2lqAde5k/C7wE
         X9gCAtEhEjp4e4YTIEGLeoU7DkF1fdaJJd+TmdNKluGDCSfaU4jVMeutvdpo9P7bM68b
         kEbA==
X-Gm-Message-State: AJIora+bzPbsiciS62at71yh5MWfd60jYHGz0szglpse3AWJmOKxspXd
        IDWMk5I7s3ExSh6mKFtLCCA=
X-Google-Smtp-Source: AGRyM1vQ1g+0jc0RoV/nmvn+F+uJrgMjfoqCkmnHGFoUrxtRHa2V6jEPRbHan1Edw+3DyBbei+gv8g==
X-Received: by 2002:a17:907:9005:b0:715:76ce:4476 with SMTP id ay5-20020a170907900500b0071576ce4476mr41077848ejc.560.1657148064512;
        Wed, 06 Jul 2022 15:54:24 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id d7-20020a170906304700b006fe921fcb2dsm1767637ejd.49.2022.07.06.15.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:54:24 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 0/4] clk: qcom: Drop use of pxo/cxo_board for rpm devices
Date:   Thu,  7 Jul 2022 00:53:17 +0200
Message-Id: <20220706225321.26215-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to convert every driver used by ipq806x to parent_data api, I notice
RPM was still using pxo_board clk.

pxo and pxo_board are the same clock and are defined just to handle old
clock definition. It was discovered that rpm is the last driver using
pxo_board instead of pxo.

While updating the rpm driver I notice the documentation was also wrong,
so this series also fix that.

v2:
- Add review tag to DTS patch
- Drop clock-output-names patch
- Use pxo/cxo_board clock names
- Remove if nesting from Documentation
- Use min/maxItems in Documentation to describe clocks

Christian Marangi (4):
  dt-bindings: clock: fix wrong clock documentation for qcom,rpmcc
  ARM: DTS: qcom: add rpmcc missing clocks for apq/ipq8064 and msm8660
  clk: qcom: clk-rpm: convert to parent_data API
  clk: qcom: gcc-ipq806x: remove cc_register_board for pxo and cxo

 .../devicetree/bindings/clock/qcom,rpmcc.yaml | 85 ++++++++++++++++++-
 arch/arm/boot/dts/qcom-apq8064.dtsi           |  2 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |  2 +
 arch/arm/boot/dts/qcom-msm8660.dtsi           |  4 +-
 drivers/clk/qcom/clk-rpm.c                    | 24 ++++--
 drivers/clk/qcom/gcc-ipq806x.c                |  8 --
 6 files changed, 106 insertions(+), 19 deletions(-)

-- 
2.36.1

