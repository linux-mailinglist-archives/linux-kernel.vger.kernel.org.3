Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8ADC465004
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350197AbhLAOlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:41:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8032 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350122AbhLAOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:34 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EGXh6017179;
        Wed, 1 Dec 2021 14:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d9QpDyUyCoaaHcZCJU6UAi9EaJPiZ6K/NgXkBojs5xM=;
 b=LhiL9NFYRVr1es+dCayuwWP+vFlXe7lzgEaFyn+Zv0uaQ4DdHyNEZslVd8K7+IdNNUyi
 KGwdP9gXhErHelLXeT9aZbofjMhqaowBS5dqQPDal1XNMj6sVLqGKmVe68HNtpb9XdrE
 7UbdKy5JCOr2e6qgnJHY/hTA0MnV+15Z9nGNNotJDsOdF3JPluNJx15rRVS42dKipQwc
 m5ffrElyxXeHtJPIfyhdbIzIFtw59nOuH2CB289WUOWc4h3oUUcukIOBBdHy70zT3Mru
 erRAASKo9KTiagMb9W31qxe9l7r/YgfCyUdqkfhiNromBOi+j2Zwf+GkYsGeQK7oI7Ae MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7weh2x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBl7e109791;
        Wed, 1 Dec 2021 14:30:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3cnhveqcc9-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGlp3t0cp3JzRhefCDz6vIJRE1lJifjwE0S0kUOXTBvL+MICS5yroc14RScYDu8bLLZEnkxp/BIFjWbPBIQWFOBWEvshxI3VepM2FL9SIcjwpWaMn07qGN5J9IXo+Koev8oiQj3CBbq8S1s1WgRk2JCH+SFL6OWDJ6sZ3zNJXFwZgH2OJd2VJs4gXVK3G7M9fg1Bfx9ESQ7SyZciyD7yPgp26TsMvfLJ2E3diBfzk32vg93S07yeoZsK6D8/b9RbG0EeMsMDMGH7pkUMXqgKFwOVkgZwJMzXQF1TSaojuyOpP9EPp1NiIqIo6jzpokqJYQu83zXiF8LShbvP7m3DaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9QpDyUyCoaaHcZCJU6UAi9EaJPiZ6K/NgXkBojs5xM=;
 b=Z8/0PJikcBqDOfbYbDAlmVemYPNZfBKCqHBbFnq30FweLKgKozVed1oTJF7/KxuNjTMilvj2pLt67VJQ5VXlKOR8OR6H1vBiVyCj06WXqB8Um0JiPJN7FZBiDnv0DwhChl1Qtg5rEIquBv1Q0aRAAMEM6Yfunww4TFzx87oQ1hWAhUFTSxm0ejlWSMmHZJOxlbzKopDRtoQqL5MXxAEGch8RNWNzRz5wN18GduAbsJuhpVYcBNhmEZGbsEf3ZfyjliGkn8M4D8Wd9WTizijwQM1tb3YNu1Joc0a1GqodJ/fQ+WcA6hrrt/0wh1aopFgxmquiP6G4fSid6lR1m99hYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9QpDyUyCoaaHcZCJU6UAi9EaJPiZ6K/NgXkBojs5xM=;
 b=Re5obKQc6Wo2NJ7S7wevJdF70XSk4KG6gV1hiQ0YyhR8aCChBAn6/ynH/oeLYuJOpu5XfgyAiuQGV4XvFQ1MHDuQYCzNcEl3H+fQK+q6Hlj/xh5VIs7vsM4sHg/kjA0Fx/rCI9ddT8qrgzlkzgQTMHrjZn2/r1C/VnT0kkjAFO8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:39 +0000
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
Subject: [PATCH v4 49/66] bpf: Remove VMA linked list
Thread-Topic: [PATCH v4 49/66] bpf: Remove VMA linked list
Thread-Index: AQHX5r/zsqb9vHBNtU608kZJnpd2mg==
Date:   Wed, 1 Dec 2021 14:30:12 +0000
Message-ID: <20211201142918.921493-50-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a6c9ec5-c44f-45d3-3c2e-08d9b4d725f7
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB45089390471383FFAAF9DE41FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJ37/u9ZtFn+cypTfXzKV9WRuF8vObpbmERonpK9nIJHzVaC6PzRc5Pt3waea69d22p57mMdA6QNmDjTirK2JrQF3B+Q8X0STm+XHXsYvs/pYDrtKimklM4rzlfaJnhZRYoek6jMks/vh9/LJuJYCFQC5KcKZJtaFB1rCoXfZDW8H3/r4sJM5Ef+KdOt7iD6JTQsMCNzWMKIyKJF+fCYAiszJtY3YXoNg+WD1Pzo7PSAZ4TZZreeAepCyFWMy5uGqbpDMQhPjrQV9YX2GZknpS8/8nCROLBGTAElEfNrmnUejWKiiYtbg79pIHCy3zCN39ShZNb6WFQU/X9XqhJjmRtEUbRfD+Dyo53xHJJ8y5uyX5jo8QH4Maoz5FcEyLr3qWrvURpqV5z9LxM49HgbpGAqVHRImmFwWJ1H9zpjTbiys4Wzo3GK8NpKd8DjSdMpCJJ3kZZXnz0GvB13FNHDbkkUztg8iwlwEM6a7cRXPaG/NryZRG9BhZ72hE2dhpYxfSXqbV9xwEek3Ra4rrvRaz/mTv3JnXdADup8YeRmTjQddGuUAu/fBBFVjvLJk1sPCzNQCdPC9at55JFbLvXq7NHi4pKq4OLcUzQidXhUXi7rDnsoLJUKkcZISqG4ktQp0WYqhtHgzbW3OUJ9NKTb8B09JbzY61ovnZu9MUf6Zv7ZHnf2TBkvk3T6celdTEvR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b0WCi0f1nakPCOkM9q0NW1fBgsnD35E8vityL5bZG0NRf5aLE7Bf7jiCjE?=
 =?iso-8859-1?Q?YRkRjHbU09aqtllFORkAH30k4sntyy03KD61drpuGxY0abGHaQqlenW0dD?=
 =?iso-8859-1?Q?mpEJlSbROnkPfAwCFpjkMhs/X4+32vJio3dH8lonNlnbv27H4I3y9yqoR+?=
 =?iso-8859-1?Q?1NJPI30GXkEnKVnUHDMiKcWFKwpETMmUyYxBIwger7EKI2vU571UGoPcPg?=
 =?iso-8859-1?Q?ywDsa+crQge8eoDhE5AHYYI++seihzNuZlQqZqm7yDH9AJmdABKiVaJhHw?=
 =?iso-8859-1?Q?VSfY4yEfBucX5PSIS5PSxnxEQTE+CegCKdDkoMmuDMdzG0AmvScPHSXYWF?=
 =?iso-8859-1?Q?dpJCVxAiwYPJ/1idNfELpiLWkuvxgffMUOlTLfF2ufutYvWE0xg1pw70D9?=
 =?iso-8859-1?Q?qQ6FWQLSzrtC0/3OX5BozP5BGwfC2/smAFzM7w70PDJhCiA0Cz9/5bjW44?=
 =?iso-8859-1?Q?aSh4wM3JKVrkMdVxzmoqw3GYjMvVKa55K0qdtheIacSlX4mYlApkNJxIwh?=
 =?iso-8859-1?Q?UH0h0vwGoBbjjcTcocbgAlhFam+d9c3bq7buWbrCPd+8gjFB/NsCU6x5b4?=
 =?iso-8859-1?Q?YcvjWPhjcWMkc3ugQyo03vG88k8wwP0bYWEmh1GV2BYN8AwhD02Xf+VK5M?=
 =?iso-8859-1?Q?u3ZtYRIHP8cJ1iNlvcekG1Z1WQGZB8P5nry5bt4wnzwlWCDZOjijlIANFM?=
 =?iso-8859-1?Q?N5VZxWKS7iFLBzDUeHo6rmTACwnVk42EILsSBmLLunMqtC/JMslW7WHGpH?=
 =?iso-8859-1?Q?ykT4RFO3WylwoFSGhMFomI4UI0PQVeuD+vxgAxq3fXCQeN7tEE0K523ILP?=
 =?iso-8859-1?Q?lxn+F5rBm9iVup0yYqLvKt00OV11WidcMp+JonEq+CBRrSqfnBP0queakN?=
 =?iso-8859-1?Q?iZUCfN/Q4CIKm3PA63GOwna+bF3QhVazFizteyEoiDVmYchUNHEqjQW/Lm?=
 =?iso-8859-1?Q?hkXJzczisCKCPYG5eDZo/cU/5e8UJoGk/YkoSCgWtkaSyj7wk7Z8F+RAJm?=
 =?iso-8859-1?Q?zQeHrPz/UohlOraDdG1PQzfws7yjJ+AHRvgRPjHc8Y8LmDAVE9oHXhzRyx?=
 =?iso-8859-1?Q?DkTnR9HselHO7BxyNJrGWR7PPZ34QRF+0qmauPu/XfMic0NQAydsZ/chEz?=
 =?iso-8859-1?Q?sMVaHwMf3HEcJPh1bkLQvRffNjGGIzoyqMe2WvYGtO5yn42BAR6pb29EI+?=
 =?iso-8859-1?Q?Lvz9+DULIjhkUc58QBN+1TTgZ7R/1gSrUkBeOWgp8Z5CqWH62Pt/b2bJG7?=
 =?iso-8859-1?Q?2uZnpeH7t10X9l/If9ocbXabm/1vBsRREAyt5/fua1rc9JFyQrJRGGjVfo?=
 =?iso-8859-1?Q?47i+xFLE9xJSRxZRHJcKVHPoLt7nnpj78zqd8WYCUq7inoMgdWjgT03rUs?=
 =?iso-8859-1?Q?XNg/aN7BIq9tB7eYtqPkSzZCq29oUj7YSkqiJmQps28+s/TNKk9JQEWAF8?=
 =?iso-8859-1?Q?dDi8+dGQdO1UpPexVm57Lazw4wqm+aRjqpabEI4E0sz2iFzLVFD5biz3vm?=
 =?iso-8859-1?Q?sDW0wDj9HuytxJhYGFlAP8JPjKzMziyX6MbpFNon9fiCzNW4kdlwFDxXFY?=
 =?iso-8859-1?Q?x0qdlnL+3dTNsKCyH3EhwJ6C+fDP2vX43H+N/niFfcBWajcOElKRSTZKv8?=
 =?iso-8859-1?Q?V8lvJQ+kAXXU5DcRHYVE2DX5PH4azQzk6EqI6zbkaRQTsRUAIvxEbXet7D?=
 =?iso-8859-1?Q?jIJsPPdNuXmIaswhfis=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6c9ec5-c44f-45d3-3c2e-08d9b4d725f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:12.6558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Re0KYH+ixES+d+JcQQ/m0EkyTg1og2ISR66HoqW3KFLq7Ig8NqZkDkTGgm6cGuK69mA9+KnvbZ9E/UddDi/RPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: f7n75AJnNdZ2TW_feURL8qBdnl1wX2Jn
