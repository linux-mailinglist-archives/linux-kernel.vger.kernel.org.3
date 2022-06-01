Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F5D539BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 06:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiFAEM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 00:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiFAEMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 00:12:53 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DA82F014
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 21:12:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVeotm6OCuDKJF0oBvK811sY9+j/sXLliDnkDE5j6T2YR8GZQInNiI1555p587xuyZKu4BpduyhVMIHs1e+8Ee86MRXKx71N2Q3y0H27CW7H3G0vmotXOvDQLW8Kb4zLG2EfTDKGtBxWJtn9PUCxRW2HPPVglbNfoGuJbJlS7h/z+CPo+PPhmkcPl5mDhdo5j2DQZRIeUs6dFT+tFtr2aupWgPDJF+rbei+qXHhqKy4Bmqg1G0lBlUfegd/YqGprWXw8pl3Tium3hXgKOB704iuIFC/L3kc07svPVgGVO70OkfEE4gxX0ONM+88flRERJTVhgHtjIgKItiYESCEEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1BWwk9692iyvzIPw7mmb1S9tyKO6EjBtiE5tdV/n1s=;
 b=a3q+1nOTAYY0eUaiPZotoQjFHt8OXcIzzLSBJRJNUbvO00Ll6rxyC/8NXXh8qmbzXh+GxneAmHGlQJ36tIYruvMtNgYY6ETRu+1+/aCiPWG0r8WWrTHZfRfplQNYDHDb6SlalRw1CP6MRKDDr25ULI0zP4fXBgE/M/SZx/V+gAS88cUFBHYE5xDQl9DkHC2gUGQN1GUj1eIa+3SjcS+W1Yh0jn7kWGnxa4bexS+uQpShUzLJ8AFr2hPp9IRaeqyjSnqlxExkz5qFeZ3+MQb1uyfT3UjKz5zhah+BzMq/Zyrz7M3/wY0CpruYbZwL9noZ+y3lDozXwuGOmpQk80XhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1BWwk9692iyvzIPw7mmb1S9tyKO6EjBtiE5tdV/n1s=;
 b=XNxzOx+tqSPWEUZUtssk/TQYkVqn0iU0SkQIvpPOsFu933VJtYkWa/pm6gLmibvWVBNBwKlxrovYkMPCHhOQNG3cI9r8eXkm5VlzNGxpCH83zKi6Icip1fMN3bJP9zZJdQdvkdg7jEj0cJIHPaDASFawoCxOijGZpj/biunL9pY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MN0PR21MB3241.namprd21.prod.outlook.com (2603:10b6:208:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.1; Wed, 1 Jun
 2022 04:12:49 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::7c37:5ee5:e34d:56f3]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::7c37:5ee5:e34d:56f3%6]) with mapi id 15.20.5332.003; Wed, 1 Jun 2022
 04:12:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, caroline.subramoney@microsoft.com,
        riwurd@microsoft.com, nathan.obr@microsoft.com
Subject: [PATCH 1/2] nvme-pci: Move two functions to avoid forward reference
Date:   Tue, 31 May 2022 21:12:26 -0700
Message-Id: <1654056747-40143-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CO2PR07CA0060.namprd07.prod.outlook.com (2603:10b6:100::28)
 To DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0808e866-dfda-4950-4d2f-08da4384fd72
