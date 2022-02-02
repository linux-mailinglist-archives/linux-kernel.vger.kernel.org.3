Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA6D4A6A19
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbiBBCnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:32 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50184 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243916AbiBBCmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:24 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120PIsG004733;
        Wed, 2 Feb 2022 02:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MX3JkAMzR3RRkt5iJQmBsGIpBshCzGuPRUAR8It4dWM=;
 b=o4SUmGDkjGyAmbHGLTFK2uIp4/WaWG8CGfcPpxaWu3GwniJLHWl6/KV+FP3TG3Km6VOu
 gKXPFsq0MkqegJcDaK+YrCh0j37bcNf0C+DCMUT4Zkcupyt1/GJZ/UWqiXZQyp76HsEI
 uyoSPJuMmZFmmFmUnDrvA+6WjbHMJXtBR9Bar61E0AgSSZ411cVZQdzH7sT+WOg1BWoL
 dvUkwd5pAVvg9QJdlZy0E0GbSKQSjx8McGElz9MySdT8nH4swAaRikgQvS2zNWRtKcXO
 KS1CdMCL85wwav7VkOfFXtC9ETxrBUKoZaKLke6dJG1VO2ybTfZLF3XB9lrwNPaxpLDM 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZdSI126532;
        Wed, 2 Feb 2022 02:42:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3dvtq1m94n-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVBhJZLFFAVhk3YZpzcYSLCzn0YeAsx6ucmarZXClEn2gT3bw8TrmdJwA3KYK/iBes5a/5+eTHWNtrzDkB/etIn9BqmlzooPYAPDVqAE88PQPB00e9R+3OmP/vLwEWhkP6MPWzl0yUscPcf/v/fdWhnlfG/LdXQ4HdQv3geCiUcqJ6C/XXoO9/81wgTYS8EPJb+QruIRiiRZGLTY4fkvB6h8G3paODBxbBDUpsBUjWWk6Hjx8/yVt2y0dfSGN93VV3TURmajOoo8nmq5L5TBhBZamNGi8MMc4txx+Egk3PmJIEKPF8ume5q1VOO08plm7BO3Wd7en9F7+BToDvXABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX3JkAMzR3RRkt5iJQmBsGIpBshCzGuPRUAR8It4dWM=;
 b=QqYz8yf28Fr2YK0RtYS0krCCj7g0+mHg58s19K3lm8HC5rjXheDuv40oSLIfWbeqB7NKXdBX9ToeAT650C6u913TIFHLn+IiOQAO60NGJdXP7pb0cxbQxlbh797qVTYc6axVVDsx9Ec+G6MFvhT9knIs80peuF507ex1f7K9v5xlwvbmAkSsunuF2GghgZYIvWAs3xs9Cpw9eroSyQCdyKjnIHHQRROL7hxd37o7vQfDEcjXKq1OhocP+10X3+5uMs0LRluNOgaM35oJuBJWgvaMg2usmzMjFud1or62t84tqLrBbr9LieE3NQkERiJoljNGwbEN18WH6ZSmAXesEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX3JkAMzR3RRkt5iJQmBsGIpBshCzGuPRUAR8It4dWM=;
 b=RvoBDlQsHCGOKktNPFhkgpSTPtgfMe3y4bc0cf2REBgDmODF/8mi/CaIpezNkZxOh2Vvp7VuuBfFwWhzWvdTt+qLmTRN/5Sl73e9WMNAPco0oWXol5UKtQi8tQtJZGoLmLCY0+XTdVKPnxVbc+auowSvypQHTXqa+KavcGWs2zc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 23/70] mm/mmap: Change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v5 23/70] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYF954ff3vGs0hv02/74t73cSsxw==
