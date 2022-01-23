Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE844970C9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 10:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiAWJsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 04:48:30 -0500
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:62784
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235974AbiAWJsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 04:48:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKIFo9h0mAGV9jxEKn34gVT58BbC14Kxu0PHrah6vxDTNfLnbgMLkCp6vsmxcNdiuc2A43NwMe0bLHZQmBMevy2pG9xEtz9EybtCUTkLkpH9uU9T7+3NuNkye2baHFerLS1z4ELMjzXL7vyzXcBJQTNrCixON8OQKEaFzR6sZC2AVjn0OW/X0GZvO3GWQ2aOok+yLZqlKMCY0bNZNRfsRU0dWbEIjq/AhO37FLuRTjStmk5oxrAJHB4G3G3rnWyTC6HsiPOysucoMshYbiTukbRWgznep0kofu7YVB2tAqVviwfyWqq+IrMFsVG8mufyBX7XU5pDbOJtydJlkpFv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVIPrBrkgmSchQG/nRiU0fxiSFlbnrJOu3wewXaT6Lk=;
 b=OAyQPdQ6MF9yej7WJBP/TCKID77gDEDYNQmqK9ghp81QQC5G24UiWD+JnqA2jlyiBYM5w2/Md0f0ykbzDJob88FK0twbNEGNl06ExD1vOCTFHDSONQPVmdUg+kY2Stt/gPpHuad4Gd9FgRVQ6giKmzEUpxgrV3jadLHQxip8WpkmrN+oVkq8rewTifCcDdY9NfUGg3zLbbjFIBxIUB0V5VGhnIrG0lJ8nJNX4FqedXmadlbbLLsuDqBk4wwWI0yT1gVRw8Qje25W/oX2ZZAtD7kvfJuZSIBzj5G5Bjsgh7cUPbNKBgTT2pDthqOnjylgqfiiatqNfgxcKRrriIWtAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVIPrBrkgmSchQG/nRiU0fxiSFlbnrJOu3wewXaT6Lk=;
 b=iHNEzaEx9TSxcpXaLaHNj4lNmVjy/qoAERDLMplNJ4bBVCBsJSdb4shSFbcZQvvGkXMRqbLHb9dufV2HA4b+9riiYVMuqpTM3SLvOh5tHUaq5Nsrky+mCVPVswoFcYGd0JMO3QYwHwVP2wvn3LbjcIJPwUwTmmcm1LClKmXF40U=
Received: from BN6PR17CA0053.namprd17.prod.outlook.com (2603:10b6:405:75::42)
 by BY5PR02MB6370.namprd02.prod.outlook.com (2603:10b6:a03:1b3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Sun, 23 Jan
 2022 09:48:19 +0000
Received: from BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::e3) by BN6PR17CA0053.outlook.office365.com
 (2603:10b6:405:75::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Sun, 23 Jan 2022 09:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT049.mail.protection.outlook.com (10.13.2.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Sun, 23 Jan 2022 09:48:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 23 Jan 2022 01:47:57 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 23 Jan 2022 01:47:57 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.15] (port=60078 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nBZTZ-0001bj-2M; Sun, 23 Jan 2022 01:47:57 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH 4/4] MAINTAINERS: Add maintainer for Xilinx ZynqMP SHA3 driver
Date:   Sun, 23 Jan 2022 15:17:07 +0530
Message-ID: <1642931227-20706-5-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1642931227-20706-1-git-send-email-harsha.harsha@xilinx.com>
References: <1642931227-20706-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36784839-fdb9-4eb8-ac4d-08d9de557c67
X-MS-TrafficTypeDiagnostic: BY5PR02MB6370:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB6370DC9174ED721322E2BF71DE5D9@BY5PR02MB6370.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQqWgy1yfltnZrVc53TTlbYycDyd7geYzm6keG3BzrtZpFqL2JmC3ML4KGOruoCbZ+3Ka83eND/LIKb3ma6v0jN3ulpHoj3Vtk2Xu1Ulko1z3WwJPyXxPzVmwEt03snS0BpkMiNCmtJ9BOsXoDiI9igv6a4jOGuaO77JbZwy87F73pZkq8CVAb9g64h65JyE54TMxqt3fMHY8F9ibFgCiD1fD5znjZrDX5Dk8xnk3hHF0E7zAmcB1luzz7zAc4jm1U99FhK3NxTP7n/VtS5bxtRubw7mO36RqfID/C9sQt/8if8IOtIyv5q9e8lIGeekMXE5F8CPc60SjgfhlD26oJOYyuQNt2kY3jspXPMWD7sSzZ7UV/zCmLcxf6KXCAkUB18Zhdp/fkYE6ZNcjBqoiHUJov/F6ZAaVI+NsCI20DZmrl1HUchYmDitb0KAumADX4ECqHmG/iT6SH3+10wAY5wr/S4neNvMXDtjatXFt1EU1k3YCC4ajGjw7Zd3bF9jbGxV8MFVYS8Z50XHon+fUnkqoUr/oktnqsuUtrAhFRP4mZ7mTAFtbUHJR+bnELKaOfpkqmB5zx2SdNXUKTYri7MGiS2lMsS3WveqKYPe2ILaeVLfswR9i6fQWxUsfbqWbMrVYoTIOBH+TOn7ElCzbHpV7BvL5+ppuL7p92gP7cclo3QpbpFtsvw5TOpwIE9wkW/CRyiZrHZ+J8MgZ5/pUQB924iEytyKZWggvHfMkcFkuYqsKKtqhIat473GrlTEQ1P8dgME1hWk+v4VEPOcHHwtTqLxK/2sP4Z5ZJuNjh9gvj/51tWfAiRBFZDC3lpC
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7636003)(4744005)(356005)(966005)(2616005)(8676002)(426003)(8936002)(6666004)(186003)(316002)(336012)(36756003)(26005)(47076005)(9786002)(110136005)(54906003)(107886003)(7696005)(36860700001)(82310400004)(70206006)(5660300002)(2906002)(70586007)(4326008)(508600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 09:48:18.8985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36784839-fdb9-4eb8-ac4d-08d9de557c67
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6370
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an entry for ZynqMP SHA3 driver in the list of
Maintainers.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fb3a88..cf2da60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20931,6 +20931,11 @@ T:	git https://github.com/Xilinx/linux-xlnx.git
 F:	Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
 F:	drivers/phy/xilinx/phy-zynqmp.c
 
+XILINX ZYNQMP SHA3 DRIVER
+M:	Harsha <harsha.harsha@xilinx.com>
+S:	Maintained
+F:	drivers/crypto/xilinx/zynqmp-sha.c
+
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org
-- 
1.8.2.1

