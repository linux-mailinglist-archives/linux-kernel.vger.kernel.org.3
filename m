Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8F4EA74E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiC2FrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiC2FrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:47:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9EB1C118;
        Mon, 28 Mar 2022 22:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0DxgoQJVBMnorAUNuBLy5VkdFwyVYBJRq0yGcL6sAxD4Wd7K0dgGV7hFCLQtTSVf/Qik2zqLPmXcdSi91Cef4V7XYKAS2qJAoYpUSYofmsc3/Qqa6nUfc7RvCsaA5YM/McZwtGU7iaWZeAYyi5JXewUOJQVpH4g9RTem8RO8RsFNkShw1EzfJfNmBv/xT5uCc1lQ8o8mNskUqPBa+0uVTxPTL/3R2C0P89a0+O6B8dAqfn222NCe6FS59VHfj+pQLZPve1ZlBW09BhMA+tFeVtXhBukwAcNYWedKIQt0cuT1/qNVZ6c5e0DoFRToG/xX6a+DB18yZwGd027TpT2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvdmBkIYG/opkno7SVRi59TkRXMUlqbKNyFhhz3OLeY=;
 b=eFNYDb7tm16AxWbCVgVH4+pwNFMCjI/Bw+LP/jyXEw98PeNn853OZTnMSWSeMvTSQ7Jmg8VR2QqLBpgH/TuTCWBJJsyMkPYYZxwm0LqOHfXhFSf5yQuEV2rrhlwiFZyLZe0FKGkSTthyCo/l03vWjtaolyj4eJQuWYEfmhPicnWOWtZHLbGKsCGIcpMR/EPQZyPNa5Ll0UACbvaiQBNxQyn02Dby367Bi+5bcXbIjKibbsGnh/tYG9uA2KJnOS40f2rfJagVSirYLoM11ENSta4WLR5kaPCWBOTSqfaH3tOlSkE6eFbrKlm6EZy4J7E0go5n3Z+SaTvHkfD824uixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvdmBkIYG/opkno7SVRi59TkRXMUlqbKNyFhhz3OLeY=;
 b=CU/2mkFtUYf9YlHf3Ha2HdK2/lviqOypDurmwvAdtze/0+QNPutQvv4EtjSnOFsKCa6tUZBmJ82rLTfAqDOPiapzst3yZAmmvMEKhk7yxkq4c3osNhogaf9+H3Ewdd0nglkDuz3vW8tzNYdnyGoknGY7ZzUkD9F62QCoUfVjn+TFTuufYo406bnXr/Q/66Q486LMBcTca9JAHbk58MOyRbHR7xZ+p2sfEBxKkYt/vmXrQuC3PlrRCKLbSFtRruofgUxyupghVRRtYvXl5zKyTquxsYxZLJfdi2hSVAy1MfWLUryVbmt2nbO69xpLOntuu8Jtdn5kV+BxH1DfLmY6pQ==
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 05:45:22 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::bb) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23 via Frontend
 Transport; Tue, 29 Mar 2022 05:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 05:45:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 29 Mar
 2022 05:45:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 22:45:20 -0700
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 22:45:20 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v5 00/11] Intro to Hardware timestamping engine
Date:   Mon, 28 Mar 2022 22:45:10 -0700
Message-ID: <20220329054521.14420-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 316646fa-4f7d-4cfd-4365-08da114750e1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4298:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4298E3E89FFB20B3A8C21BDCAE1E9@DM6PR12MB4298.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfzjyWZdACr2u0YJZ0nQv1/IudT8RGHJbQI7Tpnj64aaGv5M620hx1AxovaI4CQ53WKCx3UbonHcMXkdXli2+v9PXQFY/hoq4mx4TM7QICv68QWfl1+sAsQwR4D8LZNA0GuuxtClzJ58EmCWF9l3p0tkslrCZ2nkZ8DRER126TTm4U3cyBy2zB7pvDDZ/52gEz3TLhedR/TM4Db3DljwMXvxrOxA0EUPGvHtLGDQIbEjkoU8bT5Nw2eCJDsYK5xFnO1bUDcUm0PrreQueXsDX4aYqfI0OYg2bFQ58FNuE8M7rEtprWhTPgABJJawoB9lKOj9yWbFf1MDWqyYLUAfdHS49zDfGCWprbsiAfXdusd+y/hFUq4ppees2siZIBqwjBcBrRZ7Hupz9vCiqr+b4qgnmslazVEM0IsoB8QgsEz0FsmZCSZAdFvTLDpWa3aBhZb7t+K+F94H7AuQeoaPGgyGnf/TdQKIk0r46inHnuA/5zEgv9vOtb+I5ocThHwb5EeZBTnFAsaHC46990KSD1ff2vP3vzCeZKNJjiOlwhPRKr38+qmQ3EXCEPQKRDxvN5U/A+ojC+SwSIfshjkg6E0Kp6V9AQjJQW72smMe6Zw/ZbI25Al903nnU+jEQZgZ+JfJ4vTgLUbd9zG3jtgvUB5CKcnKccC44xG26VBm2viEhWsEhVYxTf2idNDHzfWdt4EfCwY6z+1Hre7ziLTYYT9ElH3a2QrkBwFAZElu7KT6cvCJeejjEIA+kipZV857kCrxY5nNyvKFlC5pJcxdxtUYY6oHOcJtldat7+2Qn2Jt3fs9/+d6EqYX1MGReNDfEcmoAs/HS2vdyGfQaIs52zrN3HvMGdoeVyDvaWYOquY=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(40460700003)(4326008)(6666004)(7696005)(7416002)(82310400004)(2906002)(36756003)(8676002)(110136005)(316002)(1076003)(2616005)(70206006)(81166007)(86362001)(83380400001)(426003)(26005)(336012)(921005)(36860700001)(47076005)(508600001)(186003)(107886003)(966005)(356005)(5660300002)(8936002)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:45:22.2387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 316646fa-4f7d-4cfd-4365-08da114750e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
- Minor changes in dt-bindings
- Removed kernel thread in the HTE core.