X-MS-TrafficTypeDiagnostic: MN0PR21MB3241:EE_
X-Microsoft-Antispam-PRVS: <MN0PR21MB32418A8EFCE31544B3B04005D7DF9@MN0PR21MB3241.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJBIkH04SIWff3jrR927PjRXI5Aod3sLqrC0ez3/rPwitSfOrxNQeKLc+PdlNI2Xrx/uuCnZ0CB76Krak5cgQ8kIsjg7T1JJHkr5MtaGQ2nFBeQXH0qDWX9WENUbIoorZMtSyKEvD6wf+4Ixhtj+2txDyJzFWhaVAd/qIlKygAyqqKaPdSvnn6em+ohcFcL9Bvxj9VX3uyWyxUc5zHqSSnhv7lDySkCb0dhFlcIiOqdr+JLhoHMLHz8UJ4Xtf2gGkMwEzj3FtZe1s/HkB6cR+E0aTOep/v9JtZxaYk24z8+QRsqnVNafEgOZA/w4YKE06M6Mt+aXp0LDeSw+jBrxgmgVJwm4FrGs3ICsWTRW2tKJbEjnIvyJR6K0o2XE6q2T6FmMmmxjrLSanY3RmlWZ1RW1tROaoeHvxGYdffnaoIlREqpOqboUKeJhfT4wFeJCWwEphZ0fGWbS8UhzJdXD6OAnrYcoFzgMgnx4YPgRvQV/D4yb6iku2684RzhQznME071kaitunGPTzilq/DNpg/0H94ex5AXfUX/wKKXOeYZ2nQ10sdYFfcjqakKZx9Xno2k7mrVfXpXSycuJAwnC8qmmbQ9byi+KSyWltoYopfPxC+5Xhne8Pp9IE+SuDAwrpbhZcegRh7G0gwqIL0/CyidVrg681czYue85S0TrMNbwm1HXGFkF7BZnxMhVKqjDkqP1EBR+TNIjT6JuIMLz4WBaI/aXnrXoyNRt1yWgD4meCNbrh0XjOb0SPsCVYF6i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(8676002)(4326008)(186003)(316002)(66476007)(66556008)(508600001)(66946007)(6486002)(36756003)(52116002)(38350700002)(83380400001)(26005)(6666004)(2616005)(8936002)(107886003)(38100700002)(82950400001)(86362001)(82960400001)(5660300002)(10290500003)(6512007)(2906002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CGt5aoXi6UNRFRGKFFpXW3ZvYlhM3zwO7C27DKVj+QVP1OnrZRycNcPZOu83?=
 =?us-ascii?Q?tYkIz/VB2i7YpMchQDFv1sphYHi2d1DMvq60tmh5EfoZhJ17uxUOyuNE4/j3?=
 =?us-ascii?Q?c3Kx7Q1Cyc+4TKD7Su/94Q7XBo9bw8Ox9v0RnnZwNwC8H8fHXbeYr1j4CEi6?=
 =?us-ascii?Q?MI7UM2gyVWojq9Zhu+wWalE9yco6l00/qJIyXdOEzRz0yjAKN2kyAvdJ9whJ?=
 =?us-ascii?Q?DdH6ECG94V4VKpB5xTS4wPzV/tCmkvFCBk413SCERkdtHIcbZqC5cTPGWQ02?=
 =?us-ascii?Q?3v+Iqq7Iy63UdA8CTxTjpCJifSXk2gjgpeu0VDVyISyf3SqfHRGqTndT6arL?=
 =?us-ascii?Q?DXB1+XnrNO4rtcpHzVIqdnWqyQ7MdOynCpHbOJAbVo87o7xYTfLRVJeYy9Xl?=
 =?us-ascii?Q?pi5C2Zm49xEiwNYjEbOqpg51TrBELdsGq+Kp9aIry7TRTUanJVjEFOuY6mqj?=
 =?us-ascii?Q?6jyDGrXrtQRLdSBOEtHxpa+bDFAuLfyatF1Sd/N74i0rJfvEtT/4cpIAWRp6?=
 =?us-ascii?Q?00CrZ1KpCg+qY8Nu8fWMxYm76p0IYPKWfe6IYTq3rCjkfPOksdoy4135CVwl?=
 =?us-ascii?Q?2hIs6/v4ZF83k5ZbfPHmiP2erlIhIaw3WvgfTKMGDpJUFKyU5c2PKRUA22zj?=
 =?us-ascii?Q?FDx+UNLjqry/tUq8Q8RGhABCxvLM3o5DAXP8p09ovvJ5KWXKpyT+fW/l7gBv?=
 =?us-ascii?Q?Ayxp5+oE5YcW5oSp7DBVo26vnM15DPBKmHP+wuUhIvoS5WqUwA18ZVTKxion?=
 =?us-ascii?Q?1yplLoA6p/DX0wqQBvFdCmxEcZnKbrouzNjROzg9uS7aA+3w4zOOsfS/Pa6L?=
 =?us-ascii?Q?HmK7b7KGsLVQnnWeItwdrchUXVGevQVCBBxbEOvX+eLYoNvsTbAPeL3r4MH8?=
 =?us-ascii?Q?HKDRNQJ4xJ0ZGC0XzyKbo+Vn5EfzgoNdeuL4Ojv3AkwTtleH8Svdk4nACFVF?=
 =?us-ascii?Q?v7OPtD0BOuwk2WOmeCRURUlZ/Iqaw5+0AFqtV1Y1oZKCG+3tsV4cJWR0HRRz?=
 =?us-ascii?Q?JLilqrVwXikJ1tqVBIC3PAnFYy3zd+RZ9TMvketqsvmVQs52sDNRngoK1bUK?=
 =?us-ascii?Q?a0aoI99QzQjaWrG1LjeM/xlbCizZ/a5F0G5FTPdOUf/crvUbylTh9uGhqRCH?=
 =?us-ascii?Q?7lKngfPtheXSA+4SNdyrmlIfMlI4vLMeKb1ixRRVhBRikTnP0koGZt3GMQeg?=
 =?us-ascii?Q?LWlnZ3yZA7RBkykXRDpn7yRGRG0bd1hKX4q0y3n1IiHUWWgzS/JoImRUIk4u?=
 =?us-ascii?Q?TOaEofvU53/ELOatWYh/5XUzhP2xseXADh0HDTtTplLMcazNKsMwF2rq0iJc?=
 =?us-ascii?Q?wMAN4IjtmCWvgskoVCFx2thufoH3nr/yWRjTo7UU0Sl9RPaDwtyucyBdqHUa?=
 =?us-ascii?Q?v13xkqaWCJNzKC0nFNHkBTybuL7JSEfeYnAl0BnUUeld4df6VtvOmEJAg9xT?=
 =?us-ascii?Q?YnD32koMvatvbCDKfbZaUAVPePEDcXM/citGBQoXHRRmlNMuv1A9QKdu0zQh?=
 =?us-ascii?Q?/pwRKuyRgDb2Ehp3r7ZgRla5/yjGCwOPZsBnFuqey/h6v8UajmlQrNtINEQ8?=
 =?us-ascii?Q?RxEhqd1gXe4+fW3IcexN4jk1e6jQ+KuZWEOelEZkGs4zhkmxP7YbAIM7nGFq?=
 =?us-ascii?Q?VXi0/d23FRwVaUTnOWuW968IUB+B03L7ckxZwbXLBjwhijOheQ3g3X1FkPFE?=
 =?us-ascii?Q?XFYXuN986b5PIoAoLnu1a08y6gnhJOCU4hU5cZkxF68bNwfemZCnbFAFwOwa?=
 =?us-ascii?Q?9I/aqPzp5A=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0808e866-dfda-4950-4d2f-08da4384fd72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 04:12:49.4639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8x956wTQi1TEp3bz8n5vnTw8MczseZFVpY0G9Y6mz3sbumkJhYCg4daG/SIadqPQ/oQyZqidynndGRUDTTDCPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3241
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move nvme_should_reset() and nvme_warn_reset() earlier in
the source file to avoid forward references in a subsequent
patch. No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/nvme/host/pci.c | 86 ++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a98a7d..4dd87ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1076,6 +1076,49 @@ static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
 	return nvmeq->dev->tagset.tags[nvmeq->qid - 1];
 }
 