Date:   Wed, 2 Feb 2022 02:42:08 +0000
Message-ID: <20220202024137.2516438-24-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96e65d4e-46b8-440c-6762-08d9e5f59cb4
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB41299374B166E8B3883FA762FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8n2av/+PWk1Pgk2a1mWSc4CAvwKDlXSVJ3GFzHq37CXcBDc72ojMWMicgPEOpUfzLBHD9cWw9IvAHzoW0Xq+IXrgHem12N8a3en2s7GJbusuBhRNRlIG3qysbdkRndP3IY6pYjFgsGg5kwUx/+hoI3uptomKLktcgnA2f7lvtSg60iAFsHeGUXOGPzIwIad4mi6Xi6iRxm6J3KNcFDvaA2WXTzyb0wBHZ0vT990GNxreXV3SZ8Sj6UzB1sGjHfbJAYufTcCMdeGjI/XwlDcIGmsZQujnTkoU9cS0iCI/gvbZ8BtrNoE4TWRQuHNKJg3JYupJ9gk52Bia4hrUNz+tgd6hq252XZixX7GuUEXO2sMX/4L9/QKR3ggGUcJu/AYXCUIWq2KOn/dWYL1vLoV1TqutGPFoXJ+SGFCzyHtbCQeN0o7L/QjyMIhQrUyFsHw30o89gWKfr0Qoym9BdiOGZS67H9xAhZ+zT21ET1i6r06qHS0M8QYWl2HUIOHw9ey4ylbaBM2sQnE8gxPQoFGMMQ0sTQ8f4Zm806SyYsyJEBZV6usFJ99h48KwxiJndG/LqtB99spxQ3I0/Y5dKre/ZniaL0rmuGpK/dlai7x7iNAQZtNo2a84jXK/y1iCxbng/vQh31jZKqwXw9eNNzkUMpZypBlz0oLOcyrBZiYhD718pgATgq7BdMIH01rEtXjaWeYFt0786xuTMixRInBqDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(6486002)(83380400001)(36756003)(1076003)(26005)(186003)(122000001)(38100700002)(110136005)(316002)(91956017)(44832011)(30864003)(5660300002)(2906002)(8676002)(8936002)(2616005)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(508600001)(6512007)(71200400001)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6d0WrjKgfh1U86rDHDbIn+ifYWSq14jMv0EurCgJjHTtbJD/OxKzSPR/Y8?=
 =?iso-8859-1?Q?oahG5d8dJbSSWB2iXuhmkl9wz+sv9Q8Jkn0t61o6ptZ1fLHvxPjT3eDiTV?=
 =?iso-8859-1?Q?BGEQN4hVGiGlUmGCz292waZxQZC7++41Cr+8nwvp/K3yNe/f2ZKEPduvJM?=
 =?iso-8859-1?Q?lbPAkhlafXJ15sOOQqtmEsHiMtdFeHWrI50xwMbkC4cK9TwY+/6GZ6yHLP?=
 =?iso-8859-1?Q?+qKVKiNOPYuo+GH37A6SUVAMql4d3K1hQ3XgQB9Q6iRwsvXSusE2rylbMX?=
 =?iso-8859-1?Q?zMoKWlydWh77ziV6blzmJGKXLSFxIuWd6npgUmcuJCcRGp6r5ZFAGvl9Ai?=
 =?iso-8859-1?Q?l/UhAAOSgx4G1ZvQcNjdwd2QwCTSsa1Qq7R4LX+qOCfQstJojXIxtRlCTy?=
 =?iso-8859-1?Q?qLphQBPDDW3Hy6BKXf2mf9T5opvoYVqROWfJwqZwtDw7YnY1UaL0nHJxQv?=
 =?iso-8859-1?Q?NwLymN71jJk3WwHGinWPkU0sCJWNr9DGJW+Eldmr682loWfFMyDMySEWTP?=
 =?iso-8859-1?Q?wLLc4QFwLKTfJmaEPLSiKNCeR+yD/uUHBL5HJVBTolgf0G3eXg2/9xsR13?=
 =?iso-8859-1?Q?xyNcN466Q4aWRM5mREISOuBZtP8fIgqBq78CpBpeNcjC/AiSBPEKGi6ixS?=
 =?iso-8859-1?Q?S5e+SN9CkdfOALER1Pk1PAhlgNFum465ufKAG+dhzap/hI+yx1IoZElkM5?=
 =?iso-8859-1?Q?54Ra/X3m28/sNxWMuPRwXwvWKrlRTu1Rf6Vi5zLY3leA7+51G8uZGc09K6?=
 =?iso-8859-1?Q?t/uApIsjn67hLKhj97ln2JzrBKdmFcOypm5BvUSeQITh8EEkSil0TfBpxR?=
 =?iso-8859-1?Q?lTdo3Av82lU+IboU4zjMpUScUZX4GtgVqG5J+ElkLKXMKheJBm/R/0j69K?=
 =?iso-8859-1?Q?quan5hTM5aiqkIvj/YK6VFUjCpQQImi6uoswYO4OG1x2YlaGidDqdZ3mZM?=
 =?iso-8859-1?Q?capYFEqGG0x0X006LAbYS47+ZAu5CmveRXYlYVCbfWF/lNhNlPg9OienAu?=
 =?iso-8859-1?Q?QUmHP6O97025YFNnXX0Y7oPCZgN9PMDF+xjxrSBYNYcehr3C6jVQ0OiM2u?=
 =?iso-8859-1?Q?qB6NsLU1OrKxRut2BVDIpWCS63hW6XOo0STWP2J/CslLHHXbh11xK6rU2i?=
 =?iso-8859-1?Q?n0qk3/GAGEWRChvJSCqA9XRKS4KQ+BQR7w4/IPItnTLvU3kTdFBWCUoGj4?=
 =?iso-8859-1?Q?JHa0ZDX7alrx9YbKUb/yvm9DTymdyQUQFVj3KG6oqLEzPV4ivOsStf4PzE?=
 =?iso-8859-1?Q?WhuZLkn8cjm2CawYTINrJA3g9O94egn0xjp8QDfDv+dzSb7XVl/DBO0YwX?=
 =?iso-8859-1?Q?vd0sUfayWynU8B3ZUA3t5DrHQYw1VB9L1lQFWsjl/hQCwkOxvwhcSOGmYG?=
 =?iso-8859-1?Q?Al3bdp1RSyWGcbNcAj90ai6xz9o3lNDmaZ6RyjzTbpe4ecSAcVeieK0sR1?=
 =?iso-8859-1?Q?HAGNDdiXvPf4K3oRYoPY0N40MZlCgiaP0pBFARnUmYipHujUCx6Fsqnb2h?=
 =?iso-8859-1?Q?mtuNQNSR65CzhjI5VB5A7Z66gHWbDCeIK4dE+F6uJhjj+Jsj6Ps1sCVLdh?=
 =?iso-8859-1?Q?NSQm88jXD09F6JhDHX6bsNwf7Bqd2dGiy0ChcyaX+Fu3RGHrrbSk70a6PZ?=
 =?iso-8859-1?Q?EOZCH8ZHE80cGUiq/0eM0pjV6HPbS9wOnj5RZw3NxPSP6Es44RNifXglGk?=
 =?iso-8859-1?Q?7SXmaTpkIDI52u3GhjY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e65d4e-46b8-440c-6762-08d9e5f59cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:08.5954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TeyXlyR5Jti2O+hB+0JhA/QgN+jV9cq+074l1XGab/YqwfgauFBkwmMH6dknFuf7Wa/ye1+f9mavD610kTlXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: NNuEUY8qemHFMltv3LR_uZ5MroBnWMpP
