Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA624A6A45
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244531AbiBBCqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:32 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55680 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244408AbiBBCnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:39 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Dgnd008551;
        Wed, 2 Feb 2022 02:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8DrGrAVL06v6No0uuuo78MhZ/cQVdWDW5dLDpxnlU/M=;
 b=VMqyavKPRaSJWBsuT6OPDEQTvpTAZ45FrRBreltblQIJ2D28+s14G6DI7DAiVNNUf5Uz
 cw/u4lfEoYWs+uVmo/nWHo8ZO3Cf9MmGCI/xe0nNCovuGb1v1CZryvQ9ru9BqDYi3BDe
 TmrGYqRYeRx0wBc1kk9LszWQ0tZZtCMGzZwBv7zvzZD7DeVYWmChjoqFsXHzFrBEEuX5
 9+nVWJwHitHI/fSegK4SV7j+Ww7FDfJf7+l0oJjz5iAN/unTbUW7Z6gojcHLx6N6hGMP
 4NZ05Gq9Hw4TZp9XdsKW3qCl5YK9RNIazjF0Dv/fynvrRDltTJ5hkCGnRJSAV63RymSR GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatvugh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zdxx126549;
        Wed, 2 Feb 2022 02:43:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3dvtq1m9yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEa0QLPZcfUa/q9CfJ3sJILOrWWG9jBUYKZtai9xpikR2/TByxWJIn/cGlll2MxvSuK20xLCDK1Teg879Sa4N4lQCPUpfFCi74Um1ON1H0SN6KXRPZvyz2vVzpdc5112VqYKwEeF6yNEubqfv3AAnx2Wttm8wTvRxM1hNxmkoTY30GZxrpYZDvMbl/CEjoBVQel2wi/eLSvAU4QIGtj+Cox+rFPoiTYeZ3CChZFFnA9nGqTsAl3FNGzRcoUD/tGq4m9J8cUcPahndNwEiVOiqjlOKo+vWCIH+OKpMUvttle9Fm6usn4u+woEi0ecrMnvkesGQZcRBs21Pdqdk+k1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DrGrAVL06v6No0uuuo78MhZ/cQVdWDW5dLDpxnlU/M=;
 b=GavnthoNqJ/+P3zyjilVH0l4mjaJhlCFWZWLfTHPHUbpA8DxebGOUe2VBK+xxvscljNktIqOH0PkM1fKFvgfn2GRsHXbwU092Mf0E6UqBCLGUVJurzpqzqY7OqkCqYuYkvJe7r5apktA/t6CTQKgoYAb1wmj/vBbA45fcwREtNvSF4eZIQi0bGwoyFO9rDGL4+W91o9HKOe9ekNA5Q0J6cd7Etb1EQtOhkiGT9phPLve/g0zQyZjoli1p557Zyb6nmQ7CrCsqiOSSh7XNMOHWtfOal72SccIqgXbV3vbYbo9viA/GFqNkjZhlmmxI0x6CdpBzL8lsM0QSUP3OJCPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DrGrAVL06v6No0uuuo78MhZ/cQVdWDW5dLDpxnlU/M=;
 b=KSNvD/CRb23zzjZHNQNdgVfAgvb06Hh5McVRS5hSIvDiX4gBNLbyuVRN3INgAwbOHiid/tNIQ5zap6Gv1xATheD3gxkUgjqyVcZFUEY9X6/9jYVR3kYe3hboAkwrZO+cYCvORUIVtbdoe743VpF6haPrL2pXJRJ7gyAsjILMtLM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:43:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:43:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 69/70] mm/mmap: Drop range_has_overlap() function
