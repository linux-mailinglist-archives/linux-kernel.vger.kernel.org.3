Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17251932B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244936AbiEDBMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiEDBLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D84349C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:08:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KvDs6027626;
        Wed, 4 May 2022 01:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FBfmXrp9KlKhKWdEz+tIPzTviS3VeWBUi0almuvY3SQ=;
 b=sxnm2UOObL1nzSCd1U9NMniGTsgj9h4rEMBhCwIrvPAto9SauxVNdvgJS3hnyrLCKsGx
 zDaiNhrPShU0guZfx14kQt9M2+TZaVOOXITTxMhRZunlwu3bhphsZN+f8mD72kPyRjX1
 blU3o7bH2P3pZ0r7O+9Js9bGNoxyTczeThxIHqhfl+o0wfmlDa6NiCH/VK360jsoqGRR
 K0I2OD+/48Sfv0ytp/pKSRumu/xVQ8ZFaNHLzbPLHdc18ilN72TJfh72c1026MOTgv7p
 i2oEmadNrlLNXXYeB1xTYS8KrYQ80ik8Dvmx506ipW9SGT++YGmepKuRwRdTQqF1go5D JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2f65r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24416SvK039119;
        Wed, 4 May 2022 01:07:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2wdr3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPEdvSYhFhxH/y9vR/3+l7WUcRLdhrTHHGDyrbCOmH8ic9QpNViys1Dmx/Hz9ZGN1WZsItOmxnwTHYqVTTy8yfaLer4XvbJcmNi9wIjjigYO5RRnn+M9oVIA1+m/vBVsDK5KFRjEW0JGLMhW/TedNLusqSp4suxwDKjunow0PG/ZLv1Tdb2ZEgvWIAWwYBph4wcwk/qhw8kyWBiRhV0rCShCL4AYboHDXrh5sFoCRe0TJtRSW3LY7DxHTumu6Bjap3PrwUq2i5mZlJUOJ/lALFzsirdnY2sM9jXD+oPQIL0cpum4H17/4HHdbhzH0GbVyQSAmRm7PkSzbnI7IQoMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBfmXrp9KlKhKWdEz+tIPzTviS3VeWBUi0almuvY3SQ=;
 b=AAFavG+NusKY5JbJv4Q0wV0DilqEmzUgQ7WmfRzTnz8DAQh+by7xTik1tePSGOE/6tn5qP94g/GvzpdOaEO8sGbmOT4pk65l+hIQZf5+70FThmo/KmzNeq8YRGuz4vsIYOq9UFJqpaT8uaD3IEHfiUQEc9lq0dSOtZESNrdLeBS21gApp5G1MXKbLVfOfofuVjZ47RyAYOyzzBdscpDLJjZYb9OJjSx7Kv7R+JC+95DK2plsk7GooS7UyimCkXdamdMMt3RifNRnbfcbxRbU8US4KJfRLYZHcUDA2AZyc06ALlL6dHqbsOgFcfnYrA3kBI9D+i1SztcZrvwp/ZiMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBfmXrp9KlKhKWdEz+tIPzTviS3VeWBUi0almuvY3SQ=;
 b=nrqIuNTB2kW8ZTdlykK//ZMgehb3oLoB+A8GBRx3eeql6fB0/wsrtIR0uXGvvUzWxSJUFTB3X7AFP11fesoxg/A7fwczcPuwMnaxKlAr7WyW/wyaqVv2svZ1y+bK1tSX7W/kwAGaAlcBoZUD7xsfmTVb7zoZ+KsRSv+wXYjfljo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:07:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v9 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHYX1Nh7aXcGbnpL0+njfyrlBp0pQ==
