Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7194B6F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiBOOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:46:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbiBOOpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209E61160F6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:10 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhvWl022181;
        Tue, 15 Feb 2022 14:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pq8BsbnDfrZqeESMo1PCnflJwYLvDx1XFEkEc4GYrNw=;
 b=SJz406xU4jQTOj/XzVSPon4AKn857Eack8y10kyVP7CnxIDst/A9JyKL7KIm1hsUWLlz
 ID4/DXMKyXuPM5cSZumeSgpwpdcXkSqzKh6Jt3eraZL6VPj7+qcRTBumWXvzNp7HtFMM
 RLGsjso3TM38t6e2haVl/3lVecCyT7rQIDTAZO5icTJJNTKPNMjz9jp1yu3wQcGb7JSt
 BRmkkSRFjGq6yfBqBx6Y3mOO5H/uTq3cG9nnXuDujZlttKRgkF3i6EEN/XKrt7hKkF7Y
 zkt1ErN4C+U7rFBRtS8o2NWXiHX8xmo84ud7JZuZJvoTUhU/RS49nXOsUI4pnuAnQVwn jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4Q145723;
        Tue, 15 Feb 2022 14:44:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClzaqOkLNsAciBiiqaal+e+D+5TIuhNHH5ulvlbjascBEjlxmQRecRoElATLLB4xxmuYWO6W6O5VqoPt+yn65tGCAptv2Pb1vnwyqPOjJRws/woBVsnUQfaddm/Y7p3uJ+Ny6hLEzjY2ovYRt2ujt1/cdZnSlT7tbpCwN2EK3CtJ9qJkz5IVdg12D3O+ks9EhzPeHf9h8+89M+SsqumpFarayzYUznBW3cOq5l6vLoOQKKga12MDzVJWCA1cA0+SRuHK+uNp8yqq2LoAzE1wMrhx4kzG1wMB3FwdQCU9Rs13BCCvkQmOCuEMzpTAhuXuN/io2e0bqJ0TzwDgJILOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pq8BsbnDfrZqeESMo1PCnflJwYLvDx1XFEkEc4GYrNw=;
 b=FPiFlX4xqn4ZOnWbo2Qca9jyx+UBsGplo+0afL+5xjyt7t+dbRhsGhaIV4j42bGfMa2rVyVqaodwfdI/qoaadWSrgsmo+1TALBmK6DyyaR0OZyGom9to83AfZY5+3rhuTKG4tKTHjEkmsObTrFahvHZmvO/9TfgqId9apBI6egxpz6R4m5Nl9zDtMnfVxgvOWseaN5IoK1F2xaZnNqFbkD00YHfcfteccUxho26ssdnItu/hUV+wo/0sp25n2Byoo4pAgjrxbC2jFCgkKTsaL4MfZoilpqMNLPbqrn2fwM2nG74YbOxSPvyPZf5BIrgP0PIMLw0I6oI31DXUWBhFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pq8BsbnDfrZqeESMo1PCnflJwYLvDx1XFEkEc4GYrNw=;
 b=xi64paBFKJaLtaKqHbsf1NAs4Pf/rG8HOFQx821CMOVZw/orb9pWHSqRHk3govXo7C6i6+OU3eWyY5hLhGV2Qza5gGgkItlveUmRONk1ZeyCkBcI/aVIOegZV93MvD9z+BYcOqQVz9HY9GhBKw9YgVWoR7pAzP7YNjuCjrogct0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 49/71] perf: Use VMA iterator
