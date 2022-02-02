Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB944A73AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiBBOvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:51:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29640 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345141AbiBBOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:50:56 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212DBw9L011396;
        Wed, 2 Feb 2022 14:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=KYwYi7co+fBflqIz4SKHnNnrvU51dzzg3JFQjVsXtNA=;
 b=q8NbgtU/GXAiHmI1EEHs3U3U9iAJbFGnWgRO4PbL9IICLfs1qw+6alwDdOuM5G5vfa5l
 cZ2tEGPjvYsqCwmBBEJSYSvH2/EFL1wWKozpVqgbpDp8M45YpP0wI/G8g15N8XHzd8/W
 qi8lsfkdDp/Ms6Er5el6lNBbrDkwApRUqCCw3OY9ST9BZZFUZY0iWezZP+i+3YGKd66W
 ISQShJ/b7YTIwdO+8/O+cOBxFAKRxP9SZoMib113X/kesI7VAvkKRJgEAeYjGC008s2e
 HnECI/+iHMz3UcTKu7/v73TOgkAMYGD29aMJbRoLloqPKKFXf1lRTmr/hhiQryDfQpAN RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fx9g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 14:50:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212EfjNS148873;
        Wed, 2 Feb 2022 14:50:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3dvumhhpsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 14:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewEW40s753k7DU3mtMxEd0caeozja8ogONeSdSn6IY74RLlqbC0LLcMv+OxF/2ChN64JN2yqjtdKcjBpXdxMvDCqPRpD4/mXEj6UDhQvwkQN9T3prkY5Vx4x9bKLw5JaPlsKUQQYwMhMrFwBSHItl0f1Lqi/b6QCaiaP8dKkoyxDj4cBKysZwevuMoGqkxf++zbKWsW7LSramvIuzNp3aZtSPqXAx6lAj68w9oFhrXsetpz2iWdwOQdAHglNpVOUhnvAOVSCxua79ujJC16/O+7wVVzmSvhS8pH/3lvX2aTRvZSyCfV3bI4ygoZRgrc71iL63eEcFt9FyJX4uwBA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYwYi7co+fBflqIz4SKHnNnrvU51dzzg3JFQjVsXtNA=;
 b=Gaow00fW9Gnmyh/PNZ8aAOzNYDemdZM6sjDNbfVyInKPV+FvhDBmYKOx3Kj2UMoHwb1R8I+A/b2G02ZCWWovILkDYwT+Z1mRGq4uRO3+WDtuHRhMLVCbf5ZPDxT2IlqKrxng9j2RRl89/AZ/zhHB4hdiHgvdTsF8lDJEZ4cGVOovxLXR+p7a/O9ANLpOoUxCUXx0e8eCnbQmxS1oPF6BtUbgkNQG2n1EPRIN0taVc3PT0yUu/18VIlIsB36atIllPd23zVACRbC9Ojn/8acHr1pmXoJ7nXOXxa12+8gURxYTB5uiMonQuQDH+98e2NLjQA2LyCKxWebssw0HVm4auQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYwYi7co+fBflqIz4SKHnNnrvU51dzzg3JFQjVsXtNA=;
 b=a/TVfHi9I9ilkE3zRNc190C+Td9XhVsiANV0EKbyUraUexbmflIz+2ZL5kBt12CVhT6ryJD7RnwEgksDS5JUqUhCKi7vhWD0lKJPReNQ941JpB9O8+vaaB2k/o2kdMM8TzwCj6iqsmM4WW2FfrcqdsBVIja/lbBbStzfd74GqW8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB3597.namprd10.prod.outlook.com (2603:10b6:208:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Wed, 2 Feb
 2022 14:50:49 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%3]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 14:50:49 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] kernfs: Replace per-fs global rwsem with per-fs hashed rwsem.
