Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33DD56462E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiGCJK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiGCJKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:10:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468F56389;
        Sun,  3 Jul 2022 02:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKtbHVc1RcQjeYslhXYySIbgBXaJ0GMZwOkxBOu+AkXvbXIXIgsrlY68ZigbIh2p+Mz3lFODijEX8BCYlxmmAWf8SfOks/eva7gQZD9nN3JgVTUu4XMnsuRiapvutGZiDdbdkrgh+6VJchjhHtVhyEE0hDcGuovR2p1RWiSztfsSBb399/6AUjdzFPFqHWifeBbiiDLnZYCCZzAQ8Ya0fP4z4kshsHGpEVWSLQf/Y5k0/zCx/lXyC+xSDgcRPifn1x5hi5VH/B73joYEcWbf6pXPDVa2GViOihYNdLnR66PsHH9i9nbPyx9fE+RJ+UBV3pkiYsBPxN2nfkuo3YyxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMO9YkRud2Dgs7CFcVcpItGnH1I8/OM8YjyRzC2bGJ8=;
 b=mnScqJOpEBmwd+QvWNzFNJxQ5WHPCAKbQW06xp7l4aP+sU2yris+P5DeJhk4p0tHxxM0Q+yaMRHkzoyomM58V1WyuArqB0km1KTInCYfFs8bzLlbRY9Wqs8nAI+JnG5IxMvgs/mRnnqWigs58OgiN6NlSFzS22nZpV+s8dUyR3gO7hhm/uIll4yRkd8XXX1bKAcHy/5kjNNRtMj5PAwoWSoasB7cUvlRmH13pE77trQhTDKY5COzzCi6MfPybObbrZiaF7IAO+8E6iTypAkKZtW11ny7EzhRhRCl4JuvkMqCSinHW0y4/PZxLzJxuUASBc/y8Q6NhdgIhCQrWmiuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMO9YkRud2Dgs7CFcVcpItGnH1I8/OM8YjyRzC2bGJ8=;
 b=h2qElmqOLD2Nb6K8chOfNXK9oaG0s/87iXDzOfCNSRxBt3lI15sLsYrd7FkrvygT7amhwdoH9KglNoYUL/7qtpBne2SiK93Hx/xY/9pIq/xef6FMON+Q8bBbSMACgD3qp9Mpd8mbZRjxJCh98d8wKBaBFM1VgGbzLDA2M39unY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6165.eurprd04.prod.outlook.com (2603:10a6:20b:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sun, 3 Jul
 2022 09:10:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:10:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 06/10] interconnect: imx: introduce imx_icc_provider
