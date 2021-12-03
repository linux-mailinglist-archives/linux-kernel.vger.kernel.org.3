Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A11467F44
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383266AbhLCV1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:27:51 -0500
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:14113
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1383199AbhLCV1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:27:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5/y/7c0jNzW9MSlOIsDbSivc0XwROuvjOIf4GbYnHloDWRIjPYb1CxVNh76mtxAZTryzuUueRpFrq5JNWOZv5oPYeS3cwPOE+G7ycfHRfQSGyEZ56KmuU4jt/4kFn7e8DI+vynQwyB7DJXH1V2d5FsMm8rSqMAE92Mp2Rs7lWgjlDZ8OxpnNF1uqNOXFP0vbNJujpOiiit3+Y5Ws07BzdwYQd2jc3rlbp1Rf6zatDik9XL19m4LcoDEj/4uC5+jPGNsMO04hS/YFCp2ygmvQywCiitXrmiWwrShyghnopGJmL933K8ySgHtXjkEJh2o3SuvZ92JOX6/+nNY5HyBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=my1jnLT6TU7SwBAdjPq4jOjjxnFQpEyXvE7/nxVtu3M=;
 b=PkJJe24FL65OMLnum/FHyJ1oMm2dT0D7tJgjLiC1WJ+HVtAC0B68vZYL6ubFGLGCyA3SiKLxhMA9OqNiUYd+LYtsLiqrUjBoBch2NTEl+jLUBQWtH/ATnq4xz7Um/A159PgB+dOBhdjuNBYNFxT5uQhoGX1HcdNY8jdgTxyPX2DxgiNANZMMLcGZOgdDtJt7ggBsnyEIv3u3Wz4s2wFXcSeizIyuSyYc87rAi/r5f1F542xyxKWv9RkZqltwkSYcRCl9TrEqH5eGxChJkF+lxTD1FjflRQEKwAVhXFlhnGAfplIPIUB8ViUzw3t4YrCnIxc3WlFYftfRqJo1lkEjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my1jnLT6TU7SwBAdjPq4jOjjxnFQpEyXvE7/nxVtu3M=;
 b=H1307kaGvPHrmW+CC1NXavjbhhoGR39dUmKUR6RrdhXm1JrukNzZBiAUMiLq6vkeTNblB0WG83W4gRZF4nAEdAjW81V8XvQZV66VSusoeoJjW8KHfF//fiLrCwRATyqGvLZHlULjPbaylvQc3VHxml7vsXTg0IvO36WJbR9/+uE=
Received: from SN7PR04CA0032.namprd04.prod.outlook.com (2603:10b6:806:120::7)
 by DM6PR02MB5964.namprd02.prod.outlook.com (2603:10b6:5:157::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.15; Fri, 3 Dec
 2021 21:24:15 +0000
Received: from SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:120:cafe::fc) by SN7PR04CA0032.outlook.office365.com
 (2603:10b6:806:120::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Fri, 3 Dec 2021 21:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0034.mail.protection.outlook.com (10.97.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 21:24:14 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 21:24:10 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 21:24:09 +0000
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michals@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 linux-acpi@vger.kernel.org,
 heikki.krogerus@linux.intel.com
Received: from [10.71.188.1] (port=14741 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mtG2C-0005F8-CD; Fri, 03 Dec 2021 21:24:00 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michals@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v12 5/5] MAINTAINERS: Add maintainer for xilinx-ams
Date:   Fri, 3 Dec 2021 21:23:58 +0000
Message-ID: <20211203212358.31444-6-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
References: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8782428e-5c48-4c13-c8b4-08d9b6a341fa
X-MS-TrafficTypeDiagnostic: DM6PR02MB5964:
X-Microsoft-Antispam-PRVS: <DM6PR02MB596423C0C7A67C54E33BAF0EA96A9@DM6PR02MB5964.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlkeh6e50w7hYDsYb4Q8+ncoS0HZyu4hiYT4nnPehott3d0gXnuJGlAIsWc66YoMuytRgmolNOl34jt7i/amkXn73nKgBO7eptuEt9gFLJyCGgsj3QcrqoOB7fZr9uqcJlUNT7F7sEB6Odhkt3nt++I4DyVlfv4PmS+xmE+ClxU4EQYH59UN/XiHhN2SAyjfUNqgUFPvYdLurQkbiOpsvJAsjF6GbeqEEwRA0Q0hqTcYAYspuZ6hauenKBivdEzdmLsq787ElO8SPYRwdmoBHs5uPyLfewAuEhe5MPkxdaVrCOaywPmR+b/hgS4M8azhvj95P5KN6opTdWmH7QLA+/YDb2UsyGokhsraeyiCqxRU7yeC2pNqwuFstebE8AudPTAEwZDFHJN3+wGE/FQTIyvz8ibJi7JuiJ2ayzus+RFiM3VkeWLFqJ4BDlF4Bds/6/L3BaiAPS61UFflUFeQ+3bWvTowXYnd2hho6CijJiXA79zjCES5R6a432dh6ER0z9rkQTNChAHOxp2Cw9k43UFSBKkGl/Kuwggfac6RGgxCj1zWiUxh9XjCHd4QwgvIKqDdQfLTtPasuBRX7OdvWUCjj/J3gjcI34cAB8msu8qIIPbnRP39lJKj0DtcdrLfsLVekijUQC9e3mZylb0K0aoyOmuWaiUbOfjxcIm1EV11eCS3adFh7Z1R3rOPYuyvDcn1PBGGgnSoHCfpGY4l2Q8Z1+AHp7nHNzSd/sWS4wjW2V6WgpUf2ao26Ys/2GG4HKrtUX/KL9a1/073HEPE8vbWlTebgZ9vUUgi0n7AgqA=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(70206006)(2616005)(70586007)(107886003)(47076005)(4744005)(186003)(26005)(2906002)(9786002)(8676002)(508600001)(103116003)(8936002)(336012)(426003)(82310400004)(7636003)(1076003)(356005)(110136005)(5660300002)(4326008)(316002)(36860700001)(921005)(36756003)(7696005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 21:24:14.9858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8782428e-5c48-4c13-c8b4-08d9b6a341fa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5964
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintaner entry for xilinx-ams driver.

Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..64d6a06b22f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20862,6 +20862,13 @@ F:	fs/xfs/
 F:	include/uapi/linux/dqblk_xfs.h
 F:	include/uapi/linux/fsmap.h
 
+XILINX AMS DRIVER
+M:	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
+F:	drivers/iio/adc/xilinx-ams.c
+
 XILINX AXI ETHERNET DRIVER
 M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
 S:	Maintained
-- 
2.17.1