Date:   Thu,  3 Feb 2022 01:50:27 +1100
Message-Id: <20220202145027.723733-3-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d6ecebb-c530-440b-e0fc-08d9e65b6640
X-MS-TrafficTypeDiagnostic: MN2PR10MB3597:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3597386607A4149511D33C0EB0279@MN2PR10MB3597.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdz5REPFyzx5u90gd0arQ/AufZzFkrtZ4CD7/hItLbpQLXvN+yqZqsfRD34AgD1VBI4Uo/ko6C4V47d+DkmVkD0+LIXxNuAE0L4JzPFF9cJrRktew2ZyxH20Zh65TxnFTdjmZ+C9xUPns8x/KI60tLTYBtAJmtD4/3RmwixeV4DlEK8S5b34VIj8qXltxD4yVy979eWPA36NMsWEhvCkSgT79eu3S/+Wum0BHWSw2j0J1G7o+o51FRbz77sFjKU5ZEe/0sBwEOvqyFSzrloSG0J8aqeHWAa/HygxE6PQPdqof60Jp8DPAsc3YjftKru7rZh6zl6ObRqcTnBHFARKcDs58iw7+zsbaYnUwUi9tl/kutXLFN3nsyY3KnhLGjZK0V38Km52/tGNaVE31JdFN5SJZbG0Tu61/ZHMioKPokMmUxGeyQBr7U7km8U0ct6iKq/iJEvTJ6aNVU0ksn4fBMvXNen3mcJqISmvHJoLw9Reg0MRaZt1nbSU0x3zRmNNCqRz6/97A3kvi1tu9Ubx+kQvAF6iML7daGkPRlP59+uqqafAVGd+SrKxQnjBnkY26PTOv7oCZh0akaW92A5r8tXcHHtK1V35Oyh35CxmTrBZkSz7oXXskCRDyO8ikZx3ITblK3Ihu0AzV5aG6cwg5/3nLxnuErPwh4o8srTOpFNj/CUCvSrvC/PzHxRl7ds6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(1076003)(66556008)(66946007)(2616005)(36756003)(6506007)(52116002)(6666004)(38100700002)(30864003)(6512007)(5660300002)(86362001)(508600001)(6486002)(186003)(2906002)(103116003)(4326008)(8936002)(8676002)(83380400001)(316002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B8W3v2QP8dFivXLzP7FoYNlSryxOey5QEVz3Y2ZSDpUFxCvaysbSKW7y4GlP?=
 =?us-ascii?Q?w2DOTNHmVOGTwFkLi43VV1ZGsyLAon3yR8UCzA8TeIZURH+vbyKEwdzru9t6?=
 =?us-ascii?Q?xdiZvzRVNO+Y5OlOPKrqQnMPogj3aF24H5pBIm5VJ9///HsuhMPIWj3dH0ka?=
 =?us-ascii?Q?Sm2Y2mPpZVgroj4LIDNF9bQ6Q0vbRpYtZrZAOPKN4j2y8AduXPoF4wm3JBw1?=
 =?us-ascii?Q?UoSvxy13mZMuGmf+HSm+ljmCOw44bF9RObqvk0+4KEDcAbtoZXwve6HUQCxq?=
 =?us-ascii?Q?I47TID6icZbSIXJnQ4/pA+WU+7PZRChEGJoCNDEq8sjRVtoNiWmDT9q9kty1?=
 =?us-ascii?Q?cL3HUE2niHVzNfdOKPSq6D1sJaNuy1IJEP6jkzMSpDnm+SWVoPtWfwOU3zbQ?=
 =?us-ascii?Q?BephxeXqDIyQiMo4/r1fCM5vPfUIZEGmNxbsdlaY/Go5l/XEDl1h2OIc4Sjq?=
 =?us-ascii?Q?rfsf74mUmaC1As9XE8pyoCOAVNhzGyxw73HMMYkyU8FebFJ402ljluoRRCAi?=
 =?us-ascii?Q?VjK1XdswqSlvcphOZB7Uwsh99VviAfNFKt8xKHCLINwv0Ymm2KFAhsNNfpQQ?=
 =?us-ascii?Q?I+7oL4/oMWG3NiP5dAcOfTPgIw2jSwrOVUEj1Pvj6uYW1v702SQN0K3po76y?=
 =?us-ascii?Q?9Rik5oJRwwG9zD5625j4pYuQ6VmM5Ez27buzcPBzaBKCRgYRKel75IMV3O/m?=
 =?us-ascii?Q?wTTRlbNuFT4KCtDHczF4rpi7qRD5oLa9HA+ExzlFBS2pK+qV2Di50dDFk3EX?=
 =?us-ascii?Q?YJgPMWKjbO13/iLrrVk2fhXa3cOhTg18NzcHXfifY9ARib1JmhoHpt5q9+nZ?=
 =?us-ascii?Q?EHt2g6SW3l6UwyxrDYv1HTviC7QzfC86jWlP3jNIsxlikubg8RFRyWRVGi5Q?=
 =?us-ascii?Q?UXXlSOpsLxumxqxUd08tEoDgFzo7ICzlMdgQf1TiAMKEABCZMja+pvUr/Npl?=
 =?us-ascii?Q?foHeJmMHsTJdjxv28Z5v8L9Ymti9pIRu8bvUgaAwVRKnS1vBgIkjIvgLlvAo?=
 =?us-ascii?Q?HXNxfMsdLkxzH0XwUgn39TXXPUDR+onEhS9D9Q3eipht+omonNuZ2t8NBWgU?=
 =?us-ascii?Q?JJqusU9ECdMle2yBnyqoEKagYMTq85Vty6HD+6hAf4yfLMbRahd75W82rc+/?=
 =?us-ascii?Q?XdnlcspnkwxK4GLY31YGjDClfvQ3Yyhh/8XADD9xwGB0Kh23RyPkCfCFU61V?=
 =?us-ascii?Q?pVD1zr8aSQr1U55p9Sbd4n1fLR/+BZog7JXl0v32JLTQqgqES5y3scpKgcJ+?=
 =?us-ascii?Q?3PARyJUvdJFU8FmtMEvhWoDos2I4CHFYNmQGxu9xgazLt11Q4BuczdGTc/QX?=
 =?us-ascii?Q?sFRxACsjwI5E6RWYmdTHTDSkXXr0QHu0Hnh2bHh8Q/CpgLvFggvtfa6Szo6E?=
 =?us-ascii?Q?xrMuJb/mkfCLmmw+542k7EqvMfzm1USs2B+rOixthcXew+IoxbYhqFjVEvD9?=
 =?us-ascii?Q?1Apq2mC2suw3lbPmtfxXxvlgTYc3DtWOFCIUKev0enwHR+kff0KiYFIx+2OV?=
 =?us-ascii?Q?ho06v2punt9WvbdImRMkYYSrK+nY5MQW5zJGm9cwTAb860s5XKY2VRPH+MIN?=
 =?us-ascii?Q?GUfcdwcuTayNvv7SYQf7LXn6ytFXWDzfV+/a8sNnpDc703D0VlFN8aiLU1LH?=
 =?us-ascii?Q?9MmrVe6Jdo3r7xhdREsimL6nvXUVS1ehw22j/+60eUed?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6ecebb-c530-440b-e0fc-08d9e65b6640
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:50:48.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GrFfY6Qg7hcXTxWdMla/6tkDyVrDe7P/eDKOcJxNwwkTbc+0RFYdScocs2pEr3PW1idvmpAhV9AoIwnbDDP+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3597
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020081
X-Proofpoint-GUID: rbEUv1Y-ZJyODPx6Gb-IhE84fXekPuCx
X-Proofpoint-ORIG-GUID: rbEUv1Y-ZJyODPx6Gb-IhE84fXekPuCx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a single rwsem to synchronize all operations across a kernfs
based file system (cgroup, sysfs etc.) does not scale well. Replace
it with a hashed rwsem to reduce contention around single per-fs
rwsem.
Also introduce a perfs rwsem to protect per-fs list of kernfs_super_info.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             | 268 +++++++++++++++++++++++++-----------
 fs/kernfs/file.c            |   6 +-
 fs/kernfs/inode.c           |  18 ++-
 fs/kernfs/kernfs-internal.h | 112 +++++++++++++++
 fs/kernfs/mount.c           |  13 +-
 fs/kernfs/symlink.c         |   5 +-
 include/linux/kernfs.h      |   5 +-
 7 files changed, 325 insertions(+), 102 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index d26fb3bffda92..89645ba453ab8 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -25,7 +25,9 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem[idx]);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -455,35 +457,36 @@ void kernfs_put_active(struct kernfs_node *kn)
  * removers may invoke this function concurrently on @kn and all will
  * return after draining is complete.
  */
