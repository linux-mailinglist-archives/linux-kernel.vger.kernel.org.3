Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E84C5A02B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbiHXU1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbiHXU1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:27:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8F06B14E;
        Wed, 24 Aug 2022 13:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFb7McElXTUwkqM+iYkbDMn0VH+o9Wr1fzqehOCQNoCu7n5Jv402dORXM4P/FnpIegHxGAKP3cYxF3uU/KK5W5tnh19GladERFO1KCxslm2+l9bu1YuJIbxcr8cyiIDbsRwkOG0aFBbM/Il/xd36qVpwrTRLnZ4GcMCrJ8BGF5hVxeeR+bE3l8YA7pITz/uSYBlii3TEDjlL8+LVnM2SUTJDLnZCFClVsUoTuOkPKjBUudbLujkzvUeHJIf69PcXtYmS+dru4TilFZ4WqLjomY4/1z0pH7DWUpGr7QtqCFEctJ9oN/9YWvQ4aXeGKpHV7tpETewM98NM/nL2ljwtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQz95jpSRaJgzH+g95ofGn3Iow/nWL+jZeN/D5y1eyQ=;
 b=DqAE4KSsWyWcm3et7zygT0rqy3MUidBCDKflihYCiYCCTm2ZGXTd+DLz6eNEGY+AQSav0A4EblDTwNhCJRREKevpoxNO6Sz6nZUETVaYjCf94NC3JN0LnsbBKtJSLyqA5q3aHvLL9cyba2iwG07+lUuNoL/EhUPOKzHfJHw5tJYxF3ubEkO6WG7CBhggZCTi6lbbqolsDjKuXvIP+K3BCw0U17cwU7KKNQ1lHjwhWXyIRwHGIrbREhzy5Rqn8jvlF7YrXE6v+2PZVRbYhvKEmpHiEdFamGi7i3G58nyUcQd+t4vWjFDk19kz9XbEEBjjZ5I1nvF3dLIGfhfMnMa18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQz95jpSRaJgzH+g95ofGn3Iow/nWL+jZeN/D5y1eyQ=;
 b=rWnwxjbIAsHo1yY7BOUDSq5j29epWvCwuSuCsvUjwQ9eGirOQpeUrCd7G9Njbk5nThgCpIzAbZGHSvZKb4s9EzHd4E3oUgtJuoOKzpvl3m6268A4UqgCKNwTjdJvfAXwfnn7804AD7xjTjUI2CsxOM4+Jh3xA8nm8k90LnI2rasqdB+rkPDP7k52uMqy9Da8x3Ev6Ul3RwhcG5iqNhqqil4N3nP3vSl7KFgj/dCzET0c31AwOn5lqy0VkAaj3LLnZSOwtWC8nWZBNAKADgoBc9/96AAITv74WfCWm2Dy2oPZGG1fwrQ7QbT2KGTIVjZWHh7TOvgEMlO+LH7welLYUQ==
