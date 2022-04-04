Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D14F1721
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbiDDOi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377832AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0E3F339
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DquEG012558;
        Mon, 4 Apr 2022 14:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gm74/0iA/LIx90egKsskfSSmwq94iUjGww9YFu9eATc=;
 b=CIsGYNyrrN0DR5Ti0IC9qXmUSdbruIL3YahWMbHMhphlLxf+az1OkfWXPKLpk/9PB5ds
 LUZ6jHZDJjmh3U4UluIgPopVPA4rTMiKwZ+daEaAHo/rIEC17hz/j+sv/NqxGSjEiCkE
 hCfTDJQMHKPQghNkKm+9Dgl9jdgcueej4OT47UK4Ir0rENx3ja97MuBluaTb/+jtgz0e
 y1lRhgGYm70e8bvfqaR9dKJ0a/IlKa/LOe9SaLyvBhhNoljw6Kra8x2pvTvdIT57DEEb
 gm6Un9s8PS7otSsAWwFV0r1Eb3FDdGWKeAE98cBF1G0gwuPI1BiKgVQee/Vz/kn9BfnM +Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGQDw028988;
        Mon, 4 Apr 2022 14:35:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2c8h2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmteaFPseTKQlj2z/g0G/wYqHpGf3rQM+aBvhK9k+91/pVeCncDil4ZWVLBVXuYDFMXzMxd9/nhP2HhJ0q869vpTm4J+5ECa1gxS6WjahiyVyaKpHbeuevBmBw0/SxRyvCjq/XMjI+V51gcHCqUtRSx3kecd0buVz7GMklruAX9V64Hm7FZSog/LaIEgZQWJ4YD5Yyo6GBnQ+O2Ur8fL7UqyrNcLchB29O+EpgyRiYOIsZtoad2ARnYv42oLpf3mHCZZIzUDYJmqStQlUwod3RrCEW/G4vXvI2FzqM8kjKc4JZXQ1oxnocshcN6jPYO9GGa/1kWZqbUlAXOeN0MxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm74/0iA/LIx90egKsskfSSmwq94iUjGww9YFu9eATc=;
 b=ZHuH5IqXJgWIqQcW29TfqVW43kf3iSCKa1O+Gbcofh7gI04B4z6g7iwZLNP8SfC7x2Sg+rQ69wu58pYaxnF6GIoc9EOHPQfdTFsWjgcreyKbOmNSFvEar2xD/7D6uNtMqr1F1yTU4lfAtFlS/127wOYq1LEGlK/6HfF/L5Zb/MyXBRk30MxMAOO7n4vTWufOKZfvZ+795TMT+0OlEpyU3U9brhZn3UjoEtwUnA3bzxHTUnNyK3KgZp+HpuT8K0hfb3qTnXLxT1STtxodliyRYSYr2+bQxDH52p71opEkIa+/XnmjvH3RV+/oKdZ+KwIqH5TtdZFJ2MsImhJ0cH4FVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm74/0iA/LIx90egKsskfSSmwq94iUjGww9YFu9eATc=;
 b=A/wzJ8RlcaGQo8hCdoQ9r/Wy69Z1vO5C32g9XPkYc0D6/493JzxDu++X03jlGSAeLD55stP+/P6gT6sUYHuKUobbkxnnEdDTpiuQUmizDBZEorYa6jaoN8Yn6EtfHgN6w54TfXoVaF0sPjRPMiTm9YVD2YeoarCF/wUI3C8POaY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 18/70] proc: Remove VMA rbtree use from nommu
