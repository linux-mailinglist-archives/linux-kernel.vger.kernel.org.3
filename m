Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B42B464FDF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350464AbhLAOiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:38:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7370 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350004AbhLAOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:05 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E16mU002526;
        Wed, 1 Dec 2021 14:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6QTR1jVN435rYxXfjTcgMJp0gGYuhQduOGVLUlkB0Ps=;
 b=04CG+i+RVklnBU2H6LCT/Dv3D3F2bb3Zrin0gqx1yiz4e8IFA2TrxQXDJ3pL4MMSH4eO
 f1jVRhh0Km+JPsgeHwtFFJLo91FL1Dg2+NlVgQ0IUYtjWW6KGSAPgpf64xvG4wYPpvk/
 qKoiGArQlcnHW30fZfEw9tS0jJhi4Cg2n4P1aX5yDd8SgAqTkhxtPGTSBOT8BN/cHb1/
 G0PW8cfbrdFdPhInClZNV28fEs3UWPzKj/6iGBBPbExJ0RMQJqRNdY2qvAfMRzuXRMZX
 T663/mZfgLQdJhW9pq4uzdZTfoGcuJWjWajwavU0mf0dwuK3Pj9cym3EKHhFXM/yZGqz SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EAL5H032122;
        Wed, 1 Dec 2021 14:30:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3cke4rv42p-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l++nXXlqsR0Mwz5G8qe2A05tXL2nrm/W9W2vBWNEqSqfmq7aAPoWAJODfjbrecoNW5y0yNOZUyNbFJJ0wzQThHh0Dzhb2ezgwOCDIEilwhBtG+a2ne1a3kcehOUP0asOFDleaKq5mtioB8UCiZIF08sJtzjlWm1ulmGoUpYfCp9xRYBlxqiLxljmpSmrTnHdzxm9MJsJf29E8KAUzj3ah0iJ9g79ACgTClaglPtapoCEtjXCz6LypyBZJ4LT0WDnEYLY5k4fSVu8giyRgIgf8v/tigkZOtVrLBj/lYNqM3ofHDdMZyWO8e6b9UWeZfNmwIcxHPkHd4BdyB/HOglTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QTR1jVN435rYxXfjTcgMJp0gGYuhQduOGVLUlkB0Ps=;
 b=YAD2IUhhauhrIofzFs5j7LCN5/bYQ29SFIb6WeUrHbqT7gdFGts8MAvJFHwieH4Xm+C/AazyEF8y9ILHkpES9qfvK9+3d+xMQ/Aiya8L3CTGuDVUHaeiI184FAUnho7oGoGejPLugLkKA/XKrUH/YAWmimRs8CgyL3b0y1Bt145xZnBvpbr8kJ2UYDBsNJlEX6Pxqw0BARFqAE6098KQkJVMJhKjv+JhmBWaP0Yu+ANCDA++JrZ7ukKF25jwdVACc8BbIMmWpY5OoTpK94oKtDS/TIEVOKmsr2StJNjJc87bY8DiP6prVBjpcZudDvQhBXy/xCEEi7tZSLaT2XD4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QTR1jVN435rYxXfjTcgMJp0gGYuhQduOGVLUlkB0Ps=;
 b=gzjDc/ZmO/ffWJm4lwMa+EuorwRj6typCYpEfoEKRUiuoPl2vJ/HuOazrE9qXQZwl/kCsMNsbcYNwCWV+rZXeRJYJw7iO4mR2LgadLhVIwY9W/m0U1U1aRIr1Q6fxpSFaCR3+Kd/DXez8tg+OaUZsxxPACa8ppBW/+XTciLXvao=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:30:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:03 +0000
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
Subject: [PATCH v4 26/66] mm/mmap: Reorganize munmap to use maple states
Thread-Topic: [PATCH v4 26/66] mm/mmap: Reorganize munmap to use maple states
Thread-Index: AQHX5r/tjgB33/Z9lUan012gbRJWWw==
Date:   Wed, 1 Dec 2021 14:30:03 +0000
Message-ID: <20211201142918.921493-27-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0969818-097e-4a0b-ad8d-08d9b4d71046
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB3021F9D764A8B3039559D3E1FD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:169;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CsusW9P34Gglil0r16DcMMp+qyps1h3j94TOSHaG1WY913SL3O1L428k9S8RIDdFFlsr4DtrvkhJyxbZpXIgOQ7UrT/FBuRdhveD5x9dxI8rG4Qcau0xdNbpEwzPXoi+4S7xoZJAOr/Nk2KIbQ94U3nbseij+eEDnaNQ3jqbET3vVXdg5fIpM/v+9GjbqQ5KhB6T030vBjz6XRVrQCizmqRTem/Fb+8fDWLOKs7BYWTr6LsdDO8imDejdVoKjB0+/u0oVImmPnkoEdktJyb+v31G5FvbzQbm4hauNUQqeV4u8U6ml4w5iZ7L9EmxLoCGTZCS0YOuQys1NHdG5Xvvr1x2wjxScosnSlYiYoQU3xWpVxnfUwmur95ABNh1ZsyQBvNVnv0aXmqCdxA/eKphHKl21tIdjjQQ0Q1CtA6M45UPDFM7VRcKsfldAi7ihiFWPcX+tVSaIjUXD0n1Uj2vPJauQwm6Ge9nMAZojR+XhYQcTH/IcnBKEs/rR0bySfKV08AeoBcFxeN5uI9Udos+w20fBwsopXn3E4shwNcaiKZeGZ6SMDYL9DVGqMcSxnF7qT0G6xAVYRgrO17Us93KoDVzHd874lou45adzjReipmwPmooz1KmXBJDDCoRKRqsL9ofCq+VKKbKGjgqAPeBGMNQmAG6ybXsCDExCCGvkPUkEZKfvPLCniCEncXF2dH46PsuBhg+tQkJHzhcs39a5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(36756003)(8676002)(110136005)(30864003)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L1JPX1iZ6sgjEb8GDTXzykmhtXF5IjFCa6feKXrGQN/7p9whoWheLUJ/C1?=
 =?iso-8859-1?Q?X5nJL0jELBIGRt6JjDFlVCmMJz3SKEiVkPIhdsEmvtfJLJzIwFuxQoUZOI?=
 =?iso-8859-1?Q?V8graXN3+w6N48kHO5d7ucLcOSPM4q+ixQGM0tbgVc+Dr3Vh+cTRoUEIBE?=
 =?iso-8859-1?Q?0kBzU3d6v4ZP0W8h8oOCDSEeUl7EaxXThJAbIaNnhXKdhDFfAj+55Jqgsc?=
 =?iso-8859-1?Q?/88ok3hDaMKnzGQ1WBu9sCr5VXm/NnQuEGVc4cFflBEnK2TFMimPPX7oPn?=
 =?iso-8859-1?Q?80zj3SIyoVozKH34MPMDDCMfJ6FNwxTApi5kb1BO7kBQMdka7RM4FU3A62?=
 =?iso-8859-1?Q?U7z4nuaKj+r2twMZPKhVulhy+aTj75FAbsNC/uki2AooolzOGTcgSgjFPP?=
 =?iso-8859-1?Q?ELZf0eaCW+ZbprwmYyGydSxEHvlssHSZHuHMx0WbxMkhdYX0h6bGqX8HPV?=
 =?iso-8859-1?Q?90ZoZIL2uerCD8uTYOTx+wZvVpb059zH0vklLykKILV2ezkzISxXlTMOQ9?=
 =?iso-8859-1?Q?TY23/1pkNOdG1+oKSfxpsaubB4IzKAa7JRPlFMrkHlc7GPBCxTUk4oqRRJ?=
 =?iso-8859-1?Q?Vs1biQt24B/TZsK3JaxYJlR43Kw/ZIapgF56XdS9O5kLZGISlKNVqkzqaO?=
 =?iso-8859-1?Q?DvBVITQS5b7q9UDErQlWmcWgE9LerpS2r4ZuTR/Rn/W6ilVaFKEytrdufa?=
 =?iso-8859-1?Q?JbMuir0jLlka62UIsPRfl3oQH7sohfSjEyBDevPcpQn/SiL1G7QY3pT9NC?=
 =?iso-8859-1?Q?ODzxCzlnAXJKFECE2tFe1uZDsdQn2Gg+Apwcxy5it0btaFN0V6B/zeyHUG?=
 =?iso-8859-1?Q?K3fU4WiLZL/Bbgsc2OhPn3b71sWc1Fkz6MA4sHdtTX2GmiR7kbuSgn3Vrr?=
 =?iso-8859-1?Q?9qnC40bN4UxTATuxYAXfbU15fMWZ9x2NuYDuAVRtdqFZt/Du5VmKHavwAo?=
 =?iso-8859-1?Q?WOeu80NZBlCUhGNuJGwImlBH5atuoIv7OHt7dtcCCoGX+m/Sla0HuMqhhI?=
 =?iso-8859-1?Q?+WbjO7Qlh+5ZfjPd+7JjpITA2q8/4TNnRqESte0HkWgzHzBN3xSuJgrBzh?=
 =?iso-8859-1?Q?zSOnzt0uazxXlJKOXHOQfe7zkNTHZSJobYaMUlac3OCV0brO+PGBMC2eYt?=
 =?iso-8859-1?Q?XKX72drMbx0mMM/jVeBtJCgm7mpzHHYAmOVJDv0Qbcwd2Njg/x7d0vxnsb?=
 =?iso-8859-1?Q?sjialMrwRCLlDRoJT5ohJvQLfPbTttvKAVWSyQyhvqbl1xwayOOwaLkqmS?=
 =?iso-8859-1?Q?ovc/kraSg3lm81k1006PtsndUkSY4WE9sXQidKvNDTAT6M7CgOeOkoImID?=
 =?iso-8859-1?Q?yMiWk4/yCUExelxAK6w8KzSBRXF1XeelrU843dtqjuUkKhXLRCYqtu0mhh?=
 =?iso-8859-1?Q?EXmrLCwicOuYDIVXjkMcMWw1LTqxjUOLndNK7rS3Tm3lgZuzjrPUlETCMS?=
 =?iso-8859-1?Q?ufD+efhu7p7ARUZ7yOFKUGAKeZsDxdkDXKsnxhaD7zxotkojFhvzKYQnU2?=
 =?iso-8859-1?Q?eaQdv+fx8giBUMKMkP/fN0qV3bXHj7L5DUZdeBnyrlTiazx1qMhO5wHxM+?=
 =?iso-8859-1?Q?nZCbdmeair36O949VtzkmzsgOVdxXyf2gxxSv4fevBeUuk6gRy+6SAK3no?=
 =?iso-8859-1?Q?Dv+7tO0LDRQRA2fCHAF0mE212AGOpHh1YNcePHElxFpmUGua7PvtYRPFPn?=
 =?iso-8859-1?Q?DDerIkAYKdcy6uANass=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0969818-097e-4a0b-ad8d-08d9b4d71046
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:03.2842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMr14Z0ME3G4Na6wN11x9bSkbaBXIRPkeW38TK1SvEYfvmNu9L687P+VA67dX8msj4sTYbTfhvMrGJfXB6WJng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: Mppw2206j_VrPmMbujHPyAL-0ERZf3CV
X-Proofpoint-GUID: Mppw2206j_VrPmMbujHPyAL-0ERZf3CV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
do_mas_align_munmap().

