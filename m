Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E944DDDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbiCRQJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiCRQJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:09:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FCF4AE34;
        Fri, 18 Mar 2022 09:08:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d10so17883925eje.10;
        Fri, 18 Mar 2022 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MOGv57ubr/9RequuAj4T//ZCD7zoqFPU6O4Cx9HQcFc=;
        b=VDv0Pea8DAVeB4KCp45Blcd3iwy3LF5qe6v56irzpi76BGYFnZTuuDgJPu6Mj73iWK
         tLah5aVzn6Wp8XEOW9pMxpupatKipWUuY0fxccRDLzm+PArpcscnZm2b03GiOiNOnPYf
         6gcAlfoAoyV8B0Xk8CIUdNdT7Aqrvl+pIDT4b2U0kyj+CpRLr8vTABIwDGS4Jbus5ctd
         3fQHKNV+FyJ5927P5bc/xexabJZjnp0BOzYzbPwogK88r+BzsgHdqF6Y7hjvqF7scBX3
         Fi8oQl5mvbOrMqtGXMQ9HCmFW1ExbtL6DtdONQj+ruFNYLhcUGhmtU9tNkuwbf/MdhA3
         W6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MOGv57ubr/9RequuAj4T//ZCD7zoqFPU6O4Cx9HQcFc=;
        b=dD7wL9YUYE5ysHg1VOB8rbSuPcK7wlEU8d1Qvtbul5SBd2hHfxusyINbnvBli9ppmQ
         NCVcf2wOSHWf/e0Zxg6Icv1ptxy0FMmEDvqRCT0Zh9SDTzjHtjlI9B5IZ5Ym6poE7vQM
         RnmZr2G3FETnp5MABdcGwM+ODFwTTtS+onSieDxwzmt0+G3dCak9DnbGM/CVHwhy/s5Z
         9jG21x44h8GiY/TX/06bisrmjQScPZPLfaCw0FtP12ctxJ7Nh/tMiA2yDkIkD5pdjJKC
         EylUppq3TbIyIrnT1A1HEWqHvHF2QofNsjjz2IpGvS+7VUHOow59tAvYwnWK8ldWFBrR
         l7sg==
X-Gm-Message-State: AOAM532BaabmxTT8jU6KXaHNV1gK5tAh3/7+ghBO7zy0WdFNPekDMUoj
        fvydenojY/I5SxHlAMwsdqE=
X-Google-Smtp-Source: ABdhPJyC3fSOve03PqKDPNvOv3MAb8gc5Mu1WOE5JEpQEH2I2a6BDNqIOMspZhUvkDZ/ZXypvoZjgA==
X-Received: by 2002:a17:906:9c8e:b0:6df:7e3c:f5e9 with SMTP id fj14-20020a1709069c8e00b006df7e3cf5e9mr9850386ejc.294.1647619708943;
        Fri, 18 Mar 2022 09:08:28 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:28 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 00/16] Modernize rest of the krait drivers
Date:   Fri, 18 Mar 2022 17:08:11 +0100
Message-Id: <20220318160827.8860-1-ansuelsmth@gmail.com>
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

v2:
- introduce new API instead of fixing the existing one
- do not reorganize variables in krait-cc
- fix some comments error and improve it
- return better error for patch 7
- fix missing new line on patch 16

Ansuel Smith (16):
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
  ARM: dts: qcom: qcom-ipq8064: add missing krait-cc compatible and
    clocks
  dt-bindings: arm: msm: Convert kpss driver Documentation to yaml

 .../bindings/arm/msm/qcom,kpss-acc.txt        |  49 -----
 .../bindings/arm/msm/qcom,kpss-acc.yaml       |  97 +++++++++
 .../bindings/arm/msm/qcom,kpss-gcc.txt        |  44 -----
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       |  63 ++++++
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
 15 files changed, 445 insertions(+), 236 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

-- 
2.34.1

