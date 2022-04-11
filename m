Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2544FBC05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346027AbiDKM34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbiDKM3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:29:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3F286EE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:27:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktxsGS43oErAocmecpULTwkxHqvlXpI+fTMhF8EmZ1ZIm2ou7l5knpSGkAYCS70S6U1nf4KXK29XM6aoXqWday+7b6k7mfEP6zGr6PSJNoncECxkvk4LQ1JJqon4LXSEmRoofDy3hbzVH3u4+pPHSzP7iMzefYPXoQXudhS+wZl1BtuF/nz3DABMINLRf9b4HHs+q/nW+b1ytSVY3lRMxdkkh0dmFx7BQwauDAcy9ZNW3t5wOh/tRk5KW3JqB9HwH63Pdib8SXsLSBtiiVFe9fGDEJWoc5Oq3V6TnUHXGC7XWI9YTvadeIFfRZsXsKoVqs/Fth0Zh69/8TcSApvAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFz/k8UR5BPc2LCqeuQXVR7q+ecmyaE+OB+MDMhb5II=;
 b=SP4fYF649jSJaOE8YTlo1sxgA8DX3SwI9bYqlcSrieOJbuJRuk6xXWnfY3S1PtD45Wwwli1lkS59tG8k1x0w4d1ENzC0WFZVNisrBoyb7OJFirvjO9kuYoqIFPJAc7arxamE4SYzy/BWgrNwbUwxRNl8lVXNBa8uidEPyg3mLcHzu5soDiKgJPUxlEjB9HgVpSphT04iFggmIghcn/6jFZcu7SFKX2LV8qf/U4NTb6D32n0NU2h+34cKP7m5fXvJFfsFBSUmvnAbEtFL5YkTn2agxyVYb7iPhQyZsjVqLByKA5a4VSI5lfzgitDWDqBJEzYmEk/IXSGZi7QlsUZAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFz/k8UR5BPc2LCqeuQXVR7q+ecmyaE+OB+MDMhb5II=;
 b=Bn6E+TSjN5/eNYxWHoWFFbm9ENV0hGVkB6q5oZi7LKGQvvL4ItcF4R/UduLoGHbgXjbfX3+A1D1C27JYB+4rp56XDovfAt8Z8lmwqTDwEzmCKfqT/BiQfcLZvltwNSvbl2ZXSHZLReiLNtRljBYnbYqlBU7hnKsCXGBvsnzC/tKi8d2i2+kmrwtQpRjm0Uip23ST5OFNNJ3X6Vsum7BnQP9A+jvC3MCwuHVo4inFsIC2tLTjp2LKeXf7EXHbQTrgXtWNi1P+mj80o23NXvu+Dly+oaY+dXVuHCl7t+BvDsv8J8xGzYvqS2dTceB8Y+oy5GbNdlP9XjFbhYdqb4IIYQ==
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:27:38 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::58) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 12:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 12:27:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Mon, 11 Apr 2022 12:27:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 05:27:36 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 11 Apr 2022 05:27:34 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <asowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH 0/3] mlx5_vdpa: Support MAC/VLAN haw offloading
Date:   Mon, 11 Apr 2022 15:27:25 +0300
Message-ID: <20220411122728.225588-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdcd71f6-7d11-4f09-e5b4-08da1bb6a9e3
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3604C4EAD226301808F2FA73ABEA9@BN8PR12MB3604.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfnYPFqIkCgAMaC2tmWU9yS0rgaQRPgQwkuOYDLzY0U9j4DqILsDmO8ebzfuW6iX1WZnA6r5ylAH1zzpXs27ZCNh6aEpn1n9/D+VBky2rk9AYqAlxmi8PTqhdgbfiKwOv2fFi17mai3n0iDNF/EWD8lGlOZ8552a4R/LEHApHJeJfvz6OGYUUkcGTWupl9uMQ4RRh/vk2wX9j9g++TdETGo0QQTmVAL1/qkAjCMnmL0iv9+exwrRR2qlSUAtVinLagcdf3OJEUbFk7vEKie89Rgtl59SKN9LPTBxOy43fR1KG0e1aOxvE9GaLH75t22lIZl2f8KZVS0/ANGeZWVTDI9Lux8deLya+QLAk884oUP02a91oSc9rcinPqC1d1Xol6qCCQA5yhE39fLldtnB4aplJaBbC6ZFnWTUYyILBikQC+qHYl98CBrGhnjS4yYAkFdncai1L43APMnZ61SPTgOYyIUJue8TZITWCS0CqNytKH0vWv5bphkULiIxzp6UWwwFlOaD5YmBwJQB5sv2+zqe72u38ju4arAtyNHFe6Klt0Rt5MyXjtkLKG2ZWrovb9C/QQuGCLNUJsonzB4uBBB+VetW+2uDCe0yuprCWSEb9Pnxiw6tbMZ0ltqvKwGd0BvYRBh8aRB1tLaprky3Lfp/PU9nn2audkqtf2bvaiRlddN9wZYrA7sbTwaO6W+s+lqLSUhSe87tNAnT+E1t6A==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(81166007)(83380400001)(82310400005)(36756003)(2906002)(2616005)(110136005)(4744005)(8936002)(508600001)(86362001)(356005)(426003)(36860700001)(336012)(7696005)(47076005)(107886003)(1076003)(186003)(26005)(40460700003)(4326008)(70206006)(5660300002)(8676002)(316002)(70586007)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:27:37.3535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcd71f6-7d11-4f09-e5b4-08da1bb6a9e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3604
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches introduce MAC/VLAN filter suport for mlx5 vdpa.
First patch remove code that uses hardware counters which are not
necessary anymore.
Second patch add missing struct to carry VLAN IDs.
The third patch is the actual vlan MAC/VLAN filtering implementation. 

Eli Cohen (3):
  vdpa/mlx5: Remove flow counter from steering
  virtio_net: Add control VQ struct to carry vlan id
  vdpa/mlx5: Add RX MAC VLAN filter support

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 292 ++++++++++++++++++++++--------
 include/uapi/linux/virtio_net.h   |   3 +
 2 files changed, 222 insertions(+), 73 deletions(-)

-- 
2.35.1

