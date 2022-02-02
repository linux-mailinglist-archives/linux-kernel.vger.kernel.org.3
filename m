Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DFB4A73AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbiBBOu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:50:58 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27504 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232471AbiBBOuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:50:55 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212DCJMA026575;
        Wed, 2 Feb 2022 14:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=lrqpq6IoCWrPdDLDJOV+NUYMYprJ4k5bUqgJNg/bM4g=;
 b=0/GhyWnsSZDj6JhhrjgGW50A1rikRU5hCQAQyQXLO7VA0AfqlGYjw5YEex0zC5KwBeT6
 qRkRiKvchiiMzDMA4eke3GbWbjL3AoYw6SiVx3dShS2eC41AmcR3LNCemCx/E7/uM6PE
 WYBbzrGMoZzvMqgfcLHss57/uziKZAuiazGM4yHiXF8l19uyWgaoAFWX3l6LQYlmZ5JH
 LEp944l1PAYUjsiP42worQBQkg2pvX4Y8mNfMG2nKcyzNNoTK0MGp0uC6qmD6RLLAbPt
 HIIILaadPSWrTkdG20deBxSw/Ag2IXLGBKJt+N++XLj9Xqs05Lwv8A4Gzi+Aixn9QF5P RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9veayx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 14:50:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212EfRB7114549;
        Wed, 2 Feb 2022 14:50:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3dvtq2s84m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 14:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGHz22Neub/VVT+AwvKrwfFbMAwzzyHsCD0cr/BgMN5b2anwrELiuP6BtPAnwWVVvVzFS6SNmZSdfO+ai2kK5S/EQhvVZSifnEq16SnIUYyCK0AH90POnGWDPpYj9/49Tby4elUZkjKvtpe9X2AkcH4HQmLaSh8uS0J7vnOmD2DKNG73Va35HLekeGFjDEn4Yi9hl46sQ2r77mBjAe+ISlUqFQaAtuj/94P8Bh+s+lOEmFixTqm391WXVBoPxK9I2jQPu0erGMHOQwNLABj8HS/XgtWkF9SkFIgBtBq2+xNQbVJdCOfxVHF7kf3UYnOxLR21Il4vc9pVh1jxfX3Fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrqpq6IoCWrPdDLDJOV+NUYMYprJ4k5bUqgJNg/bM4g=;
 b=YS7UUAXTLCxumH84FXP2D0ik6KgnAU6kNIEydHSGo4hJ3+EFxAwHPVvDr127NWUblfDh1Cxy/Q+kwj+rebfFot2NLs7d1WBHsOfs01X/q1M7Ab5LJwckOiQWabcQieKjnVN+Su5hEjR0PBBATMgKn/tP0IT1h/KH1tr555zmz8407PS6T4VbTGdGbRLVFzX5djQbWF1VZ0omeiH6aqJKYQz7zyqw5885ZefNHB7d65QFsXEZqy9ijC6mo2PE05sDIS+hk5DoLr6Lp4VRzmiVEGQLdfwFW/0200CrHLbp6nZHp9JxlbQyv6kUA1zOZ37nZKBoqlAFvuCnk4yclEYQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrqpq6IoCWrPdDLDJOV+NUYMYprJ4k5bUqgJNg/bM4g=;
 b=G+jxFjnsmqpgWelO7rvdBsQvEf81EwsgIkjM4wrLQXpGdKv9KhS01VF+qSdbpV7M4yNxnfpViJw89zcNFXRr1cR6ar/4X1L9I6YetQgw3QJO1pkPj5+IRPQMi7pLCYP7J6Bid62HIey4ThGJq1/ryfTPjgpVqR93ihabd+30oIU=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB3597.namprd10.prod.outlook.com (2603:10b6:208:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Wed, 2 Feb
 2022 14:50:46 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%3]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 14:50:46 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] kernfs: use hashed mutex and spinlock in place of global ones.
