Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D67574C50
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbiGNLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbiGNLik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:38:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC52D1140
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLbFwdy+8u4aHl79OSMdpqkLrpyvtOiv+72SoJvo/YXSnHojSK8KAdWJ/YARP282LSlwIgKL773sO8lbPBfu02aUToeKs4TqgDagS7Y38aBhkzwOvaH6kn6RTeITUht5X4Bib8Ex1OqXgfzGeHxZzvbHiw6QA56hxivrfmKaphbx5a6w/4GCo8L89R9OgYpBSYQawm/y8G00TJV92z3m3Ci8ZC0OBh6Q5dJeF6oHVn0FDAYLrL/++1OIbV1YIsCNB8WW20T+gmVLC0eDrpFjFl4Y7pkTt625ycWxF5zhX5vFJPNYoQrioveCDR9HOxtLTvdYwIrS14nLyMTrcX7/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKXq2z/c8gQVvdjhyLkAO2QoWj+f1XQLrfPqZi3Z7Xo=;
 b=TwJfWJKajGsGjkwRWPACr3ihTmRBqkEVD4GtZlQd9DsOTYmrrWuGR4ImTX573VntBz5R0BEzEwHm5I9l2jt+N7IgK5t4oGXfOOhgEkwrvdRNwFJCInVYRgH3tiM9bhieHFwGK16jhG3vEAlEiEveygqy9H6xGjqrI5jHvhjv96qqZJ0mb4ddC5v+WUnPkbq+QDBYNdf2SbT/3pt2POCFS1dODTrBlBzOQgkKKY16+sswkehgn9lCBIV5bMt1DXstl3EiNj8FGdMSR75U7dp6FT4EXxqE8rgH2VZHBg7E0mP7VhfoCnNxYVJeW94iCOF2SX7qi32MkJuh/cOyGXq9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKXq2z/c8gQVvdjhyLkAO2QoWj+f1XQLrfPqZi3Z7Xo=;
 b=VmlnswXntwiQxYMoQj5Tf5xdhMsTophGPORAR7xLFv7+FgiR1t8HeiHzWCXj9cxevwhzn2f/UzfWJlL5csKiSG1Jb2eimnWf3dvskKtcRH/xnHkw7CNDWbexN9a8LGS3nYtPrptd+DGZ+l0v7vxEnvvcM1AgmzzYR+kbegL2Dd8csdyRDHzINV5zcxmHdLySZ1fJbPKd0MQa+9u7FNIiFmwdGc2sHVg6ueE582DuYn7NMVBNoOQ9QR/H15hCWGsFoV52v8kT+N9mOs3EtzJMWQqfetslHv3LQ3BG+yG7fNQy0mpGfE7eC5QgFWplhy2Tnwi0TKUJSXkCqbRwia+Yhw==
Received: from MW4PR04CA0310.namprd04.prod.outlook.com (2603:10b6:303:82::15)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Thu, 14 Jul
 2022 11:38:32 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::b0) by MW4PR04CA0310.outlook.office365.com
 (2603:10b6:303:82::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Thu, 14 Jul 2022 11:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 11:38:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Jul 2022 11:38:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 14 Jul 2022 04:38:11 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 14 Jul 2022 04:38:09 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.co>, <eperezma@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH 0/2] mlx5 address space and suspend support
Date:   Thu, 14 Jul 2022 14:38:05 +0300
Message-ID: <20220714113807.85665-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b93a04b6-1955-472c-b156-08da658d6136
X-MS-TrafficTypeDiagnostic: DM6PR12MB4044:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcyMWmGd8AW8xoOwJGDUkHwobfgJiZAPal8NuAK3xuLNGxZLDBRuhp7dwG53X07kYhAJ2W8EwI8nnLbFg/jMEjFIooh2xFMTo6lJ1L4qtirUhz7m+oTMyvixre9D8LRpU9an9T0tqr3Qd/5cP8dm+jAMdmet/rZovKOfmMbHg9A46pmdhZ39BCWQsoJSCJ7ClSXEaI78iCO+oFsArI8fmu2Xw8qNxnfJePovvxUwzYcMScrc+sXWZvggNGOwgNmUtvjOOn6pE76R5LF4SEM2hzOPVTqiKat+9W2jVnLoxe6GaIukt3UYzEYpnl3MCsTw4WpgeEMHzdcfftvnU7Rdix6kRHMYYQuefUxvmjyCj21jseT7UJLPJcQ84Px24aishZPmR52AeMP72NunOku5PO/f+C230O6FmbPBwkQadVQKEQwBivkaRUYUOeQe7wOJsZidNxjXW9XME8gOl47j+pnyH0C3shLdTh5tl25Y3QBxMomXhoSK2sQV47L7b0dPYjagPqJruFFWbwJBtwGDzcXcpM3bUhJ427gSjnCwe6mAE8QLzuqGwnfoTwpjvvIgRazbzkKPq9oD0UGKaF+B0LWwidlROd8R05Tc7uHOQ5w4UdkIYM1qXRfgItp4mm/ZxUymYOlcLos8f+58yxltoklWuqlNCG5zVYw1gKLnEa1Seyx/Nh3uTw0vv1yK1fWMTos2Ee/9ieMj56cCmHjQovonchGLO/1b4RIzzMzI5LwV2cM0JUtLvJtr0bPEkSRGUlfvybTwK6ulAAHoUiIvH8TkQgklZn+LUBKlaOIHBGZeN0not4UC3yZa37yJYlgpX94e/C5T5+ZnmdC6AYPKjFzxtS0fR1WhbqIZF6X8qao=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(36860700001)(36756003)(2906002)(336012)(83380400001)(40480700001)(40460700003)(8936002)(81166007)(4744005)(47076005)(426003)(54906003)(5660300002)(82740400003)(110136005)(1076003)(356005)(70586007)(2616005)(4326008)(86362001)(8676002)(186003)(26005)(107886003)(41300700001)(15650500001)(82310400005)(6666004)(7696005)(316002)(478600001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 11:38:32.1177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93a04b6-1955-472c-b156-08da658d6136
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

