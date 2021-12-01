Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B51464FC4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350205AbhLAOf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:35:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40930 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238220AbhLAOev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:51 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E7UVR017207;
        Wed, 1 Dec 2021 14:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=39MibPW8pGb2E32dyEQ4L5oG3v0QQsMU3wPwzPRfhoI=;
 b=xIy+Jr4gWcevffMaCfdGc0LtyrLF6MwHFQpoucff7jFyubc2zWRCRK716+Tk6U2k0MnH
 4Dktb1O9Dh3LnduMoHq+xaqEJ15bLhYq4nYq38Ek9YP9H5tbtQs5RLiHVpi2pULRuVO6
 RiMRBaVibRW7V91U/x7PpAQmofyUBkJFr8/JV9a/3jBn9XjkrEx+nEHkuIQwusdAxrHW
 zDJHVBHZOqLzzH6FFVW04OGLRjmoXvoc7VaKjBzUvIKxF8uDamIzjR3IDa+B+1l97+wT
 GFlT4Qwp0aP0vsY+EK4ZSRHoQGWQAoli0WU5/kNC6O9aD3xuTmgCWQ8M8pl4gDQgCqj8 vQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7weh2q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBomF037582;
        Wed, 1 Dec 2021 14:29:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3ck9t1v56q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRJdLCQJTDyWtdK8MsclzIh9cEy/N1almikKFwNW6WNdfU2v5clvSfhCk/Z0g3L0n+eupL8V2/PQ5N3nL3XXh5I58VAK1fR5SI9YNZ1gQGjFSb0XWN0+WNV0DUf1Gs1DoShtPc9lN9BSVKLV9uX9Z2a3DNAVIys+Zlpt+UysNhk3zXq3wrJ5YzUN/ubfq9vmSrGyi+3BsnyoykEvgkqbfc+7ekvg+jnYYcS+9QOHIUCi3aaeTDliX9cNpkr8hUP6Q0UVoUtkrsmnVnHpRd0YHw/1azqjCl3wOEBTJBp/Sy6PzBDTg0risWM9BWe1jZC1/rZPDOeBCZfM/ddZxYicmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39MibPW8pGb2E32dyEQ4L5oG3v0QQsMU3wPwzPRfhoI=;
 b=oLdsMpyrKac+LndkNYlaNlP/ppzXpE4GoTLZXKdyLa2N3Py5x8IgAcc6CzSRwgoABK7xNMJNSrMnVBLiIsuH7QrG2nsPlcuJ9YqhLapapq3kZobAhsYk7FmJu1fxokssnzTKtRhZBkRCaJh20slNUsNSK3jVpDSq6SOaDa/kfninHpXmE0XeY06AiGQdxETErQu7lLc+O954473jYQVZ3heevE2mbszY/hwOFYQD2adpfV0+r0uRy6pC54HUchHedNC8KQDOFoQ7nOc+/T8fWrzoPxiKc+V7LuApHPUckbtfs3gaN+YXFLO9zZSpvj2UQ5ISfK8ktwgB9ckGc2H0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39MibPW8pGb2E32dyEQ4L5oG3v0QQsMU3wPwzPRfhoI=;
 b=ifdcDItDBRbuHpPhtufFPcNXHf8xHcXu/ZSgsHLX+zuKH3yJlNruF1gCx055hnXTGDVcFQcjIYbncTV4M9Qx8vLMGzFtKCjfU5xA2/cwZ1ttfsVJ/Toak9LnkIlP09o4vL+xcvoTWRaaHlrFAa3c5w9oWOqV9wKiY7zMKlgBX1Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:54 +0000
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
Subject: [PATCH v4 12/66] kernel/fork: Use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v4 12/66] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Index: AQHX5r/o3KEVgjJQgEmOR6p6STPGPA==
Date:   Wed, 1 Dec 2021 14:29:54 +0000
Message-ID: <20211201142918.921493-13-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d9d57a7-6dd0-437d-a327-08d9b4d70ac6
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB2768FBD99CEB13BEBB611C0DFD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yePXCGiTJNYpnt5SOO9b1qu6fpD/VlJzzXgQ/0hV11Vj9nLWMgGb5maxgvib6eh33InCpIlv3icPJ0JHk/JUiEd+X0BBKKMf5/Zswob30BCv1Nq+jsGKfcMeO+4mXB4DbF7YzOO67YO/5/ZlYJNwqOXYNoD27bUT9sXcGbBjxuKoqiagHINsokpc1Y1rtbi5a5QAs1q7ZhTRqsQkaZ/rFmk9v2Ih+EQyZkl6I1o2VVsUep98NOLFZfxH5Y9euN/zptXcGZVvLhjsSjCdwvJhBBl3jR8qDONLs+/lr6n/E8AGOJwypdm7ynNwCG661ShDLcq/X//pjo5sXG8E7arBiiX6EJgsQxljc1MERBgCjgNPCk9dOHf6JZGgNGlB8eFLxZ50ulXMOsoD55VVu4ngziLnGdTRx7xrW1tC3ntRv0lxUGjyL06x56Apq2u8xaTduCCz8VyLNjXiuPNTMbY/Xc9i5Upz/+YNZPL/IPKJNHhzmtuzRuPrgJ5E5I4e+tkz41zhG/3P8rIKHqL6pgOR/fxocUhjbKQe5sVYttsvt8u1kGy8h8vzrSfWl9gmVjTQKEWuydEAVEZp5YEZSQnL84S5S1TeFkWbJXlGBwdXph4+hNtTNAWdODr/PTav73KOn/oRA9q2sGlvSJhuAmTOU17jWf225rBw7YriTIk7KYecxjtXyLqwaURw8EbF39jB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f/n+dP+4NhP2nqSG2nid6Foxh7PShrqIAPxfeKXav2lwNYgH79Jeo5oLs5?=
 =?iso-8859-1?Q?cOM7NlhzOtCUifkjvtmcFXFw0j58Gck8AmOV+DPsS6Tv+5Zw8vDD3KOOG6?=
 =?iso-8859-1?Q?mteT/21SWtMN9Jj4zCAWdCDccI9ZS5ppDpQk2opkUGyyIC2Npm4+eD/WWZ?=
 =?iso-8859-1?Q?CNNwTPWck+jBeaVFbs24UrC0x9f0X6vjqLjcCB/QEEOuumV0zzFTWtY+MP?=
 =?iso-8859-1?Q?FS3ORpXsUd+EL6eKjRufkMzlzsnXkCuwlw2HFk9gRkDMONapR21QXsXE90?=
 =?iso-8859-1?Q?uxpQlf/pbQau6u1ETUfuEz5pNEww9iHWGMm394p32GYGM43Q2BVw3LB4+T?=
 =?iso-8859-1?Q?zX8w5eo9k1RXhw5naNsndZzckXInURbiKDdgE57VJnQadqh5CcnnYAujGa?=
 =?iso-8859-1?Q?DxK6W36HQKpgc55Gjdh7/x1VVQ4YVrtMaNdSK0+04oHuRj22A57tGWQKE0?=
 =?iso-8859-1?Q?U/cznPJVhMuyGt+tXmN0iSQp/poo1RDUNSQCWkzn0FdWQb5VINwGZ3YnTI?=
 =?iso-8859-1?Q?ZLFnXdHNi2uKIr/Q6H1pYs36l24Tbbh1ZR2Tcv+VK/uFoOWoGqoynf5rUt?=
 =?iso-8859-1?Q?o41yQJojrQAttHTIXv7J0beo6VBN6U/tAs+Upp6u+dca3M6aFewLliesL9?=
 =?iso-8859-1?Q?sDiwqrDTpe03ZFUb9KcyTve7o/8S1CwqPqsfdG0EGfc+u892fmLdTA1pwG?=
 =?iso-8859-1?Q?j42KxAVTiRWBsG4wdQQ6PqDR0RiwF5naUx5kiejmh7JD+voQRE+9/9SnAk?=
 =?iso-8859-1?Q?1sC70D9PP0AEC31+IxUfqvuVnFQDNCR1hOuoy5a55x49LWOq98fyRdwleW?=
 =?iso-8859-1?Q?zsJ8PuCkTlGolTYmMmD2KsXQ4bwrd6byCZfhkByEMTV3znFUOOY+fVN/8A?=
 =?iso-8859-1?Q?u5ycERaVgZGfwvdyLUptk3CwfctUQSWjjlLqJzZ4vktUNinMBL9dAeuiEF?=
 =?iso-8859-1?Q?cMsnnypi/HgQubVaF0Vw5AYEg3qMzbAXxS4aCBWOIMx/fUZ0tjtYq3o5s0?=
 =?iso-8859-1?Q?nMOj78UFu7tzOcoSf+vOlaw592V/UmEo2tiDmMEp9QWg1Gl31ODYRZhlfv?=
 =?iso-8859-1?Q?ylxYU7eHG/bLAL0cjZGDk/sxJASmR62RlFQ4U1VA0pOhVhHJmpdQNbog41?=
 =?iso-8859-1?Q?qyl58KwTFM8hkJMH2NydEh7UWwlnwhLO0KC5z5lNl6EZws7M5E0ZNQOvGW?=
 =?iso-8859-1?Q?fXyyHvSQt8ImL8ef3O64ikXDtEBbrblhd5nWO4rVOYj14Wh2hQjiW+oI/1?=
 =?iso-8859-1?Q?d8avt3U0TzetQYPt5HwKV2PHURqBkq6rVjm6J9NKmK9eSv0Rfh5MILWl74?=
 =?iso-8859-1?Q?g54sNYerdlIgsixLHXeUocSx/9WR0T04kj4wQkI9FCQWc8+U+kR+hK4Cgo?=
 =?iso-8859-1?Q?+Q4FLggy7ewRoOni+l/6FdKWUTgDljpg6EKW3LIAG6Jo7t7dgQK4EnX0T3?=
 =?iso-8859-1?Q?94d8/kDXMpCq37t6R8k3to5iUQNInqD3JYBi2sgwK3QotlrDHsDOoklYOU?=
 =?iso-8859-1?Q?lFAkJCG6f9dRVzg7cJiHX9JMLJCChELpHwa4BKWtnxTgzitCUR61Tc3lIL?=
 =?iso-8859-1?Q?+hY3uthfHYOSRE6yO7ZAUHSwkiDMKi3nbSTERmvsazlKOOrbASSclV3zex?=
 =?iso-8859-1?Q?wVG2KnXj+gyk++HDQkFEwsUU+qIv/lmH7RAoAJBPaVZxk1+wlItwUUktFi?=
 =?iso-8859-1?Q?2Zi+nvA2mnNK8xLBhCU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9d57a7-6dd0-437d-a327-08d9b4d70ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:54.0304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MC4ArV9bmtmeIH3uAmGf9IeY+nV3i5nHaNm2uL+CKYGipAYOKAyy5SzB7xnOelGK4XNW6mLQNmAwXsU8SN8l/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: VZIuAg6-UqM23T_FSI9dY8wQTMtwqQnQ
