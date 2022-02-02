Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AF54A6A0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbiBBCmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:42:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40196 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243920AbiBBCmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:14 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212065ch022156;
        Wed, 2 Feb 2022 02:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Tzl3cnQVWVbj8T5DP5ReEDG9Ct/Od2vE7HxU+AbS60c=;
 b=RLaYTbEwLK31YTU1I/1VVMHylLu6UfNqr/QD9A89C6w+fUynxAj5ukhNZpNNG/20j971
 U7fIffZ7EuxpIwHS/RI9H9jo0CUPUM03vzeF7fpJyXnYWuXgXaQsCaiWUKYE/W8f0ply
 3BAXqhx+eKtnCh5SskCx6eX4ZB4+PUydaN5LLJQPcYXz/zl7PIzik4Ix9VKbglUUQXBz
 mv2BljewRRvrAuv1eyd9IgAkJYOp1uV/1FEbzfYIZcJhg+PNpep0rEDDyyVSLz55IX7V
 FqAAmHNkpju7R2pjohL+VpCXyAsxu3Ld9UthDxfumH7znnLhAJBiuqlsZVaVgdmVKxiz ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZvkM015152;
        Wed, 2 Feb 2022 02:42:07 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3dvumggtjf-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEyBf50jjxyDRJgf1UuYuiO6+k6u3mID49HzXPfUZq6LXQR7QSQoa/02LN88PHWvTnXJvJLAbk7U2hkwLETz74XMADhWV7EkgM2MdEfTj5vrt21e2EpNe+JDoXINYH19WFRQ6dPtzgXpyFyiJ8D8S2KhaAtQXD43SuC48kkRVIY+3t+kMeSN/6zz7XBOnw/duLsSMqltV+3zwmbbAdZknmL30vF2PgecLygVFyQuhLXwHDpO0S57sOjnaA8/9spR9iu69Rk09jrQI5bfeggTZXtYYff5u4L6rmCfB5yZdnW8h1MAaJFnonNPPc7AYg2reCA4A31THQKI76qqdyfwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tzl3cnQVWVbj8T5DP5ReEDG9Ct/Od2vE7HxU+AbS60c=;
 b=cRp7PN7B47euR62KJtw6HCscabqGD1W9wLEq16itGoKyTDLCk0S4QiTH0Amzt5lrexCE82i2REJU2nncH8gGM52kqEVARl4tKaZjPv+eRZusWYbiFqgcBoH3SzPFOy631SkvvAKC4yzULrjTPIjOueNqKWr+R6Wwc67xB0ILqqsbd/kAgpxRCCSrCRAOEq9kQlNdA4didxeStStoWY5tBcqwEG3ppTPUdTkMk0cV/ShvOO7ianXF/ye/IbCMIVISkpgBsOzKh2s10bbst2sicSxyCwRPj+LaKO+awMwOHNe6fr6bXT4JXqp7jdkX4s0zThevm9BZPFmWN3xFufq/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzl3cnQVWVbj8T5DP5ReEDG9Ct/Od2vE7HxU+AbS60c=;
 b=LBFZz8vvTDv7FcCUTWmioQwpw/WNG98t75QFgGwzLH1aeH3plQieQG0b4QrgO04DrcxbW52b+Gfk0VeOWH8buLoYnSci0CQfWxpzClleQPKQM5gmbKZs29pVnusPwD3FbltTwm0TwKDcpqlKL1amPBuoZA0wM1PgfByh+XxHtUY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 02:42:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 14/70] mm/mmap: Use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v5 14/70] mm/mmap: Use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYF951tvaSgZJqJkiGs0oQq+W6CQ==