-static void kernfs_drain(struct kernfs_node *kn)
-	__releases(&kernfs_root(kn)->kernfs_rwsem)
-	__acquires(&kernfs_root(kn)->kernfs_rwsem)
+static void kernfs_drain(struct kernfs_node *kn, struct kernfs_node *anc)
+	__releases(&kernfs_root(anc)->kernfs_rwsem[a_idx])
+	__acquires(&kernfs_root(anc)->kernfs_rwsem[a_idx])
 {
 	struct kernfs_root *root = kernfs_root(kn);
+	int a_idx = hash_ptr(anc, NR_KERNFS_LOCK_BITS);
 
-	lockdep_assert_held_write(&root->kernfs_rwsem);
-	WARN_ON_ONCE(kernfs_active(kn));
+	lockdep_assert_held_write(&root->kernfs_rwsem[a_idx]);
+	WARN_ON_ONCE(atomic_read(&kn->active) >= 0);
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(anc);
 
-	if (kernfs_lockdep(kn)) {
-		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
-		if (atomic_read(&kn->active) != KN_DEACTIVATED_BIAS)
-			lock_contended(&kn->dep_map, _RET_IP_);
+	if (kernfs_lockdep(anc)) {
+		rwsem_acquire(&anc->dep_map, 0, 0, _RET_IP_);
+		if (atomic_read(&anc->active) != KN_DEACTIVATED_BIAS)
+			lock_contended(&anc->dep_map, _RET_IP_);
 	}
 
 	/* but everyone should wait for draining */
 	wait_event(root->deactivate_waitq,
 		   atomic_read(&kn->active) == KN_DEACTIVATED_BIAS);
 
-	if (kernfs_lockdep(kn)) {
-		lock_acquired(&kn->dep_map, _RET_IP_);
-		rwsem_release(&kn->dep_map, _RET_IP_);
+	if (kernfs_lockdep(anc)) {
+		lock_acquired(&anc->dep_map, _RET_IP_);
+		rwsem_release(&anc->dep_map, _RET_IP_);
 	}
 
 	kernfs_drain_open_files(kn);
 
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(anc, LOCK_SELF, 0);
 }
 
 /**
@@ -718,12 +721,11 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 int kernfs_add_one(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent = kn->parent;
-	struct kernfs_root *root = kernfs_root(parent);
 	struct kernfs_iattrs *ps_iattr;
 	bool has_ns;
 	int ret;
 
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(parent, LOCK_SELF, 0);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -754,7 +756,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(parent);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -768,7 +770,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(parent);
 	return ret;
 }
 
@@ -788,8 +790,9 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	struct rb_node *node = parent->dir.children.rb_node;
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
+	int idx = hash_ptr(parent, NR_KERNFS_LOCK_BITS);
 
-	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
+	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem[idx]);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -820,8 +823,9 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 {
 	size_t len;
 	char *p, *name;
+	int idx = hash_ptr(parent, NR_KERNFS_LOCK_BITS);
 
-	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
+	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem[idx]);
 
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
 	spin_lock_irq(&kernfs_rename_lock);
@@ -860,12 +864,11 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
 
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(parent, LOCK_SELF, 0);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(parent);
 
 	return kn;
 }
@@ -885,12 +888,11 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 					   const char *path, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
 
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(parent, LOCK_SELF, 0);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(parent);
 
 	return kn;
 }
@@ -916,11 +918,12 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 		return ERR_PTR(-ENOMEM);
 
 	idr_init(&root->ino_idr);
-	init_rwsem(&root->kernfs_rwsem);
 	for (lock_count = 0; lock_count < NR_KERNFS_LOCKS; lock_count++) {
 		spin_lock_init(&root->open_node_locks[lock_count].lock);
 		mutex_init(&root->open_file_mutex[lock_count].lock);
+		init_rwsem(&root->kernfs_rwsem[lock_count]);
 	}
+	init_rwsem(&root->supers_rwsem);
 	INIT_LIST_HEAD(&root->supers);
 
 	/*
@@ -1067,12 +1070,12 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		if (parent) {
 			spin_unlock(&dentry->d_lock);
 			root = kernfs_root(parent);
-			down_read(&root->kernfs_rwsem);
+			down_read_kernfs_rwsem(parent, LOCK_SELF, 0);
 			if (kernfs_dir_changed(parent, dentry)) {
-				up_read(&root->kernfs_rwsem);
+				up_read_kernfs_rwsem(parent);
 				return 0;
 			}
-			up_read(&root->kernfs_rwsem);
+			up_read_kernfs_rwsem(parent);
 		} else
 			spin_unlock(&dentry->d_lock);
 
@@ -1084,7 +1087,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 
 	kn = kernfs_dentry_node(dentry);
 	root = kernfs_root(kn);
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(kn, LOCK_SELF, 0);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -1103,10 +1106,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(kn);
 	return 1;
 out_bad:
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(kn);
 	return 0;
 }
 
@@ -1125,23 +1128,28 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	const void *ns = NULL;
 
 	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+
+	down_read_kernfs_rwsem(parent, LOCK_SELF, 0);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
+	up_read_kernfs_rwsem(parent);
 	/* attach dentry and inode */
 	if (kn) {
 		/* Inactive nodes are invisible to the VFS so don't
 		 * create a negative.
 		 */
+		down_read_kernfs_rwsem(kn, LOCK_SELF, 0);
 		if (!kernfs_active(kn)) {
-			up_read(&root->kernfs_rwsem);
+			/* Unlock both node and parent before returning */
+			up_read_kernfs_rwsem(kn);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
+		up_read_kernfs_rwsem(kn);
 	}
 	/*
 	 * Needed for negative dentry validation.
@@ -1149,9 +1157,10 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 * or transforms from positive dentry in dentry_unlink_inode()
 	 * called from vfs_rmdir().
 	 */
+	down_read_kernfs_rwsem(parent, LOCK_SELF, 0);
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(parent);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1273,8 +1282,9 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 						       struct kernfs_node *root)
 {
 	struct rb_node *rbn;
+	int idx = hash_ptr(root, NR_KERNFS_LOCK_BITS);
 
-	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem);
+	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem[idx]);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1309,9 +1319,8 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
-	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1325,14 +1334,15 @@ void kernfs_activate(struct kernfs_node *kn)
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
 
-	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
+	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem[idx]);
 
 	/*
 	 * Short-circuit if non-root @kn has already finished removal.
@@ -1346,9 +1356,16 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 	/* prevent any new usage under @kn by deactivating all nodes */
 	pos = NULL;
