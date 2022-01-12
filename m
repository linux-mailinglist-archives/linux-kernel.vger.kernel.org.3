Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC64848C551
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353807AbiALN5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:57:11 -0500
Received: from mail-sn1anam02on2049.outbound.protection.outlook.com ([40.107.96.49]:45894
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353790AbiALN5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:57:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXvihsBctMKhEgToy4MIG5khuOY4uixuZu2V/6pmnapomvvaPiwz+TayvksGCCayP9h027l/Yxk27lcyr4rbBaKJNkXJBLtDZQy/Xv1cqB/Y1g50F04Mm27PKn82nJm/7lPaSU7LF6Ag5Rn6sUD/An8wVXJcZuO2gDw8NfNUtDUN7CuJPsndfkS5ZcEP1KOGXq8wE1bsalLBn56jK3oajW/i5yXAR/IDcSoXA62YUhE0psDlkF+sGslHyrSpGVAevXvvK3YknPvGSAZpiGfTJ95NMbCFDrGUL45i2EdRPJAM1A2fD/H+zan7Dx7YYCwYPUshblThKH+bKtm8+RkIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwKoqySPkmm92p7j1sj/oCLbqIYXFNP6utVZR+6lZG4=;
 b=YEVqX+46Sg4UBrKfYiOCmNqDJALmy2lguv81t9V1RnokMaSMY7zwh5Cn0r06cwgEN1M9iKjIbloyK2MtCNUARMtg7Stx+ZNoo+QPfR3koJYfdCIF8vfeW5TyVAflsjQwDgBWGup89mMa1YNaDl55ttjPxPO02QOqxcQQ5bMkLa8Hp7NZPv3L+CEOcQPmaT93AkLPBjfcvjdf43lBOEJQriDkeBtlxoiYedKjO1u5XoM91w9cppu+rdSTEpyD12zFTOnAmMOsUbODDGDz52cmv4+3lfFv9GreIjvkeQHFKEYRQLpUKeGUBmtgk5P90ZWzvHDsawWdHAin275mcU2GYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwKoqySPkmm92p7j1sj/oCLbqIYXFNP6utVZR+6lZG4=;
 b=qCmVJiyP6XzWQXR6JssWUdrTwcrVc/yClmdSGnSz644y17wMvI4NwQrhEMJc2q0q+WAvuHJUanFtcmcRRdbH6i2RJxoqs4aQ5bVcWeLRWOGFiFjCudUzDSapa/vRDjyKZMx+ebP5JD3ksxdVOKf0fDqW/1QuKdqMXE9HXcBJWYQovF3PHqPDdHqQm5YqfCWEZTVdMs4TC6QMzus2dOoXJJV8gVzdHyi9b9td7S1mbDnop93YvdO1nLeBjw7/pgcsLNab56sGwd809nkNwDhU0v4w2umObA1UMbbK94MMDjm4OM7eCqv8Izb6khoe0FOqSJUQ4wu7kT4hiuMi3jllrA==
Received: from DM6PR01CA0029.prod.exchangelabs.com (2603:10b6:5:296::34) by
 BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Wed, 12 Jan 2022 13:56:59 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::bd) by DM6PR01CA0029.outlook.office365.com
 (2603:10b6:5:296::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 13:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 13:56:58 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 12 Jan
 2022 13:56:57 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 12 Jan
 2022 13:56:57 +0000
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 12 Jan 2022 05:56:55 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <p.zabel@pengutronix.de>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mperttunen@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Sameer Pujar" <spujar@nvidia.com>
Subject: [PATCH] reset: tegra-bpmp: Restore Handle errors in BPMP response
Date:   Wed, 12 Jan 2022 19:26:46 +0530
Message-ID: <1641995806-15245-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73d1371c-9349-4241-0028-08d9d5d366a3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27905918ED19BE4F729E2092A7529@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:308;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SUNNwDToedPfwF+SVNGyx1yvLIvcUAyuIQPnwVnz2aRyMTX/XJk+1zeJPzSWcdu9Vn+oBD5+Nqlm0Si7YnSqPxjfVFhP0WRK8aSbV4kuJ/+tj+kWTJSwj7F2edxV61kZHeZZ2u2bvP5GrVDY8xzqn3rIGfzkgb3xwdvIQ40QHyqk1r8el3cqz8ESa6OUAA19wMJlIxr+vmcEp3H+RYjDCu87gi2XUdR4gvb3EQRuTSjjJm839BwOhNOplWNYJw9I0t9f8Z7lGQOC0+CtO/7ZGZ6KmfBqb7NtUPIF8fmmkib+0f+DhtyXIv6JGSGKYTu/dR4Mw8wL3621QnVyZPsHSfNCzzzuPlsVyBcj67GtRgpktvbbM4Kvv16OlWWJoXSVIzTtEFuY2vzI/+VPQgvP8Cvk2GSNJqNd5K5386MCVkAKPt/ZczNBvrRAIRHNAQQyGdEkiMfeB/os+Z3prj0KRwqHrcho92cPJ/X6HD92wNo80BaJXLg1APcgUbYbkmZcVQ1OR5N/klss2kL05f5e7QZpouqUefpUy7MCEC/9r15IjzAd1lgIrAE7AXvw+uObIn4EA9l27HwgnyJs/dRCPwv59o08uEF5BSohVyVUR9qxwqk7yyfgsJkxGTtGmrY/ihjAPhE95nRN63onJ3vXRcdfNlfrkrIQp3ygJH+9y4HqSC9bFq2+8+IdJuejqWNeD/uOTfnC7Tf71m38+PJQXxnMriouvkl5f+buPWv03S6yxcc+NMsaOcQnpRkAnD7qBsaVkZV+0OG/+TShp+Pu5c/XGg6+0ybXHlXpVBqUss=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(7696005)(6636002)(86362001)(8936002)(107886003)(36860700001)(83380400001)(336012)(70586007)(508600001)(6666004)(70206006)(40460700001)(2906002)(47076005)(5660300002)(36756003)(426003)(54906003)(81166007)(110136005)(2616005)(8676002)(316002)(82310400004)(26005)(4326008)(186003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:56:58.5160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d1371c-9349-4241-0028-08d9d5d366a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts following commit 69125b4b9440 ("reset: tegra-bpmp: Revert
Handle errors in BPMP response").

The Tegra194 HDA reset failure is fixed by commit d278dc9151a0 ("ALSA:
hda/tegra: Fix Tegra194 HDA reset failure"). The temporary revert of
original commit c045ceb5a145 ("reset: tegra-bpmp: Handle errors in BPMP
response") can be removed now.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/reset/tegra/reset-bpmp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/tegra/reset-bpmp.c b/drivers/reset/tegra/reset-bpmp.c
index 24d3395..4c5bba5 100644
--- a/drivers/reset/tegra/reset-bpmp.c
+++ b/drivers/reset/tegra/reset-bpmp.c
@@ -20,6 +20,7 @@ static int tegra_bpmp_reset_common(struct reset_controller_dev *rstc,
 	struct tegra_bpmp *bpmp = to_tegra_bpmp(rstc);
 	struct mrq_reset_request request;
 	struct tegra_bpmp_message msg;
+	int err;
 
 	memset(&request, 0, sizeof(request));
 	request.cmd = command;
@@ -30,7 +31,13 @@ static int tegra_bpmp_reset_common(struct reset_controller_dev *rstc,
 	msg.tx.data = &request;
 	msg.tx.size = sizeof(request);
 
-	return tegra_bpmp_transfer(bpmp, &msg);
+	err = tegra_bpmp_transfer(bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static int tegra_bpmp_reset_module(struct reset_controller_dev *rstc,
-- 
2.7.4

