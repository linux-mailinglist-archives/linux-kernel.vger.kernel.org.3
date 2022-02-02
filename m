Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCFA4A6A4C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbiBBCrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:47:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16448 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244411AbiBBCnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:40 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Mghb026641;
        Wed, 2 Feb 2022 02:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EtFQih9WHTZJCiDj/1qdlcL9IV1NbnnAROwE/wgF5IU=;
 b=MuycpqHwfZIj8UFriFK1rzMoCEZtJyGTjtssD1lnwpzCK26zMVh3QTMbrWo0EhFLKsVF
 QjzlYsRFgiH697qG1rd1tjgeTMnXnvJBKnmIWx3DZg3ssjrjIwLZGeGOwkPttTE2OFB+
 erBi1Z4zPUKRTpmZMrlZL+nNqaqMP3izSjRQmdGABvMHvFoTJDuH0tTKVt6K7nfVrY4+
 4AyY5KH4hWPV87qYqPJKux3GVQqS9Up+pvDqLvLuKYS/69/74RMRPIQAfwtvmBa4OUvO
 yAnNauXRgRb2hyGBYqp8MLxtPicucIn85fkyQjBzVumwm+DL9b2MV48W8GJdeW0wWkBY Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcu2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPVa146749;
        Wed, 2 Feb 2022 02:43:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3020.oracle.com with ESMTP id 3dvwd78wmn-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jN9HoxTY9kB3WgorSeiF6sDNEVO+2Ium3cGaQl5pMSZMfyoXfpAwFuzSeo/wb9zQxgJHXb0BZ/SCCnhBRcxVchWHRzp/HpNLS8xd6MCjJ1qkTORS819SaMWpOM7unFfdOZnNaUpryIZ+b4ZfUbGszXPRc/vn8qNTQG3TltmHsEx2vSxRejTWgkl7r7E9hPTTNcyWoAJq/00Td0VwltqmCKw2ZCxCORezTuzebaFl57nTcwCBcAo4ygtywBuJeB7wAqd8nOVTX2NZsquRTIVAJ+Yytt+FEkhF4ZK29FI71Jf2Dm5BPdFx0c5RdBmom3ry11nn9epJW4xVXyJIHn9CYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtFQih9WHTZJCiDj/1qdlcL9IV1NbnnAROwE/wgF5IU=;
 b=OGV1i3qVSEPbZoyAQTqdjbb9FvGZuQOQJXslfy9zvOBa8wlJ0ghXRJLO0rZk0p/LqWiZOxCgcxUYwlWtbLDiIDMeHNGZDCGWvzAWC52OF+MQSzicyQau9Yal83nJavzLYoF24MyeAJu+ZzFMSlD2MnYdZwkyj2kJEyvet1rieUZsMO9J1zDQk2zzxnLtmEUOSdMWKbjMLm1o58BV5PDEGOlcd8DWSd8KEJHQtoTX/vF8hWzKCL0TrBX5PZpSrd/tfT4MSsGda4liCI1jhXfGT5Qn6zYZsLypS+IngzUXHuqBHWagXdw43EF6DzHtemW+o1uq7d0DGQhTYfnOBpqZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtFQih9WHTZJCiDj/1qdlcL9IV1NbnnAROwE/wgF5IU=;
 b=xjdH7PqT39eUeOFBJj5xyXXfvwoTi072gY+ylkF488NFVq9S62yrswZbj5IMGN5rrL1QqnlA5lT1LnWo8r7Jrym9ZP0IckvFxANNtxoU4uqN1EyJaLQugaoSA5wnsoEtuRvqL2C/Nebks/kUtBNHklSkQSATERhKH435DIryEQI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:43:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:43:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 65/70] i915: Use the VMA iterator
