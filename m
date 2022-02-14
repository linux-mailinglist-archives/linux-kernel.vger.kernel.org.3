Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4C4B4F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352264AbiBNMD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:03:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiBNMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:03:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8463EE3D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:03:43 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EBeNu4031188;
        Mon, 14 Feb 2022 12:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=1VLSBXEHw9Z9IXuQW5DktTaYds/UsYLR7xUfcY8F4Ns=;
 b=FgzMYz4mzrHQYJ9iuUZFWggGObFfyP3Ofiy/47VoZTvCNfNt3by4CS2Yf3agnIgqFump
 YQNJJAZNG/LMl9tvf2MwJvC9JNtFq8eZNQL664YZhsRB5XTbNG4ZwarsZzpnN32WMQd4
 2Hc/ojkRdt4DoR3cPexS11FCfR5o/0GpLACHU0bfFdgbf7mM2vEvNv0IjQ/G9/oqgfPG
 pGDSZX4B4YS1j4CY1FJYeU7P9DVbWo7BIr/NV0+uRKEskYpFKW0BDxOQaYD0dx+dA5nZ
 LVL+DVHS2Eru/mAS+LcX+PUIqCIh8gU0VXSCFIGyPbBKRzRsSiQ3KiZzW0o61c8sXP0p mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e64sbv328-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EBuRce176470;
        Mon, 14 Feb 2022 12:03:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3e62xd07d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRrZoU1YmYtZmJgZBEEub5VIMADi05M9SXjoO7ZJ+83nMm1Cpui02APKlCFvquxelq16op8rm4ZyQ9bmkFNtAF0H5Fh9cHXxwmu5zQuMAhzYjkTIVgSSReiM579ipj848/vaJ7NC3jlG6mAzeBFd+4eO+iOWFdjk3UVpmODC4rrxS6k9CS9A1b59CUofgJ12UXEviB6/1WHwHx+5WSEOBQRCOgfkUmm1L7npkv2mUs9F5+dIVSItV2oqtcoFswirVSuvw7AKGOkozcLP0DAZa//SCN/wPTQjevwcmmVFo898wsuko4/HlB5EzFt0uoohcT7mRZPpBUKTHfFhrzu1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VLSBXEHw9Z9IXuQW5DktTaYds/UsYLR7xUfcY8F4Ns=;
 b=fM06uA4Ln4Dv78xLh/TsRt6IV2nRrNGiAF6RB+LcS6S/Fth7Jv2/A28cOYeZdRvT3UWp6XPCeU6uHXnEtDhsNvimgCwb9z0PsHQpVRzxsMPRb6q/Pc2ujVOwOh59UqA5DzrO5ltGgYT0hxweyOM1U1XD9xazvHA/Htj67YQbFN3g5kJcIjf6vWUspTiUCIj+mGH4kfN34U51Sh75CIe1jUxpix5lRY/rFzT5NLliA1v5jFS+36GXYZko24MU2/Y4r4g8wAhJ7t8ULh8wITZo5ZwjimSy3sOfp+rzldU9nKQVTLCwOT/qQNXfyhrWZYctYcrObaYEOhsrAYz3b2/axw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VLSBXEHw9Z9IXuQW5DktTaYds/UsYLR7xUfcY8F4Ns=;
 b=NTYuyBzzkKmeNVEGN+n95a64bc5U5yo12uGHnEaGh4/Ymgud7thJ+1WbagrYV91lB9OLmuvpvpgHBcNylpdvq5z5c3GeAHE6bzcseFV8T22Cl3CLWDl05N9ZjwRsCFhYqPVPhPBXa8JH4i9SAmHF8n0j143C0C5WhaPKcVgp2lY=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN8PR10MB3538.namprd10.prod.outlook.com (2603:10b6:408:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 12:03:37 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:03:37 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/7] kernfs: Introduce hashed mutexes to replace global kernfs_open_file_mutex.
