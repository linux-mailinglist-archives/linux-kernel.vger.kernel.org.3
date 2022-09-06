Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF69C5AF52A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiIFT6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiIFT6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:58:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2103.outbound.protection.outlook.com [40.107.243.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE62165BF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxLrQMjbuCSuJmIRYdenBYB63pfnDbtfn6g1SZZQ/PV6C/AXmXDlS552ME1xSDW6Lvda1K1Ls2Z47/FhQ4o+mrt99IAEnjbykoPH5F17FL57FwBKPan0gW+KDq39ZvVV2UgHZ3Eby6lWtMAsTnDESwYH93sZN2SQ0IH18pWfyZCwOxonYeCkpMePjGkEPl0FuY7nlDAnyI537KJ2bSBvruNxbfoahmDU/kC5enabR2V/G4qeHsqk6fbwYYv49LZssqrHJzKRxHI7eEyomBeUaaz6r/Z4lrBQyxYcI5PWKDH13tFOmzxcO0XDNjFzXekUbjbVuELp7WD3K9Mt2SKYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpFGufIGcnpdZSyLbar/hM98ihjMAsevxSYjsee9NcQ=;
 b=nzoCAw/g+dfGLZD5QHmgj0sWXuhBS5ww/gEChHXBZhX7tg1DNMcSAr+bfH1Zgj4v0oZw7OkFlY83J/jM/GFz596YHvbzl4hOI0eXfU8aLvHspjOFHcfXnS6lGs4TyQIvbyF+N8Sz9wjouBBxlWxxCfmmTltag/dI/jjuOC7wsf9iCwo1tgtkJJlLHWMouaX9Jen5yzi/nPdgv5pfXVYe9G8IwoTLi2HuE1hJjiO6dUEI6vDCLdvNox78zR09OF6PDNGppnmFM/YzWcF99MEQgbS+F4M/uJnYlFIO7+D16Z9GoxD5wVq6Za39eFzLQspNZOHCdv6/3wLIsu9E8tJhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpFGufIGcnpdZSyLbar/hM98ihjMAsevxSYjsee9NcQ=;
 b=ZzzJM1W3zxJy0w/7hTnoIXJj6szo2UxS3iQK63IuyXaJRN+d2AYlzK+xuf+BzJLI6K3ZBfNSa261ZNRV19iCLOMFQVzhRp7oALiet+w/ely7j0hjzTylGfouBmyfn1SnUbkDNMJqCa148DqS6Hn1mXDFJRVj8QA5leMJFtaNIAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 DM6PR01MB4330.prod.exchangelabs.com (2603:10b6:5:7c::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Tue, 6 Sep 2022 19:52:16 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::94a5:3b31:5b8e:b1f5]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::94a5:3b31:5b8e:b1f5%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:52:16 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] char: misc: Allow minors values up to MINORMASK
