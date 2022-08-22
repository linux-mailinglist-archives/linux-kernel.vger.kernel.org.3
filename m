Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D246559C272
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiHVPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbiHVPPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:15:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5BD41D2A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:10:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEpmVs016597;
        Mon, 22 Aug 2022 15:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TJ1n7nQzGXDEsEXJXm7ErfHCrlkOAFr37HZ8E2mDTAs=;
 b=MiH59IOyGvkpnTg7q4tlj8tooGgv3hITz3VaUkX4HhqPVyIHq5DWP9diYZjPSGqJdpTm
 pH2y6BTK4kpaOJj9T/sLMejHSX2M24VAIy9GQT6r83M6QRgJ2Dr4/q7VBSgXfgq/hbad
 kh39QaEiFGjFN9StjpBCRQvQ/F1RY8cU5wuYBpxXvlXkfrLCabN2ltATTd3BMPfpJahQ
 Eg4MqD2j/J0pUvfNrvNL86ibetkbwCCJhW4/6FeA8Scq2ciJhLktW20uK1aP54QqO47+
 Xcm74IP47uOwiUoifJtrjylkGgFvLBq4sPms9YoRNS7oVO6O1kqoW4DODmTfW3BKu4r+ 3g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx6821v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:10:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NPa026592;
        Mon, 22 Aug 2022 15:05:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm8bcpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgkpnpkSF6HoejT32HpSqVb+Lj2goQ2YQpK9VCDQxjjTrv+qL8l10ROah0Jn8qgS5AxaJ265I26hYRbvczR/dguw6I2RvGdmmSMxBPlqyAdrcSewfKTiEE524qfDMlB8UCJCYKx5LNEN464JSuSGnuOzUyzvqZL0bPolj6RWkqD8gbyRBDaxXa1FWz7e/pp9HBrburcD7SXk79/X0d4BTwoywgyO0FmVoJNVE459nDT7R2qHV2AA4sE1StG8kGQh4+jawpwljjHPmpf0ub7x56ku8HIXJiD9X2MYuwjldX6r1v7LYL/wquuq29xni3kecf9PzGHQlms15KyU8OZacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ1n7nQzGXDEsEXJXm7ErfHCrlkOAFr37HZ8E2mDTAs=;
 b=G1Z99IRomKF1N2JUgSE7QM8nxF6VzhYPK2S3GwBhmOlEg4y+pMHOH5MC7dLO6B5IUxr+OqMUK+8MnQaKkK1UfCt8APceDetS0gSfw2EoaIRwCDfs4Vsc2uwyq5uxFHK1SYIPqGq3DVZdEMTghfBidZ2XGSlsbh63hiq0IEVTgC/2i9OMiW21lUqM8cHfHo2eqexvuCRs/yNjumIXYyBZ2Ppdk8ntDogONIPZrofreSbERhzqHjwB8Kse2Oe8QSIjbRN63QuVuDMFWIU5n+9C3sXozOgcQk74YQqpawY82l1HXgmLKDyuBwYqXr0LYUq0zhozycyyBrgFBG5e8apHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ1n7nQzGXDEsEXJXm7ErfHCrlkOAFr37HZ8E2mDTAs=;
 b=OOHNb3o1G8CAJ8QebLHM/SHJcjedUlpC1rPBL0TtmbrsM4uPGOVlvcw1OmkKRli8/Oo5W+hHO2n9BGQSIgvUXyZFnGbbyZVju1A+h7z0dUH5t2sLwr3sYrZw1iEWGqqpJE8v7IiCJma7hJOvOO3/2ptGr1sJ5CUmP1sCqdUdhZg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:05:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 28/70] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v13 28/70] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYtjiXIqzRqnV85kiLPBT4Zieruw==
