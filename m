Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE42050C173
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiDVWJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiDVWHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D292E6603;
        Fri, 22 Apr 2022 13:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQATIqcCFDWD2XVvrGiOYyTbVehlat2ioufxLLE8Mh8cbk+5FvUGSphucZR2brFyaKNqRH6Jm5grDiBT9LCNc7tDIt4G74KArocCOufKDXQofFw10ALIl8cEOB+6ochASfDPMhZwYS6/2Vkkrtfk3Z7F5Rkops2govFJak691MnOxGkm8JgzQHEUMtQme2vaOs910Jp/vo/t62Ajg+OXAUk8PqhPFRspm79EMsJCxK+PZnBGxi9UgW49iBJCUPL/nMkgBfAB+cOti70vW4TfM2uU8ShYe2Omt6LxArCPSmaxS6KWqHguvajM7M4XhUk8HfEcKXlKEtRJGAyfgKyg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjmEFM5rvEH4E9D0Sxcp7mX30o1EpldYL9gR80qVKSc=;
 b=U8w2FAqBEk1waMCWx5H260SfVO1ArGZ6c9f7tqWT8UFAa41aokMSVBBqrjKOGO5RKf0/0K29xreXOiujDEht5h0iC7JGuEwq2QPaxUvPN9RD5fxMfybOeeNc5L5Ze9XkrIYNpD+vjSqUTFnPpvldEZPPGweQ7bw53FJzBnvKOm7mPeD2AhqQ6xpsuxkvVDf74eQLaSv0W1VMqOmuZjrEkChVdMydGhJLpuRktWGHlYvf3KZ9Uwe9TcUkaWl2Dxu7ElYGAO47WmfB2T9Whfg10SHDh9Vg/3Rrh/nLEDKUuJ3zWOKI0tuArEPEF1AHCKip8KwanpthjSwTba5TofHV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjmEFM5rvEH4E9D0Sxcp7mX30o1EpldYL9gR80qVKSc=;
 b=Dd9cE3a7thvPF/v3UhuOsYgDjYv2SIJO5a3skuYD24RevynuZ9By/y5yHHJsBO3SS+6S1oH9A2l75Aqf5hvPg4DZP2y0gxPN6VsR9LHNjJNsM0HHUtSLDiOgx54dZlbzuHyasficGotOSLBtge4nRbR/fMYWt466JsK0GSgpf6PZNRHQy8QBwnRKKRiZc8j30dZzDM4TSsukSyn6FaobBhi6ie3vTmhSGDnODh2mwkILy+7T5bdi3chkXhoAp43QfpeDPjFkulag5LXpHYWJHqzQolmMzA55vvmf5Jgh2SgeD9dvz4pMsodcrf4KHMUeXb7fQIXPkEAsCZ3vRlpfuQ==
Received: from DS7PR03CA0312.namprd03.prod.outlook.com (2603:10b6:8:2b::21) by
 SN1PR12MB2559.namprd12.prod.outlook.com (2603:10b6:802:29::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Fri, 22 Apr 2022 20:52:31 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::b1) by DS7PR03CA0312.outlook.office365.com
 (2603:10b6:8:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 20:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:52:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 20:52:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 13:52:29 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 13:52:29 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v6 10/10] MAINTAINERS: Added HTE Subsystem
Date:   Fri, 22 Apr 2022 13:52:21 -0700
Message-ID: <20220422205221.952-11-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422205221.952-1-dipenp@nvidia.com>
References: <20220422205221.952-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec38e82d-7647-471e-29bc-08da24a20513
X-MS-TrafficTypeDiagnostic: SN1PR12MB2559:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2559CA3162BEEDE16A38B030AEF79@SN1PR12MB2559.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbfVeOqD7+on7ylmKjqew5Iu8uIFOmboMKhPuGjXuOTrYQxZ3YZEG9t6PFTgPaAMDwqMjXUkrxATX5JhHEi31rv113Pzjg72bPY7UqZYuEUNtof8zWvidGp0urmsSOmugtb15rEXJ5Vno/yarxwnEEw5kePk2z9naae9ZwTrXEAq+Mv7GHJxgYdAIxChMoe7kyQsXgZu+VAeLZSE/xUN9UsuJg5YPRScx9ZtXwnAAX5f3Fu/FlVcGEfW6hCGkV+l+6cuDpp+tRdE9fYNSftI+RIlQqNvw1XjrVdRfT5I6pG+ENuZqBZCL/JEzxghMo+XhUd5ES+YOxZkLXSjr2tkQ89KEjuKf/TVpv2d4tPOYyAn/lAekx2RRFJB1jogCcJkgb5Sf8oZSpR6oiEok1JQCKuz2DzO4fIs1Klv2YjrY2Io/ME6qMiDoLiQzu6gjDIdH5airdK4jeNQzF7Z0TOOiFt290q7N3dgAe+2WxOXzlRbhSOeGil9cUQrGMEwJbmPqJAsisplhFateKMR0Uj3QFq+rwOjUEgTiavM611rZw7coTy5IewuP9ddcG5v52P57f0zdRxOs6ESF+rOn2mM2PqScU5a2Lo/oaUHEvtQsfUr90skOUQgTZtic6jQoSc6yoSu1fmdwj3h6+gmBfr0XIGH/42+9LZX2mkbF7haCcUfuAYUbJGRocCkmWhbs3XsTfznauXorjkVTUFjuuquAUJxkGQLlgg/tsWxb4lbHuIrU5oFNfI37KDI44Dbs2T9IkYxT/49NUyDC9KdIFOCGA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(7416002)(8936002)(5660300002)(7696005)(4326008)(8676002)(70586007)(70206006)(2906002)(921005)(356005)(6666004)(36860700001)(508600001)(4744005)(316002)(36756003)(81166007)(86362001)(26005)(40460700003)(107886003)(110136005)(2616005)(336012)(426003)(82310400005)(1076003)(47076005)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:52:31.3540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec38e82d-7647-471e-29bc-08da24a20513
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2559
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added myself as a maintainer for this new Hardware Timestamping Engine
(HTE) subsystem.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
Changes in v3:
- Followed guidelines for the "M" field.
- Removed "*" in "F" field.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82caf7d82616..f62ff8b0e97d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8987,6 +8987,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/touchscreen/htcpen.c
 
+HTE SUBSYSTEM
+M:	Dipen Patel <dipenp@nvidia.com>
+S:	Maintained
+F:	drivers/hte/
+F:	include/linux/hte.h
+F:	Documentation/hte/
+F:	Documentation/devicetree/bindings/hte/
+
 HTS221 TEMPERATURE-HUMIDITY IIO DRIVER
 M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

