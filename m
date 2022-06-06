Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C5653E5DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiFFL00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiFFL0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:26:24 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D72123884;
        Mon,  6 Jun 2022 04:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erc0TpAEdY+FIb0aGMGfO11Ha9nVRmYpCGwICrPTT41SfTZkQW+PzJD3ED+L2lIM7AGmcrRy9dHcGODsK8u+vsu+cwcUz1V13UDtiEHdGYOhl/gY0UZPO4meA+HKjiUu1qUyqxreS29IrEnaqpOxCOi05WhVmCKwxIKOb3a0K7QnBQGiovKj+8hFgDJdd+3vXNeamHuv9DcypKYXiUHzv9jm4fcvcLHEAuqaJpgqCMBHIL6i5PBlgdmmswAAHmX4IJz28IkQndq94vL7bLaCuZ45Tqoqc+3OmpkqF6+UR7J7Y/9aw+qrWdYBb7+7ja1h38gYksugz1wPKZV2MPEtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQNi6+nRCuD9tAryUrXQYztjDu9fT3dlG0qO5h6x6bM=;
 b=gadeZCpcEWNrbwUQMCYgGNVNJBtk5YDyVe3ySKQc3EY5QGvMuiyB1vJrnvga+YWjELBy+UI0ANcUom5BsJs4P8aB4bJvjKSg1HrD1ziim+Ash+6zY5LO1vCDRH0s0vOaDyg1rKUpfkwJCZKPXMgE9hUbDA4yAkGTAdyHy6NdzR9bkthhI75GwZhzEpFY5+zJxw/KsE/G8EegP8kVM0UYa+WhmVr08Bf34DBx4X7O2YvQdT/Pgj154C85RvGQlJ0QTiuUbJBAFR6JbjZVFYi1XjyJXXT/FEGLs+ol9+58to86VXf3OAeGqVDA/jdd84j+xynmb59hGkhXSUDYlw/KAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQNi6+nRCuD9tAryUrXQYztjDu9fT3dlG0qO5h6x6bM=;
 b=oE9v1ZpbXxqczKETS2WPoL9gGV85IbgApIYgM4R55tEK0i9BCr8xQBWavKB6znmuOMBz3ZhTISvk1qGAxIMk9gqneQFNRQTRi9vCzum3q9lifcyYhlf5sp8qAS6pMXrLZ4NDqm/5l0zBWSLn7/c3KAFQy39DUByQzg65UR+LqKk=
