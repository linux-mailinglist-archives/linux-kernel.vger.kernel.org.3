Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF54B71C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbiBOOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbiBOOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85782105288
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:04 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhhOC030895;
        Tue, 15 Feb 2022 14:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+14j/V8X7Kh0Du6pTjr/WG129+iLTCW1GphVnUtIV6k=;
 b=eTaUw8z8B4zZpXgzPU8fe7elJ3h33bpPJKCfrm6ESzxfo1XKcr/NWxFC4RkrScE8zi0A
 6YKLV/cOe+eCsFwfyf8ZalS4bCugIOPYrfYqG/NvaaKQm4SeSQN+zn8Jguqu6CqDucwZ
 SY1Q1oyYE5HfEPI3/3nkJjCJxT8vLx9yfmtCkr2+gpFZywAdS1tjQ9WNujR4OF4e3j+f
 n/ENfZHBdieOnHwwkeDhmYX5gqZV9o9hjCa5eRBcxMTPnZc7KV4MiKXi0esCn9+UaLib
 WCPdCt26w/wv4/iEORufomgZWTFNkjARE+VazDSs+eVtLRjsB5uq47L+7zveZoBLrikB JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psatr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4K145723;
        Tue, 15 Feb 2022 14:43:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fjq5LZ28zE8PPmiFrQxN27ChOqxT3AedGjifEWP1NcJEEx3UGWmiIjse86gxtvd/GEkByP86QssN45caX5ne3tNedt0NQmy1RKt+FnTrYU3C9xH5bOq8wEVkwgUMvRwblahVxLtxd60adOeJrO4sr2TxkBC1WBNjoF8dBH3+AJNddS4WfnqrVC4ooctEMa6WzvauBkS9x/a3vyGcMdv296B66pvIaO652pMFkhqWIritN6jQJlE5wy74bkPPENT7pwHQ3j8Foin7L3NXy/s4+v6BWgYak3yp2nGT9R+urLoA9si60LM1A2B+R4ty3sU4b0XfDPDRoKjt6ug9QGyBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+14j/V8X7Kh0Du6pTjr/WG129+iLTCW1GphVnUtIV6k=;
 b=bIrRAWGgQt0ToNFBOsQ7eq1ZgIFsVTdE99Vm+ngmoAN9JR0zHzb2/uM4Mzy4bjkMZbk1CWDBtb5DKIBwylFT4noR1jnjjpy8v8L8TyQb3wrzE1GKOAbjefEEwTIberXLn2zBwFYr1kv8TSQ1RfWS98dg+joz7y4o105zCgYvzAxNNnxewCqLvNqb65fK166wQZ9JEAQ7OPEhlTVNFJhspYrZkfDNAIhXzLVCR6uYp9Lx0H7ORZfqC9eL4Tn/idvmZGrmspeeBAehm8pZnoezwf98GkKTX0fW+QgN2Ol0oosdqBUb6XzlBSn5EKZIOCMbTLMfCB/t1HQU4txay6UKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+14j/V8X7Kh0Du6pTjr/WG129+iLTCW1GphVnUtIV6k=;
 b=peDRc333h01jgnnDjkylYD4rzgDvJ3VAGX6PNikFLJ2Nl/KOxV2BXJlsJtQiRZ3HWQOYsxnLD6noKbwxfXaJtnWSYgg+GayssM/oxPUM/oiUjiV1rek4cgobdKa5bHGOfOwWKP8absiTtzHOkBRJyDkNZ4XyvJMpyZ+ruLYh+oo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 40/71] um: Remove vma linked list walk
