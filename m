Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC446240C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhK2WPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:15:47 -0500
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:17025
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231702AbhK2WNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:13:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjB1Xw11Btj+AOGpMvPUkJNCsLfJ3aw7g86VQgek8bUc/2HHkNxxuTTjYsKLtAmT/kSQwKfLbollOJ3dBAuyQhPBILvAinC4Q40xE0ZY/AR37+60MFZ7D2gUXEYIWzdjdWDfiBpAht54MkTlNRFJvJv+3AiLNuyr+svFnP+V/Qo/8FX8Hn6zSViUWgJbF6A2Xja+57XbcGIPJyxIbELA+5vlEM4OxbdoSwCU9nmopeeeHRZUz9oOvsFVLCUPFyaS69jAg6rzc/EsBGZE4yvi+nHiM+vbMLKyarJ7c9rCzfQGw84hTUev5wc9nLIO5uPxEIZofKHgWPanGCJckRXrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soj0x5uyE6Lb3ymsy7KV91m6aeS/EtauqvJ9f1mkmPU=;
 b=bjwM6I3cUWvlHmQMnjv2Xwfutj+rsJH2aHnwMKxG08iSKjp9BYPCtrW9cGa/b4tkrvD37OO3fR1SJ/T7OZk7EQXEs4gQ+8EBxZoh10jlmQo20UM3poVGnGTmH+9iuZ+h3LOFWgYPv3h3uR0HxyrDlWZ1N50R2+mXzqz6yH14yENQck9/SMoVUZfV9eHMwEdlBQA23orc9cLk4VzC+JXJScK5kvlyvdeeVWmPJa/pSCqseGRmngqjyoBvkCsIzFMllDaYwSZvk+R+K3aVMa+7T3w9MNUUATlewJ2D/svQyfyU8I4MOc07E0VnBWkDSTyTrfgvWMeXviIhZNvyNfHQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soj0x5uyE6Lb3ymsy7KV91m6aeS/EtauqvJ9f1mkmPU=;
 b=b5IenPUmMtb3fnzaWgmcyOown/li9f7gN+CeBd8aNzAHtMdrX6G8SjTY7BFGx98tCUVe6WwweEgzk7jPApJhhwRlt9KCAAfx9L5KEu5DTgho19f1qOFYjX+85Xyb+YT548rJ99LEPdPe4Pb03Uu45iW2xZONODwpsDo9qtGGnlM=
Received: from SV0P279CA0063.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::14)
 by DB7PR10MB1977.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Mon, 29 Nov 2021 22:10:23 +0000
Received: from HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::72) by SV0P279CA0063.outlook.office365.com
 (2603:10a6:f10:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Mon, 29 Nov 2021 22:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT031.mail.protection.outlook.com (10.152.10.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.21 via Frontend Transport; Mon, 29 Nov 2021 22:10:22 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Nov 2021 23:10:09 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Nov 2021 23:10:09 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 77A9B80007F; Mon, 29 Nov 2021 22:10:09 +0000 (UTC)
Message-ID: <cover.1638223185.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 29 Nov 2021 22:10:09 +0000
Subject: [PATCH V4 0/4] regulator: da9121: add DA914x support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b58db9f-514c-4849-f515-08d9b38509b9
X-MS-TrafficTypeDiagnostic: DB7PR10MB1977:
X-Microsoft-Antispam-PRVS: <DB7PR10MB19776C5A1CF4CCED50280BDDCB669@DB7PR10MB1977.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs/cQ25XYgoJddKdYK61yFELsrgi0IckJVtaZdjJRJm27n69Mg/vmPbtq4mnxRAZadXz0ZDgG04+szOMYiTTZL+l8Mj7YwD9xWEX6hlHQG3F1s1mSFqZn0Jn4WC/7pbjL+FdQT31gLUrbEv952O1fvfsrrFi21QUOEqxUyaZ2xmfRCt6QfR2nQqQtcU2VkLXhEPX7P5Zc2DAomp2XHZC7JZSv+7HbTqBWAxrVmc1NMowRUB6Xcw1TDXZR2jaJZi6e90jpZ6hP75ioWb1xem7zbStWoukUNz4aJzB/+C1tI/mohVTq7AGFmUeLxdBgcW6Zn2zfzPNkZoj0Bii1E3ZkWaSVfz610GlXbmruK5sKUSZomJXKCmSHFMhuMCmPt74rELCoa7/sKsWu43mZW2vLZYcwivwZSfliiXWXyHjtamL1uc4fAkk78PWimKb5YcWD20xsag/im7g4HAT0e2MFaxQZBFtzdcnsVzOOc175IHboNpWU+x/8Mr1sy4NSlFKuQIDwSkcsuu0RZ4ClYP7srQ/sQLQvuLKejGmUg4Ob7A991Fvlcv7rxw7CoU+R+ptPryEi8QDFQjt6i1iMUzvD2QF79m/MXf+ojApR1DkartwXziAvZ9ExPutfBycJi0cnUjAq5OgEcqUGQzafClHx6EnQgawbzePLckx8gMBkhYnBBvmHynxm0FQmwTSqk+/4Dbn87AH/ot2vcuunNEhBlqVHdLsPbak1mz4PlKihqg=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(36860700001)(47076005)(86362001)(82310400004)(83380400001)(70206006)(110136005)(107886003)(4326008)(70586007)(6266002)(81166007)(54906003)(2616005)(356005)(186003)(508600001)(8936002)(5660300002)(426003)(36756003)(42186006)(4744005)(8676002)(26005)(316002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 22:10:22.3961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b58db9f-514c-4849-f515-08d9b38509b9
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB1977
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends the DA9121 driver to add support for related products:

  DA9141, 40A, Quad-Phase
  DA9142, 20A, Dual-Phase

The changing of current limit when active is now prohibited, for the range,
due to possibility of undefined behaviour during transition

V2:
 - Separate removal of obsolete/unused test compatible from binding

V3:
 - Fix binding update
 - Improve patch titles

V4:
 - Fix build issues
 - Split off current limit protection to a separate patch


Adam Ward (4):
  dt-bindings: da9121: Remove erroneous compatible from binding
  dt-bindings: da9121: Add DA914x binding info
  regulator: da9121: Prevent current limit change when enabled
  regulator: da9121: Add DA914x support

 .../bindings/regulator/dlg,da9121.yaml        |  76 +++++++-----
 drivers/regulator/da9121-regulator.c          | 113 +++++++++++++++++-
 drivers/regulator/da9121-regulator.h          |  21 +++-
 3 files changed, 173 insertions(+), 37 deletions(-)

-- 
2.25.1

