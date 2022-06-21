Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD23B553512
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352079AbiFUO7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352211AbiFUO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:58:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075089.outbound.protection.outlook.com [40.92.75.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCB238B3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/5LqrqGoJ10szKIWO8p3cdAnZJn8C8xfFeNFqHmw6kXmT7LyEuGekaCo7ts3R59lkupP5PwwSK7OVTW8GYyu1nL7OiyK8WIrD+2BNca21MGa34N9yVnjYWmGBYbSy9yYve50uHFkawmXVdhyKC0BIdDw0DipcrwyzZsH+HuTgoYzKtDfjuKmeVvfm8vZ0IGDC+25GU30beUorQb+Op6b9d9XcrG0m1xZKKXHj9+i8I3GgyfIJoyC+YUI9rc75AfW9f4g4HWiyNGSiJvWlLqA1dRF7803zqh5y3ociDY8/NyZL0EknWCC0I5kn/BfTyud5R574xaCSk7iiK1pJnkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkIpHOiFsBE7TckXCIgupXutFXM182+kySHL+jZrKaE=;
 b=aedbZgvWl3185xM5V7w1n8FwL8sI60XQpohiV0JgN6dmnLuRZVf9AghqmMKkMrzdNFp45EahSsJs0Gb4Ble2loCBgufMKa5R7j9GY5yAIpgJ1YqYTrI5GX5W4ioaKpFiDEIuszxVgrbkwoIpB8tigO/3ig5Rv8FRBhkvzS5l9laSRE//WlGnTEV44MZieRKyhZFJBv2Nq1ka1X14LjhrJJN5LXefbj9YfpYji7DKRUvnKmk9Q4qmvIeuec093YiyKZLwiY0a3XPtla9ww7S/JgbKxkrlqoaijqMD8lI1UIbADX3p212bUev2l6QekSHswgKSFNYzoQyHs46bsT2img==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkIpHOiFsBE7TckXCIgupXutFXM182+kySHL+jZrKaE=;
 b=PxFK1iBySgo5DHibrRODvKYZEH6Op5l1VFAf81rF498Jl8G6wVH3nvt83aG1c5oM063sL2RS5pu+uiVMRIQOj0cmrHfBzi654Avg3ZcdQxje/eToGRzlS+J0allUQpqXQNWpLDb5oCN6NHyZjefsGsPpL3H91oPTSiYOw611rTkgBQkQYdgFIDxKU6W1ZUH9x/SUYNmvYmYAOf4+TcPtQ/JHSZfTloD9mfRWVBe2PyCC4ruA15cMDqHBZjIsEPe/F+JpFi0JVv++zbtPXkbKVyfreR3sfx3q1hiYGvY3LDuJViA3aiwzzb3V2/FnLwotSEkmRwQIyveczxsz0mHc1w==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by DB6P190MB0437.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:3e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Tue, 21 Jun 2022 14:58:46 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 14:58:46 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8192e: make sizeof type-independent
Date:   Tue, 21 Jun 2022 16:58:45 +0200
Message-ID: <AM9P190MB1299D518C86D495B168954B2A5B39@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [xzZ6TgABBooZcAgZ/X7PYjvGH9OihRdzcnLobs9wUZuSpmaEslUjSej+Jdne3LLH]
X-ClientProxiedBy: AS9PR06CA0378.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::18) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <20220621145845.229560-1-f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7838720f-193e-4766-d41a-08da53968ac0
X-MS-TrafficTypeDiagnostic: DB6P190MB0437:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xrm3o4bJAgfaHIwG7PLA/gbqG2hHYopx/oohTngR7xXG/mhGE40XbnCbBZQC6laSvUhowBPYJc0rIxOc8/QcPDC26d35S4Z/5kT2eWBr5G3czmZJxkaW5cK7PBsfLUGqJLTXROvdauKY+m7ZVhu/ckXz0VDv1vLWJNyAb9UmVQPG9TkPtzyEPXdJTSA8HN7ECFxEy3qrDRV884s7oyZmY6AkqkE3mxQeEKOhen+wr54ZOE5a/vKzysO73aYWhUu0KWLEX2iVCdYYkSo0K/6ptXt7NoFLYvo1CYq5OQ428pzMzvv4kdP3KAiKLQ0pZj+x9dgXFQJ6x7Uc3/V4oD8skPd6tVIf6UFniGtvSBRVu0X4yEie3nhDtE+6BxgfWgHwsxNN843yQjBykGKmdUO/ffcB+VzG5J8dxxUXcAGKwO5EMGmgINQPHgWWwZXyAE/VwRptLljXgk4Z+HaismsfvnhUBdDoT4q9yJf2+mcNemlqvD1hwgxeF+am4XroATjKrEOBkQnw5CuxqHDQYuCPIbY12rLFsOCRbWzR2HvzZuwBsiqS6IIdGibY9UbtRWdw6y6SIkFxdFPUcdmXfv0CPA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ivIE68/sNkNRNQFn7b5HjnZYACtVAJEEFlHueJApSAFpvBuQzvPIxF8JfxLV?=
 =?us-ascii?Q?vpPd80VtYZysuHWZqZF2NlFYEhMrMMFLy70Yxg4vz26Cr6kZaM9B3RNrbxNZ?=
 =?us-ascii?Q?mLmQ5aVlmAuOLWlzeOAGbc1J6AqIk/fWENYJ/nWoo0t1szHHHrEe4bIHCCtP?=
 =?us-ascii?Q?w3xtsKDJh+o5bMaC6t50LNLHjPi07SuxQzF29IFpXG6GKbDz34BEJosh+nM5?=
 =?us-ascii?Q?7ljSnVO0pQqg+ZTMW64Q7keCyNKLQXyj2Am8EKqVYGbgW6jtWY+vYal+1j/Z?=
 =?us-ascii?Q?FtitNSEM5cwGsZV51T5wOXPGXDz0YYgKqfZBIvuh+AelZurheg69kshaenTS?=
 =?us-ascii?Q?1jvYUEJ3XlRKTkYbylzgb4W18XmMfNSkJdn8o3Rkb/UK7UMiaiJ6VK9WpsxA?=
 =?us-ascii?Q?L0zhy+QsMZlb/5sk5UEbBE7Jym5xiLmvrRIxFOUpdKy94MEEa7JdG+FF3FEx?=
 =?us-ascii?Q?nmbYOevS9l4mxZw6ogzNpaoZEHbXOpMBRFzYh+aVUjjxBCsm/j6qXleZ2+Ld?=
 =?us-ascii?Q?o18x4h7EL19Rie4ollFY0HHpvL1Pf+qPKEn73Z5Q35gbx3AZHwB4b7ZjmaP9?=
 =?us-ascii?Q?8izRmx7PMb4xvwtkijbSBphCqaiTnlAVy4HGo6dLi6r0GNmBsq63BNLGhPXw?=
 =?us-ascii?Q?AgGRreH69Z1Fr9OC1QJC8xB8q/tBRyWqM2kB88J+GDvPYXPmHDoRQCaKu1J6?=
 =?us-ascii?Q?shtPmGXiETPPsz6MzfL619K8YNd/KWADehOay3rH2fYeCMuLqgu63aymOJg2?=
 =?us-ascii?Q?sZsMvfdkDviMhjVEq3V3NvSbspo5LO8Qwy0+QcOmJ9zy4v1cNwdrUdZ5Wojw?=
 =?us-ascii?Q?E9M/Keer4IVsw5Ci1Q7jFtbGj80JU9shmOOyucI1joNtp+qYVgNSHw5b28j6?=
 =?us-ascii?Q?YftR78ZW6ul2MHf50mrOQncAmOcteYGcJuVY4QKsi3ceN9G+hkBKDhsJKPjV?=
 =?us-ascii?Q?v7/PHzjW09nnpVxPSxacdsSRQ/aMCrjTHCXDQsUGZoP7QlPpP5wKyvE7sf/F?=
 =?us-ascii?Q?04+ZRWSXTRjr5+ECbpTCZZJ9rjU6hSkTOq/8sSjpWm6ykVeMphH0Q4BjQj5X?=
 =?us-ascii?Q?+nLmG4zuXJjqvzbpzrM5nztjxIeGgRvx2ozdXupAAg2CB6ZCbquZc/jdCo92?=
 =?us-ascii?Q?BZYBAG+qNbxgzay2+epH0FbJ8V/Ehmo1yZIFP3O0xbEfHdm622GdtWuDijHE?=
 =?us-ascii?Q?LUeOqFeB2CWO26pbjpiyd3gn4dSnrUn9FLZvKzAkngPJI9uNYk44MUgWOVWZ?=
 =?us-ascii?Q?Oq8i1IsKkSbhKP0Z3P851+lkyunKKjrri4oRkf2kVxgBE3q6cv/JGK6l8m3b?=
 =?us-ascii?Q?WgtNANRl/TZJmE6wNj7KAepTfsE4BmUO9bAfiXsFroVlUTUbFGJhHfkcHABm?=
 =?us-ascii?Q?IKvrqK1EoRJ92g8nh+I/wl7IG7aRLGiz54d6Pa6QC1w7kOaFmCgCurLBu6RY?=
 =?us-ascii?Q?RV+xNARq/IuXlECT4LToAHEOIFwwBYZ++9kIbzr8gSWhB37PAbUyF3i1CT+G?=
 =?us-ascii?Q?Qwx+Z4dD//CjfUI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7838720f-193e-4766-d41a-08da53968ac0
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 14:58:46.6469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P190MB0437
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making sizeof operator type-independent.

Reported by checkpatch:

CHECK: Prefer kmalloc(sizeof(*txb)...) over
        kmalloc(sizeof(struct rtllib_txb)...)

---
Note: First patch, trying to follow kernelnewbies tutorial.

Signed-off-by: Felix Schlepper <f3sch.git@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 37715afb0210..01e163e61f0e 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -205,8 +205,7 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 	struct rtllib_txb *txb;
 	int i;
 
-	txb = kmalloc(sizeof(struct rtllib_txb) + (sizeof(u8 *) * nr_frags),
-		      gfp_mask);
+	txb = kmalloc(sizeof(*txb) + (sizeof(u8 *) * nr_frags), gfp_mask);
 	if (!txb)
 		return NULL;
 
-- 
2.36.1

