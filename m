Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA620563042
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiGAJfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiGAJf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:35:27 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30046.outbound.protection.outlook.com [40.107.3.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452FA747A9;
        Fri,  1 Jul 2022 02:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgPo0njhq/NQ2eqRefo7vawrwZu4Vv2qhdL5Yst39EUTeiZ+r9sNUMqcdRmAGW0dXuwYVMpH1oyngBWqZ6Ax4/lKKLmRz1s45/uLUB9PNzfSeJT5umPbkEAtl+95B9W/uiUfBMeAEWcnk859Nq8wBDWZ5G2ZMj6y678beU4FMoA2Jrtj2PIggFd1yl/j0fXbZvdXVtayHssVz8cqf8tBVFIHMfXv7XoYT0UooCOTb+1poXqGgw8KbsVSo00BSaaEf0vAYGhSwyAmUXnV3OaT1P4mkz5d0h/o1v+dL1AD+YnGq/8thjp49Bq1RJiZfUEIsCmM+ABF3SIQGGzTjCGkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otVKadlaaoou49b+fDAQ6ZmGz6y7tRTCzm2rje/Z1yI=;
 b=bP/nm+XOfzPIG1XOXgWRoyhrZf1vE8tteccTMvGmVLQFSD9V0iClGSxj4vnj+TZ3+CPvIBiI/UA9ObG2nO+vfIv+iunbkx1Bexo5iGUiF5x0ZZJUE9KVcByAbbtsQC1xeyeOTBPmde27/6LKW2JqThCHJMP5dhtz8doUrD1g+Kjuq1wZl5yunaRn+Ai7JZCgEKM60jePzx91DLh0ocOgxwjWkaoAVFv1+FU3eeuAcI0E/0R5lQMcS2RGBU0cU/pduMcgp1zb+SyroTqgUfxVxnAk7UCXuzwn4GcymbyhOS3fw7z0WPQEYH5ojcQGyatxUd7N8EKnSeaqGAMHZkygUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otVKadlaaoou49b+fDAQ6ZmGz6y7tRTCzm2rje/Z1yI=;
 b=dGgDxx9HxH/BFUxp/cHaUgFc66SB19X4+nOZIJxFefDDm+dujQe7/Ng5QLxLyF15Mqv7n2s0z4tZSWsh2j/M1JZPQ1H5sEN5AcFO2BjWWEKSjvDUl8+nMbotksh32ql2dD7rHtPdNeYiTW3tHl246whGbMZw/z3krGOk9YGOgGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4655.eurprd04.prod.outlook.com (2603:10a6:803:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 09:35:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 09:35:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 2/2] remoteproc: support attach recovery after rproc crash
Date:   Fri,  1 Jul 2022 17:37:02 +0800
Message-Id: <20220701093702.265249-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701093702.265249-1-peng.fan@oss.nxp.com>
References: <20220701093702.265249-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0c8e266-73b6-4154-7af7-08da5b450647
X-MS-TrafficTypeDiagnostic: VI1PR04MB4655:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j91gj4Pfq+7kf1IL1BP/e6TaIv0qm5TU62uNDAqhOmob6GRBt9kCiE/XXFVMcFdsIQGnGPQhPArw/gNAS+tNyNHdqyu8sCLmjNeWe4KPwJQr5X187M0vVGhDWxzG01rboJIKnpy+WSBfl0wcqEhMOi4qEzr7Ox0VMNBZZwPoOJFwDHeGBHojBFs8BwUB01aD6CsYzKgOxbzeRn71v1so1qq+fwGyF2gqhNLWWU7viXzQ0RsttqVy3EoXiFsQ/HQWnAaviqVDwuBfuGhyudQKuQmievYCv6XjhBQ3aQVu9HeJfodtnJbt0LUACvEEBYm8D90CDZmf+YLxJcd7dmHEoQgTjgkDNuyk4jIQxcCly6l0noL9n5en83ZzliJIjdTEIiSF/spUDa3q+EAVYXv4cbQ2cdiBPZTMKnD8+xattkJHKtdAjtrIPvZSVhWWGeI/kggCDSSNyhT6oAOlZrxmWk3TTZTt0Xeq3UTCNGZzgaWW/syiMKZAukKfxnaob3MzC5pFw9hiCKvTE2T5z8hqhCeTm9mFx9nWMcJ1XXK5Ng8MIuOWd/kWXkMEMpFearF6o6ORW+Sk6KDtncecH9RhRxzOMNCYD422aVd6+MY9xj02Xtf6X4EfMUrMa8kQQZU0TFZdHFjL/+4xyKlC5xq6lyiJeqCZt1DZC4mt3a9MBuI3x6vlrBRGmu52o4f3k9GrxETtiB4hgK8HUhUDHL4rQhgb4Km56G/8aGLNwmKK/lrg43adbw56+SHAyU10hxX9Vh4JYOHC49yHdR8F929KkielRr3/pnmSopPPPkOHdJuXTzRmFot3zCTYkvVVQJwU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(1076003)(316002)(66556008)(66946007)(4326008)(66476007)(2616005)(86362001)(186003)(2906002)(8676002)(6512007)(8936002)(5660300002)(478600001)(26005)(6666004)(52116002)(6506007)(38350700002)(38100700002)(83380400001)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ac5jLxBN6Lx+Bh32IHu1sCNDOKhMzRzoXMykPQFSZe7tPLA16oVH/M1ddgy/?=
 =?us-ascii?Q?DdGMM+zy6/517cG5dKh8wrv/HddMfY3cu6gYXAnMZSMrfXhnLppLEKI9+VoU?=
 =?us-ascii?Q?o+N3Bq9nXvrckUCgLBz5SeybH4VjplTIcTsIn6jVxlSfbJALR88MBFpx+Cu+?=
 =?us-ascii?Q?lA2SZiTxaTdhPBu6DnqFr/p395N1tGS5SGvSqEgTYbSihrUFUWIJJqTGNg2t?=
 =?us-ascii?Q?78pHEVjmKP+ktl9L1wwjbO41R3CrHNuyqFYz2vUzJHQeNicKsGuIjqC22z00?=
 =?us-ascii?Q?J5Q5PlpsESh1p7KXQtz2aW+ACoxqKjb3CVeoMUFxCejBvtfr5is4S2kgQgMg?=
 =?us-ascii?Q?dKMvxJwHTw3qotk0kr9AtIZttMzgX4wPnhRurhnIxEj71JD7x7ZIpkwwDD2w?=
 =?us-ascii?Q?a/ItjDOssocEMwpBZutppopPr2pzMzUWglraEboNm8BNP9d9UiwPSDduE6zJ?=
 =?us-ascii?Q?XPX8euMnD5W3rR6dCCex6Ru0diR1ge3Augozlz22/MKkuRMrQPyooNjxajP5?=
 =?us-ascii?Q?AphcgVArfPZfyuL/RJhf6IPgJ+V/53kjmb1czSmK/igfk6Wcc2PRu7MAtiYP?=
 =?us-ascii?Q?yAHzyvlLblCqeaaN3YA1DUxiIe5o8XcT1L3r0Dx9QsZqOJWfgdf51o+NmCvT?=
 =?us-ascii?Q?v+VvDlPHlbQ/QSa6zLCxpBDU51anSqxDgyyO7ocHGE2LE0JO1xwWFOpG6q70?=
 =?us-ascii?Q?iBlTJoG9u1AULSkySH6z/jYw2xTLWrHefvVK23meSfXqlBZPSzp4HfmUEq7k?=
 =?us-ascii?Q?V8stOp3UVEH0YsFT7nNLuWsxMwtB+cpMmWPk2G6PpLANcfzbfUi9sUOXK3Kc?=
 =?us-ascii?Q?RAg5pSqj+eepXjzuHM3afi/EeNHTF78lf8wWJTF+vW+CKPeBMD9XLs0nfL7k?=
 =?us-ascii?Q?fHc6Og+l+EG1KfVbUY0jZXrRP1m+AnUq3JtbnE6jHOQD2KDSGFCzhAA8Ktv3?=
 =?us-ascii?Q?1d5lPdrouC8d6AHx241Y07P3JYqEWvsdPYhRLnPDTva/maOYwOvia1+TfeaX?=
 =?us-ascii?Q?1iQ/SxbZqSG1LE06/7ppgdiUvjF742Sq2kDRC7jDM4nHQlcPydQo2QFCj4k+?=
 =?us-ascii?Q?+6jD7M/WgEZRIw3bkqFil8wFmZwLD36Lnp9Gy+6RZc8/YEkXKTJDcO/CPys/?=
 =?us-ascii?Q?54uo/t5Pve6X2rQJZguqWP9lVkue6LYreIXsfRxTLViCpOEBd32Pk6b5CG1V?=
 =?us-ascii?Q?KlsEPo5oV+YfFtjgjIUW93lC3A+QIhLH8iTGGU8RYI7BtWkTieKXdw7icDdy?=
 =?us-ascii?Q?7ZrD7wi8Oz0AhMJh/81le0MJ8hucK5qkXsGAd5o2H8YdiedxvA5H4QpvRVAY?=
 =?us-ascii?Q?D9O0+F+cIrGGaWWl4yGwvpfYtNIwWaZppuBMrqzaHI415T9ueKHZDaWtkwIx?=
 =?us-ascii?Q?l5smm68x6sFmcl6XzxiLx3Jmvz5jLPHQSU6rKJRsBGIUH3qJN2pj5R+58/mx?=
 =?us-ascii?Q?IjKtrNoTkCMM4qYT7DdhT/fRLzmNQjFFPvtU9p/+N4q7YsZdsIIaQGkB9sFx?=
 =?us-ascii?Q?Baya4MEBW77UH4Jdt54rqNCwStHfDY9+ppuMzcI5HegbNaZ+PPQSDv5ryVw2?=
 =?us-ascii?Q?xN4+s5XwzXJOcgghzxV8K2IzCShI3gw0/0EcFwRc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c8e266-73b6-4154-7af7-08da5b450647
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 09:35:24.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivejuijwqkQEm2mpb6AzqjcPuY4LTe5o86nnLzlfxqCndcqYFC5pgl2oqKNown7MqLu39pf054p+gJVG1/VteQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4655
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

