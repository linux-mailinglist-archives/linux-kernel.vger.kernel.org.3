Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160A049128D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbiARASn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:18:43 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:18081
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231768AbiARASl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:18:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEPfzhr7ViO5iN/rtH2Dm+VNddEFzi7/lDR7yNdsRveUNO2gpk+A9shTNE7pN9vC0QEeubaTl/t7aqKhPsGW7YwWCggbyDm3yg8wj3lj2L3/sDHKafg7z1sfAGpTq9I06WkSl8QSo1cnAS70stmhybPG0taT2WjhmXUkYovvwuJRg4ZY2X1hxM6X/VWvy5kcL2s8guK0hF1fwpYrlvtnEBGafWK2EkOKy5ZqVQSHjRVdWKTvP09dpqYOMzHXudVn+DFxtHZfGZzM56RK25yCOiK2ZtEJ5z33ON+u5L5W7pMOryfP+sX2/SoqiKV7dSJY2E0HKzrCupkpK6vyeDG1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyxEvFwIbxMWlu4UstBX65Y7BCHvXTAXf1p9ALTmJFY=;
 b=aCUL/pBSOmWnwbhsTlHbQnRF+10CvT62oeRQ8LdC3D76SJevJHbCnfWJL51e2zteG7DAaC/dVpP5dFtBKu/n0ni3NFjm0rSApfC/FJoaNXEq8FdaQnWCsPzNP+dLEm/B8kavXxbmQCKKA5+ewa2Z6rFFoZaPA3Lkh2jnDHbjcEP3Ct0PsPrIyu9QOlD0/a8rjVyV7lLLNbJ9iN/VMOQ2dWdJz4Sc/O9MPUDFRPSgPgVrH4KvCIYjmOvNYlNxTVZPHDalI31GyLG28O//OBgoYCyHCzrYxkfjoNQnossq779hx2q4w9aJtfFnKgcxwFyEKHt3xsduEXV8RpUdgFKtgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyxEvFwIbxMWlu4UstBX65Y7BCHvXTAXf1p9ALTmJFY=;
 b=YoWMvFmbKPK5HYFo8a8T0OaLhWHNdD46IaiVCZQzLKNIR8Q7BLu7tjnyV+IFwfL2nej+f4sGwfcK4okwfx75bYEoovUJ9YkmUnDBi6xpLGjkzPik7DpmN/ZQMmis1ay7gbCj8SmAWUehRsg5LxmNko3CNfS24UrEO9FvfnL8tZPzDC5cNxO69usHKRsQd1yRi6XVWItu1iHoOtf15X1Pyz9/+g4Oy0Y5aNbkhzv6xjcTXdXO+haH3CHx/xyYOFQ6Pd9xyN06cqdtz9KqIkF4Euvg+YdqRXz9e/uisrPS82C9UfaV23q1v3nf3i7CBGPy2SC1rWV14K0RtMDxM5bjEQ==
