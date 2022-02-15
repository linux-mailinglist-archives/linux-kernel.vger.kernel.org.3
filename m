Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478FA4B7347
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbiBOOtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:49:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiBOOq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179EE11D791
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:45:35 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FDBvXK007505;
        Tue, 15 Feb 2022 14:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gm74/0iA/LIx90egKsskfSSmwq94iUjGww9YFu9eATc=;
 b=kQv12przPZCx1aVwzd1Lg9sf9/2Qn0Ifju0h86++HwwXHkGVav+Zw58cPDBT2KycH1xu
 BSCSlwdjw+qhIEHGuDeutMk4ShKdJ9dPTMHWta1YgdTPvO8ofItEJGaDPQ1L9rKI4cgL
 cNE0zFJ9A1nFDwDirO8u+a0mDAR5gjjlMjOYbgECL5Hhk261zjjnTbPhW6Dkw80V4ekM
 uTNEmebU6LSJ66Du4+08t0hAkvtpYiZokZkCKn5FDyr5BNqHPYGh/FyNULRkjYzUZgKA
 LMjunrhrA8Tt1MZRZAgftUbuTi/+X+E4VoUZpNe9+QqJqlJg2PjpwdutxzRwyOJtjfRC Fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8tn016271;
        Tue, 15 Feb 2022 14:43:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 3e620x7uun-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckDY9Jkso38VnauNwCV0Oleq0zSc4VjtI+yut1lUZd8gb9MZxVZHVlzgRk0PwYBh9f0fBcAkYGcDCDh8zcRLflxe/PiY/OrCdYVNtqlg6yCh2YPBz8NfgTxnRLJcgn5VCvlCPPxN8fpr5Slyiz7zqFqP9LP8VCtSQXYubWmx1vai68DaOwIaEXKYtM/tyzhn8C7c9Yxzg8QEXrMJW7tdDfiqX6jN3ZamOWWIJwZF9l1P0uzcKmK8IdrTtL9J0c2Q+EevEdIBlE8LNMOwWMrW6MqalJVK+ACDMLKpGHj81tV35gKkOXYkQDSFYqLPV/x8RrXUpq9x8s3a5cVlWvrt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm74/0iA/LIx90egKsskfSSmwq94iUjGww9YFu9eATc=;
 b=Xn6FzrgYS7IZB/MKcXLuzg9DDEKSGwS46VtyZezMFMK7sUiMKgOSo5Ig3GqoJ2aGiBAahFqY//kcOf39RhTi/LKj071/Aw6BpbBoN/W+GUqGA2kAn+hvOh8MkChG74LR5RpsbxmaqWdO12GXTs6DyoN2wV7wwMiPyWYgsOAKVm2pOX+SmEjkvW195SiWErJBIighcL8WZzKBVzmXNIBZsNzT7XQRV7IDkaGxRgAlKC9bY8BcmxBlw+bWp63wFMkeS6mrn6nDMCHEIltDx7KYjcOR7H0zscKs8knB3S4LM8AsBVWMpFhzxeLnVcgvrDLb0X1rQL01eMl8mnL1NmEhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm74/0iA/LIx90egKsskfSSmwq94iUjGww9YFu9eATc=;
 b=TbH8CLDJhEwxTmb+YzrnYycijZXq6Av8P6GuuE2iggU6FoDKj3iESaAN8P0nXzLuFfuvOi8wMYMgEoA/21wdyoeOPjPSScF0yU1IeHcHGKXn8iHxXyybtumQqhxvJ+yAinYEu8aRzhsR2MUJsPcVZj/XuTxJULjTlqm1S5FazpE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:43:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 18/71] proc: Remove VMA rbtree use from nommu
