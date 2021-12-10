Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7131847041D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbhLJPpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:45:46 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:20346 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242996AbhLJPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:45:44 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BACurAO000494;
        Fri, 10 Dec 2021 09:41:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=megKTtdERtUJQU7KuUP30kshCuoJQgJUVUMQRry7JoU=;
 b=LXVZWtCvdmAuqmh2Ote9MrHf/T4NZp8c3ySe44tjnLIxw0OkWbHYCqvPswUUFxMAvG2h
 eHm6aRAE1G/qVb4t5JNRXz2YjecZgistwAyNNwL2zsxIZ1FwPFmoD+QbO2XMtyfkLJgT
 DfI5DgZXZDLErdmA+zJbY/P2ev3abvLDaC6S7ijyZ3zjDQXDrt7DTCO8gpOzN8Ru0Ohq
 ArZpMVCBZzVBf3s1DLiwLjjifAfuu+xlJ+gAkAcp0OIGJJe+SdnMYnj41PDWQ0ZtpebY
 eQ73xoM8rJev8BypF9DWhMiMebeQYXogfY1cBflmde9Gr5yhKjbDkgCk4xhpldiUB3Oe pA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cuds09y4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Dec 2021 09:41:59 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 15:41:57 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 15:41:57 +0000
Received: from LONN2DGDQ73.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ED93B2AA;
        Fri, 10 Dec 2021 15:41:50 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 0/6] Support Spi in i2c-multi-instantiate driver
Date:   Fri, 10 Dec 2021 15:40:44 +0000
Message-ID: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _mPNY6G98xq7wlA5zS2fSdP4vUb_8Q4z
X-Proofpoint-ORIG-GUID: _mPNY6G98xq7wlA5zS2fSdP4vUb_8Q4z
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SPI bus in the ic2-multi-instantiate driver as
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
driver, being upstreamed:
https://lkml.org/lkml/2021/11/23/723

Changes since V1:
 - Added Cover Letter
 - Split SPI patch into move, rename, reorganize and add
   SPI support
 - Hard coded BUS type for better decison making at bmi_probe
 - Driver moved to acpi folder
 - Change to use acpi_spi_find_controller_by_adev
 - New shared function bmi_get_irq for I2C and SPI


Lucas Tanure (3):
  platform/x86: i2c-multi-instantiate: Move it to drivers/acpi folder
  ACPI: i2c-multi-instantiate: Rename it for a generic bus driver name
  ACPI: bus-multi-instantiate: Reorganize I2C functions

Stefan Binding (3):
  spi: Export acpi_spi_find_controller_by_adev to be used externally
  spi: Make spi_alloc_device and spi_add_device public again
  ACPI: bus-multi-instantiate: Add SPI support

 MAINTAINERS                                  |   4 +-
 drivers/acpi/Kconfig                         |  11 +
 drivers/acpi/Makefile                        |   1 +
 drivers/acpi/bus-multi-instantiate.c         | 500 +++++++++++++++++++
 drivers/acpi/scan.c                          |  19 +-
 drivers/platform/x86/Kconfig                 |  11 -
 drivers/platform/x86/Makefile                |   1 -
 drivers/platform/x86/i2c-multi-instantiate.c | 174 -------
 drivers/spi/spi.c                            |   9 +-
 include/linux/spi/spi.h                      |  22 +
 10 files changed, 552 insertions(+), 200 deletions(-)
 create mode 100644 drivers/acpi/bus-multi-instantiate.c
 delete mode 100644 drivers/platform/x86/i2c-multi-instantiate.c

-- 
2.25.1

