Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64254464FE5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350142AbhLAOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:38:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38078 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349986AbhLAOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:18 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EP5FY018239;
        Wed, 1 Dec 2021 14:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8DDbtQO++EMN3Eo4L8NGqx1HAYErsnGh5I7n6SyEnso=;
 b=BOwa/3J3fn6xc/euVE7MJSpVspBat7d4KaHQAazVySm55oemg/uaYOZ6h1QEFyuz4Dkv
 gGejB3bPCk6LxduHxJ39K+mHp4Nmqx81Fa++xT5XON6MzFmZRlmc9QTzNZLfyLAC5oSn
 RTIIgTZ0MiUD4CH2EnNSpm6rRBwru/yFZPqPUfciJv+1qiTSSwL45va7oYOVPdcIP+gU
 I5DHfNTxHdn76C3VWx9Ft01lPdI9NZnMrKGGxH6TKEG0cfAp6gXqbYibXrhK1AwlyPRf
 ouV0rwOmylCWI0hCTD6kaH5vEJ2QYKyxpfZjIcySYRs3OZC1t+EKMrrJOgnxUA2u4UNL rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyg10m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EAL5D032122;
        Wed, 1 Dec 2021 14:30:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3cke4rv42p-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSQsgU0kylpXX4MzG44ZtQliMBUQfkqW6xfvWWILgZJgFHBtuGzqLdc5Nm9SJRYG2MlOxiW6xZmbnuVqTZFhXhaxHooARZ1Rf3DyjmFJEKYNjVIwBFoOXD/WAkb1nfflkxCBT4iszxPPFfnH2ohu+Is/uwP8W01aOefvZofeD1+/QkP7CEDsXT1zxtJkmQMShjXV/6S/1WGCXfko1ibX6K3m2xs2+wPKyoa7jv9Mgp4xcPINsUQdNXTMNQox9q36/TRxQ0SgRIdsMNwi5kezaDb9LV0TgJaPdN2p/U4vpwmP1UkFVDnuuJj7IEG7iuYhAC9e/XBsJgGrfOqb0qKX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DDbtQO++EMN3Eo4L8NGqx1HAYErsnGh5I7n6SyEnso=;
 b=NQWqnXWDpC+37wy5W4+Jg4AGv96NpQdsy1aqjBwxlMpS/dehSCVhdoLAfHIZp+MwbkSbRzV9jGRUI0GbGcM7noUAx5+fAAs4QfLVhHwBq+Hbf3K39KBkWU/BY6iq/5CDjvTLNngyoKgPTkL/e07+LAL6QcZZoGKhb3VYOvf+g92wCpgaB+dm1RgG4T2WDLkEMbuCXKSwMF6pWe8dQBizoVJT3vPHBhgKLQCrL3Hy41Xx79hROjSimsJ+xgy0ChwnJzwyiznBpCxLyENFet0BIYjGZGu+4zTkbouaoONj+TMkS2dZQec32aqNBOlOS2+Piy8fSafg+0u+k0QGmNW2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DDbtQO++EMN3Eo4L8NGqx1HAYErsnGh5I7n6SyEnso=;
 b=vbYGE1JTuivKbj6OJNDN1bxuKVn5m/WMTHjD4zBA2LWRFy/ehRERf688Pf/rVb2iUXBM34eydh5obPhlmlRtm7FrIEsmd1ws9Y1PORaD2VfCzXca4lZ6KWq9zxmGXI9zbFtYHg1iD3Enrg5yn7ydHrQz6lGGjTNGm39ExX/j3LY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:30:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 24/66] mm: Remove vmacache
