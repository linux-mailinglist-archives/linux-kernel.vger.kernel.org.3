Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A07492FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349682AbiARVVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:21:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60846 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234887AbiARVUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:20:45 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IKEaet013797;
        Tue, 18 Jan 2022 21:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=3qKJw62UCoeOA2yhT2v7u2xg868SrCEtlCLACAoo4o0=;
 b=ho6RtR/RQGA5LKvhOpOY4C5ADc/ncKDzBFWL3RtFDDH14a91ix3VcOGnrJovI6B+rK3L
 QzjOQc+SerAlExoBxaF2cDWjpMlVxTack7toQqaDVhUcYd4xpAr0pdF8TBxCUWzL5i6w
 WmZxL49LFTrZaZSIqv64VL3VzL+GTLuUStHSZRTeLwjynQtY+sNoiBWvX31pnrYPSZun
 IFTLHP0eWU4ByMABj3hr82OMeczifilS6IrrLr7f7xa1i/1y9REfiQh3DBD4SpIw0H9+
 Q62AUANesEnKONwjhWT3rp4NRbq64UfsEnHodSF8K/dUjJ7loFW4ADe4ldf5PdLM6ItA Ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52u7fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ILK4mF062125;
        Tue, 18 Jan 2022 21:20:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3020.oracle.com with ESMTP id 3dkqqp4r97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqxzdShYsNIRhmuKJ/X6/+5aj3rSHIHLV19gyIs+6vdS2RneHHe+lgs2Rj4Yiw1ql+TdQp992ik3OhbPLJ/oFfux88SF+HAo0Py0roMo79XCeoUPNreFRfRNi6jrvk1rIT3SeSsDG4jMx7BriV/s93Z4BVLJsUXG4oBZ6UbKaoRucJw6moZNxakn/fAnpMdOkmCpt4QG/eQAt5bxn2/oDll4ald3K8+yfsVNLpIPWxOhSXDefclmIHtE77jcLSwXVw+8aG/1kjrrIvMD7SdrdFCvOdMIKjq4I9GYe84fWLRLoxd5aSZvDxyMTbjYK7nhf3zhpMB//ZePlsdI7t39xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qKJw62UCoeOA2yhT2v7u2xg868SrCEtlCLACAoo4o0=;
 b=OKQZ0qHXZ0EPIwA8Crzl7kajYyFWDI/pcBdjDGYY1dN6mu+HLjJQrfotsK7ZA9ZInmrTc68FuP10LaKG5CzegbNZ8nSlk7lB9AbWETM0ABrWz/1/qJHwPYUf/yUBMTwnpdpC1mUBnhNi9syn823/Of3SGfrzfxrE9bZrnEFmTyWiia6vY8pqlci5YyZpf9HT+57ukLdhY7M5VITpT85fJSXhzPa3WgdITYdXwUjdTAWaIg8u7EUILvyp9Ejs4fLw1BPd0/DhyrgYKlmD4B/arFkWwS5RIU9741pJB6eary2qKDzWLHOISVBpnlW6JuQ53+GPzQ73+Kgk06OOKS144g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qKJw62UCoeOA2yhT2v7u2xg868SrCEtlCLACAoo4o0=;
 b=vQVItWWhRxzAlFJ3k6dvmH5+/zlapLAcikGYNYVUsEmZ7/WDiSJvjmHZ2lmfCQsrqi7qJfPuAK5Y3qt68G2v7aCw9bYov6WzX2KeyZP2EEbM0Q0Vj8B3gmn6KXAbW9ft6MEKdA+75fy8J23cv7TgKcjMVRLEmK7vQ/UNkjfhDeI=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by MWHPR10MB1584.namprd10.prod.outlook.com (2603:10b6:300:29::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 21:20:18 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:20:18 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH 3/6] mm: Add read for msharefs