Thread-Topic: [PATCH v6 40/71] um: Remove vma linked list walk
Thread-Index: AQHYInpebRkxgd/5dUS1LwcSPclsKw==
Date:   Tue, 15 Feb 2022 14:43:17 +0000
Message-ID: <20220215144241.3812052-40-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6122c1c5-5384-414d-afb7-08d9f09196df
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB55788C4D4E035A682FD82A73FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r/0iAx+0M3ws55dpk6WwD7OM45F9X2hS5x9mBfqjWVnp4E5F624Wik0WWyGp+2EMQd3kv4criMKuC98bODFril8HEL44f0Chp/HxnLvMGtbp9ZCgSicevpqwOaTJ/agsQBD1jh43ARjq8w/yBFfrriw264Tc1wUfgGsgS21soh/kv3GRWFN8oPCRT35umWo++3yr7aQzUc6/XUVRcqcYwyyJEehoXKq5H8xdRHPHE/7nPdL+yZhQqEdTkBUry05kV+E4C0TJZbuTrJQWCUa0nZjdGE34pHQzWLHVypWH3VTzK5ThLk9H/zQXBDGW1iQ4sPYW43zIa/sabIN/6dFhQ37MQJxDi51LZJAs+dlI4/LN9PLFIUqAl+7UWUCub1/Jqhj+iXIrnB/hlI//zmngnLBzSxQ3cEYY2ckafMHKx5nR0xgzszsznB8lwH095tAIex9QjVz9s5MKmgh6wKKosDCCNVfoI+vVU8bKpU+sxMQi9xqwui5SPhYZv+EB/z2KvK/iUpkRznGeUtXxbzIIiF/EbQQU3hURtBb3tlZIv1JehI5ScejwxRdRA3vlWnnZ8LOsXFPXnCGv5DGXFssNpJt9REQseFA01lrW6NxW0JPQsWCP4xAmSnWgC3izYhfjBtal/TGvJ4ot6PUWkVv5nU8QXBLpzi4PadGWSbzxZ1JfNfdNNZoRlkYHudppLeiV03qEECiWfrXLKuWRmLzFMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uI03ErfkdSiBbuGFVwMUEItbvvwIeicDcpn5OaF2TKpfu0o1KmDSAAd7eD?=
 =?iso-8859-1?Q?9cV0l5f6eF0fmbX60bI6ROJM1BfVvouFybhpXePOHXzX0rx94HLgrSAiZX?=
 =?iso-8859-1?Q?l3SF5JEfqJ0whnFepFsj9u5FJ7FKwLcizbDrrBJormyR5dJBQ6o9gUpgkn?=
 =?iso-8859-1?Q?6nPTWCr4Z/3NB14p9Lq0Q1FBcxd+JbW5R10CHvox2IBWK/uERfCWVBsFFH?=
 =?iso-8859-1?Q?sYiNGLJkxvBfTzaWgcQ3OsrRjH/QM7GQ+3s2xBiiAx8cAmNoNFc7pSRI9S?=
 =?iso-8859-1?Q?tIuTVEqB7s0mqrzvGuch6DU/+rarCOFpqPMUebMiK00tLdxNRNehoL5LfB?=
 =?iso-8859-1?Q?Pfm7lEjmS6SPyqCC1GYSsRg3ascJgOLkpf1Gs35GlSf7DFiSJioIxYqDbn?=
 =?iso-8859-1?Q?DGAGKKez/JJcgd2TpzwlqmLERr0aeCYybJCVsjQs2RYb+7jKJzlw1evxpr?=
 =?iso-8859-1?Q?9CoG/LaqSazOTKOf7P2sLA5sXDIaIg7HxNgctgGRebM7oGJ5TWSHnCZcsl?=
 =?iso-8859-1?Q?mnSyhsWNvJgUvrnELa9yiyG3g4YH0MQE/1fpY9bfHUlTRNgrbXjtXQlBrV?=
 =?iso-8859-1?Q?aTbbE0SpKtOW0GkQpWBOG05XOYCSjN9QWDqQ4dBqHNokZdknarCRrf+ooq?=
 =?iso-8859-1?Q?ZGN8/jqJTKQzRKijzWuQTJmOUAqLB/F3Gkg5qfySDA4JzzjqEPyhe9ZA+j?=
 =?iso-8859-1?Q?YxG95OFTXwQ0Yhjr2WjR5Ik8SrjQf1o5xVcfzA3ubMU33t9B+rdGM3gaja?=
 =?iso-8859-1?Q?glTQowJEuOTEt4dJjjV32BMlkdxWJTFXRIADn8P7y3HMEMjhwta3HVIgYJ?=
 =?iso-8859-1?Q?CHUrQ9xOUiKAdQFZCi+6Delq14LoLpJCest/Ao711z2ufYeK0IHXxQSYm8?=
 =?iso-8859-1?Q?qikGFvOeoXgq85/CzRzCy/UIPgmIkcYei5p15Sh5i6gy5cOQUH5LJh6ytv?=
 =?iso-8859-1?Q?89HLIx/KCGBGplL5YgQySkjTkLNzkWPBxm1QikszdQxc7gdJWQiXj91hbg?=
 =?iso-8859-1?Q?HbMdbf1EGOw6nq1T84cSwRjvJYfNHMZnYVxupyqycPYROrCs21UVI1Ues7?=
 =?iso-8859-1?Q?DB9UdjyU1RNeb0lLTmSilWGug4gSbSdWhwthQRtfpDDkffChq6ui7hZVHB?=
 =?iso-8859-1?Q?LqaD+iu9ES3MqxBGj0v4wuFUq14g27seq2rqrPJUW2molYwwNvgKSDcSEC?=
 =?iso-8859-1?Q?3Z/almgpHuNROwxN4KyytrrAj7BZgjHGyW8bFdFZB8xHoJB6tpynCriyPp?=
 =?iso-8859-1?Q?EY2lfUAPN8QJKMt+oQYPYKYh3IKePr7rN/EshEZ9AVKLL9yEa7abC5eTSX?=
 =?iso-8859-1?Q?y/xgfcIKElBw4vC8K4hS3Kuuf4dItXs+6nCByBeBD/BoOLjvxk3CAJSZ3L?=
 =?iso-8859-1?Q?8u2JGQ5wBt5sryR6f2XaU5f3rOe0DtkPysSRxjgsySw7k3xWzr1QOteouI?=
 =?iso-8859-1?Q?55lsAaxgyAqg1hvA/y4EbjN9K4dnTnFZqS8m+w2zaIIsNJ4kQ7wttHi+KK?=
 =?iso-8859-1?Q?mKQKSnzbgIZhN760eieFkwyWvbPLpZR7Zh/GQsv/zRVkP5jfxaGj5k6OBL?=
 =?iso-8859-1?Q?ayB2Cxw+5RomjyHhShSGelqnbmuvdNUj+GIbjoQeBpIkp3RX2yxMwenb8V?=
 =?iso-8859-1?Q?leto1EW3qpFx3fUQSqF5b3Y5sDSVy8CmxUBVELP6ppSRcUGqclXsW0EW9v?=
 =?iso-8859-1?Q?2YUuUs6hqk4I90wI5PE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6122c1c5-5384-414d-afb7-08d9f09196df
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:17.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FD4rXsHxpy5awLCaIzOy0PEvbln3Gmw8UNfvtdHl3VrWxGxs6MHjUc/Sa/fd6bpYR02aXRaOdO4sqNdZslhDCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: RFe_duBn0PIlWKZ5q-V2bGhNhCrsbEjZ
X-Proofpoint-ORIG-GUID: RFe_duBn0PIlWKZ5q-V2bGhNhCrsbEjZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index bc38f79ca3a3..ad449173a1a1 100644
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
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-		vma =3D vma->vm_next;
-	}
 }
--=20
2.34.1
