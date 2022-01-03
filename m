Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027F9482F16
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiACIqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:46:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18400 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232233AbiACIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:46:27 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2033rfZX028950;
        Mon, 3 Jan 2022 08:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=R1e6IyKiBeWUf2cIs8rl/0M9pg5aF4DPep2J4R4vHxs=;
 b=mkn3BYHbCNPtOJ1o64bziVH6x3LOZy0rlINyALn8vk9R3cUVJ20NL16T79TdGEku+CQY
 ElXpyxjohoBqSktfP3IZNR4dT/S0ZfR0HHH1dO3giQcslZ77myT0IExvd1gRKGAHW+3e
 Qg12h/5x+l7S6RKnLaglyE0v7tYswTuzuVolXqtNtaE/+r9SaWFji4mqX3funY449Pta
 11IHSvwShWN2S0mUOBtRujCq635B61pHRwFPR6vxzi44qesdZfdr10MzvLikdknkp/bS
 ROhWRfpVob4s2u6du+C537IVrGhjsy0ekEjQezfwXVciTgTwxT3sRUtLJiijpTPpumvI RQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3daeuaj6hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 08:46:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2038jf3h179537;
        Mon, 3 Jan 2022 08:46:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 3dac2ucebj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 08:46:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gkwo0kXrRqLq034jq/gHHea1OlccjPC5lZAexm6/lkD5Z67c06X1M3xsaHOoeVey08GiG0t+KCF5t4nb1jltWcfbLt3cbeio0QBJGBxOcluE0fZVQgTHMwYcZV3/c7nd2mYmUIryOGC2F+T306JG76JJqTb1DOOx+tTo4/5WyBT/lL/fr3IdWnSLU/q+mYhhozDQ0IFL5kZst+KnEBipIZAyVAv00YigqVUkpmPq3YYgd3hps3D9gEugyFxXF26VSl3TKm5NxIQw3+nOn8+OlRWwUMqS9ignnMZ/9+C6Jx3/gPmbqsiEdnQSNDfL8Tefy3RjAOPAFzb23c8z5kr4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1e6IyKiBeWUf2cIs8rl/0M9pg5aF4DPep2J4R4vHxs=;
 b=HoYc/Kr8qWJP4Th7LgPQqSOP7ksRIFEQ7Xjg4/RUqHFWpCbGWHbL48duBkvcbpIbyFompwEtEHKAeiYLlajJ0nsYh+EItB4nXPyzhkqJ/4UvOvFDvg9lAP1NlFf7W2lQ0EpE5FqEmtdpCJYs5D8ALeb3bazG7guQ+BEOzxUfRl9/yvhZVhVJJ7A++iI17EgyXSXV11BRKVgDLw9Cvcx0tY3u/RZWOlmH+EVb7OV96QNWioZBycl9dTYrN7qkiRYfBuZxZAjm5b4925bvxa0Nw2MO+dPBTcL/1XfZ3kgXNrqjaP/m60/TMe92+CIZGh6/xagNxnWjv+TdblydBejpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1e6IyKiBeWUf2cIs8rl/0M9pg5aF4DPep2J4R4vHxs=;
 b=iUdj5qeXhcHgnLmesXrUAiLczAZshIKyOlsA8aOP6tHRWm1w2flIZV72ZbFLEZmI9ZMpquolG6iSPdhZRIaZsuML6EG31/Vio6D9Eo9PyO/uVPUigeWfdAE1XWLY/YbKDNqCVuJR+e5jc3f3jv/pS8WC3ETa0VB8q+XHzNNFRhw=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO1PR10MB4417.namprd10.prod.outlook.com (2603:10b6:303:93::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 08:46:15 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 08:46:15 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] kernfs: Reduce contention around global per-fs kernfs_rwsem.
