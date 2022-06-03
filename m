Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775D253D107
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbiFCSOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbiFCSAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:00:24 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021021.outbound.protection.outlook.com [52.101.62.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11796590B2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifEVURYX85iYdjUtdukE2aMJsr+LfrTTLcVZFoPeK1dHQ8Tz6yuWpo+1U0y2AkW7GBk172LOnoHO9ozfMsH3e2a2opcbm8dru+kXq9gITVd95jrVJLsN/xL+FRqFIAowwdog7WFqJm6rFabIPf/EaTjO2KAhfw2aNuBqwcDvNItwukrOrF0LBRXn7mQfdDKwkJcxkfHxs+yE4omD5EbHBcTDsyEiPSgPkEl4VO5rxRnA2DVLyKucNCUQTVQ2hqgHPFZRQQhAuTCSy44tZrJRix28HDLV3YJsEhSmel8DWYF0EbXQ9RBDMgMjrkPcwQvFtGw+ZZafdisYHxOaTtqwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p4UZ4r0g93UAP563UDA3TUaPEFSywC05fl/RxIKE/k=;
 b=TJtxbqElk7R4IMxe3WSMQlSZ0fhO+7s/tBLWsQKmpvYIY8LiesYXJMk0Vbl/s3MHUdfFM6pcOfKTN96KRnjZHev3o3uyGTKjBidDTzV74jEXaB1Ke3tXsyzVlmJUfyCFaZnTAFNfVxMtyphYpe349jfede9mWzpPvBobhp4A4Q4QCjDO4psNK8d5TCbGo5YLTlv1pxxki9OWO9VvI2Igk/Ig4Ow0rLgcZvpJz26Llqtso/g1FmSxOhjKUE2t09OPFzuxs/GeObw2SXzsHfqmZMa6vHoxKs1v0Kx2Rljjgte3dnsDhVc6kTRMR89VJOS5QE+pbT3zlrOU5+GeB397pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p4UZ4r0g93UAP563UDA3TUaPEFSywC05fl/RxIKE/k=;
 b=aWic741m0YjX0dFH6Lblg90eAGyBaQH1HlCqMjLeArUQmVq6X25dqFYeTtNgh8nU2tahdNI2201q8DhmU6y8teBRfNuQOjHpY1AVdk923vHvsqeToHZRTZPLlobSLvMIn1rdac3qbGiMqpEISqXtVIP3HVFJ3nSlD52OVzRqkuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MN0PR21MB3535.namprd21.prod.outlook.com (2603:10b6:208:3d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.7; Fri, 3 Jun
 2022 17:56:35 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8%9]) with mapi id 15.20.5332.006; Fri, 3 Jun 2022
 17:56:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, caroline.subramoney@microsoft.com,
        riwurd@microsoft.com, nathan.obr@microsoft.com