Thread-Topic: [PATCH v6 49/71] perf: Use VMA iterator
Thread-Index: AQHYInpgicPZbw0hXUOpg04Y3eiotg==
Date:   Tue, 15 Feb 2022 14:43:21 +0000
Message-ID: <20220215144241.3812052-49-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9105f7d7-47df-46b9-8c41-08d9f091990d
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5578C57C6CEC5BBEF74008C8FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XvI4Lf++eO7fbAHdmLQkX+S3pWhdxwWUuya8vuaeb+PEFAEWbNErEzvh+BUKq2v5ASsrNPaVTC40z8QTsflqGqi5cX6OwQ1B4uNi4/CjIyjRg5xqs2CyhDkBLd+kaya4qcd+QngGmacV3gY2f85/yTiK+dz1Rbv+ZgzuPMvC+FAHbn4oiJKTritplsDrjeDeA/CuwjrVDhBn3+4T6B8IDnZtAuSVkK7LLpkurF6ljcw/saNLYa14dL1TSQyKGKyrh5W3/vfnbm0UxFItPgpYRscAXofxZQwrKu/4HmPvIYJcYkYhKZg9Zq/Kv/rkkpn2nV5QeF3BLNRZwLAfQWgYRDTArJfpBwhx7WBf1k7IzMzArseaPNyG/o/s0Y8jXDEofXR9A26BL9ABIgk5IetIeLBLZOQGu1BLZEPTQuveHAGv57CLO2QxETc+xHVKVh8XHk8FZ58NqCpABFq4dsR4YcUhottByPEA6gPhiJD/X2VzeKy5k6Xm1XuPQGGwO3cuwuxFysq94C+JmxYxh/xGubHop/t3fL0Eig4rkVZkZ4MS3gtMl0nl0n7WrXjJ94GnPTaRJEawVMTqa+nFhXncBkEGMrqvvrBAQpwNo8HlDCct4nNxYUXGUzAOl10gcgBFY+vTeRK4y9aoJUzTmy4ajSB6G+3cE7g23b/GVtE+gf7I5de6C/gRFwO9QWWa8r8lhJunVYBPotl78ZVfNjJyXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?srwOwkxeEGK+yubYn07oEXH9zQ9NMYwO23w/i7VUkqvYEDHCjCKMLM7MIE?=
 =?iso-8859-1?Q?cSm/Zjip+O4ZdR7eWQG3yAtbE6qZK6ZeT+TmDYu4PupNs34Fa60MvUZ7uO?=
 =?iso-8859-1?Q?WpHbCz7bmf6IWsjb+TsQBjeGTXbKLe0pWgmDV8r4KA3t0FU13WNFBNDCcf?=
 =?iso-8859-1?Q?3spOx+V4AgMVouD3qtA5Ev1fV+ez3GQxLc08j4nexjPXRwFxvgdryKuN05?=
 =?iso-8859-1?Q?5wqSvjDUpHWFPw025Xk0Bj3x0/zK6pyU/OxkGfmx0vmNRWGySKXlvpM2ph?=
 =?iso-8859-1?Q?oKleBz4uX+XbBADw2u1dBRKXKvKLYNxzMgxBb0ZogczuT05MVv/FV71N8I?=
 =?iso-8859-1?Q?kHB8h4QYRXkEWyI5L9LyR0Op5328J0Ncvh6q0YUbVnp9IUm1IWkLqL7RVk?=
 =?iso-8859-1?Q?mOXvN1uijBBtRUJWwaqHdKKUSvnNC89iu+sYpOf8hoL6dBAtSGcO5VjB7u?=
 =?iso-8859-1?Q?8JZ/QpdfjhtbnkqAXE5FGPGB38Jo+LTlpNLXnlYYgDlLSCWNkJrbZAebA8?=
 =?iso-8859-1?Q?3A2Clf1AYkrxwluk398fdg0NRMx4/Wx2V3EaVT2k84IIcP5+7EZxCXZRHN?=
 =?iso-8859-1?Q?umlc5ybkd/3FgRskgtR+auv4hfMZdzjJses+lgthcPYQF0pEaurSatDlGw?=
 =?iso-8859-1?Q?+1zz5BJ2yFav5O8R+e7uTwLu/BhY2DCYSMEd4ORy8sQV1kDL5frcVQrQEj?=
 =?iso-8859-1?Q?QWO8Zg0S6TdZiCD8a7YbT2f6NTPu3iUKVjB3w/r6KAG4oqalJt0rN9e7LX?=
 =?iso-8859-1?Q?rJpZZX1+o5BfkY0uC9lCSY7z4PbAZ2Fz1zIIE6GlPa/iXJKCMNMOpqhe2k?=
 =?iso-8859-1?Q?asU8B3pFDd/wV/b8BuU7Je70z7eLd/cK8cSDXIlx9rq/XlOgXsKk8/5SM5?=
 =?iso-8859-1?Q?213lO/rZdyWM4JyHVOAcyW6cFa4rG3PTYaeahGqGDfTYx0Ac+L326/8bCd?=
 =?iso-8859-1?Q?LE5kZvJDtpd1+wcPlt3BtJUROfEVyon+OMKI1WQ73ZIfRwJqLBlWDEytJo?=
 =?iso-8859-1?Q?GaLixKAwril7rFaTJ9M3bYGAxDipX76B504v/U8FH7Dr5rhxJWOz3BKhyt?=
 =?iso-8859-1?Q?oOe4aovvlNs4xk9SzwgSEFn2fyGDJS0qmPXS8021ju+YVbfR/zTEtmTsXR?=
 =?iso-8859-1?Q?A0WvV2KJlai06lr/3/LJ4fLVvJVcnAo37OkXQeHEJAAiPUqkpAF2/hcD9b?=
 =?iso-8859-1?Q?5UUSD7ph8qCGXgbLm3cmcH8jZhL4JIB7pPQRVZpb62LhYuH6/T8WTpBjHL?=
 =?iso-8859-1?Q?t8EN93+w59956tYnFx9wrZEoIhQfgG2N3Ch/BNUDmede5fq2jCzjlx5gjH?=
 =?iso-8859-1?Q?1qilQlZu0kROdHHrmrYdbfWJcva4B2hVYha51BRGaggANSzwyVOxmLq2q4?=
 =?iso-8859-1?Q?vCCwYkg8/Qv2JfQweysPukPlFvq9RvGjrD5K8vb06/sxJiwt9jqtDPblPW?=
 =?iso-8859-1?Q?17uf712F2pXeZ1D/bqGSwbw2IGsmJPLpjYj8lalc5ZDmS5qm22PevrrSTG?=
 =?iso-8859-1?Q?NC9390q42KKiVo2121d2/tGpIHI164r2YxK+2eQyEbjVfJ8kGz/M+yalah?=
 =?iso-8859-1?Q?mHsmBFPrl3u0naV5Qm4fQ2+dAej1LoGUjqqCUSC3TPTlO8JANuLwHIEiv8?=
 =?iso-8859-1?Q?OaF8LL6Ys6NNlNG28HqYkyRGD6kQxd8jAE7f4TLrShYfchdgcoV1BwHUEo?=
 =?iso-8859-1?Q?HysZYBFc/sjXc5B9YT8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9105f7d7-47df-46b9-8c41-08d9f091990d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:21.5730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pc5kDjYl5/LUXijMbvv6sPA3zbN7Wtfmj3SbOzkNG26S54PXs9CvGXXXfpdIr2Ax9yeGZF2zKopna8mHfNcS0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: OkSAs9nYU46-5wvSooeBqtAkPy0SXCZw
X-Proofpoint-ORIG-GUID: OkSAs9nYU46-5wvSooeBqtAkPy0SXCZw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/events/core.c    | 3 ++-
 kernel/events/uprobes.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6859229497b1..935e738a5eb6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10319,8 +10319,9 @@ static void perf_addr_filter_apply(struct perf_addr=
_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!vma->vm_file)
 			continue;
=20
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6357c3580d07..5dee6c41f36d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -356,9 +356,10 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *tmp;
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	for_each_vma(vmi, tmp)
 		if (valid_ref_ctr_vma(uprobe, tmp))
 			return tmp;
=20
@@ -1237,11 +1238,12 @@ int uprobe_apply(struct inode *inode, loff_t offset=
,
=20
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int err =3D 0;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1989,9 +1991,10 @@ bool uprobe_deny_signal(void)
=20
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
--=20
2.34.1
