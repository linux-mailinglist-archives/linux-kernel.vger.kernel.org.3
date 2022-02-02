Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668BB4A6A49
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbiBBCqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59790 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244424AbiBBCnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:43 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120HSex004746;
        Wed, 2 Feb 2022 02:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=S9sx78mDXYGOny54fgInGD+W19FanNb5myqWQM+kJ2Q=;
 b=l/2X8l/a12cMvk6hrC3R7gQiCM87siPuH9cXgC/TkQJueB4kE4I766BsEkkIZNVd7bqX
 uBIObydSUvPFSgws8u3lZiGZlxpaGyqnJyflsdXTZmkQwQOXjj77rZELoR+pXXTfF87U
 FQCCvPTg9A40YAr3CeRhiMO/eetDLSGAA/ZeK22JmIUCvgU/d4tg4ZGB8VPls47GqNss
 3U5n33hMbD/R6za6c8m6kyQ3PMChhZaaXH4h6VMus/dvlIfM3Ua6SP0H9wvPbC0WlTsz
 Sn54qgwmtakwm41ffmGgn9Y1Nqsp4Fo/oLGgF6VtcSJvzYx0m7rgGIbIBOW7RLJEGDVD HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac4qfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPVb146749;
        Wed, 2 Feb 2022 02:43:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3020.oracle.com with ESMTP id 3dvwd78wmn-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9iWdK0sHuEIPr6v3BRipWinrWo6Z1cxNyOqlOTPnhzsFrJ9xnZi9LxGzVbxrz2wF9M/Tssa0J00F3YmqMpP+tp89scAs3Aa5xAxMXbktB0UgUzJi0oig1v3ZWQP2DaXNj11K3sZh5sHL7zXc+50woH+tJyH8BeN7ljOzFP5uSQLlQ0jR3Re+7Od8BnguSHe2frzElVpr0g8NXVDFmsQJxqbQZo2GQMIiXXM+cFHmr0ubJyRLF1COE1+iXzt5yFIMfoeHeCwX2hPiNJ8GyL/xgqpwwX7tn9NWsn3DvOr7B+gdS0dHVji55SOnz4KbU3wXcE6SDZOl0xoLhOhjNmGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9sx78mDXYGOny54fgInGD+W19FanNb5myqWQM+kJ2Q=;
 b=RGVWL/ZUmlAPlqPwnKGigJK3xp7HMXgFSmQxKwiKUlEOLVhVFHRgCvUvzNunhvpEBnC2sdnu5d409Zw2zN72NeZjGHz/zoWtyHx38QhKADgKIbO8cx8UN11zJGYH5Op09NC3fEYqFOVoGtvmEY5rs2gdal4EpMTDJxI48efBLXC8/aU7QGfpf8ct/Op89i8jsvwTnx5kDuwJNL5Lf6Bm/t1BCazoTmpzXRQzM9wpbQ+usFDloTWEnBxF49BDwui3n0wCVBAMPv/Xlr2zIJoryK/h0VZXKGme3a6Uk1BeAiv3Wv3HUQgKUgUTIln/PmPRFNWd47K0G5ExsUg/AhfEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9sx78mDXYGOny54fgInGD+W19FanNb5myqWQM+kJ2Q=;
 b=sOgj0DrRkECzqgca3GkqD8/DfmkpLHH9hKqKfFzLPT5lHNc9dyoxoO4pB0mLRt26HMcNx988MPfxFq5Ie1sOOBW2iVkfyQJa5FGa+NJvmdQmXJmS5Nip2MOQJ0npKbAjhValo2LraQRCsyNmkrVv0pur1DXf41B7TS4JfjC+Osk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:43:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:43:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 66/70] nommu: Remove uses of VMA linked list