do_munmap() is a wrapper to create a maple state for any callers that
have not been converted to the maple tree.

do_mas_munmap() takes a maple state to mumap a range.  This is just a
small function which checks for error conditions and aligns the end of
the range.

do_mas_align_munmap() uses the aligned range to mumap a range.
do_mas_align_munmap() starts with the first VMA in the range, then finds
the last VMA in the range.  Both start and end are split if necessary.
Then the VMAs are unlocked and removed from the linked list at the same
time.  Followed by a single tree operation of overwriting the area in
with a NULL.  Finally, the detached list is unmapped and freed.

By reorganizing the munmap calls as outlined, it is now possible to
avoid extra work of aligning pre-aligned callers which are known to be
safe, avoid extra VMA lookups or tree walks for modifications.

detach_vmas_to_be_unmapped() is no longer used, so drop this code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 212 +++++++++++++++++++++++++++------------------
 mm/mremap.c        |  25 +++---
 3 files changed, 145 insertions(+), 97 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 39a947f29f6d..199f66716eef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2744,8 +2744,9 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
-		       struct list_head *uf, bool downgrade);
+extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+			 unsigned long start, size_t len, struct list_head *uf,
+			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 436e136a64f1..14190306a483 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2274,44 +2274,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vm=
a,
-	struct vm_area_struct *prev, unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mt_szero(mm, vma->vm_start, end);
-	do {
-		mm->map_count--;
-		tail_vma =3D vma;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
-	*insertion_point =3D vma;
-	if (vma)
-		vma->vm_prev =3D prev;
-	else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-	tail_vma->vm_next =3D NULL;
-
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
-		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
-		return false;
-	return true;
-}
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2391,13 +2353,17 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline void
-unlock_range(struct vm_area_struct *start, unsigned long limit)
+static inline int
+unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
+	     unsigned long limit)
 {
 	struct mm_struct *mm =3D start->vm_mm;
 	struct vm_area_struct *tmp =3D start;
+	int count =3D 0;
=20
 	while (tmp && tmp->vm_start < limit) {
+		*tail =3D tmp;
+		count++;
 		if (tmp->vm_flags & VM_LOCKED) {
 			mm->locked_vm -=3D vma_pages(tmp);
 			munlock_vma_pages_all(tmp);
@@ -2405,35 +2371,29 @@ unlock_range(struct vm_area_struct *start, unsigned=
 long limit)
=20
 		tmp =3D tmp->vm_next;
 	}
+
+	return count;
 }
=20
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
+/*
+ * do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a downwrite of the mmap_sem
+ *
+ * @mas must be locked before calling this function.  If @downgrade is tru=
e,
+ * check return code for potential release of the lock.
  */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+static int
+do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool downgrade)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
-
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
-		return -EINVAL;
-
-	len =3D PAGE_ALIGN(len);
-	end =3D start + len;
-	if (len =3D=3D 0)
-		return -EINVAL;
-
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
-
-	/* Find the first overlapping VMA where start < vma->vm_end */
-	vma =3D find_vma_intersection(mm, start, end);
-	if (!vma)
-		return 0;
-	prev =3D vma->vm_prev;
+	struct vm_area_struct *prev, *last;
 	/* we have start < vma->vm_end  */
