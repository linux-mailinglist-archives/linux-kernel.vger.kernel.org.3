Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A79757ADAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbiGTCSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240897AbiGTCSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29D0481D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:17:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0bCP3003860;
        Wed, 20 Jul 2022 02:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=k3oxQRBX+ZtXJiK/59T/xjtRMEADJ3xNle/YphuQ1qM=;
 b=tdMFlLDV8XLX2UdK01067IN7+ieVljVVQMgB2j2orL3/dTr81J2ysUb+ywiFhxi1fchl
 7/akOsF0LvoRAHMwb6ZDsasVH2ZeLe4+010Y1ibFvND5OFuXhHnnYv73kdapBD3hTE4N
 yYqo8yY54YsQb1NzpRCjg/oTuwbbrcZduJrpciStVzF6kSskjGU2eIkPsuGZ9uGB167z
 7Xr4hJQNhQg2nrdgRNLBTzmSD7+DMmflm2eqUXWWJET1uJ1FI/zVSxT9UmroPZpLPAl5
 TdlhUQCKNl46bByaiYswdt/+uBup4K5ULddO11io74l3ufP7nUlwRUJmdjXUopgyKIFT Ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs83k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHLKw022321;
        Wed, 20 Jul 2022 02:17:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseann-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5yIJBvA3xBlasRardYF3Y/lUQIbsQBV4DLQ3HYtHV4gnklHLwXoPwsG+kzsrSD8ioKs3ft6H+J4/XmtUMVU4vThIc3qv6s7yzMq8tv+gxXR+PtnEOE5fEFg+VWh+7EPppTshtamlAMcBymmJnyTGB2bQlvEFj3yEbS+wkvWFXOyuXsJp4GoShZiAExh485H6hI09BI5Zsd0AA5bsf0yPby9MIk+p4gquMIyt+hK0udXyzX0ZohB1hW2EEk2DLaUexYCoNliIguaLpy7bXWwcP3s5P3SGzST3+bHEy1utAfCrNrXais+PzMFG5wzMBOKlkFwglr+4Rd9AkVtmq4Qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3oxQRBX+ZtXJiK/59T/xjtRMEADJ3xNle/YphuQ1qM=;
 b=k7Pgw/055CCUZr7mTEEtoi49+cZQEfbuc4ZfmGm1qYTjmi1G37dQpC+PW/6XH7cJSYGLzhaK2Kt0kajzmmrZfw7Vz6JxViT2WxCGFeNNr6PUvNuAEKZqdHluqC8kWhebkL1pHUgiAz7gmVm7+zqc3beAWQOaUHpK/Gc2OTkWVpWZzx1MF8sAOdQpS9unc0lBQF9yKD1V4IMnLPToz0TdaRgEST2dShZhQVXrCQ4s41o2DyFZ5DJvNcx1O/fP414fIYT9rH3P3cMjPP4vA3biIMqLR9ib+vUz7S3NIX/GF2xIwm+pRYjNpXR8FYL+SIYXmsPiuG3xvBae5JclKI0FVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3oxQRBX+ZtXJiK/59T/xjtRMEADJ3xNle/YphuQ1qM=;
 b=qaLle4TzCInC8WM29aUxlTpyE9WVyAhj9I4l/wPef5QPTA9lTxbvvdOsitQ10VfbrAFVVZ7dIVEmxE4Oiiv6Ke0Z0WWeCktQ0XDAL+4BsbDE6l3f7zpKsUiEYvX7IZ1IYkRmFOQ4YVL0kydmFKnN0dVeAGCVu03ROVXyghvtLJ0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 11/69] mm/mmap: use the maple tree in find_vma() instead
 of the rbtree.
