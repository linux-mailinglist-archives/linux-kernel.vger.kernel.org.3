Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF91500704
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbiDNHiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240405AbiDNHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:38:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983D022BED;
        Thu, 14 Apr 2022 00:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvCbKtrnkWcG8NIXm+aUTMP7NCj7lOTXp5SYzRdsd+yFO3PoiyELPhwS4KIRomVCWgQb3FqMrMLh8EI/GSJOuIWeBJLNI8Lq5rDlPom9U+0CPwp76wTiQhnNZLjDpK/CtlTYUDSJdzaagvGjyeyB7O5FfVR4NtOIzFtJHQTVfUsOLUOp3ybfCnJ0oS+2Iewy4hjzkzdPCeTOouwvNFKp15n5jcj5h6TnejeNmW1OJB9yr3u4YNiYqzxJkDuYzhAVQJhEHJSp+mEkMPkabLKZmY0hEhkSH8+frYYV1VFXl02mdeRgB1z7agQKl6/F4E+dD8OzAY6T6QWfOl+x3GhNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fyy5UfBHq7Yc/1fayB1T2YM5gz65KvfA7zqWELaok7I=;
 b=Dg95trVvENu8EkSCLcPlB7HW4MEje0gW5E8MGqtZYAHdN24QaviWE95aYXcepAZNodHuGhnNc9fYiTM4P8DAXFqRM2NzbzivJ+9jIQ268HqGU1/UAlnT/ZtRsWWTvjPTj1FVCfKDoeqLDikH/8yspOelvI0Zs1KT6U+EdHniY6alpoArZKdL4o8EtfKf+XoJBYCeliolOHOXTYsxqz8IZtzfnyzu6/SL+fs5Hy/piDrfMBJiaHBYr6vCLSluVAURoSb2djbZd2P+ZHLiHKM+p6vCp840tOcZiaYKqxg9yALUJ9MUQQfc72izl7zSejQ07yUx50qXXsZOXMnwClh3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fyy5UfBHq7Yc/1fayB1T2YM5gz65KvfA7zqWELaok7I=;
 b=qTJZRCW/dtCyxz9d24Ul81t2VFCfTBGEspECz4WavTsgKf0he6ZXn4BKCuPRizX/yH/HGXJ7XtGj8kF2cZGNpz8K/b9PMZ6ThRZY3N2OoPq567B9ClE81s6GkAMxVe1yhLbYV1PEDMRRtWM356Wxpo23D27hbPWsp7of79OKLKsSJtzm5DVkcpZ2XdrnjvpzKw6ZmamgJBIRTbgXjG2t+dppIVnZltQ4FKYSoXG0jqu75dh8Ff2gluw/b2hi29x5Rz4eCWZzCCvHCOwA2vkvuxBZynh68GAwlME6zU8stGB+BfMTu8Q0ELrZiLFlSxzQzzjlyu5Jw4VaYWsbsUzidA==
