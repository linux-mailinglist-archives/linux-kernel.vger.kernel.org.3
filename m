Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF8E464FB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350066AbhLAOfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:35:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39788 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349947AbhLAOeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:50 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E5uwH002539;
        Wed, 1 Dec 2021 14:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FzdUKDu/ec7PB9zdwGcdMgvwS0hJ3Vrgg00jW6TdeGQ=;
 b=FNhbyhSf9tMjMdZaaO7O5uxXd5otKohtKEt9w0yhRZUKrNC9rCWWQNteR/7/VtaXr6gn
 nMOJBHFjEaV2xg/u5UuQhzCv+0MBw+hhuklytA/BNynIIipZ8Lyi0OzmmV4OmU1ULaS9
 U5cG0Zddgx2E2FMAcLt9slcUCyyvmcMjZzeZVrzTDs7SA53rv48MQ5rao6htnZRyBDSX
 doWHTwixN+fnAHYAw+MIBGJSj2LVJcLXDRz2XrOE6mdhPfMHXS0ZUB/jynPFTYXKREip
 WoG7gI+bAW8O6U1SjqdM+lL2oenVeY7p1DLlJ1e3hhuO/F58qpgELaysYLHyeM6n/Qvi NA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBMFK049269;
        Wed, 1 Dec 2021 14:29:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ckaqgkcte-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMdK8tJxo2Ak2zLcDslSZE4lqHs0nXX/KmhuwAVoHteuftGPPa1zYmUyG93WUi0pQgDLZqoAsO+jUCBuPGyd5R1auw9jwGnXeUDcxXMJLbVre20nTNAnK2X742TVbiiiD6zpeoTELuzxZWlUv0CozxWI1n/7XphyjTnJyt68fT1B8eoYMhkbrQgSgmG5EEoIS1+vHibNi2pZeTZa6ZnWG5pWfk32f+kwxctV2A8CzG4bYz2foFRhUnERQIMcUlNQQSxvyhfQKPoY+lEaE26ALn+VBl0nT3Yy7DYS83ezM6GuqsSba9l/qqzi8Se3sqFNXjCg4kfyk0uDekL9QZN2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzdUKDu/ec7PB9zdwGcdMgvwS0hJ3Vrgg00jW6TdeGQ=;
 b=lurIIuqx4ZbNgbpNL1btf0wHuIrEL00au8OSw4G3UZXjYs9eaD4MZhkhluGR+4u4MCtdRnZl/iDmqurseLK/dTIxWsnaUNrfBXmSmGi6XH8zw3mMdBPZJDi+s09SjdpJZSpXXcRtNOEd5p0EQ+T0kjQyuXp5ZLJ7lgphI200GqBzOoi3Fyi1qJxQbhoGGPR2ls1bMH1jputop8LG/JypbDZMgC4NIOZSLg74HsB14dPBKoS5lfsZ2L20gwP77sxze6sMp+BSXvJsuCB5RCM2iTHCaDTWiy4cmtTsI8LXwOpOSGD4F9xxR+QJh8+MIUH3P1ZnmkX7r/36ZRIQm0rnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzdUKDu/ec7PB9zdwGcdMgvwS0hJ3Vrgg00jW6TdeGQ=;
 b=S89OXpv3ZcEk55uYsg03WFcFIkbj/4T5+Yc2psiV5PtAeOglwty+RERL7p4kbYmip6bE8daMFPqjK2xhyZZl8Q8TWQ0DnbXGOMxsNkOFlQmhVv0G/DO7ftjOua3kKFhdIKP1wNJvfav4K6MMjMlti2blI0yaPtC5tSUrAxGuymc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:53 +0000
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
Subject: [PATCH v4 11/66] mm/mmap: Use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v4 11/66] mm/mmap: Use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHX5r/na1ztpYesMECiyTp7r8thMA==
Date:   Wed, 1 Dec 2021 14:29:53 +0000
Message-ID: <20211201142918.921493-12-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13a41f46-870a-4a7b-1d40-08d9b4d70a7f
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB27680C9D99EDC8D52858EC2EFD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2ptjQJ8psPwOqfhporE9I7N08tddtx95i+FUEh6sdGUXiEW2rswKhry3j4Lwe8TTFoA8O6dTRbU5OPaiaDdBhgzZsxbcbKXZGv8kTp4I86Uo3Y6kAX3Wo/uWjulOBV89qPThGT/pi5gdeKutBARwmsY15UFsFQ0lBfOk/jHWohKiQZnDDYhx1ATYU9BBY/fNIzfmQkp8Wcx9WAYZ0AFIfFZYX6HOxxyt9Us0RSAtqoPDIKPYrIzRq5nPNqpq7yeN8eU6ys7Veu5p5aG+tOWUxViYyKcTE0ZFucg90O6Wl1/Jux54ZFV8XHUEnhFGZZ+BRSebiHvJQ4Fkw9Lgz6uSLRMXqcUXUUXjXG+iKl2WGULi1fzhWy3RxkvgHmvwCly5Py2MjhHO7jAwnQC9EDmPqoIj8sasCekq0Mef1JVoscls3TCqxgrDX5rGZPDyjwn2JvIyQmOCZOML4a0EZ11Kkz0tOEgkgbLuxlkhqpTFg+QFknwGAAvZh4lyn5yXqf5f15yTCzkJE0nVfKFg71IeD5iEjfco84qSgjmZJcl4GuB16WwDT4QELQ++P2df/ZXKXhjTBoNEh6PlbGY6hG4fFX74gJ2UBwUpBF3CK3A6KKvZmvFOCHSUcGqd8JeZFqos7bNUg9uahsOU03nF6Grg9tL/aCH3fbzRy3NWRDwtGCELIxulMZ0IInuGSkSezmKvDQLCUFeWvER8IBh7IZksQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6FGYKCC/YCVvyInj5Xllt4blAzsH7vskzAa/N1sOsyG9cWXZB8ENLevnhI?=
 =?iso-8859-1?Q?elbz5GuhrNN/OoovvHNdBxRRaJBc4Qsqg1R47FejGDr/TCZTTkQwNOQz93?=
 =?iso-8859-1?Q?qVa0onRNXHf05X7fBfiCtB1GHNDaxXL8mRPjY0kbj2ww5DKQe82pjJmEyd?=
 =?iso-8859-1?Q?pezR7WaMj4NL5Yjx66sZWbIRVx4opSK5hvBvVzghmlC8XmT67pBftjCzbs?=
 =?iso-8859-1?Q?k72Bl75qVzv//wpNAn8lLmNp+pgvukE48Zcc22saGPPbOSRbjEKxmFeIeq?=
 =?iso-8859-1?Q?mSXqMzOmOHIbyb9EFsrGDcI8yScbs6jSLhRjp+6dMvjCPnVSCEnmcW9qcD?=
 =?iso-8859-1?Q?esc37+2b//jpQlcO26qrNX6RI+ccnPon6gNXEy3bjdNT1BgALgpQ9/coUR?=
 =?iso-8859-1?Q?IWUIUhUIAVR8qA+clGmNkEaMzSCba/dW5bGbMP9qIWeX6Uwuj1lB1q2OS3?=
 =?iso-8859-1?Q?9Rd9pLqGypixDZENX0BvzhjzhLTYhaj7U/xAwtAs59rRYt3SR2kz32RadR?=
 =?iso-8859-1?Q?w8OcqmlaPAQlwzEEqsskR4kuA6CUIyhmuQKhywwN/vxO/Ct6H5FNDDY7l9?=
 =?iso-8859-1?Q?H3jeF8ppX86I7fwD6EGPQM6AtNMjO8a6w46QY2qRC/s3GHdxREjJ1LQCCG?=
 =?iso-8859-1?Q?ftvjNLMt7A/1Cr2MTMyqvn/uGwWI+rKTqt6umONX0cSKhUvBq9YpLHdmVv?=
 =?iso-8859-1?Q?7YHFUQQTyZWrOETk2oXjjnfWCBr19DjLpzDjQcvABKkPKHUXjJs8gRO2ZV?=
 =?iso-8859-1?Q?A3/A80s8AjpdFyyDCZp3VYgedXidzrapqAnyzat3fP8Gaw0YF+C5ppQo9w?=
 =?iso-8859-1?Q?jrAfBJz/XR+q6CVq91c71WIxQbq28lrhLda5vQpLdaFcUX1N9pK5yBg5Xe?=
 =?iso-8859-1?Q?BuviYAHCQW8RzQSf+VxCEeHUg2PjWF6LH2r3wLA7ZanZ1ASNy6i8ZzJs6e?=
 =?iso-8859-1?Q?/Ua7az9bYCPuMK7VIwvXE6ttZuH751BrXx/jnmgyJgGOXcZhV9PceX+ZgQ?=
 =?iso-8859-1?Q?FZQHHPzmrxbFqw4cdZV1VwdCGRmPmypaLoh0mUwOU+J6UUaFg9yC5+HVip?=
 =?iso-8859-1?Q?pMBbWPoQ0UKs79GfGiTZu89AqjNluUH8Yd524tQCp2tTiLFgCiOmGup5vZ?=
 =?iso-8859-1?Q?44qJYdhGS15M2xpV42GKMSspTi8hBWnxwEc6f20eLNQw50JDuPd1Wg8xh4?=
 =?iso-8859-1?Q?+1xd87VRJH7MQEIB4eaMQdmQqZ3MH57qOpV9b2+XYbCLjHDCODDcAOb32G?=
 =?iso-8859-1?Q?DcMXWqxvta9DZvuxSefalhB6oeWjGIvJb7ZaqYhbjN8rpDtBeBs4L7+tnc?=
 =?iso-8859-1?Q?iJNlPGF5pJSxMT+ODJL3G1KO7VAU9U6QC09heZBpIWz9dL38sfpUqtLqHu?=
 =?iso-8859-1?Q?uJXhivlGeN9HKSj7Q3Kx+qjbmWaojTIZHlmFlM59+uQNOwDARcAp66Y+hI?=
 =?iso-8859-1?Q?vzf2a45whxiCeJe/QRrsuD/ZzWMLCRuSUWv2F6GJ12EJpRtMwqohz7eA5G?=
 =?iso-8859-1?Q?h2zstH30ayeZI3wNANDI/DhC9+aVFGdBKiAGjYJkKZ0Elb0Xo2cPIGYBJ9?=
 =?iso-8859-1?Q?WPpH5Tf5xW4NGcPIo00sDHVZHvut8eAd1S8SPOdHo2xU54EFb1sPfEhDgE?=
 =?iso-8859-1?Q?MgXN/L8VDxGB0Z6kKdcKGuIDbpcm6n+iKpQNG+x0y5O/hYMXGhHyKhsXRo?=
 =?iso-8859-1?Q?3n5oQsKOtlgj33+xpLk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a41f46-870a-4a7b-1d40-08d9b4d70a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:53.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKhNnnagSzVswHlD/kenQXdNVpe6lLTNiEHHrawVFKc7w9QJ52GXa6D4LK7ORgqdiJk4bYdR0KT3gHbcn6Z/WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: P_OcGfPwbfCg6LyOD9Ks9g53d81-FsmH
