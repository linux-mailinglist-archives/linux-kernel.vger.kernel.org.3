Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2476758A98F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiHEKmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiHEKlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:41:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3368A6D554;
        Fri,  5 Aug 2022 03:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxnF1RxGUwMDhzTs4nhTFDAAyXHEwMJe0PnqIIXwT3k79rbykYhtVBZxJww/3Ms760TtA04vHKwTn5KtmnVXvtdJk2Qs25USXYAylOtK52ocdqZng6AtcFpqu1FvYe0Z+IWhYJK6/4g23L5oQPgwWEv4itbGaDblvlFDeoV5coDS8w3FN6howkx9mG+KRKbE7W0xiLg9jI/ZDNSqlgC/9B5uKW+MaRkUgXWF8kpBRiAcFRYILisTCaQXj+HIsYMQaOjgQsjb5xh2lH+3VQSVTefsrnCZ6ikC+/xRVkZSSQXi7DE+n+s6vF/giNx5vip7twhXz0oWDfYUQy8gH+oSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=citX6S8zuMzc1Lvq7ORAg4xm+IUkRpyOXMZ6SBuzdzg=;
 b=QKPUCvtHIepCbwpsBrQ7fmaiqwoT50CsrXkYiwHdswdZE53r4UgJneKSsrPEnIaHxuPQp8L85bWteEGx2329HHSCmKjkKWaEgDjYfK245SAsYAhVSJmcDnvehurQ/433qoPf8BoDkui+o6ZUywzHGNEyIAagsC1CjpGPdABSPAKnPc9UoM2N6Tt4pk/KhUoRyGyKwjZAtgXvQyYDwfbR0qyNYzvFRsRF7WVc+Cy0lA7L5A9wHwd0DYyGMs8MEsypwQky31v2LmZU9bbBTk1kxnXclBthnBvwOtyGgZ+08ZfvdA3ox5BTGaEq99p+tY0V0RbhBWCePhpTP8S4lH69jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=citX6S8zuMzc1Lvq7ORAg4xm+IUkRpyOXMZ6SBuzdzg=;
 b=s0hjUDjYf0vZ3nQQp9XCDkdEXXD1+hYJ7oGXSBYHtFC4/QMJn9XkbRPVKn5y/+FYhyhKJziXVXzJnTiQCDlZzRb4RLd7m48ubTtpztKMSWK1GuY8q3IqBKmjI0PQmpou1g+xBqLKGefZiRa5mZxrv9v3l5+SWsClhpFMPpsz1Bta41OVnD+Kerq07tcwP+r+vTVZtJBdbQjJQgi6y4nKHeVOVHy+rVZQbDw8NYHQLTcomAHz0zw+ltcD8r0jWPkjIwzKsiTI3HvgDQUXUvhKgIzU5MlzcGh0QUOllVun2/tUKeOEtknz2P5PATNMJ1g4To6dfAKo5itOU3Jc4BEPXA==
