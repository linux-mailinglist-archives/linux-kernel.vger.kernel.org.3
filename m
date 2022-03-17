Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD414DC01D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiCQH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiCQH2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:28:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1991C16D9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:26:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3VavG012048;
        Thu, 17 Mar 2022 07:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=tuwhzupYn9MdHEhN7xuseMBuIqIbpn7WFU30TKjjxqQ=;
 b=bsHS4Ljf4TlUMvu8VmuQDYKFO0Zj4W2gkKdPT8J8GEUjYzpEIc6Kw1FKJKv3nKlpYEVs
 gHeeCNeyPcYy2RoqWf/as57bq3LZmgJuaeXOTkOQ1a9vAxmxGIQDlztwytDZcR+pGWTv
 sO6MHQOh2h3yOdi7CpCVzT5cR0ZmsF3u9Yln7BrFSfFIUGCBCprKc8kAEmcSV6I6KTHY
 mTvhVRhfcKCa2cKC++tq98k/H4BoGVGJRu74VgDO7n67ofZDnMHinrRr8CQgFxJ0x7L1
 bFZsFA5h0GfY8o+/kz1kUcT6Tk8ZNKZjdW+LqgF4DeZETLNTObecZl+Drkzw8vjcI3gq OQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rg5yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H7BW5e180504;
        Thu, 17 Mar 2022 07:26:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3et65q1vab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMKa8lvYpU58utb9VkmC1LJfBqpCli+bSPJve5XWH+ldUdmbOSanDpXznkr1vGB0c4+FHWW8q3l3yRoPI4fo3na42V6OvCmxl6DW4pYpk8oi8fAAz+qrtkgG3mXDVtQjvomsdiW04PlG3Pn9wJraC00Jh9kqvjtaYzAEkCWYXQ/CAlzHR5keytf0nxuGgaZ1B6VyN1qDJWFIdZ/cDsNqJacCTNhYOTiM8jxaesFdWAJOFhd5T6X+hHffsJ8pOVvJrtp/wIT1Y4zPQIXtAB2V2NlDsVl9qyPhrZ2xxu8qVV1mgbVaww3Vl/ncIvRsoSril6ZxDPHWtgioHiwk/2A0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuwhzupYn9MdHEhN7xuseMBuIqIbpn7WFU30TKjjxqQ=;
 b=gYaJAcYUpdas7aBuYOAcZb3mCofKePBDJ3wHXhzQdT/PAvj/lCqFO4iPcGouiBYlICMBSAOt9Loxx3LoQ9SxOiMo0tS4YyYdRREVLM5X1CxHJEhfZ34Q2dRDgz2k62sYgYUGYUNBbmAMc4DHGBe69SU6xz8p8ZF3E/ouh5DkF3aNpA5Lm85iCQfrslWv89Y1asjESZCQxKOGRAqyLGnDVIoBEZmZv8TuvJHO8UTdAlSEMyDhs067ro3NlK+2WkKiw3StS2yznUmDEOUCop1U15J3g4C9HML3hka4J+UBhOZXzsuadaQcwUwPrT0DQn/gU0y26TUjGo5b0bIQP1hXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuwhzupYn9MdHEhN7xuseMBuIqIbpn7WFU30TKjjxqQ=;
 b=Ji9HZsV9BXQsVQPxiPvNJiU96gcHkf/cY7oCWZwDtLvHCYloAtVf1OfEN5DOShlTtTh7Ahe3rJuAt/EuYHkLMCLqFyxW0c3GcQ+8H8aJusahRFhNiaWAvALTtCa7ATL4Ti4hn2wCT+8llkVbJ77X8xHZSK8+MK4l3LgzH6i0e0w=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 07:26:36 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:26:36 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 6/8] kernfs: Introduce interface to access per-fs rwsem.
