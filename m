Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808A74A69FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbiBBCmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32206 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237321AbiBBCmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:05 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120ULVG005139;
        Wed, 2 Feb 2022 02:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=jnI18zw9eyNCrN/yj15FsY8gzzhromB5Ri8bBrwzTZQ=;
 b=Su8v7XCQ7PXI0mPso9SmaI2ttJC2VHbPGrhbF/1TSR087pzp9nVichO0rB9cXdkBssXM
 rN1303k5s+JHs/reV5bytgBXCqig94Lsu5aSXfj3cByCKeRG2J9e6GhsFE7zFM9adV2q
 +UpMjBDFYwQDBb1oA6TgizR1y7BCn1Hbg+V9X/u2Mpn8vKKy3sMQbKY8jTBDSRJTeekJ
 WTgM8TwapkEx6uquin9RjGIaeo30jNkTVKANIweqLYBRrcsrA20ZWekpOzKqv7atv1nc
 q8uQWXkn3rIOAxYHMQogC3G3lnDYScAzx4Fkp7BWQiC4bcKI6avEM8WTerd5JbWC49pB 8g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPEB146731;
        Wed, 2 Feb 2022 02:41:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3020.oracle.com with ESMTP id 3dvwd78vk5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acFIpCEmdptzERTvMLvcHrAVH1FyhzduUnsdbs5H0sP+yPdAww1e9vu1WQNf9fMnuxc3Inx7KGY8NKbyZCacKp0YfdXdpzES5yiu3G8Tob/5LVkdBU8iIB9WVXMgyf8FLlxpZ+sDMLbwCAD78OCgV8psgpAjgLRf+M3PezsYbie1QX55TgLU1rZbxWzhTwWW5HEGiGvtDrI8dmNONhiUaGSPgwV7aZTn8fVmpXN7UOqnNyo8GSM83dwO6BrQ4PFlbpYUWluRNRijOhWt9pIQqhl221Qa7aG4zXZUzOgWrj5qct9YoTlbr8/5MlZQr9BU0XJOcbtM6Nmk9Q3Q3D1/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnI18zw9eyNCrN/yj15FsY8gzzhromB5Ri8bBrwzTZQ=;
 b=OR5Gn/3XPzjM/cZDGCWbuFeq3jf3KVH4LGLAhX9AWwb14gClCSCFXkuX4zN1noMYSUqNGH5cMQNgU5pWPBh3ND4luCC83kWnd1+UUKkXrjOChJuNHLg5cAxUNKY3Ma8t9I+02iN/nB+icwFsDswCDDCONO3KPInd8lqsWrO1FdMEBDQ8GIfZWlxkzWLi3dc+71MXLOsQ+hOwAk7qlvp7Fxlwj4pjGFL07QKrpfjJ9PFrV4QEPtbUUy8gY0gCV+JlNgYOIri8tFGvpADtQB7DJtK5eV9z48jnJTKpbdMyxR8CN1vt3aktiRhYoURzvfBC/VoMCCyg0tp0QQ8LKBodhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnI18zw9eyNCrN/yj15FsY8gzzhromB5Ri8bBrwzTZQ=;
 b=zJ0RbAT2T4z3SgU+niTas5FV31uv8ptziq9bw4K18sJhCQGQuhUlTj2WOTt18qa4z5/qtztObf0GEy9whHnfAIaTi9k7cKwsEH3mjN6um5QpRWMBVYcbwptb4Jo+Xr+2UXM9ReFqw4LeRsVRvCyQ9xfaEFFYWBuuIQ7oCoee+ZQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1325.namprd10.prod.outlook.com (2603:10b6:300:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Wed, 2 Feb
 2022 02:41:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:41:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v5 00/70] Introducing the Maple Tree
