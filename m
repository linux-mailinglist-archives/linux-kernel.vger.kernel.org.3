Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF5574C58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiGNLkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiGNLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:40:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EAE5B06D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFE3/f2SSeMV9DttdNhunhuU6kTSAHw03Pbc9gqLuQK1bqAY4bN3kLvkQZD/iGgIAJptNl100qiKXq1YDkTSXmxKYFkQmfjZIYC/y615b3cRfw+M+W/t84VZZUIutg6f/mmHCi7p/2zntuOTDVNn4Uew2H/+eWZJX+1GBFwFYA0M/Yweqjwv4RzBt723TajHVAtViuJZ79jUakG5jsNI2Mc4JRCtoo1FSriAXCX1fF4dJnZ/wKgg6NdpGeum6edXiK17aFTpfMxUQPdATmgl9/sRi1KkyUn1BeeCM8VT27k43wM+pk+gMz85OXo3yRsp18NPLiKUPDn+GsOGOgnJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKXq2z/c8gQVvdjhyLkAO2QoWj+f1XQLrfPqZi3Z7Xo=;
 b=UImLUknbhVC4sqRKR9XNWJlyRK3YcaPGg6Vf+9lyf7ThosE0ErlnQ0sp3h9dk9+UHedjWBsvDqIo0jbyOgaQ4J7j3dHicg58PYfuR72HSh8MSW6wB1KAQAr3lPvG+nopb/hcE5Y22Iz52dnnImHtptdKnbHnPSmrFl8m3zCdEnPFxRRO8ake8f4Y2lyYk4utLBB6s/6C6kcqCnoDJEsjNinoe8qhD1GaAirgexAlqQP7RoblUiuKFG0lenooWRbKYGxPln1w9lmFrwn8C1AJooC9HynbP3U6mi2uOUt0vc31HfWGSmvrVWAR+pRhafr92uPj3hSlkD41OzeHlxNRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKXq2z/c8gQVvdjhyLkAO2QoWj+f1XQLrfPqZi3Z7Xo=;
 b=mOcCrF3o1Szq9/qoYBgqRB2efctNGyXwzNqongd4+H9/NID2zA+7zeTiRn4iW1+K14sV7/ydeNL1dphe+mAbU6+0FEL23c3fBclopX3xilfWXt21SKe4CPzyMurFLPlcWaKeKN8VYFDcpFgFBtsZbgD3WNHjE73wxCyL8fsxd7vr4vz2XLmrk8fnGdLQntGp4LJsuVrMNStTQfU2TFuKqg193DXtcnqiz1r3MBbKpBQ9Xf7tY6Crdj7p0dXHDrje4n84bMwRA5hCjbo2XTrFydDciZNF4i+/W9Z7hDiRfVyb6aTI2poMVo3z3Xe9ZACJ3nL/xuefoycDIoU+djW9dQ==
Received: from MW4PR04CA0034.namprd04.prod.outlook.com (2603:10b6:303:6a::9)
 by BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 11:39:33 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::e3) by MW4PR04CA0034.outlook.office365.com
 (2603:10b6:303:6a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Thu, 14 Jul 2022 11:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 11:39:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Jul 2022 11:39:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 14 Jul 2022 04:39:31 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 14 Jul 2022 04:39:29 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <eperezma@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH 0/2] mlx5 address space and suspend support
Date:   Thu, 14 Jul 2022 14:39:25 +0300
Message-ID: <20220714113927.85729-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89633863-5248-42c4-301a-08da658d854f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3462:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +D3imCyHFYqwgjoekU2H01rEn0zLt0tHYTAOBI19tIotqmdkUH1E5/iRZi9wD01/EOcrksBK1qH0pc6Zb9lTeb3QNLd04rRmZbTPA6huOrP0B/AhhIclXmObFDyKpIPQq9AfnmWndiTiKq7KOemXYMvSgB43vknC4ByS5uaByYmKIiScwxozboGywiJzBCAzaAZ39nuqZuMHc3XS8y3mdl+fVM53bsZO+248YAjKwb/C7YofvVvvI1UpHGv+3REJeJpkEThe48hocTSZ2Evd88g16ciGk+86Mk5fhQDhpaOXU7kV4SDBfDgCu5Zdc7DAyS5mdjTEFV5q0edmxXiOZIH42XPnVagM0HPL3Te5kstb+CMuFHErTtFTZnaQsCGtqlnSUD+zIk0OoPWRk1w5fzaz8SFVYz5BmvsocIdOB5Dmnzzzk7k0R8w/X7S+Rn4JXJ7WImf2l02FNnUZacF1gqbSUJBBJ3yCBLJV/p7YbJK8T3c/1kNFiHmO9TXcT4y/MN4/jhox2VejWApUsTCP6im4Jsk/VdKeLq4Z4Jr1EMBvDokKAmGAPIs+yuhJmZkqEEwg6cvOAlJ9IqGYAAkpDhE+EFku0ZpoPRTIldWqW+Vsnqp+irl0LN68loIVPLYfUwL1ETwNWKSPZFj7xwvb2G1eoRVUUsGCpth98k3PKSArUFCjTwZ6NQkQHEextA9MxNKXEfmVJh5AAd20i3hZcAt/ChYy6x86LgXKuTrmvvBkD1kAh0QxNV1AH8Gxfaj8W9Cm5eU7tM//BZiBVag0umcHDfg7iyGEND00ZeHk3kClIIl9bZX0c453Cvh1jLQ9IpiLt7v1SEVH+7+BCeZXO0Vtp45tbjkiX0YMh9U7Ft4=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(40470700004)(70206006)(41300700001)(6666004)(40460700003)(8676002)(2616005)(4326008)(83380400001)(5660300002)(8936002)(2906002)(36756003)(36860700001)(82310400005)(81166007)(15650500001)(426003)(47076005)(336012)(4744005)(40480700001)(356005)(82740400003)(7696005)(478600001)(86362001)(107886003)(316002)(110136005)(70586007)(1076003)(186003)(26005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 11:39:32.6606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89633863-5248-42c4-301a-08da658d854f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3462
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two patches add support for the lately added suspend
callback and address space support. These patches are aimed at
supporting live migration on mlx5_vdpa.

Eli Cohen (2):
  vdpa/mlx5: Implement susupend virtqueue callback
  vdpa/mlx5: Support different address spaces for control and data

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  11 ++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 171 ++++++++++++++++++++++++++---
 include/linux/mlx5/mlx5_ifc_vdpa.h |   8 ++
 3 files changed, 176 insertions(+), 14 deletions(-)

-- 
2.35.1

