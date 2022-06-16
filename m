Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0396554DBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359430AbiFPHcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiFPHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:32:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D125BE74;
        Thu, 16 Jun 2022 00:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhivMWZKGnJNCK9Zjg616phGOcilRZWdzieqdbxHrep13Cb+aE0LCOp9l51kUN/ikc8hLLtPaYhAVI6JdArdHpc8hSuevIl+I4sq6P1TFz3V0Do7K5Yh4ustkoS/BbD/FPEUSSi5yBqR9Sva1dXAwp2K+eJ5RqmjNPGTfJA4ipAawDtWsaiXK2+3DTj64Rbag+C6vUrM9+E5vMf4WMuX78a8pO18dvgBsgJzK3T8MB53hY5dJVWCjbp+kvMUo+5HsfggkBshILiyyTjxjT90uiGgEo4N545I6tHBztsKUp9CMvygecSRWMDf5HPk+x0xg3WZhcwcFV8Jp3lkEfOgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acQKgVJF7AArGjJMPl+670oOUbjqsjIozrJ1xFJ5NrI=;
 b=F5UT/HhXBTQSX3nGNAwQrUpHTpo4ejI9+6fnZ0hXzMpKwGmxSsVmp7ZYshWJBSWLWFMDH4c6DvQ3OIZhAY1Zjpd6rKCedv8Qybb1GKs/8FvowwhB4lar7eGuapf6qsZXDuNCcW0qImCE41hLyTCY9WNLfh+QgA4TZMsAEBsp/L1Jq2KQjPOl5VRDKtd33nZp98ose5vfcA1DU7y1+eE4Yn3XYL7gQmfGJ2Pr6vm1EWP/NRW87CnhQDCrZps9waO2wgUNlJSRrgplSWSMThkQLY4zFho0FcFWyhOyFYjW3tpWW+eOB10v1N5ZTlkI3EnQQKNgYpJO3v5ZYwTBc7Jjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acQKgVJF7AArGjJMPl+670oOUbjqsjIozrJ1xFJ5NrI=;
 b=MZ0f5ANOHiLGqTUh4EUP8dXXsr6/M+OIwBMKGaH008LQHV0QNZlFq/uVYP/2qaDhCotrB6oFkUytePR5VTA0qZottLMf6nguxqMgP7FjUt221Cb2V4+Zu4Zb+TrsBdKfrVYSoaVkgaSbaWe1JuLmUqAhnwN5EjoAX+70NgN4qUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB4850.eurprd04.prod.outlook.com (2603:10a6:208:c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 07:31:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:31:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/9] interconnect: add device managed bulk API
Date:   Thu, 16 Jun 2022 15:33:14 +0800
Message-Id: <20220616073320.2203000-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 739e75b4-603b-4a52-ea39-08da4f6a4c74
X-MS-TrafficTypeDiagnostic: AM0PR04MB4850:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4850EE3C65D0EBAAD9875AA7C9AC9@AM0PR04MB4850.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nw9tSfVWk2OHsvBtQgHryzBstKm3b+VX/Mp/jbMLncLM0WZzjYsm+5n6qsgqEyeYGgBgMcny658YkvpEcxI/Lka/6DZ3GQag8KOXSsws93igFdF+eLxwi7BSwe2Pm8fmJV9ya+KRzxbc/GVSeQ4LgSd9xgDlG6TuiWQS+CO3Y6RqNRMR0SGoTWMiorhQve+47psm4rCDJIV5Ku9j5LnYefIF5ofoMoYvVypS1RtI10Slf11mhSqoGKiYdTO4AQrKiPbtrx6IQ4TLEf54PY8BZSxkjVNCEpkIpQX+DZQ6+a4ahzfdOFvcZ7U+PG6bDSqG9UXQ1ZBFHcZ9Guzqm14y1rllicfUmMOXfPcAeP4K2Z+F7I4aEQn57oOhzZpR2wUIoLi28Nd3cxK5y0EQ2YHeTzXksg21tGG+FMMxLnhlNx6FEd9uZMGvTOOer8RkcepGaeMLc39+v3b0GOv3H/g+DsR9jbvedXP24R5fXQKdsWafBz3fTX2jlBTaKliSxutzPy62KpIAoU0yY227uFmF15BVaAmlM5VLaKdrAfRJVOqRjeiVgMOjYXZ0+jMq1NPzU9Iaq8kviN3ZJ5ni92LrNt91qU0ssLv33WqaBuaBDpFjcQFk3JeG8wxfdDDiHK8zKRoYqrjm3D587eKIjdLNwvTGk/cFerAHpASvBRVvsJibhAREk19MeK9fhLW+i49k3MvWzd1r0c7bcwgNZr8/F/Dw1xDdxJdwgoCwucQcbxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66476007)(26005)(52116002)(6506007)(4326008)(66946007)(6512007)(2906002)(66556008)(2616005)(86362001)(6666004)(8936002)(38350700002)(316002)(38100700002)(8676002)(508600001)(7416002)(6486002)(1076003)(186003)(83380400001)(921005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?okSBa/8+GeDabKszL3ASLETfYSKzUrQxf4yhWJ9Dzv9nKpscojRWr8rHHcs8?=
 =?us-ascii?Q?K2SVjykHm4oRNsIPvWyFy4SP5UrrXjcQjijpe1MdT/+5M7CSdCWm7UzgjImj?=
 =?us-ascii?Q?mAuwCcuUHXDHSVnZDQ2zQZA/J0V1VlzC354EJvI+YP/vko3q79i8MhnHtjt6?=
 =?us-ascii?Q?LnpWf39v6d42Xcg4CnP3CKUc6HR6w+IFJCDChD+ylffzAR/XHzHKrj2WdL/0?=
 =?us-ascii?Q?luHblAxLinOCB+zKkqbnYoiQ803wskyujhkES7d9lMAMfp/C3Ujh1GWuGBlB?=
 =?us-ascii?Q?mIU7BCFfLLtZHihG3JfgwDfvQ9HMHHryFOAE7f6e8nLjH/A9rFbSnvar3Mnl?=
 =?us-ascii?Q?vH3AWjUhXTji+YO6BPXQTCqiiz9d7mn5QFsvVG+9jbQnnJjLAzVgs8eL6lNV?=
 =?us-ascii?Q?hsgttb2QrkFYy0mLTkQNfD8sk+aU713MaQ5/diFU8FImYgskUaYqA6hsPBjm?=
 =?us-ascii?Q?lFRxFs2DSOebFWPT6a97MmkGycLpIc9W/NATSIniANDMlkIJdmbfEPtykSnp?=
 =?us-ascii?Q?uQroDt4FTS63TU/fUMrodqRVrx2kNXI/LCZ/D6TCIEho4ledn4vk7a6M7t+d?=
 =?us-ascii?Q?7+C5I99f0qJgrRkZpQqbIW6VsXgKvxZ24iB4zcvPRmIm3qserLng4nPinHyw?=
 =?us-ascii?Q?/XMcptJZQOJpse4PfIgzpTeiWK9vfvk5VK0ttko37AZOdAVCYdSzebk074Iw?=
 =?us-ascii?Q?8/4+evavWYLA9qAgp6xmz4BiZ3bd4Ctm/ut0cagtBH31qZkW830SnJwP+3yv?=
 =?us-ascii?Q?2UKOoy+qc0Di658AE1WwP6/+HmLY/sl26UEVwohxNLy7QI0BP2+ZejkcEfYM?=
 =?us-ascii?Q?wRb69ZfSdbkPpLEO3R74N8RNhyrCXOQ8Izh7LoECm0QINz1m5d+yILEWSCoS?=
 =?us-ascii?Q?E4wZi6mfBd66BPpfpiI7chqVAD/EP7kG8axt4JcIE0sYL4dl8eG8KYa8U1WC?=
 =?us-ascii?Q?8P/3bK73FtI4cdf8mkUHu67KycG2BebDizS5Uo6pKcdPcyBwMLJzWXvVvAi6?=
 =?us-ascii?Q?AQCpvuHCBId3nF9GX2Qrq+RDT9l+3YXUO+kr3UTyk6HuypPL6hz7+cmnMqYa?=
 =?us-ascii?Q?TmgKwOrdFtjQ1+1VwY/xGgo5o9DzXAave4qXEO2unEQSfxarcFh3QHe+0mhz?=
 =?us-ascii?Q?PE7/+h71uuJY73Wp435YxkwlgYRWCKo6N3djN1n03CPmtgufI5XxXjG6X7+C?=
 =?us-ascii?Q?jG4lKSl7AEO937jZxQHIRWROTFa9fgdnCfkHm9w6pReX2Oo5baew7aQm5h1l?=
 =?us-ascii?Q?ffWEzybS7ohFxuraQomv9ScCczzzDY/df9+1T5/23flqD2+08ZCtz2EY/xvV?=
 =?us-ascii?Q?Ul9efOgHL9TT8C7YtG6yWyNccZECNFSu4EmcLq6/w776Pvc5UM/1X63Gd3Ck?=
 =?us-ascii?Q?cVOpV5Ob+u773iNAQZzTO0zpwZxBsNwYrb49tSJDZCdbQikFXR2qUK68HaI8?=
 =?us-ascii?Q?W2V+DpSikrrx+uoeI1z0HA5+K+TP6yewI+EAYwxuJpAmxt2pDT6OA3pb6XLJ?=
 =?us-ascii?Q?mIidpgIsoiwhUZrV0BYzLS2Sb3G4c8/mbjjiCDx1/K0+oFjMbpmuOwNebomf?=
 =?us-ascii?Q?tSdJWZ9vdHJeaeySXfE1gVqjJJF7J67BV5bwh56EX3F3SpLZfl1IRl8OkvlK?=
 =?us-ascii?Q?ecPkuxXeHP1jZA+kuRH6omsxnM5cAy7aVvdO2wQBUe8g5ICNAHGl2Jif+Uu4?=
 =?us-ascii?Q?UccA8xXTHxSNU+xRCwop89mLjcbqRQYzWXBevaWO8NsbN/TWc0Irxg0A+O5p?=
 =?us-ascii?Q?2o5UlRmY6w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739e75b4-603b-4a52-ea39-08da4f6a4c74
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:31:59.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SO3YfkjS95k3etlvfUOmv0DOxmZX6fFT3BAswGkX3gvcAyuBwZYXjoP3/0l96UDCndzrO4vBrHf/2G5Uxl3PwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4850
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add device managed bulk API to simplify driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/bulk.c  | 42 ++++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h |  7 ++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/interconnect/bulk.c b/drivers/interconnect/bulk.c
index 448cc536aa79..8b1d8a412464 100644
--- a/drivers/interconnect/bulk.c
+++ b/drivers/interconnect/bulk.c
@@ -115,3 +115,45 @@ void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths)
 		icc_disable(paths[num_paths].path);
 }
 EXPORT_SYMBOL_GPL(icc_bulk_disable);
