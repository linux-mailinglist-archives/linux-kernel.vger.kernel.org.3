Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5BB4D778A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiCMTGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiCMTGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC9F4AE02;
        Sun, 13 Mar 2022 12:05:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id yy13so29628733ejb.2;
        Sun, 13 Mar 2022 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O8sAh0i3YjlYvKWfabfn4UdLz5/JsZ1Iy5tseKB2bG4=;
        b=czxUROYtAK4hsfgsXXbFmUfDqNRlnzdsN/MziKzMsbXWLs2aoef/dnTsf2q+W8V+kO
         tZzf1NU5lyukUTbvs9KEjxIez92axE0JHwozQhB/1WsUEl1eUDNLkdV9tpFmXjH1q0SB
         108xgrKljhpsEbdTnncWBkjrci+fdLoBmxZha93vjMy6YVlSdyKiME2Yx1s2ivTiF3lv
         /ry9UGen0Yx/n65BgkUlQ9Au1ufI5oB7vznDOIWGMbqTR9Kx3LW3scTTXzdG/96cnNAy
         74Xi/h7WJ+T/kO8gvti4x7QHnclPjFH097E+HAw30HUGBK/Jx5tVrJRD6CMpazHiGVU1
         ed0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O8sAh0i3YjlYvKWfabfn4UdLz5/JsZ1Iy5tseKB2bG4=;
        b=VER9nEA07J9ElQ339ZKGaCte/PnZU5DoqPHiqEO7FfpG147AKUlef7HQhkBa6lpHUF
         dhilaY5dSGZY46xGkI5r7ND7xB3+Ug+GT5DVsU/BQsf/9eW1jdv8sSD7Xbk+f3Ms3bO+
         QTAvWmDoAWLxt2Mq7Y2ugfCBAL3110hN3iLW5ntzkQTZZcb42u7UOivk3M2inM4osYxB
         g+vmju0rrNGRhKyahPzBRiBkwybmrEKoP727haYaoYt6qKvAoOVOoQpVU3FT9vVOJWjt
         7McJJNRSTxzz7isEJMv8r+75+5Oqr6kG8Ep2LlfHOhhgiUFjKW84Em7J2du31SzyLOf6
         x87w==
X-Gm-Message-State: AOAM533eYFI2xUfH5KWgcaAH4OLKgBew7GvHUah8yBYOLtFB/0LPmVAl
        +HZkrmSFwWPW1T+QXstXRAI=
X-Google-Smtp-Source: ABdhPJzeNZFkZWhTuKPfPVuyIk1NAL3F9lQTXKRNLdMpk3apUn+jBTH/T+mPIGE30tnU8iW4ibJWqA==
X-Received: by 2002:a17:906:7185:b0:6cd:e09c:e5f5 with SMTP id h5-20020a170906718500b006cde09ce5f5mr15999024ejk.287.1647198300742;
        Sun, 13 Mar 2022 12:05:00 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:00 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 00/16] Modernize rest of the krait drivers
Date:   Sun, 13 Mar 2022 20:04:03 +0100
Message-Id: <20220313190419.2207-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This is a follow-up to the ipq806x gcc modernize series. Manu cleanup
changes and also some discoveries of wrong definition notice only with
all these conversions.

The first patch is an improvement of the clk_hw_get_parent_index. The
original idea of clk_hw_get_parent_index was to give a way to access the
parent index but for some reason the final version limited it to the
current index. We change it to give the current parent if is not
provided and to give the requested parent if provided. Any user of this
function is updated to follow the new implementation.

The patch 2 and 3 are some additional fixes for gcc.
The first one is a fix that register the pxo and cxo fixed clock only if
they are not defined in DTS.
The patch 3 require some explaination. In short is a big HACK to prevent
kernel panic with this series.

