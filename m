Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987A24A6A43
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiBBCqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13722 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244400AbiBBCnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:37 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120DhHY011406;
        Wed, 2 Feb 2022 02:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2bNeRaWpGSQP6Tura8ff9hgRov3Vv4MgXllLeWsugh4=;
 b=iS/ZMXY+t+bEpOytM/GMnoKAFfj8cmfc+SmIuil/bzTMzrYRgMAkizye9mB3LyiX3wPI
 9gnQNo+c/9rgd3phwdrTTqQ8XClUY/hAxMWTy8kRSXSqzDkQqOtugcPx3b+aYskS82TO
 Z3DC+4azuSl0C8Ic4u7x1lXW8QANP2eG59/IS6S8HIi7bJIarG20UPshBzklU9emw140
 jwZmnLT/VLt9HexNWFQQQv6CDSp2zqlY6E9XvQ3hdtCL0+FmJvJU5uF/KucAFrcX9bwW
 7Zlci8Eban8Q8IYEQJwMR1SUxxtqVxC+33V4AZ1IBKnZL/7zj6GUEra9P4Nv+zwk8RLe bA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvsex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZPVV146749;
        Wed, 2 Feb 2022 02:43:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3020.oracle.com with ESMTP id 3dvwd78wmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:43:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0tl0ytRQGNB0p7mG60WSU0zh6mmd0omJCnv5UyjgFD0Nf55vdk1GZWJuO79/0oH/4JjJKlVhmUkCSZ9HoZPyK08b7lzuwJLmtfdayLKUGkLP1y743z/TqJVAkHX5INl+wb5r+ZiGm6C8YOZDRJOLc6h/MWGeN7j4sm8SMfGScpR3P/l91rlCcqcQt+OewMPthtLJhv56Qzt4pfZnKIbL4X+0PsQiPrdRdbQcN3RpTXbiiRJLbk7PSbd8LXLoJyc/tkpouSxtziw1toSoHn7bBjsZg9SnaIzp0yJIuOJwt9mn/kYONPMGieBLJZSAPHD4czzxT/MszT6JUI7t8derg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bNeRaWpGSQP6Tura8ff9hgRov3Vv4MgXllLeWsugh4=;
 b=E+A7oCrICdCEfI3Sk9DXUtQmj1Gi9jKQsYuB41bTzQuDVXQC8UpRiDYZm0Z1wLMkJpyhBNXsyiFAr3XhdTSYyIYZAQOz8Xn0GZlCIVwLDn8YpUsT1eYJibouzunuS7zIcGsEjiHBiviycz1g0PUTD/O5L5QT9Q5vNyVTjQcsxma47r1fjxYFaj/uDyQfI/DXu0jJT4YaEtEwW75Moa+01dR2KhUtoPV4H/I772yvVZ7oLFyYUIdQo4rlCrvjAWM3ORoMiEA5xq20lM5zhmbkQxSVG+QsP8uiSS18UvMIk4gTsvFr1gx0bAyXSYosJ+o43eypaN3Iie5kt58CJzMtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bNeRaWpGSQP6Tura8ff9hgRov3Vv4MgXllLeWsugh4=;
 b=fDbIQJaCxQbzd7wqaw7+QXNqwdadfdz41Qamg9YI2+/JVHfZfFx8PfSzry6YVAu1hO2+9fYrXI9BC6er1SypBh9hno7ME5DsMyflImKD/9g7YFxD96kON0sr35rz8wG4TzrfZD6By/ccquT84GI01wHqTVtasEdKdnCmkMkD0vE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5865.namprd10.prod.outlook.com (2603:10b6:806:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 2 Feb
 2022 02:43:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:43:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 60/70] mm/mremap: Use vma_find_intersection() instead of
 vma linked list
Thread-Topic: [PATCH v5 60/70] mm/mremap: Use vma_find_intersection() instead
 of vma linked list