Subject: [PATCH v2 1/2] nvme-pci: move nvme_should_reset() to core code
Date:   Fri,  3 Jun 2022 10:56:00 -0700
Message-Id: <1654278961-81423-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:303:6a::35) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbc0a539-9774-4bfd-f4a3-08da458a6662
X-MS-TrafficTypeDiagnostic: MN0PR21MB3535:EE_
X-Microsoft-Antispam-PRVS: <MN0PR21MB3535B449435EB4C6AFE48535D7A19@MN0PR21MB3535.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66GWsTErU8WbvQOSgLltFzSygFGnWcpyyK5S1oTTYo9EGJamWd0S3su8CH/24xm+FOau5Rsg251mCkUs8DYfUDupXZdQUwZrOPSEhnnDcAPmYnm8BtlH9AlIK+Z7tNPRBjWkS+RzZfKgyq0Af9VP7umXOl20xbm9Bamjmd0EJn9U4zWkCll9kv/ZD3p33/Fqd2mLbKUgLF8s0P5+4nRjQjeVNeDHG+qYmzr3l7uoebz5B4RHlwix1vhXfUxS85JQdMxPZCFTVFgANlmHzTLlompsyLJLI5cQ71l9jmJvm35gQtPGiOkHEN3MZnKIkRT6zFG+yis42MKq/YBeJxOTLtVWJn3QQxHoIZmJGkh3mvMIalLpEsCaVlwGDVVrZUaH0z+AovCZ/ZL5mlx0tgd/hsopIAYip8pgrAqgxDgrtcjgAxX31/qLl9n7mkQR3Fjz9Q3WCn/HmAVbwBQC2Nv3InoEYlvQH1g152dWrN/tuDVgaNETi4PSdn+wnOm2biuN/7tXVq89mCldi+ggQcks8flUoNgBQunMMtOTB9P29B9wRvn2cyzxlbt2rf+/DxZWqQKQNxNhgU2PAJgqqUXL0Rdktr14v3zgF6y1nUFRX5Nafc8wCLhKrqJMeyvp/nI73msMgi+gLzZbKDR3XUCVX+pY8LZZ7lYZrKbvwPkcTPLepamRAkdRwqU06O0TCNvPEKGW0zpZSyOJtVn4RXS6z5Kk7tOH/UY01DSuJz6LvjIzzXt7H2O/XKezLx8aafgg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(6506007)(6666004)(82950400001)(82960400001)(26005)(6512007)(36756003)(52116002)(5660300002)(508600001)(6486002)(2906002)(8936002)(186003)(38100700002)(83380400001)(38350700002)(10290500003)(316002)(107886003)(86362001)(2616005)(66946007)(66556008)(66476007)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kUJlOnUE5MtBHoFMTgaaz56nQNWtSKI4dn4n6JqLkDxiOyqCFbp+KBDHMkMG?=
 =?us-ascii?Q?RF6F2T3XOhrd9l3x0FeLp8bqiI7eUb1bjuub5MCt6p/yURa9/ovjqbFcI2Me?=
 =?us-ascii?Q?ZoCrmLtX9vs/eZTpPdIm/nylHy81H8DKxT7o7HsKgRLETay1iXcS1GB/VDlx?=
 =?us-ascii?Q?e1hYdfBWH6vOlAFv885qFCGH1lDKQysZBpinmkoBB3Pzt4TkgfqlHhQlj80B?=
 =?us-ascii?Q?gxyn9jvGSHDD+EvfyGYQ8ifDYk46JMsvbQ+OgDQfDUwTOLYDK0zemASNkoEW?=
 =?us-ascii?Q?BbcKvk7CnrAQx1tpRqXnE8+ptlLUmokIM9+1IHw7Eblw7xVgxyWMXNnsFGPe?=
 =?us-ascii?Q?JfHDfFvLguDQvuJu+pAADRXhE5dKOG6zIPSWpO/UkwnhBK84fz9z0CtoKJpY?=
 =?us-ascii?Q?uLNq/Rgdk4ST4f7Wi/FHerXXehe+dfO9s0W4WtAgIotpIY3/MJlTeXypcLco?=
 =?us-ascii?Q?CZF5HORSp9vY/6lohz7zWzzXZ9A4selcHwyj7fOX9SvNe9VetJLhqFr52MoB?=
 =?us-ascii?Q?qYnKwCfOCG/1zyRhdtzvaCbvJtU7uaehTu2cF2V4JS3fZjlAwx97Qrcnmliv?=
 =?us-ascii?Q?DcmUgZXpZ/GwkfuF5xKToarh8UFBNty9JV4n3qv82lW5xKEjSRNBRFWQ3AL3?=
 =?us-ascii?Q?rp3QGdfDEStgnayWxI3yvcNkyVI9Jws0uTJRDq6VeX3BOEbuGNx0ZG3ShFtQ?=
 =?us-ascii?Q?iF4wWuGhV0GOkNKxrEF/C1PHB7uDTA/rJsqQ+bzweV3qYpEillKaM0jENNRi?=
 =?us-ascii?Q?VQpT6mfffDkbyF7tu78qhFbdYiPMcYF1rY8+5Z6RpMPquRKUcFyymiATkVq+?=
 =?us-ascii?Q?Zle3ctVNrMoKP4oW/g6p96KisVzo9HKuCd60/VS7RNtvTGj2F+bAdss+HLe7?=
 =?us-ascii?Q?kXVxXzdnWOMXFkXym6QM1NDZkKhjkQGI9IjBsyOdxSNhWQhy6p/HRfsEjptM?=
 =?us-ascii?Q?j6rLBMg5LjKw6SEDzlb4d5KUhx0TQbsNlrcILuSgPIf2hYbTwDQ+xQXyCVTl?=
 =?us-ascii?Q?AseK7kpBQIdc1+digWbe+Pqg0p9zFrX6MyiDn3cOG16l3Tu+ZvYi1x7VGmuG?=
 =?us-ascii?Q?wGwSLa6LvLkqqS6RVCVwQJDiDIozmuQMOqpO8DBMAOEsOGnazztnvUG/42b+?=
 =?us-ascii?Q?BbCpZoo1h1pI84KXisfU2QjKboRc3qlUAEDjucy781g4ql19lJbX1T2ftQty?=
 =?us-ascii?Q?NgKgnI7voSDd/0uF9LcqCDTzTxzwR4agz/gqWHnvcw8cZQ2tmrjiQg8F4p3R?=
 =?us-ascii?Q?boc9PtXOxoLafkG+bk3rMDxIM/byJomWpamGBp733888EGhodw8lFRyUQDuU?=
 =?us-ascii?Q?XShfQzEzKPXuA5wYf0ka64Ibm/ALj1tnIP896kRfo/pZRAzwUE+zXrWDDnzj?=
 =?us-ascii?Q?tivkvMF0Ll6tKpGkmyTnCvnOOQTBGu6nI7Ix4F4a7L584Mlmo5HPL8J6YR+a?=
 =?us-ascii?Q?fZ6DniDY/fS/6wGRP61ysVmfUp6wYyZDfF+48mIv/oTjE2vHpuIVvnMHdjSD?=
 =?us-ascii?Q?CtnBWMC0cnYMO6fXxDxSiw1N+7THmenVUkfoN+qxz5Ca1AyutJkm48xfWlda?=
 =?us-ascii?Q?NFIIxwmWWsEH8OCY3sSDFn+Cdj9P05mazKNCYuwLoWkfJ7tgocAtFKUPgkVw?=
 =?us-ascii?Q?UMXIWn4yE1p3+93oghATpNDRwhreeXAt5RFz8KKG8N4AY1HSaeBkT5LFfBSw?=
 =?us-ascii?Q?S3w8NJz8g2DqlrpPyWM7Ep3+jBBmx/IWDVcDW76bApPPzGqlEXfl+mdXvb90?=
 =?us-ascii?Q?p5pIgjrIEBge+C22PghDRLaImvB60GA=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc0a539-9774-4bfd-f4a3-08da458a6662
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 17:56:35.3004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXCkPibfpDhsKu1fvMThveUUpOwDs3PlujlcVXsAMBHSb8MdJ5Z4JV0ywgZ88MWWuFQwMuulxFk4GfkyuckemQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3535
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move nvme_should_reset() to core code so it fits with a subsequent
core code patch. Tweak the interface to take a nvme_ctrl argument instead
of nvme_dev, and fixup the one reference. No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/nvme/host/core.c | 19 +++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 27 +--------------------------
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 72f7c95..ea9ed04 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -171,6 +171,25 @@ static inline void nvme_stop_failfast_work(struct nvme_ctrl *ctrl)
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 }
 
