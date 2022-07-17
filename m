Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7F57734F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiGQCsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiGQCrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397511A3A5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8qIT023882;
        Sun, 17 Jul 2022 02:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2yzv31jvbzIM1RAWhUs6/hu12i4syFzBij3ZHTOL2Aw=;
 b=Osm8t2ycxq49d6miE1orfDlQtU+6CZ7NP1d/UDUWI90j6t+yMIWqSJuokE5fI5klZ9Gc
 4ImrkkxuH1xCqLp/rBlzpTDrixMyizbn3Rn9vGxzfnrc2Bhg9VpYK/B+4/SohcBoTPBE
 HUTwW5NCN5H2Vc9vaKGE6hiWGOJJwpViEwQVoQAxNSBCBr7t1OxfcX8Up1sMjUL4Py9s
 U08GjT2I0DLMNJEjp7J+Fpv7vscPNWuLDN0veBrELwrLdfxbHYOhZBWLjMIOREHtBgbV
 1ShB5x1rYB8AZZA3oHzPokx1J7DbGyyyfoGSHNVNfE7CvSKy8YS29B5JwdbMJCoI28Q/ 3w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvt8xdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY48E006055;
        Sun, 17 Jul 2022 02:46:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d815-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omsjt3HpI1w15oQg2KegxPjjG7H1JvNTcU/AVHKN4IDb/a1mk5dcCgN88nuBk67lLCklZwhGKK+UHpWnkHcrfowXeyagNkXsg7YWFC9YGvs7qCPkkxzsbRnCfyhLbVXr9GlRtbtewllHyCHsaBBF+h2izQzWc+cfstgkMrkmtL6z52EY6ufXx4ZucOhBNQ1KjEWVzAtKAiq5pyoRVKBf9SY3IaqGvpWiNpNHNIKklR6zkXFlU/FMNaycI+s1IEhDcgo318cWH/d09ULdX5BjHG9z5Lifi8taWnHT7lBngD62CJ3tAUzWP7IIClUj+zxFdsjANWGAJ6MFAf00cISAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yzv31jvbzIM1RAWhUs6/hu12i4syFzBij3ZHTOL2Aw=;
 b=eDATdCaakHgfceNZ6hzkGinoEoxq3IYT+AOy5jnLCLDaMQSWVpwVWlBHkk92+NjopzLWXlEQifmkDbK2Tqc8Do1e1tcomcahTFg8uVN5501Froi8Wvr226+dwxdTIk0WuBETOTsWa9cozMNTZtytDlDGbg+AF8msLKHh4AnBe32DXaBsitviY3s4himjxffUCBSKtmBatMKbSV/HwyzKf79fx741Rp9w0FS/NdnNskmj9pZsuIlsOZOMahnGUspWbSkwp4PRls/VbgNkeMQFxzVm2ysvOJKBPlaTiI18Syyb1+2I8raEsnDumY4YixIwCATpdH8LtSvcx23L8Q3LAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yzv31jvbzIM1RAWhUs6/hu12i4syFzBij3ZHTOL2Aw=;
 b=kJ5mVNfB/R533cKP4EWl1YJ6J3GOUeJiUIDKvPVUlA+NqRDG4BqycW4BJePJ2+bf/XVP+si7zucgyATrrrUV7hvFzH+m91/j/DntrXcMdrGwtz9bTfiUjC9dMNMsVIdQc043bYjDbxcTWfOWfHvpMAI9xICMvJ0uLXrCtJAR11U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:46:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 29/69] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v11 29/69] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHYmYd0YdhGtnDPYk+lKpAsI0Vxng==
