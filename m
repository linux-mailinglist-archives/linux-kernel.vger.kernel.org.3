Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D28148A670
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347476AbiAKDgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:36:13 -0500
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:54782
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347355AbiAKDeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:34:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsb7A7vE4I8+43l4EU6Mq6xVO7LnH/+qOvfTA5upRtp1YwXJcO8On91lFc5B0ecnab/b8Y4najSUTSmcQxS8yX8IR9OBwKjgxSmTAjFVYCBrzZ9BwbsDUka95t7if1EoI/fQI+g1wsyK4fQn9j9iB5Gn6dRpn8r+b5lKYU4zNwzJLBTUc+YMvbOPtS4aD2dvqREPRn+Q6GC2eQxldUBTVv3QtIiE0YNqqBukXnALQ2aH5CCOlAt0rMA+5lvr7vHwYvz+qb68/KMwhM648r9KeCii4e6dkNiFO6X/cwEHqEBgPxG0CZIxeabCi8ifXtUZnnLLJEwcHNRDdTNzciWb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da6kLuIGU1u4oHl1NOQN1CNX40Xzl9HRwpazX8ouviw=;
 b=amCc8CmEeOiBnkUlbRu54PRRHEwDVXccGPfQgy0BC4Ajm77LFMCMmOsG+QQLj7+K0t6uig67c8Tq5+yw+GS7UMcm0bx1r/sVF6YtbyO3s43zCtz9Ndyy9YeubpGRbHN9CXopJzDTdT/Qn2Cbh8GcGwN5qmLmkFRKDIN07hGnWzV7rhktYzgjv73Nv9KBA/FBmeBstLA3zVvbeReO89HI7JfitQzYhI5FM+aSBIk3+HbM4lOcGzx9rJNanh4yFAZUu+IXgBUs+27k6Sjws/A70GtYCHaQeCLYRvOe7PbvB5X2X3YjXKL8QR5JNGsOArIW3f7g1R4g++4ZyCobgqYf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da6kLuIGU1u4oHl1NOQN1CNX40Xzl9HRwpazX8ouviw=;
 b=UYDogBnpkEhy1DXDFQXWKvn1XDi1ThZK/9u6EdRaqMyA4pkYQTXyvdwOg8nN2OAW/CFDZW51dQMkZb13m8IU2kw1RIwzyWKqEmb7YWQos2AtVmygQj7nWoSiYw867fXE8GwK0h6L6JUj2WnMMHrFaocajA6JGIWXKBDDd696ynE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:34:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:34:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/9] remoteproc: support self recovery after rproc crash
