Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072B3492FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349491AbiARVVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:21:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62320 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349530AbiARVUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:20:45 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IKEdRW023808;
        Tue, 18 Jan 2022 21:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ElbwZLavMHhHKFKqKAZsHLd8K6H2gl0uN3mepsqZ6WA=;
 b=KpIzta3OaU/S1/oH48Bz3xMwsHw8niDgaByMS0ITY8bdUpfjpjtMgJFx9xOx+4GuF2bG
 lYeT6zRbgtix+eJ+hKENx3MP+gJL0XAokgKgN+alw+KSYLBAB0BpTCcgUQ7FtAEeK9Gp
 YiKqiIy63ilCyvyL3T5S36SUbqoRUhKsDrW71fjM7RVx0J/EM9n1+1e1gehFe/zT+FSu
 z6lEbEmIISmkK67JTkGnQxdDjb5Hr/xrUU4MMMHBYf7HX2zCcou1VYRiYWZLnwnrmzlv
 1c6XFOsIAkRg6nPCSCXi6UYMjQrjycEumE16ur4Rhphf7cEMUvYTR1mZOCmHMHAJr1Ej RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc51b3kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ILK6de062381;
        Tue, 18 Jan 2022 21:20:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 3dkqqp4r6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtdE5p7UczmwE9K9jucstp6iYR4ri+G3BJkHAV+fXWoCTCJ8pYLpbIco0P90QqBXAjz7q5iSGpERvI7ry19QG70jIg3fdfQWXu9hWN2icKaaIvNZwVaFsIEFY6uLjTINopuFO/bbPzSVBsQxWLbc+nSYm4CNIEcxg8ufvgZaSnZYaDFK2jyA8KVwhRjn5jUrYTEfmkGgsmth1GfOwZEYclO3QJQ6GAnJD3ZykTC5fUKQktUUInjZHiHt0xqxtom+ZW9Giisdc/fDXqew/vDK4x8wIi8vDWA5AiuMfebYaayaWH6RGV0mI/HbZO7gCCsnQzz8r5CdrZdPwjb0rxQnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElbwZLavMHhHKFKqKAZsHLd8K6H2gl0uN3mepsqZ6WA=;
 b=cgm8/az71+/QqJ/fX6+z4ZuAVIxJWczVzmZNxWOBQzB/SK82cy+5bx9UyR6usVVk4nF3E2V+FRgh/uZx6VQN2tp0eBQW+C2WpLwkKAkrtXfdFpuZ7AgTiE5YlXr5WjuSJLf0YmxUh6TJAH5So49mGK12MLhdaMiGnhrPz1Stv6eeZHuxaaLqu4fsPC+ZfqUm9o+nSIzXG11MSxytLAVjIdK3mPkKT1deEkwLL3G6diO8zp3tW7xBD9VWZBPtwLoMYHaJjIl8J3ReC6uPFPKu9rp3rNk5xn/3L4WszC2yH6I9uLa+5emTeBG9mBQn0XbhYOTM1PLx9qt75P0yAcFssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElbwZLavMHhHKFKqKAZsHLd8K6H2gl0uN3mepsqZ6WA=;
 b=R7a9lxYLtl0uJ9Y9/+HTxZvBhBRNzndZAsQFBA0k3LyURYj2ijHamlUD9d8zUaMLKrIG/HcvpVRE7jUzYnw5VHlfYKMWgwPgSn7A2Sdqsx6EcwqYyLAfIvcqKdNrf05H4ZdHiQ2APWLBou/jLcHjL+wjylAQJxaFHY1fBztHJcQ=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by MWHPR10MB1584.namprd10.prod.outlook.com (2603:10b6:300:29::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 21:20:15 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:20:15 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH 2/6] mm: Add msharefs filesystem