Thread-Topic: [PATCH v4 24/66] mm: Remove vmacache
Thread-Index: AQHX5r/tdeMDi3uDUUi/ohXADvZbiQ==
Date:   Wed, 1 Dec 2021 14:30:02 +0000
Message-ID: <20211201142918.921493-25-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d98f68b-66f6-4abb-0d5b-08d9b4d70fc5
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB3021C5BB288C18BC8C765FE5FD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mv6I5yWa2iXG7GgQ0KApKtwJV0X233W7QmI0ZqapVDlcQA57IUmALjO3L4PGXVPaGSdk65sp8xC/XlqTSTj6Q7N014ljkw87zEenVPXHiuc3+OvhR5WlbEJRG38ZSEkyfJBlhtwAXA+QLMhntD4gsAenRbVEZc2dJ9XSLljX+fwz2yXTL21CwH3f6rzfG2TCcttNPICfUglRx/3Q/CXGgC32IrvFgbpkRxKO6xXI4LjEsngWTCxLwP4GceD0c0+199SdGFx/BVn2nHNoS0H/ZGEAhU5gdOmlbeX9dA4YzDKIES6UQdX3h/lQ30narYnvXuhHRKmdqGFSdIltNLOg/hJLhknLEVnrFSs+xVlmifXFG4KR50AdVS0X+3SlYWLhDugMNqobkvAO8MbPKIdQpCO0X8bCxZNP8O87BiTuvYWntOVgQcWArab9pI/m+jFG4F1Xy+0HIDgl/tI6Ojxm1q9xHsxbNxxwWfoS7bjZCZp8akH4DIZZ99Xe8pzFimW8kKYZkrI0qnAcWW6oIo7VJi1bPWQ6baP5quwi/KAa99ZerItS4Nxd6RMB+85oxjKmXezT5p6NXpVd4lF7m/9L54BzeUSGzB8/xw99qJha/pE35gLgefcaIMOG8F5cKWC21HSkgl0XSOL2h5pPbCKtFUv9Z055rg7WupLwQzDDob4I20gXSpv4EpzUujAKkwWvQfMzv/F5//peVAW/xewSeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(36756003)(8676002)(110136005)(30864003)(26005)(1076003)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WWUGTOLQcBbQypEZYSoHttG8IOarGy8YhCkdABrLEFjgTteZnlUo0JSPZs?=
 =?iso-8859-1?Q?oDU4esXn8ezsOjkB8Hlju40y+10H2YPQoUXwPy3fLgoHtlvACL3xvoiF/0?=
 =?iso-8859-1?Q?vJsEJc02sYEFBKFXJBorYzNPctDhTyCmrT1JFHwTolAjDSfg6jokQe0ojb?=
 =?iso-8859-1?Q?KBDurLLrR75DWGCZbxP9B7LYJFo/FJKG9T3hDhFRW+HpyfxuefGExqEWjw?=
 =?iso-8859-1?Q?izeF/SuL1xMsSUY5kRtgGVQAYVRFNAbzsNY0bsNEhAkHvO9kLN7zX2vD+Y?=
 =?iso-8859-1?Q?CvLWhSHpTO4t5po5iGJCkEkVKqezak4+KGZ5QpuwGuOK90kV5mJbZNx8ai?=
 =?iso-8859-1?Q?mY49JVmsDI7A4Xk72+NAMwuuHEQ0jHaQWHDrNVDk4Y9ahPLb3JV08Ul+FW?=
 =?iso-8859-1?Q?Z3/GXWppu7pA2X5VC5s4ebeaYldOVJbuO8N3LpPwzgr8ADqahfO2i9ktVf?=
 =?iso-8859-1?Q?SyzfevnWoR68akYvIpzAbItYxg6aUmXsvP4YRl3OFzL+THC/X1ujhrM8fZ?=
 =?iso-8859-1?Q?IrPO7MxSCcLk43pExmTuNMaQ7gRJcenvEwQeDOUorqepIKA5qY+JDSb+HI?=
 =?iso-8859-1?Q?lnfw8VL6/00FnUFdS5LNR5pCvkTnPr3laNANxPzZhYffNyf6o/wyYw4MHt?=
 =?iso-8859-1?Q?SgKs+E4ORmRybYv3O/EiV9CobfapYuW7IV9yYKZ8iGZCL7jQLtYZcpDuhU?=
 =?iso-8859-1?Q?b9N+kPLFsDn7/i+ptJ7cAASzwhfxo+vWzoEXWpJtV2kXKpiaEM/pk+ka/U?=
 =?iso-8859-1?Q?QNlC2f5x6O/aWMX4rExYxhdR+/yEIA6h3SAW3U46VcglX8rw6aA+R9HbYS?=
 =?iso-8859-1?Q?nW0Liy/P/vbLNdPda73OXbNK1hREiUZqY7MbCndVP219kzIvwjAya2Aaug?=
 =?iso-8859-1?Q?5uLlF4eIEy8E+tOttEE/z6VP+W/S66Zmj0NwEIF8B2XHlpRoIwv6mk6UcR?=
 =?iso-8859-1?Q?YWwDCoXBfS/XcMBj5fabxjSlf1gHz5H9zgWtObplYxsMKz2lxxRmr/18WZ?=
 =?iso-8859-1?Q?VYgMst9/UO9KTaMgT1JRhCpRcHiol4EdVBG6cp/1xbcCUdvrX8JLGiGjXa?=
 =?iso-8859-1?Q?rSXQkRmgOiAJPx0cSknVJFBfNbPAn/WP8kx488+B0PJBwCWdi8tlw7SBOa?=
 =?iso-8859-1?Q?1bEND9nI/2F4HnBncIluRhqIlZqrLJL6HBliFdF5wXlnCaYd+lxFnNa4K1?=
 =?iso-8859-1?Q?aWdV1tU27ynN2KTViSs87Lz3ucO7I06NNQb4PK+Ir9RMRHlMuUUYteaN8F?=
 =?iso-8859-1?Q?PWw2iI+aiIctWvkRxpOnVQUCBPI1OhmQ66IxoK7WXerpuSczJzr61ucP7U?=
 =?iso-8859-1?Q?TSjBCDSlf66aZJSI/OwlU1tHmM3T3U8wNnN2U2dOx+Dyq4e6f1/LhhLSVl?=
 =?iso-8859-1?Q?UcYtTqIatouycVZt5suPa4lMKzNkZHz5hqZmueLtqF0OhOduLpLrq8tCHH?=
 =?iso-8859-1?Q?wTzUDHPVgjpzWMzET/j0jBTP56igeid0L8mtUbJxMyzl4b72geyX9aTeZb?=
 =?iso-8859-1?Q?Js9IrrgvzwkiYKER2MKIbcUWH5izv8cgOSUo44qent7W4Z3OzbhSt27kaX?=
 =?iso-8859-1?Q?Rv2y95Fcg/fbdN786SMw7vO+wIxvQIGq0SnIDrSl9cPARu5hSdx/nqHY5H?=
 =?iso-8859-1?Q?kk+gpzKCdOeO216JjxUWuqn3LvWkEWkPgIPLxKN6/G9bUF+NhdJAXyBOak?=
 =?iso-8859-1?Q?uKobnSVR3PTGFQ8srgA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d98f68b-66f6-4abb-0d5b-08d9b4d70fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:02.3597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CdZPXMYeYLnBf4xLiNZhiQZNCUKa6Ihyp8fgD6kc0ZZSlq+R2geTW9MHAVbxeIyWiIv/7dFCYeech6FZMMEoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-GUID: FZqkx0FmHKHl5o9RQggdx1vN8rGVc6iX