+static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
+{
+	/* If true, indicates loss of adapter communication, possibly by a
+	 * NVMe Subsystem reset.
+	 */
+	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
+
+	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
+	switch (dev->ctrl.state) {
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		return false;
+	default:
+		break;
+	}
+
+	/* We shouldn't reset unless the controller is on fatal error state
+	 * _or_ if we lost the communication with it.
+	 */
+	if (!(csts & NVME_CSTS_CFS) && !nssro)
+		return false;
+
+	return true;
+}
+
+static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
+{
+	/* Read a config register to help see what died. */
+	u16 pci_status;
+	int result;
+
+	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
+				      &pci_status);
+	if (result == PCIBIOS_SUCCESSFUL)
+		dev_warn(dev->ctrl.device,
+			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
+			 csts, pci_status);
+	else
+		dev_warn(dev->ctrl.device,
+			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
+			 csts, result);
+}
+
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 				   struct io_comp_batch *iob, u16 idx)
 {
@@ -1293,49 +1336,6 @@ static void abort_endio(struct request *req, blk_status_t error)
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
-static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
-{
-	/* Read a config register to help see what died. */
-	u16 pci_status;
-	int result;
-
-	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
-				      &pci_status);
-	if (result == PCIBIOS_SUCCESSFUL)
-		dev_warn(dev->ctrl.device,
-			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
-			 csts, pci_status);
-	else
-		dev_warn(dev->ctrl.device,
-			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
-			 csts, result);
-}
-
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-- 
1.8.3.1

