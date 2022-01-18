Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C8B492FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349646AbiARVVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:21:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59102 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234934AbiARVUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:20:44 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IKEZlG013780;
        Tue, 18 Jan 2022 21:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=2GI/FyC9Fd+f3mWeDhzM6dyhQ/6gPBjtaUMfsTe/i04=;
 b=SjhpDC/uP72XkvfuesEeUHwYqG75tJd0s0jqlf2WSPaBXp/dwbmoUjeEyYH0Iti5yzuh
 h+kTh9Udeme5+t0AIM1jNtmwkx8lZbcaE+fc3YmJjmyKOLRPHvRLeFhKhwajJJieUzn2
 CRHurC4EUqMsZz0sPkgVt/ZEan7inDjqiHFOtyMCJdWO0ergOsfneUQ2PMzon/M9jS0L
 uqb/XyqDsTYWduZOA4VHLDS7GOA7+p/w1rUSXelXx0DGV31vG0hqjn5Ekj88hi11PfJo
 LaBS/eQQ00xgfaBpFIgOGpWfKu9Ynf2NpTItWlI0GkzBmvppwhnyIi+quBlpf74Tx/KQ rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52u7f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IKubiD030214;
        Tue, 18 Jan 2022 21:20:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 3dkp34uybd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VedLcVOom2iUF3p6n68PetB3WQsYLzNywmuGK6OtngKaOdvryy9it3U5RAK2cYPKlfbG/oITk/Zxau0/d5aA43vB4IEmHwq+AW8rqVw54SchzbzCMougzxpHElOem0LMjFj9ce5khlWrJXuvj2BaTeYeykatE9IE7TsHLvNjTFo1HFi/NJYYI/yx2TeNqlTRuACa/wmt+PRbrL4+bTTeo/qPGFr6pe2eNKEFDpW/EtE+fcbuEQ93dseVF1x9K9TmnIWIsJLbvx2fY7P9hC6RELT2M21LmIvXA/QXjJltsF0Bhi1frL0cFiBpltpJw/RxyopI3O7jB4+/RL9PHua87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GI/FyC9Fd+f3mWeDhzM6dyhQ/6gPBjtaUMfsTe/i04=;
 b=iVoTedZML3X5aIlIqJwoIs9vZvTlfKk2Vl2V3uOhjgXeVOvPQpEbFIvSTbDT6B4wFdef8ZTtqA95gCILUXFmGBc6lYq3y/UmLPMWglynoBBb+aCjua7wwkNYVSY6/6B5Lo0W1H320f4sYn7pyX+OVLS5Ajx9OoXHhp5TYYwTiFaEdcW/etLZVEMyFFrTQmfsPpA4B7jMjwT8vdWZMrK9qgn8/XbWR56SgUZbbhxXv5mgHndGe5G4aZtE5NmaS7o/2Ob5Ah2F/lVBLrCiZIji/NADYQ2Qb3tvtONtKIZwc/SWZwswWo+S21FyvOzm7Qp305/4hlqiVKfWoSSHfrnZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GI/FyC9Fd+f3mWeDhzM6dyhQ/6gPBjtaUMfsTe/i04=;
 b=ZjTCbkQfniRHDIp0JhrZIZ9IAZX9rzBijXGCOk+1nlUTIHIoScGWdb8Pj1qsdKouEwCmNVY4JDV/1YLzXzKVsCYA11COwagrffDPNLN4t0lpq1JHo440HDh4JdWv4GV4f/cy7uetAeb1IWqPZO+jN/RSE1JpQrXsHfNT8GP4bGo=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CH2PR10MB4374.namprd10.prod.outlook.com (2603:10b6:610:af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 21:20:12 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:20:12 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH 1/6] mm: Add new system calls mshare, mshare_unlink
