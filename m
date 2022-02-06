Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DB84AAD77
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 03:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381558AbiBFCPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 21:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiBFCPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 21:15:14 -0500
X-Greylist: delayed 3917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 18:15:12 PST
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47745C043186
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 18:15:12 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2160Yose021115;
        Sun, 6 Feb 2022 01:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=gPuukhgzveLeAAMTMqwrzBq4NZRpnY4X8nwxuJTUeO0=;
 b=GN3f1yezi2pUiv7MKJtLRBfhsfEDJz0UkU+nmPTtsdg12IIDeQ/NWQxa2lPRfTCwopQn
 ZzkGkSkNGiEmglKSxO3sjVaEhmr930tUD6u5EqrQ3/tv5DQ03B+rZYZdC9poIEFm8tLq
 J8liERECcGdUaJXifWgOmVF8UjSzEZ1eJYInHM0E2FNHRdDuGxUcanTCJv996om0AGIB
 jnfF7QyoK1QPnVONIil/tR2ydNu18ALnisz+i9jannQ8KNvepNONpMVDuHPXWDCt2u03
 rQN4GkAegZsKhHO2PdbviLXvwPExQy30Bjbou7+VhiZPu+cIB4/WKpIF7k6Evbq5gBZf 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1fnda0s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 01:09:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21615RA8087165;
        Sun, 6 Feb 2022 01:09:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 3e1h22d9ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 01:09:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZjWCCtfkPcTWnouW965T1UnMEXDzyz7z0wdSRL6V76KsK/aRZplFPXDGQqPLg2vYUEzp/yRsvEncfF2i/RUnwk2CQTQ4wn4A6W741xyg4LPQX29tw3bKFlZ5nrmcePhnWUbGtNEQOQc9nVahdA9KZqEUA9Fx2kCKzu2ol/IjAlKOtMSApYMcHg37GFYOkVOqr8J34dLkSZXzNlD99VgkUBE9OEMc1GgAPS8gey4fRRrFPgb27Rv2Q/kW5qw0AvCRP1TitTDTzH4YLZCcrUWkXp1KuizGsNHpjhLtXISQW5Ks5/of9Z3zugpcNsvrv46bMYCOaz2Mcc1sHUMxLeH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPuukhgzveLeAAMTMqwrzBq4NZRpnY4X8nwxuJTUeO0=;
 b=mmaAKcaeFlPDXTVlSJcWQa0rvYWBBOFp4IrpiUTdAPuLxhystqlVQ1Frn8msrAw2y/J09mt1bW4nTHtbceT9yr/8dieA6U0q5KiIKswO+axaB3n6Vn6w+TNQUkS57pCEXR9h2ZJbR/Yj0O5nLWvthitAAOFYDyUTLgI+p4LKmk5nR779ueuU0c4aA92YXoVuXgFvR2Pol57zJd/VvMXyGzbXz3TMlDNARVCEBY9f8lndwDqexEID+QH800FJg3NhYcz/NPgnAfWfrPF9QxQkyVbBDjzNrPlpIg4/NPhVyE9reWurW+WQ/FZodsPVeBKZV9iFpnn8l8480mkbuOdXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPuukhgzveLeAAMTMqwrzBq4NZRpnY4X8nwxuJTUeO0=;
 b=H6UYWlilAbmYS1FvIaJ1AgIziwIExka3J9lKw6DHom3G5DjX+ftSi4sWo9qNQsnr3NS6a+AT869eTy4NCTVHVR+2RjhplVefztyvtM6XdBxNMy48m++3EaqAxyNGVhfHAfzE6WpxTBezY3cxyJhQwrOE7DUhMV2snUdu6d4Sta8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB4079.namprd10.prod.outlook.com (2603:10b6:208:1b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 01:09:50 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%3]) with mapi id 15.20.4951.017; Sun, 6 Feb 2022
 01:09:50 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] kernfs: Replace per-fs global rwsem with per-fs hashed rwsem.
Date:   Sun,  6 Feb 2022 12:09:25 +1100
Message-Id: <20220206010925.1033990-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206010925.1033990-1-imran.f.khan@oracle.com>
References: <20220206010925.1033990-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0019.ausprd01.prod.outlook.com
 (2603:10c6:10:31::31) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7561be9c-070e-4e7b-bb95-08d9e90d5f95
