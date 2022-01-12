Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114A048CC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357589AbiALTxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:53:14 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33198 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356987AbiALTv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:51:58 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 99ECDCDF9F;
        Wed, 12 Jan 2022 19:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016544; bh=0kWYHyQ+FdQZVfHCIbfLblrDXNannTFucaCQYt2r6LQ=;
        h=From:To:Cc:Subject:Date;
        b=miax10sWCxLcvuPulMRI9I8OxkGClnhZ7on8fnVVyuxu3eLoIzlmYgDUW+CcsPSnK
         Cz95AHMYXfk4vBg0yIPTahxcsi7xikZlNOJK59DxWJKpylDH8bAjfHzKVFpB2OfNoy
         ookhq+C83s4UtZgJGkb6zXdZKvG7GFw/47b1tpAI=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Amit Kucheria <amitk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 00/15] Initial MSM8953 & Fairphone 3 support
Date:   Wed, 12 Jan 2022 20:40:49 +0100
Message-Id: <20220112194118.178026-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Luca Weiss (10):
  dt-bindings: phy: qcom,qusb2: Document msm8953 compatible
  phy: qcom-qusb2: Add compatible for MSM8953
  dt-bindings: mfd: qcom,tcsr: Document msm8953 compatible
  mfd: qcom-spmi-pmic: Add pm8953 compatible
  dt-bindings: mmc: sdhci-msm: Add msm8953 compatible
  dt-bindings: thermal: tsens: Add msm8953 compatible
  dt-bindings: usb: qcom,dwc3: Add msm8953 compatible
  dt-bindings: pinctrl: qcom: msm8953: allow gpio-reserved-ranges
  dt-bindings: arm: qcom: Document sdm632 and fairphone,fp3 board
  arm64: dts: qcom: sdm632: Add device tree for Fairphone 3

Vladimir Lypak (5):
  rpmsg: smd: Drop unnecessary condition for channel creation
  arm64: dts: qcom: Add MSM8953 device tree
  arm64: dts: qcom: Add PM8953 PMIC
  arm64: dts: qcom: Add SDM632 device tree
  arm64: dts: qcom: Add MSM8953+PM8953 device tree

 .../devicetree/bindings/arm/qcom.yaml         |    6 +
 .../bindings/mfd/qcom,spmi-pmic.txt           |    1 +
 .../devicetree/bindings/mfd/qcom,tcsr.txt     |    1 +
 .../devicetree/bindings/mmc/sdhci-msm.txt     |    1 +
 .../bindings/phy/qcom,qusb2-phy.yaml          |    1 +
 .../pinctrl/qcom,msm8953-pinctrl.yaml         |    2 +
 .../bindings/thermal/qcom-tsens.yaml          |    1 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi  |   50 +
 arch/arm64/boot/dts/qcom/msm8953.dtsi         | 1337 +++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8953.dtsi          |   90 ++
 .../boot/dts/qcom/sdm632-fairphone-fp3.dts    |  189 +++
 arch/arm64/boot/dts/qcom/sdm632.dtsi          |  125 ++
 drivers/phy/qualcomm/phy-qcom-qusb2.c         |    3 +
 drivers/rpmsg/qcom_smd.c                      |    8 +-
 16 files changed, 1810 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8953.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm632.dtsi

-- 
2.34.1

