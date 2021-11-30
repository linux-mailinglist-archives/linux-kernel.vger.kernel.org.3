Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76BF462BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbhK3Ed0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:33:26 -0500
Received: from mail-dm6nam10on2069.outbound.protection.outlook.com ([40.107.93.69]:15712
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233263AbhK3EdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:33:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AasB4UjBwezmxV5irvGPrzAe5nw9dK/ACNakvSX3lvzQ1ZLer3AEqb19VR1pTYGUALmPkgUDaZJmxaGHFnw9GLQJEAGcFgUEw9KVh29ErT83S3Krw8KPmQzl4rgy+yJqW6BAhNLiYGtknzd9iqeWeRbaf7Fcc5aeorTleHRBbUpvJh7TuS+sqMycGQkluhVyvQLxisBNw8OLCCbvyO/KmN9/l3bbzmeYJWzUEjruqZC+gAmLni/HPMgHA4lKtXQg6I3+w3V8dpd6aOHNptQ7Sp9hUY/F0W6JJ4VLlwiOkK0+B7GW7EWVCQV/d6C02j1Onj990OMAVOyUEdgdJoCdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVJQ9l0OXua9T/P42CXL2suYizR+TIfbJb9aA0Kgk1k=;
 b=S8WlsocYFFhjG0cecEANcTY9Vokq6c+096YwHq8VzfghBEiqGd+OTVHjzLGeCKMgGgzYyoR34T1SMWYaJSNxUH2rHNctoxS/8T8d070oOLvBkbJmiBGJhOtTXQ2qFhIIGgFtjsofLf63HJZMHPARc5HO/Gq1bXDQZ+J3TJZyKeg4eLL9WMEaODENq/38F/wM8/fRfXp5MxYXSUDAB82iVdVrB+4qL5qRQbK9J8CZvIJubHt05ohwl8KQ4HSCjhCvjcwazrXVUoOwW5xWKEA3yPAHIwTDubx/a6rMiMc/3SAn1K5sXyGm73OdfISOggPjtY3DmJZGUSLeTjLTxOs6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVJQ9l0OXua9T/P42CXL2suYizR+TIfbJb9aA0Kgk1k=;
 b=h/Y01iGkjtQQkqCKIkVLV80KnXjGjFWBXmD9njI0ykMTqRRgb2JeQ+B3I29e8Cs1bbsIxBhY2w1jI70C/tiYkBcvQ9Ku4WJjMbC7hwvlkQDNG2fYxzXmAmyrw02qHrFyNTSpp0sc5qCKMZb0PsxmMx2gekli2EDSDXvmhS29tH7sCOiJL30HTkOrvYcR2/hZ+OqEK4v85jOGxLcghQ2Vd73BW06kvGjFV4fJMzaCfbeyPhaISeq+5WXv/1+AM3G4Tgz3lKEFUR8l1MzgU/A7TEXKkah6yzYJU8pS85imaS44IfXAdfsAUtZMhZ/paSAUfS/4R1LVmElmnmytD4RfhQ==
Received: from MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::33)
 by BN6PR12MB1778.namprd12.prod.outlook.com (2603:10b6:404:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Tue, 30 Nov
 2021 04:30:04 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::1b) by MW4P223CA0028.outlook.office365.com
 (2603:10b6:303:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 04:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 04:30:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 29 Nov
 2021 20:30:02 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.5;
 Mon, 29 Nov 2021 20:30:00 -0800
From:   Parav Pandit <parav@nvidia.com>
To:     <virtualization@lists.linux-foundation.org>, <mst@redhat.com>,
        <jasowang@redhat.com>
CC:     <edumazet@google.com>, <kbuild-all@lists.01.org>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <kbuild@lists.01.org>,
        <elic@nvidia.com>, <dan.carpenter@oracle.com>,
        Parav Pandit <parav@nvidia.com>
Subject: [PATCH v1] vdpa: Consider device id larger than 31
Date:   Tue, 30 Nov 2021 06:29:49 +0200
Message-ID: <20211130042949.88958-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a915042d-c290-492d-f3f5-08d9b3ba1470
X-MS-TrafficTypeDiagnostic: BN6PR12MB1778:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1778CCA1C5064EC69C774A53DC679@BN6PR12MB1778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndaXzwqfj0O/qsCKUMYUXVclSx8gilKqe4+lGvvOcCE1d2FdiJwJ6l5jQAmQJlhbHk071M8ClonLDMQW8GbXdgHuzSnyywyRadMU+XGvdwptdC29leAe3JhRtvYXrzjnB4i6OFus6g8Ft9F78ufJabxNg1Jr+4xp/LMkhvuAvtcFQRJnBlGajrAmC3eFlG9YKTMX5RyrqNpJRFnj6CnYaATRntPEthvBUxRG9Hz/C5e4dinBfL68JSPahAQvV6k5TBdlEls7ZZVn8YIUunt24W9efACxKucuQuRWonQXl1GmQChLBWb4Lp1xL/nRxkA6sVp0XJuZVnMWjFY+mKflmaWz52/tyPlOwin3zK0S3ws8oXsSnhGvsBaEP1wqVFOo9YS8HLCnyx3PnA+p0ZrpRlbxCyPjUFDLR0sUBO6OL1r1m61j09SZCSmZUkmrxN24GGbKQ+tOqI54vyxLvaAGpSO1rpifMpGiHb/hq8X4vy+QIxG862WNy6BgaRXK5UF5yxcepCWYsU4vVkP00e7QF+GMcNbzSbmcJaxaQkOeDotVx5rIf6iMfjPmCeTsrEKrzWvISrMQvEEBiBdYEzEtioxCoZBMWkJC/uEmjSIxogiiXo9rqg/idGLbYLmGW4f4JvrbYTKtQMyaVqbi9WISYITJxZ2lsWFZe6+ioAQl/aF43hjVvpa0fJ/DaLDAWdhlT0CdjyBGgxZdPRCmH+ll1WEISpLaWGMGDVuFVWOmYXCXxUyPIgaTcxUrTyhbdo3OGeRjfg3/poWqZVgk38oeJw==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(36860700001)(7636003)(6666004)(83380400001)(508600001)(107886003)(1076003)(26005)(82310400004)(40460700001)(36756003)(336012)(2616005)(316002)(86362001)(426003)(47076005)(2906002)(4744005)(110136005)(70206006)(16526019)(70586007)(186003)(8936002)(54906003)(4326008)(8676002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 04:30:03.6712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a915042d-c290-492d-f3f5-08d9b3ba1470
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1778
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio device id value can be more than 31. Hence, use BIT_ULL in
assignment.

Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
changelog:
v0->v1:
 - supporting device id up to 63
---
 drivers/vdpa/vdpa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 7332a74a4b00..09bbe53c3ac4 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -404,7 +404,8 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
 		goto msg_err;
 
 	while (mdev->id_table[i].device) {
-		supported_classes |= BIT(mdev->id_table[i].device);
+		if (mdev->id_table[i].device <= 63)
+			supported_classes |= BIT_ULL(mdev->id_table[i].device);
 		i++;
 	}
 
-- 
2.26.2

