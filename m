Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE06464FFF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350693AbhLAOk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:40:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49486 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350087AbhLAOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:25 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DCrpx009641;
        Wed, 1 Dec 2021 14:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FHnh1FxTnANTiSYe9KANjyluYKqY2MT3hxYJq9odXII=;
 b=jqjPsiOwQUGpOW5lMXPbZhAGRADH6sJgklTCAJC5axZt9xiQKvvsuoBkDwFG94OFYpzX
 QbS2DqsRUvrGwZJeoD+mj0yqbAcxDlIx+H8FesL3mC50vDkDTZMhvAZMnxu6hMM7XX9N
 ouzPAAyA8BFgbISZe0iYHFuge/D8KruZcAadwgAPamTIT9B8/sWWLxC6sGDb76yERsQS
 UBlGEMIxbGVOEn/hFwwsAXS/t2IjwjPQiDoDlQWg69w7FpScgkcWeYPfzvj57CSOKwGM
 4yLD+bbeVS6vScSkeAEKzrtuVG+Rmba6gHiDDewAtFf/pRx9PwU/wIDaJRWj4fK73auW wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBoq9037533;
        Wed, 1 Dec 2021 14:30:46 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3030.oracle.com with ESMTP id 3ck9t1v74d-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdu7NdPxXqqH/YpLH32gHOTEAR/pYDno8JvV5HCwfRAuR47is1FqKpVU0DK7hWECrteCwo2m9/r1CvNKw3md09eWv2YYnzjg8SsVTG6Z3I00dM+e5wVxgcmNgb4NVeiTFytpufHagh0QWY8kIlXwzwbHlRmiq5rlgoJbezRiyOIPHpjnBva7AXN2R/gkqEFbIYWLye7iDCh3nKycRQ5PiYlK4gWn7bJyD5f3tWaNRHK3D60QJFl1Aj0MfyoD69IvEQePnu7D7BAlvfKRLSJ5V2UsQjruFWrAk6XN/M2fTq6tnvPMwOV5Zz6BcCuxZHHkMb2BTg5cY3crjk2iY4iCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHnh1FxTnANTiSYe9KANjyluYKqY2MT3hxYJq9odXII=;
 b=JjfBQl1zha5zlddbKo4ceMcW0bd0j0NIIPZmSz2Wutumk1zuI3xPp5Lnspxxa5WNZpl98c3xDN20NYjY/dlKbUp8A4WHaUu5aFum624m2MWk0mk2UBT4onI0xAqKV1bd8ZL5DkWEpNWD5lQy6ixAFFjsb4KKM1YCqRKdXnREayPoIGr/4j4TyBiAALQkUmCI676UN/gdlskdxbPQEjOwUpc12X81AuGVo9cHQIDDPv6xWP+W0XANrj39JjsGF7j64YE9Tsg9XQgaqSpmTNWQjoOq17jarkYvsZmdqmz3/L0g8fDBlNciTFmtygCg/B1D7JMWiQCgEKCL87DePs6uLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHnh1FxTnANTiSYe9KANjyluYKqY2MT3hxYJq9odXII=;
 b=mnKfOG/lvnvByc26lRz4FYY1MMFq+Kny4zsPzJrIz4QYtxe957rKSNtyc3ApDOcXqb7Sqt1pb56c8u014n2TpyW9Ac3iQjbsP0RKY4a1IWn1/uvxtrJRKYmUYjY33JnLU9dorf3u62TjQfP6tEZQ3uzGI32BLlnul8zXKgWMHtc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:30:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:42 +0000
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
Subject: [PATCH v4 58/66] mm/mremap: Use vma_find() instead of vma linked list
Thread-Topic: [PATCH v4 58/66] mm/mremap: Use vma_find() instead of vma linked
 list