=20
 	/*
@@ -2458,16 +2418,26 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		if (error)
 			return error;
 		prev =3D vma;
+		vma =3D __vma_next(mm, prev);
+		mas->index =3D start;
+		mas_reset(mas);
+	} else {
+		prev =3D vma->vm_prev;
 	}
=20
+	if (vma->vm_end >=3D end)
+		last =3D vma;
+	else
+		last =3D find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last =3D find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		int error =3D __split_vma(mm, last, end, 1);
 		if (error)
 			return error;
+		vma =3D __vma_next(mm, prev);
+		mas_reset(mas);
 	}
-	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2480,22 +2450,47 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			return error;
 	}
=20
 	/*
-	 * unlock any mlock()ed ranges before detaching vmas
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
 	 */
-	if (mm->locked_vm)
-		unlock_range(vma, end);
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
=20
-	/* Detach vmas from the MM linked list and remove from the mm tree*/
-	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
-		downgrade =3D false;
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	if (last->vm_next) {
+		last->vm_next->vm_prev =3D prev;
+		last->vm_next =3D NULL;
+	} else
+		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
+
+	/*
+	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
+	 * VM_GROWSUP VMA. Such VMAs can change their size under
+	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
+	 */
+	if (downgrade) {
+		if (last && (last->vm_flags & VM_GROWSDOWN))
+			downgrade =3D false;
+		else if (prev && (prev->vm_flags & VM_GROWSUP))
+			downgrade =3D false;
+		else {
+			mmap_write_downgrade(mm);
+		}
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -2505,10 +2500,61 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 	return downgrade ? 1 : 0;
 }