Received: from SN4PR0801CA0016.namprd08.prod.outlook.com
 (2603:10b6:803:29::26) by SN6PR02MB4127.namprd02.prod.outlook.com
 (2603:10b6:805:30::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Mon, 6 Jun
 2022 11:26:20 +0000
Received: from SN1NAM02FT0012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::11) by SN4PR0801CA0016.outlook.office365.com
 (2603:10b6:803:29::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Mon, 6 Jun 2022 11:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0012.mail.protection.outlook.com (10.97.4.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 11:26:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 6 Jun 2022 04:26:19 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 6 Jun 2022 04:26:19 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 p.yadav@ti.com,
 miquel.raynal@bootlin.com,
 richard@nod.at,
 vigneshr@ti.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 michael@walle.cc,
 linux-mtd@lists.infradead.org
Received: from [10.140.6.18] (port=43350 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1nyAsE-0000SR-Qt; Mon, 06 Jun 2022 04:26:19 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <p.yadav@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <git@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RFC PATCH 0/2] spi: Add support for stacked/parallel memories
Date:   Mon, 6 Jun 2022 16:56:05 +0530
Message-ID: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28d63e8f-bab4-46ae-9f9b-08da47af6174
X-MS-TrafficTypeDiagnostic: SN6PR02MB4127:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB4127F056CFFA38DD08E6E9EEBAA29@SN6PR02MB4127.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0D/AkC3Vz8HJH3MC7+GjH1cHJ5v97vJ+Uo3AjQ4vMMNV7N8J3LyRARQBw/AoJiMV6DlIcI0rVy0gGyfsdTRGynFUX2a/LgH4b9KE7eLsdO46RVMvsd2icyUqmH+9SiMSbF/Cff6MW4eRMVcbNfEqx+Fn7rY/i3HPbTSIMTRhMACIg8on3S+EwehvUE/NCw3MSGb8WS3ir1uAKDIbr8+UO9wfew2ji+KtixiUA4/Ik2Avai/9X1ymvO6lt5WqfUyr/TIaK42nIwwo4/BVMoxoHiBmHpfw5CwYEWrgWoN/12GskaPox73KgncJdAb3l18jUahGQmDqqPflYp5mM3nkODWX9NBjE+Rr2faxx2XgPfisheP814EnPX7+GOqTQH7vmKBOuCCBItsThNxPQfJnpQ18/pcypQFqCdteyPaHqh8jVh3Wv4w8/DhHtWe3ezYDmpcpN7kLLyGOCcTjxdYL2HU//dk4kk4Vcgb7UQfoMpd7MxgQnx7+hoPQGu0O8bmvO6Gh7OSuS24MSrAHqmEdkjuOKPLoMXTy24NAhj6aULaCyV1DJgrXIqQqjk4TbSx+ofJabRNiDW9jty4U1BXEt4LCQEVQFJyKhg5soRGF83uj0UwJODbCz85K+bFCOk4oAuyR11E6HfUlEsJPedQSiJ5rVIzHgAcdel7m/TuzPYuNF5oNXoCF8zsviMt2slHLVBy8fcstGZL62QpQIO4ngA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(83380400001)(8676002)(40460700003)(70206006)(26005)(110136005)(54906003)(70586007)(9786002)(8936002)(356005)(5660300002)(7416002)(508600001)(7636003)(47076005)(426003)(336012)(4326008)(2906002)(2616005)(6666004)(82310400005)(316002)(107886003)(1076003)(7696005)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 11:26:20.5447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d63e8f-bab4-46ae-9f9b-08da47af6174
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4127
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC is the continuation to the discussion which happened on
'commit f89504300e94 ("spi: Stacked/parallel memories bindings")' for
adding dtbinding support  for stacked/parallel memories.

The purpose of this patch series is to demonstrate the changes in spi-nor,
spi core and ZynqMP GQSPI driver w.r.t to stacked/parallel memories
support.Please go through the series and share you comments.

To support stacked/parallel configuration following changes are done to spi
core and spi-nor.

- The chip select member (chip_select) of the spi_device structure is changed
to an array (chip_select[2]). This array is used to store the CS values coming
form the "reg" DT property.

- Added a new member (cs_index_mask) in the spi_device structure to hold the
index information of above chip_select array. SPI-NOR is not aware of the
chip_select values, For any incoming request SPI-NOR will decide the flash
index with the help of individual flash size and the configuration type
(single/stacked/parallel). SPI-NOR will pass on the flash index information
to the SPI core by setting the appropriate bit(s) of "cs_index_mask".
For example if nth bit of "cs_index_mask" is set then the driver would
assert chip_slect[n].

- The flash parameter member(*params) of the spi_nor structure is changed
to an array (*params[2]). The array is used to store the parameters of each
flash connected in stacked/parallel configuration.

This patch series targets flashes of same make connected in stacked
configuration and for parallel configuration both the flashes should be
identical.
---
BRANCH: mtd/next
---
Amit Kumar Mahapatra (2):
  spi: Add multiple CS support for a single SPI device
  mtd: spi-nor: Add support for stacked/parallel memories

 drivers/mtd/spi-nor/core.c     | 104 +++++++++++++++++++++++++++++----
 drivers/mtd/spi-nor/core.h     |   5 ++
 drivers/spi/spi-zynqmp-gqspi.c |  30 ++++++++--
 drivers/spi/spi.c              |  10 +++-
 include/linux/mtd/spi-nor.h    |   8 ++-
 include/linux/spi/spi.h        |  10 +++-
 6 files changed, 146 insertions(+), 21 deletions(-)

-- 
2.17.1

