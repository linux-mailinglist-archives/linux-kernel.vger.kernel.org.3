Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8771516E10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384522AbiEBKZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384481AbiEBKZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:25:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829A8DEA3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1DgQK94Djm0Op6Bf2Sptl6kKCG+6P9JxNGT1hqQ0EcupkRIqCF74fQP/Bqge7nG3KatHezk366hmFxCNgyZUYygXOYlUv06yj8fh0muU+nW8MG9VmiIsr4aXDSa2iqQQdCeutYqx8atRbZqHDZnmCwLBR3sPXxsh3pmyZlObAvrJKwRocINHXPVDC++H35IibVm94a9RTJhFgOPOc7hyB8qNdHoLOMnyMtEGeYwWKumXpV7/He1N9rnTfWbYFqkw1awNhjl3BHwPBYHvm3t1Fp2k/eTTHM6IW5Q7hIC8dNx1MsQ88YbooYi6+jq6sAsIJMpZux8Gk81gXW41e1kAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf/qtWi6xlUo35mT4RbIFldCt1THqBwoZNCAi4nEwUw=;
 b=lFNRqkbg3anraqdw870QU1j9kkA6jHx2LYZCEZN1K/nqoh0PA4Pun3GLh8hxOruSzvJfs2azXBEAPmv69ecxCA2ML5VBKN10tXgDLANB7s+S6eVgQZgQhbCnwS9QIq5LklqjO1bNleUyA0hLm/+2AoVkimEw4ChX/9Aj11OJx4KTxVsowvsq8aPrN4jkzRwqMI4qKPgHvIDGVUWCL50RJwwhQDAGD+m+4XNji6S6oi0S8S5Fc/fwqTc2H84INsc+gVJbyQ802/aJchVHd2SEwqlabDUzvmfcblzKjjkY42d4FrBiG0vy1pu7zgCibUctxFyofi2PfqoULPvCqbs3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf/qtWi6xlUo35mT4RbIFldCt1THqBwoZNCAi4nEwUw=;
 b=hMEFvxkfDbApyNg7+IBcsY+5v/gAwyz++bFEGlOzTWvl7XeQp7ka+RzEMREiVw7Z4eFnmXUBHhsoXTyC1vVI66i/HZDarETE6ND5WRgnEYbPCa7Z8PBjqmTBJg8dbyyc2dnL5tMUWCK9I/ynGDIUz0g78n9z9CvG4Sb8lGP0VbDmHWAK8HoZdR62JoQE9OoawNg1p7uU7fu5/VT2VM08nqfcBxNMvg3WPJOpcyFdZeBITtk3vDHihYmHka561meLiwmLo+VWqQ2zEwxkOhk7tCXGWRGiI78Gdd1UQ3J5uTcKda57vkvTU1SWg+NmwyCFgqDeqzx9GeWly9DvwD0nPw==
Received: from BN9PR03CA0644.namprd03.prod.outlook.com (2603:10b6:408:13b::19)
 by DM5PR12MB2549.namprd12.prod.outlook.com (2603:10b6:4:bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 2 May
 2022 10:22:12 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::b7) by BN9PR03CA0644.outlook.office365.com
 (2603:10b6:408:13b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Mon, 2 May 2022 10:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 10:22:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 2 May
 2022 10:22:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 2 May 2022
 03:22:08 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 2 May
 2022 03:22:06 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 0/2] Show statistics for a vdpa device
Date:   Mon, 2 May 2022 13:21:59 +0300
Message-ID: <20220502102201.190357-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d85965d-b4d3-42fa-4483-08da2c259f10
X-MS-TrafficTypeDiagnostic: DM5PR12MB2549:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25495EFAD2B85AE5A9FC3352ABC19@DM5PR12MB2549.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ruf+XX7XcxghDXuRw8oKxkf3C0PPCskhnJCHPyzbnpOYJXfM2B7+vqVMfuQydPofu4nwgsBAspBqh5mCdq1sz1KyV4xgrlahPPdAonErJXmaWRMPOqfyFD3ZuEPXx4c6qo8i3bjyfQ6rLxN6+L2r7HrLjoHmBVg2zlQ0cI0jpiYYexEh6bkd0vP6x2vBUVgZ/Ifr3PSzW82q7tIgfwXgtV1FK/JtWdibSnHxp52BETjhs2JXK+Twaf7sh3/oCNHtRbh//VuAxXqpOvGvPlW3HxPWfK0+1RdDW0eFr5DtiHiqh+GHMtOxaqhoGlsEc+6lRfoH0CQrdG39gTv5wVfJYRn5OltXY3WZxjlS+v/jf3iUm3O8yOQmCEGKBpHYBHYsy3mdmpSKpDjAWdESNfpEoq8Y3pGbEgyq+OD1OD9G8b2Yd2hW1EChCsNoQF0RuNVGufRIPGQJFlmH04/UCpGIqBItJvFkN1ZhjQ1cll9PMUjirT90mlBijvVYy1pMzj3gaeyi02YEucxQdZfq+culgBFMVclkSFdoEDOf6Iotz7He6H7UDWK6nrflXvF3IdWxLa/Rej7YEe7OOy8ppqU2mzhAB1MOUdgwYcnqWamONh6AoCz8cou2SvOdgnczLZUKEHh0dcy1Icsqkh7uB+CMuiSWr/XYZqAFRHKd6Frs5v3p6qakvXSXIPkRgem3q1j8G+1+2NUQzq2StI0mZuc62w==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(508600001)(26005)(110136005)(40460700003)(54906003)(7696005)(6666004)(81166007)(426003)(86362001)(47076005)(336012)(82310400005)(186003)(1076003)(2616005)(83380400001)(107886003)(8936002)(36860700001)(4744005)(36756003)(2906002)(8676002)(70206006)(4326008)(316002)(5660300002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 10:22:11.8527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d85965d-b4d3-42fa-4483-08da2c259f10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2549
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two patch series adds support to read vendor statistics
for a vdpa device.

The first patch lays the ground to allow an upstream driver to provide
statistics in the form of an attribute name/attribute value pairs.

The second patch implements this for mlx5_vdpa which gives received
descriptors and completed descriptors information for all the
virtqueues. 

v2 -> v3:
Fix sparse warning in patch 0002

Eli Cohen (2):
  vdpa: Add support for querying vendor statistics
  vdpa/mlx5: Add support for reading descriptor statistics

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   2 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 165 +++++++++++++++++++++++++++++
 drivers/vdpa/vdpa.c                | 129 ++++++++++++++++++++++
 include/linux/mlx5/mlx5_ifc.h      |   1 +
 include/linux/mlx5/mlx5_ifc_vdpa.h |  39 +++++++
 include/linux/vdpa.h               |   5 +
 include/uapi/linux/vdpa.h          |   6 ++
 7 files changed, 347 insertions(+)

-- 
2.35.1

