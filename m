Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08874E4BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241680AbiCWDoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240440AbiCWDnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:43:55 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30062.outbound.protection.outlook.com [40.107.3.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4670CF9;
        Tue, 22 Mar 2022 20:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvmH42ZewpgUu++yLGlSS//qSNrzzEk+L3KWDCMxLh4Ia3zXnJSNPG4hQF78+InxemoQMEOq4GPqQwdboHK023+exmA6VqcSU0Y2fVY/7oOmtB+jErLW/0qbVDqjiG1tZ6Tnc4siNjgzktAMTvJ3k+Dowj8JWnfdf6ksa7xrKf0/Bii/0sVJwrE3SyIEJZoZCU/39hZJwEFqG8ojK3Afbe+ypAv8q+SfTA52v3LMVgXxtrDfuOGEemKF4jRr5r+9JcYMP05en4Dxq3I1VZjbNr4SRE2J5WtcaeV9p3E6n0+5BRvY/7yRePs5IuK1cE4Ouq23cL3J+kWxx3PF12dfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVHg8SrcD1/iCrzLq8zCMg7MJyiD06axkQZdB8BR1Fw=;
 b=KZhhqD+DtBi396iYX6yZvuP4x1/YMmtTzhM7X9NCpNDFLKN9u1iT+tVI12ZIf08S60Bc9QlFrgv6ziNrf6MMJlI4RyNavtrYlYrBQiOf/rCYk2RsaZiPcM+GKaFhKECK9sBtNHSpFiR9keU3vJg8rxlmyyPEsok+xvDQb4VqHx/FHN6ZVDcb3DZg4ni1LE/JIapHND6+iHPX8W+HoFBaUXI1DSbdoq6yVodRRBfi10aiuVuR3lVWge8yX0o3iLmAbqOBV5r22zOZGN8GuRSjZ04wtAuQu7cukYrnSkg0xdq2lkYD7bwr6dVBJCkYbN/FepwZNxjimN0fEMIMBbU2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVHg8SrcD1/iCrzLq8zCMg7MJyiD06axkQZdB8BR1Fw=;
 b=A+bpVrBbGJRNTm4Yb05WvywK8Z3zual3EnTdZ0avskRCSEfPq+HA4keuRjPwXN62dy7czIQzENt7bsOxOYwF/7Sgcbm/QhaN3uc8ZSss+VWDPIzBL5SKIdKjunazVbqheir1QAPN0vkY+PBdeApmkFm8k5SMNNGxvz2R7IVf+ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6868.eurprd04.prod.outlook.com (2603:10a6:208:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 03:42:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff%3]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 03:42:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: [PATCH V4 2/2] remoteproc: support attach recovery after rproc crash
Date:   Wed, 23 Mar 2022 11:44:05 +0800
Message-Id: <20220323034405.976643-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323034405.976643-1-peng.fan@oss.nxp.com>
References: <20220323034405.976643-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0111.apcprd06.prod.outlook.com
 (2603:1096:1:1d::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e93f289e-8a02-4cca-a499-08da0c7f241e
X-MS-TrafficTypeDiagnostic: AM0PR04MB6868:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB686835774DCA90022B887084C9189@AM0PR04MB6868.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkTD/+EuKG6lDroA37TuU5Uj6dggrHyptK5Vfuhyi1+026X1LPvcXls90HYiCN6rh9HQojWZlskvpxuizp12eNl8dcyeMSO+rzkiAZW/GC/tvFkgC0IN4Rey3NES/J7b0QeHfzpXBxU7SZxCK73LTBaDxMwnMCH2NvUY0Cl68IlfLN9ubqBI9R0gBWBE7lj9eNlCUaPJGPz1MoOUGy22bfuG3X9UrRP2Mwg3QGEUn9RGWHZ0BOuDizIIC5R1EtuBdmKk4sCV8XxyGvUTUrPCYnICw4qU2IJa//uLZAmQHeP0gY57VLWfLA7etNrdCtMdbBvLvAdNfw94GM9IPI5tKwriKXf7Pm1621zo32CA1nn3s1Uz0Cw64esMYVoPu18oiG2+2Skcxxapty6P3FuVkYga+qeO9AuCdN2aWI+N4cWudkdgE+rjlvbjZlhC8o4CFeNq6wb32tRRMPxAFIR2NsJ9e8EOvVh2T3kfmXO1f43md9sVD+yhtkBpX4qF76BruMGP55/cdu4Jc+tDCzm93FtdZf+uU46iz8RwTCRa6OOYmCjuvW8ARWmgfNAJ35s5qG2JQ8y8BtxyIky/Ij0UOk68bWFTVfPEHEVq60yOipEzUonvrvEaqJ56SSp1EDO8veDj424sRSBt0fUBy9VVQsRuFpRWwAW5X+LDlxzL6zVTPH1MiMW0zRu03+7xYityeTSgZNQ1i3FpjfLMbPsBdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(52116002)(38350700002)(38100700002)(26005)(186003)(6512007)(8936002)(2616005)(5660300002)(2906002)(66476007)(66556008)(66946007)(508600001)(6486002)(6506007)(6666004)(316002)(1076003)(86362001)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XdsH/WqwsXmDnN3lOHKECrM0M5XwAToDWyOVoCf0asmScxLmM+CRTKqFhmCv?=
 =?us-ascii?Q?XSsGgdMOC0TPnUt/Z7+0ya3oYfV+zo26xzIw/IoBRWN+L8H2Tzo+gT68H5NX?=
 =?us-ascii?Q?304aCU20Qx0/thhBkx0GozK/jh+vtmuvFHRnqd3pjQCK0YmEaPWrMwwWPZRw?=
 =?us-ascii?Q?EOOUug26W83kbMOOH8QJiy5OWJCT1DCXtvX8CuAD6IXFlE6XkeDaPnYgmaxF?=
 =?us-ascii?Q?pDtrrLyN72jOny4ZDT1vs2NBEYo5bS0GZlBG8BWl1atjAq+mDS+3M7MXknLR?=
 =?us-ascii?Q?9Oif6YFIff1f0uYk2A48R0+Gl4rhPCYy2J9eVD6Av38NkFQ/HBXiCqc+4PVk?=
 =?us-ascii?Q?2vgKUdYkgeuNdLgD7h9T8Ykd9YrbZ8elCFrIMYUjQ20RTY57Jl/kvgxT9B8v?=
 =?us-ascii?Q?DVVR6ac5m//v957PKVu27r/TCEmzR1dK3sFg1TqDPwGwbcQZIfjyy8B4HkSN?=
 =?us-ascii?Q?iY0Q5nHD12gRKMV0MlGzVyDZdNqOwQaLpqz4MnIV9lgx7yODU6yQJx2y7XO+?=
 =?us-ascii?Q?KZWsGkZ7tHj6UKNqvAI2MmsZcOCWxPMqeu8decuSUdzI5e+lEe1ltGXZ9p2D?=
 =?us-ascii?Q?/mokaaF9wHgNnZuxE6uEbKgK8jedCx6uIEGrVxyVYTvzJmoAEimCsKIVWF9D?=
 =?us-ascii?Q?OyE7p6Ppn+5zyDwFZTHXHgbCiLLkmoA6nKyeBwcvOjfPYcdYBGFex8awvEPo?=
 =?us-ascii?Q?6qgtdH+84Yhj1j77JJH74PThzBcHQ5BmNKnFpi7sPId/5WqIi56cEOqnlLSG?=
 =?us-ascii?Q?CtYDUNHNoVCjrUPjijnfLMYt18gr2L2xCS7aZVQbDV2GX+5CbVhBEBFsdU5Z?=
 =?us-ascii?Q?9c/EkPhon7lDpmhumLC6C0hmj505LV+eLFZstCpqrJ2J6lW2vCWrN150OWeI?=
 =?us-ascii?Q?LdYLmDEYKYd9RLkMbJbvVEhTig2bvOdPjN4EmlbvStuJR7qA6Md55YBg/KNa?=
 =?us-ascii?Q?YnppnmpRDFoOma1UTJusfhOK7VX2fknCP4zsC+4E3TScso+Ur9JQD7hpvvvf?=
 =?us-ascii?Q?vV+OQ/RwDugayzcTNRm8ew/4r1DNiYYZlfmLSv6VEdS6uxMP8SS469Yi73PK?=
 =?us-ascii?Q?DEOH0v1AY7qbmIAQvmPT+45Diogk9icPsxgpP4PL/lvaGI4VzN9t5PhRBwkz?=
 =?us-ascii?Q?qWAbp11PoVp0jSJyM453Le2C1hkFncsCi/uEfR7dlJca4lO97MelKH42GETh?=
 =?us-ascii?Q?79vuMhrrYSoscm38usTRQHLn7eXidI1PPrYok/Jdx2TknRNNuN7iBTUz2w2t?=
 =?us-ascii?Q?bKNNppjp5KVp4p/VR3Ks6LEMvcl8r/vSq1e9jbuywLn0NclgbrxRQLnFKnoI?=
 =?us-ascii?Q?SF66KzXGL+OyyNHw/SSBZmHM21GRYlHvzgjnGxRC13dRodTWXKp5ttybDwcJ?=
 =?us-ascii?Q?/axV03e9QOI7HvAXsTh8eCIh95PU51NLJ2WLGB+fZVAs+i/v+LIMvPYDfO6L?=
 =?us-ascii?Q?P2c9sxZeB8hT2rFNiojH8a2o1z+rfAh7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93f289e-8a02-4cca-a499-08da0c7f241e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 03:42:23.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bt5pyPymTEUsWBHG6DeSStux6kCXVqfbDX2kiamgNkw9U9B2SdrEH2Q+NWg7qoGIYKm5HBUI5Cj5eJp4TdIbzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6868
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
 drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c510125769b9..ad04515750ef 100644
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
2.25.1

