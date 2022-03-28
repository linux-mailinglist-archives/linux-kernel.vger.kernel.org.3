Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C53C4E8DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbiC1GRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbiC1GRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:17:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2055.outbound.protection.outlook.com [40.107.96.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7557E27FF3;
        Sun, 27 Mar 2022 23:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URo3GWZ4ag1Ew50i/qSqlNeTmfE+ARjySCLeq5kExlNhYmu2/ndWOB60ZOMLIymqaYWniIN6j6l+YaBwxgZkPDOeGgUkGiEX7rsNnyhfy3FcsxuEnauqb4h5nhlZ8AcbWli4Ap0YW34OJd2PkGvbCJOsSs5rLHGpIFXWLvT2JclDBqZPtL05MCfarDRiv7LYmQaCqRIf30aYxLtw6jLLXyjaftugiot0dj6CPjkSn50amVvvy96Dpg/DNwJ86nkfFR/vPHr+d8AYOUDX2w65Z3pLWY5Jjjv9t10iLdxjoRPGkUTGY+p1vlxsgFDfosml9b99SPmNcE99kTSeKy5wQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgYC8rsiIXE/L6Yotxa5CwM59DCs8RBz0unGLxb+rGk=;
 b=SUGSaY/NRnOJXglhbF5/UN1VOrY0hA5EeBGI7HUyuaAce5UB45xhQpja3Jbxe8Ig7VQll/LixJrN6dUdMSmhNGy6FqpalsHXeMjmvB2p242TOgrdxXh3sP6F8+ll3n0j8iqdqAkVLAbFMHi1hJwYAhJXEI9aVSZMiDgdZe8Nb5aRQspL8GcpLp7b/+TtJRRWaG/XKAnYIdk6DqNP2MHuk1Wk7dDvoNQ5gdH1EFkvW7gn11CdBfhBiZFQ/w5h7Unnsb3GVafum1A6bpQuRsB3j837oeaCJFuNHJFXt9DstvgWqHdaml1moSbFiVI4RWZhcu0wge48nXK3LI1tEm9ubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgYC8rsiIXE/L6Yotxa5CwM59DCs8RBz0unGLxb+rGk=;
 b=a7lapxIPW3ffu9cCQKBwHBWa8hMvwar2CNkvv3mnrsS6Fv3bhgSOGmMFJdJhmWF49zC6Nf0W0sS8RRjue8TV2aMEVEfP5HeC46rt9fQaZiEDBvU/e4NjHK/y3spWeHTsJzzqRIxsBHeJ0+W6RzDtDDkkct5orS6sccyf1qM7FEGPX0vLq41UFwwnEkHGbVrtMtT/D0iHsyBQNgx/cSkvMU5vjDxYtPNL0x0lna42X0Z9ykZ3dhnihZFr5/9eHbkO08OPUea5j1hTJNq44G/8whIcZPrSnT3kqa9FNjMPEVWgfO8A5P4ZwcDX28p5iEns5imeuZkZD0Mv6iO0Qi8jJg==
Received: from MW4PR03CA0062.namprd03.prod.outlook.com (2603:10b6:303:b6::7)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 06:15:58 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::28) by MW4PR03CA0062.outlook.office365.com
 (2603:10b6:303:b6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 06:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:15:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 06:15:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 27 Mar
 2022 23:15:56 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 27 Mar
 2022 23:15:52 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <peter.ujfalusi@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <oder_chiou@realtek.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RFC PATCH v2 5/6] ASoC: rt5659: Expose internal clock relationships
