Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC884B72B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiBOOsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbiBOOqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED37D11943F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:43 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhhOP030895;
        Tue, 15 Feb 2022 14:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=S9sx78mDXYGOny54fgInGD+W19FanNb5myqWQM+kJ2Q=;
 b=YKZkNZ/GGtzTVPe23DX3u61YZSo9Ocj3zlpjntjUjqGyVxE7CVfJoMk3MiISKRnIPU1d
 BnMPGMNpSH+TBI7OFKMG6JxirTeIQqCdC3m+segIH6ek5/kONQvSJFmj+0FCVgs5cnBL
 +7DuXdn1ghq60PunbzoukDdyreR4JkbATz7WUZgD02kALAnS6pwMRQzTm28nkhRRFtSj
 uGlSPDgLt1aVzedzOPnJ+/6JB5fmCMMSiru0Gjni4ap9CZ3xSpavMqeSS3A9kdFNAPZc
 6VZ6wi47kxEk6SoGoEeyU6UF4EcRWGZ5VWzhj2RozoguXNMLE6/tEbqYWLAVHH21iEky 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psavf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEe5VF157068;
        Tue, 15 Feb 2022 14:44:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3e6qkya227-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5rEEgu/qhNp+/vD7AZXQa+Ky7yl6MLPz/bmuz9veIDev2hvAm54NGvGa7/ehEuMwghWAViMQubMnnaZIvMreTRmNkM+VByNRSPiVAbpOZ7Q/B5b4osCQkEH/UFVp2Io92GawnhbhNMtnDlnHtW8sfTuSa+pqO7f3ffuWFptIffddvaME7kq1dU4+mkk1bTVgnKbejsHY+c0HRInI8s+b6Sjkkw1Rf4I2c+XXW9ktn1oJT0MKizHMModEh3ATIpjQe5ZAlTTIrVKzV1wzj6u0S85eX6Imdlzf3VU0pXLJlii/8oW7sXCVO/PpiKI+DGEBTIUFLFPKDOCLtW/Rkf+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9sx78mDXYGOny54fgInGD+W19FanNb5myqWQM+kJ2Q=;
 b=fW8bAJJQdQ44oLVlL9YgC3uzAyIMdOQHBr38Ph8CWuvLEAiouza36ZFYtXOwARFOWWCOMXBhvfLS3wC0FJ8qJMb9iYsLDLnC32cY6rkoJajOass1ye6r8vryR5aFfuA+TVGeALGl5JCHoCk9i+/q0pmWiGTL9lPlqnH7p1s24iGMBeUIpB4g8pI59nchXuxpTQZfHy+UbHajpKLIiCKLCTtEgrgYXbrZfpBkCYatNpxXJA0At7dyYfHyz+YSJ3pu10SHTw7fXTFRSKtZAAtaGf+whZiUq8BC4VPFT8Cu6/aX466XDtRG+XZ+5NNKbygznQUj70Hb3/LVA+tQfMG+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9sx78mDXYGOny54fgInGD+W19FanNb5myqWQM+kJ2Q=;
 b=TOARlrRVXwjTkjlDiCv0UfPNmxyvkbkIKbqN5tjxIasrk0E4bCPvnK5MOArgkkD7HuHUK9iBg8QcPVcDoaEmyh+NKkf4YguW84E1nlqaOMnvP99Kw59i/E4obkYcoOJpHBYFapx0E01ou3n8OcbnbrAhmLwP4T4itVlwiSwEVnI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 67/71] nommu: Remove uses of VMA linked list
