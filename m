Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6DF4BD149
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244816AbiBTUUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:20:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbiBTUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:20:04 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADFC4C43C;
        Sun, 20 Feb 2022 12:19:42 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0A706C6D5A;
        Sun, 20 Feb 2022 20:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645388380; bh=m6+0G7kMhIz7HsIPX/lDQc+bJdPk1YftvzsitotuDew=;
        h=From:To:Cc:Subject:Date;
        b=K+bXim3X2qVn78qrWNwVF9x83UOent1HzpLSuC/FDJoIX49K2/c5PhDo4MoB1TP8y
         S7vJZBjFwYXS6DMDqnEX7HQJI6o5iBi+qD0z2XrABZ/6AH4dmnhDpZaNVs26MHuvod
         CiZk15Ff0Lx4+HzTTqircIuMJ8xfHsdXtFRXRYZQ=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Amit Kucheria <amitk@kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hector Martin <marcan@marcan.st>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 00/10] Initial MSM8953 & Fairphone 3 support
Date:   Sun, 20 Feb 2022 21:18:53 +0100
Message-Id: <20220220201909.445468-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds initial support for MSM8953 (and SDM632 which is based
on MSM8953) and the Fairphone 3 smartphone.

Only relatively basic functionality is supported like storage, volume
keys and USB.

There is currently close-to-mainline support for other components for
this SoC including GPU, WiFi and audio, this series adds only basic
support so that the other components can start getting upstreamed
easier.

Changes in v2:
- rebase on linux-next and drop already applied patches
- drop msm8953-pm8953.dtsi patch: integrate changes into FP3 patch
- for individual patches for other changes

Luca Weiss (7):
  dt-bindings: mfd: qcom,tcsr: Document msm8953 compatible
  dt-bindings: thermal: tsens: Add msm8953 compatible
  dt-bindings: usb: qcom,dwc3: Add msm8953 compatible
  dt-bindings: arm: cpus: Add Kryo 250 CPUs
  rpmsg: smd: allow opening rpm_requests even if already opened
  dt-bindings: arm: qcom: Document sdm632 and fairphone,fp3 board
  arm64: dts: qcom: sdm632: Add device tree for Fairphone 3

Vladimir Lypak (3):
  arm64: dts: qcom: Add MSM8953 device tree
  arm64: dts: qcom: Add PM8953 PMIC
  arm64: dts: qcom: Add SDM632 device tree

 .../devicetree/bindings/arm/cpus.yaml         |    1 +
 .../devicetree/bindings/arm/qcom.yaml         |    6 +
 .../devicetree/bindings/mfd/qcom,tcsr.txt     |    1 +
 .../bindings/thermal/qcom-tsens.yaml          |    1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/msm8953.dtsi         | 1326 +++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8953.dtsi          |   90 ++
 .../boot/dts/qcom/sdm632-fairphone-fp3.dts    |  183 +++
 arch/arm64/boot/dts/qcom/sdm632.dtsi          |   81 +
 drivers/rpmsg/qcom_smd.c                      |    5 +-
 11 files changed, 1695 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8953.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm632.dtsi

-- 
2.35.1

