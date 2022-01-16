Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF26B48FDF3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiAPQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:50:56 -0500
Received: from h03mx16.reliablemail.org ([173.236.90.20]:23824 "EHLO
        h03mx16.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiAPQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:50:55 -0500
X-Halon-Out: 76b5d194-76ec-11ec-a67c-00163c72d6d3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XF6MY+Oe0VC6ipxCCBP5H+WQ0jqB6VALeTJl0160SzU=; b=MuXW4p4Ijak+O6wBDCeDJ5Tkg1
        2zE7JEXbmRdWt8Nsd2xfHrSaEb9RHheqZ/DRefXLljVSe0Q+nlSmloXuYpHmW/ofo7Xdef1WKqWo2
        ZoqHBnOHJf+T7GCScIC+V+30leyKVVCVpAjGZRjDcq3UpizrP8WI+l32P54+NvRvE4j2ID300XG28
        nU7azh69gory5sSKzYYsDxe9TEBc0n7/PscLcFtJ4py+HUB2jJT+O6hFuTghTqI087TG2H/1sGIMU
        J9cOOqZMTcqNxIrg+muFamJdOE2lrANQ+m7xEfiaaDyem1EmB3AvlBmWY10aGo0sHi82VMy0nerw6
        TF9WzZHQ==;
From:   Henrik Grimler <henrik@grimler.se>
To:     semen.protsenko@linaro.org, virag.david003@gmail.com,
        martin.juecker@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, alim.akhtar@samsung.com,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH v3 0/3] Add initial support for exynos5420-chagall-wifi
Date:   Sun, 16 Jan 2022 17:50:32 +0100
Message-Id: <20220116165035.437274-1-henrik@grimler.se>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung's tablet Galaxy Tab S 10.5" (wifi) has codename Chagall WiFi
and is one of several tablets released in 2014 based on Exynos 5420.
This initial devicetree adds support for accessing device over USB or
UART, and allows using a rootfs in either the internal eMMC or an
external sdcard.  4 out of 8 CPUs are brought up when device boots,
which is the same as on the somewhat similar board
exynos5420-arndale-octa.

Patch 2 is necessary after a secure-firmware node is added, otherwise
device hangs during the CPU1BOOT secure monitor call. Without the
secure-firmware node we are not able to bring up any secondary CPUs.

Changes since v2
================

Addressing Krzysztof's feedback:
* chagallwifi -> chagall-wifi and Chagall WiFi in messages and comments
* Re-write commit message for patch 3, use commit hash and ("subject"),
  move hint about bootloader issue to galaxy-tab-common.dtsi
* Fix s2mps11 regulator nodes, use &ldoXX_reg handle for device customisation
* Re-add usbdrd supplies (works after fixing regulator nodes)
* Remove unnecessary, duplicate, compatible in galaxy-tab-common.dtsi
* Remove extra clocks xxti and xusbxti
* Prefix key- to gpio-keys
* Add pinctrl pins to mmc_2. card-detect pin is different than for other
  Exynos 5420 devices, so define and use mmc2_cd node under pinctrl_0

Additional changes:
* Add/fix supplies of mmc_0 and mmc_2 (vmmc-supply for mmc0 is unknown)
* Sort mmc_X properties alphabetically
* Fix IRQ pin for s2mps11, it was wrong (gpx3-2 -> gpx3-0)
* Mark LDO31 as varying between devices as well, it differs between WiFi
  and LTE tablet versions
* Fix typo for LDO5 (regulato-name -> regulator-name)
* Remove regulator-ramp-delay from buck regulators, based on
  exynos5420-arndale-octa there should be no need to set it

Changes since v1
================

Fix mmc_0 and usbdrd in patch 3:
* Remove extra, non supported, options from mmc_0 node
* Do not set usbdrd supplies. Usb networking does not work with them
  specified, but it works fine with dummy regulators


Henrik Grimler (3):
  dt-bindings: arm: samsung: document Chagall WiFi board binding
  ARM: exynos: only do SMC_CMD_CPU1BOOT call on Exynos4
  ARM: dts: Add support for Samsung Chagall WiFi

 .../bindings/arm/samsung/samsung-boards.yaml  |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/exynos5420-chagall-wifi.dts |  65 ++
 .../dts/exynos5420-galaxy-tab-common.dtsi     | 666 ++++++++++++++++++
 arch/arm/mach-exynos/firmware.c               |   4 +-
 5 files changed, 736 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/exynos5420-chagall-wifi.dts
 create mode 100644 arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi

-- 
2.34.1