Date:   Wed, 2 Feb 2022 02:42:02 +0000
Message-ID: <20220202024137.2516438-15-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 518a909c-8376-4a00-aafa-08d9e5f599c0
x-ms-traffictypediagnostic: BY5PR10MB3970:EE_
x-microsoft-antispam-prvs: <BY5PR10MB3970105B39A3191B55A7DA1DFD279@BY5PR10MB3970.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /0nWQbUD2ceWiAXl+1ZrucFkDG3GvuvrknfKbFFx5XFCHFe0ZRhewp5sqGbRAzL8eiKwRIeHNVzR8IL3FCkSM4Yqho0orOoHoQkuYvCNe78sSvQWOO8kK5VCq4Az8BNvt0Iy0r2SrdcCE2Mn7J72edy0k3scrp3v9i/TQKeFgp2Amcyx++JJyTQ3Ob40xfL2qAPbNg2UnLlSALPQ3sReRbMB7jtfgfcUaW7ZEY1LZBuCeIkUlU1X1l8DC1Idmx+MTznbDrTc6AyCt1BZzwl7vpstsvXYT0QMDs0Vx9SGAgxAUew3voc1YOpWf7zXOtPVzlr9oGjMVFSjD863aY90m0SDP5u2NYUK+Dc1Tni3S0/ngdbb944XEJWktePaMmahVA717bNG0WsYp7XrRQKjXbahs7NC3q79qrW5z6F92gh8107y4visBieUrBZN56t3dFwSFZ1nieCgQFJyb0XwDHUaSl6wLK/DRrhnUnojv9o1MRFbbgYNSF3b2wf1kSOLdxUY2UzTteSTdIbqdWqySsSZKXw8GDPDiukosgHLOk9ANopfvWyYW3etZCpBDPmelp5eM368WMeLYyeZWET6oJw5HmIRYoi81hZzl13SRIgcxCJookBOSUIV7GUMWy/qqrNJWoF8ZIxE/TwveEXdfBb++kaOQqlyWWPhBrGZ+O9ahuqFcTVOnD4kHf0r2LhcIg1ORTWmcqEMvDIYDG2yaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(110136005)(44832011)(2906002)(186003)(66446008)(8676002)(91956017)(66476007)(71200400001)(508600001)(76116006)(6486002)(26005)(66946007)(66556008)(6512007)(5660300002)(6666004)(6506007)(64756008)(83380400001)(86362001)(1076003)(38070700005)(2616005)(38100700002)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A1YYBEBoFioL1lz8QrORO27Zt1kgJLcgBN1MyP6oHjmR0ZGpZOISliKsTq?=
 =?iso-8859-1?Q?tGduCD2OAH/x+QyitpP4s4W435UspFBbAii87NO+nPpToo5d6DIYVhgnvl?=
 =?iso-8859-1?Q?ClUnU+i8lpX0QXJKmsnbZINEcpu4pjygxOflqpmLZLxZGZud+WeWrzifg3?=
 =?iso-8859-1?Q?kD0K07L8uykBk2SYqSDE/xLwbSp79IIVxHT5sKvM37hOkXi+niLIqwvdo8?=
 =?iso-8859-1?Q?tmQ61NpGMaDrF+tovW2rkSakUUjZptHm8q2pvxLP9m8FVmNAt7a2q1lBQL?=
 =?iso-8859-1?Q?qoo2WkbY1GldhbOLiq2IGJttK4ROZ1w1zinXeMFWyFaUPf6RGqrDMcQthy?=
 =?iso-8859-1?Q?hswRTIFaoa6Mrp+6i3OY7M4+O7MFhMaEZWlb2YH3JxEX384Z8+5JTM4tHl?=
 =?iso-8859-1?Q?7hPzIOgkqVSRVyajGlj3CfnXSYZh/k0qfQexvC0MRUSG6HuZ+u24Pcl4R0?=
 =?iso-8859-1?Q?/CmDD/TfJccDbmFUJguqsaOJINuXLtiHzL0xNTSUBbPyXIogp2ayOXLMFr?=
 =?iso-8859-1?Q?AZ1c8Y9nx0y2+uWAlSmqEMXAKbB3ZwcMjUYVE9oxaXkyZBCHX9NUiVqn8R?=
 =?iso-8859-1?Q?EgAhE7Y5dsB7VJ3g4J6cYBOf6etqJidHsz5wGIKnMmAwyQlchvqDdAMDpM?=
 =?iso-8859-1?Q?g2DafZZPt+BAMVAF49jnmkLkRiHgf0f0lyic9xdHAN7hnfI+4g7GyFuR6p?=
 =?iso-8859-1?Q?MBwI5eoGG6nkrmbWSuDQt6Bx58NlSknV+w3ntumA9M2LPJW4Ypj24XCIe5?=
 =?iso-8859-1?Q?YGCM3YmE5S5MZiy9yUc2jUbaJeiTLNeWiUzb9nKW0PYxxlmd66iP7ej0xX?=
 =?iso-8859-1?Q?jDcXZ/by8SP4mArnpZpG2nH0JT1mAxlzJ2BJET2TP++bMDh11WX117f9j2?=
 =?iso-8859-1?Q?NphaO6KzPdC2ot5xr8GnibCc93FjsYYAxNdLV0aHncLk2Z73Qcr09Tyisz?=
 =?iso-8859-1?Q?eYXaATrGhrP8qS2GgQImGip56ZF5hGdjM3T6+F2BVxM2dS2H2lZvZrTFjo?=
 =?iso-8859-1?Q?Gabk+0KX25GRcIU/TDQ1GrljSCLJ1O/84TmGKhoqn92SR6ZuJ9gyTPuc1A?=
 =?iso-8859-1?Q?Whcg7xBEIXsdmdp+qE5lpClyvm/sESwZwTA+zOK2+GwWhFd5h6dnj/vvA3?=
 =?iso-8859-1?Q?bp0fLvz42O1BJhISGL6bMQJ7lp718JFZD0wuoCWaUCReh7/aWQfRYEDydw?=
 =?iso-8859-1?Q?r5qbcifnrXxrTk27/1lUBU+W9X/kkstiNfc1Bc7dCyKyiE1rk4iuH+goyv?=
 =?iso-8859-1?Q?CgwjzMU38ko4ACAW/SaXH/jcFbYdpjvXR0IcZcZTBrFCtqYmKiHOwd9rc4?=
 =?iso-8859-1?Q?Ix0rRmnhkS50ubNAohLAkc3dG/e1Gbm31uP6WQPAK/F+1gcS4MupM9PzfP?=
 =?iso-8859-1?Q?z3Me02SF/QM3yrRja5TD6ghedJEc8kH/5Y3AheEyCAa78907+NYJ/pvdBF?=
 =?iso-8859-1?Q?8/xmgOaU4LzSJwUYDSPfnGWTiZSxKLsuMwwdXSJgLT0Vomgo4ubwlzNsGw?=
 =?iso-8859-1?Q?8yXOEW6b2Q6/hvjgwki0D6e5rarLPH8q4FBJmSExPSpRuy3vt3v3CLKLdR?=
 =?iso-8859-1?Q?BNgTgoDyuMxfOtEJLWIDE0mnl4XCtShHlbsv7tmbBTNHGB5wxy35YeE1sh?=
 =?iso-8859-1?Q?8VkyLnPKvSNRAzGPMHVg29kAseIHCdfRMBiey/akCpuIniP2wX7lZifIU+?=
 =?iso-8859-1?Q?k8v6bPbhJcwcRmY3SBQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518a909c-8376-4a00-aafa-08d9e5f599c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:03.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcDEBFC6qrrE7FLGohnhNtGHFvN4N98p+SiCGOCqUZn9gWSqjeJVfmYUKJ7g7ybBLglh0m4Bd237TBsPCuvIzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: h6vEna-RI1o2yTQDw9AxbDUU_lxmF1qz