Date:   Mon, 28 Mar 2022 11:44:09 +0530
Message-ID: <1648448050-15237-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 130dcd6b-df31-4a8c-d22c-08da10826cad
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB418151423D57689A9C8FA8F0A71D9@CH2PR12MB4181.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kj9OpxRxFDdxYinOaRLSfZJjC06yaQcdJN05B0Zw8ZRS+8A7SSkawFBYjYU2+BmJ7DtBxOtF3/ZSVTK1xbHFZjiD6iDRGQej88b/UHyQjYwi3d+/+VY3N1RvUS/az6dwEP7aRbMxZ0ih/H+Ly9avRqG7qI6HYk4xtC7n0bDagSV16dHQcvqVwoH3yy4cMjiatJheWKldW7QzqMWtN9dZ0tgRtWgFY7pEiF5/vI5Ru0sqxsUBx+qs0ZUZQSNt/GoiZeFcFDRXBA+sgaSHCmXHgVCiRwRD2vZaCeb3aCzPJehVdN8b3OzeHm+cvbZflGtztl06THcKDzSzbV8JDWUMZyflyC3huGHDrw2xVYHPmhOcz7EKMKZoextOUjjY57poj2C/pmSdMIK5BvEaQNPxfvxyGtTJb+IgSXogclMuQr0S1z+23B4lzvvn1hDdm2ijiOuNYgb+m29OR4fXiVtUbkKT+TQKMFDN3V0lFBqPKNfTcUeKcbbFB2sLffzKMW5TEwFMyBbGUfG6sqP62RcjYSHF5ePZGppnAmrzxKIHKVCvbPm0VVh0R/YLN5RvxAxWSawrNj6QmriPzivUolR/9g3LEDQ2Oi6/x+fz/4SsBK2mebUCjvJODbShgFw+9QlXXnuJ5nfDcRyST3VbeOgzEqsa+i8VECoxcPZDZWKG2qyMJuIT0zX8yBp5ABXxTqoklyvihD8hLwfpGp2W0LQzbUMfG9MtQax26tmraIA9AMsUmDjJHb60smE04ihHoabYQl2qA9hftIDDIN72ScM6c1LRQX6HLkgumuF1Sfdmbys=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(186003)(40460700003)(26005)(426003)(336012)(86362001)(2616005)(47076005)(2906002)(30864003)(7416002)(8936002)(54906003)(110136005)(107886003)(356005)(81166007)(8676002)(966005)(70206006)(36860700001)(70586007)(316002)(4326008)(7696005)(36756003)(5660300002)(6666004)(82310400004)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:15:58.0064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 130dcd6b-df31-4a8c-d22c-08da10826cad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RT5658 or RT5659 codecs have multiple options to derive Sysclk:

  * Sysclk sourced from MCLK clock supplied by SoC
  * Sysclk sourced from codec internal PLL. The PLL again can take
    reference from I2S BCLKs and MCLK.
  * Sysclk sourced from RCCLK.

The clock relationship for codec is as following:

             |\
             | \                                        |\
  BCLK1 ---->|  \                        RCCLK          | \
             |   \                         |----------->|  \
  BCLK2 ---->| M  \       ____________                  |   \
             | U  |      |            |  PLL output     | M  \
  BCLK3 ---->| X  |----->| Codec PLL  |---------------->| U  |
             |    |      |____________|                 | X  |----> Sysclk
  BCLK4 ---->|   /                               |----->|    |
             |  /                                |      |   /
  MCLK  ---->| /                                 |      |  /
         |   |/                                  |      | /
         |                               MCLK    |      |/
         |_______________________________________|

Presently 'snd_soc_component_driver' and 'snd_soc_dai_driver' expose
callbacks, set_sysclk() for Sysclk and set_pll() for PLL configurations,
which are implemented on codec driver side. The generic machine drivers
(simple-card or audio-graph-card) depend on default values for Sysclk
source or PLL reference. Specific clock relationships are not supported.

The simpler solution would be to expose new DT binding properties to
convey the PLL and Sysclk source. This attempt was made before with [0],
but was not encouraged because it tries to do the same thing what
standard clock bindings already provide