Thread-Index: AQHYF95vPdlN0wUjhU63r3V7yJPHbQ==
Date:   Wed, 2 Feb 2022 02:41:52 +0000
Message-ID: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f812b67-fa00-4b37-9d7e-08d9e5f59216
x-ms-traffictypediagnostic: MWHPR10MB1325:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1325F951B402C274AB3CCE7BFD279@MWHPR10MB1325.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nuTqKRwk4WDBnkxG2ws/O7soWnnp2WHYlw/G4yO1AKHq/Vde1hYGqGD8DkaCPoidgQbc4/nz6KMDWhuzl7QTA04fO9iYkxu307s7/mOH/Lqner32bkFK8jWwWh2w+8XakSOhZiCqQPLkJvkfUhpiiToL9rqhigiZBf94K8nXiImJq1JMl6MjrQuqGl4HHmFuakXVmINfQ244kYhXq2dZfcklkd8MzVQOwqMQCqyy44y3i3FAT2LDYFwqgRH9juRDhL5wYWRES4gRFX//rNA5o3gP+ST/lql9Zigu1IB08uoSgc7mjZK6ikFMVFlQgMZTuso2p0J1GJqSAKWvFdKjummiLkvCBHlRDv2f7Mpbc2+dOXeq7Qx0Tcbu9fHc/VBY294x8ODwoJ6btLrqeDp6co65VbBfmZ0gTdtxn6lAw24vYeVT7EJmevSB0OCVd1wVVFJnRsWX0nfddo6izIPhrrIb6W6XaEW9YTwdb68dTat20TB3I3MdVd7hi6NwdZ6GIwtI/9I3eBeECtD/igvk466RXaoMZG0WIsz5zrhhnh2u6aI+vkOAfQGDayiB7N+3vg80MlN4YzlVzIq4d1NoC53ck2jYZrYAJKFQIfmLUBvZAQeTiWZfVBne4DszSAi+NSpBY60L9HTAZw5Y6WowF7MXE4aRJGslZfwuVcX20H/xZ9K0/43fNWD83R3X4MW2x1I6bhQABj7udXFGpZUbXrXgKs3ACNALohQNJF7rn3UxIh808BmvzhicGt+YP0NwlE/c5uTpauCQU7gG22diC5VYz6PCThnahPiS0CFjgfLqXD0ZsQOJ5NaRQQ4qeNTq8tQ8CXjS9OW7XEVdtRevgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(38100700002)(30864003)(110136005)(86362001)(508600001)(6486002)(966005)(6506007)(44832011)(91956017)(66946007)(26005)(38070700005)(2906002)(122000001)(71200400001)(66556008)(186003)(66476007)(66446008)(64756008)(1076003)(8936002)(76116006)(36756003)(316002)(2616005)(8676002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GddYU8Yd0pm4JfTUrfwgEzMxMOpkmLqnIpTapyzao6nrqx5AbdlKhcroYo?=
 =?iso-8859-1?Q?krTfwas8dnIGLFsmCcTIX3Jzp/w3BGkugOwV06z8SwL2Bt6lhagGHSi4xw?=
 =?iso-8859-1?Q?9iCstWNU7Grb1IkFEXgQZeli3KlAoWEiWzuVecz4X4ftUEppbWgZ455bcR?=
 =?iso-8859-1?Q?oYZvJPf5FvqoRnAKWwjC1fyfJV5gT/IeJzIv2PUQaRMOhjHSBYwvT+OVs5?=
 =?iso-8859-1?Q?3vkjkZ59VPSUX4F2Q45McUen0DMH5jy2llhkmSiY6RqoukCd7+7RY/DdRa?=
 =?iso-8859-1?Q?/DQSEomCUSzNPTbfHq0diWl7ahF+KRy0OL43prTbGYlsiVWqg4LC9C0BfQ?=
 =?iso-8859-1?Q?ZvuqEXk5Ca2anK38z5RtVZgVrYqzG5t2XNGYlwtnnPzMAH6pZCNlybJBft?=
 =?iso-8859-1?Q?Tfliy5ISApwDnoSmWcqoQlI/oMsapA/kYU16p8CcKGHYQfDOFwwbJYsxA+?=
 =?iso-8859-1?Q?7/C9AFUhc/f3u9B3YxBbixz5KCyzUluURWyIC56lhA9Vnp0pL1Zsfjmei8?=
 =?iso-8859-1?Q?SrtMpFwyosqkhqZgH/pQ6w/QExzGa7bfWcRKzBbCBpvLrg+kIBhtFyblf/?=
 =?iso-8859-1?Q?Q7aKNO6wPAAfNDY0QQkSuiq/T7fxkGPxckHYjKrPuUvPHvRiIX8SbPrTY9?=
 =?iso-8859-1?Q?6Ta3qzqVz98aDul6yowFSuJN6l2w33kzA4GS4xPxtg8SgZ9BrTXUmGzI2O?=
 =?iso-8859-1?Q?ck5NdAdYXnN+QokWapkg1l5SaQhMcB6vmmijdhw3h9RSvLf6SOBmIDTmdg?=
 =?iso-8859-1?Q?yaEAEX51ifgUmLKWLSEwK80fI1qR9445zZ95fEJo+lgu5j0fSi58V2LSWt?=
 =?iso-8859-1?Q?LElg1Ra2oaj3T7Z/EU2rVW1liFp7eKWq/lvB5Flg7823zianXCYFLJagRO?=
 =?iso-8859-1?Q?uj42KGJeXdrTZ7GXtHK0J62h75xc1sTpD6COJx26MVEgawhcvjOnZaUmYM?=
 =?iso-8859-1?Q?dNAoGM5PMtbyvjJj9usOGWOgjTS1Aa3237hdgiWpZ6i8jjCmw3Q2rG0sqb?=
 =?iso-8859-1?Q?m6tXLESt9P/1dKkZ6nYPfgbzXWygTVR+jI4vIwPLT8MEOU28R+ttqdpmim?=
 =?iso-8859-1?Q?Ax/a4Mm+7QqVXrQnLeID11Ke1Q7wdYhUHAB0imm+EwjLjfMFxdAe8J9YI5?=
 =?iso-8859-1?Q?kWlOoaQBdh3rj0XpjtM8ywbC4xRM2SHS0FYifzX4cFfdoAWZhmoddeYNZ+?=
 =?iso-8859-1?Q?izXhKUMHHSYqlJrTC5RjpTqH00GTVrCahRVWYNNFGgBJY6pC7+6AWOWm7F?=
 =?iso-8859-1?Q?vG1qdQTPx/HG1uWGCWdppBjQkDZHRbzKALbAmtT+4q1KqE6DJKzL0MsYQy?=
 =?iso-8859-1?Q?YduPE2VFKF6t7kB8CYw2vzH5lKar4rE/tSiCI7DYf81e0JC1S+vXD3lVme?=
 =?iso-8859-1?Q?6QBfwgwUHI45gK7/b70RfyEwwEUr2lu6rprdqw9EfmciVJRtZQpKM/qPdY?=
 =?iso-8859-1?Q?SMURe70bYB5OZx+utEK+hJxwgjhYrCIPzODSG250aarNwa+CoTyY6lmI88?=
 =?iso-8859-1?Q?5aj/ux4k7K/OC2YWNOJ3eZpDO0JW47FkTzMEC9RAY2wsP+74NrRdtAV4xW?=
 =?iso-8859-1?Q?zQu0SVUwn+IJnTWva6LL7M+CiUkj3FOlIS9CtvMUkcdRP6rsdRf4mkNiVk?=
 =?iso-8859-1?Q?i4tjL0j3p/11c4ZDsYUmyRHYTzzvRKn7Gi3HZW0WpO/YvwZCZKXa6P9UYQ?=
 =?iso-8859-1?Q?tXb9zC+BdlyxHXvcp1c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f812b67-fa00-4b37-9d7e-08d9e5f59216
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:41:52.9402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNyBA0YKxR6rjXVumSgyaXFDkezbuU5nm/+Hnpgyuno9QE7TVauIHY+/dFxn1DPqh4kyle6y5oOnFAnb0GBjEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1325
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: 1XAhe4_aoB0fyNhq6XJsvirfLN4LIsCW
X-Proofpoint-ORIG-GUID: 1XAhe4_aoB0fyNhq6XJsvirfLN4LIsCW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree is an RCU-safe range based B-tree designed to use modern
processor cache efficiently.  There are a number of places in the kernel
that a non-overlapping range-based tree would be beneficial, especially
one with a simple interface.  The first user that is covered in this
patch set is the vm_area_struct, where three data structures are
replaced by the maple tree: the augmented rbtree, the vma cache, and the
linked list of VMAs in the mm_struct.  The long term goal is to reduce
or remove the mmap_sem contention.

