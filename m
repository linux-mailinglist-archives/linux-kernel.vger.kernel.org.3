Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE74551B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345029AbiFTN0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344848AbiFTNXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:23:31 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104822BE9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EreK2F+UKN/Dc4bTzGhddvhzNB83NC1Rju6VH83hdUPJDnLDXI6abv4+nBBPcHLVbRzrT28uwVQZJ8YqCPaY9o3UMTBh/pIY6rtbJ/tN7q90jp1Q/jjRURpddHjOrdoXb1f/2woFmAtvcqoJEI7ULHBvZtE1P1Vjn2eNQJuDrwB0nrzq3h9PewSTYHK1RGLU+dgRyl+QhdBRCBfMpGEqEcg7vWVij46GYQm0G6nVOLxoXuYHU3uS6fRZwyAwC2rX1MWeWgeDLG7P9vwyTqYCcSP2Lon+l6K6anR4F6QGtc5D6jTQGuLVW34UcuncWk1MNQJgjGYzds6ZbQR0nM8sjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK7juQf3hXsGYDXi0CHHLdn2Oh1S9pIs9jawGZaqmig=;
 b=VluXs8aSuZpFxUE8/h3VeC+Y2Dna7S0L0TcRZ+zX/a0BdL8O3BMuLUvUYgKq1HIXkDjae9g/tphSELb7QkDeScJZcYx7U3VaMy82vPJeFIYEM4kzV/HyQF97CzB21uHwzsPDSedYE3/83roZ/V1t8xY4wRL5QtT0YvPma4ywlWjrN7ornfk2dcAp5fKcdr5wkJ6Y2be5ZG0qPh52mdleJAmkUzXWVTfA7XSBUFT2zlptfik1A4vXTqFIwDsiE9vFk+5paiCyS/PKKrfSgf0ELgwUKeTv6jQeM5CS/B+ODQURAloeRCjj8h8hbdpqrATz19cMBIqjuJ4YwZG5SkQVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK7juQf3hXsGYDXi0CHHLdn2Oh1S9pIs9jawGZaqmig=;
 b=ktk7BKnCwvghpNllSz92zYSPX85EPJReM4/HHqGr//+Bd9w40cgBKohA2fKo47l9/zl43UXE80z1sb2cch1BJWHw26VLqZHzQfM8UOBg7oCbIHmpMxHmRbw4tMT7y/SfWZqWTewJDXZWsogJQqXFYE2+T/qWRfcJ5aq30BRH/OvWEo7i+BSr4vvM8zcLySRauXo8+nmdDhWMDapbPu+i9mG0DWelFWdejX52oHS83FzUQ8yNM9JRiaFykkQWFuh2EfxL5xSv+2D5jzmTzJhmjGHKYVPlUp2HwyE0fj7Ae4AY1rhDjxDKLUKQI/Qn0wyfj6PyzD3qJoLLOCFAB2Pajg==
Received: from BN8PR12CA0035.namprd12.prod.outlook.com (2603:10b6:408:60::48)
 by BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Mon, 20 Jun
 2022 13:06:21 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::58) by BN8PR12CA0035.outlook.office365.com
 (2603:10b6:408:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20 via Frontend
 Transport; Mon, 20 Jun 2022 13:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 13:06:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 20 Jun
 2022 13:06:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 06:06:19 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 20 Jun
 2022 06:06:17 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <eperezma@redhat.com>, <jasowang@redhat.com>, <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH RFC v1 0/3] Support live migration with mlx5_vdpa
Date:   Mon, 20 Jun 2022 16:06:11 +0300
Message-ID: <20220620130614.19679-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b30f2382-b9b4-4cbc-b569-08da52bdabc4
X-MS-TrafficTypeDiagnostic: BYAPR12MB2840:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB284040A130EC4137BF5ED99FABB09@BYAPR12MB2840.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBjw+BT9g++WFM8TrzjY5trtxDxVrvT8h7SpkLWs5xTYl6WD3BD9FRE+qxlzo8sOPzDRoaOEr3Ed/pttnKXDdQJFgnBwsknP+AazurbtHJB25frP+grseVaT9Hq07nJGWzCfsbRsBzy8KIvVkaSmwFBbas7NWIFSUdBbX7JI0lJCdEwf4WEH9xw3+CX0tvwEiZJPurXt7DeGrlHOxdQ/MA3RaDlKTbDWffHBvC8hj70DplFSlETWTbtFjqPaAq3Ja2rLgMKdgACXBHTpP9d9ztyyU1bor51F0WBfMCAusMnBZgdikCdCH4oZzATfjmjHXEebbOZIKEcCsGFM06G2zhc+T+GjuZCwn6uzuR+oV9p5d7d4wxjZ0YJqArzhyDLW2YJlPQ8a+NV+kenO3WNkuR0/9lhvbvV5HEprZTMYnJtrDDs7dAuF3bR9VuCJnevlLtUYn2m3Ipl1E79Ttr22eNPo6sjbsBdVbYSYksvItLfdgj2gVCoCQzie+XnH+NydQziym84BRNT2PE19I5xEse0uyeSSDBG7JOFJhgOeoPALTbuj8u9y0UauawGdKqGo1v/Ho87iejnelxpX/RJz66bUwnvJzJiddrq0LgTz7dCtDaBnxrCMj8MWlKXFkzmFeoq7xZQPeihOu0gBb0uVvEYCWrAL4E58HwHAw8pAlGGWBjjhodNnqPeRrgsFj8pRu844s15+aU2SFKPPbRRNYn7HnM19wNsBq/eGqQGGmeAImWwh8kFd0RqVxTsavuZulyFEWw9XIqKpRIs/iGxlriJmzFoezts3eclPn4AQnu3YP/xH/71y+bY+d06p9xCI5ZgpO/FoMfaKnpK3k8A1vQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(107886003)(1076003)(47076005)(186003)(426003)(336012)(6666004)(81166007)(7696005)(2616005)(26005)(36860700001)(83380400001)(356005)(8936002)(5660300002)(8676002)(4326008)(86362001)(82310400005)(36756003)(2906002)(110136005)(54906003)(316002)(966005)(498600001)(40460700003)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 13:06:20.8094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b30f2382-b9b4-4cbc-b569-08da52bdabc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am sending this patch set with adressing some of the comments.

Please note that I will be on vacation for the next three weeks so any
comments will be addressed after I return.

Eugenio and myself were able to actually see live migation working over
mlx5_vdpa so that's a good sign too :-)

Following patchset supports the suspend callback to suspend VQs to allow
sshdow VQs to kick in. It also adds address space support also required
for live migration. We use two groups, one for the control virtqueue and
one for the data virtqueues.

Finally there is a patch that disables VLAN support since it is not
supported currently.

The aim of this patchset is to enable development/testing of live
migration over a real hardware device.

The below two patches are also required to be applied but I did not
include them in the series since they were sent separately.

https://lore.kernel.org/all/20220613075958.511064-1-elic@nvidia.com/T/
https://lore.kernel.org/all/20220613075958.511064-2-elic@nvidia.com/T/

v0 -> v1:
1. Fix a few typos
2. handle memory map updates for all groups with a given asid.

Eli Cohen (3):
  vdpa/mlx5: Implement susupend virtqueue callback
  vdpa/mlx5: Support different address spaces for control and data
  vdpa/mlx5: Disable VLAN support to support live migration

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  11 ++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 157 ++++++++++++++++++++++++++---
 include/linux/mlx5/mlx5_ifc_vdpa.h |   8 ++
 3 files changed, 163 insertions(+), 13 deletions(-)

-- 
2.35.1

