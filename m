Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0B597600
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbiHQSpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiHQSpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:45:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5801E3E6;
        Wed, 17 Aug 2022 11:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gl+I1jbj1ed5x9IyG39bftfnr99vQWiQhkElNJC+6uhACsBK+kPGpo+AY+z1sQxvYof9gQcLp1pdgD9TTRIfd0YSn0gAWS2I0vh4bTT4AFJF8/l3Xjh+zwIzSZNvsKSBPOxBRnd51aV/5AVGAYzwlmbF6N12M/zSN3zWOCggYo1lzJqfv/3pOhj0H4VFOkC5NZJPPBd3uTUoaUI5aQGYfQAipmZr8e/L1/u1DgpLCq5Hqi47cNRs+pY9DCibe2TPBHi7jIgIcL/6+C6UwXgkwHaPDUxC3+y8a4vDCav6d29CeHaubl7tdC1HgluKYe02NNKJegiNcCXl8BW8sxxgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdyyRl3AmhjpcMUvtFRUBu+NU/QPTgz7zXa1cOu7/q0=;
 b=m1I3suzHTrQET1R9SCadfv699XbntYiYF9VldfiZn3QB1fwaHi9yGh0M/z/yMPIHWWlIp3UrncgxXZxXuBZaJXvug8lAj2NhtLfUkTCPdEFVRhV6f9jeKN4w+BBnwB6SUSN8ksWUiL1HtFcqQcjdQYsWZxRy5BAF3Une9FWXXAZXuxr0Kf4OhovbJ4C+d+3yeBH5KKYN6mnOsMFw63v+bfPYFZQpC4LaSH0IlGIgx9s4EWW4LiKlOvMmBMJUxdjYweA+5AjcIZ7eXiAaBokh+60Mb6A2Xy6TrwuCR2IdiAOC/mltoR3/j0GJ9nE1wgMPk2ltKePr5227SlsD1YitXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdyyRl3AmhjpcMUvtFRUBu+NU/QPTgz7zXa1cOu7/q0=;
 b=QR1lY799s6IOs2RR1oS0kZ5fkmUwfuhf3RJh7unxx6E+lLCgD4p+3I7e2BgY08J671Y5SwpCTvooCkW1c6ePMZTjqYhAJfvKuq6RrIEO7GFcrMddTKBSGjQ1ZrNzZZJFqdFvDGkOcDfYTZSZrtAYn7X7Ai27Y7s7PAAOl+JcQdGTFticIFTie+E18pG7FHeCScFeNkA+W6l334ZMvOMYNa6lqxv76SRAQvmvQy3sqMOSfK4oZzI/cgwcQcQGsMDUCwwi9c31yvg2wyM1GcKc3NjXsFxhP7fgSP1d1S5vg1/kDl83DR5U4i4IWsHlHREFBqdTCvokJa9uN57uIgYBUQ==
