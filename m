Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE359539BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 06:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiFAENA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 00:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiFAEMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 00:12:55 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2002F01D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 21:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVt2t3QQPLbZwJ3P2gxgLvRqwu1Dsbo7nptVrlrSgTu3OBQcXR1ltJf8lXIjG1g0yb0N5jJOsTVFUrI81mYOcc0eEZKUfiSFJdM+vH/yPLZFWjSd5VKXxscL+yUWPL3ZBxLz1/Jh4bEUhObWZNPuJsY66pKbfLzRqor9wA9L9MsRwhE+WDlccAtzl8VeHehQk1woKYgUfl7gui0/0sC1SuY5euYPNZWOIMZJbWzyBw/U0NoSsXRS1sqhA2iJqPUscfmZw1q05RoxZq3PGAgoL67ojVtNqJchXQaB2AnSzCFpFTlIKp0lmFk6NqQre8twPSMibV6qsAmGb4lutZA9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+Shq/gmthPP1U0IDkP/V30UerlrzGsHlUHJ3pT6dAw=;
 b=T5fhAACAjjKgqsV/EgQKAjXP0ZGx8qSCdhY/KPVNFRYGsLKTzK+0VeElZWpVuvEudjVBl8ZgH/DKb7L/1E4syn5f5pCo+KIJaAO3CL5TcODyK9gCOPDpIF+ikE4p9NsRiiPSU/yVLl0CLgEd9LgKN2su3VbEjLSJ882tmon+HKTNb480YqbfJwecScShoGUVaBlm2dqU6PFeUhPB5T/3c1JGzjTjQKVM+B4wFd4yf29zoX9xzj/KmlzgDHAtTieG/GPuX6/qwP68EldIskL4JiwnzP+mQnDhR3c6X5HFj9gbw8YV/MQ+C4dV1REnELc32eDIaVGFmq7lwW/1YVPbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+Shq/gmthPP1U0IDkP/V30UerlrzGsHlUHJ3pT6dAw=;
 b=ZgFukNy3vYT9HZm1TprOsTOn5bivk+Hd1gjHSlYLuNz5hRhlZk5315WcHJmPtgj90992jsDExWszpH9hrBBA+AL+Zs5BN8pA7xKbemx+ONp2nlMX4u30YiLjpx2OPkBFlJqcDcf0rpw+VYi4upymXpWNrzK6IEoHS/H9Vmtnbmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MN0PR21MB3241.namprd21.prod.outlook.com (2603:10b6:208:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.1; Wed, 1 Jun
 2022 04:12:50 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::7c37:5ee5:e34d:56f3]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::7c37:5ee5:e34d:56f3%6]) with mapi id 15.20.5332.003; Wed, 1 Jun 2022
 04:12:50 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, caroline.subramoney@microsoft.com,
        riwurd@microsoft.com, nathan.obr@microsoft.com
Subject: [PATCH 2/2] nvme-pci: handle persistent internal error AER from NVMe controller
Date:   Tue, 31 May 2022 21:12:27 -0700
Message-Id: <1654056747-40143-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1654056747-40143-1-git-send-email-mikelley@microsoft.com>
References: <1654056747-40143-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR07CA0060.namprd07.prod.outlook.com (2603:10b6:100::28)
 To DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a0b8b6d-7012-4c39-9b16-08da4384fde2
