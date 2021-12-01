Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ECF465006
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350365AbhLAOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:41:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55404 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350108AbhLAOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:28 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EJZTM012062;
        Wed, 1 Dec 2021 14:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qySFw+X1GPAl5BW1S+EiG6vLqLNDW3/J6JndGMz+0Ro=;
 b=QCECo9sp/evHhGCK7gemERuVLInG8z//+QkvfJOMfS/lxvEuvrEUN5eqHLZy36zGkEVt
 45lgysF6Up3LG8TKMJ9tdTMhHcHDesGPdn8Wb5n2mHgLN29r66WAjDElFbz1s8q8MmAv
 w60ksH+J5YQUOo8qCw6xO/16gwYRph8ACEIvgs5P9ygchPgmPtwdxBJ+Pcfca7XIvOtS
 i8yIr89XKp6q85iYG5d3clt2bMq139iqGA8IW4WkvDzQKloBRSE+10lTLHZ8HoEy0RvC
 pk9fQQ2jowzW5VTJvGwnqJaeDPjVrgSnXj2rAzDTz6mt2yrmxT+NxPNfI7PbnizoM0F5 jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1h0wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBov1037539;
        Wed, 1 Dec 2021 14:30:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3ck9t1v6xx-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S726Pm1pxxVQ7rfRbuOIQ2oH3uLMkh6chZpZUu8vAnU39fdGl6VOHgl2T4LYgwNyrQ8iJOd5F79qMNu1tqMLNA3rQUKReMVP5nRick9K3xBR9kEMarGJipxDl6JuWOngzpLaOjzzOJt2aLC2Uq5hdUlZjSSqhdzZO3ohW3s2RivMbePd07w1D2DFviBEk4NrbiUxuD1QFVbvClnkRvUVgBKWVW3OMC6J5TDUAH4ZHhr0Bn/I/Gzez4+rNZlMBSY84OEtg07uS3tC+oPreq3twlgj2MQVCXDucwt7ghVSkhlBrji0D5NKSIUl6HSfufH4/M1eREutmwz1BtTCJFbO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qySFw+X1GPAl5BW1S+EiG6vLqLNDW3/J6JndGMz+0Ro=;
 b=b9M94+q0g97ef8y71mebiPb+POmpR0uYMJIoQ6kxB8Cr3OAxatI0qPEt0ezS5BlpFfqxAaVWl74YHl0+GdaFvDV4cqRP/Q60p3Sc3PlhiVIA3gqxmK/zyyWYsI2OerSyWZzvaNrYL6vBC+U/nC7ZYB4JvVWnbdMjeZ5V+EzaddRV7NGogmxK0blC1Tu/hEp/Bz7kNpUPtFODzzf9J4aU5pRd7DL9kkAvjuau2Y/qqArC/39/2tCa73eWuiqNpqnpdMaMT2pbdHrdEWxZbiiMUL6F8QYPtif+8pWCsCQO5lxG439pMYuIrj8wgN3D8G/uZXmsP4d4mIYZGWRxxujAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qySFw+X1GPAl5BW1S+EiG6vLqLNDW3/J6JndGMz+0Ro=;
 b=gUZKvh9kvs+hZExoqYzlWIiUm+Jm4/iAQbm/SYH4CgK5LD/Sp9Cetd6pJnUzT/azpHRFBCphz+aPfZYMd2BzQzt9gr8ghVHDDMSaR6p6iNVY2okmXWoHXwnmG68x82/8mJiGdXLYBQGpsDYTmFcdptXJ4FtTUmZN5G0WRbqyquE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:30:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:40 +0000
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
Subject: [PATCH v4 52/66] mm/ksm: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v4 52/66] mm/ksm: Use maple tree iterators instead of vma
 linked list