The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
nodes.  With the increased branching factor, it is significantly shorter th=
an
the rbtree so it has fewer cache misses.  The removal of the linked list
between subsequent entries also reduces the cache misses and the need to pu=
ll
in the previous and next VMA during many tree alterations.

This patch is based on v5.17-rc2

git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220131

v5 changes:
- Fixed race condition in mas_prev() on RCU read of a dead node
- Fixed potential double NULL entries into the tree in rare cases
- Separated testing from tree commit for easier review
- Added an extra patch to clean up __vma_link_file() by passing mapping
- Extra patch for riscv link list
- Expanded mm/mempolicy patch to remove new link list use
- Changed comment in include/linux/mm.h to reference mmap.c for vma_store()=
 -
  Thanks Vlastimil Babka
- Added comment to vma iterator code to explain the use of vma_find() for
  vma_next() implementation - Thanks Vlastimil Babka
- Fixed missing and incorrectly ordered s-o-b - Thanks Vlastimil Babka
- Move duplicate documentation from rst and header to .c - Thanks Vlastimil=
 Babka
- Fixed whitespace in header - Thanks Vlastimil Babka
- Changed mm/mmap.c remove_mt() to use mas_for_each() since it is safe now =
with
  the locking changes
- Changed khugepaged_scan_mm_slot() to use vma iterator
- Changed munlock() to use vma iterator
- Changed vma_store() to use vma_mas_store() instead of its own implementat=
ion
- Removed RCU lock from early unmapped_area{_topdown} patch
- Added comment to vma_find_prev() to explain why the RCU lock is not neede=
d.
- Renamed vma_lookup() change to specify mtree_load() for clarity - Thanks =
Vlastimil Babka
- Move vma_lookup() change to after vmacache removal to avoid subtle change=
 in
  vmacache behaviour. - Thanks Vlastimil Babka
