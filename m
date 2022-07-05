Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0744566092
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiGEBOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiGEBNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:13:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E16E0CD;
        Mon,  4 Jul 2022 18:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz0mcfGmf2QLkCxihSF2LY54Es8YwNP2CG8Ky5VIrMCgfFw2s0V4tdNjGSNjFymH/WlmgFWYzd6ly62NaPsjmORcT3B+0fF2ZQm9Y1Ox47RBiXhioAMkxF0AgQixRQ33Y1FCLBx5N2VBIZC+H0O6lmkHVpMhtGZrYaGPDKjMcUZuvdAAdu1zFvgye+B5GznBtEpeYAM4QDuik3wX6RdR2E7ftCcZXs7OUJjKSkkQ44U0/Gyrz2mv2SSKQI452uHuY/zhEC7KApLsWOK36gX7qCZwHEh8reQbzcYac4en7hH7hXBOpIVBq8rz+of8VLF+5pWcXvNgnvFvcDGMUZqDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPQbJWZPWISzBcw/TBuoplLlGV/IqikeycOVRNRmXNo=;
 b=O/zmCSItmLFbSsKCQzDpaV+z+700CQCegpODN4ybLziMSygV3aj35vUgfOz57EAFRMnecRAHtASrnwsQXnY/4RnbVCNzbskzMXucV33J2/gtpudKCn3bPDrwPvp69rLJBFmeo/nQurkkEEdVyAi+QEwtLE8suSfh9mA9DH9eZ7aZomM/ScUKMaE15c5dxY5M7zqzbiyLh62jpZ/nXzfS2mhtnonXdRJgA71vE61FS5+qs+XoQnXIlidVuVhbLmQwWUpx4dqDwav2+tj/Rj2UXAoPUHa0PQ+vqNq3HssShXrB3EWioB07unSUfbhYdlyB0tnkdZlxDMMu81/8+ZCnQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPQbJWZPWISzBcw/TBuoplLlGV/IqikeycOVRNRmXNo=;
 b=SKJUN3JuFxC1v2+0iT1Eavon6x9vLLPwOWj3c+rwxKAfGs6IUteyLrrBQsWSXu1lmeNdKEyzE95HFPqju3BxjSqM09qdnegO+puLWEUfbiMCd9s5jJfjpovdfOYW+CG/2ZOdCvMcV0jTEdiyenEaSRhMhQNnmqru0n0rTYeKJaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4365.eurprd04.prod.outlook.com (2603:10a6:803:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 01:13:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 01:13:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 2/2] remoteproc: support attach recovery after rproc crash
