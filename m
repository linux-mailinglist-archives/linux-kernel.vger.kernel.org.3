Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBA7492FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349623AbiARVVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:21:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50386 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349527AbiARVUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:20:43 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IKEEwH021250;
        Tue, 18 Jan 2022 21:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=KVZEqbez+HEjEszY7yPbZ6Pivn8loewptq4mxjOMA5c=;
 b=f9taApvtqrULiTxat6+6us5QEIZgzkUre2iOct43IUCnXImMZc20HUp2Cu2Z10nX2vj4
 pU2oRNQxaJJQ5EEYiR74N4Lue550rKbTC4ZrahDKYyW+HfCtb1iNyOd+Qf084cGpEPbX
 xdinPIbMa1QXT7pEShgsoeFGGCGo6SeizhP5o6R6oKknCzuspgVLID5AU2hWEw1kx9p5
 59OP/AgHYMOdTueY28oZHJIjF8jnNTfEE7HNm0qH/IpTGb/NUGoMgYSxR2z/m2mgrTSw
 x052xW9fHw99owOF/lzHLlARSmOblfIh3UIaAl+ygWA9eCnC9BYD1iBt4TyO+h+TOKab Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q39j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ILK4K8062049;
        Tue, 18 Jan 2022 21:20:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3020.oracle.com with ESMTP id 3dkqqp4rby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k33n3C8Bj5Z1SgFo/yxIIAD0BPnvzIchISkHJZs2wT6X9b7yG6Bcm9u3Xb1aRQuBUj2TC4xsiJvU8DWWtr46Mi3TJ3Ru9/wBkJbAFmhlVrKsXtcjNrZhRMaxZYotULVRTJGtFuEwGrZ76UAGCF/HApX5SSjPWL1QsCps6nDonbJhUJ8Gav+I3gzIlgetPOQ8gSkhL5eBguWRh99aEc/TYZGhOkfa5O1VwnEQbAdPuV8/Y5ZLqfn9apI+/EVOI0xQ4ec6EM400ftDtN72ih6MnvjW3L7lAAV80zR/1S4zwkJJEhTNCAEwxWRqNp0bQmzop4n8Jcy8OHNQqF8Bv55mIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVZEqbez+HEjEszY7yPbZ6Pivn8loewptq4mxjOMA5c=;
 b=jR1EE1ym3B11s4zcic8Y9iBaE2HnLV1ZW42VW0MfdBF/0qxN2gwvC9NaH7cOrxjnHvCSy5FxWCjuEWEaXtlwFgPIb/kBtfefKZfAy6v2PlawncnjoG3aBzLqqYsPXxtZf0kEPNDG0nnL6IwPR9VWPxFQCLWazgiAJ9MJg/q8vAUBIPdsIvESHxk9hozdAezHRDJAFZo9jsExHevmo0o9RyNoilYnYHSS6OorLgBoLi+p5vzz9XcqeemSbJic+wrg14b6O7M3IdykX6hITIG5Uj7/iht3GJ2/6v3mhPS3qzhBvpMHSQ56gi5mn0PfaAREutE/ilUKC2LnfgblZpL50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVZEqbez+HEjEszY7yPbZ6Pivn8loewptq4mxjOMA5c=;
 b=oD8Z0scvz9TfQo8RuY36hXMcK9geAqu/OT70vx5/uZNDDSw94QTHmHutofMgjgH2J/yiZJwd5iP9WbLD+Vd1G2YECLFzFf5x5Q6p0bLVS/HsHRnAOVpeqo3X8slgYFZHvucFYojJSAr6oYR1SjxhShBLXmPCGlDRLxTD1lBJ0fg=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by MWHPR10MB1584.namprd10.prod.outlook.com (2603:10b6:300:29::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 21:20:22 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:20:22 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH 4/6] mm: implement mshare_unlink syscall
