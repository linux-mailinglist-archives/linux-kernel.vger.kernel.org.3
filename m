Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32E34B6F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbiBOOo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:44:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbiBOOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135AE105A9E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:34 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FCMtvX024375;
        Tue, 15 Feb 2022 14:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8rzf0Rj04YS6Ao+nAAxGu8Pa6Q9I162nhr3UASecJ2Y=;
 b=yqTihj7laVp8vVT+nC7c8xJso/92cepPZY0m6aP1nrZjTvraK0QM235oGbUc465jqMOf
 mO2fqUGV52FiQEkUC2yZ3gYFaLf5BwSIodSqI5n8Pak63vJ390lPkvbfR+7E5zLA03lC
 C99js6G6t0819CFW3AAR3Rje7NVfoBKOF6ojgKswGIsU89LKuGeqo9iXCAXHy4+gO/p+
 B20MnM0Vcg163KEsKQgSvfqEz87u0sOMdDazesBVmJjXDkTWcOm0DZLvCKe7LPPSRj6r
 7TYEreC7Q7l8XvdOrXDbeHB5/KqxQnRAwAVtoKf+0LmPahkcmSW4x4w5l0tD7d53rEPF qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psarf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeUFq145877;
        Tue, 15 Feb 2022 14:43:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 3e62xeqejm-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgwLKFjnstyS3JX1qF258fva3QrkBScfrbwK5AUH/uEV7z6VOlb0Fj21Ik4A3Uec8KS+hqmviFerVy0K/KNYkbjv6KtoD21ngibK3oBESt5DHXYbAuG6r5rD0sSxZTUxvQ2EVSIJ56F+fkWJG+K6MmXeu38S83Y40C7RwP3K+WhDFep7uKYc11OAGcGFCjv0h30YhJ2PiLuJY64taFnGXofjDX3oqyYC86KcMkP0V7mfXgCPl0JF9gl7Edgluru6SnY/Q3EoageSYH9aOtAkI6TqOZpVsc76EgoSeXinNUo2TdSL/RLP9iQGYe00TFxZvdPqNN+z45ryY9MpXsNeTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rzf0Rj04YS6Ao+nAAxGu8Pa6Q9I162nhr3UASecJ2Y=;
 b=dRe8P1b6nloVJrELdOnUGWMsEl05gN0R3Exno0NaByeBD76AKsH6ylLo8oVWQYqOE5SMQYn7GvhAUZ38cCuF81vEVSZ7UW/Y7zY2kgF2zlPkFdvJekJXF8iXl//NEb4kxuDz6XA9s1r1Dogmeo54QGIyYcPXdETDdYBBgJEXQbukEeS8TS+OK8C6vQVr4zKZ1W4QuL+okOLamUE22GK6EXFq1Jaa5MT5MiHtMQE8OC1FIuChlJvi5q/mnnsCC8K8d7f3N4b9W5sEIrCzZ0qDPQjbUnGXcNCEwq0lNEbCrEuUyaBPLvfJdYMdar3LUMlkVDiEoK4c7w5cJ1oUQTQjBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rzf0Rj04YS6Ao+nAAxGu8Pa6Q9I162nhr3UASecJ2Y=;
 b=XNNTrywdm4v+uLpguGnn6TRcBNift53tbxOvl9zNnYMKSTVQ7N9uMRfEkuLgkoMjvJkSSljNnLB2lJwgm3zjpnecMqlN5bO7Ek5cHV5hBtVwBWG7GmfMrDxBTX0mSluNW5Okt/4obnXYiyzIOM8ZBF1kKQL1nrCmSsnEF4lw79g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 24/71] mm/mmap: Change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v6 24/71] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYInpabLGe9JdIbUSkODKOTvc75w==
