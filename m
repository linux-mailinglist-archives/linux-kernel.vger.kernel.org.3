Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC18E4A6A23
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbiBBCob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13446 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243898AbiBBCmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:53 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120iB3X004739;
        Wed, 2 Feb 2022 02:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xNzRANR5EmyGNTyOTsg93HrDHS8Rd9c8SvI++TWpXkU=;
 b=slNVdN70L7vQVjtrtr7ff34BOEXhXNLhBE52x4dm1bDuFlxvWWRKOyP7dguacbIf7nZa
 t/GTHtopYfesGpav0W7zlP6VeWBuMi16SjDO3LYU7TWv9k2Jd7zrO5ZEOBQ3gTxvWr7d
 Lpc8Kp7g0B1gZoxeKGA1O+IZfwckDtRLJN1AAVxlpBXYIQeLAxLFFmnHC+AzaOvXXzUJ
 GH7OXK0nb6QMCK32P+GF47jqMeMV71zR2SI0bax30A6WJq1Uw3OXi1uU4WgZJTBNMwdb
 6XOdfFkwu9ygkDpeCD+wQS9boCEjd/AnsjAdrKTbFmOxEpHQffK0yjCYp66cskNxC4xV 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZweZ015318;
        Wed, 2 Feb 2022 02:42:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dvumggu7d-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrVZsomJRLBkxAm9dy6T4I0iBTmSN2clseAUOWzNqA8FQi4+qygNokPYI14Eu2PDnArNXeUeduBhF1WkPt7TSxc3pbEhDZbhPQM92/kfTAs7GVIRoJu49Gcxv2ir+snvEs++x/hqQ3nBymfe7fsDBz6Ooy1pDapBMX2vGwIhyFJKarNyHdjJou6Jln2wThhz9LQzzZr7eDoGcvfIums6ngdHI5Ikqnar1GF1bYpiJ3QQR4Fgn4j36KJp5p/ZC0eX/C2+K6Al1g7cO0JFuwh9JHaD67+xiTRlRofZeD9io0eoKDpbxWg+4cG7Q2nfgYFfGY/npSUJjCh0Lla9CJMFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNzRANR5EmyGNTyOTsg93HrDHS8Rd9c8SvI++TWpXkU=;
 b=KW4j4cxcuzkQhIaeIgo+ywDmFWm7zrYOVQQGnuhXAlqLiX0KcShUyL+pTQHpl2KF9nF2h199pmDXooFllCM6DChwTc/d5Y3EClbI4SI4oRD7+tro3rlMGz/mAeWDX6S3L49pMmrzBN71Xee+NdpWK57vZpy5o6T7E8DaI8QXNjAopsikLmRm4vfw3kEfH5ScvX6L2ifDJSMUZneycnh+YMXL+73ZBCUsk/MsaVYu8FaGY5LIA+cghoeHvHO4wq/Fgl2szoEGP/9Ozoj8bK0x1cKcl/nVIRexeqqMaCcqkZu249bTVZccgnZqm/KZ/1enEYCqoFCuFvXN/C/5FnLy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNzRANR5EmyGNTyOTsg93HrDHS8Rd9c8SvI++TWpXkU=;
 b=XPwMjJCnkahxPWHO1unM1EL5Hjh0p6+3hyxkdb/bpJD9m6l843Uy/N4EM5Em11iuDH2ZZYL1jpY3nQM8hX+8ryWRrPldUktoFh3hGCR6OE6ZwCBUoHVVDgs3wS4K5gpc6vLNJA+tSKSmxNeIrKBhGAq/obnDFDeSlNBPeawTvtg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 32/70] parisc: Remove mmap linked list from cache handling
Thread-Topic: [PATCH v5 32/70] parisc: Remove mmap linked list from cache
 handling