Date:   Tue,  6 Sep 2022 12:52:13 -0700
Message-Id: <20220906195213.2370775-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:610:b3::13) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccfee8a6-db89-4089-c62b-08da90414cd7
X-MS-TrafficTypeDiagnostic: DM6PR01MB4330:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wL55QidZ3rsRFoGBJE614BIidflqZWcYdPJgvKjf5v6cdVUVXI8FCH/2P6EsAzU0S9wzBL7rN+HxC3FzgK5xAvYizMwH6g84knf9sjvhceAeEKLWkn/uYRgwAYkzLRtNCKFzzooN6kbb63tVi5enY2D7uhaABLe/J3wt+BR5jimeaJ7EK/uwex+WMMEcFZvBF5kyoSTZ93GQK8Nf00Hk4KvXHzt9e8eYJvS2zpfqyL/QKH5ZJrtop7AGHATuM8BifiuNNE/m+cVdWsJXpE1HTaduA3oIWtL04euc5+DRCKZYwI/U6MB2atPyeMsOOEIHArbKwAe3HekC+1CSd2Q2gogu1PAPrxQ6+Ng7cH8aQBaY1X9cBO2rcbw4IQ4Q/T0MVf98pOK4OUsul0+ZGlxZZu7/LviZmyX9VLcxhede0cxBwzL+creux7SiQaLwq59d+/P/oFGubgnl/gNTv9/926GK1fxTJaSKkaCd50My9wQBtKdhfQFj1xji0IxdCTIAhLsE0thoIGjERQ/KsjPYMg+6R4j6rR41vMUEbXgDFRxJ4MZLG6s12LByjQds0nTGJqNQIuWz1p2xXIf/3BO9qlF24SfTz5ewhFg5gtzNJtAAfXLsdyGSRXZb5U+o6pcQ5WZ46vFlnRgBRN9zI78BF5bC3lnZA5KkupMeAeVCokMCYZDZVB1k2LjRR0vpTGjeuH7jf6dj4vWAtfxiHA6DQpsBNGYaAzT7HSsz/NKB+uSqNM1VAP7DWN5U3iSnXqA8n+lmuEUtIPLnR1xIn5P0U1YCm2v+Btpx54S9MssmVeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39850400004)(376002)(136003)(396003)(26005)(86362001)(4326008)(66476007)(38350700002)(8676002)(66556008)(316002)(66946007)(38100700002)(41300700001)(52116002)(6512007)(83380400001)(1076003)(6506007)(6666004)(6486002)(478600001)(110136005)(2616005)(8936002)(5660300002)(186003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O2PtTE5/52lnuKyrf5JK3aKaxgBoW5eHPPwcipzI2hIItobmHcqjHF7jJYy1?=
 =?us-ascii?Q?ieNUZrm9oSEv5E0APS5kWNrCMEXnrn0L0gELptg1cvY3E73fm4n0z84DFco2?=
 =?us-ascii?Q?A2RErCPdQKAA/PR7TLowOPXAe6PAv6m3gNkQdLTCGW3dYXRBlv2/8bUUW5/k?=
 =?us-ascii?Q?B7jujWkXgo3LjNEiJDPDyhJ5mHPW1PaYV/XDzjkzIa4A186rSmxUIZMkHNYN?=
 =?us-ascii?Q?LybJIXgezxaQfvMJL9FGSqM2j9ZjoY0v1SXtK/8ZLEP5qkxws/KIfFSlyb/i?=
 =?us-ascii?Q?ssbEQEMPp4DxKxLNwOqUv8vXD2Z4YBNrOrjDtXTwzu7ZMgg+tfpx3xAHZqba?=
 =?us-ascii?Q?yYMuXJQUE5d20UZ8mQ+gnYIZWn7JPKeVN6VgOZbrA4UYdaap4214tCNP8BRj?=
 =?us-ascii?Q?BKzfkgKaMNoNjBZvkDP3MbpkYT/7v7U38YsM9wGzZ7AsTKCD4FTkPD5KohaL?=
 =?us-ascii?Q?CAHFTmj7Cd7IH9nekVGqU6Si88L5BbeAtAvXBLPEqMdaYwuH6BsWirmpn7Fi?=
 =?us-ascii?Q?UHYROPD6Ebs3VR9pf2wGo5aMjEgsk71ip/zVbFBbD6AL5GmVFPkzXH6ul4Lj?=
 =?us-ascii?Q?25HK/MBc85xZMYMDiceSUazbd3d5eEuEtPxV0WFzRTb8voe2u3AokfXnY8j+?=
 =?us-ascii?Q?i93i3h7nPFeDalsugDa/iUcoJkBuElgPcm4myBeofOpp0toDGZE3duJHToQK?=
 =?us-ascii?Q?9h7avNFZIWW4Igor6vXO3iS6bNTSfnna2ybSDIH6A/yZ/VP+y9CIehvsROf5?=
 =?us-ascii?Q?XStvYPwezorTUxEGz5qyuV5imIINKa0Bakoqerd/YjAPHb0A1/ZQAByyZgCK?=
 =?us-ascii?Q?9uRSCJAaS2P7YTKRnFWyNe3FJRnef2pFUBgssHCohMmqtleZ7wm7pAjqzEox?=
 =?us-ascii?Q?9uUw9h0wK5VKJo2fDhR1qXVRiYdGVmFItjQ4+rW+0ms5B0i+aWo2yikH9eqJ?=
 =?us-ascii?Q?bZJiAnWamAwf2tH9Fa1Q6PM2eUG8upYUmZVBM+pKAsfY3q9OWLjS1MDQB4zQ?=
 =?us-ascii?Q?BRsDrRX6f3bg1gRiBVBbLLJuWRBazv7WMSg5UMS/RXCa2TFh9V/Z7CecNBVt?=
 =?us-ascii?Q?CyYhtIGoFMEGkVI9g5O1Yb5PmMF6IfT2Gu8kZVAkQvBP2mG0W5DDLPOiUczF?=
 =?us-ascii?Q?A9b6D5s/VRrpAFZqPAb+4AeU3uviUNDHVOpzZDjmWf+pBk7F9OuPQk/wvL+4?=
 =?us-ascii?Q?yIKokDFezyGGZd3e2JHHGV07qQ9Jk0vE5Qr7F1VyLw10fJNrz+tLjTGM1cx1?=
 =?us-ascii?Q?V4K3QfL+n+nlXFEiZf/HltFAnL4ScMvSTe+rcbkSTNok8I4+gaW+Vc+GSP+J?=
 =?us-ascii?Q?gwfOvsP8QtCFA8t4PCHnD2DGuP1Vy+mIjsRld9KkT7yo66dIR7EI+bQrwJQw?=
 =?us-ascii?Q?JXzrFySWvWwM2wa403QSQp2KaDJ+PgcABANlpJEEiGF7Or4bBW6EbUMHcqWf?=
 =?us-ascii?Q?ytAYMIK0YZJnrm1ISSnCHr+moZ4Sxa1QRqwWXR2BP0YAVx/bktGaYioIW/Ae?=
 =?us-ascii?Q?QgSHw4bqHlcmZhrtI6j1303Ron1VQXUL/YrE+QkYm4lwDinCo0CNILyoDa1q?=
 =?us-ascii?Q?KaqZ/iuw8zJ+/5ke/DE2DG8Stz/otRidP2plljj36c0X7VwFMo3UmqIRAF6S?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfee8a6-db89-4089-c62b-08da90414cd7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 19:52:16.5642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFAtrvJoxFfU8YCpP37y/TP3Dhz6mr/NrAm+rqmt2iFHEWpdLe6q+Fh/4MQh68kEpWKN4CTXzRp34HKbtafY7I3E9Lxyv3UgUoDAFJ1M25tfzDKtfOQr5FbbDSZY79Ue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4330
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For per-cpu coresight_tmc devices, we can end up with hundreds of devices
on large systems that all want a dynamic minor number.  Switch the dynamic
minors allocator to an ida and add logic to allocate in the ranges [0..127]
and [256..MINORMASK]. Allocations start from 127 growing downwards and then
increasing from 256, so device numbering for the first 128 devices should
be the same as before.

Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
---
 drivers/char/misc.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index cba19bfdc44d..05727f0daa6b 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -61,7 +61,29 @@ static DEFINE_MUTEX(misc_mtx);
  * Assigned numbers, used for dynamic minors
  */
 #define DYNAMIC_MINORS 128 /* like dynamic majors */
-static DECLARE_BITMAP(misc_minors, DYNAMIC_MINORS);
+static DEFINE_IDA(misc_minors_ida);
+
+static int misc_minor_alloc(void)
+{
+	int ret;
+
+	ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
+	if (ret >= 0) {
+		ret = DYNAMIC_MINORS - ret - 1;
+	} else {
+		ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
+				      MINORMASK, GFP_KERNEL);
+	}
+	return ret;
+}
+
+static void misc_minor_free(int minor)
+{
+	if (minor < DYNAMIC_MINORS)
+		ida_free(&misc_minors_ida, DYNAMIC_MINORS - minor - 1);
+	else if (minor > MISC_DYNAMIC_MINOR)
+		ida_free(&misc_minors_ida, minor);
+}
 
 #ifdef CONFIG_PROC_FS
 static void *misc_seq_start(struct seq_file *seq, loff_t *pos)