X-Proofpoint-GUID: P_OcGfPwbfCg6LyOD9Ks9g53d81-FsmH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code.

Add kernel documentation comment for these functions.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 262 +++++++-----------------------------------------------
 1 file changed, 31 insertions(+), 231 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8425ab573770..0ee4e430e4b1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1995,260 +1995,60 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
+ * the correct alignment and offset, all from @info. Note: current->mm is =
used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start =3D vma->vm_prev->vm_end <=3D info->high_limit - length;
-	 * - gap_end   =3D vma->vm_start        >=3D info->low_limit  + length;
-	 * - gap_end - gap_start >=3D length
-	 */
+	unsigned long length, gap;
=20
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	rcu_read_lock();
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-			   length);
-	rcu_read_unlock();
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length))
+		return -ENOMEM;
 	gap =3D mas.index;
 	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
-		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end >=3D low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >=3D low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_left) {
-				gap_start =3D vm_end_gap(vma->vm_prev);
-				gap_end =3D vm_start_gap(vma);
-				goto check_current;
-			}
-		}
-	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	gap_end =3D ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
-		return -ENOMEM;
-
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start =3D info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start +=3D (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap !=3D gap_start);
-	return gap_start;
-}
-
-static inline unsigned long top_area_aligned(struct vm_unmapped_area_info =
*info,
-					     unsigned long end)
-{
-	return (end - info->length - info->align_offset) & (~info->align_mask);
+	return gap;
 }
=20
+/* unmapped_area_topdown() Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from * @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	unsigned long length, gap;
=20
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	rcu_read_lock();
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-		   length);
-	rcu_read_unlock();
-	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
-	gap -=3D info->align_offset & info->align_mask;
-
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end =3D info->high_limit;
-	if (gap_end < length)
-		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length))
 		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	if (gap_start <=3D high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <=3D high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <=3D high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_right) {
-				gap_start =3D vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
-	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end =3D info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -=3D info->length;
-	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap !=3D gap_end) {
-		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
=20
-			while (dv) {
-				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
-	}
-
-	return gap_end;
+	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
+	gap -=3D info->align_offset & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.30.2
