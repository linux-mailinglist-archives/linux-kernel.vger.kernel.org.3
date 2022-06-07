Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25E853F2E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiFGAP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiFGAP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:15:56 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D154D24958
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Udg05ODlWRy3SzjW8yyfT5Z9e/QvvX8CTBqQScynKJKUdS1dTbhsi/o9Yx3o08ZLsizfMhlWUpbWkBv35c9sbanSd4fW4+SA2kOLZQuwcUuS1Xyj0jKA9oIduY5yIHG2vA+NgUns+AKbuVWctii+XUqEiECuVCsVyOw+AxSidLwcKb7A4wsx1dmZkwlZTT7vqj34WoqK9Xg4kZlQ8ZPxXPd8fAwdXeXvlL5Q/f+3lfCI3/DFJ7BaC420b7L4/+LKjX360rEdJ0mMf0zGuTyeiuRTHDh8BrmYSDYyXNVTYPgfOPt+opQy/PM7zm9lDvL+ob0MDqpZDURyqiMIeCJrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKFCwgufwNV7/yQCbYy55RS7j9ILGY+Sram288MX+zY=;
 b=gPBUTrGaqPxfY0uSvN5vNUj4GHdhfxrG7x7e9j7HPeS6DpB02rudjjLmdjo0VwizPJSKIDSxFZQ00UcXrKt0YyXF95sOHsLhr69z0DLs4bs8XrGKPS6Pbx2OalrC3RI/qyuTZ9KPFpGIETAEt9KW6DA1kHSXP2h0liB66p0NAgT4SaT7clW0hXc8gfEIMJvChjQ72eVUgNJvxvUxjxPP6wb/GmjCR7r6/l6FX8Eyu9C8aVD5tPJTOUwHESdcQGxicFOK9FMQayECrQtQ0A1Tw7KdlXwRW8MbtR9FYdHaa0u8ypgScaRRNX3lkPCA0zBOjqZSez+SgPBCRly+PtHu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKFCwgufwNV7/yQCbYy55RS7j9ILGY+Sram288MX+zY=;
 b=BB4mQ6+Aflq7gL0GXg7k7JQOrs92JzS5M16J8k+ak0J0WsdMKjJUOcXLB6nxIghdrzUHKxecfeGLOGyp/ufxa+jeEyWAfay8Eo7aJpZCVl1eJZnsGWyHjlJ2T9reTqc1X9SSZatO+fuRP4shaREBX+DDHLPFnh8S08XDbDbjSZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MN0PR21MB3415.namprd21.prod.outlook.com (2603:10b6:208:3d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.1; Tue, 7 Jun
 2022 00:15:52 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8%8]) with mapi id 15.20.5353.001; Tue, 7 Jun 2022
 00:15:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, caroline.subramoney@microsoft.com,
        riwurd@microsoft.com, nathan.obr@microsoft.com