X-Proofpoint-ORIG-GUID: FZqkx0FmHKHl5o9RQggdx1vN8rGVc6iX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

By using the maple tree and the maple tree state, the vmacache is no
longer beneficial and is complicating the VMA code.  Remove the vmacache
to reduce the work in keeping it up to date and code complexity.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/s390/configs/debug_defconfig |   1 -
 fs/exec.c                         |   3 -
 fs/proc/task_mmu.c                |   1 -
 include/linux/mm_types.h          |   1 -
 include/linux/mm_types_task.h     |   5 --
 include/linux/sched.h             |   1 -
 include/linux/vm_event_item.h     |   4 -
 include/linux/vmacache.h          |  28 -------
 include/linux/vmstat.h            |   6 --
 kernel/debug/debug_core.c         |  12 ---
 kernel/fork.c                     |   5 --
 lib/Kconfig.debug                 |  10 ---
 mm/Makefile                       |   2 +-
 mm/debug.c                        |   4 +-
 mm/mmap.c                         |  21 +-----
 mm/nommu.c                        |  37 +---------
 mm/vmacache.c                     | 117 ------------------------------
 mm/vmstat.c                       |   4 -
 18 files changed, 8 insertions(+), 254 deletions(-)
 delete mode 100644 include/linux/vmacache.h
 delete mode 100644 mm/vmacache.c

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_de=
fconfig
index fd825097cf04..42b29b4ea9b6 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -801,7 +801,6 @@ CONFIG_SLUB_DEBUG_ON=3Dy
 CONFIG_SLUB_STATS=3Dy
 CONFIG_DEBUG_STACK_USAGE=3Dy
 CONFIG_DEBUG_VM=3Dy