Date:   Tue, 18 Jan 2022 14:19:15 -0700
Message-Id: <d83e39a4e9248547f5f97530d468a1dc179573ed.1642526745.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0dd4aee3-7dd0-41cc-259c-08d9dac853d4
X-MS-TrafficTypeDiagnostic: MWHPR10MB1584:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1584E7F9CA224259F557B14786589@MWHPR10MB1584.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfzErbsfvk8wOxXm/VHlrZeaO9DlM8z2Du6YscL+WrR/zV8PeFQJaB4hpU0js+kUPvuuoVa4EqGxKlw4n6s4EkQyahtFwh8W5h6dyGBoTPy6ttPkeCz49JxfTw8/ulCcXtHwd5+oNcaPd5Cuvea4mvI7Gbp2sGCw+iulw7G1C2QX4DNBBbDoTwIQe4RfFpNzv5JeuqORAW/pbB96tLNGcmcoH4KQqnS2TxO+5Sr8/q5cJ37VpIuoveTvasUrIa1mojmG5+GhzorWu9/M8wA6B55twN/9VQz5NUSY0heDBU24ThTOcZ6If7hzVbIhKoTqo5CqivATDMFP03MAcZWUsQh/LYAht868O/OqGNYfn7vK+QRmSMHwbLhdkDMGBLC1Q2uk9ZGxdwpmgoH0y6yZdhwalYzn/Uso+/JQ74RqRIY8AvkgYZKGBER7CbnH///s3ChMKlcwR6XnXbSw6WqynHJ99AJM97dekzMQ+W04MeoruVxTTHAHp9cgu73MoKA1RqtH5yTqX6IhbrOV+GLWvBn2q7lzXl8RY03r33W3CUWdwe8iF0ftvNnLt2tsNfkVcaWJm0AJtkLmrg82reNn3Qo5kMQ6O5KNw1KhOscf4UWiNE6d0IGXCCvfoBxu9TbEgVpBBrdaE6kwtej4zkF/G8t8U+Aehs4JUIgyhlJXgmZ2cpxRVMRAX6Vb5QgoP6fpdf4JgQsekyfizWOsjDKzrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(921005)(38100700002)(316002)(508600001)(52116002)(6506007)(66476007)(5660300002)(4326008)(86362001)(44832011)(107886003)(6666004)(66946007)(66556008)(36756003)(8676002)(8936002)(2616005)(6512007)(2906002)(186003)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yos5/sDkxM2zmnEkDZYVmXyFqltYRN/rDJyoiIO6X4csV11H+jXj0FcaiDQc?=
 =?us-ascii?Q?zN4Vq8Cn02QFYqH8WdOCHnIw9YutnEktN4Ju7t4UiXM5DrndHxjT0Vhi34tr?=
 =?us-ascii?Q?gRUTN4zkZ3LuxeEr3zvNQXYcdwpBQKYeOV+YRi0mVt9xLuWBP+YZryP5rwt4?=
 =?us-ascii?Q?Ofln8IbAPJG3AWy7VUnZIrXyR3znoOCh8nUXzpYZAaCu/8vv97+ETJ8IVxZo?=
 =?us-ascii?Q?kX8rBsPkTi0Av8/5XC1zn/pO2gSK9zBfVg6XopjGiBHDCYsmQSSPlHxcmQ/x?=
 =?us-ascii?Q?AUUa61badcJU7YEnv23fhTMvbrQM2S+SJdXOzgpLpCOur3tX5B3GvIz1H3lh?=
 =?us-ascii?Q?v4ufH56vskp7+y5PAKTHjfxHvW/H+v7XM+GhVpgP2u6PEutcEkdJPn+sRhxO?=
 =?us-ascii?Q?XlpYwn50JHsBpzI6jGQE6nu8wffq4U/MbekdLSDdhyOOikeXKrlHG5pElb5b?=
 =?us-ascii?Q?uI7IhIbsea/5WrvVfRU3ig+KstoC3fdCmxGe2e2N1lbwHBiNBzcCjKNcUO0w?=
 =?us-ascii?Q?q3AwNhg6DZ5yJ+ToiCSdgOANOLgOTbKZVSB5P9AEmTOCI8ikAMZRwtyCxi/U?=
 =?us-ascii?Q?gxMQLqi1W4NB/FOIWFyQs+Imu9Mw/Z9NkPnDbYzhJoVulslvqtALUz4tTJUT?=
 =?us-ascii?Q?4RvxmyNTYhNeEw1ytX99GeBi/yNns5eSmnSSSHt8TCmz91mA8Xzu8sCDDXG7?=
 =?us-ascii?Q?OUlsyI4OHjBSyC82/G7RDO3uzHTTEY9BNwZ9m0i/lPLfi3hm/CEHKTuHpGIh?=
 =?us-ascii?Q?1ht2HQ0Zy2AfXyBH6Sk4wdBzjGrWYuY21R+uNc89+lWzBnXjVLWp/dm7BARU?=
 =?us-ascii?Q?DIsOVYcRK8u6qkjYp39JTxRvnuE4TSAvinFocXKBwYrhnK926FVsx0M4PepL?=
 =?us-ascii?Q?/sMGqcFb8HWjK/HemI22kQJ39pKTflw97DMuPA9LhxUCwNvx99cMC8+2NDg/?=
 =?us-ascii?Q?IDH3b2U+Ziw3ki3zdIO9l0bq4uPoyp1EIBVfnVXuhwI2xom29+GJuPsp/PIU?=
 =?us-ascii?Q?Sp3O2t2PgFRIWscToYbABVJG/QbetGXzKpW8raONV4Uy7nAz8IncuYr0yA1O?=
 =?us-ascii?Q?Lb7sDP5KB7g+73mRQpyJZt1cfBijjXLPwgIH4r2GfXQ7IDVC4OiPovDzdV7k?=
 =?us-ascii?Q?TpD5SdRMqJwRc5jsozOLkX0DqE3i4sVE1HmrTudEMfvm96JA5AfL+fczG8jU?=
 =?us-ascii?Q?2qBNVCJIyq5vy5feSZATBE9w5UAuEn9/yIV+BS903t4BG/dAiFqJwu1Kg1+V?=
 =?us-ascii?Q?CY9A4KZ9T2Pw1E0NssKyRW9scrnXi+hIs6slWLeVBNdgfQNgzUt26arCcQ9y?=
 =?us-ascii?Q?gUNSoSzsBJl1acr+61cxeogKZhygukJObbftTltPYL7MfdoaOVPtlfQJc/m6?=
 =?us-ascii?Q?Au5EG5tidk03+fKa0XpVjNdV9RpMJAwG+0E2Fp4XJ9M/B3jwpPTXH5yevHOl?=
 =?us-ascii?Q?8v4Ew2UoGCclWZVudwuK1aBi2q5M7yDM8E0QGdDkgDwOFTJVAe5sWctYlQBr?=
 =?us-ascii?Q?XfJJPZsrzkkImZZmrGlE7otpvyMCo/IXaGBlcrayN0KuZg483Ub3KT4Aprzs?=
 =?us-ascii?Q?JpYwFBq1b3tc0IY7VGG16ijO/jZ57XpvM/NT9mxNqhmkUfGpCDipemQgnsiY?=
 =?us-ascii?Q?DbP2pkm0V8r3vesfA6S3Y79yT9HcEWA1Jbdr58FIMc+7Q/9GHKUKr4TuHhsg?=
 =?us-ascii?Q?v+y1wA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd4aee3-7dd0-41cc-259c-08d9dac853d4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:20:18.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkdS25XRC9WMch4aTHA6sJkKcolgJC0SZj3rgMECpAAtPvaEmzNlcKV8F8uf2ijuWwjVjQFGPU5HAHx2/J4gWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1584
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180122
X-Proofpoint-GUID: teFXwto_L5cMzRY8bpAjmfE7HuJPoMZ4
X-Proofpoint-ORIG-GUID: teFXwto_L5cMzRY8bpAjmfE7HuJPoMZ4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a new mm to store shared page table. Add a read operation to
file created by mshare syscall to return the starting address and size
of region shared by the corresponding range.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index e48d0f615f9f..d998b23c25ab 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -16,14 +16,37 @@
 #include <linux/uaccess.h>
 #include <linux/pseudo_fs.h>
 #include <linux/fileattr.h>
