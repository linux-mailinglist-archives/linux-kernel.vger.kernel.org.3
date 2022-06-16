Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA3454E1EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376954AbiFPN1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiFPN1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:27:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657D1DEFC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW2JKqDYPK2yZieY5E2KweCro/o0rQNj3NphmaLLzK5zoOtVmh4HFVnWfb68ySWKw/P708wUZn9asU/xqR1Sz9Cck+J8UTgMk9/vZYd1XhtuZEsGyRCBbCi/Gg17tr+o6j2R8rcwNhViL0MD+5k1fk4j1KqLkykULBFKzdzNYmfzh0tkxR7elZUIoG0dB4TfSZVE5AituJWETURxSEjlb7gIi9SvJXhI6CJWpilnRK5X+PrOpn9nbnMj6UTwv+TYsivI6aEmXYTFzNrGFL1zba9/0TGYQ1S1WnmwnVPvkOF1CjAthVzavwWWznc4mvy+nv1fKjV3csyOHENGTgwoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFRLZVK03KU43QG3EM7m/vuDxgFdCsp9pcQl1a+GEFs=;
 b=Z2m8epnAw3MB+wzKBHVrMzcbX87K7s3sObknO6w2TIrT4RmjGgXeah0Hq4oZ5dG8/8Gn+OKy6gMg8KshKBmaQk6oIUzsVMgPilkzfbhq9oov6A781dN6UmLG6xxS/BUrhgvaKDO5tVnoK2l7Uv3Ha7YpNBr9S4yz1wjouWxYuJGEz16l7x0jUDDMbhwzMq9uXPS4cMNJaVma2fRk7/F01FJPX6Va+pnVnhumgfS/qEOFxyfKLh+oJqcqgp8HDWNldfZGN7KfpfJLM1H1MQYbLIqxZKIPbBS5W3JPrxJKT+AwS7XXbEtvzzoTPNo+ZgZl6mdW4/Q/b4EJ9/yDSYTE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFRLZVK03KU43QG3EM7m/vuDxgFdCsp9pcQl1a+GEFs=;
 b=n8uo8ZF8QBECS8O+GgXFWeNzj8RMafP/IBqWak/yssnBxsBhZG/ojwKS2C4QoF9mFR12AcU/9YSRvSzCa97Iwa0sDF1ALvfX9KrHBhojLdPx207jh8sD+Z1On9yhqDS3RohXoKUuUsP8ImYZ9tJUC+ZHyYOEy4+2e/l2wti9YnEEEducDoudnDmR1/6ePlkdmBgAbEN0nzrbPjl7TT107W6iQ/kGG3O7k0AsM1RxEJ7GSOUt7rIa7ruKkJeD5wA4KNvPGpdizFVyxrB6nZRGHL2BZfacyHt9RB1itu2ET48mJzZ6PFul7cL+ojQnM9UklgQeNN5D3iku3XHy+wOuJg==
Received: from BN7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:408:34::24)
 by DM6PR12MB3548.namprd12.prod.outlook.com (2603:10b6:5:180::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 13:27:32 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::61) by BN7PR06CA0047.outlook.office365.com
 (2603:10b6:408:34::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14 via Frontend
 Transport; Thu, 16 Jun 2022 13:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 13:27:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 16 Jun
 2022 13:27:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 16 Jun
 2022 06:27:30 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Thu, 16 Jun
 2022 06:27:28 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <eperezma@redhat.com>, <jasowang@redhat.com>, <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH RFC 0/3] Support live migration with mlx5_vdpa
Date:   Thu, 16 Jun 2022 16:27:22 +0300
Message-ID: <20220616132725.50599-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c844decd-d4a4-469d-6a89-08da4f9bf7b6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3548:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3548EC126CE1B69A38BDF462ABAC9@DM6PR12MB3548.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZLU4Hfsacxhed9br/NFFU/tMziUNs3l/WqZvKPQNAwOwiTpSvNLwFcWYnMjAI9eujDp44MH9PyAadk8IEHXYiU4i1Qh63keqlYyeJhyHa86ELucm+e8snRwaoMQCqoW3yKFl+++lO8+y3LwihkpG3Mw333hStFZJ9mnGdFwxim8xadFQwFooM4Z4Yp0BFYENTG0WdC7+/vgGfjMrPWZxL1XccSiyURpwT1AjUqNdyCakAdj5IEYcDHX3sYnm5lHiNbEbU9mKU/sD1GYXWId70cobOdx8CAHIAZcvYqHP9+jTFKsu8a/vjTGJ9utD074III2aBDPPZ40HoGHp7vU10qb+3Z71jeODLoGOak1SFJglPpaCUMupxkC5zAXZEAb+3GYnqWitoR16QvGmyujvMTcDdJaXEdtxK0qc0xYi3xCZUU8UuSTxgddtLFLwRAm32yGBcwCtAqexB2fcFFOAHSFVqEUnMoNRTtQJIAwEprgNML1A2NyWD2pP48Gq/F46Zr/2KFYdz1F4JbsIb4FpWtITObiQtp33uLt0MD+ioJh2c3HwrIDOhXwI6NCD/jGO2vQv1k0A0lwDSU1J/wN3awciUu+bgq1ihUD0IEWuQVS8YAfP/aZBT8K1q3wztYZkshnQ8A4bXQIsOmZxvu2eJt2UgWFZ5FnWQDvo1uET20PQkDe9JwLG3pTy0m0PDUaQfKWJ3Nb65C7p521+e55GO3mlozqx/vKGez4Qt6RFvXX+weX7ztU+eq0naoKcwrrf0bKR35ohzoGbh6FYrkgUw/fi+sou8cCpJ4l+A9zcyVZuoHfxn6R2j9TkTl0h8vI+zJ8iaz+09nX+Smcg7LIIQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(54906003)(508600001)(86362001)(966005)(6666004)(4326008)(7696005)(70586007)(8676002)(8936002)(40460700003)(36756003)(316002)(2616005)(26005)(70206006)(5660300002)(1076003)(47076005)(81166007)(36860700001)(336012)(82310400005)(2906002)(186003)(356005)(107886003)(83380400001)(110136005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 13:27:31.9236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c844decd-d4a4-469d-6a89-08da4f9bf7b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3548
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patchset supports the suspend callback to suspend VQs to allow
sshdow VQs to kick in. It also adds address space support also required
for live migration. We use two groups, one for the control virtqueue and
one for the data virtqueues.

Finally there is a patch that disables VLAN support since it is not
supported currently.

The aim of this patchset is to allow enable development/testing of live
migration over a real hardware device.

The below two patches are also required to be applied but I did not
include them in the series since they were sent separately.

https://lore.kernel.org/all/20220613075958.511064-1-elic@nvidia.com/T/
https://lore.kernel.org/all/20220613075958.511064-2-elic@nvidia.com/T/

Eli Cohen (3):
  vdpa/mlx5: Implement susupend virtqueue callback
  vdpa/mlx5: Support different address spaces for control and data
  vdpa/mlx5: Disable VLAN support to support live migration

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  11 ++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 170 ++++++++++++++++++++++++++---
 include/linux/mlx5/mlx5_ifc_vdpa.h |   8 ++
 3 files changed, 176 insertions(+), 13 deletions(-)

-- 
2.35.1