Date:   Wed, 4 May 2022 01:07:52 +0000
Message-ID: <20220504010716.661115-12-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae9c0e72-7310-4367-ce37-08da2d6a84d1
x-ms-traffictypediagnostic: CH2PR10MB4214:EE_
x-microsoft-antispam-prvs: <CH2PR10MB42148D0160CFE43B3110D415FDC39@CH2PR10MB4214.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRLKU9Nf1PqFfvJMR1UVTNoOwpCoHVWV9WFiR4JdfORbMrBLK46PGujvQmswndNhezvRcJtBKVZYC9AGxhE6+tRtHVyH0l4lWIu09IbOjU1nNngqxYserkSsJPFrpYqDOjEg9Bac2rULtIgXJDmPzJvAqkRiMmeEfASjLLpz2QbI3GuplWeT7ev+2qCMHH8swBNto8I9fLT3jw9txRPp1cW80OFXz1CbcAuaqfbhMXqO2CwkWCL5w6yvV0ZuTjmymjTYmkWbtKrIHauM417jhnsXFVm3bmGAbyr2hEIUDDEJp+c39wNhND4tZ7vHZ9pn/HDiAAMc5k+eCaUWdObHstRPBO/lQ9gz/WpDWGMGnFoeC0XA93gcDsP988Ki+4O/AGXiSmFSu8ugTjUlfOpkHGJ5AKlDlzjrTeEEgDZLrzjQnq3IZHhqvzgLjBdkI9u8V1YhupoFXFTj0dO6sVYo3uHpCNufhg+tugD2ddlJRXmAJtUGppvMWshdCxGGPtp0NwfntR1tcUZSxaSFdREfa1vtbu9QwU683tulUDE68oWKV7bjGkMdLMgBkOUhOoyuFzuIq3PTZO6P9kQO+0qJHHI4BwSHg+b/9XUMBgeX/r0PnF2OnBdkPFrryWAHPZ971f4dC6JQf1cPzaJlWagJNnK2L7WUP/aFpLORwS6sZuslDBj49IDsIlXNUFT+DF5crbExWF/d/LRYW0W8W2lKbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(64756008)(66946007)(66556008)(66476007)(8676002)(76116006)(83380400001)(2616005)(110136005)(186003)(1076003)(316002)(6512007)(86362001)(26005)(2906002)(6506007)(71200400001)(36756003)(5660300002)(44832011)(38100700002)(508600001)(8936002)(38070700005)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PLoMw9zw3dHlAx/Jf6p86W7G9SEkGOlJFCdLCyK357Jk9JI2iIMMEUgWGe?=
 =?iso-8859-1?Q?mpUVnRfDy0jNL1O2NrX9KOeGlUEx9H+6uGKThH8ju+LIdGtASubfdTdwU1?=
 =?iso-8859-1?Q?Q9WNXMRrIKdbVmwFvA8kY4DdpCMmzcZ2oLMiaY7ukaViUWxMEVwlrg5ypj?=
 =?iso-8859-1?Q?Arm1ZubZ/9uqmB0qFAyGpNaio9EzvNAHnGGz/OOKGn3uv6oQJ01UJzpFia?=
 =?iso-8859-1?Q?mHy5CFG4prrzhMbtvmru0VT/rcqslTddwC+LcQOIDGa3fPqKQyNnSDnCKi?=
 =?iso-8859-1?Q?lT01Cwboqw1oo3OL6x5SxhMKw4Z4PYokPnwzf79TB7JgBo61p1GAyWpW0i?=
 =?iso-8859-1?Q?O9Pea39n0pQxT0aaO8X1FFDln35l9w6zqESpN3XCc7I9YPPrlgx771t+75?=
 =?iso-8859-1?Q?F4K08nC6U6ScEbDJ5E/aKbpRtg1ba69lV+9pVOm5OjRIH8v3FP6w028H0+?=
 =?iso-8859-1?Q?CV+NBqZqcuVtDg0Dh3G2+hcaOECIzf0v2I78t79A/IGRkxVnpllGRo5HQr?=
 =?iso-8859-1?Q?E4cyn1Y/9XF6DdE3hv+jMvgRLWwGzsP5GtW7jN9urDLQfxe02oGAiCOZuN?=
 =?iso-8859-1?Q?qo0jxHtndrMF7v3r63DCazFhU/58BKgmnx1NWZojbgRTJtM/JlED5S91Sn?=
 =?iso-8859-1?Q?6OY0qoSgoJalarNmHUp/zng/QfzVGFSWnnjJczmRQXRAOgA1aKlJW0yrir?=
 =?iso-8859-1?Q?ka01chEQaQPujitWmRBrtfb9/1E8DGAVE+kDByYkHv2lbMvcXXFwkb8Q8H?=
 =?iso-8859-1?Q?QYnk8cN5O2reqwkJBSLxrOogF4LRXr/rOQS06LJRGm4YOdurub889qcV6z?=
 =?iso-8859-1?Q?SYlBMlMgucIUskyQgpf1P8VNXNSM7o5oEXBPvlWPo0CA5lxmBH8oBkBvnn?=
 =?iso-8859-1?Q?oRNbWGQL7wTi7J91S4f0H1amEr73PlCL7+WUHcDBGf8fm8IYCZhndHx2r7?=
 =?iso-8859-1?Q?M3MmnCUwtA06OUDFR32GTKtN4EsC1PJPPb5LlH8xsIgeQ9DGiGI8Aw37vc?=
 =?iso-8859-1?Q?7dVk4KRbMlIH2yuCF9PUYILXDbo7UFv8pXVa10/xIHi+b+w0q9sHm7mj8v?=
 =?iso-8859-1?Q?awcdmN+FCGgnOjBmvsiezF/zSSOtmyltHVbLxOie0PIc6MnsiOmkHmKIj3?=
 =?iso-8859-1?Q?wjl1URRwHvqjpz7fJIDMO5IOcBIh0ypajhgcY1CtbmC2HYuyTib1L9ykaX?=
 =?iso-8859-1?Q?GmycSb4GW6uTV5f+gIek+h+RzPOJ3tFJo5jPosGV8yPJsmZzVSBXxz6ZIH?=
 =?iso-8859-1?Q?PHFNzKBdDP0CywuY0OR078ztTlXlGvXwIINQrSAjm1ow7C28xBu+R2KNfj?=
 =?iso-8859-1?Q?L/CAJ/WSmJDBEmy2/rSE8pUtijXAAHbzyLLkzBvwgw5r5EKM0t2AGY4jkh?=
 =?iso-8859-1?Q?vrlGYpvD/TejgALxD0PX5XTV7w889gXLqLZRqpV9M4f5Sl6py+jDyBztul?=
 =?iso-8859-1?Q?vTpg1ojgpcgNmzrZtHRqYx8DRPrL13lgAtBkMx2mHEiXYtB/qRffD4o+aT?=
 =?iso-8859-1?Q?P3Ew2c9766TpPWBd1+MsilX0TY7E2IjnmINMSe/cCmiQNCOPDQCAWmXRdm?=
 =?iso-8859-1?Q?YSEeVQKDY1jpLT+xXuLibP9ubGKCW5HDyJtHmATo7rv0CTpa03sK+PuELK?=
 =?iso-8859-1?Q?2jQRptpgDcgjMACjew3yd4PTOJUNF2gkVtmyKHJRXgIO/OnlwxJE1pkWAs?=
 =?iso-8859-1?Q?2w+cO+utNpke64wlb2U4lCnjCvwb4NGbLd3AoKWemakqA6pNTRukalmQYY?=
 =?iso-8859-1?Q?FAW4/yQbqSyz1C+Mb/foDPv5JgYwzNy+QB+L8hjOhYLFZmGg1U95JetdqT?=
 =?iso-8859-1?Q?4hX0GvQab7RjKN5yL6YeiLqq+rqE/3w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9c0e72-7310-4367-ce37-08da2d6a84d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:52.9941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfKb1SKnOKRjFpQV1woaFu3hyoInZoUrxXZQ4i1WKdeiCo3SRBGt/nZwA8GvM+ykz8L3g51xypXNklhpV+xCDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040005