Date:   Tue,  5 Jul 2022 09:15:27 +0800
Message-Id: <20220705011527.2849057-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
References: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d5ff74f-28d5-4575-2fd5-08da5e239eea
X-MS-TrafficTypeDiagnostic: VI1PR04MB4365:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDys6XYaDDMHK+SjzIelDdIjhKqAmjpu9tfcGKCB/L8Mcm1bboL8DjnTA1Kw3SWyUpeBIFgg7biApINOLM6wCyCrFvdv5Qch8JfQBYB6GzbHaKylxezaRrr7dJ1mcMqp9wetxSdySMA/cCmEI1xRh1pCEy9rjPa0T+8bgOvlq9lbc2C/MmvyKW/ZcqU7oIVclIPiolYWOz0H6nLzZCDIwsMwwgi7QexE3KNdLkv2mVBxn6rxpyPye5eEeOOj3yGAk5IN5dDGHFJBtwwjB7QmJaGGemgCUxgkBrwSP7iN6JCe1AKWryIfuiSRAq5pDVNECMgwnLLY6ciIit8rvXO6tiNcqpGlZ4fCnelJsAgOwE48Xg5AoDZgDSJFSkOjOpTRSceI+AJMlkOeVgg60mBIPgH/sSqE/AW9NPA+cS5GnfTXe4R9S+WhUJZ8R/jY7GQoa9mz076bomwn5Uz2E3sa/wwH45FzyuvhIt7Z+JD7WOMG5giZyxdZCKWFZHukBBjvxY+m7wDZRH0XRkuQrxtwozxl3DwyeSnE3SGAuPTXXMrrhhnkia/ieO6JbddvYQOzQSBdQsfNk1I6O07ZVTUw12LdTjE067xuPJsLzD1Prv9U4iV7IuWOFpZClbHEulvVq0/8ciho//PoDs3Hjs/eWOtEqPVoJhRN6itSskjMB5b8sNLeNbjRNux5bkWFwg72j0QTXv/V7srNAQJes6mxRHg8IYNNVuGzfUxXHcYjhi9s272URoY1IoCYpnvn2YBtxflZzdvzGMoUhjZ3g8/NA31CVoeDm3CLk71Z43rl4vew61S1Z0id8gB17SacfzRL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(6666004)(52116002)(2616005)(6506007)(4326008)(66946007)(8676002)(66476007)(41300700001)(86362001)(6512007)(66556008)(26005)(6486002)(316002)(38350700002)(1076003)(478600001)(38100700002)(2906002)(8936002)(186003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/fwJoQT1CRYWG9BJhSXYciza7BvhZUUYgHRNOyc9gj0cx5BdhROFKDIg03R?=
 =?us-ascii?Q?GLl+mL2PCb81b0x/OL91/AtVBN4I1SQcCwhNV9jOwy4N/Ogsmdgye6Hk0V5G?=
 =?us-ascii?Q?AQSexWU7U0RJm4Q3LXMNycdnM806krxv1qjvn2H9l2I/iSLjBOz7f6Hyownc?=
 =?us-ascii?Q?i5cdfkCSJ0CSv2Xno6a1ztayuiJMV+2jm/gzkDrXD5xgcMdkiRjcY/ZT8vmf?=
 =?us-ascii?Q?27CWZCIyL9BDUuUHEjVrG/NioL2TQ9Vs+kcW31b4i2hNCOlMGu0yWpDNSGD6?=
 =?us-ascii?Q?+MEpgXt0idb50v+XWqus+SjjjxTw4APQ6UeUEXxGdjG+57nTdNBIW78Se5cA?=
 =?us-ascii?Q?Hlm3pd98WUZjRaLDdbPFkhbx5M0WPmb9oTGDdB6cnBJx/Grv58Kns1fS0ZRc?=
 =?us-ascii?Q?zZk/ze1e8VbEhJPzF7JAqAyipQV+jXvDdWae8ZfclJ0GWlZfCkjV4grcLkDC?=
 =?us-ascii?Q?75i6n19hmh3ZVSBPzyyQgtN119Njys+JSqyEDZHcI7CeMyHBKIjqhZtQL0oo?=
 =?us-ascii?Q?TJaqrm47O0V3in/xmoecUJ7ocpwfdXj6kYAH9jWQUDVBarjgXTxS/NaNjJcn?=
 =?us-ascii?Q?KdhgCibwaajnsCT+qlCy/GlyyafZ0K3dGvAP9cK0mOl5D4CXrprOlakGu7fi?=
 =?us-ascii?Q?Iu+9PtNU7NSsO01gK8xeRijvEoV57fUY44xbZWDFcsOvCy9w6XcuB1EYm6z9?=
 =?us-ascii?Q?W6cGndQ1Vhdf8pRpoQK03FcMQ3wiXuqb1TLc7wmWxp8Y6llxIM5B8l1rb4LW?=
 =?us-ascii?Q?IbUQoEbc+DWg63J9cHUXkxqV9X3BZdCznY2p1LsE8hYPKs1IhCBzW+TGMhHQ?=
 =?us-ascii?Q?9rGFPcWDjaheqdLvlKiECoRZg2FJIEFiDOu/G3A5W71Pp9UlRC8Hm4O00wHj?=
 =?us-ascii?Q?XYdjeflFe5nkOj+HjGYUFVKIevC66KF3MeOtFgo23Ypkr3C+FFcxIKFK4Ih5?=
 =?us-ascii?Q?2Ylf4ABBr1+p1j1ZBlca8c2arZaot29hczhLlTwooiob6V7lDGCbcpA2UNi0?=
 =?us-ascii?Q?8bv/HXmhn/h7gvXaeT2VCCUSj0ZzJt91izAnlExRgWs90yU+BRAK+kwlCn/J?=
 =?us-ascii?Q?eVU2jcxz/8ALjaH/taPNRIu3DuBhFbaW7dfE52UzzknQbtRPRiLarUXh6+lX?=
 =?us-ascii?Q?utffkIbWG+4f9YtzKsLrmD/ZdxZe7+EDecl+quzLxgIzaHZkL5i4yl41fbfG?=
 =?us-ascii?Q?+izOwU5FbgH6RXxORxrjbwKHiMHSJqepHIHuLwUmT9EveTj77mWAxpxv0vdV?=
 =?us-ascii?Q?3J+GN7bD5g/qyec6HRmwJ2hEwM/uOTOVHh/wXBqM/ey+LtwgZ7knS0edMNwJ?=
 =?us-ascii?Q?pWoA/paD4A4omUhvDr5WvYetE78IqHklIYBggAr4h0QVMHjPLcuFe7UYXRO6?=
 =?us-ascii?Q?v6QpDG9mbm3LdDyE9PDZmEgRMJSSwly86sQl5gZXH4Wh/dM15dsXkkhQyrnV?=
 =?us-ascii?Q?3yTqm1XYXBt3Eq5pHeeXnNLYu+HZ/xLtQRvO3G2VShQ/OcPAVDPUq5nqtV2/?=
 =?us-ascii?Q?dKde0kkAd9c/k6Wxv6Fg6E4eHw3dMrf8jOB2/Qa1wrWdAit7SX/Eu1CJynYN?=
 =?us-ascii?Q?NKtCW6I1o2Y1dtrCz3dSlQ4xGK3ab0A6Z31TzjxT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5ff74f-28d5-4575-2fd5-08da5e239eea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 01:13:51.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9viw6dqY7Ou9ODPWdKcFLnWUUlNZViagwYU8vxs1H+dTboE3j0NcoRGW4Ta929q9rKBxyRVUqZ5cGJxH8HpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4365
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Current logic only support main processor to stop/start the remote
processor after crash. However to SoC, such as i.MX8QM/QXP, the
remote processor could do attach recovery after crash and trigger watchdog
to reboot itself. It does not need main processor to load image, or
stop/start remote processor.

