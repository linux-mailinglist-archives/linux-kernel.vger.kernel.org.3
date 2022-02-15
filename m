Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF08B4B6F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbiBOOqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:46:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbiBOOpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FEA1160C1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:08 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhhOn030901;
        Tue, 15 Feb 2022 14:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=udl56DNLtyTHz/srt+tyNwBTfvWFDlIXimZgRN2PeM4=;
 b=OzpwHnM0QJuehlcxdHBW6otrzUd/MuI0wBOKclzyhZaePhkTAupU598Pl88QuUu2tY9C
 I9trTXKvNbbVGCOKnXbmEWbNoULwssiY8mQyH9Sc2A74ZjkB8AxPYIFmXnoGsQkkkIv7
 j2J0BlzX80YKUNhKKIRJMciAvbeZluUNs0taDFi6xNMZan1dqAMInOcdKHQcMZTpFs/J
 m722sPEc/P62T7hfSJFBoO+LB/igeiFCG7MRG1NdtH9Vbe+7ZpgqphagbeELsiso0JEm
 lKHQXNKaK+yrDcVMrgyhW2Jrxi/BF8X5bSZ15wmkbyYBEY5BfbhiSA08lthZItmMruqM 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psatt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4O145723;
        Tue, 15 Feb 2022 14:43:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezXuOKKDrKq+k4OOkXDNYz2FYmH6r69ypoAMOe6bVqpVbf/VaLB6uSg2hu9ficNdKcEMNYkCpLp6R8xWGLTNLTyC9CZROkTObfkeYFcY27tEmcc5OcmOoS7sjGSyRqzXJM5MuMXROkaXs5TvJr62CMOBFKQ8piBG4zyC4+u0G/L3HgDniuTy7ItJMAVqoSdAvsrlfHV+oFyvIUCQ3PZQ7JM5sb+bz7xt3EK1oEHA6YKfQukeVFC8DAOr9Mt4A+EV3wlHQnFO+6rCbvBwB+5AsdtWPcEZgAfjTChLGUxGaDeJaOKJT/iF0Ish4vwDkOhJN/APmcH0luxd6D1Mu31yBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udl56DNLtyTHz/srt+tyNwBTfvWFDlIXimZgRN2PeM4=;
 b=VAgC+KloEvmt1yVX1nBC0v+8wS7Z+ggoe1HYI8VDQ/8shLyszMwYH4BmqvlQh/ZiJERTXwI90mSLP2KtKWvfbJHYWLcd/RISR/yCyYmTdV9w/9KTdFWWvhm+W4raf9x0aQUT4ZDPJ630SClqnSIuZbMzBdEwTNnnm/Wx5wSS0lS25sQOmz07PktDixNJt1NmPIEfawvWQWGcCPotPO0joFZfOYU+lhhULj6EVLXfsGeh9vf23Bf6qgwwEmzu8c7RKSKxGQvfjWzLNGhS3/0G0jb4RXmpdHNuVGrCCRZi+zW+3Xo0PGQSp6NMAlCoB0LAQxIAoC1OSVhNfpYpoWDdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udl56DNLtyTHz/srt+tyNwBTfvWFDlIXimZgRN2PeM4=;
 b=i48lNffTcFpWtKOT1i3FeoWxV279i1NIcCZyJ/VQfK9C44NqI6IdVC4ZI4XD/kE40dJha2PBHUCTWiDpMIETYjOowTBeu3Jeo4Ww0o2r2VckgoBLXlptmYXODr2hxUSeyXAb1XggwZmT1w3+FMdPH7Nn9vJr3jS55WQmnjNs+/0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 47/71] ipc/shm: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v6 47/71] ipc/shm: Use VMA iterator instead of linked
 list
