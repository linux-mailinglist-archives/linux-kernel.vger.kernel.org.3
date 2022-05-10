Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B154C5213B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbiEJLbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbiEJLbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:31:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D101FD855
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6sl48UCI7TZAuN0BGXl56U+csDhZ8mq/xaLDNeNImDMHEexAMQQPnNU7mtL1t/fjFbjVEf7o1+xbNq9hPXwXO2G65iOQUO77Nul1ytTNp0XULzh5BCcl+CrgO0ykIlu/icXmTekzN64Z5x+o1eByLF2BBJDVXtQF8S8QS05jsekn9suBRPmzltEUoMz8hSnllkgaahazEW8furzZUI3z/xJWtjV1X+WGBFomRtsC6UCQh/pPnZM0xCcDkyZAXBTNgtztEmuPM2FZ3hBgMB7eSxVREBDhKg0dGWbm7reaPfnF9hqMcSmagVyawXOuB2Eqju07egPNBuFBSdHc1AiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f+thycOdtLRaoIvtgfmxIi45ikBBTCspVZvmDMcM4k=;
 b=XHgGSBl/mRSGVwgoqea5ZDELECmOxzW2lZ5YzGmKyMo+1tBpiylQqNoBuiVuWD6dqzuJdY5kPZhgZNYUgPd9VvermATEk5M6yJodfKmWmtjz5xVK1C5jYdbS66XyDpz619WfZ+Yqkf2mlDMIu5e64b/RVKYkGSDgDaCK25nftZ1w9vW7zKgXRTYKi5+/WkRM03DrEGWfHil0w45Ogs6RhZ2EtM/1e1my3ZBMGocbQo/t0QLFUM7H+i/baCfvGYvbV4o8aJidCK6urOxwBQvYDdhmx+bszyRru4NPOnYnNtJRnp/44mrFIM0Aft3wvo9oovt46Dnfr1lf6Uvpe6hiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f+thycOdtLRaoIvtgfmxIi45ikBBTCspVZvmDMcM4k=;
 b=TIgfj3HlSDjZK7Gnjzban2jHcjbrzXDnpqnBohgNzdPgRd/DcAP+/F6cjySak4Zb1d4uMtvxSDHZztzymD+tJMHK4CIrOl3hW5cjkP8jYrQp16A/X4mZcpq24/ndOOUprclrP6samsyWp8iQgKXrDCZSq/FGxluVMz4cK1ipGrHvDlSU63Y62bl/oEcyt9zOMZoJrT30E2puQf6aK+Y8V+WzVYxLkPjNrpKiBYIzAVqHSQSPR7frq1rsozwfuKOZrw//4XDYYavqOEkaNnlHpbPxBrP73G0rV0th4lCZDJAFVz0K4RGS36ejgxj33GkcCDt7Gh91Yl0c+laHo8Yntw==
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 11:27:41 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::45) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Tue, 10 May 2022 11:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 11:27:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 10 May
 2022 11:27:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 04:27:39 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 10 May
 2022 04:27:37 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v5 0/3] Show statistics for a vdpa device
Date:   Tue, 10 May 2022 14:27:31 +0300
Message-ID: <20220510112734.205669-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efdd4b0f-78c7-4ec9-de9a-08da327817db
X-MS-TrafficTypeDiagnostic: MN2PR12MB4222:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4222025ECD6E907C363DBE4AABC99@MN2PR12MB4222.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRPotF1jDhV523d2lipI0OL1BMLrQY1+w2ktD1fWCg3BsLW9NdxiSa4YBVRqf2gJIUiQtcUIql1+HbqYI/0uudEcWZca51SXOJdlv3UmVjC0HW0sPWyobO8OR8j8rtabR3MxKK6IdRY6W6fkqF8JOHvHI6FlH5PgOsqkKHtDcQwjBloN3gudKKuZnayRciLUIAt9iuJIeysQHsobePw7rof1xujkciaqy4MZoAYTFPxC8pL53gkHIdTeZcw6elKYQCKhaJQ1WHzPlgS202Wb0sYPCLnoUcCJZtKWog38g+XjFqdamlOwcn3GS7n150PFQqsWFWx6MzuEq0k9/vo/8tGKTx8T9rPgaH5IsUBhocJXD7LJ/EQTsJagwdQtP7kJ+BGHR3xUql0E327LkCwM+5yrTtu3QOqsNw4kXGGXHErmybgVTVoo2hA5nHGHcEFzh8uzC2iTOqoSiU0xdTRkRTIaXCCHrScOJdNTQQmADqNplKm0Ku+EP/mFVIZW0fe6+ZLFhrmrVyZ/ZhTF6nVlUxNwhDj1VfP94OKDF65835fvEYwDO8dlHgPdLkfSD5vPmbw+PHwS+PJBm0YijZjdO/xaJA1dvu1xMducVd/9HFik9UqknmPVDnSJn+MqTI+hZavlb0qUSlwxPjumJ4g+4igr8hjAMHZeLAjBhCYijQhgeJ6oL3I3sdYlivunWneKMIloYIck46i6KiJaoG9j3w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(356005)(82310400005)(86362001)(26005)(5660300002)(36756003)(83380400001)(8936002)(1076003)(107886003)(47076005)(316002)(70206006)(4744005)(110136005)(6666004)(70586007)(508600001)(426003)(4326008)(54906003)(8676002)(336012)(81166007)(7696005)(40460700003)(2906002)(186003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 11:27:40.2846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efdd4b0f-78c7-4ec9-de9a-08da327817db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following three patch series adds support to read vendor statistics
for a vdpa device.

The first patch is just a cleanup fix.
The second patch lays the ground to allow an upstream driver to provide
statistics in the form of an attribute name/attribute value pairs.

The third patch implements this for mlx5_vdpa which gives received
descriptors and completed descriptors information for all the
virtqueues. 

v4 -> v5:
See inside the individual patches

Eli Cohen (3):
  vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
  vdpa: Add support for querying vendor statistics
  vdpa/mlx5: Add support for reading descriptor statistics

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 165 +++++++++++++++++++++++++++++
 drivers/vdpa/vdpa.c                | 153 +++++++++++++++++++++++++-
 include/linux/mlx5/mlx5_ifc.h      |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++++
 include/linux/vdpa.h               |   3 +
 include/uapi/linux/vdpa.h          |   6 ++
 7 files changed, 365 insertions(+), 4 deletions(-)

-- 
2.35.1

