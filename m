Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0268350C22C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiDVWKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiDVWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF5F1785B3;
        Fri, 22 Apr 2022 13:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uvq5CriEtsbyKtO5Xh2ZHOkihiaQxhhLwOlltJXa/e0oDErWjmULJdoGEPm1VJcHteynFlWxl7Q0WTxs7dojb8mAnD1g7t4JyyGo7MRqhVvMkQzm4+xjKnZbr2Lif1HYtqz3ChRMkSOEnvMG08Fm4JiXMmX+lSMKYU/wNgNXI3R3h8b4ChnMThe8mG5SfoKLCBxEDpufsn2P4WguDJsoP7CwGETyv8vRazPIJ3ybR4WgLFKIbpQLFbrmnzdsXCYL6dRlDB/s+1xRkvKl9dyjlbeyAXLnaQsn8RfunS9Xvg8WDn4plT45xdwPXGyzrZs/ahtQfofLYPxvBlm7IXTLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCSBssyt4i+JZe6Y5IvmY9G5sVSpfyfSPFL2C999oPk=;
 b=LgI4w3oTWLnW5mj0Uoz7gpItABf/wycc11vPF3eo+PKcsq4cA7SMB0k1SwN38sc20FLJ50Ar72Xf5YHSeXJZ+tAIXnHRmBkn/2T0n8gyCRysxrf/URJEiqNHJvHgD8K9zVYGimtKT3vYDIedys4gxXNiiE58bRH+es7biUpsnYFNrmxLAPozle/L2/bUp8lf5jFGT30GScGRN7InqsfVe2KhjrTnTpQjocn5HHyntOXWAD11y38vmaiW31yF/4G4MX2wEHCNKlInUye2zE9jsNXCNMr8Sym4/RBfzaAU4XMGbFGUAH/YsLixYcufx0vVdOwiWKC45zypJgJ8gDplvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCSBssyt4i+JZe6Y5IvmY9G5sVSpfyfSPFL2C999oPk=;
 b=W79EIvEOhk81nclZtXXD5W4mRh3mqXkplqtcb3vJIdpSMkFneukWc8fQCid5B6USvh8aWP77PSAXFMjzX2OUgtEiNLVQFVeMBSezHyVEld+xGn0hj/YZAihwCmbe8isyzw/Tpmw3SbYOIyq0wPxrqE9MP7Zneu/zb9Ijea5xsrE3sGHUaoMEGVT8bPEPtxmPNu5HybzK/HCalqu36Ze3Pl2GV4o3+LFQV4/IGUwO71moiSTEXqVPwlDc0bY8k7E78L4+JhOooHBEONmCPpVjQRCWviqY2l9HohNm33k9LbC4cxM9iy3be0mYBT5OJ49VGWkb4I4y9DCoFcyjKNljiw==
Received: from DS7PR05CA0019.namprd05.prod.outlook.com (2603:10b6:5:3b9::24)
 by DM5PR1201MB0059.namprd12.prod.outlook.com (2603:10b6:4:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 20:52:18 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::fb) by DS7PR05CA0019.outlook.office365.com
 (2603:10b6:5:3b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 20:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:52:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 20:52:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 13:52:16 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 13:52:16 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v6 00/10] Intro to Hardware timestamping engine
