Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4EF55FF90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiF2MPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiF2MPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:15:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E0271A;
        Wed, 29 Jun 2022 05:14:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d2so20449016ejy.1;
        Wed, 29 Jun 2022 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHmGvcAwjMTZ68AEPuaau7yjS/xP095Vw8xR/6G9M44=;
        b=dwGDIgOVMbNkIKnimwg7JWw9QbrW9R+V4YfsFtZkjQa2W19F3y1yYwTPFpx2om0QJn
         zrMidS3DN05TabBEqA2+bwZxR4ldoSbT/kZ6Cb4I19ov28zmDdlS+7ezCn+UdayCOc4A
         L6q3WAMm45757JSo8Jq6ZXl5Mg5g16L9XtsXRmVp+Zg9ofi5m6dHWdC96i8DBZpkoDRm
         OxjhTFek+URlsjgiEUwFznOgCUWBumYNm3nPWewzhsRCT/Gk+8tUi+sIBn6m7roTSurZ
         IjLy/sCFjki9l0TaeghDdyWIZVDSGhENeB7dxgYoJYWSQexe2UbaqCA115pbvvdV+zS3
         BmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHmGvcAwjMTZ68AEPuaau7yjS/xP095Vw8xR/6G9M44=;
        b=j7PGYgci5lcJ33lRUN0Ncg44kKMNkjaNJlyFTYBxvZfcgOv6E8CY0kCfrpaQvhlAaq
         OkLAB+P6/O2DjVLYg2RP3YoT/39inLdWncY23vpKowy/GPk84Zs7KnA3Bz6TROSom4sZ
         3tszTxsOMABtk74tzZvWLktqnxBjIZcxCwku7EyfuFlbkpShirPHpz9/z6SnKXc7/HJd
         KgZ4hrJ8NGgtYBWT6z6OBjivlbDV6Ib2snT+mTdRtxMJYdtn4QgUJBiwG4C1bsentXnL
         znwmctvUT5Zc3w2DGtoaKoeGjA/hMrrVkWz2rd/t2OnSAVZfY9ICbl2GyQpXgQdFkp0O
         ZCrQ==
X-Gm-Message-State: AJIora9JALvfbaA5+ZEi2IAFPjmPX6HX3Bnwxsoc62l4fJvZFDMKl1d+
        /jcHBJBKavO7mCtqYJ7fCwQ=
X-Google-Smtp-Source: AGRyM1u5PhrkGHfDyxRki1JPsZ/Z3pwbf2AVbm/ZgWbk+Mc5QHbT+s6OKfJdPObq/CpLZCLjsQn1uQ==
X-Received: by 2002:a17:906:70c8:b0:726:2b17:7b24 with SMTP id g8-20020a17090670c800b007262b177b24mr2994266ejk.333.1656504897903;
        Wed, 29 Jun 2022 05:14:57 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id l23-20020aa7cad7000000b004356afc7009sm11224421edt.59.2022.06.29.05.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:14:57 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 0/5] Krait Documentation conversion
Date:   Wed, 29 Jun 2022 14:14:36 +0200
Message-Id: <20220629121441.6552-1-ansuelsmth@gmail.com>
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

Also fix kpss-acc dtbs_check warning.

v4:
- Fix error from kpss-acc schema
- Fix dtbs_check warning from kpss-acc
- Improve kpss-gcc for apq8064
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

Christian Marangi (5):
  dt-bindings: clock: Convert qcom,krait-cc to yaml
  dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
  dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
  ARM: dts: qcom: fix various wrong definition for kpss-gcc node
  ARM: dts: qcom: fix various wrong definition for kpss-acc

 .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
 .../bindings/arm/msm/qcom,kpss-acc.yaml       | 93 +++++++++++++++++++
 .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 90 ++++++++++++++++++
 .../bindings/clock/qcom,krait-cc.txt          | 34 -------
 .../bindings/clock/qcom,krait-cc.yaml         | 59 ++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi           | 21 ++++-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           | 12 ++-
 arch/arm/boot/dts/qcom-mdm9615.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi           | 15 ++-
 11 files changed, 287 insertions(+), 134 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

-- 
2.36.1