-	while ((pos = kernfs_next_descendant_post(pos, kn)))
+	while ((pos = kernfs_next_descendant_post(pos, kn))) {
+		int n_idx = hash_ptr(pos, NR_KERNFS_LOCK_BITS);
+
+		if (n_idx != idx)
+			down_write_kernfs_rwsem(pos, LOCK_SELF, 1);
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
+		if (n_idx != idx)
+			up_write_kernfs_rwsem(pos);
+	}
 
 	/* deactivate and unlink the subtree node-by-node */
 	do {
@@ -1369,7 +1386,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		 * error paths without worrying about draining.
 		 */
 		if (kn->flags & KERNFS_ACTIVATED)
-			kernfs_drain(pos);
+			kernfs_drain(pos, kn);
 		else
 			WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
 
@@ -1402,11 +1419,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	struct kernfs_root *root = kernfs_root(kn);
-
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
 	__kernfs_remove(kn);
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 }
 
 /**
@@ -1492,9 +1507,8 @@ void kernfs_unbreak_active_protection(struct kernfs_node *kn)
 bool kernfs_remove_self(struct kernfs_node *kn)
 {
 	bool ret;
-	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
 	kernfs_break_active_protection(kn);
 
 	/*
@@ -1522,9 +1536,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			up_write(&root->kernfs_rwsem);
+			up_write_kernfs_rwsem(kn);
 			schedule();
-			down_write(&root->kernfs_rwsem);
+			down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1537,7 +1551,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 	return ret;
 }
 
@@ -1555,7 +1569,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 {
 	struct kernfs_node *kn;
 	struct kernfs_root *root;
-
+	int idx, p_idx;
 	if (!parent) {
 		WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",
 			name);
@@ -1563,13 +1577,15 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 	}
 
 	root = kernfs_root(parent);
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(parent, LOCK_SELF, 0);
 
 	kn = kernfs_find_ns(parent, name, ns);
-	if (kn)
+	up_write_kernfs_rwsem(parent);
+	if (kn) {
+		down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
 		__kernfs_remove(kn);
-
-	up_write(&root->kernfs_rwsem);
+		up_write_kernfs_rwsem(kn);
+	}
 
 	if (kn)
 		return 0;
@@ -1590,35 +1606,66 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	struct kernfs_node *old_parent;
 	struct kernfs_root *root;
 	const char *old_name = NULL;
-	int error;
+	int error, idx, np_idx, p_idx;
 
 	/* can't move or rename root */
 	if (!kn->parent)
 		return -EINVAL;
 
 	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+
