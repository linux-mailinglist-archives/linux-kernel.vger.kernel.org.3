Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D45A4D4607
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbiCJLnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240682AbiCJLno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:43:44 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9648848332;
        Thu, 10 Mar 2022 03:42:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPqZmlPEv5F/KId/w9cZcOM43WTXpONad+/FVmus+9QkYgTVuiyCvBw/xcQ9+rwOYYeWYZU/7BLy/k7p7jglUKhEIRPBcBgMQlqyI/42nnruEYnT4W5kztFj9eWhCvlmWwpG1LqgR0J/t8Nh2CIp3l/NK8OH8OakREYDA1KH5lPsLPlRukwbgFJF4wUx+d9szIInkKLHLiUFFGwJeq4ftpurf72UwTpLjK2XJ8PYwZyNy1zB1jiegR+HfUFLaXLm4hF17u+MS2iFXb/amVrOfWL/2JEyHx07XbSdJCeJ3QCH6bJgHGkwfxUjA/bN+E+GTvraDC/znHzKB7aWlkCC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zik1vcpPSiC0eIrz6I1m4gA+hH+Pf27ZiFHQdb820M=;
 b=l9p1kyeF++vJ132Am1aTAGK771qWmjZnJMl0wmdah8ROF3BW9K3eGCydU8LYxo/PvZrB2M3gFJ3uzREu1mJBWOW5b5oJnT3k+WHwdwKV7PMj++2JflbWQKKqZjvpJVNfw+fegCzUYdg9bwbyXs7as/F3kuI28CXxxKta/DkywzMr6ZUPvYEYR19owlC+wN30G2B3mY2ffFTB/m/tcm8mmOPXy9qIVIdq2cGP+ycy98FgTDMZz+CjNxfzpr2k0k6UdYogvI8ITH8BRxCC7jtnriIsMAQg1KzkoVYEXxlPrFN1FkQ24nDyvJUNxBiazGMKwwiNIT8EKNK8NqKVjmVX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zik1vcpPSiC0eIrz6I1m4gA+hH+Pf27ZiFHQdb820M=;
 b=dfhsU6lAK8kaoi92rrdcVX2muVWZwJZInbfW27BTI+oPVu2PzauG67A/j7LcA1p+ZQWKojHjq+owjJV8Q6YLZZsyRZk9JBltAQkLIu+zz+zN/tMF+XiKldB5DCCUbeMwbDJzMhX4VRaDPgzQa4w5TlHZI9wi9ze1faSSb5OQkRSMxu/N1HwhDitc0tVc4JJs4+/ias0/fPKMiGlZeogYTNpwLvRK3buEP2tF8r2J3eoVzb1tT0O8CM3eLKo/PKOkHbwTTaZdgOEFixnxyrxBFqoyzLU3fSIFtmIvI38+eNYuTF36qdMazp1N8SaFiU9Uu4QXqTYPGhWPWBMJssM6IQ==
Received: from DM6PR14CA0066.namprd14.prod.outlook.com (2603:10b6:5:18f::43)
 by BYAPR12MB2805.namprd12.prod.outlook.com (2603:10b6:a03:72::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 11:42:30 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::cc) by DM6PR14CA0066.outlook.office365.com
 (2603:10b6:5:18f::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 11:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 11:42:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Mar
 2022 11:42:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 10 Mar
 2022 03:42:28 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Thu, 10 Mar
 2022 03:42:25 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <oder_chiou@realtek.com>, <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RFC PATCH 1/3] ASoC: soc-pcm: tweak DPCM BE hw_param() call order