Received: from MW4PR03CA0072.namprd03.prod.outlook.com (2603:10b6:303:b6::17)
 by MWHPR1201MB0272.namprd12.prod.outlook.com (2603:10b6:301:52::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 00:18:39 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::ff) by MW4PR03CA0072.outlook.office365.com
 (2603:10b6:303:b6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 00:18:38 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:38 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:38 +0000
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:37 +0000
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [RFC v4 00/11] Intro to Hardware timestamping engine
Date:   Mon, 17 Jan 2022 16:22:03 -0800
Message-ID: <20220118002214.18271-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b04b489e-932f-41d7-67d2-08d9da181366
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0272:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0272694C9DA9E3D8DE8530A8AE589@MWHPR1201MB0272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsGPzN/LOgsU7tjJXNhhlFD613890B8oL0uUKvYt3wWvttJFV1OaIi5HKhCUzKGll2ar6Okk3M0Uuh7ZVF+sW6WM5hAg7M3G3yN2qHETJRdaRhLhits4SQgm59YFcc751CHbYbH0FW8RfWIRhYtVNyF+H/2IIP1rH8v4u+iUYlp/cmsTPXXpo5jmoe1B/jxa2F0A+/mQVfKo1tzuGWe5c7Klyv4UrykUfMfbliTFWSr4jh1eQcfLjGwAqq7oqys6NOOLjhYS+fASFZWtTl1cPDdqhEb0u6o3bHN+e42Egi/ZkT9ec/XmJIUbFrEEluOnh3XyZbmQyxOt1xfl2Kf9+ODn8F6aD8508TYIJ+v0NrXXkNU8IN8ZILwZxCqv33II840nBIaGBgtw2Wh0mHtRSZN9xpZ1vRcAeF34oXJy6s7msbcEBWORR5+bAOv74cMI+362105ip62XBsNK3LATuZgbHw3deOh2sTnE/qEYbDobgrAcL4W8KUzaXwxxv3U/8t99C0csjQwWto6RfSMn+XAWKpql3JzYp75k5YZ7rvu4DGRH4E4Xvt0cpIrOk5UHeePEQVTiFhkKqf+xSxbgPaod2atqYzeYDCo9w2cIipSDUbI+vCXqY5lMRKfgq8B7d4AgXvVh6Cr7Cd2Aqz21EljDZmAIOdi2pMII2Wjf9Bg/JYr94/wLhV6dHtsfRQnHYRJ25z4wuUW190omcs7prIq6IXoODW0xyWoM9mHW3CYooVrIoxEXNyzmmoUkc5IABlKLUo0uSchE2izFNOqy/e+7evvJTgFvZvUKEomF4WbcoxH+Ou+VgDF5GvyfzKyoJbIp1tIxpn8X/XQXJ9u50UDtQsA4pbIIiOu6mkG2nj9H1qDxhf6imSgTT0hpZdrDNQUP8TFL63fppNkS1B5HH/GNfmNQLmHpwJAt5BMtz8SxoMkv8yY9bL+Q6aioJOGn
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(8936002)(7416002)(7696005)(966005)(316002)(110136005)(107886003)(921005)(70206006)(70586007)(2906002)(2616005)(6666004)(83380400001)(508600001)(47076005)(336012)(1076003)(36860700001)(356005)(40460700001)(426003)(86362001)(5660300002)(186003)(36756003)(4326008)(82310400004)(8676002)(81166007)(26005)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 00:18:38.8090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04b489e-932f-41d7-67d2-08d9da181366
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0272
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces new subsystem called hardware timestamping
engine (HTE). It offers functionality such as timestamping through hardware
means in realtime. The HTE subsystem centralizes HTE provider and consumers
where providers can register themselves and the consumers can request
interested entity which could be lines, GPIO, signals or buses. The
HTE subsystem provides timestamp in nano seconds, having said that the provider
need to convert the timestamp if its not in that unit. There was upstream
discussion about the HTE at
https://lore.kernel.org/lkml/4c46726d-fa35-1a95-4295-bca37c8b6fe3@nvidia.com/

To summarize upstream discussion:
- It was suggested by Linus and Kent to extend GPIOLIB and supporting
GPIO drivers to add HTE functionality and I agreed to experiment with it.
This patch series implements and extends GPIOLIB, GPIOLIB-CDEV and GPIO tegra
driver.
- Discussed possibility to add HTE provider as irqchip instead which
was argued against as HTE devices are not necessarily event emitting
devices. From RFC version 2 however, emulated threaded irq style
implementation.
- Discussed other possibility if HTE device can be added as posix clock
type like PTP clocks. That was argued against since HTE devices
are not necessarily tightly coupled with hardware clock.

Typical HTE provider does following:
- Register itself with HTE subsystem
- Provide request, release, enable, disable timestamp and
get_clk_src_info callbacks to HTE subsystem.
- Provide optional xlate callback to the subsystem which can translate
consumer provided logical ids into actual ids of the entity, where entity here
is the provider dependent and could be GPIO, in chip lines or signals, buses
etc...This converted id is used as communication token between HTE subsystem
and the provider.
- Push timestamps to the subsystem.
- Unregister itself on exit.

Typical HTE consumer does following:
- Request interested entity it wishes to timestamp in realtime to the
subsystem.
- The subsystem does necessary communications with the provider to
complete the request, which includes translating logical id of the entity to
provider dependent physical/actual id and enabling hardware timestamping on
requested id.
- The request includes callbacks, it will be used to push timestamps.
Optionally, the consumer can provided threaded callback, if specified, the HTE
subsystem will create kernel thread responsible executing the threaded callback.
- Release entity and its resources.

HTE and GPIOLIB:
- For the HTE provider which can timestamp GPIO lines.
- For the userspace GPIO consumers, the GPIOLIB CDEV framework are extended as
a frontend to the HTE. The kernel space consumers request GPIO lines directly
to HTE subsystem.
- Tegra194 AON GPIO controller has HTE support known as GTE
(Generic Timestamping Engine). The tegra gpio driver is modified to accommodate
HTE functionality.

Changes in V2:
- Removed buffer management and related APIs from the HTE core.
- Removed timestamp retrieve APIs from the HTE core.
- Modified request API with two callbacks, second callback is invoked in thread
context and is optional, while first callback is mandatory and used to push
timestamp data to consumers.
- Replaced hte with hardware-timestamping in DT bindings as hte appeared too
short according to review comments.

Changes in V3:
- Corrected grammatical errors in HTE documentation and its bindings documents
- Removed multi-plural words in the HTE DT bindings
- Reflected changes done in DT bindings in the respective source codes
- Separated previous patch 07 into two patches in this series as 07 and 08
- Corrections in MAINTAINERS file

Changes in V4:
- Removed hardware-timestamp-engine device tree property from gpio.txt
- Added hte_req_ts_by_linedata_ns
- Removed hte_req_ts_by_hte_name
- Renamed devm_of_hte_request_ts to devm_of_hte_request_ts_ns
- Corrected hte ts seqeunce counter handling in hte related code in
gpiolib-cdev code
- Added line level detection in Tegra GPIO HTE provider
- Corrected GPIO line level calculation in gpiolib-cdev

Dipen Patel (11):
  Documentation: Add HTE subsystem guide
  drivers: Add hardware timestamp engine (HTE)
  hte: Add tegra194 HTE kernel provider
  dt-bindings: Add HTE bindings
  hte: Add Tegra194 IRQ HTE test driver
  gpiolib: Add HTE support
  gpio: tegra186: Add HTE in gpio-tegra186 driver
  gpiolib: cdev: Add hardware timestamp clock type
  tools: gpio: Add new hardware clock type
  hte: Add tegra GPIO HTE test driver
  MAINTAINERS: Added HTE Subsystem

 .../hte/hardware-timestamps-common.yaml       |  29 +
 .../devicetree/bindings/hte/hte-consumer.yaml |  44 +
 .../bindings/hte/nvidia,tegra194-hte.yaml     |  82 ++
 Documentation/hte/hte.rst                     |  83 ++
 Documentation/hte/index.rst                   |  22 +
 Documentation/hte/tegra194-hte.rst            |  52 +
 Documentation/index.rst                       |   1 +
 MAINTAINERS                                   |   8 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/gpio/gpio-tegra186.c                  |  81 +-
 drivers/gpio/gpiolib-cdev.c                   | 247 ++++-
 drivers/gpio/gpiolib.c                        |  58 ++
 drivers/gpio/gpiolib.h                        |   1 +
 drivers/hte/Kconfig                           |  50 +
 drivers/hte/Makefile                          |   5 +
 drivers/hte/hte-tegra194-gpio-test.c          | 273 ++++++
 drivers/hte/hte-tegra194-irq-test.c           | 179 ++++
 drivers/hte/hte-tegra194.c                    | 690 ++++++++++++++
 drivers/hte/hte.c                             | 887 ++++++++++++++++++
 include/linux/gpio/consumer.h                 |  16 +-
 include/linux/gpio/driver.h                   |  10 +
 include/linux/hte.h                           | 250 +++++
 include/uapi/linux/gpio.h                     |   3 +
 tools/gpio/gpio-event-mon.c                   |   6 +-
 25 files changed, 3043 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
 create mode 100644 Documentation/hte/hte.rst
 create mode 100644 Documentation/hte/index.rst
 create mode 100644 Documentation/hte/tegra194-hte.rst
 create mode 100644 drivers/hte/Kconfig
 create mode 100644 drivers/hte/Makefile
 create mode 100644 drivers/hte/hte-tegra194-gpio-test.c
 create mode 100644 drivers/hte/hte-tegra194-irq-test.c
 create mode 100644 drivers/hte/hte-tegra194.c
 create mode 100644 drivers/hte/hte.c
 create mode 100644 include/linux/hte.h


base-commit: 07f8c60fe60f84977dc815ec8a6b1100827c34dd
-- 
2.17.1

