Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E34B6F51
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiBOOp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:45:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbiBOOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:44:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16E310613D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:39 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEOoLP006800;
        Tue, 15 Feb 2022 14:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fpaQm34yUVm9NiSuon3NTmdABFzYxmG8nsz3o31qOno=;
 b=cu+gNpD0aB/EW/1ocrFKYh8JTkTwIHORURiUIaq3n6ls8T3SUaippt7slM5W/BDWO5dT
 yqCD4SXcrgsnSyIWvZOcP9J4PIc0BNLIQbus3mIFosZC60gbiXjKVSuVT2qheMU13UmB
 zl+x7d4y4ZIsL+hjPGgtxmCBh/5/by+vCXWowOLmvlcM6JnOUeZ/KKxDQL4b+KjiI97A
 bJBd+53osE8w3p+Soh9WE44cxQGuR9R8UCy6DAoSB7pO2kRs4VztHx4ewBDEvLKpAj0G
 BUuNUAJcijhECRSqERwfQ0hstH3Tz1q87lj1sCNKxSxmlPKbGgkqPHH5Rn6TZIljXdgq pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0hgbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeUFw145877;
        Tue, 15 Feb 2022 14:43:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 3e62xeqejm-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1v47AofQ9F+AR6gtKSpgWuDlQbZSNdrz+exQqmeJu2GpcEgHF/adS0XHOie/li04ktMmSKCYm3iERA/SUgSRbL3REqk/Ufdn9Lh/IMVs+KnVzxUvSNfscuuCMudv4cwZpEyTnjDPUrkY+j0vJba8nOV3RJBQx/RpPgKnjkv0pl0tOUJcwYvXJ8Aj6k/DBc3mFzRmlBL2JWNkvIcBguMyU+wtVf4tOBuVPOhOH82KgES1Aqdnu5HMyfk1UyargvdGoVUsHaTDOjlHbG/kuEEZh27peO2XmRz9rrOcj0tJWIn5Nl/8VltRBXTu3QM78FSL4Q2WWKPGpKZuNnLAnv+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpaQm34yUVm9NiSuon3NTmdABFzYxmG8nsz3o31qOno=;
 b=ZTQ7/Fmra5sojAK/QzKYzusD2zDWKMiUVlmoGKgIUR0HTegUTA5tgiZXiM9cf7uOzznMiItH2DzlNhZyzhy0in8+METeuPXtS/My02fyCWgFkNxFOlDU4GvWtQzD+xxqFsNlZyJfq8Rc9YELHe99Qb1RYcdQQeVAqWKndOL5GYF9L9EwD4XmcetpdnsUc2pKuyEbRfI7AS9QhFL2ORrDd7JkPqccnDkR6uuYRLJJ86GFcKdKFrpGloCuSYs/U+O3AxOf220Q8Mk9u3tDxXsguQCGDcZx8s8vhh+0iD6SqItbxZ2L77QizL/OHMhIjeG6FVVfDG3A28M2r1du4dgIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpaQm34yUVm9NiSuon3NTmdABFzYxmG8nsz3o31qOno=;
 b=jX5zb728Ef4kwOWEvgX/xAtysC/ueXXbfn1Vb2vmKReMhqBUVNcNwTR2RdrO48axm5etQB1k/QLklGKJbBk7vSpBeienuFfWsTXh5v1SWHoT1CIvhW/Smm/pPV4yGRoFQ0zFt/1xqbiCvnw1IbKvgmVwyoeblP8h01sYojs92+o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 28/71] mm: Convert vma_lookup() to use mtree_load()