Date:   Thu, 17 Mar 2022 18:26:10 +1100
Message-Id: <20220317072612.163143-7-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220317072612.163143-1-imran.f.khan@oracle.com>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0035.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::22) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efd8c823-a3fb-4664-5673-08da07e77814
X-MS-TrafficTypeDiagnostic: DM6PR10MB4332:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB43328C4B61FA5EB08834FF81B0129@DM6PR10MB4332.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQUrLm5hJRlegYuqJJBT/r0xY0LXJAlGa8P6a4Z+B11MSkdYqPJzcQOwGXNUVirtldVBVTgl7cZP22jhLLf3yerqbqdUxlk/oBWKGjQDhpWzW5SfATzyXAWrCf3FRFwSU2Hh9XXzwZUtgmNJKxUphwM+vReqlj7Bv/icwWaeTu5wvA6GFYK9+IoYc+g4v8A5VJ83SjcIyr9wccNSyRpQTvXZYIsL1Rwte51UWdVuOrWn/Z2KJeS0gxuXciQqo6Azhd6YToVLpuNJEqozKxNNR6PMTgFjN5LW0I+9JFd6AGDNuyesLMXlkfWjU413lshj+tdPVgGa0Hh16vFyLstHSJTqGRy8yc6hKM/7r8Jy3UhkZZLg2p83VwrA3tswpw7JSZG6dDSa0UUr9ZfDgXzmzhju+bCM5xWagjZNIGO557uFzF3VZUgnAJZDFfVbiqltRAE1BExudZSQvYIMxl6t3gomMSopHtF69zRCTH9n3G10/f+qns+szdSgVspPksnHhOSdMCMO74mnKHNlbisx7pFy7zmq/otDQ2QKhTcwCxH9jJ2H3prUHWxtKpAk4LPkZ8Q5sCx/CNRWjqzdZJcKPk/5xxKYO9+0Mw7r87aiBU059XGga8y06nh349aWYGYRnIdaZGoWtz/Vmao/UhrFT53tJtI6ZI9hQt3eOFdWUbLRnDA+SarklLwIiWULwVW2DcgIR6Hfa6j9Yyq5rGeFeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(8936002)(26005)(52116002)(36756003)(38100700002)(316002)(186003)(38350700002)(103116003)(6506007)(86362001)(6666004)(83380400001)(1076003)(5660300002)(30864003)(4326008)(66946007)(6486002)(8676002)(66556008)(66476007)(508600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P2TZYhw8ZFfgrGvFg5PQyqlIGkWrX+In/gic70UwFUKR653q4nwPPVky0NKF?=
 =?us-ascii?Q?h3bOA9uLs6bxXaU1uyrAcj36oVtz8lckLeap7NnhsZSuPz1LXCBiIVtHWpQC?=
 =?us-ascii?Q?bRD21r80xLNMyi6tSXGIpLKs6yLxDwLqU8KGrl63GwVvXUP0sDZdSp0YgYNi?=
 =?us-ascii?Q?eZyK97+Mwse6h2+/qCsBlCy86aaqmUL9hB9aA+rzQs0negm/AvHlxY6cnhyT?=
 =?us-ascii?Q?LA70oGd5q2L/lZCSDjoeQvXrbSxLoA/s7q+rSF6+jNa4LPoECN6uih5aXkUf?=
 =?us-ascii?Q?3FRDR4Jn5+lG2wVDTpxAQnyL35RBFOMDtQVzv9cQzOQnmuFDeY9dytlj1YWt?=
 =?us-ascii?Q?P2s0ZnNCafnRmE1Zq7Ppr91wtCFR++Gp3O3qKNh1lbrNCHdD/rdzeu7g3eLR?=
 =?us-ascii?Q?1AJww1xoRY2WwDHx9Vf/kqSFicJ/s9NIU1QT8YAN+nAY6YZiXm1Qz1pGx8dS?=
 =?us-ascii?Q?RdR8UySoKp24uTpEm0aJFMxgu3AcFtd1mSDybKkggNGQIkmWoq2GakCh9Oua?=
 =?us-ascii?Q?gn47qGd3+WurMwBTrJc2l/Jhsv+gVrUPI7q2Yev9URmMdpyGPD5Z2S3FHep+?=
 =?us-ascii?Q?IiJh3a9L3phFYBhMNLWqdUFkVR3DFLI3T+r5gDP/EN8DKNHkWojFraZ1slbK?=
 =?us-ascii?Q?0qH4e7T4nuK3w+DplwvgMf5PjosHbnhxnMlMIOgnas4c0bGbBeSpgg5flniA?=
 =?us-ascii?Q?1IYaipOVA9dCIhsxbw+FwPRr/FudGwp0HgBiSZDUA5+88UKhU2ErSvu63hsU?=
 =?us-ascii?Q?jt2q7RZkDNmKKRhjcLl+ZahGoztPXdS2k1mYPbevS4OQMQLdr6dWb5Qd3oar?=
 =?us-ascii?Q?sfpsm/d4pmQEMYVO9Eb1xHaHvoi/MeIBVMAdSqtsu96BmH6v8htQA9SEiiiA?=
 =?us-ascii?Q?W7bxrvILdgsD5zXULcbcYJrqGg8LZRf6GDSNKev3XMflrpK9mbXr1aKd6qK3?=
 =?us-ascii?Q?rzAwMoimvYT7H4CmNIkq4HSWzXEEhLIjmYHkkEOFB7G5Peff7gRGzmhiVkXj?=
 =?us-ascii?Q?Q15Hv9yCYoY8Ma0lAFSbpoCkFiMkUuHmCF08jJU0mmG+UQmCQNUJ+La9OuT4?=
 =?us-ascii?Q?8fcbwE4JoOaF0jwN05xy0ZcR1/TLPoZ2Iimmfj6oq6WLOaiXOweXpe1jrO9K?=
 =?us-ascii?Q?GZbP5U8LmmGASu883aoTVDHUk/McM00YiwOGKXidz4mo5CkmHbxtTWqz0AbE?=
 =?us-ascii?Q?dv1AQB7vf0JuKw9DcOiNNYoF4XUUwxVBMnOQ1zwbGiF9ijAnr6ShNqVZy8YO?=
 =?us-ascii?Q?pthgkLG7RihfcFS40X/e4zPdqpP/iARIdXFFjuVFc8vTKICMD2gqjcW9wHtt?=
 =?us-ascii?Q?kkB81PEJRrue7aHdQEzJaL2L4CvdhUVV6TrNn/2dwV8hoiG52kzb5gUAbFcb?=
 =?us-ascii?Q?/H+aTt3BhlwFW5bD4c7ADOEFnHlP9MW9GrO0uDm17cO5eyNWfJIF9d60x7zL?=
 =?us-ascii?Q?+s+NXZdtAn5t/WiIy/hSZMQqSnZvhp/QS7luiOrqxKovuGq+9AIheQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd8c823-a3fb-4664-5673-08da07e77814
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:26:36.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uypESRAzb6yWZu3Pb8W+BPNFeUJwf86i4OaogN4uaiiqXLmWMo3S5xfmB3ljsoAgfhzcveDDYFg7hnYQs4zWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170042
X-Proofpoint-GUID: IzPj4xcaNHpXhIZmIqDVbY6dT_BhsWiC
X-Proofpoint-ORIG-GUID: IzPj4xcaNHpXhIZmIqDVbY6dT_BhsWiC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

per-fs rwsem is used across kernfs for synchronization purposes.
Having an interface to access it not only avoids code duplication, it
can also help in changing the underlying locking mechanism without needing
to change the lock users. For example next patch modifies this interface
to make use of hashed rwsems in place of per-fs rwsem.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             | 114 ++++++++++++++++++------------------
 fs/kernfs/file.c            |   5 +-
 fs/kernfs/inode.c           |  26 ++++----
 fs/kernfs/kernfs-internal.h |  78 ++++++++++++++++++++++++
 fs/kernfs/mount.c           |   6 +-
 fs/kernfs/symlink.c         |   6 +-
 6 files changed, 156 insertions(+), 79 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 17b438498c0b..5dce041b10c3 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -25,7 +25,7 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
+	kernfs_rwsem_assert_held(kn);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -461,10 +461,16 @@ static void kernfs_drain(struct kernfs_node *kn)
 {
 	struct kernfs_root *root = kernfs_root(kn);
 
-	lockdep_assert_held_write(&root->kernfs_rwsem);
+	/**
+	 * kn has the same root as its ancestor, so it can be used to get
+	 * per-fs rwsem.
+	 */
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	kernfs_rwsem_assert_held_write(kn);
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -483,7 +489,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	down_write(&root->kernfs_rwsem);
+	kernfs_down_write(kn);
 }
 
 /**
@@ -718,12 +724,12 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 int kernfs_add_one(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent = kn->parent;
-	struct kernfs_root *root = kernfs_root(parent);
 	struct kernfs_iattrs *ps_iattr;
+	struct rw_semaphore *rwsem;
 	bool has_ns;
 	int ret;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(parent);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -754,7 +760,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -768,7 +774,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -789,7 +795,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held(parent);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -821,7 +827,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	size_t len;
 	char *p, *name;
 
-	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_read(parent);
 
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
 	spin_lock_irq(&kernfs_rename_lock);
@@ -860,12 +866,12 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return kn;
 }
@@ -885,12 +891,12 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 					   const char *path, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return kn;
 }
@@ -1055,7 +1061,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -1071,13 +1077,12 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		parent = kernfs_dentry_node(dentry->d_parent);
 		if (parent) {
 			spin_unlock(&dentry->d_lock);
-			root = kernfs_root(parent);
-			down_read(&root->kernfs_rwsem);
+			rwsem = kernfs_down_read(parent);
 			if (kernfs_dir_changed(parent, dentry)) {
-				up_read(&root->kernfs_rwsem);
+				kernfs_up_read(rwsem);
 				return 0;
 			}
-			up_read(&root->kernfs_rwsem);
+			kernfs_up_read(rwsem);
 		} else
 			spin_unlock(&dentry->d_lock);
 
@@ -1088,8 +1093,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
-	root = kernfs_root(kn);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -1108,10 +1112,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	return 1;
 out_bad:
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	return 0;
 }
 
@@ -1125,12 +1129,11 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 {
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	struct inode *inode = NULL;
 	const void *ns = NULL;
+	struct rw_semaphore *rwsem;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
@@ -1141,7 +1144,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		 * create a negative.
 		 */
 		if (!kernfs_active(kn)) {
-			up_read(&root->kernfs_rwsem);
+			kernfs_up_read(rwsem);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
@@ -1156,7 +1159,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 */
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1279,7 +1282,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(root);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1314,9 +1317,9 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1330,14 +1333,14 @@ void kernfs_activate(struct kernfs_node *kn)
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(kn);
 
 	/*
 	 * Short-circuit if non-root @kn has already finished removal.
@@ -1407,11 +1410,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	__kernfs_remove(kn);
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 }
 
 /**
@@ -1497,9 +1500,9 @@ void kernfs_unbreak_active_protection(struct kernfs_node *kn)
 bool kernfs_remove_self(struct kernfs_node *kn)
 {
 	bool ret;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	kernfs_break_active_protection(kn);
 
 	/*
@@ -1527,9 +1530,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			up_write(&root->kernfs_rwsem);
+			kernfs_up_write(rwsem);
 			schedule();
-			down_write(&root->kernfs_rwsem);
+			rwsem = kernfs_down_write(kn);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1542,7 +1545,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -1559,7 +1562,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 			     const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (!parent) {
 		WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",
@@ -1567,14 +1570,13 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
-	root = kernfs_root(parent);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(parent);
 
 	kn = kernfs_find_ns(parent, name, ns);
 	if (kn)
 		__kernfs_remove(kn);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	if (kn)
 		return 0;
@@ -1593,16 +1595,15 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const void *new_ns)
 {
 	struct kernfs_node *old_parent;
-	struct kernfs_root *root;
 	const char *old_name = NULL;
+	struct rw_semaphore *rwsem;
 	int error;
 
 	/* can't move or rename root */
 	if (!kn->parent)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1656,7 +1657,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return error;
 }
 
@@ -1727,14 +1728,13 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
 	struct kernfs_node *pos = file->private_data;
-	struct kernfs_root *root;
 	const void *ns = NULL;
+	struct rw_semaphore *rwsem;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1751,12 +1751,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
+		kernfs_up_read(rwsem);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		rwsem = kernfs_down_read(parent);
 	}
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 07003d47343d..f46c25fb789f 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -838,6 +838,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
 	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 repeat:
 	/* pop one off the notify_list */
 	spin_lock_irq(&kernfs_notify_lock);
