Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7637A4A6A28
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbiBBCop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36472 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244184AbiBBCm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:57 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120QIZi015788;
        Wed, 2 Feb 2022 02:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=f10PNlILbdyuVdKX1mrOrc6nMHulUjHGT/q9NU7AbWA=;
 b=Gnb/fcJKsaS1ZKlrcR9GSdUfdoL282UolLebTOkAnnHIMfEBbXFL4kJcXsfOKGh6xM4q
 kBuw6xehNEaHgwf+T3qoc9aXCMJcxthB7E+i3I/gL+RjC3UhvIpCXerdcKNNsSfZxLJQ
 8iwK+OhoJmCkMtqBBf3uumVUGVlHbq1hg8gl+B0SrMmQnIzBzKcleDhFRH4jQONKv2n5
 P3OemfhJ8rSwrlz4UhTH/6k6jUdzc264GiUM5zCXkjffOgsltgI9GDG2E+/yebH7/JXI
 mO/h8K6ApB3QJXwdx2kiQJafh9GKa0c8s25nr8wruChxEPUGCWuz7kUk4OIUU0S1vblK Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcnw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zweh015318;
        Wed, 2 Feb 2022 02:42:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dvumggu7d-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h876qlUBSO/uz4JoJoToP+ldx/sAiNaSeSWUUynoTG9v30YwtTTmgnx/HUw4JeQ4mj7lg13AYKbeslQZpeOJuFVdw4N/kONHEyFcMp4y6PtU/h6OGPg2QvMa8jlK4NwnqNQoLHaZ2LgOXtS7wJ9fJ/Jla9EmtNCTU6UUQreebzj9XtK/j7edf8a3ex8q56WYda1xIabzLOUlAZFGZU76t1AlVP53hegzysiDlnF2Ws+NHneV52/T1s4AwXNJaYF7B6XKX5hoPtwtomWg5tXAxxMWdS3hpMNg68DJ3H3qz80Xbt3Qqr8co3MdGQ7UVkDx8d43rXSRkyU9hhnqnSVhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f10PNlILbdyuVdKX1mrOrc6nMHulUjHGT/q9NU7AbWA=;
 b=c/kJRm/D0UQGQAgXenf0CWQAYm495zPTzTiYY3D2LCtWN/VeMxPgqztyfx5Fy6sr4rGJVnw84mqMmhe0JL2G0xNHdlv1iO65PYWKvXPc9Ha3jnAWplju3zRbmTbR2vEyKAfTWjuoPGQnZ3k54PPRCBsUZsK4p5N16KrcOeKh4cisfOT06QAuVSN0Gh5G+DDdOTothoXbqQHLeo/QrGA2/cQF9oyG5DejkCPVpvVtMtVZeqyw9z6g2xEsMulEEMWSXYFNbhwRIc2KmqDXZmAO1yxlNJbNFtt4ynuQoHWQxDArExcMufoyp60zwrxCx5CpTK+2KTvgsosKPywwxjmLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f10PNlILbdyuVdKX1mrOrc6nMHulUjHGT/q9NU7AbWA=;
 b=A/HmAJ+JMG56aiLoMYVJ98gZ5myjY6/NY9ASzJMS8L+e9DX2ok6KWgBR+ZS7j67gRBr4hP9yPPJa8AK5g5bM8U39oKnF1XZCoqbMX51TXNXzX4lOUgLxXHmECsILxufMdbnZKtPThVgt8I3RdAxpL3xV8KKMDpOnYBYm7zl8z1M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 40/70] binfmt_elf: Remove vma linked list walk