+	/*
+	 * Take lock of node's old (current) parent.
+	 * If new parent has a different lock, then take that
+	 * lock as well.
+	 */
+	idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+	p_idx = hash_ptr(kn->parent, NR_KERNFS_LOCK_BITS);
+	np_idx = hash_ptr(new_parent, NR_KERNFS_LOCK_BITS);
+
+	/*
+	 * Take only kn's lock. The subsequent kernfs_put
+	 * may free up old_parent so if old_parent has a
+	 * different lock, we will explicitly release that.
+	 */
+	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
+
+	if (idx != np_idx) /* new parent hashes to different lock */
+		down_write_kernfs_rwsem(new_parent, LOCK_SELF, 1);
+
+	/* old_parent hashes to a different lock */
+	if (idx != p_idx && p_idx != np_idx)
+		down_write_kernfs_rwsem(kn->parent, LOCK_SELF, 2);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
-	    (new_parent->flags & KERNFS_EMPTY_DIR))
+	    (new_parent->flags & KERNFS_EMPTY_DIR)) {
+		if (idx != p_idx && p_idx != np_idx)
+			up_write_kernfs_rwsem(kn->parent);
 		goto out;
-
+	}
 	error = 0;
 	if ((kn->parent == new_parent) && (kn->ns == new_ns) &&
-	    (strcmp(kn->name, new_name) == 0))
+	    (strcmp(kn->name, new_name) == 0)) {
+		if (idx != p_idx && p_idx != np_idx)
+			up_write_kernfs_rwsem(kn->parent);
 		goto out;	/* nothing to rename */
-
+	}
 	error = -EEXIST;
