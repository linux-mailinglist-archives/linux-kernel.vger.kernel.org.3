Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D138464FD9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350369AbhLAOhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:37:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1464 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349992AbhLAOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:02 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1ECcS6002533;
        Wed, 1 Dec 2021 14:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pJpse2ykoht5HtOmSmcEVVPiH7WSqrXnU0XB278v4/o=;
 b=xf43J+yHHBVB16VnrRgR/8wUE8kW3mEA+oN8g9bUhbDj6MHIm4cXnmCPJl0jlUaiwldm
 9QemlK6zcyjsvCvb+uYljN1p9WLim8rpKKK/ly0wDkmArkzh/WovTf8iP2JxwDf0cT17
 9HfzzbASjFF0hUNsaOGbSfrCIPdqgDDWcEINgPddJEZ9wRZZveYIkTg6SPU//5sDPsTi
 hK2ZORdANv+fcaoOj9EylfOjRnJh1PuQSApvxpXQOSTM5mSn+gvpVSywCTgdT8GFLamg
 PphD6JDIg3sLK4Xa5GN4Cj9UbvisDaADXB6+fyWAXs9pG9grjJ3Q3wMh/Ie5qA96BB97 Iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx2273-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBlwa109866;
        Wed, 1 Dec 2021 14:31:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3cnhveqdaw-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REYGqLc4FPm3tVPZft8qACevkNDhapwliai41Z0WUnvIRotlOCq8IUI3ZmMoHeXAQxtm+wnuSJWa5kWrVgtvKm01tWyfBxL1Eg/zzcbACvN2zgGKp6aocJ2fVjWw1bUH0QJkbglE01Wz6fLlHqrZZVfGB1u0w1bXQMBSBYNwINmUdZxoRiZK9E3CzLFQQt1PnPsvgiB5FeqIcxPk4qi02/GCFHqsc8010k43bMe24rilypWHZKG+yT+Mrz7KqlYL0mfNYpb3vZGHWKHAkr+9o0PyxXCOwmbC8JIq2kZncvx9Dq3MScjXHGLRGTEPUfJYq8gphEPtVhWCWYyWpdFlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJpse2ykoht5HtOmSmcEVVPiH7WSqrXnU0XB278v4/o=;
 b=EmwXSTqZvUgNYGH/31QFzheY76/qUAysxVMhSai/l+e4F0TMzcX7YVoH0EK2pqk0PJQlE3RMq8uGXuuVt5RroNMJsOiXPUSoH+uxTRG4ZNZfm223Yp8aw8iHf1qO10J/VT9nFqrTxlQOpVA9nZ05Y/HKjKkW0rm1p+FdHa6p68BIZhQlkgf+a36zFN4iF8TkbL2HcqOQaLNjS33urznp2T/qDZwPDiI9SpynbReRr9JuvKVnLxib5o8diAg7vK+wnOB64LdqH2+4GNYL68udclO2knvCKXuSWdRkWkHzRPau+z2I02XjNFNUHmGLWN/foFOuRnInXmi3k0ueLLJd0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJpse2ykoht5HtOmSmcEVVPiH7WSqrXnU0XB278v4/o=;
 b=Fuz2Ri6mpNdTv8GYuWOMUE+j5KFJ8PO9DmBDsOtiaYl8lCx3hL4e93qIvLCE83uosM7UEaE5FWw+W8nHEAxks0pZdeXyBN+xlc5lpt1Zs/YM7q7pPBhaJYYvJIFkmVIHrnDkwCZ7WfTSQvtKRwGaxb51EvQVcOyGrLD6T7rLGSw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:31:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:31:13 +0000
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
Subject: [PATCH v4 64/66] nommu: Remove uses of VMA linked list
Thread-Topic: [PATCH v4 64/66] nommu: Remove uses of VMA linked list
Thread-Index: AQHX5r/8HxPnsXSv40y1GuowyJAhjg==
Date:   Wed, 1 Dec 2021 14:30:27 +0000
Message-ID: <20211201142918.921493-65-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbb3a0ca-2e82-4046-17b6-08d9b4d73a43
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB2464B80F03702399B6CCDFB5FD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xcz7ArqRtCvXvI9cyJ5eIVdzdFuqeBpvugTZIoZQKHYVxSDanQitZPA0jMTWJJ/kL7INN9K9DbSt5E+e8TWrkS3WQ64FzZnp8g6gnFOXwyAr/Y3vLwf7tQjOhfSlOk12k2zDa/TrubeJOVSk3ANnYVc9amVXuTnzEu8F4swHplivewWGTFQKL6hI/Y4ca5Vbmz+FY+DMyTN8Y21abAGaYedyxQlZ+acfh5gU2AlFFgXAJcMX3uJvW9ZVInP+vgTEPakAdIK1cIEShbiI+8wdE7KIkoDVaGA0/wxCVDdCRCDoEGJ74tgUu2fWRRS3dy6WH1WP9AKDLbaiVPSG4AUB39KYjST/v+2jaC744D/dUWfbvEF5NfVjxRmM9fSEuaNPQcjWSqZ+WacW5dmnqWm7UNSrgxk6mymNrwpMWWMPho6H2pZsibCV44/lwPTu3HdzQE1lqogx1neJSpnIHV7CJ7DH+UnK+MUrBLuWj321JalEornogFmwYTkANf8hpSv+Am2dorHMDhfEbN+5oGIC7Ebmo/zSl/4+lsx32D9TYmOGGBuCiKu55ADENkDVcdEX4aL/bwqriytFJ3z7eKdzOeomPkNn+1EALO2LAOZ8xvivckSx7ysqdB09NiYaZ3UyyLzitcnOQjaOMXTowGqpVf36weY5YpD3CeWF4X+KiZ3AbSChCzbOIsztFlCSwdewAftrpL1tkqHs089DR3fN5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(6666004)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(110136005)(38100700002)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mHpL9Q1x0nHQxpkla00XRBJyk5aO591ERlA7sHl3SOz+I7hHq6pGjDgmCX?=
 =?iso-8859-1?Q?qZD6doYbyLYsvKmtkIK+nlxzt+J2UAhKMtzq59r9I3k0YnVcUF7olczyg8?=
 =?iso-8859-1?Q?zAPxZS4a9elB6RhJwOq6hD6lK9NhWB02+geiCboQawSjKcu0Cs0qKZUIWa?=
 =?iso-8859-1?Q?0XTzpNkwZqZdozsryywwR0IVNhyXOgeqjF3utQ2jt2EorrT645KfN0E1UW?=
 =?iso-8859-1?Q?RMcxz+NS8ZYOx5XuLZuDKb0UeIzn+8cOoSq7GeYyCOKXpzgPLLK/dem/tX?=
 =?iso-8859-1?Q?O2cmuHKuObErJ4P9wLCOmbGn3Najxx9T/cbUr/BqdeqDiZRnvxbRf85ERo?=
 =?iso-8859-1?Q?RF2crm8jq9/bRNAOKJC/vPl3udYSTjBJJDeXasBl/aTV/wjEJoNXX6L116?=
 =?iso-8859-1?Q?rCFrang5RxRgRMs7OgW2dxLqfMqEkFrjuBJxxjCjp+XjSeDGTG23ZAPC5V?=
 =?iso-8859-1?Q?FP+PltoL26lkzhRsxmh43zd2AlsQ3+w3kjbgMa3/MEqpWNyjkw7yANy1wm?=
 =?iso-8859-1?Q?3NTHf8t3L7XDQHYV9mVkXdhAkSgcwZaqks8IbRVV3kYF6Q7tCja8m/DSHA?=
 =?iso-8859-1?Q?QxriTew3htWZJfmxLB3y8JaKXQ/Q4SrmE1M9ng3DtzYo4NDF6MQKIn5MwP?=
 =?iso-8859-1?Q?ftojYGKxD1F3o+cMWT2lIXaUM31VnMWbSn4T88P4n9feoHUHmsEau0s6HT?=
 =?iso-8859-1?Q?x6nq7HtfpuyAFN0qOsM5Sakt+BUonj7nPR7C6suQcXnuJdTMDKMQopqbzZ?=
 =?iso-8859-1?Q?pF5cQHJ9pONbANE5Rq1Pjq0jqX+HUwz/5yWlDLA3nEkr/ivFO7p8+bPnDk?=
 =?iso-8859-1?Q?NWAjKaoCyr4wZiwk9F1WN7oRKLjxtQHDE18qXO89jTVTKOssUqEioAkx60?=
 =?iso-8859-1?Q?s0EQ+tmTcWd/ZqTF8QuHaCJlpWGh6+lwhFb/71IutNJtS4KJV0mPF9rhqV?=
 =?iso-8859-1?Q?ZC8HFoUUVG2os/OCrB2dFy/TvEVnx+jb615+qDhcEff+3p2SD1jU4fl9En?=
 =?iso-8859-1?Q?wUhq697QuhihrIfS5La2jTDvyccqgGKNCyw4gfyH07OMSL13byW/+ahIBN?=
 =?iso-8859-1?Q?Yj5qhBmka1SkiA4U/R/RDFLLhimvwgVxElrGQF4m4xVTCOT9o5XhgSEAbH?=
 =?iso-8859-1?Q?6U7gWuOsoNqe7FvdOHrAYLzMlX4ct/a7YKaRQIsPrPZkxsId967mpMDmJx?=
 =?iso-8859-1?Q?gSizZsc9Vr47VZ4MBHMfbF7dBUtZrgI/u8E6L+SUo13Df7ADk9nTu6MrtU?=
 =?iso-8859-1?Q?DXhI80BDvfP1H6nUPsz5B9mQWqJzv5I1myOlBRcwS8jysWEAClqygjhHQD?=
 =?iso-8859-1?Q?3ob2tOGSyqj25fcR7tNRK1a1ehXY3LQ86RNTIslrmP8nOs1TdzRU6COzMB?=
 =?iso-8859-1?Q?dmI4whDazOnbCveHQuGsQHXFGslizLrmMGsaLykNiCHeNkIoAZO80FmkKm?=
 =?iso-8859-1?Q?lSaCvvqg3IAk4WKqjfX+fIkRbkeX7o56xfjmi4U1DoGNMYQTJu7mjCklAN?=
 =?iso-8859-1?Q?zIgnSFpmE4/kEmZFAtbBn8k2yOL+b4xrjhR4lZhgfPP9GGQk+epVPPzzJD?=
 =?iso-8859-1?Q?XmjvQQngCWtWtSENIyiVd2bsY21KblMGtDa/72qmLpXAQyhbDma7FzXdRA?=
 =?iso-8859-1?Q?jSr/gjrBgzTlrycG5L8/3Pf4FgPhwKIRKjqHg4UolpFxuetZMTfUNkb3xX?=
 =?iso-8859-1?Q?Lg6yUjIhVwWTbqKY6qE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb3a0ca-2e82-4046-17b6-08d9b4d73a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:27.8781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nf35+jZm0pujtB2ym3Ku3fj8LrJC64gvEOiAPaNentHJVcbYaex0S62XYpCrh/ZJW4yXqnEzoMMzFQM3k86Qxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: BcSXbRvgMHqcV1iv8sUXop8WXNkCUeqM
