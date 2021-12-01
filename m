Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2A46500C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350562AbhLAOl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:41:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2108 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350027AbhLAOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:31 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EP4r8018228;
        Wed, 1 Dec 2021 14:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qOODSNj3xWF16lg2dceY69Zg7s6eCc806WccLBrO/7I=;
 b=D4YBHt07/7dljl8B9ga/BwYzuJQR2ebqD0ETHUYZOe3N0kNUkYR4WqXWHDvV9F8PYaU5
 bkfANdPaQHvS+Mt1jcIxNMYhNcqGimHujuZAXvrycoRq5rGBFNk17vWTb9ZwfOIJ9aMJ
 vggFglqmhc23HlYcI9vZBNQzkw89iCcTUR2YFXSqt9l4sS/HUBgwAsjjZsqlVAb6iFAb
 h0aO49W3vjLMXoMz6eAAvgvASC2SvPHKnE8Kcfra3ltEJxS7WZFjHWvwoe7UgC83LX4w
 I/3gVuVVNulgb/mYE/VTZoktxg0P7vwZAoSArPqDk9Tz1JGUP70hD2Ft91CyT4rQzGhe Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyg14q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPO108922;
        Wed, 1 Dec 2021 14:30:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAP3Ngpha8FjEGNbaHRmSz+5IKVA5H3FzXklBQEtk2Im/9QfV9BgcoTHxtvpzXjpDkUxQJyyY+C6ZwAIcE6oq8Vh/dD4hzgJ12bGIsTfLSSW0JhqbG86aoF6q/Y9gadIGTuLee31ZkaNeOs/XoGh8p6XzkCm/6JOMmU8tCnpVz32OyXEhWH17fTIINzmA2WygHtb5hpPE81yq/RYIPM1InSxBXaqbT3L2axEAr6ZdURpXtN0+JICy1kR4AeXEmY9eLwyk2Vh8BFRKmOyKGmIYva1fayjNTsG8PvApwjVLMqUNYXCYInqEYWq5AGEcBQYk7WeR87zmuy6Eu5DhUB9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOODSNj3xWF16lg2dceY69Zg7s6eCc806WccLBrO/7I=;
 b=aZl/PrkL8GQTqXKti9dKmDL7RRpMxstZYgdo7WbjR0/o5c83haotWtD2vBM3ty2o6vB/CBnHDtl7m8Gliun88q1MVHgkxpEG7qDNuBgCZwxrkXC2iCHu1WEWGRB9Xh4S+iG0OYydwpuChbIahIZPqsMOvlx1a9Hks+44Je9WrMa9iKh4TJgpieVQ70Q+PHRVoufvezFmPeoyqxEzBIxLTR3LMCkSjBbvh9+t2Xct1W11TDKf5T5/E/f2g+Af+/CafICeQFH3CO4FF0WHw8O/rwMNV4dc9lXEYqsa/dzSo3zRqw/Bqy9pgbiCGyT4Wqqw4iMCUOz7TBrg9GS34Kh18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOODSNj3xWF16lg2dceY69Zg7s6eCc806WccLBrO/7I=;
 b=nvaX4J1i3ZXlqwPi8bc3DtLToOFc7rgDjgmn4gR7iiZPE1G9/UOHWBpj8lGUz21sjdR7yxnbhmALOm3A/FwPpmeo+Q2DqKpAGkFjOma9rVO6Zlxt6MXB8/OPB/8opnCIburGVi30vyhLW87v4Dg7zfYgabXaiVqSvWMxpxTv+R4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 32/66] x86: Remove vma linked list walks
