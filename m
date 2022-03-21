Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37014E2BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349911AbiCUPTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349901AbiCUPTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2FD10EC5A;
        Mon, 21 Mar 2022 08:17:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j18so11530822wrd.6;
        Mon, 21 Mar 2022 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4IGptxZ1Fj/rxyhFk27+MlJU6AA0j30gb7cbqQiOOM=;
        b=KDmvf+e2FwkPan7KAyChyliuW0KQGte9n8i7sep3stYwfVwbtyK0PQz5QjNdmJbrJ4
         iTPH6ZI8Z+FJETI38oejOoMuxMjaHH919KdWteOiyolzOSqGv2e65AdHsBDKSxw5+64i
         wMOHaZQEA2pEBy2BeI32OIXOkl0vu8OcX3llUPPQ0qqYT1ri2Ilc7NHN2NbC9f6xFlX9
         AxPlI8jjfelQrI/eKlWxDXlnjvZEb1RZtjr/O1xOALL71YJsFimtMfCgpPg5OZWC62Jc
         cE7DYi1ehg4KbC30cnWyYHQBMUMA2mGiGDY2omYtnIWaVJKOnL+c5s8tvNdC7bWZC+ts
         QEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4IGptxZ1Fj/rxyhFk27+MlJU6AA0j30gb7cbqQiOOM=;
        b=N2FoeI07i12Y+bCYjkzvLULk+/wMa9efn82K4K0RyoTdazLU5OncxcwyjbV+3T2A1L
         bCCt6rscxXspSkR4omRVEZSGOhZgurmRXeAmHH6mEEQ9zRX0JLzg7lbLI7HbMyl+TPeZ
         n+0aFsOXvJOihvumtx8TZAQflsFrzbio46jGT+YsJ9Iv+ksrXzaikHpUtEK4QMntlJsv
         hcNVQcfxTzrtNfbYRn/u7LQ/znbPLwj7Ys0mSS7irGfOHltlhdyHgcP4tqtxEqB2fV/o
         y8ga1dt2DT7vN7pAGMwWs5mWNG0j3lIvfuKuIrhPklceG5i67aaL6ZBCVZUEmYvMmRAU
         b6oQ==
X-Gm-Message-State: AOAM530GJgHDE0YiaF4A1YCxWJR1ytdhvlZJQc+Zu8tdEFpIuGoSGMuN
        pbvQu/xfVOWKbQngDGI/GZk=
X-Google-Smtp-Source: ABdhPJwSeo6aGBz94AOUGz2JbiJtLjN4kug7S+US6ukMc9vkj31tevhFjpKEP4sgMraSUMJWzvSsFA==
X-Received: by 2002:a05:6000:1e1e:b0:204:203:73ba with SMTP id bj30-20020a0560001e1e00b00204020373bamr8505290wrb.445.1647875865467;
        Mon, 21 Mar 2022 08:17:45 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:17:44 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 00/18] Modernize rest of the krait drivers
Date:   Mon, 21 Mar 2022 15:48:07 +0100
Message-Id: <20220321144825.11736-1-ansuelsmth@gmail.com>
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

v4:
- Fix more dt-bindings bog errors
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