Date:   Mon, 22 Aug 2022 15:05:17 +0000
Message-ID: <20220822150128.1562046-29-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f604266e-d6d6-4dfa-c736-08da844fb998
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5j1Ut2iE9q2L6lkExc6vO1+dsPzt2nWItYLJs1hff43+GRZPq1eZeUE+wNba4mJhhyBUrcOFFAq6yeDlXuWMt64wsj+sNVaKDpm7/rFlDBrO6S/9KQ2N/yFzpxAMNjivU0c8M2gbJMkU+BzD5rqzdL7Ypnthe8WPVUmhdBvHI8mgYkjhP2JQNOb63eVzQAqQTqFVTDZP+mHiCocXCgIzAcYPoDn1GW7cxBvU5zEbZFTk8ocygF3BkVvXdg4zDWQuwZsadgfzZP93XVzjBVDwag9/eNoE9jnDMPP2bSn+mBOP0fHj3KL0pG64aBTirwAVLTIIMQcRURPrMl5rhhunYrago++jy4oR+qxEbRV4VMBSNKW9+N2LsZIAQT30fGEnlkCH5rYczFBKWpZK97/CKPuQlpcfDpmQu+ijnK1EyMGCm6PjZ8sclhkHzluJSxFtN8JVY5VVBTyGfQfeKv0Yrb6OfC9FOy/+RxZ0ghjl4mi/BkIpngVmim5ssYlSDa2a8tg/x7X9gLEW5XDsAu8DStaSl6dsFKPtoPrsi7sIwNinXQkhkA/7HIMb7mTnTw+tMMB7N4kkfABIgexCdfr7Q4QplNgWZ0nqAVx9hy4Ne8v/oJ4eg3y7XkOlFz6an83c50vlpLjIM8m+AeQGvvuhxhWYpJx3SiN2aLqKOEt9BjIOSgaLZGbfxN7sHxq3PfIcCnriNwgMnGPAyQMBUHStO475PnMQvAL8EbEcN9f2MMTsvn3/c5wetsKvZc0ujN2WMrIvFHtgjJNDO4cKs2fp1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(2906002)(86362001)(6506007)(1076003)(2616005)(107886003)(6512007)(38100700002)(186003)(122000001)(83380400001)(38070700005)(110136005)(8936002)(36756003)(71200400001)(316002)(6486002)(478600001)(91956017)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(44832011)(30864003)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v2FEgPvobiF5PVMAHTjyoyPMAhdYhyk7iwOSKoe3owX+PO4V5Moqri8qTd?=
 =?iso-8859-1?Q?GXi26TbQtam9Sbcme/ioYANLzIiSbwWUb2ftj0yc48GmKmrRjaGgVlUdM+?=
 =?iso-8859-1?Q?ES3nbVkepOYyIpWL18o1tNntPzMYhLufNDJLJzYOi3wvCQRLFBF8GmWrnt?=
 =?iso-8859-1?Q?HjltA/O1K71ZxMGqFBwT/atGmGFTmV6rCt7q1YUttN5UmlNzmwNErGZk+I?=
 =?iso-8859-1?Q?haVZyP3vfQqYQy7dcBbUaMaGnXqwemVwz0GG6PCl5ZToxN0T729EOOhOdb?=
 =?iso-8859-1?Q?XCjCGSsr+Xw8YmXQXOolVUp6PbpvCsv44AtxdVLpqpplx3TlsVK8gDpKZG?=
 =?iso-8859-1?Q?6dvf+ZmCzlr1WGXak9ecckhNs1g04XbaG+GXNbrusvkT946q8aHz8ZGXkh?=
 =?iso-8859-1?Q?YaHtJj0Iiap2oV6vcOoWPyJznK6ZyCn+3/Nto2Pv2PmCMxjl3wxRuDVcvG?=
 =?iso-8859-1?Q?OH6X65bxHPx/sSFnBXP1Tn6UafyyRnvdsDnDwCCpOu+6g/C93816fFkkVg?=
 =?iso-8859-1?Q?XEda5GTUobf1RbkiL6SlgelwqKzhFZAV+I8upDHuunqS/r1E+tatD4Q0uP?=
 =?iso-8859-1?Q?S9YaJDnkH3+VFYxylJuuEavUBrdse7tvTVP7z2dc0YHdUoV76L8QLf/Nv3?=
 =?iso-8859-1?Q?K0qLiCpt/S0ntxWpxIknJgxg7PNsCCBgyraoCq7JYHD5X5ufMUeRGkzI4d?=
 =?iso-8859-1?Q?lU5z6DPBBZFYMNVnCC06r6T8m+kUreX4iuPoed77CLMRkunFROXRK5Vzjg?=
 =?iso-8859-1?Q?WS7w60VlWvLJoiflyaQvhXHc4e3aTNTE9t+rx7jvWomaALMlxUDtGKpofc?=
 =?iso-8859-1?Q?ie+0+Jgk25QsbdZjmjif4E2SLcUwvwzOtuxW3rbjRj+AKTl79+AzJmM3bG?=
 =?iso-8859-1?Q?OfEzKtPM2jJ9Coh+wxVegtt6L9Gi5tbtfReLXHHq4OL6sWPBeyk+ykDDc1?=
 =?iso-8859-1?Q?Gpmku4/ORMBO1Cor4q9NTmEA2G7OCZhN9kv3p4kT3FjImEug353ohqoXsa?=
 =?iso-8859-1?Q?zwL0cEEnHgiPx+jpgUeBVMDpHo6f61FrR/0Yk37jvWkkMGIarYnbxfIfdf?=
 =?iso-8859-1?Q?GO0XuRW72utUzfbPvNtPkfm78l8XJHeExeRiRX+8yRx6bpcko7NNlQLKJz?=
 =?iso-8859-1?Q?yNDEzEs+AlEwR6ieBX0kc+5qE1JWwCqR9NBlvGMuNUM4PFczMnAqQh9Qh4?=
 =?iso-8859-1?Q?XIoiukGxiMGJ4vjHUSt1veEJHvB62/F6fVT05TDxJipgxgqOYhRYPp6/Lw?=
 =?iso-8859-1?Q?xrHuEA+c2W90DiaagLOPsCjvPtFr2vU7USbu7aj5cGo66r0hfikaejVPyq?=
 =?iso-8859-1?Q?ORZ31ynqiB4iw+s7Jqlj7VQXntIc9T2sZwn+Igk0xEKfGPyDRzc4bQrEQr?=
 =?iso-8859-1?Q?bNCV1yNvAdtYVsEIw5Ti0Z9pkAGWUBOihWKY62Lt9oCjsLh1g9bXdWJC3g?=
 =?iso-8859-1?Q?QLCDJ1BGUrhKRyFijiqtyvTB9rhf3Nd+vR2bu4A6MOp76h3hAyd+sgKF6E?=
 =?iso-8859-1?Q?yEtJ+rJS0Yl5zBWdhQNVhT4zLPD0q0cSzeLpaf3/ljeKZJiiWYOqnO9zqX?=
 =?iso-8859-1?Q?e9MQtDifpQv2GehnhrhbByKEaiG5FJTjSTPtTQwiPlJaO8h+pwBsxwcFS6?=
 =?iso-8859-1?Q?fNk3nKlpHIsvvL2bsJEBVfM5n1jndFt+SiLdReC4OCMIZUmyFU9LdRqQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f604266e-d6d6-4dfa-c736-08da844fb998
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:17.7270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8y9Th9grDgDW29WFj5EBRPtaYsE3EEwhCqDSukMh2baePhCZVX5VJmaZLxkrue10rf8DiFFcRhLrR9h6uHmYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: UzF3Pi5oupwR8EFZ3YavAd2D3Heh39Qg
X-Proofpoint-GUID: UzF3Pi5oupwR8EFZ3YavAd2D3Heh39Qg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
do_mas_align_munmap().

