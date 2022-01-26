Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C644E49C58F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiAZIwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:52:21 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:25056
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238583AbiAZIwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:52:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCaroeZWeXxKuRaEreUQH9GKTEAPzSPWeFnLwwvApVCqcxrVWNLsSnpxFwbnO6bZQoRkLw7gSIMo7TNQrgm7WFl2PzXnsvC7/oANMvbl0jHXVsU6gC81i7DDaw/PuspKpKfHRmgxjt2GUP2vDjWdtpZvoGHRnUD7e4gqqttNp7HDlWtDD3AAXo/E7JVPtnExP6u4OQLPTXqknf6zGE32Q0L8Ft9EL/i0Csbh0/phbr5XHMsOJgLzElilQdBhtuspX0/0jA7x1+NSULNEnN9TmLYqIN8+laASHXM6RkyXX4DHXAKSStstlQKyEnuZpQnq7uHWkruOtRBl5LDSKtw+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UHUSfUrfnSNNJhQv6a3mg3eMDCmzSiz6dxyr3fGCZQ=;
 b=A4ot+QHxvZf94i9eyT/wFF3t+VnH0rwJ4LwV0x12YQ9w66rng+ZHQGaEcLHaJhggUmIr26QQlkdhcxhzCtafGfzvKLKrPm1ltKjZvPv0igk5F/waHUZYniw+RXxJHhj/hQhPhE4A/1YsLJ5ECsmHSYUEDxj+Mi998/BwId9oEzRLuNrSyv0JhNBTV3Ndi8oWGB51LYvIa6Zu+ClxIdsILDrO4wxbS4bkGOgCq9RHgK0rRKOVIdmJSyX73+z3PoAtYh2uk1lPJtDgqhKbdwQHdbpLRRyV6AzmIkk5X5ohB0mOF8GugKAbQU7Y8q91/3He9jnjhOZJM1RfGJsv8iQmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UHUSfUrfnSNNJhQv6a3mg3eMDCmzSiz6dxyr3fGCZQ=;
 b=clQW59xm4FKlZoABTt1TKt0p0giGU2IgIg3+UydNPhQNJ4V3qedJJ2sVmkAK0V2Qdr+KBXWSR0aUg5KHhjVD6A9BxJf3aSk1icDRX72Z4ZrmSIFi9pVcWU9CLHCl+Tkq9JfyU998ALfOi00M49QocuAcwTVhAnc4/JZelTgL8LM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7130.eurprd04.prod.outlook.com (2603:10a6:10:123::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 08:52:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 08:52:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] remoteproc: support self recovery after rproc crash
