Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D19B4B4A54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbiBNKOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:14:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345407AbiBNKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:13:08 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CABB65780;
        Mon, 14 Feb 2022 01:51:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQhrK68ikLxBZuSMAwhuCcI9r34kChWj574fpyNm1axrIFEOIXpqw/6Yav4SX213GXJ/kIIk5qnnaRaGoqsXOtJigIBXaXuUWeSEmuWHYOQwj8DzQ7y+eVEq74AtHcg2aLU4PbuQcGX/Da+/Ab/gywNri2byiJkb6NXx64avUz5wI98Ot4eBu4Dwyxvt1Sj0gbHRppwvaG8aZGXgMzidUngYSuel9BSENRn6ab72FR1Rebe6KVkscakLmbAVgxhlT1qtiUIMBr6wHX9jTq2MdNJbiqY5z5dJl1zs5bFfMbc2e9+veopgcsnCzW+xjPXlbGc5AnndBFIcbht+y1XhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsQ7L8rQ+j7uFSbvBR+XBVMOjuIRXFeibMuQAS5P3I4=;
 b=bxAmt2zchBVvfMVs/VB4j+bIZ4VNcFIWhBdLp405grPHfox4JieOkqxwaBsMc3jt9TGtveIXaSoXREmLXI0onbZsO03HSIXxnKHeLvheTzZAC3A52BDrJ4EtJK1WmG/uTpmn7Cu3524PHz54hSpuDJst3KTfAGI8DfR8k91Du0xG/fGoef6zieGmi9Tp3xaMhiIC9nqcDpI6Q8XSW52B1eixBxkIIuHsZX2vHbaK6yuCzMDKKRuBSNx4lfIVfBdLM1aO2vRTK8zdWJiP1l39ducFVfvu0lHvQb3zZG39hGOHJi4F9Z6HAx2xTxCs48/TxQ6db2UZDf42fi75ILjRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsQ7L8rQ+j7uFSbvBR+XBVMOjuIRXFeibMuQAS5P3I4=;
 b=GxqKGLT6ddfR0b6EzkEExPkOdJpQgUVcGXaEx88wKLLhl9bmrwRz0S363QB7SU9iuHpHXR9KjprogTi4OfoirJTC5pqcbECIEvss0Rxuz3g3WAlWhz6M5iPXekEjEVuKeHxswPaO2ZhV+TF59rX6Rg6jaklOtlH1LO15/J0pztPTgdY9x4+wFbZvdtKkv0dzpCVo0oUUqXzY68K2B1qahguB5K8Ru+qNhTDmpK/eVNKpV8GO5cttfV9Yu2QjkCVi1redF3xqxM741daA3X90Z82fqPHsjN2P8QIoE9FdOUJ15RWZ4pWfT6rSksOXgqGkSFUESXcbc2F1LrKx2WNuSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:307::12)
 by PAXP193MB1933.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 09:51:09 +0000
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0]) by AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0%7]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 09:51:09 +0000
Date:   Mon, 14 Feb 2022 10:51:07 +0100
From:   Markus =?utf-8?Q?Bl=C3=B6chl?= <markus.bloechl@ipetronik.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::22) To AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:307::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2d5602a-d433-455c-8c2d-08d9ef9f86b8
X-MS-TrafficTypeDiagnostic: PAXP193MB1933:EE_
X-Microsoft-Antispam-PRVS: <PAXP193MB19332AEC9E0DF7B8452ED7FA92339@PAXP193MB1933.EURP193.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtwbfTg+BHk4anzJV88Pzd+jtxvYsg14hLiSqTJHZA+LOmLvxSmTxCnmOscLOIPd07Wep0CwFZ4tpsB4epn9f1fM+v+SqkFp7DXIJBnjuECBOpEVhaBA/EQTOdx4sGA0/idooFfY+mNedmzN34tHFrLx0SDjIt9NSyMAKk9oklsuc9ZvytNV74bi9VcFivFvpcLomlyY3MD6HezOLMZWqJYDMnDcX1ur68tHNhboLXVjOz/XwnfQHEn9zmZxX76DUEhQx3axj8M+Tr2IFnIaFY19tyuyrRCSCBKYIAeUfY8sRyUkItc8CBH2ZT7hbyVWp6/1v8IqeRAx0UlJX+oCV+PP7Hdx/IaPqL/bzB/ZK+kOwPo1Xli9W9bloxfqengxTBYGJFZ47dHnVJxK4DYOLloZNT5pQuRZ74BrSU7u/s5xLp7lw8Fq6l42zwLIULD3vq14LyYVZDjTBa2yv0yr7fBGn31e97l9iFhX5nRG8AxLaerhyVswkZjdtSiWx/wz24t9AsNwrfwBKlXws4C+ZujOhVsxQMNGKP57zNYnhVJHSObMyAGGmwv+7CxJ26J1MRLO0zbyNxkiqg+E3rz/lhx3t40HR2WV111fpjJYHrZUkYOu4HcK9HvdyYco0HBO2KmGJvkOjdR1sO4n34Cykg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1572.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(8936002)(5660300002)(6506007)(2906002)(1076003)(186003)(36756003)(2616005)(66574015)(66946007)(54906003)(110136005)(508600001)(6486002)(6512007)(38100700002)(316002)(86362001)(8676002)(4326008)(66556008)(52116002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck1vbjA5bDMxaWxUVmFOZEd4UENhN3JRRTdNbjErVzJLdDdrNzE5eU9LMEpm?=
 =?utf-8?B?UWhVZWxIb0Z3MG9yaU8yY2laeEd3ZTdiQVJNQm9YVjNCLzdZeFVRdGJwM0ZW?=
 =?utf-8?B?bkx6UjNRZGJnOGUzRFhBVjBReFdZUmxZcEpWMFVNcDRFRG5FTzdOSGZLdWJG?=
 =?utf-8?B?cHp2SDRkT2p2Wnc5dEVUOUczQUpBSnJzTm9pQXFnUUVkM2Z6Z3ljWlVzbjZ5?=
 =?utf-8?B?SVhNOTN1VkZPZm13djhCK1RRMGZtWmFNeEFsdExwSEJQSEdndUV3eDJNTk9p?=
 =?utf-8?B?ZWdIVzZ1UkpoaWE0S05sdjJUZEVVVU9tNlplVjUyL0kvYTVDamJmWTZycUJV?=
 =?utf-8?B?WUJxRXI5czYxU2UzaFkxdG5lUEJZL1JQcEtIN3lWM1puR2hjd1l5ZWF6NnE2?=
 =?utf-8?B?RlRzZk9rUGRHZkF0L1dMOUp2Q0htM3ZmTUtaWmNjN3VJd0NFMmIvaTNua0E4?=
 =?utf-8?B?RHpqaHVDOGNELzZIZThuZXdRY1pzS0RjMi8zZmhQL2FxQVNBNUJibjZlQUI0?=
 =?utf-8?B?WXZ0NG56cXNGMHlVWTErYURHMXB5ZSsvNXdkNGZvUlZ6M0dydW9UMmFsbTY5?=
 =?utf-8?B?S0NxdzVDWHpLdWkrRmVxNmxyT0c3STNULy9vd2Z5QTc2OHArczY0Nkh3OWdk?=
 =?utf-8?B?Z2t5RXk1cFVFZjVhRjJlYzJzSzk5MDUyUi9ORjdmL3lqbHVYZk9mbjB6VlR4?=
 =?utf-8?B?T2VUUGwzM0tYWnlWWExOWnhMcXdES2lzeUtaMmxJM0dXZENDY3ZWV0sxQWQw?=
 =?utf-8?B?eWc2ZHdTU1pwczlQTU9WeFJ6ditML2krN3JFTllleVNJLzNBdDJLb0JBSmxC?=
 =?utf-8?B?b2o0aHJyY2IrVkt1NFVqTVdQSldTYzMzLzl4dms1Qmg5alQ5ZWY5NysyaUE4?=
 =?utf-8?B?UVBaUExaNDZqYm5VMm51dzRnM2grYXJNekllZVdMZ1dDQWdBb1dVbHpuV01h?=
 =?utf-8?B?WXZaS1BkM2gyUzA4RzhVT0I2TXRBZXVDdk51VzJZOUNtR0pkbkhuNklESU03?=
 =?utf-8?B?ajZ2cHI2NUxGd0hZOXloWk9yeDdFa1FMS0V3MDlXZng1UmxFY0thRUQwNUVE?=
 =?utf-8?B?bFdSb0FaMHorVzgveGRzTERpUlo4QW5VdkdNSmhuOTZybjY3dlRJUzJNSVRR?=
 =?utf-8?B?RnZIVUpTYld2bW5ISC80Y2NNc2l4TzF3Qmd3M2lRSTE1cVlKNm00b3QyUGFv?=
 =?utf-8?B?UmZMc0ZKOVpUcUtkTDkxOXdoQnQ5MTZ3RHdVd3dZR3NqZlkwSVZ2VzBPVWIv?=
 =?utf-8?B?T2lSS1dWUmU5c2J2TktWQW1naXJJTGd1YWFMMk1nWXdBTWhBVUxZTUtZK0Nm?=
 =?utf-8?B?QWE4amtob0Y5ZWdkTU80d00xR1k1bXI5MmY3M3ZzYlhIbXRoOGRORkk3WjBt?=
 =?utf-8?B?d2xFR2VJQWRaTkZUWHBTN2hBZmVqVllTd0dWVHRpcG5TWStha0FvMW1YSEdz?=
 =?utf-8?B?UWtHelRwblJnYm1nL05zeHZaZkViNUdHMDl6NVMzQVdmdVJ1aGtXbkQrYW9B?=
 =?utf-8?B?Ri9WNGt4RGZMNVljQmhVLzd4WVpmdkpKeHdCYVQ3WWxaVWtUZDRiTDk5NHZm?=
 =?utf-8?B?UFhnMnl3bmFGaVdVRW5hQ0FHMnZtbU80aDJpVFRTZmV2V2NXVkwrd0lQMUY4?=
 =?utf-8?B?ZmhnY1NPdGRiVCtQUGk4cHExOER3eCt3L1U4VHdQY2ZDa3MwblMvcXRKNFV6?=
 =?utf-8?B?TTI1RXdmSW1ySFhkWW16V2JmVXUrakE4cVFkNXZNeUZXOWJnZTlvUEtaT2lD?=
 =?utf-8?B?OWVNaUljcDEwRFlueTlia202SUpHRHZzb1ZXY09QeFRMQzBTSkJrRk10QW5E?=
 =?utf-8?B?dVgrbWxUS2xBZncrZzBRdnY0VTlBVktIMi9KS25YSkdJaytRNnZTMXBvak5r?=
 =?utf-8?B?RFpuNlE4NHl1VExCTEU1S0p6NDgySVM5OE1pTHNLelNPYWVyNkE5dzBIS0xP?=
 =?utf-8?B?eGxrWmpiSmpMNkplZkhLVkhZcWdyenJ4UURRejhlOGwwd3BVQ1BGM3dmclZN?=
 =?utf-8?B?TmU5Q21URVBCZng4MDJWT1dSZ0ZJT241ZW1oNERkbWZCY2tqUTQwTWVwMjZW?=
 =?utf-8?B?dUx6MnVmY0szRlJkL0c5Q0x1UzZhT1YyenptUlBVOWZOcWJnRG41QlZ4VWdX?=
 =?utf-8?B?b1JWMGhpbHpzd0puclJpUlpGQlNhcHV2S0ZlcGcrMk9WeDh5UzBDWC9lUDlY?=
 =?utf-8?B?dk1RdmJvVmNLTUFSRE5Zd3RqYkttRjcxM2J4VWpveEx0SEd6MGVmTDN4aytm?=
 =?utf-8?B?cmZKNzIxWUt5QkJzUUVUUFZhM3JFRFRCLzZSaTVjNTA1WitncGVtVDhhZk5T?=
 =?utf-8?B?YUVCUEh5TGN5dzV5Mmppd0JCUXRkUTlkK2VKa2M3VmZVZmZlbkUwQT09?=
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d5602a-d433-455c-8c2d-08d9ef9f86b8
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:51:09.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9z+Lb2VDXu5Q/XRBcf2uF0dvAq/mK5x7Ei8cLJt2xxxky/moWsR3gR6YAIg+eFKOrjGlfoUCzKrA3kaU07Md3woYz5gahBPcqVofcIf0zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the surprise removal of a mounted NVMe disk the pciehp task
reliably hangs forever with a trace similar to this one:

 INFO: task irq/43-pciehp:64 blocked for more than 120 seconds.
 Call Trace:
  <TASK>
  __bio_queue_enter
  blk_mq_submit_bio
  submit_bio_noacct
  submit_bio_wait
  blkdev_issue_flush
  ext4_sync_fs
  sync_filesystem
  fsync_bdev
  delete_partition
  blk_drop_partitions
  del_gendisk
  nvme_ns_remove
  nvme_remove_namespaces
  nvme_remove
  pci_device_remove
  __device_release_driver
  device_release_driver
  pci_stop_bus_device
  pci_stop_and_remove_bus_device
  pciehp_unconfigure_device
  pciehp_disable_slot
  pciehp_handle_presence_or_link_change
  pciehp_ist
  </TASK>

I observed this with 5.15.5 from debian bullseye-backports and confirmed
with 5.17.0-rc3 but previous kernels may be affected as well.

I read that del_gendisk() prevents any new I/O only after
flushing and dropping all partitions.
But in case of a surprise removal any new blocking I/O must be prevented
first. I assume that nvme_set_queue_dying() is supposed to do that.
Is there any other mechanism in place which should achieve this?

Unfortunately I am not very familiar with the blk_mq infrastructure so
any comments and suggestions are very welcome.

Best regards,

Markus


Signed-off-by: Markus Blöchl <markus.bloechl@ipetronik.com>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 961a5f8a44d2..0654cbe9b80e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4573,6 +4573,8 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
 
+	set_bit(GD_DEAD, &ns->disk->state);
+
 	blk_set_queue_dying(ns->queue);
 	nvme_start_ns_queue(ns);
 

base-commit: f1baf68e1383f6ed93eb9cff2866d46562607a43
-- 
2.35.1