Thread-Topic: [PATCH v5 65/70] i915: Use the VMA iterator
Thread-Index: AQHYF96CFZN7DS80u0eHsd19NJdXPg==
Date:   Wed, 2 Feb 2022 02:42:24 +0000
Message-ID: <20220202024137.2516438-66-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 758fd911-086f-4121-2fdd-08d9e5f5cbd1
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB586505DCBB1251787320DD5FFD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sZYoKpPFbBaX/Siqf+59kuuhSOPueWLFperqyHvNBhKiascc3OKv2j3G9a2gx4tTNuHoOXyorVukrhW2nDFIX3ztF6/eUvkxlWiwwaxbZIOiWOZS4usSlDkCbpeqXNeLaOZusgMcMfNFzq1AK5NgEnIz8ozGbulpdfTpnHj2D25oPllI42XvoX3pI7rUABrEdmoFCpvt034R97+MojTY4oiOu90wwwjr+7SFDYuwrTcM8FJFLGFCzWhSgvhmMH3TMm3Zdl2E0LpjBmRVlua7i1T9lVxygg3i7tWRYLrWgLRU+HEdG/cXiMkrQ6mXw71mmyAUS1XPRlJY02WK1cTb2CIoSHtUvNRxSBDD4kKZwb6B4UtMWZ4D4Co80bH25TWaaKPygqv3cj8hUBIt5ZB7k3rO+6h9su+dA1MMYfHH1aeaf7UEpEsWQZc/Wl95NvxtzthAvYLxhyHAcJKVkJvvJBE3OtCuyVj9QDYSKQFu93z/igIWBKDoYk4HvGJ4rLFFnqBxdz2JormJtveQFJBVW3z9sbbH4AhKKZcYi7txVXNBZaWzQKX7yaAew3hHu7gCcaMyHXIo3BtfgCHMhPmjhGJASosG7d/ocY1BI33OjsDTZlXxlN14fffWENMnVNsKiVqM46TLpvccTLUdom86X27nBKExsKxeX5CPjnw6/BAGcuEQw8KTAFL2ArchRjyvfnyvoNkp50mQ9XSFDHQW9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OSlXYJ1KS+F0SO/2LeHQxS6Dj7HDpE1utuaqTb/lgIvDZ+vxktWI2xM7LP?=
 =?iso-8859-1?Q?4P7UvLI/FIRIRMsPuv9NPvvvNbT1Cua7wRChvbu9nHuYjoJStGc+CxcojL?=
 =?iso-8859-1?Q?yEln4me1FpNN0z7FXSuZtysn1eqmjeNh3GOXk+DLCPT1th+q6KEJqYq2Km?=
 =?iso-8859-1?Q?K+TfeL/3q7igIXBg0yHNxy++S+ulaoniJcS/tytGLo8gqHxEztAgQjIgGn?=
 =?iso-8859-1?Q?v8i+lEG10mb2kUC0V+CWmkOlYFJdb3pmV7eYKjZIwTKVwfV6/ZOoixtRbA?=
 =?iso-8859-1?Q?ZLTK5oAUbd2oMIZtNG3AnnZVBkT/vy4iepcsEFiJ3rbVGRTUJXMKBz/moE?=
 =?iso-8859-1?Q?swM7s8exvEpJF7RFp/IV1kr3AnYsczEubLFNuZvdXI+zmw4o7IrwsHWHQu?=
 =?iso-8859-1?Q?j9yd4arXwec3llINZqBSePZ4l6zBTy33eozmkPR4/IUSjkabnNCNlqfFCk?=
 =?iso-8859-1?Q?VU4HumFnBOJN4BNfK0c70HFkqsJOddaibFLxYBQsw10va5anxt6dET2n9L?=
 =?iso-8859-1?Q?Oi6nTgMmyAGx8Hy4lBISOfvXoRUhrrlwfKS1z91Wddn5Rks5lYUDRWaXAx?=
 =?iso-8859-1?Q?IiacJKXZPQO/ajUcIOw9HgvnkOjibG9q7NpkaB5WMEYFpV1ykVRj6BHZ/G?=
 =?iso-8859-1?Q?9X/Ggr/m09y5a1/AluUoRVxoUtasmWr0CfW1Kmx9Ywuxe/mApHoYJe0zbr?=
 =?iso-8859-1?Q?s4OetpO6QWMyhHk5UV7HUQEWFtZvVpp1trilKKamVqcQvgooMhbljNZIms?=
 =?iso-8859-1?Q?5fYZiaLQdM9zq6Hu3VFlDURd05T+MDZKAIi6Zu9CzU6B/oSuitDb43mOvM?=
 =?iso-8859-1?Q?soIPq7EiZeLgY4BJTkMFQUGqJ9Uvc3qb7t0XOFMsDznv+zLaKS5rWtKp2v?=
 =?iso-8859-1?Q?WHmhw6OSBKfw65SIaJ06W+sKmnMsZPnwzpkL0KdPsyOmO71JpzDj6rcpJn?=
 =?iso-8859-1?Q?KbrJ8CzcmpE8Jv4YaxsNnBeouPzlAv8RyAO3T9jFKBo/0hZjxO3o0jbU8a?=
 =?iso-8859-1?Q?QiMo4YpIwv2StJkcGKAE9rAqogXT07gby3QTE12x7GNWywxobK22ojUANE?=
 =?iso-8859-1?Q?ZGbLy9YGnIX6hwAjjcmEvcQIObOmr3wYdhzZuu/NZjlVPZ4Zecs2M4SDBZ?=
 =?iso-8859-1?Q?bOKczpXqvhMxLQBALp73H+uWDuz77ZG51efm/7dXLqCIgZ9JnwAtKzMBA4?=
 =?iso-8859-1?Q?XUwycgbaXqnOOP6N8mfZh7nOT5naJ0jRM8ptiHVassPSZCeDAWVgwmmbbU?=
 =?iso-8859-1?Q?8dj5qu9EkegkkYoKIYck19aX+Fwtvoc2BMVbBgWZn2gTpm8hxysz455AI7?=
 =?iso-8859-1?Q?xD8d56VrDOjw4et0ExFDj1K3uwgt6xKTSoZiTBVEr8vJu3fAP5uSdGDZNF?=
 =?iso-8859-1?Q?KN8Frpslj9lNxWwQ18G9u5yE2m0MN5ufmSCDz1K+3WToSaGb4bPCcZ36nK?=
 =?iso-8859-1?Q?qdin6h0Ks8M1qtxURkovzLxOOekG+Q9UKHSuTeFMYBuMgtTi3/Dn72bIIr?=
 =?iso-8859-1?Q?EyfqWGVLkvG4Au5R0enkMXlB+TciO9dz2K1QYOYqT6HTqRNe5uC2e9LwMP?=
 =?iso-8859-1?Q?gPQmoQRlsj3BlfmVcgKjeceYu6cQj9Lvs2L6qMUN5OE+Zpvms2T7Q1V/K6?=
 =?iso-8859-1?Q?5cqS2mlXpwooqntR4kCoks0uBBw2U55Hl3Lvk4hdyPIodvhwRR1L7GvdQv?=
 =?iso-8859-1?Q?dp5swYOqKbtTk7o9P9s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758fd911-086f-4121-2fdd-08d9e5f5cbd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:24.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLLdE8UIGWde6EZ/3bV3fSzJb64Ti14H4L5zcVWBUcO5nFdf2Z1oe4/9aV1vv+PByJsvpK4S3EBxBB3bEomKiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: jEQi_RLCZGb2zdKBS21JEhoz3wyguP-y