Date:   Thu,  3 Feb 2022 01:50:26 +1100
Message-Id: <20220202145027.723733-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202145027.723733-1-imran.f.khan@oracle.com>
References: <20220202145027.723733-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::30) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d939299-38a8-40d1-6e1c-08d9e65b64ca
X-MS-TrafficTypeDiagnostic: MN2PR10MB3597:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3597B5FB9E9F2B36D4726C31B0279@MN2PR10MB3597.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ug3lQmA4qo68JWtMi54XqHgVi6zflJHKDR13mq0US0RL7zlBV4Awyax55lAOwGzKwRvg81h1rQfkJBr/xOn6SD6n9vFEZMxz47wxgeoEdgIrZzSpAp91b8aTE6xqjiSRe/zKnKFJBwyHqu4MFktMJnBfmj34+hGr1LoZKV8doRXNTedBr0NH98T7ZD5lRJY+EDXdPr0kjlQLfdrvGo7sxj5Jdn1OZQgrlFf9FOaVvWE6QD9yBBI2xJ9HJRDHWEPzpiAa7dqEBxkflK5HzpnL3VSvuINJW2A4Kymbn3lmFVeJodKsJmPM3p88f/2mewPnq0VI/p7KxbY5BprvsHC+YbV7q8vXop/Cem9nuiXXkJ3zT64por2L79adH00cf78lOtR0kiT3hTb/+XWYl0tsXJVHG8IHgRRonkhQ7jsH/jODxE42ZSX2OeA+kIusfa+n0hKVPmAKix/ngc2k+T3adoBAPqGGH2uJ06ID4Dr9ilUSRDadpQlVgjFRZjWFt5QK45M/NbA/S2au4+935Szh++TB8xKsxAXPOzy0F63cgaql6wQEUIFhS+L4g+16jH+q1WmXbDM/9OC5y1AJh89GD1rhR0RQ9OjdAete+gSeGQ10UrrhEkdzjzoNijQTuEOli7FQQTnvCIGo8qZvtTyKKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(1076003)(66556008)(66946007)(2616005)(36756003)(6506007)(52116002)(6666004)(38100700002)(30864003)(6512007)(5660300002)(86362001)(508600001)(6486002)(186003)(2906002)(103116003)(4326008)(8936002)(8676002)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K7R7J4W+BGWSxuPqVbnIqjZ4hq4KKB9bZvz7yHjnnb8xA+KJIEDTot17X+rn?=
 =?us-ascii?Q?m81laRroTBVJeL+ulFON//0hOKS5jY5z1lLZX+E4XUSGGhG8cPEt1IpxSsNF?=
 =?us-ascii?Q?9gL2KCUFVylMDm8dZatX62XkBHyOFqJWYoGHj+EC78POTKL3R93tuHFkJJf1?=
 =?us-ascii?Q?NI8QXLTgq9P96E/gmk08ceNbrv3J+ZjOHTnDRo/nDWhDnY5I1xW7JKSCGTfe?=
 =?us-ascii?Q?KJ2YPpbXisnhrS8vm5UVy+G2nfxiqjGtWSGOLnupve2CZHYGSPKpG+t3+t39?=
 =?us-ascii?Q?itX9KowSP0nVXJNyPGx5PrxMf5Rk7U8C6piz+p7xCXbkPhJc7xOV59Vkevk7?=
 =?us-ascii?Q?zTrW0314XdZAbK/5Mr5a0v3OD+rVwo9uBKsQW0q7Ie7e1YZ/d2/oleHjOd9j?=
 =?us-ascii?Q?H3sRmeUrc3i5bskjewpua6SYNpvX0B13VIDFq9eB9J0SSG0LenXnEey2GKSZ?=
 =?us-ascii?Q?Tr86wiJDZxfJ+tBalYk2lswfFvYkusT2aWN+ZDjhzjQUxmUGf1WdsJmioahT?=
 =?us-ascii?Q?77AvwBv4Ylk4ezKpW05OcF+jlM9yQI3OCDn2vAdjp4QykawnyIu28yyTSVdr?=
 =?us-ascii?Q?OHHRU4q+A49U//8TpO77pTLBr7aBPl49mzrpYEOhC7qaBDO9zypbJVrPq3z9?=
 =?us-ascii?Q?y4uA8Kn8qLVY4yEtJshiIDi9DifTVnkJYuUl4p7XWR9vsmiQvivdxl8iqLou?=
 =?us-ascii?Q?b4N6L+emWP6LtcnMwHZKHZg5eSwYSCYiXJt+Uzpy+dYWQ/Xxx/EnqRa768d/?=
 =?us-ascii?Q?witZWfFR1cjGhm842tA0h5c3BgBc282i6J7YiQ4sJwAEOHh7R5ZzRbM1JSAg?=
 =?us-ascii?Q?wRcSb4Qf7WbgJu5EDjKfZzM8Tlx8HZ58XPYcpR+bmfdHqjEzlmcGiw8QZycu?=
 =?us-ascii?Q?9E+k8N6qzf63CUA54fYTcqOM1uPHAwsjqFqfwO20ahCZGRYtVyioTjvuNFpf?=
 =?us-ascii?Q?ClLsPRzo/Q0IkNLG1cK1zn+rxsWH8sg2m2UsEr1kgtkJbL+5hUL0b3jhYFpJ?=
 =?us-ascii?Q?ysyAXhqLcg9aoxw0lQ/jQ/kfHB1s4mSKRwQHQa8EEjzN+4f5d/CrvEFD0vjy?=
 =?us-ascii?Q?9IC6/R+s2AW5Yu5aQIharr5701OKsFQ/5GLe/dyt6SRyPzxQS1n6bX6ZhcRY?=
 =?us-ascii?Q?hi7dT7nPh/geLuakBAXNFnz0a9rZqzV7y5EJajtG6nlYdvFYHmVOaCsjl0tB?=
 =?us-ascii?Q?2Zd2PtDRTB+kVO8Y8WzqYbkCBwUItxzNCmMPwlgilpLVNsOoESoJFDg4VsdR?=
 =?us-ascii?Q?v6bIZmlLdNcbqZLSLFancJ5cidj+DHiZsKuWyVK2GVWKuTN4nRU9X0uUufqu?=
 =?us-ascii?Q?ULPiJ7EZSoTiQ3YcBO1wQVlGSK/7pSbCVjohNZmrTZK/VgunfcLlgzyj/VLX?=
 =?us-ascii?Q?zKVLEdF4Oo80dX1xkm7Q5L/I5t/7UBAUdj/UvfFUU+4N9U1/blMntPTZZrtH?=
 =?us-ascii?Q?lmPpsZyDfb8/qXwY/F5hvbr1ptu52JIdMTK2/Drtz05qbZr2fCIStatxjn80?=
 =?us-ascii?Q?ZEVc7S69SaYqw9iOAHdR1pXDa8ntMzq5DokeBOh+QIez/WdKQNuha4ddG4kL?=
 =?us-ascii?Q?A1pyt1aWuHQu3z5aeml9QhQf0XsH7jF/Y0km7otfR8d+gQwjbSs+Hj6g9c7C?=
 =?us-ascii?Q?+WmPEMBK83stnUPIazpL/nYodjgnLNPXAIAK5e4Gcf8B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d939299-38a8-40d1-6e1c-08d9e65b64ca
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:50:46.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwhvgkubX7Va7OddoOTnT0Whvr0Yuvkt/JfHbiJjyen+DdDcsscc/eL2XOaRviXBGvjhMTFuI4guqsqxomJH5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3597
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020081
X-Proofpoint-ORIG-GUID: niviasyNmvWfsmVYGUWMz2HnvlXFKGcV
X-Proofpoint-GUID: niviasyNmvWfsmVYGUWMz2HnvlXFKGcV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now a global mutex (kernfs_open_file_mutex) protects list of
kernfs_open_file instances corresponding to a sysfs attribute. So even
if different tasks are opening or closing different sysfs files they
can contend on osq_lock of this mutex. The contention is more apparent
in large scale systems with few hundred CPUs where most of the CPUs have
running tasks that are opening, accessing or closing sysfs files at any
point of time. Since each list of kernfs_open_file belongs to a
kernfs_open_node instance which in turn corresponds to one kernfs_node,
moving global kernfs_open_file_mutex within kernfs_node would sound like
fixing this contention but it has unwanted side effect of bloating up
kernfs_node size and hence kobject memory usage.

