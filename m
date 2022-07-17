Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DA057735C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiGQCuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiGQCtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED5A1D325
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMOljE026163;
        Sun, 17 Jul 2022 02:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=76v21Z2JVV0DXNojyMGHN1ka5ATJuHZl9ratM4Ol8cM=;
 b=tbO2H8/cQq776ptlL9wGH+66BHhNIkAH/Hf3aLqpD3IeL7vLE1+YYpdOkXPM8WlFdaNm
 BxAFXEEGXiV/PwhpIilKpcXzUQdTmWxLT2vF7xv/gqBW4Cwv3I/+djEea/EIPvOK+eXd
 Raq76c2vEq1WgAypJba6efN//uFdjtsy0ZO/DdZF8ZcqFcX68vX/EXm4HZLTb+5y/tnG
 l2CdX1A2O/ybk6Q2f7i/+WCDDUbzLarrO4MiQC1Hqfgu/NnIMGsERfKH1Vdv51oCsyJG
 8RIobVm620fddNO9hEtffJoFwA9W3EPGlO9PIXnwo04rpon2Ki2apljxAVR2fu4kqmZ/ EA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISN036113;
        Sun, 17 Jul 2022 02:47:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF1C2VMSSxvfMtdKIiD4YC5Kzg3beexE5ZIyjTk410/wobV0T11Mg6UAN/KBsFrBI678myd39M+2jBDP1eHnj6UFxLuopfQXWVRcdOqcivfGdac6NUnMl7g7fTaCRRA5r4l0+y6AWA0e5PXJ5Wx+jHvJClP1cAihwuh4OjnKkVS5mCOmEEMzCrITPyL2z970qREOO2kIk6Bf/RxEcdeZdcuC6wJkb9SWY7FqlSCUQUOT9NyoCnoVMateX4YeoGQtKK/RybtETgpPy/mLtWJxVCC0D0ok85uboO2GXBmzJDSEp917haNd3EOqkiKEEq80x0hvCrCemuNer0+8EvWeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76v21Z2JVV0DXNojyMGHN1ka5ATJuHZl9ratM4Ol8cM=;
 b=FQscjYIU4Msg2g6aJqkfu0xn655euJOt4p7jh76GSKS//kFQZd9lLzs0JMITvwgB+Dy3uqYp37jcTr3cEYtM0dpR1h892nRna8mztakF/ZoWF1E1H1F8uy9oNJzp2ja48qHGVLd3Cp7cGc9I3A/yDQi2QdMWGBqNZDdI/tHEpAWdNXP+ZftIVF7FBGgWts3PSWT1eAs6VbgbRKTwybN74IGZ/RRKZX8WnUpR2KVflzVOEIkW7uw9LHs1qFfUkuFuhmhCYSjgboMdNirABR2kXSoAErigmtmckPKOcJy8WBsDxfQwF2N3uTj45QJ3pumjjJ4JcIGSTQzDYxOerV3EoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76v21Z2JVV0DXNojyMGHN1ka5ATJuHZl9ratM4Ol8cM=;
 b=O5Urq4/Oz1hrBMtN2NssJfWyTeHAl4vk/6R/Z1wxWFnQK8KNf/1A+/wFNEfbb3KmdEsFRwpo7wpQhwl6I6K0ssfRFi9QKgkQf6l+ANVxtFUdJa2vMPVSc/d2XV6op743K2WQpmf2bl37oHnIyoc9QzZgi4dRlOGsDr0aUXXxFyM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 40/69] coredump: remove vma linked list walk