Received: from DS7PR03CA0287.namprd03.prod.outlook.com (2603:10b6:5:3ad::22)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 10:41:49 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::6d) by DS7PR03CA0287.outlook.office365.com
 (2603:10b6:5:3ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Fri, 5 Aug 2022 10:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 10:41:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 5 Aug
 2022 10:41:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 5 Aug 2022
 03:41:47 -0700
Received: from build-petlozup-20220627T000321362.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via
 Frontend Transport; Fri, 5 Aug 2022 03:41:47 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>
Subject: [PATCH] soc/tegra: pmc: Add IO Pad table for tegra234
Date:   Fri, 5 Aug 2022 10:41:00 +0000
Message-ID: <20220805104100.3098200-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7aea471-a5ae-49cc-542c-08da76cf19e4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4Wx+BRbjkIOjq9ddT4PCak4/FvOMV1wF2fCNb/fLF7kpG+K5jm5XsokdLY8r7Tfaa62Guz9puzSs/w5F9tKqYv+yLoeCuWGvE8xSZiHXIQfR46C40fgObFVLJrsq1B8cCltArXvTEzA+TxKYh2ScD+Qrf6dsM6UYIzQIMBmaR18ltIs07U4Xbxe24rmXFBO+eagNw2UpqIrQdkeQtdlvYus43l2wqQgG/gk6g5kuh/anrSLqeyq8xKLNpek5QP8xWSi3pEGJe+8rqIZ/U+9LVp4ZTqe/QUFmOAu3L41UuIODsce8Juvi51FJOAihtJobSczzuwc8ANav9dIVtNxPH6l0sq5RdMBUnptgN6/hFzOiwAuLMDdwIOqEPoiHTnHAq/VAvpGEKr3kEECNoK8sT2LuKceGUazvVQDLSbMYvfGOR47XQ6/b4k2CQeNrDnGodA5GyfHpF4Aa14SGLrpdks0OSp5KsH6Cv0v/NTueRuK+vQSDL6xoRylZbYxGq7sr/BiViJKXVB3QfC1rQu2U3lFnLmnzH4wFiN2Usc/0M3yuIU+jiA4sGKaXC3ZWRKZWzSSCfTvUUR9moJE+darRx4DObCVVEQ0YbTInJN4boUpMbMIbkOjG+MgE79v+edec/nxLg38w4PmjtmRjrz6V2Uz8efmI+dJG7D4QiITFEc80IuMYjSNyJUg+iAwpdlHkSo4ttFC6hYd6YgaVve14hJ9Ac1dhewiVtc0pOjFf7MYshecbbgDVh0R6W0bVZ6bcHg+orPd3dEnUgz4LpVLjC6COLwQBcI3LpRcVBE3/rTPFiozW1iRmL69w2uVQVmDR5+82DhExfleaPvpnPJH2nImn0HsSrxIa9MviOzF1bM=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(1076003)(41300700001)(7696005)(186003)(426003)(26005)(6666004)(82740400003)(336012)(921005)(81166007)(356005)(2616005)(36860700001)(107886003)(82310400005)(2906002)(36756003)(40480700001)(8936002)(5660300002)(70206006)(86362001)(40460700003)(110136005)(478600001)(8676002)(4326008)(70586007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 10:41:48.9954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7aea471-a5ae-49cc-542c-08da76cf19e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/soc/tegra/pmc.c | 116 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 112 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 5611d14d3ba2..6d666fd0370d 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -266,11 +266,22 @@ struct tegra_powergate {
 	struct reset_control *reset;
 };
 
+enum tegra_dpd_reg {
+	TEGRA_PMC_IO_INVALID_DPD,
+	TEGRA_PMC_IO_CSI_DPD,
+	TEGRA_PMC_IO_DISP_DPD,
+	TEGRA_PMC_IO_QSPI_DPD,
+	TEGRA_PMC_IO_UFS_DPD,
+	TEGRA_PMC_IO_EDP_DPD,
+	TEGRA_PMC_IO_SDMMC1_HV_DPD,
+};
+
 struct tegra_io_pad_soc {
 	enum tegra_io_pad id;
 	unsigned int dpd;
 	unsigned int voltage;
 	const char *name;
+	enum tegra_dpd_reg reg_index;
 };
 
 struct tegra_pmc_regs {
@@ -284,6 +295,8 @@ struct tegra_pmc_regs {
 	unsigned int rst_source_mask;
 	unsigned int rst_level_shift;
 	unsigned int rst_level_mask;
+	const unsigned int *reorg_dpd_req;
+	const unsigned int *reorg_dpd_status;
 };
 
 struct tegra_wake_event {
@@ -364,6 +377,7 @@ struct tegra_pmc_soc {
 	bool has_blink_output;
 	bool has_usb_sleepwalk;
 	bool supports_core_domain;
+	bool has_reorg_hw_dpd_reg_impl;
 };
 
 /**
@@ -1546,6 +1560,14 @@ static int tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
 	if (pad->dpd == UINT_MAX)
 		return -ENOTSUPP;
 
+	if (pmc->soc->has_reorg_hw_dpd_reg_impl) {
+		*mask = BIT(pad->dpd);
+		*status = pmc->soc->regs->reorg_dpd_status[pad->reg_index];
+		*request = pmc->soc->regs->reorg_dpd_req[pad->reg_index];
+
+		goto done;
+	}
+
 	*mask = BIT(pad->dpd % 32);
 
 	if (pad->dpd < 32) {
@@ -1556,6 +1578,7 @@ static int tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
 		*request = pmc->soc->regs->dpd2_req;
 	}
 
+done:
 	return 0;
 }
 
@@ -3132,6 +3155,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.num_pmc_clks = 0,
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_reorg_hw_dpd_reg_impl = false,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -3193,6 +3217,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_reorg_hw_dpd_reg_impl = false,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -3250,6 +3275,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_reorg_hw_dpd_reg_impl = false,
 };
 
 static const char * const tegra124_powergates[] = {
@@ -3367,6 +3393,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_reorg_hw_dpd_reg_impl = false,
 };
 
 static const char * const tegra210_powergates[] = {
@@ -3497,6 +3524,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_reorg_hw_dpd_reg_impl = false,
 };
 
 #define TEGRA186_IO_PAD_TABLE(_pad)                                          \
@@ -3654,6 +3682,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
 	.has_usb_sleepwalk = false,
+	.has_reorg_hw_dpd_reg_impl = false,
 };
 
 #define TEGRA194_IO_PAD_TABLE(_pad)                                              \
@@ -3789,6 +3818,82 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
 	.has_usb_sleepwalk = false,
+	.has_reorg_hw_dpd_reg_impl = false,
+};
+
+#define TEGRA234_IO_PAD(_id, _dpd, _voltage, _name, _dpd_reg_index)	\
+	((struct tegra_io_pad_soc) {					\
+		.id		= (_id),				\
+		.dpd		= (_dpd),				\
+		.voltage	= (_voltage),				\
+		.name		= (_name),				\
+		.reg_index	= (_dpd_reg_index),			\
+	})
+
+#define TEGRA234_IO_PIN_DESC(_id, _dpd, _voltage, _name, _dpd_reg_index) \
+	((struct pinctrl_pin_desc) {					\
+		.number = (_id),					\
+		.name	= (_name)					\
+	})
+
+#define TEGRA234_IO_PAD_TABLE(_pad) {                                          \
+	/* (id, dpd, voltage, name, dpd_reg_index) */                          \
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
+/* Reorganized HW DPD REQ registers */
+static const unsigned int tegra234_dpd_req_regs[] = {
+	[TEGRA_PMC_IO_CSI_DPD] = 0xe0c0,
+	[TEGRA_PMC_IO_DISP_DPD] = 0xe0d0,
+	[TEGRA_PMC_IO_QSPI_DPD] = 0xe074,
+	[TEGRA_PMC_IO_UFS_DPD] = 0xe064,
+	[TEGRA_PMC_IO_EDP_DPD] = 0xe05c,
+	[TEGRA_PMC_IO_SDMMC1_HV_DPD] = 0xe054,
+};
+
+/* Reorganized HW DPD STATUS registers */
+static const unsigned int tegra234_dpd_status_regs[] = {
+	[TEGRA_PMC_IO_CSI_DPD] = 0xe0c4,
+	[TEGRA_PMC_IO_DISP_DPD] = 0xe0d4,
+	[TEGRA_PMC_IO_QSPI_DPD] = 0xe078,
+	[TEGRA_PMC_IO_UFS_DPD] = 0xe068,
+	[TEGRA_PMC_IO_EDP_DPD] = 0xe060,
+	[TEGRA_PMC_IO_SDMMC1_HV_DPD] = 0xe058,
 };
 
 static const struct tegra_pmc_regs tegra234_pmc_regs = {
@@ -3802,6 +3907,8 @@ static const struct tegra_pmc_regs tegra234_pmc_regs = {
 	.rst_source_mask = 0xfc,
 	.rst_level_shift = 0x0,
 	.rst_level_mask = 0x3,
+	.reorg_dpd_req = tegra234_dpd_req_regs,
+	.reorg_dpd_status = tegra234_dpd_status_regs,
 };
 
 static const char * const tegra234_reset_sources[] = {
@@ -3861,10 +3968,10 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
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
@@ -3879,6 +3986,7 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
+	.has_reorg_hw_dpd_reg_impl = true,
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
-- 
2.17.1

