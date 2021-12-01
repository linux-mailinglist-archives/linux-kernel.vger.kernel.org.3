Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC588464FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350252AbhLAOjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:39:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45070 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350073AbhLAOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:23 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EOuJH023540;
        Wed, 1 Dec 2021 14:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rhXNmZnznFRovzMMcOQhdBZ1NLEbsCl4mmlB08V3TTU=;
 b=mXPzUkI/2LasuZ5o3UVqYYNiu/frSmeMZp9rFxbvhwkpW2OBia4QIVm8aKlJGH5Zy4PN
 chP1/wReG0k/hZ2kDOGg8OqsIv3vvaHUFcwLWLzzbto1CnY9Gol6irQE31GIfOFrbycr
 qk7TTDa1D/UWb6r0+92lv8o6xKU401r78XGw4pYFjDovJIfmPcSRUnvt6rshmX54X/0f
 bihAGxOp/3ALjRmO9YJRLyCC7ZVp4Q79w4aKg0gDnuYCFthKpPAkHDK5Q0TV5W0BF1Lg
 +MIOIigmXzyxgBedSs13cpGo/p9S8aNMRZQQOYeZN07oCmegLcT/RWE5mQkbq2CVYcLZ 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9gkgghu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBl7Y109791;
        Wed, 1 Dec 2021 14:30:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3cnhveqcc9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARgJ3Ww3LLkxZcF8OpPVIlXy7yUAhISILtL/IOW1pTAifbBA4kJiyBdofoN7hocd5PF8tULH8yn6u4gW5xz4EWQfjwcNqEM5xp953a5fo0OiQmXrFdrAZxWvxaQZnH0zupnNkBtCmDMkJR3PWUNbE2IXmXyNvnjGIvQdfbk0BecASyOO6mkGk2bYJy3KpRHCH1jBLMN4ghFPMZk3XMwR+wY09PrYEEKCUphfMpzHtCBH+IcCBM7wIfGTY6sXRqJG25UephQZRja+C88MWaAew9oT+qnMhGRkXlVd4uXJhzbZroleHgfhHSbUiGYoqBkIXIMdHrsTwfpXYsnnkbhDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhXNmZnznFRovzMMcOQhdBZ1NLEbsCl4mmlB08V3TTU=;
 b=cjCIF2E/C1XbKjD8pXSjKs9YjYyv7jscIhrzI8xjz0PAC0JAeKnCYNswr5WZNxlzHincI4hikqoOVzjKdCHmZg6f7kHB4+dAFoFN+GvMfXSlsrfpvMx/7pfHmfp/nEuJ9gRHg23NJlp8RkPLH7W9nLQpP/1LtqZ7jJ5cysxFRcGmojMu0At2xzUTHSqbU2OkGfCmsw6CZrnXFAkv07l4PTq+u0CoMGBV2UsR8smB3csL9u750NSqAJTwoxa+6mJoD239OxZP3O3Lz+U1QDddsHp17PN4t6vwtMLOnbJ6LAl4X80dd3+8yGtU2c9HFZ8DQhbJixDILdBuzLE6DM7yFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhXNmZnznFRovzMMcOQhdBZ1NLEbsCl4mmlB08V3TTU=;
 b=iBJ4Oz8RiWIgZCYO6OBnIvwxH0XzG8X/HZzbq1ZIqMfliaa3s1qqEN/W97p3Q37MMYiS26Cjqz0WuzBe6xV+yOUP3i9sIFmjf1wlONPFQ+11PYirmCfW8fgNmQNZxPhsMOwCxeFjfYHa8s6e1htVCtuc1sSLT9vAioUNbQOumG4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:37 +0000
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
Subject: [PATCH v4 38/66] coredump: Remove vma linked list walk
Thread-Topic: [PATCH v4 38/66] coredump: Remove vma linked list walk
Thread-Index: AQHX5r/wcwICCKzeIEWkD/OHNmLUUw==
Date:   Wed, 1 Dec 2021 14:30:08 +0000
Message-ID: <20211201142918.921493-39-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e2fd9d0-b557-4f2a-716f-08d9b4d724ae
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508077BA658748959442048FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W3Q3wuYLnOyOioGRHSut9IjGXO5IqdbxxeQ3mtpzn3WZOYkxYCWMYsvA8KeZn1oi6VI5x+t8rHqWGGb0GclELRA7Py3bqQxwBs2MF4Vlb4IrLqYXd4kzY2zo5CQOlnEEcXKFmMFGuh2dP9NMoBR4K7r8/UgBwKPwNec31Z5l7RM2f4H4GkdvDvPXCEipLWvD9Ou+Hck8/VaBRGiI8lytakDQ7Gr/4aAVk2WCbzRLYnixvZ+1dBwbW1Adzc1uoHJ27AQUtuw18pnIOVAcdY+v14smuxVH2hyu58u4gku0eYFl0T/UaP1I4LQ1PneYpjlXwPnWsSDJt3QjgBBOW+ZEyoKMUsGulIrbnlSY9kO8Ri5l4D2sFnhJnQl6cJk8gQek4DJfZ6wmi71tRyW0lv8NOIZOSusIEmnx3xzWuLNz/XPlX8LDG+8W/RzFCmQpld/TOfczo8xdfdpCudla9i6RJK6Au3MCYJ9XAxp3gxJ8MAQAS+pdIEEEMEhd/QABcc4Udg+vA23vkrAWQg91nzq+2Rp/ctzi6pWJfQtvRB5SNsvribJ99LJ/0arZnm5YZgLD2ZwjMXwH2JqM9R4AtGxGzF/p3Vxx4YXZBU19TlzcaJ5YB2bRM+XpYQYm0PBTppySqsC9kDWQ8jEO2R4kPcNxV56x1w8tR71F8sLE0dw9O4ryK1xD84k8OSJmR7L6uYgK6wMspQ3Sh7i5vNiAIbBm4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rz34BZ+7a6AwJMnqSSBL5Izkzn7QNjrJUMJTuJbyUj4I6eXUqNtGraO0In?=
 =?iso-8859-1?Q?ZPQvMnbzz0psYdpNOmEsmJh1vvZ0aWMUEweKYH3hhZ97qDC8M2MMMKkWUt?=
 =?iso-8859-1?Q?TJb5fxAqwmoOW+PSjC8+2Ip0skR6vSslMeBJ+IVrbMQoSYT82b4cJ4GeTS?=
 =?iso-8859-1?Q?ugjKhotCjwnFiWxK5356aR+8T4/8fCHXl5iizKGGRn/aUJp7+jV9NHea9h?=
 =?iso-8859-1?Q?chkknsVoz75RUVJHy+fk+6TLVeNeKK8w9F2Xfq9NtoVqlwq3csfNLoV4F1?=
 =?iso-8859-1?Q?v6Hz22y7XRzVARgjhktFxwGsm+WIX/E0s2v558lY9lL+CZGq45nWZU+bav?=
 =?iso-8859-1?Q?o6vEJvi1QuNhbCLs4k+D+wXzU1GBXfOr8lFqvmIV3EBoZfCWPuwfUJgcLs?=
 =?iso-8859-1?Q?LjJ+En+88ikwhO98bPexmHDWblhX+pZCXLRnv+GHzi54xcXb9YqYtnUz+s?=
 =?iso-8859-1?Q?iICFqdMdJazpkCY6F7HRMkZY69/rNe4UfrjI+l/8P8xJKuGeefhojaMUxk?=
 =?iso-8859-1?Q?g+5sO7mzrGpK/+M9sPMpR3n+yaWbzjCBt+nj2aBj2S6Odl53UY5pBg8dfm?=
 =?iso-8859-1?Q?hcLTPFTssO5vJFEZy14wZQoN9EiNApmTlOS7FRFjd1GAjyPHSU5u/08+8P?=
 =?iso-8859-1?Q?RaiHK9kbZOkcLSTyhS6ftCh2Xu4TPUurYjeL0B7F0gMZWC/NXdo4ug8NJz?=
 =?iso-8859-1?Q?bY1liAgMfGjyzuYk3blyVoliTZVk4kTD5xHrtqVDZUb8veGGb+l4cY8bBE?=
 =?iso-8859-1?Q?XAiWEfvG8hZJVT5THhnTtgK4ePsL+/nAusbvdaIzfseO462yyJjAow1pMS?=
 =?iso-8859-1?Q?Cu5yIUsJUOD6+sTYAWh7/CD9JQxooD1z+uGIIxdxEItWrvLlY+ofhIRbls?=
 =?iso-8859-1?Q?uOUxuIjXQlS2FurG2f9gXKfmacnDb/KNzwQ9pV9euAstWnexx0V6rmPIcH?=
 =?iso-8859-1?Q?WRyDYYvqao/9XHwkyCHc6tSid0AwwGjR9Ws02q8H4Owy/wu9pWGR0nnrSS?=
 =?iso-8859-1?Q?kPtmPpGGOKmMk776JMAQ7eJrIR2k1xejdBwqVTsukvrwfOMfrXR6isvmL1?=
 =?iso-8859-1?Q?tuI+tKp1h7EDhEObEcH2kNuhSrRreNc+rATG471DaZ8oNhsYS/TWNYUGdW?=
 =?iso-8859-1?Q?rdMLEmRb9bxKJOsF+YxZPW7U5FaW4fPgjFq1j5twmwkzJ8u25a8/GkeXSe?=
 =?iso-8859-1?Q?6zS5FOPcXLdqxaO8FjJ+KjwDcn7vNOf9FV59kRMWzuuFfBMl6L3LonpjkC?=
 =?iso-8859-1?Q?pAvDc7nuAisudUGTBvmrWlJt0TRlyz4QWzdmhx98Mrsp9AyJ7Gj2USISt0?=
 =?iso-8859-1?Q?rq5Q1dTXXuT6nVPGiDcGr631giP0k6dE6ZqgsPPrNWS5qAuTUZDEmKbiDS?=
 =?iso-8859-1?Q?+kJLjRZQTFqnb+4sInug0K66WHVohVDd7Zx0VczjLz4AyHtiXv/ELy/10M?=
 =?iso-8859-1?Q?601H6GBhZFFSPtMOGOraILqwXlD+TdKm+cIYPuml2XNP6CqiQCjNtfnLfy?=
 =?iso-8859-1?Q?pS63B+21MSK3M/ML2hetbjE8xyA4ivRD9+6pNGVbcnilI7m6oHR8+4L+xX?=
 =?iso-8859-1?Q?faVTNWUP+S10Gd3G9CDzC74L/8If4Gyto+mQtwrZbqm6OA519q6De4FR/i?=
 =?iso-8859-1?Q?VzffxO5ILZFOIgZ+VyGqTQDucO1x149o0BqFmo0pz7eBmurjb/hFFTI/rY?=
 =?iso-8859-1?Q?Vx69vN5kNvUoThET680=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2fd9d0-b557-4f2a-716f-08d9b4d724ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:08.3113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78SGGdgW+dnNYevJ2Bx2FJNEz3jpus6EWNnHY6JXA0MBEY41ILr5jrGQZ1idL5/clmZhrSmRQ4TocD9rqfthsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: wwEYJpbBJp9mpZWUPbZmDUPWKSzKYT1O