Thread-Index: AQHX5r/1hd39GhVMG0ubXF1xkkrhJw==
Date:   Wed, 1 Dec 2021 14:30:16 +0000
Message-ID: <20211201142918.921493-59-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0ab3a32-6f90-4626-eacb-08d9b4d7275d
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB246424428642334B4004BE60FD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iFuTilBHU51x9TwBwTa+vABGZV5Rmr5QipnPAyR180qfC12bmitEMfhZj84v8q3nGRbFn+y+Vld+BtGqoAXoflA5YxbDH3p/oqNsxih2IMybFcbPAAPsrtUeuKipB4WB/OALzEyh46AQtcAGi8Rqkwag/9yA+zHCY41NWGU5fSP8hxNKgAhaPItTWyksZ3D2/UHtIFW3/Z28d1eaRRFrNiGbIeUc9y65cZmNzs4YGNLJTk2uJ+990QbjZKtLVXgpjYUdY/SevcBfP1ZVfmdC3lI10VKgd22os1Lmv16ZRnpwyhYL1rvQGu9KsXklDCfn67XiPs23mW1cxBV3LeicFb5oetG1kZykQhl60GiAf896iwJNN4mwZnRmCeSb5pObyTk6yLg8bmYuPjxO4QlXEulCXNw8KF+xfqFBvVdnOu7ha8J+RIWnagezUDjVLEPdUjqbX14zKncH8ektuKCmYPxGi/o0lAjCBuV8AzIvX7A2irOOJEHZLr/FckyjAbnzPWs6UotOtyTGNxzjqIMGE8qmb/toF/OQmGlyUh47xg4wMMOBRZmCdLg6gt3XTcHEV3Cyp2PUOo4pWD7ihrLCCj0KXJiwJZdLhdsfpsQsfuoZKfKtHo97CHRXQZohFSmEXhDsH+4Z3PIU1vuiqIT+Nax5OBFNLBKfl9cdulEijS+9tdHd6Lmi0AHzEfuNqORVkVGqMTU5SNCfvW8BMU5qIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(6666004)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(110136005)(38100700002)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PL8x3X++7GU989NAeLAIcXWC8H6HuEHJg6X4yQuSarveQB1ZK3aLc2qrVL?=
 =?iso-8859-1?Q?in+KVtfVe63frMweFHCRwITOkC5qCLK7N6F9gAnCgcqAP3knb4WHZnrjj/?=
 =?iso-8859-1?Q?XSttArl7t6gktR2rh0sxH6qCyD5sheVb3GLzv84Dm7NtphHiuR3ScXH3KF?=
 =?iso-8859-1?Q?mrUOFUdl/18pE1d4HeShKhKIav+4sQShHszefOZMSEyg7YI0GC63OrHEO4?=
 =?iso-8859-1?Q?BmD2RZCXe+aiBkHs/dFqpDGC5eKY2gOHVsiaNERRbz7/uDDzkj29Wv2kBu?=
 =?iso-8859-1?Q?LpNMKXr9int3z8FGArehnnMNgiIt9XLju8G8FgWY6cY+K5Wa1TWMuxhDCM?=
 =?iso-8859-1?Q?tupd8IRkIm6pICXCR3tdFH4Gssc2XNJmQ98yZ2k1xOyKwk6yJDDBvWCmQx?=
 =?iso-8859-1?Q?Ss9KxkYa/C7kIgXekLEQvnP4J8yzux+A/QIEpsrYy0TKY1/sqz7JFPt/bw?=
 =?iso-8859-1?Q?aDmS5XTxjZ3l5LsiRvAQ1YlFceiyVx3eUUStg361gFPli6yLdFhCtYABA9?=
 =?iso-8859-1?Q?8HcqmdhfgEY9wErZGoIsfj7WuYQFX1mttdIR14wnq+cJxUx3Djxfw6zBIt?=
 =?iso-8859-1?Q?mXRfDBbKpGNOzdlh0WIDSs+eDb14tsauJ5G+3iVBioqu7CawtAOz0jQTVo?=
 =?iso-8859-1?Q?SmXDY8ehn6dWEREisdFn/b6ozYewv/+sGwuexs2Adzk9EoyPFrcYi+t+gD?=
 =?iso-8859-1?Q?bLAWgtmN8DDdNtkGCjXSSUAwzCsgzA5y6EUjZeS7rRgZwyAxqsa9Hw8Z8h?=
 =?iso-8859-1?Q?T6DkubKM3y2bN02bvjP9SONyBakopUmLol/qR4095FynIKOMXEG721farD?=
 =?iso-8859-1?Q?njN9X2xlSMYB3KtDw2unBGagcZIfhHePWHSmjJLhU+UACR2kgpFqhxi3ZR?=
 =?iso-8859-1?Q?9b2m8kWQIWOJxZ+ckhIvzZ4lcSJEWZeVv0U6cmPZkg/iqMFnlIZX559mCL?=
 =?iso-8859-1?Q?9DEe25cHFxpBkdZVy8kNu89urDYOwPTmSBS+j8vL19o/GqHfClnJiycc9N?=
 =?iso-8859-1?Q?PXQsTaasOjs/EIrRth/2Bivi4FGzksx53D+yvarkQxnipFXi93QDelz9i5?=
 =?iso-8859-1?Q?uOj4Nakvld5qqJr9EpWkcfHBs+YT3PvoukiWc69l0GecWHSAKJPnVCk6o4?=
 =?iso-8859-1?Q?i7mc/CdVPsBqfIohvhNhM0UMQKSeDT3GEJBcRCdsy0dfhnrZ4fN3oa7NsY?=
 =?iso-8859-1?Q?gh22AqDZKMc4VnhzuoAjd2TP1Gn6rEYm/NxS6Cx1V1hrWelPejuQTdpSLk?=
 =?iso-8859-1?Q?734hMR3QtVqVCLxNDAHyeGYFdCqWuWml5wi7TPqAY9nBSJLdYJphbXgvDT?=
 =?iso-8859-1?Q?cMW5ObS4GwoaL61u/AxzB90oyZFMB9G8esDRUDetr2hIZnEogxT9cullZ+?=
 =?iso-8859-1?Q?/AbFSg57UV76iKAbxjU1x6xFO/PUYpBLddxuAjsNnWlL+f39XyUKqOKgiP?=
 =?iso-8859-1?Q?8rbkWZj7Ll8rNAhxWzRHI8b3+bZz9/1mTZKwt3x5ob3jUw14hK8ESnWnrZ?=
 =?iso-8859-1?Q?ocUi6fJAmAUGISTrdyp8x1L8qLM2c8kLud8pJVfnTEwUcsb/ZaSGOXYXmi?=
 =?iso-8859-1?Q?kAjqP081pxjknnKnDjYEl9eD7pmJIp2g+bZlaLMojxuhZCbyu4qBzIM04S?=
 =?iso-8859-1?Q?ZZWSahokEjk2uivnm+QU5n5fBCDjXdWOKuW54nfLxplWYZqr76INOseVRp?=
 =?iso-8859-1?Q?inxQ+axoQpAszp24liI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ab3a32-6f90-4626-eacb-08d9b4d7275d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:16.0509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TVaWMPyj49DMvEY9LVTEUQgY4ftAwj/Ep67MtoK5FcZk4ndCgfMbl4/lp84ITNBkEDJBJMWU3l7+2ydeudzZ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: Gj19UEg-gxi9muEt42IB5Sq0aSnGCuZs
X-Proofpoint-GUID: Gj19UEg-gxi9muEt42IB5Sq0aSnGCuZs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mremap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index b09e107cd18b..4ad39c985d04 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -713,7 +713,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -869,9 +869,11 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+	struct vm_area_struct *next;
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	next =3D find_vma(vma->vm_mm, vma->vm_end);
+	if (next && next->vm_start < end) /* intersection */
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.30.2