Thread-Topic: [PATCH v7 18/70] proc: Remove VMA rbtree use from nommu
Thread-Index: AQHYSDFBguk568H5rkO0QNNyu3TnfA==
Date:   Mon, 4 Apr 2022 14:35:40 +0000
Message-ID: <20220404143501.2016403-19-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdd1d22b-ae85-4de0-3e59-08da164865ad
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812259E71FBB168DCF99F62FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X76SEPeqH3Y/DcTYeTCwi9Swm4DV1ETlCPAKetRqBziHPt9iKtaI9YQV2MmLUuP7SfrFyfp4Jp6RtiNLSzTzhDNf5P0m1z+Y1OaFH2YX3+x6Q0Pz7Wp1+h7+W452rO+XE1Mhra2CIeJSCMXAQGDPuTG8clrjKnEW5bvOhUHegXv8trqLhzp4AWZVBjQ4Jhpqf9Woeph6JtAuByqUOqaQLZnUw3xJblyAN0VrT32RB/GUmjO+lKgp1GG4E1k+L8ZbATJT+ShvsClwKQ3ryuM8m2OBRVA0KTMG3kZlmHAvulIQhUVLyzTMDZZ3/0TjVLnQ2TeWXJCyqKC5Fvr3A0XpF21kpxzF99ocMWdwCFTsEjukpSrt7nfoFWvAaHOtZo+Mztfysbrnh+SFP8cI7K8MnB9TI90fQCOE3SQrXgdPLHCfvSXSUhgPHIz4l+/8UgviJMy17N9ITJMFCBHU5SWQDPAes1FcEr3/rCSk4IikEUneOemPpghVZcAi23M0x75W1Nnjuyeu3aNhYD0v2l8yaLRvR1xi7Pey58hxSIt5QzRjfaQQ05ZNufA6LRC/I2qfc4eeBM2BAgKJIqc2fNZgTuRLbKvM/UBbxIC94Q0b7XlQ1J7T7yKtjUNX++VCdW3yseVO3U3Rqedl1CHBqiQ+qSF7JMI/U+5qOfcjU6fROZLWxiVJxa57rEiHUxlHqVx5rsA+/ZVQcEHGiYMn7Lc2lQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CEz15SHndAVQGieZXGrE/Jlf/Ff+PAEkJEUkEpSLOISv+NrkJd23oPtINS?=
 =?iso-8859-1?Q?BUJAECQ5ryTwMEMCXn7iEHc96QsjtFWdB5qPTMYKZv6rtFHR1VTUGcsSOC?=
 =?iso-8859-1?Q?23aAxdSMyPYu4EsXunkEZUA7NW10U+zUfP/iDR56SsLJ4JPCgeDbCmpmSW?=
 =?iso-8859-1?Q?GT3TszEcqN+whYjEyupvzUBCgs24Xs+6X8kpl8w8n4jvVQ9shhs1fm6vxh?=
 =?iso-8859-1?Q?fFKOXanM8plR/UQnl5/p7ssNT0SSgNUV4A/zRTBDFdCTKreOJVeeOgzFsU?=
 =?iso-8859-1?Q?7+2zft/9zj0ZjZ9Y/75bp7bY1OA6aAzFUV0WUHTAKpt5p7Z3QmcNAUe0wf?=
 =?iso-8859-1?Q?0EmJXpjQAnDy5DjCFzqY8Xzag2We2X+qHFhGWGdiT0A0DuHePxk8tGumN6?=
 =?iso-8859-1?Q?4EEXIaM1h/aFd4DexHBjtfFa/XcBIt3bKG5hldQQkNteBmrMpaV+7CTSup?=
 =?iso-8859-1?Q?tEDlh6mLOKNwoLN5+S1l2pGgEDiZ3GM7m5GZX9kY4CGZwTjR3r7DhJuLwI?=
 =?iso-8859-1?Q?5+6sSVjmI0OeNSWXO9r8UyOslKGcwIejOhYActGGaU0VM7OIo52dW5TKla?=
 =?iso-8859-1?Q?d/JJEZFQUwJ2rjzkolHPqAr9PKFbUrGCfCgYB2ZTwQpEkQqG/48XtB21w/?=
 =?iso-8859-1?Q?AYQXi6qsEgdS2TjX/OfMkD58tAWXMp5I2orehELZu7YxMKLqWAIEeAxV1R?=
 =?iso-8859-1?Q?ACTCX3nOZjFkHYZIZBDYTR8loWbUb1NrfocoY//CxjVq9uwxl35XGOJh1s?=
 =?iso-8859-1?Q?x5wlRCOezsiHTvMXtS7UjX0soW+RyzbfelpJpqVXqZYTaY2Qr/critxTYM?=
 =?iso-8859-1?Q?ylhKWCG7OCVjdNZRXPCPjeHsot/7q0Vl6o4b8PY1zhuBq2w5WhKBQsd17d?=
 =?iso-8859-1?Q?xJJu94IEFPD2o6o75r0TjZZh9ZGTi53pMOIGA5Pek/i2rJo15UJhOV8BfH?=
 =?iso-8859-1?Q?0dBv94ge8z28h+IIpr4Rb77vf536X279UyROzwO4pngcyuiRPKWX5MzSM6?=
 =?iso-8859-1?Q?XZJ2kGNarHhU3NPNikBvKMw1UBurxMjmwPOXn3ZpvBSTEXsTp9Wim/YOAZ?=
 =?iso-8859-1?Q?DxKYALk8YrFGDCKLtSZArIFaEV7w/ZiC2NPsS6OAot043b3z4dMyOqKuC6?=
 =?iso-8859-1?Q?szhnQRU1cULhPNqiBiQu59uRUQuhVNA6d/lOhYNECcg0xZ9EeM0epnUvNM?=
 =?iso-8859-1?Q?FFtFoXWaBzq8TcMsw13okh4u0i/gaIl6rtEY6hxXANNg+CEj9NecSgSkmW?=
 =?iso-8859-1?Q?80yM/Ab0sZjOfG3OggNhcsopulH5C7HtkkCBbE5p8QRrOt+NkTvb0ICUDd?=
 =?iso-8859-1?Q?fDAxDMmNrRuww4L6mi9CcpXdvrb5CcqazbyDrA0459SZN3QrfAJe+Q5HqB?=
 =?iso-8859-1?Q?N0q5+YdUlK3anlCE0ERvsrugR+24Otakrjrst4AQEBsOnG6rzVsDgmbgPP?=
 =?iso-8859-1?Q?dXmHH2H+15LBfUMwP8ZXB1m8nXQFSWzKkjGL2tUtgCUgfqi4gvN8s3ugK1?=
 =?iso-8859-1?Q?PBAaDfvz2RA562ga0lx5cBAF2rxNx8tlplorFQVaTiuYzgDcKZAxQl6ZvI?=
 =?iso-8859-1?Q?kgtNnV+56UicMi4LBViTqcTf4O7pxeKCTDrF6Qq527bxLhgJzBHOSbX9CG?=
 =?iso-8859-1?Q?oqRi6h4R0g2B6GzpxaX3RVGNZiclhu/5XdPuLn22CMQBHY4kZtnIiofuIg?=
 =?iso-8859-1?Q?UqnLsPv3bHVmjW85g6yEIN/jGDWybae7l57xOEj40/VDjnVKgzX3p0dPsm?=
 =?iso-8859-1?Q?HniuApcZpGtoqM4Z5nHUGtbXZnAp9oVGW/Hck7dKJlwfToijWAyr7+vdBn?=
 =?iso-8859-1?Q?KRG7lKcmbOdlzaOKnvC6ptHQlFRg1sY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd1d22b-ae85-4de0-3e59-08da164865ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:40.1438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIxhLSP7VqvgyK/oOgTmONpSAfTEgUknGRJ7V10HjpzBAhPX53B/o7ZybluvAAbwUSW2SERcMBFpLlAmJrFW+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: cDUm8dcaEdlRbGWHnNBqfS7aqdm0UV5T