@@ -852,7 +853,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 	root = kernfs_root(kn);
 	/* kick fsnotify */
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	down_write(&root->supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
@@ -892,7 +893,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	}
 	up_write(&root->supers_rwsem);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5da..efe5ae98abf4 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -99,11 +99,11 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -112,14 +112,13 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 	int error;
 
 	if (!kn)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +131,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return error;
 }
 
@@ -187,14 +186,14 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return 0;
 }
@@ -277,22 +276,21 @@ void kernfs_evict_inode(struct inode *inode)
 int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask)
 {
+	struct rw_semaphore *rwsem;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
 	kn = inode->i_private;
-	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return ret;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 6e6398a72578..8b24bc7e36c2 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -206,4 +206,82 @@ static inline spinlock_t *kernfs_open_node_spinlock(struct kernfs_node *kn)
 	return lock;
 }
 
+static inline struct rw_semaphore *kernfs_rwsem_ptr(struct kernfs_node *kn)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+
+	return &root->kernfs_rwsem;
+}
+
+static inline void kernfs_rwsem_assert_held(struct kernfs_node *kn)
+{
+	lockdep_assert_held(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_write(struct kernfs_node *kn)
+{
+	lockdep_assert_held_write(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_read(struct kernfs_node *kn)
+{
+	lockdep_assert_held_read(kernfs_rwsem_ptr(kn));
+}
+
+/**
+ * kernfs_down_write() - Acquire kernfs rwsem
+ *
+ * @kn: kernfs_node for which rwsem needs to be taken
+ *
+ * Return: pointer to acquired rwsem
+ */
+static inline struct rw_semaphore *kernfs_down_write(struct kernfs_node *kn)
+{
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	down_write(rwsem);
+
+	return rwsem;
+}
+
+/**
+ * kernfs_up_write - Release kernfs rwsem
+ *
+ * @rwsem: address of rwsem to release
+ *
+ * Return: void
+ */
+static inline void kernfs_up_write(struct rw_semaphore *rwsem)
+{
+	up_write(rwsem);
+}
+
+/**
+ * kernfs_down_read() - Acquire kernfs rwsem
+ *
+ * @kn: kernfs_node for which rwsem needs to be taken
+ *
+ * Return: pointer to acquired rwsem
+ */
+static inline struct rw_semaphore *kernfs_down_read(struct kernfs_node *kn)
+{
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	down_read(rwsem);
+
+	return rwsem;
+}
+
+/**
+ * kernfs_up_read - Release kernfs rwsem
+ *
+ * @rwsem: address of rwsem to release
+ *
+ * Return: void
+ */
+static inline void kernfs_up_read(struct rw_semaphore *rwsem)
+{
+	up_read(rwsem);
+}
+
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d35142226c34..f88dc4e26ffb 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -237,9 +237,9 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *kfc)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
-	struct kernfs_root *kf_root = kfc->root;
 	struct inode *inode;
 	struct dentry *root;
+	struct rw_semaphore *rwsem;
 
 	info->sb = sb;
 	/* Userspace would break if executables or devices appear on sysfs */
@@ -257,9 +257,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_read(&kf_root->kernfs_rwsem);
+	rwsem = kernfs_down_read(info->root->kn);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_read(&kf_root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 0ab13824822f..9d4103602554 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -113,12 +113,12 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 	int error;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	error = kernfs_get_target_path(parent, target, path);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return error;
 }
-- 
2.30.2