- Drop extra vmacache info from header - Thanks Vlastimil Babka
- Fixed htmldocs issues - Thanks Vlastimil Babka
- Fixed formatting in mm/util.c when removing rbtree
- Add missing arguments to doc of vma_expand & add VM_BUG_ONs - Thanks Vlas=
timil Babka
- Fixed error in mmap_region() check to see if the vma can be expaded over =
next
- Remove spurious edits to mremap - Thanks Vlastimil Babka
- Consolidated fix to do_brk_munmap() into introduction of the function - T=
hanks Vlastimil Babka
- Change xtensa loop to avoid missing address exhaustion - Thanks Vlastimil=
 Babka
- Fix up cxl driver - Thanks Vlastimil Babka
- Change second loop in um tlb to use vma iterator - Thanks Vlastimil Babka
- Added comments to fs/userfaultfd.c maple state manipulations - Thanks Vla=
stimil Babka
- Fixed fs/userfaultfd cases where maple state was invalidated by vma_merge=
()/split_vma()
- Fixed do_brk_munmap() vm_flags usage - Thanks Vlastimil Babka
- Reverted bpf linked list changes to v3 - Thanks Vlastimil Babka
- Fixed mm/huge_memory comment - Thanks Vlastimil Babka
- Changed mm/khugepaged loop to a vma iterator - Thanks Vlastimil Babka
- Change mm/ksm.c to vma iterator instead of mas_for_each - Thanks Vlastimi=
l Babka
- Changed walk_page_range() to use ULONG_MAX instead of -1 - Thanks Vlastim=
il Babka
- Updated mm/mempolicy to use vma iterator - Thanks Vlastimil Babka
- Restored VM_BUG_ON(!vma) to mbind_range() - Thanks Vlastimil Babka
- Use vma iterator in mlock - Thanks Vlastimil Babka
- Fix overflow handling in count_mm_mlocked_page_nr() - Thanks Vlastimil Ba=
bka
- Use find_vma_intersection() in vma_expandable() - Thanks Vlastimil Babka
- Use vma iterator in oom_kill - Thanks Vlastimil Babka
- Convert swapfile to vma iterator and remove mas_pause() - Thanks Vlastimi=
l Babka
- Fixed comment in i915 patch - Thanks Vlastimil Babka
- Added comment to nommu exit_mmap() about locking - Thanks Vlastimil Babka
- Updated documentation from mtree_init() to mt_init() - Thanks David Howel=
ls
- Renamed mas_entry_count() to mas_expected_entries() - Thanks David Howell=
s

v4: https://lore.kernel.org/linux-mm/20211201142918.921493-30-Liam.Howlett@=
oracle.com/t/
v3: https://lore.kernel.org/linux-mm/20211005012959.1110504-1-Liam.Howlett@=
oracle.com/
v2: https://lore.kernel.org/linux-mm/20210817154651.1570984-1-Liam.Howlett@=
oracle.com/
v1: https://lore.kernel.org/linux-mm/20210428153542.2814175-1-Liam.Howlett@=
Oracle.com/