The kpss-xcc driver is a mess.
The Documentation declare that the clocks should be provided but for some
reason it was never followed.
In fact in the ipq8064 DTSI only the clocks for l2cc are declared but
for cpu0 and cpu1 the clocks are not defined.
The kpss-xcc driver use parent_names so the clks are ignored and never
used so till now it wasn't a problem (ignoring the fact that they
doesn't follow documentation at all)
On top of that, the l2cc node declare the pxo clock in a really strange
way. It's declared using the PXO_SRC gcc clock that is never defined in
the gcc ipq8064 clock table. (the correct way was to declare a fixed
clock in dts and reference that)
To prevent any kind of problem we use the patch 3 and provide the clk
for PXO_SRC in the gcc clock table. We manually provide the clk after
gcc probe.

Patch 4 is just a minor cleanup where we use the poll macro

Patch 5 is the actually kpss-xcc conversion to parent data

Patch 6-7 should be a fixup of a real conver case

Patch 8 converts the krait-cc to parent_data
Patch 9 give some love to the code with some minor fixup
Patch 10 drop the hardcoded safe sel and use the new
clk_hw_get_parent_index to get the safe parent index.
(also I discovered that the parent order was wrong)

Patch 11 is an additional fixup to force the reset of the muxes even
more.

Patch 12-13 are some additiona taken from the qsdk that were missing in
the upstream driver

Patch 14 converts krait-cc to yaml (should i also convert the kpss-scc
driver?)

Patch 15 finally adds all this stuff to the ipq8064 dtsi (and fix the
stupid PXO_SRC phandle)

Patch 16 conver the kpss driver to yaml and fix some Docuemntation errors

I tested this series on a ipq8064 SoC by running a cache benchmark test
to make sure the changes are correct and we don't silently cause
regressions. Also I compared the output of the clk_summary every time
and we finally have a sane output where the mux are correctly placed in
the correct parent. (till now we had the cpu aux clock all over the
place, probably never cause problems but who knows.)

Ansuel Smith (16):
  clk: permit to define a custom parent for clk_hw_get_parent_index
  clk: qcom: gcc-ipq806x: skip pxo/cxo fixed clk if already present
  clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
  clk: qcom: clk-hfpll: use poll_timeout macro
  clk: qcom: kpss-xcc: convert to parent data API
  clk: qcom: clk-krait: unlock spin after mux completion
  clk: qcom: clk-krait: add hw_parent check for div2_round_rate
  clk: qcom: krait-cc: convert to parent_data API
  clk: qcom: krait-cc: drop pr_info and register qsb only if needed
  clk: qcom: krait-cc: drop hardcoded safe_sel
  clk: qcom: krait-cc: force sec_mux to QSB
  clk: qcom: clk-krait: add 8064 errata workaround
  clk: qcom: clk-krait: add enable disable ops
  dt-bindings: clock: Convert qcom,krait-cc to yaml
  dts: qcom-ipq8064: add missing krait-cc compatible and clocks
  dt-bindings: arm: msm: Convert kpss driver Documentation to yaml

 .../bindings/arm/msm/qcom,kpss-acc.txt        |  49 -----
 .../bindings/arm/msm/qcom,kpss-acc.yaml       |  97 +++++++++
 .../bindings/arm/msm/qcom,kpss-gcc.txt        |  44 ----
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       |  62 ++++++
 .../bindings/clock/qcom,krait-cc.txt          |  34 ---
 .../bindings/clock/qcom,krait-cc.yaml         |  63 ++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |  20 +-
 drivers/clk/clk.c                             |  14 +-
 drivers/clk/qcom/clk-hfpll.c                  |  13 +-
 drivers/clk/qcom/clk-krait.c                  |  44 +++-
 drivers/clk/qcom/clk-krait.h                  |   1 +
 drivers/clk/qcom/gcc-ipq806x.c                |  27 ++-
 drivers/clk/qcom/kpss-xcc.c                   |  25 +--
 drivers/clk/qcom/krait-cc.c                   | 201 ++++++++++--------
 drivers/clk/tegra/clk-periph.c                |   2 +-
 drivers/clk/tegra/clk-sdmmc-mux.c             |   2 +-
 drivers/clk/tegra/clk-super.c                 |   4 +-
 include/linux/clk-provider.h                  |   2 +-
 18 files changed, 448 insertions(+), 256 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

-- 
2.34.1

