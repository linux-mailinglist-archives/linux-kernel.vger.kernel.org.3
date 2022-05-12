Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762CF524764
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351166AbiELHvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351218AbiELHvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:51:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FEB26545
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm5lBZnt8VXCy6pN6oJA/5Ib3L53b41QWYK2uTqNw6mDaMm0NtkYDVTOG7OXo/7Nv7X2U1ORwrtF+Y6ni2McfegKoUokdZY4a75e/Z0Agpx3cOf/pM0VrmKePeew2JhEuZtpY5UJoMvyaOwt5stsx4oK6mc9NYFDyKXop7DJK4k1FRRURJzgMgGVgHoymkR5Sm6DOuBULpAcemKHzbbU9ndlKBvYJ+ukCoHZtHeaip2B3xiw995RiqBHm1NekgYcXB2+AFFYC7/EtpD8ZJ0UuJyNUxaP7+LhNi4rQg9Hjb14vlfTFhfJMB6pqGu8+U4+0ajAeudyV3/Bz51gJJyJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58c6IyPMDZczsswgHeNjfm+K2un8YjjbIu/313Rf3P4=;
 b=RFlBzAHATc65s+L2NXgsgjSmpCrM5mTNwi+hWfTHfBhgz/WATEqZey09gI5JZFp307hdilq7JD6187Ed5ZEvCqSeHE7drt1QwdrpUw9KAzcGpgxxtIfqr825Au+0pEDbOPu/8770FwP86gJqfex3chQu0rbAIKJ0MCvKixpHqGnDUFOFfYYSzAiRSfRqVxY42HWl7VMgmMMUd/DyW44lXsdof9asgycYu5xSlWQaqIIBbn0amiu8jnaWPPC9jPP3J9MWWldL9Dc27CMPnWvOlmbL75R1MYoARrGHykVjP26y35GgtXp2s4ovTubInmc8e+JnX2wNEjqS4quNH26mZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58c6IyPMDZczsswgHeNjfm+K2un8YjjbIu/313Rf3P4=;
 b=avJiyfL14J41JCihktEEo5SQWFQuBaQGnpQA/HWUvlWYWQ6lph+l9XpTkaLMn8P8qyJsSJ54l9C8Umsf8x8DCQ7IBGIjLkjLCcqavyUU1/VYmRMWGnKZUct6gAWIx8cp4w0Rrk9OgcBDJzWkdBL2YcS/5fRtGFgKWr07yzvBtxtFqgYpMMH3YsXowtBRYyh1Lpmslq8LYWTkGc49tlwPDuir0GdKKTQPVgSUjHT0SP8xOHpFwN+73OwFzGh4VdaqrhyxTlPIjhJdsqy6T4P/mXrOdaovmfZ++PhvLQssVyC/KdbvQAvnBlyij1YZrjsHPeOdIvnUexc6iNrQpPfCtA==
Received: from MW2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:907:1::21)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 07:51:06 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::82) by MW2PR16CA0044.outlook.office365.com
 (2603:10b6:907:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Thu, 12 May 2022 07:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 07:51:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 12 May 2022 07:51:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 00:51:04 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 12 May 2022 00:51:02 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v6 0/4] Show statistics for a vdpa device
Date:   Thu, 12 May 2022 10:50:56 +0300
Message-ID: <20220512075100.1715286-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4b6f867-54b4-435d-2f9d-08da33ec2b6d
X-MS-TrafficTypeDiagnostic: PH0PR12MB5433:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5433B8332FAD22894065054FABCB9@PH0PR12MB5433.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uC2vXOWj0oVUyXJlQ73ycPLcz5LcZx9ewL03QRPtqTWZV5YwF/6iLISGG5I57t0hlw1bFbGSfXUKqStwLT4NOHKSFBEg4J4CjMTcQ72qhJw2JAK60zxEUctpSujZxR0T1o4jV0ub2JHgWlpS1flNk2gCJOE4jcnpJcJ8xjQdZbuaxT7wpHb+ngOQ0rRYtxCLxrYtBPDIvQHFf3IhaJiFg+Qo2Ppo1BThfltal3WxSsMWY83L7O3jNhfhZSig+vkEiit7uTuK4R1JqnSS+T4xF1rAyOF17/b3MOZUMci2YjUebNJUaJmLy+yg4Ri+x5mRT6+2rD3cCuXnweeB7gL9sLm8SHQxURZLHSpV9GScfv61AcsGm2P5VrOH7jV4H3VLtapxFzFXezb3Vqkrwy7yJAXl6NYm5omtuTedntbBRudmQaoNIfbcg4eQDu0YT1puBvvTF6xGdnFjkYg0fus3zKAZUKeLP4iZs2VZkrQaboNI4ZEGgl78iort49vmJ0qMX2k0uz7wVpHjCmQpkq3l+Uo7X7Z5mq0g9FZZrzt1MEJ2+5MQwtSbkbddQBQdC32fdANe3WY7n5s9P/+BET+4FDdRnMWiBippWAOHZmBwZCZjgZzpB/2BEpLvWIPyeFIVriYaJck7UUEN69MB8p6hempELF9h4pWezfiFGBKZwhOg39AuAO61IG8082Xh64JeNQucIxNUUrSCpc+47/dvCQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(356005)(36756003)(2906002)(8936002)(81166007)(36860700001)(5660300002)(1076003)(47076005)(426003)(336012)(508600001)(83380400001)(70206006)(186003)(8676002)(70586007)(2616005)(107886003)(82310400005)(54906003)(316002)(110136005)(7696005)(6666004)(26005)(86362001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 07:51:05.9127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b6f867-54b4-435d-2f9d-08da33ec2b6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The makes changes to locking scheme to use readers/writers semaphore
instead if mutex.

The forth patch implements this for mlx5_vdpa which gives received
descriptors and completed descriptors information for all the
virtqueues. 

v5 -> v6:
1. Move negotiated features insertion from mlx5 into vdpa core.
2. Include the patch that changes the lock in this series.


Eli Cohen (4):
  vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
  vdpa: Add support for querying vendor statistics
  net/vdpa: Use readers/writers semaphore instead of mutex
  vdpa/mlx5: Add support for reading descriptor statistics

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 155 ++++++++++++++++++++
 drivers/vdpa/vdpa.c                | 222 ++++++++++++++++++++++++-----
 include/linux/mlx5/mlx5_ifc.h      |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++
 include/linux/vdpa.h               |   3 +
 include/uapi/linux/vdpa.h          |   6 +
 7 files changed, 396 insertions(+), 32 deletions(-)

-- 
2.35.1