Date:   Tue, 18 Jan 2022 14:19:16 -0700
Message-Id: <afc1eed3b9095b279c4439a3627afa4973bad007.1642526745.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642526745.git.khalid.aziz@oracle.com>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d2fd1fa-2da4-436e-cb7e-08d9dac855c8
X-MS-TrafficTypeDiagnostic: MWHPR10MB1584:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1584400A064DD486AF98142386589@MWHPR10MB1584.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:283;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJxuz+azbtEdDRu9v10f6Qmmj0BKpVzgKDZ+yoichqwAwZP1JnYSdVP9yRjtojnKJSgzT30tbTphKUQJPFaRLOfIfOCjrVzvT8VLlM7KJu8/go3wS5o9pVR3wSziM+3Sx+Yi34SHO9ieS3Wiuh4xXojsHgcP368kdjXS2YjXovhKKdZqx5hjOjd9annjOPQSRvyyx86jfS6VgAFeb7Fk12dB/DGd+1E1RJoSTd7Z2kjeaBvoJz52i/i8N1MbdUHisKICc36YDBCEqrMqCxbXjMPvD+WvcjIGJwzIbpbldYxvX66WLs59mcDns7BB0VTVZ5kdHpBJMxFZocHRHdytfAXb/ECzMiUGMeY9N3KoJUC7Z5lZQpm6iE88v7MzbeMfvIwm6oSB1rdqOT/f4+sEVrO/oaGGvcM/htInrmCTeCOmbEExrz91AoCiR5dON2OdHpMbWZuT6BE7EBd3dN8FrnRFWepOPoRUmtlDbdezbz0/TjjA4VCt1OhaP3E8a8qQ1yxCllRPB94tpbEvr0JjBp7awW63xdXqB1fRuv9ETq3Q7m9ZIR65ICAE892qYcN9/nzF4RFGYXkAf1uPGt7LyrkCF4BJEGd5VT5u5wPmaN+TwmQevmzu2Yj32LWhvgoJo2ydTEOtq/fnZNMHVFtMw1T1rxfByuW7gChj4hfCtiLBaIgRPiTa/FgP4RPZxArGlKh0MBg0+1jge19du4GXgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(921005)(38100700002)(316002)(508600001)(52116002)(6506007)(66476007)(5660300002)(4326008)(86362001)(44832011)(107886003)(6666004)(66946007)(66556008)(36756003)(8676002)(8936002)(2616005)(6512007)(2906002)(186003)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nE9cTBCndAt2hooJjK0lP6+5jV12DwPPnLkISIYB31y5jYUSD8h4g033LKsp?=
 =?us-ascii?Q?LrdYbx6+wVLgNqOQAWFH2M3pGTqS+L4ohhIjWgUll/HsXRvGUPHM/i8gPeHP?=
 =?us-ascii?Q?9Tv+s9x7tv6eAK58dxg1rky1EpwNdxYQNnPfl0xjXcT+IviJmFqidWxcoCAe?=
 =?us-ascii?Q?j6GmVlDoQswluumowDkFb/AXKVnW5UWgOwpyaNCTfiIeX2bata8ufGeMuULP?=
 =?us-ascii?Q?MXlnk9MC3LozC9ZrM098DRThNxCTK17vfIJO/UPwO8n7JFQOkD6k7cvY8IJb?=
 =?us-ascii?Q?FbVkO29HJSF3u8W4rPMlWQ7z9KTxrAkuwoY/d0qsY/mZoqZsUXsm9yN0BUdE?=
 =?us-ascii?Q?wDSeiX5BNWuHexF2IlashVURp2cwaszmA6xxLAWDbMHvNKozXq/BOQtUmDwh?=
 =?us-ascii?Q?iEtq6B1WoxO6k3w5w/Lzhg3ToiTpg781Wi0eUJ3dt4Jyf6V/PY9aAOivLgZT?=
 =?us-ascii?Q?wdVUfGRum99xKjxTso2y66zm/PhmN+V1JtQ5c6hj8d69Z/aM37ZfSXEHv2Jb?=
 =?us-ascii?Q?a5HYu/Iv4F9oLuf04O8jePi3J8ur6gYQh7hc4rci7PD2Qm7NCLlSllTE/5cI?=
 =?us-ascii?Q?aaREzVC8I9IYToYiHJ+H3IUeMcmJZ20pl/P8FTISs70lvXlghhs5CJ2iHaBZ?=
 =?us-ascii?Q?iGDlx7jlCgTcPrTlEBRxe8c77NRQFJ3D06vj/SiyGHcAO5Tt7Zm8cqXlOUqs?=
 =?us-ascii?Q?vKpBWchAw/zPVZokjoS39OSALUsWNv2Do3xP6RF4TwvQGN/tUW3y9ahNXYSv?=
 =?us-ascii?Q?IhSoTNRi6G8NXImBdaEcXJHi/qsEUGDsgum6shMOg9PRtWn/Ya9SxAXwQctQ?=
 =?us-ascii?Q?Rx1AcOrtyJu61uillAk5xEvw+GEqUumKe6KzvzT5S2VFdbxatsrJ/J6ZuO4Q?=
 =?us-ascii?Q?2dRLYtNU9DuEQ89q0HzxjbXAaNYJcATGJ/C3WTApWn0X2qjUXBrL6kLcDWM9?=
 =?us-ascii?Q?h7EID6SVr57Mql1OChbJqy44KKnCLT8BBm+D3kykmVsUXLmVy6v4i3966bx2?=
 =?us-ascii?Q?JCt2oBHFmrEGFxrG0KunZKG2B+bxO54Z1zYC496/KIz+rrpUHY0hzQ3A11A3?=
 =?us-ascii?Q?KD7qWNasrOuILh2H9Aw/ZRhouEkypQhn65ezyaAJG0BRNiTMLsUGcrwLuS4Y?=
 =?us-ascii?Q?LEvmITqenaQ66CEkrvVmZ/7O3DfTWdZeBKG/ayBRxJ4dTAsjNMUQOiBzetYf?=
 =?us-ascii?Q?ps6uQd8mtniRlBWJjgeyTHyvPNxn0PkzUCRhQOseewslvci4bAx8HtPqsuGq?=
 =?us-ascii?Q?YmAS1nHgUymtXfUtZ9Ivmc+ME7ZJCtb8fh4c/+tmuNrJSDZpoWAPmNsyAOfW?=
 =?us-ascii?Q?sYvOdaIqwRQupegtQD1ooZKPt6VQrvDgVMDCQg3muqUyR9dYMtRi49Pq3hd3?=
 =?us-ascii?Q?JD2HumBMRP1K3LwmyXKp5r3CGxqNw1hytPEwNCxHoGq6eHl/ucjWRFTH013c?=
 =?us-ascii?Q?Zaubh8D6fERXZnIgc84IE0cqZoqltyz+8oJMGom8phh1H9/w50rpgx2wJpA+?=
 =?us-ascii?Q?DHFtNHa6KiBjuAV5FkWYAdoj9xUVD0wQotDe52J0X1R09WYxi8OgNIYG4xgP?=
 =?us-ascii?Q?ZOTWFoPtbtqion/NX/CCPV7rAeRV9abT7frWJi5OBqJtcui1Iid3ZQv2/41m?=
 =?us-ascii?Q?Mgls9FLEn5iAceUQf3PamGXkkIMSuCa+BSR86YXgWh9saOhr3+I+kUfi5T5d?=
 =?us-ascii?Q?pl5rbQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2fd1fa-2da4-436e-cb7e-08d9dac855c8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:20:21.9672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0euU8GEyNbElicuqH1JmFIbVUHJvmDJMD95EPIXeQ4Od1CBFJPigyui4Jm0KM5b0CgamY7gE3AaeHdk/IknDHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1584
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=871 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180122
X-Proofpoint-GUID: LnaIVF5X3D6sODwJy0W1tHcw0R9Kor0H
X-Proofpoint-ORIG-GUID: LnaIVF5X3D6sODwJy0W1tHcw0R9Kor0H
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to allow mshare syscall to be made for an exisitng mshare'd
region. Complete the implementation for mshare_unlink syscall. Make
reading mshare resource name from userspace safer. Fix code to allow
msharefs to be unmounted cleanly.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 144 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 113 insertions(+), 31 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index d998b23c25ab..8273136363cc 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -22,11 +22,24 @@
 
 struct mshare_data {
 	struct mm_struct *mm;
+	mode_t mode;
 	refcount_t refcnt;
 };
 
 static struct super_block *msharefs_sb;
 