Thread-Index: AQHYF957aPfD4VsP6kafjoOw/moqPg==
Date:   Wed, 2 Feb 2022 02:42:12 +0000
Message-ID: <20220202024137.2516438-33-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a430cd0-dfec-494e-6b63-08d9e5f5b119
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB412938A176623A0F68623443FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2isogDS4U0vL2jpCSSLn5o2Doq1tx1xPTO/JdNVlniDekZTv08+SnQsT5sctYanwtimZWfPyOi2oKL4g5t2ALeCtyJlCVaUTz6prmLdp9N9c6ThI2H/w70kyuE3Eq0vxrfDsBy/xFUhGKbBv2s+tB3n826PaB6JdkG6qFRC7mBxsRVbENBnTocL+JlJ+zMd8XZFRwYuRFibjZtV3nlQXmo+eFYLis0QO2dD4hFDYovNTrUglGsuO7FxdEH+CDei+YSH5qr6vq8gy7N0gAJTCS8OBaB0W6BUsS8US5Zms72yy6FZNyFP5j2FJr9Ci8zGdg7MSiMtNMtjnBj0D61y7QCi/iVtRaNGbhSFLPeSbSAlBtNWcfiA1FzbGYF7ZJm+pyAfvCz/QLygXC5Qb8z/LCo9c347N3400iB08F0P2Ww2c6QMFUirxr1cGvYQEQytnnhieaNYlcNhv9prFz/07U4pLoJKbODG/LLSjeTrVsQwNT+PW1/+Zip6isBHECRkd2yn49dEt11La2QMfgFzCi7BbW2Q4+sA0FHBMoqnPQ26waSDEuZAYN8lzGay7pFfNmEnHGOqSLEjLvvjtVF3dhweUAt3jEQpYcF4NBSz+S6X0RjCC+2koWt4OTCoZ57eccoJinsiIV+ZCKGUjbcJNwBV4alFzgaw/AYjSDFi1tfk5xnO00rT0H3s2+NE6L8cF4QX98mWSvZSdWH6TcByLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2616005)(66946007)(5660300002)(91956017)(44832011)(6512007)(86362001)(71200400001)(6506007)(6666004)(508600001)(6486002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(110136005)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Lwk8KpgdaG3teCkf/B7RR1oKhLK8iHDGGDZ+93B5Z0/IM6wZ73XZmougRW?=
 =?iso-8859-1?Q?IjoZSnhoTrUdpRMj72YfGwshLx3KLaktbNy9v1KPiF8ta0eRxLP9rXjNeF?=
 =?iso-8859-1?Q?u+ZZxEZVgfmTtr/Jgvoo29kCu1sr+01P3+vJVbQX3LqLN2ZhH66LosOUrQ?=
 =?iso-8859-1?Q?AvuC+D10qXRvXiXyuca4/6srd5lh8GBdc9sRj4yHVvxHo6hvGuUvkKBPWt?=
 =?iso-8859-1?Q?9o9Kt4y5JJwBWodJnrWJeheT9bDpqHjc29OvDskWbSKeFXbP2B2v8E7MKc?=
 =?iso-8859-1?Q?kKvET2NGy5usNUv0fys1p53c1KssvruYMyOEuQsCRGxL9GOc2dushInWMQ?=
 =?iso-8859-1?Q?+9eXaI/qUWJT1HC4mEsh5yK9A1wb0FcYUwkVOZL4XFEsgopDaz/KftDK3W?=
 =?iso-8859-1?Q?uLubp9T+MgdqZrHngTME2qkChGFndztB+0TJnFAbUHjqNHl6A4ZCH7zkka?=
 =?iso-8859-1?Q?7vQPYyiGM0hr+lv26vFKxX3Ud2cL8rLh3GwrD/FeXz59IK93+T5Vxy6bPi?=
 =?iso-8859-1?Q?kXeVW6ObAVtrFFowEYY1bTrcXz8IV54oKS6NHH2+mJ3MaI+AOxONczGJyr?=
 =?iso-8859-1?Q?4qMHMWIgMLnZu+P9pjFPliX6cXPXUkwIbjPgb97PIoCbjptwm4BdrV0Ek/?=
 =?iso-8859-1?Q?ulaQwNqGo7rnHnIxw5oN83MA1INfQaomn1Xd0S9qoGuj02xoK+RGUiKYzD?=
 =?iso-8859-1?Q?nTU5yJxppAdhUOZyvrI+UNytdL7jtudCEly08YdUPlCr8wRdr1j5zEzkEz?=
 =?iso-8859-1?Q?Hmt4G6WuYWzJza6AczXiMvX0twvhJvdwM59T9/oJKM5apI0THZ0o1xKClA?=
 =?iso-8859-1?Q?cEJ4h6u4GROyUPMMO/HKdFG8ZE0AATs6q70EI5Kfn3hspMSZRReQpWx1nB?=
 =?iso-8859-1?Q?lirV2ryB+NV+WRBSBGQ7teOep3aJ5vY/5uLXKsUyn/tLAUjsy076j8Bj0B?=
 =?iso-8859-1?Q?yO/AG/Xaw1UTgJqjUjnurVygf/7orfR2KMCPOuSSXgZjAgcqv9gDU4ZIl8?=
 =?iso-8859-1?Q?O15S9kifN/KUYcaO85bFSJRcZp56PHPNezdiJitLGA7LFycg8fSwt1SMRV?=
 =?iso-8859-1?Q?a6TQHsRs84GYG1/56JGI0DKC4mDSagvJLk5l7+coDr1KS2xBKn6rCk9rFS?=
 =?iso-8859-1?Q?dOBTSVYca1KsjT1R9L/bpgAQt1Q+5IkTKp/uwjFxZaXqLPLjwvhib/Ct+s?=
 =?iso-8859-1?Q?prwFh1WWTyqZ5FEzlo4Lojk7pT3QJRkotuI6RQOmDcBdTRSryzWYrr+Lnd?=
 =?iso-8859-1?Q?+wuxQ2GLQAaranDFM3cCVUylZlVuqaCuXWNWaz66JkkdrMg+g+2QvKKbOw?=
 =?iso-8859-1?Q?sW/y9ccH1b5J/9lRxo4rUBnhVlFzQkt1wo7y/EsbMKvnb2vN/yVyAXC6Og?=
 =?iso-8859-1?Q?84hbnNU/EoNvlM9/y4O08KRohM4XrI9YNhe5/ibborkLxi9+oH0qSpvJqY?=
 =?iso-8859-1?Q?375E7KOjNxr5QJRsVW4bBSm/1M8omnGk7irSyS3wkHu9zjqL9t+d3G/U84?=
 =?iso-8859-1?Q?GF5THza/Dvi/4MfXAHKoZysabQqEp2Qad0Aal3BdRxAhHFJwzuDDVAHw1f?=
 =?iso-8859-1?Q?Ay/GJKjIRA526xW205QhrGcUgNWKnkpX+6aObWl3rPRawfXWeGIIZZt25h?=
 =?iso-8859-1?Q?C6eZ/xznd3QCgvwwaandm+7uG31xS9zOT+nDFjp+iMPoxYcx0n95bJk+Xl?=
 =?iso-8859-1?Q?jc/8nwxBnm9gKxBiyX8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a430cd0-dfec-494e-6b63-08d9e5f5b119
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:12.1889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qQw2WKs+BVSm6Naj0y0K806vYd3IX7gdd0iHN2PI4Lq+nEhe0bx2d9z3UDaqGn10amyFeZyzSLaqCoSW9oPhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: GZZ-QoWQaShr2X529Domut2mU1bRb1oJ
X-Proofpoint-ORIG-GUID: GZZ-QoWQaShr2X529Domut2mU1bRb1oJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/parisc/kernel/cache.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 94150b91c96f..c3a8d29b6f9f 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -519,9 +519,11 @@ static inline unsigned long mm_total_size(struct mm_st=
ruct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		usize +=3D vma->vm_end - vma->vm_start;
+
 	return usize;
 }
=20
@@ -570,6 +572,7 @@ static void flush_user_cache_tlb(struct vm_area_struct =
*vma,
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
@@ -583,13 +586,13 @@ void flush_cache_mm(struct mm_struct *mm)
=20
 	preempt_disable();
 	if (mm->context =3D=3D mfsp(3)) {
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+		for_each_vma(vmi, vma)
 			flush_user_cache_tlb(vma, vma->vm_start, vma->vm_end);
 		preempt_enable();
 		return;
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		flush_cache_pages(vma, mm, vma->vm_start, vma->vm_end);
 	preempt_enable();
 }
--=20
2.34.1
