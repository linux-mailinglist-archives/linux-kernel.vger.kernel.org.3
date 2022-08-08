Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0058CEF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbiHHUPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244126AbiHHUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:14:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E273F1A076;
        Mon,  8 Aug 2022 13:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir/Di241lbu+QpjE2ULkJyQ/Z2Q6VUHu0So/DXm9PgS4MD8+undra4mWWFPSctkeFMSqeVSRyp0o1H1NDuiPbi8GMiqVWWQQNchD3Ob3zS0l4i3I8u8NPnusZa56sD1qnLOlHJCeeQURZxNQfR7n0C65XQtAT/GB1hvKdpOL1UWJ8dkrytVsByLkDps1sc7xzpI71T1aEP48gb7vcz/dEBUGH6BBQyqS4ZNuMP/QTcqZzbp5A02TSa1XaoWuWb3XJSsF69vgr6h1N9/CF//3KudxToWuz3zaii26AWWgTwSrMt6/iHtTKif29tWqs5GJ1L0zp6BtcsBzTwrYleYD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYCfVPa2cGxvwdokipj2TAofwRVcK7F7QfeIZ1Bn6v0=;
 b=TCFbES4crJItu2BE/Nm2H4I8qho5a0z2KYow2G1mYR/w6v0cPibBR5XwPFYCL9kmyxx1iTmmzVoqoI/oss4wWnNDORU/63+lzcYsKk+b+3qYJkn+AoZeWADjdhabiU0tqFlV9GhgROEagJR8Lyov9baBVXNKE8/gaCDiELzg/KsA7yXT/B9sIdBQl+4XifEVNflo4vjav5+3Xf0sfi2acQ0qQLKElHic56EPA6FyJXxMZD5NGXeBQtJeEUHclrVSMISTWJQPUH17xKGVrW+XRWRjB9v1JalcLztBDszYMGQkHQvQpUn/91FJ9TmPLbvNNzpQ3yWb1Yh3y/LLcBIL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYCfVPa2cGxvwdokipj2TAofwRVcK7F7QfeIZ1Bn6v0=;
 b=VWiKB3AgMozZzJlfiMpWOdDe2aLUpy3NFITjvAdrGy82uyVcMSw4GHF9z3/QazX6/Z+0cpISsapTw2Nht3TlDi9c3cU4quqbpgdN78fw+ACQixPO88FU2lFz3expX+rdeRheCuy7wyZfEd7siH0ct1aIX3/R/elrnmLgnQP67XFgLsLYkt6rZs7krMGGeRxjsQVboaCzbyvoR3jD4dXQXty8bwHCneZuD6s1hAaWGm2i+77GiiGJAukXy6AOkxyRrULzPg4KstQ6t+zRGjG1to8YEw9QmbgWsD3GlcmmzAuwilk5sN8fjjSEW34B+W0EGAxZYiuCF5ym8JFRUotJrA==
Received: from MW4PR03CA0183.namprd03.prod.outlook.com (2603:10b6:303:b8::8)
 by MN2PR12MB3694.namprd12.prod.outlook.com (2603:10b6:208:165::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 8 Aug
 2022 20:14:42 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::9c) by MW4PR03CA0183.outlook.office365.com
 (2603:10b6:303:b8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Mon, 8 Aug 2022 20:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 20:14:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 8 Aug
 2022 20:14:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 8 Aug 2022
 13:14:41 -0700
Received: from build-petlozup-20220627T000321362.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via
 Frontend Transport; Mon, 8 Aug 2022 13:14:40 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>
Subject: [PATCH v2] soc/tegra: pmc: Add IO Pad table for tegra234
Date:   Mon, 8 Aug 2022 20:14:20 +0000
Message-ID: <20220808201420.3451111-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb4d1e9-7132-479a-2cb1-08da797aa143
X-MS-TrafficTypeDiagnostic: MN2PR12MB3694:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coHGMYHBde/BmkSCWGucAJCI0IZ+fyWZzRlonOyZ7Fb1973PWfwiY9GCJB6FRWX03QOoSsK5fHUPtLly1jNjCo292raK6yQtpbG6NgO+LE+z56m3gryVkila5C1+2MasElz2EWxeQU7EYRlUv7JfCVtuSbLTykoZADh178TDVwocZQGmqYZZzc7faRW2RQfKOHQs7NkoMVn7PyXGVXW0ZDY9x4NlNtwePb/N796fMJjjyAkWm00dsWSEQavH/kRUjewzsxc0O6vKUHobEy/0MX/qLZWLQw7azgfyJD18U1ad1Yt6OGhpJFSosfq+3Q5rRThLm8ZzXbZb8vjBV7pAGoLFS6W8B0tplKl34BdsUh6mVUUBZe9iBx6gZbgnI55FwFYVXb4p2WWM51hm9MP+mRJ0CEczLDtE4G7VOSsQQgmi0UxcHRpW+IUP8nKUhn+s0oiFfmpHWadbc188hj3H/k54U9LjFIrdfM+oxfGBBrbGAzvnBaoUnqBKHV43xPKWNml4mohSEr4GSpsOMEGdT0/Vnur0a5+SCM4mKU8VBEb1GAVnSqciIx9E5FTEJqtuQUNt0cE/La8adxlKkJJlkRnfPG6jzw5kl/vQcnrOrRr9gKoQklwJV6yI6+5BWiEBvgoWiNj8cTvKYSoZTzdB2CImH9kYdNeaMLL51WZs+M+jLYgF0u1DnNJhnRbatByrO6E48SBQmpj3/mntvEZU0h8YOTHm0D9ziLYIzTJwRBkp+NGSUY462yu8D6Z7rc+YNz5PV613pU0762COzV9tGV4bnftIPfOQ4PPHwMgaEMv+BST9ebJXneh0u5FKQ6dUhGKtnCzdv97wPRXSmF1eQHcszS/Hn+WIjZWYxC5vV3w=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(36840700001)(46966006)(40470700004)(83380400001)(26005)(107886003)(1076003)(36756003)(2616005)(186003)(336012)(4326008)(110136005)(86362001)(426003)(316002)(6666004)(41300700001)(7696005)(2906002)(40460700003)(47076005)(478600001)(82740400003)(36860700001)(70206006)(5660300002)(40480700001)(70586007)(356005)(8676002)(82310400005)(81166007)(8936002)(921005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 20:14:42.3914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb4d1e9-7132-479a-2cb1-08da797aa143
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
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
 drivers/soc/tegra/pmc.c | 109 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 5611d14d3ba2..34d36a28f7d6 100644
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
 
@@ -3791,6 +3814,81 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.has_usb_sleepwalk = false,
 };
 
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
+};
+
 static const struct tegra_pmc_regs tegra234_pmc_regs = {
 	.scratch0 = 0x2000,
 	.dpd_req = 0,
@@ -3802,6 +3900,8 @@ static const struct tegra_pmc_regs tegra234_pmc_regs = {
 	.rst_source_mask = 0xfc,
 	.rst_level_shift = 0x0,
 	.rst_level_mask = 0x3,
+	.reorg_dpd_req = tegra234_dpd_req_regs,
+	.reorg_dpd_status = tegra234_dpd_status_regs,
 };
 
 static const char * const tegra234_reset_sources[] = {
@@ -3861,10 +3961,10 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
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
@@ -3879,6 +3979,7 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
+	.has_reorg_hw_dpd_reg_impl = true,
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
-- 
2.17.1