Performance on a 144 core x86:

It is important to note that the code is still using the mmap_sem, the
performance seems fairly similar on real-world workloads, while there
are variations in micro-benchmarks.

kernbench, increased system time, less user time:
Amean     user-2        887.04 (   0.00%)      887.58 *  -0.06%*
Amean     syst-2        165.58 (   0.00%)      171.42 *  -3.53%*
Amean     elsp-2        532.29 (   0.00%)      535.27 *  -0.56%*
Amean     user-4        909.41 (   0.00%)      911.48 *  -0.23%*
Amean     syst-4        168.91 (   0.00%)      176.91 *  -4.74%*
Amean     elsp-4        276.44 (   0.00%)      280.24 *  -1.38%*
Amean     user-8        962.08 (   0.00%)      964.41 *  -0.24%*
Amean     syst-8        178.70 (   0.00%)      185.35 *  -3.72%*
Amean     elsp-8        151.55 (   0.00%)      152.77 *  -0.81%*
Amean     user-16      1042.51 (   0.00%)     1037.92 *   0.44%*
Amean     syst-16       190.52 (   0.00%)      195.19 *  -2.45%*
Amean     elsp-16        86.03 (   0.00%)       86.64 *  -0.70%*
Amean     user-32      1225.85 (   0.00%)     1208.83 *   1.39%*
Amean     syst-32       215.97 (   0.00%)      220.13 *  -1.92%*
Amean     elsp-32        55.03 (   0.00%)       55.02 *   0.01%*
Amean     user-64      1235.68 (   0.00%)     1232.82 *   0.23%*
Amean     syst-64       215.98 (   0.00%)      222.28 *  -2.92%*
Amean     elsp-64        33.12 (   0.00%)       33.24 *  -0.36%*
Amean     user-128     1610.29 (   0.00%)     1609.63 *   0.04%*
Amean     syst-128      268.52 (   0.00%)      277.45 *  -3.33%*
Amean     elsp-128       25.98 (   0.00%)       26.04 *  -0.23%*

Increase in performance in the following micro-benchmarks in Hmean:
- signal1-processes +1.81% to +11.12%

Decrease in performance in the following micro-benchmarks in Hmean:
- brk1-processes -38.07% to -43.20%

Mixed Hmean results:
- pft timing system -4.73% to +10.75%
- pft timing elapsed -4.31% to +22.47%
- pft faults/cpu -4.10% to +11.50%
- pft faults/sec -4.12% to +28.96%
- freqmine-medium -6.86% to +11.06%
- malloc1-processes -24.52% to +4.61%
- malloc1-threads -5.18% to -48.83%
- page_fault3-threads -13.92% to +11.37%


Patch organization:
Patch 1 is to add a missing lock to avoid an assert issue when using a vma =
iterator.

Patches 2 to 6 are radix tree test suite additions for maple tree
support.

Patch 7 adds the maple tree.
Patch 8 adds the maple tree test code.

Patches 9-18 are the removal of the rbtree from the mm_struct.  This now
includes the introduction of the vma iterator.

Patch 19 optimizes __vma_adjust() for the maple tree.

Patches 20-26 are the removal of the vmacache from the kernel.

Patches 27-30 are internal mm changes for efficiencies.

Patches 31-68 are the removal of the linked list

Patches 69 and 70 are a small cleanup from the removal of the vma linked li=
st.


