Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630BB544C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245438AbiFIMdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245430AbiFIMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:33:31 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F39F186FB;
        Thu,  9 Jun 2022 05:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcCZmgsalLaiq1H159KH4P0pS03RdGeaUGs1ws5V4wXOk9g9idmryH8LYqVyKcI+fwNh9TT5kwoLTh1kNcuqhn0p1BG8tpVR7xEHz6avm9P9FzZx6XXhxrlfmBpxJB9GQ99aev9KUt0grd+mKv20PPI2APk1YuRzW4HmMmB3nc0PtB0Qo3FKLfrjVzzxG5nbDFnUmXzakNIcS80nqIOayPRa6RLrxDgY1gyLuAKAlB7nuwFFweH98oauVmoyAmSaZRj3sY4oqTZsK3oqWzp/SWxXcMg8WpggAUhl9BOTacjNd0SrZ+QEFc9ia6GCQbl0NTVKQq/Nmy6UTnWC29Yr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AhxINjBYSayOm0wbQf1JweZvXYsx+vRUb4sT7T3218=;
 b=AKXXVEQyVcO2Q3cSI5C9FyFpL5ui/sYilwqBFbhtZLrmkEcmnLt/zCQiKwOGlL7PPi4WXzFceOjKqqW/mOaYmCrlkcZ5RqVCGfQxbNpwG0cloa83yGGF00kvrU4ozj/hAIKTIb1601sE4g1XZld4ihBpv1d99Gwn8qJExj9esFtgrxXgp34FneAICGTj0nMN5uzJ651FsoWJplwPEbRngPg6WuroHlkLiqlC4zPi3uT6zASpvl5SogeVqD94eSebOeL9tqvoJi8xVkl4AZ2ZdtSuSgVoarSLgpsor8D3gzktthWEtE8c6Q0arWLW2g/stL9U24FaW+Zcu8qvkwXYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AhxINjBYSayOm0wbQf1JweZvXYsx+vRUb4sT7T3218=;
 b=IGbUANeHwv5qn7rGDp7lflNxCMmCAbYxFSguM7Lsl7QqXhKHzRxAEdBkDjqGywFo/8bxTFbw9JNIoq3aJJUTmxg0E4tJCkvZmp2HqEGFI1r/CDhkoEuzEQkRZdTAlvBWEyF4oMG93/WjVkEXe54nxaz3vaapMarS1Sjhnkk8R9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4475.eurprd04.prod.outlook.com (2603:10a6:5:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 12:33:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 12:33:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] remoteproc: imx_rproc: delay after kick remote processor
