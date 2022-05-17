Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0C52A2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiEQNOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346316AbiEQNN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:13:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84C41321
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHNTeNJT9A9Cq8ljP52xIBw5DsqvoSd4kYn26sPXpB5ZJzdsRpnQ28Tc1qqZ9GnPQlOr/pYlJhMOKVuxrmQGoc5Rio6SxVC8O3ivbcDy3eCbmTmkZpdXHuen6HBOmPNjoDn3i7XBbhyGFW5UTF53Rh14Qwb7NU+7gD06AbhO3vmLRRSBIfc2ofCVE7bHfLD5B8dMtgiOtkKo1ptaiX4LnDuemO/8797AwFI7KTXdR/j6f6JJq8UCmwdQ/eCQZHSPdPBnQGdcLX92zOidVA1hRY+yIaIyqq9C7RaPRICcK5HaMccaFRGx46qWVu1hvifjl4KTp/+wtKObFnoX23V7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7WhuvXu0ruubo2BF/6Rj/5Yx+bz3nfa0pqzNGU2j9E=;
 b=kmbbNeK7KS1CLcxfbLEuzCegZGn+0uctWY0vEw/tXVJmItjudRPDPBk+AJ7f4Grdl0v8tlX1odwwn9SD/oX4x9pY2i/Zq54hOFOSo34OWGXkUmy3tEX+oYUvT6rf1gGziXHxGz+iOIcvxbhFAFAHElkYG4UEhRMBVifoygYBzUH917MNu+7b7dzpioaAZikZ9H3ztAZOSbo5Sew9YuluM7wwCe3zdfU4UgKGztt11gs9Fk0im5a6kPkLwDwxO0MBsO7ilCe/AW5hNQ5WwH+MJiQrfKzEJ5hn0KxSqtZzgMqYGtSm4UulCWTtcow3CjNGoqEMuEMvuxWkhk+lydHiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7WhuvXu0ruubo2BF/6Rj/5Yx+bz3nfa0pqzNGU2j9E=;
 b=OPvmABDstDPdFzmkUSr5CCWc6HwPJKxVp07wjOz3TlplWRUKVDXYl1iSBsiK1h1GcAzzKp91kof1BZeMvDSaxMlpf+L2KCb0JQp/gZQ6bkJHMX0fXzubfBVIfRvLjsGSg7+uze7hK9zUJocroUCIre+7GNO3/va/Xio33kp4CAtw2xggarTpmYRRnQ5E4m+zLN9hUk2rHcN0uKxYo/O8Cns8YYIsYs9RLIT5SG/h/zdsS9Rc8bqCKhc/dCgXPNS26V+VTuDGSIGhOIMiKtAugRtk4fPOFkT09NmUODpwp0EvdRTL5Q7nI69KGADwoBt6jmGN51d77ud4n5b5Sv3NrQ==
Received: from DM6PR08CA0047.namprd08.prod.outlook.com (2603:10b6:5:1e0::21)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 13:13:54 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::9a) by DM6PR08CA0047.outlook.office365.com
 (2603:10b6:5:1e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 13:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 13:13:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 17 May
 2022 13:13:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 17 May
 2022 06:13:52 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 17 May
 2022 06:13:50 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v7 0/5] Show statistics for a vdpa device
Date:   Tue, 17 May 2022 16:13:43 +0300
Message-ID: <20220517131348.498421-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11ed7521-07a8-47aa-9cea-08da380717ba
X-MS-TrafficTypeDiagnostic: DM6PR12MB4418:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4418AB1F426A22D04A38030CABCE9@DM6PR12MB4418.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HXndHuRpwAFZLBVh4lP4G5B4zHBljx953auVmiRc5eDDrSx7/PVEk0KKN/AnP/GcMf0Sd6WkXptR2cM9dg+SnyQfn2Kr7wqZ38MvWEHRHDGS8K+/61EX6gBeWo61D0F1tELq9eimrz32UA68ltXz3L9dWOjQW4IDxpwBvxNsmcA1U18bTBzgcUgtLLdQVs/J/HvNrZE29khSw7uhcD2e0FEPQQoir0WOj57aUIMEsIm+/MRCQfjuVYkgVpkftPyIb01eM+MlVU6FTL/WrvbjdEtBSk1Gy286mNAIJgM+3HCh5DJemnDiSApaXUjYJcNheQvb3FgOvxq+zMueVCHR6MBGUSmU2WUQ6PWhwhTMQ+dfSH5A5oq8C9uISv7tPR8xGJK6BMmftEiZJ1qEHCbbpajRl8/wBgwC7Fu34jhrrVB6EZnjM9Sb0IzZHqgOWVScx2aZwfeAQNUG6Fl2lYSAT+Zr2I3Z7CYNdvWFk6WhhfuaRJUPNOerFs/I+PHRAQJkQlJee1PxXeFun1AWN0Dge9HKXqhgimHbg74XxSBoiTuHtGkrR6TAvonESGyh5biVb9QhpVlA3u04BVAiK7+t3R7QzUW2QJ80OMcH3ts4eY/d/W1OaYjrlrZmLe3M1M0/2atqGlzako/QpmA542WCMLWPxbCyV0nQUQEWhK1IVIYQzoGzyF7l1LbykTVqJUFs8RdmU4uoATSDE/VJDI9sg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(7696005)(36756003)(1076003)(316002)(2616005)(107886003)(5660300002)(8936002)(86362001)(82310400005)(81166007)(356005)(186003)(110136005)(54906003)(83380400001)(70206006)(70586007)(8676002)(4326008)(26005)(47076005)(508600001)(426003)(336012)(36860700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 13:13:53.9128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ed7521-07a8-47aa-9cea-08da380717ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following four patch series adds support to read vendor statistics
for a vdpa device.

The first patch is just a cleanup fix.
The second patch lays the ground to allow an upstream driver to provide
statistics in the form of an attribute name/attribute value pairs.

The third patch makes changes to locking scheme to use readers/writers
semaphore instead if mutex.

The fourth patch implements this for mlx5_vdpa which gives received
descriptors and completed descriptors information for all the
virtqueues.

The fifth patch changes reslock mutex to readers/writers semaphore to
achieve the same goal as done in vdpa core.

Eli Cohen (5):
  vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
  vdpa: Add support for querying vendor statistics
  net/vdpa: Use readers/writers semaphore instead of mutex
  vdpa/mlx5: Add support for reading descriptor statistics
  vdpa/mlx5: Use readers/writers semaphore instead of mutex

v6 -> v7:
1. Add a new mlx5 patch to modify reslock from a mutex to rw_semaphore
2. Clean old comments
3. Move VDPA_ATTR_DEV_NET_CFG_MAX_VQP attribute insertion from mlx5 to
   vdpa core.

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 186 ++++++++++++++++++++---
 drivers/vdpa/vdpa.c                | 229 +++++++++++++++++++++++++----
 include/linux/mlx5/mlx5_ifc.h      |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++
 include/linux/vdpa.h               |   3 +
 include/uapi/linux/vdpa.h          |   6 +
 7 files changed, 414 insertions(+), 52 deletions(-)

-- 
2.35.1