Date:   Tue, 11 Jan 2022 11:33:27 +0800
Message-Id: <20220111033333.403448-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111033333.403448-1-peng.fan@oss.nxp.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a9186f3-04c0-4100-671c-08d9d4b35158
X-MS-TrafficTypeDiagnostic: DU2PR04MB8725:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8725407B5ADEB8D1D8A2B64DC9519@DU2PR04MB8725.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+iz9UyX190wiBqEtqGkbS5HOR9Z+wlOzknGgT2H0WhBHey+VWGduDIVJWoT6NvFBvoyHwTTDE4fC2QuMJEQjOJHRBOWZsLg0cXgMuv5SkDzrFwyYfBjEU6IDzSn67T5ZYysNHGstAy9lLxT/2r3ISxYWCIYrtiirJT39rRta4idN1VxrP3x45yZVu6N17HgiWR2NNOJDiJ1WxHRbCqyrVpdXEm1lJfN2kcIoTrsYIowoaPIwvprPfEuj4NChsFwgir5yYC2g+GQd4jHnM3fmOt+vPXMX6EMLuhKPTXXhtEM1EgdIqxSOS5QxwEH2q2NBIMu+RKErZLXSzv9sNDUIfrG2IBiA/zZVlD2ONMrsiF+rhrL5qp+hO6EC5UrAxg23x92aPtxkPz0NgcGGdLAdMNZyDAhYEqft1G7opN70FMBHtHntHwK860gYLcrKyzu6yOnaTUYOEg3xsBRdpB7engNuHyFfi5sO7sRYq/4nxXGkSVO89gNIdpJyRza//OAonBAlkHAR7XyGOK0lnjOwRusXs70gP0RNrycMR7gIqHcoOZKQ/pOLtuBwVyX93kXOEBTlHpOPRepixTsNrQhgu0iG+aGsoGePCcIg2firtiyxjWVgc4Zs0oiQdjC7L9rEL3CNRgaCTcJjFI25I8g0jYvMO6hHIs001PG6QN/uAJCLpvozjr06S74SCGEgerfXqhtshdj474aiZHaoWJ664ehHa7cwNhH+UrkjHtaNRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6506007)(38100700002)(38350700002)(186003)(508600001)(921005)(2906002)(8936002)(26005)(8676002)(6486002)(5660300002)(6512007)(1076003)(316002)(6666004)(2616005)(66946007)(66556008)(66476007)(86362001)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NbPf8dYgLSropYDcYY2GqvruHgRIK1GmKvSfLgPNmkdqB5m2vrUnmsW2HGI4?=
 =?us-ascii?Q?eyII9N2Sp8i1IUHXx6BSAvwRpmTKnkp3WyqvsMcfUMybQmUa5ehR4mpSiP1Q?=
 =?us-ascii?Q?OAkzwy9JyxuOa8CLXWY/WqR6HCmW+5DDYzM/NQ2oXGN86ec4RhRtJK2354fQ?=
 =?us-ascii?Q?/ezA1AStr0uvoNmvG5qCZeKhNX1K5Uj1dniSoVXCFUfjH0maZ195y4gsCTlt?=
 =?us-ascii?Q?xAXFv+ObvbF/fWKGdYxvhFnsygJUGmA04JWogMM/c0mWwKhzu6YqqiZOyEp0?=
 =?us-ascii?Q?OK8CUGCqL/e4DHGLftDPBaXM9ZsqFUoGygy2yNDr5/LOYvINVBZeLCl2bRdr?=
 =?us-ascii?Q?mE+PeXI8t135S/LzR52JxX1fvenu1kzXAuJqG4BK92S/K1jAyOy3UTpm4jCz?=
 =?us-ascii?Q?1eG2b2Hgo8g6KnAjaLQ67UB/ItzvWcVUx4CmWUPCiDau9jvRLTzW8ppZ6H41?=
 =?us-ascii?Q?7xeAkY8jn7aEK2EZtjWIzumuH8Um6uzD2GoSP1D8TnVziDzJlZK9qdh7E04l?=
 =?us-ascii?Q?lQppm1mXmZRHZTL0Yo9cWf7bcwDts4hLeW0Hk+sYNvbmZSEqmwhfqW42Xr6x?=
 =?us-ascii?Q?2jRbF01OfIICi5mUr4fBw32iyG4FUi0AkVy7uwYvUzHmBaIB6CJf5DlvTG1A?=
 =?us-ascii?Q?4Via6oU5nfovREBlb0M67PC0N58V5ckmM+/GvvK/7Hj8OhxqMNNjmkwXFP1L?=
 =?us-ascii?Q?NlNZXCEBlEoFz7ycBMzbzQRwEanoc6SPm+S9b2qloU3TjM/2XPqK+XJtJS6n?=
 =?us-ascii?Q?i1NAd/WC//3OUs651iQB1S2krhSYJ6bY+SMBgtPKaHnL/fzHkqtqE//SKpfY?=
 =?us-ascii?Q?1ae/FyZyitzPqPohcfxRjWSMx/BgLCS3KSABwvc4cYxTSsPV8nu+WAU5ZvCZ?=
 =?us-ascii?Q?4X9fyn7+HsKQRKkqkhO//BY+VMm5i3buoL84iuuwWH5nUDm8we/K8t5tPDCR?=
 =?us-ascii?Q?hsw0DFayStJ6IVM+XuoMTqxYl8GnP+CgCTWb4zFQQB/th0or3ADIFKZYhSzS?=
 =?us-ascii?Q?od+sBQ1pg7OO+JDiIB5WC1os9mWRVHth2og4y2UHowKkYwa5k9u614Dk9mrO?=
 =?us-ascii?Q?bq4TtZtsZFLHcdzT8rV78+PSBGZZtkySSYY5n9Rz9VqpWzgs1cyu1UU9E7Gw?=
 =?us-ascii?Q?gW7BIGN4NqsWKeVgSuS8/fyiiuAkBcn9W8jFEItHHsO8hDzstq/QyEJfQ5X6?=
 =?us-ascii?Q?WM1Y7niMfJ6eMQFpu3YJqHeiCElmSktTf+IKV6SKhb37lm5d5gAI+fAllzFB?=
 =?us-ascii?Q?JTVfhpe49psNpaIDjafDi09XvOGf+IMTY/E/+2cAEv0+fCxtiRSaMZcx/CAE?=
 =?us-ascii?Q?TAe5toNCNP3R05pxir8R98jvN0KAEAPB17dek8+JgTTcnugCM/XmY2CufkOw?=
 =?us-ascii?Q?nX0AhWDhD3NrpQ+oTc7l9KvBovxnSoCH8Ghu6bAAftdussDa6r8wn+YTozwh?=
 =?us-ascii?Q?yvsM/9OTiwWdDzGm8oRZ3KPZYpbrDQga8GdmB6Co+kJ6Vn0mjeJEMMKnexwX?=
 =?us-ascii?Q?iDbWHBauJEeUOhiRW2ur8QYfbTdVGHaqXcl5AU6aWJP8DOgJQyWtc8lyRw8y?=
 =?us-ascii?Q?nl9rV/cA2ZR57Y69cnSbAM4AxMEuDJKb+Cs+6X6/kjUHsyahbaDFpvGslsd5?=
 =?us-ascii?Q?lG0nmUyAqaq01iEmwGT5XuY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9186f3-04c0-4100-671c-08d9d4b35158
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:34:48.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qYh3BMymiZCU7sOVxmxRJz5DvGSSG+RdvmF8j9fcGWBL1E4Y1PqD3S7FWu42Kve2obrdL9bX+b5kzfjTudJ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Current logic only support main processor to stop/start the remote
processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
remote processor could do self recovery after crash and trigger watchdog
reboot. It does not need main processor to load image, stop/start M4
core.