Received: from MW4PR03CA0310.namprd03.prod.outlook.com (2603:10b6:303:dd::15)
 by DM5PR12MB4677.namprd12.prod.outlook.com (2603:10b6:4:a4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 07:36:11 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::1b) by MW4PR03CA0310.outlook.office365.com
 (2603:10b6:303:dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30 via Frontend
 Transport; Thu, 14 Apr 2022 07:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 07:36:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Apr 2022 07:36:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 00:36:09 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 14 Apr 2022 00:36:07 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <kkartik@nvidia.com>
Subject: [PATCH 3/3] mailbox: tegra-hsp: Add 128-bit shared mailbox support
Date:   Thu, 14 Apr 2022 13:05:57 +0530
Message-ID: <1649921757-16919-4-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
References: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44143230-4a7e-4888-1c34-08da1de972b6
X-MS-TrafficTypeDiagnostic: DM5PR12MB4677:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB467771ADE09198BFE8D47A08CDEF9@DM5PR12MB4677.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6tGrtNBka+mD9zVsXfydLEZUhWKeUhWXMhtSZDmVBdJU+mdF4rLSQhvdn4NC7QaM9goAfqeSsXWrmanmQBfJ1jCH0+Sww45YTj0XudVWTkf8SJBW2jdcAbv/q6x4rgS4ngdkB2I+HEsUk6DQr4E6x19BGkT0vTmf5MMCWUzLQCALwd9o2XGLlVjswATW9w5yq+saiABP+wbYcIgQA1mgcGUs7EeZDgdtwkd91hzOUFous5J5iR1+aV9K2Av12VMc0YA0Iz+f9ZW/Wg8xj9w9w6birqZ+JvSHRO5hx2mgUBSqU11NvkPtHL5MkUZSp6hl0xS0ivj+8RpIkMH7wRJqYqXrtzVa9E1VKbj7vb33GSdAuI5J2qVK26qEryW4KrwxPNsInyYFVeLwN/xpRfGsQJul0Rpx9CLC/uDbqjITdFObzWZtCAft2Gg8HnDxS5DO6z5XyJdUy+/hNrufTvYv17N+lbW9vpZd79ZycPWbRVEtQWk/ulUNBaAu9UNtQjh3nAjOVHrbmfqK9UMvoMDqjXAQxPT0Oc1Cd8jHXw67dZIBy0WXv+NTqA8yzf+M8m4d8Dj56wFIAyfHLyEBNI86gV9sfihwEH22gdPR2GJpPaASj7DHi7KtYBqMLWXbxBio5En6LTNtPMOHNk9h+qA3dPBS8egCPHr/8OMWF0ebMhm0QWIAvTB1d1sNIexLSMUCpO5+Uuq+Jvqg0R7d+hvlQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(36860700001)(15650500001)(82310400005)(8936002)(2906002)(36756003)(110136005)(81166007)(7049001)(356005)(70586007)(5660300002)(70206006)(8676002)(40460700003)(86362001)(508600001)(6666004)(83380400001)(426003)(26005)(336012)(2616005)(7696005)(186003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 07:36:11.4375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44143230-4a7e-4888-1c34-08da1de972b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4677
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 128-bit shared mailboxes found on Tegra234 chips.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/mailbox/tegra-hsp.c | 77 +++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index af61ae43ab09..f58448b10d90 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -46,10 +46,18 @@
 #define HSP_SM_SHRD_MBOX_FULL_INT_IE	0x04
 #define HSP_SM_SHRD_MBOX_EMPTY_INT_IE	0x08
 
+#define HSP_SHRD_MBOX_TYPE1_TAG		0x40
+#define HSP_SHRD_MBOX_TYPE1_DATA0	0x48
+#define HSP_SHRD_MBOX_TYPE1_DATA1	0x4c
+#define HSP_SHRD_MBOX_TYPE1_DATA2	0x50
+#define HSP_SHRD_MBOX_TYPE1_DATA3	0x54
+
 #define HSP_DB_CCPLEX		1
 #define HSP_DB_BPMP		3
 #define HSP_DB_MAX		7
 
+#define HSP_MBOX_TYPE_MASK	0xff
+
 struct tegra_hsp_channel;
 struct tegra_hsp;
 
@@ -88,6 +96,7 @@ struct tegra_hsp_db_map {
 struct tegra_hsp_soc {
 	const struct tegra_hsp_db_map *map;
 	bool has_per_mb_ie;
+	bool has_128_bit_mb;
 };
 
 struct tegra_hsp {
@@ -396,6 +405,51 @@ static const struct tegra_hsp_sm_ops tegra_hsp_sm_32bit_ops = {
 	.recv = tegra_hsp_sm_recv32,
 };
 
+static void tegra_hsp_sm_send128(struct tegra_hsp_channel *channel, void *data)
+{
+	u32 value[4];
+
+	memcpy(value, data, sizeof(value));
+
+	/* Copy data */
+	tegra_hsp_channel_writel(channel, value[0], HSP_SHRD_MBOX_TYPE1_DATA0);
+	tegra_hsp_channel_writel(channel, value[1], HSP_SHRD_MBOX_TYPE1_DATA1);
+	tegra_hsp_channel_writel(channel, value[2], HSP_SHRD_MBOX_TYPE1_DATA2);
+	tegra_hsp_channel_writel(channel, value[3], HSP_SHRD_MBOX_TYPE1_DATA3);
+
+	/* Update tag to mark mailbox full */
+	tegra_hsp_channel_writel(channel, HSP_SM_SHRD_MBOX_FULL,
+				 HSP_SHRD_MBOX_TYPE1_TAG);
+}
+
+static void tegra_hsp_sm_recv128(struct tegra_hsp_channel *channel)
+{
+	u32 value[4];
+	void *msg;
+
+	value[0] = tegra_hsp_channel_readl(channel, HSP_SHRD_MBOX_TYPE1_DATA0);
+	value[1] = tegra_hsp_channel_readl(channel, HSP_SHRD_MBOX_TYPE1_DATA1);
+	value[2] = tegra_hsp_channel_readl(channel, HSP_SHRD_MBOX_TYPE1_DATA2);
+	value[3] = tegra_hsp_channel_readl(channel, HSP_SHRD_MBOX_TYPE1_DATA3);
+
+	msg = (void *)(unsigned long)value;
+	mbox_chan_received_data(channel->chan, msg);
+
+	/*
+	 * Clear data registers and tag.
+	 */
+	tegra_hsp_channel_writel(channel, 0x0, HSP_SHRD_MBOX_TYPE1_DATA0);
+	tegra_hsp_channel_writel(channel, 0x0, HSP_SHRD_MBOX_TYPE1_DATA1);
+	tegra_hsp_channel_writel(channel, 0x0, HSP_SHRD_MBOX_TYPE1_DATA2);
+	tegra_hsp_channel_writel(channel, 0x0, HSP_SHRD_MBOX_TYPE1_DATA3);
+	tegra_hsp_channel_writel(channel, 0x0, HSP_SHRD_MBOX_TYPE1_TAG);
+}
+
+static const struct tegra_hsp_sm_ops tegra_hsp_sm_128bit_ops = {
+	.send = tegra_hsp_sm_send128,
+	.recv = tegra_hsp_sm_recv128,
+};
+
 static int tegra_hsp_mailbox_send_data(struct mbox_chan *chan, void *data)
 {
 	struct tegra_hsp_mailbox *mb = chan->con_priv;
@@ -571,12 +625,20 @@ static struct mbox_chan *tegra_hsp_sm_xlate(struct mbox_controller *mbox,
 
 	index = args->args[1] & TEGRA_HSP_SM_MASK;
 
-	if (type != TEGRA_HSP_MBOX_TYPE_SM || !hsp->shared_irqs ||
-	    index >= hsp->num_sm)
+	if ((type & HSP_MBOX_TYPE_MASK) != TEGRA_HSP_MBOX_TYPE_SM ||
+	    !hsp->shared_irqs || index >= hsp->num_sm)
 		return ERR_PTR(-ENODEV);
 
 	mb = &hsp->mailboxes[index];
-	mb->ops = &tegra_hsp_sm_32bit_ops;
+
+	if (type & TEGRA_HSP_MBOX_TYPE_SM_128BIT) {
+		if (!hsp->soc->has_128_bit_mb)
+			return ERR_PTR(-ENODEV);
+
+		mb->ops = &tegra_hsp_sm_128bit_ops;
+	} else {
+		mb->ops = &tegra_hsp_sm_32bit_ops;
+	}
 
 	if ((args->args[1] & TEGRA_HSP_SM_FLAG_TX) == 0)
 		mb->producer = false;
@@ -853,16 +915,25 @@ static const struct tegra_hsp_db_map tegra186_hsp_db_map[] = {
 static const struct tegra_hsp_soc tegra186_hsp_soc = {
 	.map = tegra186_hsp_db_map,
 	.has_per_mb_ie = false,
+	.has_128_bit_mb = false,
 };
 
 static const struct tegra_hsp_soc tegra194_hsp_soc = {
 	.map = tegra186_hsp_db_map,
 	.has_per_mb_ie = true,
+	.has_128_bit_mb = false,
+};
+
+static const struct tegra_hsp_soc tegra234_hsp_soc = {
+	.map = tegra186_hsp_db_map,
+	.has_per_mb_ie = false,
+	.has_128_bit_mb = true,
 };
 
 static const struct of_device_id tegra_hsp_match[] = {
 	{ .compatible = "nvidia,tegra186-hsp", .data = &tegra186_hsp_soc },
 	{ .compatible = "nvidia,tegra194-hsp", .data = &tegra194_hsp_soc },
+	{ .compatible = "nvidia,tegra234-hsp", .data = &tegra234_hsp_soc },
 	{ }
 };
 
-- 
2.17.1

