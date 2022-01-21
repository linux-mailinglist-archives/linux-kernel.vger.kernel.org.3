Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD524963B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379564AbiAURZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:25:02 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:28936 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235853AbiAURZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:25:01 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LH9Hb3013159;
        Fri, 21 Jan 2022 11:24:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=fdUwz2fE9/QnfJvce4ApsdtnpQfQkVgz1hq5AF0+SjU=;
 b=B5VlcrdMdMnk8NnB1oGnvhNUY8thT0ZHWhzqkHQunX7NyQuJcAtBq8n8dCbgQSYKT5SM
 OslAjFIQCDqEbwQYQ92p15vSdJCpQW3OyzT4AB+VcTrbNo1CeDlindcIxz/Bsw1y3jWt
 62uTq9+gyhPJLWscj0cgTj7hsjozFXA8okB2UdDnYoN5VF/hdpsz46mB5G2Ugg1B3dJW
 /3f1L08AeTQBSdS72TmWxhdUKijFH/ALpCIlH5sujkzffXMQjNjwQ6MSMYKuHWqptE4s
 AdbAgUR4IK5LsrkO+qC+yqBKjmUerS1J9aRDPb9tTnXv4tCl/atB3KPOYA4QOdhUv9WY fA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhynrw8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 11:24:48 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 17:24:46 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 17:24:46 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2132CB0E;
        Fri, 21 Jan 2022 17:24:40 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v6 0/9] Support Spi in i2c-multi-instantiate driver
Date:   Fri, 21 Jan 2022 17:24:22 +0000
Message-ID: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t8MGG8qELi458L786NZmVmfIVRSJege4
X-Proofpoint-GUID: t8MGG8qELi458L786NZmVmfIVRSJege4
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SPI bus in the i2c-multi-instantiate driver as
upcoming laptops will need to multi instantiate SPI devices from
a single device node, which has multiple SpiSerialBus entries at
the ACPI table.

With the new SPI support, i2c-multi-instantiate becomes
bus-multi-instantiate and is moved to the ACPI folder.

The intention is to support the SPI bus by re-using the current
I2C multi instantiate, instead of creating a new SPI multi
instantiate, to make it possible for peripherals that can be
controlled by I2C or SPI to have the same HID at the ACPI table.

The new driver (serial multi instantiate, smi) checks for the
hard-coded bus type and returns -ENODEV in case of zero devices
found for that bus. In the case of automatic bus detection, 
the driver will give preference to I2C.

The expectation is for a device node in the ACPI table to have
multiple I2cSerialBus only or multiple SpiSerialBus only, not
a mix of both; and for the case where there are both entries in
one device node, only the I2C ones would be probed.

This new serial multi instantiate will be used in CS35L41 HDA new
driver.

Changes since V5:
 - comment, commit message and Kconfig description fixes
 - minor fixes in serial-multi-instantiate
 - use lowercase for SSIDs in patch_realtek.c

Lucas Tanure (4):
  platform/x86: i2c-multi-instantiate: Rename it for a generic serial
    driver name
  platform/x86: serial-multi-instantiate: Reorganize I2C functions
  ALSA: hda/realtek: Add support for HP Laptops
  ACPI / scan: Create platform device for CS35L41

Stefan Binding (5):
  spi: Make spi_alloc_device and spi_add_device public again
  spi: Create helper API to lookup ACPI info for spi device
  spi: Support selection of the index of the ACPI Spi Resource before
    alloc
  spi: Add API to count spi acpi resources
  platform/x86: serial-multi-instantiate: Add SPI support

 MAINTAINERS                                   |   4 +-
 drivers/acpi/scan.c                           |  16 +-
 drivers/platform/x86/Kconfig                  |  12 +-
 drivers/platform/x86/Makefile                 |   2 +-
 drivers/platform/x86/i2c-multi-instantiate.c  | 174 ---------
 .../platform/x86/serial-multi-instantiate.c   | 349 ++++++++++++++++++
 drivers/spi/spi.c                             | 137 ++++++-
 include/linux/spi/spi.h                       |  20 +
 sound/pci/hda/patch_realtek.c                 |  43 ++-
 9 files changed, 551 insertions(+), 206 deletions(-)
 delete mode 100644 drivers/platform/x86/i2c-multi-instantiate.c
 create mode 100644 drivers/platform/x86/serial-multi-instantiate.c

-- 
2.25.1

