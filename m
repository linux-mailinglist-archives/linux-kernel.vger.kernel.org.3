Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6746B2B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhLGGA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhLGGA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:00:56 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE365C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 21:57:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5BDA241EF0;
        Tue,  7 Dec 2021 05:57:24 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC DT updates for 5.17
To:     SoC Team <soc@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <e18b476c-7b1f-de73-53a2-0e21fb5cd283@marcan.st>
Date:   Tue, 7 Dec 2021 14:57:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SoC folks,

Please merge these Apple SoC DT updates for 5.17.

This brings in proper separate DTs for all t8103 platforms, as well as 
the PMGR nodes and some miscellanea. The PMGR driver itself will be a 
separate pull.

This is based on the fixups pull I just sent, so please merge them in 
that order.

-Hector

The following changes since commit 0668639eaf14813a39a8d3e0e6597d568581d4ea:

   arm64: dts: apple: add #interrupt-cells property to pinctrl nodes 
(2021-12-01 23:11:45 +0900)

are available in the Git repository at:

   https://github.com/AsahiLinux/linux.git tags/asahi-soc-dt-5.17

for you to fetch changes up to bf2c05b619ffc0bccf60d2108bfadc880ee7f5c7:

   arm64: dts: apple: t8103: Expose PCI node for the WiFi MAC address 
(2021-12-07 13:41:32 +0900)

----------------------------------------------------------------
Apple SoC DT updates for 5.17:

- Separate DTs for all t8103 platforms
- Add i2c and cd321x nodes
- Bindings for apple,wdt
- PMGR bindings and DT updates to instantiate it
- WiFi MAC address DT handling

This also includes the MAINTAINERS change for the PMGR driver itself, to
avoid merge issues; the driver will be sent in a different pull.

Manual fixups: Added i2c power domain references to the PMGR DT commit,
since a prior commit added the i2c nodes.

----------------------------------------------------------------
Hector Martin (9):
       dt-bindings: i2c: apple,i2c: Add power-domains property
       dt-bindings: iommu: apple,dart: Add power-domains property
       dt-bindings: pinctrl: apple,pinctrl: Add power-domains property
       dt-bindings: interrupt-controller: apple,aic: Add power-domains 
property
       MAINTAINERS: Add PMGR power state files to ARM/APPLE MACHINE
       dt-bindings: power: Add apple,pmgr-pwrstate binding
       dt-bindings: arm: apple: Add apple,pmgr binding
       arm64: dts: apple: t8103: Add PMGR nodes
       arm64: dts: apple: t8103: Add UART2

Janne Grunau (4):
       dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
       arm64: dts: apple: Add missing M1 (t8103) devices
       arm64: dts: apple: t8103: Add i2c nodes
       arm64: dts: apple: t8103: Add cd321x nodes

Mark Kettenis (1):
       arm64: dts: apple: t8103: Expose PCI node for the WiFi MAC address

Sven Peter (1):
       dt-bindings: watchdog: Add Apple Watchdog

  Documentation/devicetree/bindings/arm/apple.yaml   |    6 +-
  .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |  134 +++
  .../devicetree/bindings/i2c/apple,i2c.yaml         |    3 +
  .../bindings/interrupt-controller/apple,aic.yaml   |    3 +
  .../devicetree/bindings/iommu/apple,dart.yaml      |    3 +
  .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    3 +
  .../bindings/power/apple,pmgr-pwrstate.yaml        |   71 ++
  .../devicetree/bindings/watchdog/apple,wdt.yaml    |   52 +
  MAINTAINERS                                        |    4 +
  arch/arm64/boot/dts/apple/Makefile                 |    4 +
  arch/arm64/boot/dts/apple/t8103-j274.dts           |   33 +-
  arch/arm64/boot/dts/apple/t8103-j293.dts           |   41 +
  arch/arm64/boot/dts/apple/t8103-j313.dts           |   33 +
  arch/arm64/boot/dts/apple/t8103-j456.dts           |   59 +
  arch/arm64/boot/dts/apple/t8103-j457.dts           |   47 +
  arch/arm64/boot/dts/apple/t8103-jxxx.dtsi          |   78 ++
  arch/arm64/boot/dts/apple/t8103-pmgr.dtsi          | 1136 
++++++++++++++++++++
  arch/arm64/boot/dts/apple/t8103.dtsi               |  128 +++
  18 files changed, 1808 insertions(+), 30 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
  create mode 100644 
Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
  create mode 100644 
Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
  create mode 100644 arch/arm64/boot/dts/apple/t8103-j293.dts
  create mode 100644 arch/arm64/boot/dts/apple/t8103-j313.dts
  create mode 100644 arch/arm64/boot/dts/apple/t8103-j456.dts
  create mode 100644 arch/arm64/boot/dts/apple/t8103-j457.dts
  create mode 100644 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
  create mode 100644 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi

