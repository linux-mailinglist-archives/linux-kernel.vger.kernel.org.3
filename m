Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C246E47B8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 04:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhLUDRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:17:40 -0500
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:60281
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbhLUDRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:17:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khcS/T52z1YVYjHANAmkXrqBDmKnm5EQ/8yc0/7MlkhgJFNAa7Qtfh8CHPRT0xyVuzEq7gDSQeaeaKwFHHuIJ848MjHlu/gMQiq58XGKAoZvtafnwCe+JSCpGFMP9jPBJG9u2d0YfliaJH6BV2ptgtd8ktSSZI7VP8NeGTdsV3De+Fd5LJUdPS/d6cs16Qv2Lm37sRr20Ns2zmfnocBssSVOxJboJaVz8bRgL+7FkBBbjacizqDZJe58HAdP+hxD2owtTPX/ilGyWtjn5zKxKfd9XfqzSQt1eo+n76tJE8K9FtXYC3zoLdLRsINRrXVJzpy0pHllx+iIjptLfjN5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woyRgv3p5OdglqrYJSnXx66sPyXr1PG7vkOBUgMFvsY=;
 b=CCxZlCkaCVWqcfabBlYXANpvD4+dr/zSW1qfcnVCPEv+tWjo63QWHilu2FcSOGixLvI0B+NJju+VDdt88XYZg2/l6PvExAP7wVf5eyv7EnQ+804rsWrEVH10doxX9dGGTkLlRaiSBFxIPCJ/IQLd5P02+Sb+XW/YiMwUF8eK8Kp0taWVuJHxiib5kFCTtlEAQJ/jFEsuB5F63S5p8SRJDKiaWGx+PzvQPSBNt02zwGmP0/qT4d+wh+UvWIS+f1LbQiYV20YsRYa0DGeZ/muNxPlY/eqDGrEuIUSIMh813HPlkne4PArX09/UbSCHAPB3hIHmiWVI+tSTawF0nbUvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woyRgv3p5OdglqrYJSnXx66sPyXr1PG7vkOBUgMFvsY=;
 b=NYTph51j62WS1kzuv+6ZGQKyqiFlbyO8EjKgArZOEYcohBUF3Mz7ERFCbRBZ701/FO4W/EFxnyzMsQ4xYhBdFW3yrJYHiaiIEBxgW7v2bEGk9ytc+V4K5Zwdh2AzvJ4o+zKyYYAz4XT7IV+eoFq+iyaBofy1m7YgBSwlTfPB9qY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9305.eurprd04.prod.outlook.com (2603:10a6:10:36f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 03:17:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 21 Dec 2021
 03:17:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, bjorn.andersson@linaro.org,
        s.nawrocki@samsung.com, jbrunet@baylibre.com, aisheng.dong@nxp.com,
        ulf.hansson@linaro.org, shawn.lin@rock-chips.com,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, van.freenix@gmail.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: bulk: export of_clk_bulk_get_all
Date:   Tue, 21 Dec 2021 11:16:38 +0800
Message-Id: <20211221031638.3499920-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0099.apcprd02.prod.outlook.com (2603:1096:4:92::15) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 21 Dec 2021 03:17:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d5b72b5-07f6-4b42-3771-08d9c4306e3e
X-MS-TrafficTypeDiagnostic: DB9PR04MB9305:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB93052D41C87D9D87C520573BC97C9@DB9PR04MB9305.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJveoSXlE7DinmgZB8UMZ43yTO6X0eSZWmzYgVyMe9mrgrHlnFOjSTmCR2dxDrkmP0+uZ5NawjXVCVLZJm8IETLsb2kdVWsRnNlyLgztAV+F1OlVu85hv7sy62oRrZoJRhv+t1IeM8WtHHx0npZebN38Lp2asxhDwUfgk9A12lRgJF2v9iXTh2ImviDCgz/a5GNYLHfmgzilcbsstGpeQ36vKae1GP22oU556WMdi1MpuzCXF7PZnhCe5OqPXvu3hm8PSzSuQF7ESgGMolYgpOQHm4uufv/KZZWXOZgJ4F/qHG9W53t6RpHlcRT0pdHr1GzJ6uOWplf/BbStpnF8YA3NiRbfHyJLRReO/ADmtb/DN5m0WjmwXaEfPGOKGHHEhLYEbQRpjmLVykexSLX5p4foQoGYLmCc07xJt3LK9uonLCI9z2hvuzCrqKS/N+ge8RTlUexrLPzzjHKXovsGePr3bEOyBe6vXugcwVIQSq8h9t7APaD6vroHX7sMxZ8CjKxzo+dn68BB9+JhLrzf9ZZB1cmWJc0AUsWTt9+JOL2NJ6bqQ8kT1jomCW2Nt4NVH8Z/tIT+KjnaXWAFabZKxC+NMSDvzvOeOJu/M9+NSittDiFGHXfZS27hGWzEA5xnkPRn3XLji40HuACn9fGZusJ3obdX25yrFz+mFCKga9nKeU/2kCSKAJE6u57jyTxZGycUCFAcmT/Ioc5oboKU6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(6506007)(8936002)(186003)(508600001)(2906002)(38350700002)(38100700002)(26005)(316002)(52116002)(2616005)(8676002)(66556008)(66946007)(6512007)(83380400001)(86362001)(5660300002)(1076003)(6486002)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?baXr2GHc5GekZHi+16KeNGuiGN8atSXxptbkQYNmsrOLz6/7GWPFepVrkcrQ?=
 =?us-ascii?Q?W9wLiNZ5AE4OBqLipRJ97wfJ+97ZeO0y714en1f0RN3p5lRaZkG7wX6FcQUS?=
 =?us-ascii?Q?N/lHeOPF+jwnWsWgrmoPqmVeXJkSSBNKl3a35yHqK8NefZ8+M7C2cnVeWjC5?=
 =?us-ascii?Q?l81XPiutHIyZe5VCjUd3q6XL52UqZFjW5ZbgUmlFASf/M/YZKveWuBcIRRcH?=
 =?us-ascii?Q?ZJirxNqgdSXbZ35p4MgAguNP02sGSzkrMihT5jJ7XbJJvaiyPAD3iPv6C6px?=
 =?us-ascii?Q?V39Th6fZBCTuh55m7IYQmuvqCxKcqqk3T8Dt+Q26Xr2lPJd3fPvS9+I+4YZ8?=
 =?us-ascii?Q?2dSK3ZfyDkzEsiuQIc5QHpAFiOCsjVqZN5qtpXQ0P+kYKDk7zqNaCoAUD6zH?=
 =?us-ascii?Q?mq1Qnhbg06jgOtwRF3flFvaUq4yrEZvZDv6WA+5ZA9UnbUfGb9KnLOMXwaAh?=
 =?us-ascii?Q?igrZH5VMkcNLMRA9RhBCYSv+TNSltJtq+2uZf4xLwPD1CwqthUv2n37rwOZm?=
 =?us-ascii?Q?pjWxZqJxvNcJPJNDp3T4MKvJGb9t5gzWZUQB1w4YbfORreDUIwp8A1xUudqZ?=
 =?us-ascii?Q?BJdbVmAwQr8B4ErZFO1t+CI70Gh8GSid86EtrAcXT2gnttElA2pYUvLQdYbt?=
 =?us-ascii?Q?qqHAdRBMSWpv4aHcxxu9/jWRX2UguIvLLBjn77jmp8PeApYqmI+fHC3mdQCx?=
 =?us-ascii?Q?v68ldqpGcuPbf9oVoyvBvZe1BvhSfIVv/ka7SBzxCUt3HoCucgz7b/ljXJLt?=
 =?us-ascii?Q?L32BaMLeFt+mZUtVmhySz1yWabyJcdy9xjD+xsGZXOqODMnrP0bvmELPVyr+?=
 =?us-ascii?Q?pMKpQ6mRFhBJ6pb7+Yb6g+BjKYJda7dmCeacxdphmvDqyJE7hSMNZf2htErr?=
 =?us-ascii?Q?pszPrJsGxveIoOTWgusikk6HcUe0QvWozSn+oM/xN7481Lb86E9FYte8nM7S?=
 =?us-ascii?Q?KVCC1OAUYKMI3akELSb40Ya8adC15hKzhThN4GQ4F/+OlycjTguLq33cCZdR?=
 =?us-ascii?Q?n8X8cTHgKCuQ2wnmmjdlwWiDnddSfgrh09doZdy1o1dpFg+6u2OPdoJU/gNw?=
 =?us-ascii?Q?+xEEkzHjrk6MDZgcydovClbX70XxpMaXVL7MNJlADoGj8WZljNP4wKOkARh7?=
 =?us-ascii?Q?W/aMLfXDwfYYNs+K68z7uRB56KpVwMcHaZITYSIf+XgTjTGqy6IZfJal0B0a?=
 =?us-ascii?Q?M3c5EtEwSVy6EmoBi9HSgEufreIQhmsZd7SeAFdZPq20BoOXYvbnb15L+Sdj?=
 =?us-ascii?Q?5IYBuRvwNjRGR1C5lseuklV7aOi2HEjKmNU5V6eJLnNDY0UhuFBZZ/Dlt5EC?=
 =?us-ascii?Q?jD2p4k3Fvs0nNuNWIVnq6uFHc7EqWDMIpr7Kx0THUfO8YbUzVAmjLUalZlWW?=
 =?us-ascii?Q?jnXk/KmklV3lyaw1gGVhrMTi/gq2i8eAB3gXbNP0IptU2bYwE7N3e17KlmZQ?=
 =?us-ascii?Q?rtMU+gIkyIiho+SXCHratWdx5PdhBNMXVJRoF5bXCWdxaXFdYCXL2bbrkP98?=
 =?us-ascii?Q?L51/RhHapxTZ9OUSMbzWWBDHBTR6Kx7/Zf8i+QcCRR3IMGJNN09jcsaURpaL?=
 =?us-ascii?Q?SyMVWdid70I9g5Pe0YKISaza15E7JiFT4zOU+MEUxkvK05awE9WSaQJa0yYP?=
 =?us-ascii?Q?TgcHI7oPIXwuMArd9vHrvTg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5b72b5-07f6-4b42-3771-08d9c4306e3e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 03:17:35.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+ts212NvkP4fqCMgCz5dBa8ET8baEkpu9FyGEN6kfpLWqUnxPicCCskucWguc6VZv2jhkBAaq7djFwKnBTyfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9305
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There are cases that need to get the bulk clks of a device_node which not
has device created, so export of_clk_bulk_get_all to let consumers could
use it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
     An example here, mediamix node has clocks property, but it will not
     have device of it, so we need of_X api to get the clks.
     src: src@0x30390000 {
          compatible = "fsl,imx[X]-src";
          reg = <0x30390000 0x10000>;

          slice {
                #address-cells = <1>;
                #size-cells = <0>;

                mediamix: slice@2400 {
                   reg = <IMX93_POWER_DOMAIN_MEDIAMIX>;
                   #power-domain-cells = <0>;
		   clocks = <&clk IMX_MEDIAMIX_ROOT>, <&clk IMX_MEDIAMIX_AHB>;
          };
      };

 drivers/clk/clk-bulk.c |  5 +++--
 include/linux/clk.h    | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index e9e16425c739..6dd7aac0b84c 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -43,8 +43,8 @@ static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 	return ret;
 }
 
-static int __must_check of_clk_bulk_get_all(struct device_node *np,
-					    struct clk_bulk_data **clks)
+int __must_check of_clk_bulk_get_all(struct device_node *np,
+				     struct clk_bulk_data **clks)
 {
 	struct clk_bulk_data *clk_bulk;
 	int num_clks;
@@ -68,6 +68,7 @@ static int __must_check of_clk_bulk_get_all(struct device_node *np,
 
 	return num_clks;
 }
+EXPORT_SYMBOL_GPL(of_clk_bulk_get_all);
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 266e8de3cb51..c49c7918d6ef 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -372,6 +372,18 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
 int __must_check clk_bulk_get_all(struct device *dev,
 				  struct clk_bulk_data **clks);
 
+/**
+ * of_clk_bulk_get_all - lookup and obtain all available references to clock
+ *			 producer.
+ * @np: device node for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * Same with clk_bulk_get_all except the first parameter use device node
+ * pointer.
+ */
+int __must_check of_clk_bulk_get_all(struct device_node *np,
+				     struct clk_bulk_data **clks);
+
 /**
  * clk_bulk_get_optional - lookup and obtain a number of references to clock producer
  * @dev: device for clock "consumer"
@@ -808,6 +820,12 @@ static inline int __must_check clk_bulk_get_all(struct device *dev,
 	return 0;
 }
 
+static inline int __must_check of_clk_bulk_get_all(struct device *dev,
+						   struct clk_bulk_data **clks)
+{
+	return 0;
+}
+
 static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 {
 	return NULL;
-- 
2.25.1

