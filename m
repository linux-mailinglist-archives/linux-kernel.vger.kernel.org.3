Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABB04B6F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiBOOo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:44:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbiBOOnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52588104A75
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FCMtvW024375;
        Tue, 15 Feb 2022 14:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+eFsOuyYhMWOhXVOvSHI0DFG+egjiko361qSV6as5lw=;
 b=KzWoPp0nmiFOK0gV6A69aG3HPVa/j5y6a8GE5qW/WoRF2I9ozVoLWr1j66QKP7YRMoiw
 KLM1Zy0fSyaHS8Fe87RUAal1KWJD4itjmuHpu+KnxAAN1IY5y25qnQLMb07hxCXDmejC
 PLllKBsED3ye+4o6rIEZDJNcvrnLaj5Daw77v9gEGMQfLEs/hS8vQUIHQz+wLwQRB+Zy
 iOMZEUiI62M30NuMar/ejP8bMXvUnRWbpCEoVDcKHIcrSkw8sCbNmvMo80jrPd49dEaF
 uYFIqyb228PNuT48Ee6edKHl5k2mCdPpuqcHQTF9UrlvFuQ3RjQ1LC+BBwsD6qltkBuA ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psarb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeUFk145877;
        Tue, 15 Feb 2022 14:43:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 3e62xeqejm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuOIBjD+jV+LAv16LNAfWzfsfUa9XrQB5stFXKDPYyOik3MfSlZa6maDcW1aZ83kK9qCnC5lRmZac6AUkM8sbIz4J+nn4JRYRCl9TFgZBzQfapdok/geQboKybtrGBn9/8Ox5qzIEWq10lW2zimElm8xTD5Nb4xoeAnMOTli8avh/P3YuC5qHl5PovgVWrnuDCAbe3ZoZ6SH1YubfCWqPVdE+MhGAUanb8WFIoSDiz7XYrgA+RyAlqmyHl9QjV69Yx4NF54mLIfLC2t2nJViNMgzsmy9IM+ed6jJ54EprLmdHvSvKuvSoQYK6YSndBIIpbdgKlVg1uaT8eH247IC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eFsOuyYhMWOhXVOvSHI0DFG+egjiko361qSV6as5lw=;
 b=fyEmc4C0lh8A6wjGlmo0ETEPJANjbCpU7EoCeFR6IRseMRCkPf/Cw/wYVvC0s8XZ3o1I+vBravo2POSwArHEG58ibPQJg6QhmK+grM/F7kSl/O6BLC3HxCsxwo7XB9o0CdSkD1bVYZzh3DvShZBA3DVv7KuwXsYed2MTYm/Vo2G9gAJ4KmQkQ525T55VtVuDoHOKqpsZLvEKAxY5hBoPOSO/mZXLjxcYtKG23wMfnYKfY5/NlsyioyBtLPyXsJ+6MrrXuRVDXLcZ+xomXqw9WGYdvEgh5jstFYzlmGGLgBN/Z71ssFVokr+NBK3v63HsVkzBWujHcb5kHJagX65irQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eFsOuyYhMWOhXVOvSHI0DFG+egjiko361qSV6as5lw=;
 b=F4JFUS2DjdO7eVzyGahKNZo50pyrJz8Z/68Dfam8vLiXR2jcPzeC0VcDaO78wuFxKg2JDI9r8004b127Cxfp2TEh5Y8i2YIIACksG3h9aqsJO5cKp5Gdy9boq4VX9FpSIq/+DG6olcz/ExeW/ny18w/ItF5cztfJUQarxTgLyC0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 20/71] mmap: Change zeroing of maple tree in __vma_adjust()
Thread-Topic: [PATCH v6 20/71] mmap: Change zeroing of maple tree in
 __vma_adjust()