X-Proofpoint-GUID: VZIuAg6-UqM23T_FSI9dY8wQTMtwqQnQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator and switch to
the maple tree advanced API to avoid multiple walks of the tree during
insert operations.  Unexport the now-unused vma_store() function.

We track whether we need to free the VMAs and tree nodes through RCU
(ie whether there have been multiple threads that can see the mm_struct
simultaneously; by pthread(), ptrace() or looking at /proc/$pid/maps).
This setting is sticky because it's too tricky to decide when it's safe
to exit RCU mode.

For performance reasons we bulk allocate the maple tree nodes.  The node
calculations are done internally to the tree and use the VMA count and
assume the worst-case node requirements.  The VM_DONT_COPY flag does
not allow for the most efficient copy method of the tree and so a bulk
loading algorithm is used.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h       |  2 --
 include/linux/sched/mm.h | 13 +++++++++++++
 kernel/fork.c            | 35 +++++++++++++++++++++++++++++------
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index acdccbe9b96b..4d5ab70b1f6d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2637,8 +2637,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* maple_tree */
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index aca874d33fe6..74de6b3f6c8c 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
+#include <linux/maple_tree.h>
=20
 /*
  * Routines for handling mm_structs
@@ -78,6 +79,8 @@ static inline void mmdrop_sched(struct mm_struct *mm)
 }
 #endif
=20
+void mm_set_in_rcu(struct mm_struct *mm);
+
 /**
  * mmget() - Pin the address space associated with a &struct mm_struct.
  * @mm: The address space to pin.
@@ -96,11 +99,21 @@ static inline void mmdrop_sched(struct mm_struct *mm)
  */
 static inline void mmget(struct mm_struct *mm)
 {
+	if (!mt_in_rcu(&mm->mm_mt))
+		mm_set_in_rcu(mm);
 	atomic_inc(&mm->mm_users);
 }