Date:   Tue, 15 Feb 2022 14:43:11 +0000
Message-ID: <20220215144241.3812052-24-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89dfb92b-f335-4f59-da7a-08d9f09180db
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4689FE65BD71CB4FC779E063FD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ozKmIpFFLQn/xNx0+FOu3otTAhthxUBkWTvcqoVsFUcKEOTN7OQof2fIS3EafcprRrV3+Xj/RiCDVuEcO7Wid1ISUGIcvR4/Kw9nMBluvCsPEjv9/sSvRln59tVLiJYqZ3mE0QpkZosAHDnH1XWg7WksLIYFPGULTev5tMs8hEcoiYmMGCZBSPyo7nu7nGlLataQhwByPJ/dCEipa3oGH2OfrCyjdBk/xXBZI0RZCz+i+nXUtgFteMIPot3u7+S/RgDv0rFesAO8JxOIl09XBLAiAb00GL+9REFeky/V//Ts7gLVFD1DMQfmr+FBoCiU2996dG+/KJ/CBoLGY7TD17MWTpHJib1kqkm31pD1+RT+gXfj5Woq5EMF9fKIfc07i/J3xLRQ5b4uadp9ZYsezuI+Kw+4kK2QSTYwmKqz0zcHo0OCSaOD4G8Ew/AFalLNXt4bxEO0R9qSf6S6m6JiVGzyexXf/4EoRUL2riYH7NEOBqHNPV2d2q5Yy7PICAWYMRPGjDGezZ/gFiJnl0eLIvoZS69/wnODeMTDsLp7fhkOjjg7ESM/M9QNsenI3Jm/Yl2sa+TYPlMLCnKiIxR+Vzek0pHMkjUOUMWIxzvyQsIWhnzufVpz4j8TTQxoHq2WAslyvW3Yfp0gx1THO6GjRXFlGBT3mqReFF3XmZU9i7e8oqyYnHZyEVFK23h+mtaCWp0TwFnmjR66gCeJ64zTQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(30864003)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DOu9zZubLXa3TDEYqtk1lXHqslvbYrBR3UXPDKOWOcndjqkRwy5HU6jsgW?=
 =?iso-8859-1?Q?q0Ib5WUhHNRfJTDG/pPHNJbE2/uaVnSJ3IX5p+IeHirL/wE0lun4yVihhg?=
 =?iso-8859-1?Q?ecsqVNMF9NbjUoCAHWsTrOs7+5Brf53e69lxl9ZXqid96fsCgk3os9Ri/p?=
 =?iso-8859-1?Q?G00qq1RA0TqVRcuRilFNArHJ9e2rmBc9oNtLpoE+dAuGWp8pX2IsV3kr5a?=
 =?iso-8859-1?Q?WbihK/w6oDBKtwJ93ZVcH15A6SEATz2ufEBlwZJpWJn2griRNc0J2zgTfN?=
 =?iso-8859-1?Q?gmwJ7Y90gEm7KyYaSnAAJMwoFDp/pMwt73MmqoYZfJkvbtngIwI5VoI/eF?=
 =?iso-8859-1?Q?mvKzqFAwBevoTIB44mwnV+yqInEYjiE4HgMpYvyAF8WnzvcPsxqRo2/G21?=
 =?iso-8859-1?Q?X8WTr+UOWNGyJFdfdz3eFeIHvNb6KhfXG4MYe1DFp2Ag+KWEa6NS6TBGRW?=
 =?iso-8859-1?Q?Y1W3N7FIvDCfxQVtVS1D6ezAZqkuZEARrzx0/dGNydkdAcsol34ULl3ije?=
 =?iso-8859-1?Q?jE8vYys+aMoJBg/5ChkT9NuiTfO1i/7aC99x+KsA5qSZZnvBA9gMqthnkY?=
 =?iso-8859-1?Q?3xGq1Vr/qYZj16GrSSjKkcl6DbakYdYWokhkX+XYWizhtMlZqdAPfdUAXQ?=
 =?iso-8859-1?Q?1n9gePwyLqOlpdPApu7hmA55JN8VZcaPeYW0y2Mi9O4fyVSMubXX+aSsGT?=
 =?iso-8859-1?Q?WSFvHQKWOhJjlJ0jvl/2Ecm4HF5V+4ohJsPdReZQFHLpGxS8w1tUCtKHGE?=
 =?iso-8859-1?Q?wQ4CdQsCNlHc8dTuvkQ8G3wazWUcl4O5HxC1BI57NLYVc/JOJmfPLtX8D9?=
 =?iso-8859-1?Q?eXnJycoIAy6kCZA/2+fRHKwLpRlBFAaqAys5zOK0umARnyXxEZ9r/Xo1xP?=
 =?iso-8859-1?Q?gG4BnwDMx/cdD9I6T8h0YidhhvBKdC3sBpWoH9pDGI/N3cKfiGRv84etyu?=
 =?iso-8859-1?Q?RjUPmqkuWQEaXsMYujfaJEQZE+Y8aD+eSZyMtTE3n9mLLcY05fqhuy3Tx5?=
 =?iso-8859-1?Q?V5cVVzQsJOkbQJfS8wIP3qH5OgJ2dQZX1vtuvDZ3ack6VD+swpyoyfnkt5?=
 =?iso-8859-1?Q?IX1yRsy7KHEk780z+kn2Cu1zXWFCq2V5KY6EVmQyShIEyQwhw8s1sfMa/h?=
 =?iso-8859-1?Q?jfNkdM95DInWnJGFExCcNittw3qORNqtZhHShunD/0KRUhvrx4AfB/LgXy?=
 =?iso-8859-1?Q?Nivl8L834BVBR+Mj4wVpMo3AjgGCFTPOTCYjORLiJQ1tSEJmZol6qEz1y1?=
 =?iso-8859-1?Q?Y00vXk4GyLbPsSpuPgy+xVuoo6RqJb9TaueKCuRQFcyBxTz8lW8iLaqK5y?=
 =?iso-8859-1?Q?UyBbW1RrH0q3VBIvvT6SnbmT6qC+INYwR0JmIbJbcjiSC4Ho9Pf0m43Rgk?=
 =?iso-8859-1?Q?qBeNfrXHVudmVwLcyKlEkjzTJEIPKy+VXui9DduLPuSLbNM+BJgQHSIj/Z?=
 =?iso-8859-1?Q?fvhxWL2ZX3UdGir22pmEvF/0o59lg5OCwdZ2LG7nNRUcqt1GYLlXoZrHtE?=
 =?iso-8859-1?Q?ExKIbFIKpDBGVhp16SvLWllxrlw7i2LCUWprSalAj++pDflsNL1JVe2DGx?=
 =?iso-8859-1?Q?qIhnUbHnJ8eq5eWbtlaR5OYRQCNfl4HP8Xtcq+7TRyl+YHZGO1vR/vOZwV?=
 =?iso-8859-1?Q?+tBOmdAfK9qG8SmvbFljdzoUYhsov9rfTAGyCqxBe51x2UZ06RpwrkHogB?=
 =?iso-8859-1?Q?i8KGjRD6XoS0Qiaxyz4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dfb92b-f335-4f59-da7a-08d9f09180db
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:11.2612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/aH6UvV83UbLm7iqIB5YMvexUfuZ78K/krBNv3AULwyuFfSAm52R6D2/WWZ+vmT4tS4e6F7GGXW32WRO4R6wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: bw2WnS6EdDAjbXooKOIFsSIgIrQsvjae
X-Proofpoint-ORIG-GUID: bw2WnS6EdDAjbXooKOIFsSIgIrQsvjae
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

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to
split or coalesce.  This avoids unnecessary allocations/frees of maple
tree nodes and VMAs.

