Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D344FBC12
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbiDKMcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346070AbiDKMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:32:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7683EAB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO0XuwTWt476WYLQAQ7TPcznt9BSamFdNAwrFiV+YrCbGCCawjceKmqEDeAJxkyfLyyVmWr1+WsRYkyrVMSeCsKCz+is9EMYmlqsBaj/wp5RrZGjPR/o6tpegsIHbm3XoaNNP7N/86BVlUVALrCzxOhL39ymq28tfw2AIqDhUeXESjConj0N/3pxJnLzVM1/tTWVNyH58Tm9NUaFoLl3N0+5yeyn4gwcDbog5/EW6YFydG6pwSWypd9VQBpehWwJ41nL8VG78MGHyn3ZQYzKJeR5Bot5Eu0oGRYPCtcCtHS8iAzoaKNhWgamTUJQOXP36FO5sPYLA5VY9sPMAKHHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTdod2GpetLgxohnbuxVF/lhpkd4I2cM/aNwJxy1wuE=;
 b=dFavlq+vTm+j7H98QFcn2yJvNV64/btrLGLvTSPmpoBpNi3CzoiI/6CgRALk++CTaV8T027rDd8Zv3prYe7bDLmx106sY7S8D4k7+65L5oUne6kJcm2BSDwYqc6d4IiLDmXN5tFMV1aLXWQ4Hcu9WZzoiCGIs4pBiyFXZxUdBsxfVvkmh2/QEcQYRE45oQJxu47C4BXUsuw0y9qXMUhziHa3o7w5VYjf7geFBfNTCMJtYvWP99haLppqlui2YBuE7x3W/7a32QbGlqF2y6ZVmiyk7QlBvrRf4rZ/HoSMD2hy31xSR9Lm9+Wx5Zo0kQ1K78ObOa2Zojf4zLHvqAtJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTdod2GpetLgxohnbuxVF/lhpkd4I2cM/aNwJxy1wuE=;
 b=Yri8hWmsBtubkOFzj+GTBH1w0pu0R8jD55q4zLrSnvgDyNkWVMLFm2CN6hlERfOlj3kIaqOGNi0oEIj14mftBZKtE+pnZHT79k1AGnp/Hi/vTA97+ZjHYkkv9p1PknaUljCUNVDxMZCEr3G21naYEBeCo1Qv8nh0z+Kt5C/mYjYJfF1TDyzW1Fbj+6fTHi9dLuksPk/VwKWncxfXovWPfZxaZjrYFkzv8RAMUE/pzWpVCvGDE2IZbAdCW1UcaPOlC71d6OdPOmviuB55S1EDcHYBjphoaSCivevns/Q8A6WlKXeKn5lL+KTOi508kDwSA6xdZcoZVDnPVV4LX6GK7A==
Received: from MW4PR04CA0039.namprd04.prod.outlook.com (2603:10b6:303:6a::14)
 by DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:29:52 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::74) by MW4PR04CA0039.outlook.office365.com
 (2603:10b6:303:6a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 12:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 12:29:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 11 Apr
 2022 12:29:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 05:29:50 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 11 Apr
 2022 05:29:49 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH 2/3] virtio_net: Add control VQ struct to carry vlan id
Date:   Mon, 11 Apr 2022 15:29:41 +0300
Message-ID: <20220411122942.225717-3-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411122942.225717-1-elic@nvidia.com>
References: <20220411122942.225717-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37954b20-e8f5-4d33-53d7-08da1bb6fa00
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30836C69146CDE59390D1173ABEA9@DM6PR12MB3083.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQZD7BaW1R34XXNV8+1rfKtUMzyikmcPXMF2JC5LKs0nylGlgVGrqwOT+R8AKwTchc6Xxkbb0q5l6n9lEFHi3M/+CVIvvIWdyoW4/0kEAY16ZsOQUkLc5niGYiqVGePyXQuC4GoJY5udQdT1DhZPc0ezv2XouGSSFcYBal1WRy65PGMJaJ7e6YHNiKFTVSUsJpNETZLY0EBNgMW77HohmFYj0TKgtxyxmHEBcpBMH2ZSMUzSrgxujTkl5lXZK4vBiC+73dZ8BwH9GQ1OmZrmCuOas2Xvxm0k7wBWN0tCgSM7XgVVBPP02wlUEij0BnCW1dYGswtPjKOuA8XbkdCoeOwemBSgnxNt1j78up8Zm00uk4tnUuSilvhfGlcyDHTR97YDkStq/A5Fg5w7xVJEI3nkggKMoZReG4zTdn8QDUgyIf8q+gBKn5QyjEcEC9OnH0IkYA01ZC3b4wr0uloKbjWmAHzc9PnX0B6QROqktiiJIBCdZPD96AzAKhdrUl2BzyLOHTaGrcJg2Jq177IMbqo08Dpk7DWtX7X7CSHj8Znual/WGRgJYrbdyFkH77AH3J9XnjoxHf+4LaCIz8EAzMfgBJwIaFn36Z1i5hHLFzVF9yNyRkXUiWkpul+gkK9Kw+7y99aSsJsPajtyJvZdVE9j9An/+lMw4ysSRByk/xoZDtXO/rBd0h+PLAjBgg0xJjahAmowaJJHU0+ncpHL/A==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(426003)(47076005)(8676002)(82310400005)(4326008)(2616005)(336012)(36756003)(8936002)(36860700001)(186003)(83380400001)(70206006)(70586007)(6666004)(26005)(4744005)(107886003)(1076003)(5660300002)(356005)(81166007)(54906003)(2906002)(7696005)(110136005)(40460700003)(86362001)(508600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:29:51.7419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37954b20-e8f5-4d33-53d7-08da1bb6fa00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add structure to define the payload of control VQ messages carrying the
configured vlan ID. It will be used in subsequent patches of this
series.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 include/uapi/linux/virtio_net.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 3f55a4215f11..b94a405fa8d2 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -270,6 +270,9 @@ struct virtio_net_ctrl_mac {
 #define VIRTIO_NET_CTRL_VLAN       2
  #define VIRTIO_NET_CTRL_VLAN_ADD             0
  #define VIRTIO_NET_CTRL_VLAN_DEL             1
+struct virtio_net_ctrl_vlan {
+	__virtio16 id;
+};
 
 /*
  * Control link announce acknowledgement
-- 
2.35.1