Received: from MW4PR04CA0202.namprd04.prod.outlook.com (2603:10b6:303:86::27)
 by BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Wed, 24 Aug
 2022 20:27:27 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::7b) by MW4PR04CA0202.outlook.office365.com
 (2603:10b6:303:86::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Wed, 24 Aug 2022 20:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 20:27:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Wed, 24 Aug 2022 20:27:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 24 Aug 2022 13:27:26 -0700
Received: from build-petlozup-20220627T000321362.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29
 via Frontend Transport; Wed, 24 Aug 2022 13:27:26 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>
Subject: [PATCH v3] soc/tegra: pmc: Add IO Pad table for tegra234
Date:   Wed, 24 Aug 2022 20:27:23 +0000
Message-ID: <20220824202723.3340035-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5404fc92-ced6-4e7c-8c20-08da860f0f9c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3285:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Y7CbIIuBIFGQzmWlM5euT+BJT+YkglysafNu6tgAlbfFR3npaIgTRdJ18YoY2zc2ZEMJRWPGSg3wHjfj6oF2Q8CjxOA6hW3QCqJtwSN1TV77+LxAIt2a7SIvddjssJiAyGm53nW7r6ncAFNIpYDFHjj+Zpp2coYEZqm1QCTuEc6Z4r8mf6+Z8fdBGj/sQrD+W/fzm6Df23cTvdwqpV6cuHVmOoa4HmdFaUyaZUITrwAgPp1k19cNteUjJZSffdnPL1zQBaETQlYLwPvvheJnhZmsk2dGeiwpW9LZqe9bozTcH4Ug9DJRwjFH0Oc+Sjsvv6CRJju2BI5hDXqN36LIJqE3KtFq/rIon/b003cDVpapy5OidAtwjEcvZwht6+FHV1GEXQHTowgg1PyiQt7Cn7CIH1EvwDf/jyqcSN9b/nJfZp6pWBdto6h6tAEHuvl3ZICL0XK95NJzQLohD+L63ZfZNFFk7NIabOo8ORyNqy3LVpP5MvL8z4sz4sPDwIb8DhlHeQ7O2gFLFXxgBKRUM6ga9QlQDfbOnycwvRTf3SGuCI/4TDlSxbRbJUdGUEycrP80r2zfo0RquINjsNpo3qGlrIDj10OMntTTVjMZTbbr9QiJaWjrTwxB8ui8t1D8KK2E86smNBuLyIfB+zXDMbJffFCfBOqHukWcqP0zLpplnEmkSMeEfjn8/3HxfMIEGqAAb1KOBFubwu2g3uLiIPKt6issrjG6pUkjbo6V15c8f6KLbFwUGhpg+C465EVupq879CjlwKQKX/BQZo3+rtzYsjgIG8abXgmDAtxRpnXBGuqyGOsBETxIWpLm9ps
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966006)(40470700004)(36840700001)(26005)(40480700001)(478600001)(36860700001)(83380400001)(316002)(82310400005)(47076005)(2616005)(110136005)(336012)(36756003)(1076003)(186003)(426003)(82740400003)(70206006)(70586007)(921005)(4326008)(8676002)(2906002)(107886003)(7696005)(41300700001)(356005)(40460700003)(5660300002)(86362001)(8936002)(81166007)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 20:27:26.9645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5404fc92-ced6-4e7c-8c20-08da860f0f9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3285
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IO PAD table for tegra234 to allow configuring dpd mode
and switching the pins to 1.8V or 3.3V as needed.

In tegra234, DPD registers are reorganized such that there is
a DPD_REQ register and a DPD_STATUS register per pad group.
This change accordingly updates the PMC driver.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
v3:
* Update to make the code more readable and avoid using extra flags.
---
 drivers/soc/tegra/pmc.c | 163 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 151 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 5611d14d3ba2..495d16a4732c 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -266,11 +266,23 @@ struct tegra_powergate {
 	struct reset_control *reset;
 };
 