There are patches pending to add HTE provider for another Nvidia Tegra chip
which will be pushed after this patch set.

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
 .../devicetree/bindings/hte/hte-consumer.yaml |  43 +
 .../bindings/hte/nvidia,tegra194-hte.yaml     |  82 ++
 Documentation/hte/hte.rst                     |  83 ++
 Documentation/hte/index.rst                   |  22 +
 Documentation/hte/tegra194-hte.rst            |  52 ++
 Documentation/index.rst                       |   1 +
 MAINTAINERS                                   |   8 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/gpio/gpio-tegra186.c                  |  81 +-
 drivers/gpio/gpiolib-cdev.c                   | 247 +++++-
 drivers/gpio/gpiolib.c                        |  58 ++
 drivers/gpio/gpiolib.h                        |   1 +
 drivers/hte/Kconfig                           |  50 ++
 drivers/hte/Makefile                          |   5 +
 drivers/hte/hte-tegra194-gpio-test.c          | 273 ++++++
 drivers/hte/hte-tegra194-irq-test.c           | 179 ++++
 drivers/hte/hte-tegra194.c                    | 690 +++++++++++++++
 drivers/hte/hte.c                             | 828 ++++++++++++++++++
 include/linux/gpio/consumer.h                 |  16 +-
 include/linux/gpio/driver.h                   |  10 +
 include/linux/hte.h                           | 253 ++++++
 include/uapi/linux/gpio.h                     |   3 +
 tools/gpio/gpio-event-mon.c                   |   6 +-
 25 files changed, 2986 insertions(+), 37 deletions(-)
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


base-commit: f8833a2b23562be2dae91775127c8014c44d8566
-- 
2.17.1