This patch add a new flag to indicate whether the SoC has self recovery
capability. And introduce two functions: rproc_self_recovery,
rproc_assisted_recovery for the two cases. Assisted recovery is as
before, let main processor to help recovery, while self recovery is
recover itself withou help. To self recovery, we only do detach and
attach.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++++++--------
 include/linux/remoteproc.h           |  2 +
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 69f51acf235e..4bd5544dab8f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1887,6 +1887,49 @@ static int __rproc_detach(struct rproc *rproc)
 	return 0;
 }
 
+static int rproc_self_recovery(struct rproc *rproc)
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
+	return rproc_attach(rproc);
+}
+
+static int rproc_assisted_recovery(struct rproc *rproc)
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
@@ -1901,7 +1944,6 @@ static int __rproc_detach(struct rproc *rproc)
  */
 int rproc_trigger_recovery(struct rproc *rproc)
 {
-	const struct firmware *firmware_p;
 	struct device *dev = &rproc->dev;
 	int ret;
 
@@ -1915,24 +1957,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
 
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
+	if (rproc->self_recovery)
+		ret = rproc_self_recovery(rproc);
+	else
+		ret = rproc_assisted_recovery(rproc);
 
 unlock_mutex:
 	mutex_unlock(&rproc->lock);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e0600e1e5c17..b32ef46f8aa4 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -529,6 +529,7 @@ struct rproc_dump_segment {
  * @elf_machine: firmware ELF machine
  * @cdev: character device of the rproc
  * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
+ * @self_recovery: flag to indicate if remoteproc support self recovery
  */
 struct rproc {
 	struct list_head node;
@@ -568,6 +569,7 @@ struct rproc {
 	u16 elf_machine;
 	struct cdev cdev;
 	bool cdev_put_on_release;
+	bool self_recovery;
 };
 
 /**
-- 
2.25.1