X-Proofpoint-GUID: WqMfaISErelorzYWXi-1RZC6AEinjAe9
X-Proofpoint-ORIG-GUID: WqMfaISErelorzYWXi-1RZC6AEinjAe9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This simplifies the implementation and is faster than using the linked
list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7e01bab46416..4343286a6ca1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -675,29 +675,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long =
start, unsigned long len,
=20
 	return 0;
 }
+
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
-	unsigned long nr_pages =3D 0;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
+	unsigned long nr_pages =3D 0;
=20
-	/* Find first overlapping mapping */
-	vma =3D find_vma_intersection(mm, addr, end);
-	if (!vma)
-		return 0;
-
-	nr_pages =3D (min(end, vma->vm_end) -
-		max(addr, vma->vm_start)) >> PAGE_SHIFT;
-
-	/* Iterate over the rest of the overlaps */
-	for (vma =3D vma->vm_next; vma; vma =3D vma->vm_next) {
-		unsigned long overlap_len;
-
-		if (vma->vm_start > end)
-			break;
+	for_each_vma_range(vmi, vma, end) {
+		unsigned long vm_start =3D max(addr, vma->vm_start);
+		unsigned long vm_end =3D min(end, vma->vm_end);
=20
-		overlap_len =3D min(end, vma->vm_end) - vma->vm_start;
-		nr_pages +=3D overlap_len >> PAGE_SHIFT;
+		nr_pages +=3D (vm_end - vm_start) / PAGE_SIZE;
 	}
=20
 	return nr_pages;
--=20
2.35.1