Move some limit & flag verifications out of the do_brk_flags() function
to use only relevant checks in the code path of bkr() and
vm_brk_flags().

Set the vma to check if it can expand in vm_brk_flags() if extra
criteria are met.

Drop userfaultfd from do_brk_flags() path and only use it in
vm_brk_flags() path since that is the only place a munmap will happen.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 283 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 227 insertions(+), 56 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0388dd11d39c..c080ea65215d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -189,17 +189,40 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+/*
+ * check_brk_limits() - Use platform specific check of range & verify mloc=
k
+ * limits.
+ * @addr: The address to check
+ * @len: The size of increase.
+ *
+ * Return: 0 on success.
+ */
+static int check_brk_limits(unsigned long addr, unsigned long len)
+{
+	unsigned long mapped_addr;
+
+	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
+	if (IS_ERR_VALUE(mapped_addr))
+		return mapped_addr;
+
+	return mlock_future_check(current->mm, current->mm->def_flags, len);
+}
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -241,35 +264,52 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
=20
 	/*
 	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
+	 * do_brk_munmap() may downgrade mmap_lock to read.
 	 */
 	if (brk <=3D mm->brk) {
 		int ret;
=20
+		/* Search one past newbrk */
+		mas_set(&mas, newbrk);
+		brkvma =3D mas_find(&mas, oldbrk);
+		BUG_ON(brkvma =3D=3D NULL);
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
+			goto success;
+		} else if (!ret)
+			goto success;
+
+		mm->brk =3D origbrk;
+		goto out;
 	}