Date:   Tue, 18 Jan 2022 14:19:14 -0700
Message-Id: <32784ee26d895bae2484e15fef205d5590720c4b.1642526745.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2ed5232a-cbc3-4965-31ed-08d9dac851d1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1584:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1584045B9F9392B99B126FBB86589@MWHPR10MB1584.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUk6M0zDVUUZ1VXfo+hmHmSgAeaEqGobihZHIjQC5YflK6UEUFJk/Zt59FBxj9f70bkB3IoQn1A7aOMH12QgrXDrYoc/BCORHMer/kn+RDPjy6WfXXYrQwr9b3hJWQJeZ1/uYhwSmZRCWv/Zj1YFyXH9j+eS6Qpg9QWsm2bBpuLim5kFKiWqzYR0hJ5QIdZ3CQ9DALXpjVf36Ac1srhIaLqw7u+SvPHXTbcpXQBDYmUotuUrhFoV34VqCfgKnrCmbP9QfDu5sGQscFxWS8W4LKmIfYpyLt4oc7Tf9paiaWiqZG6QGSMfaJRHbk0WY2Uw35BLWTT+dkzFUgpt1gnYL8zGcdwaf9brNs/AO6BUHBBmFiF6f+rsrCJBaWvIxRhgwFmmhSv4u+dPJsA+gSxcowY6t7u5e4RKuKXs76HLQYsk6idriVQEVnf3jcja51rTZxFHc4po4QtFhBvMwX+mCHrfQgxnHZM+iHLLBNtEuYLlLZ0fWOV8vlX20e3CE6c8Z8cBRaOtzjT4fduG2vynJOJb1kIJlTCYwTBAMMetUPYpuhLfv+mrB5JoaogWQkm0i6rX1+vtiEb6Wqp7ikz6JUSnkY0t8Y0+eA7bzAu1ulLtjnzQFgOcsWKdqQFFgV3T6fPzPVqFs0MSew2PEkvkFHI9oE2w5JqlbXNcusS1oh1WbOQl/xb6u9KtgJcZpyqnA6IcXYJr58EwWDfrN7RbiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(921005)(38100700002)(316002)(508600001)(52116002)(6506007)(66476007)(5660300002)(4326008)(86362001)(44832011)(107886003)(66946007)(66556008)(36756003)(8676002)(8936002)(2616005)(6512007)(2906002)(186003)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0IwZUv9V8oQeAZZDFICHEsRo2jkewO9bzgr4MqxGo8Vg70/51uFr+IkPvyL3?=
 =?us-ascii?Q?L0LgUfm5hZEU9E9YcCbKcm0YU+eDqZ0SfpvDCfCW2Zj7LZmDpsQlElAn1XKm?=
 =?us-ascii?Q?eiY/18y5ml8uwSUsAtJoRSp48wdOCJUgXKU8nnvxkQjsvdsMx4D0uZLuA9rU?=
 =?us-ascii?Q?wO2BodSVgVbxYg5Eqwv0LN/mJ6G+x1yrxV53st5X4RSO7cqkgCzNtN9Tvnt0?=
 =?us-ascii?Q?r+hgl/f+Tuf4oBSJEovnMeDULTkRVTNCvnl90KHb8RbeBahem2GZ8Kl7gDa3?=
 =?us-ascii?Q?+iwrN2cBNFSJObaK3dNVNUoQF5gCWOU+IMtH5WDHVssyDbv33ybP4/HQfo0p?=
 =?us-ascii?Q?BfMj0XFfDBmZ8TOCEweR4iHTHCxg9PIXjilDFsMvJmS0Pxk31cLtrj3e/9q9?=
 =?us-ascii?Q?uC3Fr9L5FQKmjPy+1BtcnJ/MC3tBsPXdnM5KlmxAXVhLG5OjkztUMeB+1KgN?=
 =?us-ascii?Q?v7RJCN5RQ3lxASVhh3upyr2bMMi8MdwoDPn5WN8evq5ioG6E2OyrEZ3oY5Qs?=
 =?us-ascii?Q?Uly5vJ7RvbfCIETcn6cYYAQk8SbZ/osAlH04P7oZMri4qvqbMLdAOu34EugE?=
 =?us-ascii?Q?DFbtyeH8VCLNX19aSGzfaBb1AYO9BQAUzMmY9X+8E2KRMyKjnGrSdoON0YEI?=
 =?us-ascii?Q?PgqjcduBCdAyNOiLdfc3G8H9TlcA69YlpD5JTpw0pWXd9CjvOIJL5XmPS3Dw?=
 =?us-ascii?Q?z0H3oRNvz19bw/Y3cRhwallPObhoRxju7qNufpoJxHc9e3JUvccKggv3bODn?=
 =?us-ascii?Q?IbZBEdMU1kr4QbMXdWoycSN1DAOzQkXrgb3UpHZJjgwxkIFBX3wXf4sRXb5+?=
 =?us-ascii?Q?yClvulQ1XhJWlT3i24d9XDRsGhG8DXHATP/0pfwqOLaYKzgaPn7fMI156xUs?=
 =?us-ascii?Q?i67Snqy326X/cxtSXncaFfs8YEFoOxNtsf5yC3lZkO4bx0jx77HXSudMpxMD?=
 =?us-ascii?Q?j/x2Wd1r7umMybUrVXBPcfb3FIZCdl+8edCS1OawSm1bbnpVFj1X+2Lv0C8M?=
 =?us-ascii?Q?S7UPu8IiFzpc1VygvvTazHWeCsEEoQS80t3w5dk2xStVOMgw68G7x9+DMK3F?=
 =?us-ascii?Q?joX137890vprVYFOmGdJK72g/JLqEepR5epqujS8uVuoHtRDEF6gtL9R7dyc?=
 =?us-ascii?Q?xRj6zqW5MHG4OBupdv9ghl9f7sv6TJhvFoBvuk0/VIRGysIQXAQbHhfRwKEZ?=
 =?us-ascii?Q?mDI2RDyvOAier7Z+Ga54rNhG3wYlmgBRDF7CrM68LA+NirYBHiXJgL9ZUI0J?=
 =?us-ascii?Q?tVtK8qM4yzkfmjV9H15Gs0zvqm7GXCH1l2isOYfMU66OPPTPx7ZqgPK4IX6F?=
 =?us-ascii?Q?Cv21vfLl9vPlcGpnA39YYhdnfmPQ98TpQ0Z8Y4/wL4SQORylgRQRpbTx9e/p?=
 =?us-ascii?Q?X9psMD9oHhf1idMfkV6MfA+w3FBxOrBnVTE+oVxx9UZ5T7Gb64NO+cciU49X?=
 =?us-ascii?Q?NdulmBsf+UtH0lkl/o3YZxUJamzOY4DXwioGGPSQ20YxZGRJhKHlnbNAC24y?=
 =?us-ascii?Q?u3nV+GZd2dcoV02T2pXdgeg2SMkJSCawkvI3+km/GuGftmodhd7sonDIzdpW?=
 =?us-ascii?Q?DQ0mWzLRnCa2ydbKYXX3TmnvEj9j/pv8BFm432sM/aT499b5P2f7eZLgRZ9X?=
 =?us-ascii?Q?2X6oAm4OIZTTWD1lRPTbd4z4w0LZ0Sv0bkNe861r+p+pQ1e11aQTZIt62ewM?=
 =?us-ascii?Q?opMJFw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed5232a-cbc3-4965-31ed-08d9dac851d1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:20:15.3426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkdSOMdn2HwjgxWPun1Izwwd/6Od9d9++KfeFAFS0XNOB6hnkqyzkFgo4QmUc41jKflAYEUih5zQ7x72e3W9pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1584
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180122
X-Proofpoint-GUID: 85KVOkd9Bk14rHi_-dnOzfjW2kI1mkV-
X-Proofpoint-ORIG-GUID: 85KVOkd9Bk14rHi_-dnOzfjW2kI1mkV-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a ram-based filesystem that contains the files created for each
shared address range. This patch adds just the filesystem and creation
of files. Page table entries for these shared ranges created by mshare
syscall are still not shared.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 Documentation/filesystems/msharefs.rst |  19 +++
 include/uapi/linux/magic.h             |   1 +
 mm/mshare.c                            | 191 +++++++++++++++++++++++--
 3 files changed, 197 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/filesystems/msharefs.rst

diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
new file mode 100644
index 000000000000..fd161f67045d
--- /dev/null
+++ b/Documentation/filesystems/msharefs.rst
@@ -0,0 +1,19 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================================
+msharefs - a filesystem to support shared page tables
+=====================================================
+
+msharefs is a ram-based filesystem that allows multiple processes to
+share page table entries for shared pages.
+
+msharefs is typically mounted like this::
+
+	mount -t msharefs none /sys/fs/mshare
+
+When a process calls mshare syscall with a name for the shared address
+range, a file with the same name is created under msharefs with that
+name. This file can be opened by another process, if permissions
+allow, to query the addresses shared under this range. These files are
+removed by mshare_unlink syscall and can not be deleted directly.
+Hence these files are created as immutable files.
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 35687dcb1a42..26a12e33a3c1 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -98,5 +98,6 @@
 #define Z3FOLD_MAGIC		0x33
 #define PPC_CMM_MAGIC		0xc7571590
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
+#define MSHARE_MAGIC		0x4d534852	/* "MSHR" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/mm/mshare.c b/mm/mshare.c
index c723f8369f06..e48d0f615f9f 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -10,20 +10,117 @@
  *		Khalid Aziz
  */
 
-#include <linux/anon_inodes.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/syscalls.h>
+#include <linux/uaccess.h>
+#include <linux/pseudo_fs.h>
+#include <linux/fileattr.h>
+#include <uapi/linux/magic.h>
+#include <uapi/linux/limits.h>
 
