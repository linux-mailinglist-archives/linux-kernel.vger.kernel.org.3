Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A80553C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354959AbiFUUwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354633AbiFUUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:49:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CCB2F3A3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ5FQh011595;
        Tue, 21 Jun 2022 20:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Lu+uXqeWPObf+f/9hhmyapGX+qynTn3ejmeyktuGCwE=;
 b=r9mySExUsB0Combfs1XhtVMK7kOet4XUYJAhp4VPPEy00aeUTbkTzd6w0lQASszpLjA3
 RLLtUtN6v/vc2RIPm+NkyCpohsKwTLLXFyeL8QIVJatYQSHr9Rh3RZ1UIVW1MH9zIhCN
 7XAQCLBbko3wb9r2R6iRHk4tL5tygTISWdxRwEaZLrtNp+V2y4Je5Dq2VrwkDKTFlObR
 5wR27M+3POwvd2lNoTh1eYlWbfM/nBivDlBO2KDbdVr0cy5Dq4mFmRPJ5Pj0hDgj0i71
 MH9Ay0l9eRUa0ZFNvJLgICNLE1cikRnLfSCKd7Rkt1CvFXj+LMvMVXtnlCbvkdOry7G5 bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0eqbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKdwkQ010169;
        Tue, 21 Jun 2022 20:48:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfuvv7n-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDZYHAhfO0XfhEiqhSMvooQDbvqmJFRkm+pL/JVSj6g8TV9HV3CC+5vPg+ElSlnsWjaHtoosgFS6+768nhqJ2deQNWsveX1PpeahRLeCgBXbomVSBvT3Hv6cdMxBnbhJbg88g2L2pkCsHDB2d8+MRK2UOLSwBL8uLDHnC9MaCN3vNJ4J7c/RQI6tBnI5qCvQ/NKzI3aFIdodebaTXXITUpcWy58HB9E7dp2IzpfVT4r2hzRfzH5R5tZ91PM4bXfqs1dPMe2VELidXcojAw7D4wRZTHicru/cSBFZEF/b2Z0SBVr30WloKBF3W8rhQAydXP53Q3OB6Fju0cqxYnB0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu+uXqeWPObf+f/9hhmyapGX+qynTn3ejmeyktuGCwE=;
 b=fOelrsXUTo4nnkYVy6w8gB0msmdgmeUBSrdX6LZgNai3SOjeqJ7NQRxaTiASiqiydEXI11VP48LTtnBwKsUxwl8PWfNDfFdFYXHgBR8xrA4BCtXR2qle4nk64XRSGhaLCIPLZOQx0vxjovGAj8g5mnHhIlJ+dsY5bavxGTJaCt1xkoU2oP+RxzlB9Ew+x5N/wVBs09BjxpOh5p/H1PEJrXH+EVOotZgB6RfgwQIbkY/IPE3cm+YzfjbYDPDZMhvL659wkFpQW1ZEGJZKKBeK2YbOG0MOQw0o5sEmsL+vh9QA9CUTD3P8Z6WMcfkmYXW7oROk7bH4X8Z3Rtkgw67z8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu+uXqeWPObf+f/9hhmyapGX+qynTn3ejmeyktuGCwE=;
 b=jBX1GbyXqlt1sRXLbKC1YmTKgMgkfoAs0tjDJQ3Y8GKUV7ND0MHznwPSRbA28W2qzH/Otc307qgzUhIo6RsIjFtyOBOGptZIJ4fHQbKOTobgoJSg2sgv57t7avBwQJUvvF+tBCQuqk6x0KulckpLZWJcoGOSTWld4npE9Sdqvns=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3869.namprd10.prod.outlook.com (2603:10b6:208:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 20:48:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:48:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 62/69] mm/pagewalk: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v10 62/69] mm/pagewalk: use vma_find() instead of vma
 linked list