X-Proofpoint-GUID: f7n75AJnNdZ2TW_feURL8qBdnl1wX2Jn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_next() and remove reference to the start of the linked list

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/bpf/task_iter.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index b48750bfba5a..2d964743f1e6 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -299,8 +299,8 @@ struct bpf_iter_seq_task_vma_info {
 };
=20
 enum bpf_task_vma_iter_find_op {
-	task_vma_iter_first_vma,   /* use mm->mmap */
-	task_vma_iter_next_vma,    /* use curr_vma->vm_next */
+	task_vma_iter_first_vma,   /* use find_vma() with addr 0 */
+	task_vma_iter_next_vma,    /* use vma_next() with curr_vma */
 	task_vma_iter_find_vma,    /* use find_vma() to find next vma */
 };
=20
@@ -400,24 +400,11 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
=20
 	switch (op) {
 	case task_vma_iter_first_vma:
-		curr_vma =3D curr_task->mm->mmap;
+		curr_vma =3D find_vma(curr_task->mm, 0);
 		break;
 	case task_vma_iter_next_vma:
-		curr_vma =3D curr_vma->vm_next;
-		break;
 	case task_vma_iter_find_vma:
-		/* We dropped mmap_lock so it is necessary to use find_vma
-		 * to find the next vma. This is similar to the  mechanism
-		 * in show_smaps_rollup().
-		 */
-		curr_vma =3D find_vma(curr_task->mm, info->prev_vm_end - 1);
-		/* case 1) and 4.2) above just use curr_vma */
-
-		/* check for case 2) or case 4.1) above */
-		if (curr_vma &&
-		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
-		    curr_vma->vm_end =3D=3D info->prev_vm_end)
-			curr_vma =3D curr_vma->vm_next;
+		curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	}
 	if (!curr_vma) {
--=20
2.30.2