+static void
+msharefs_evict_inode(struct inode *inode)
+{
+	clear_inode(inode);
+}
+
+static const struct super_operations msharefs_ops = {
+	.statfs 	= simple_statfs,
+	.drop_inode	= generic_delete_inode,
+	.evict_inode	= msharefs_evict_inode,
+};
+
 static ssize_t
 mshare_read(struct kiocb *iocb, struct iov_iter *iov)
 {
@@ -114,7 +127,7 @@ static struct inode
 }
 
 static int
-mshare_file_create(const char *name, unsigned long flags,
+mshare_file_create(struct filename *fname, int flags,
 			struct mshare_data *info)
 {
 	struct inode *inode;
@@ -123,13 +136,16 @@ mshare_file_create(const char *name, unsigned long flags,
 
 	root = msharefs_sb->s_root;
 
+	/*
+	 * This is a read only file.
+	 */
 	inode = msharefs_get_inode(msharefs_sb, S_IFREG | 0400);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
 	inode->i_private = info;
 
-	dentry = msharefs_alloc_dentry(root, name);
+	dentry = msharefs_alloc_dentry(root, fname->name);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto fail_inode;
@@ -137,6 +153,7 @@ mshare_file_create(const char *name, unsigned long flags,
 
 	d_add(dentry, inode);
 
+	dput(dentry);
 	return err;
 
 fail_inode:
@@ -150,10 +167,13 @@ mshare_file_create(const char *name, unsigned long flags,
 SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		unsigned long, len, int, oflag, mode_t, mode)
 {
-	char mshare_name[NAME_MAX];
 	struct mshare_data *info;
 	struct mm_struct *mm;
-	int err;
+	struct filename *fname = getname(name);
+	struct dentry *dentry;
+	struct inode *inode;
+	struct qstr namestr;
+	int err = PTR_ERR(fname);
 
 	/*
 	 * Address range being shared must be aligned to pgdir
@@ -162,29 +182,56 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	if ((addr | len) & (PGDIR_SIZE - 1))
 		return -EINVAL;
 
-	err = copy_from_user(mshare_name, name, NAME_MAX);
+	if (IS_ERR(fname))
+		goto err_out;
+
+	/*
+	 * Does this mshare entry exist already? If it does, calling
+	 * mshare with O_EXCL|O_CREAT is an error
+	 */
+	namestr.name = fname->name;
+	namestr.len = strlen(fname->name);
+	err = msharefs_d_hash(msharefs_sb->s_root, &namestr);
 	if (err)
 		goto err_out;
+	dentry = d_lookup(msharefs_sb->s_root, &namestr);
+	if (dentry && (oflag & (O_EXCL|O_CREAT))) {
+		err = -EEXIST;
+		dput(dentry);
+		goto err_out;
+	}
 
-	mm = mm_alloc();
-	if (!mm)
-		return -ENOMEM;
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		err = -ENOMEM;
-		goto err_relmm;
+	if (dentry) {
+		inode = d_inode(dentry);
+		if (inode == NULL) {
+			err = -EINVAL;
+			goto err_out;
+		}
+		info = inode->i_private;
+		refcount_inc(&info->refcnt);
+		dput(dentry);
+	} else {
+		mm = mm_alloc();
+		if (!mm)
+			return -ENOMEM;
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			err = -ENOMEM;
+			goto err_relmm;
+		}
+		mm->mmap_base = addr;
+		mm->task_size = addr + len;
+		if (!mm->task_size)
+			mm->task_size--;
+		info->mm = mm;
+		info->mode = mode;
+		refcount_set(&info->refcnt, 1);
+		err = mshare_file_create(fname, oflag, info);
+		if (err)
+			goto err_relinfo;
 	}
-	mm->mmap_base = addr;
-	mm->task_size = addr + len;
-	if (!mm->task_size)
-		mm->task_size--;
-	info->mm = mm;
-	refcount_set(&info->refcnt, 1);
-
-	err = mshare_file_create(mshare_name, oflag, info);
-	if (err)
-		goto err_relinfo;
 
+	putname(fname);
 	return 0;
 
 err_relinfo:
@@ -192,6 +239,7 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 err_relmm:
 	mmput(mm);
 err_out:
+	putname(fname);
 	return err;
 }
 
@@ -200,21 +248,54 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
  */
 SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 {
-	char mshare_name[NAME_MAX];
-	int err;
+	struct filename *fname = getname(name);
+	int err = PTR_ERR(fname);
+	struct dentry *dentry;
+	struct inode *inode;
+	struct mshare_data *info;
+	struct qstr namestr;
 
-	/*
-	 * Delete the named object
-	 *
-	 * TODO: Mark mshare'd range for deletion
-	 *
-	 */
-	err = copy_from_user(mshare_name, name, NAME_MAX);
+	if (IS_ERR(fname))
+		goto err_out;
+
+	namestr.name = fname->name;
+	namestr.len = strlen(fname->name);
+	err = msharefs_d_hash(msharefs_sb->s_root, &namestr);
 	if (err)
 		goto err_out;
+	dentry = d_lookup(msharefs_sb->s_root, &namestr);
+	if (dentry == NULL) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	inode = d_inode(dentry);
+	if (inode == NULL) {
+		err = -EINVAL;
+		goto err_dput;
+	}
+	info = inode->i_private;
+
+	/*
+	 * Is this the last reference?
+	 */
+	if (refcount_dec_and_test(&info->refcnt)) {
+		simple_unlink(d_inode(msharefs_sb->s_root), dentry);
+		d_drop(dentry);
+		d_delete(dentry);
+		mmput(info->mm);
+		kfree(info);
+	} else {
+		dput(dentry);
+	}
+
+	putname(fname);
 	return 0;
 
+err_dput:
+	dput(dentry);
 err_out:
+	putname(fname);
 	return err;
 }
 
@@ -228,6 +309,7 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	static const struct tree_descr empty_descr = {""};
 	int err;
 
+	sb->s_op = &msharefs_ops;
 	sb->s_d_op = &msharefs_d_ops;
 	err = simple_fill_super(sb, MSHARE_MAGIC, &empty_descr);
 	if (err)
-- 
2.32.0

