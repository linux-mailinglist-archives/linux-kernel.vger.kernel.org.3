Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3301E577361
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiGQCvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiGQCt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F4C220EE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8gpq031743;
        Sun, 17 Jul 2022 02:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ImfLIF3eqPjyro+zlEJOUe3mszoepqLB4lgiSV55qEk=;
 b=zwRZWX/RRpeocgbOGp8WUfxmyxOUih29zyawrS737TPvDszkoH3Z2/YfpvfcXhPCxzHD
 V0WQ5x9ud+VvkC4OUmVZZbarDxyKmK+1dfa9qKYF9tHShF3W8ojFaiP+pSMAalN1mQI6
 xJxetbaTE2XpNmUrSnexuLGJ6es+WcO+9XEj893quCqBkWA47uuGIf3pq83NiJuJRWkk
 XjH1P0EkOVQqv3saBsyzvMwMQtOc/jy3IJXoWa75IddQqU2eihabCyY3INldQJ63zx2e
 N94M6ocQoXy1MJM67PCJ2o4EeWf11P87AK8BJxTWtPwT7FLJ7YvvZnuiCh2tLgGqVVp/ CA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm428y7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYIxr036125;
        Sun, 17 Jul 2022 02:47:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6au-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsYqlehCl3LTr5SFm6zIUDrWnNBkkIDUc825K3SEfP1GyuLKxWrkwWOTp9SD0JbJRga/+Ak4h2u2IK/LXU/U3fXMSEtrDoPrHIIIojgwnRxNvWbA0M/oqUh5po1rlOsuUH4u2VY/Hpus54yXcR5/U8W7i2eXMvcVNknakLxH58pCp3235lZ9WR3jqfq/Bdd5MVfE2wqupgUgtAm0Tg9KEfi+sgUKgfJtgseLkniAWK1dsABkIrNYqymT8Omc45b85WnibjI5KRaSJEDQEE96a/Vi6VFk1zL0LNVjUdxBIoAhWAT4qKjlXlcijm9yFylmxs7JRdsLHdBYPO0M67nH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImfLIF3eqPjyro+zlEJOUe3mszoepqLB4lgiSV55qEk=;
 b=VVNCRFvqJ6rcmF767pqu1SlJUqi21GJ6nSzYA4u0LriBPy9A84jBfYGPkAP5bDC2tsbqoLndfhY/zSOMa94Aot9/+wqRtIbm43NZedkt7l0J0bN4bcwx1dCCTawIPlXE8ZAyrBTErOfD0PaeBaLSsP3/IllDMKEIKdIF/plKYKjJBTOXbQIdDO3PudSptUjwPiKsaZkpv9hdtO5SssRCW7pWV1FBIuhfHP0c/EFri1Wf62OEVvtjDGCX875AgO4UclxO7lcXxK2x+cbFfMJBwUcSWb2ArptycmZiy9xaDnrD8m2tn/tDtZkJE2C26zSRTr454VRlbXc4au36LrI6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImfLIF3eqPjyro+zlEJOUe3mszoepqLB4lgiSV55qEk=;
 b=ph1gHGy9vt9AOYSrSO0nhOQFYFAkIhhTGWAEo6rlneAGkCnkNMXjnrq0x5VJJPHlTLhbgkwliJPCxhRgFsoT17EwJRZe0RPVQzG/sIl5OA20cmaGSmR+o6SnZjB6vTboIMsbktRJwsuUP1Qgez1tRMqJ/fPGaPq5HHR0MULTriI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:47:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 51/69] mm/gup: use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v11 51/69] mm/gup: use maple tree navigation instead of
 linked list