Thread-Topic: [PATCH v6 67/71] nommu: Remove uses of VMA linked list
Thread-Index: AQHYInpktlRN/HWfpU+y2YZ2fdyOxg==
Date:   Tue, 15 Feb 2022 14:43:28 +0000
Message-ID: <20220215144241.3812052-67-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be8f78e6-4a4b-4b1b-7ab6-08d9f091aff1
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1863675E529E2D2A80662806FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bG+mZAVAo0kCALiWVzHRUrYUuFJtCPHtoV4DSEQI7E+SuP7AGn8aTZ9cjvAKg8tudUpcQ86L9wEgBeaBTW5r9EvGnz2Z3OaAIcfgODhzPmb+rRhDbmEbDJrLf64RZUszOcZdjkrPMCZXsdwoHiB2Nx42XrtNiusYhG7eWNdBTDyXyCecGI69q8LbWaGVw0JTx3gT1CckQE+FeTYoaLKOQIDXhOph5SfLXdYM7v8vUJITYMH7xCdYXDlO/GDep7cJy67VCtkFrWfeOcMUHW3q4okrFX5b7OudCDxOgzPJjKN28uCjENl+rfEr2iKouHXXvktEht8LewCD2VV/oGDpyV6r6HCxZ4DAFVXfZTDyfA8YJB2ijOX4Dov19fXfiK2o0NjXlYnrQQ/upUGxtksgbsnEBfYeDefWzkZdGk6kdia0eGey8131KuaC46ajrykqD+J7icM/mAUfHKkA80KeqWJ12k0hwiWoi+ez3t6oMkFX/LfFo4J/+n/z79iBycphFK9ta1YWXHSbttZCtCq/4ykW5QaJ6uFlQI+sJBsPf5wOmlB1x8UOxS+8UXuXt5PtJb6QEdIhnJfgUA0FaKiH94DvSgPJY4XV+V7jwtnu3XK4JjJUAVKKtA06R2N/m9g7J13b6bSFrvbGQCfJn8JodLK5z9z0+6XPlrZKGG1ZtgvXBHqCCobPGlWoLo7o1a0d6C0HVK8epAp+IumFmRtp4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uuzB6TVP5XBjDRIf5y/fL0u2o+OuVm68oKuz69LIYO4safzWJEUH0IQ5dV?=
 =?iso-8859-1?Q?4W9eDAbVsCmX4sZ2n1l625Ep0+OyuZ0/cc2bwPdDLWRCDXyVFSga0JNDR8?=
 =?iso-8859-1?Q?0WS4AUpkq2Q2zGLGCTLlclhSCVJ6vhwQ5nOUpi8+N3aFUnXXcsZWj8f0DG?=
 =?iso-8859-1?Q?YMYfZMiih4GvmvfggY2v9PnPFDxsjsYylivjlrhl+5J5qkNno2mbJIA0n+?=
 =?iso-8859-1?Q?SKH6XK7J8UsjU9sjDyYAjvVufcYfrAOQX1ZAeXqx2LxC9R10n35TdceNIi?=
 =?iso-8859-1?Q?Ogdu0zSd9XxOMU1eb7iPWt/2bEiyyZkvG0q3Z8kvrmnptOuYRUsnEcBwMh?=
 =?iso-8859-1?Q?dzdnDAKHJuOEvnN12y5LOqwlX0yDFsBMYW1wVTQoF/FTTuH3BKcoP8yThJ?=
 =?iso-8859-1?Q?LjquV7sCjZ+tLM76LNxn8FXREGbdMND5exQyeWTDhBw19Drb/HQxgLk/RU?=
 =?iso-8859-1?Q?1ZoqcUE0C+vNhjrr/EglYGimvR4rTk0CxiDR6el8cK7LqUkMgIbgge5shk?=
 =?iso-8859-1?Q?X1Bajbg0e4fkpT+PF7L1sUaGm+gfTo2Jda0c5968aY0ankJSFRfPGWNoCt?=
 =?iso-8859-1?Q?XBN9dY8jgpfQCPhH9lLm3L5fhNBafB8Aax6olhyP/ynWmyHhJT6y1NmRlV?=
 =?iso-8859-1?Q?6dVC9bplHnpXLxCGh3ndNExanjgB0VYxHr5tnbLkVg0mxGLrFW2BOr17cW?=
 =?iso-8859-1?Q?xl956Lpy1pyyc6bfuc93c9yX6aLVMX9tccRXi5hWWmkAzVb/ZbpFW7rSd4?=
 =?iso-8859-1?Q?5vRBMkqpuWcoUOaFFKLn1YAmf79g0ed6K189Wbpt7sEi1wRo1qJeZVzG4i?=
 =?iso-8859-1?Q?hY6HyAw6j9KV3FjbtvhChIGYIWXdsxwmGaBCVkTGVEeHYFHfsM24bPQEao?=
 =?iso-8859-1?Q?d1OF5exKTJxiCFfSv2YTNXU4w4kDo3+vjbn4fOT0Zo7RE0nD+uySYAg9G6?=
 =?iso-8859-1?Q?KZfE+DrhCDyGmP1vfyZN9pqUYjQ/MHhNQUDqyOuw+sabMGugpsf4Jy0Mix?=
 =?iso-8859-1?Q?B94j1Hqw9Hw49qYmcMECQ8z5V+ZXw9c7X14reyXkkYq1oCtJEfy14z+5P1?=
 =?iso-8859-1?Q?Vk2pEEkQ5o4uqDhBexopfVwxEmTcgWIDH/TuK5LTV3o1TuIgqxtotCtnje?=
 =?iso-8859-1?Q?JYHClyY7iNH3D+8Ur3YdDX9EvEtrzjI4Ri9u/Sx7WLsaq4Q1Yuos5vGYS8?=
 =?iso-8859-1?Q?5oqfhMP29y+vTztM9YfMEnIBQ5OydDPALWOFkuTQ6szcWqjTmZR76TA66q?=
 =?iso-8859-1?Q?tvdNV24mVJmkPO2W09abkIkpKel4hh+3Qib3e+SfTxzQDsocbfIUgPUjdM?=
 =?iso-8859-1?Q?7TUfwb1Fyo+PwZ+eAuaY0bLfb0+zKQf8S1MBjII9GTp7TtY0DeSrY9UBdx?=
 =?iso-8859-1?Q?356OYeutizXJasrnB7EELLSIxAYxgaWgiQQYbIGYIEkaoaBQRtNrP7Xo5U?=
 =?iso-8859-1?Q?6j04sbhyLU3d2HhF58Ixxu5SfU7ujkpb7+cAFH/5OBPDqBIK3SyAgN0vqO?=
 =?iso-8859-1?Q?5Dm2rGInZ5/ZtRt+i3f5hNIhFd7i5lxoQ0QxGGWQWri9asGNIV3RBw7BWy?=
 =?iso-8859-1?Q?RelRioZ/t+bZcYMS0d1EHj6aWA2HPVJaMkEUJdY4OLoWwmDGIssgTLja8e?=
 =?iso-8859-1?Q?BaR/OkLW0mgJduXf9Gn3Eqiz97QACJN7hkRf4dsVGgMOIbWOYBFmkfxM1I?=
 =?iso-8859-1?Q?bvFB6V+YjYBt1guMHrg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8f78e6-4a4b-4b1b-7ab6-08d9f091aff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:28.0882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p10SdSjWpKl32+lFe5eUSD71i3cS5aJqs7ShoO9D3xombnl80GlvUwIIjRIku+0A0p0iZ040Bv3IF+JsD+pzLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: XHdk_yjXtJkz_P51RT4UB7HeDXFsSQMO