Thread-Index: AQHYInpZvAYgZq5xT0mioApqwST95g==
Date:   Tue, 15 Feb 2022 14:43:09 +0000
Message-ID: <20220215144241.3812052-20-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ce28e58-0b0c-49d8-66e1-08d9f0917f7d
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4689061A15A6673130AAF52EFD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7icbt8AAewgEVMnm41+FnBEwiQ5HArvlP4mbfgLobdYdfs/DiF+sICKqghHwlmwZgKnvX7QrS7ac4wvR4HLPItzRIrV0WFQ6Od9XOQUW6blFSAgIuK1w6Z1FiZG6ZRfXR/awj6XoxlqyI6dz66hvMr+g0RONKMuEYRjSnWy2YrFlIOnSuXcdY01RUWAIU7ySXj/b/nWxU0ApkoHxp0k6YDadQeFcqGWFPWUfrRRf18lNw+nfhTvXk1BMpVlNpIYxx5eBJTqrtW6Lhd0Lb+geRKe7dYASzY4qjx+n3HWRexIq+EfiXBHgzJfxvDt3mCMvVHItlivj4mnY8e0KfuJRw9ArzDuESLlVKj5XaPkNomiKr/W7IitN0rCAsE4yd7iKAX+xQC8oOrvHxds52mU/tAB5aQfgVQSBDuZx/JLkHKbU0N2Z+tKclvkn0zj3gw7C1Nots+En0T1psV6feCbYLi4waDWwJGN20RUFJjpUPH5LkD8GMVIn1xKmZl/SUhruc+ZDjhzvAlWMZ7LO8MZzGG5dowF7eWqsW0adTYJmcWCh4nqgJwTiaqfy7sG7SnkRm/iDdnoM9RVvcVa6KCeRkXAjm5Xi1wGEpCzUkeUVDWmp0aVPD89aJ2tmHx2WSWBsyTWv5xfooUq7lUg2BEu5h6iDU1Jt1Rht625YvPhJyYtT8g8QhFQcvj86HBG7mtt9wbqnqUsYFlh3o9oaqUb2mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y1pbIeExnUIgY8+mhtgTuYUsHqCXcB3vieCPnYjOyHUr+KDGE6jcWtLe8g?=
 =?iso-8859-1?Q?cXRBfjVu2tEYU0g7Z/DYScOsnGoag6iL8Aiz9LKh2XD7AKrrRdsVoyGfW5?=
 =?iso-8859-1?Q?Gd1AVnt8cetezEItAemH4kYOKj/AQxhUwYhCqCp7vnH25aZ7El9j6QWDs5?=
 =?iso-8859-1?Q?Yzpcz/miEjaUQpWDNAD2y2Gu1h8mrPGwaQ+9Zp9Q92CljAtxuj5YxAH8ta?=
 =?iso-8859-1?Q?hTWZUndui0YwsPzC6Os7s5aXTbg7EDmjxVutL+g/oXxXolnTdNmL7wsS43?=
 =?iso-8859-1?Q?CMEmvGdn01K+y62NWNnAZ5+rAjyH61ghQ5TboD1f8qoKgl2ggLDnvIsR0E?=
 =?iso-8859-1?Q?FVsqB/czxp9Uny+udYemNP6zSvBPvFk8tERxWn4wDICkkPwTajCuyfzrHh?=
 =?iso-8859-1?Q?HSSt51AbLuCTTsmXIhd8AFansd6b3JE6pb++udT9EJ5bgWWErKvR6uUI2D?=
 =?iso-8859-1?Q?XYuPg/QfzxP1E9yAIDYR64WVZ5I+QeF2l5EQrZaYvgYG+0cuRalQ2OylWC?=
 =?iso-8859-1?Q?KZgXnkfxSxMpWUcCD4n+0NgbdrCNWUHMIdw/+n2idCPv26H+1f+U6RvJbS?=
 =?iso-8859-1?Q?ekGjzEnYhctZKpupBUEbZzLMAFVqpQSTT4+5xoAghQGhxtzOIHgzSLYUu9?=
 =?iso-8859-1?Q?2UHtv80fnQr5EHcFEbHHAN/Opxf/H/1i8QgsVOx4j06cui8UmU4z7/sJY6?=
 =?iso-8859-1?Q?EARfF+rfFTvD2TFnIjJd0qgXtOIR8VlEynfxBSG0/WMUA9PPk/c7KIAmv2?=
 =?iso-8859-1?Q?8ZCNqncq1ZJTDVHP5TFsvkrkkop/JfRXfz+HR9+W7AvbimAVPx0etP5j4T?=
 =?iso-8859-1?Q?2MeIPQY3vvJh2GeNtIK2rGe8pAw1WOE/ANiwQCc/ezkCfn/te+Dh3krHSc?=
 =?iso-8859-1?Q?ThbNPcNfyIBz7PImFOdi287yqEKVUYycle4VXmXmvbEYyji1jcGhRpY4fe?=
 =?iso-8859-1?Q?liW5MiD3hBfUAbxFIiSmW7yefSD4NndKUmaL9lbN8UkZsWIZoon3vC2ipx?=
 =?iso-8859-1?Q?E+P2KNw8T9djFjJq0FE+5fihlccNykoMDuuxbaePglpqg8Wxfaomv85gmZ?=
 =?iso-8859-1?Q?oSGyRfkKKQoAt6nDACYUDNOI73dJFilB3fLy90876qaxXItU79QkPrBL82?=
 =?iso-8859-1?Q?2+WN4SwDR7gwlXV9kfwTZcyoMA1R9U8mjkkxYM18diUx5SdWuL27Bk/OP4?=
 =?iso-8859-1?Q?5DlLxoDhy2yNXgxVmA4BInAcG1SU35Q4qMYFn3cDQhoCcBsD+etxT2kcha?=
 =?iso-8859-1?Q?obS9PnCbP3V15iDKO7M760sgJX/OXFbRsL2G4flCkJswaE1ypTcTo//a5d?=
 =?iso-8859-1?Q?aQBCh1XdNa7ZRwGZJUbKE4wT/WuaoNiYJRROsxu1ak1b6c4Z+SI2byN/aK?=
 =?iso-8859-1?Q?XUkBzTfK7b4QkMU7PSHMoQn5s3cj0voou/qp/B11zScl7PK+OkYH93HqnN?=
 =?iso-8859-1?Q?TO6vVDl2gLyNyGbr8fTrvsRcWClUIsUBxqTskByKvKTeOwpvSrX0HbOgF0?=
 =?iso-8859-1?Q?OqDzADtSZJ08GTbrFEMEmiJ5QQCb36XVxjLtf/9n0um+DDyCt2QMJJ2rTe?=
 =?iso-8859-1?Q?rJq+tLrDYelntpsrVDXgapNH8ZxjcWB8ECtzkPR9lIcpiPJ/sLwkmiKl8T?=
 =?iso-8859-1?Q?dlcI3jGuWmW5vSWYdrS0GmJXZTqgBbTJCoq6R18H4fWeZGWaoYklP6prd1?=
 =?iso-8859-1?Q?FlTOVsR+lyGyvQjj+lI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce28e58-0b0c-49d8-66e1-08d9f0917f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:09.6519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lBpJGfOeURklHyD6RwDJsFYERAh7BL2AX9sBEiRE2vKC4fLW+jBaPKn+fU0mJ205v9kmDFGpBv69O7yaLgqsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: vLWCjfATu72lHCMV2edJhNi62ENBj191