Date:   Sun,  3 Jul 2022 17:11:28 +0800
Message-Id: <20220703091132.1412063-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
References: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f048a12a-09f5-42de-fa26-08da5cd3e70e
X-MS-TrafficTypeDiagnostic: AM6PR04MB6165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tA3+X4fK5+ddZr5AqZUXomgq4ePCoHEj/jxvT9hlTL88OH/23JdgT8d9j8qnVDOEDXlBdUXgo397SBqzy2y2p9jvpEG9fQGZrrIGw7lwCKmlg10kUIZKcMqhQCPMaqC6Wli5ItsEyaGfZPS005rr0L/4334r4toily65S1nFn+jBwKkyD5gUr/5HeLjFNuzum4h4OcjCN6RC6svyrriAm3tDRJE4Vq/GnjoakIaGyrmoM8v3B8WBHkGf4VeJL+1tEl4OkBQ4pqOEaNtbW0L86GDLUaDMhRkzL+Fpjs4kr2nDN3OTbQRlq1CDqSri5z8yCUSWRJuOQDDd3nNaj9euA5JgE5nBxiPZqMxpVTENJ5XMW+RYqI0O1JpXygNDQtirEaOPyWKaAOFlLLorsRLTCZgT8gCLPB5FWaz1XbZ50BcvCVdyhuCzDBwnFfqAGC86MfaXpbQ0ffskrBP9lB1OePOrgZT13PfkTtEDkn2FDVRCiFSftu/PzVn4kH7Lcw5fkAX4qNlxUSOtN55XC/pbcYVdnV7nOpkubKhxvHfPF8+q3BZkWTXciWcmwEi3owfCvI4ExP/RsQxo30dWIVPv9Hg6Mdc+wvf1L8EQU3rctXEqpc4LqhC7ydkxGsun7nc1GofJckc3t83fGnJZ8f8HKhdsz3ls/R3wANUkK3qP/rC2U7xFZe+CpSgBNLv1KzZqumRZTN4QCOSlIR12oLT6GMXmnBbJOh1QrP2LPnT8AdrJe64F90WhcYLBORmN1poTNGGCegvS58UaLUwWtDpfQJ2KFw4TTO1NAQs7s/xzc5Ubt6zNMhqAz5gHauSWT7285OUTwVYWYMW1tw0niBwk+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(86362001)(921005)(38100700002)(38350700002)(5660300002)(6486002)(478600001)(8936002)(6666004)(2906002)(41300700001)(316002)(7416002)(4326008)(8676002)(66476007)(66556008)(66946007)(186003)(83380400001)(1076003)(6506007)(52116002)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LqoDlbbFP5pnVisS3PBAu92rRNltj2ryxL/jZJVJFnd8dXoP86TSFVQweN3h?=
 =?us-ascii?Q?+1YVsyacRrHTKDYdxGjxhHTGlGWaTf2sU/3BGtDgjUM6YWvT1UAsZce8eCuH?=
 =?us-ascii?Q?6K+IA7pNu/9VtnMFVzjW0z+jzx6N919LIUMuGlzLMr0G7C94aYGDPxmsgIYs?=
 =?us-ascii?Q?62dtx3/3IeJ9CDBg5Nk4ddGgydwp8VC7wXCdsihslRja3NcpeS9DdPVoO2m5?=
 =?us-ascii?Q?SvHyCCOg+1p1bIF4B+aozXvsLLij5TgrqEXLK5jnAdUnT3MJAbb0Y2M10v9E?=
 =?us-ascii?Q?n0MsQo6xWVuU1rcBuOaX8qcwasdl77zmAIKkbHPZRZDnI4EauznSIdmUPfmD?=
 =?us-ascii?Q?E5eXQ+nilxBmxeCHa9bJbYsET1Rn3WOwpqoWeor/Ld5Vq2siRPpV3Bsk4D9Z?=
 =?us-ascii?Q?OWNinZ5KCDmAaD5n6fHuXiUAimiDuJlJmYoOq1Tduf0/Pfg8qJfId1eXq3GQ?=
 =?us-ascii?Q?YdztTnjHl4JVdoTJ2A5eG20NDGS7FdBDBQtkKEv2P28/A/boHzMTKVNRmA3T?=
 =?us-ascii?Q?q30bjQpDfenvka5iqf46NTwEWF2flXLeYH58CJa6R2P7gjvIJlE6zCnpSG0i?=
 =?us-ascii?Q?ioluIBioi56uhx/aXdlTb2Iizra2ejGVJanuVfBZcnaY1k+kAkZoxJStxe6c?=
 =?us-ascii?Q?UkCvC3seTZVc3Un1TxIl7ieD9+yfgEBKZ0cti/38k9mxXcu0SfQl+9enkTJk?=
 =?us-ascii?Q?O1TI+CSDv/WrMxdXgH9vBYHWNmseT0HNLW3IL0NCZoXbXK/Gg0tGJcqDbOLe?=
 =?us-ascii?Q?izjyTbnLnNZ+4dEE1sTRDydTizMQTdaDdz/TCV98cBpc+bjPEk1Ev0tL4miu?=
 =?us-ascii?Q?R38XiWPTkyIzyj04xPMG0ne2XcZK10qIJAI7AW5puiv1n4aKeVYKJPjFHTU3?=
 =?us-ascii?Q?VequZ5MhslFEqx4oN0XGjP9PA38WfCb8eW7eLWJcvgQPR4WFCGWlaFN0oPYo?=
 =?us-ascii?Q?zci1wHVyRyna73NYk9PBk8eBRs+3cSPrw/2jH0zVN3hJt9aXxA7sA4Fk4vle?=
 =?us-ascii?Q?8v5OZLvNWAG3mv0Okco0J4ZC5MFhed9QbPmQPfJUSEoTHFi8W1o9w4/+w5B4?=
 =?us-ascii?Q?0hw8Rmwhu03v4hmcj4UcVZaaGgIuEzFi6OOiz9r9WKtPkYCZdBRLOaig5jHd?=
 =?us-ascii?Q?zlXhEDEWo9axoQKCcw6Lz4Ve13PAwUAcj+d4CtqO0SzF6z7T/hOQMOAyuoqA?=
 =?us-ascii?Q?wRFqgiK1OGAEgF8udHPWJpPwCmm50S4Q13W1NCZ0e+m2VcnBlIc4MnDocROj?=
 =?us-ascii?Q?mUo+mCVdF60+wyBrrjhPmEDJSfv1UYtO8kdy8GAobRTAfKzE6qFmB9+GudRF?=
 =?us-ascii?Q?M8k3BzXOQyqEO4duxAOQQDMW6Z8hTJdvGpt3X7fIqJEQyda/TNvhR+FdiEKp?=
 =?us-ascii?Q?fdnAbBZFPO8YpzIhyJznZzmmd4isEo5hQAKAx6v6c84ZU3f0P76YIddWi3u7?=
 =?us-ascii?Q?g3jYoAWjx9SE3UQJKaVPeGmDY5VyL4sVOOBW4EChkRDbp1TRR0XKTM8rpsX/?=
 =?us-ascii?Q?Udsw0ple6y5jVj8kVjDCeuCSvqVvNnS9mzN5XlqidtsVKGm8nsnEuGQuxOjT?=
 =?us-ascii?Q?+Yf4WHO70kMcO9Z4PjQm7pQwdaxgBkJ11LeDWHlN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f048a12a-09f5-42de-fa26-08da5cd3e70e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:10:41.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLkaKWXbL6cZQivgbCHt9dCijpyoImfK1BI5ZloL1wfQa+z1nKdkzTmoJ4b+65WVXIeOSdDuiZjJaXkt/CABvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce imx_icc_provider as a wrapper of icc_provider to