=20
-	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
+	if (check_brk_limits(oldbrk, newbrk - oldbrk))
+		goto out;
+
+	/*
+	 * Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area
+	 */
+	mas_set(&mas, oldbrk);
+	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -2728,38 +2768,115 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * brk_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 1 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
-	int error;
-	unsigned long mapped_addr;
-	validate_mm_mt(mm);
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret =3D 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely((vma->vm_end < oldbrk) ||
+		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+		/* remove entire mapping(s) */
+		mas_set(mas, newbrk);
+		if (vma->vm_start !=3D newbrk)
+			mas_reset(mas); /* cause a re-walk for the first overlap. */
+		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret =3D 1;
=20
-	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((flags & (~VM_EXEC)) !=3D 0)
-		return -EINVAL;
-	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	/* Change the oldbrk of vma to the newbrk of the munmap area */
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
=20
-	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
-	if (IS_ERR_VALUE(mapped_addr))
-		return mapped_addr;
+	vma->vm_end =3D newbrk;
+	if (vma_mas_remove(&unmap, mas))
+		goto mas_store_fail;
=20
-	error =3D mlock_future_check(mm, mm->def_flags, len);
-	if (error)
-		return error;
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
+	unmap_pages =3D vma_pages(&unmap);
+	if (vma->vm_flags & VM_LOCKED) {
+		mm->locked_vm -=3D unmap_pages;
+		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
+	}
+
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, vma->vm_flags, -unmap_pages);
+	if (vma->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
=20
-	/* Check against address space limits *after* clearing old maps... */
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+
+mas_store_fail:
+	vma->vm_end =3D oldbrk;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
+ */
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *prev =3D NULL;
+	validate_mm_mt(mm);
+
+
+	/*
+	 * Check against address space limits by the changed size
+	 * Note: This happens *after* clearing old mappings in some code paths.
+	 */
+	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2769,28 +2886,51 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
-
 	/*
-	 * create a vma struct for an anonymous mapping
+	 * Expand the existing vma if possible; Note that singular lists do not
+	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+	if (vma &&
+	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
+	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+		mas->index =3D vma->vm_start;
+		mas->last =3D addr + len - 1;
+		vma_adjust_trans_huge(vma, addr, addr + len, 0);
+		if (vma->anon_vma) {
+			anon_vma_lock_write(vma->anon_vma);
+			anon_vma_interval_tree_pre_update_vma(vma);
+		}
+		vma->vm_end =3D addr + len;
+		vma->vm_flags |=3D VM_SOFTDIRTY;
+		mas_store_gfp(mas, vma, GFP_KERNEL);
+
+		if (vma->anon_vma) {
+			anon_vma_interval_tree_post_update_vma(vma);
+			anon_vma_unlock_write(vma->anon_vma);
+		}
+		khugepaged_enter_vma_merge(vma, flags);
+		goto out;
 	}
+	prev =3D vma;
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev);
+	vma_mas_store(vma, mas);
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2800,15 +2940,21 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	vma->vm_flags |=3D VM_SOFTDIRTY;
 	validate_mm_mt(mm);
 	return 0;
+
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2819,13 +2965,38 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	/* Until we need other flags, refuse anything except VM_EXEC. */
+	if ((flags & (~VM_EXEC)) !=3D 0)
+		return -EINVAL;
+
+	ret =3D check_brk_limits(addr, len);
+	if (ret)
+		goto limits_failed;
+
+	if (find_vma_intersection(mm, addr, addr + len))
+		ret =3D do_munmap(mm, addr, len, &uf);
+
+	if (ret)
+		goto munmap_failed;
+
+	vma =3D mas_prev(&mas, 0);
+	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
+	    !can_vma_merge_after(vma, flags, NULL, NULL,
+				 addr >> PAGE_SHIFT,NULL_VM_UFFD_CTX, NULL))
+		vma =3D NULL;
+
+	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
+
+munmap_failed:
+limits_failed:
+	mmap_write_unlock(mm);
+	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
=20
--=20
2.34.1