Date:   Wed, 26 Jan 2022 16:51:20 +0800
Message-Id: <20220126085120.3397450-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38d49383-41a0-4a91-eeed-08d9e0a926d4
X-MS-TrafficTypeDiagnostic: DB8PR04MB7130:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB713083132E35818A3B30795FC9209@DB8PR04MB7130.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EGT7JwrxCVobc3NQeJSU8q5HrVSEe2RXKK/jTN6Z/J0I4OLAlbLjA4TbW50Z1W9FHDf798idt+NWRWusxNcE8m4dvjPjC3RP0lYsztOdb48Ueyzp7XVXH4ortlkDuOk2CJqPAJdp2RyrUFha8Ob1G0jnyTynro2TKpcGuImKAX6LMwZQox0m/SGj+v1SdZrgDHrRkkhQh6dhjXnieF80XTzVTSwtoyZtHUysf8uB3ga6tlcEPM5UDQEH0sCtPRyYoumFtWUD3QKWHkqyb+f5H8D8d6qtbyO5JYtxcA0rDlUztoQQC86lXU/k48GslrC/6/0OBt3iEpHS32nX5QluuyekhJCzwmv037hBHiNrnDzEQ/BagpPYYKPvNEXRc1eWKZqwPlgBtNKrpi5QzestadflbEU9HispPozUU1jJip7NlzSYCvs0eWKgmoNx5SE9L9GIFrOWGbssUq1RhpKvJVnXj55sERw2oWIA1u4OkK0anpFsTFVBdzgB6EZkBnX/Jk3ve+iy3InslOCq56LoNJ/lpmNPR2HgwSBbYqLGkCH0ocCl4uu/cVJyEfPynHI3gxdzyMfqqCC2+wnnQ3lfWpUaVPPITCpnIW+BzpZFNBSoriSdjtQg9zefSx1dlxWyw2Zwsv/nWbIBMi7kypHTIAQVESMMLeBFOcjro+Ex7hE40v4uCqb7PofEOTnWSKiUySxAVfMgraKmLou4OyzxaLdX+OMoCov1g1NePjMhHvkkxi4VcsBuhYCOiku2vA5Uy3SWlGRfict/7Bfu2Yp8xu23IE1hXQ5LsfI+8AVlcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(2616005)(1076003)(8676002)(52116002)(6506007)(6512007)(6666004)(186003)(83380400001)(8936002)(4326008)(86362001)(5660300002)(66556008)(66476007)(66946007)(38100700002)(38350700002)(2906002)(966005)(6486002)(316002)(508600001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRHgRoyX67+QX8c7kp1tFyEri0I0/08uUWncFekrDw60ItvyUpcv43sqC+xX?=
 =?us-ascii?Q?dhysQ7Qv/zIC+nlkyBy9fzE/ldU7139EJnDPWzKx4zZlLM+Z54Z1tfrL/RrP?=
 =?us-ascii?Q?HgTooB2SMyu1xMvk/yeS10bBdD48Me2KaaVnDGyJhhYIsspR9kfuEXGvZYRX?=
 =?us-ascii?Q?wBa+L2HxLa5keKQTpjzDVyNYXY+YiSoErXE84tyBdRPxZ5oIu2hJdhk/Y1Jv?=
 =?us-ascii?Q?HfEoECfKaBJqFJ6Ml2+k+Osat4k35IrRRD89/KyIvjzxSlZo5034bR1wnGxm?=
 =?us-ascii?Q?/sx5LTFq2LMIqFzG6d6oX8AjpC0L87R1WbRUYew1S1FkUd3sdHh+DMrAsvF3?=
 =?us-ascii?Q?3YetL2/0jEZyW0YlCOuU/6AOcY5aAd0ZOWBCjMqx1dKkAhn0ZizqJzA5qF5w?=
 =?us-ascii?Q?LGoggnIQU9MEDeRiDetGBrGbBCpXklw6nPhk0D1n2ZLfrf2vlSBjTdbbG14k?=
 =?us-ascii?Q?liAvUGsmleVXcI3QItR3Cbvb9lkh0B9LmHe3joIDQcbfwtcAfpE99c8fR4H0?=
 =?us-ascii?Q?jT/zfuFKYnSu8XyrOD/uRn8tfGC2nR+2+YyMusLfrrX1v9r5Xs/lDVwl3xH0?=
 =?us-ascii?Q?qJNHm9jOMmUalt6Agg3ZD95Y5WBC6vnhazgPGP7STSVVY3DdwLuEVx94r1kq?=
 =?us-ascii?Q?pOrakiX6pznFOB77nUggmoa3iZmIHP9VJEBfFtvpG9Wp9b6FN9Z5mzHjjVDA?=
 =?us-ascii?Q?Na1glDmP6bgFDaKIN/qUYLQBzeYJXKvOwc4NvFPtqVtmGaPsFpr49Flp+5iM?=
 =?us-ascii?Q?VGANmg3bzMgTQZkuM49LB+Lgm2LqfdkgAsKznu/hB40BcHovn8jaI8SzJyFM?=
 =?us-ascii?Q?14jeqTI3tVxWV0rBlAFt6cMx3B8W9aIjaCyba2zlZUzTjmxyKFA86WDYRrWe?=
 =?us-ascii?Q?yWENpwxYWS3DVvHYEHfYkhMO9JuxIv88Hegi3xRqCSoo67R0cfAiuB1rfgYO?=
 =?us-ascii?Q?20kWLblcVy4/u0Poh7EQcwJylRou2uNOX4xEzN1Hs4mRJQXs2SzfvOMld74q?=
 =?us-ascii?Q?67aPOOdJMLT5O8+J9HTZvwKiNI57FSmEBAzqTG1EbRbdVnRP7inExm4urX3c?=
 =?us-ascii?Q?WthSv9VlYoiLetsYF/QCjl1+Pjt0LSvs/+4h/ossO2d3fquw2fZqRDe1AS9P?=
 =?us-ascii?Q?tHbAKUvtq4+teG2Y7KVEi1b/Eg483NFP5qMDtrkcoXUoz7ab1uFVAm6IMaNz?=
 =?us-ascii?Q?W5rfYANpWoHjgdRAaktO/AlJcPUDj7Twrs5t+qI1gwfay7SHAbIh/Nq4aQeL?=
 =?us-ascii?Q?ypZFUfg86AWGstYEtJ1G6J/28IkWlTxIokueaqL4cMdvj6viwSuqq9OxvDk+?=
 =?us-ascii?Q?rctQebdga2jj5QB09nyjWzbKvlY6lUWedGt8Ta8b6vjnSfX8FdElIyzdGXuF?=
 =?us-ascii?Q?e/w17W7PO5nbBuNU9ROd6QKrOB5n6/0KekKg+CLXC1VC2EUoRqtNtKYnMXqA?=
 =?us-ascii?Q?qRyewNcSEqufcPvalTLbVwzKM+yBPNUjy2T67LYoeI45A4jEAIunaHsCvizb?=
 =?us-ascii?Q?RnAPboUytZYCTgy/BClPR+UaWFK3LYgknvFC9lwkxGNyFTh5jQi04CZtvqe1?=
 =?us-ascii?Q?rwnOn41mEl6E9/c3krotHVfAoyvUxilRocJK19yfBcEn6YiUk1BGOjvTZn7u?=
 =?us-ascii?Q?aq8akW0DSTOWJSNJ1flNat4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d49383-41a0-4a91-eeed-08d9e0a926d4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 08:52:15.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hw+QCY0BKDvh5KeU9v7rtFVOz/lbd4h7bxLO/BeP/b4zVJJrktAxRES5VfqJGDmrLmiuluumNewHhl/sCujFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7130
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

V2:
 Nothing change in V2.
 Only move this patch out from
 https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364

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