X-MS-TrafficTypeDiagnostic: MN0PR21MB3241:EE_
X-Microsoft-Antispam-PRVS: <MN0PR21MB3241DE00F77D6512BD30100ED7DF9@MN0PR21MB3241.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEbmePSHfQpusd+NxXIPvnEW6az+fZvwdxwg75qsABxZDLsBsB7CtQ5qomA4eKiUXE87g5sHuegZRbWkHHs4iR2IE5mxRjplTS9CRJcOZ1A6mETRvp4QWBtuBN+0reDYLSa5Q7QaO4ssufLUB/zxGqANYbMsYSlLggKOkA+8U/2CwwaVNoquWWJegHt78G5yI0GC2UXUvVFm5189tsELuF5ihFpD2TBYVPx0BQrCmhIzzPJNtLk/5HxMQ+BQCEcB+lDHs/26EXOJgyoPd2n9rihXV3TxigaDtT7DwiBynSjIeQl3Xd8Sx+0eeyVBqMp9OijsaBVpUpPkrQQpDy7e0L5InbyTIi55Nxl1GwZc7nc3osSut2WkL2f+3i6plrkYRoeZKZ3VNT7M8PE1euRJNtgDUSARjudsyLFOk0JPaFV3qv93Xw0LdReURSs3qS50xnzBBrD+cdgy85UQYyPtWF6kiFFUrL3GTNFoUOhdVqQB6TVD/tnG5HM/7cpo3iHtHJ8nbyUlDQQv1wfcA+axbVPqt0CBhst4mU9OQEckbPI5XMCCOXNjyHbkR3AeqGpenf4S2Ngx6Bj1ziJ1k2bKleN7nDhZfD42I5WkmrsQwOX8YfJ7u+d7/XI7AD0RacRdQnaQEZLze4VeGemQ2IhgTEWuc34UnkQeMvToVjSkhi6KZDno60tiVibu+GlrfC+J9IXjAqsGF1iYdppa94XnE9/Ic83UFdPqBb+cL1oKKWOlkbl2htyCDsSGyQPlnCR6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(8676002)(4326008)(186003)(316002)(66476007)(66556008)(508600001)(66946007)(6486002)(36756003)(52116002)(38350700002)(83380400001)(26005)(6666004)(2616005)(8936002)(107886003)(38100700002)(82950400001)(86362001)(82960400001)(5660300002)(10290500003)(6512007)(2906002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pvPQ0hUNTfuvO4PPYDA3kx4djk21MhQGnLVT5EwFCTqp8rTDoiDOXlvCtac3?=
 =?us-ascii?Q?9BSCevuep073fcesl//t1UZGtfio7mNfC0Epq+Q1HG8a3qEjNO8jL55GtD60?=
 =?us-ascii?Q?oo2vMQmMBzGqg8yfT+dA2GunAVjfPAwt6g/vNWpSKxv9V+KiqtnXutcNmgbC?=
 =?us-ascii?Q?GQAwPFF13YbFUs+SV/1LF3T4rR3e72vEfGHPbvLIbKHwP16y3GGUUczfyylw?=
 =?us-ascii?Q?LkAKN+qt58PeQ5ZnyXYsdavCrzWr+t1MR5JGOISF5HsFxGjTjr8cVPrLV2wS?=
 =?us-ascii?Q?0FQnxisEDPQYwxR1sETAgdMKSBSaXn9R6zWrhLwKYiRjrgqpERMm5BQcw5FN?=
 =?us-ascii?Q?UR3rMaBBUyZWOR+qDVyxSLQZpnhYbHAT34gL7vvsbKwNYMA5fKuczjXxN8Ie?=
 =?us-ascii?Q?azMnNbEkJ2zJCtA6mUU07e08sWfP0lTi+cL3WXD+v0yvyASCOgd9vi9eHTt5?=
 =?us-ascii?Q?pcu3ROcWLD44kLaE8fDUKVYXuQGMV5vBl/rcTbUto45QCUO9mQZNRHUhA5eH?=
 =?us-ascii?Q?ltgN0qgaM1eZHeiQHinkuTlREytHyXEZoTLdPejgincSl40BCiRsnV5OBpLo?=
 =?us-ascii?Q?9HSGe2mOUtBLZWT5B4PoveVtTHXsHdvzzKm2vYHCnPDXPNkm/7pI+mC88VPB?=
 =?us-ascii?Q?B5BkaGxleoH+auRKGNNc0b2jagIjEdXO3VEHYWIG9wDc9nQ7P3QYnJNSdv3T?=
 =?us-ascii?Q?fO4S8J3sJH1DFt14l27W5cY/1eoKw58qVcJfE1nKIJnlljlArD2wZS9JWPQc?=
 =?us-ascii?Q?QtxZJrkcQa+lfyrdIFENNTrsejl0a9dNYl8PmZ5C+XndUFmioaT6gzy4YDsY?=
 =?us-ascii?Q?KvpAi2PLqpUKWniUxew/QNisvs5k58SxxPdTE0qDxxl3buVLRNRsmoUNZIpL?=
 =?us-ascii?Q?Gy0ao5gtHWzOhs4WsR8fD587ZEqXZqT6RNyMl+/APq7Epq9R2sCPpB0TMCgs?=
 =?us-ascii?Q?4j6d5W/4wgS4Xf/WFMe0+J+bY9Mbkk9Mo8B9LJXsCeiz8vUGT9LiJ9lW2vOk?=
 =?us-ascii?Q?S8NBFGqxm1hFNWjOGSsZBhGxmBij+8CSKgNvN9r5eLcXpoJYOfg/th+1Adey?=
 =?us-ascii?Q?4eL23/JkdmPCYDV6G/QDZp02zvE2f7K8Ngl7pl25f0Om80XzD1hP8DGFEpYV?=
 =?us-ascii?Q?/4baZtP0xKU4R774OjgQkt/h0MfR5XFgO6zwl9IlnFmnFxjJbc7sjOp/43JA?=
 =?us-ascii?Q?ERKuvraGYCbNTlwTh5BcByKLqOYEQCttT3t0L6wICnYomSokYf49k4GD3iIA?=
 =?us-ascii?Q?MJGuMw9lw5FqT85akhShBGUPWE0WPL3gGu8FxSy7YshL35d6LTtHwkoNTdGX?=
 =?us-ascii?Q?gjSvhQ4JEr5dcCFGHj+EqzVmnaVZxvuzCUjUT9GyAY9v07D8omM5kWeQgUkR?=
 =?us-ascii?Q?yxdG1Mb1fzag416EMkh/9UgxjPL69CwX7ivfFJ4zmRmYkl48YDED2eWGXF6K?=
 =?us-ascii?Q?8+6cevZb2pl6uYWJ+2DpcWajCaWYIkWLBMUh5oIXQqN/U7/sRYJ31dh7gCnz?=
 =?us-ascii?Q?ax8pilwK2yN8PsUS+wNYfuoeEURcSFoPNJJjyCBTR6J4C4tNK50Dqhz0nJDY?=
 =?us-ascii?Q?etjtg7khe22lh7ad2n9VdjkHd55hoxWw3ABc4QGUJ9LsfkFJfKN/1zPdyxE8?=
 =?us-ascii?Q?4NyQL2BzLvltNOxgB6i4crHfRFeRQn4w63N+N3IaVdTm0ZzAz/ABirwZGwtJ?=
 =?us-ascii?Q?nKwFnl8utLeJjKUOXLk5G3Er5fx8qdbsPXM6+c98+RYAjwAAJseSkeTKdiMH?=
 =?us-ascii?Q?A33fNl+crV2nE2bnRHcuswJQXDQ9A4I=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0b8b6d-7012-4c39-9b16-08da4384fde2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 04:12:50.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAMLZYhAELGgLeUGP3R5Ei6+D19BebF3r3cVH2szb6H1OjBCMkLA0UoG3epj9CeXUbd98EHzDN12Xg2BzrVkiQ==
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

In the NVM Express Revision 1.4 spec, Figure 145 describes possible
values for an AER with event type "Error" (value 000b). For a
Persistent Internal Error (value 03h), the host should perform a
controller reset.

Add support for this error using code that already exists for
doing a controller reset in response to a request timeout.

This new support was tested in a lab environment where we can
generate the persistent internal error on demand, and observe
both the Linux side and NVMe controller side to see that the
controller reset has been done.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---

 drivers/nvme/host/pci.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h    |  4 ++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4dd87ac..b2140e9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -131,6 +131,7 @@ struct nvme_dev {
 	void __iomem *bar;
 	unsigned long bar_mapped_size;
 	struct work_struct remove_work;
+	struct work_struct persistent_err_work;
 	struct mutex shutdown_lock;
 	bool subsystem;
 	u64 cmb_size;
@@ -1119,6 +1120,39 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 			 csts, result);
 }
 
