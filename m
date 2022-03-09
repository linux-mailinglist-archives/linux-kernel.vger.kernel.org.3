Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0C34D3CD1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbiCIWWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbiCIWWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:22:22 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFFD120E8A;
        Wed,  9 Mar 2022 14:21:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2ckgYhslW0OmKCVPd4RclcfnFfrVS7Zx8Rro9PmTXO/i1f8XLzXkIGThbkBB7Cmb6GGavSOWs+1dcrPb0lUXfU7KevJShZ/LjbjJ7fPJcGLAwQtLc9m0VX9iEV0dRVEUxUyvbmAdHFlaOBOiwWWcuUuzYupro7zyF8xF0eNrG5k12Nzae/vBkQN6Qk3t/zjtHfvIvpHU+O6CDGv3Y4jJJDpnIlC6WnKx+F17EDQ0EZJflZFORPIn8OWkxlVvz0KSw9k3MIMHhLqHFfj7r20fy/K3FOT+m6GVB3U1FaltudeQOKIBa3tIxHKkYdCcUay1goaJcUTXWFCKfUAlKldEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhEfDWu1ze6ZvDKWXQK6H8VW1nqMi7O8EtFzjmxrFKo=;
 b=Q7KR36K+YzMiiAwcee+A6CK5rGOnYN3KNWX3sV0b7q0DmYcyugUFDpk/pYnrB7Ti7wfoPqIjbvTxKY4y4v439OjkNLOY0aDvoYF0hby2MRXpxVPA6xZxhhsYHTMY4/QfYV95i7iOi/e2NIr80dXuIqoPPo8rWdeh9wiUaa9VDO9664Exsi7uZNHS5qGwSvucgmZry9VGOw/55qA2Ur+ba9aFdg78eNwSdoj4Dy16tJAO+3iGbo/fuHCfJNn76X3iYVY94A/v3qmtYRiWmjNQ8e1fXaxL+u8GZXscrZ7UihpZ4iB80eVspC3BVX6VKM7UlykbtxcG4KZGdkId/aH0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhEfDWu1ze6ZvDKWXQK6H8VW1nqMi7O8EtFzjmxrFKo=;
 b=A2ifYit/B9R83XA/4W+CWjMetMA/w8qLm5FhQZHL8SL9NcyEr5go3hkhYPmjz+Tv9iQAfLDaUgnO0tn96Ym6bXkePbvGq2RSN1HOA7OB2TtOdjUmekY2QCdpnHYIZ3vRuHEFZC8Qf/CM+ckYcUaIcjFWcuIhaF5cRFZfgxpURjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4512.eurprd04.prod.outlook.com (2603:10a6:803:69::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 22:21:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 22:21:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: [PATCH V3 2/2] remoteproc: support attach recovery after rproc crash
Date:   Thu, 10 Mar 2022 07:01:28 +0800
Message-Id: <20220309230128.15856-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220309230128.15856-1-peng.fan@oss.nxp.com>
References: <20220309230128.15856-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4317c70-346d-4b0e-20a5-08da021b2339
X-MS-TrafficTypeDiagnostic: VI1PR04MB4512:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4512041BEB71BF15B6DAC282C90A9@VI1PR04MB4512.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7G0WbRDVvOHGqJpaMfAk0wUMvXKnLbqSMHr1BXJZYsmNRfD1X/b6RI+aCYmSWQQyw+anJyascq1Z/3kvLNRxQDcydd3B3b1XiwvDM7w02XuPEUAJATRC+e1BTKUkJXltWUuvkSKt/dP/xiEHCGG6P2iS1cBQKVqIwh0u5/nZ6UuGXQozSGipS9kMAaMtIfTbfD9JzHb/gUXiL/R4VJBCGE5ntIYdUeo8W4n14RbbuyUU+yPS0iIlJtEWuAgtDXibmqmAqGB0plPk99rdjrg3M6OtVmyexkVbI2NqahywFC6A2LhUtnCMp0LEwePkND1VGMxIl6ymAlS/vugpGoEyo9J0UcQqZqBEVuw5hthwNFjdm1O3qfX4ip7Mn1tyDr3tgL1O8jZnNpLNSYCaQJCNpNINMypB9u8iFYK0knylqcTGUWxm3S7NYriE72ByLu++zhqCMrdbmGq//10PEDMGEgCy9Zz0mkEA4u3ljAHd+1ZAiAbmGO44kwOAM2tsa9gQ/2vFpl/eGOIk4B6QFyY7nX9dKq2M77FNTrKGgF5Pn9It1Sp40hnfFBfFYrk8/3qKYVTx4wCfFkPROhToZAs+41WBjLrltTtQmwHMaIeXoStppZbkuVmRJD4w0MeguGA6XjK+0Ab67Z0OWSvGqgVXvATUKT9iwc2Uay8H/CG70+akrGmoJkhwWzmlkE4XHFZ6lao/VlSkjd+A7+Bsc1ZyGemOtgjredEZCyD+alsa+8+kkVHWctKgRaCjne01g4Qzcr7eUxyVMgh2yzoPSeNc8c69k/kNuut35ZdlzHoEk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(2906002)(6512007)(83380400001)(2616005)(26005)(1076003)(186003)(66946007)(66556008)(966005)(508600001)(6506007)(66476007)(6486002)(4326008)(52116002)(8676002)(86362001)(38100700002)(316002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVakTZIG4k7zKFbDJV0IZdmlTxYWSm13zodo//e5vo8h5E8S5x87Y6yPPb5D?=
 =?us-ascii?Q?icTu+mLqipkSrk3jsgT+GgU20fbKOibFcXJZjSR/c4va21F3pd7g7B8N2H3N?=
 =?us-ascii?Q?cGCUwJdD6s2WGtFN4kbawObYqz33agVu2OHs9jePE58W41cyE4elebs3ZJLG?=
 =?us-ascii?Q?ieWMGK4XvRhH5yQMlWUsq46Jyc4JNa8ZXX0GYHZJ9tBuGreYZbXOcmMb+VrK?=
 =?us-ascii?Q?cH2oFN8h1eXcbBeXSjnpLAj0A12d02couiDRapTANZZ+6kL24cLAA0iGVz8D?=
 =?us-ascii?Q?DD3nYyEOiahTFS/AmslR3xmw3X/p0hw3ohY+IqkCYAo5ETPJMEhELLwPPNQo?=
 =?us-ascii?Q?aqOgcBPKzZYHaiVVpFS+2vBXEZYZoPCPI4BhThCUOppZFPtPSagXsZxNMVuU?=
 =?us-ascii?Q?+HkbpChn3bM82V3RyiQaYAM6ZVWX/X4JsPruh8YlGT4r28SaEoSEFeOMdki2?=
 =?us-ascii?Q?8acJ6rUziEOGwCWF5WZihHW1TyMiCLeOnPFz5kpbB99xnIsIwIOuk+wFLKwJ?=
 =?us-ascii?Q?2vOVuDxHPVuxku76FajwFPk6LZQq7g7mulby/3KPvFvegCODMztRbWntyS1Y?=
 =?us-ascii?Q?G2u3GZ8eDcYKXzG5yMogtT3i80o6iATbl/HPKs/J2MpDaRd5YoRYJn8oLGVJ?=
 =?us-ascii?Q?v7VAE9LEUcOeR3qlcWdolJynPz3xQtigGgzyZnIlV2Vbx4PyJdx7KF+FPtKn?=
 =?us-ascii?Q?tTDvKej+GdMSVccCrFnQGLey+5tYS53dvU1TJe5iCpLVy7ARsXQYmjhjSjGh?=
 =?us-ascii?Q?vK+CnZ1E4eyHLRKonHmktjYqiaqKDzVzH06mftcdWXmjSN+c1tp0vq6eK/We?=
 =?us-ascii?Q?263MpDZrckTujFHQgJl1MG0C7X+C4vfpwxZ6F/55QKmyTKfwaDzpTdMG6PTv?=
 =?us-ascii?Q?bI0rnJfBhsyN8AzfZOVieyD5gkHDWy1K0P3belfgD2mNs+/XiwBQ+pRbNfVf?=
 =?us-ascii?Q?sLd9CydgleaA2kTNodRne+ExDtmCmXDLobgTuaxNArpR6e0AlHgFlWpy0cho?=
 =?us-ascii?Q?i2mWLQuarNU61XFA0AAGj6eNM7V18KI84wvNa/Syt7Cv6S3sNKbTLuU9MOTU?=
 =?us-ascii?Q?zONqa2+3u+dXKPU9LIONIKvPlp+FeJrIxMSlBNiEBpyzMCHXhWK8yhc0qI8T?=
 =?us-ascii?Q?FfRX/lU45Qr6A4P6cC+2v+Uzh3U5svrOWtWH3xSUpIjWV1Umtj0Hbv+AHHzO?=
 =?us-ascii?Q?sin/duz61vkaRViH536wZw/zxG9dwftSrAsYYaA3ePy7TJLNdGIRIxM4XBdO?=
 =?us-ascii?Q?EKnbhldqiwyP6c6QaoeRiJKUlfYgI8CqTMMuF0Kiq1epP7jFck0SVoRfp8Xz?=
 =?us-ascii?Q?7xnCuCKi6c/SCxdjN5N1AWU9d2uEE3p8WswX8Fch11knYJu82EZrQ34v2Kwi?=
 =?us-ascii?Q?Ccc3JC5TP4oB6ohKodPcC/KCpQsPSssyyGk78I+hldIsTEmotdgr+46rds+v?=
 =?us-ascii?Q?hOTIf1R2w4mqD/udYmJ2Ca+aD7EZRjwTrcKHN+fj7qtx69rMObzDb64DLgKv?=
 =?us-ascii?Q?yrSMSnOUVfEnF1x2sQp/ZHxa4xbnxQehs0lJ7j905BZvd99Y2PObhbYo2CbK?=
 =?us-ascii?Q?1B/89/S32NbPLvHnaP8LchiUmYT+VuA6tn8tMfinjd5Upe9c72OcywAc555b?=
 =?us-ascii?Q?fxXA9yz7nvgEIrkmx8kHMs0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4317c70-346d-4b0e-20a5-08da021b2339
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:21:20.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Poi0I75p/6sVfTqx5hXrWJZeChi+fQ6Ys3BUyg+sxRE7ydi+kcKJF9bmh9MlJhSdcJ3zFcGBBdTW2vCVRNk+sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4512
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

V3:
 Resend with cover-letter

V2-version 2:
 use rproc_has_feature in patch 1/2
V2-version1:
 Nothing change in V2.
 Only move this patch out from
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364

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