Introduce two functions: rproc_attach_recovery, rproc_boot_recovery
for the two cases. Boot recovery is as before, let main processor to
help recovery, while attach recovery is to recover itself without help.
To attach recovery, we only do detach and attach.

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_core.c | 62 +++++++++++++++++++---------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ed374c8bf14a..ef5b9310bc83 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1884,6 +1884,45 @@ static int __rproc_detach(struct rproc *rproc)
 	return 0;
 }
 
+static int rproc_attach_recovery(struct rproc *rproc)
+{
+	int ret;
+
+	ret = __rproc_detach(rproc);
+	if (ret)
+		return ret;
+
+	return __rproc_attach(rproc);
+}
+
+static int rproc_boot_recovery(struct rproc *rproc)
+{
+	const struct firmware *firmware_p;
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	ret = rproc_stop(rproc, true);
+	if (ret)
+		return ret;
+
+	/* generate coredump */
+	rproc->ops->coredump(rproc);
+
+	/* load firmware */
+	ret = request_firmware(&firmware_p, rproc->firmware, dev);
+	if (ret < 0) {
+		dev_err(dev, "request_firmware failed: %d\n", ret);
+		return ret;
+	}
+
+	/* boot the remote processor up again */
+	ret = rproc_start(rproc, firmware_p);
+
+	release_firmware(firmware_p);
+
+	return ret;
+}
+
 /**
  * rproc_trigger_recovery() - recover a remoteproc
  * @rproc: the remote processor
@@ -1898,7 +1937,6 @@ static int __rproc_detach(struct rproc *rproc)
  */
 int rproc_trigger_recovery(struct rproc *rproc)
 {
-	const struct firmware *firmware_p;
 	struct device *dev = &rproc->dev;
 	int ret;
 
@@ -1912,24 +1950,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
 
 	dev_err(dev, "recovering %s\n", rproc->name);
 
-	ret = rproc_stop(rproc, true);
-	if (ret)
-		goto unlock_mutex;
-
-	/* generate coredump */
-	rproc->ops->coredump(rproc);
-
-	/* load firmware */
-	ret = request_firmware(&firmware_p, rproc->firmware, dev);
-	if (ret < 0) {
-		dev_err(dev, "request_firmware failed: %d\n", ret);
-		goto unlock_mutex;
-	}
-
-	/* boot the remote processor up again */
-	ret = rproc_start(rproc, firmware_p);
-
-	release_firmware(firmware_p);
+	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_ON_RECOVERY))
+		ret = rproc_attach_recovery(rproc);
+	else
+		ret = rproc_boot_recovery(rproc);
 
 unlock_mutex:
 	mutex_unlock(&rproc->lock);
-- 
2.25.1

