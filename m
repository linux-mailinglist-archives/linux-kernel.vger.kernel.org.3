Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC66464FF3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350089AbhLAOj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:39:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41118 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350051AbhLAOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:22 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DDQAB010074;
        Wed, 1 Dec 2021 14:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kT3cEgYgmm5Xh9Pz7hJuun/feObyMjjkmh7VxMJX6Vs=;
 b=VjoLVn+/WeNqcCxr1ll8AV7HMXgHXlJLWw8GsTR/58uLJU1PRqLXtsgFoJ0vgwFafyvo
 5kIHbkkLJqXBnJ2h9+LWOBsrWDyBIRkg3ToC4XLTGr49hWVUkCT35DpmclM1WqG7yd21
 ZpD6RneK8Xk5KyjNEomkdaqCv1QkiwWAaR7WJubaLyroW8II4b4x0AH/wiV1PtDmKdr3
 8j/BIlZ2+8kCxo48BJaoShWyQJz3JwX7UvGFP21U55dVmFdbIo34Co9wA8I51OzHCxNm
 fYeggYtnBUqTRsyNSUAB97O5OpLnGOI3rZ5qaacTmNFtl/Qs3vwKWyYwJN919RqwsvFE RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBl7Z109791;
        Wed, 1 Dec 2021 14:30:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3cnhveqcc9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgVDRT/34mhxinPo8PYqWlX3J+krRu4m+EHn8ipJnTG5Jd3SrMhLP9FyJ/xufh/KQkA/AAtZCU7/P/ryTibM0dau+MOcfL6NAYRLU8+NI+PEJYtEc/4aFSNrq5A3xGg0ruZZJUz6Y4erWgYr5nGRbBBXerEORaVTGzT57bNTFCKobPg5AzBnpmhb/DKaKNqe/xYzDmogmeOvHgSN7MAm8HdksheqmUSZioigip4L9nxDVuR8+/CC0k8sZxf+0ivECb84rQHeKVlcLSEXvnaFwNUxRuvr6UUCis6ycsNZXq9K/3tDHw6MQ80+qYCBtoSyG7kxxvv2zz/heqSopWPNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT3cEgYgmm5Xh9Pz7hJuun/feObyMjjkmh7VxMJX6Vs=;
 b=H6ecQqF4Di/tlCCs5ALoWEFL7kaxeTFruH1f1O/prLRBgnIocYjllWgNXjylBuVGyN58gGuxyBnk6RHyLO8KdUXBQLFJCHwk7ximxFaw7OivBQa5Ehzyq4Do2OMThvbJZ4JQULo9s09k1cI8fRcLqLxMa+tdwNJUmk+H06pO+lIgeXOjW6hiK8SY4XbvNIkKBEf5B1BTzHYIXjQGxsHXiZwQu5dEK9F7ddxUwc1aueyx7TzLUd9wREH51ExgVJl9oWSLUWj+Cr2eqmSYEq+unCPheAGK/DRMB+Css6zGLm7JpmBf2Vy01PdIoNCeBXPNKJgD0e1HtbqUhQrErUG6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT3cEgYgmm5Xh9Pz7hJuun/feObyMjjkmh7VxMJX6Vs=;
 b=U4S+mfkDmf30Qj6ibd2izC0XaNwuU+h3GaFyQUioyRPFC3nn4SWXrr/5fE0gGwti/228pG2EduUIELOpX8C7PafdpgyV/ORaBaxAs/ohQjfErEiZ5ww/gWo4p1LYA3iabY460cOS+hNF9I2srLoO3KLBgLB6eb6XTzrLBHAfihI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:38 +0000
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
Subject: [PATCH v4 40/66] exec: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v4 40/66] exec: Use VMA iterator instead of linked list
Thread-Index: AQHX5r/xeY0gQmeZr0+LO7hmfQvN0Q==
Date:   Wed, 1 Dec 2021 14:30:09 +0000
Message-ID: <20211201142918.921493-41-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 036f19a7-6038-43ab-5371-08d9b4d724e7
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB45081743B7A38480536FD340FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTxaGGg1Z4/JkOLLQNz7vTwORgHOaTVo3jFK9xE09FaNXmOLGcKV9bicLdS6qIk18CvxaeS0lIfJCtIB6ZbQ0fpWAVYpp4DqIhKKA3vYu7heWxk757KKIw8avHudYX9/f7L02Yh14cajuh17AdEWWsWrTldBfNC5BWbw/QxSVSe67WVKJlXgvi2ATK8HbeDHMkA7aeY/GXM0yGZ2yZ2fwkuiqvJ1aYooh53O2x3IuxuOad+3vhiYZBmFTQnF4jq6+rSB/xfD2v/NVKLiktnvlrEhOJGHA2vjM2T4Rb/DLjmm5fcdlUhUN+N2oYosHl0i2DRwmC5eo69axVoqRJMmqyol+28cdzuGs4oF91DdXmhIic5fD2gyzao7sECS2eK8ujhFX7Aba2Kb2ZHAXFM66wAUT7buk4sERnRyZP69JS0dgXL+qK8d4Od0M92j6F4M6P47PIMaWzqIvj27RD1YItdj4peYdhk2XkpNcjPKk9oNvGPGjbPOM4vgZcNehdGVzS5qT8uHahQPG0vXYaQh6h2VFWapSWj9VRwwQCATNK8/CZzXDKPbaIMVa/oZBVgV2ny2YHTxWuqkeoYFwAAdD8yQ2nKD7PyjWZqcqS665tozMVzMj5ZvBZOR7jVkhxDVN2ZB6uRVc3yxskM+RSgqFZxMFzZtxeQ6xpEHSBdp3SfhA7W+Ju+/rlommd2Mz2Ye
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z4CRAtJfSJEpvF09KeUg8HZha4ZQBg27AxtdlGnHRMme4u//MmkIAxEyvq?=
 =?iso-8859-1?Q?FyzcFvlTbvsaoRjwJOGayo6JcwRP/2yTdwmQYrsO0MViYxvr4lKBpcjdxz?=
 =?iso-8859-1?Q?Jhg1n8J20fs+KUDbrMgTJQjX3RgQ+WJF8qRnWEdv7v+rRRoSt4LT20w9N9?=
 =?iso-8859-1?Q?axmyfTxVMa+eC2tJ3vhupaysClymL/6d1RYqzTC+mZcVLjHmzF0/pkMy/Z?=
 =?iso-8859-1?Q?RZi+qyH7SqvnvLbQNqgeqak9ySjYw/L1zAkGK2shILu9h1qp7IqbGFqrQ8?=
 =?iso-8859-1?Q?IEThWLfmJvdrAqUXfAuL/67v1ziWY6vA5Bv+Ao+6j5r5fpeoJfOi88kFDV?=
 =?iso-8859-1?Q?ZEmMnxtpztD+2LWNLZcpkKDQVPC0ZTPKBBz7EuJotJuMtC8rS6qNf9gMcP?=
 =?iso-8859-1?Q?XLBMF48g1VXDiJHhnYbkpYwOpO67wyqfPVaIq37f9mQKj7gMs5ivpPUaWn?=
 =?iso-8859-1?Q?GqFwUEAt8i1AHLcs1C2tcV0jB/MbPYUew7snms97wd1+bzeuEFlQ2HmrU2?=
 =?iso-8859-1?Q?4sNTb0vjlo5hgmUc69Qi412JRJ0DcEu39vDzE1E5cM8DbF8uZ7+M/USK2B?=
 =?iso-8859-1?Q?5vSS+FL20bHXmy+rQXVINpsENYHNlsnI22gEGqy4VtkhWuUJrLguBfi/d/?=
 =?iso-8859-1?Q?qypFZ7i8OOWyMgJM5fwPcIQlfv+Y/azdhrl0hRdHwGjwqT/ELEs4E7+bna?=
 =?iso-8859-1?Q?wb9CSZOpjqTvs5EsWLIO74n6S5REkZKw8ALoppGzzW0Uw0DqPs/WUA2mCL?=
 =?iso-8859-1?Q?vG5IR5WHq480KmfcAQ8m6vtjuRyzWnumr9mn62SQA++EG8Sd7dnqY4HiXx?=
 =?iso-8859-1?Q?ZjgA0AHI/MYBh+t83JBTTzZA2JzMUHdHn/g5VuTLhPmtV39PoTp1/nZNdX?=
 =?iso-8859-1?Q?cbYAhVvI30rHwhqVoVX+r7tiTrtZeTc17oMX9cWlLaR0L6bFdW33Dl0xq4?=
 =?iso-8859-1?Q?RpZJYTj5Fm6hr4Z+WTRyvohrGAh82FyYHv7BXG9+z8Sujcmg0hGK49TjUS?=
 =?iso-8859-1?Q?7Pat1dvsRiRr60QHWYIXzIUEL1VQlspVXqk6CXpMPMbdEzixVbL0qKMhqa?=
 =?iso-8859-1?Q?KJlSL1Zi2+X2k2YS8M8aJnnMvcyC5WkOGAWVxH3ZbKWy8+ej2yiE5vqjea?=
 =?iso-8859-1?Q?LtVa4MYaa33O6Iv3j6C8zlC/8InSyHCSKsHxhU9WZ9ydwBm8+q5PK4ni2E?=
 =?iso-8859-1?Q?wPTmYS47punveV7Ed5m+BkaEn9ScGbFeX5os8MoKTon7yq0qN8o7wQ2OPW?=
 =?iso-8859-1?Q?Z7utENl3rFZzt/7S5wfZ8mes8m/94wyj8C+6uCkMUx4sh+U9yhc6HpRvAk?=
 =?iso-8859-1?Q?SWwFt+5HGd8ekwt1q7YzIYhbA4cs639/dF/aOJCGYIwM5xAcoaj+d9fzdC?=
 =?iso-8859-1?Q?RE9dweL5kEo0Opx+YEznL0E5jyuEInWFL2P8wSTsrttZbamLBmg4wK7UsE?=
 =?iso-8859-1?Q?iJkP8ItpOtaGG+8TeM/NQYfXHKclnqiTjkYb2Fda3UAlIl/srBFJRvRoSk?=
 =?iso-8859-1?Q?H9XTbLXIkLV8764j3QbYi187b/+TrZlnTcmQ7T8ucrHWTyFZV2/MddRcFU?=
 =?iso-8859-1?Q?IkfQGIfWVjy2uVWEN2mFw0Vqq/gi4vi5Qk/S1KMcexrCMO3OTIsPE3H7+h?=
 =?iso-8859-1?Q?giWXQDschSlWDoa3wDAtRhhwkvnochJaFNzoR6a14LI8SwUbg0AF5b8rQX?=
 =?iso-8859-1?Q?NuNrlT/onwxYtL+U/tU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036f19a7-6038-43ab-5371-08d9b4d724e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:09.0978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 574cvWF15tixcFudUJzI6kPvz/jFRHcrJh9/90583zkLzZkxxQDqnRadfy27dr2SWDO6KkcuQ+qN0iEHmtB9hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: XVgD2RQh1yGZMHby76tdzLwVM629lErh
X-Proofpoint-GUID: XVgD2RQh1yGZMHby76tdzLwVM629lErh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove a use of the vm_next list by doing the initial lookup with the
VMA iterator and then using it to find the next entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fee18b63ed35..f033745c148a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -680,6 +680,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -688,7 +690,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	 * ensure there are no vmas between where we want to go
 	 * and where we are
 	 */
-	if (vma !=3D find_vma(mm, new_start))
+	if (vma !=3D vma_next(&vmi))
 		return -EFAULT;
=20
 	/*
@@ -707,12 +709,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(&vmi);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -721,7 +724,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.30.2