Date:   Tue, 18 Jan 2022 14:19:13 -0700
Message-Id: <a2cc7473be38c4c4712970903e159da94140d4ec.1642526745.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: d9be30c6-2d4f-4fb2-ee63-08d9dac84fde
X-MS-TrafficTypeDiagnostic: CH2PR10MB4374:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB437455330E0F21FB7B6D5ADE86589@CH2PR10MB4374.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahT1t9IOV1iCjem24XL77SmmnDFnR0r6oEScTYcQ7xww7BQdOZDiHKBT9OWlzaScnSNREnLhIXaEVP5Pohmg2u5GYrZR6CLxcRtwi8F7/C6ynljL/7/X40P8uqqcbl4wlKAytrZoy4tlShYoNBztkQ0itlWndddO7o6tUDLM6F+n7/2sk8472INmTj0LFECBWE56e0CHFx64rDeFixHSrUb8h73pe65A/1kfNzmFpAcv6bWcidUfQBdmUdMvI3Mdm84AakZAD7Jrac6ldR6qDau6Q4CJlfndgaezBrdrqk6xC9xLHExOsrUoMKKuQA9BluObWvacpCgkPkF3fR1FZ1DptxGe7MUs3R5u+gViSTO13h8cZPTmYEYut88jK6RJcEI00aXlZ0tOeMmt80FGdBP8Isgo19G0W4RZYmyBS2VM0tT5lhR1OazDX1N+iGHQtYGFhx4CMEwPt/3DY1HXxEtEJ+ZHWq0lL9a/soLCRXAVNSnYp7SfOKCWf+4TTjyHIdWyE+aLzYDtW+YF4y5/K8xSB96anINQP249sV25shqf2KQocLGKh5FPG7x9wlOf6NRU3pB95X0T5+nYMScTpuNP6YFJA61dqN4cv563fBhN/Uhvbk8j5cYYr5HF0lKuqJGeCMCimN0GhTbCel5zastixdRdiwQ8C7k/Hpjph2DUiTqaVveMgol2k5+dzzBZm1o96Ej9eLFiEdI+KLvW1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(86362001)(8676002)(2616005)(508600001)(52116002)(4326008)(66476007)(6512007)(5660300002)(7416002)(38100700002)(83380400001)(2906002)(6486002)(6506007)(8936002)(186003)(107886003)(921005)(36756003)(316002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eOooo4CcR0e5iYC5EmV2iI0khYIERKIKg/W5h5FH0yqgDe8gIUvqJHP5hRfG?=
 =?us-ascii?Q?BJ3qFyIfKHqF85cj/x6V3nE+jyk5/sTBY/7Uygr+SVvMg2bcWecboHG1lUUP?=
 =?us-ascii?Q?hzozdyBTNPtrojfGz8dTuJ7stoz9GTL4splbFcEZjQGjjP0bqRVKY7mJUU7o?=
 =?us-ascii?Q?eZ6yaeIbhYcwvmCWN989OF7fO7GANQcLIseYBLYVG0znFKqR4xPRoONrwvzb?=
 =?us-ascii?Q?mNWYopa2Khlhjf9y6OknAzALnEmyT5bujXks9HI4D6XyxD5D5eXZKimGCAQU?=
 =?us-ascii?Q?hVcMCnqwP060oKNExlho/5MVbzuLALlS1KjbXMz639XqFKHH0eLQBb2kwbKi?=
 =?us-ascii?Q?AliSIe3b3HbQ4tBkIJAP6CLmRVPySx9hrLYlJ7INjVBttunJsPI0zW3NblQs?=
 =?us-ascii?Q?TAWqzVJpXztvNq5oCAdh1xFRcjO6MNt2eW/LNzGBH70FDHDuRnL247QAJaPA?=
 =?us-ascii?Q?GjNbq+eYfZY27841rblFobOdsn8n2iRHkn8U3b7jkdsCu8Z85UmofEL2iwC9?=
 =?us-ascii?Q?YOF7VHTIDCLLVLVRwDO1D7I+v0KX3yQ9dtEkDKvGr4MAyEYO9R48JDGgUt6Y?=
 =?us-ascii?Q?kNcXjEYwiXWFHYbE/cC3kJ3JqYh3qO8TfNQyb63lh9oihPUXY2G3mfvTULb1?=
 =?us-ascii?Q?Y6WhNdhq26hWHPEblNmIc0qN0Shi1eLj1Vm/E1gx2OIftmUxCgvt3KhE50+2?=
 =?us-ascii?Q?lYNgHSsIhwALwKeVzmuxz0X+bdB4gRXxpXAV9JDkjnq7kMGUVtJ8c6ARzppR?=
 =?us-ascii?Q?dFu914Q9n59CGt1ZuK0wEKW+tQYxQ4qL8sMDxXmhLgSFLpfPtWEY4I/WnR1h?=
 =?us-ascii?Q?R3R4A97HB/pRqODZ9ogg00uvn59wjH23bQffF3k4lJfT+6V7B2YT7ASUdTeC?=
 =?us-ascii?Q?Zd0GvPOtCAuhA6CDR/vbUdjQ5ty4zuXt9yh48fdDSq2QEiOxZ4jK5v9fcjCf?=
 =?us-ascii?Q?necPo5k23IvX0Pm5NGKyJJkc5GIN4Pi3DnnFhWiiK1F6cdVpt+oZ7JNSj75K?=
 =?us-ascii?Q?zmlJ7PdRUqwHjW0z5AmDzkn5PC3ItoEYh3f7y2i51IjEbUn3D4HHcSzAKbFt?=
 =?us-ascii?Q?QsSyYaLl8hiC5b0fH4hrS9eVG+46uBI5CrupDVfoJQu49co6wYTNoiUWl0tV?=
 =?us-ascii?Q?PVRFALRGV6uqZYBPXbeIA/6+1n6m87y5gFF1VZqlDbgAHSDRyXj76qViR9rv?=
 =?us-ascii?Q?yrbNgP0JSbNO8E2s84tjpxy3Fb91iwAzuluhrTZhbonOBahI9GrVfDgjEaKN?=
 =?us-ascii?Q?BJ6qoCoTAba7iXIWO6Mzt/pjdbMobd0Hi/8GY/vLSfKspNE2blCNZisPfmN5?=
 =?us-ascii?Q?i5pOeEEBIkD/LmEoZcwbioVf35wasGMVUtES8HUm2RvaZZJ3UFgNHlA99J8q?=
 =?us-ascii?Q?X4uk12LPin0mTehbA4IQebQnA50WjrWndcQkEW2a9SMP4YLZAns6+LPBCH0M?=
 =?us-ascii?Q?EpbBlFKE+Z9JeVvZU0tmDyEYYTFFMSL62QIKiwIp8SYYY3LZBjUkOkACMJj7?=
 =?us-ascii?Q?hBs8drJyOuknQ2FW4ewzTpWBIm/C7uSGbXjJwnW8+GlJkjwQu1dY9HmehQnN?=
 =?us-ascii?Q?iiW3No6RTybscnrgIiUOBBX1kXbyEdi2sw/o9V5CsG0ys7GH1xhS0JTRomz2?=
 =?us-ascii?Q?RP0y2gy/zJZlw1q1OLJu1FoN193mTvz+244na23gY2kSvpIO3txwS69I/D6u?=
 =?us-ascii?Q?OpviuQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9be30c6-2d4f-4fb2-ee63-08d9dac84fde
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:20:12.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64HI8jpr00PcTa1sByLpjYhij8abPzUBSopdLOdS17yY66+5C6SCEQDX1HLzra/7qjezRj5RARENDrcwUFBOZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4374
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180121
X-Proofpoint-GUID: 9JI_DYADL2dZieeENYlWOc3YNv6E9ewe
X-Proofpoint-ORIG-GUID: 9JI_DYADL2dZieeENYlWOc3YNv6E9ewe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new system calls to support PTE sharing across processes through
explicit declarations of shared address space.There is almost no
implementation in this patch and it only wires up the system calls for
x86_64 only. mshare() returns a file descriptor which does not support
any operations yet.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  2 +
 include/uapi/asm-generic/unistd.h      |  7 ++-
 mm/Makefile                            |  2 +-
 mm/mshare.c                            | 60 ++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 mm/mshare.c

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index fe8f8dd157b4..bb403deca1ff 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -371,6 +371,8 @@
 447	common	memfd_secret		sys_memfd_secret
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
+450	common	mshare			sys_mshare
+451	common	mshare_unlink		sys_mshare_unlink
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 4557a8b6086f..27349ad579ff 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -883,8 +883,13 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 #define __NR_futex_waitv 449
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 
+#define __NR_mshare 450
+__SYSCALL(__NR_mshare, sys_mshare)
+#define __NR_mshare_unlink 451
+__SYSCALL(__NR_mshare_unlink, sys_mshare_unlink)
+
 #undef __NR_syscalls
-#define __NR_syscalls 450
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/mm/Makefile b/mm/Makefile
index d6c0042e3aa0..fca44c0d5e74 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -35,7 +35,7 @@ CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
 CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)
 
 mmu-y			:= nommu.o
-mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
+mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o mshare.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
 			   pgtable-generic.o rmap.o vmalloc.o
diff --git a/mm/mshare.c b/mm/mshare.c
new file mode 100644
index 000000000000..c723f8369f06
--- /dev/null
+++ b/mm/mshare.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * mm/mshare.c
+ *
+ * Page table sharing code
+ *
+ *
+ * Copyright (C) 2021 Oracle Corp. All rights reserved.
+ * Authors:	Matthew Wilcox
+ *		Khalid Aziz
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/fs.h>
+#include <linux/syscalls.h>
+
+static const struct file_operations mshare_fops = {
+};
+
+/*
+ * mshare syscall. Returns a file descriptor
+ */
+SYSCALL_DEFINE5(mshare, const char *, name, unsigned long, addr,
+		unsigned long, len, int, oflag, mode_t, mode)
+{
+	int fd;
+
+	/*
+	 * Address range being shared must be aligned to pgdir
+	 * boundary and its size must be a multiple of pgdir size
+	 */
+	if ((addr | len) & (PGDIR_SIZE - 1))
+		return -EINVAL;
+
+	/*
+	 * Allocate a file descriptor to return
+	 *
+	 * TODO: This code ignores the object name completely. Add
+	 * support for that
+	 */
+	fd = anon_inode_getfd("mshare", &mshare_fops, NULL, O_RDWR);
+
+	return fd;
+}
+
+/*
+ * mshare_unlink syscall. Close and remove the named mshare'd object
+ */
+SYSCALL_DEFINE1(mshare_unlink, const char *, name)
+{
+	int fd;
+
+	/*
+	 * Delete the named object
+	 *
+	 * TODO: Mark mshare'd range for deletion
+	 *
+	 */
+	return 0;
+}
-- 
2.32.0

