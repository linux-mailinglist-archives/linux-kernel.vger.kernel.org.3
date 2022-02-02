Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBC14A6A35
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244862AbiBBCpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45792 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244231AbiBBCnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:06 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120MghW026641;
        Wed, 2 Feb 2022 02:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AKiGh/i3U57wEKSIFOU8ncGOpP7PcXMeoEJ1oP6Nsa8=;
 b=JU3cpuKj0SY+mtmLCT0c7izTHSonJ31RIUAwTixhrYpiKSc7beUmH6XcPunLdNNkrcLi
 2st5QHVeakjJqaNl4KW3CYfDka0TXsUAL1xbUyvhLVudbc4yeknM+BBLoEZMSsGknLqz
 Ti2NIM6p36uXfCkD9Q+eOHc83Hp+lTvmtSy8jOTTfs3zsberlVccJVC/KiekfAxjjG3B
 mVwosU9ijP4f6pI+UtaKDSZKtJ7hSS6tqWayNFcoFoXyYJrh2AJT7+37GrPhxaJP5yVo
 a4I6xhkM2s96lUcuFHQfACeweF4KE2wKoRtxsYqToMUcUxHGfBCi5W22OewQOZJfTPM4 Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcu1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zwrj015281;
        Wed, 2 Feb 2022 02:42:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3dvumggud1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO6QqJ9eqXU5vhMj4G8MjzZso+1pqbTIqpOUmYq5iuIZdR4sw2k0cp4TXpGUvlwVG3ppCcY5wmq35gSdRGlPUDILqL9/gu3141Ya7SDLVPUZmBspcwhSoK66YnVKnfsC6JJxMUV5+d8qixSLtDaY2oJZY9WWpqeyeMxkfP7zU7XiYmlNOfbCrEVUBr10WPp9dM4HPEkYoHLwBMdBbYormSOXPVg+s5JC4AuIBZnxQO9j6m/7W7ol0av3k4HeY2ujBxseNjaAmKDVRccjOHIA14vyHKc7UITTYPXVASv6ZLXTX3ILiamhCPYDF4qCDZPA+4J34D4Jm4+08uLrKp5ZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKiGh/i3U57wEKSIFOU8ncGOpP7PcXMeoEJ1oP6Nsa8=;
 b=VpnqA1SGNU3yvFbhiqCs6iVucNJ+UI4I9YLlBm3WZGcz8F03ogZNdOKb3jx1sR2DmT0bVl4bGYNBBJrYRVFfVoxWIGxLBqh8A58vRzAvVQVBG3l/FW2F1UcD3Fh2BRkR1MEtu/zXCvN/iAYgIHQu6YcqJMBUPX+T2UsfYODnu9R1ZIVs4AHoPUyu8kWB9OXmZ1iYEEsBGz+UDAO7GFSi60prScZIiIfRCphOfajoLe0ZSrjhkVDE2ZDbHk2su0EaTVOyXxCZ5iUT/Hu32v2DOQROID1WFr7gecjqk+M0nZSYDiZXuXL/j2a9YAYjp8YgIEsImtO0vwhvHdiRnYUwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKiGh/i3U57wEKSIFOU8ncGOpP7PcXMeoEJ1oP6Nsa8=;
 b=Lnz/lq9MsGMqTd6UBMLTrcKQmDgD2TDPZKMVZs9JHg7z/2hF0cyh2i1B1kZiMi21bHpEd7pTAUbNinYwU/tsxqzDSsJcXe8bFrRn3ijRdDmumQsLrUWFzkwVcOMETQMI+ShgY8z13pKvtJrICZTqbiJdXR7pISgVjXDKKD4j9Fw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:42:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 53/70] mm/khugepaged: Stop using vma linked list