Subject: [PATCH v3 1/2] nvme-pci: move nvme_should_reset() to core code
Date:   Mon,  6 Jun 2022 17:15:14 -0700
Message-Id: <1654560915-22449-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:303:b6::13) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fbda3db-8cf0-44d4-86a6-08da481ae1ba
X-MS-TrafficTypeDiagnostic: MN0PR21MB3415:EE_
X-Microsoft-Antispam-PRVS: <MN0PR21MB341591BDB977015BFA37FE01D7A59@MN0PR21MB3415.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xK5J2V+mkGvN92WVsAkwcmbacvjDbSrcHgcIKGaWp91Y6Ne+peDpbtPgZ8XzDOKIqZPbhEobECRaKwpQ0/OLTyn31gszBRqsg9ZDrhRbCfnExx7OtkQRZPh+DJy3DN6XGIbNZ2OzZoxoPfPE4AuDF6Vl6sHZljCxXuhCSULaS4M7nx48SF0woyonGLfKICovV4yG5MwkmbtgYIFDRsgrADi9daVo+P6q8AE+kzXcPLdgmzrQDqj6W+KumyOUkho3i81I9nNzxlz6eYxyci4Gg53QxToFUPETDaCt/YQnZTtZU9pkwG7yiwm5tYLA+MniV7iAuePpi0SxiQMCnfEOw1/ROLDLQwrFyEriwYGKFxkc9uQ9utnWr+kgepFCm0RZtUBrwiNuLRodYtFWAaRCIGtW2aFH6LiYsHA49oo4VmI+3qY138Z+DkrnCqZvsGzcnq1k5TxtKVPeDbNrlP1jY4B32IWysV9iKFbctpNbp1UrBVKl7cNCpljOlIuEWBJs/GBkj30r3KoHa6qtM6fMBGcyxfzR9WNjxRYaTb11aRcZJBGTC3abaB6lDsFiiqBETlNP6v1jKynXIPhqUXorFrSze06y6MX2yiSn9NoOEr19cSiMv+ONjdZytrk/e9ziEnRQd97btVqRvXiGUfl4p1AmZ5YuO0/sZHkCMMaO2quACygW8FZngSExT0mBSb3FYm5q3JXWnxj0o0iBs0AO8ooGscE6aOq0DePRppVIc7bEHuDDExfQU9NmEAdFX+to
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(66556008)(8676002)(83380400001)(6666004)(66946007)(82950400001)(66476007)(82960400001)(2906002)(4326008)(52116002)(316002)(10290500003)(26005)(508600001)(6506007)(36756003)(6486002)(186003)(107886003)(2616005)(86362001)(5660300002)(6512007)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gI6unz9Bzek0KGT+heUzW2WZN+ROMIxE3NlrPBtw499roM0QcJCNi+qcSq61?=
 =?us-ascii?Q?wk9nz6/4lGt+74vJJiSOY1xA30knsEzKZuYEcTQilVa7yQiJJ+VfCPmetI0O?=
 =?us-ascii?Q?fL91Id1a32rTlhHEuv6HnT1j1D9Tl3YFE4psp9oSSBWVmu//C+ur14J9V3lg?=
 =?us-ascii?Q?uCgUDahm3dub7FkRTztq07DkqKJTQZsCJT6r+du0w4VTWrRzb7Jy2rrW9OZD?=
 =?us-ascii?Q?G4Ay1tr6hE/KHEx4ULyfXpBAiJIxBMJzzqzgFzNCP/Oq2XaDrvdCJ41NJ74X?=
 =?us-ascii?Q?J96qv7COyDVeR8sse1jXTjvLiig8A1jq4thCBF1HkUofbOAP1o0D2pTGIlhg?=
 =?us-ascii?Q?zjBrL2UG81a835YClQGbRfqANnd9u3Y8A5qVe7BXGni/9x1BffZU4VijQB1e?=
 =?us-ascii?Q?Ch0kQzSIYijO9rUwwqLn9Hs8DIbUg+//BoHEUc/CumuMODFolzlY9Ql9P6aA?=
 =?us-ascii?Q?6w8PX1cC4TDbzX/rh8GDR+9LY7P3VajtBu7F0XTW3JCtYeD4PB5cdPOKi3a7?=
 =?us-ascii?Q?XEjEuilpS05hl2squsWbzHcqhZ8FbhwuVRDtYaNGSKNDZLLWvuRY85YDVycT?=
 =?us-ascii?Q?j1kco97UZYDT8mVG0xelbF0ABdvlD0bQYNRGG30RKNWpjULaGWXde1U1XVY6?=
 =?us-ascii?Q?HwN4kw0YtusvZ+yCqRldg0P3kJrJVM99lON/VrrfiBsoJx897D8jIfIO6ila?=
 =?us-ascii?Q?vB8p1wNoB5Tnm03sEGEP/NINZQTVhBznPfsVwmOjrFhL95EVEnrTDUNuyPU9?=
 =?us-ascii?Q?KY1hu4a9T5VOrSAJpyTj7LgKn3Ro6CLzo4IG+mnE/BnLkbZ/VX0jgmIurQDD?=
 =?us-ascii?Q?sry4iSdgSBQhidj8npSViPTk7AmQ0L/OHBfwGQmMCnt4JanptARY2GxKaMIV?=
 =?us-ascii?Q?/uFvTXHJ8vCNQlwVJ/Hm3YQDvcYFc8lstI/blDrBmy6IEzeytPvBxKHN8mSf?=
 =?us-ascii?Q?KFTjw9r8Qg+PAdlvn8UovIumPVeZqdObdUluFoKfr41YDTzE8y86+Uclj58e?=
 =?us-ascii?Q?qhj6uRIGo3NdGYw6kPfPDEemTc1uJ8VO90wUJvYQ8dPbr9inPBKO5+28oKOF?=
 =?us-ascii?Q?5fX5VYAjZSecFhcJgm4gmOIpGNPYZY+4xHGNScizbd/pDTV5QPg8bmpRF1bQ?=
 =?us-ascii?Q?sNPahGV5HrxdUDgXZTIQwClsaPv8FRkA9DsZi13EwVpEo54dEWdARvJcO0Zj?=
 =?us-ascii?Q?mFr8QkWVU/Y7dshMylY+PDPbdXCficWHWhVdlyHziTb27nXEWC7JwhCYiYy7?=
 =?us-ascii?Q?sWZSZBcbwCh6J3JYXgIgSJy1154r227s48wzmrjCk6VmCRAplGZFqogiB0/s?=
 =?us-ascii?Q?Lr/ZuX/HZFoMGe8VpIq8YNj6kDdiygKKr/7TGsfmb0iL9V7eLZMVEfRBeF4X?=
 =?us-ascii?Q?KfFKVjYhzOH9aRko1q6WCb1um/YnrYo/S8G7B7ch6KAqMzKI0VgU8cDCMZc5?=
 =?us-ascii?Q?cGcKwnJsC14J+c6tnDhD3H7QJw8YCMiSDJtKSfIug8PaiziwSO1LjMIC6+y5?=
 =?us-ascii?Q?WNcDDOM+XGi9sZa5T2RcEx+TiJw2YSJtLnNvi6Pzb304mw3YM20y8J7syb6j?=
 =?us-ascii?Q?bvhdxCWgFHrEzEs8eZKiMj7LC5i2wrD/QhH7eim9a80Cp59EEELF7G5Go2Ge?=
 =?us-ascii?Q?qk/49EzRfaMMEdwCElWgl5tX/frzvEsgp3uT/4zv44qPG/k8vLr4701wnuPC?=
 =?us-ascii?Q?uCmk+zC+amWST+M1kBHiEt5CVAGckP9781wyMHMUVlzV7QkGVdOdS9AbCAF/?=
 =?us-ascii?Q?FAmEjNZGFQ=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbda3db-8cf0-44d4-86a6-08da481ae1ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 00:15:52.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7xTtc5nP4RYz04RYe05dKqUdqzNlYdXI4QBsCRyc7Ks0b0VU9iA2IqnvG+F6CvyCLk1lV7Yu4Vd8DO3DklDGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3415
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v2: None


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

