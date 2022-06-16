Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED254E1F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377087AbiFPN2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377025AbiFPN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:27:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EFC12ACA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW+XVObgbQcb0e7NQIPn4DDspuqaJqQWJ++9IgcA16PblJMCMvn8MkriZgNZqwZBrllbeIyjJeZUekYNqsCcmw4qXm8gvJ1x0ODopHuFNQI5n/B3zrrUd0A+kuKBCVIGew5wI/II5QaPMXWooq5RrGLUGqX1faBogGS6MKCZeyO0JwSxYzU8pP9F1ZE4t3mRnHQCgsRYc5fk7beXjU9PPwWk6/4Nsrihbzk7W5YfHwn2W3TGam/lWQbFAKSuU/UT8AytD4/EjrmfqXfxYTnraiFsdjYSPDuA7rP+AxistNnlfSuGiIG0VVcLu8kAvbTN1VtFEr1DN9VvwfHzOqmbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8DXp/xcUhLMf/MGUx3oq50TAThwwYZ/d5jMFpWM4nE=;
 b=dKygLTgecHa6uBFrDJjWhPGN4XOVorpWbcPGbI6qf1cqhvZJV1aPYnhfiwKTGt/w/RReDW7MW0AwlFyJFH0xMIdpvfo7Je4xDWqbG5PqhKao99s3wRJVG0u8O5RkGG0pfER5LaI5ullactUjeNOhpM9PedcQyTQl2/NlDMl6dFICFfUfRZYSiQNVRoEh2f0m85bW4qkgtU8oawz5jgwups3QL+3X+ZzZ01YQ2+jPmu2UbKE81PHy0lWmT2kb+6xdeU1n2jzIhJn+7JhRjeiETfd9np5Bk6Q3iAShj7Bo/t4TI/bArUzudfal2x+g3ygiokUUZTQEkC2RHUnMr+FOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8DXp/xcUhLMf/MGUx3oq50TAThwwYZ/d5jMFpWM4nE=;
 b=nSH5RxVN8//8cAzrDnW97sHVWmR6JpVJonzAT3tIOhY+sAFLl+2u2+t5FkdnhSNBMHYw+FuZ8Nd9MvcXeaVHOLZrcesUZvxLLmnB//Jx7NuAqbzN7EI2ACP+3PNkQnw3WjbvSfjCVqow2MMZydrQ+NFOvIjm6+bFDUVE0qKRIHaE/TLGhEYDLbUb0TY9HQ+vUsNAgfrw2K3B42Ep85P/NOzXy0Gzm2A0x7QlCjHcM956jfq7Qoz1jAEJthfKBRfVThvHQMdl6OgGxs5JfC/gdhPsPz8feVQlGMNY7eHHc/6bZeVyzBVNe82AEVVTZbRMb6VR1VC0Z4vQHKD8tGvXeQ==
Received: from BN9PR03CA0921.namprd03.prod.outlook.com (2603:10b6:408:107::26)
 by BN7PR12MB2611.namprd12.prod.outlook.com (2603:10b6:408:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 13:27:42 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::77) by BN9PR03CA0921.outlook.office365.com
 (2603:10b6:408:107::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16 via Frontend
 Transport; Thu, 16 Jun 2022 13:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 13:27:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 16 Jun
 2022 13:27:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 16 Jun
 2022 06:27:40 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Thu, 16 Jun
 2022 06:27:38 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <eperezma@redhat.com>, <jasowang@redhat.com>, <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH RFC 3/3] vdpa/mlx5: Disable VLAN support to support live migration
Date:   Thu, 16 Jun 2022 16:27:25 +0300
Message-ID: <20220616132725.50599-4-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616132725.50599-1-elic@nvidia.com>
References: <20220616132725.50599-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8160737-9d3a-4b6d-cf0c-08da4f9bfdca
X-MS-TrafficTypeDiagnostic: BN7PR12MB2611:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB26118C502452C8B1D6CE8376ABAC9@BN7PR12MB2611.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5Cixr4BC5x2VSsX+9hcL49XzF68c+EEPd7pZm4++28lDa/zL9Vt7IZ/R4WDQ15DCnBuzNDtJ7xWXtrZzti8UaEbtXSKC3CSCE7gjC4qJ5rPTFfLftlRZJIjT4rLym/D/mCyLBUjMecrm7l7WS5WYeccgtLXOZqYeirsDooVC8/NdK4F8lCJWAs5wRpFaWDwqp6lVZ3Na9goLMf4NFelkvNjUYVOcQ+e7KGwYtl1QhkDKQUf1o1VSQdqvLzp5tIC+D/QEQSVUDd7EPa+FWR2cWh9M6eNn5d/NN/7YTKXCdIDM8GanHMGCXtY4VI0zRQagy8F2jg/0qwhD77+QpGsXw/v/1Fuk8H+KtYb2Njvpk2W/d7L9uWtho58HEwrTMRKc4hG4ko8SiYu0QmyzTbcgj0J8YEvLqA5ccLgzOKLf6YaA16Np9EiuZ/ceqeEsAqCAO/q6bJRwl4V/CCWQCHpqC8SZmnr/vMkz4XRZL8ZSG74dMVgbr1/q1A2Y+CBwdXDoUnHQcdrWsvT6J8MLOCse6K0Iu7M5tmvQ821wlP7/AKJxRjHfQ7s1FyGJkRrYA7kNx61G2b/WqgWyCLETOXedfXmx/GUaOomJ2to5pXn6wIfVw/osQH1yGPDb3EbuNeSseeXWIWa1m/NytbDEkxVSVVwApg+u1c9P6T6RMft4D9FIwL7KELK+zEyum1T1shHUwWmXxaspmFMMqq8KQKQ9A==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(2906002)(6666004)(70586007)(70206006)(7696005)(8676002)(4326008)(36860700001)(4744005)(81166007)(5660300002)(356005)(54906003)(110136005)(36756003)(426003)(82310400005)(47076005)(107886003)(2616005)(336012)(316002)(1076003)(40460700003)(186003)(86362001)(8936002)(508600001)(83380400001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 13:27:42.1079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8160737-9d3a-4b6d-cf0c-08da4f9bfdca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2611
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current qemu code does not support live migration for devices supporting
VLAN. Disable it.

Note: this patch is provided just to enable testing with current qemu.

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 34bd81cb697c..1568cfdf07e6 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2172,7 +2172,6 @@ static u64 get_supported_features(struct mlx5_core_dev *mdev)
 	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MQ);
 	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
 	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
-	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VLAN);
 
 	return mlx_vdpa_features;
 }
-- 
2.35.1