add i.MX specific information.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c | 24 ++++++++++++++----------
 drivers/interconnect/imx/imx.h |  6 ++++++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 9b83f69945d8..1f16eedea21c 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -134,9 +134,10 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 				      DEV_PM_QOS_MIN_FREQUENCY, 0);
 }
 
-static struct icc_node *imx_icc_node_add(struct icc_provider *provider,
+static struct icc_node *imx_icc_node_add(struct imx_icc_provider *imx_provider,
 					 const struct imx_icc_node_desc *node_desc)
 {
+	struct icc_provider *provider = &imx_provider->provider;
 	struct device *dev = provider->dev;
 	struct imx_icc_node *node_data;
 	struct icc_node *node;
@@ -184,10 +185,11 @@ static void imx_icc_unregister_nodes(struct icc_provider *provider)
 		imx_icc_node_destroy(node);
 }
 
-static int imx_icc_register_nodes(struct icc_provider *provider,
+static int imx_icc_register_nodes(struct imx_icc_provider *imx_provider,
 				  const struct imx_icc_node_desc *descs,
 				  int count)
 {
+	struct icc_provider *provider = &imx_provider->provider;
 	struct icc_onecell_data *provider_data = provider->data;
 	int ret;
 	int i;
@@ -197,7 +199,7 @@ static int imx_icc_register_nodes(struct icc_provider *provider,
 		const struct imx_icc_node_desc *node_desc = &descs[i];
 		size_t j;
 
-		node = imx_icc_node_add(provider, node_desc);
+		node = imx_icc_node_add(imx_provider, node_desc);
 		if (IS_ERR(node)) {
 			ret = dev_err_probe(provider->dev, PTR_ERR(node),
 					    "failed to add %s\n", node_desc->name);
@@ -239,6 +241,7 @@ int imx_icc_register(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
+	struct imx_icc_provider *imx_provider;
 	struct icc_provider *provider;
 	int num_nodes;
 	int ret;
@@ -251,16 +254,17 @@ int imx_icc_register(struct platform_device *pdev,
 		return -ENOMEM;
 	data->num_nodes = num_nodes;
 
-	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
-	if (!provider)
+	imx_provider = devm_kzalloc(dev, sizeof(*imx_provider), GFP_KERNEL);
+	if (!imx_provider)
 		return -ENOMEM;
+	provider = &imx_provider->provider;
 	provider->set = imx_icc_set;
 	provider->get_bw = imx_icc_get_bw;
 	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 	provider->dev = dev->parent;
-	platform_set_drvdata(pdev, provider);
+	platform_set_drvdata(pdev, imx_provider);
 
 	ret = icc_provider_add(provider);
 	if (ret) {
@@ -268,7 +272,7 @@ int imx_icc_register(struct platform_device *pdev,
 		return ret;
 	}
 
-	ret = imx_icc_register_nodes(provider, nodes, nodes_count);
+	ret = imx_icc_register_nodes(imx_provider, nodes, nodes_count);
 	if (ret)
 		goto provider_del;
 
@@ -282,11 +286,11 @@ EXPORT_SYMBOL_GPL(imx_icc_register);
 
 int imx_icc_unregister(struct platform_device *pdev)
 {
-	struct icc_provider *provider = platform_get_drvdata(pdev);
+	struct imx_icc_provider *imx_provider = platform_get_drvdata(pdev);
 
-	imx_icc_unregister_nodes(provider);
+	imx_icc_unregister_nodes(&imx_provider->provider);
 
-	return icc_provider_del(provider);
+	return icc_provider_del(&imx_provider->provider);
 }
 EXPORT_SYMBOL_GPL(imx_icc_unregister);
 
diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
index 75da51076c68..0ad2c654c222 100644
--- a/drivers/interconnect/imx/imx.h
+++ b/drivers/interconnect/imx/imx.h
@@ -10,10 +10,16 @@
 #ifndef __DRIVERS_INTERCONNECT_IMX_H
 #define __DRIVERS_INTERCONNECT_IMX_H
 
+#include <linux/interconnect-provider.h>
 #include <linux/kernel.h>
 
 #define IMX_ICC_MAX_LINKS	4
 
+struct imx_icc_provider {
+	void __iomem *noc_base;
+	struct icc_provider provider;
+};
+
 /*
  * struct imx_icc_node_adj - Describe a dynamic adjustable node
  */
-- 
2.25.1