-static const struct file_operations mshare_fops = {
+static struct super_block *msharefs_sb;
+
+static const struct file_operations msharefs_file_operations = {
+	.open	= simple_open,
+	.llseek	= no_llseek,
 };
 
+static int
+msharefs_d_hash(const struct dentry *dentry, struct qstr *qstr)
+{
+	unsigned long hash = init_name_hash(dentry);
+	const unsigned char *s = qstr->name;
+	unsigned int len = qstr->len;
+
+	while (len--)
+		hash = partial_name_hash(*s++, hash);
+	qstr->hash = end_name_hash(hash);
+	return 0;
+}
+
+static struct dentry
+*msharefs_alloc_dentry(struct dentry *parent, const char *name)
+{
+	struct dentry *d;
+	struct qstr q;
+	int err;
+
+	q.name = name;
+	q.len = strlen(name);
+
+	err = msharefs_d_hash(parent, &q);
+	if (err)
+		return ERR_PTR(err);
+
+	d = d_alloc(parent, &q);
+	if (d)
+		return d;
+
+	return ERR_PTR(-ENOMEM);
+}
+
+static struct inode
+*msharefs_get_inode(struct super_block *sb, int mode)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_ino = get_next_ino();
+		inode->i_mode = mode;
+
+		/*
+		 * msharefs are not meant to be manipulated from userspace.
+		 * Reading from the file is the only allowed operation
+		 */
+		inode->i_flags = S_IMMUTABLE;
+
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_fop = &msharefs_file_operations;
+		inode->i_size = 0;
+		inode->i_uid = current_fsuid();
+		inode->i_gid = current_fsgid();
+	}
+
+	return inode;
+}
+
+static int
+mshare_file_create(const char *name, unsigned long flags)
+{
+	struct inode *inode;
+	struct dentry *root, *dentry;
+	int err = 0;
+
+	root = msharefs_sb->s_root;
+
+	inode = msharefs_get_inode(msharefs_sb, S_IFREG | 0400);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	dentry = msharefs_alloc_dentry(root, name);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto fail_inode;
+	}
+
+	d_add(dentry, inode);
+
+	return err;
+
+fail_inode:
+	iput(inode);
+	return err;
+}
+
 /*
- * mshare syscall. Returns a file descriptor
+ * mshare syscall
  */
-SYSCALL_DEFINE5(mshare, const char *, name, unsigned long, addr,
+SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		unsigned long, len, int, oflag, mode_t, mode)
 {
-	int fd;
+	char mshare_name[NAME_MAX];
+	int err;
 
 	/*
 	 * Address range being shared must be aligned to pgdir
@@ -32,15 +129,14 @@ SYSCALL_DEFINE5(mshare, const char *, name, unsigned long, addr,
 	if ((addr | len) & (PGDIR_SIZE - 1))
 		return -EINVAL;
 
-	/*
-	 * Allocate a file descriptor to return
-	 *
-	 * TODO: This code ignores the object name completely. Add
-	 * support for that
-	 */
-	fd = anon_inode_getfd("mshare", &mshare_fops, NULL, O_RDWR);
+	err = copy_from_user(mshare_name, name, NAME_MAX);
+	if (err)
+		goto err_out;
 
-	return fd;
+	err = mshare_file_create(mshare_name, oflag);
+
+err_out:
+	return err;
 }
 
 /*
@@ -48,7 +144,8 @@ SYSCALL_DEFINE5(mshare, const char *, name, unsigned long, addr,
  */
 SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 {
-	int fd;
+	char mshare_name[NAME_MAX];
+	int err;
 
 	/*
 	 * Delete the named object
@@ -56,5 +153,71 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 	 * TODO: Mark mshare'd range for deletion
 	 *
 	 */
+	err = copy_from_user(mshare_name, name, NAME_MAX);
+	if (err)
+		goto err_out;
+	return 0;
+
+err_out:
+	return err;
+}
+
+static const struct dentry_operations msharefs_d_ops = {
+	.d_hash = msharefs_d_hash,
+};
+
+static int
+msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	static const struct tree_descr empty_descr = {""};
+	int err;
+
+	sb->s_d_op = &msharefs_d_ops;
+	err = simple_fill_super(sb, MSHARE_MAGIC, &empty_descr);
+	if (err)
+		return err;
+
+	msharefs_sb = sb;
+	return 0;
+}
+
+static int
+msharefs_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, msharefs_fill_super);
+}
+
+static const struct fs_context_operations msharefs_context_ops = {
+	.get_tree	= msharefs_get_tree,
+};
+
+static int
+mshare_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &msharefs_context_ops;
 	return 0;
 }
+
+static struct file_system_type mshare_fs = {
+	.name			= "msharefs",
+	.init_fs_context	= mshare_init_fs_context,
+	.kill_sb		= kill_litter_super,
+};
+
+static int
+mshare_init(void)
+{
+	int ret = 0;
+
+	ret = sysfs_create_mount_point(fs_kobj, "mshare");
+	if (ret)
+		return ret;
+
+	ret = register_filesystem(&mshare_fs);
+	if (ret)
+		sysfs_remove_mount_point(fs_kobj, "mshare");
+
+	return ret;
+}
+
+fs_initcall(mshare_init);
-- 
2.32.0

