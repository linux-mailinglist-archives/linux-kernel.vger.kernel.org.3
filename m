Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A3948D5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiAMKns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:43:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45430 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232845AbiAMKnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:43:45 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D8anPi010471;
        Thu, 13 Jan 2022 10:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=B9rW45hAglELiakb7/te6Jk1/0h8oke5PSLOXWjpptE=;
 b=wsRICYfvQUtiSAdB+LL1wdnUVWyIA4npnjul2a9GMp2V2xwJiMRn1kUs1GggyZzjbXwn
 Ekq0laah0Fyo2Dl9tdblpZCD4UUPJv17VvLTeBV3w1yne2ti2tOhczKU4IUhT+I/Chmu
 umMhQSsDqogLPk5EwA9W9A8HdcqqoR0DKdsBtd60CLliqk0JTbOR/YVnWN9kb16rIu3f
 XZX20j1FFZ4fYx5KG0Lef6Ggkl0oQPDFY3FdU3zrNxXbWZk090CadE9CdqMKGPBWay10
 P/qztkusva/kbm+UEm4ps9r71Gq+ge2DdsRXqiPKCUicd5C/tx8WRVN4/gi8NAh5y4tK dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx8r7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 10:43:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20DAeYUf112832;
        Thu, 13 Jan 2022 10:43:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by aserp3030.oracle.com with ESMTP id 3df0ngvf78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 10:43:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdEuIvZr6R5Xf/5tBDq9TsN4yYASw4+qPsJF5SipvDGm2jHl1ah/MWZ0MgKYDqU3eWrQF55kXS86VZzKb513V/ps7vUWqpHbLg21MxUMfYxFRTVgiAyl07SthaW+aqn2JEtcauSYzzNaTvWtEvjN8nPP4NJJrKt0akisrbQYIbnA4Rpuw++qVI2GEcrveeKIJlx8xBzxIUdgk1/Zr5nqRxmMHna5/R64szKEn1xWNQTiwGNYOh6r3denhuZah2lDCxK71K2eb823EVTTyqKYa83VPxpOnAni9WYKYRq3+v3laquWiTZbmX9S4LR+JWFxbSKjS5d4UUsDNFW4HBQD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9rW45hAglELiakb7/te6Jk1/0h8oke5PSLOXWjpptE=;
 b=VSe4d6GaObV/EIVRBCCEpC6GiU+2llETq7K4JDeAclF0GT5iLCO4OPIoEL3jF8YZOUVhS//8S3TmDM7XQXjytUnm3u1pQgtwJQu1sZ270Tu/9eVgdgmEfVOjZrpasug4UhkL6edFd7oErAKSgn0skFDAmB0IscTLrn/yh7kyfNizs1y79eBYC6hVgDv0JwS7BsXToSKtxxpwPRSh1unZxr+i6eCgSaGFZr7OJ+aa2VqyD4+z6NMXS145C/D9aQ5z7txP/daY2ILiFyJjf9C54s3uFyjd4cjhEJ3W2v7ZTspLJ7pNkGuCrT+cOkKmntJ6I8qSLwvRX4Nikys2L/Ragg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9rW45hAglELiakb7/te6Jk1/0h8oke5PSLOXWjpptE=;
 b=jZbdnVGmBxJdtXUa/vvaebHngmih948XuHes54FIYhhxPgHehpvMTmrYVao+OU4DvNLS9jjv6uKkAcydSYhEAXeqFYTgfu5/0TsiICxwpnwz3IK+M7b5Lyh/7uMxS5y90vdCTpSy6PQB3pRYfdsI1wMFB8TcGoOIJbFEHEIAOO0=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 10:43:37 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::183a:8dd0:6d9f:596f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::183a:8dd0:6d9f:596f%4]) with mapi id 15.20.4888.010; Thu, 13 Jan 2022
 10:43:37 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] kernfs: Reduce contention around global per-fs kernfs_rwsem.