@@ -183,14 +205,13 @@ int misc_register(struct miscdevice *misc)
 	mutex_lock(&misc_mtx);
 
 	if (is_dynamic) {
-		int i = find_first_zero_bit(misc_minors, DYNAMIC_MINORS);
+		int i = misc_minor_alloc();
 
-		if (i >= DYNAMIC_MINORS) {
+		if (i < 0) {
 			err = -EBUSY;
 			goto out;
 		}
-		misc->minor = DYNAMIC_MINORS - i - 1;
-		set_bit(i, misc_minors);
+		misc->minor = i;
 	} else {
 		struct miscdevice *c;
 
@@ -209,10 +230,7 @@ int misc_register(struct miscdevice *misc)
 					  misc, misc->groups, "%s", misc->name);
 	if (IS_ERR(misc->this_device)) {
 		if (is_dynamic) {
-			int i = DYNAMIC_MINORS - misc->minor - 1;
-
-			if (i < DYNAMIC_MINORS && i >= 0)
-				clear_bit(i, misc_minors);
+			misc_minor_free(misc->minor);
 			misc->minor = MISC_DYNAMIC_MINOR;
 		}
 		err = PTR_ERR(misc->this_device);
@@ -240,16 +258,13 @@ EXPORT_SYMBOL(misc_register);
 
 void misc_deregister(struct miscdevice *misc)
 {
-	int i = DYNAMIC_MINORS - misc->minor - 1;
-
 	if (WARN_ON(list_empty(&misc->list)))
 		return;
 
 	mutex_lock(&misc_mtx);
 	list_del(&misc->list);
 	device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
-	if (i < DYNAMIC_MINORS && i >= 0)
-		clear_bit(i, misc_minors);
+	misc_minor_free(misc->minor);
 	mutex_unlock(&misc_mtx);
 }
 EXPORT_SYMBOL(misc_deregister);
-- 
2.37.2

