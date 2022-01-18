Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC40D4928DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344886AbiAROya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:54:30 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:61268 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344189AbiAROxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:53:52 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20IA16xt003923;
        Tue, 18 Jan 2022 08:53:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=oT71zYZrNYYAVg8RxuJrWoYyZlkJNB+Jr07bzKT9yzM=;
 b=gkkinJg8iKrLsu5gefMkccLiXiaaF52vG01jOgeGPicGGgVTtknU5rW7kmtu8Wx6yU6A
 iJV07uKpNyBrorvOiUEl8cMdbaONSKY58MdRNLrpQ7PHbe7zDi4qf95nRs47/nrSmBJB
 dYJ7gLdClb4wIB3NWNI+4zKpLgnDCzT3Ou8rCEoKs5UvhCtvVF9Zg5I6t+pFG1UqlI7k
 QuV9d5xg/7LbmbJMYLQs0kk9UUA9r2Uo+ldP4TBUbAcbYbzc7PkRvDoVKE+DOd0Sg/F9
 mUZazc9L4r06Wzbptmt2HW5dgOQGVyYn8YH85nQ31P6VyhadYXAD2/+nTBhIOPudtsik tw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dn8k2s8sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Jan 2022 08:53:29 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 14:53:27 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 18 Jan 2022 14:53:27 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C0C01B13;
        Tue, 18 Jan 2022 14:53:19 +0000 (UTC)
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
Subject: [PATCH v3 00/10] Support Spi in i2c-multi-instantiate driver
Date:   Tue, 18 Jan 2022 14:52:41 +0000
Message-ID: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zA00nyU-pN3X5N5JynvrPg8PJJY7TPPk
X-Proofpoint-ORIG-GUID: zA00nyU-pN3X5N5JynvrPg8PJJY7TPPk
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

The new driver (Bus multi instantiate, bmi) checks for the
hard-coded bus type and returns -ENODEV in case of zero devices
found for that bus. In the case of automatic bus detection, 
the driver will give preference to I2C.

The expectation is for a device node in the ACPI table to have
multiple I2cSerialBus only or multiple SpiSerialBus only, not
a mix of both; and for the case where there are both entries in
one device node, only the I2C ones would be probed.

This new bus multi instantiate will be used in CS35L41 HDA new
driver.

Changes since V2:
 - Fix review comments in bus-multi-instantiate
 - Modified spi code to export new helper to allocate spi device
   based on ACPI
 - Add api in spi code to count number of spi devices in ACPI
 - Add patch to add support for HP Laptops
 - Add patch to add support for various CS35L41 devices in
   scan.c and bus-multi-instantiate from previous chain:
   https://lore.kernel.org/all/20220117160830.709403-1-tanureal@opensource.cirrus.com/

Lucas Tanure (5):
  platform/x86: i2c-multi-instantiate: Move it to drivers/acpi folder
  ACPI: i2c-multi-instantiate: Rename it for a generic bus driver name
  ACPI: bus-multi-instantiate: Reorganize I2C functions
  ALSA: hda/realtek: Add support for HP Laptops
  ACPI / scan: Create platform device for CS35L41

Stefan Binding (5):
  spi: Make spi_alloc_device and spi_add_device public again
  spi: Create helper API to lookup ACPI info for spi device
  spi: Support selection of the index of the ACPI Spi Resource before
    alloc
  spi: Add API to count spi acpi resources
  ACPI: bus-multi-instantiate: Add SPI support

 MAINTAINERS                                  |   4 +-
 drivers/acpi/Kconfig                         |  11 +
 drivers/acpi/Makefile                        |   1 +
 drivers/acpi/bus-multi-instantiate.c         | 369 +++++++++++++++++++
 drivers/acpi/scan.c                          |  16 +-
 drivers/platform/x86/Kconfig                 |  11 -
 drivers/platform/x86/Makefile                |   1 -
 drivers/platform/x86/i2c-multi-instantiate.c | 174 ---------
 drivers/spi/spi.c                            | 142 ++++++-
 include/linux/spi/spi.h                      |  32 ++
 sound/pci/hda/patch_realtek.c                |  43 ++-
 11 files changed, 592 insertions(+), 212 deletions(-)
 create mode 100644 drivers/acpi/bus-multi-instantiate.c
 delete mode 100644 drivers/platform/x86/i2c-multi-instantiate.c

-- 
2.25.1