Thread-Topic: [PATCH v6 18/71] proc: Remove VMA rbtree use from nommu
Thread-Index: AQHYInpZ/zxiTprQF0O+xati8ME+zw==
Date:   Tue, 15 Feb 2022 14:43:08 +0000
Message-ID: <20220215144241.3812052-18-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfdb3ac3-e1f7-4877-01e4-08d9f0917e70
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB21978B83D35EA5905C718EF8FD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r7wiXUFw7BhtkQLv+bpvZFWNlZnwmSKM6srbr+dT916yt+PaoZybmcW7apKBTxlAcLY0vHTSbJcdtiThAJqQDMdIa153Sj5Hg8Y17poeFKcKn/XHDrdxjBqS58t/KJS2MrltPS8JmwcllEsfakBLwGrsPcKkcEBsW0x1IQ77k2yLcco71QseWEMmnkDsJxeRtMpxMDQ7ZS9L/i7Ii59NSCO295/HrW2hVM9Jsz0xm6DOGz8rqiGSxQ8QwQXxmjUxdeGevPE16QwmRTi3jztvM1LM+yGpK8jMCxSdxkfazueScRXd3fVGSVJ8qkJEWYKEpuuNZpyNvrGW//h+Dq3AE3eqPgGHYYfGE0Lgq3MtrgE0PdknPX/uMuuhNFp8N1k1ilRdV22I6Ktiy663rgB11JhLXjZ0FdP6uZuJ1d+xS8ao267vl4rpEoLOq2B/sWlv7yKUsB/hqZfpMb6/3uAH1nu2NlUdKr6XC9KmE0XRsnazL60rPACgbA97WYw1KP44nC9o7taUYOsYWbjvRI+YYp9wuXnkAJpJiSyo+bKL59f96gNXkB21FmUpkkHpzjcSQsADvun4t0YQbxJUydJNTxzxHkNP4Wsj1BgB5edizFwfvkxPMJqTdy4sxnlt6dPmmowFmzTOWlGJQHuIdnCKZ1Ve9TFrMYWq4ydNkLbamnvb+aNzmbEXNqlDuskOxdociEKAc/CK5cSmK/YbIH9yVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(6666004)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ERxXWBp6Geu0jFH6AJpoLooidpUBqA/fDaoKe9PDmmNF3ga3Nk/F9YYsQe?=
 =?iso-8859-1?Q?Ny9TkjjcfIMvnyND+blC3k3YlwdgFMPm6ufvKb9FFtCQQzwIwYteo+K72B?=
 =?iso-8859-1?Q?/IItzc3DLSmAN09nKw0o2B6lIv5s2vzZ1vYTTvmWiRskV8GJQLUdJk4Yu2?=
 =?iso-8859-1?Q?ZDM8lb1DvuW+mvab4/7exXOHypKgMQSvrzVE1JjUritMasBJWnADtXcm2n?=
 =?iso-8859-1?Q?C+NQdxjeuujYEBVrZ+2QgmNpZL0DqC0c9HQEm1j21WxmYyf8U83G7aNkMJ?=
 =?iso-8859-1?Q?n/x64ttohluY15EBpVSC7ndA6HyyC4KbusYDKtW8ipieM7G49CGCcZIM9x?=
 =?iso-8859-1?Q?7dUiAi2Auz0hgiUTdIoVE10TCWi2BNIHhG1eIjSqT0BNgTg5W6AmGab2mO?=
 =?iso-8859-1?Q?/AI+BqHuQRi4Qb7A1ziowyQ+L6YO8BfN3Kb45M8yFFwYwk7UQczHss6UMp?=
 =?iso-8859-1?Q?yR0RJxgFGROVDTSWv8M7KjwiPZtMrOYPN2T3QYeh4Wsu70un7IcW2BeJ5b?=
 =?iso-8859-1?Q?EuCi+h6PeiqQ0YtQDdoZcX3PgU5LWZdjhlAAmctwE1+aDtQybCcY9rApX1?=
 =?iso-8859-1?Q?Dnn5Fh7O8qbrlct2hHPa6U/CbddfPx19YcOU5WuIw66zYmhTmEBnT2Ckz8?=
 =?iso-8859-1?Q?ztO9sj31z57KfupVVrCfptHG7vN8hZar30Jiq3VL5XvCWzqCEqixw4/YAn?=
 =?iso-8859-1?Q?ar04vXqR3RbBPFdPQPfChJW7kgI0HWc7d7Vj6nKMA33+mWbtzLtlHeE8iG?=
 =?iso-8859-1?Q?ayMFWVQr3tab82CznPOO51KH1lrXPnU7G56SRUfZx40/HRoPcx7l6lhf88?=
 =?iso-8859-1?Q?yA3e+neJnjL0g0YSNVIhW0LHz12LTtDhpyqSE5X8ti8eoE+kzHkXKM/Yn1?=
 =?iso-8859-1?Q?8/ZBWWTa9EWAMn2gpYHoLzKxLiGD1mtPH0tssNyf+Sq+4ptUMCwHaApXHD?=
 =?iso-8859-1?Q?eSW5YQL/rj9pPesF9Ev8TBS2bm80fiuprguIWvOpqG7KFyYu9qf/7we9Fu?=
 =?iso-8859-1?Q?gVoLK8cXTFmWDpgm7yEwUPiOcRJw4n4/rJS2UB5VDThCsNTbGTt7rmzvjS?=
 =?iso-8859-1?Q?89HN8XB2xOtOJ/NRMK23l4SHoX+2JbfNUz5lRyA/VkdodY7CpDUXgr9Fia?=
 =?iso-8859-1?Q?a/ji/hK284wbM76vposTqVXk5QhkzQOc563i7iHTFzuMLy4auy1lXfOCfc?=
 =?iso-8859-1?Q?Rrlz36Ni0Y8h4sFhS/KVBVLbIz9odMBddsQKbOHCGl/sw3+5QIUpGHYPjF?=
 =?iso-8859-1?Q?zUstviULiFv/0Wx19PtOarvjxB62nRZVoyYWQzY0ibgYcyU0dmFqvq9pC/?=
 =?iso-8859-1?Q?N1EircVAy04fM96b9Arzsyxu6JKAEzjiybSFp5SUKpb8ddMOKQl4xb5caF?=
 =?iso-8859-1?Q?EArqFodUgp2wkI9RRwy+tB1ZrQ3lurCKrU8j6R7MpsryCGpAcHtJyxtBac?=
 =?iso-8859-1?Q?1XVMbhnhUm8wXVXEilXGT6DbdMUpVvvu2mVeWAd+Vz3+vDI9Vtq7ZeO9My?=
 =?iso-8859-1?Q?FlSIuQhd6Jo5OW9kAzIrICP0VMdk4gh3wyyQXjPpU6f1SJSDvNwgePjbN/?=
 =?iso-8859-1?Q?ew/ILK3LKG098+pUIrwFiIMHB0Vlmdeyunc6CEVezbP0S/M2ktnZL5DpGb?=
 =?iso-8859-1?Q?87lsRacqviUK0f44Wuc+yIKoeIPNh91eIbIjdss3xrNSj5PZcliQWiYrxh?=
 =?iso-8859-1?Q?99mfQnTaJWPW6792oPs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdb3ac3-e1f7-4877-01e4-08d9f0917e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:08.8551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVhFBO/AJAOV6TxQ14tT1mbit++OQYBNUQOjTpc/I9bnXBQ+/tVJoW6fyj/Q+J8j6ox+mceRxlPJCZ/kslmbIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: dheciiUYJ1rJ1WH0NljdKuquqP8f4QLg
X-Proofpoint-ORIG-GUID: dheciiUYJ1rJ1WH0NljdKuquqP8f4QLg
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