Date:   Mon, 14 Feb 2022 23:03:16 +1100
Message-Id: <20220214120322.2402628-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214120322.2402628-1-imran.f.khan@oracle.com>
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:1:14::28) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54b24421-f8be-4d01-1506-08d9efb2082b
X-MS-TrafficTypeDiagnostic: BN8PR10MB3538:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3538094F51B81FFCB0A74ADAB0339@BN8PR10MB3538.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stkj8wPVJ0eprKc/Ec/uQhz+17mICD/3+xDC0dQm9VWaDm7J2RzND0IwJ+bE2f9B0Lf9Z9jHcVWenh9RXGRliVvpt+axGqW1Xl85s5tcvgreQ328Gw0XdWBkkLu0e6fpIQfqwffQSAlHj817I0hE3M5SHwn0M9r/Rveqm2SizNkdRy37Qf7W9Z8VRcHbL/baJkkOf1eawF+JU/L6z8zml/8KZF1A/RmBkMAXONQvCm69/78hDwhpsbUvYk458yyK2Z30PjW8W9KogCnORUquDMAUGlpEDhlN4Iu/+kKoR5FftQ0ZDgj76OHaaYtUoSu1R7rmpanUd1+p4FlgSDU8MxhxkCrtOpSWZ4of/sT15orGgOZf1Sqrg/qKPhD9PcGdxBd5fXhdnLqgzD8Dhu8d8yeuzFPnG6uNE4I7RPlG9eWeauXBzPVuK7qjDrdMddeNAn7WOL3bySKGwTWBh68Xrc7MvduCmxFGS+JPl9+5grPn0f7+kSpj8XrYp7tIBNME+qfUayodsndhkgLSgsKLhVhY9XI/oSSwEC2bQjCv/VpfJOYcg+7dJpg3g8aYiit8w7VRbc9rqKrYvv571Wx+hzFdLbvEbVq0fYVTq80iLjNyhQWBzoLdCAHxXY0dg9tvaJ/SJCmNXkuYDLex/QPO6JnHsMx3xVyZ/0aPDu4acHv2cc/fp7v9ygycv2TbCdkR2ZecoNgBwLxbBazEGEUcPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(66946007)(316002)(38100700002)(2616005)(36756003)(6486002)(66556008)(4326008)(66476007)(103116003)(186003)(1076003)(26005)(6666004)(6512007)(2906002)(86362001)(508600001)(52116002)(83380400001)(5660300002)(8936002)(6506007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?digoBS3M0Kxjyo117ya9S9FDhCT+jmP1m5FR40dswl+EC3nDPc04bdCi4W/D?=
 =?us-ascii?Q?62+jvyjZaQwm2UcLwzxeeN8jPnLlOSiCKQphayFfd3Nh74lZI/dZ6zOzZ0dA?=
 =?us-ascii?Q?IUC/Zs/aY8wbOJDE9d9MMArTGa164KKF9ow5OgvKO0H7658D2zOeoOgFZOHz?=
 =?us-ascii?Q?jTVTkbyoOSLgjEO7NPu6s8zTmThFGkM759j6LRd535QqYP4mJEergo5arvKW?=
 =?us-ascii?Q?qzkxnLw0EDqFdpYXTqMrvG0cmX1LGuGoHX6+2LLz1rHj9Q1drt/jzDr7ciXg?=
 =?us-ascii?Q?L+Gadc7mRJPUAbdJ99SbybilarxNHkLbD5HHWypifgaP8VZaZEvN1cAWhCbr?=
 =?us-ascii?Q?MYKwcndaisLyMl4HsEKIZi9QPmU0NOp+Y4a7Y8p/CU1Ej9dO4US7wPfYhk/U?=
 =?us-ascii?Q?oeaStaOXz1helBz89qp8H203W0v6WqogAmvWcJ2yEGFfa+LzdSTtAfX+BJiu?=
 =?us-ascii?Q?TMyMjvRSZIVzBItFx+XqIKJ7xoHDpLPNYEyPXy4njuaagBt+BPL+E9p6f2EN?=
 =?us-ascii?Q?1dgrysjYL3RQHOQT6IdySTQOobFWGx65ar070pT6SUmwH1d40ukiNsDJ7GO0?=
 =?us-ascii?Q?CY/VxBagRt2uU1ui7sXoWuukY1A4U0Usbt/uJGhR0V5NsR1o/OBUFfl4rC/Q?=
 =?us-ascii?Q?lNmGS6ROlqkc3gF/zNHXO3wnMNYYAX4g7IUTzTX+e7G1O/JGfUo8f4O2m6C2?=
 =?us-ascii?Q?YKu5USTcoO725azWr3rbjuNtR5Dkdp1Bb5UCtU+2Y5MsBlQj9SDP4L0QZWG0?=
 =?us-ascii?Q?oF9u2Hp2zYJVCyg6IHEH3sRdAOVbNAq0WH6tBLuAbV6gJpmz+VK04uUjFLef?=
 =?us-ascii?Q?IZqnk4YcOucsmgO9WgpmBvC7KBayf6/xuk27ZwKFWtX18s4uneOuenrzXo0X?=
 =?us-ascii?Q?Ck6T5NpvE/K2LZXj/cmP5VNVcsaJOlze5RkOkxjJOhDUmOVzTPeFX8d/To7C?=
 =?us-ascii?Q?FMblb7Zx+EqozSx9xNmNcHSAMSew4hm0NbnQFU0sGwsscZBMT3zuhsIKiQvP?=
 =?us-ascii?Q?c0PnuI3f8crBroqZuOgdukBO0xDo86jtSBvyheh7FCa848z3fJ6A4R6rUxU9?=
 =?us-ascii?Q?yLHrPmBgJOH1vH+1F8hNt/4FBYlECgoyQ03wYy1SKUEPM/jYnU7sxF0xIMph?=
 =?us-ascii?Q?k57NAgReW/azyOhZSjr7IZTDvV7GIK8N4mq3TW0NBcT19TI6TQOQGj+nxnbK?=
 =?us-ascii?Q?YuJT91HtL0o7vZLJiMcpXs3aheMEeIPFxz6iLihUTCpBVG3wWCsUjFyEC4VH?=
 =?us-ascii?Q?GVA/QOyfu9r6A/YvWeGpZbaydtFBsofv+sbTTCS97i4XgH4zi+NIG7RMzXdg?=
 =?us-ascii?Q?4w9mDypof8xln0JG19K/iOhJar4dbZbU/JJMtF7iwbd717L/LgtfzzGw+P76?=
 =?us-ascii?Q?BPjjNzL4gSRxMQ6Rzd251rFtdR1i//kYQSdcS3nD09NRWK8lOjjtv8JI9lI6?=
 =?us-ascii?Q?AEM1U8nO+fC3MZ8NHme9Go8/J7BtdyvkaCK/P2rRf8f0T5sxfEbUZrVTEwTK?=
 =?us-ascii?Q?RMH02b5SkLVRkyLFD3CavE5saKGcN5ux70O/03xMgtc59vGwv3vZLb6D3EOP?=
 =?us-ascii?Q?36OqjCBQpucuKhbCrpy07za4D6qeqf30hGXiLmW36Ks4EsOT1T5C1FOKgKV2?=
 =?us-ascii?Q?h2T1DxsE1Gjs9XdbhmTCteA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b24421-f8be-4d01-1506-08d9efb2082b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:03:37.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bjz5SiKA0j1EC9hpZBkyK2ix9qWSaGMW6h/QmFlPWyQCyCc58E9zI18NV6ZiBqLpm/etSrKRfNHtMSeSzH8Wnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3538
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140073
X-Proofpoint-GUID: bbt1JBy03B7JldXdFyPzp9-WgvuUShKA
X-Proofpoint-ORIG-GUID: bbt1JBy03B7JldXdFyPzp9-WgvuUShKA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current kernfs design a single mutex, kernfs_open_file_mutex, protects
the list of kernfs_open_file instances corresponding to a sysfs attribute.
So even if different tasks are opening or closing different sysfs files
they can contend on osq_lock of this mutex. The contention is more apparent
in large scale systems with few hundred CPUs where most of the CPUs have
running tasks that are opening, accessing or closing sysfs files at any
point of time.

Using hashed mutexes in place of a single global mutex, can significantly
reduce contention around global mutex and hence can provide better
scalability. Moreover as these hashed mutexes are not part of kernfs_node
objects we will not see any singnificant change in memory utilization of
kernfs based file systems like sysfs, cgroupfs etc.

This patch introduces hashed mutexes that can be used in place of above
mentioned global mutex. It also provides interfaces needed to use hashed
mutexes. The next patch makes use of these interfaces and replaces global
mutex with hashed ones.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/kernfs-internal.h | 23 +++++++++++++++
 fs/kernfs/mount.c           | 13 ++++++++
 include/linux/kernfs.h      | 59 +++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index f9cc912c31e1b..03e983953eda4 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -147,4 +147,27 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
+/*
+ * kernfs locks
+ */
+extern struct kernfs_global_locks *kernfs_locks;
+
+static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
+{
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_locks->open_file_mutex[idx].lock;
+}
+
+static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
+{
+	struct mutex *lock;
+
+	lock = kernfs_open_file_mutex_ptr(kn);
+
+	mutex_lock(lock);
+
+	return lock;
+}
+
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a7..fa3fa22c95b21 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -20,6 +20,7 @@
 #include "kernfs-internal.h"
 
 struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
+struct kernfs_global_locks *kernfs_locks;
 
 static int kernfs_sop_show_options(struct seq_file *sf, struct dentry *dentry)
 {
@@ -387,6 +388,17 @@ void kernfs_kill_sb(struct super_block *sb)
 	kfree(info);
 }
 
+void __init kernfs_lock_init(void)
+{
+	int count;
+
+	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
+	WARN_ON(!kernfs_locks);
+
+	for (count = 0; count < NR_KERNFS_LOCKS; count++)
+		mutex_init(&kernfs_locks->open_file_mutex[count].lock);
+}
+
 void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
@@ -397,4 +409,5 @@ void __init kernfs_init(void)
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
 					      sizeof(struct kernfs_iattrs),
 					      0, SLAB_PANIC, NULL);
