Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD774A6A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244681AbiBBCo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38578 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244195AbiBBCnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:00 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120HCjU011409;
        Wed, 2 Feb 2022 02:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=z5GkGZxF/NMP0n8yPlIZA/7TqAWku/UUEWIq9kXgI8k=;
 b=LB88TJ6XMKPooj5l8MSs53W8roMjVKLhYaA93WLmwmUutxvT2iX3UV3pkUX0wq3EGUBR
 c9vm/Ccu0qP1iHgiHJXAy4Ck9g+DOHVNX2gdTfIJ3Q33yYh9zpY5em2oikkAxMrabNoH
 akEnP7MAhJ21Sf0S8Z6jE2L4UvHlOxY7WSZNiZYo49lpoATkMqu/TJ/4bFCJn5ZYB34s
 weWvNgw7ZNopfAiaK2XyFYb7Y9tj2c2bqKbf5CGXmooQ8HouwObFSpICWoDxsefLLhZt
 amh8s3dWZ7LxboeXu7f1qdNQXUExCxg1HWrAzizdGF+OByJ34o8jJCcFuvpEuDNg5ww1 bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvseg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zsu7007633;
        Wed, 2 Feb 2022 02:42:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 3dvy1r8aet-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM9QGvjvEnmgGDIgltlsLPVvMG7NwAg6Q2DSK/ftgqUBBgGG0KeUbFyvn8doHJMZ0LHQEcZRkJfdVIQfc7rOh9rsLxLrcX9f5ppxHX9NmybQy1m5xvrcoEEQ/vu72pxsIYJduKOPpF36rUB6yIA/KaMGB3e6VVDuygu0+bjyb02r1y2GfyzkcNxJ0LDW1Ac2B7UORuAHAticn+5CZAFtwlAkPaHynlgTketos++oz0k1r82zkBgeLqosfNqZQR5JpoohQ0xb/M/37Z0Siqdn9Cve4yr+ex7JZHUWXoZMxXpqzLcuaA0rwpKdeY9rYVmuF7XfGMHwwcna+CD0JvgeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5GkGZxF/NMP0n8yPlIZA/7TqAWku/UUEWIq9kXgI8k=;
 b=hmDw48Ccu+qQiAnKRZGW/yK4pYvbrX8d7cE4sRdVcj0VqcrwIGsqKrPMztyL2jT6vV12pQ72oOQw+r8NR6OdFLrYsVnfevbqeEO1TPr5X2Gyr/hbWRCDl0PEzq4Yzkg3sgfmOAs2Ffku9gMAJr4/4rZ1QTMJb/J/bX2UsaTFg6krr38YcdINEGcXfJFe9X7XncEsIhb/5VXHJ5KAWqY/k2uAiEAA2FZIfwZ/ujL30uPGZaF0noqmgyFCEDCH/ZkiwwRT60fOMsLqiaPR6QLdqwF6aZZSD47lJQ5bUBAedhQrIFqaP5fu6naZ+tEuUjvd9OiOMYmlx+hVLaljyj6s0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5GkGZxF/NMP0n8yPlIZA/7TqAWku/UUEWIq9kXgI8k=;
 b=spDez3CxFldNLBehtincAvLUA/woTuG91oGruXABByF5SLRVXI+GFuw/IuKgGs2IbvNVStrWxP0Ky7qgVxRvkeTb0QnkH4+PPj/GO5tZJc+Zqy5kA71Xcf4L1jmNty3p243deQUoA6DZNL50iYhNWPIsG309r0Ssv8mhURcVQfw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:42:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 43/70] fs/proc/base: Use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v5 43/70] fs/proc/base: Use maple tree iterators in place
 of linked list