This patch uses standard clock bindings to establish the codec clock
relationships. Specific configurations can be applied by DT bindings
from codec device node. The codec driver registers PLL and MUX clocks
to provide this flexibility.

[0] https://patchwork.kernel.org/project/alsa-devel/list/?series=438531&archive=both&state=*

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
---
 Note: If such model is OK, other codec drivers will require similar
 handling. Objective is to drive clock relationships from DT using
 standard clock bindings. With this machine driver need not know
 the details for configuring codec PLL or other clocks and thus can
 be more generic.

 sound/soc/codecs/rt5659.c | 248 ++++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt5659.h |   9 ++
 2 files changed, 249 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index e1503c2..3bf9680 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -18,6 +19,8 @@
 #include <linux/acpi.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -3527,6 +3530,9 @@ static int rt5659_set_component_pll(struct snd_soc_component *component, int pll
 	rt5659->pll_out = freq_out;
 	rt5659->pll_src = source;
 
+	dev_dbg(component->dev, "pll_in = %u Hz, pll_out = %u Hz, pll_src = %d\n",
+		freq_in, freq_out, source);
+
 	return 0;
 }
 
@@ -3843,6 +3849,237 @@ static int rt5659_parse_dt(struct rt5659_priv *rt5659, struct device *dev)
 	return 0;
 }
 