Date:   Thu, 13 Jan 2022 21:42:59 +1100
Message-Id: <20220113104259.1584491-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113104259.1584491-1-imran.f.khan@oracle.com>
References: <20220113104259.1584491-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0083.ausprd01.prod.outlook.com
 (2603:10c6:10:3::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4681d80e-a00d-4284-f365-08d9d6818e0e
X-MS-TrafficTypeDiagnostic: BLAPR10MB5138:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB51386541CE2489BB0A164D77B0539@BLAPR10MB5138.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdCLiceuQG8dRrYHjwMaSEynpwwY0kgQp+eHzB+q7ZaYg50MjttOUY5k/n/ind9YPZJrkOXQ/oEa17Cv21jDdy3iJza9oVgfS/cEQQTPxmDmK+1HEB8mjZOlyb/yRPY7eDZf+qOjhcbeVBx4+I6Sf+17teZ3YGLbsN+iFXyWQQknen79exehGiYiYtRVFg6JE8yyJUN/KdmKNOMHjcz/r+jql/Y09Na9BothlYwosI9vqPh7mIqSjACboNYORqDom2d7xaz1frzKC/Hr9zNjkR5ywOitloR57X+xfFaONAlDHNeIvlKsn02m4enhvc+3RYl0EyiT+aPvwtFjUMPsOCm3tv3+dJcYQg2DuGIPBnbRT9e79tWU3YEHIthNsqSS1mXhjTiTsiY6HBIINbiwfBlR5N+XapEymIxowvF7vz9GeuTH0D06M8NxXeoM4eV6XFsEqzFhAPALCJyi2OFlQeM5oRFWkzTrnPWq1NxoG8dm8vNvL91IUfroCF4beFgZ+VAckovhaK99DwzU55pCMwuFwWqE5VAWhk3DrQ5DSKokmZGqHD23VRY92WcLpwe9lPc5xlIGHlCv/BZWLT/XwFwimB5JI+LthnaJLCW0lcKHOXAK2YIwvue8NvxIXUe2DNqTMoEJx8V0jwfuiXkbuqkObt8CEHEzvuuBenN778k1EynAo6k3FyQpYd0TZjQW6lB5ynuB3zMaZQQoG+ep+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6512007)(83380400001)(1076003)(2906002)(36756003)(8936002)(6486002)(316002)(38350700002)(38100700002)(8676002)(52116002)(103116003)(186003)(66946007)(4326008)(508600001)(6666004)(2616005)(86362001)(5660300002)(66476007)(66556008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LVzfVED3DONzZYSSK5mNP1CZjuNRjvk5NvVlvtKr5BCmOce1k7ABvf5WncR?=
 =?us-ascii?Q?61WujmiBypHZtXsJydvTy4BcJ8oR0paXm1nPvv+pgmyoMiWSzz/rb9r1aFYT?=
 =?us-ascii?Q?blHoEKf+RnkzJuTShCZ8/Wdmo8Grr0qhZhlT3jX/4KrAxq24UqG3mExDDpVO?=
 =?us-ascii?Q?swiW1t08lw+I11kzkQZzziEjKLSKBC5S645kndp5Al3Q4C39qOadN5PTXvP3?=
 =?us-ascii?Q?nb7z5m86EV+9VTBW9/6pgvp90rjPKlMwNqv+3y2YJblTUCQjlrOPL2zi0AoV?=
 =?us-ascii?Q?YzxsmRlSvaXo3QOaDaS3gU5wMRDDQOsPU+dh7QlGBMxrZRphpWzxP9NFMBJe?=
 =?us-ascii?Q?Xmctb2nBewEqTIXZYHnV7dcw0Fc/98Ec/K2SQRSGQCHAgLJuy2UnaOAKIUbj?=
 =?us-ascii?Q?Pr0m3FDS0vA2Jw3nAfM+epQ/oqRS8nI7Qfs9+1/I3cEnMUGQlfzIQ2wXkHI3?=
 =?us-ascii?Q?z9t6yE3R6yCFRk+/8+lfKcfJ62Z3Heq/qws32QRq3rTJ/ElFMfMIUBFYVk7v?=
 =?us-ascii?Q?+KuKwxQLpdKJ7AcLVh/ix6W3I0BXZ75XDmtpreEk1rAaxDuhtqkmXXAdmZbv?=
 =?us-ascii?Q?iMNaAz2oSq8FCOER/I6DAApj2GGUPSK7kfvQYt5R7iAe6KUcuLmrzaV33jXT?=
 =?us-ascii?Q?24jy6YrQbwo38dFPLFQVUaeLCxNcZhROB45ZLRYlxO8xU85jGXCzadVy07fm?=
 =?us-ascii?Q?4qGOY9u1Z+o0PeC9J1bnDa2yM/TBAxaYUZwN6dtUsmtIF43yqgGlEv8eDZjQ?=
 =?us-ascii?Q?+ukuC0FLd5eqyhLxIKXIv9Xuy3KutH0mbpMMEr/AKuCDXjDRjxnSRlcVy1HX?=
 =?us-ascii?Q?tosccukzRXUSEgCQOY8+3BDQC7OLzGZGeMXJD4DUeDSDE26/Y3WTHv75fvyl?=
 =?us-ascii?Q?3C57lr9T3SIeQk/X8Oyy8osSVMo2OiRVuaM9MqbrCoYqYsdEwinFyqAH3YNn?=
 =?us-ascii?Q?+PSdvk/G3847tk8AdpFZJeW7LLtjP1Esw2WqGZmJCd6ObPCyTjL7Z4/yYwME?=
 =?us-ascii?Q?cSW6faB97BVfUDWuRV+ly4dp0bamRhCn+l1XTgfUZgkdQLiSGjp0eHqiTtPQ?=
 =?us-ascii?Q?ueoSy/XQhzSyWcknKVtO+PVZmVIcxT8MkQrDPAeoeoCaZcmqTWve1UHe2oqT?=
 =?us-ascii?Q?MBbA1CR2f8l+j4veCZIvbqNl7oq9ywpqeOSfCMylbDO08oc9VXx3VTF9yQ3x?=
 =?us-ascii?Q?q4ZqH7uYhHNEhjCON+g6DB51kuXKKzWYaooVJzVPbxaKrKbW2ZWOyw5SefQF?=
 =?us-ascii?Q?ZDEyDIsjxYqQavoNkGQcrY5dNeaCcNUkVoI42vznGMP/n7J+lnuFgx03hwGc?=
 =?us-ascii?Q?D+m6PLmnDge/0XgKF1qtDbDwZzWby7wap4vKTevYLd4fxtRkOpT10qcK4LHe?=
 =?us-ascii?Q?Ix5aMszihjryecH3NqX3BaWnl5JXbxOhYHMGFiqRSMpmgSGMvYSe7Zlk7f/5?=
 =?us-ascii?Q?PZTE9EQ4aftCqpm/gz9Ly6rP1V94v5rttHqBr7fbmjtNobYv0wQ030KwTqDq?=
 =?us-ascii?Q?c3woz8QEbC2/zpDSOiZ1iTyYBCiGVrQwHpCptH0ahTts8M2CL07zHLMB49Lb?=
 =?us-ascii?Q?+FzZHbk8jNmD3KnAIjLJCB640Tr6h0IdLBodNtW2XbF4ou1on/Qx1S9F3dHa?=
 =?us-ascii?Q?rgLxUC9VGdLEnBXlIfrzdUs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4681d80e-a00d-4284-f365-08d9d6818e0e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 10:43:37.3667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lu12Vz6h3TeM9x8vuR2QIHOFn2+HHXH4O7Jmgqciktkf3lFd0Pc+mZA2jeEmv3qpVNGe4doU3OS3xTKE1zFQgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5138
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130063
X-Proofpoint-GUID: YSCobwOuPZy7SZdDl_hPn28uLXypHdVR
X-Proofpoint-ORIG-GUID: YSCobwOuPZy7SZdDl_hPn28uLXypHdVR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now a global per file system based rwsem (kernfs_rwsem)
synchronizes multiple kernfs operations. On a large system with
few hundred CPUs and few hundred applications simultaenously trying
to access sysfs, this results in multiple sys_open(s) contending on
kernfs_rwsem via kernfs_iop_permission and kernfs_dop_revalidate.

-   21.42%    21.34%  showgids   [kernel.kallsyms]     [k] up_read
     21.34% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 20.05% link_path_walk
            - 9.76% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 9.75% kernfs_dop_revalidate
                       up_read
            - 9.46% inode_permission
               - __inode_permission
                  - 9.46% kernfs_iop_permission
                       up_read
            - 0.83% kernfs_iop_get_link
                 up_read
         - 0.80% lookup_fast
              d_revalidate.part.24
              kernfs_dop_revalidate
              up_read

-   21.31%    21.21%  showgids   [kernel.kallsyms]    [k] down_read
     21.21% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 19.78% link_path_walk
            - 10.62% inode_permission
               - __inode_permission
                  - 10.62% kernfs_iop_permission
                       down_read
            - 8.45% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 8.45% kernfs_dop_revalidate
                       down_read
            - 0.71% kernfs_iop_get_link
                 down_read
         - 0.72% lookup_fast
            - d_revalidate.part.24
               - 0.72% kernfs_dop_revalidate
                    down_read
         - 0.71% may_open
              inode_permission
              __inode_permission
              kernfs_iop_permission
              down_read

Since permission is specific to a kernfs_node we can use a hashed
lock to access/modify permission. Also use kernfs reference counting
to ensure we are accessing/modifying permissions for an existing
kernfs_node object.

Using this change brings down the above mentioned down_read/up_read
numbers to ~8%, thus indicating that contention around kernfs_rwsem
has reduced to about 1/3rd of earlier value.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             |  8 ++++++++
 fs/kernfs/inode.c           | 35 +++++++++++++++++++++++++----------
 fs/kernfs/kernfs-internal.h | 18 ++++++++++++++++--
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index e6d9772ddb4c..37daaffda718 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -720,6 +720,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_root *root = kernfs_root(parent);
 	struct kernfs_iattrs *ps_iattr;
+	struct rw_semaphore *rwsem = NULL;
 	bool has_ns;
 	int ret;
 
@@ -748,11 +749,14 @@ int kernfs_add_one(struct kernfs_node *kn)
 		goto out_unlock;
 
 	/* Update timestamps on the parent */
+	rwsem = iattr_rwsem_ptr(parent);
+	down_write(rwsem);
 	ps_iattr = parent->iattr;
 	if (ps_iattr) {
 		ktime_get_real_ts64(&ps_iattr->ia_ctime);
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
+	up_write(rwsem);
 
 	up_write(&root->kernfs_rwsem);
 
@@ -1326,6 +1330,7 @@ void kernfs_activate(struct kernfs_node *kn)
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
+	struct rw_semaphore *rwsem;
 
 	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
 
@@ -1378,8 +1383,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 			/* update timestamps on the parent */
 			if (ps_iattr) {
+				rwsem = iattr_rwsem_ptr(pos->parent);
+				down_write(rwsem);
 				ktime_get_real_ts64(&ps_iattr->ia_ctime);
 				ps_iattr->ia_mtime = ps_iattr->ia_ctime;
+				up_write(rwsem);
 			}
 
 			kernfs_put(pos);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5da..7a55ad440bf4 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -99,11 +99,15 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem = NULL;
 
-	down_write(&root->kernfs_rwsem);
+	kernfs_get(kn);
+	rwsem = iattr_rwsem_ptr(kn);
+	down_write(rwsem);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_rwsem);
+	up_write(rwsem);
+	kernfs_put(kn);
+
 	return ret;
 }
 