Thread-Index: AQHYF959OndPyKg1HE6r+unWHlHVvw==
Date:   Wed, 2 Feb 2022 02:42:16 +0000
Message-ID: <20220202024137.2516438-44-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f093841-0448-4142-577d-08d9e5f5b4c2
x-ms-traffictypediagnostic: CO1PR10MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR10MB480188D6813114A1F5348FEEFD279@CO1PR10MB4801.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X9IB947as4b1cG/CP2lm8ecAvYITKxkeVF6DD5l8kIrKIFsb64suPDXBrLmNb8tVGwbEzq9nbBwkCiBUIQYgXiOxzfZ0RmpHVUx26KZGKc2yfn0r8kEVSqL7e7kQJdHdwq4P6hLMB4+hZ6Anurf04KIj5fL0nqtaqwnBFD+jo3L9HH6juGazPxbL+3h2wx3KA4EaZAxV7ROhel4kwAD6I1HDtRFAhPnwt6g6HLITwDOapONUZmJ11y4t9yP3X35EOTwXWspoHX3gDBqOkyfroVfec4u0MBesBlWhfM+IttNuDcVPR/VCsgbFgZ2YoZsrZoOktvf2+2mOJ0FQo21E3rb11e3EKOk9XZNBqQFPnHN2ZKJ0Eiy4yC0Q67ADdoyZ4fHnDaFWKJODl3EBSxRKze05RfMGI/sKq4UoZqYWL95wgVXdZDzRr0Te8wSwujpIbXc5jJh2zEIXNMDrcWKb2FT0fBtI99XR9MHIuEjk3TRv3CsKabmELyhrp3UdPGG3HGBXVIy4uOQP+U3Prn5FANzRKYi8LcuklBKICp2h7X4KUyK8McseBxVxSq1ZjJoUTNP9AeLSW/EOCKYOWfZYXu/3yt9pR/eat/w0XhugH+xeggyWCRod+sDlOnQUfJbA9lCUYYf9NEJ4dt0bzWEqSOWsFWzkTBKD/dISzNEAcxwDjhTG0gAlmhTaKFjoz0KXW3IAd4Mpvtvb1aWh7tTl7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(1076003)(26005)(6486002)(4744005)(122000001)(5660300002)(36756003)(44832011)(2616005)(6512007)(6666004)(6506007)(83380400001)(2906002)(38100700002)(66446008)(76116006)(86362001)(38070700005)(91956017)(71200400001)(110136005)(66476007)(316002)(64756008)(66556008)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TmaVN2nfzYT8RQAwPI163bG/ZCHwcSMuxOPALWK1dKYdt9rPR+z3oF7Uvq?=
 =?iso-8859-1?Q?NFBItxAB2OPN3ySAR9/ub2lbtbPkvtHYKTVaX4gyXi1zcNMZ7V3ZG6jipi?=
 =?iso-8859-1?Q?kbnNzzZYedhd+zdTEodoccOX9XpSTmGqFvvDD+SiPKT7TFNNtco4+WeKqj?=
 =?iso-8859-1?Q?gOFA5TOkDvpFc1dK4UAk+7rKcsHzpLIZ6seIq8QquCnH2EoRmAIY07qOOP?=
 =?iso-8859-1?Q?HBIrvcbAk0dmBIjdk5Zpl8o5QWEvlVEB1VIaVgQY7BhPb6vttEwqRqVC8G?=
 =?iso-8859-1?Q?szjrmOgid8cu3iGePuhVKwBLDSxyLdELvoSDDTiwmyrTSXyPXTfKnKTXPB?=
 =?iso-8859-1?Q?1kBu2jDGjKG6CloetWeGVrgHerfXz34iopj6GZoAml7gdoiE2efNeq3XC2?=
 =?iso-8859-1?Q?DkPWYJ+HVgjXRUh1FAOdRllT/0A7KQfT6zXbvfGx6ucLYEOO8ZshVTnuB4?=
 =?iso-8859-1?Q?8Pu+riCt4MS7mdUhe6JoEuyqF/3guyYmhyUTUHKXDtAL+01gz0nbdSQxjr?=
 =?iso-8859-1?Q?0AsbXN7bs8rhCWefBDd0oseyWdVseT4KzKzkLKkFIXhJhM/qwuUXtLWKLx?=
 =?iso-8859-1?Q?dWRZzxBQR8vviz/Xpmc06JTthDTLntW237Q4TeNhpxYs2VcxFske3okApn?=
 =?iso-8859-1?Q?4buWrTyK9Nx7QHv41+qdqCqH/FIxBA5hDD2ugpE1qYLbb0ZwTFh8CePAcg?=
 =?iso-8859-1?Q?DITa5eih4upAJrCRMF2IA4RcNJrJ9u28Ow0fhIZlkIN0A+xHHrWgd+Zrzc?=
 =?iso-8859-1?Q?mSomg4g3lZPCAnzcedKIZvfT6ScjKB4RMcN6cD8OPu7noWp11Ig5M4NLBr?=
 =?iso-8859-1?Q?lIsCRbJ/C3NJVtXWKvBNpOxeyxlzBwMJCIJkL+jFpOP8FfbToKTIQ1Uvc+?=
 =?iso-8859-1?Q?FWKLf9g5ARCFy42jaK+7Pz6MeLUBdqx0ukXS4w4SOBphiHv13C7sNe0fpe?=
 =?iso-8859-1?Q?Ltd+bp9DHUbsV0xp2fFjXPyDWgWOLcMeRrWEc+msAY+Haxgjyrqm0Fdztv?=
 =?iso-8859-1?Q?p1OD7EAwh0g2/Vk4CE2RgyEPo92+KSZiMUI8MJMJGfqS0Xk3vPchwJ+2fD?=
 =?iso-8859-1?Q?sm8doQ2OLOgfwp+ioHFHER7POsUcgJgdeh+f5WJT6fgsr67YnrFhf46VGs?=
 =?iso-8859-1?Q?yZZT8nsPvadkpC8cLpmo1/Lqe/6UoE1lqmZZq+4h8dqvVjgQSAQoFW0bRA?=
 =?iso-8859-1?Q?khygGNDmQGRxegThz4wxnZXKwaQyNfQs7V0g3fZ4X+l2QrRqqJkprChEGo?=
 =?iso-8859-1?Q?okw7KDL5ANxL/5FiVWrGjMaEdV0D6KNG8Gx0SmvisoXQ6+UfxXz8I3//zj?=
 =?iso-8859-1?Q?HQg6Qery/Qwt8TwmAJmUsUlx3kR71NahvR0BLlGH/a4DTTxUwUpX69tpA2?=
 =?iso-8859-1?Q?LQmwzEY4PTzIhnQeEMmrXImmoxlS0mGHhpcmzfipeenstkzvgMgiMzZMI0?=
 =?iso-8859-1?Q?FLZhD5VL3fxsBa8nmuhB3ssvGex0mYCKD6u93q5ZHHINO3AZkLO68o4PIz?=
 =?iso-8859-1?Q?44ZCO0ApuoKpsd27Hir0ZQCLdrlrrVlpl4jgL0mtvfJ8QDQzglJtsKKY3m?=
 =?iso-8859-1?Q?yGGr5sdk335jVT29g7dSiV8Ht8CGfkBxjASqijCw2oiFYGpQ43QTcdc1oz?=
 =?iso-8859-1?Q?poMqo3HwCv1z/V5E8XVcnKFZW1muqpj7dxl7ncoOTbgyYdvC8kIjxHdrXe?=
 =?iso-8859-1?Q?PgSvVppGG7TvoBQeXgQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f093841-0448-4142-577d-08d9e5f5b4c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:16.2667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WH2Csm9z22ptHtmg1eoUAd/Y+rZHqtWI/cvNX/s0fHESHn+BvefSXCbu5oRaoIe9x+5VzW1snQW2+axE2C4CsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: e_EpesbRlPhbVF-ZLYZKgN1IEwJLjOzl
X-Proofpoint-ORIG-GUID: e_EpesbRlPhbVF-ZLYZKgN1IEwJLjOzl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d654ce7150fd..a62851782aa5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2323,6 +2323,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2350,6 +2351,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	}
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2361,7 +2363,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
--=20
2.34.1