X-Proofpoint-GUID: jEQi_RLCZGb2zdKBS21JEhoz3wyguP-y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Replace the linked list in probe_range() with the VMA iterator.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/=
i915/gem/i915_gem_userptr.c
index 3cc01c30dd62..59ae919ee109 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -425,12 +425,11 @@ static const struct drm_i915_gem_object_ops i915_gem_=
userptr_ops =3D {
 static int
 probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
 {
-	const unsigned long end =3D addr + len;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
-	int ret =3D -EFAULT;
=20
 	mmap_read_lock(mm);
-	for (vma =3D find_vma(mm, addr); vma; vma =3D vma->vm_next) {
+	for_each_vma_range(vmi, vma, addr + len) {
 		/* Check for holes, note that we also update the addr below */
 		if (vma->vm_start > addr)
 			break;
@@ -438,16 +437,13 @@ probe_range(struct mm_struct *mm, unsigned long addr,=
 unsigned long len)
 		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 			break;
=20
-		if (vma->vm_end >=3D end) {
-			ret =3D 0;
-			break;
-		}
-
 		addr =3D vma->vm_end;
 	}
 	mmap_read_unlock(mm);
=20
-	return ret;
+	if (vma)
+		return -EFAULT;
+	return 0;
 }
=20
 /*
--=20
2.34.1