X-Proofpoint-ORIG-GUID: h6vEna-RI1o2yTQDw9AxbDUU_lxmF1qz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code.

Add kernel documentation comment for these functions.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 253 +++++++-----------------------------------------------
 1 file changed, 32 insertions(+), 221 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5c331befe739..02b12d7dd362 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2002,250 +2002,61 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
+ * the correct alignment and offset, all from @info. Note: current->mm is =
used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start =3D vma->vm_prev->vm_end <=3D info->high_limit - length;
-	 * - gap_end   =3D vma->vm_start        >=3D info->low_limit  + length;
-	 * - gap_end - gap_start >=3D length
-	 */
+	unsigned long length, gap;
=20
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
-			   length);
-	gap =3D mas.index;
-	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
-		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end >=3D low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >=3D low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_left) {
-				gap_start =3D vm_end_gap(vma->vm_prev);
-				gap_end =3D vm_start_gap(vma);
-				goto check_current;
-			}
-		}
-	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	gap_end =3D ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length))
 		return -ENOMEM;
=20
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start =3D info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start +=3D (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap !=3D gap_start);
-	return gap_start;
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+	return gap;
 }
=20
+/* unmapped_area_topdown() Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from * @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	unsigned long length, gap;
=20
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-		   length);
-	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
-	gap -=3D info->align_offset & info->align_mask;
-
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end =3D info->high_limit;
-	if (gap_end < length)
-		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length))
 		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	if (gap_start <=3D high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <=3D high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <=3D high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_right) {
-				gap_start =3D vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
-	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end =3D info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -=3D info->length;
-	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap !=3D gap_end) {
-		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
=20
-			while (dv) {
-				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
-	}
-
-	return gap_end;
+	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
+	gap -=3D info->align_offset & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.34.1
