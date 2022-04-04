Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DBE4F1755
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378186AbiDDOmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378128AbiDDOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:41:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2D403CB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dk3O8014690;
        Mon, 4 Apr 2022 14:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GN4nSuCffCIRfDym4RFy4RsbprQZBXDZS4ZkAcH8gmY=;
 b=dKGazqIzv3dhalkKuyKNWQ7+YT7PkUYh34JQNnVDa4zFkHrXu5a17nLZqSt+P4TfLlwP
 2mWtq1zE3q9xI2eB9AZD1t+E22sVrSHxwjluYd7LxjCFrY2cglks0SqekmY26Q6HeBpF
 lt+jgRAMQ5dQPFGJM1NcPfiTZC0JvzmnNSRiGiuJ455E1GVgmhWhVipbuEvC50Q60fZi
 OJOIXNVl0YCZDrD4g2J+LEex9V7+qOqaGCqR7RnnwfWawicdbwvF9N6qTNiE3d8o/gaq
 bb4UrpibHu4JEc+KXJRm3E198kzz51Di5dfuogTVYav/SV+5PGUDHZDarvmLTj+H5fdR zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EaJH6008393;
        Mon, 4 Apr 2022 14:36:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2c9f1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER5RJ23jw9skvpIvurTRh/OTNi0m4ZOb7QvbtVBB9Z/dlLR6HNvak2frrcq7cZvMyIL93yJs+cVl20JAypDB9RT7cjx863Ua72MKb7PJfsUirKp4Whhu8EmfVqZ63cNUS59MtRqh5mzpxbJWmcffNp35zu5WetpfS6ee5w9rHZY7FoirBe+8whjLIldhe+7uTqkiAKDTJVFzqPBpKEPYY0zOsOgmF0xx2NqHpKcdk+pPy8J9vAVg/vw73OS43XIbM+/3XrfKI9qSYnrphv1h7lbAqeWMCBrNFiAroLFDuM+JmJnMz9oOUylh6ynypek+C8AFL2idE0sHHrPfbBWG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN4nSuCffCIRfDym4RFy4RsbprQZBXDZS4ZkAcH8gmY=;
 b=Vwlks6fdB2AvmsJHhOf7t/k2diI/GSu527PfK+Dhr1ge2GONVNJnvmn1GqqdBCWwR9dRxomSV525TNKyxZuio9iDluI6sbJwJIceFJxaH3r2oX8BHY//qNSnIGT7EvWBuY9RxA6X5s+ENGPJL5vhqHn4odwQgJur2NieBiviCPd2C7QfporJTrLoDl3GmwrLIsT93wNt2HFOCQPJq+NRK/VyeUA1bSJW1+FjTiKKwGKKcNZPInlIC5UUxA5fdQwwUwAinCyWGRYxmR4QQwT7wULBDBxHaaJ1ERQiXgkhqnfbOV/TDjbr3bHpDM69sdwFcU33o0TqxJgziOqoLfzDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN4nSuCffCIRfDym4RFy4RsbprQZBXDZS4ZkAcH8gmY=;
 b=q5wZVtx+LV9GVoekm8/1JEzW1oE10Wvt+I+mihc60bBm9APsDfw8/6IJCGlnUWACz7wfPIXG7jhX2m1DXmeF2q+HyTtToR/l81esSw/LVfOGS6zSMH2mFcl6AqkUSnH5f05aSYN+qw72UbC8tV9acbSIoK3a5o0CspM0toewgsQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 59/70] mm/mprotect: Use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v7 59/70] mm/mprotect: Use maple tree navigation instead
 of vma linked list