+	kernfs_lock_init();
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 861c4f0f8a29f..3f72d38d48e31 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -18,6 +18,7 @@
 #include <linux/uidgid.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <linux/cache.h>
 
 struct file;
 struct dentry;
@@ -34,6 +35,62 @@ struct kernfs_fs_context;
 struct kernfs_open_node;
 struct kernfs_iattrs;
 
+/*
+ * NR_KERNFS_LOCK_BITS determines size (NR_KERNFS_LOCKS) of hash
+ * table of locks.
+ * Having a small hash table would impact scalability, since
+ * more and more kernfs_node objects will end up using same lock
+ * and having a very large hash table would waste memory.
+ *
+ * At the moment size of hash table of locks is being set based on
+ * the number of CPUs as follows:
+ *
+ * NR_CPU      NR_KERNFS_LOCK_BITS      NR_KERNFS_LOCKS
+ *   1                  1                       2
+ *  2-3                 2                       4
+ *  4-7                 4                       16
+ *  8-15                6                       64
+ *  16-31               8                       256
+ *  32 and more         10                      1024
+ *
+ * The above relation between NR_CPU and number of locks is based
+ * on some internal experimentation which involved booting qemu
+ * with different values of smp, performing some sysfs operations
+ * on all CPUs and observing how increase in number of locks impacts
+ * completion time of these sysfs operations on each CPU.
+ */
+#ifdef CONFIG_SMP
+#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))
+#else
+#define NR_KERNFS_LOCK_BITS     1
+#endif
+
+#define NR_KERNFS_LOCKS     (1 << NR_KERNFS_LOCK_BITS)
+
+/*
+ * There's one kernfs_open_file for each open file and one kernfs_open_node
+ * for each kernfs_node with one or more open files.
+ *
+ * filp->private_data points to seq_file whose ->private points to
+ * kernfs_open_file.
+ * kernfs_open_files are chained at kernfs_open_node->files, which is
+ * protected by kernfs_open_file_mutex.lock.
+ */
+
+struct kernfs_open_file_mutex {
+	struct mutex lock;
+} ____cacheline_aligned_in_smp;
+
+/*
+ * To reduce possible contention in sysfs access, arising due to single
+ * locks, use an array of locks and use kernfs_node object address as
+ * hash keys to get the index of these locks.
+ */
+
+struct kernfs_global_locks {
+	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+};
+
 enum kernfs_node_type {
 	KERNFS_DIR		= 0x0001,
 	KERNFS_FILE		= 0x0002,
@@ -413,6 +470,8 @@ void kernfs_kill_sb(struct super_block *sb);
 
 void kernfs_init(void);
 
+void kernfs_lock_init(void);
+
 struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 						   u64 id);
 #else	/* CONFIG_KERNFS */
-- 
2.30.2