X-Proofpoint-ORIG-GUID: vLWCjfATu72lHCMV2edJhNi62ENBj191
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only write to the maple tree if we are not inserting or the insert isn't
going to overwrite the area to clear.  This avoids spanning writes and
node coealescing when unnecessary.

The change requires a custom search for the linked list addition to find
the correct VMA for the prev link.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 14d7d69d554d..0388dd11d39c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -582,10 +582,11 @@ static void vma_link(struct mm_struct *mm, struct vm_=
area_struct *vma,
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
  * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
-static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
+static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma,
+			       unsigned long location)
 {
 	struct vm_area_struct *prev;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
+	MA_STATE(mas, &mm->mm_mt, location, location);
=20
 	prev =3D mas_prev(&mas, 0);
 	vma_store(mm, vma);
@@ -613,6 +614,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
+	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
@@ -739,17 +741,27 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start)
+		if ((vma->vm_start < start) &&
+		    (!insert || (insert->vm_end !=3D start))) {
 			vma_mt_szero(mm, vma->vm_start, start);
-		else
+			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		} else {
 			vma_changed =3D true;
+		}
 		vma->vm_start =3D start;
 	}
 	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end)
-			vma_mt_szero(mm, end, vma->vm_end);
-		else
+		if (vma->vm_end > end) {
+			if (!insert || (insert->vm_start !=3D end)) {
+				vma_mt_szero(mm, end, vma->vm_end);
+				VM_WARN_ON(insert &&
+					   insert->vm_end < vma->vm_end);
+			} else if (insert->vm_start =3D=3D end) {
+				ll_prev =3D vma->vm_end;
+			}
+		} else {
 			vma_changed =3D true;
+		}
 		vma->vm_end =3D end;
 		if (!next)
 			mm->highest_vm_end =3D vm_end_gap(vma);
@@ -784,7 +796,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, insert);
+		__insert_vm_struct(mm, insert, ll_prev);
 	}
=20
 	if (anon_vma) {
--=20
2.34.1