X-MS-TrafficTypeDiagnostic: MN2PR10MB4079:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4079BD6AC709CE96BD36A8A1B02B9@MN2PR10MB4079.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03esnTke+R3pMCIVsXQYOaeGKF4uVJIUvqR7re9K4zUW7/f75OMhMbY7GqpE3Q3PyyHXE50zlALBpGJ1ijXfQaTMjZiz40DuJz4KSh2hzlr7DbNuB1OFRwR5HrErbHq53zIFlLXTUy0z7eyRoKre8i7faCHO6tiBVAYSdJ5THUeXsrtaLR9WHURAZdYVP4vhVc4xzWmVhkvKpfZf8nqVu9Yw4vXv2xEOldoeIbejLQNu+viLAXPN/EhuiZLFzLB0YrXMPyHF/YqMd2mNpabUQ059Voxl5GE8DCUiLsY934dTLC12HWaQRhXyuwlgfstDt5WAAhsOSOJdxwxmyYz5nGbO8bk5T7rr9FdIT+Dm4vHdOmxeMGzGMK84o0J/ZZ+h7W4bFZgpcgLqX0nbdtLh8X+KLKhp9orGGzuvvL1DOyrLLRn7AdDuEKNERpf/0bMfhlMCVw3cqDuvXF8TLQ5+HNyRnPzowXxuIBJqocKEDqehFW9aew5CsrH2pO+XR7A4WqInPZBaLsvVc/613bitdoww4qqPzpGYusrvFjdiuLUgkLVDCjLfjqB6ym75eYFZ5lXEiJS296rrgEFvpYGKx/6u4M6/V1WQBolLTpoAkyJGsRM8VHQc7vXfpMbI6EpQrskI+2YcAU677Vwp/j1Agmdhx/Qm/yFqd0O2Z0vXmFizTHM4hK2BowHa3U9t0TlHpkSLR8bFLuNYLYovpqSxcy5j5hmM84UOmynBEF6A1yY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(6486002)(38100700002)(6506007)(86362001)(508600001)(8936002)(8676002)(4326008)(316002)(6666004)(38350700002)(52116002)(6512007)(2616005)(36756003)(5660300002)(1076003)(186003)(26005)(103116003)(2906002)(83380400001)(30864003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Y1adI1Cl1cQLtki6P7MLsr/LL0sihl3ogw6D4iXWw+dls0hnF5yjnh/pBlT?=
 =?us-ascii?Q?RfNzmDvRMelTZzMQYU7gsLVS6mh5MdFBKyM4RkB6hMdZZWQ4CYdTNnZVlDFP?=
 =?us-ascii?Q?/KIOdrEY94Tx7mlZtDn6qhPoQkrjY6lrrVNmg+AvKhxOLnA+93aq3bXtqoc2?=
 =?us-ascii?Q?wzP39NMVxW70VvkWVvj7f1C72Uwv7pLlQlyrTejgyC9HI1pkAYMlwY9hcc1Z?=
 =?us-ascii?Q?QWSpLrUx+2sC1C1HudFMf3L928+u73ze7tn2NQaat2yTH3MnKvZcF+Iqqst/?=
 =?us-ascii?Q?Hr23DH3zly6aqbvNQqjEOJVQpfy4irPmcxOcWcY5rgvFK3t4JyFC+I32tre8?=
 =?us-ascii?Q?4vOx8AC4K9/pzbf/9ns/19nz0voiOQTF1j/RUnSNVJkKRx7L7dmD8SNKVAlY?=
 =?us-ascii?Q?HJSELuv/7cZ3FxjhvRZBwxOk262+ZGhSq2pn1m4mVF5JuKWdvp5vmK0G6XCj?=
 =?us-ascii?Q?1CkSknbi01UowEgmIur1GNEkgknTZVWV9gyrQ384ka0qqVMgNmDfhQoZONj/?=
 =?us-ascii?Q?tIdTNXJQb0T6Wu0FxWdnj/EKiHdKCroq+H5WFt3zbfKGK8gQe5E2QbTQSiV9?=
 =?us-ascii?Q?p95u6z1QGc6zHFqtxWIvd3OMK4zn26+UzzCqM40VPGW+m98xwY++3sZhf/tH?=
 =?us-ascii?Q?2Sbi3yL/cLYFKBpXDVZz/KBABun6pKsW4XuE5LdAQV4zhUm2gg1UWfEs9txV?=
 =?us-ascii?Q?hiiU1BK8aTC4kszwXK6iJKd5+tBUCHHWiKQnMWsR7s+DsYcs0p88KfMEzP+7?=
 =?us-ascii?Q?5DZmyw4ATSj0bbaCHAF71Vexn9DWYWC5UGaZ4p5/we5u/U3VRMngKlq6CSRU?=
 =?us-ascii?Q?jeW78d2dpJidvtr0SFLnS711SJCfQHwV3B3DsHYsmve+i+e1NGBl6k42Qhnt?=
 =?us-ascii?Q?57D0hOBpc7i9wwvQfNH+KHIlISHEb3SV5o6aweEtVM8cm72dFVAJphO/ctYb?=
 =?us-ascii?Q?7360tOiD/5ENrCqPxJ8GvE2krnJqzts/vVOzoxiLNgqiKk9BHPKtuZWlDuMq?=
 =?us-ascii?Q?OBblpQckwKinPJKfVVvV3Yw/4TQ/RKZUp3cBOLHKSC07nijuJKOFb5HJ5lzn?=
 =?us-ascii?Q?zv5sEwWkkiEkVfRY7PVYk/i4yEVS2mTqXic+L4Bs+pWZc7JH5ENFsEFl6xfs?=
 =?us-ascii?Q?5vJ8UBjdQpkpJelGtBfN1pq/QIaXoE3s0bIMROcfpzonLU+GIlFAut6UD0eA?=
 =?us-ascii?Q?JrsZhWXm3V0lH4Vc4opurucY/9/0hr8YIXz5jLaQFMs/F2u9vzUtXTyIoFR1?=
 =?us-ascii?Q?WUPxkvEEirTL6IpxMBYOYeKZGjJJ5XTDI9ZzY9R0/o+I5Zo4gtK1lJQN978o?=
 =?us-ascii?Q?hSCC983aRKWtgX1uaqmvenJZiq7bnBPrc5gBcofQwT+0uzEPbHt3euA1KEFB?=
 =?us-ascii?Q?msYE5C+KRDPY703NEsbAflw1uDU41r6A6CKNv8AyvDj3hjIa6zps8k+Z52bf?=
 =?us-ascii?Q?1xDE8v427IeRkc2UGJvNO8aWLmE7sB8gAgO97J8R8VihZTwBrdPE/5EDG0Fc?=
 =?us-ascii?Q?GWh1iHophOG1ufSEiZ4TwjuBJhkw3s/AV0p9l6ltnlouHplWZntvofhYN8ld?=
 =?us-ascii?Q?r46qAc/iLptaAOlA4x57kXc1yj9leUJ8fLQW+5ngYbXRDUw9HKZFKQEFUyBg?=
 =?us-ascii?Q?wwS8X4i7Dp1kp1oXVX9CCnc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7561be9c-070e-4e7b-bb95-08d9e90d5f95
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2022 01:09:50.0567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1ghMGkn08qNDB4GJNDwncgfGS3/ixaKo43+XV5TYAE9qdLQy9APDLPfWbm1SRaKGFnmcLK/b7l5QCdu7R9kug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4079
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10249 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060005
X-Proofpoint-GUID: uhjURn-C7frjPG4nI0uB0TNs0QhgHqlk
X-Proofpoint-ORIG-GUID: uhjURn-C7frjPG4nI0uB0TNs0QhgHqlk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 fs/kernfs/dir.c             | 276 ++++++++++++++++++++++++------------
 fs/kernfs/file.c            |   6 +-
 fs/kernfs/inode.c           |  22 ++-
 fs/kernfs/kernfs-internal.h | 112 +++++++++++++++
 fs/kernfs/mount.c           |  13 +-
 fs/kernfs/symlink.c         |   5 +-
 include/linux/kernfs.h      |   5 +-
 7 files changed, 323 insertions(+), 116 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index d26fb3bffda92..ec1fff78c25a9 100644
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
 
@@ -450,40 +452,42 @@ void kernfs_put_active(struct kernfs_node *kn)
 /**
  * kernfs_drain - drain kernfs_node
  * @kn: kernfs_node to drain
+ * @anc: ancestor of kernfs_node to drain
  *
  * Drain existing usages and nuke all existing mmaps of @kn.  Mutiple
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
@@ -718,12 +722,11 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
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
@@ -754,7 +757,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(parent);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -768,7 +771,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(parent);
 	return ret;
 }
 
@@ -788,8 +791,9 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	struct rb_node *node = parent->dir.children.rb_node;
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
+	int idx = hash_ptr(parent, NR_KERNFS_LOCK_BITS);
 
-	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
+	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem[idx]);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -820,8 +824,9 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 {
 	size_t len;
 	char *p, *name;
+	int idx = hash_ptr(parent, NR_KERNFS_LOCK_BITS);
 
-	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
+	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem[idx]);
 
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
 	spin_lock_irq(&kernfs_rename_lock);
@@ -860,12 +865,11 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
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
@@ -885,12 +889,11 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
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
@@ -916,11 +919,12 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
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
@@ -1050,7 +1054,6 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -1066,13 +1069,12 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		parent = kernfs_dentry_node(dentry->d_parent);
 		if (parent) {
 			spin_unlock(&dentry->d_lock);
-			root = kernfs_root(parent);
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
 
@@ -1083,8 +1085,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
-	root = kernfs_root(kn);
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(kn, LOCK_SELF, 0);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -1103,10 +1104,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
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
 
@@ -1120,28 +1121,30 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 {
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	struct inode *inode = NULL;
 	const void *ns = NULL;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
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
@@ -1149,9 +1152,10 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
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
@@ -1273,8 +1277,9 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 						       struct kernfs_node *root)
 {
 	struct rb_node *rbn;
+	int idx = hash_ptr(root, NR_KERNFS_LOCK_BITS);
 
-	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem);
+	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem[idx]);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1309,9 +1314,8 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
-	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1325,14 +1329,15 @@ void kernfs_activate(struct kernfs_node *kn)
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
@@ -1346,9 +1351,16 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
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
@@ -1369,7 +1381,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		 * error paths without worrying about draining.
 		 */
 		if (kn->flags & KERNFS_ACTIVATED)
-			kernfs_drain(pos);
+			kernfs_drain(pos, kn);
 		else
 			WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
 
@@ -1402,11 +1414,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
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
@@ -1492,9 +1502,8 @@ void kernfs_unbreak_active_protection(struct kernfs_node *kn)
 bool kernfs_remove_self(struct kernfs_node *kn)
 {
 	bool ret;
-	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
 	kernfs_break_active_protection(kn);
 
 	/*
@@ -1522,9 +1531,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
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
@@ -1537,7 +1546,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 	return ret;
 }
 
@@ -1554,7 +1563,6 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 			     const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 
 	if (!parent) {
 		WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",
@@ -1562,14 +1570,15 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
-	root = kernfs_root(parent);
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
@@ -1588,37 +1597,65 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const void *new_ns)
 {
 	struct kernfs_node *old_parent;
-	struct kernfs_root *root;
 	const char *old_name = NULL;
-	int error;
+	int error, idx, np_idx, p_idx;
 
 	/* can't move or rename root */
 	if (!kn->parent)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
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
@@ -1646,12 +1683,22 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
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
 
@@ -1670,9 +1717,20 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
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
@@ -1681,18 +1739,37 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
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
@@ -1704,16 +1781,41 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
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
 
@@ -1722,14 +1824,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
 	struct kernfs_node *pos = file->private_data;
-	struct kernfs_root *root;
 	const void *ns = NULL;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	down_read_kernfs_rwsem(parent, LOCK_SELF, 0);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1746,12 +1846,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
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
index 3d783d80f5daa..fa9a6a48119c0 100644
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
 
@@ -112,14 +111,12 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root;
 	int error;
 
 	if (!kn)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +129,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	up_write_kernfs_rwsem(kn);
 	return error;
 }
 
@@ -187,14 +184,13 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
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
@@ -278,21 +274,19 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
 	kn = inode->i_private;
-	root = kernfs_root(kn);
 
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