Thread-Topic: [PATCH v6 28/71] mm: Convert vma_lookup() to use mtree_load()
Thread-Index: AQHYInpbCrz/8pkuQ06f7gqP5H0log==
Date:   Tue, 15 Feb 2022 14:43:12 +0000
Message-ID: <20220215144241.3812052-28-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d63e870-af09-425b-db39-08d9f0918205
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB468924FC7B49BA4E529CA8F9FD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F4UL75kN5hXk/YCxRqDhDmvKbRpV9szPeFsjBK0skf+xgDhjhvpbx0RYSE17QCEic5JTSnaNxVWDyK2bZOKgsFouiosTtA1r9pmARTyJjkRAyugYyk4zqMcOFpDHSdgSRzyjcRu8+QmL90im2NDESUJ8QpP5IgjrMaxuYCHnoC69vt/ZRU8PCF+YhpGqACumtCL3Q1Y9hNFex2xoEhKpU3hi6BIaHT0FKEEXl2611DDcsUvFw9u/5ZhggtfiD0z2ONCZgANqujaiklzszBy8s8BQxjamb6/P9xUa1k0puThpAePpV8ldSLj26HMBUj+nhawALixTHeJlP8y10jZUUIFrKgjsgLyjU4jTgGIA21B2lRO8N0AmMBunFPxdFJDixmSd4j2I5ljh7ptvnqmhR1cXplqnBZbtEWc8MKeiCiTfBsAwDmrBTeqw90wAVNuM8f+wR22417b/d/fGp8Qmsu7OeXH3VMT0JeiiA/f2gnrxNwqA774mgd96NHSSLBGkqV477qtYrIWw+zGQhCjbQ6RgzlCKfnL3JQICEUF1nf7QedkgYsPxAne3Cbpqg/nbhfH9f4PiS+Yr1ySXsnWF2Eo6pHoP6WTzyOC4AybFaFo/KsUmQDN72QsDIvu7UW80MOh4Ogm52DdymzLZLXKJOuy54Kt6bz6928FxZiKr27TiR7Z6u/qKpu3hjz3NXyvYH/XWEaFnDuj2uH4rHmxPlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(4744005)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UDrJ9m4uORB2biJlVQhvlrasIvwx+sejVmUoMBCwQTUdatUujnvCdjZRQv?=
 =?iso-8859-1?Q?ALw6Ss2KXiyTBcL2Ity5+BCK4w7bDF5KEQrSiyKiPGvjZ7wljDuAKJcgms?=
 =?iso-8859-1?Q?x5MZDXqk5N1zUrST8EWPsJJcrsYKKEffCSHFx8/KFIy7HFBEnUr+XU/CpA?=
 =?iso-8859-1?Q?hDvrvq/Cp8tzJ3fKXSLPsUwp536aNZ8ZfkIM/lUqbijCFs/Vdc4GhUQi5p?=
 =?iso-8859-1?Q?uMshpZ4hn/rSaFEXWzgzmhArc5pGdD5xiuXW1OUt2tS4hwikuAvjw3anRb?=
 =?iso-8859-1?Q?HErWtDHfRHdDgyDf67BD0Em9sexPaG/LiHqm1BWN04ehiiicLZCidwr0NR?=
 =?iso-8859-1?Q?tdMPd+1q4HisUYQbbJabPGczowtZ1Ev5wtkE8eqakXixMi0CDfFkApvHgU?=
 =?iso-8859-1?Q?qHmOVBaSYiA4rEHAZfk/Zi3P3YatuD4LbcffTUREEintHS7kSi6YSgRhH9?=
 =?iso-8859-1?Q?q9COpAo4ULvSSGkGss3+wfHcGRNShAhr0rmkgkxSZQ3bZ1mohXUmtzZQtb?=
 =?iso-8859-1?Q?Fk5lPYy9GoY2OkNrgAfDqj5VEqPIPKRDkj5wXLQN5pk2LmABRC+NgZHbB9?=
 =?iso-8859-1?Q?BGWOJy0XFb6TnG45BFE+pK/EWhRmMXxmQWi3cFU9hDa7ZP9F3toNhyhBXR?=
 =?iso-8859-1?Q?3PPWCYODC4PgqBSx33NBzbWGN3lIdp0s5KfnMcvBIYsTtAeeqSf3cwPfh3?=
 =?iso-8859-1?Q?ixLFJWwEdsVkO8NR43uqrBp34aCub13BRGNYFnZavS7nWrJWf/Ky5qVc+U?=
 =?iso-8859-1?Q?MYZXmvKhksmxUdf8EAMISsU4Su8YaRZmShguqjskke39gklMaTeij5Dlrw?=
 =?iso-8859-1?Q?M6VHmx9onSzK15GX+Es7UZt/lwI5Akyc6e80mv8xQlUMBCcFxU1XVSRm9o?=
 =?iso-8859-1?Q?qCR1szTGiaeQMIzNlnIfdaBZjvc6DvRIANXYZ5LE5LpISDihMLPs99hlew?=
 =?iso-8859-1?Q?54Bgmy9/mohUEp4QD82zj1LU9414pJ0Ky4RKo1yOlyn/Vzo889BnfBkoiU?=
 =?iso-8859-1?Q?fTdLnkPfnSUs3f4PrI62IXViwRqCbV5DomInzMWZo5kL2qp4+0hjWru8bZ?=
 =?iso-8859-1?Q?AovY/Pv+swsE9iupPpewggd5AF2LsBB+/7lRZUy1NLKcdn4nS8Tq0yRJLR?=
 =?iso-8859-1?Q?PSXMggr+fxlmBncE+/lT8ap9smezs1rVRQm0LyJPh18NcuXxf7Esx2WX0I?=
 =?iso-8859-1?Q?BA4Nx+PXf57wSyg6DzbvQdoXuUdEQ0rmJHpkHC5mi4VQP0CfSgFu14NPKs?=
 =?iso-8859-1?Q?IOUju0Lqoz2Wu9dUldhkCYbfG/kDz+rBAn+MoEdS79Q/mE0aEKckjsbeAt?=
 =?iso-8859-1?Q?wcq7evBIEfP1tBsDgUwJUKv5D9OV0C/QIMF8Vv8jN8pSTj6sFbBJnI0SKF?=
 =?iso-8859-1?Q?1qMvtZrsdaoF4CTUj7DHvHti85dVt6s6QtmKMNSV8NAk6Mf1pWwosFsPmL?=
 =?iso-8859-1?Q?a98sIzH5wPzo9sGoOOYNsfouTz7KcgJt3xcr1kZo3ct9TfCP/T6u7bfQXQ?=
 =?iso-8859-1?Q?lUZ9/hwx0fueTa7fkP6BGenPVjLbF1qODgEMAsc1B9BS1zGjop6cAM7mQP?=
 =?iso-8859-1?Q?XfTSNwBWCRpDixIFXk57GM85JewnX4FmOrXg8zthE6SyHdK5D8q2F/3YxV?=
 =?iso-8859-1?Q?29dFGxbotvqRIGZ+bSCItN4Nx493P9MBIrhzB36lXsfDWk3lMj5j3b8o3R?=
 =?iso-8859-1?Q?i1WOh97PxPLbNOZbXNE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d63e870-af09-425b-db39-08d9f0918205
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:12.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rS/UWzXnIKbCpPr2SKEDNXloiWp8l6d1W3VR9h7HNfCJ7BbnaHBMnq5m5A0QBMw7BskZ1UHjpvb+AHUQRXFP1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: E25Mj6QJbqdnWkk8rJfjREyP1CuerbR8
X-Proofpoint-GUID: E25Mj6QJbqdnWkk8rJfjREyP1CuerbR8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Unlike the rbtree, the Maple Tree will return a NULL if there's
nothing at a particular address.

Since the previous commit dropped the vmacache, it is now possible to
consult the tree directly.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 72654108380e..c57d23b9564c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2802,12 +2802,7 @@ extern struct vm_area_struct *find_vma_intersection(=
struct mm_struct *mm,
 static inline
 struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-	if (vma && addr < vma->vm_start)
-		vma =3D NULL;
-
-	return vma;
+	return mtree_load(&mm->mm_mt, addr);
 }
=20
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
--=20
2.34.1