-	if (kernfs_find_ns(new_parent, new_name, new_ns))
+	if (kernfs_find_ns(new_parent, new_name, new_ns)) {
+		if (idx != p_idx && p_idx != np_idx)
+			up_write_kernfs_rwsem(kn->parent);
 		goto out;
-
+	}
 	/* rename kernfs_node */
 	if (strcmp(kn->name, new_name) != 0) {
 		error = -ENOMEM;
 		new_name = kstrdup_const(new_name, GFP_KERNEL);
-		if (!new_name)
+		if (!new_name) {
+			if (idx != p_idx && p_idx != np_idx)
+				up_write_kernfs_rwsem(kn->parent);
 			goto out;
+		}
 	} else {
 		new_name = NULL;
 	}
@@ -1646,12 +1693,22 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	kn->hash = kernfs_name_hash(kn->name, kn->ns);
 	kernfs_link_sibling(kn);
 
+	/* Release old_parent's lock, if it is different */
+	if (idx != p_idx && p_idx != np_idx)
+		up_write_kernfs_rwsem(old_parent);
 	kernfs_put(old_parent);
 	kfree_const(old_name);
 
 	error = 0;
  out:
-	up_write(&root->kernfs_rwsem);
+	/*
+	 * If new parent lock has been taken release it.
+	 * Lastly release node's lock.
+	 */
+	if (idx != np_idx) /* new parent hashes to different lock */
+		up_write_kernfs_rwsem(new_parent);
+
+	up_write_kernfs_rwsem(kn);
 	return error;
 }
 
@@ -1670,9 +1727,20 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
 static struct kernfs_node *kernfs_dir_pos(const void *ns,
 	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
 {
+	int idx, p_idx;
+
+	p_idx = hash_ptr(parent, NR_KERNFS_LOCK_BITS);
+	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem[p_idx]);
 	if (pos) {
-		int valid = kernfs_active(pos) &&
+		int valid = 0;
+
+		idx = hash_ptr(pos, NR_KERNFS_LOCK_BITS);
+		if (idx != p_idx)
+			down_read_kernfs_rwsem(pos, LOCK_SELF, 1);
+		valid = kernfs_active(pos) &&
 			pos->parent == parent && hash == pos->hash;
+		if (idx != p_idx)
+			up_read_kernfs_rwsem(pos);
 		kernfs_put(pos);
 		if (!valid)
 			pos = NULL;
@@ -1681,18 +1749,37 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 		struct rb_node *node = parent->dir.children.rb_node;
 		while (node) {
 			pos = rb_to_kn(node);
-
+			idx = hash_ptr(pos, NR_KERNFS_LOCK_BITS);
+			if (idx != p_idx)
+				down_read_kernfs_rwsem(pos, LOCK_SELF, 1);
 			if (hash < pos->hash)
 				node = node->rb_left;
 			else if (hash > pos->hash)
 				node = node->rb_right;
-			else
+			else {
+				if (idx != p_idx)
+					up_read_kernfs_rwsem(pos);
 				break;
+			}
+			if (idx != p_idx)
+				up_read_kernfs_rwsem(pos);
 		}
 	}
 	/* Skip over entries which are dying/dead or in the wrong namespace */
-	while (pos && (!kernfs_active(pos) || pos->ns != ns)) {
-		struct rb_node *node = rb_next(&pos->rb);
+	while (pos) {
+		struct rb_node *node;
+
+		idx = hash_ptr(pos, NR_KERNFS_LOCK_BITS);
+		if (idx != p_idx)
+			down_read_kernfs_rwsem(pos, LOCK_SELF, 1);
+		if (kernfs_active(pos) && pos->ns == ns) {
+			if (idx != p_idx)
+				up_read_kernfs_rwsem(pos);
+			break;
+		}
+		node = rb_next(&pos->rb);
+		if (idx != p_idx)
+			up_read_kernfs_rwsem(pos);
 		if (!node)
 			pos = NULL;
 		else
@@ -1704,16 +1791,41 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
 	struct kernfs_node *parent, ino_t ino, struct kernfs_node *pos)
 {
+	int idx, p_idx;
+	int unlock_node = 0;
+
+	p_idx = hash_ptr(parent, NR_KERNFS_LOCK_BITS);
+	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem[p_idx]);
 	pos = kernfs_dir_pos(ns, parent, ino, pos);
 	if (pos) {
+		idx = hash_ptr(pos, NR_KERNFS_LOCK_BITS);
+		if (idx != p_idx)
+			down_read_kernfs_rwsem(pos, LOCK_SELF, 1);
 		do {
 			struct rb_node *node = rb_next(&pos->rb);
+			if (idx != p_idx) {
+				up_read_kernfs_rwsem(pos);
+				unlock_node = 0;
+			}
 			if (!node)
 				pos = NULL;
-			else
+			else {
 				pos = rb_to_kn(node);
+				if (pos != NULL) {
+					idx =  hash_ptr(pos,
+						NR_KERNFS_LOCK_BITS);
+					if (idx != p_idx) {
+						down_read_kernfs_rwsem(pos,
+								LOCK_SELF,
+									1);
+						unlock_node = 1;
+					}
+				}
+			}
 		} while (pos && (!kernfs_active(pos) || pos->ns != ns));
 	}
+	if (unlock_node)
+		up_read_kernfs_rwsem(pos);
 	return pos;
 }
 
@@ -1729,7 +1841,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(parent, LOCK_SELF, 0);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1746,12 +1858,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
+		up_read_kernfs_rwsem(parent);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		down_read_kernfs_rwsem(parent, LOCK_SELF, 0);
 	}
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(parent);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 018d038b72fdd..5124add292582 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -855,8 +855,9 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 	root = kernfs_root(kn);
 	/* kick fsnotify */
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
 