Thread-Topic: [PATCH v4 32/66] x86: Remove vma linked list walks
Thread-Index: AQHX5r/vscXmXcPCjkaKRmFpcqFugg==
Date:   Wed, 1 Dec 2021 14:30:05 +0000
Message-ID: <20211201142918.921493-33-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b105a761-f27b-453c-9838-08d9b4d723f7
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB450835416C6FC67898B225EBFD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WleBagJlBoyjhxfGoX8+blJy6fFWs/ZmilTBbl8nxHxcdVCrJgUYyGLqRRRAlsGaZJaBwcARZy7e8eFxtig4PBHWrvrGxObxK0ZA4OVhiorexDnjrpPQGc+sOOKcHPmiXdxIJ/VV2azhq/2cNyYyKdcGd/a3bvvw+zuJg3r6cbqsQcR2UNdcVEresG8C56vE4juoCAw1gOPiCklJi2MkOExXaWbw6Vohpe78YXXc9f+8OiP3spjV3HkRGKMG/5Au5lL8fvlsDso6rYRKFnr7xuhI5W1pGDyTT/56IBQrrcfr/Sm25nD2xPVsTSWDoxVy+0WE28C2OUhw1PO5nFTx9eFUqKLtA2Y+fZ7w/EIcD9McvEvQ9mINtD7UVU8a8GT/pemxqbb7q3gJFE0RvJXoz8iwRAJTmU+W6V00PGjBTF6OsVWSloR54dx9ooAhe3cugjU+r2MYUkTvoGvQLA1eiZFGvfbk2YdGKuz3TIPPbNcm4a1ZmtVh3v4S5lHlFVjZHxe4gEXyYGGQO+9EgGe1YY5xSLh9BZrkXAeA6zTGAZG/kH3tfO+M0RGO8M0uB3QiQraFs9ng12mm6HndOT9FsqPv4sYdup342qEvqfclCBqxX/eLV45bEPxI5aNdS9xceaCqqWr2fyi/MsoJKAJBcVwEUQJ292AHrOba9I2rh1VDeFALUWAo07XugBBdFZlt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lIOZ+T9mbDktie/IIeFTkvt2PnOR6l9QFwr2DxwnLuwIHcKqy43HAxECkU?=
 =?iso-8859-1?Q?vslmJ6NMB+ZF1svMatSpWPT9Izy13tgg1tjqCwO37EzDVq8HWAYhKJe5bb?=
 =?iso-8859-1?Q?w7+lLgJTEmuxrHt2rOqlOth1hxMrfVC8gH0S6G5da3Wy0dekfsDMYNgthh?=
 =?iso-8859-1?Q?E/57rkKfLaJxpVvG2W1mmWvDEtZN5g+hRHDAnQtWaV1mYphe52YNaYLETn?=
 =?iso-8859-1?Q?WEgzDegVuRw4SbgZfVgtqA88ev2eslQVwKJu8tz8kDNXOzG28ska80s/Xs?=
 =?iso-8859-1?Q?QoZVY+VKhVHaqFYWITlqsjCtDM91RycYqpFihbZ+IALwO2So+JKHsDjq+v?=
 =?iso-8859-1?Q?0jru0sRjyTz5aMJJsPcMgBkoJqL3XEnMDHpPmIBCDmze2WaQZtDeEoIRHI?=
 =?iso-8859-1?Q?Ek0dm036uluA1Jn/63jHauQgrzLYVZsT6LlNSgSfVQiDE3qf2PClChWKhK?=
 =?iso-8859-1?Q?hFsCdTNaWP0MN1xQKnGBfVf+HPvk8TGacY00AGKfz2eqdwfcGXU4vvEXDS?=
 =?iso-8859-1?Q?4T77xzPAI/Ve5OeaH/oB3qDRoAI3mSl03fTv0T2dW27yA/+Eqd3hDwwAgW?=
 =?iso-8859-1?Q?1ZQf6zlg0Cg/m3COrxNwucnNAV7JnTUeFm33ArMC74MfKQ0iERCMDHC+h0?=
 =?iso-8859-1?Q?7k28WjxpalYOn/vvmOvxaW6WPGHBlrOjS4tL+i82B5qpn2J8kaZb8sC7G4?=
 =?iso-8859-1?Q?j5ZFy5hDq268IjF2DDwtUtOUg0ZcQMNO3WDmhM8DzGAHhyEZ3MiIn6JD4Z?=
 =?iso-8859-1?Q?Pg4cZQoUFTiJJy7Ip6QdKs340QzzF58pD+UtXGeplgdKwIuR/C23uWj9YX?=
 =?iso-8859-1?Q?Kx4ERFr1tspCSP12qJymDCbnP08vP8YD0UUgf1tDvPivonXgEmBPndKiUv?=
 =?iso-8859-1?Q?/HGu6bBesFFj18xFRN+YEQfhJ6Aa2bY3WyN8Ao1Dso7+UD1WpWZ4fCeNWA?=
 =?iso-8859-1?Q?YCaQMJcVxFE9lUD81niewThfewBZbOkvyfQ1c+yWfbYaiIf/D8L+3JC9wX?=
 =?iso-8859-1?Q?htea3tvt5A+uKRODpd3Zkv7LYTcs3kANQ2/Po+kuqOI3FzLXftLPYvB6OK?=
 =?iso-8859-1?Q?jd5X5lY8rvpJ7jQH5JyTjRRS+Y04U/C9wx3BQiUPy/RiOlC65wbpvVff6l?=
 =?iso-8859-1?Q?JxaCvs1oGauwL/iFX4qUZ5y/BxrO4wmyGOxUI41Tul4jC0+UXBvpGJTVz7?=
 =?iso-8859-1?Q?kjVZWNRqkX1oyVsFrtmAKd7j4Xvs2eaSoBuYyoFL4nOgjutl5cllTAT4p6?=
 =?iso-8859-1?Q?yxm97cEN+wwpFPAS8iHQ8m8kIX6gj/O+CeAftQy1YgatsppxPfPam2M9RO?=
 =?iso-8859-1?Q?Al1E8cldRcwo6B9KCpa1aknz6nWxR6FfTv+kNzzVgjCQNNPHmKPUJgpAI6?=
 =?iso-8859-1?Q?CgYUJkwblZn66h1pFG1yuckrfQmkFoQykfsbvWjt2JxhYNtHj0vAWMCmPW?=
 =?iso-8859-1?Q?8A17rtCUJG6kkSX/BHkiNxA17lavrTjhuPiNjqNTW6frRuJCvhnBTtYJVk?=
 =?iso-8859-1?Q?9i3KgBaQdpuYxIj16dWFaKTpRNA/xuNRVijIWk0B7G73EpbYXEU4Q9UNQ6?=
 =?iso-8859-1?Q?R/1I/pdSUTYFW/RpCFIQJtttSo/YFFH6sGzKwkxxVvi6picYYsUEIjnxxe?=
 =?iso-8859-1?Q?GzikuvRSBavwwmEbs3ZP2fY9kjPJ3Uj//xRdtvLZFPSp3jVXAg1NFIFeL+?=
 =?iso-8859-1?Q?gfIlsZif8xZY5fVOCto=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b105a761-f27b-453c-9838-08d9b4d723f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:05.8817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCXggW5cgjl4dR9lGHdsCrycDZWWVbzrGrjgH4Y6MiqOVNAl9JLh2JT2CFaOkU4dA6OrQlUQojVnGhE6fGmOjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-GUID: 0iv7cox0LQSCd73uyRR-wIcH_4rWu8bC
X-Proofpoint-ORIG-GUID: 0iv7cox0LQSCd73uyRR-wIcH_4rWu8bC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/entry/vdso/vma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 235a5794296a..3883da001c62 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -127,17 +127,17 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_mapping))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
 #else
@@ -354,6 +354,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
 	/*
@@ -363,7 +364,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 	 * We could search vma near context.vdso, but it's a slowpath,
 	 * so let's explicitly check all VMAs to be completely sure.
 	 */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
 				vma_is_special_mapping(vma, &vvar_mapping)) {
 			mmap_write_unlock(mm);
--=20
2.30.2
