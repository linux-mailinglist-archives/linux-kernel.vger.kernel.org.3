Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEDE4A6A46
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbiBBCqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55728 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244409AbiBBCnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:39 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21207Sdc022133;
        Wed, 2 Feb 2022 02:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5qCx1j+0CGYKIpc9uCbEtwe2aJKhQY3ouZEvKLAzhRA=;
 b=fjFNYnbKdkzUBpUqvjL9REUW9pGA16IK2M4MHDc6mQAcfodX0LKLgz2FPNioPKF0JHOF
 BFXr7wqGtgEhdVdmyI8cm3s3ckxUatWRIaK3/KToiDsvnNCZoyD1jaObezXTvZIvnZQi
 XJET8ujNUarJGHyCNs6b4I9vog7pM9jlqJHs0PRMTnmGuGjwFwU7BxyQd2Zt0qBkA+4v
 yXkM8o3pJQkHFv2Irw1+GBYUar3wHrjpKNnemIYvdREso+yVu0YO+Eg7EvNG6MumBhFu
 it7owdZgGU4Z5cX7/hSUa67gLbm661YCyMYMwWmqaCbrWxVjgaGblaAuFoFEFdKB+2Eh 6w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPVZ146749;
        Wed, 2 Feb 2022 02:43:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3020.oracle.com with ESMTP id 3dvwd78wmn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6xc1vdD/TGOsbT9lZhMS/DgVI6ExN9Fc0nKNqrnNSPbvgRUovrOqL1RXIYq4uaE/q0sp6/oQUmJApGObQ0kVeEBwOTmNsYkgZZzzx1v+qLvGkJ8RtreXT5GyzNY3CVEPOgXs/M/9guuV9ICGCEXzTOWop3FZDmI7tcMIKEz3ljviSQOh4CtubviJpNTHHGkJsSUOpL2KwTV6Y/TLJ/qfnv7bURduiyubFC68I/MOETrlt9TARtEPK6nif8gXfzXV2mFUGNowpGceYUvxh35X4v319ljXCBynA/YUes3xCF+H+gVY6Q/82TKln/1EeofRv77oZLYGJKksDAozpRvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qCx1j+0CGYKIpc9uCbEtwe2aJKhQY3ouZEvKLAzhRA=;
 b=NKluklBo6NqOKZYx885DshlEoHaqWq9ZbVpjN7kbsYOhyeJ/rFBuBFWNHQyV3HZrokAUnFZpXK2GiSik1HLWVh8hpL9L/ky2JYeCOT+KQswc2QyXOXgl0yxqiBCtT/x2ktO7yklP4jOxlqvoY7FyfD2QYZ2+hIW4hK4k4f7/2RN4jP5sFbqGFa/aFocopnS0+PWBuHJ9du/+qDLDLk4tkZsRjNTgl07bgraG4M9qJjlPFk6tB5qnQAJeyirJFsKkIOwnkcwIxRNPdvegMa+eowapojJdGyYMAhEcTjuIKBWYS1XrOpzDpndkAxrtEqz/bARXidGJVXZS6vZUpSqAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qCx1j+0CGYKIpc9uCbEtwe2aJKhQY3ouZEvKLAzhRA=;
 b=st9bHOA47rW8t1sZUqkcCg+5C88Ngn/b7Zeee4dZnqanZLsQlao9UdCVa4ZoL0wgcrBlObePrKxoBGs85i8mpSZuwfoehjDxiNwaGwwMKCUVWaDtfH31e9THaOT8wLOuqb868v2T90QPJaLy4ZdS9dA4fy18eifCZUXjyGHSDD0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:43:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:43:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 64/70] mm/swapfile: Use vma iterator instead of vma linked
 list
Thread-Topic: [PATCH v5 64/70] mm/swapfile: Use vma iterator instead of vma
 linked list