do_munmap() is a wrapper to create a maple state for any callers that have
not been converted to the maple tree.

do_mas_munmap() takes a maple state to mumap a range.  This is just a
small function which checks for error conditions and aligns the end of the
range.

do_mas_align_munmap() uses the aligned range to mumap a range.
do_mas_align_munmap() starts with the first VMA in the range, then finds
the last VMA in the range.  Both start and end are split if necessary.
Then the VMAs are removed from the linked list and the mm mlock count is
updated at the same time.  Followed by a single tree operation of
overwriting the area in with a NULL.  Finally, the detached list is
unmapped and freed.

By reorganizing the munmap calls as outlined, it is now possible to avoid
extra work of aligning pre-aligned callers which are known to be safe,
avoid extra VMA lookups or tree walks for modifications.

detach_vmas_to_be_unmapped() is no longer used, so drop this code.

vm_brk_flags() can just call the do_mas_munmap() as it checks for
intersecting VMAs directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 228 ++++++++++++++++++++++++++++-----------------
 mm/mremap.c        |  17 ++--
 3 files changed, 158 insertions(+), 92 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc6b7ecf93bd..254ea6c9666a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2702,8 +2702,9 @@ extern unsigned long mmap_region(struct file *file, u=
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
index 0f4e21a405f6..1c90a58b9cd8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2362,47 +2362,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct ma_state *mas,
-	struct vm_area_struct *vma, struct vm_area_struct *prev,
-	unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mas_szero(mas, vma->vm_start, end);
-	do {
-		if (vma->vm_flags & VM_LOCKED)
-			mm->locked_vm -=3D vma_pages(vma);
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
@@ -2485,40 +2444,51 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
- */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+static inline int
+unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
+	     unsigned long limit)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
-	int error =3D -ENOMEM;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct mm_struct *mm =3D start->vm_mm;
+	struct vm_area_struct *tmp =3D start;
+	int count =3D 0;
=20
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
-		return -EINVAL;
+	while (tmp && tmp->vm_start < limit) {
+		*tail =3D tmp;
+		count++;
+		if (tmp->vm_flags & VM_LOCKED)
+			mm->locked_vm -=3D vma_pages(tmp);
=20
-	len =3D PAGE_ALIGN(len);
-	end =3D start + len;
-	if (len =3D=3D 0)
-		return -EINVAL;
+		tmp =3D tmp->vm_next;
+	}
=20
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
+	return count;
+}
=20
-	/* Find the first overlapping VMA where start < vma->vm_end */
-	vma =3D find_vma_intersection(mm, start, end);
-	if (!vma)
-		return 0;
+/*
+ * do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
+ *
+ * If @downgrade is true, check return code for potential release of the l=
ock.
+ */
+static int
+do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool downgrade)
+{
+	struct vm_area_struct *prev, *last;
+	int error =3D -ENOMEM;
+	/* we have start < vma->vm_end  */
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
 		return -ENOMEM;
-	prev =3D vma->vm_prev;
-	/* we have start < vma->vm_end  */
=20
+	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2539,17 +2509,31 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
 			goto split_failed;
+
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
 		error =3D __split_vma(mm, last, end, 1);
+
 		if (error)
 			goto split_failed;
+
+		if (vma =3D=3D last)
+			vma =3D __vma_next(mm, prev);
+		mas_reset(mas);
 	}