Liam R. Howlett (60):
  radix tree test suite: Add pr_err define
  radix tree test suite: Add kmem_cache_set_non_kernel()
  radix tree test suite: Add allocation counts and size to kmem_cache
  radix tree test suite: Add support for slab bulk APIs
  radix tree test suite: Add lockdep_is_held to header
  Maple Tree: Add new data structure
  lib/test_maple_tree: Add testing for maple tree
  mm: Start tracking VMAs with maple tree
  mm/mmap: Use the maple tree in find_vma() instead of the rbtree.
  mm/mmap: Use the maple tree for find_vma_prev() instead of the rbtree
  mm/mmap: Use maple tree for unmapped_area{_topdown}
  kernel/fork: Use maple tree for dup_mmap() during forking
  mm: Remove rb tree.
  mmap: Change zeroing of maple tree in __vma_adjust()
  xen: Use vma_lookup() in privcmd_ioctl_mmap()
  mm: Optimize find_exact_vma() to use vma_lookup()
  mm/khugepaged: Optimize collapse_pte_mapped_thp() by using
    vma_lookup()
  mm/mmap: Change do_brk_flags() to expand existing VMA and add
    do_brk_munmap()
  mm: Use maple tree operations for find_vma_intersection()
  mm/mmap: Use advanced maple tree API for mmap_region()
  mm: Remove vmacache
  mm/mmap: Move mmap_region() below do_munmap()
  mm/mmap: Reorganize munmap to use maple states
  mm/mmap: Change do_brk_munmap() to use do_mas_align_munmap()
  arm64: Remove mmap linked list from vdso
  parisc: Remove mmap linked list from cache handling
  powerpc: Remove mmap linked list walks
  s390: Remove vma linked list walks
  x86: Remove vma linked list walks
  xtensa: Remove vma linked list walks
  cxl: Remove vma linked list walk
  optee: Remove vma linked list walk
  um: Remove vma linked list walk
  binfmt_elf: Remove vma linked list walk
  exec: Use VMA iterator instead of linked list
  fs/proc/base: Use maple tree iterators in place of linked list
  userfaultfd: Use maple tree iterator to iterate VMAs
  ipc/shm: Use VMA iterator instead of linked list
  acct: Use VMA iterator instead of linked list
  perf: Use VMA iterator
  sched: Use maple tree iterator to walk VMAs
  fork: Use VMA iterator
  bpf: Remove VMA linked list
  mm/gup: Use maple tree navigation instead of linked list
  mm/khugepaged: Stop using vma linked list
  mm/ksm: Use vma iterators instead of vma linked list
  mm/madvise: Use vma_find() instead of vma linked list
  mm/memcontrol: Stop using mm->highest_vm_end
  mm/mempolicy: Use vma iterator & maple state instead of vma linked
    list
  mm/mlock: Use vma iterator and instead of vma linked list
  mm/mprotect: Use maple tree navigation instead of vma linked list
  mm/mremap: Use vma_find_intersection() instead of vma linked list
  mm/msync: Use vma_find() instead of vma linked list
  mm/oom_kill: Use maple tree iterators instead of vma linked list
  mm/pagewalk: Use vma_find() instead of vma linked list
  mm/swapfile: Use vma iterator instead of vma linked list
  riscv: Use vma iterator for vdso
  mm: Remove the vma linked list
  mm/mmap: Drop range_has_overlap() function
  mm/mmap.c: Pass in mapping to __vma_link_file()

