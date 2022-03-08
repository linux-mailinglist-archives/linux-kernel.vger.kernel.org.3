Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A5C4D0FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbiCHGJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbiCHGJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:09:08 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50056.outbound.protection.outlook.com [40.107.5.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793A733A1D;
        Mon,  7 Mar 2022 22:08:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjVlRUSj8cvbPIKzaD5YHCmuEIwH73T3wOb4Vq93DXo+FwC6Uos3tsnOI/Yrdjp4PQomhdSflntGttBG+wlrpxpVHiYrC6EU6f1N9oX0Ui7pX9SGMWGNvxxBe8TCPTJiN8vJE8Ytda66FAbTSFWk4/EDV/9jVgcfRqMw4TtkpqkMT9z4Gb9cveAzYSPeJxQiNDxSCQKfwDz/nbl0ZhMVvDHPJSyyRIMdrMQzXYINHrHubwDvMUySpH6FsIq24ZVeLKKtnIUfT2MOWgGQNc2ufIf6xICGMRshGxiwtzmNXPMAhXmWgg5mRYnTNMeudsqI9GsRvWSAMYUJZG5Zd+IitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kl27rtUBGCsH5Da/betVraMEJ30saeOo6bRW46sqlQ=;
 b=EHneSVa6Ro/zV6+Y8dRe40QbOcPpfgOayZWNsidRjtXJP3bIfr1EAkLLrzHA/uO1I8x7w5pZpCYkLmfhlJ7pXFfswMDBvIjDTuMpWYMkwsCMjXZeAlUbd4dIEiclHvfA2tUTJ3aqcg0TdDgTx604Yw9zLK/BqpLrnUoX3h4Xm5qRvl9CcB3hmGBrszj409sAXq8zwtliwbkhc77zW3fzXmWRIWEf65H4JmM3RDWbCYsWeJ1YT4lVZk1M616QApC9Q5xH1RgvuvRRs6evYK1btrghOoRhpXrpLDTiTFerDnJ6sLnO2HIajbNAGubQk70tdktOv3ntTDAq6NZ55Jyl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kl27rtUBGCsH5Da/betVraMEJ30saeOo6bRW46sqlQ=;
 b=OD4bW2nYKcPYpvP/lshchaXrT6pcMch5CnMz+aZZz/o84s6Vu8JAylE41QX1devox8iAUz/e7PFBGuzf4J0Tdfy2XVGUjd0qI+M9YkrslhpiwehoZ8xIfu6Iyyid1+jPLKNKcmlQ6Wue3uWc6Jx40DUfWtD/1GDKTeDSbMcc4kU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB5471.eurprd04.prod.outlook.com (2603:10a6:803:d0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 06:08:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 06:08:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: [PATCH V2 2/2] remoteproc: support attach recovery after rproc crash
Date:   Tue,  8 Mar 2022 14:48:21 +0800
Message-Id: <20220308064821.2154-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220308064821.2154-1-peng.fan@oss.nxp.com>
References: <20220308064821.2154-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f7a6543-82f8-42d0-2fea-08da00ca0537
X-MS-TrafficTypeDiagnostic: VI1PR04MB5471:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB54712A5F29C253363171B28CC9099@VI1PR04MB5471.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9PJrtuWgToOpa3xI/gF6pIJgdPf+m85z7EMQ0DwWj/i9H+ZisQ98o3jKt+gKMWYIkRRQISZ3oCFpQ2Uy5Ijb1mGN3J2ByaiXdFac5InmX0JpUqMpw9m0Zim378eFqmQINDAnPntOp1y82hs/4OJTPSxwpLJ0CoT+P21QcIy9s7cu2uh9th5/DJAp3OsH0WnxNDq8nX9PzWFsvTCZ3i0rVJV2/NGwyIy89CU0SD4zGkwQXli03Gw9M1USld8d2/7F9EjLe77AaQrSlmxcBDuZWPwSDLpU31iVf4AYpnnXw3a7NIMj7cg2peoZ/DRmB6it1DeSHd8Oi/o0WAkwTe4XPQHUWq8jSsocugXjDRiXnQm7Bdew94Iao6jQR0W2msZ0U7F0+tHIrzOaIKaWuo6vdagMhNXRUKKNOXxhSBfRoMji76G0DCh6ju36xg15yQp8lgZpzc1tgwGRfWS/G43L9b4bKTisAihS6MIYkP+xuM5gop/m/s/KN+/z7Uns7q2SnnOk14BbqK3C1YZeScq/+6nyQPDDi3ZJ3ELhNYB0voFajc0Zh0W7gArrut+Tb19S6qqX/XIHxWZpyXFQn7sVWuK7Sfb9Ye/Rsgmivu6U4b/7oFQevUlTyXuWXNKcD6WPMZNDqt9trtnns9jGcXFosv+m27W/p0TS9kyf/wIJgMp9QBJ9WCEUpUIHDpGIaTeZWwtNGsEuEXYWkA+rnIfzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(66556008)(52116002)(1076003)(66946007)(66476007)(6512007)(6666004)(5660300002)(316002)(8936002)(4326008)(8676002)(86362001)(2616005)(38350700002)(38100700002)(6486002)(2906002)(83380400001)(186003)(26005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4crspq09TAAfvT7iT3KeKikynK1chOb3fjlN0sVu2FzPjXIQGIg7DKXM3IHA?=
 =?us-ascii?Q?0XTXZu/9QDrVPCXSLxaCDlvBdv4suqhNyk3DsLnQIa5CURUA0gYHlYL5QcHZ?=
 =?us-ascii?Q?lFyamORLeZ3zEpSAUcj6wqMyZ2iCg0AVDWa2xjHemHzLEsrKMdsmFLQaWWMJ?=
 =?us-ascii?Q?JhwVLg7y6k1YNbQ8F84xmw5eCIZEy8kh8Bv4RuD0X4PNRY4YZu09QLjJZK3w?=
 =?us-ascii?Q?+F0Ee5X6lXwlJqsTyJKy7DpZyBS9Py/4G69Ly6bT+maIpKt738c0ktE5kGRB?=
 =?us-ascii?Q?Hx/y602WboWlwLf9MPDipLeXLa4WqRND5gl9ZYaTce0+2uHQWLNxmJz6hS6V?=
 =?us-ascii?Q?sf2LHPXNdV3NmvQOCYyYgm08hSQmNNGnBM17LXHBX6Jfw/5w0yVYTngpbvaU?=
 =?us-ascii?Q?oWdjdza3sbZQmtgtipWojXWFQslzir0+0zP3YTSd3moexAvSoCXDzQyJxAbM?=
 =?us-ascii?Q?Lj7fR0OJrGuQwOg13SnZQgUyS0zqUYbzOZqAw45sAuAMsrjEM/eFzm0EoEk7?=
 =?us-ascii?Q?AlbIjHdBHSQP7aJVYSe7JjZ6HtGS31M9JCiwyV1i8TY3OvQovNs51MemSLfh?=
 =?us-ascii?Q?bZ9Xwv21xCW5YQ3jHUwv7wCf5GtsQXM6AyASGBzRVVXZlq+i8DY4om8Uq++i?=
 =?us-ascii?Q?8h7kUhasPVyOOhZ8HgLcmq/R6BJ4wqBNgrxmj+gNWdWTfZ6ihy2gkG+zCNQ7?=
 =?us-ascii?Q?oB/8ERxxd9+rUSnW29rlQxe8gwW2V4XMVqhx9bXPxu925WEQp54wdXWBxc+y?=
 =?us-ascii?Q?TdVINRe3OpIr0GBL7h8u3q4Iy04wKQeNYWOSCBkGaXYrYf+W9By8bd7f9FGo?=
 =?us-ascii?Q?iLdm1lIYfDiy85sPS1Z00ffJz3JFEIxBly9DYo8NbfLiBZniaEt2ZV5CSQqP?=
 =?us-ascii?Q?emVxXR4zW6kJHEzQyDp4s00FKN7sdRwso1jFs2vSAq/rpj6TjY6M2Dxpb7wy?=
 =?us-ascii?Q?zU0V37E8/wTdoCsmCMyJGAY+Eu1RYLN39nnxk0qyVLUKTgkI2g47kzig/Kkg?=
 =?us-ascii?Q?dN0BI7Z0bpTrixB8pwQFGKqM2BQO0m55Q0/64tWGX4omESxX+s5Gto7uEAOf?=
 =?us-ascii?Q?4GAHKl2o8+D0MjwzjHLaf8DnCPdI0AdItHmu7RrKDy5ko5Oqzo4Rl/n0/fpu?=
 =?us-ascii?Q?mx8TvQJrT2E4j6DXgtXuzLdLnblfwnC7UxHO9WFH9YznrwwBusOHmaBnyp2s?=
 =?us-ascii?Q?4ChtiIlIMsSsGgbdBQBS00MA6/a+rLZmz0GovU4mTeZa/nLdSkeslbEE+Zq0?=
 =?us-ascii?Q?Dh5QYPCySsENZADzDwKJgEGM5UfteEuJ9nqk/a2slme/8N/Qw1IGdG8nlKef?=
 =?us-ascii?Q?lQGWhhjtoUbA+0hbyu1XznxIAnyUAiENjpFmxF1dO6ciBS/AAFNF6s/Wp3FP?=
 =?us-ascii?Q?MqXtC6CmOSQQ/FJ9KXxGbLo/1MvRwPJTRtYOGdX3wAZYu5xC88hTKEhpKJh3?=
 =?us-ascii?Q?veJol306MV/hnVYT0mgMt9ZiLvf7iHZffqO7925RNH80I7I0O23RYb5gprrG?=
 =?us-ascii?Q?Qopp9PpfiGhSJrM+GOz6PlmnOrD+Vn3GC2hh57/we1RrSkjK5isG4CFixpXT?=
 =?us-ascii?Q?eTD2jTxUhyCFTQo68mAMNbsU4zhzScgH3RuV5Z2AobU5LzxL81eJJhTbmpcz?=
 =?us-ascii?Q?PPtavQ/5ORDkIq2mv0LqEY0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7a6543-82f8-42d0-2fea-08da00ca0537
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 06:08:09.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaORpQ7X2llgnKlwFluEjF5u+YdAMMy4cOirGvypVPM78xkXBWtJqx7HdsCCjsQNz669m9rjX/ho4jewx8COAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5471
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
processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
remote processor could do attach recovery after crash and trigger watchdog
reboot. It does not need main processor to load image, or stop/start M4
core.

Introduce two functions: rproc_attach_recovery, rproc_firmware_recovery
for the two cases. Firmware recovery is as before, let main processor to
help recovery, while attach recovery is recover itself withou help.
To attach recovery, we only do detach and attach.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 use rproc_has_feature in patch 1/2

 drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 69f51acf235e..366fad475898 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1887,6 +1887,50 @@ static int __rproc_detach(struct rproc *rproc)
 	return 0;
 }
 
+static int rproc_attach_recovery(struct rproc *rproc)
+{
+	int ret;
+
+	mutex_unlock(&rproc->lock);
+	ret = rproc_detach(rproc);
+	mutex_lock(&rproc->lock);
+	if (ret)
+		return ret;
+
+	if (atomic_inc_return(&rproc->power) > 1)
+		return 0;
+
+	return rproc_attach(rproc);
+}
+
+static int rproc_firmware_recovery(struct rproc *rproc)
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
@@ -1901,7 +1945,6 @@ static int __rproc_detach(struct rproc *rproc)
  */
 int rproc_trigger_recovery(struct rproc *rproc)
 {
-	const struct firmware *firmware_p;
 	struct device *dev = &rproc->dev;
 	int ret;
 
@@ -1915,24 +1958,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
 
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
+	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_RECOVERY))
+		ret = rproc_attach_recovery(rproc);
+	else
+		ret = rproc_firmware_recovery(rproc);
 
 unlock_mutex:
 	mutex_unlock(&rproc->lock);
-- 
2.30.0

