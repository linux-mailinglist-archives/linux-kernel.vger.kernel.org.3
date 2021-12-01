Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987CA464FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhLAOii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:38:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56940 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349980AbhLAOfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:00 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EK9Dc012065;
        Wed, 1 Dec 2021 14:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mZPq0xCR6hIK8DBDvVsI3tR86eGoSrVebgXtmGlbApY=;
 b=OwPOnUl8KKmKMWqkcvIFs4tCMpbVNCUz5cBrFicrI6VBs2JktqfuS2EdG2Z9FGu6170V
 0S+BqS/EmivafPpQ+14Jct0zMbbtnTUr0aIdqRbzo6hauPKAam3gPlwKn8npzVwvO+eN
 fccwumRudENqXzEsxSP9sgAlvXoFlsCPC3OahtIU9QZXkBWnNpPGRu3LKx4Lf7EWIDPG
 +93MK7hAL3LxYG65KQllgzTfW9pFwxnpjnZV4StjVGkoDQJ8Ik1mSZu/5MoUEKWFWkEp
 5PqGP0mFKcZPB7J8/xS7GSpzenzPgQuOUm6D6hntqxdiB9dNE7ZBYt7u1f/LQhlgwj+0 bQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1h0q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBomE037582;
        Wed, 1 Dec 2021 14:29:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3ck9t1v56q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di4YFYXzWwxN5XZASzUAREhgfX/t5GzjV5NYRtrtMh9pckxnPkg7EHKyZ5r4uhlGeFrg1St11EarGwAtmBYGuePWGN9P9a7yuQAwo4JAGd+7xGA/au8mLjmOdwEfUvCpPiIUDBMvUfV7vx9xLJ0+/KOZzRgbllpKr5tm4wCm465S/QudhxyVOzAn18QYdoNGPg+7novc6Nw212eX595aqdGD42hgbIqpBvZIF3XjATD6f5+78s+Nadrqy+qpvhxmB9XM7L8M9jZpCLrltAO0fFdTmoQ+Y+cnWUug7bVtYQjrNKNuBjJm+L9cdE2Tjlzpxi1VUsPakB8MHpZYyyPDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZPq0xCR6hIK8DBDvVsI3tR86eGoSrVebgXtmGlbApY=;
 b=LoXYEtqtd9MBgmbWbSf2OTGJJufZySZq5aMbvuEjXQrZWh2r5BbdbsmCod+wNOvCmsSMjSEtJzS2C7wYX7y7fJd79tHZVRxhBAKUbBMB1fswRIMBOxzMkVTISmnRKGpQAIqnI53bcy2WlYagEAwbjYgNKtql23WzP/JROG91eXT4qTFeXbtGrqleM7y+7+h0BSe8vxP1Jj3svPK3jof/dRHhZaQh4CMu1kUryalTp1rIqGd7AbFxJrhE2m0NS/6bpU6d25fCELjxJlwoCSWuJ3j/oZnzK9Dp+wReesU79/LJJXlyr/DtKV/5Rz4n/EAVzC3hivxy48OgR2xI75NGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZPq0xCR6hIK8DBDvVsI3tR86eGoSrVebgXtmGlbApY=;
 b=ZNgG3hWraQi6uTKuG7u/wBp6h3ZvP6KitOwjG7wI46yDvUjK5zKYweNK6dPYCGEhDm6xrYfEDb0QgwGenjBhr+JF4KIskY2Dsky0iqRXrtx9VemQjtvkYE7pu28aGSJdTESscmSmrhn/73WwDKlfPg8f8+aypUppnJT6AUeyCxI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:52 +0000
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
Subject: [PATCH v4 09/66] mm/mmap: Use the maple tree in find_vma() instead of
 the rbtree.
