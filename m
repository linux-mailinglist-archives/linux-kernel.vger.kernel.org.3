Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06C1467F3B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383211AbhLCV1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:27:42 -0500
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:13665
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343604AbhLCV1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:27:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpPj0P0z0xexeyh9DHhBIxqVIDVDornbLxEUdqhTBXSlRnN7BIYkLt0pOrIhxHckeBRt6zEIecOwFLAVKirMUVOIkboEGD3hhWyL1hKmSliCqfDW9z8LzmOGy8v5bXFGeef4n8BFzBooiqtYSPw1RYwot0h9oMlLA+ijbiduG9FdjvEJ4J8EkFXcbEaoXcNRMXhr/mk4E0dl8k6djod9U5Wp3aklyEa+lN5Ih1YiFRYKlTG/4g88v/t29sobTnQ966+t+KQ+1xPEdYXoE3LNyFYWBjIAyNutu4HMPCOo+83Nio294Xhee7bAPzsW0uMflqfOVtvqVxT7JzemRufMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9osciprBjfgPHB0rmvprFZspGoIxxBbK6uZ0xZh2ag=;
 b=b/rxwCMVKlhYxyc5CtX9Bt4S9LyGZixycUmpjn/ijqDFEjOp/XNGneO/ngrlj8GVoE5oVez+YlfhX2qoXO0nv7iP/yw15cIer0U0AseR0GceksuUfO1Xw895JFKiyuP8g4ChQjHMvdc5G1XCFvM2mlJGb5c7FHPswPY3Cxw5oz4NV1FUDGTNHxroipcMIdh0elkTL5IyelL6ZGbYEG886+Rp7gNT73q+wfE+hDxyhsaPv+TOxzUvZ2D8Fnz1YXlPBuT2RH+ayOSh5c9uLUVYbIH+OwBGFbNB8zBIKz20xGIEIEdbsFNMBahAzWdTbw60W24VttTP8XLe+XN2IFElvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9osciprBjfgPHB0rmvprFZspGoIxxBbK6uZ0xZh2ag=;
 b=A0PthSVy9VloT0iT3/p1VMSdZ8mMPE8x0OByRYUWAbx2brt9WMjknk4EnyPZUdE8oHw7W0VohkuQ+mAnSVM1PV0H3XWDSmAdwkH37tjYMCpZkTpNAULjf8ePaZu/UTRevza69VL/Y73PtP8dfYgNoBdoFu6HXz4g6OGnmtSllYA=