=20
 static inline bool mmget_not_zero(struct mm_struct *mm)
 {
+	/*
+	 * There is a race below during task tear down that can cause the maple
+	 * tree to enter rcu mode with only a single user.  If this race
+	 * happens, the result would be that the maple tree nodes would remain
+	 * active for an extra RCU read cycle.
+	 */
+	if (!mt_in_rcu(&mm->mm_mt))
+		mm_set_in_rcu(mm);
 	return atomic_inc_not_zero(&mm->mm_users);
 }
=20
diff --git a/kernel/fork.c b/kernel/fork.c
index cc9bb95c7678..c9f8465d8ae2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -374,6 +374,16 @@ void vm_area_free(struct vm_area_struct *vma)
 	kmem_cache_free(vm_area_cachep, vma);
 }
=20
+void mm_set_in_rcu(struct mm_struct *mm)
+{
+	if (!mt_in_rcu(&mm->mm_mt))
+		return;
+	mmap_write_lock(mm);
+	mm->mm_mt.ma_flags |=3D MT_FLAGS_USE_RCU;
+	mmap_write_unlock(mm);
+}
+EXPORT_SYMBOL(mm_set_in_rcu);
+
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	void *stack =3D task_stack_page(tsk);
@@ -491,7 +501,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
+	unsigned long charge =3D 0;
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	LIST_HEAD(uf);
=20
 	uprobe_start_dup_mmap();
@@ -525,7 +537,12 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_entry_count(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -539,7 +556,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval =3D -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len =3D vma_pages(mpnt);
@@ -605,7 +622,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		rb_parent =3D &tmp->vm_rb;
=20
 		/* Link the vma into the MT */
-		vma_store(mm, tmp);
+		mas.index =3D tmp->vm_start;
+		mas.last =3D tmp->vm_end - 1;
+		mas_store(&mas, tmp);
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -615,10 +634,13 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto out;
+			goto loop_out;
+
 	}
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
+loop_out:
+	mas_destroy(&mas);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -634,7 +656,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_nomem:
 	retval =3D -ENOMEM;
 	vm_unacct_memory(charge);
-	goto out;
+	goto loop_out;
 }
=20
 static inline int mm_alloc_pgd(struct mm_struct *mm)
@@ -1111,6 +1133,7 @@ static inline void __mmput(struct mm_struct *mm)
 {
 	VM_BUG_ON(atomic_read(&mm->mm_users));
=20
+	mt_clear_in_rcu(&mm->mm_mt);
 	uprobe_clear_state(mm);
 	exit_aio(mm);
 	ksm_exit(mm);
--=20
2.30.2