+bool nvme_should_reset(struct nvme_ctrl *ctrl, u32 csts)
+{
+	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
+	switch (ctrl->state) {
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		return false;
+	default:
+		break;
+	}
+
+	/*
+	 * We shouldn't reset unless the controller is on fatal error state
+	 * or if we lost the communication with it.
+	 */
+	return (csts & NVME_CSTS_CFS) ||
+		(ctrl->subsystem && (csts & NVME_CSTS_NSSRO));
+}
+EXPORT_SYMBOL_GPL(nvme_should_reset);
 
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b72b6e..0d7e9ac 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -762,6 +762,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
+bool nvme_should_reset(struct nvme_ctrl *ctrl, u32 csts);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a98a7d..c57023d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1293,31 +1293,6 @@ static void abort_endio(struct request *req, blk_status_t error)
 	blk_mq_free_request(req);
 }
 
-static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
-{
-	/* If true, indicates loss of adapter communication, possibly by a
-	 * NVMe Subsystem reset.
-	 */
-	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
-
-	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
-	switch (dev->ctrl.state) {
-	case NVME_CTRL_RESETTING:
-	case NVME_CTRL_CONNECTING:
-		return false;
-	default:
-		break;
-	}
-
-	/* We shouldn't reset unless the controller is on fatal error state
-	 * _or_ if we lost the communication with it.
-	 */
-	if (!(csts & NVME_CSTS_CFS) && !nssro)
-		return false;
-
-	return true;
-}
-
 static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 {
 	/* Read a config register to help see what died. */
@@ -1355,7 +1330,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	/*
 	 * Reset immediately if the controller is failed
 	 */
-	if (nvme_should_reset(dev, csts)) {
+	if (nvme_should_reset(&dev->ctrl, csts)) {
 		nvme_warn_reset(dev, csts);
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
-- 
1.8.3.1