+	down_write(&root->supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode = NULL;
@@ -892,8 +893,9 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 		iput(inode);
 	}
+	up_write(&root->supers_rwsem);
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5daa..a8b16f08a667a 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -99,11 +99,10 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
-	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 	return ret;
 }
 
@@ -119,7 +118,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return -EINVAL;
 
 	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +131,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 	return error;
 }
 
@@ -187,14 +186,13 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(kn, LOCK_SELF, 0);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(kn);
 
 	return 0;
 }
@@ -287,12 +285,12 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 	kn = inode->i_private;
 	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(kn, LOCK_SELF, 0);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(kn);
 
 	return ret;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index cc49a6cd94154..3f011b323173c 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -19,6 +19,9 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 
+#define LOCK_SELF 0
+#define LOCK_SELF_AND_PARENT 1
+
 struct kernfs_iattrs {
 	kuid_t			ia_uid;
 	kgid_t			ia_gid;
@@ -102,6 +105,115 @@ static inline bool kernfs_dir_changed(struct kernfs_node *parent,
 	return false;
 }
 
+/*
+ * If both node and it's parent need locking,
+ * lock child first so that kernfs_rename_ns
+ * does not change the parent, leaving us
+ * with old parent here.
+ */
+static inline void down_write_kernfs_rwsem(struct kernfs_node *kn,
+					   u8 lock_parent,
+					   u8 nesting)
+{
+	int idx, p_idx;
+	struct kernfs_root *root;
+
+	idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+	root = kernfs_root(kn);
+
+	down_write_nested(&root->kernfs_rwsem[idx], nesting);
+
+	kernfs_get(kn);
+
+	if (kn->parent)
+		p_idx = hash_ptr(kn->parent, NR_KERNFS_LOCK_BITS);
+
+	if (kn->parent && lock_parent && p_idx != idx) {
+		/*
+		 * Node and parent hash to different locks.
+		 * node's lock has already been taken.
+		 * Take parent's lock and update token.
+		 */
+		down_write_nested(&root->kernfs_rwsem[p_idx],
+				  nesting + 1);
+
+		kernfs_get(kn->parent);
+		kn->unlock_parent = 1;
+	}
+}
+
+static inline void up_write_kernfs_rwsem(struct kernfs_node *kn)
+{
+	int p_idx, idx;
+	struct kernfs_root *root;
+
+	/* node lock is already taken in down_xxx so kn->parent is safe */
+	p_idx = hash_ptr(kn->parent, NR_KERNFS_LOCK_BITS);
+	idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+	root = kernfs_root(kn);
+
+	if (kn->unlock_parent) {
+		kn->unlock_parent = 0;
+		up_write(&root->kernfs_rwsem[p_idx]);
+		kernfs_put(kn->parent);
+	}
+
+	up_write(&root->kernfs_rwsem[idx]);
+	kernfs_put(kn);
+}
+
+static inline void down_read_kernfs_rwsem(struct kernfs_node *kn,
+					  u8 lock_parent,
+					  u8 nesting)
+{
+	int idx, p_idx;
+	struct kernfs_root *root;
+
+	idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+	root = kernfs_root(kn);
+
+	down_read_nested(&root->kernfs_rwsem[idx], nesting);
+
+	kernfs_get(kn);
+
+	if (kn->parent)
+		p_idx = hash_ptr(kn->parent, NR_KERNFS_LOCK_BITS);
+
+	if (kn->parent && lock_parent && p_idx != idx) {
+		/*
+		 * Node and parent hash to different locks.
+		 * node's lock has already been taken.
+		 * Take parent's lock and update token.
+		 */
+		down_read_nested(&root->kernfs_rwsem[p_idx],
+				 nesting + 1);
+
+		kernfs_get(kn->parent);
+
+		kn->unlock_parent = 1;
+	}
+}
+
+static inline void up_read_kernfs_rwsem(struct kernfs_node *kn)
+{
+	int p_idx, idx;
+	struct kernfs_root *root;
+
+	/* node lock is already taken in down_xxx so kn->parent is safe */
+	p_idx = hash_ptr(kn->parent, NR_KERNFS_LOCK_BITS);
+	idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+	root = kernfs_root(kn);
+
+	if (kn->unlock_parent) {
+		kn->unlock_parent = 0;
+		up_read(&root->kernfs_rwsem[p_idx]);
+		kernfs_put(kn->parent);
+	}
+
+	up_read(&root->kernfs_rwsem[idx]);
+	kernfs_put(kn);
+}
+
 extern const struct super_operations kernfs_sops;
 extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a7..ebb7d9a10f47e 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -236,7 +236,6 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *kfc)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
