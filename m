Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7E746500D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350577AbhLAOmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:42:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15984 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350140AbhLAOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:37 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1E5uxN002539;
        Wed, 1 Dec 2021 14:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JVYiGj7zxYnpmEXEjBltjitzBrpqk8zBSKjniaVAZGk=;
 b=rsYZe3GkrkbyK9Z4GJ9uWTDs11pni5u0FuTCxJkrkYGHxe5tmum1dCYkiCF7UY0voxVn
 rveGneAbJO4M9ZaMFukikzJy1+H4C/1e/ncKBprHs5qxtpyBsQ6x+yIDTIuc3ZX2TJnz
 oA2/8g9U0fMRI+2cDG/HAgBkbioqvlSkDcc4F07yK/IYiYc52CFKr+Qcs4exRdpfUweQ
 ZiFlmY/3LD92ZNGhCi+zutntcVjYrwEtAxK+ThxOFcpZurj56JmBBcFSX0mrKroECaMp
 yrIYRHhfIZIPLBT2eI4nvxblxsrMv1KibeX18zDra8AKDTFpoWdC6HvHPhPV+9iflVvA sA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx221s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPS108922;
        Wed, 1 Dec 2021 14:30:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK7IQT6RDuaOS9C+HHE1ePLBB4aU6uvwIwnS+GqkLxnWVuvb0mVyzRXfau4+ceQht8YmfFF6dWiJEJt+hXT1PizBiS/PRtxwgpKLjEWgOswKSWzTtraaXSobzVkZOXdcDJQHytQJwlJYY67FyjD2gHCPOY0NNoHPjaSviIF6lXAltsWT6uSr8Lag3DjPp+SVV5RpA8hf8hep+ZtA68ygPcNFl6nL7NSxlmpxaoXYB8vYqBCpCyrXfeWreLlY3WeqtG8jlwYkosW6rNaph+soLGU0gUn7twGpGE4MbZTTF/aTU50PfGsdnDJi5fMxxwel57MjYyht2bXjmHl1gkspSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVYiGj7zxYnpmEXEjBltjitzBrpqk8zBSKjniaVAZGk=;
 b=lz2ZFkUH5NmO43xt41cLRWMFK7wgekbdI4L2NN50+rwh1J4InNkoX/P3++YWlAnd/SvEGk/jCatqs1Fc36SJmoDVlgvHWlxga0ZDZKC7oIIVy4fqJA1sBzYTsAH2ffgKM1Egfu1vK83U4FdSd692gAhXVpUXINd06bzRsi4ye/8cGPzwADR8sb5gvnB/26YLXPo91mtqhVa6cVq1Ubm+yxE0cdue/R9H1yxwKISpgUAXkbo3RbZE0C80x6rngzNI8QMVNNmsO/n+22Kv+MJetNwOmhyXBfC1Lxbhbm3hTjUGWjiQnivhAqEsZ7nVYfpz+Vq9d0GH1ZWb7ZDdUFRoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVYiGj7zxYnpmEXEjBltjitzBrpqk8zBSKjniaVAZGk=;
 b=xo4m9NiQfc9Wy0KLmns+R6JCseV4l7+uqIllJz4vUQiiuuXof7Nq6zKi+J5IGhQlRoQPo61G5i+SbBjAWvjRIehkE0BJDqt2gU9l5ujUhTJH6xykdeynyf5I6mxExZOIOLb6t7Awju4WK7bsZm68Nh1hB4c/FmuwLRBULtEpf7U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:36 +0000
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
Subject: [PATCH v4 35/66] optee: Remove vma linked list walk
Thread-Topic: [PATCH v4 35/66] optee: Remove vma linked list walk
Thread-Index: AQHX5r/wLdDkN8FmykuWW16eIAkEeg==
Date:   Wed, 1 Dec 2021 14:30:07 +0000
Message-ID: <20211201142918.921493-36-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21b31a45-1dd2-47e4-7c36-08d9b4d72452
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508FF3838EEE98E6E452985FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSk7zoG9svWuWeZLbab7y//xF2EZYSo3rVWcj2IzX6erhxmsdmy1MvrnDD5Zj6yDygV8lLiwe33xgw3cqGknxqQZaxf8Mo8FtXYkWQRYnyNWP6R/Kwhp9V1cATgeSIpWwAAvqLs2akU9fg0uk554jhdQwLLSCBoNknfQYffLFBFtemT5mX38VAdXTCRww/llg718OdpDm78VyIhh+DH1VqDePU6/c5sjxMz7GApPvSvoiAJJJ3yPcPUWggqXP1VCtJw/DHRvKOU7Qb2r/bCK8kI4LCMWKI/ZDRC5kBUYxODme0monY3j41/9bECjzCPpNEQQg2+88En7FCNAOl8eV3Ck5Ctvte3dVrcDShDO3K0PfaWQ12hyRzGtdFcSGTGpz8EYn06ZlyLkZNB7QSDPGtSp7URPlYLNlDPJEdaU1PC9WMAYylnT4e8uH+nWfSUkCWPIM9d5ZKN1jZ46kksMLY9fwxn8KttEZZ0eZCfQMm9EzmVz4v3Yuzg8qASNLs8LPTXrRu7H+l3Cv30srg2qIhmgl22MCVO7BWSyXiHSglL6h8qMkiF2nNKxo8QllQFkgUW/QvM+PouikzwhqYdE+t++NCmUnptGnWeoZgnI2J8RoLxAZRyfnivlOQi6mLKj3A19qk7iEORHpSLtHobdFnOB5B8M+3UGX6Go0UosN3bVeZPh8fKmVLUC4pllUvRx2olgTn22jHMvhbeVEKyocg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bMl2p8ShMsnQlqLfX4ovDNigeL9jzuhpaTyB9nGnSB8AnrC4U9cBhUsTqU?=
 =?iso-8859-1?Q?FZdWLdQtDI46466v95pr53jWseoBpuZ9GdH1Bk0wqzyWiK2jyGws2TnyM3?=
 =?iso-8859-1?Q?qcSqiLFB3vISQvkWmiLMzRtEDvaWkk5ZN3S3CI1/0mKmlVC/PXrvGaTsg4?=
 =?iso-8859-1?Q?dinV3OdZmJlSN6HdJpj8c1RAsm+M3JlCkJKi9ERzd6KEUjwYRr5kEBn3hW?=
 =?iso-8859-1?Q?vunZP/tqVO0I6+0jos2LAJFZzGxbiZhUgQWSZet1ZnkVqv3m3ofAxYLRLh?=
 =?iso-8859-1?Q?0nZXsKYLkP4n4IWbFSXkGxREijMzrKGqsPdcQn91YCyZrbivyplvlxs0Eq?=
 =?iso-8859-1?Q?uZb66VlYBWYaXTBEYsXTZx0zPLVQTScVw5kQWxyFhs09xupHEZCGtgJDHM?=
 =?iso-8859-1?Q?210TqIFfNXwaN9QgT1f6306EUgE9Nbznx6R+aJg41DcyoytE3qQm13AGM9?=
 =?iso-8859-1?Q?s30vGhmCi3h6fHPLX+IPij6EcLQ4F5TnpdSLTEbn/MsoelBChoex/VGksw?=
 =?iso-8859-1?Q?ATFrDCaFV2jwc88PEdmumqWQNloMW1xJfHftvwc1sGKdgxgROAbICchxSi?=
 =?iso-8859-1?Q?tCEzmGVygSb5zCi2/yecLiosLtgtiGNmglUTL8NoUW+i9kkq/qggWKOnWQ?=
 =?iso-8859-1?Q?HEuRQnwwJfFuQosvIn9n5y6VdLBEDEef+HsEiBE/EXK49XtM6AJR6WY0YG?=
 =?iso-8859-1?Q?1zvSz+z9FikKdi7E8QsXiTeKLOLayeAXHb/nHrgd0UwzJWkNLQOngLopnC?=
 =?iso-8859-1?Q?r1Cbg9WeEQExPbftrgPk7eX0Njibldu5s88CynuCGpFe1AQp5EoT/6W1eX?=
 =?iso-8859-1?Q?iRGArQ+VYO4yY6aVfoMtoU1EBAKWTAOqJEYiUma2Ip6qyilfV92Wk3nvQL?=
 =?iso-8859-1?Q?1DKIbta1dVSLQgVgZsyA0enYlcQ1aYeg916WgalvMRQJ3GV3wF6cAcgmSn?=
 =?iso-8859-1?Q?m6Qja4T7h03MBsbeo86dOgvQoi66yLCAgD43J3xSYaLFrveyz44QMQnI5J?=
 =?iso-8859-1?Q?wH442chTMQ0thw4kJz7THMRpUFMrmmhdHYsIhiaJoVt2to4R+c30jsKke2?=
 =?iso-8859-1?Q?M3fW+mnzMwijsxoUlotj0U0VCg5cank/KGqHgHZvRZPoKIVLrEk8jq508G?=
 =?iso-8859-1?Q?9d54eZ/dEgyeDocayfryvgBlkELQhQWRu/QM0PaKuUx5gDqE+QmZbWxLgS?=
 =?iso-8859-1?Q?2AapPwmREBwwoEQmp2GKGUT1G/90RkVPZswFlhB6vZcnURryCQCn2hBzC1?=
 =?iso-8859-1?Q?Nwrf1yByX8G6KdaogeD76RKdt1fjIFsenLq6lHx1kESbSsmo4Biy4AhC58?=
 =?iso-8859-1?Q?NfqP0+BDS2+x3pjyUSyvHjWN+uv8UwtgJWGwhSEZCb0dKOmUGnImKstHLx?=
 =?iso-8859-1?Q?KO1z8v7EeHBheSS0CASdLeamrPQ9zBWu9FlN8bAmC3YjbC5dpg+e+Nja9u?=
 =?iso-8859-1?Q?2ArmUT9RbV6FGYEhux3lWDWQ0rNA57esOl8d4zppHqtV7c3OE/JH8VsEiJ?=
 =?iso-8859-1?Q?gL1X+fhHOvbXqaZ0h4Eej5vRh+wj7miy3fO6ylg5bCaqEssp5hkOFLkoXJ?=
 =?iso-8859-1?Q?akJfJHKiPhbI9MmuJi+VRIdQZ2z9KIHXwwTx98bTE1F5vwnalYiHP4ydTV?=
 =?iso-8859-1?Q?/TsiTpDPEdSXyhegz7lEXAJCfnkKVLcTSMEqVMEJLDG/1LFdcQFrJyfa/D?=
 =?iso-8859-1?Q?K9iG0wMH1in3qxVlo2k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b31a45-1dd2-47e4-7c36-08d9b4d72452
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:07.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVxjc6a+kSJMoKFvbwxiMfzgLrFYEpPzpnifVPr3t7y/05cFPVrv+vygR/nM005PaJPP5jZ1PipUY5LLeEjPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: DNdtdGV3Y2F_9k7vH7g9vy7g1WUf1l-9
X-Proofpoint-GUID: DNdtdGV3Y2F_9k7vH7g9vy7g1WUf1l-9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.  Change the calling convention of
__check_mem_type() to pass in the mm instead of the first vma in the
range.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/tee/optee/call.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index b25cc1fac945..177575c445de 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -342,15 +342,18 @@ static bool is_normal_memory(pgprot_t p)
 #endif
 }
=20
-static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
+static int __check_mem_type(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+			return -EINVAL;
 	}
=20
-	return -EINVAL;
+	return 0;
 }
=20
 int optee_check_mem_type(unsigned long start, size_t num_pages)
@@ -366,8 +369,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
m_pages)
 		return 0;
=20
 	mmap_read_lock(mm);
-	rc =3D __check_mem_type(find_vma(mm, start),
-			      start + num_pages * PAGE_SIZE);
+	rc =3D __check_mem_type(mm, start, start + num_pages * PAGE_SIZE);
 	mmap_read_unlock(mm);
=20
 	return rc;
--=20
2.30.2
