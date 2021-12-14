Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4075474426
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhLNOAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:00:37 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13580 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234668AbhLNOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:00:30 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BE4Ko3j006814;
        Tue, 14 Dec 2021 08:00:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=HxfX/SoFE0LgM6209wZqoglTHFuqx9omB1l1OGzjfZw=;
 b=foz8zeSvrXrqg1fLlMilCuC8xmOKSeFqtHftwn5e/bEckIFKuG2gsj/mxo+63CweucR6
 47unlpW7ZSDn4PZpF+iWE6pw6Nf9hBbIm9xlj/7oJ0q0kHbGzGsemyPIgWlLqzar0UwY
 JR9KabpVHEm1lpQSYYUQCryoZIA8c7qpiIeJ6wOdbFSDEs2xarljSh6kbFifkOMplSSH
 D8bmQeWzHAz/4JI7Rf2oSp4xdC5yoJ2QdAwycZJ8CcihTh6OqyEbi9Tw8CQ6tvcq4R2w
 2ozkgjOlbmfZi8Z2hxglNs2/Ezv86ne3VSxyFzPGl4mKhF2O65J9np4AyHa6ZXoOz7Oz zA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cxh14grht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Dec 2021 08:00:02 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 14 Dec
 2021 14:00:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 14 Dec 2021 14:00:00 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 34C4D7C;
        Tue, 14 Dec 2021 14:00:00 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v4 00/10] Add support for CS35L41 in HDA systems
Date:   Tue, 14 Dec 2021 13:59:49 +0000
Message-ID: <20211214135959.1317949-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kzg2siUfDy0WOJbouaCNJPoYdExKSr7D
X-Proofpoint-ORIG-GUID: kzg2siUfDy0WOJbouaCNJPoYdExKSr7D
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for laptops that have CS35L41 connected to an HDA
codec by I2S and direct I2C connection to the CPU.

Laptops that use CS35L41 and are SPI will be added in the future,
after the support for it is resolved at i2c-multi-instantiate driver.
i2c-multi-instantiate thread: https://lkml.org/lkml/2021/12/10/557

Hardware:
 - Some laptops have two CS35L41 amplifiers, connected to Realtek ALC287
   by an I2S bus and by and direct I2C to the CPU.
 - The ALC287 codec is connected to the CPU by an HDA bus.
 - The CS35L41 has a DSP which will require firmware to be loaded.

Architecture:
 - Creation of a library of shared functions for CS35L41 ASoC and HDA
 - HDA codec driver (RealTek) and CS35L41 HDA driver are combined
 by using component binding, where it uses device names to find the
 components and bind to the master
 - The HDA CS35L41 driver applies pre-defined registers sequences
 for each action in playback for HDA Sound card

Changes from V3:
 - SPI bus driver starter added
 - Use separate modules approach instead of liking library
 - Add CSC3551 ACPI _HID for more I2C laptops
 - Removed regulators from HDA driver
 - Add note about Non-conforming _HID
V3: https://lkml.org/lkml/2021/11/23/723

Changes from V2:
 - Not an RFC
 - Create a new HDA driver for CS35L41 instead of using the ASoC one
 - Use component binding and device names to find the CS35L41 driver
 - Create a shared library for ASoC and HDA CS35L41 drivers
v2: https://lkml.org/lkml/2021/10/8/344

Lucas Tanure (9):
  ASoC: cs35l41: Convert tables to shared source code
  ASoC: cs35l41: Move cs35l41_otp_unpack to shared code
  ASoC: cs35l41: Move power initializations to reg_sequence
  ASoC: cs35l41: Create shared function for errata patches
  ASoC: cs35l41: Create shared function for setting channels
  ASoC: cs35l41: Create shared function for boost configuration
  hda: cs35l41: Add support for CS35L41 in HDA systems
  ACPI / scan: Create platform device for CLSA0100 and CSC3551 ACPI
    nodes
  ALSA: hda/realtek: Add support for Legion 7 16ACHg6 laptop

Stefan Binding (1):
  ALSA: hda/realtek: Add CS35L41 support for Thinkpad laptops

 MAINTAINERS                                   |   2 +
 drivers/acpi/scan.c                           |   3 +
 drivers/platform/x86/i2c-multi-instantiate.c  |  11 +
 include/sound/cs35l41.h                       | 739 ++++++++++++++++++
 sound/pci/hda/Kconfig                         |  27 +
 sound/pci/hda/Makefile                        |  10 +
 sound/pci/hda/cs35l41_hda.c                   | 525 +++++++++++++
 sound/pci/hda/cs35l41_hda.h                   |  68 ++
 sound/pci/hda/cs35l41_hda_i2c.c               |  66 ++
 sound/pci/hda/cs35l41_hda_spi.c               |  63 ++
 sound/pci/hda/hda_component.h                 |  20 +
 sound/pci/hda/patch_realtek.c                 | 147 ++++
 sound/soc/codecs/Kconfig                      |   7 +
 sound/soc/codecs/Makefile                     |   4 +-
 sound/soc/codecs/cs35l41-i2c.c                |   1 -
 .../{cs35l41-tables.c => cs35l41-lib.c}       | 353 ++++++++-
 sound/soc/codecs/cs35l41-spi.c                |   1 -
 sound/soc/codecs/cs35l41.c                    | 360 +--------
 sound/soc/codecs/cs35l41.h                    | 734 -----------------
 19 files changed, 2049 insertions(+), 1092 deletions(-)
 create mode 100644 sound/pci/hda/cs35l41_hda.c
 create mode 100644 sound/pci/hda/cs35l41_hda.h
 create mode 100644 sound/pci/hda/cs35l41_hda_i2c.c
 create mode 100644 sound/pci/hda/cs35l41_hda_spi.c
 create mode 100644 sound/pci/hda/hda_component.h
 rename sound/soc/codecs/{cs35l41-tables.c => cs35l41-lib.c} (71%)

-- 
2.34.1