Thread-Topic: [PATCH v12 11/69] mm/mmap: use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHYm97nr1nk64HIzUOQREHypCEyKA==
Date:   Wed, 20 Jul 2022 02:17:47 +0000
Message-ID: <20220720021727.17018-12-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f47a11a4-71c6-4a9a-1a90-08da69f60ab0
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ToX5MyXtfhzo2votqEXnOoQQy7GFRai4gnBTpYyG4pRGLlfKIBAXyc7dj0ftZS90YfG0Q2mhatiw1aKM85AilWOxu51BlKZDxXin8dPwjXXklTd5QwPtOTy5E+KR8OI2il/+ilkAz7AZV7uyeUh9eD+7bWEM4P1oKn3cOLPqcqPf4oiXKOAc23GhXQHaMx9AMryUgVPX4xZK6GZmvN9ekkplu21VyIRe+LPJ/NKlkeDS8blQWXsAYD4wK71AX/Z9nft7clZptSZ5EuCUgYBK0eamHjmP1nPKoCK5+AVihhV19+6hwiUWHBDtPZ0SOF5M9sG+/P1p/MhlflBERC5bTuunny4wIwFoO2/5TM716pfgxSHLjIaPoDVoJkGIpgYtsxX9q4MWzY7Jx3yRXOg1dBSy2BR6NipY5ZtNOyw51q0NM3xXhIoV/2MGaeQsdfYqKvADisBEIqkgkPVIGGeti8Ygho82SLqdvAunBC5CBmTrI4XQxa7l6aGYECxJjJIG7AtyXABphIc9V2WB7s7RmgDiEX/uXDlxVcB7FgQdYzUawkMPZd31ar3I/kPppjy2nZNIP7Mrgt2jTd+yzgqiHG7F/zL0+R7ezSv5YsR7jCsNHRsUb7Fz41xU6qAokjY6zxnqZ4FQpJfln88KKSZ2dEEA/xGrFDb98VL1Ijq/9gMtYyo68ZfA8akcUTLwjHT21oN42Luylpn2TXlMRJDlMcuB30k7Wo5z7OEkMb0ivLwc/6CG3Q8vEzaPdSJi48quyisM1m15OCxe4Qy0OOz/fD8OSrx8T0jGFmWfNapDrYbJYQy3RKPBt2p0oadWJ4GAm79wNPGtpqweUrpEDd2jMG2yXoF0ydSM/e0TGHAz7fbm9pLH/Ya1KEso+L3xGx1M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oHa28E/8tNdU1dPo3lKVZZVy5sjfb8C7ZJ3/+mxoWak9ka8fyLSF4coVRA?=
 =?iso-8859-1?Q?9/HuBllFN/feTTaKS4FMYp3a9O4ytfR4UD0Q5ycneCLcNmIW1qjl4828AB?=
 =?iso-8859-1?Q?nazpdeU3HCZ+L3kp1sCrfT7toQeGiHrDGu5i80hcL122VYK5ynvQFTiSZm?=
 =?iso-8859-1?Q?I+H9axYQrlNHqR8pqgCBef0anlQGj5L44cHUqT3eVOHalIdu5TqLTCu96E?=
 =?iso-8859-1?Q?dXOMxEb+fK3vdgh/S0BP9dXcgVnTdKPv1wz1q8PSfRQehTQujK4awfJGDT?=
 =?iso-8859-1?Q?JMSQnePpSdUqzLwWe2I2xDeWwMzuCdCb7mI5Sq+RvWkLxmWxwi2NcT1csD?=
 =?iso-8859-1?Q?4SCcdtqDPNDUAqT11Daa+r68EpcjUMdFir58J70IS5IWigL/jKKgjoe5E6?=
 =?iso-8859-1?Q?wXtFXUAFqfho2mGcUSiD0umGKfjx6IJ9N0dO55H6vXhr8oA4Xsbo9UpkRv?=
 =?iso-8859-1?Q?UU7/IOAyW9Dezd8O+Pt86E2rtkk35SdmCGbBT/b4k6Jv+ArL4sokhUfXVd?=
 =?iso-8859-1?Q?H1q8ju8WxoiYr3lc6/Q15pzerUkmZ7/QBo1rMmRoggLtWdLsopOUkLdYmS?=
 =?iso-8859-1?Q?TDWvzeLqUIQGc9VTjNGQgpGJ/GyFX8Se5dYUoa3Lmekdi7RTCPLKObvG3x?=
 =?iso-8859-1?Q?sz7RDpj2ebYDht9l7lA5hosIpAb9wvQt/pMSJOds5VArig0Xa/jozCGeFm?=
 =?iso-8859-1?Q?PVCt5pEE2IwsdWTxP3wyYdP3QTKJ4OpbuzrF1HfD/Qwua7IdJP9Z9GHDat?=
 =?iso-8859-1?Q?5mC5i6l16jFUM6DIYxbvlunyJNTyk+LqYWYfNrtopDyWTW2m67UIgH2goV?=
 =?iso-8859-1?Q?4T14SFy1VJyRQM3x0Svh86zpB6jwGBZsj0k70eBcdtdrAY6I6h6F+X21Hz?=
 =?iso-8859-1?Q?KLSzCLdPBRTmVS+cAbGAnHZ2ek9mXr8nMEHkvQ6Vm6IyPGlgTCGwnaLaNe?=
 =?iso-8859-1?Q?wm0zx8ICgDGzwWqtszPy9ay1zlUFXv8pGmFKUXa8fb2hiimwfsU0I0euAq?=
 =?iso-8859-1?Q?Z/u8rfy8uMd2Ln6aGCu4FnBrnQkgIyyEHqG9pPp+u9i31CT6XVHbtgUMKJ?=
 =?iso-8859-1?Q?4pDsQ2oQlzchGD5VEO1tn1AvvtddNu6GRyc5PxScHFZPSmglts7YLm+1KA?=
 =?iso-8859-1?Q?+LZg6lEjRdjQmQfnPJIPxKiTScEEnQDIr06TQ/H0hZtY8SRxX9qiFh7lWa?=
 =?iso-8859-1?Q?3H+j1NVMERMrsmsZpRWvsw0eEzM8fQ6nl5evOmuX4DuNcbxdH8VckBl/ci?=
 =?iso-8859-1?Q?jPBo4G/2IIsjpjeAAW+0NWCtjgnRtYDEZWCZXrbtvrjL/4VE0qCu4nA0l1?=
 =?iso-8859-1?Q?C0FZDsOoDuYREyvLnolx5nliRqxGLxBOvqb7Qv7jmcEpy1gyOzqFH9xqJp?=
 =?iso-8859-1?Q?jEp62HiwN067TN3Y3g4dQDF7E0PMxBfCfU9d9y5uIWlT1TaqwS8kKgrbur?=
 =?iso-8859-1?Q?9ENOFK+daNoPguoMxaL4L1imX1eqsuHEvvEqyPlUx+HEDttb+ANSn6ITVZ?=
 =?iso-8859-1?Q?+/S+1IPYVSXkAz/EucyarfciqDey6HiGIGhsXgIxBWan2ccnGrPV23w0uK?=
 =?iso-8859-1?Q?rBFUYUrT2yupydDw8Ccueyt8GonG1WWmxUxafPz1ekE4MbcPPLMizzK8ND?=
 =?iso-8859-1?Q?2ZnZly9YKuXWV5LnifJx700s3t9A+ob57lKWrImIBRfIi0VRegh9y97w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47a11a4-71c6-4a9a-1a90-08da69f60ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:47.1188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kqix2nsBbw9qr3L4bRj9jmoe1gtja3SJZEgo7hsBb/ZORImPcCm6Lx2gEvyKhAxetcFFbXlyifzqouRiDHxIFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=882 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: aKvehXTobcqvsaysE19-b6hjo7MyjYhP
X-Proofpoint-ORIG-GUID: aKvehXTobcqvsaysE19-b6hjo7MyjYhP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Link: https://lkml.kernel.org/r/20220504010716.661115-13-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-12-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1a209b61896f..208deb8f55a9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2491,11 +2491,18 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next VMA.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next VMA.
+ * May return %NULL in the case of no VMA at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
+	unsigned long index =3D addr;
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
@@ -2503,22 +2510,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
, unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	rb_node =3D mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma =3D tmp;
-			if (tmp->vm_start <=3D addr)
-				break;
-			rb_node =3D rb_node->rb_left;
-		} else
-			rb_node =3D rb_node->rb_right;
-	}
-
+	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
 	return vma;
--=20
2.35.1