-	struct kernfs_root *kf_root = kfc->root;
 	struct inode *inode;
 	struct dentry *root;
 
@@ -256,9 +255,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_read(&kf_root->kernfs_rwsem);
+	down_read_kernfs_rwsem(info->root->kn, 0, 0);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_read(&kf_root->kernfs_rwsem);
+	up_read_kernfs_rwsem(info->root->kn);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
@@ -346,9 +345,9 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
-		down_write(&root->kernfs_rwsem);
+		down_write(&root->supers_rwsem);
 		list_add(&info->node, &info->root->supers);
-		up_write(&root->kernfs_rwsem);
+		up_write(&root->supers_rwsem);
 	}
 
 	fc->root = dget(sb->s_root);
@@ -375,9 +374,9 @@ void kernfs_kill_sb(struct super_block *sb)
 	struct kernfs_super_info *info = kernfs_info(sb);
 	struct kernfs_root *root = info->root;
 
-	down_write(&root->kernfs_rwsem);
+	down_write(&root->supers_rwsem);
 	list_del(&info->node);
-	up_write(&root->kernfs_rwsem);
+	up_write(&root->supers_rwsem);
 
 	/*
 	 * Remove the superblock from fs_supers/s_instances
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 0ab13824822f7..5d4a769e2ab1e 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -113,12 +113,11 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
-	struct kernfs_root *root = kernfs_root(parent);
 	int error;
 
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(parent, LOCK_SELF, 0);
 	error = kernfs_get_target_path(parent, target, path);
-	up_read(&root->kernfs_rwsem);
+	up_read_kernfs_rwsem(parent);
 
 	return error;
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 5bf9f02ce9dce..3b3c3e0b44083 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -179,6 +179,7 @@ struct kernfs_node {
 	 */
 	struct kernfs_node	*parent;
 	const char		*name;
+	u8			unlock_parent; /* release parent's rwsem */
 
 	struct rb_node		rb;
 
@@ -237,9 +238,10 @@ struct kernfs_root {
 	struct list_head	supers;
 
 	wait_queue_head_t	deactivate_waitq;
-	struct rw_semaphore	kernfs_rwsem;
 	struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
 	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+	struct rw_semaphore	supers_rwsem;
+	struct rw_semaphore	kernfs_rwsem[NR_KERNFS_LOCKS];
 };
 
 struct kernfs_open_file {
@@ -619,5 +621,4 @@ static inline int kernfs_rename(struct kernfs_node *kn,
 {
 	return kernfs_rename_ns(kn, new_parent, new_name, NULL);
 }
-
 #endif	/* __LINUX_KERNFS_H */
-- 
2.30.2

