Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2500C464891
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhLAHeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:34:01 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:24263 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347654AbhLAHdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343805; x=1669879805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iMAVgNFJrRkMzoxIES2g+e2qL15Hbp1w1JuJqWBXSKs=;
  b=WGGBkZtTmyiwV0D0X7D2jVN0lzqUjjdz+Viajgjqohp3Q9ZK+ECtfxcA
   qQC/XujB0B6twI9NGp8ELkGNuGYKsx/AusXk16BxIHPiD2+zo/J3oJOlh
   fY44aCQf8SmAVUBc8S6hAtYmGLI/kfZgodkBv2I4Wgr4VoEyNl0wEfK2v
   8YYe2LQj5H5AXKLyZFkdCmCoPhVtgFdWtNwg5Xp/0FLmOO29UPf0J8W/q
   vs4gBG1RmI4HbmZLfzHRvXhJB/tnBNS7CA3m9kuIxy9XM6SuwKnYpXicr
   hZYGbeA6DVAhdrkQONA9ks8Iy7fBG5MrPHdy2wF6OLmSV5ktuZ5vrT/cE
   A==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773221"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Dec 2021 08:30:03 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 01 Dec 2021 08:30:03 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 01 Dec 2021 08:30:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343803; x=1669879803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iMAVgNFJrRkMzoxIES2g+e2qL15Hbp1w1JuJqWBXSKs=;
  b=W8dFFVix2sVBhlPCf6GtNIS042Z2hPm50VvfHs7mzitfiiAixP7sSw3q
   XGXdRMhxYJ5C2HSvrbAjOiFpu3GQXP/1u4YniEUVEyJcyaJ5ouFNo51n5
   WDEIYH/33HSxUfoK89NWYemdqgP1xSgjgB/t3s7KhU9r9x8MrUDrMqHm+
   Sh9X04e+JEN66DucxqmIekxVMYabQQmuSpyDfpNwlRUmX2lXNUcZbA38f
   Cs4pB+XF7Q/FlwqUfYtrpceBGo/526pmC7OsIYxABR2a0LmMnE6koXELv
   H7Lge9CCCwklLzWe4GPEKuMMc4JMUViuzDfG4+uAySgQXG88W8gBdLFFc
   w==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773220"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Dec 2021 08:30:02 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A8071280065;
        Wed,  1 Dec 2021 08:30:02 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/7] Support for some TQMa8M* boards
Date:   Wed,  1 Dec 2021 08:29:41 +0100
Message-Id: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review on v2!

Changes in v3:
* Rebased to next-20211129
* Adjusted commit subjects (tree -> device tree)
* Use hyphen in node names instead of underscore
* Removed bootargs from DT
* Fixed audio-codec node name and handle name
* Property 'enet-phy-lane-no-swap' was already documented, but got accidently
  removed during YAML conversion. Fix is pending at at [2]
* Use matrix instead of array for 'fsl,pins' as required by pinctrl bindings.
  This reduces the lines in stderr from dtbs_check for these DT files from 475
  down to 191
* Removed TODO regarding unsupported USB over-current polarity

Changes in v2:
* Rebased to next-20211101
* Added Rob's Acked-By on Patch for DT bindings
* for other changes please refer to individual patches

Note on TQMa8Mx:
Due to CPU errata cpuidle is broken and needs to be disabled, see [1] for
pending patch.

This patch set adds support for the following modules:
* TQMa8Mx
* TQMa8MxML
* TQMa8MxNL

Each of the modules is available with different i.MX8M variants, the
bootloader modifies the device tree and disabled paripherals which
are not available on the actual hardware.

All of them can be attached to the same mainboard MBa8Mx, although
TQMa8MxML & TQMa8MxNL need an adapter. For that reason there is a single
mainboard .dtsi file named mba8mx.dtsi.

There is a .dtsi file for each module named imx8m?-tmqa8m*.dts.

Finally there is the final .dts file which includes the mainboard and
the attached module and contains the missing connection, prominently clk
and pinctrl defines.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20211105095535.3920998-1-alexander.stein@ew.tq-group.com/
[2] https://www.spinics.net/lists/devicetree/msg460023.html

Alexander Stein (7):
  dt-bindings: arm: fsl: add TQMa8MxML boards
  arm64: dts: freescale: add initial device tree for TQMa8MQML with
    i.MX8MM
  arm64: defconfig: enable drivers for TQ TQMa8MxML-MBa8Mx
  dt-bindings: arm: fsl: add TQMa8MxNL boards
  arm64: dts: freescale: add initial device tree for TQMa8MQNL with
    i.MX8MN
  dt-bindings: arm: fsl: add TQMa8Mx boards
  arm64: dts: freescale: add initial device tree for TQMa8Mx with i.MX8M

 .../devicetree/bindings/arm/fsl.yaml          |  31 ++
 arch/arm64/boot/dts/freescale/Makefile        |   3 +
 .../dts/freescale/imx8mm-tqma8mqml-mba8mx.dts | 253 ++++++++++++
 .../boot/dts/freescale/imx8mm-tqma8mqml.dtsi  | 335 ++++++++++++++++
 .../dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts | 237 ++++++++++++
 .../boot/dts/freescale/imx8mn-tqma8mqnl.dtsi  | 322 ++++++++++++++++
 .../dts/freescale/imx8mq-tqma8mq-mba8mx.dts   | 349 +++++++++++++++++
 .../boot/dts/freescale/imx8mq-tqma8mq.dtsi    | 360 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/mba8mx.dtsi     | 282 ++++++++++++++
 arch/arm64/configs/defconfig                  |   7 +
 10 files changed, 2179 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/mba8mx.dtsi

-- 
2.25.1