Date:   Fri, 22 Apr 2022 13:52:11 -0700
Message-ID: <20220422205221.952-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53b0b17a-1d42-4e53-85f0-08da24a1fd2c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0059:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB005945FF0FF3FFFD21468213AEF79@DM5PR1201MB0059.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OfF9TO8sXzTulYESTIsCyj9kVJnSCwQvODKgVOeuo3ONAQ5rbNBSW3yWLw6HN8lw2lF1sBZiMZm9By6WWdv9F8k+hqJ6trPjo9pA7xkCD1LJj+2TPOSRrA9stdNwySGykp7MNrLJNZCEBbnoprzpZQ/wb27a3zqSv8bK4YQMwxTxQcoVfdOpzO3dDm3V/uEquji+wp2MeYaD8U1gg/HhruPO7Goc/1NtpBUGsooipwIOPiVT2Mn/oohzesz1B3u6DhshsOGML+pYJaLopS+1XQc/A1+nCxSM4Hi3QDL/jqOEae55fhYUXWmPY+kPcPoL+TKEDyofw75bPysb438WanDt1LZVJPqFe+jQRJ7boE67zlxDtoGEKM9BV8oM5j9sxr83Pp315Xe5AztY1lfWXOrvHMUrUsQjflHSV5jXJsglaAUSyeTDiRHoTzUnnUxEsrxAtQMt83qRsV1CBpQum9rVjWfEeE/BePtq6jETl46/aXOPdgP+VXXhvJUmZtDThMtp2NbNSIw/qJniZJjNXXQdF5/I2agT87afHPMl12tiDPrMBQTi9xDHKSI4w8E4I1e9BHEnBGbAbObNjRmhtd3kewGQDhp12e/Bd98q1IPJBjLBb9seQoLK42zRJKmfLA2R2P+9px25PDN3TZo96TAaSGkWmFpB6MdHPkAECmtyHlBsS7iw41B5w4T5G3x3AC3peSr4itAku0V24aEtm0KgdVZ5fcd9Tcu1iB6/WSLY5YEQbXE+WWSD7vaHBV4zGvVm5v2x9KDajF2fjU6Ni17HPrzE+oO/+lFuf/9b7WbWBZE9xn5hFSeHHOXrC0+s7T0DgJcl6Bkbb1xdvctAbvYMtYoPGpVbS8xZqTzr9ik=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(2906002)(70586007)(8936002)(2616005)(83380400001)(508600001)(316002)(8676002)(36756003)(4326008)(86362001)(110136005)(966005)(7696005)(40460700003)(356005)(47076005)(7416002)(6666004)(70206006)(107886003)(36860700001)(921005)(426003)(81166007)(5660300002)(1076003)(336012)(26005)(186003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:52:18.0828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b0b17a-1d42-4e53-85f0-08da24a1fd2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0059
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
clock source info callbacks to HTE subsystem.
- Provide optional xlate callback to the subsystem which can translate
consumer provided logical ids into actual ids of the entity, where entity here
is the provider dependent and could be GPIO, in chip lines or signals, buses
etc...This converted id is used as communication token between HTE subsystem
and the provider.
- Push timestamps to the subsystem.
- Unregister itself on exit.

Typical HTE consumer does following:
- Initializes line attributes.
- Obtains HTE descriptor.
- Request interested entity it wishes to timestamp in realtime to the
subsystem.
- The subsystem does necessary communications with the provider to
complete the request, which includes translating logical id of the entity to
provider dependent physical/actual id and enabling hardware timestamping on
requested id.
- The request includes callbacks, it will be used to push timestamps.
Optionally, the consumer can provided threaded callback, if specified, the HTE
subsystem uses workqueue executing the secondary callback.
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
- Corrected grammatical errors in HTE documentation and its bindings documents.
- Removed multi-plural words in the HTE DT bindings.
- Reflected changes done in DT bindings in the respective source codes.
- Separated previous patch 07 into two patches in this series as 07 and 08.
- Corrections in MAINTAINERS file.

Changes in V4:
- Removed hardware-timestamp-engine device tree property from gpio.txt.
- Added hte_req_ts_by_linedata_ns.
- Removed hte_req_ts_by_hte_name.
- Renamed devm_of_hte_request_ts to devm_of_hte_request_ts_ns.
- Corrected hte ts seqeunce counter handling in hte related code in
gpiolib-cdev code.
- Added line level detection in Tegra GPIO HTE provider.
- Corrected GPIO line level calculation in gpiolib-cdev.

Changes in V5:
- Minor changes in dt-bindings.
- Removed kernel thread in the HTE core.

Changes in V6:
- Changes in dt-bindings.
- Added APIs in HTE core.
- Merged tegra HTE test drivers.

There are patches pending to add HTE provider for another Nvidia Tegra chip
which will be pushed after this patch set.

Dipen Patel (10):
  Documentation: Add HTE subsystem guide
  drivers: Add hardware timestamp engine (HTE)
  hte: Add tegra194 HTE kernel provider
  dt-bindings: Add HTE bindings
  gpiolib: Add HTE support
  gpio: tegra186: Add HTE in gpio-tegra186 driver
  gpiolib: cdev: Add hardware timestamp clock type
  tools: gpio: Add new hardware clock type
  hte: Add tegra HTE test driver
  MAINTAINERS: Added HTE Subsystem

 .../hte/hardware-timestamps-common.yaml       |  29 +
 .../devicetree/bindings/hte/hte-consumer.yaml |  39 +
 .../bindings/hte/nvidia,tegra194-hte.yaml     |  88 ++
 Documentation/hte/hte.rst                     |  77 ++
 Documentation/hte/index.rst                   |  22 +
 Documentation/hte/tegra194-hte.rst            |  47 +
 Documentation/index.rst                       |   1 +
 MAINTAINERS                                   |   8 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/gpio/gpio-tegra186.c                  |  81 +-
 drivers/gpio/gpiolib-cdev.c                   | 252 ++++-
 drivers/gpio/gpiolib.c                        |  58 ++
 drivers/gpio/gpiolib.h                        |   1 +
 drivers/hte/Kconfig                           |  33 +
 drivers/hte/Makefile                          |   3 +
 drivers/hte/hte-tegra194-test.c               | 239 +++++
 drivers/hte/hte-tegra194.c                    | 730 ++++++++++++++
 drivers/hte/hte.c                             | 948 ++++++++++++++++++
 include/linux/gpio/consumer.h                 |  16 +-
 include/linux/gpio/driver.h                   |  10 +
 include/linux/hte.h                           | 272 +++++
 include/uapi/linux/gpio.h                     |   3 +
 tools/gpio/gpio-event-mon.c                   |   6 +-
 24 files changed, 2929 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
 create mode 100644 Documentation/hte/hte.rst
 create mode 100644 Documentation/hte/index.rst
 create mode 100644 Documentation/hte/tegra194-hte.rst
 create mode 100644 drivers/hte/Kconfig
 create mode 100644 drivers/hte/Makefile
 create mode 100644 drivers/hte/hte-tegra194-test.c
 create mode 100644 drivers/hte/hte-tegra194.c
 create mode 100644 drivers/hte/hte.c
 create mode 100644 include/linux/hte.h


base-commit: c2528a0cdebd8ba7ef30e0655f8ea89f34c3a633
-- 
2.17.1