Thread-Topic: [PATCH v11 40/69] coredump: remove vma linked list walk
Thread-Index: AQHYmYd3O/2twAABqEqLSjLyQcdaXQ==
Date:   Sun, 17 Jul 2022 02:46:50 +0000
Message-ID: <20220717024615.2106835-41-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37104adf-9eaf-40df-2b90-08da679eaf94
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZWXAe6aCO7xODQNc4FSR8XgQTbBSQmpTGv0I4rn89uKB9JVFLgtwGdNTO6cb9smG1cNuysgaOrGSFXmNfrefY3WIonuRhfmZfPcdywY/CvDm/dlSoPC03FuWd6Gha8hDrdcwKeuZrDpPjmVPgZAabQDrOSIB+Az6c4DfhUlLaC78ePCP7rdWLTILi7HfvxYTa9Ov4YeGrZR2RysmfZXCsCJLfwgM8XtrQUO2kQJ+zV7NyKl2H3xMgnDx9fhBynsp6ycyYkXK7diCdwYc3c5jcrB78nQggbQ7n5iLfEVm6d7O54kJtGZqjXxCSIrTTb3ndFmUWsbptSBT0Eltkon89W2X+u1bv9P2a15LaHhDGYclvMCrCs4p0Y7KFfuDmK57BHPDl1FAAvNXjUfn9tHiR2jCWhVwgCO9ijBFtgrsAUF6IScoLmcfYjBtHXNluzzn6gevMAoyLzrPCEDktiPdcGaxCsQdlpdCr3LicLElyKHs54S2CtzOSl5J58KWObWeOPlM7+RAQhhULruirm9uGZqAWjCzbiqDjlBgYj9Mj98bWDLu0yRIPhnWMkVs3j+QQUO/h8ixrZTTZeHpdWKh05N9iYM7uBaXuCAQymo80PYBNbODPWxoYL2CZOQ4ZpTuPqWCZPHRIfr5nMeVgA0UjOfaG5cx7PmEm4RBVxklVJI1IYWXih3fqZeU1OpdV6DSFnR1QcRGppk/Zq9PcZElDrpPoQaNBjQdkrX+IQZcrcy4SbXu8tWgX16bVHGAtrzOS8qiSP6VYI5eoudKq2cbbDihCHYDfOGmX/yei2+pIKF/Nj1f7BESwvYI3DQzha/o0cZMWDEPHqylCeOeE0yaBo4LehQuvsqyNJfaxCq9pSsyyDbgdWAb2IsJVhszWWNF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JT/jTvu+2OEIEwXibSz7mAnyIJ8AxPa/mjzI6WizvL4K5paf09CEMxPJKU?=
 =?iso-8859-1?Q?cKiKly9MXYFpAXL3KnjVWW/d4lI5BEQGkykS6YnsqjTOu5QaybG74FDjzm?=
 =?iso-8859-1?Q?BjFmVaRI50uIPbVVAfm+XmSMODwI86QL03w/m6GNopVjNMp1EJ67dyNlSl?=
 =?iso-8859-1?Q?HavkLDGR/gywFOGHu2XTiBOqii4SS3pbJwBnS7yazI8zPKx99LapHwr4rn?=
 =?iso-8859-1?Q?JajuASVKLNnomqqCTWGLBoxyILwpzNByzRzjctponP+d7aiDHLg32nzbyD?=
 =?iso-8859-1?Q?Z0C7u/ACMR30By4bRTiTvMX54kSusAypz4IdqCBtN5kuCZ3wQY2AdT/Q+K?=
 =?iso-8859-1?Q?3tAB0Y2jBTsTGOFw3DA107ksIN7/btGebVeLr6qPewgPOHLdmFLc6C1j/U?=
 =?iso-8859-1?Q?ZwVcEUbXn3szvJGHzVMFkG/4j13fDVf07gY+lNwQ19Fw29M5Neiy8p45yV?=
 =?iso-8859-1?Q?ys1P8Dxf1TqDY3UBHVRS0cVnnOsFALEQ2Byirt2Dzf2w0CrEnn8nIGyXDx?=
 =?iso-8859-1?Q?XEjay5NfhbLv/+6tEyw21mvaFXSlEhDwIHAJ33gA0QArNmJHxRjpYFrszZ?=
 =?iso-8859-1?Q?Yh6z45ytkL11GQKgPQpyrJgT3xjc2g8Z1we31FRHDEu0OTKWZG5sai/BcO?=
 =?iso-8859-1?Q?0SzLru6JTZNufyu84YI1kIXXt1eQA88+W+JH9T8njf47ySt3RFY6BqNKzP?=
 =?iso-8859-1?Q?EljalVVFHRF48PETGssRUjary0iZj+V6RrJ0sMTB+1FD7LdPObyFe27hO/?=
 =?iso-8859-1?Q?TK9Y5bExb4CTMstCJPvU9A1pqtmy8JqRjC/m8mtg8xHbQ0PIyG0GCmqTb+?=
 =?iso-8859-1?Q?F5gR6dR5Ha+gzz6CKU9yWpk/nU+vCWNr9doNNQPdeDoiujKyVPmJxKVLgQ?=
 =?iso-8859-1?Q?RAU1nPtzJOC+n/tASigqEKujcRKnlszX29HDHwdORz0qU/ZXKypPeK9V+N?=
 =?iso-8859-1?Q?XpeQGo2+1loalvDJv3QRcHybwUiUx5fwbGSKALOiKUb26JSZcSaG1LEzdI?=
 =?iso-8859-1?Q?HntHySDbvBOXE8q1SSFQUa/zTWqrB3dQN3z5Ta5V8JVEXQRNktAp9oeEg9?=
 =?iso-8859-1?Q?BMVIWavieL8NZlAyIw9YEmjXEAJ3uEamBIbZQ9peDCMAvtEEnLFgie19Bv?=
 =?iso-8859-1?Q?3smKMYu+SSOJH5/Qs5eVUUsLZUONijyUnWvZBxU9zORCSw4Nf+ZgtKEyiP?=
 =?iso-8859-1?Q?yJB1pqbIKC7TUBJ7JHxIx/td9iue2bwJMC919AsSTaxOAuWjFRaqsZqtwA?=
 =?iso-8859-1?Q?ZusHm2ibMvk9r4jNenSJnDpDllkZuky8QaclYa+cnn+Ucgj96FUt2u523h?=
 =?iso-8859-1?Q?84epTNhLV1MEkyzl0UT5tc3yYcV/RyPs1EH6QOhEmz4Jw10OxnLM/CRQYz?=
 =?iso-8859-1?Q?HipNRfM3d5xcieQwDdNTpURrTAtp1bO6gukkt1ZMUZk6Ft8tqWry+GUk0r?=
 =?iso-8859-1?Q?J5IPdX90kBhs74GZVVcE7CekYjMNbCvOQGfMnBijYTgFi0iwJUMmj5HRSA?=
 =?iso-8859-1?Q?lRt+WwckLiASrdro+9Orz4o6d1pDyHmRlZqO4zb63kruyYWooZrCbNo7xG?=
 =?iso-8859-1?Q?RFYeNaaNRz7Gv3vlZ3XYx2XNCkMX18YWBDU7AnyoUTvt/71y3KjOSidvEJ?=
 =?iso-8859-1?Q?hHS2wcsIGLLsSQq6pI/aUARvNEirXHtflR1jlWSVHDa85eqaOB9lHbZA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37104adf-9eaf-40df-2b90-08da679eaf94
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:50.7244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FqHjzVUYwCYGxOqj9ihpeNi11ItmUhccCe5y6u+B2MhUcQ1veMIFdSQJZYtDO9IO/7JX5AJfsbGQm9R3qptJoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: 6voVI47zASo-BsHFW11yUZJnvNK2TeUT
X-Proofpoint-GUID: 6voVI47zASo-BsHFW11yUZJnvNK2TeUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the Maple Tree iterator instead.  This is too complicated for the VMA
iterator to handle, so let's open-code it for now.  If this turns out to
be a common pattern, we can migrate it to common code.