Also since kernfs_node->attr.open points to kernfs_open_node instance
corresponding to the kernfs_node, we can use a kernfs_node specific
spinlock in place of current global spinlock i.e kernfs_open_node_lock.
But this approach will increase kobject memory usage as well.

Use per-fs hashed locks in place of above mentioned global locks to reduce
kernfs access contention without increasing kobject memory usage.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             |  5 +++
 fs/kernfs/file.c            | 61 ++++++++++++++++---------------------
 fs/kernfs/kernfs-internal.h | 51 +++++++++++++++++++++++++++++++
 include/linux/kernfs.h      | 39 ++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 34 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index e6d9772ddb4ca..d26fb3bffda92 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -909,6 +909,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 {
 	struct kernfs_root *root;
 	struct kernfs_node *kn;
+	int lock_count;
 
 	root = kzalloc(sizeof(*root), GFP_KERNEL);
 	if (!root)
@@ -916,6 +917,10 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 
 	idr_init(&root->ino_idr);
 	init_rwsem(&root->kernfs_rwsem);
+	for (lock_count = 0; lock_count < NR_KERNFS_LOCKS; lock_count++) {
+		spin_lock_init(&root->open_node_locks[lock_count].lock);
+		mutex_init(&root->open_file_mutex[lock_count].lock);
+	}
 	INIT_LIST_HEAD(&root->supers);
 
 	/*
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9414a7a60a9f4..018d038b72fdd 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -18,20 +18,6 @@
 
 #include "kernfs-internal.h"
 
-/*
- * There's one kernfs_open_file for each open file and one kernfs_open_node
- * for each kernfs_node with one or more open files.
- *
- * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * protected by kernfs_open_node_lock.
- *
- * filp->private_data points to seq_file whose ->private points to
- * kernfs_open_file.  kernfs_open_files are chained at
- * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
- */
-static DEFINE_SPINLOCK(kernfs_open_node_lock);
-static DEFINE_MUTEX(kernfs_open_file_mutex);
-
 struct kernfs_open_node {
 	atomic_t		refcnt;
 	atomic_t		event;
@@ -524,10 +510,11 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
-
+	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
  retry:
-	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irq(&kernfs_open_node_lock);
+	mutex = kernfs_open_file_mutex_lock(kn);
+	lock = kernfs_open_node_lock(kn);
 
 	if (!kn->attr.open && new_on) {
 		kn->attr.open = new_on;
@@ -540,8 +527,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 		list_add_tail(&of->list, &on->files);
 	}
 
-	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
+	spin_unlock_irq(lock);
+	mutex_unlock(mutex);
 
 	if (on) {
 		kfree(new_on);
@@ -575,10 +562,14 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on = kn->attr.open;
+	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 	unsigned long flags;
 
-	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	mutex = kernfs_open_file_mutex_lock(kn);
+	lock = kernfs_open_node_lock_ptr(kn);
+
+	spin_lock_irqsave(lock, flags);
 
 	if (of)
 		list_del(&of->list);
@@ -588,8 +579,8 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
 	else
 		on = NULL;
 
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
-	mutex_unlock(&kernfs_open_file_mutex);
+	spin_unlock_irqrestore(lock, flags);
+	mutex_unlock(mutex);
 
 	kfree(on);
 }
@@ -729,11 +720,11 @@ static void kernfs_release_file(struct kernfs_node *kn,
 	/*
 	 * @of is guaranteed to have no other file operations in flight and
 	 * we just want to synchronize release and drain paths.
-	 * @kernfs_open_file_mutex is enough.  @of->mutex can't be used
+	 * @open_file_mutex is enough.  @of->mutex can't be used
 	 * here because drain path may be called from places which can
 	 * cause circular dependency.
 	 */
-	lockdep_assert_held(&kernfs_open_file_mutex);
+	lockdep_assert_held(kernfs_open_file_mutex_ptr(kn));
 
 	if (!of->released) {
 		/*
@@ -750,11 +741,12 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
+	struct mutex *lock = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
-		mutex_lock(&kernfs_open_file_mutex);
+		lock = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
-		mutex_unlock(&kernfs_open_file_mutex);
+		mutex_unlock(lock);
 	}
 
 	kernfs_put_open_node(kn, of);
@@ -769,19 +761,21 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
+	struct mutex *mutex = NULL;
+	spinlock_t *lock = NULL;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	spin_lock_irq(&kernfs_open_node_lock);
+	lock = kernfs_open_node_lock(kn);
 	on = kn->attr.open;
 	if (on)
 		atomic_inc(&on->refcnt);
-	spin_unlock_irq(&kernfs_open_node_lock);
+	spin_unlock_irq(lock);
 	if (!on)
 		return;
 
-	mutex_lock(&kernfs_open_file_mutex);
+	mutex = kernfs_open_file_mutex_lock(kn);
 
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
@@ -793,8 +787,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 			kernfs_release_file(kn, of);
 	}
 
-	mutex_unlock(&kernfs_open_file_mutex);
-
+	mutex_unlock(mutex);
 	kernfs_put_open_node(kn, NULL);
 }
 
@@ -922,13 +915,13 @@ void kernfs_notify(struct kernfs_node *kn)
 		return;
 
 	/* kick poll immediately */
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+	spin_lock_irqsave(kernfs_open_node_lock_ptr(kn), flags);
 	on = kn->attr.open;
 	if (on) {
 		atomic_inc(&on->event);
 		wake_up_interruptible(&on->poll);
 	}
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	spin_unlock_irqrestore(kernfs_open_node_lock_ptr(kn), flags);
 
 	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index f9cc912c31e1b..cc49a6cd94154 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -31,6 +31,7 @@ struct kernfs_iattrs {
 	atomic_t		user_xattr_size;
 };
 
+
 /* +1 to avoid triggering overflow warning when negating it */
 #define KN_DEACTIVATED_BIAS		(INT_MIN + 1)
 
@@ -147,4 +148,54 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
+static inline spinlock_t *kernfs_open_node_lock_ptr(struct kernfs_node *kn)
+{
+	struct kernfs_root *root;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	root = kernfs_root(kn);
+
+	return &root->open_node_locks[idx].lock;
+}
+
+static inline spinlock_t *kernfs_open_node_lock(struct kernfs_node *kn)
+{
+	struct kernfs_root *root;
+	spinlock_t *lock;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	root = kernfs_root(kn);
+
+	lock = &root->open_node_locks[idx].lock;
+
+	spin_lock_irq(lock);
+
+	return lock;
+}
+
+static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
+{
+	struct kernfs_root *root;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	root = kernfs_root(kn);
+
+	return &root->open_file_mutex[idx].lock;
+}
+
+static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
+{
+	struct kernfs_root *root;
+	struct mutex *lock;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	root = kernfs_root(kn);
+
+	lock = &root->open_file_mutex[idx].lock;
+
+	mutex_lock(lock);
+
+	return lock;
+}
+
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 861c4f0f8a29f..5bf9f02ce9dce 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -18,6 +18,8 @@
 #include <linux/uidgid.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <linux/spinlock.h>
+#include <linux/cache.h>
 
 struct file;
 struct dentry;
@@ -34,6 +36,40 @@ struct kernfs_fs_context;
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
+ */
+#ifdef CONFIG_SMP
+#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))
+#else
+#define NR_KERNFS_LOCK_BITS     1
+#endif
+
+#define NR_KERNFS_LOCKS     (1 << NR_KERNFS_LOCK_BITS)
+
+struct kernfs_open_node_lock {
+	spinlock_t lock;
+} ____cacheline_aligned_in_smp;
+
+struct kernfs_open_file_mutex {
+	struct mutex lock;
+} ____cacheline_aligned_in_smp;
+
 enum kernfs_node_type {
 	KERNFS_DIR		= 0x0001,
 	KERNFS_FILE		= 0x0002,
@@ -90,6 +126,7 @@ enum kernfs_root_flag {
 	KERNFS_ROOT_SUPPORT_USER_XATTR		= 0x0008,
 };
 
+
 /* type-specific structures for kernfs_node union members */
 struct kernfs_elem_dir {
 	unsigned long		subdirs;
@@ -201,6 +238,8 @@ struct kernfs_root {
 
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
+	struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
+	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
 };
 
 struct kernfs_open_file {
-- 
2.30.2