-CONFIG_DEBUG_VM_VMACACHE=3Dy
 CONFIG_DEBUG_VM_PGFLAGS=3Dy
 CONFIG_DEBUG_MEMORY_INIT=3Dy
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=3Dm
diff --git a/fs/exec.c b/fs/exec.c
index 537d92c41105..fee18b63ed35 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -28,7 +28,6 @@
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/swap.h>
@@ -1017,8 +1016,6 @@ static int exec_mmap(struct mm_struct *mm)
 	activate_mm(active_mm, mm);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
-	tsk->mm->vmacache_seqnum =3D 0;
-	vmacache_flush(tsk);
 	task_unlock(tsk);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad667dbc96f5..300911d6575f 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pagewalk.h>
-#include <linux/vmacache.h>
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
 #include <linux/mount.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 04b055a80501..1ab6260fb164 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -456,7 +456,6 @@ struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
-		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
 				unsigned long addr, unsigned long len,
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index c1bc6731125c..33c9fa4d4f66 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -31,11 +31,6 @@
 #define VMACACHE_SIZE (1U << VMACACHE_BITS)
 #define VMACACHE_MASK (VMACACHE_SIZE - 1)
=20
-struct vmacache {
-	u64 seqnum;
-	struct vm_area_struct *vmas[VMACACHE_SIZE];
-};
-
 /*
  * When updating this, please also update struct resident_page_types[] in
  * kernel/fork.c
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..4d8640b03319 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -856,7 +856,6 @@ struct task_struct {
 	struct mm_struct		*active_mm;
=20
 	/* Per-thread vma caching: */
-	struct vmacache			vmacache;
=20
 #ifdef SPLIT_RSS_COUNTING
 	struct task_rss_stat		rss_stat;
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index a185cc75ff52..dd9e1e98bdec 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -119,10 +119,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NR_TLB_LOCAL_FLUSH_ALL,
 		NR_TLB_LOCAL_FLUSH_ONE,
 #endif /* CONFIG_DEBUG_TLBFLUSH */
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-		VMACACHE_FIND_CALLS,
-		VMACACHE_FIND_HITS,
-#endif
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
diff --git a/include/linux/vmacache.h b/include/linux/vmacache.h
deleted file mode 100644
index 6fce268a4588..000000000000
--- a/include/linux/vmacache.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_VMACACHE_H
-#define __LINUX_VMACACHE_H
-
-#include <linux/sched.h>
-#include <linux/mm.h>
-
-static inline void vmacache_flush(struct task_struct *tsk)
-{
-	memset(tsk->vmacache.vmas, 0, sizeof(tsk->vmacache.vmas));
-}
-
-extern void vmacache_update(unsigned long addr, struct vm_area_struct *new=
vma);
-extern struct vm_area_struct *vmacache_find(struct mm_struct *mm,
-						    unsigned long addr);
-
-#ifndef CONFIG_MMU
-extern struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-						  unsigned long start,
-						  unsigned long end);
-#endif
-
-static inline void vmacache_invalidate(struct mm_struct *mm)
-{
-	mm->vmacache_seqnum++;
-}
-
-#endif /* __LINUX_VMACACHE_H */
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index bfe38869498d..19cf5b6892ce 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -125,12 +125,6 @@ static inline void vm_events_fold_cpu(int cpu)
 #define count_vm_tlb_events(x, y) do { (void)(y); } while (0)
 #endif
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-#define count_vm_vmacache_event(x) count_vm_event(x)
-#else
-#define count_vm_vmacache_event(x) do {} while (0)
-#endif
-
 #define __count_zid_vm_events(item, zid, delta) \
 	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
=20
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index da06a5553835..c4e6f5159bed 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -50,7 +50,6 @@
 #include <linux/pid.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/rcupdate.h>
 #include <linux/irq.h>
=20
@@ -282,17 +281,6 @@ static void kgdb_flush_swbreak_addr(unsigned long addr=
)
 	if (!CACHE_FLUSH_IS_SAFE)
 		return;
=20
-	if (current->mm) {
-		int i;
-
-		for (i =3D 0; i < VMACACHE_SIZE; i++) {
-			if (!current->vmacache.vmas[i])
-				continue;
-			flush_cache_range(current->vmacache.vmas[i],
-					  addr, addr + BREAK_INSTR_SIZE);
-		}
-	}
-
 	/* Force flush instruction cache if it was outside the mm */
 	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index dcc58063f632..3493117c8d35 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -42,7 +42,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
