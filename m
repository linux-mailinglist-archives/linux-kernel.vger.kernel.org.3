Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA574A67B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiBAWW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:22:28 -0500
Received: from mail-dm6nam10on2075.outbound.protection.outlook.com ([40.107.93.75]:18281
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230336AbiBAWW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:22:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjxBdvg2DQYcRHxMXl9jsqd2N+83LvIzp/2lkJRmSrnOrW02hlHbslWd+oqdMq3pYVE+66LWrP7M6bgbfexHcRPpjpG9kjSwFZ2HVTQaL+Wyi71rNlNEK2pF4ggDBysbpdT8jX5lMLSPsWXZrflZy6FnBpuad9J4602dnISHDYCs+LR6zu2uI7FjAkBYjsQljEHNNJkZZAL67hzGqklhKXI8fSOzT2dnmatbX9OMYQ5yFfXzW98zkIlit6xI4VNfPm4QkglfRA9I7caMbh/cq2FZWw7lddSR3GSbta/2WNFNAm4sS6BZY9He5QpG6rFLuCtXUalwBU4fQHs7+kQ/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4INEFGvjk0RBKuhRWu38HSVmycb6V5yJ4wOc4+Wg5JI=;
 b=CzKzGeQXbYr+HPEAFz+x2yPBy0oXs4ix+4j3J2rg0uBTpBcDHh29ywkiD/ckCp9vC07gKhiP+B3RzgxYGBNLjPs0BgIDOBbaixIOIKQvvlsAeZK2GOoJK14xFS+zd6E/ceCTkarwG/h+EJy6YHnnM+Q1qU1aKZO8bvtHgdKtbxDrQQ5OVKn6IdlfZ8Cxpg4HXdgzqaZpLDpvDbv5z69vcmyNaCpiO3C8iVxSLkAoexzvYpWwH7QYhQHyRK8lfempm3CDTtURT31Ula0q2b+5FclC5HcU+nI39TpRz+hSN3VRyI/qFZ6T6UTCSX/foNwkKg7/Bv15Xe5G3gSesHCzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4INEFGvjk0RBKuhRWu38HSVmycb6V5yJ4wOc4+Wg5JI=;
 b=nuvaxyA3TQpvYOZJfpAsy0aO2pU8gMpKdvLCsq0RAX+bw1OK35zSIIr0+NnaBH1llKj+n6ivxtTbpIxSOJlSHgCT2/qMtaLiqNDsbC1eZXGWEZrJlmZfZXXgjZQfacV80hRvS17F2GMFRV/0vGyt1NWCd9Ht2dlW0TCx+1fBUBQWnOMYtp4wAx2cUukhkQpNz32Mm33yg+4XH7kdrkAZl+m/cw0lgmNA361BXucytXbESrADiAawXbHAdoqSepDn7uyC7JqO7I6kTz6yDKcIfr4DB63cKzB1v7xwPsAlmuzZx9bVNJ0unbSCoHfJPPr8aGI+0jNaxx0W21GUz3JU5Q==
Received: from BN9PR03CA0533.namprd03.prod.outlook.com (2603:10b6:408:131::28)
 by DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Tue, 1 Feb
 2022 22:22:25 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::8c) by BN9PR03CA0533.outlook.office365.com
 (2603:10b6:408:131::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Tue, 1 Feb 2022 22:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Tue, 1 Feb 2022 22:22:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 22:22:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 14:22:22 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 14:22:22 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v4 00/11] Intro to Hardware timestamping engine
Date:   Tue, 1 Feb 2022 14:26:19 -0800
Message-ID: <20220201222630.21246-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddc8aedc-471e-48bc-5550-08d9e5d152cd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5248FEE037B605FFFB8BA185AE269@DM4PR12MB5248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RM+yqRMsYM7foTqc7ufeV//3symJOe6fW2y1B3uBKBG+JuYlrV0l+aS4F3SQRNrfR/G5jhVD3EIyP86MoYFSoy+MG5Gm1IXm4hK1wdSB4AbTIxOJHOGvA6SVYSi9AttJHIp6CQgAoFowVol5ng8FASso6e7ipSIG9Zerpe0CeFKgHRR6w3ftuCtddKYD4AXnZJc0O6snsdjYq3DmusV+Y3VXXTIAbNMorCR63fYCgSWzqkcebH8RDxhM7lq/Hds9IV3HgUUGUAvapNLLBPPGI1nSPHu44gyF8lukwUqm3PDlBqmfD28cBhv8weToEYEszbOIU5TBOkcS1kj32+LphkUUp5ALUUPQUalRudOnZ9Qp/rkNeg2FXTIge1n/51cNKSKEbP4qJp6I11yaiFKJtWTwNgxJZQO/wgRojGHMJ2RAVAAJyvC9m02GjWeQxPpHhAVUaR2qzyS8U/Z0+dF+qvJcQ33/wD87571xUzQhv52BoyN3YWvdt9WibTSGt8sBIBAgPTHPC8kelTxUt2MpS12FhuPVFMstYdGNDM3ZoiFnhUyOY4y8CuiEXZO+kobKuJ5MCxegiMZ30O4erIg4JSN9ZFBJNkOKMdmzpV+xjhTCY/tG03YJIaaZSOwpMkahI9RupOJTraCH4sNJIelJvVdWxjVAozc+F/KU9KShpTI3U+sxtaP40d54c0t0+VKoHxQtnYJZMWHlyRcI/p5xmWC6IJ8cdkdy+rFSZGEnCjGM1pPJczeO6RkxEmO5+LkaI659Lu7YHGRryr77guSUTpzlBnYmRzl7eZBPjLukVWXGvFPv05x4v47c2TbkiuzLQmuSmzh2x44jEIwnf9JwyJVAMwdjZBLoULka8x8SDEg=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(336012)(426003)(316002)(86362001)(8676002)(81166007)(4326008)(186003)(107886003)(1076003)(40460700003)(83380400001)(966005)(508600001)(26005)(2616005)(2906002)(110136005)(8936002)(82310400004)(7696005)(356005)(6666004)(921005)(70206006)(5660300002)(70586007)(7416002)(36860700001)(47076005)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:22:24.7874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc8aedc-471e-48bc-5550-08d9e5d152cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5248
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
- Converted into PATCH V4 series from RFC, RFC V4 remained in the review
without any comments

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

