Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A904E1C9B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbiCTQ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiCTQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7151B344DC;
        Sun, 20 Mar 2022 09:28:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so9112998wme.5;
        Sun, 20 Mar 2022 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KcOijGi5og4ld2tvnsTePSNTR92XBpj3TQ2NlwE7kBU=;
        b=mGTn9mZmezpJmG0UBF31vGiOajqAuzDPLPA6zisTAVAbeaCnW0aqhG0R091L5HURZv
         5UXkCxK34eZ+5P66lbJBuX/yzfD2nHD+rujXEUidmknXPryaFp0INVsOjVN5ztNaxESD
         Rz81RsrG/UlJ5qTFats5GtgTwVS/oJgwUB4xrKWla47FH4f7dzeCwSiv27BGTxVQfpXa
         GMfahz2fC2SwmYe51ILTheLQ1NUfkemAG+zXDGULO3hZRSKgkSQBbPjO1fKkJ1Fe8CR+
         4dvtVmfOT25aasIjFVQ1/H+pI8eYlS935zBOcfD1VL1UyzeH7Bt6IjdPvA+or3TSfbfB
         UicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KcOijGi5og4ld2tvnsTePSNTR92XBpj3TQ2NlwE7kBU=;
        b=NiySuYzkHBmTTs9rUykBfzP+59OmutW9/wh0v1NB6vHehu42SQQJ8/dvLOx3X287kU
         BTzAjeUD80PPHRNL16kWIdpIW8TyPOYGrWtSd6HZ3DE9MP9XhVzVFE5pI93SzQUqx0zd
         zLTDRbP8tq8zrcLALQI7jYeQZ7H3XUZ44Z/zTQxZeHWgc9vj0iEtn+VtAgk+uaXlsqB5
         Ptd+c3hKsEmvkeT9tHORhj2sgExqiOprw1gZrWi+c0X1GHQVvAr2p0KeQGjRc78Ntw3g
         1iwtymYw+YyyXU0Ve84f6TXLnVbJUwe+lRcynNlHankObLSa1hRzZEH+tTMnMKIDaoSc
         O7vA==
X-Gm-Message-State: AOAM532ZbaAF5h1b60+EB32vp/apcD2jDtF99tdGtu7rMcAyOC7JPutV
        IHBLmd3osfOQvt2snU7dTC0=
X-Google-Smtp-Source: ABdhPJz3tifzxDAWJ1uNsnjFJEcL933i0CUw51N/qATmVkMutDHoNGHno7FLG2vHZ13hcfwNgDjkAg==
X-Received: by 2002:a7b:c381:0:b0:37b:e01f:c1c0 with SMTP id s1-20020a7bc381000000b0037be01fc1c0mr24568393wmj.98.1647793690646;
        Sun, 20 Mar 2022 09:28:10 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:10 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 00/18] Modernize rest of the krait drivers
Date:   Sun, 20 Mar 2022 12:34:12 +0100
Message-Id: <20220320113430.26076-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

Patch 14 converts krait-cc to yaml

Patch 15 add to krait-cc Documentation the L2 clocks

Patch 16 finally adds all this stuff to the ipq8064 dtsi (and fix the
stupid PXO_SRC phandle)

Patch 17 converts the kpss-acc driver to yaml and fix some Documentation
error

Patch 18 convets the kpss-gcc driver to yaml

I tested this series on a ipq8064 SoC by running a cache benchmark test
to make sure the changes are correct and we don't silently cause
regressions. Also I compared the output of the clk_summary every time
and we finally have a sane output where the mux are correctly placed in
the correct parent. (till now we had the cpu aux clock all over the
place, probably never cause problems but who knows.)

v3:
- Split Documentation files for kpss and krait-cc
v2:
- introduce new API instead of fixing the existing one
- do not reorganize variables in krait-cc
- fix some comments error and improve it
- return better error for patch 7
- fix missing new line on patch 16

Ansuel Smith (18):
  clk: introduce clk_hw_get_index_of_parent new API
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
  clk: qcom: clk-krait: add apq/ipq8064 errata workaround
  clk: qcom: clk-krait: add enable disable ops
  dt-bindings: clock: Convert qcom,krait-cc to yaml
  dt-bindings: clock: Add L2 clocks to qcom,krait-cc Documentation
  ARM: dts: qcom: qcom-ipq8064: add missing krait-cc compatible and
    clocks
  dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
  dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml

 .../bindings/arm/msm/qcom,kpss-acc.txt        |  49 -----
 .../bindings/arm/msm/qcom,kpss-acc.yaml       |  88 +++++++++
 .../bindings/arm/msm/qcom,kpss-gcc.txt        |  44 -----
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       |  68 +++++++
 .../bindings/clock/qcom,krait-cc.txt          |  34 ----
 .../bindings/clock/qcom,krait-cc.yaml         |  63 ++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |  20 +-
 drivers/clk/clk.c                             |  14 ++
 drivers/clk/qcom/clk-hfpll.c                  |  13 +-
 drivers/clk/qcom/clk-krait.c                  |  44 ++++-
 drivers/clk/qcom/clk-krait.h                  |   1 +
 drivers/clk/qcom/gcc-ipq806x.c                |  27 ++-
 drivers/clk/qcom/kpss-xcc.c                   |  25 +--
 drivers/clk/qcom/krait-cc.c                   | 186 ++++++++++--------
 include/linux/clk-provider.h                  |   1 +
 15 files changed, 441 insertions(+), 236 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

-- 
2.34.1

