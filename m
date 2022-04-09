Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D0C4FA22B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiDIEDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbiDIEDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:03:48 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0F5CF4AF;
        Fri,  8 Apr 2022 21:01:41 -0700 (PDT)
Date:   Sat, 09 Apr 2022 04:01:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1649476892;
        bh=wMncmnY+rrP3Pvn94fRUXX8ko1xmtHWn5l07vjpjZUA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=HLKP4Xwd4zfZ6loQiXG3sbR9NuEW5LCougG4m+/QeQth+6QAL3tEsOt/T/WlZpkfy
         IcxOhPOR3GLkBr12Q3XlUFabin2n1SUEAFdX8qHV//zANuYTbk34sO6hbZKb5C0zi0
         KrB26sNehSsL1TJdZ+3OFN7RHnMGM+OPrPvpb6j5rt39AaJMRlddWJBpQjzjeQWQmb
         Gt8fJxDLrxf8UDmhS5dMpzDIPmJrN2nHwts86sWRhq+1L/0FQB0oSQcUhdPPcr1jUq
         wChKjrVpsWiHPCdZ7NpEpJ6gVoaU3g5WM2P2qfSgCEx2FwT2RwbLT3/jNU5LShFP6V
         p4qgIjjSGJk2Q==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 0/9] Add support for MSM8996 Pro
Message-ID: <20220409035804.9192-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8996 Pro (also known as MSM8996SG) is a newer revision of MSM8996
with different CPU/CBF/GPU frequencies and CPR parameters. Its CBF clock
also has a different divisor.

This series handles the difference in the CBF clock and adds a new DTSI for
MSM8996 Pro with CPU and GPU OPPs. It also removes reading msm-id from SMEM
in qcom-cpufreq-nvmem as it becomes no longer necessary with the introducti=
on.
of a separate device tree. Separating MSM8996 and MSM8996 Pro will help wit=
h
implementing CBF scaling and CPR; as they have different CPR parameters
and CPU:CBF OPP mapping which is difficult to implement in the same cluster
OPP tables.

Dependencies:
- clk: qcom: msm8996-cpu: Add CBF support
  https://lore.kernel.org/linux-arm-msm/20210528192541.1120703-1-konrad.dyb=
cio@somainline.org/#t
- arm64: dts: qcom: msm8996: Add support for the CBF clock
  https://lore.kernel.org/linux-arm-msm/20210528192541.1120703-2-konrad.dyb=
cio@somainline.org/

Changes since v1:
- Rebase DT changes on already merged patches[1][2].
- Add more details to commit messages.
- Split removing MSM8996 Pro speed bin bits from opp-supported-hw into
  a separate patch.
- Rename msm8996-xiaomi-scorpio.dts to msm8996pro-xiaomi-scorpio.dts

[1] https://lore.kernel.org/linux-arm-msm/20220203072226.51482-1-y.oudjana@=
protonmail.com/T/#m6e1341ccfa50d11d221ba8c618f73c21a83b8acb
[2] https://lore.kernel.org/linux-arm-msm/20220203072226.51482-1-y.oudjana@=
protonmail.com/T/#m36f194cd9da1fee7058a88412985aab10c499fa7

Yassine Oudjana (9):
  dt-bindings: clk: qcom: msm8996-apcc: Add CBF
  dt-bindings: clk: qcom: msm8996-apcc: Add MSM8996 Pro compatible
  clk: qcom: msm8996-cpu: Add MSM8996 Pro CBF support
  cpufreq: qcom_cpufreq_nvmem: Simplify reading kryo speedbin
  dt-bindings: opp: opp-v2-kryo-cpu: Remove SMEM
  arm64: dts: qcom: msm8996: Remove MSM8996 Pro speed bins from cluster
    OPP tables
  dt-bindings: arm: qcom: Add MSM8996 Pro compatible
  arm64: dts: qcom: msm8996: Add MSM8996 Pro support
  arm64: dts: qcom: msm8996-xiaomi-scorpio: Use MSM8996 Pro

 .../devicetree/bindings/arm/qcom.yaml         |   5 +
 .../bindings/clock/qcom,msm8996-apcc.yaml     |  11 +-
 .../bindings/opp/opp-v2-kryo-cpu.yaml         |  56 ++--
 arch/arm64/boot/dts/qcom/Makefile             |   2 +-
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |   3 -
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |   1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  82 ++---
 ...rpio.dts =3D> msm8996pro-xiaomi-scorpio.dts} |   4 +-
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi      | 281 ++++++++++++++++++
 drivers/clk/qcom/clk-cpu-8996.c               |  61 ++--
 drivers/cpufreq/Kconfig.arm                   |   1 -
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |  75 +----
 12 files changed, 410 insertions(+), 172 deletions(-)
 rename arch/arm64/boot/dts/qcom/{msm8996-xiaomi-scorpio.dts =3D> msm8996pr=
o-xiaomi-scorpio.dts} (99%)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996pro.dtsi

--
2.35.1