=20
+/*
+ * do_mas_munmap() - munmap a given range.
+ * @mas: The maple state
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @downgrade: set to true if the user wants to attempt to write_downgrade=
 the
+ * mmap_sem
+ *
+ * This function takes a @mas that is in the correct state to remove the
+ * mapping(s).  The @len will be aligned and any arch_unmap work will be
+ * preformed.
+ * @mas must be locked. @mas may be unlocked if @degraded is true.
+ *
+ * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
+ */
+int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool downgrade)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
+		return -EINVAL;
+
+	end =3D start + PAGE_ALIGN(len);
+	if (end =3D=3D start)
+		return -EINVAL;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma =3D mas_find(mas, end - 1);
+	if (!vma)
+		return 0;
+
+	mas->last =3D end - 1;
+	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+}
+
+/* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length to be munmapped.
+ * @uf: The userfaultfd list_head
+ */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	MA_STATE(mas, &mm->mm_mt, start, start);
+
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2542,7 +2588,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2746,11 +2792,12 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D __do_munmap(mm, start, len, &uf, downgrade);
+	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2884,10 +2931,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	arch_unmap(mm, newbrk, oldbrk);
=20
 	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
-		mas_set(mas, newbrk);
-		if (vma->vm_start !=3D newbrk)
-			mas_reset(mas); // cause a re-walk for the first overlap.
-		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 		goto munmap_full_vma;
 	}