Thread-Index: AQHYF96CbuoSwLMC+UuVln+7/64Y4Q==
Date:   Wed, 2 Feb 2022 02:42:24 +0000
Message-ID: <20220202024137.2516438-65-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e26eea2f-14ce-4671-bcdf-08d9e5f5cb9c
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5865B7359FC767B10EC49AF0FD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WV4roZg+1tg1Att6Lrr+tXJHSKn8JQZpNxLG1HZl+YO7wG7uEWYiRSo2y4Lcw/kVSjEq12t+Lb4DXEkzM5aFHh1e7radBCLd0UK/czAhWmeh93Lfmo4X1pcrdFwX4j6vGKtxaDf30JtOSVTYiYpnaLvqTqdmOMNs40J6Hik15iVkzTJNW3oXB5EVajZ2/7l1v2p9N2vQO6jhC+BTl8bWtnK5HO5M+KJWpgt3kwGirKlgZyRx7OXuUjwcXQ6ErLh/9kTZTqfoAUE0HcHHfi44epjIxAWKE6HkfsT/RFSph1HzHOUPPI9TTj/aqRk1IeqZv59IPGj7umE/eUb/CwNaHXSCqBrXbJ94BWIVsGyqRqSIe1psBwOjzz0v2VE0w0f2kIKAuVMWt7pEEK3OAXuO5Npu9xkHV4fJHBvEfaRkB8mnBn2w4tAc7Gn1Lesha7Uv2PLS/+WtsVUxeHDct365l8U8R9JYuMRESmJtDeTIU7SMvFSxQ+7xmOFU/4hSgLWphefKdMM2Vt4mgh5UZ5ynF7WpvGegtXEh0AwcT5rQn3Kkudh/RICaxrWd2u0z0UpuC6li/AfvqYueZA9MMHBXqFT7aQAKjBkQP4b9kiCszxRUjV8jrpl0sGLmI7xgCfbg5KhsHvfxo/7znZAbGh7yb4WLrPlOg5EeOeLPvCLbCIWBS9tp2CGUpkrg8PpqUr7LuigbKS/bVbPCDZClipTVyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(4744005)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gnblhIQM4p1DujzEAHKKNrqdHwRwYkji8GXXx7kWuyM7AhjglUmjgfj6/z?=
 =?iso-8859-1?Q?Ge4GJ+QM9Mbv5advnxrA2aGt4JQ3UuNdyBhaXjwkDMHgyU5YGwT8GvEsJq?=
 =?iso-8859-1?Q?VOk6L11tM5gcRk3fz0TtS5Wu18IMCLYJXJHjbNSa8fwGEGAkhEDPb3+qQU?=
 =?iso-8859-1?Q?koDSCMb3dfz6i34GptYnccuFDG/fdsx/0bxsd/BVKkoJrEA/5b4lgEAyRs?=
 =?iso-8859-1?Q?QdwMXn41YLjx6Yd7phazlYP8I+kXw4qNoWvfBtxAZbrPN7V4aggSmUOVVW?=
 =?iso-8859-1?Q?JYgWotC3ch09xLLuo2qSrG5yxS1/IA0/phO25rMN/Xj7UAck0uuYqaJ0XP?=
 =?iso-8859-1?Q?stW/IYdPMDTXZU/OkZ73LLHiM9SwlX7WRrCTbteFUn6z4KwtZmBkSFcJQO?=
 =?iso-8859-1?Q?3EboYDXt9fq24Q4JU2pDYeg3oC79TbYRsm4U5Mo8c79EkLmypBdIZ125Br?=
 =?iso-8859-1?Q?vFXhdIMG2jB6ewpVtIeGhz2M9Rfim9AjXvrnEfja02yzG0bTpkb2K02BOl?=
 =?iso-8859-1?Q?g2x4WbDXLnjxvXK4uwdxYP1K5Xj9XG7oEw8fQGYJRoXM+F99qJIM//QEbb?=
 =?iso-8859-1?Q?LBO5hDtYqpPpH46jJaFgBIE8QVI779AH6WpcT1E57i2kyuPEXuj1SQilHc?=
 =?iso-8859-1?Q?iRpL9A13UMaSXqGm9Aq8X/sc+6lnHEv5M01r/bsFriSnSFkh4cqROsJwkW?=
 =?iso-8859-1?Q?3zrfNt6Vifnxk+0q/4ST3//KulJcv86FxB1mhrL8RWmRXf8jEvrLs2xPhX?=
 =?iso-8859-1?Q?JF0+mm0PWC+ZwJBzCEjErWBDRpWqKm7xjsFGCgOD+H250kjem9mnIDv135?=
 =?iso-8859-1?Q?x0Tr7OCrw5ds2DhB9fW3BvpkPEq3Cj4QjNFJN6OVtKJXSu0lZv2UGMQOfm?=
 =?iso-8859-1?Q?c/p1R6jiO6yzsUPvUUKHpaJGk9N8y3u2Po3l13O66dPYYA9Ggvr39QH0mJ?=
 =?iso-8859-1?Q?BrQKSgmTKzr3llqKR+dO07+a2NgLH8BBIGoZDLI3rcboAumIHPQSrN5PM6?=
 =?iso-8859-1?Q?B9F8gKSs23aUzkV+tu2UROGy3pQD55nMJjZSVV60XGwMAYRRu8yJQ0rEhe?=
 =?iso-8859-1?Q?1k5BGMZKB573wBSJFZVu+psTs8qmv2KZ9wQoPeF4ALz6/01njO9Xx9ylk5?=
 =?iso-8859-1?Q?pzPOFkezKEsSdolQAnvIEOfTEgsLZ/bsxYpO9TU7Bhq7Gb7OPvy/U7d1U2?=
 =?iso-8859-1?Q?7OidCSEiAJG4TC5uac1gVznJRpxFs0nsC2WBEWR7mWCLPAco6uxT9Qp/v9?=
 =?iso-8859-1?Q?pgaY9+iKUFY1jOkjzTQqbzbf+eEKo0ip8cbieu6UeU6Z1jXW6c6u09NIo7?=
 =?iso-8859-1?Q?C+FvOFSH+xQsa6IzdYBou9HHl8CYIoShSWM946P4WK/8Fg4ceGvBrzIEqH?=
 =?iso-8859-1?Q?20zWpVrYe+BR7LtthUofiRrPS5HX5O1cScu2GV2Mx3tBpv5PMAGm2ghmHq?=
 =?iso-8859-1?Q?0h6gUkeuYusWvQ4gJWxCqgf+MbK0pUhZm7BaKcMg2wT0NO/oiEQh2ZIOms?=
 =?iso-8859-1?Q?m/ZqeQinzO1/MgEQCYsJg17cjKINXvGKjYgpeZ35V/MP57pMwevOcEYI/z?=
 =?iso-8859-1?Q?Xlf1A+wLMVUtIF0T5hcsG9v6Go2s1S5ecFtw/jMmjqon0kWiTYOXDoAqFQ?=
 =?iso-8859-1?Q?d8vT1tWC9h/68FuVkuOHY5OWr/Pvahw4C6DIvcHx8N7NNcGM93wOORZKbg?=
 =?iso-8859-1?Q?MS33EWec7rvgUlfLv2M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26eea2f-14ce-4671-bcdf-08d9e5f5cb9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:24.2506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ic8F7/kI4ogI37M7xLNhu6B4226Q51lYh5N22Shy7uHb/KlNNElirQCaObsKepHGt6FCVUnx35JbfLsGkjDTUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: hrqGByG1iFQyrVMYsvy9-IJGeOzluV2Q
X-Proofpoint-ORIG-GUID: hrqGByG1iFQyrVMYsvy9-IJGeOzluV2Q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

unuse_mm() no longer needs to reference the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index bf0df7aa7158..fc17e02f12c6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2071,14 +2071,16 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type)
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type);
 			if (ret)
 				break;
 		}
+
 		cond_resched();
 	}
 	mmap_read_unlock(mm);
--=20
2.34.1