Received: from SN7PR04CA0047.namprd04.prod.outlook.com (2603:10b6:806:120::22)
 by BYAPR02MB4456.namprd02.prod.outlook.com (2603:10b6:a03:57::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 21:24:12 +0000
Received: from SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:120:cafe::c3) by SN7PR04CA0047.outlook.office365.com
 (2603:10b6:806:120::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 21:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0034.mail.protection.outlook.com (10.97.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 21:24:11 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 21:24:09 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 21:24:09 +0000
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michals@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 linux-acpi@vger.kernel.org,
 heikki.krogerus@linux.intel.com
Received: from [10.71.188.1] (port=14741 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mtG2B-0005F8-ON; Fri, 03 Dec 2021 21:24:00 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michals@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v12 0/5] Add Xilinx AMS Driver
Date:   Fri, 3 Dec 2021 21:23:53 +0000
Message-ID: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e619eb4-a6c9-4696-370d-08d9b6a34019
X-MS-TrafficTypeDiagnostic: BYAPR02MB4456:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4456B4316F0FA32715344F26A96A9@BYAPR02MB4456.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7EelH1R4GAMQBMfDaGA9SOZYgBCI4zOSIgohNPhls8vsDDluA1A96h0VEpwD8ztth0axVkpnH3uCKdjfT57P6dQaRbW/U7DgbvDhI5HbZCB+Df3VyCkz7VJyOtJNHHjx03whKGNQMFRdtCDfKFAYjBmCsg6jdh6LrJadoexm/wFOvMONlHwZKV+o78938Bk7v9UTxCiYP583/Y13Hj+zg3GFPDYzkRWaq7J6wkjbtTOs5jhw6BHmEJ50ETAcWZvbgDRHEqhFoNUjY0bQAGGlyXa+bze1T++YMp2BQyrCE1hsm5b+pQTRC/lQsB0K8Uu3chU1UjrP+6ZIdSD4NtzfeEhQ340voPUAdLltFFwIGuf0qvKQD8CJ0vk3FhtKh/ktkeKFlekuG8XBE/q6QQwxv0bG9uQPVBryyd0PQYfL5+axrtswQtQA3LXBl/9tUGHomGcSZKMof1TC84o7GojGYS8ZXHdwIY0dSJE6f1fptw2XmdLzSkjQ7AgvgVY79QWSyIZeer5stAASkUV3BcrNQST3aeAf/GqDdenYZMNnB5tBQ248Ysf94jpT+m7feg0GNPn9xxnWtL7Ke9cV0M35jrBPezt7N00PkjR/KcqiwDdHzpx2z5LSovjAepTVMqwXwPJHJtV0HLEKTF3tdatIxgXclEpkX2FZSOHZaG7ampgGhjPb6NsWs+rNykz1gAogTyXmN/a+YsvPxirP+dJxaB+x61IaxlLm7OQxTxr1Pe5f8WltocSkEh4+xOKj9fUlih4N7p0FNc+IDTom0GMzBlsIcWSIkptWmOhhNC+NU/g=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(336012)(2616005)(426003)(107886003)(5660300002)(36860700001)(70586007)(83380400001)(82310400004)(26005)(70206006)(316002)(7636003)(110136005)(9786002)(8936002)(47076005)(8676002)(36756003)(4326008)(6666004)(508600001)(356005)(921005)(186003)(2906002)(1076003)(103116003)(7696005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 21:24:11.8142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e619eb4-a6c9-4696-370d-08d9b6a34019
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4456
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
This AMS driver is used to report various interface voltages and temperatures
across the system.
This driver will be used by iio-hwmon to repport voltages and temperatures
across the system by using various channel interfaces.
This driver handles AMS module including PS-Sysmon & PL-Sysmon. The binding
documentation is added for understanding of AMS, PS, PL Sysmon Channels.

Changes in v2:
	- Added documentation for sysfs (Patch-2)
	- Addressed code style review comments
	- Patch-2 (Now it is Patch-3)
		- Arranged the includes in alphabetical order
		- Removed the wrapper 'ams_pl_write_reg()' and used writel
		  instead
		- Removed the unnecessary delay of 1ms and used polling of EOC
		  instead
		- Removed spin_lock and used mutex only.
		- Used request_irq() instead of devm_request_irq() and handled
		  respective error conditions
		- Moved contents of xilinx-ams.h to inline with xilinx-ams.c
	- Patch-1
		- Addressed Documentation style comments

Changes in v3:
	- Updated bindings document with the suggested modification in v2 review
	- Removed documentation for sysfs
	- Removed extended names for channels in the Xilinx AMS driver
	- Modified dts to use ranges for child nodes
	- Reduced address and size cells to 32-bit instead of 64-bit

Changes in v4:
	- Updated bindings document with the suggested modification in v3 review
	- Changed the Device Tree property 'ranges' for child nodes
	- Used Channel Numbers as 'reg' value in DT to avoid confusion
	- Removed unused NULL arguments as suggested in v3 patch review
	- Addressed comments on Device Tree property naming

Changes in v5:
	- Updated bindings document to the YAML format
	- Updated bindings document with the suggested modification in v4 review
	- Renamed iio_pl_info struct to iio_ams_info in Xilinx AMS driver
	- Updated the Xilinx AMS driver to not use iio_priv_to_dev function
	- Updated Xilinx AMS node to reflect the changes in bindings document
	- Update MAINTAINERS file

Changes in v6:
	- Removed all tabs from bindings document.
	- Removed the xlnx,ext-channels node from the device tree since
	  it is not neeeded.
	- Fixed unit addresses for ps-ams and pl-ams.
	- Removed the names property from bindings.
	- Fixed warnings from checkpatch.pl in the driver.
	- devm_add_action_or_reset() used for exit/error path.
	- devm_request_irq() for managed irq request instead of
	  request_irq()

Changes in v7:
	- Added use of FIELD_PREP and FIELD_GET.
	- Added the spinlocks back the v1 which were removed in v2 for
	  no justifiable reason and replaced with the same mutex. This
	  caused deadlocks.
	- Removed the buffered mode information from channel config.
	- Usage of wrapper functions for devm_add_action_or_reset
	  callbacks to avoid typecasting functions.
	- Usage of devm_platform_iremap_resource().
	- Handled platform_get_irq() return values.
	- Removed the remove() callback.
	- Fixed the dt-bindings.

Changes in v8:
	- Replaced *_of_() APIs with fwnode.
	- Added missing headers.
	- Fixed documentation.
	- Added devm_add_action_or_reset() for iounmap.
	- Restructured read_raw function.
	- Added helper functions.
	- Usage of GENMASK for all masks.
	- Added defaults for most switch cases. Some can't be added
	  since the default will never occur.

Changes in v9:
	- Added a fwnode_iomap().
	- Fixed Kconfig indentation.
	- Added the overflow checks before memory allocation.
	- Usage of fwnode_iomap() instead of iomap().
	- Rename ams_parse_dt() to ams_parse_firmware().

Changes in v10:
	- Fixed licence in zynqmp.dtsi.
	- Changed the macros to use BIT().
	- Realign some code to fit within 100 chars.
	- Modified readl_poll_timeout usage.
	- Usage of array_size() instead of check_mul_overflow().
	- Usage of dev_err_probe() instead of dev_err().
	- Usage of kcalloc instead of kzalloc()

Changes in v11:
	- Added missing bitfield.h.
	- Fixed AMS_ALARM_THR_MIN macro.
	- Added terminators to enums where necessary.
	- Added explicit values as suggested to enums.
	- Removed redundant macros.
	- Added delay value for readl_poll_timeout.
	- Corrected shadowed error return.
	- Corrected formatting errors.
	- Added default cases where missing.
	- Made ams_parse_firmware() a single parameter functions.
	- Usage of devm_kcalloc() and devm_krealloc().
	- Directly returning from dev_err_probe().
	- Renamed masked_alarm to current_masked_alarm.

Changes in v12:
	- GENMASK_ULL usage for 64bit values.
	- Added ams_iounmap_ps and amsiomap_pl instead of generic
	  function.
	- Hex values to use all capital letters.
	- Fixed a case of wrong kernel doc.
	- Modified macro voltage names to reflect the scale.
	- Maximize single line usage wherever possible.
	- Handling of fwnode_iomap when CONFIG_OF_ADDRESS is not
	  enabled.
	- ams_read_raw() - Reduce the size of switch statements by
	  using helper functions for IIO_CHAN_INFO_SCALE.
	- ams_read_raw() - Mutex unlocking in a single place using goto.

Anand Ashok Dumbre (5):
  device property: Add fwnode_iomap()
  arm64: zynqmp: DT: Add Xilinx AMS node
  iio: adc: Add Xilinx AMS driver
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  MAINTAINERS: Add maintainer for xilinx-ams

 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  227 +++
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   24 +
 drivers/base/property.c                       |   16 +
 drivers/iio/adc/Kconfig                       |   15 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/xilinx-ams.c                  | 1450 +++++++++++++++++
 include/linux/property.h                      |    2 +
 8 files changed, 1742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.17.1