=20
@@ -3140,7 +3184,7 @@ void exit_mmap(struct mm_struct *mm)
 	 */
 	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
 	if (mm->locked_vm)
-		unlock_range(mm->mmap, ULONG_MAX);
+		unlock_range(mm->mmap, &vma, ULONG_MAX);
=20
 	arch_exit_mmap(mm);
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index 002eec83e91e..b09e107cd18b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -978,20 +978,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * __do_munmap does all the needed commit accounting, and
+	 * do_mas_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
+		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
=20
-		retval =3D __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
-		if (retval < 0 && old_len !=3D new_len) {
-			ret =3D retval;
-			goto out;
+		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
-		} else if (retval =3D=3D 1)
+		if (retval =3D=3D 1) {
 			downgraded =3D true;
+		} else if (retval < 0 && old_len !=3D new_len) {
+			ret =3D retval;
+			goto out;
+		}
+
 		ret =3D addr;
 		goto out;
 	}
@@ -1006,7 +1009,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	}
=20
 	/* old_len exactly to the end of the area..
-	 */
+	*/
 	if (old_len =3D=3D vma->vm_end - addr) {
 		/* can we just expand the current mapping? */
 		if (vma_expandable(vma, new_len - old_len)) {
@@ -1048,9 +1051,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 			map_flags |=3D MAP_SHARED;
=20
 		new_addr =3D get_unmapped_area(vma->vm_file, 0, new_len,
-					vma->vm_pgoff +
-					((addr - vma->vm_start) >> PAGE_SHIFT),
-					map_flags);
+					     vma->vm_pgoff +
+					     ((addr - vma->vm_start) >> PAGE_SHIFT),
+					     map_flags);
 		if (IS_ERR_VALUE(new_addr)) {
 			ret =3D new_addr;
 			goto out;
--=20
2.30.2