Date:   Thu,  9 Jun 2022 20:35:00 +0800
Message-Id: <20220609123500.3492475-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609123500.3492475-1-peng.fan@oss.nxp.com>
References: <20220609123500.3492475-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9326d93d-89cf-4ea9-412b-08da4a144086
X-MS-TrafficTypeDiagnostic: DB7PR04MB4475:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB447513A7052EC7A91D0F43F4C9A79@DB7PR04MB4475.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egwSX/+GT04amGr8JyZoRsFKs98P5jPPQSE9TSQ0B3UqumPQEnSGrVjzbxFFAGBlJrkOU2qnyYeGcpIQoZb1x5IjnIFDcvflCRJuPPuWysITT/PNjz/khmx3V7SxvNSXwtqYxAnj0UYWk8+yryROcrpISA/wF5LJQWw+PSiOHg54N5q6tA3g+EMZ/GMRuAh2ZL9EI+3zwyc9Yjbq+oK5YKEyaOW1KBKOoPoD6H4uJ3qxizwyMHeknM/rfjct68HLjsDpqExWyuawSuUHbdPSOoIYl0Plsu89h/0YR0U9WFhVVQU4/uakrhnSrbVj990Aw/vMFiucphlgIccLnqxm3PuUs+jSKMJb5XXaHL2pyeC+ORXoSClUJnj8LaXXJRhzAdILxRVMgmiIjlZd2WSk/CfycnMaMaEYQXR5HtcWK0a9Tz0CGC8WnTB5q3E4f5RDHWduGQrOBxRRdy2VWMbSok7PqMiggjiWJB+B7jaPj4MEnp4Qoe2yl1dmw1RUrmFapU8ikz6ao73TZQibr7sbEf7xCUU2wPGmVjSetFpboRI5WOjLeJxbfgAEEUWCK5dvVnmh/jmgyQjczRhjnSgxzAodSiWUeTO1gL6ZT6tJ47z8cJffUvxhn9yG4JJYSc0hWGv3L7ORlp1W7YQRXrDBUdt878WRNWyKiLJKvEou0GIdNHDrLx84yzrRNG51zybHGiVArJu1V/5ba9MpCUj1UPguVlIPERHzQBKra02w17g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(26005)(6512007)(4326008)(186003)(52116002)(316002)(6506007)(1076003)(8936002)(86362001)(8676002)(66946007)(6486002)(66476007)(66556008)(83380400001)(508600001)(6666004)(38350700002)(38100700002)(7416002)(5660300002)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MMYjQ2rjZ1Trw9p+lIIX90Tr7D18oEeUFYzbLJgWLUGMYPpMbus2BkBA24R6?=
 =?us-ascii?Q?3QFn2gVupaAWAu4LXzRZ1wcRtgOEJbxGO2OXs2d5sMHH8DWyp1Rj/S9Tmorn?=
 =?us-ascii?Q?LPc+Ymlx1RprX0kzT4NkNRsoTe/pfHZnQlyegYAm6uIshm3IqRPSEgBZP/1F?=
 =?us-ascii?Q?p/Iz9WK0fitbtrzz6Uib60+ol3xjIY3Nem62P4wvorFtrwmuIEsr0NxpEDKh?=
 =?us-ascii?Q?8ecYENeCT1O+i3Ia/VgYLoRaXZuNxeavhSeeIi3DvF+yokWsjCgeEJarRRD1?=
 =?us-ascii?Q?CREjHo6vGxymt7ntLfFzBGUPlocgN4TtBRYdomzezYAP3BkORnCWlK23ouey?=
 =?us-ascii?Q?Fcey8FbhWa+ZuHU/xwGWCMKqSr/lJuIGaRLitm6FtM0yfGA9JQZ6avewkPsa?=
 =?us-ascii?Q?1l15pggFgCOiYXEfvqUt5/zh3t/tpwjgBfoKNv/bOeyMS4lv0MKaXax9/V+i?=
 =?us-ascii?Q?EIQxEp1YplMSpFO+9IUmKrkwQ5go57A0KKcFMCPe2IhxLlDqFFxqq5ZQLgt/?=
 =?us-ascii?Q?WYqu8DYjovPVfeFNnfGfIBpboTTaXAeIekypwa0gIPpwEHUX8pZamJQ4TjE4?=
 =?us-ascii?Q?ONuHrEaiNyxDuzWq9MKOyNhKhMtOOM10mC7PPU2zmxlJAiLIKW1fi2tedNF+?=
 =?us-ascii?Q?uDh76ydvKHl6kxQUijAxI35GUZThQvjaEOm2y9cXQSpxquS6+2PfM1tHLoBE?=
 =?us-ascii?Q?urR6w6QDthKE9008cp/w0OrRbrFbaJdG4yTSTXmYz9Mjr7XRq0ZOMZYs+bDW?=
 =?us-ascii?Q?xXdEfrtkvsjWNx2kUyPTOugbiLHq0qs3fhvMTEA1qyZKc3DYbMczIybE1ZA7?=
 =?us-ascii?Q?ejf3SF5v+ziMTfj03oquEL5FKukSqQibOA7SUHPyaPy5HVaFE4h2S6Liy3RK?=
 =?us-ascii?Q?HNel2wKN/3CGLwZVe3+8CUWsHc1fiV3y8diCrIW4UVxxlNIJF8qvpd/PZSlJ?=
 =?us-ascii?Q?i1eoUewqL3TYct0hdhCzpEvsmdXMxyAIPugmIotjgiWDDDYz+vYWIbwmq8AM?=
 =?us-ascii?Q?jyhv4nJ3WJYg6x/kVMl7cf6nm4zFZXM9jdlmN6cfcwNEmkx31XCICd5GAFmG?=
 =?us-ascii?Q?x4oNQg5bx93oFXiaRUh+cRESjCxds0m11Yes2R9cYrUXRfaBuPeWhO0RefOn?=
 =?us-ascii?Q?gog3fhn9B3UpgHoOdCp7bSNkrOemoIVeYXcMvdIRxJCU5hWw39uLK/L2IAnX?=
 =?us-ascii?Q?+6ErVBA210g5+cBHY2gNL46yGZk9JhR/ohNkl6uuhz49c0sofCisWr0bZddm?=
 =?us-ascii?Q?vNiBg8N6TSCAIzP775xQc/60YNjynkMqxPkYU25BPO0r71EFtXhLLGLbaka5?=
 =?us-ascii?Q?5MLc2nhnCAoK34xTKJGwccvFGsXNEBGQjXkSnloWZsbPqGzBhUyXOtG5KDQw?=
 =?us-ascii?Q?VW86ULzHCC9ahCtGGWtdU4npI5dH0/CwzaU7rwNZcpFCCMNuXpoUe8YN5W0R?=
 =?us-ascii?Q?bTfQYnMub4Ys44QwaOb4yiDUKAJB2LnHs2QOB3xMLjNH6p1Iy8KnF3FnaxD7?=
 =?us-ascii?Q?uOhvcX5rdAEg+ShlPQuKKDM+d/YXsugD4M+mjPWJlYD4FRCIQrrVPSZVv4gg?=
 =?us-ascii?Q?jNilOi+++tYzPLXw1GN4/HfOB1LMeAALtzizaHzZ7dctzLssLddcOOJhhY68?=
 =?us-ascii?Q?Ozd+zfOTRu/yxwJ95mwNuu9Ufk/w01qMqOPcjr2MUiMwnu0llkoEWeje5gR+?=
 =?us-ascii?Q?BBdddyLqiWyAFaFQVDBpUZDGbrLTa0h/L/PcY7Ep06sio6pO4mwV6Hs7rk3x?=
 =?us-ascii?Q?dDR5tWbVsA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9326d93d-89cf-4ea9-412b-08da4a144086
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:33:27.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzNUcoW0fiOpkrpO43EAeyjS7WPgwNltXwOL/lV5orU8LX6FHn8ptvopS0dMeWtKlctKFEZKjduGcWFyRRVtAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4475
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is case that after remoteproc start remote processor[M4], the M4
runs slow and before M4 finish its own rpmsg framework initialization,
linux sends out vring kick message, then M4 firmware drops the kick
message. Some NXP released Cortex-M[x] images has such limitation that
it requires linux sends out vring kick message after M4 firmware finish
its rpmsg framework initialization.

So add delay before linux send out vring kick message.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 8fe139624ecc..ad0fec128504 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -6,6 +6,7 @@
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
@@ -109,6 +110,7 @@ struct imx_rproc {
 	u32				core_index;
 	struct device                   **pd_dev;
 	struct device_link              **pd_dev_link;
+	u32				startup_delay;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx93[] = {
@@ -381,6 +383,9 @@ static int imx_rproc_start(struct rproc *rproc)
 	if (ret)
 		dev_err(dev, "Failed to enable remote core!\n");
 
+	if (priv->startup_delay)
+		msleep_interruptible(priv->startup_delay);
+
 	return ret;
 }
 
@@ -1020,6 +1025,10 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	if (rproc->state != RPROC_DETACHED)
 		rproc->auto_boot = of_property_read_bool(np, "fsl,auto-boot");
 
+	ret = of_property_read_u32(np, "fsl,startup-delay-ms", &priv->startup_delay);
+	if (ret)
+		priv->startup_delay = 0;
+
 	ret = rproc_add(rproc);
 	if (ret) {
 		dev_err(dev, "rproc_add failed\n");
-- 
2.25.1