Thread-Index: AQHYInpgI3nV2nLv2kOO+/gC4sJFDA==
Date:   Tue, 15 Feb 2022 14:43:20 +0000
Message-ID: <20220215144241.3812052-47-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a678d23-9d93-40c2-a6a3-08d9f09198a4
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5578BDC42AE78FE852711772FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3lN1lLm63TOaDtsly15NrXh+L32U8Cf7DqUUYsE8kGA2BCbYK2ioSg6kgevmfpaB3Yp8HcK84qgUIasxTjV9BoPvupv3OmJ/JiWNy/mAS0aBqPxVqmWsIaHKG/s5ZHUem+fzqdrE8EfdXFWisxvOZOd8kcZyKvM6b4TO4s3oTRkrTmt8VVbhMQTtLGl/+oKxbEvsUoDED+mUpqxsKxatiMqouWVETwwKkZ9mSX1hjsCS2erw3APJA2THUita3GUPkqidwYno0u0rgz4UI8PhtszEpEl8uWsYEPi16GPpEcMfc6cWr5qDGmR5RQZU/1scek8fU+HC4NeN16WhdlZWRxyI8n1EdLY77CJVhJtGFrW2U2iwYAYS6sTfe9PVKw/6LGOPZyknR4MMiXacw+J+uJ8zUaCdFWXdjVnplVSQdNI68E0NpzWeQ3iyiq7W8aPWamtjC8BUT3todF+4kFuaolyEXWy512jhd1MlY7/cAMy08QbAXKkFCY1P5huI8YrCquvFSpFHcrDmuH1UtGyFJ9XzLZPktAnB+XgIQCm6fuFCWjdWem7O8LrXU+LDID5kSl6DYD0d60tUKuBsV3AFDIfcrghHPNMYPhkdULQBzosjphI1ooGqKDvxYnwoXCCLToQpdjxIocrG4ZGKrY/HOVUpEIR/PQabhr06jHE9V6JC4j9CVBUWYkubq5oi4fW8MxM3z7s2ChqP7/i27WhTjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?50ML6s1Z1qX1z7ttn6HLOC6wANL44+TWwIOEXPrj9zuH1/2UGTFJBGBOwB?=
 =?iso-8859-1?Q?RNi33Ou0f3rt/ibfhO5Oz7bhRCqed8LlBr1uGGVyQCeP8KvG2U8+KAS2e4?=
 =?iso-8859-1?Q?3dPm3azgONLWdoONZlC86r6P7SmREXgW3ZRUfR+3P4C1Uw0WS0z+PpBvhs?=
 =?iso-8859-1?Q?dIi7yk6zHV/LtIYdjxwL0DLT8ZDdcjgsHgXZHyF+rJyVVxzZsaYsnXOVsY?=
 =?iso-8859-1?Q?3e2tN3b5q+5lMzlT5OeSCIMo5wfSY3Zr0KRhIR6uizCDc9DNeENn7M0yhW?=
 =?iso-8859-1?Q?zJd98+w/uRbC6iKtcxJDirdB79IbbaX366ESGM+pVdsdVbMxdAosIj/KbC?=
 =?iso-8859-1?Q?pC24JNNvMqgcx8dxFQ3bcksZVO5QxXq90DDfvm68a4krc9tmxOYwumON5z?=
 =?iso-8859-1?Q?TrFU1kryd6shOt/128YpnAr0mF1cjDiK8hMhw/u7LrXM9qAb6vF09aB9C7?=
 =?iso-8859-1?Q?oh8oyTtQIggbSThzMXTZp5gXv99mVSweqBjURxGtUIF+1aL7ogiZ364maB?=
 =?iso-8859-1?Q?QP7KppHFnmWuwTS1qDrttcIMF5JKlQNOIf+VD+f62ks7WthcgXd+sWpRVi?=
 =?iso-8859-1?Q?WXtLJeF25uAiTDEvzr4BE1PL/fTFoj7COrHRStiAtIsuogD6KrpIzGjU9N?=
 =?iso-8859-1?Q?FUd4ELAu0duxDvEtIn4Z72HkwaCgXKFb/Nza0thUDbVYeDe3wCxdU2ydRS?=
 =?iso-8859-1?Q?N4ds2y6ntuye9KaADXwvok9OUMMEiYrz0FUI9rAEsCpaYIaB9/Khjwuy79?=
 =?iso-8859-1?Q?6I4ivr7WHMtR2MNJx2kn0AC0PXhxos/q4eRJhLUwgEYnHs5grufJ/gZ60l?=
 =?iso-8859-1?Q?dTugpWbMPPGQKJbB7FqrlrmD3G20iP0gaqu9OG04GFtRsBK+VwYZBLzkkJ?=
 =?iso-8859-1?Q?t6KJiht9l2ImSDS/b7uoZCmFQE/mkzxaQ1C2g47j0myu1JVTOfNX2oUIl/?=
 =?iso-8859-1?Q?ryZmFxtSvsT7CVu+Yui52B3S2Rg+qlGXBXjbuCvgvbbCPzGSHjfdtvZlnR?=
 =?iso-8859-1?Q?bVZJjp6WVaRbtU1BLWBbv8huNhBGZK2oPyf4/pqIwjR1Vc921Ntzl0/dY8?=
 =?iso-8859-1?Q?c86CD0zIRia73hb6JR4P5ewJsLZsM3Ylb8UoFr2Eu5Jqsh88yw5FjmcczV?=
 =?iso-8859-1?Q?NkRWxYoccsn/gZRQOzrA52U8zZ9I0WkRlMhlq7gbJcBxRkfWuhvTaHR4Fv?=
 =?iso-8859-1?Q?smnS35XYJh1dsEa7WWULPF3c+FhVTQBGD+WYGQ2zFf84Oy8fOAX8bbltSr?=
 =?iso-8859-1?Q?2QUe256TiT+/4lfwX0/2yHr5w4DXzYF45f24raTTtnaxE3vZprj1+CiEp9?=
 =?iso-8859-1?Q?KZWMI1ioROmFnkAs/yFThVspP5NZW6kGqpextYa/OtWKse4wI0HXjk+fpl?=
 =?iso-8859-1?Q?JmEJf6NTX3PV6o+d5rJ5j/J1akMJ5jKPQ92/zxR9TVdgpX3VwCW3WJKGuh?=
 =?iso-8859-1?Q?zlx5flTTr519llkqfHG09eHVZ1ZSNt3QMM4565NgXnbQwVk2Yst1YDae48?=
 =?iso-8859-1?Q?aPkLWKu3WTiWCbAefGLesvEqSEAtwaDhqcLMSx4k7qCpipy1/zz7Buo4Yj?=
 =?iso-8859-1?Q?1vj1GWymKr9FYkPe+SDk9R0f2qLy6w5aoTMKzHZzg1NwivCLLl8ysmHD+q?=
 =?iso-8859-1?Q?gJP1ignL3Q7wZ6FaQkJYB72dOsQI/ux0ALhppJkyJ0Y29fT4/0c1i3JR7m?=
 =?iso-8859-1?Q?SSr4OVxe4blCNw2V0Sg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a678d23-9d93-40c2-a6a3-08d9f09198a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:20.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzee8n8H662xCrV1Le+7gkNDM0t/0g5jvomOj00pHNIDyNXK+t7oDH/g6PHU2Vvl94rpCcYbENhCwx+K0RRgTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: VRtAhIttZ-dMrNljkNZyQWJTnK_To3Lt