Thread-Index: AQHYF96BCSrlLxZ990WKYiwfNw1u1g==
Date:   Wed, 2 Feb 2022 02:42:22 +0000
Message-ID: <20220202024137.2516438-61-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8719195f-b9af-416f-6658-08d9e5f5cae0
x-ms-traffictypediagnostic: SA1PR10MB5865:EE_
x-microsoft-antispam-prvs: <SA1PR10MB58659310F96333976E61418FFD279@SA1PR10MB5865.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8sAaCu0rsMdhPglX/EHInGGa7KKRWl8G+M+oSaVD1gF6+4ikbdfJus+c2hWRzmLZEQKhruNbBUt9SYAClEoT3X5vK+dmqpkkwamuewizNuUPV/dH6uFZgscMq2QKv6jVGWAIJshfdKJ+Di9VVpX/i0XL6IGqvTjyyQBEG9WCbJrxrEYdr4h7otVEGH31ENAoLcOsZakvmzMijBokTwdvWhrr870iuTkUm5nWsPghLRPQf+rZNhmPyJatmhLgZe29EmlMh6Nfg/2xDilecay1HMUNdRlUcQT+zf0iUMhREzzZZNKTy7RiUFJSrnUCFgCFJNrnUVByD0Hve+9p6UrxLYH2HFs7sSkxwmpgJG2sp1VpWg5pMxB01oIsPoGHL4GHf1dkiOCKvtKrw2sKxMEbTWTuOK1vgjhs9H5f5FfKqP5V+JE88XxE7VFuoGSsPm5Ht5ilXUPVFacoMqQgzdxp5OacfjOwr2V1kDxvVjowz2T2FG9dMFYX/vS4s7MQ9YBJzmkLw0xzRmeyGYcJT4aTMBe5SdP4RGffYpR/+ATyvNWZuuUEgja7uaYYb4ZzlJnF3Q7g44Z3qlv9sj0SngdTupsfo6T/JbLHFeaADsYY5Oe99GAVOxV8bhf1jx4P27CDLBQsvoSt/ebxxFCqLm8Ytql5Ct3wclgKzkM3qE2aLPNPIrdKqGxN0X5UgVAnvn9ZL3cyYYJRUS8MNCkDxqeGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(5660300002)(36756003)(83380400001)(6666004)(508600001)(110136005)(186003)(6486002)(66446008)(26005)(316002)(38070700005)(64756008)(76116006)(66946007)(86362001)(44832011)(8936002)(122000001)(1076003)(2906002)(91956017)(6506007)(2616005)(8676002)(71200400001)(6512007)(66556008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?312Cdg3c83uAksriKyTEzmLMO1to/zkMG4ZOU4ExAZ6ocsLrFJ2NswBBZu?=
 =?iso-8859-1?Q?fUs2d58IfI0qdjlg01bGhprY9iHE0G+lBqblDG8bWg7XFj0MIz1z4+juOM?=
 =?iso-8859-1?Q?ckMkr4DzFIzqBZbDWNLHMe9UjBvHOUlj6ZQidnnF7R8kXO79CQxwSRNuAW?=
 =?iso-8859-1?Q?+/OQilGz3qOjF2rVoesk8mDfLEbw3XUIvoUhK/cpgzSGYcfhzSlqqe253a?=
 =?iso-8859-1?Q?D9MVBMU37SkEzHGaU4AGtJSFwgHBvFVumWUyLt17kvQABk0OzKS4VC+Uqt?=
 =?iso-8859-1?Q?yT5HetemD2HV43L5eas0hDl9dqJqu7jieaFkeUMMBIUF32jAM6T/Db42BM?=
 =?iso-8859-1?Q?9iRGWa0cfxMvpaJkcZX1FbBw9nsuVzTxfU/i2HrRU6Gy7bdH2YeD4Z/onJ?=
 =?iso-8859-1?Q?XLHRISyd1Re/IgfHau6AC4Mn9LE4szCwQbbdqLFJ5/Zaz9M3vagcUeEyU7?=
 =?iso-8859-1?Q?ha8njtVMa94Ko5EnOiLCB/StVcT9AQ8zgQiMExW8smi2iAiWtUiTpGt0nE?=
 =?iso-8859-1?Q?e14CdLIIVxczg4xD6E69zrlC3rv0HFm0MzjY6C4POnLIa8L1FHFOwS9gf4?=
 =?iso-8859-1?Q?1CfNXTaIUCoM7NrVgM1tVNheLDPl7g34b8lO5RvKzyYjfTlZfjLMV05a2R?=
 =?iso-8859-1?Q?hhSQ2gD8Q6hVXx9e836NkRtfzcpprwoZ+Xk198FnsaM2gKLUrXy4gzKSsD?=
 =?iso-8859-1?Q?+QwgMlPZ1DELfkkptbFEj0mOzZYRlqhC7p2JEKQTiT+WYwdDv7UN7K9Ena?=
 =?iso-8859-1?Q?Pfp18IxW5V0lUGuijZPRAkPkl5hPM3hQpOMl+8A6Q2SSc0qlWB/bAiqCyz?=
 =?iso-8859-1?Q?Hr0tnlrACD1UGMe26e9MjMpXI9e+vXJgqKtHe395XtVyntxIojbqNs404x?=
 =?iso-8859-1?Q?FeMFwOVyv6CZKaN3gJwb30/ItFxC/sn2DskJ850gfLcWUeK+QUwO9TpERt?=
 =?iso-8859-1?Q?bb+jDFTyko77E7vJubihP7wV6pszGdQoRCGTDhX65vG6d6Xs63FyBZz48e?=
 =?iso-8859-1?Q?HSk67DkGMHaPR1cZgq3XX30ugKSSGcOB/hodMa56lx6aHkrIrjVlsYsV6p?=
 =?iso-8859-1?Q?hz32t5i4/vSTzdP4jdaZ4qI6Ppw9AqiEqJZ5pm/vJZxlkbj78QGRPaF558?=
 =?iso-8859-1?Q?5RwlIjLxJe/67WVu4QaMqFKVUEEF3qiULC71qH/3ord+xKtdahKuVisKlT?=
 =?iso-8859-1?Q?P2tgs7sWqVDRm7JeG3FOhxjnsHyLyxYAKl0KnMx2qUyk5ymRIiVw9K00D1?=
 =?iso-8859-1?Q?zZkZb/NyLblTr9Qhrr/3iKtJcKQ+93ZyN7AGPE3898kStbr0enU7pvZbke?=
 =?iso-8859-1?Q?arOTEBMMsaSeoYgs0SYl293vitZBGrIXIN23TfiVrfUm3alcCG5NVxXIBj?=
 =?iso-8859-1?Q?21ocwGldqD3hiY93E9luLKB8sZ/2RC1iCs5IKAMY9e6qLN73eRmf/RE5Hf?=
 =?iso-8859-1?Q?JIeioGf9ZQVC9QgvypZZ4434/TtjsS/LYk6Ph+IOtYXGcvt7lmgcPoZgZR?=
 =?iso-8859-1?Q?MvS8myCn+RhxTo3Klkgk6HYTUodvUyrxsxZv5clQngR0A5JRJH9fZHKXNQ?=
 =?iso-8859-1?Q?MntF53qhzbfmuyKymrcxm+KzXvJTZYCqaeFdFTxkqg00/WLq3LMHOTfSSu?=
 =?iso-8859-1?Q?9Xrm5xiPVDRuB1mqnNkO5iR/RtddVPzTcg3VbQF21SAZ0vf0+/n9u/UEw6?=
 =?iso-8859-1?Q?SnyifBpL4lWLp27vp2w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8719195f-b9af-416f-6658-08d9e5f5cae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:22.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRpvFog2Rf8+jQUfVXKzCzVKhVLcqjKoE6L2VN21S+FQ1lsH+QC0OwGuiOftbkp9TUWQrMh0nr0jNUpyc3mQig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: 7JkD6NFREiyr6R2hHGDlAsVmAyZoTmoU
X-Proofpoint-ORIG-GUID: 7JkD6NFREiyr6R2hHGDlAsVmAyZoTmoU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index ccf8f4fe6f5f..fc7b8c88474a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -713,7 +713,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -869,9 +869,10 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	if (find_vma_intersection(vma->vm_mm, vma->vm_end, end))
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.34.1