X-Proofpoint-ORIG-GUID: NNuEUY8qemHFMltv3LR_uZ5MroBnWMpP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to
split or coalesce.  This avoids unnecessary allocations/frees of maple
tree nodes and VMAs.

Move some limit & flag verifications out of the do_brk_flags() function
to use only relevant checks in the code path of bkr() and
vm_brk_flags().

Set the vma to check if it can expand in vm_brk_flags() if extra
criteria are met.

Drop userfaultfd from do_brk_flags() path and only use it in
vm_brk_flags() path since that is the only place a munmap will happen.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 317 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 256 insertions(+), 61 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 95a6dcadf529..b21fe2fa5846 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -189,17 +189,40 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+/*
+ * check_brk_limits() - Use platform specific check of range & verify mloc=
k
+ * limits.
+ * @addr: The address to check
+ * @len: The size of increase.
+ *
+ * Return: 0 on success.
+ */
+static int check_brk_limits(unsigned long addr, unsigned long len)
+{
+	unsigned long mapped_addr;
+
+	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
+	if (IS_ERR_VALUE(mapped_addr))
+		return mapped_addr;
+
+	return mlock_future_check(current->mm, current->mm->def_flags, len);
+}
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -239,37 +262,59 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto success;
 	}
=20
-	/*
-	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
-	 */
-	if (brk <=3D mm->brk) {
+	mas_set(&mas, newbrk);
+	brkvma =3D mas_walk(&mas);
+	if (brkvma) { /* munmap necessary, there is something at newbrk. */
+		/*
+		 * Always allow shrinking brk.
+		 * do_brk_munmap() may downgrade mmap_lock to read.
+		 */
 		int ret;
=20
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
-	}
+			goto success;
+		} else if (!ret)
+			goto success;
=20
+		mm->brk =3D origbrk;
+		goto out;
+	}
+	/* Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area */
+	next =3D mas_next(&mas, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
+	if (brkvma) {
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; /* Trying to map over another vma. */
+
+		if (brkvma->vm_end <=3D min_brk) {
+			brkvma =3D NULL;
+			mas_reset(&mas);
+		}
+	}
+
+	if (check_brk_limits(oldbrk, newbrk - oldbrk))
+		goto out;
+
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -2730,38 +2775,115 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * brk_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 1 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
-	int error;
-	unsigned long mapped_addr;
-	validate_mm_mt(mm);
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret =3D 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely((vma->vm_end < oldbrk) ||
+		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+		/* remove entire mapping(s) */
+		mas_set(mas, newbrk);
+		if (vma->vm_start !=3D newbrk)
+			mas_reset(mas); /* cause a re-walk for the first overlap. */
+		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret =3D 1;
=20
-	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((flags & (~VM_EXEC)) !=3D 0)
-		return -EINVAL;
-	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	/* Change the oldbrk of vma to the newbrk of the munmap area */
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
=20
-	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
-	if (IS_ERR_VALUE(mapped_addr))
-		return mapped_addr;
+	vma->vm_end =3D newbrk;
+	if (vma_mas_remove(&unmap, mas))
+		goto mas_store_fail;
=20
-	error =3D mlock_future_check(mm, mm->def_flags, len);
-	if (error)
-		return error;
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
+	unmap_pages =3D vma_pages(&unmap);
+	if (vma->vm_flags & VM_LOCKED) {
+		mm->locked_vm -=3D unmap_pages;
+		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
+	}
+
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, vma->vm_flags, -unmap_pages);
+	if (vma->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
+
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+
+mas_store_fail:
+	vma->vm_end =3D oldbrk;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
+ */
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *prev =3D NULL;
+	validate_mm_mt(mm);
=20
-	/* Check against address space limits *after* clearing old maps... */
+
+	/*
+	 * Check against address space limits by the changed size
+	 * Note: This happens *after* clearing old mappings in some code paths.
+	 */
+	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2771,28 +2893,59 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
+	mas->last =3D addr + len - 1;
+	if (vma) {
+		/*
+		 * Expand the existing vma if possible; almost never a singular
+		 * list, so this will fail ~88% of the time.
+		 */
=20
-	/*
-	 * create a vma struct for an anonymous mapping
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+		if ((!vma->anon_vma ||
+		     list_is_singular(&vma->anon_vma_chain)) &&
+		     ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)){
+			mas->index =3D vma->vm_start;
+
+			vma_adjust_trans_huge(vma, addr, addr + len, 0);
+			if (vma->anon_vma) {
+				anon_vma_lock_write(vma->anon_vma);
+				anon_vma_interval_tree_pre_update_vma(vma);
+			}
+			vma->vm_end =3D addr + len;
+			vma->vm_flags |=3D VM_SOFTDIRTY;
+			if (mas_store_gfp(mas, vma, GFP_KERNEL))
+				goto mas_mod_fail;
+
+			if (vma->anon_vma) {
+				anon_vma_interval_tree_post_update_vma(vma);
+				anon_vma_unlock_write(vma->anon_vma);
+			}
+			khugepaged_enter_vma_merge(vma, flags);
+			goto out;
+		}
+		prev =3D vma;
 	}
+	mas->index =3D addr;
+	mas_walk(mas);
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev);
+	if (vma_mas_store(vma, mas))
+		goto mas_store_fail;
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2802,15 +2955,32 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	vma->vm_flags |=3D VM_SOFTDIRTY;
 	validate_mm_mt(mm);
 	return 0;
+
+mas_store_fail:
+	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
+
+mas_mod_fail:
+	vma->vm_end =3D addr;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2821,13 +2991,38 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	/* Until we need other flags, refuse anything except VM_EXEC. */
+	if ((flags & (~VM_EXEC)) !=3D 0)
+		return -EINVAL;
+
+	ret =3D check_brk_limits(addr, len);
+	if (ret)
+		goto limits_failed;
+
+	if (find_vma_intersection(mm, addr, addr + len))
+		ret =3D do_munmap(mm, addr, len, &uf);
+
+	if (ret)
+		goto munmap_failed;
+
+	vma =3D mas_prev(&mas, 0);
+	if (vma && (vma->vm_file || (vma->vm_ops && vma->vm_ops->close))) {
+		mas_reset(&mas);
+		vma =3D NULL;
+	}
+
+	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
+
+munmap_failed:
+limits_failed:
+	mmap_write_unlock(mm);
+	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
=20
--=20
2.34.1
