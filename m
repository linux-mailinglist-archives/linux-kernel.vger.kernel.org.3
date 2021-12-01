Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA246500B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350545AbhLAOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:41:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52332 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350096AbhLAOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:26 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DDQAA010074;
        Wed, 1 Dec 2021 14:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Hi9BLqk2llq4rH4Dfl2dHM9t+oH5nEI0Xv1cdb+QWP8=;
 b=W8IKVoosTx5nlu9eCIxcU6pELSaTZDj98RX8LGV9s3YKC0c7NgegCTQSWxRG6WPcTce3
 hg+JDxi2vW639TuKV74ufHuR0jpktZrESkb/0stLWElGm9kCyjejadcQ/iAhPvdp3p9x
 L+J6sZhRUdtarGYIQj4XxPCm7Y8EBxf69u1R5rKp6Cp003Gxzv/mHl/40FJevVKUE2an
 K7bGCW0sYKrZITVYdv7ZHsKUHtMEBV85kU42qxkavSW0FtZgTzmtlmSwVYVsN/RSn9KY
 xsdEbvUKqj0Kt35RJSeXC4w/cN4M2WtoCQBhrdi/yCdNc04ukt5EOjwzgX0OM5sJjslG Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBl7X109791;
        Wed, 1 Dec 2021 14:30:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3cnhveqcc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdt7K15RfyL02J+/2/VOqfbFplvTOCzU+ULA8FWNjVfvoKc1TdGVUbssT6x61OFU1A6N/hdprQnQ7K7jYV/fpa0O7Y0BWlkGuzt3qZd+pqich/NzFFrrIvI/6W0gT7KLEUsGjL17cqhA7gFqvKgIdqnUtZh6qMSl8J/UtClOsBDepKP2OBg0JQuoO6JnB1Bh8W8RWe17lHP9hD89fZ4nqa2v03KFxSz9K3QsMdZJZFoUSsJzmsuiUfTVl2/23sFHK5OXfTWOcwMBXtwAP//LO1YFoJal13lHebe6GSpOHwouubGLDN4rxfc/0c95eSKRlf9/3OJ1If8lIp9Xp5kpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hi9BLqk2llq4rH4Dfl2dHM9t+oH5nEI0Xv1cdb+QWP8=;
 b=SJoXcTbJUajzHPBDhHgGfNLQmtkdeYdBXL/aNZsOvK/EJJfsjDUmbz/QhjGcG7Zr8qi5APy8DbE9JHJ98y7g7GuO1sxhtG3JtZJxCm3OZ0GwF1fNVj/rBVkKoCMpmIf5CEKwFYTmw3mYV5nEtTd9/2FXflLi4dIWPo5vPtXqTNNu5RNAENPfvT5LCnrfzfmNkYARXiyjo4jE+a2LDewhjOaNmh41MW1EukEApkgcbOleDpw95vpQKDzNTeJz/UzGB6IMB/t9njLo9ZhR8cJTA8WZsH37Q4DfMkVcTpl7zQZBIYZbcDPOvoG6CPb06a6MOGpICiIoN0pKu/aWlrRGHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi9BLqk2llq4rH4Dfl2dHM9t+oH5nEI0Xv1cdb+QWP8=;
 b=VPnJ0acCH6ghYgeM+tTEW9JjPUd4yRhk9q5IeAZ9PC+rujWXtPwpNLVuIGwk+IYvJNrHw+ljx7wspMyx1wGWxkiMlnab7L4CsqjV2PRGny/7OKf5etmUeWXUzTlKsMVTSf3oj9EsZW2wzKsICscUgDO6uRdtO0KuhZhfg9B519Q=
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
Subject: [PATCH v4 36/66] um: Remove vma linked list walk
Thread-Topic: [PATCH v4 36/66] um: Remove vma linked list walk
Thread-Index: AQHX5r/wXumaXL5xo0uEf4D3pnIFRA==
Date:   Wed, 1 Dec 2021 14:30:07 +0000
Message-ID: <20211201142918.921493-37-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65745a14-e7ac-4c32-1a51-08d9b4d72475
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508D198419438BB0E067FD5FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nM6vkSV7Ezcx0m5iy9wL1B/k8S4JRa1GeqUcD10LH5OqfD+3epwD1VjSXmzZs1cSoAtCcRVG2Dva8nkGDNWvWb4Oy6j8MUlsFvK/J/ft2o9N/NzVyTfVFXsVeOCM9g6lv3fxvk8ValPOnuwKPaSEm+FbkCsBkXEgfXyOBO8IKA/jR5TonkYqFrtFK5J+VzFxspMfNqxu9VxHSkO56Ir43o4/6hnXFP2KmEkPl9Gm6KW+6bHTYby0Tel5bygLGJlwCGvwOyzNDPmIxrFjxQvBGHr6E0TfF0q50UmcXo+7spbI/OjltECsyrh64fpXfzRkV7jDWUzZkAcBonN1Q9Ah4v4KniDbf/3YAkTmTG4r+japB6dzii8t2+qfixhcbWzS0tk7hVdCfUt9+1xHomyFv22oDgbZuDY3kJpH271Ci5SzT63YOFQkQeN6xsMsY1lY+eJiix0PeVkYnHYOEkkif+jvHmMaa3XD09sovZ6zmZUSNfQG+NwbEvIlTiy4e9Iktcvz0iBTchJhSwKidJW94NfQ/ngsCgze7eYkXeqaO3eI+rhGxgfgcjVBpkyaoZBXxCn94EmmvPqIDfVx/mwlqDcxo/13hTSRpsUeyCtw+oIX3wgAFxoLZoc6Fbgya9YWu4leUq9P44Z2jzZhBuuWyVGHgQfGCXPPmqRPaUceREjxVPBJ3lBML4HsCahwE9J3EgDkEhuPmI3GFfqs3Uq42w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+r4HULa35P9hh63vVbJnTea7ZrG7xyd3ljtztTJxxiNTn42x7SopMK6TJ6?=
 =?iso-8859-1?Q?OoKAqj3sU0SGV6S4JD1lJJEXthn8vUZNaAV+AEBfhhF2F8o/4zZ6ngM1+x?=
 =?iso-8859-1?Q?wIWxdEC6gdLfPTB8RNolreliLuI+wpTpca405JzI/ZuJdp5U3EiFQbyoS3?=
 =?iso-8859-1?Q?Hb20bdBc/pEx8SsiqPA2scV0pn0d3GlItRVas42bz/tO2FIPVWBIaOQRXy?=
 =?iso-8859-1?Q?nwCbT3LcO8MTF2DFtYZ6o0993ZgAwsUTC0kUT17qhE0Jx5PLK+wPFXxzRt?=
 =?iso-8859-1?Q?yS3/zojkQj0Z7VGuf96sbkVFs//+rXY9UjX6GWU38lKyejt5CezXBnxhrn?=
 =?iso-8859-1?Q?pA7ZBFl3mXz7saTs6qMj2Wc6/Aa4W8jVsQtaEHHck3sqPgAkN3RdVLP+9M?=
 =?iso-8859-1?Q?kcEUMaPD/6ddn1RKdhN35E6GB1xwoLJdzU7uoENLkTK9/vBth5WjMPAMfg?=
 =?iso-8859-1?Q?3rgM8yEc/K3CAKYRtKZviighvjVRbB5OTk7BpkrLQf2bE7QsdO+VMODaYm?=
 =?iso-8859-1?Q?oBrfM/mWUWh3SKZqTjOv7SSbUD1ZoWXmifjqeWBu+eonqmWbkZOY71FQBE?=
 =?iso-8859-1?Q?AZDQPAewn6VvyWUElarc+jKuihaWbWH7QI8UgfCvOhJ1evIBZy83nAXLBj?=
 =?iso-8859-1?Q?zJHqrN4ytX21nxjtNveBvJydw+QFaPP+SS4fgcVmHc3UUDHeftI9D5FsuU?=
 =?iso-8859-1?Q?qGoe/c6Klu1Au/XIJFg+AzMx3Kqc1yF1rGFHiGKHGPpN6I7/h6SuJury8a?=
 =?iso-8859-1?Q?wB9AKs4UFcALbTgCTQmpCZn0osDBmA6fWUb9FTfYRg6GwAjO5ElgYmsZlG?=
 =?iso-8859-1?Q?SrIpsW9e4b5uRriAg2ABrIizRlFGVZQgNDkUZOX3E3XOru3pQ/PFw/vkvx?=
 =?iso-8859-1?Q?iJRxyr9rfAOT7DwRYGG35et/zf8cRldly6dt8MDN7aEBf0h+d9yEmDtK+S?=
 =?iso-8859-1?Q?gO3HqV4a0K9WEo7WgSIFZGKvjqAOtBXluc/vgIdcm4D0qSEAXRAP40qgvJ?=
 =?iso-8859-1?Q?pkCAcEhqv3F8dNt1mlGIFIyJIIV2bDp2bA2YrKmAGnSN2ty0fRAWYpbPZR?=
 =?iso-8859-1?Q?J6nY0iQrhZ0+RaL/C1t9Vc/jvcPj1+yPnBrgQAwDPTL20ZWncvFEYf8wPQ?=
 =?iso-8859-1?Q?N26M/GPf+oYsJmU5km8yTxhWB1JnZL72/QKOf+oEEByWdwMJ8LmQgkOB9M?=
 =?iso-8859-1?Q?L9vVy1VX5FE9d5b2BQgWsl14zIJ0jMgba48BeNe0bq15sbo70OKOvbV7Zx?=
 =?iso-8859-1?Q?jBciC04ujIao9/WNOPr8Tpg6klp0FTccK3r1BBecR1qQTn/EGAE6H3o28M?=
 =?iso-8859-1?Q?PAtpBqMXM+ERFFQhuJ8mHV5ypxjanlmxhTUjcrwS4scPI+xv6bbroH5h6d?=
 =?iso-8859-1?Q?Elhi6X54m6YV9ndaJPFCl6go9CqijQ68mbIriUlzH9FOhN/1mKKGA7wNHI?=
 =?iso-8859-1?Q?GmUNYqvjkwC6vkOKCXy/iC5T3+Z2MQISaZRtqilw3nssqrb1LBN2iWyByt?=
 =?iso-8859-1?Q?j0fi/YmJC76fiuC/9DypOhHe4AVESiVXZR/NcTtdlDQofA2oQ8ZqJNPmpc?=
 =?iso-8859-1?Q?5mcxZJZWqZd10wvgteXDw+YLocbrB4N60lPFehpbLV/f3cwe92944RfSJV?=
 =?iso-8859-1?Q?/kCZhLMEiNN4YbLB4fa+MrRWiTqhoWG4WgtiImY8zgoTl0StMKv9IKqc99?=
 =?iso-8859-1?Q?MPfMacjCGoIh5QL+5R4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65745a14-e7ac-4c32-1a51-08d9b4d72475
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:07.4928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKxwQQ9KKbYcIpd3K63jbns/MASJ/fzwIdf6tyHCmL5UdyOeu6dxu9mSoCuHzwZ+XJGSGdFyDaDHT4GnI3tGSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: h6M_qO8SCt4fzkFvIkRlQK3yDTwRyqCx
X-Proofpoint-GUID: h6M_qO8SCt4fzkFvIkRlQK3yDTwRyqCx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/um/kernel/tlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..25f043037d76 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -584,21 +584,19 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
-		vma =3D vma->vm_next;
-	}
 }
=20
 void force_flush_all(void)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	while (vma !=3D NULL) {
+	mas_for_each(&mas, vma, ULONG_MAX)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-		vma =3D vma->vm_next;
-	}
 }
--=20
2.30.2
