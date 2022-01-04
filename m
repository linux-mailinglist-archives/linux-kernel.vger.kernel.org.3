Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9B7484263
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiADN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:27:47 -0500
Received: from mail-4319.protonmail.ch ([185.70.43.19]:27109 "EHLO
        mail-4319.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiADN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:27:46 -0500
Date:   Tue, 04 Jan 2022 13:27:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641302864;
        bh=N7TpRcOftGUw1oifCpP7wjHuRkrHBIGaeiwn9kajWDE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=IEMI4JihSWX9ee2Vw9tB89Q4ml+v1FxEi7fDsZXnsmu23gdA9N2b/Dz3muscm7U85
         NW02cO4eqnLQe25jqTCd83fegrMNTPxbRpii6fZfqb7KX5FcmoHIXazWy5TG7ho+q+
         HXSEOsJ17jHdmzjUzDq5eE6zsRnGT0sACL0TLrrCLB7sIi6O40EG7XKwL8EllSJFl0
         ZfBPMCytskxwVXfs+xHIS8Qbcjc56JmFnNqHj8Qqt1v/OTWTJXzFdDJCzPvvyAcM7q
         07vq06iLa19PRvXHj91pnMlQfrvMj4R5gI8OYpr25+gKpfdd+1ttO1ibFFIVxTxtTm
         UnwOjr4cN9v5w==
To:     Rob Herring <robh+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 0/7] dt-bindings: Convert multiple Qualcomm OPP and CPUFreq bindings to DT schema
Message-ID: <20220104132618.391799-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a compilation of DT schema conversions of multiple Qualcomm
OPP and CPUFreq bindings:
- qcom-cpufreq-nvmem (operating-points-v2-kryo-cpu)
- qcom-opp (operating-points-v2-qcom-level)
- qcom,cpr

Converting each one to DT schema introduces new dt_binding_check and
dtbs_check errors to the others, so it was better to combine them into
a series. Some errors were also caused by a couple of device trees having
OPP tables with names that do not follow opp-v2-base, so these got fixed
in this series as well. Finally, the lack of MSM8996 compatibles in
arm/qcom.yaml caused an error in the opp-v2-kryo-cpu example, so they were
added to the schema as well as to the msm8996-mtp device tree, which only
had qcom,msm8996-mtp as its compatible.

PATCH 4/7 is a new version of a patch[1] that was sent as part of
a different series before, and PATCH 7/7 is a new version of a patch[2]
that was first sent alone.

Changes since v1 (PATCH v2 4/7):
 - Split the schema into an OPP schema and a CPUFreq schema.=20

Changes since v1 (PATCH v2 7/7):
 - Remove allOf from compatible.

Yassine Oudjana (7):
  dt-bindings: arm: qcom: Add msm8996 and apq8096 compatibles
  arm64: dts: qcom: msm8996-mtp: Add msm8996 compatible
  dt-bindings: opp: qcom-opp: Convert to DT schema
  dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema
  arm64: dts: qcom: msm8996: Rename cluster OPP tables
  arm64: dts: qcom: qcs404: Rename CPU and CPR OPP tables
  dt-bindings: power: avs: qcom,cpr: Convert to DT schema

 .../devicetree/bindings/arm/qcom.yaml         |  16 +-
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 166 ++++
 .../bindings/opp/opp-v2-kryo-cpu.yaml         | 257 ++++++
 .../bindings/opp/opp-v2-qcom-level.yaml       |  60 ++
 .../bindings/opp/qcom-nvmem-cpufreq.txt       | 796 ------------------
 .../devicetree/bindings/opp/qcom-opp.txt      |  19 -
 .../bindings/power/avs/qcom,cpr.txt           | 130 ---
 .../bindings/power/avs/qcom,cpr.yaml          | 160 ++++
 MAINTAINERS                                   |   5 +-
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts      |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   4 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |   4 +-
 12 files changed, 666 insertions(+), 953 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-=
nvmem.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.y=
aml
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-qcom-level=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufre=
q.txt
 delete mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
 delete mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.tx=
t
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.ya=
ml

[1] https://lore.kernel.org/linux-arm-msm/20211014083016.137441-6-y.oudjana=
@protonmail.com/
[2]=09https://lore.kernel.org/linux-arm-msm/20211221133937.173618-1-y.oudja=
na@protonmail.com/
--=20
2.34.1


