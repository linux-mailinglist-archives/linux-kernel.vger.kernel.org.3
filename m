Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8B751EEF5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiEHQhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiEHQhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:37:22 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9655EBE1F
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE5qgQR5or6quXhjKL7ddPaRJ1CiQ3ZiqrjscsaxProvvl6u7K4dMgb1DtECtwMKOGfv1vRLdzta4XjoLtsw6gl46L0WBYyUfaTpNrBcRI3HcGzeIROuyC7JsLyCtF9wvHd9GLStCoxCnbKRSk4aZdTwCmMflbRX7dvuIwZZR5MW3G83Pf5n5a0nhQ30vSkon/epdnLzRnpUTZqf1N7t2NKh7wxVz9D0jAKDiUaH022KFRNfkRTilXJqotOFIDWuRi5Tjy2SiuT7jmEivhxXC5IJJLV2Ahc3R2MZ9PG4ZjwEz/5sQRMHG1ycju7gZC/o4ez400vmrBX5N9UqqRmX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxhVRjPdiVgR1OHKYnT+eRt6/lEe4n9fcPg6RI6njno=;
 b=lJY3vCOfvh6adGWcXMlh1SWwnOWSQanFs6WoYWKyWtlLZpoGqsdiCJ0jK/6INNyp7kPTepskBXMapahkHtmWTQ9kB8poOB0BhgzgHedQPwHZD68XhHExKQlIofAcQHaAhAl3HVJz3y8CK1CdwG2Urfvb8Rf93KtB58/xzwaa/7PhkeUSJosYT0YYgOKzx7uPdnqvNfB0bflIb1hAjYDza9Ms0rKxNqiJZ+PtULxPZpq3F/4NNJra8tgZ4mAA3idGA/4t3MKDjdarc85K++aL7R6k+yLZNqtJWaW/paRKT9ubrwkSfv2Ql4sM0pKjd19CA8vF38S+LO11/pm5DS+c2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxhVRjPdiVgR1OHKYnT+eRt6/lEe4n9fcPg6RI6njno=;
 b=Muu7eOMGuiMalF3oiyLG7bW0z/tkXp2JtKQW4n1a9vzjsGOqWJ5FnGOcFkZNpXnNhp7kCULEWQZrVN0XutqJ8uorklrUxqmOiJ8FAnH6iXEuEu7ixRvdQO07sJC60SURVbylHoGoFOW75wwiOVIpFDuFjaepuq6xCLKqfDlrfzdtjS2GjxlIvJ1Q7iqfT9E455vd1L54tEwyvHiKwE9DKULCg2I/IvRG082ZC4HS7esWNrgm2iKUOT3kC929l85jPdE41cWD9EBAjnCtlYDF+hZb81GxhRFkELLeFTphjRmZgmcEav4f+mgYrotipYS0GyEvIRCrJh8zAM97pbLYAQ==
Received: from BN0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:141::9)
 by CY4PR12MB1733.namprd12.prod.outlook.com (2603:10b6:903:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Sun, 8 May
 2022 16:33:28 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::50) by BN0PR07CA0019.outlook.office365.com
 (2603:10b6:408:141::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Sun, 8 May 2022 16:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Sun, 8 May 2022 16:33:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Sun, 8 May
 2022 16:33:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 8 May 2022
 09:33:27 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 8 May
 2022 09:33:25 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v4 0/3] Show statistics for a vdpa device
Date:   Sun, 8 May 2022 19:33:14 +0300
Message-ID: <20220508163317.204673-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8767fe08-bd49-446d-a276-08da31107b5d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1733:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB173343BCE98E5FD3A0781D42ABC79@CY4PR12MB1733.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7cDMd+0fc9OeaBobQqH1SLJHSqyorClsZEaMLaGjS+gQ6oJFSkLOoq1qhFNutZ13yl2KrcUaeZn/h7oVYH6zIj83yUy1Fn3UY9aqF2uWLepnko4/orBE2rWqUsujzeq/Cp06wZ836/gWkhG1Il1l4kIOesZWQ4Ua1UGInC9Ugat9anLkYTxYfZm5cAgLfmwNlz2KsbSPvDLpnhUxkngUv7Q0X7MHkgJCOPKv6H0WJOwbalmZ9wCHfAO5QyPPRR9XUfywNMzSA/BhXav910bpOCIYVFBCduKvP48CHA+A1yPsYtB/APwDvtaTIpfS7WzRAOy/CbwGXXZw4fQDdLZyiW7DVjgzfvNRtzJAnkBtzNp5LjN1qHfX6QskPJz0dwzHPFPTfomcSTDzqM0CXx5krxDDF8iiqtJoUO/n1lMk/M+6ZHVeKwgm8io17wupOrOnmO3l/r9dJjPssHq06Cp5h2WIJTmwsaDV0LF/8bxu89/6HF5KPve/K19MhSOgtRjsrQzFYnExEWkXJkCrOO41876q3HY85K3t95IaY9ZSFHe8QNJsyJE9rt4RD1ZQPn8XeDsUA6DI3bL1xdMR53ND9mYqwp7S0jhksdY0muAJUu3yTswUQKLOpYgg2WrctDQXJqGhYgHkU1K2MzzLtIGITTCvVNZQUDnHcfZhjW01RDNoikhcRKJ31eCVzg/M01cAmLDntrAJoWjoBDz8GICGQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(7696005)(356005)(336012)(36860700001)(426003)(47076005)(6666004)(2906002)(5660300002)(110136005)(316002)(36756003)(82310400005)(54906003)(83380400001)(508600001)(8676002)(8936002)(70586007)(4326008)(70206006)(40460700003)(107886003)(86362001)(26005)(1076003)(2616005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 16:33:28.3599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8767fe08-bd49-446d-a276-08da31107b5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1733
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Jason, I removed your ack from the mlx5 patch since I modified it a bit.
I am sending the userspace patch I was using following this series.

Eli Cohen (3):
  vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
  vdpa: Add support for querying vendor statistics
  vdpa/mlx5: Add support for reading descriptor statistics

v3 -> v4:
Add a small cleanup fix patch
Only return statistics if feature negotiation is complete. 

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 171 +++++++++++++++++++++++++++++
 drivers/vdpa/vdpa.c                | 143 +++++++++++++++++++++++-
 include/linux/mlx5/mlx5_ifc.h      |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++++
 include/linux/vdpa.h               |   5 +
 include/uapi/linux/vdpa.h          |   6 +
 7 files changed, 363 insertions(+), 4 deletions(-)

-- 
2.35.1