Thread-Topic: [PATCH v5 69/70] mm/mmap: Drop range_has_overlap() function
Thread-Index: AQHYF96EuPnY1NUUt0mFPn2I2cUlBQ==
Date:   Wed, 2 Feb 2022 02:42:27 +0000
Message-ID: <20220202024137.2516438-70-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcb52075-aab2-4a32-fb09-08d9e5f5cca2
x-ms-traffictypediagnostic: CO1PR10MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR10MB48016937030B3C80A408E3A8FD279@CO1PR10MB4801.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qM7cLQkp666RVua3yVQI2AEqx0FiZeW9xsNxnOEeWZ0DA8hUvXUET49dHxljBrmy6YCGdVC4ChANMFPYo204tRVBPCp5/yB9gQzMXgi9DU9++QXmTL2yc6mxNHLD/vihtPqiwQhO3uy4wwwhHvH6Z+1McOD6+p8gT3xloj1SZjduWtxCNdCKvkzlyOjiXMxtON/Q30bcYToiANRLdHAVJMH0/ZcqRXhiZzpVke5A0/6aiR1RKZm0Y4YOQ2cEgYSYtEPXcseZhJzUrJsCWvNcB5Uvaq2mp1iQUbrJbCEX60PCEVp2QRYSNl/g7K+sz6m4ZbTPwb12pKactTcaTA/5xg6AXxrqWEqwI40U95EAr2q2UEqbf4WWZQy9MdyzuMBLgao3hoRl40E+eipmv/92YpKKXr8WlwkBgOMhSlabdxFTXfb4M5RO64GFCKhzEC8G/rPZc2XWOdMort9dgBcE8+7iD8JgVLHGNysChMYgBLXQyfF109n0Aiz1r07hf4kI1o7lrT4nmeoNY+8x9R2vv0WbiOc4bRz2Co0dy794TQ0DzSwpVf+MS+8IkjJncywYGoUD2VIcCdO6vlXJqQGOieff5HxyvP4HLailVoYEkz6UgsjqZ03g0RsvQrWF2YbUeoTBekEWxRLC/FHL6/FhmG9zSNSXyyu17m5k66cUbnpApE3vbrxa/1aRwqNATcvQpkzTkNPo8h0sUh95FEfKfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(1076003)(26005)(6486002)(122000001)(5660300002)(36756003)(44832011)(2616005)(6512007)(6666004)(6506007)(83380400001)(2906002)(38100700002)(66446008)(76116006)(86362001)(38070700005)(91956017)(71200400001)(110136005)(66476007)(316002)(64756008)(66556008)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nwGELDCPA51H1HTc7GIh0FsncJlAoUgLwwTTnTek4iIVdSTJqaz4IVeIJL?=
 =?iso-8859-1?Q?1hiO7s13sgdd3djMsPR9DWB4bjYGAOjYf2sy7bfGwEw498QfejPDktUwTC?=
 =?iso-8859-1?Q?LyjTKUKeDPP1oa1ZffhWh41eCWy2p875vv6ZNKRUq4HswGYR4pNdOKPw55?=
 =?iso-8859-1?Q?Q4cwfmvMZ6DR61j2OcFseHZPoKYglfnGispczSKkDkXQA7XL2ZLBsGEDxJ?=
 =?iso-8859-1?Q?Ihf2+jcvNeZo6f7UatmN7aKs7/0Gq+w/Rq/xkanVXtcallxJTmlVG5pwbF?=
 =?iso-8859-1?Q?2jcBWN526i0FyNBPdDKQQDsGi7wA6uORA4hRUYs9dnIA3OWycKlP12feMx?=
 =?iso-8859-1?Q?UdZjWTXeXa0a+aVSEjlsTwZNCz++GTu2FCAQvJVdqvuZhbOTkry/MdNV18?=
 =?iso-8859-1?Q?M9+Nj6WRo5IIdI/WOY4VC/bbHI9azted9PeTMBMKuKJ3DRfEGE3mt5Fway?=
 =?iso-8859-1?Q?jtRDzauE3X48gPE/xO3/Cv6fgeVeyXDUr3X6rsZzkbmN+u5oc8tMEh9k3s?=
 =?iso-8859-1?Q?KSKsZXNg75EFIPBSaEU7V6lQc2HqbmVepzaAUaZacaSBPvoTfH/l4LctGo?=
 =?iso-8859-1?Q?BmCf4cMvmb9a92EZrzcO3rUC4vKm4ZZVgZqAREyRZeGW+faeQakxjGBjSE?=
 =?iso-8859-1?Q?MDGhSun0fXzd6ig8FSs7fFj2n/6+E9KrPou7/+sRAAagX3PDp5xZXC4DY0?=
 =?iso-8859-1?Q?53T5Hi727jdf1TQc7l4IydaWw4+0KBIc3qLA70QefPVMmeNMHybz0R8CkR?=
 =?iso-8859-1?Q?Xv0MP/JkVlxD2RtNG1tBxqpeSRjiJMRRtFX8hJPys0fdxVgEGxsv1woB84?=
 =?iso-8859-1?Q?Plxd8oCnqkKUO5arHxTz52mmiaTb5JVO2UBTRz7tzlon0zC8W0TYXgCKy1?=
 =?iso-8859-1?Q?GEqZCrBnJLTwt/cz6k175TUuZH1CEq2TSSRKKmr3iDNNZeYAdKvPa2gwNf?=
 =?iso-8859-1?Q?FtEbc/jHqFa3kDkEm0o1KPo83CbQnKkDlhQfcNcFki7gVjE1NGuveMHBvF?=
 =?iso-8859-1?Q?P0D6WJpyrSw8I3Gl8mGhR/F15nHcKzcKpK4VOm0MXvaAJ+Mq8L2Nl/srn5?=
 =?iso-8859-1?Q?87yKopDmnvxaiq5qNA5/Prj53wNAxkXKivwxFnDeFob3Q5hAF3+giWG0hg?=
 =?iso-8859-1?Q?PaWz4QiEGrTKyaxlkCnhfe7X3pxim8bwDzlkpUP9p3BQPG6ZCN6jQb5CBF?=
 =?iso-8859-1?Q?8cB2O7YwE/MbwVc8O6OmtktJWuV3k2yUKUdajl/dTDwuOI057Vs0Q6NIUY?=
 =?iso-8859-1?Q?Mt2Jv/fxz73KwOpEToQCyuo995h48n9a48ZFeJ+J3Js/yitz15cakxiqRT?=
 =?iso-8859-1?Q?53LiJR2Zz0ATaEfrQ6T+2twSaBAKiNCZUW/rgX/cFckP0LER0wyD40SW7S?=
 =?iso-8859-1?Q?FSBmAqEq9gFZehDMM8UQbjjtjTblPN/tPNMn2o8S8xMC5Pzao5l7qUHon5?=
 =?iso-8859-1?Q?Ou1w/+lEVK6ZPaJDu1CVCMMyVG7zvFewKMsILgFt349SaoX+QcBqF43Hkl?=
 =?iso-8859-1?Q?kLntClPdGDs35wFDoMLYK5Kh/Ev+dwuyW3oiRz6ApFhw5B8lN4BUcVS8Xx?=
 =?iso-8859-1?Q?nz8QVrEcmxJRSzKBOAsLrHMyk5wU854h7zr++G5xwZVjrRe3ls9m6ouvLo?=
 =?iso-8859-1?Q?BdoHh3YjVCr/KJByLex1BmkaJcUqUA3UIcS3QqnVtl0+I487MLXCLpmKli?=
 =?iso-8859-1?Q?7umcwHDsGT8kPGyt98M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb52075-aab2-4a32-fb09-08d9e5f5cca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:27.4535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3VVwWcauKYHTHZ/aM8ZzVhwstpfP9L1k82pxW0k/V1ifNL4ixK/OvL/aubLcV3cpHJdnL3hs3kqOA++fOcwJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: h3Bn9eOATGAXBwODILBDFGd2XtKzuHYG
X-Proofpoint-ORIG-GUID: h3Bn9eOATGAXBwODILBDFGd2XtKzuHYG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4b6cf9dc0763..8fdef5b83b74 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -440,30 +440,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -3222,9 +3198,7 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
--=20
2.34.1