Matthew Wilcox (Oracle) (10):
  binfmt_elf: Take the mmap lock when walking the VMA list
  mm: Add VMA iterator
  mmap: Use the VMA iterator in count_vma_pages_range()
  damon: Convert __damon_va_three_regions to use the VMA iterator
  proc: Remove VMA rbtree use from nommu
  mm: Convert vma_lookup() to use mtree_load()
  coredump: Remove vma linked list walk
  fs/proc/task_mmu: Stop using linked list and highest_vm_end
  i915: Use the VMA iterator
  nommu: Remove uses of VMA linked list

 Documentation/core-api/index.rst              |     1 +
 Documentation/core-api/maple_tree.rst         |   196 +
 MAINTAINERS                                   |    12 +
 arch/arm64/kernel/vdso.c                      |     3 +-
 arch/parisc/kernel/cache.c                    |     9 +-
 arch/powerpc/kernel/vdso.c                    |     6 +-
 arch/powerpc/mm/book3s32/tlb.c                |    11 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |    13 +-
 arch/riscv/kernel/vdso.c                      |     3 +-
 arch/s390/kernel/vdso.c                       |     3 +-
 arch/s390/mm/gmap.c                           |     6 +-
 arch/um/kernel/tlb.c                          |    14 +-
 arch/x86/entry/vdso/vma.c                     |     9 +-
 arch/x86/kernel/tboot.c                       |     2 +-
 arch/xtensa/kernel/syscall.c                  |    18 +-
 drivers/firmware/efi/efi.c                    |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |    14 +-
 drivers/misc/cxl/fault.c                      |    45 +-
 drivers/tee/optee/call.c                      |    18 +-
 drivers/xen/privcmd.c                         |     2 +-
 fs/binfmt_elf.c                               |     6 +-
 fs/coredump.c                                 |    33 +-
 fs/exec.c                                     |    12 +-
 fs/proc/base.c                                |     5 +-
 fs/proc/internal.h                            |     2 +-
 fs/proc/task_mmu.c                            |    74 +-
 fs/proc/task_nommu.c                          |    45 +-
 fs/userfaultfd.c                              |    49 +-
 include/linux/maple_tree.h                    |   673 +
 include/linux/mm.h                            |    77 +-
 include/linux/mm_types.h                      |    43 +-
 include/linux/mm_types_task.h                 |    12 -
 include/linux/sched.h                         |     1 -
 include/linux/sched/mm.h                      |    13 +
 include/linux/userfaultfd_k.h                 |     7 +-
 include/linux/vm_event_item.h                 |     4 -
 include/linux/vmacache.h                      |    28 -
 include/linux/vmstat.h                        |     6 -
 include/trace/events/maple_tree.h             |   123 +
 include/trace/events/mmap.h                   |    71 +
 init/main.c                                   |     2 +
 ipc/shm.c                                     |    21 +-
 kernel/acct.c                                 |    11 +-
 kernel/bpf/task_iter.c                        |    10 +-
 kernel/debug/debug_core.c                     |    12 -
 kernel/events/core.c                          |     3 +-
 kernel/events/uprobes.c                       |     9 +-
 kernel/fork.c                                 |    69 +-
 kernel/sched/fair.c                           |    10 +-
 lib/Kconfig.debug                             |    15 +-
 lib/Makefile                                  |     3 +-
 lib/maple_tree.c                              |  6943 +++
 lib/test_maple_tree.c                         | 37204 ++++++++++++++++
 mm/Makefile                                   |     2 +-
 mm/damon/vaddr-test.h                         |    37 +-
 mm/damon/vaddr.c                              |    53 +-
 mm/debug.c                                    |    14 +-
 mm/gup.c                                      |     9 +-
 mm/huge_memory.c                              |     4 +-
 mm/init-mm.c                                  |     4 +-
 mm/internal.h                                 |    78 +-
 mm/khugepaged.c                               |    13 +-
 mm/ksm.c                                      |    18 +-
 mm/madvise.c                                  |     2 +-
 mm/memcontrol.c                               |     6 +-
 mm/memory.c                                   |    33 +-
 mm/mempolicy.c                                |    58 +-
 mm/mlock.c                                    |    34 +-
 mm/mmap.c                                     |  2106 +-
 mm/mprotect.c                                 |     7 +-
 mm/mremap.c                                   |    22 +-
 mm/msync.c                                    |     2 +-
 mm/nommu.c                                    |   127 +-
 mm/oom_kill.c                                 |     3 +-
 mm/pagewalk.c                                 |     2 +-
 mm/swapfile.c                                 |     4 +-
 mm/util.c                                     |    32 -
 mm/vmacache.c                                 |   117 -
 mm/vmstat.c                                   |     4 -
 tools/testing/radix-tree/.gitignore           |     2 +
 tools/testing/radix-tree/Makefile             |    13 +-
 tools/testing/radix-tree/generated/autoconf.h |     1 +
 tools/testing/radix-tree/linux.c              |   160 +-
 tools/testing/radix-tree/linux/kernel.h       |     1 +
 tools/testing/radix-tree/linux/lockdep.h      |     2 +
 tools/testing/radix-tree/linux/maple_tree.h   |     7 +
 tools/testing/radix-tree/linux/slab.h         |     4 +
 tools/testing/radix-tree/maple.c              |    59 +
 .../radix-tree/trace/events/maple_tree.h      |     3 +
 89 files changed, 47179 insertions(+), 1847 deletions(-)
 create mode 100644 Documentation/core-api/maple_tree.rst
 create mode 100644 include/linux/maple_tree.h
 delete mode 100644 include/linux/vmacache.h
 create mode 100644 include/trace/events/maple_tree.h
 create mode 100644 lib/maple_tree.c
 create mode 100644 lib/test_maple_tree.c
 delete mode 100644 mm/vmacache.c
 create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
 create mode 100644 tools/testing/radix-tree/maple.c
 create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h

--=20
2.34.1