Thread-Index: AQHYhbAVN/coEYHuSU6KdWF3McCE8A==
Date:   Tue, 21 Jun 2022 20:47:12 +0000
Message-ID: <20220621204632.3370049-63-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee4997b4-2246-4c1f-c3ec-08da53c764d3
x-ms-traffictypediagnostic: MN2PR10MB3869:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3869A8D3BC4A9A06B5CE655BFDB39@MN2PR10MB3869.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sc1+Eeib36qQHLJtBvrU2NLQ+rNKzhVzDbWzD025G3XXlfzZuPJYQrGfWTcLgw5x0OVgT9XFO9kr//HEfUUZQqPrc5IatTzxrYqdtfpKTcpueog4nga/WajaPGS1q3peLA4xEIrhWMF1O/od7NqeHv/vPY3WFQURrNxe4nRXfLzqNP3Emcvi+T7q9rUkZO1t70QPyTn2Ram4QQ3j9BtMLdaPoXbpq8Qp2PzkB7yR0amZDw8yRDUoXdKFPA9spv9FxkDub33A7CODzvLBjDrLXub9kpNAMaRVF+DHdvjNiEVbi38UyuG7ybtQNglzXnwlGIA+BjFJQii7ZwbfcmmOOmACIGyBi1jfpnUbSA1hg/K5brugxWw3TIV1BG4r3Q8BG97A2cbiXrxNDJfqQ+qoJhN1s6FEmRHvmu8W8JYL5YH2K2X3Xq1t19viofh5YPNFfix/Wt3xm77mi/1xms4EkTLfFXeXsEJk7kCLZ955OSSiMcHr99y0/kgQAHW5FnhuWUf2Cet0LTeppb4v0eLvAS1RPcLUV/SPz8S1+ZrYujEVU5mc3JNlTQrMBAT1/hNp3VGUvFIVQS/3lRjpxLNy6bUyqKiUXG33Hmi66wDbJA4uOweFNShchXEpbJKxQm2KvUAxGAb4K58p0Gg5YxmHeOCTwx+JAxDbfnSSTmZlwBsI0Oo6SQgK450CRuk/HRbmuRwn3Vdz5rzqFOgD2unolCglRj8kNTdp4xc6mxJd+ftxstJ0hxToSGwUB0SjbNeaMVIdFau6y11V53kpgzbAAljays/1csAOqM5ZCMoylOk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(26005)(6666004)(2616005)(966005)(91956017)(6512007)(6506007)(186003)(41300700001)(1076003)(122000001)(83380400001)(38100700002)(44832011)(86362001)(8676002)(66556008)(66476007)(38070700005)(5660300002)(4744005)(316002)(2906002)(110136005)(66946007)(71200400001)(66446008)(6486002)(36756003)(478600001)(8936002)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PyGvcnn9Voz7wya4NRtjQmQWAFb8gJEU12PmGVjy5kE0Rn2SiM+h0SIOaH?=
 =?iso-8859-1?Q?XMXNzBShE+4X7pWN8oFAjQW5ucvZgTIEDtGqLW9mRLGvAsttbdkqrOhrWU?=
 =?iso-8859-1?Q?HFv2+ToOmDrJZt6SIbLxniBUKxkAUDdw8gG4xvu8uuecczcyhl1bMvnx4W?=
 =?iso-8859-1?Q?GsJUXcj5zd83NbGlziFdBEYnaHVXa4msLkN1lQpy9nSypouU7+9W/B0wUp?=
 =?iso-8859-1?Q?iEZYFiv72UOaLrTGyQbN6h+yOlJoqZeY7cWh9dURVHfgPT7tTCZDdhcghj?=
 =?iso-8859-1?Q?Y8+FldoTxN3jh9FVfhIOKS6l5ZeI2Cw99G2JrInvP4OVnj1j7kfz/C57qE?=
 =?iso-8859-1?Q?VFGdb6B/evVD9VENPYPY2NHu2MZtgy24L51HPwCMMrMXKaBgPkh8suDzjA?=
 =?iso-8859-1?Q?qvafjQ9bX4hoeBzUZhsPP8NlVup2VbwY/VgVAQ6mE6weccd+2+pbNVdco3?=
 =?iso-8859-1?Q?O2ik+2jOr8q9Eqgfo38Y/96fn3L5j+7btpzeOlDlWxaCSKwORRwj7NYANt?=
 =?iso-8859-1?Q?HgAWLeKvlHPX37+3AkmslcFPTN07PNApt1Ktx5mekFQ2yA3VfMb8uYtZ+k?=
 =?iso-8859-1?Q?dwq9dAAp58Jx4LlNQn8XC8ITb0ZCsIzR74xc7Th1lEX1bMAl40+5w+bF6u?=
 =?iso-8859-1?Q?KP+nU3CuoMEG2PZ5259Z04TX+B+1l+ZXdfVcsVGyZLTcNBTtsKPpJU/1lw?=
 =?iso-8859-1?Q?avq1VmaGyxxuEitikMr4a5E9EudyuEqSuPYf+L35gWt8OOzoDBqzsOIEUV?=
 =?iso-8859-1?Q?yFffy8YX45nojKWE9CxxvajV1HWtN5kWq/E0+DiTe1pAXPMCvs1z9rHG3Y?=
 =?iso-8859-1?Q?hx+nbTvgSeoV0svWK/pbAgsl2+EG71wmE7vQSlZpWX0lRdHlxvkFZZhieP?=
 =?iso-8859-1?Q?QEfQedkXmnfFIMJ2Dw8NIEh/45XxBb3P89Flx0fnBeOK3H4qSNxFu0TH2s?=
 =?iso-8859-1?Q?14/gTOOinDDt1tpRh9xXn3tnCSbcc9VxrxSvYCyEqoO1xy5jt75ohsbBwR?=
 =?iso-8859-1?Q?PesmUO6eKUGHpUAJw9w3n9cfgr01hnQm0sHPXyRJ13eqcEObKZnthEKddW?=
 =?iso-8859-1?Q?c2k40A1l8wJqK6gHlwqtrIqqMV+SCEUFqSYy1jcB22m7RyEl1llsOoLeWq?=
 =?iso-8859-1?Q?ab3oN7pQHcuwKuSLE+dSME7ayCufFrA/8JKlNDz6rBx59jv/msC/5bAwO9?=
 =?iso-8859-1?Q?Qtimv46YdMI01WvSuy8oUMXWkaHRJPwVvvOrHXbRidjeL+W78mM/1dY01K?=
 =?iso-8859-1?Q?cePp/eE63u6KhWcSN8CgyBdwrCquOY5SwjewWcULt50Xo6ZnmcVXe/YeCQ?=
 =?iso-8859-1?Q?gUJYFb6sRY9nlVHkuMZr+hT/blPxG0MHwgVLrCOjpZiNctxRuUlXkhKCTC?=
 =?iso-8859-1?Q?bRIQEHSLeBLmBJDbi7tKxXFvcXcembZ7pHK8F1we7vcrr7ItFV8Zptwdmi?=
 =?iso-8859-1?Q?MJUdz/V6ppBFIeGf3E9F5lAXZ93oOTWQ/C8EDb7BG6olRJRlLmRVvcOql1?=
 =?iso-8859-1?Q?rs/3OP2WhNP0u40CROghLEraL+Q9VF1fzTvS0M87ofd61pKIMyRbN96qjy?=
 =?iso-8859-1?Q?zlE6qIHSq+PJvDiR60Tf2rPHZMTogex84sXKiw48cTFElkiQSGL255ub+c?=
 =?iso-8859-1?Q?f27x+Fp0M0WrrfzudeTLFvHu+kNP78dnRifKlbLYltjdaAnsEstZC7zMEn?=
 =?iso-8859-1?Q?Tb983CAjApWwWIriK1nacvdfkhAHgFGnkTstIRo9lv6xHzGOC9lulaW21Q?=
 =?iso-8859-1?Q?JdlZRnc+IuErIXix+2IKC8fYFQVlGUmXcBQbL73Z1bz4V8AjzDSEahG4mm?=
 =?iso-8859-1?Q?sBj2BhM7j7vcj3GMC7xicDhKLim6AwI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4997b4-2246-4c1f-c3ec-08da53c764d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:12.7375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FL59dX7UE8xi2LiZI0r2S6xVXd7aN0tnOxr6cgh/Ei1cLZtKrNL5Ydky+pIjvIHufm7ZhiJpwx+xE0nR/nOZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: hFSyo4XqQTabG84HrQ0gnQH7sfH4EK-6
X-Proofpoint-GUID: hFSyo4XqQTabG84HrQ0gnQH7sfH4EK-6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

walk_page_range() no longer uses the one vma linked list reference.

Link: https://lkml.kernel.org/r/20220504011345.662299-47-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..53e5c145fcce 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.35.1