+#include <linux/refcount.h>
 #include <uapi/linux/magic.h>
 #include <uapi/linux/limits.h>
 
+struct mshare_data {
+	struct mm_struct *mm;
+	refcount_t refcnt;
+};
+
 static struct super_block *msharefs_sb;
 
+static ssize_t
+mshare_read(struct kiocb *iocb, struct iov_iter *iov)
+{
+	struct mshare_data *info = iocb->ki_filp->private_data;
+	struct mm_struct *mm = info->mm;
+	size_t ret;
+	unsigned long tmp[2];
+
+	tmp[0] = mm->mmap_base;
+	tmp[1] = mm->task_size - mm->mmap_base;
+	ret = copy_to_iter(&tmp, sizeof(tmp), iov);
+	if (!ret)
+		return -EFAULT;
+	return ret;
+}
+
 static const struct file_operations msharefs_file_operations = {
-	.open	= simple_open,
-	.llseek	= no_llseek,
+	.open		= simple_open,
+	.read_iter	= mshare_read,
+	.llseek		= no_llseek,
 };
 
 static int
@@ -77,7 +100,12 @@ static struct inode
 
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_fop = &msharefs_file_operations;
-		inode->i_size = 0;
+
+		/*
+		 * A read from this file will return two unsigned long
+		 */
+		inode->i_size = 2 * sizeof(unsigned long);
+
 		inode->i_uid = current_fsuid();
 		inode->i_gid = current_fsgid();
 	}
@@ -86,7 +114,8 @@ static struct inode
 }
 
 static int
-mshare_file_create(const char *name, unsigned long flags)
+mshare_file_create(const char *name, unsigned long flags,
+			struct mshare_data *info)
 {
 	struct inode *inode;
 	struct dentry *root, *dentry;
@@ -98,6 +127,8 @@ mshare_file_create(const char *name, unsigned long flags)
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
+	inode->i_private = info;
+
 	dentry = msharefs_alloc_dentry(root, name);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
@@ -120,6 +151,8 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		unsigned long, len, int, oflag, mode_t, mode)
 {
 	char mshare_name[NAME_MAX];
+	struct mshare_data *info;
+	struct mm_struct *mm;
 	int err;
 
 	/*
@@ -133,8 +166,31 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	if (err)
 		goto err_out;
 
-	err = mshare_file_create(mshare_name, oflag);
+	mm = mm_alloc();
+	if (!mm)
+		return -ENOMEM;
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		err = -ENOMEM;
+		goto err_relmm;
+	}
+	mm->mmap_base = addr;
+	mm->task_size = addr + len;
+	if (!mm->task_size)
+		mm->task_size--;
+	info->mm = mm;
+	refcount_set(&info->refcnt, 1);
+
+	err = mshare_file_create(mshare_name, oflag, info);
+	if (err)
+		goto err_relinfo;
+
+	return 0;
 
+err_relinfo:
+	kfree(info);
+err_relmm:
+	mmput(mm);
 err_out:
 	return err;
 }
-- 
2.32.0