Thread-Topic: [PATCH v4 09/66] mm/mmap: Use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHX5r/nx3yUoeR2AEiEqkmElp8OPg==
Date:   Wed, 1 Dec 2021 14:29:52 +0000
Message-ID: <20211201142918.921493-10-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd02a189-fd51-423c-0fa7-08d9b4d70a0b
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB2768FFBC2DDDAE9AE8006513FD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W52i3/Ly1lJ7FvfUAaBrZlG97AnTYqzcqU6TVY3O4XW+Z53edQnhaglTkaiZTLR5d/gk1TUcZzUzQ7Wpf4DL92KMX+qZWsmzjGMhtch3bwQ7iWG3+Olrjv+YuAt/JR33udshqs6jh5Euq0Q/+ZjVl+5HTj4qVcOhnyvsUD8Wff37AEUCig/FeK7u08rMMufCM2gwDTynYLKFj1ZMPegrtIaEWoEnIEwxomLUXkyWIkVz0awVqfDgjz6v8vjdwyCEZzVLaDIWGG2O9G5vCWYr9endpEme1O4L54MHSmhtYszmoBz4TxEDK9NLZ/1DlLjqHtCgMrnmQq2WidZsSNwz6VF1K1G0wV/DybJAN9XXnT7zAHPlkLN4rHcBRS4FXP+LcWL1+lxK3gEkjF/6Ac3REITwJ3/tfBICNq732cAjVIZMS7xhcYsXv5yZierQ+uATnZXQmP0wyxmbjT5OdXbfF0MUlvCLqaJeK93TCPRwv+JDoo5e7pBw3x0WE9CZQsp+RTHQ/Zh/jlNdX7oUGs9ReJRADvxJpbnlyEe1piAjmjP1JZG1UA/v9hhkLUBLS5cTlaX49qdzUaVGsEnwAfJLMrr7jasaYfFL3GaTK/70YybSh5axr64AbQKPkeSIjtn3sbeHM0CgXajoyIF4LCcwa2+bG8kG+Qv780As1hS2vz/Y7mtBZ1Bapdm0nIXKTezHdgHr9JS0Urt33mUAD2DJaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NphSaMP0rExd7kLOWzFaB2QZ18AjW9GmfNTPpXlniHxeDw9K2Mphsw4A7C?=
 =?iso-8859-1?Q?aViy7V+V3wyaSY68TdnwpBqKqDqa/1yu+/Qolwpq2dEzllcQj0lsNuA1qi?=
 =?iso-8859-1?Q?Xdc3ronAYTQqLh3Q2cjMovQpPxIrD4du3Apyz9RiRIlhhA7Fr+esKrCxky?=
 =?iso-8859-1?Q?DzB4V1Je+gMJN5iRlqz6rZRyAi+sXuWtV0eVGNumpHQv/O1COG0q0IrnrC?=
 =?iso-8859-1?Q?HZZ9NTQT+fYr902tArfp17/gkRlvb2yZV3Hp+dIWKT2Z9GbG4leUW2Bnsz?=
 =?iso-8859-1?Q?a21TmPOzMtN09nqI/WYk+gMnp2UTQSPjDUNNYM2xIguOO8K1BSX0Zd8xJX?=
 =?iso-8859-1?Q?UD0L7S40fKwnuIVXiT4mksrlh/yAOTqFWckSF9q+/bGUhfSYV0ffmKcOxt?=
 =?iso-8859-1?Q?UXSgNLp114I11k4xGYvoI118Wm+97qulsGZFTgFzyWlKl1+zu1kOlcmVIM?=
 =?iso-8859-1?Q?i9FMXHDqx8yZTuuK74A2i+VUwxuzIW+hm/NFB7X+vVCs5+LsMLALlW9QWn?=
 =?iso-8859-1?Q?AoFlzj/DfdnYE9q8L16XxnkXSp/TizWmFCCfAO4y20SFHhKWV1Wjr0klYI?=
 =?iso-8859-1?Q?v5GNL2RLBbvx12WVbyrbdXxvS9mqkK2WEZBx+DQWJdqZQ4svcFB7t5zJnE?=
 =?iso-8859-1?Q?4b5VYGRO2draTUzxB4RQ2Ef7O6bEup7kwWNf0vyfmvzQcIsYF5qqcoFjrG?=
 =?iso-8859-1?Q?iAxf3oP0PCCFJeSFCEwjkkXJAQ/alGvQBbxBjJ4HRlLgLtL+DviV+342zs?=
 =?iso-8859-1?Q?Jn1Kb4qfPXwMaeLCH1paqf/Ue2R8mKDd3t9mF00rR0ShgD3FFbJe91rQea?=
 =?iso-8859-1?Q?ngebRfdA713hnyknxbUq2YdzDV6i7Xrv21lSqhAaKiQgoGlKf+Uze8dZ4g?=
 =?iso-8859-1?Q?SigNTbVkHIIcvLKmLKXSDH3zWH42HvS5OXeKlArw1lSndQz3KUoz8zJrQi?=
 =?iso-8859-1?Q?6vm6oOLFu/0T110PTZczAiVHWXwm+bDIrzJEILTc41OUmOeMbnopsJ/7F/?=
 =?iso-8859-1?Q?tSgnYVZGVZKIKIB9FRyx1hT2GIqEKWBnTj2b2TbBoqy3bsXRpZXvRDvLM/?=
 =?iso-8859-1?Q?+KMsImQzzBAKl/uNdhT+cgez3hARmt76pAvNQ3Eep1tMdibcQAELUnAxav?=
 =?iso-8859-1?Q?A0lI8SBvYvOYM32tSwNSM0j1rxGW32x8cWtwZTWppVnDyS/5TQK50tEUl6?=
 =?iso-8859-1?Q?d+Fmu38wKZU5OPZ1V3ngwcNkuPi8Q7czz3B61MC539JctDxpsGtja3svB9?=
 =?iso-8859-1?Q?f1rJ2ps/WgMmLRDS3MQR5xoIlATldtDMgCvG/vCHMMsyawMf92+d01JZq4?=
 =?iso-8859-1?Q?yw5x0nlff3vUJ+5aiuKGIaIoMZ5JzKYd2OzMi5vBo67D2GAbDm9AAvLUcp?=
 =?iso-8859-1?Q?+OMRP8IioaDVqQTDGGek3XIzTbPkc8bg++KJGIJOsrlO0bUJWtLcHmVBws?=
 =?iso-8859-1?Q?/LtfQu8qV6onGuYfU6YXt1TYzfOFoH4SqzjMY3L2yhEVTnC+3djnvqJjk/?=
 =?iso-8859-1?Q?3CsFVbs1x8mwvh467hLCIAeNtpY6qKRxjMHQIls/JEl2qSZT7yPly2c0MO?=
 =?iso-8859-1?Q?HBmP6CAjOln8Rp8cQqyjonMsJAkxCw4y0o9ZURJe/SKc5FKATAW6Y/dnH/?=
 =?iso-8859-1?Q?nVA/GfqjLyNIL15WuIdeGTdXrQOosqjsXCpRDsEW8J1t3JsBlr1banJj9R?=
 =?iso-8859-1?Q?UkAk6Ev8TF4kXAlI8PQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd02a189-fd51-423c-0fa7-08d9b4d70a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:52.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InE7IaXdyJf3irq7dfwTR3U/ozZa8m47n9PbZQuj0yXr0qeXZoxzfckhEZ1vnix/slh7PuYT8cDse8BY3gXjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=950 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: hzubFvD2oiwzJegdwQcpL5CyDtK7AoN1
X-Proofpoint-GUID: hzubFvD2oiwzJegdwQcpL5CyDtK7AoN1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index de78fc0ce809..6a7502f74190 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2429,10 +2429,16 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
=20
 	mmap_assert_locked(mm);
@@ -2441,22 +2447,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
, unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	rb_node =3D mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma =3D tmp;
-			if (tmp->vm_start <=3D addr)
-				break;
-			rb_node =3D rb_node->rb_left;
-		} else
-			rb_node =3D rb_node->rb_right;
-	}
-
+	vma =3D mt_find(&mm->mm_mt, &addr, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
 	return vma;
--=20
2.30.2