X-Proofpoint-ORIG-GUID: XHdk_yjXtJkz_P51RT4UB7HeDXFsSQMO
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

Use the maple tree or VMA iterator instead.  This is faster and will
allow us to shrink the VMA.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/nommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index f500c57a59f3..13028f93dfd9 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1370,6 +1370,7 @@ static int shrink_vma(struct mm_struct *mm,
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struc=
t list_head *uf)
 {
+	MA_STATE(mas, &mm->mm_mt, start, start);
 	struct vm_area_struct *vma;
 	unsigned long end;
 	int ret;
@@ -1381,7 +1382,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	end =3D start + len;
=20
 	/* find the first potentially overlapping VMA */
-	vma =3D find_vma(mm, start);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1400,7 +1401,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D mas_next(&mas, end - 1);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1449,6 +1450,7 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, =
len)
  */
 void exit_mmap(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	if (!mm)
@@ -1456,12 +1458,17 @@ void exit_mmap(struct mm_struct *mm)
=20
 	mm->total_vm =3D 0;
=20
-	while ((vma =3D mm->mmap)) {
-		mm->mmap =3D vma->vm_next;
+	/*
+	 * Lock the mm to avoid assert complaining even though this is the only
+	 * user of the mm
+	 */
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
 		delete_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
 	}
+	mmap_write_unlock(mm);
 	__mt_destroy(&mm->mm_mt);
 }
=20
--=20
2.34.1