X-Proofpoint-GUID: cDUm8dcaEdlRbGWHnNBqfS7aqdm0UV5T
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

These users of the rbtree should probably have been walks of the
linked list, but convert them to use walks of the maple tree.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/proc/task_nommu.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..2fd06f52b6a4 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -20,15 +20,13 @@
  */
 void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long bytes =3D 0, sbytes =3D 0, slack =3D 0, size;
-       =20
-	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
=20
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
 		bytes +=3D kobjsize(vma);
=20
 		region =3D vma->vm_region;
@@ -82,15 +80,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
=20
 unsigned long task_vsize(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
-	struct rb_node *p;
 	unsigned long vsize =3D 0;
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma)
 		vsize +=3D vma->vm_end - vma->vm_start;
-	}
 	mmap_read_unlock(mm);
 	return vsize;
 }
@@ -99,14 +95,13 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long size =3D kobjsize(mm);
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma) {
 		size +=3D kobjsize(vma);
 		region =3D vma->vm_region;
 		if (region) {
@@ -190,17 +185,19 @@ static int nommu_vma_show(struct seq_file *m, struct =
vm_area_struct *vma)
  */
 static int show_map(struct seq_file *m, void *_p)
 {
-	struct rb_node *p =3D _p;
-
-	return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
+	return nommu_vma_show(m, _p);
 }
=20
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mm_struct *mm;
-	struct rb_node *p;
-	loff_t n =3D *pos;
+	struct vm_area_struct *vma;
+	unsigned long addr =3D *pos;
+
+	/* See m_next(). Zero at the start or after lseek. */
+	if (addr =3D=3D -1UL)
+		return NULL;
=20
 	/* pin the task and mm whilst we play with them */
 	priv->task =3D get_proc_task(priv->inode);
@@ -216,10 +213,10 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
=20
-	/* start from the Nth VMA */
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p))
-		if (n-- =3D=3D 0)
-			return p;
+	/* start the next element from addr */
+	vma =3D find_vma(mm, addr);
+	if (vma)
+		return vma;
=20
 	mmap_read_unlock(mm);
 	mmput(mm);
@@ -242,10 +239,10 @@ static void m_stop(struct seq_file *m, void *_vml)
=20
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
 {
-	struct rb_node *p =3D _p;
+	struct vm_area_struct *vma =3D _p;
=20
-	(*pos)++;
-	return p ? rb_next(p) : NULL;
+	*pos =3D vma->vm_end;
+	return find_vma(vma->vm_mm, vma->vm_end);
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
--=20
2.34.1