+
+struct icc_bulk_devres {
+	struct icc_bulk_data *paths;
+	int num_paths;
+};
+
+static void devm_icc_bulk_release(struct device *dev, void *res)
+{
+	struct icc_bulk_devres *devres = res;
+
+	icc_bulk_put(devres->num_paths, devres->paths);
+}
+
+/**
+ * devm_of_icc_bulk_get() - resource managed of_icc_bulk_get
+ * @dev: the device requesting the path
+ * @num_paths: the number of icc_bulk_data
+ * @paths: the table with the paths we want to get
+ *
+ * Returns 0 on success or negative errno otherwise.
+ */
+int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths)
+{
+	struct icc_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_icc_bulk_release, sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = of_icc_bulk_get(dev, num_paths, paths);
+	if (!ret) {
+		devres->paths = paths;
+		devres->num_paths = num_paths;
+		devres_add(dev, devres);
+	} else {
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_of_icc_bulk_get);
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index f685777b875e..2b0e784ba771 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -44,6 +44,7 @@ struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
 struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
+int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths);
 struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
 void icc_put(struct icc_path *path);
 int icc_enable(struct icc_path *path);
@@ -116,6 +117,12 @@ static inline int of_icc_bulk_get(struct device *dev, int num_paths, struct icc_
 	return 0;
 }
 
+static inline int devm_of_icc_bulk_get(struct device *dev, int num_paths,
+				       struct icc_bulk_data *paths)
+{
+	return 0;
+}
+
 static inline void icc_bulk_put(int num_paths, struct icc_bulk_data *paths)
 {
 }
-- 
2.25.1

