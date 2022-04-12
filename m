Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5D64FE22A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350859AbiDLNRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354998AbiDLNPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:15:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE317A92
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEpQCdNNJy4gAVr7ZXpGTVD4iIneL+phvRMN5WTZIXYePJxsLwqlfToST680AO+q7ecGePqqGOy2FBrdxFgWa8nQNKefjEPTIXBP6AxRaYLUMSrUS8OIIe7psL3u/WZqKgkEVRNIatC3avgkYy2rz7gVwJocms5BYNHMByV4qUzQpGaVPCgimWsO0YrloJ/h9oPRGFSP/pDeJwHVLMng+/pvBg+B0WVHthKsAtn8mi/78BifgvsGPq6L42xo/h2OICp6/NDed7BmlfjUrYD5Xy8JpJGzC9mXD1WMu8Anx2InaArEnoyea/QarwQZlfhbz0YyDnnry5IcMtUEq4b5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsKFe/5xJAgUALZkGb7KP+5SpfbIvfXoN4JmybCk9A0=;
 b=iFvUgPsi4OU/bSQqLE3QR6XP3swnaLvHVm11tMFoPu+THMGYp9M+RvEluezN7rERKXO+YTSTQEOAsxZAHVne4U62VL4/pjap2X3vaq0isTlyV8srt3Fp+E5l8t6PyK43O0V5oKaguKkQfwUp7QK0fA53VCoFUNQsoX03pJL/HGny8+8mmln438sabdTgqJQhIpyn+Cl/v6WAzzSStnYi28EW9WA3/LrA7tsAZ6s5C6xfqywWiWh7yw6xZOC2MZSl821+0JWjPa6zMD1xMN267K8axmypilEI7mXLNRPqteOJ/5ADzzBQxSixuStD1y4E7VtTwNM29SoXb43rhUWBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsKFe/5xJAgUALZkGb7KP+5SpfbIvfXoN4JmybCk9A0=;
 b=QQabdHkndiL9VVUx56q38iJW+fdKIEW5LFNU5oGVxSGIQt1U3387cuxQC2AeY9IiM5KFLOd4KxbehW6lrBM/9EGTP7tF92nhQsmQRDbe/o5v4KZ9WrrVRAsKMJX6rWEJ0+3Fo4jxJMG4vqVHSZzYdv31D8lshBDEgLSsXNmr5Wc8ketricMhpC7g6NQnCKPjsgNaXLcIJsZTNLbWraWUlGnKByCza/pI7bFfKsN4B7RxV16xEPD0FoWhvfLr4z3R9p7BiLol99EPWtomfxvesEf19h3CiUsnJW58eECMKuWpwqoSzzV5nvEQT45sHxf4ABorYiaLDov2gVU1y7ftnw==
Received: from MW4PR04CA0370.namprd04.prod.outlook.com (2603:10b6:303:81::15)
 by BN6PR1201MB0259.namprd12.prod.outlook.com (2603:10b6:405:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 13:04:32 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::92) by MW4PR04CA0370.outlook.office365.com
 (2603:10b6:303:81::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Tue, 12 Apr 2022 13:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 13:04:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 12 Apr
 2022 13:04:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Apr
 2022 06:04:30 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 12 Apr
 2022 06:04:28 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v2 0/2] Show statistics for a vdpa device
Date:   Tue, 12 Apr 2022 16:04:00 +0300
Message-ID: <20220412130402.46945-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b98c919-52a0-4414-f98b-08da1c84fc36
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0259:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0259174601D92C24C9C38B93ABED9@BN6PR1201MB0259.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EuysE6y+Q+c1YL5XP6ALP9w6xQbQ+wO8tzhGR5qQdGjeWUS7XJLLkkqqyB0vjTjXc8m8ljU7QpfQdNgiJ+bHBDqgImYcCPCU0pqUokSb9Gq2ns0ZH9EItXX/B6IXudxOHrO4JZc5Gm9QYEDBq58xBsD9fneD46gz+9Xr8y9krtsTMN/o5xK1imzKPSXPnWc9FDJT/5dUOo6wfchCgBWoguxicfeeIvB5vfFZ6Lj7oydbz/H1poSPUcM1qChuGlaTwWcZe8EFlyN4xRbZbOGDOXqaVSmq6MY0YqrMATAEqfH9nDOUyBQ/FiRb9LEmhw9MmA0udDxwnxk0PaOIoqEbZpyKZoRQPb/qiJkSWfBUdwSHu84PvBUBxAGQTCVGwnLJPghZgDMzBQ2BUx1S0A2XoKJPE3anHFgiNhGv3I0l5H3PpD97alvSa4CzgAzbEC0cPosMByBKIP7l1xmIDn0YlpuoNSQbwiiFwiUnQjBj9YrN4zgOkCCd9XgWTUQTjochJMKgukMvZmQ6zcEmwEwp2OiCylaQSifz//Y7wTQk+NujgE9PbcYwVusvZ3jzXjabUW2iAfxaVd0VHDWlTU6O6QvZEUB++p3xSWQXvPsvaoG2WtHcykOljMjnqLU9fCvQoajOTD+h0zYzGciAc0VMSCZbt46WGrojD4NnT8bXC4ABqJhT/TskIXkq2UNk9yWBr3vlFM1iZKbTae7J2h0TPQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(107886003)(70206006)(70586007)(336012)(1076003)(110136005)(6666004)(186003)(4744005)(8936002)(2906002)(426003)(36756003)(4326008)(8676002)(5660300002)(356005)(36860700001)(26005)(47076005)(54906003)(86362001)(40460700003)(2616005)(7696005)(82310400005)(508600001)(316002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 13:04:31.7974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b98c919-52a0-4414-f98b-08da1c84fc36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0259
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

v1->v2:
Return negotiated features and max virtqueue pairs in each stats record
to aid userspace in determining if this is a data or control virtqueue.

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

