Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701FA4FBC0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346071AbiDKMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbiDKMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:32:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB0D3EAB6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4nIRUCVg3H1JeTXprdcfF5pEDHcTWQQ5uFGv8xEsrJTK65lz1XE+KGbbez2EGOg29mhHE++orWk3DOpLD9dV+aii50mKN+6PWtCO8+oBydzuTY+cEqTLLrKl6tTbPtJjarnEA17TYP4eGA4aZQxGJpKbMFy28csfQsKT2etM2X3fChcMNjxum/DYao07B9Y/Sccd1iAeZQBcFaB0ruRC41ihtXn6DENiCETLmc7xYwLJSzQpYxgVUZaoTtWnA2Nl4IMYKKWoOrtMTeIuNkHxrq+ZldBi2bZ6iVYZ+ALgfojSlRXgPPGJ7M2WkiYaTS7UDdJXqrY341/esGgfESK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuy9qucb/2YxP3yFbRWRxNJxcqd7wfai53i6WhQpj68=;
 b=O1pBRYQGy6zeeoQin5gJ+uwDwW7QVvC0JTVBknSYYpQGtXA42Emb6Tu3Uero51erbDZU4byCeMQXQIPE+HfT23O7mvyaeK/i71Zg+UN4zX9vFs4PapwaYYRu3Z7FvA7zxG2eOEdrKebxqVp4gbmTxo/JIKRG4HmDmBRKMoFsYZBjf4WggMWPvNBZmEtfKBuJeDWnPjlD/xDyOSu6ax8bsSORLYsNRXtk3E8uB0jKuYs8zcON3/AaVAGRT69TfjUSO4PtXyWLliGIZlYoXHnT3/1NZzNJyoMBafB/6pLJOkeQAJHW8Fz4M2a+empIZ65JSws1cM8qIQQOkGAknvZ+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuy9qucb/2YxP3yFbRWRxNJxcqd7wfai53i6WhQpj68=;
 b=YYDhicR9GX2sDFZ54Qfk+E34qj0dYU9UboH3kMdZwQCD1j5UUxW+15CsW6HHm2V/nitnQJWEjjw4i50rwGEciTV1RWZmTNuadkCXmTWNT3k3f7eB8rCz6lP6mc+wgUOCJMhoZ9QwrhEYnQcvnsFEX7R+QYO7eq6yr9+1cY3T09Z6E3V6+Wa2X9eKDHmA4ilwT9eHKbhY881Tgp5mi+Cghp2pMdvh3MBF4/jyYiRAN9jm/lhzg829t0fw8wTCz2BFtDDwGZjuhXsRwRLM6imY5W+5nyMEcIXRuO2mUx5/WQd9qfO7COJgX1F9ahT+YI+IKbY2/+0NVO5I5AB0lCVsPw==
Received: from BN9PR03CA0741.namprd03.prod.outlook.com (2603:10b6:408:110::26)
 by CY4PR1201MB2502.namprd12.prod.outlook.com (2603:10b6:903:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:29:50 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::39) by BN9PR03CA0741.outlook.office365.com
 (2603:10b6:408:110::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 12:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 12:29:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 11 Apr
 2022 12:29:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 05:29:46 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 11 Apr
 2022 05:29:44 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH 0/3 RESEND] mlx5_vdpa: Support MAC/VLAN haw offloading
Date:   Mon, 11 Apr 2022 15:29:39 +0300
Message-ID: <20220411122942.225717-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 559b465f-b8fe-41b3-a1b4-08da1bb6f8be
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2502:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB250242A54A86D1F4DDD06215ABEA9@CY4PR1201MB2502.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1G0q6zeQs3D1/A3+tuS260xz+/IDMyd3tUxwh0SDm9V4H2v5gtMAKQRrGAJKBD3pK5Pge2ixkCNIUgBdo2vWYG5/AkPvQaAPoV/YO8B5dLTKRm6Qxni8m6pBRuiBHqugiIC5KikopqP0TPU6EOKT6RYhBWhRVFOzrqO2b2WaaJW3E/8MyxagUXz7J3lS0eUwr7aoHzSssndI1KIVy+WEyjQVhmt3Tj43oKBHlKg5FZ70udySheVQQZWYKQXetDLmmODmbsZTfyxQhtaqp7KzCgsCKdtvEBInGyRLHK6/RmjoDJcuFkaRFFK5fNIPO+5K/ZFKUTBagVCllEF/5r+G4t9N+pbXp5gTsipAVelb31njsJxFZaRQC+4iduDPbhpwqUB/VIxH+GRYDCtiShyHBvTjESWQAxarvGMCYTK6n1foTISGrgD3b735w+iuC3MHjfQaVRB0iSZTkQfR1leCsG94P+xN/xN89a//RN2dRecsBavY3Rth1pnOUXAt+Yd9P+OgbaCt/PvccIfGrVPvo9rpfa/nXHCbwj7PdgZ7iRN6gh+mG9CpSiN5XPpU8KUASLSZB4va/ctTeM2h3z2/ULzCfrjDbcuAOFq7EL0SsTTnm5xc1d88pVx6EtiooV6sGMlV4hCsBmgNETax2CqCS3ORSGsffcIwzbhE4Tlx2Riq5E07t1g3DEOf1f3WJXgUo1K8vFHrfgPyxNfnbAnaw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(426003)(47076005)(8676002)(82310400005)(4326008)(2616005)(336012)(36756003)(8936002)(36860700001)(186003)(83380400001)(70206006)(70586007)(6666004)(26005)(4744005)(107886003)(1076003)(5660300002)(356005)(81166007)(54906003)(2906002)(7696005)(110136005)(40460700003)(86362001)(508600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:29:49.5868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 559b465f-b8fe-41b3-a1b4-08da1bb6f8be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2502
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

Sorry about the resend. I had a mistake in Jason's email.

Eli Cohen (3):
  vdpa/mlx5: Remove flow counter from steering
  virtio_net: Add control VQ struct to carry vlan id
  vdpa/mlx5: Add RX MAC VLAN filter support

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 292 ++++++++++++++++++++++--------
 include/uapi/linux/virtio_net.h   |   3 +
 2 files changed, 222 insertions(+), 73 deletions(-)

-- 
2.35.1