@@ -1056,7 +1055,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
-	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	seqcount_init(&mm->write_protect_seq);
@@ -1512,9 +1510,6 @@ static int copy_mm(unsigned long clone_flags, struct =
task_struct *tsk)
 	if (!oldmm)
 		return 0;
=20
-	/* initialize the new vmacache entries */
-	vmacache_flush(tsk);
-
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm =3D oldmm;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 24c6469948d5..3fb0d617fce3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -802,16 +802,6 @@ config DEBUG_VM
=20
 	  If unsure, say N.
=20
-config DEBUG_VM_VMACACHE
-	bool "Debug VMA caching"
-	depends on DEBUG_VM
-	help
-	  Enable this to turn on VMA caching debug information. Doing so
-	  can cause significant overhead, so only enable it in non-production
-	  environments.
-
-	  If unsure, say N.
-
 config DEBUG_VM_RB
 	bool "Debug VM red-black trees"
 	depends on DEBUG_VM
diff --git a/mm/Makefile b/mm/Makefile
index d6c0042e3aa0..170056c0a7d1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -50,7 +50,7 @@ obj-y			:=3D filemap.o mempool.o oom_kill.o fadvise.o \
 			   readahead.o swap.o truncate.o vmscan.o shmem.o \
 			   util.o mmzone.o vmstat.o backing-dev.o \
 			   mm_init.o percpu.o slab_common.o \
