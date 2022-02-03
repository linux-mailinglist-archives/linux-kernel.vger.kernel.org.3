Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBB34A7FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349356AbiBCHYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:24:16 -0500
Received: from mail-4324.protonmail.ch ([185.70.43.24]:22889 "EHLO
        mail-4324.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242617AbiBCHYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:24:12 -0500
Date:   Thu, 03 Feb 2022 07:24:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1643873050;
        bh=Cg4VVZKyYzdKoQN0OKZO+sJINPAqHtXoxzHLdJuIiy8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=kpaLMmRNDM4NsRUfXN4zBaf9lL4xBbIOxHMQTyumTQiwFteQPFqgKXmHTmzCFjxsV
         ZXFFbHuRMDyHvZlW2FahfANqu1WKRMsCY5o8PKHwNXe4Rb+z73K+xSJAS4/Pcr7wVo
         W8jRDpGc23n0w2HtyPo2al4obP9y4pUd7wd0hZ1mQ6hnTeVTO67ZuAZIc6AO8p5Ike
         psqwnraYOFH3OV+JMiBxhJhoEQsbPaldsBAlqct7AooUQtvhGpoyeMQXBRRQSxt21f
         OoI71at9kUaVAYaqFue86oFMKAqDUonhsSM8WlAupOEmYRH5Wd4t5vzo7tVXhlzGn5
         2Gm02GF3BZiYg==
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v3 0/7] dt-bindings: Convert multiple Qualcomm OPP and CPUFreq bindings to DT schema
Message-ID: <20220203072226.51482-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        T_SCC_BODY_TEXT_LINE shortcircuit=no autolearn=disabled version=3.4.4
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
that was sent alone.

Changes in v3:
 - Resend with unified version for all patches

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
[2] https://lore.kernel.org/linux-arm-msm/20211221133937.173618-1-y.oudjana=
@protonmail.com/
--=20
2.34.1


