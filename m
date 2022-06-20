Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D68C551C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbiFTNWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345966AbiFTNUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:20:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3D21270
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLVcrDbhLazna0wtoKGbAh69iEaj8TmX0AFeWoqiv7zSS5oj+nyGECcy3MJQPyNh0/RSzs8m+NfUtXLJ/+T+vOnotOhr7+BbTJYYOdPEQQAsp83U/jF9c2yakq1UVLxNB9YdNE6pNCJOT/RwXLhY10E99CzVoUDJKuTRU9hZC6gxVN+KnuZVW9OvN4r74xCsEaetMFQgSK7SvGoykLDeBvDGk5oqltIMV8DLJvF/tjG57OhjCjuvhX0OLcuM0EH6NeH1aDzA/CrN78TCk70gHmY1nvIEBv1cce6OUJlMtCE4L0eP5HqDlH2zGGdrJjvMtGDbcDg9ykFxMRDhRRQNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esHaG2jhqwvNjd2L5nGegXUxT+4rVJ9Gfm3Wr8WE31g=;
 b=Argk+XlfiwgFl4BU+tIuMSfCzxX/3Zlb21sJTf2zjkKJH/E/SmNfbe40l77PqhT3kHVAI08rGrd+p12srUzd5rhVijISBX5z/K/KgrTel2fjA5V9OXzadC7ybWboMT4LTwBvGdmmFMfeE37wklcOdJaMRwqEuVQVjpBEUrttk+ZMVhNU3re5JmrBzf69PmQfztdicnfTY0WMm3LSEb4ddYYLsIGTcTYfZqbb/jMI7PnQ+Ald6iwLk0UvJ02LvZU2dyg9TpFi6MEfKRgnVzpRcYLlwqicyabIZO2ZpTOs3+PxlTHz3+KMS810IEMQPH8gv4YrV7oM3OmP3XH0kKRi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esHaG2jhqwvNjd2L5nGegXUxT+4rVJ9Gfm3Wr8WE31g=;
 b=ZQkBWL2vrTsn2QJ7YbrJh+bOgJT0CI41RLXJom7Ql55BCk3oRCxMC6KlUylhUX967UCvdxPlhhCrUiiV+polldt6bAqL4GCXLyyNo+SkEdCoriNjo2bC9X9SfumH5APbKyDCUasj+hEKA4nwAoHhNypS8AZ5Zl6JY50p+NSiQntZPy+ql/fVozNxPwhrm/M6VDqE9RULRS34x8q/SUvjmBN+c3V4pvdxJyEhKxKadj5WGE0d/Md9L+6aJz31JZW6cZPqJPku0lqsuFYiv1Uw6vLo6tcFmU44UZoZQB53DgTUDlmsDaf3s8UMfLI0hA+6B9M5jyFnEQhNqpk0GJUTsA==
Received: from DM5PR16CA0037.namprd16.prod.outlook.com (2603:10b6:4:15::23) by
 MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Mon, 20 Jun
 2022 13:06:30 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::60) by DM5PR16CA0037.outlook.office365.com
 (2603:10b6:4:15::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Mon, 20 Jun 2022 13:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 13:06:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 20 Jun
 2022 13:06:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 06:06:27 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 20 Jun
 2022 06:06:25 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <eperezma@redhat.com>, <jasowang@redhat.com>, <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH RFC v1 3/3] vdpa/mlx5: Disable VLAN support to support live migration
Date:   Mon, 20 Jun 2022 16:06:14 +0300
Message-ID: <20220620130614.19679-4-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620130614.19679-1-elic@nvidia.com>
References: <20220620130614.19679-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cf26089-38ad-427e-1327-08da52bdb08b
X-MS-TrafficTypeDiagnostic: MN0PR12MB6055:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6055902E8D0670AF33AF7EF9ABB09@MN0PR12MB6055.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4XUieuAmerUOF8n5Ng0VDmUMq9feaW5KEwf5bW/qjzR2AScH3x9e8bLPRm+sjCwyW8Oy08NFAyMwGpGo9jEySOmPOqHcp27kpiRRQy6fSgd0FqpJWc7Kbz2+4L4cWbhbp5QpiKKaNLJtl7Ynuwz4+4srdKGEJMPQEejkAVAmhXslKuP+5YTti11wreoWtTqaWCkDtlFXKEqb5kjCdy2YSKaZ3Hs5mcpf298gvePpkKj5BOer7Nz0ZGhNNB7vwobqoqCLrNOi+889g0TIO+7QTED1fg2o14CpB7Yo4AjCCSwqUFDeMOCR9/XsH9Xxw3+ot9yTZkI/+/ssQEFvcjDURVzgBUJ41B8fIAhwAvqZDhBUNprrKSwkCjrGjNqNemEtMwsEVFalXPJa7eF7eHGsl051P+Ul9BtGScKzjEMT+KQD/u4aqba+mpCp3JT23Yk95DJt+Fn1V5CQupiKc8QkGM6CiMFowvTbqRYKpusP01dt7+ULWkuLlFJwbTTclvAJ6+L/hRm/PEc1VrZfldv9X9JXehr3Ubz8melXO1rwBCB9bEbHXe5FQRlMFpB8FfLDfqs/YP1+jYWnRB1NmoXFRxhHmJcL6NAEhMaJAJvZb3WfHuQPtxbMjO6+VfXWKBhYTgr9OwGrKK67ClNuKcSmRSFhB8etCvV4StvR3CmQIJmOrt57TcUG65stNu+gXpOFV3gNSu/XmXcuiq26F/5bSJAjJNHFtWZZqD/6uZlkp+y4wUlfORuLoVikv5bhnlQ
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966006)(40470700004)(36840700001)(36860700001)(186003)(107886003)(70206006)(83380400001)(356005)(4744005)(47076005)(316002)(2906002)(426003)(5660300002)(86362001)(2616005)(336012)(26005)(8936002)(82740400003)(54906003)(40460700003)(40480700001)(41300700001)(81166007)(4326008)(110136005)(8676002)(6666004)(82310400005)(70586007)(36756003)(1076003)(478600001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 13:06:28.9453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf26089-38ad-427e-1327-08da52bdb08b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055
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
index cb637dee2ea8..a468e02fd869 100644
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