Date:   Mon,  3 Jan 2022 19:45:44 +1100
Message-Id: <20220103084544.1109829-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103084544.1109829-1-imran.f.khan@oracle.com>
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0010.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::20) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b74bc58-c897-429d-f5ec-08d9ce9580bf
X-MS-TrafficTypeDiagnostic: CO1PR10MB4417:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4417B1E7BF0FF86FA2379D5EB0499@CO1PR10MB4417.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKn0L6ec5c5mg7M6r4JKLks09lDKS4mmkldsHa3vXd87XphIct54pSyqsl67bZ7BtL6Dyy4Ah3919kvxN4LhGJE8h9innNW8QbYfqcIsoYan6w391EXvNOBhfyLS5Rv2P2YCVRky9jL02UPyFkfrkYpC1FIz4QMCjvn8BT/vAEsRbXWqJNLR+Y84tc1N4xUukRJOszmBSqhYLVKjFSlra/rSGHsloaDkL2IbLwT9fQr2Dy2TpvK+4XiM6RlIeSjp4XQ3YUixzaC+LM8uILr+L4rfccsVTNSGBhZMi1FaOsAizq07TZ0Sm2H2ecfOmlm9zZW7qHmHiFQQ3Ka1xjrP8fO+L+DVa2p7sL+K6j/q7MY8W/TXNmKE9m2ZcF5stRuhfz82KOVqT7m0JR+THWteslX1CoYhucdsE3ae0rkHuygJKaUflqSvl8LWxIMmNFfsnL47OfLWLABCS/+AZ3YYdWPuI2UemK+qpZ+dcR6Ts3hWV1gfKO18FMMuyraT86NrW6KIU7NN/KBsCdb9TSFpUj7/KkhMi80bnKe+9YVRzk+egXIspF6JMCNamSZULlcvAEZpPBODKb3NsRzYhpmWM2xCts6U0MRk1xvVpb6Zlos94SxkKC2am38QAzFERhwW6yNkQ5iq3S5H6xbKzxzXk4xfPeimT9ym0CrZlRdqUNsmpM2Txvun1jwXDfAHmyuciJdaHc2mPBxXVl0TUl3CgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(103116003)(1076003)(8676002)(508600001)(8936002)(38100700002)(5660300002)(86362001)(83380400001)(316002)(36756003)(26005)(38350700002)(186003)(2616005)(52116002)(4326008)(6506007)(6512007)(2906002)(6486002)(66476007)(66946007)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aH3kGtNg3HeoEbafHepzSQYC7ESkdZDDUJGkyZ/EMWuT2wilA2Rn9xj6a1Wm?=
 =?us-ascii?Q?4e+I1NIOc89UfkoVNmzbzQ0oCUC61+m4EXFCPLb+qoVKqmttAtTPqQ/1P/Mi?=
 =?us-ascii?Q?HBwT7op74M/fD/Dl9Rxj244ExpsHE/Etr4O4Qriyq6mrhRGwwb46dQ+5f/Wb?=
 =?us-ascii?Q?/qJjWmBfOSNf8g695iLYv6mxjMQcmo6nRmYGoSOKVhOXpgwTjN9/yumbK/3b?=
 =?us-ascii?Q?ImQva0ibu8eV6Vf1p5eJxNQxYu23Nh/oXQPsCfjXJFkqyD/hYaodTnYzJz/2?=
 =?us-ascii?Q?G2vdS97VO+UtsJjlCQqQR8WyKOTG25HInWS4B8SKwYZ9M6HL0TKMDcvIVrxl?=
 =?us-ascii?Q?vmpivn/a7VhakuDig533tI68P10/lOxwiFhS/i4x7oipo9c8ciAq+zFj/2ZH?=
 =?us-ascii?Q?rgGL/ljcD8i5LpPzVko3LyiND+Ve5fqbxAPd9EiCllP3d81aJLLR3MBMqDOL?=
 =?us-ascii?Q?mvtnQlOZyfZb/cAwwLbXVzw0tanQ89yN3BsjXj5+/Fgv/CC3lxWD2gQ4BFPx?=
 =?us-ascii?Q?bJsdTamQYNvMaE3/wu/X7oHfiAFRbLptdFslgW8TtMvSWqBl+3aDF4ru90KW?=
 =?us-ascii?Q?tzVQNmVdJDJb3lC2IFpTDGPdVDl+hfaWtcFZefqO+80BWAsu9RBlSE+fgaGl?=
 =?us-ascii?Q?Ryn55gerH5A20W85rPpeMtrXRcN4Ei230gd7cZem8z9zsGiiwcwzWMfkkPz+?=
 =?us-ascii?Q?tF6fAxZ68SfrnjqLFUwTJbstjUtpobjoUOXX1y4SaJ1t4eMoOllkm0c1emB3?=
 =?us-ascii?Q?x1GlxBUG1siRS7wyQC01SnklwVrxJ2ukzfDWIgy8R5AOW6x68Fr+R0JH986X?=
 =?us-ascii?Q?baB61UgsgAa87/gil1nikQYoo3I6nhsw49g9uTJSvLmltR/xTMmpnNqVT7Bl?=
 =?us-ascii?Q?HiNlo3cDUfth0FM87pgbLLZFkRNfcB5iGAQ+DBXcD0TTbY8tOGVZQ03Shu6U?=
 =?us-ascii?Q?ae4/g9EppVno+xqsZNJyihUj9JuLlQF5KBZrKmc8vUHL/Kyo8+AYQ503uboY?=
 =?us-ascii?Q?73gQ35EbqW/gf08uB8VElU+fC62G3+6/uLk6OQz2v3zrpwmhcE3gudurF8he?=
 =?us-ascii?Q?sjYC78wRCy/kNk97kEpLxFBRFPJLNK4pDIpF7Wm4CmTUWzgbJmfcZSGkZABY?=
 =?us-ascii?Q?eKHtbgH4D54M6ubbAXcM1dB5N1KH3xpAeq0cFSzDqdqI+how5upZEXsr0L+y?=
 =?us-ascii?Q?w7NMwopZetEZpowrsX/bPNSl8otLN1m2M2xiSTIj6p+T1rQ3KrpeKMWu7oTe?=
 =?us-ascii?Q?BbdxOE8v+dh40C+elUo8NZqsxNLzIDN0XtXtjeVJExi2+TMMeRgFzHukMAt0?=
 =?us-ascii?Q?V00qZZKUAmaxwiKbpBVrwiNtV2jktmcWj3XhKADmgSQDkxkG82om0ul9V9zy?=
 =?us-ascii?Q?cuaLY6LNqsBK8BRAESVHrmnCvl3z914dcKzwkS43hWK7vt0rSUqf4AyCfwW/?=
 =?us-ascii?Q?zauv2ToDrpGnf1A0tRZtflTOdzRk0G2df18W2Ehc7uzDIzQ/A2ra3TDZk297?=
 =?us-ascii?Q?/nNVibqdyhJ9+yWN/Tx6dpZ5GDZJaRE7ZHtLxksTFoKYdmlOuA9KnffHvXjH?=
 =?us-ascii?Q?m3liFu5m33ezBHEmajIRpH3LbAzss2KmN/5w/ut1BSWdjw0clL8yQgvNuIOi?=
 =?us-ascii?Q?/bhTEZZnbAEjz/dQDVCg6wg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b74bc58-c897-429d-f5ec-08d9ce9580bf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 08:46:15.6398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ThS3GMU2qFEX1vO630MpdC79pXOWnNPrjDgyMOH15xzkCd8GIWfZxYWyka/qtulcQeZ6sgVRIDZrXfTcxPiig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4417
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10215 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030059
X-Proofpoint-GUID: pwIR4gRb96U_p13-sD2Zb4CRFfez-qZv
X-Proofpoint-ORIG-GUID: pwIR4gRb96U_p13-sD2Zb4CRFfez-qZv
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