Link: https://lkml.kernel.org/r/20220504011345.662299-25-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-41-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/coredump.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f960b64..3a0022c1ca36 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1072,30 +1072,20 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
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
+	if (gate_vma && (vma =3D=3D gate_vma))
 		return NULL;
+
+	vma =3D mas_next(mas, ULONG_MAX);
+	if (vma)
+		return vma;
 	return gate_vma;
 }
=20
@@ -1119,9 +1109,10 @@ static void free_vma_snapshot(struct coredump_params=
 *cprm)
  */
 static bool dump_vma_snapshot(struct coredump_params *cprm)
 {
-	struct vm_area_struct *vma, *gate_vma;
+	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	int i;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int i =3D 0;
=20
 	/*
 	 * Once the stack expansion code is fixed to not change VMA bounds
@@ -1141,8 +1132,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 		return false;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
=20
 		m->start =3D vma->vm_start;
@@ -1150,10 +1140,10 @@ static bool dump_vma_snapshot(struct coredump_param=
s *cprm)
 		m->flags =3D vma->vm_flags;
 		m->dump_size =3D vma_dump_size(vma, cprm->mm_flags);
 		m->pgoff =3D vma->vm_pgoff;
-
 		m->file =3D vma->vm_file;
 		if (m->file)
 			get_file(m->file);
+		i++;
 	}
=20
 	mmap_write_unlock(mm);
--=20
2.35.1
