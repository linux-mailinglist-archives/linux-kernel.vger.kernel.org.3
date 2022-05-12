Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C4525450
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357421AbiELR7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357202AbiELR7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:59:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6132324F224
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:59:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CHYYTu003183;
        Thu, 12 May 2022 17:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=bw3zU9KN5rFsmJmfZNiQrM2wS38y2x/vZUW3nwEdjOY=;
 b=mRN9/Ov8bjHXGZtBQusVnqOcaqLu2DWr3JFVcR51d6jEqbwGTpD3wTmnSPqtdYgUEhGA
 vfSvFb8lI7kZmlBJroi7EpZtswaznff04j/D1TXQ407Jc9XprqbD4Fl+A0WmsHZnHOPO
 BhxS5FT6vbt6cDPUVqirvebNZoaY+g7c9CObmTUbm3i5nubcYSEjLJDXy3tYsIy/Xl4T
 a1rhJRpRNKSrPbXrM8zqgEIIcIkfcCWyZdiBPl5HGkxE5UpPt84nCQW6T4fbt+TZnVvH
 eXTj7fKIbHFErPe0VdhLCVI0lM9qAYX3/ih2/py0vsrokjU3hipdGa9fcK6FCq0YSxUH FA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04mj1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 17:59:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CHummM022580;
        Thu, 12 May 2022 17:59:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf75hkkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 17:59:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO1+5S1QHFgw3aYXMe+4d/o0ftDaC64GCNwH2Mbitfp8/9SF6AJMMI7nmZ81DWMjoHqe6pP+Y4Uk5Hcbwf0efeYCRHzhIQqll+XUYxKHVe6R2IOwLYrsrwQl2g3wdt4aBn0uwGvyQYDH0O5YexN8pH9KcWQ+nV+OII3a43xNCGNro/2TEa3HGlJPH63leB3vcrOAO7YzsYYJb72bDNMoekmWwwwqqlQ9Z/+k9/E3PZPhx23luZulu+HIvPAo6VXNtHsscCKtCUOgUl6+OjYaSqaeo8BG9via40i4sE+FDaBYYd0/ZrtDqCK+4FJo0iltnVOsRC2Rkzl8F7+VMT5rEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw3zU9KN5rFsmJmfZNiQrM2wS38y2x/vZUW3nwEdjOY=;
 b=LH0gHbW3rCnhgMs2vSMvPcRQFxEzfXJ69kDsUCC8t46S8UWDTCUpAAs+WI49gQkta42UhvFkSyvXxbNmDUiaw3HjZxOVjFN1kKTTpomRW5kac/S32J6Hx4+0FuO154F8ixSYWFRk7lpia+R6AgbA0YF8qG9g4ebrCc8V6F1d8S84AXPFphQ3aFVQ9iA+KlZY+YvEpBbLyxgeDTRZ4I+KVu7v8XGPtaMJ+U0ADz8lS27SpIJrbhkW/CKJ2Tmj55VTeCnOXATznR00bGleBJqVpH3l+H/G5z2vqM25oHsToBw6xXLX5YI0l1B85TWo3ZNFsLrrUKBwAby9ETZrHwa3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw3zU9KN5rFsmJmfZNiQrM2wS38y2x/vZUW3nwEdjOY=;
 b=bVdiNBeeFDNBhaBSukK9ruZx6GWVM5XS+llKRtlXEXp65LWwkEDkvwlugGTI9B0moHz72mnVHDooyxCvqfJKBGdxPQl6lCzyRhzUm9SzxAExtx8Jm0pg84ml0T9EjTOsXBgcGyJYyLJrtE8jsvweqBSXWDAhQWv7/AwW7lF20NY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1308.namprd10.prod.outlook.com (2603:10b6:3:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 17:59:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.024; Thu, 12 May 2022
 17:59:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] mm/mmap: Fix leak on expand_downwards() and expand_upwards()
Thread-Topic: [PATCH] mm/mmap: Fix leak on expand_downwards() and
 expand_upwards()