+static void nvme_persistent_err_work(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev,
+						persistent_err_work);
+
+	nvme_dev_disable(dev, false);
+	nvme_reset_ctrl(&dev->ctrl);
+}
+
+static bool nvme_check_aen_error(struct nvme_dev *dev,
+			__le16 status, volatile union nvme_result *res)
+{
+	u32 result = le32_to_cpu(res->u32);
+	u32 csts;
+
+	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
+		return false;
+
+	/* Currently only handle Persistent Internal Error */
+	if ((result & 0x07) != NVME_AER_ERROR ||
+	    ((result & 0xff00) >> 8) != NVME_AER_ERROR_PERSIST_INT_ERR)
+		return false;
+
+	/* NVMe Spec 1.4 says to reset the controller */
+	csts = readl(dev->bar + NVME_REG_CSTS);
+	if (!nvme_should_reset(dev, csts))
+		return false;
+
+	nvme_warn_reset(dev, csts);
+	queue_work(nvme_wq, &dev->persistent_err_work);
+	return true;
+}
+
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 				   struct io_comp_batch *iob, u16 idx)
 {
@@ -1133,6 +1167,8 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 	 * for them but rather special case them here.
 	 */
 	if (unlikely(nvme_is_aen_req(nvmeq->qid, command_id))) {
+		if (nvme_check_aen_error(nvmeq->dev, cqe->status, &cqe->result))
+			return;
 		nvme_complete_async_event(&nvmeq->dev->ctrl,
 				cqe->status, &cqe->result);
 		return;
@@ -3085,6 +3121,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
+	INIT_WORK(&dev->persistent_err_work, nvme_persistent_err_work);
 	mutex_init(&dev->shutdown_lock);
 
 	result = nvme_setup_prp_pools(dev);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 29ec3e3..8ced243 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -712,6 +712,10 @@ enum {
 };
 
 enum {
+	NVME_AER_ERROR_PERSIST_INT_ERR	= 0x03,
+};
+
+enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
 	NVME_AER_NOTICE_ANA		= 0x03,
-- 
1.8.3.1