+enum tegra_io_pad_dpd {
+	TEGRA_PMC_IO_LEGACY_DPD,
+	TEGRA_PMC_IO_CSI_DPD,
+	TEGRA_PMC_IO_DISP_DPD,
+	TEGRA_PMC_IO_QSPI_DPD,
+	TEGRA_PMC_IO_UFS_DPD,
+	TEGRA_PMC_IO_EDP_DPD,
+	TEGRA_PMC_IO_SDMMC1_HV_DPD,
+	TEGRA_PMC_IO_INVALID_DPD,
+};
+
 struct tegra_io_pad_soc {
 	enum tegra_io_pad id;
 	unsigned int dpd;
 	unsigned int voltage;
 	const char *name;
+	enum tegra_io_pad_dpd dpd_index;
 };
 
 struct tegra_pmc_regs {
@@ -284,6 +296,18 @@ struct tegra_pmc_regs {
 	unsigned int rst_source_mask;
 	unsigned int rst_level_shift;
 	unsigned int rst_level_mask;
+	unsigned int csi_dpd_req;
+	unsigned int csi_dpd_status;
+	unsigned int disp_dpd_req;
+	unsigned int disp_dpd_status;
+	unsigned int qspi_dpd_req;
+	unsigned int qspi_dpd_status;
+	unsigned int ufs_dpd_req;
+	unsigned int ufs_dpd_status;
+	unsigned int edp_dpd_req;
+	unsigned int edp_dpd_status;
+	unsigned int sdmmc1_hv_dpd_req;
+	unsigned int sdmmc1_hv_dpd_status;
 };
 
 struct tegra_wake_event {
@@ -1536,6 +1560,7 @@ static int tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
 					     u32 *mask)
 {
 	const struct tegra_io_pad_soc *pad;
+	int ret = 0;
 
 	pad = tegra_io_pad_find(pmc, id);
 	if (!pad) {
@@ -1546,17 +1571,63 @@ static int tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
 	if (pad->dpd == UINT_MAX)
 		return -ENOTSUPP;
 
-	*mask = BIT(pad->dpd % 32);
 
-	if (pad->dpd < 32) {
-		*status = pmc->soc->regs->dpd_status;
-		*request = pmc->soc->regs->dpd_req;
-	} else {
-		*status = pmc->soc->regs->dpd2_status;
-		*request = pmc->soc->regs->dpd2_req;
+	switch (pad->dpd_index) {
+	case TEGRA_PMC_IO_LEGACY_DPD:
+		*mask = BIT(pad->dpd % 32);
+
+		if (pad->dpd < 32) {
+			*status = pmc->soc->regs->dpd_status;
+			*request = pmc->soc->regs->dpd_req;
+		} else {
+			*status = pmc->soc->regs->dpd2_status;
+			*request = pmc->soc->regs->dpd2_req;
+		}
+		break;
+
+	case TEGRA_PMC_IO_CSI_DPD:
+		*mask = BIT(pad->dpd);
+		*status = pmc->soc->regs->csi_dpd_status;
+		*request = pmc->soc->regs->csi_dpd_req;
+		break;
+
+	case TEGRA_PMC_IO_DISP_DPD:
+		*mask = BIT(pad->dpd);
+		*status = pmc->soc->regs->disp_dpd_status;
+		*request = pmc->soc->regs->disp_dpd_req;
+		break;
+
+	case TEGRA_PMC_IO_QSPI_DPD:
+		*mask = BIT(pad->dpd);
+		*status = pmc->soc->regs->qspi_dpd_status;
+		*request = pmc->soc->regs->qspi_dpd_req;
+		break;
+
+	case TEGRA_PMC_IO_UFS_DPD:
+		*mask = BIT(pad->dpd);
+		*status = pmc->soc->regs->ufs_dpd_status;
+		*request = pmc->soc->regs->ufs_dpd_req;
+		break;
+
+	case TEGRA_PMC_IO_EDP_DPD:
+		*mask = BIT(pad->dpd);
+		*status = pmc->soc->regs->edp_dpd_status;
+		*request = pmc->soc->regs->edp_dpd_req;
+		break;
+
+	case TEGRA_PMC_IO_SDMMC1_HV_DPD:
+		*mask = BIT(pad->dpd);
+		*status = pmc->soc->regs->sdmmc1_hv_dpd_status;
+		*request = pmc->soc->regs->sdmmc1_hv_dpd_req;
+		break;
+
+	default:
+		dev_err(pmc->dev, "invalid DPD reg index %u\n", pad->dpd_index);
+		ret = -ENOENT;
+		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int tegra_io_pad_prepare(struct tegra_pmc *pmc, enum tegra_io_pad id,
@@ -3291,6 +3362,7 @@ static const u8 tegra124_cpu_powergates[] = {
 		.dpd	= (_dpd),			\
 		.voltage = (_voltage),			\
 		.name	= (_name),			\
+		.dpd_index = TEGRA_PMC_IO_LEGACY_DPD,	\
 	})
 
 #define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
@@ -3791,6 +3863,61 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.has_usb_sleepwalk = false,
 };
 
+#define TEGRA234_IO_PAD(_id, _dpd, _voltage, _name, _dpd_index)	\
+	((struct tegra_io_pad_soc) {				\
+		.id		= (_id),			\
+		.dpd		= (_dpd),			\
+		.voltage	= (_voltage),			\
+		.name		= (_name),			\
+		.dpd_index	= (_dpd_index),			\
+	})
+
+#define TEGRA234_IO_PIN_DESC(_id, _dpd, _voltage, _name, _dpd_index)	\
+	((struct pinctrl_pin_desc) {					\
+		.number = (_id),					\
+		.name	= (_name)					\
+	})
+
+#define TEGRA234_IO_PAD_TABLE(_pad) {                                          \
+	/* (id, dpd, voltage, name, dpd_index) */                              \
+	_pad(TEGRA_IO_PAD_CSIA,           0,         UINT_MAX,	"csia",        \
+		TEGRA_PMC_IO_CSI_DPD),                                         \
+	_pad(TEGRA_IO_PAD_CSIB,           1,         UINT_MAX,  "csib",        \
+		TEGRA_PMC_IO_CSI_DPD),                                         \
+	_pad(TEGRA_IO_PAD_HDMI_DP0,       0,         UINT_MAX,  "hdmi-dp0",    \
+		TEGRA_PMC_IO_DISP_DPD),                                        \
+	_pad(TEGRA_IO_PAD_CSIC,           2,         UINT_MAX,  "csic",        \
+		TEGRA_PMC_IO_CSI_DPD),                                         \
+	_pad(TEGRA_IO_PAD_CSID,           3,         UINT_MAX,  "csid",        \
+		TEGRA_PMC_IO_CSI_DPD),                                         \
+	_pad(TEGRA_IO_PAD_CSIE,           4,         UINT_MAX,  "csie",        \
+		TEGRA_PMC_IO_CSI_DPD),                                         \
+	_pad(TEGRA_IO_PAD_CSIF,           5,         UINT_MAX,  "csif",        \
+		TEGRA_PMC_IO_CSI_DPD),                                         \
+	_pad(TEGRA_IO_PAD_UFS,            0,         UINT_MAX,  "ufs",         \
+		TEGRA_PMC_IO_UFS_DPD),                                         \
+	_pad(TEGRA_IO_PAD_EDP,            1,         UINT_MAX,  "edp",         \
+		TEGRA_PMC_IO_EDP_DPD),                                         \
+	_pad(TEGRA_IO_PAD_SDMMC1_HV,      0,         4,         "sdmmc1-hv",   \
+		TEGRA_PMC_IO_SDMMC1_HV_DPD),                                   \
+	_pad(TEGRA_IO_PAD_SDMMC3_HV,      UINT_MAX,  6,         "sdmmc3-hv",   \
+		TEGRA_PMC_IO_INVALID_DPD),                                     \
+	_pad(TEGRA_IO_PAD_AUDIO_HV,       UINT_MAX,  1,         "audio-hv",    \
+		TEGRA_PMC_IO_INVALID_DPD),                                     \
+	_pad(TEGRA_IO_PAD_AO_HV,          UINT_MAX,  0,         "ao-hv",       \
+		TEGRA_PMC_IO_INVALID_DPD),                                     \
+	_pad(TEGRA_IO_PAD_CSIG,           6,         UINT_MAX,  "csig",        \
+		TEGRA_PMC_IO_CSI_DPD),                                         \
+	_pad(TEGRA_IO_PAD_CSIH,           7,         UINT_MAX,  "csih",        \
+		TEGRA_PMC_IO_CSI_DPD)                                          \
+	}
+
+static const struct tegra_io_pad_soc tegra234_io_pads[] =
+	TEGRA234_IO_PAD_TABLE(TEGRA234_IO_PAD);
+
+static const struct pinctrl_pin_desc tegra234_pin_descs[] =
+	TEGRA234_IO_PAD_TABLE(TEGRA234_IO_PIN_DESC);
+
 static const struct tegra_pmc_regs tegra234_pmc_regs = {
 	.scratch0 = 0x2000,
 	.dpd_req = 0,
@@ -3802,6 +3929,18 @@ static const struct tegra_pmc_regs tegra234_pmc_regs = {
 	.rst_source_mask = 0xfc,
 	.rst_level_shift = 0x0,
 	.rst_level_mask = 0x3,
+	.csi_dpd_req = 0xe0c0,
+	.csi_dpd_status = 0xe0c4,
+	.disp_dpd_req = 0xe0d0,
+	.disp_dpd_status = 0xe0d4,
+	.qspi_dpd_req = 0xe074,
+	.qspi_dpd_status = 0xe078,
+	.ufs_dpd_req = 0xe064,
+	.ufs_dpd_status = 0xe068,
+	.edp_dpd_req = 0xe05c,
+	.edp_dpd_status = 0xe060,
+	.sdmmc1_hv_dpd_req = 0xe054,
+	.sdmmc1_hv_dpd_status = 0xe058,
 };
 
 static const char * const tegra234_reset_sources[] = {
@@ -3861,10 +4000,10 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.needs_mbist_war = false,
 	.has_impl_33v_pwr = true,
 	.maybe_tz_only = false,
-	.num_io_pads = 0,
-	.io_pads = NULL,
-	.num_pin_descs = 0,
-	.pin_descs = NULL,
+	.num_io_pads = ARRAY_SIZE(tegra234_io_pads),
+	.io_pads = tegra234_io_pads,
+	.num_pin_descs = ARRAY_SIZE(tegra234_pin_descs),
+	.pin_descs = tegra234_pin_descs,
 	.regs = &tegra234_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
-- 
2.17.1

