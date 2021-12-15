Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887BF476026
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbhLOSC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:02:29 -0500
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:58948 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245461AbhLOSCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:02:16 -0500
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id CE3E4F40EA4; Wed, 15 Dec 2021 18:55:04 +0100 (CET)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        rw-r-r-0644 <r.r.qwertyuiop.r.r@gmail.com>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/5] rtc: nintendo: Add a RTC driver for the GameCube, Wii and Wii U
Date:   Wed, 15 Dec 2021 18:54:56 +0100
Message-Id: <20211215175501.6761-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211027223516.2031-1-linkmauve@linkmauve.fr>
References: <20211027223516.2031-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three consoles share a device, the MX23L4005, which contains a
clock and 64 bytes of SRAM storage, and is exposed on the EXI bus
(similar to SPI) on channel 0, device 1.  This driver allows it to be
used as a Linux RTC device, where time can be read and set.

The hardware also exposes two timers, one which shuts down the console
and one which powers it on, but these aren’t supported currently.

On the Wii U, the counter bias is stored in a XML file, /config/rtc.xml,
encrypted in the SLC (eMMC storage), using a proprietary filesystem.  In
order to avoid having to implement all that, this driver assumes a
bootloader will parse this XML file and write the bias into the SRAM, at
the same location the other two consoles have it.

Changes since v1:
- Rename the driver to rtc-gamecube.
- Switch to the regmap API for debugfs support.
- Report low battery and unstable power as invalid data.
- Remove Wii U support in Kconfig, nothing specific to this console
  needs to be changed in the code.
- Don’t attempt to change HW_SRNPROT on the GameCube, this register
  doesn’t exist so we can use SRAM just fine without doing anything.
- Add needed changes to the wii device tree.
- Enable this driver on the gamecube and wii platforms.

Changes since v2:
- Report low battery correctly.

Emmanuel Gil Peyrot (5):
  rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U
  rtc: gamecube: Report low battery as invalid data
  powerpc: wii.dts: Expose HW_SRNPROT on this platform
  powerpc: gamecube_defconfig: Enable the RTC driver
  powerpc: wii_defconfig: Enable the RTC driver

 arch/powerpc/boot/dts/wii.dts           |   5 +
 arch/powerpc/configs/gamecube_defconfig |   2 +-
 arch/powerpc/configs/wii_defconfig      |   2 +-
 drivers/rtc/Kconfig                     |  11 +
 drivers/rtc/Makefile                    |   1 +
 drivers/rtc/rtc-gamecube.c              | 377 ++++++++++++++++++++++++
 6 files changed, 396 insertions(+), 2 deletions(-)
 create mode 100644 drivers/rtc/rtc-gamecube.c

-- 
2.34.1