Date:   Sun, 17 Jul 2022 02:46:46 +0000
Message-ID: <20220717024615.2106835-30-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79638167-6307-485b-0865-08da679e9aac
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gpq2IffKW9zzuUakVm+3RiKBC1z538DkNZOHC62PCftQOxfJMeJ/CbUkgylHZBV3wougfLMh15pETnTM6BqjjP78YxA3L+MAFLaFEhJgzcNL1s85WU9WnynUg/Zcq/sjP149ZIM9e2j5RhiUz0BCRB+yVaGIzpU5wE8reS12Jb9CHvQx8flXxl/vckhv150apIwgrHEZ/I7xYytJTZ/ml1XSNebitT+1EqaT/QscZ1p789XwxpL58BZMkDP9JVhuUAGrLj2MaJNQ89//lE8CCY6vfWzLcF7MMZ5NKXBstS/6iS440QnY+hiZPSuYC1UBMJahbZGAQrvS2ffFmuC4Lf+7IifKUZZJkroOoBlAb7WJdKTTzp5LGb2VY1slkvaVbUPaKKoMs4EsiJAiSPtDBmrZEm0jCN53MWxcjlnEIu8CZSA1OWd/fCE57F0UXXc/umVDkRda+fcisXYOqGKY5r7wcIPzFB7bYdhGQgWYaayyrO9W3w7Dni9qMRNGR8SSEZvqT7SVLWrNKjYZ5Y5/F3h2gcrgC7U/nbrq0T3hr/JVK7iFZlqlMnW0pdPc0rHIZB5pb8hw2FT/LQAYMZmeALje3Y1lXaaLG5NXUd991eiw8mzKvr+FscttcsUOfkl0BObOQVR1WU/AACzsnZU4CDl2uowPTS4gHKKs8dwjeCxg7P0N79/q9Yv/gjKnG9t/NnSr9FfljuHydkoYHZk0oYhtQAJNkUU7uMsobrony8FLNuuYtim93a1qJwzKuIwx/1RpxzOaCmAkczeXFDeWX8L7lDJr2GeOF2UOJkFdbxdWY0ykwKyzW04T0Nr4cxqG1FJnTSJ+AJDSEIt55+JUZ8OcJlwYsMTV4+qLMFcSLCdnZLTyj51VXasEWGhRYCOO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0Axm0s1KwIbIclwtrAc+c7f70oAwm90Nvsy/fmiD806eVYzm1D85lXkI+U?=
 =?iso-8859-1?Q?k2m+s0deT2mndm3hzxLJHrU8j0PeFBWSmbHNKKkqaUYWIHqALtX5iEj9Ze?=
 =?iso-8859-1?Q?jv18oNbjo8OeO72sUccM6ZSMx4Q+bg+UY3o4Hu4E8aRNRVzts6TirmKjP+?=
 =?iso-8859-1?Q?dIhDoR/1bZfmYNdPdR+fFxjoub3SAOyjsLeJ9W47LDSBKa4eduI6ZZ14aT?=
 =?iso-8859-1?Q?vJ29q+q6k+98+RFteuZC5unxEoPJB+yMBaV3RjptQ62GRgC/lJes5vMZIE?=
 =?iso-8859-1?Q?bsfUx4FgsozvI96cg/HcyG4OzrZiI2acXywqFuchYMDWgRFSQ5jTmChcL9?=
 =?iso-8859-1?Q?3Tv2adtV+G4wiWMa5+faSEvZ85p3CXYyV5yEdHvL3sUefy7tgigJyfmLKb?=
 =?iso-8859-1?Q?x/Oi0FqqJheV3o1BUHIY89GUQfb+KQHD30LworVPASkWldJYIvx/AcprDh?=
 =?iso-8859-1?Q?RYc7NyPedFgcjlbpwSqxgcfmuaDPuP4wcbwc3innnQOyPkRw0r1KtNFAPj?=
 =?iso-8859-1?Q?OkmgHWxmvSCKbVcVv6PHnhKV0dNZ9xezayFuOFeRAyiAzlXOusBqWdDCHJ?=
 =?iso-8859-1?Q?8LfOdlyNjlgfqykYJCBU9CRvEGeHeJl/EazfL6B0pwY83NFNB5Ox8//mST?=
 =?iso-8859-1?Q?U3siIMs9XUbmNU0AEWM7QzJqTvbL/sz7L4KwYNC0DKiPVWJ26r2dhHgfj9?=
 =?iso-8859-1?Q?P5jbfcmmSr21KlOh6wmTyIVud6gWE24o8h8NohdCAfmGnKMSy94zATJ0MH?=
 =?iso-8859-1?Q?4pxE039IyFIc84ex7KOm6Qb064XLnz/snXt7Y8jkyLoWz5u+JHvg9DWDQ6?=
 =?iso-8859-1?Q?V1hPOprzRUv65Nzat5PZNQCYhpKzxt4Kn9kxRTBQ2ZS8wrzim/wyVOBMuW?=
 =?iso-8859-1?Q?yVisKy9huGHSekSd1zNUAUt1XoM6ROr+UMOLsJ5S+qy3uibV8d+d1Aa3B8?=
 =?iso-8859-1?Q?xUqFZ8Fyw5hZhUNoyBlK8cti/hO780uLdYDqL/ZqbCMbpAzC8Gpo+gsOCe?=
 =?iso-8859-1?Q?aJR7LnglvGC2M9u9dJo7YgjFi1eS8W4wY+E+Cd80fIZYko7PKygjWXBYYo?=
 =?iso-8859-1?Q?YdCR3t8dP7Py7c+9v/sehXfRgl+tkAo2sXn4wB3bVXPRyaV0RtifrkDl+s?=
 =?iso-8859-1?Q?VLfTjVYDjKR0UivtR3OwlT2wBHz4oWCGoStAs3lmN1T1v9MMBcdTdxdzx4?=
 =?iso-8859-1?Q?QdUSeEpAvyOaLNko0Ntg6JACojRMdWQB4/0c20dPA8G7fr3tVVZ/M/9byp?=
 =?iso-8859-1?Q?uJtxTD56Y3F6G9byzOcSAkjBG8wwZbaBPBbtyv2j0tD2CScYc6dKU3BhBK?=
 =?iso-8859-1?Q?nzwMBBBhaN0zSWJKSbmH57/+nj3z5R6G/NtpftsOfaVIP7QCu0JVriugCT?=
 =?iso-8859-1?Q?JyKVTOxN8mNY8rZxy7XHFqXPTTNcDSlPx/ZwOB30Ws2yn+zD/w/fQgmdZS?=
 =?iso-8859-1?Q?e+Ay6OJVeYesHUU14zWEN5J2feNiQjMOmRcGyG8gkwnM1OhHZKi/HkFBBq?=
 =?iso-8859-1?Q?EgBDM8abYwbC6R2tBjN16wk/X1tbtsiS5n0MZtW0nkaYoBowIoYjOJvB4b?=
 =?iso-8859-1?Q?jePY/P/W0aps2MkolWquHfgFgZPXBwoUtlMu2ixZgqQJG38NR7BdeHFxen?=
 =?iso-8859-1?Q?rMPqFRjbMILz7gPHC1B3BBGixFwDDAbV72kYriAUc4P/Rk3C/1vkOm2Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79638167-6307-485b-0865-08da679e9aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:46.3653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6WkNjLmHYms7EK77kGY5TLR7LK8Qm0PSnAHSrwey80zjNqKlmLKspRvy1+v19tkUqnevJFuiRAIrrYe+bVsDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=953 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: jKyFa96FdWchfKkxvnTKKZsQf68zOcSs
X-Proofpoint-ORIG-GUID: jKyFa96FdWchfKkxvnTKKZsQf68zOcSs
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

do_brk_munmap() has already aligned the address and has a maple tree state
to be used.  Use the new do_mas_align_munmap() to avoid unnecessary
alignment and error checks.

Link: https://lkml.kernel.org/r/20220504011345.662299-14-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220519150509.1290067-1-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-30-Liam.Howlett@orac=
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
 mm/mmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7f5301ed0213..e4bfee3d2ae2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3092,14 +3092,14 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct unmap;
 	unsigned long unmap_pages;
-	int ret =3D 1;
+	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
-	if (likely((vma->vm_end < oldbrk) ||
-		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+	if (likely((vma->vm_end < oldbrk) || (vma->vm_start >=3D newbrk))) {
 		/* remove entire mapping(s) */
-		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
+					  true);
 		goto munmap_full_vma;
 	}
=20
--=20
2.35.1