@@ -112,6 +116,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct kernfs_node *kn = inode->i_private;
+	struct rw_semaphore *rwsem = NULL;
 	struct kernfs_root *root;
 	int error;
 
@@ -119,7 +124,9 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return -EINVAL;
 
 	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	kernfs_get(kn);
+	rwsem = iattr_rwsem_ptr(kn);
+	down_write(rwsem);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +139,8 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	up_write(rwsem);
+	kernfs_put(kn);
 	return error;
 }
 
@@ -187,14 +195,17 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem = NULL;
 
-	down_read(&root->kernfs_rwsem);
+	kernfs_get(kn);
+	rwsem = iattr_rwsem_ptr(kn);
+	down_read(rwsem);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	up_read(rwsem);
+	kernfs_put(kn);
 
 	return 0;
 }
@@ -279,6 +290,7 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 {
 	struct kernfs_node *kn;
 	struct kernfs_root *root;
+	struct rw_semaphore *rwsem = NULL;
 	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
@@ -287,12 +299,15 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 	kn = inode->i_private;
 	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	kernfs_get(kn);
+	rwsem = iattr_rwsem_ptr(kn);
+	down_read(rwsem);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	up_read(rwsem);
+	kernfs_put(kn);
 
 	return ret;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 4bdcf7a71845..f1977d72369a 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -39,17 +39,23 @@ struct kernfs_open_file_mutex {
 	struct mutex lock;
 } ____cacheline_aligned_in_smp;
 
+struct kernfs_iattr_rwsem {
+	struct rw_semaphore rwsem;
+} ____cacheline_aligned_in_smp;
+
 /*
  * There's one kernfs_open_file for each open file and one kernfs_open_node
  * for each kernfs_node with one or more open files.
  *
  * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * protected by open_node_locks[i].
+ * protected by open_node_locks[i].lock.
  *
  * filp->private_data points to seq_file whose ->private points to
  * kernfs_open_file.  kernfs_open_files are chained at
- * kernfs_open_node->files, which is protected by open_file_mutex[i].
+ * kernfs_open_node->files, which is protected by open_file_mutex[i].lock.
  *
+ * kernfs_node->iattr points to kernfs_node's attributes  and is
+ * protected by iattr_rwsem[i].rwsem
  * To reduce possible contention in sysfs access, arising due to single
  * locks, use an array of locks and use kernfs_node object address as
  * hash keys to get the index of these locks.
@@ -58,6 +64,7 @@ struct kernfs_open_file_mutex {
 struct kernfs_global_locks {
 	struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
 	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+	struct kernfs_iattr_rwsem iattr_rwsem[NR_KERNFS_LOCKS];
 };
 
 static struct kernfs_global_locks kernfs_global_locks;
@@ -76,6 +83,13 @@ static inline struct mutex *open_file_mutex_ptr(struct kernfs_node *kn)
 	return &kernfs_global_locks.open_file_mutex[index].lock;
 }
 
+static inline struct rw_semaphore *iattr_rwsem_ptr(struct kernfs_node *kn)
+{
+	int index = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_global_locks.iattr_rwsem[index].rwsem;
+}
+
 struct kernfs_iattrs {
 	kuid_t			ia_uid;
 	kgid_t			ia_gid;
-- 
2.30.2

