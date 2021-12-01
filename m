Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAA0464FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350129AbhLAOff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:35:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43974 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349949AbhLAOew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:52 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1ECcRn002533;
        Wed, 1 Dec 2021 14:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ze5mFgSyZ+ZQTsYRn4+a4f3TvD/4+clcpL1kpRmwbag=;
 b=b5poALOfOiOsU8YFOAwYEwCVOT+Vg+oQYsEo3v3T+qWp5lo1faPaTPez1n3nKf9Ximgw
 i5oL2uuCP9fQAurriKFScyA9UbA7XmyvO+Xs5f1KQSHopeican50Ze3STmODB6eUHw0V
 Ap82faF+wck9ov/e+Kj1snXSDuZCr5YDs9c5XjOb69ii750Pza6NDtjfuBrTpfH9DMYO
 LtIGW54Cn9DDHtLGET/mgjr5D6nS7qydzdUEXry0MXovd5rQcaZHdybh0NRHMBTs7rwJ
 aJlZUiM236O43RPTNUG/Y39hwGoEu/YmovJ6jxsm0uL/Fe5sGi76r5wocSedX3A1xfAP hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx2229-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBoq8037533;
        Wed, 1 Dec 2021 14:30:45 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3030.oracle.com with ESMTP id 3ck9t1v74d-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiMwUIcD37AvjrT7/z2fBo1qDI9dAsuDR1Ee35Krn0tQwueAPE4OBiHbRh3yVrqgQqbX3+QmW6zvxA6Oj33OIkK+uHjl30htH36K736RtwVnn0CWuX5bbozL+7RCY165FZPO5+PRqvMPD3DjJDnLrGF5AlstRWQ3F3HLOuWoNTQV5nQNS2nXKIN951AqAYVBaG/XYYAuuOhvemIWoo2pgshtoBpI4F5LpVC3AySEXX9Ec9SW9VVWEpsMF/J7CUscLQ4+JpZXwBLoUgGD0euRgPrQS2gzelbz4lDmgGJlGww/x+d0wL9WNyT9dOrQGw0kp0o8vEJ7wJZzwqbMIbD/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze5mFgSyZ+ZQTsYRn4+a4f3TvD/4+clcpL1kpRmwbag=;
 b=RwlQ4KY28WN4LrDFtzfeBGymUviBw566hkQ8Cl4FG4LRNi2oWFUx6WW09iGTGjUmgCWt32t04DBFulaeOfnBZu4/OestvAF1j74+EgDM/SVHluHU7tmfR8pbcTILOMPZN/+tLFqXI6Pyvciltusv6FIVyxCm800YmHV/R//e+mD0NmcGcS3urTDk8exHgQ+5DjQR5uVq++gVeNwnJXO5YdyiWqr5mOUgODTFPZpvCsadjs8R2KGtinmepT0y0fBtqiii1oQT1+4/euyTP98IsCQCzeKN0mIbSKhGqntLZ2AY/nw5PVjl3a8EJTa821RpjR9FcBEZtnOskeIbZYHWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze5mFgSyZ+ZQTsYRn4+a4f3TvD/4+clcpL1kpRmwbag=;
 b=SIMHJmqDWG4KUce034ByR9HxViCFVoPhmTbNXNFc9KUB9mKNU9xQFQSgvD6wfuHZDVx2irctQuvfZ4UhXUd6bPS1qlAoEsFLUt4oj4C9DekUyrJjfManDzLTxNeUf7qzjB6oVroDtGe+TQOXdRgT4eqrC0O9EBc9N8HFBimRrWc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:30:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:41 +0000
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
Subject: [PATCH v4 57/66] mm/mprotect: Use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v4 57/66] mm/mprotect: Use maple tree navigation instead
 of vma linked list