Since permission is specific to a kernfs_node we can use a per
kernfs_node based lock to access/modify permission. Also use kernfs
reference counting to ensure we are accessing/modifying permissions
for an existing kernfs_node object.

Using this change brings down the above mentioned down_read/up_read
numbers to ~8%, thus indicating that contention around kernfs_rwsem
has reduced to about 1/3rd of earlier value.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c        |  4 ++++
 fs/kernfs/inode.c      | 25 +++++++++++++++++--------
 include/linux/kernfs.h |  1 +
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index cd68ac30f71b..a6846e5e2cab 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -750,11 +750,13 @@ int kernfs_add_one(struct kernfs_node *kn)
 		goto out_unlock;
 
 	/* Update timestamps on the parent */
+	down_write(&parent->kernfs_iop_rwsem);
 	ps_iattr = parent->iattr;
 	if (ps_iattr) {
 		ktime_get_real_ts64(&ps_iattr->ia_ctime);
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
+	up_write(&parent->kernfs_iop_rwsem);
 
 	up_write(&root->kernfs_rwsem);
 
@@ -1380,8 +1382,10 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 			/* update timestamps on the parent */
 			if (ps_iattr) {
+				down_write(&pos->parent->kernfs_iop_rwsem);
 				ktime_get_real_ts64(&ps_iattr->ia_ctime);
 				ps_iattr->ia_mtime = ps_iattr->ia_ctime;
+				up_write(&pos->parent->kernfs_iop_rwsem);
 			}
 
 			kernfs_put(pos);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5da..6d375f3b5e17 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -101,9 +101,11 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 	int ret;
 	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	kernfs_get(kn);
+	down_write(&kn->kernfs_iop_rwsem);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_rwsem);
+	up_write(&kn->kernfs_iop_rwsem);
+	kernfs_put(kn);
 	return ret;
 }
 
@@ -119,7 +121,8 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return -EINVAL;
 
 	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	kernfs_get(kn);
+	down_write(&kn->kernfs_iop_rwsem);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +135,8 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	up_write(&kn->kernfs_iop_rwsem);
+	kernfs_put(kn);
 	return error;
 }
 
@@ -189,12 +193,14 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_root *root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	kernfs_get(kn);
+	down_read(&kn->kernfs_iop_rwsem);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	up_read(&kn->kernfs_iop_rwsem);
+	kernfs_put(kn);
 
 	return 0;
 }
@@ -207,6 +213,7 @@ static void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
 	inode->i_op = &kernfs_iops;
 	inode->i_generation = kernfs_gen(kn);
 
+	init_rwsem(&kn->kernfs_iop_rwsem);
 	set_default_inode_attr(inode, kn->mode);
 	kernfs_refresh_inode(kn, inode);
 
@@ -287,12 +294,14 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 	kn = inode->i_private;
 	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	kernfs_get(kn);
+	down_read(&kn->kernfs_iop_rwsem);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	up_read(&kn->kernfs_iop_rwsem);
+	kernfs_put(kn);
 
 	return ret;
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 5ed4c9ed39af..c0fa319d266b 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -166,6 +166,7 @@ struct kernfs_node {
 	struct kernfs_iattrs	*iattr;
 	spinlock_t kernfs_open_node_lock;
 	struct mutex kernfs_open_file_mutex;
+	struct rw_semaphore	kernfs_iop_rwsem;
 };
 
 /*
-- 
2.30.2