Thread-Index: AQHYmYd5pv1StL3IFUOezJUKk0iyHQ==
Date:   Sun, 17 Jul 2022 02:46:54 +0000
Message-ID: <20220717024615.2106835-52-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4871958-aa9e-4b34-0a07-08da679eb1a3
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZSu/hAHEYNIrVxiIumyrXBv0Xd2R/xgxLRRmoOGUfFDlspmTW2NgCQSinFu6u0/hGQeqC7ric95iACHTftGOMK6hQ579P3vZ88uWqUvfyUMlYrmZUyPcKvS/yHqBNg8gr3F/khIPkNu5Nx7Vomy/ZmOUoFX9FlL4zb9PemZM7LFmvtq6099yf3yeWhIifrRbBoyYIlimZjUyx/SjXbJuUJJcsjP/dElU86XhpGiqIMRwS57pQLTUCGAA8M5KGY0lGuJigfq4RrB56j6BXabyjjtgyqLQD41G7la75VKqbEfHlygZuy2Q2xeDg8uFx0ZnakKkOaqf31U/B+vN52d/0quOYJyCtVQABzjHQHLYNNLrb1fhwIsmXZDfP51dlM/WYVMuMoCXr6MUJaJiioGjIBSioHb5wg6+NAoEEc6TMU7/aCUrMdMiuTqz2dpFGD1T8WFZkZ2wA655BxNtSLuwAonesnYP6fdokkP3XshJyTX+g2ZAUID908PF9PQ3uO8H7OvHqJSwPTlieGhC0sitLfdhpWBK0VDeg7VP7gZwzhVWJ+6zBSG84ELK2UEvjnZRRBbnTxrHvoBvUKj0lXOB2l86NRINnyoaZ+KVnhnBTW0vq2eAfaXdxDTvNnQkWXw/ynv3smonW0wyOxr/bc20qdUxTY6NJoOH2gbQ8A3rlFVSvMrzN4hpL6m8mOnOJX9rbX95dIRrL+0uRTQ+jaHMgOWQuDQNX/i4dZWZGanE1es/o1Ctvljc1bvNZT7yQjqZWFQgR10vDlC0EsTmFSQzFz2uTarw/ONieI7IQo9cBvj/QoTbchP+xx5JmXwWVZykYy6aHgX9fRDwReWrMoqynDXmqkP8o78oNR3VG3MT+zb/7vaBLozWdD8rvDbtAlgh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iJTrkiJ7X4DmEDHwHrH6vt3jacZYkVUv2PnN4N14L8Tm9Vh7L+NMUJQIdW?=
 =?iso-8859-1?Q?+CN22QAY5e9OxJd8NhFBqcm5QViTxKezFcPV+zy64Pz2LID2vIKCUc6GaW?=
 =?iso-8859-1?Q?abxRNcJhnhx3w3iAJO2V5ms/3MJkESytP38xigbFwzBlX40Um7UncSv5+4?=
 =?iso-8859-1?Q?iyiD5WnhGwda6ZAr3lu13EECmxcd64+ykID0cMSKmXUIUanCFPFMPmOTWt?=
 =?iso-8859-1?Q?/QsBipf0s5wdW+NHXmw/olfMkAfAxm3X095rTKYSGSsQk8PORHJoFRLbGF?=
 =?iso-8859-1?Q?Bga90ByIs7JSW/zhEWP7kbmXAnLFKpCvPtcERyDruIUar8rRvXwaJbOx45?=
 =?iso-8859-1?Q?LKcXKiUJPOsANqQR0PvZ2unYE6GCGK1JS1+a2On2nFK/OEwAfhWcM1GMZM?=
 =?iso-8859-1?Q?Bmzgaf7hDpYtmiiEiHD+iCnU9uAapF3HBFGnKce1KDokUe5oQG6vyxZiPz?=
 =?iso-8859-1?Q?+5FUmxXfT4rDo3sf4TewtARRR4WSJsGpZVSUR75HJD8JZRPOdusyARQccP?=
 =?iso-8859-1?Q?m9YT3NE6/DIJMoLDJIvePaeIBtNZRMCF/WjwDtoehKYlGNj+2TG0dUxbAy?=
 =?iso-8859-1?Q?k4WxkVKaRWwQho4OK8/C+5ItQ2HQWdVq+DoYrL8u2yoG80rPLw4M6QLrrv?=
 =?iso-8859-1?Q?BuFhBgN+Z0UTrqBDDT/DD/Pm20MAXHH1+7JAcg0gXyusDfJMBxTUkUdoJ+?=
 =?iso-8859-1?Q?hFuiko5J1Apw9jIbBDszmLOXsW/MSAKNksrfU8DN1/JTNG7GJ+VcQx8q/x?=
 =?iso-8859-1?Q?zh7gU1r+n5H1N46ULmvCNLPTMdDyur3a3vXTn7hEq8GL14T1r0NVJy+WVO?=
 =?iso-8859-1?Q?45d8g7nQ2ufQfAeoLcwlwgi3cMRPQmoiBMnSdahFghSKBNUAoRf3STENVz?=
 =?iso-8859-1?Q?y3x+TBneO/8gYQs4F7hItcbjZIy4jilojky2+Dmdc/Tj6HOtGksu9iStyH?=
 =?iso-8859-1?Q?JFKVENQjqUJ92J2rW/gEHdHpRKiscz7XKwfFpiJ7mRUlcokaiKjP6NhQZ8?=
 =?iso-8859-1?Q?LwrFRG1RztlYDcvcvfDLODnnAxYPM9/scELFrSLJ2X/M0Yfsv1kMM2QTpR?=
 =?iso-8859-1?Q?+HUgHyw6kdoeyLROg2mMFDyt0KhNS1m6FltZPLnRjk38FKR2+rMgHzh61Z?=
 =?iso-8859-1?Q?ndd2nxmohUpPbgaq9R8Cr5fTDray3jghqn/CdaUeuXBxp0eh1j/gNPGBqV?=
 =?iso-8859-1?Q?z8cfkDbgObcrIZO8x/1Xh2xIX3VTJ9tgrx8RdCbKPav8BKENR4QdLjQSeP?=
 =?iso-8859-1?Q?JTPtj0DE3FiN69hGdmlazo4fs5vPqwgNNKQ9TNnjB60Fs5eHgbMjZNWkO/?=
 =?iso-8859-1?Q?ClYOmy7J9GQYf36Wd6WfNJ1E930pfaOzPreCu6HtkS18I1aLCD83Fq4Pu+?=
 =?iso-8859-1?Q?QegQjqjVzFN19gC16DLS5sUDVKn94vepjhvkRER1tMZtP4n9gxCtBM7dXz?=
 =?iso-8859-1?Q?3YLh+Npxb+IfkgHpqFiDJvDf+esIvX1VccCuXxrWBAhSbo7QZPtQad4IwK?=
 =?iso-8859-1?Q?qWq5BEbEXv9BQj4LE/2IJPWn/LrVFwJhGtVjojrxeSNR3SnierjfInhp1E?=
 =?iso-8859-1?Q?08mDmnTqEvVDhygdy2SWfmLtNnT963OIH8WJ3L7AeTdEH8m645cy5HU515?=
 =?iso-8859-1?Q?ZEZPfcGz/y0CiHrG6a8J3Fh0fEn1HyCeZ4YnEIE8MhSB5rjBF4QSvI3Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4871958-aa9e-4b34-0a07-08da679eb1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:54.0210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2EzcjdtXrjoVjq4VoKP5w7J/PI1lk/wuKvMBmu8ih1UfwZLMexuvk46rpw7eWlW0D+7v+3WuNZXRDmSpiWpcaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: kcfu1ZsESC_pDX6iWOqcYy7K3GwbFf8b
X-Proofpoint-GUID: kcfu1ZsESC_pDX6iWOqcYy7K3GwbFf8b
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

Use find_vma_intersection() to locate the VMAs in __mm_populate() instead
of using find_vma() and the linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-36-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-52-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 407a81d5ca03..f0e5d68ea932 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1641,10 +1641,11 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D find_vma_intersection(mm, nstart, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D find_vma_intersection(mm, vma->vm_end, end);
+
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.35.1