Thread-Topic: [PATCH v5 66/70] nommu: Remove uses of VMA linked list
Thread-Index: AQHYF96CTPC89n80G0WNMnFUJKcKDQ==
Date:   Wed, 2 Feb 2022 02:42:25 +0000
Message-ID: <20220202024137.2516438-67-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 412453ca-c189-4a64-194f-08d9e5f5cbfc
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5865691157C3DCCDB5061535FD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fAL3/mrAliGRIR5RXqk1qmlznO9C1QYPk3RC0olYSnCRk2rpRa3XWtUC4nXfvotsY+aLFgYEv5mG9L4TnEbVSS/jIMYoajk3hWB1BGroWO5Axej0Aob84PXrfM+cYYZzNYGNGpOBW9gGPrKBj3PefRTvHYYYmDu/mKhF2aM8VdxDZppQGLJxA1kbxLaM3tXDcixJL1sU2g1t/isIf8SSl9yELOFPnB8KfrrNJhF0ppBHMekpc9kzqf4nOpcZlnEHovlhTGFCJH2zQrKMqzF9G5stXh54eHY45wC6hgcmUtClgGrARiMtBA4mtI6PNYCZWpm7e/v8I5JXZ3wlGsSlYTg+M5q4WoySbY1z8fru2i5bRVUXQvzMyTVmNSaIEPS+T82Z/fNghos7AIcUp2wlXoqFnUYJqdhuyueyQqFXtibd6zEi5xGpAq2jL74e8fBr4JITaF0ZHJo3+64uieJEAfQLvELz94UxP6ALzKGqF2Q4vIrHCqFDh9LrOkb6hJFK6hidNoAYQkhmF9+crpIO11EAyxK4mD9MzlPw+Q25md/IUJQEv0AkrBahc4gDDJ57U6Sxr8JJw4RpPG8igM2+d/EnyorUPPga2xGawmjI+i6zPf1HsT7cpjYDNbDbuaCoXqHLx89eamWjeXzlEIpfp/mAJxNvQtEC+li7On89WTqMnh1yRykyxIK/+Z9zX9REciTiylQgZZSmwdH/RHyRTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k9ceabE1NsYjnJNNVtHjGy+nLzg7DNDkIn8i7Jx0xIoTLLmqZX0JpC463p?=
 =?iso-8859-1?Q?q7JF9UYRBloBg+F7jjrcr6v4Zr9PpHI/w5YTPGY7XFNOAbRHwzlWlwxgzZ?=
 =?iso-8859-1?Q?3tk0tbZEMQTv1gfI0j7GN5INCLeEfw+eI27lBJiK+drm4rKlOUm0eXDv5O?=
 =?iso-8859-1?Q?ZpdGwoP03nF03bv6rjDb++YEuT+h0rMt9N6iPdMPwOIsxr9T1cOSOp9bMg?=
 =?iso-8859-1?Q?7nmzD+yOCp6YkXbTnR6c8xVss9xJZYzoyLdPvKeaxDWcmHb0vD5oP5f5C7?=
 =?iso-8859-1?Q?96qS+sFFkXkmsEK18O4rc5CSAajPVJiYZq1lT9UEeT85e9v9+o2NFKGGgu?=
 =?iso-8859-1?Q?WpNVJtFG1QoqkAOG7KyoTp89Vna8KCYbhw06M7SghLoZ13XEsTQQHEz5As?=
 =?iso-8859-1?Q?oaC/tO6aCCB6e4iaGEBduF0CA/FyCfJxSI0zf36iNebXqOa11itU1UudFI?=
 =?iso-8859-1?Q?ID9n915l9mov/2Tb3Xq2Dxl/K1GcjH3LDhVdkMHnmbaOWsuLp0hQpiKzjE?=
 =?iso-8859-1?Q?Rh5elH2l615WgcVSS8Lh0lLmMSigHA0xOxn9dRsNEnw4sWLHKAf/bOdwwF?=
 =?iso-8859-1?Q?K1u+LioZtHFIRDCd/3jcvZfAebSp1R/GhzvQGACvPRbnPH8CwAAMTfiHkH?=
 =?iso-8859-1?Q?Ynyu5gXUY+zwwc+nMpvik9kCt1wYey9CyhPr7Aph3mQ4zaDy7sN5RuyGw3?=
 =?iso-8859-1?Q?88Qq6cWPdLEY2bDRJEctYf/W/D946pPnv9YH5MqpzmlozLgM5X3rAMLywW?=
 =?iso-8859-1?Q?9D3ZZjbNpKS61LJy5weuDhTCLMtOpB0t+8WEJy0gGa1n2nA3xnXsN5PI9u?=
 =?iso-8859-1?Q?NNTPBApPrF/xWYwGpOCbgkeieBDT3vaZoTDE70pWiyBzPJ5fsviSQ3Pobu?=
 =?iso-8859-1?Q?Wj6zxy8lzaoietqsZxi6YsUG1etODs0zE490sEntT4/Ae1Kv0OGuUXyuHs?=
 =?iso-8859-1?Q?9aksXUxE65Czhrhb9grHipb0eAmRxXkuA71ae3NA+8exvprXZ5CjJqPU8Z?=
 =?iso-8859-1?Q?Bk8GX9TkNBabv6XM1LFtkmNx2bv920o9EGyfJ31OzqngD9NUi14I7OU8i2?=
 =?iso-8859-1?Q?l+oO7nWPy6Kl3hqhI+HJLTUfNaSuyGhBr+mltDGNRjwKP3Z7uaHTZS/Slh?=
 =?iso-8859-1?Q?mUeVOwpkYVRDOG9we1VG0Z6/rm8gATXI1CKoPYaugELnFk4upy6iniYTSE?=
 =?iso-8859-1?Q?cRhMAktdJsxbolkiCAdbfgRFKCsHn4KrearP2g16M6XETi2z2o9h5Y9awI?=
 =?iso-8859-1?Q?pxLYR6jufNLR+LUK/25eADT4gk8y5jzJHFk311a9JK6c2Dfu0WPZ67ULwA?=
 =?iso-8859-1?Q?UFjDbM2nBgC7UGNYHmrezv/BNGLPNSjw6F8oHXXlgngFKBeuwKv+0MEy8b?=
 =?iso-8859-1?Q?PjPnzj1RZo7WD+Kak3JTU4XWXKD3uNYVJlWIXVfTOQHxzlwLxRQ4tCRxUs?=
 =?iso-8859-1?Q?R+Dnf47+fh4kZnvRZSCMtkpxazf4aHGw3d1byHHf/jO4uSbG7TdU77oBIB?=
 =?iso-8859-1?Q?oF9DJvklJHfEhjft4t6eqveu7RyUBARJWFf4yKfDs5+hY1baIowo6cUVxB?=
 =?iso-8859-1?Q?7eOOVK2rEJ7y6+XxQr6+SZR8bkBozn4VT2SZjDGjMwyGbChShABRRVKtUk?=
 =?iso-8859-1?Q?dVt7Cpysb2e9RbncokiOABygtbvvnKwPD4Ky7L3qWCFNtYPouOS3ex5a6W?=
 =?iso-8859-1?Q?q+3qz0m9vjK1u9VvCOg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412453ca-c189-4a64-194f-08d9e5f5cbfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:25.2505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RA74gUsKErNzsDM215qr09DO8/WLZFO0UwNbIAAcaY95bYVJmkRTY2I6lw1ioQEtNfs0qSW2Slxf4oI7eTQI9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: gdr0bDCHy6YO35cK-8tiuCHRHU2hxkoi
X-Proofpoint-ORIG-GUID: gdr0bDCHy6YO35cK-8tiuCHRHU2hxkoi
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