Thread-Index: AQHYZioEIQGdMJMVtEKGyI6Jl4lozg==
Date:   Thu, 12 May 2022 17:59:25 +0000
Message-ID: <20220512175915.1814885-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ee13d27-28da-4f18-b106-08da344126a6
x-ms-traffictypediagnostic: DM5PR10MB1308:EE_
x-microsoft-antispam-prvs: <DM5PR10MB130819C62E09C9D05816061EFDCB9@DM5PR10MB1308.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eXZNfQxJs8nTVVDYuBRpA0E8K+x8HtKHL24JdJ7Fg5jE0hPl1QSeUGQcr4L1jvW0txy7iamiBrLIG0Of5i4zLSEdRwk3OPfwK3T68EdASTsMuqUEBxIgsjHYWZhKNrMVC5aBKgE38KSCJ7P2ZXB2RE126YAUA8/aPttP0nhXhhX+5x6eCTM54daVyxCFgrqf3F33SIQRJ37t8AN0S4nm0g5Tiet7A8CUzsRJV0wbTqufNIgdZ8k3AnOL7LGXYL+t0r/P2b65aOZ6T7jESa483OZpVcHhEwJoHGKGBSd+IzYYuQPtdmRHeCUuChZtky1aIisG0oCVHu4cBWxftWnCAL/ajJqRtIBD9QZ0rjbJfY6Ke15/4lLB9X5WkrkXqLPpRE2YAIAj9tYsVnLpMBv+5GIszr1P2XTp2BxNeqzKtrM5S9MCJ2IIoqNMOIH7Ab2HejFA4DYPOf+lj0F1ybsdWsxbkjBP8aHXT3dx2YJm9bjeJ19ZrAuJDf3TtuRrI1ZVMnt0eF+55xwyiiELx6dR/kv/piYE8X76bstBOT+GgAYvyRseLMIiCisfGmpsI0lFn/Uf+uVq0TT2ozYtQC1pRAvHWADK9YueCyOu7Kpd4CDOHiQN+rsMDidoU53kvKLyU/UJsATwigkc2QQ917O8W0aata9pwWWscb2C7HRCWZmz6De1lefw+EC6JBiZbu4PsbzrCFoTcEFio/d8kqWuug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(122000001)(38100700002)(71200400001)(8936002)(5660300002)(38070700005)(86362001)(6486002)(316002)(6506007)(66946007)(66476007)(66446008)(64756008)(66556008)(91956017)(76116006)(8676002)(4326008)(4744005)(110136005)(83380400001)(186003)(36756003)(2616005)(1076003)(44832011)(26005)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R5735PDp6kEaNPU5knDZShE0T/8gCAFKcYEe1lNdBNPnfP8O5OCeIR2VwI?=
 =?iso-8859-1?Q?fhpGDmuK1U/AC6PLx9vX0dd7e7AgQAmiSHnk5R/VDKoKfUQisXK/rRKAFr?=
 =?iso-8859-1?Q?2bohB88Zpyvb6WxrVakQ20Jarmgzjgjn3pWSwRMKY4bb9sCJPLi65OJDgo?=
 =?iso-8859-1?Q?y6FgyErgqaREs6yyv82YDV7rB027X2HduspvFXQlP1+CmeOAHrOla+K7ve?=
 =?iso-8859-1?Q?3isjQGVCyEL4xymua13pJHHhCCGSCi3OhSkypoGgq+dZ2HVuLKmNuBY5rw?=
 =?iso-8859-1?Q?hutJYzHNHrxuTBRijpq9/k5+4HemIsrwJRKr9E2+DXLRiYpurDTiLggRtW?=
 =?iso-8859-1?Q?UgbFvdHj/iX3wRmkIOWXdVQK1DBDVi3A5jfpnwpS5dOEQvsu0Vj7/Q8tJw?=
 =?iso-8859-1?Q?m5wcWwVJEKuwDCSDY8bej9b9yhZEweTiAvfEDk/1GjRuUUJrAIJtOx5yg2?=
 =?iso-8859-1?Q?6q8uadYORDCpDglSjsvHdndqH6mIbvxEKT+9hMAqk5bwUJS67NEByUf89Z?=
 =?iso-8859-1?Q?HDvAVdq2DaJJHoy/D9nPBOkCgVc3A/dI3y+tvvKzA8sZZg/kJ2lZgqmmbw?=
 =?iso-8859-1?Q?6FTvKwIJdf/Gyam0cq2gokGpf1x7SaXGsyFRxrErTVjY34J+GwNG2AVSVQ?=
 =?iso-8859-1?Q?YtrmWBqMiv7WvXxId2kPqnsrNXH3YX+xaP8YOoQs5vkHaL33kLYL2e5tBP?=
 =?iso-8859-1?Q?AtNgDbRtgtTvbWjPC5Zv2TW9M9XC2HTMgFuXQeCatUeZ/4fScALxRSNg3G?=
 =?iso-8859-1?Q?sOIK+4t8kYwfpMZHhU3ON8SvsH/SakX3L9xBR0oZLQjGIFEfD5XhRwaORD?=
 =?iso-8859-1?Q?atRuSvQ6mSBl0KN4C2jIaa+UIMvtA5GFjhHs6m7l8Vqrv6jYADoGFDFlFv?=
 =?iso-8859-1?Q?am8L8v144/oMVbIG1TiQ5EuXuZleNcgr9rCIz0iyljfevffJ1LdPL2rrJa?=
 =?iso-8859-1?Q?ClcUvNLKTA17btzsdyXQAgl3c8V8E5w1O9CMEXSoIVr6ELRCxIW5sl5Fe5?=
 =?iso-8859-1?Q?rIex+qaYwneToW3IQ++46eoSN2T/v55SReM2rlTMlUXaOz0cU5bQr0HeiW?=
 =?iso-8859-1?Q?KSHshn1wbRiZ8+hWAy5txe3eajpQTBHw8OGfc3bGdna6uCsFsCCiBJ02CG?=
 =?iso-8859-1?Q?ajMU3Ig0OwfzvNcTq50gg1I0KCwekgLM9ftwfNIGSYMvtibZ/8P3/BZJmA?=
 =?iso-8859-1?Q?a8VjGkdi9Cp8l8gjfX1iPaYBMIh7ZAHKZJ1NwPhP9hXd6AjcOYsYtKnqmm?=
 =?iso-8859-1?Q?4ENQJv3A4UeV/ns7dBVceOd5Sg4oVC9pwMiqbToSDDP9w2QAt1v8KvxDXb?=
 =?iso-8859-1?Q?TuLf/NVtCQA7TH4z6pkfNCnDz6zcBRxEVrQ2OpVdWej6H3qkFEJ9ltZx05?=
 =?iso-8859-1?Q?r1m3m/HdlKsMNSyjj5st78LaZNtZukVxK7TUILQHKOmbgfCGO80jQomSDt?=
 =?iso-8859-1?Q?uzBZ3S5WjHcE3+TqxlkEWuEiP2XWZsLfH+2aJ5kxCFlJ78CibX0NDUidzR?=
 =?iso-8859-1?Q?Lj4w1MYuF6eQafa+XRkQA0CaghDtQjtD4/5KJRMG0hSlXfgTFdkknnN+u/?=
 =?iso-8859-1?Q?zGQTqAeCKMPG5gc3qGfDUsYfmFtdg5EymZ1uIWgh9UtgBbEvtgc4seCVVw?=
 =?iso-8859-1?Q?Ni3WLNrELjYuKBelXdILwcQXVDqNo9tn3QH4J2iRO4N5s6L2gd6zoV/oQC?=
 =?iso-8859-1?Q?dUTjiQv3q7Mxtu1yDUqZ4IslgGx3VovwWSPM1Zb/Mr60q2qoJC0YovWkRt?=
 =?iso-8859-1?Q?Ms29gXmc5g5fbCl3Pm0g8KLNCXmBTkW5vtgsW9U4zjNstY9SNnrZqG5s0W?=
 =?iso-8859-1?Q?37kwSLiOkvNKDYUpchELBBBSPlSqZHU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee13d27-28da-4f18-b106-08da344126a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 17:59:25.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GnG4/KS6Fwac5uSjUxkA6PqtgskMapouj80hVGdZIOMQHGlHuiynFXg8GTnsQBVK/IPPnP2P+Qpk2EJFuZNsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1308
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_11:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120081
X-Proofpoint-GUID: wGH37IaeNNeTLrhUJzA8WlFNgdywb4Ta
X-Proofpoint-ORIG-GUID: wGH37IaeNNeTLrhUJzA8WlFNgdywb4Ta
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory leak is possible in the race and error path in both
expand_downwards() and expand_upwards() due to the maple tree
preallocations.  Fix these by always destroying the maple state.

Fixes: a760774e7b7b (mm: start tracking VMAs with maple tree)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index c147d2b5550b..ebfd71a79814 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2047,6 +2047,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	}
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
+	mas_destroy(&mas);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2128,6 +2129,7 @@ int expand_downwards(struct vm_area_struct *vma, unsi=
gned long address)
 	}
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
+	mas_destroy(&mas);
 	return error;
 }
=20
--=20
2.35.1