-	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2562,16 +2546,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			goto userfaultfd_error;
 	}
=20
-	/* Detach vmas from rbtree */
-	if (!detach_vmas_to_be_unmapped(mm, &mas, vma, prev, end))
-		downgrade =3D false;
+	/*
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
+	 */
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_prealloc(mas, NULL);
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
+
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
+		else
+			mmap_write_downgrade(mm);
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -2585,14 +2599,63 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 map_count_exceeded:
 split_failed:
 userfaultfd_error:
-	mas_destroy(&mas);
+	mas_destroy(mas);
 	return error;
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
+ * This function takes a @mas that is either pointing to the previous VMA =
or set
+ * to MA_START and sets it up to remove the mapping(s).  The @len will be
+ * aligned and any arch_unmap work will be preformed.
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
@@ -2626,7 +2689,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2845,11 +2908,12 @@ static int __vm_munmap(unsigned long start, size_t =
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
@@ -2978,7 +3042,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-	ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+	ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 	validate_mm_mt(mm);
 	return ret;
 }
@@ -3118,9 +3182,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	if (find_vma_intersection(mm, addr, addr + len))
-		ret =3D do_munmap(mm, addr, len, &uf);
-
+	ret =3D do_mas_munmap(&mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index b522cd0259a0..e0fba9004246 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -975,20 +975,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
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
--=20
2.35.1