Date:   Thu, 10 Mar 2022 17:11:15 +0530
Message-ID: <1646912477-3160-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646912477-3160-1-git-send-email-spujar@nvidia.com>
References: <1646912477-3160-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc13ccfa-1301-431d-0668-08da028b0f3c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2805:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2805462CE16951442FD91DCDA70B9@BYAPR12MB2805.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: URjE8JbSPKK0Thxufv35D04/oWRF3/uQpFtYMyJMClFSCp66BPNWR1PS65uRl9xd199NY9nwB8u/AbqI32GSoCMe23ExzecObITll1953oCYhOWSHH9++QqB3qwq0Krn17/mmZG0XzsvkqUazLhSCLED3kJvazG+NIciHBO9NWEgCduBEVwT9YrWYS5nMivq1GB4MP6CbWBNca6BNVzRjtbD1m9Gco3oadotxkbBll+IARGZfh49CaaTRYQYc/k/W2tPTrYY2GVD+V3yGNl3omro1cSDX9EEgkmOpYz83hLIKuyWQci0seoloav8thZ/MvwdC7rt2srDhE0rFaFlrMCWeKP+ShJ3KIIRhqvpmSNk3+nMCHpYjkFqr6F0j7UBKjQP1GlLktiwk2eznzUXxrBhdINXqNQDN64DhTTz0xkf7JGkYGLSUAn4EK+Mj2Ge9zTRxPYAPng2Z73X8rfItH/qRqXlbGlLsGEAtLGIIWwgx/GM9SkvBkEnoaI96PbgtKWjfyiNHoXKp+72NsMgKSsjoUDs6zTff3N1IetOIJno4Zw5XJy5wKp/m3Qrjluyy+oW+sdogFpg2Wc8d5CA1txi9LrU6pRhAPCMlrlxfc6M2ujlyCkbwoNb6w6i9RH6wDFWEHa5IrWpwG0jygKzFtozRE/R7DR4jcN//ZZWE6qHwOtAZmI33uJvmKCiDBlWPV3xVLZeMm5lcGONr7WwrA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(336012)(316002)(2616005)(40460700003)(186003)(70586007)(70206006)(83380400001)(54906003)(110136005)(36756003)(4326008)(36860700001)(86362001)(8676002)(107886003)(81166007)(356005)(426003)(5660300002)(82310400004)(26005)(7416002)(508600001)(8936002)(7696005)(6666004)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:42:30.4085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc13ccfa-1301-431d-0668-08da028b0f3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2805
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For DPCM links, the order of hw_param() call depends on the sequence of
BE connection to FE. It is possible that one BE link can provide clock
to another BE link. In such cases consumer BE DAI, to get the rate set
by provider BE DAI, can use the standard clock functions only if provider
has already set the appropriate rate during its hw_param() stage.

Presently the order is fixed and does not depend on the provider and
consumer relationships. So the clock rates need to be known ahead of
hw_param() stage.

This patch tweaks the hw_param() order by connecting the provider BEs
late to a FE. With this hw_param() calls for provider BEs happen first
and then followed by consumer BEs. The consumers can use the standard
clk_get_rate() function to get the rate of the clock they depend on.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 TODO:
  * The FE link is not considered in this. For Tegra it is fine to
    call hw_params() for FE at the end. But systems, which want to apply
    this tweak for FE as well, have to extend this tweak to FE.
  * Also only DPCM is considered here. If normal links require such
    tweak, it needs to be extended.

 sound/soc/soc-pcm.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 941410c..cfaff25 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1442,6 +1442,29 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	return prune;
 }
 
+static bool defer_dpcm_be_connect(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *dai;
+	int i;
+
+	if (!(rtd->dai_link->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK))
+		return false;
+
+	if ((rtd->dai_link->dai_fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) ==
+	    SND_SOC_DAIFMT_CBC_CFC) {
+
+		for_each_rtd_cpu_dais(rtd, i, dai) {
+
+			if (!snd_soc_dai_is_dummy(dai))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+#define MAX_CLK_PROVIDER_BE 10
+
 static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	struct snd_soc_dapm_widget_list **list_)
 {
@@ -1449,7 +1472,8 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	struct snd_soc_dapm_widget_list *list = *list_;
 	struct snd_soc_pcm_runtime *be;
 	struct snd_soc_dapm_widget *widget;
-	int i, new = 0, err;
+	struct snd_soc_pcm_runtime *prov[MAX_CLK_PROVIDER_BE];
+	int i, new = 0, err, count = 0;
 
 	/* Create any new FE <--> BE connections */
 	for_each_dapm_widgets(list, i, widget) {
@@ -1489,6 +1513,40 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
 			continue;
 
+		/* Connect clock provider BEs at the end */
+		if (defer_dpcm_be_connect(be)) {
+			if (count >= MAX_CLK_PROVIDER_BE) {
+				dev_err(fe->dev, "ASoC: too many clock provider BEs\n");
+				return -EINVAL;
+			}
+
+			prov[count++] = be;
+			continue;
+		}
+
+		/* newly connected FE and BE */
+		err = dpcm_be_connect(fe, be, stream);
+		if (err < 0) {
+			dev_err(fe->dev, "ASoC: can't connect %s\n",
+				widget->name);
+			break;
+		} else if (err == 0) /* already connected */
+			continue;
+
+		/* new */
+		dpcm_set_be_update_state(be, stream, SND_SOC_DPCM_UPDATE_BE);
+		new++;
+	}
+
+	/*
+	 * Now connect clock provider BEs. A late connection means,
+	 * these BE links appear first in the list maintained by FE
+	 * and hw_param() call for these happen first.
+	 */
+	for (i = 0; i < count; i++) {
+
+		be = prov[i];
+
 		/* newly connected FE and BE */
 		err = dpcm_be_connect(fe, be, stream);
 		if (err < 0) {
-- 
2.7.4