X-Proofpoint-GUID: BcSXbRvgMHqcV1iv8sUXop8WXNkCUeqM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the maple tree or VMA iterator instead.  This is faster and will
allow us to shrink the VMA.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/nommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 11ae550834cd..acb9aafb0afc 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1370,6 +1370,7 @@ static int shrink_vma(struct mm_struct *mm,
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struc=
t list_head *uf)
 {
+	MA_STATE(mas, &mm->mm_mt, start, start);
 	struct vm_area_struct *vma;
 	unsigned long end;
 	int ret;
@@ -1381,7 +1382,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	end =3D start + len;
=20
 	/* find the first potentially overlapping VMA */
-	vma =3D find_vma(mm, start);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1400,7 +1401,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D mas_next(&mas, end - 1);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1449,6 +1450,7 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, =
len)
  */
 void exit_mmap(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	if (!mm)
@@ -1456,12 +1458,14 @@ void exit_mmap(struct mm_struct *mm)
=20
 	mm->total_vm =3D 0;
=20
-	while ((vma =3D mm->mmap)) {
-		mm->mmap =3D vma->vm_next;
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
 		delete_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
 	}
+	__mt_destroy(&mm->mm_mt);
+	mmap_write_unlock(mm);
 }
=20
 int vm_brk(unsigned long addr, unsigned long len)
--=20
2.30.2