Thread-Index: AQHX5r/0oKsiVYoWv0SiYWzYqFoOkg==
Date:   Wed, 1 Dec 2021 14:30:13 +0000
Message-ID: <20211201142918.921493-53-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cebf8358-451c-457b-b35b-08d9b4d72656
x-ms-traffictypediagnostic: SN6PR10MB3021:
x-microsoft-antispam-prvs: <SN6PR10MB302134D182E132A68F93CAF7FD689@SN6PR10MB3021.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: US5kbistU3+sLZ4EPBbNO2g8L5pQdKzo74NQ4/+I/LWXj/ja4JdRqDMZFUcVZRYwmRr1fS204kizn2Y7mUYUBYqt5tY/PI7e6vl0KPZpVXtKgij/H2fL3cM+1dRIoCwArodnGig64jeComOG9RGAJo7T35/oR5fai8IJUyCADqIJCBd/wL6tNPMbCikB9hbb/Sex5GtWiX9AGJ8Cape9P5EddQRzWUwrtcFadIVfTkrqL987r86yfsf2SZyuPWeM6o9vsHe6VZ0ZJ/cAjR8JtqtalDtAD0OrMEWYstI/TraPA1caWuFWzFQfcB/a9qflMilU2PNKzxAHYdaG5udoS8/LfcJVUtO7lyNbebzT/EWINA1UesQ+jPd0870wS7kXm/Bq6ZPdLggXzhQiEBZC3qha/SqEClLr29/GzwGE3VvnIzbCByqLNT2N9PWOnPmpzDGlO+HYcqfph9mWwxom43lXJps2Q8wYZNcl/w39JeaqEKt6oPL1vBotdZfYhFowdWimprQ0sRjRBZCkXeMDg+oHsIiLstmieDHkPd8PenZDMx68FchHvCmdalyyrg+zjvmKHu8nPX1jDM/Ad2BqMhVbiHC4uLH9XE7JZTQujlyzRAFL/RNAjC72KTFp+9HSJXANpXoE8ECSAox2l1ihuUgGkJ21bDw0x/8NdMZPBFfZH9/jBgReA9J0HIv62YIIFX+Sr8wowBLsz9PJ/9YzJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(38100700002)(107886003)(38070700005)(316002)(66446008)(76116006)(64756008)(66476007)(2616005)(122000001)(83380400001)(2906002)(6512007)(91956017)(508600001)(66946007)(71200400001)(8936002)(54906003)(186003)(86362001)(44832011)(4326008)(6486002)(6506007)(5660300002)(6666004)(36756003)(8676002)(110136005)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U5IQnYbaBqzpJ1HJyum+5jrNkzbQ3ICsg5tgcBE+XmzsbcAhoj+ZlU51oT?=
 =?iso-8859-1?Q?V59EMpF/XodlQB9sT5wgC2TjX1XyarWXrCzPb2BLUlYIctpbv87CvDSWAM?=
 =?iso-8859-1?Q?Vq3yPWBFNtT8Kh6+PgtZiIoi1djEUooCCt2D9ZqOrTDP2iQ0NuxoosfR6R?=
 =?iso-8859-1?Q?eXjjAXE1HSGjJ1an6JZ5DuTImtGMSdHGvJHI2wK1VLhS8a/oA5pR6SStwp?=
 =?iso-8859-1?Q?WypWg7m/8PdXb0M39qs3EwOilf876AYlvkliuU+S5lOGdNrBbIJP4lD++U?=
 =?iso-8859-1?Q?LWwVguhMU+Qd3Sg3VvAwiLjsFjzWaC2k6JtowwG1kkfUwrZmrI6ay9nJ4E?=
 =?iso-8859-1?Q?Nk5nj0mizo7t6eCmg4z3/ZHEY87AUko8kQsWIz3R6fX8qU3vdQWXvaTAJV?=
 =?iso-8859-1?Q?r2IrIZaFdE6HoxoTZtFcNgccFb83Ilk7BClDbwU3nfetx1xEaUDCMv2ix/?=
 =?iso-8859-1?Q?9FXBMHhWmLKM/y+cWi3pqcDkSqU/ce0T0mleefr7xNd5TvB79SbZDK7p2b?=
 =?iso-8859-1?Q?74SJrulbH+/7zlHZhe7M5q9bZRK/ulz9P251L8ar2TiHp/NaDHPfhjrodn?=
 =?iso-8859-1?Q?2bSKEyJTV6CzriKgfGF18gA3wSIUEmGmrS3fLfGCVCoOwwvd8YwxpQN+h/?=
 =?iso-8859-1?Q?yUrMAth6UgTGSp1lpKCo7Y7uhKkQTx4RWjsmeLxdHJiS2w1szzMgsa2jB0?=
 =?iso-8859-1?Q?Q1x79e37XfqjypPHpNnGO04ehjzKaFDSjcfoeHw+Bc+8+HALch95ujsRCF?=
 =?iso-8859-1?Q?fvG3QvCEL2yPTvo8Eg1nGEult4L3bizOja/3s79Fp9Fr9ODgv915FhinZG?=
 =?iso-8859-1?Q?zV6U8hz5In2xTQgqKZR9UPlqIc7JLz8FImL5koGK6a9+fBECNaAddpmYIt?=
 =?iso-8859-1?Q?pADyfrB9iwMh44Gqrcl149gQfRW7KYljr7jnYRhClajg14FzWo4lPtiPD0?=
 =?iso-8859-1?Q?ucflEwMIL53f+En1u+hbvb0vHrvB1LSk5oGOd4dF9Bt54/9prlPonCBkYH?=
 =?iso-8859-1?Q?EveVhv+iEfbsY/YDUkv9t1XDn4x9PYF8Qw+4J7evU/opQRuB1p86bh+BNb?=
 =?iso-8859-1?Q?fXKTeItpXCK8nNI34utp71TKjSjT50LlNO+G9DmRiK4cLIrtxkIzEne/1L?=
 =?iso-8859-1?Q?37yXhEem4KuQAC9tc5vmrhrTP6KA/HHJM0WpJzEbCS71ZP4FtPBvQ4Kogg?=
 =?iso-8859-1?Q?dirt0vmLVYCYbpAbHWlZa09LS/6PBec5pfITBZgImXLSQrXg+vdiOMdmEg?=
 =?iso-8859-1?Q?REiRbMKIBor6Rxzju4M6LPOTv9cFPWT8fH5h5LyMX28TsGY5ELxoC47p/e?=
 =?iso-8859-1?Q?lersIyAvVjPhvh6rqta/TnRhD0tAOyHyv58FjkE6QZZdCrxRocXWL83fSi?=
 =?iso-8859-1?Q?0RNd4iu1MfPEjI7ZCeXeVQDkAZy/DrNS7aYSKtCU7ZxkAYRoSjJ5twC2+1?=
 =?iso-8859-1?Q?JYTY3qfGcubQ/D+h72A90lcAh7on74HNrJxLWcvjFPHNBewcKVotXLu13j?=
 =?iso-8859-1?Q?1puB8YY/B8yShT/phq04XoN8gYJH6ipdhJRSBQzF1DsX1GPfviwXs7mXps?=
 =?iso-8859-1?Q?Jo1QI4Ui/l09IsdJh2srTiFcAspYs3q96G2WOBWY0Ak/T9gQJZmYpaXpu9?=
 =?iso-8859-1?Q?KVtpVY5kqIlac98zvfxuUxJx9NIOquv3merBM4jCEpNr9gA6Izx9q4RwRh?=
 =?iso-8859-1?Q?3reSv+hWSFSClnWd2Ww=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebf8358-451c-457b-b35b-08d9b4d72656
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:13.8081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXPbWqvXB3+m5GqthlQoQTCajD5dL45n7XwCKehhgmF/3oFHHSBE6ozRRo2L0/F1Sua4qJF8zx4dWxtaOTegZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3021
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: Z-W-5-LCph-dkD4vIemhy-Ga_n7YVyg6
X-Proofpoint-GUID: Z-W-5-LCph-dkD4vIemhy-Ga_n7YVyg6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/ksm.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 0662093237e4..d309249c95a4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -973,11 +973,13 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		MA_STATE(mas, &mm_slot->mm->mm_mt, 0, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -2226,6 +2228,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
 	int nid;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	if (list_empty(&ksm_mm_head.mm_list))
 		return NULL;
@@ -2283,13 +2286,14 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	mas.tree =3D &mm->mm_mt;
+	mas_set(&mas, ksm_scan.address);
+
 	mmap_read_lock(mm);
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2327,6 +2331,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
--=20
2.30.2