X-Proofpoint-GUID: wwEYJpbBJp9mpZWUPbZmDUPWKSzKYT1O
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the Maple Tree iterator instead.  This is too complicated for the
VMA iterator to handle, so let's open-code it for now.  If this turns
out to be a common pattern, we can migrate it to common code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/coredump.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a6b3c196cdef..59347e42048d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -997,30 +997,20 @@ static unsigned long vma_dump_size(struct vm_area_str=
uct *vma,
 	return vma->vm_end - vma->vm_start;
 }
=20
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
-					struct vm_area_struct *gate_vma)
-{
-	struct vm_area_struct *ret =3D tsk->mm->mmap;
-
-	if (ret)
-		return ret;
-	return gate_vma;
-}
-
 /*
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret;
-
-	ret =3D this_vma->vm_next;
-	if (ret)
-		return ret;
-	if (this_vma =3D=3D gate_vma)
+	if (vma =3D=3D gate_vma)
 		return NULL;
+
+	vma =3D mas_next(mas, ULONG_MAX);
+	if (vma)
+		return vma;
 	return gate_vma;
 }
=20
@@ -1032,9 +1022,10 @@ int dump_vma_snapshot(struct coredump_params *cprm, =
int *vma_count,
 		      struct core_vma_metadata **vma_meta,
 		      size_t *vma_data_size_ptr)
 {
-	struct vm_area_struct *vma, *gate_vma;
+	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	int i;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int i =3D 0;
 	size_t vma_data_size =3D 0;
=20
 	/*
@@ -1054,8 +1045,7 @@ int dump_vma_snapshot(struct coredump_params *cprm, i=
nt *vma_count,
 		return -ENOMEM;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D (*vma_meta) + i;
=20
 		m->start =3D vma->vm_start;
@@ -1064,6 +1054,7 @@ int dump_vma_snapshot(struct coredump_params *cprm, i=
nt *vma_count,
 		m->dump_size =3D vma_dump_size(vma, cprm->mm_flags);
=20
 		vma_data_size +=3D m->dump_size;
+		i++;
 	}
=20
 	mmap_write_unlock(mm);
--=20
2.30.2