Thread-Index: AQHYSDFKcivSdfmlb0mJsGOV34m4KA==
Date:   Mon, 4 Apr 2022 14:35:55 +0000
Message-ID: <20220404143501.2016403-60-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a99eff99-bbd7-4f11-d7fd-08da16488438
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB574254BC07AE43603F8B82DDFDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WmlJTZXslbwg2gbNN7+M+KgHTs8NTq4bcasVx9ydOGki4AP887oLlhZqFFwg3AezlE3fOVL2FTnAbNmkL43fK/7ffut0nWGnV4WNXsMPMoembCbEvp93yo6+foCf4yvX1OR4dqlih8FdRUoWO7FJnveZqErk0LrZPFy57na9ZzqptVj3jUyMG9t02OgDBFTvZ5k5l2T8LM62vMwBJlTpJ/QK3lhPqXL3vmKqmf0y2/Dy4dHJLNv8uScA86RUyBsiJJVKzHPw0vaV4cEiLgLowjy10D2EiDued7KdWQv6to+VgCirYaM8UiqhWL7NpCPZS4cwTvZ6HQ9Lmx26hzI65i80D9A7OwHvUDE4EwpRwFUKZUB0iMOx1J2VE9KmqWdXleIpjwvdN0AS6S5KeyZ/WQuJ4E6SSId1rQ3pbtCrPDptgErdB+D5jhx/HjMxE8mZ2jdBnFkmGxVilPxu24HufR1IMqZiIK3ciYHthIx02eK6sfs0qKuBjQgH6amHJtd4PQS7yPPE/iIviYqOmp9PfVFWbwl2Yi5vXpx7WVeRpFyP5Dz8sxwGbfgEoUrlkfxi1FAnBfmNg2ufrslexuwOViBjoY6fNiqRJunF7HF1BqFQ6wF2m0gHn3bVCUGh6KfaQa+a2FyBiOQFS1u/dKTXAIOB4KuUfVeCxz5NsV14RbiYsP8BpM9RGvCNI4f6xGal5ZkxiislJuNI/4RPyhGRXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8AnnCa0VieIN0wbQXbNt5kcv0TyNIFM5hCTw8ue1FaQUBmakISM/FHUc2I?=
 =?iso-8859-1?Q?r0Y05zGaZ69cFroTFdm6e5Wd07XCPRJQc8dl15Fgce2skXBWzfi2bz16Ey?=
 =?iso-8859-1?Q?ryfQg1bQs/OTCmFKfGhRXuNpQDjQbB03bmdUFGPsGQ23UFEeQog+xjjsPq?=
 =?iso-8859-1?Q?zIRz08DgH3GQY7ScdsbGevXH6KU5nCtoXb/hl6T3IFYmG+57pvNA/tiJvF?=
 =?iso-8859-1?Q?AScaye4B4/XbCGZYrD8fEwN7STPYCKA0qA3v/kGz8O1CCCynZSdB+cvVQX?=
 =?iso-8859-1?Q?19W1xC8HfVGOTpM4GWuY2iTuAOiqKPj2hypnosZ/xZl+m1WB2dIw3L+RL5?=
 =?iso-8859-1?Q?SrgP9uKYnPRifvFy1gxGmtXfTNN1BZG2wq7lioef37e0lrlBKlGZa78dsv?=
 =?iso-8859-1?Q?3qslWjLSa2lu6IGOVrDobr4jyeAh+HTyntS3dUjsIvpjO5HTY/2L/XNvf8?=
 =?iso-8859-1?Q?89J/TaHEaJAF4yaLsJWVdMaOCnV60gTDWGecmgc8Tpx0rWKPDFYHZCYWyC?=
 =?iso-8859-1?Q?ci4HGUUlBVF2vrJXSaoa+gcWEzF7XlaIDlNbRoEj9H/WHveG6p7nZkshqt?=
 =?iso-8859-1?Q?4nbO73QDgttFJGHdAK+TChRNGV2gQT+jw9ov0Luuz70g7YZ6Z/o99GWSnU?=
 =?iso-8859-1?Q?cXisthHztwwE+sDmKlxBKOj2krWPFJ1mpajVsKoDUZ6uoVi4MSqBysDi4Z?=
 =?iso-8859-1?Q?qaIbnbEoj1BqqPdROi/Hmwi69ys9+CqHBvfmVku+TZoYme+/nBJsFDTDVQ?=
 =?iso-8859-1?Q?SAl1SSqoqoFsUF9ARwkzCD/OF0Y2GKkms+Hi3+OmI+9OfEQeyY5NCG5QLi?=
 =?iso-8859-1?Q?mAA8ScgTjdf81Lmp+FYCS6DluqcPgEhcDFkTkK0QZxQwmFs3O57K7sBcZv?=
 =?iso-8859-1?Q?/u16iItzVhsDYMVSuYNGfZJ0gl0JPszDybPnx0VVRohVNN21MSBbPGbXb5?=
 =?iso-8859-1?Q?HmwaCZIKackIS1mXVGk5ePIETPg3nVK2O+oo4cF8gXs/BMN1g7uwHUm/a9?=
 =?iso-8859-1?Q?J1KknPb8UWxJy8k8JS91m4uJNHRdc4PpjJx0hpOr0jFe4EjwB2OF7KBjkY?=
 =?iso-8859-1?Q?3BO8pEmgbCpcTnW8HQH5ffMJ6C928E1HMuNbtrgY5b2fayE0Iro3lhM95W?=
 =?iso-8859-1?Q?X/QtxCRKPI496VBIzUQuIZNO+4+17oShERzx6HO2vgN0rN2EvPO3nZuJiU?=
 =?iso-8859-1?Q?eYOj6xGMpLMmf7n6mPwdi+MwVGTvp708nhpN//yB8rbYPpBuFyqNRnHPu4?=
 =?iso-8859-1?Q?cO+fviUM8n4YwZRL+4tMzp/MS5UJytl9wL/DzMt2msXpfK4hCtnkJhzyMx?=
 =?iso-8859-1?Q?1AjljYNbdxxxtES6xkGS/cDJJ+t8+YElw1oJHXONxrL8+nHGQSz8GeG/0I?=
 =?iso-8859-1?Q?LgSqBuQvtgqd7nFotnD5NniIHgVLGEy4NzcsDKJLRo5PbXFL5tgdlUGnBs?=
 =?iso-8859-1?Q?8xifF0f/l0E4OornidUv1GYb4cROh1M6jfyZOp7Nh2MDZb4Tj+rLOWzd7J?=
 =?iso-8859-1?Q?Qlr3/ium9gpPcDTqYPThPCJHeKeENoctDGgKSrxMgriIsbn1vXol5qorez?=
 =?iso-8859-1?Q?2FmXG5gImE3Lef7aYuyvQ73tDxN1MxmRxjuIRWUSrurk5xsypbE14Oei+R?=
 =?iso-8859-1?Q?k0mB5FMcqG4eULgqME7DphupE88c6+Hv2pVrofnjuW0X3oScjSc7pfks+V?=
 =?iso-8859-1?Q?DOof+Q8Nq3pZgcw8YLJXLWdiwLeMWjJytweHoXo/PBQWahU5FeRZxp8x0l?=
 =?iso-8859-1?Q?lw9xzXqhWrSvFrOG3JbGzSDUzw6Rw/biDLAqtv+1yeikKUORwFUijYPXZY?=
 =?iso-8859-1?Q?4xBDwJ4Ptd4hPrOw8hHcwkYGDhriAnY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99eff99-bbd7-4f11-d7fd-08da16488438
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:55.6271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSyad1O7cbTZ/WFSkKm3hQ29XQPDv9Wby3IeM3xE8vx3zSIwoLjJoJoL5bcfOvPj7MI/1p6PXxhJgD3QFouejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-GUID: 4LSMetoEZDGlftbcEySm9z7rmPUm4gMH
X-Proofpoint-ORIG-GUID: 4LSMetoEZDGlftbcEySm9z7rmPUm4gMH
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index b69ce7a7b2b7..81e5392ab13e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -539,6 +539,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const int grows =3D prot & (PROT_GROWSDOWN|PROT_GROWSUP);
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -570,7 +571,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -596,7 +597,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if (start > vma->vm_start)
 		prev =3D vma;
 	else
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		unsigned long mask_off_old_flags;
@@ -658,7 +659,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
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
2.34.1