X-Proofpoint-ORIG-GUID: VRtAhIttZ-dMrNljkNZyQWJTnK_To3Lt
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

The VMA iterator is faster than the linked llist, and it can be walked
even when VMAs are being removed from the address space, so there's no
need to keep track of 'next'.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 ipc/shm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index b3048ebd5c31..7d86f058fb86 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1721,7 +1721,7 @@ long ksys_shmdt(char __user *shmaddr)
 #ifdef CONFIG_MMU
 	loff_t size =3D 0;
 	struct file *file;
-	struct vm_area_struct *next;
+	VMA_ITERATOR(vmi, mm, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1751,12 +1751,9 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
-	while (vma) {
-		next =3D vma->vm_next;
-
+	for_each_vma(vmi, vma) {
 		/*
 		 * Check if the starting address would match, i.e. it's
 		 * a fragment created by mprotect() and/or munmap(), or it
@@ -1774,6 +1771,7 @@ long ksys_shmdt(char __user *shmaddr)
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+			mas_pause(&vmi.mas);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1781,10 +1779,9 @@ long ksys_shmdt(char __user *shmaddr)
 			 * searching for matching vma's.
 			 */
 			retval =3D 0;
-			vma =3D next;
+			vma =3D vma_next(&vmi);
 			break;
 		}
-		vma =3D next;
 	}
=20
 	/*
@@ -1794,17 +1791,19 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
-		    (vma->vm_file =3D=3D file))
+		    (vma->vm_file =3D=3D file)) {
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+			mas_pause(&vmi.mas);
+		}
+
+		vma =3D vma_next(&vmi);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D vma_lookup(mm, addr);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
--=20
2.34.1