Received: from BN9PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:fb::34)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 18:45:15 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::d1) by BN9PR03CA0059.outlook.office365.com
 (2603:10b6:408:fb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.17 via Frontend
 Transport; Wed, 17 Aug 2022 18:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.7 via Frontend Transport; Wed, 17 Aug 2022 18:45:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 17 Aug
 2022 18:45:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 17 Aug
 2022 11:45:12 -0700
Received: from build-petlozup-20220627T000321362.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via
 Frontend Transport; Wed, 17 Aug 2022 11:45:12 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>
Subject: [PATCH] soc/tegra: pmc: Print reset info during probe
Date:   Wed, 17 Aug 2022 18:44:56 +0000
Message-ID: <20220817184456.1184459-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c23b8c7f-11cb-46be-7691-08da80809fc5
X-MS-TrafficTypeDiagnostic: IA1PR12MB6484:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFM67JEKdNFUXwSimV1L6nHgxDLjUdias6D4i2rPtiCN4Q9nFKrLq790GDnzOBdQhbnioSvYXDe5RIzMB/7s2ptyMCrAIijFng9DleUq/Ee7x92u8fAf9fN3N5pJ7QN0HoWLpTVbFmm32zCXceGkV2FVSvAbE/0wQMIFvkqtpKn2RtTsUy5HSSB5qrBT1KFvtrHZMdxGUmGd8HwAmENOxZ0OMa5g7zbXmp6HDWtgMWmrG84JwLm+abNlMc24kuTlGuFRKtVbRAG0HlYVWTRJulrSrb1g7FxgQVAQqEjCQvudLcf/2TFoSq45NfzGmnoqXo7N+wkDXFV2AfmO00tiBD2GXA72XaTQpXeEG/2l+JPJ7RzyoUdjwp3FwVA6yC0poej8XhbdtB46y9k+kun8XNpwMaLJbZ6/jZ3Z+gdR9Gt2R8xAvus6gRERiNjsVfH1oXHyuNpvHk7bCfJMU7gw/dU3Y6Z9DGc0oXK9i5EJxaeHh93NRngc+zEhDEPlNI51NroBJBI2NkZxaH2Cf/rBJ9Zdonf0OT7DJK4Z9brnj38dB+K4haiKa5e942MgLh5AvK5TrQaqUOkdE+R3q69B7X/BEIZEXMu2YHgIRVdUaoJjfnQ0FfVt8Q6DD7gJu2nn5jdP+Bfd5DXSHk5QHdDmsPf709EgVhsziXJarJVHsfRAZGZMclmCfVV8xfOORp1U9l2/6kZ+ZhVisghfGpmtKHY2sZlYxMcMuXpnvSEtYO6R6SR1MBPzPbZ/1DJH2SX3F0vnppEZhIimFCeCGoN6/HzNqihBwYOBRscbGdK3vNXSD8HIxT0aJH7JiXs327NO
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(40470700004)(36840700001)(46966006)(6666004)(4326008)(2906002)(26005)(82310400005)(2616005)(7696005)(86362001)(41300700001)(40480700001)(36860700001)(8936002)(40460700003)(107886003)(36756003)(478600001)(110136005)(81166007)(921005)(356005)(82740400003)(336012)(47076005)(426003)(1076003)(186003)(8676002)(70586007)(5660300002)(316002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 18:45:14.9159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c23b8c7f-11cb-46be-7691-08da80809fc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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

During PMC probe, print previous reset related info
such as reset reason and reset level.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 34d36a28f7d6..dd98ea034149 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2177,6 +2177,31 @@ static int tegra_pmc_pinctrl_init(struct tegra_pmc *pmc)
 	return 0;
 }
 
+static void tegra_pmc_show_reset_status(void)
+{
+	u32 val, rst_src, rst_lvl;
+
+	val = tegra_pmc_readl(pmc, pmc->soc->regs->rst_status);
+	rst_src = (val & pmc->soc->regs->rst_source_mask) >>
+		pmc->soc->regs->rst_source_shift;
+	rst_lvl = (val & pmc->soc->regs->rst_level_mask) >>
+		pmc->soc->regs->rst_level_shift;
+
+	if (rst_src >= pmc->soc->num_reset_sources)
+		dev_warn(pmc->dev, "reset source: UNKNOWN\n");
+	else if (pmc->soc->reset_sources[rst_src] == NULL)
+		dev_warn(pmc->dev, "reset source: UNUSED\n");
+	else
+		dev_info(pmc->dev, "reset source: %s\n",
+			pmc->soc->reset_sources[rst_src]);
+
+	if (rst_lvl >= pmc->soc->num_reset_levels)
+		dev_warn(pmc->dev, "reset level: UNKNOWN\n");
+	else
+		dev_info(pmc->dev, "reset level: %s\n",
+			pmc->soc->reset_levels[rst_lvl]);
+}
+
 static ssize_t reset_reason_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -2979,6 +3004,8 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 
 	tegra_pmc_init_tsense_reset(pmc);
 
+	tegra_pmc_show_reset_status();
+
 	tegra_pmc_reset_sysfs_init(pmc);
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
-- 
2.17.1