Thread-Topic: [PATCH v5 53/70] mm/khugepaged: Stop using vma linked list
Thread-Index: AQHYF95/e6EuXuNRUUGHFQAPIFN3OA==
Date:   Wed, 2 Feb 2022 02:42:20 +0000
Message-ID: <20220202024137.2516438-54-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 930a2ee3-87ea-43fe-8c5e-08d9e5f5b78d
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5865C3E09255CB9156506843FD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IX7GMzOqUVs56+SnRq4ZPQgxqJpioH3Ai52jXjSLbjh8c/CMP4awQgiW9/1UIxDvcWmsLbDKu+JwlcFfJ7BQBge6X6/wQ/NMEHyhHb7UfTDAZjRxV9z5yUelxon6hbEGfVAAJrprMTFt1qQ9dG1MqFmmC+pWOTYN39b/Rh9ncKdyGuX43d18b+dShuSe9WOJr6QAHwgdiJ4+z+Te54LuagmmXiEu9gJItr0WaGT5gz0kJYxP/tw4pJq3UUEfxPKweoaPEZtbtyf/i7MlgkXH9H+sLSsxF4s/dTbBmspuifouNsLbfFiaFETCWHKRSCuU74Na2z4yOxRLRI1x4bShFJsSG/sujTxNXAbv9LruNLjiFidjJvHsAjY5sDk4Hzh+CLpbRuLEYqcLPbq208S2uEbvSj5p4u5uUujI2VV8pMBxnwh0uS/ideYb4UB0CceuE+oZrB2sv9A7kLTFesvtB61uxWN3wB9ifK3s5fEVt11GQOyXRc+BnOi+HZggYai6IdXEqVs0P9HAWJe6ps/1mLRT9iF01Udr1/UjYdugoToeeVl+RoxPUkOBU53skztWi5GQwZJxLoVDoCSGNMRLYx1VVzVBUoC2lQFVNA4p89CBKiIRbekHNjuYVoHT3VmM01WLGH8YkvaWCNvaLKGl2b6KwNjugLlHlM5Z63xBo96Vg6y1mZ4vCkTlikClC7kvp4C5Az7yc4Nw0LYmYRSQHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I6anJ4CB2Iy2JCwwwHz7Cxb91mWNCQUpTAc3oDZdW+M+bqRJujVCcZxwmx?=
 =?iso-8859-1?Q?IYNVsgI43HOBnj7XzdFQ54rs3RAbptP31lVcFTFibLaE9TquhXVcHNo40A?=
 =?iso-8859-1?Q?N6vLGcd5JxlAeEil0gjF5fnfDRy0TddZoZ1AAfetRHogxHx8MbnFzuS+Dm?=
 =?iso-8859-1?Q?oOw8A4uhMWzDcTuLGFKwSX4u7jg1oCaOspvo2flG7ilxLIZ+xUW+tYtmOn?=
 =?iso-8859-1?Q?e85z683EPfiOAHGjr18RcYxQOjEZE2bqjyeZV0mySfOJ6H5+7lrO/Qq6vg?=
 =?iso-8859-1?Q?3DZFCGJWyzN1vfRfVwceK+4ItOewOfFtY524W1TOQ3AE309Y6bI6VsdzFX?=
 =?iso-8859-1?Q?tRVDfGqZ1H509VEdwE+ERw0QDYJiEuwRmGwZ9X33C7Tbgmfvd5l0N3gvPU?=
 =?iso-8859-1?Q?zcASeqBtHDtWVCIRs/ewBOFsVH3OjaWYdbwxJHlP4aVGaP25gzI8Use1DO?=
 =?iso-8859-1?Q?XKZQsRBjLF9ZMJbDKppyQxV5C5daOxhpBzzcw6KEumryapEo8DN4PmrBZC?=
 =?iso-8859-1?Q?r4eFjy1sVRc+hULiQsjQ3LEaPTkHz/uWkSPTU4+trEcjEH35gPGzzkVVPI?=
 =?iso-8859-1?Q?ZWY82Sxw1eRn08Nqcm6fvyACYY0JYOfSSBGV9SMgcdNI2CPWnkidLCRsJ6?=
 =?iso-8859-1?Q?Y5ETgmTu55tlxpwxIEfvOukagEqeJPprl/Qry9XKRMRx/3eviVDhcaVTTt?=
 =?iso-8859-1?Q?9AMTUT6bXBKKUH4BttNxeMllemZTalo6E4b5DMSPVtFhYT1TZ/dSpVKruy?=
 =?iso-8859-1?Q?RkpO22Ny9ErWTMTAoig/2+kRtCrRgmrBg9CieqFJe7T+J4H7GsNICZ/59d?=
 =?iso-8859-1?Q?7xSxhPUr0SBub3/aZE2APm5NMRfZxg0T8Rt0StoJ0lhOXucU4Qq8POJEnG?=
 =?iso-8859-1?Q?+pjpedKmijEiltqqlnuJ5o8gYN8Jv354IrU5OurieFkALLMkidLnHOXXuU?=
 =?iso-8859-1?Q?xCMjw0MPtFYZTbeZlCih/XhEwzFbKUrHNbWN1a9fVzCoJxbJrtu7yJEJWN?=
 =?iso-8859-1?Q?GAaH2FqhWrU2WH+GBoxKU6djIWY2BY+b8KNTybnBYpFFFcEcxzyZJxOje4?=
 =?iso-8859-1?Q?y9KBPG1bQ6ITuiBahWQ3NK7ISFROsvhhsOCp7vpodziZ3658NvYfAS4pU9?=
 =?iso-8859-1?Q?XYWJT+L8MkgVYSvFebbC9g3YbAU89QOGicI04dNdwYyHWmnaZGI74BGx7G?=
 =?iso-8859-1?Q?+32exHMss2EGN7N8HYAbECWLBzsILpq/h9dYC+Vstm/HodJGN+aPYke/cT?=
 =?iso-8859-1?Q?BFB/ZNvF8qEIn3dE7wDjnqCmx1+Aa6P/b3tzGiujf5DXSUkHD421F1BhUn?=
 =?iso-8859-1?Q?Ask/C9SIafgF6gkhIm64cnHiVaC4idZcIn+tJeBkAdZzTf3HqyxcU0jAKc?=
 =?iso-8859-1?Q?Rg5i814t0+hA1JZgEyTLILDon/rCGPboUs2dOHr3gQPT5PNSbyWYxVKRvb?=
 =?iso-8859-1?Q?ySfrmWAEjgNcv8/HH0rxUMUngb28jBOeysl+/nzro+XdSvY1iwsjMtBkxy?=
 =?iso-8859-1?Q?YKdrhpg07e+t00Tghq1Rb+14ekWE8UqTGShLHu2Lx2Em7DK7E4pJwHmaSb?=
 =?iso-8859-1?Q?vgH5wgkAgRcSIKBmlFoYXZbZ2vuHx9ry6/E8enjUyKfpYW+UCJbCeQNy4B?=
 =?iso-8859-1?Q?093qI8Sq8ZbjkyXILvGWIGnF1LvBF8lNDw0Is5OAhcEjMkt3ge9dEXFtei?=
 =?iso-8859-1?Q?aNKWrwr5qilXQUHWRqU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930a2ee3-87ea-43fe-8c5e-08d9e5f5b78d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:20.2821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OsmQaBi2KdeHbZDFztMQ7hmblLJqdNUEmAxPgeQWvc9orrnnr6JSsd/h68CN3QIsohmTTjNf23Go8OfY5u+Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: T3u84xBkDzV79z6sFSIJsuL9bLLgsjrV
