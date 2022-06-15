Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575A754C016
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbiFODTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346045AbiFODTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:19:08 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00042.outbound.protection.outlook.com [40.107.0.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DD46674;
        Tue, 14 Jun 2022 20:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL5Sw+4da2OCVBdmdkP3JCB+/Xy1grIfjB+gy4H+dkz5yDbYUpI8wx/9RA9WN4y/Dtb+5gbEZ4xqW2UKO540vUAv6IcA3irnljTaoda3GNmj9JkO8nueRxCwbZ7u54cxW5duoOu/JV2aZ59Gdt2pi2grshfTlNOEU0MvpuwL8oVkX528pOPHHHaBzhZyzuvZGUOVR9OUwyolrmHZKEVRpItdVOS0cT4XWHmTfTcwXf8fSM5XtOsmJ9+/MlQF40XCmIuLBeXmd3mdTvJI3TNkoEXN5tnq77UXF6nVH9Yq/ms7q5zTQ4BEVn7jk1KSBqmjK+TqKDtpUb8SOxqMia/6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXSbX9XhNhe4FjBB8+RMHxB6YN53l4UF07qi1HUuSs8=;
 b=IXv14+7JECpbRId+GO/Ttavcx1PZk4kBtq7j8iKItkQer3PqmmeF1Efcx+BMfgNz+bxX5i80dufWAmECkstkgaTzA3hRzBC0+e7AWtKQdDGjMECBV9ZzvUdjIOiWhGXObCmwSK7W8OYOqyuUumU4+H3iUxc4GsW/ZfgZ3MDNuIcLM2YGSVhmgaVjcAfc4JR624HWrAarmMnp/MSuxr9TU5NMkOdhdeawskJ4V6JuI1V16kTzzeSJr5ASZyRJcgm6BIRYsmB9+JqLR4IPBCsHgZSVFJJwO0yerXrh8tyGZfefu4THeTRAHorsXdqCtNjaB7DK/Etzw/gWXSqj5gnf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXSbX9XhNhe4FjBB8+RMHxB6YN53l4UF07qi1HUuSs8=;
 b=lO6gHe8fj+Hlqd3piygDt63O/c0wyxkmvhYtAT+lwXRgnTR+ou+hlNSXXuKdymTeakCx4BvBYKZcDFf6g0rm1kTBdTgFc/UKNfYIOIz0NdmzwKulSVS433CWhFHxvJYpVNrJK3zADczvUTjsiUgGY+z6lm2dUnPgc6+SOzwY7MQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8817.eurprd04.prod.outlook.com (2603:10a6:20b:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 03:19:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.015; Wed, 15 Jun 2022
 03:19:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 2/2] remoteproc: support attach recovery after rproc crash
Date:   Wed, 15 Jun 2022 11:20:48 +0800
Message-Id: <20220615032048.465486-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615032048.465486-1-peng.fan@oss.nxp.com>
References: <20220615032048.465486-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea8b265c-7ce9-4611-17c0-08da4e7dce13
X-MS-TrafficTypeDiagnostic: AS8PR04MB8817:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB881799511984564CBE4500DCC9AD9@AS8PR04MB8817.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkPQ5CQ01VRlaTGYkl0qUIYG5O9p1//KPsMvPosPmq+CZXwKNJ3LC+B8wZv5I2I+rpLrHl6WMuMe3ECbFxQbl7KakAKqi6QCkSZOSRJE2ptwzSmGHgGa7jyJ0CgJwFbn1yxnReWiuxBJxVT+758VS9asWMypxJwTA9oEKoG98t4KHAOEdQfkGh5sh59JkTSuB2v8R9TJqOLDDC3lRTbmh+SqqYTC/edzG7oCxqaVXpRlnsiI1O5Ie2T8Eb5DJVcKxens6W5z3vxRp/O+gCJsrGGCU7r+idqXDbDUtrM9sNIOlkMNK0zgf4UQTO/FsHD4r3Lfvd0D07zD76Zvoz3VtK/OfIAqA0bCf3T8oXBYfajV2CjvIrizvPOPbyecnf7/YOZ9fHh6H5e27tq9aSIH1hy39Te/44JC88+GQlyUjHUrfhAKy8wFWekWDqXvdMesbqZFBAGVr3HO/FCyB20twx+R/0H3hrxI/JfStAVdlsdV4Yi7dVmg07qkhHrAfhxwzZCh5/fiaAcjBRuO6xpK36/I2JuWaT4ZErlzyyWQI6ysCoSllwAbkgnCe5T0KzIMoz6NpFAIzzdqql1xKqqdT83fzCnH44lmq+E1g2FkqJlHjXALcp7u5G8sBX3jfzeYYzh+Mj8swadsY/Ch4H9vmRNjB4LEPvE5qlfYyTVyDu1wYOVzYh0IsPV0N+wKA8JLHUZl8Zkj9uM/5ZYVQGbCaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38100700002)(2906002)(6666004)(86362001)(52116002)(6506007)(6512007)(38350700002)(26005)(6486002)(508600001)(8936002)(5660300002)(83380400001)(2616005)(1076003)(186003)(316002)(66476007)(4326008)(8676002)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34YjhXeFhEz3EF5T5XUcuxSflLEUQAfzetouxV3gp+eX8zdQNLOZft9WTXxY?=
 =?us-ascii?Q?KyDddb2Qhia+exC7oMaOgm48EdDuCdZ6R/Vs+KOiNDYjd/8zds6s46oGcwhm?=
 =?us-ascii?Q?yKHZJZTV/tMP2pLhhGEfZs3jpZ/yflrP/MDEfFgWfdcX+q5SlibTi9BhNn/+?=
 =?us-ascii?Q?jWmTLTquMneye2X2S4ZhOeedtsqjHhtKscVFwEROf9ObhN414up23IUsEr6I?=
 =?us-ascii?Q?3ldVRy7nq8gO34VGvli3erYZXrNNI0t+w7jho/UJsAbLgbmUpIKIh2wlBYk7?=
 =?us-ascii?Q?31PWFmB0/y4ecLfPsYDazA5WUZaXiTP9pPYbCtXhAavh042Au6t0V8OtIL/Y?=
 =?us-ascii?Q?IQOH5Re+cusf1Q4pNjV2ijuPMkaen/v6r7y7sKj100bAnzjDv3ijU/OQ9zZl?=
 =?us-ascii?Q?yNI12zKi3Q51YOMC6YTKWuTC8hy8xyPy9PrjaEBugqXzWchk/43ECwtbXoHq?=
 =?us-ascii?Q?mhNQvsF3EwFv0/TxJPx7gbdq7qnvKS/IXujjPaUXRdRhaZFwViA366HvRfej?=
 =?us-ascii?Q?gIeRBxegl5reDFUcAu6CCHxbR+Wm7/sCbx6KybhUxk36rXjbSjMaeh8zfz04?=
 =?us-ascii?Q?5zmojx6ObMJwfIwGqc7sgSBU2SZzSyKJodxfA8LBAxntyIc+QboRandNAHMy?=
 =?us-ascii?Q?JUJhd3AOoXRlqw2rHzxlrgv0IM3+Qh6bn9SbmHJpoKAHmOuE58/KYjCUVmRX?=
 =?us-ascii?Q?rw6cbKpsg9tBKYgOJsNwBAF/dP2MQMGxYVOqGoJJOQHYLPSDHlW7hkfNbsEm?=
 =?us-ascii?Q?+DHwaJbKy0GS91y1RHJE3FTvQfuDuBtv8E8OxFzxZl3Z8EVBDVs8HvgglPtP?=
 =?us-ascii?Q?Y2Uf3BJzUg1OXlsPUM+gsSLh1UL5cW5vymSfT/26zDPPef2GAaVjgpOJI8Tp?=
 =?us-ascii?Q?iC/jyOAP9cXLXUkIBCtn0tzjZtHItJm2XB64+gHHFo0dhJcau6/S9r8T9sp1?=
 =?us-ascii?Q?zIxoh+zLXGFLtwsKr6uCZ+jInajckwauG/pKhL1uAPsjkrFhP/gha8zBWAar?=
 =?us-ascii?Q?+tmBPzTICNjYIYVVo/wHq63XooNsoeCw+jX+wHGA8iABumv5LmAR5JssIqtt?=
 =?us-ascii?Q?+bRNYK5+chc1wF+CqQRhy0c7zBbpOcguWI3aYaP59Pz0fouW9t9+tm5OMVco?=
 =?us-ascii?Q?B3HrxIWMRgibSJfz9lsdzIAde+Xa58rOwSYCLdya8jQ3sWilb0dZ83WKzc8A?=
 =?us-ascii?Q?aWJsIirANIKFVwdFbndjkUiRsFehJjFtRQmaH6aISp1aZ0f/WD5zd9+eN33l?=
 =?us-ascii?Q?jWKTC19SOKj21Smhl+4X/USO0W0DsMiO8QqKrYEkUIHOL717e6Syp0jMsd/b?=
 =?us-ascii?Q?3xkll1w8satmXpYdINo0CNaQvoMSnJlj+ok2BCBwPFqzrQdc1LGZFe0bKwHk?=
 =?us-ascii?Q?MmGUXQMsyCZAl4HB+8z9E2ssvRy+2CpGQ+J5zNTjWiP6QukvoWD0vcg/+DSt?=
 =?us-ascii?Q?PYdwfxTp+ifC2pUocnFtBOqfWKjz0MNoAZ3l1ths/88bzNlvz2kROV3vwL+H?=
 =?us-ascii?Q?Gyp/z6HBL6/b+egZJ3YRi8biudnMvMk9ubjGJ12LVhm4JvPKzB+K3bI3ZoYk?=
 =?us-ascii?Q?HW4zL+8tys44PG6kU4B43BycskBiYpj+Wb9NSdXv0MGlE2mElJJtQFc6Mrf4?=
 =?us-ascii?Q?ryHg3ZEJW/5ce+dej3SqrzE2i9uZgEV7ihPDDJDYcYgAP1ivifASMtFZypFN?=
 =?us-ascii?Q?/Tkprqza6YcDssFRw1CY9d8NF0rveD84ohIqjnG0lHKafljL+76kCdP0dGJD?=
 =?us-ascii?Q?c8vKq3pw4w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8b265c-7ce9-4611-17c0-08da4e7dce13
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 03:19:06.3457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN5q1vHipA27HRsBJuM5EVwlQewZcH3qiXXHD8g1eqSxOO2LA/TgLW137mKGZ8rCzjJ66EN56T+FMAzmbnvIAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8817
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
 drivers/remoteproc/remoteproc_core.c | 64 +++++++++++++++++++---------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 02a04ab34a23..1c1c90176aff 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1883,6 +1883,47 @@ static int __rproc_detach(struct rproc *rproc)
 	return 0;
 }
 
+static int rproc_attach_recovery(struct rproc *rproc)
+{
+	int ret;
+
+	mutex_unlock(&rproc->lock);
+	ret = __rproc_detach(rproc);
+	mutex_lock(&rproc->lock);
+	if (ret)
+		return ret;
+
+	return __rproc_attach(rproc);
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
@@ -1897,7 +1938,6 @@ static int __rproc_detach(struct rproc *rproc)
  */
 int rproc_trigger_recovery(struct rproc *rproc)
 {
-	const struct firmware *firmware_p;
 	struct device *dev = &rproc->dev;
 	int ret;
 
@@ -1911,24 +1951,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
 
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
+		ret = rproc_firmware_recovery(rproc);
 
 unlock_mutex:
 	mutex_unlock(&rproc->lock);
-- 
2.25.1