-			   compaction.o vmacache.o \
+			   compaction.o \
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o mmap_lock.o $(mmu-y)
=20
diff --git a/mm/debug.c b/mm/debug.c
index a05a39ff8fe4..440a0614d14a 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
+	pr_emerg("mm %px mmap %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
@@ -235,7 +235,7 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, (long long) mm->vmacache_seqnum, mm->task_size,
+		mm, mm->mmap, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
diff --git a/mm/mmap.c b/mm/mmap.c
index b0b7e327bf8b..fddf38ca0589 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -655,9 +654,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		/* Remove from mm linked list - also updates highest_vm_end */
 		__vma_unlink_list(mm, next);
=20
-		/* Kill the cache */
-		vmacache_invalidate(mm);
-
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
=20
@@ -877,8 +873,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
=20
 	if (remove_next) {
 		__vma_unlink_list(mm, next);
-		/* Kill the cache */
-		vmacache_invalidate(mm);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
@@ -2142,19 +2136,10 @@ struct vm_area_struct *find_vma_intersection(struct=
 mm_struct *mm,
 					     unsigned long start_addr,
 					     unsigned long end_addr)
 {
-	struct vm_area_struct *vma;
 	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
=20
 	mmap_assert_locked(mm);
-	/* Check the cache first. */
-	vma =3D vmacache_find(mm, start_addr);
-	if (likely(vma))
-		return vma;
-
-	vma =3D mas_find(&mas, end_addr - 1);
-	if (vma)
-		vmacache_update(mas.index, vma);
-	return vma;
+	return mas_find(&mas, end_addr - 1);
 }
 EXPORT_SYMBOL(find_vma_intersection);
=20
@@ -2545,9 +2530,6 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct vm_area_struct *vma,
 		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
 	tail_vma->vm_next =3D NULL;
=20
-	/* Kill the cache */
-	vmacache_invalidate(mm);
-
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
@@ -2928,7 +2910,6 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
=20
-	vmacache_invalidate(vma->vm_mm);
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index c5ded0f92a52..11ae550834cd 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -19,7 +19,6 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
-#include <linux/vmacache.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/file.h>
@@ -583,23 +582,12 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
  */
 static void delete_vma_from_mm(struct vm_area_struct *vma)
 {
-	int i;
-	struct address_space *mapping;
-	struct mm_struct *mm =3D vma->vm_mm;
-	struct task_struct *curr =3D current;
 	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
=20
-	mm->map_count--;
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		/* if the vma is cached, invalidate the entire cache */
-		if (curr->vmacache.vmas[i] =3D=3D vma) {
-			vmacache_invalidate(mm);
-			break;
-		}
-	}
-
+	vma->vm_mm->map_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
+		struct address_space *mapping;
 		mapping =3D vma->vm_file->f_mapping;
=20
 		i_mmap_lock_write(mapping);
@@ -611,7 +599,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(mm, vma);
+	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
@@ -633,20 +621,9 @@ static void delete_vma(struct mm_struct *mm, struct vm=
_area_struct *vma)
  */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct vm_area_struct *vma;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find(mm, addr);
-	if (likely(vma))
-		return vma;
-
-	vma =3D mas_walk(&mas);
-
-	if (vma)
-		vmacache_update(addr, vma);
-
-	return vma;
+	return mas_walk(&mas);
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -680,11 +657,6 @@ static struct vm_area_struct *find_vma_exact(struct mm=
_struct *mm,
 	unsigned long end =3D addr + len;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find_exact(mm, addr, end);
-	if (vma)
-		return vma;
-
 	vma =3D mas_walk(&mas);
 	if (!vma)
 		return NULL;
@@ -693,7 +665,6 @@ static struct vm_area_struct *find_vma_exact(struct mm_=
struct *mm,
 	if (vma->vm_end !=3D end)
 		return NULL;
=20
-	vmacache_update(addr, vma);
 	return vma;
 }
=20
diff --git a/mm/vmacache.c b/mm/vmacache.c
deleted file mode 100644
index 01a6e6688ec1..000000000000
--- a/mm/vmacache.c
+++ /dev/null
@@ -1,117 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2014 Davidlohr Bueso.
- */
-#include <linux/sched/signal.h>
-#include <linux/sched/task.h>
-#include <linux/mm.h>
-#include <linux/vmacache.h>
-
-/*
- * Hash based on the pmd of addr if configured with MMU, which provides a =
good
- * hit rate for workloads with spatial locality.  Otherwise, use pages.
- */
-#ifdef CONFIG_MMU
-#define VMACACHE_SHIFT	PMD_SHIFT
-#else
-#define VMACACHE_SHIFT	PAGE_SHIFT
-#endif
-#define VMACACHE_HASH(addr) ((addr >> VMACACHE_SHIFT) & VMACACHE_MASK)
-
-/*
- * This task may be accessing a foreign mm via (for example)
- * get_user_pages()->find_vma().  The vmacache is task-local and this
- * task's vmacache pertains to a different mm (ie, its own).  There is
- * nothing we can do here.
- *
- * Also handle the case where a kernel thread has adopted this mm via
- * kthread_use_mm(). That kernel thread's vmacache is not applicable to th=
is mm.
- */
-static inline bool vmacache_valid_mm(struct mm_struct *mm)
-{
-	return current->mm =3D=3D mm && !(current->flags & PF_KTHREAD);
-}
-
-void vmacache_update(unsigned long addr, struct vm_area_struct *newvma)
-{
-	if (vmacache_valid_mm(newvma->vm_mm))
-		current->vmacache.vmas[VMACACHE_HASH(addr)] =3D newvma;
-}
-
-static bool vmacache_valid(struct mm_struct *mm)
-{
-	struct task_struct *curr;
-
-	if (!vmacache_valid_mm(mm))
-		return false;
-
-	curr =3D current;
-	if (mm->vmacache_seqnum !=3D curr->vmacache.seqnum) {
-		/*
-		 * First attempt will always be invalid, initialize
-		 * the new cache for this task here.
-		 */
-		curr->vmacache.seqnum =3D mm->vmacache_seqnum;
-		vmacache_flush(curr);
-		return false;
-	}
-	return true;
-}
-
-struct vm_area_struct *vmacache_find(struct mm_struct *mm, unsigned long a=
ddr)
-{
-	int idx =3D VMACACHE_HASH(addr);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma) {
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-			if (WARN_ON_ONCE(vma->vm_mm !=3D mm))
-				break;
-#endif
-			if (vma->vm_start <=3D addr && vma->vm_end > addr) {
-				count_vm_vmacache_event(VMACACHE_FIND_HITS);
-				return vma;
-			}
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-
-#ifndef CONFIG_MMU
-struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-					   unsigned long start,
-					   unsigned long end)
-{
-	int idx =3D VMACACHE_HASH(start);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma && vma->vm_start =3D=3D start && vma->vm_end =3D=3D end) {
-			count_vm_vmacache_event(VMACACHE_FIND_HITS);
-			return vma;
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-#endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d701c335628c..09045aa69f13 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1375,10 +1375,6 @@ const char * const vmstat_text[] =3D {
 	"nr_tlb_local_flush_one",
 #endif /* CONFIG_DEBUG_TLBFLUSH */
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-	"vmacache_find_calls",
-	"vmacache_find_hits",
-#endif
 #ifdef CONFIG_SWAP
 	"swap_ra",
 	"swap_ra_hit",
--=20
2.30.2