X-Proofpoint-GUID: T3u84xBkDzV79z6sFSIJsuL9bLLgsjrV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma iterator & find_vma() instead of vma linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/huge_memory.c |  4 ++--
 mm/khugepaged.c  | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..1d23f6fee0cc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2270,11 +2270,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 	split_huge_pmd_if_needed(vma, end);
=20
 	/*
-	 * If we're also updating the vma->vm_next->vm_start,
+	 * If we're also updating the next vma vm_start,
 	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next =3D vma->vm_next;
+		struct vm_area_struct *next =3D find_vma(vma->vm_mm, vma->vm_end);
 		unsigned long nstart =3D next->vm_start;
 		nstart +=3D adjust_next;
 		split_huge_pmd_if_needed(next, nstart);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c4c4107bb767..f313a8a01c79 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2088,10 +2088,12 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	__releases(&khugepaged_mm_lock)
 	__acquires(&khugepaged_mm_lock)
 {
+	struct vma_iterator vmi;
 	struct mm_slot *mm_slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress =3D 0;
+	unsigned long address;
=20
 	VM_BUG_ON(!pages);
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -2115,11 +2117,14 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	vma =3D NULL;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
-	if (likely(!khugepaged_test_exit(mm)))
-		vma =3D find_vma(mm, khugepaged_scan.address);
=20
 	progress++;
-	for (; vma; vma =3D vma->vm_next) {
+	if (unlikely(khugepaged_test_exit(mm)))
+		goto breakouterloop;
+
+	address =3D khugepaged_scan.address;
+	vma_iter_init(&vmi, mm, address);
+	for_each_vma(vmi, vma) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
--=20
2.34.1