Thread-Index: AQHX5r/1/4BXpZ6L10a73qtFjPbdrQ==
Date:   Wed, 1 Dec 2021 14:30:15 +0000
Message-ID: <20211201142918.921493-58-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0baf5c1c-d8ef-4cd7-4453-08d9b4d72736
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB2464D6E18D30FBD4842653DEFD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zf1/JKfWx3OZZrWsuXJmm1IHrdWHI47zzn24QM2T0lRQQxWex2y5D38Xt3LLLhveY4VxCPh/Sy4WqlhzmBRvrJjShyZC9KJ2cO+jiu94o1DlRQr0gMDVAke/ZxMyiY5yI0XTOaheFRmLLC6YdvKFhLsI9xjjH5iBLdoftfoHQUUU+0RBQTss5APIr5QXXDtxmWiTv6yD0cxBRI02dfNEe5wMEBh3gV8UE9MQ6MTC7Pwz27FaR+WMMv5GZz2qGMroewbEqxqr8DBsKsEXkm0d/UqeoidG5BifRTtjrAnQ517ANCzAM7xalOZBGS/o7aK8MfJS7Ve9k/2GtAviwUSHEJM2lOgsIrLNNZU8pow9GZ2RJfOl6iR+KO5dX1zCvN+Wszt3i4fKp31btqlppYn1NwwW9UVE+dqrx5+YKwTq9wZ/fxQEqryashuBDIv96HEfig4/gvvkyGFp2haHdl4l/KxzlhQz8SnjUg5Y6/yR1QcEe/H3khkBgPkfEFF+inQktcCefqI72Ua9pXPVsBw0x1v7+tBxH4mrDkysrybhN/waWI4maXniXefZhFB8lh1SHprtQKywv6yfO3YbKtk2K6lS8XPYp6cg+SPdiVxfzqEkn7hxAXRMnb0qBhkajBvIncIvB5ZJYBPMKx69sgP+8t3qz6jh0jJ1Gyq3Dcbm8VABJIGhDrSRCayPUkuzt/OjXvzptAovhDjnH6Fc/Joykg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(6666004)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(110136005)(38100700002)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8bJ9KGw2e+KgC5zRh0T1vgR5Uwx2vj75gXlAUtm1usWCXZwja0LmobZmBI?=
 =?iso-8859-1?Q?3Py1QvZdClJSrvMuQdrR0EDB36px2hWZ74MmBmVsEjxUrgJTKiaKCZbqcL?=
 =?iso-8859-1?Q?/FNJAa1kVuw80ie+W6H9/m2lLRJMwDaokmhHN8Yx63RcG/oVgReQKJB8D8?=
 =?iso-8859-1?Q?iulYbi546npnRRYJtqGHDmxtMoBS0PPQsxcTc2LP0pFa1J5Xjjmjue3OQB?=
 =?iso-8859-1?Q?6SFpRD+MxdjOD4bOCTOFtCWQY/nELynjeNDbDovBRRfNCzylA36weMb0XR?=
 =?iso-8859-1?Q?T+Bc5mtaoc04WtngX1xArHnqfhtVI0k4Bki1X6J55pvZdI/ottPnXy4BOJ?=
 =?iso-8859-1?Q?3fsuaIbEEKcQkNjfbxEniTBrvmA3I3kf+AOGH9/LuWV5Ifg2zeMl60Fs09?=
 =?iso-8859-1?Q?mclNbfFqji3aH61kTHl1VZfjGtRrZglzWaZ0qXbWNRH7DEjB0aBdGwHLJZ?=
 =?iso-8859-1?Q?kQO3hT2JW8+q/DTrw4Fx35/X5lv6bND+EO84B9BUGEp4UeBo3i58VhCPKV?=
 =?iso-8859-1?Q?psUz0orT0vgCRCGrhn+9zeQkSaTje6zuy2HYg6E9xzkthd0s/jOFsbcUcO?=
 =?iso-8859-1?Q?qDd6mrx5pZHk+A746QPMMsTU2SJNBvBTcGGt1jUyEklprTKiYlRcO4Hf7P?=
 =?iso-8859-1?Q?FAqNG49zdwLQVbTBWwBr7QcZ7gnpaQpDX8nOtC1xaoVhKHfng4+4jE1qD+?=
 =?iso-8859-1?Q?/LKschAgPxAkdDWc1DRMuSKJDNQ3yoeL5w9bKzeuycvB7U5hzeEgGgjDST?=
 =?iso-8859-1?Q?7m1wk+YU5Tudn7H8TUXutOpL/aIIIrWjoWhEOerbC+C4qCEyqLE9CAX7WU?=
 =?iso-8859-1?Q?pGAHYgCv8mWR3zq8ureoi+AJIJT4cHJTAJUK5vBwD0+dtAu4SP4/CB35H+?=
 =?iso-8859-1?Q?5LWjXWmbvlztm3pBL+DeRvS3kkf+3aY9nj9159gvx9dHBA0Qe2t21Fm81Z?=
 =?iso-8859-1?Q?PAiYBZkGatEueFGVTU8zXBLXmlHThqToMghUFkgqeorrY6Z8IB2zD5TbAI?=
 =?iso-8859-1?Q?uaA5eM1M2TSIlT5cSng5p2s7wyd03l+dHGvLn0sQ18fVLRqgdkmAXg8mqL?=
 =?iso-8859-1?Q?qpV4Z+o6LzmYISJNsBzOWxFQtjGddzkFE0RpVHGR+Et9WGYspgEcK/9CE/?=
 =?iso-8859-1?Q?Ob7St8yf3Ag3gNrc5VILAqBXUTALl4Z98ALfcTGgSKy0QsH0uKUqNsnuUG?=
 =?iso-8859-1?Q?i6QbhBqGyQUZENXOeUkbda1Wklb9s+Zz+4WaFLqG5Fwvs+FLaML20FNrUz?=
 =?iso-8859-1?Q?zgmVinjO+lgY+KX6PjOtPsBTOfLN8lhUxpZd4iZiGbrmMyy/uVwMNiG9yo?=
 =?iso-8859-1?Q?V6GsAVVL1mvnYueGLYUiqOq2/Oz9S9F9ZK/l4wcxaZJGBqYN8RoOJDI7gk?=
 =?iso-8859-1?Q?9D8w3JY08+f/zqDq3p4o7p9SqdoXNYpGQebtowCGKLWvsB6zTCoMLhBSMD?=
 =?iso-8859-1?Q?+ZCmX718PRRt5QwQ2qDRzTbdm+eGjW8BQOnWbFKQRSqbI+lEPBmKtwBo0o?=
 =?iso-8859-1?Q?v/yghcPcW4FcGTeAMgdGu5f0mAio+nSwMaoNtLJrlCLc5bphU6q9vzjxSE?=
 =?iso-8859-1?Q?fXngjzpxE0x2OtJTIK0QNNwOqTqq4v7QchuS0mOjnsLiVgmwSmLvJSeJff?=
 =?iso-8859-1?Q?arcR0mODSvLuj2ch4MJk0qEDhQP+v43m/TTapElsPJ+IobavaZnNiskVzY?=
 =?iso-8859-1?Q?7EuwMqYw6/buCZ/eLGs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0baf5c1c-d8ef-4cd7-4453-08d9b4d72736
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:15.6931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmBwb0uuovgkiSktpMDfIox6Q3fObugIqo9LVwbmNCFKq+quyE6XahRXvUPGqLVcxC9UCxfYke10gbSt+k2XLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: iqTX6meYlt8Qva54bcXHZkXi94ArY7Go
X-Proofpoint-GUID: iqTX6meYlt8Qva54bcXHZkXi94ArY7Go
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index e552f5e0ccbd..7af58fd467c6 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -528,6 +528,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const int grows =3D prot & (PROT_GROWSDOWN|PROT_GROWSUP);
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -559,7 +560,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -585,7 +586,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if (start > vma->vm_start)
 		prev =3D vma;
 	else
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		unsigned long mask_off_old_flags;
@@ -647,7 +648,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			goto out;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(current->mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			goto out;
--=20
2.30.2