+static unsigned long rt5659_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct rt5659_priv *rt5659 =
+		container_of(hw, struct rt5659_priv, clk_pll_out);
+
+	return rt5659->pll_out;
+}
+
+static long rt5659_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long *parent_rate)
+{
+	return rate;
+}
+
+static int rt5659_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct rt5659_priv *rt5659 =
+		container_of(hw, struct rt5659_priv, clk_pll_out);
+
+	rt5659->pll_out = rate;
+
+	return 0;
+}
+
+static const struct clk_ops rt5659_pll_out_ops = {
+	.recalc_rate = &rt5659_pll_recalc_rate,
+	.round_rate = &rt5659_pll_round_rate,
+	.set_rate = &rt5659_pll_set_rate,
+};
+
+static int rt5659_setup_clk(struct snd_soc_dai *dai,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_component *component = dai->component;
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
+	int ret, sysclk_src;
+
+	/*
+	 * Update the clock rate if Codec is driving it. The consumers
+	 * can use clk_get_rate() function to get the rate.
+	 */
+	if (rt5659->master[dai->id] && rt5659->clk_bclk[dai->id]) {
+		unsigned int bclk_rate = params_rate(params) *
+					 params_width(params) *
+					 params_channels(params);
+
+		clk_set_rate(rt5659->clk_bclk[dai->id], bclk_rate);
+	}
+
+	if (rt5659->clk_sysclk_src) {
+		sysclk_src = clk_hw_get_parent_index(rt5659->clk_sysclk_src);
+
+		ret = rt5659_set_component_sysclk(component, sysclk_src, 0,
+						  rt5659->sysclk, 0);
+		if (ret)
+			return ret;
+	}
+
+	if (rt5659->clk_pll_src && (sysclk_src == RT5659_SCLK_S_PLL1)) {
+		unsigned int pll_src =
+			clk_hw_get_parent_index(rt5659->clk_pll_src);
+		unsigned int freq_in = clk_get_rate(rt5659->clk_pll_src->clk);
+
+		ret = rt5659_set_component_pll(component, 0, pll_src,
+					       freq_in, rt5659->sysclk);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rt5659_register_clks(struct device *dev, struct rt5659_priv *rt5659)
+{
+	const struct clk_hw *sysclk_clk_hw[RT5659_NUM_SCLK_SRC_CLKS] = { NULL };
+	const char *pnames_sysclk[RT5659_NUM_SCLK_SRC_CLKS] = { NULL };
+	const char *pnames_pll[RT5659_NUM_PLL1_SRC_CLKS] = { NULL };
+	struct clk_init_data init = { };
+	static void __iomem *clk_base;
+	const char *clk_name;
+	int ret, i, count_pll_src = 0, count_sysclk_src = 0;
+
+	/* Check if MCLK provided */
+	rt5659->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(rt5659->mclk)) {
+		if (PTR_ERR(rt5659->mclk) != -ENOENT)
+			return PTR_ERR(rt5659->mclk);
+		/* Otherwise mark the mclk pointer to NULL */
+		rt5659->mclk = NULL;
+	}
+
+	if (!of_find_property(dev->of_node, "#clock-cells", NULL))
+		return 0;
+
+	/* Get PLL source */
+	rt5659->pll_ref = devm_clk_get(dev, "pll_ref");
+	if (IS_ERR(rt5659->pll_ref)) {
+		if (PTR_ERR(rt5659->pll_ref) != -ENOENT)
+			return PTR_ERR(rt5659->pll_ref);
+
+		rt5659->pll_ref = NULL;
+	}
+
+	/* Possible parents for PLL */
+	if (rt5659->mclk) {
+		pnames_pll[count_pll_src] = __clk_get_name(rt5659->mclk);
+		count_pll_src++;
+	}
+
+	for (i = 0; i < RT5659_AIFS; i++) {
+		char name[50];
+
+		memset(name, '\0', sizeof(name));
+		snprintf(name, sizeof(name), "%s%d", "bclk", i + 1);
+
+		rt5659->clk_bclk[i] = devm_clk_get(dev, name);
+		if (IS_ERR(rt5659->clk_bclk[i])) {
+			if (PTR_ERR(rt5659->clk_bclk[i]) != -ENOENT)
+				return PTR_ERR(rt5659->clk_bclk[i]);
+
+			rt5659->clk_bclk[i] = NULL;
+			continue;
+		}
+
+		pnames_pll[count_pll_src] = __clk_get_name(rt5659->clk_bclk[i]);
+		count_pll_src++;
+	}
+
+	clk_base = devm_kzalloc(dev, sizeof(char) * 4, GFP_KERNEL);
+
+	/* Register MUX for PLL source */
+	rt5659->clk_pll_src = clk_hw_register_mux(dev, "rt5659_pll_ref",
+						  pnames_pll, count_pll_src,
+						  CLK_SET_RATE_PARENT,
+						  clk_base, 0, 1, 0, NULL);
+
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get,
+				     rt5659->clk_pll_src);
+	if (ret) {
+		dev_err(dev, "failed to register clk hw\n");
+		return ret;
+	}
+
+	if (rt5659->pll_ref) {
+		ret = clk_set_parent(rt5659->clk_pll_src->clk, rt5659->pll_ref);
+		if (ret) {
+			dev_err(dev, "failaed to set parent for clk %s\n",
+				__clk_get_name(rt5659->clk_pll_src->clk));
+			return ret;
+		}
+	}
+
+	/* Register PLL out clock */
+	if (of_property_read_string(dev->of_node, "clock-output-names",
+	    (const char **) &clk_name))
+		clk_name = "rt5659_pll_out";
+
+	init.name = clk_name;
+	init.ops = &rt5659_pll_out_ops;
+	init.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_GATE;
+	init.parent_hws = (const struct clk_hw **) &rt5659->clk_pll_src;
+	init.num_parents = 1;
+
+	rt5659->clk_pll_out.init = &init;
+
+	ret = devm_clk_hw_register(dev, &rt5659->clk_pll_out);
+	if (ret) {
+		dev_err(dev, "failed to register PLL clock HW\n");
+		return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  &rt5659->clk_pll_out);
+	if (ret) {
+		dev_err(dev, "failed to add PLL clock provider\n");
+		return ret;
+	}
+
+	/* Get sysclk source */
+	rt5659->sysclk_ref = devm_clk_get(dev, "sysclk");
+	if (IS_ERR(rt5659->sysclk_ref)) {
+		if (PTR_ERR(rt5659->sysclk_ref) != -ENOENT)
+			return PTR_ERR(rt5659->sysclk_ref);
+
+		rt5659->sysclk_ref = NULL;
+	}
+
+	/* Possible parents for Sysclk */
+	if (rt5659->mclk) {
+		/* For sysclk */
+		pnames_sysclk[count_sysclk_src] = __clk_get_name(rt5659->mclk);
+		sysclk_clk_hw[count_sysclk_src] = __clk_get_hw(rt5659->mclk);
+		count_sysclk_src++;
+	}
+
+	if (rt5659->clk_pll_out.clk) {
+		pnames_sysclk[count_sysclk_src] = __clk_get_name(rt5659->clk_pll_out.clk);
+		sysclk_clk_hw[count_sysclk_src] = __clk_get_hw(rt5659->clk_pll_out.clk);
+		count_sysclk_src++;
+	}
+
+	/* Register MUX for sysclk source */
+	rt5659->clk_sysclk_src = __clk_hw_register_mux(dev, dev->of_node,
+						       "rt5659_sysclk",
+						       count_sysclk_src,
+						       pnames_sysclk,
+						       sysclk_clk_hw, NULL,
+						       CLK_SET_RATE_PARENT,
+						       clk_base, 0, 1, 0,
+						       NULL, NULL);
+
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get,
+				     rt5659->clk_sysclk_src);
+	if (ret) {
+		dev_err(dev, "failed to register clk hw\n");
+		return ret;
+	}
+
+	if (rt5659->sysclk_ref) {
+		ret = clk_set_parent(rt5659->clk_sysclk_src->clk, rt5659->sysclk_ref);
+		if (ret) {
+			dev_err(dev, "failed to set parent for clk %s\n",
+				__clk_get_name(rt5659->clk_sysclk_src->clk));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static void rt5659_calibrate(struct rt5659_priv *rt5659)
 {
 	int value, count;
@@ -4142,14 +4379,9 @@ static int rt5659_i2c_probe(struct i2c_client *i2c,
 
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
 
-	/* Check if MCLK provided */
-	rt5659->mclk = devm_clk_get(&i2c->dev, "mclk");
-	if (IS_ERR(rt5659->mclk)) {
-		if (PTR_ERR(rt5659->mclk) != -ENOENT)
-			return PTR_ERR(rt5659->mclk);
-		/* Otherwise mark the mclk pointer to NULL */
-		rt5659->mclk = NULL;
-	}
+	ret = rt5659_register_clks(&i2c->dev, rt5659);
+	if (ret)
+		return ret;
 
 	rt5659_calibrate(rt5659);
 
diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index b49fd8b..d46d39f 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -1763,6 +1763,7 @@ enum {
 	RT5659_SCLK_S_MCLK,
 	RT5659_SCLK_S_PLL1,
 	RT5659_SCLK_S_RCCLK,
+	RT5659_NUM_SCLK_SRC_CLKS,
 };
 
 /* PLL1 Source */
@@ -1772,6 +1773,7 @@ enum {
 	RT5659_PLL1_S_BCLK2,
 	RT5659_PLL1_S_BCLK3,
 	RT5659_PLL1_S_BCLK4,
+	RT5659_NUM_PLL1_SRC_CLKS,
 };
 
 enum {
@@ -1797,6 +1799,13 @@ struct rt5659_priv {
 	struct gpio_desc *gpiod_reset;
 	struct snd_soc_jack *hs_jack;
 	struct delayed_work jack_detect_work;
+
+	struct clk_hw *clk_sysclk_src;
+	struct clk_hw *clk_pll_src;
+	struct clk_hw clk_pll_out;
+	struct clk *clk_bclk[RT5659_AIFS];
+	struct clk *sysclk_ref;
+	struct clk *pll_ref;
 	struct clk *mclk;
 
 	int sysclk;
-- 
2.7.4

