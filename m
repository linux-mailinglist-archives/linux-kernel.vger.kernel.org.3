Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34F155ECFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiF1Sto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiF1Stm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:49:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA941248FD;
        Tue, 28 Jun 2022 11:49:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id cw10so27669631ejb.3;
        Tue, 28 Jun 2022 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ObwhxGoXe2ARX6DreYdA3iy7rl42wiy5qX/jBWrSpM=;
        b=nVGPtX9pniV/ybRejCUwJ7N9XYru7cWW5qzGh+AqY8r9tZZsUf9eDP8ACkL7Ylnh77
         qcP5ANLB+fYXAwnzbpLalaxIvQnz7SxhfXFsejmUIoQXWDj6jFPgVuLl9lNEu5SJp8k7
         CAVYc+5O2CVvaEArqAd7yDh3LTLBhT5pMEsxPWvmMPn2z18Z+0jlIKBzF4TgUXlYPlDk
         91YUJBZE+1Ilhqp5SWx9guw20ewvZel8IbfMQiMy57BUisnkMCx8Z1y78YJSq5hrQlpJ
         C1obfYnCvy38qBBu1Lrcr0EDDVUifm0pl5Toywvj0pEyxgEdtKfRHjwXnxmhP/Hhod3W
         moRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ObwhxGoXe2ARX6DreYdA3iy7rl42wiy5qX/jBWrSpM=;
        b=xioUlA1D32acYj61dQMPZP16O2ADYCqBfudPL+c0zBc2k4CDtC80TxPl4gW3GCWsZB
         YMOnfKZPgilF4TUMZQn17L9z+46gXJQaTVXuy3vqLqWM2GdSdH4W1KK+O4B2MX9VG6HO
         bUX+4t6InNtxnYQ7DlajzErClWWaFOxi0PtJvWfx8LOEpZCMYqcT2KYrTCQRDGNpEdOe
         ehoIy6tZv5CRN0L5bJe9NKyoFLwJi/+YEhCBL/7mYZLMgaYRO8zWllHKPjP2ZKkEueUD
         oEQm0NfSMk/xhqpoCCA8X0MEdM57ObzTipkbONyjzhl/JvR/UmdwQ8lSVV25SANs77eD
         xTAA==
X-Gm-Message-State: AJIora+TbjQklnbnk9WbiAfqtOAAKjQ5AywJ4yfCdAiECU2fCQk9wTK1
        tAp6AP1j8Nb3JLqrK4oTQQw=
X-Google-Smtp-Source: AGRyM1t+WIYcP7ofsz0WZlACCfJz8MlGeYIB1VazUOXiK1PyGbMd+9sYo6v4vwUtXqoYKfii2vXGmQ==
X-Received: by 2002:a17:906:2bc2:b0:726:d02f:dea with SMTP id n2-20020a1709062bc200b00726d02f0deamr4392270ejg.60.1656442180000;
        Tue, 28 Jun 2022 11:49:40 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id t21-20020a05640203d500b0043573c59ea0sm9747593edw.90.2022.06.28.11.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:49:39 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 0/4] Krait Documentation conversion
Date:   Tue, 28 Jun 2022 20:41:33 +0200
Message-Id: <20220628184137.21678-1-ansuelsmth@gmail.com>
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

This series convert the krait-cc and the kpps-acc/gcc Documentation to
yaml.

This series comes form a split of a bigger series that got too big and
now hard to review.

While they are still more or less wrong and doesn't really reflect real
driver implementation, they are converted to prepare for a fixup later
when dts and driver are finally fixed.

Minor changes are done to the kpss-gcc driver and minor fixes are done to
the various affected dts to fix dtbs_check warning with the new introduced
schema.

v3:
- Update all Sob
- Rework kpss-gcc Documentation with the new finding
- Fix dtbs_check warning
v2:
- Fix bot error by adding missing #clock-cells

Changelog for previous series "Modernize rest of the krait drivers"
that was split to smaller series (only Documentation changes):
v7:
- Rework kpss-gcc Documentation (split patch for pure conversion and
  tweaks)
v6:
- Address comments from Rob
- Fix warning from make dtbs_check
v5:
- Address comments from Krzysztof
v4:
- Fix more dt-bindings bug errors
v3:
- Split Documentation files for kpss and krait-cc
v2:
- fix missing new line on patch 16 (krait-cc patch)

Christian Marangi (4):
  dt-bindings: clock: Convert qcom,krait-cc to yaml
  dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
  dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
  ARM: dts: qcom: fix various wrong definition for kpss-gcc node

 .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
 .../bindings/arm/msm/qcom,kpss-acc.yaml       | 94 +++++++++++++++++++
 .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 89 ++++++++++++++++++
 .../bindings/clock/qcom,krait-cc.txt          | 34 -------
 .../bindings/clock/qcom,krait-cc.yaml         | 59 ++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |  4 +-
 arch/arm/boot/dts/qcom-mdm9615.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi           |  7 +-
 11 files changed, 252 insertions(+), 134 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

-- 
2.36.1