Thread-Topic: [PATCH v5 40/70] binfmt_elf: Remove vma linked list walk
Thread-Index: AQHYF958LmyPp3yJK0qJ92gjKkaIlg==
Date:   Wed, 2 Feb 2022 02:42:15 +0000
Message-ID: <20220202024137.2516438-41-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2d795c5-86e3-4852-bab7-08d9e5f5b37b
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4129A4A04205D72CF62BB601FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovySZg2HMZdvsU/NQnWFpYMsgADXIZYkXet4PvC9l/y1XYI0N4cbsQSWVlP48xAuP5i6296A41byco7uRBbnlg4aQem55OgbmoLfMK6jtZJ9xexG3nYWBAdJvISUh3lOk5zkcoMTld9hEqMuMDIupofOs093aSxWg0uAMy9lZv/SgjtWCbBJZcnPYtoPYXKrRH0jsT05ZPyizmfdzuaKrRXryFqJ0vvz0W6HV1KjCLALs0VhU/qE1RP7iMXdHXLrre2LdrEv4FWp0smpEBVpyaJVHpQLl6V0MScyQWr3oQWwV64Es7czM95P9ibJ2z+2jXePGONyprbXZTH7QXoaWa0LM480FVqVY3VcMcQx2n/ac5XJv3cPCjgF4SsQOVzVs+86+t4DCgI551+CaRaVGWAsTOw1ld4V09vkRah8BlSReEvSyVPvvjYlVLRchBPyCT2ZL+F7Kg+BJq1VhMn3XrY8l7x5y8mZq5kmz8SYX4fapQ8qOvOn5sfVsBrVCmw7zErG+Ycj7ZNcUfrU30AhNWeYGSHujHbn2TpaHX/u2L9aUrc+99wT36NCiAD0+mghjcO6eahyXiEYxmq3LGnKJ4rPZXXzfoDfW3tutcnVnmysFuJnzD+qEBTRlV4b/cE+i8ZOAKJ4py05x+gOhXEbVqcINntxmv9667OspclbVofVtYN+hMxSvMvhQXgqwCo97a4Y0eaU+9kUXDXF1RtLVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2616005)(66946007)(5660300002)(91956017)(44832011)(4744005)(6512007)(86362001)(71200400001)(6506007)(6666004)(508600001)(6486002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(110136005)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hKRFkuYYAvjiRWlaP1YWJ9oyL7yklEg4EGq6uZL3O9P+GWrAIeLGYkSMl9?=
 =?iso-8859-1?Q?vAsZRl682LK41oSUvn6dd3EDirOycwLz8j3cTLJCsuNgULpeQpDzTM9BcE?=
 =?iso-8859-1?Q?GBt0ILci5h3PXFAYpzWs1LSubJPTD0SCeCnktDw0z5i8BdPgfBkTroH14q?=
 =?iso-8859-1?Q?84Vj4ONF4bApdXwomGxnvC9UO+i0/ilBtYJ9no+lXCIyTmQL+lkCWYPbKn?=
 =?iso-8859-1?Q?m6qd6UbiLM8JBJOtuthzchOeD7c28RPqmtYLgOgm+amwuQ6SisdYOzuj9J?=
 =?iso-8859-1?Q?+opkhHnOxSHoCVSau4F5vVC5j8nwuYrElq17lVVjBY3Jd968nAk2KjPvLb?=
 =?iso-8859-1?Q?+qTwnrbKJSDlKVqbalFjjEasVD+0AElq7yOkzxZpKnA8w/wVr4MkIdLijN?=
 =?iso-8859-1?Q?znxqjpumxwbuFRjWZwz/N/smxtnXCCHFfEhoME98zqDmyZN5ewb7UjL4mt?=
 =?iso-8859-1?Q?J+WKELjWIb2Rc/ofN+7MPfFVdC11EgSpZdl2d/exWldwtogogswkz8ODmo?=
 =?iso-8859-1?Q?cAXXkoPCdyWMZBEZI4l1IajjBZvyK7NeVMYlWl0a8rhhinvO/HL4vmWsAc?=
 =?iso-8859-1?Q?gqi7g3PvpX1dB4mmMLsURHquVpeq3JwCSEgpW9lV83l4m5uFBuHa9I22sI?=
 =?iso-8859-1?Q?P/DbVY+cdy7jlITw1HyjqvO1fmI+FWiOeCn7aBL6Uc8ZVIKgbmFVOhVoNR?=
 =?iso-8859-1?Q?Q4YMUlQ75BFZLrJBF2jo4L1kFZ2WYOz/SGKlFMo+asoPeaxQ6/dmp1Jpfj?=
 =?iso-8859-1?Q?6LvOEjMk5yoDoak0sTi+FpZNTBuqZDFYgF/RIA2p6ly19xxu598HpXUQ/m?=
 =?iso-8859-1?Q?CpDlUWM+HiXOFMY6kLShQsVAEpJET16RbT8/YrOO/X4+rvxmhi0ZQlDYeN?=
 =?iso-8859-1?Q?K5dQMoZiTTZJBnYrthrGH2tbGDA8Bb4y1/QwXZWy/IOo9EHh86+mEAak93?=
 =?iso-8859-1?Q?pFkbS5jUpl9nDPvM7m61q/HUI1fRRc25mT54D24B1J5bSsCPrdzhUXaymc?=
 =?iso-8859-1?Q?JvKEONLp0VANB6p9Eecm0wIzWJQwn3nj8ldbXKqCm0aIWFdjjXPUFK2stb?=
 =?iso-8859-1?Q?mw49b6fQPQmUiwfgRCClqBIm/uTuq20T5m1x6p+wu9JKBGJHzaWGLpdO7m?=
 =?iso-8859-1?Q?tuHFMqJW/Y9u3dUIXklpPC6no1YGZBts/tV/cJ8BQTdmm8E++c5bhSL7FC?=
 =?iso-8859-1?Q?UofFMBspQQENunW1vhBmuKZDCPwo09hDpp3l7d1Gv6dte8xnGBZ4HhXCqC?=
 =?iso-8859-1?Q?gxJF4zaumZhZiAu2ifjmHKTjmnGymmAioAnSS+QIqYoS6PXd1lYijBqE3B?=
 =?iso-8859-1?Q?DrrmN0aBO73R7uS/vSDbt+1Co0FOELZFx7NB2Tpj2p6T/VRVPpOgI/mifA?=
 =?iso-8859-1?Q?Gm7LjyZuGT46f0Qp96JpzILYiNNKWXypErpbBeZQ12hsf9lozJXEVdjyNP?=
 =?iso-8859-1?Q?K0vAsX1B1ZmX8PQULdvuB8FARSvn0aFGNudjnKyBSktroFEutCy2SZWvOT?=
 =?iso-8859-1?Q?Mre4iPPnCgiNjeUoN3CA5RehtBiKWz5bX6WbcYw+lqRuhL7wgc/TrBS8tW?=
 =?iso-8859-1?Q?SElffUHPHOj6RwHsT40c2OAQ//TpL3SfJiZrDrZYxr4+U19U8iuGRaBVkc?=
 =?iso-8859-1?Q?p2ox14Yst2PKn7TzLzodo1ZrqWbIzgoYyCbU2HtX5LNbt7D6HhwgUihsxt?=
 =?iso-8859-1?Q?VevoUwRZ/VuP5OCOLKo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d795c5-86e3-4852-bab7-08d9e5f5b37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:15.1262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36ryEU7V7Edk4yWBsB/rv+2wvQrjrPTeQZYKAwuttf0A1RU/tnj+QM2IhwO7gxoohg50wY/Q65jpjQczRvxH2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: BqUV8RiHYAcMC5hs7faY8CsQJTW8VgOR
X-Proofpoint-GUID: BqUV8RiHYAcMC5hs7faY8CsQJTW8VgOR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/binfmt_elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index dc2318355762..a8aaadbb273b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1622,6 +1622,7 @@ static void fill_siginfo_note(struct memelfnote *note=
, user_siginfo_t *csigdata,
 static int fill_files_note(struct memelfnote *note)
 {
 	struct mm_struct *mm =3D current->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	unsigned count, size, names_ofs, remaining, n;
 	user_long_t *data;
@@ -1652,7 +1653,7 @@ static int fill_files_note(struct memelfnote *note)
 	remaining =3D size - names_ofs;
 	count =3D 0;
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		struct file *file;
 		const char *filename;
=20
--=20
2.34.1
