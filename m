Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9E5510176
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352186AbiDZPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352100AbiDZPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A2015A432
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSxpC011286;
        Tue, 26 Apr 2022 15:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jiiqwWTcSVmUrGeXEAypedCW5tagsdzk787hNrV2FEk=;
 b=TPUgZYLD0fvNaPtmJU3dYLLawX/GjJum3kiVooBWwRZvd1fWUEUjE9cqg+JKtSFL8sV2
 dm/U5pgza5EYHKSy9ouOqxqWjJaz9U7MwTyl+pnDhos+EYb5HlgyaURI+pz+zsnHU5r7
 sMapBsINikkMm65nWrJ7oPR2w5D4urSCwZu2uTB+9kVVbmfkqXYrToxSgzKnF+qwReu5
 9UX3/9LAEIgXf3sg4n3kTFC3hFpAYzhIdRvxXkpjCv3kGPn09+Rb3My8rb+nSqePVSvx
 avHbVAtP4O5Gj1dqNVX5ua2hGAxtXfJbINA4X7zEGECQbTpyhP9ikux8HW+LiKmfPF25 lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4ef78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF64Wg012598;
        Tue, 26 Apr 2022 15:07:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3grd1-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5bqrCDurFeLz6Gkx/DA6AMk2A5Tz1hXt7DecrEzDeTyls/gXGHS1yub/nNGdN0WHAuvfixw/4KfNW13W3mI3HuKy5xbqatNkl8xxbXOIWxaneT5QSAopheg1SDeEzEY0hmeBpsjOqiltfpmZf9bwkA/d4/0GcdMVf21UZdDDT4Io9IMQJuo6Ro3JMdddPOY9Eo4SaXNKvpjcRl+zddNtMRfqvQufvVt19OpQkidIv5jds7UA6BG8wa1NGQD2bzfPC5Wc4zCo8w3QIacrzPiKjzKsolvjrteT6sf+MKep0p1EHXC3vcshtlOXTS70gJ/LOF4FhJnj3EpRlXfx34GIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiiqwWTcSVmUrGeXEAypedCW5tagsdzk787hNrV2FEk=;
 b=Aoa0faKIp2ue4JJE3HykUXL9dEFyO+gh7fn2ux4B2kMR+wrz2oRAL09on2czVZcgIBRXVoj1ln5n/J4chkBu90whYudpeuFRjvKRAH9XVwG6MSD4iEhtSpUloAljB+COWD7vr4+MHEV+4FHO77ewOjncI4+5q2ibrA0xmTeSyYrGGn0ffn4vmIPt5JIEAa5QbEXf7lnOupFJmUyiqnD35czw1XP1/L+6rpqa/oqbFqNMT5bulMXw+NykFaJHLAMFqokrFxIDAFnvpXqb/PGqvuUgmPn04YXjfXhKgtEVDoRwapcrFeSnBQliB0NPL8NODrVEcVNGAEpVj2a/ggNxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiiqwWTcSVmUrGeXEAypedCW5tagsdzk787hNrV2FEk=;
 b=GjT/9YR1/WbrLt4C3q3OuvE54/kjuaIlTqw6i0r9gM2nSqPiglyVeNjk+M4pdT9Y6wtfgt4nCkvg1caXIlwQQ1tcoxzCDOigOKbYvMs36WIivRojHwwHR63q9Yjc/RrwCgHTfotYNp4IS7nS4D0529a3q2d7OU7YXN7+sK+BEAM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 34/70] powerpc: remove mmap linked list walks
Thread-Topic: [PATCH v8 34/70] powerpc: remove mmap linked list walks
Thread-Index: AQHYWX87W418ihTXTESXemgHenDitg==
Date:   Tue, 26 Apr 2022 15:06:39 +0000
Message-ID: <20220426150616.3937571-35-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c394d64-b474-494f-8a48-08da279671f6
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929AA68698EE4F93298B4EAFDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0CT8Sj94fm4DnXFnGvIUNSlVtC/lUVjTtZ1OYI6XwD30Mja9Ds5jCVyPge49zDPtuoYKSMb2t348YWXK9KtIyNtzO0ShrL1+S933LzcvHx/QtH3uezP08xC3VkXwZ+dNXlxHz931Yk+pkQbjDnX6RZQDLXEFWTkYFf3V5uDs3LatjGCYpzjHsenckFBDx2VRWYufbzUMku226e7IlvTwd9XeXj77LpdAUZy/NCGcY8wTyXQwjhAj/Xrve/5vPM2S6dhL2Y/tkQYwheuJ7iSig+PAUOiDjZMO/GlCxzeLq9Q0FZGNFg9V4rtEtXlFiu8vtsPjJ48SS1taZarwfhNSQ6yoiuEiZnc5V9DkLqNYRkB5R2mfk3QHuR0YUDrXkhwDHQxboIjGBZcWU9MudwwUtTsx4cU0BU5oj0Cu0MgXSI/Jx8Jc/haHD/nEjuqHfM9CIv8B1fPpRw2anrWE1WUpYQXWgQ5lp5/e64sZVT5UlTpZN5Pb+3vKPaL7MOBbzdCaSseK55MWCq7M6mJL9MD9BpnMl1fZ7L7QhAANOPP0Z7gw/Gz3T134Ol0PVHS8pWFs7d7WV1OV6OAjs4mKErg8fOzvh3NvES+x9npOK4Yp1tMw+2P+Yfw/ulsFUoQQZ7hNzwwdI/A413LOONKyOu2s3LwKDqGfnicH3bcddBnWwPXb8EtY1D2htpsliU+mYX/Z2ug7ylx1Q2q2riwWhCpaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ECyldSrecEwlpsdj7+yRmlkBAl1kYAbaEOH6m5qUEH74/QYZPGhQLYzVol?=
 =?iso-8859-1?Q?+kecO0euyLBlOdMfH4utFkfJeVdYJq8evPjPfDYk/8aMBtWLlkHjT3djeV?=
 =?iso-8859-1?Q?ITQcFoO0xzRaNnMhyu8Rx1RMCPooWwWQlfjVBRUs6OVoP/5BnjbgIgleoa?=
 =?iso-8859-1?Q?/98bWQN4b/pVDMf1e8FveKImvypMChFVeaA6sTs6BEUK1riocJ9WkYwkdd?=
 =?iso-8859-1?Q?nxShCFLMJzvpIJjlEE2WDcYyCV7n5MzcrxYP03w9eZSTbpVjssqN0+lhq0?=
 =?iso-8859-1?Q?vXM2b1A2KkGbxq3TGHprmTmKLmp202t9m09ojJGJKBdIQSK1V2NWyLjvTn?=
 =?iso-8859-1?Q?qu/gAjbU3lM52L63tOqgTesxs2Oib4N8OCpJuSkJ7xj+gj2i3eEtighi1U?=
 =?iso-8859-1?Q?DtFIwLRJ89bJk966A1JonQgnKsUJSFsPuUicAIJVNExY5v1boH+IeRtMKh?=
 =?iso-8859-1?Q?Utb9gqJ3SFKeda1m5MuntWVO0x6NXcFeZAzfML6rn6UwIXJY/5F18zzZPT?=
 =?iso-8859-1?Q?0Fkc7d98sa7YVzzrt5NMYmoiAEgnP6QyYzJeOlhI0rvsz0Jbr4N4AFCMIE?=
 =?iso-8859-1?Q?m6Lt+eSFk+d5whB2lvLeXdnADPctaZVnCzOWKWDbz8SVf+9tkhmdMMVkUo?=
 =?iso-8859-1?Q?K0bQY5UECyNcvcbWuRnI5edl1+gCh3hRui3Ca1YIf5F4YGthKqL7/IFf92?=
 =?iso-8859-1?Q?S8exwtW/zbaQgcW5R9VUVmKrFEKPOW8KWTJ2GitYGvyg5ozMbt4ZFw28Hl?=
 =?iso-8859-1?Q?Avcppni89bXbtl2NUFzVe28PnKVSn9Jr1AijUjh10AlZs5yAaOx7YKASUz?=
 =?iso-8859-1?Q?+AmuGLY5Mk7eFHs858o0Ozl6psX1IQuHyzF414Xw4Z+nsibSNFhHUjiXXZ?=
 =?iso-8859-1?Q?LjA7uRoC41CZK8eJB9AawdvxHTMQgFg93dY6rRmT3P71N3aZVC8LcFoWZC?=
 =?iso-8859-1?Q?STczufCQkq1SAHr6o311XgInntfk4kF4R0t6+0ihf1ni6/fP4oBenl+UtW?=
 =?iso-8859-1?Q?ByWGuxvhdEK3UodDB7lgRCBKODPOmZQ+dbvHGsd0d64xcG3ih1EQy136IF?=
 =?iso-8859-1?Q?r7fX7GDWG5h/nFgbxAeqaQvjtbyR96rfiZ3IFIsw83N+n3h3E8AwYGU/XO?=
 =?iso-8859-1?Q?Rn6dnkGOZAm7EbGzvwOpRDKtuk7kwnThejL5vwYAqIdLVRFtNkx/yqk9hj?=
 =?iso-8859-1?Q?FdZaW5TNrowSg2T/VhAaAK3wx1CiRRPZTwU/AJ6oJQ2WDWyWNDC4SLXNF1?=
 =?iso-8859-1?Q?O9W7u3C+OQKfoPnEJgbVEsL2f1+3Yn/7FvoZziEv1BTS07NCSObPjpk39g?=
 =?iso-8859-1?Q?/3QbFlvJ/3FA1DWQzyNEQNw8XZ9WgcTX736yv3jYaNDI9GJG8kLqT3LvtI?=
 =?iso-8859-1?Q?nIkPlaM4H9I4jvCb8Ye2lmsXK0rq9FD4+74bR5ve3NYdW6jXy1/+WDJggc?=
 =?iso-8859-1?Q?K2pzKqtQqfou0hpzoW9V4PEWjzmCvvJHo+TCos+jc3Fr8zuA/Xuyksh8Ta?=
 =?iso-8859-1?Q?fRAqPxo9KtkLaxW41ElYI0j8xQw+/Hxz/+Fwjd/OrIXXynIAwQUEhldWoq?=
 =?iso-8859-1?Q?9S5HpBC2lswyC7Y+5CAaE/YuH6YlMC2sSkx+35WU5QBFgdhpoeXkrENqC+?=
 =?iso-8859-1?Q?ZjCZ0gBPfxZAJ6s9/T+cOa5ktos+r41xn6v0yJrtSW8ypEynG5XkaTdIZo?=
 =?iso-8859-1?Q?QVuVEO1n/j6GXgxvHV0G6WntP0k7U37C9uopJrzC9ioRkXVxlaBf5Qtv3p?=
 =?iso-8859-1?Q?wcyJ0WPdFAhov8vg17IWuJUsanuSYr8L1/itM8zGlO7A6jKNqZORAdScoQ?=
 =?iso-8859-1?Q?os+wTS3W4gQ4x2WvzqBvl/EO5chXpc8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c394d64-b474-494f-8a48-08da279671f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:39.9898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZTMjwTuioXUzGaPlLLWREznbsuJCG4dUV8r0zWrc3t4NVfp6bxO658wEhZGtBCpM47cX3BKcJk0rS0IkgdMow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-GUID: Jmtca65CtFoVRF70ZcRiOpfkhwZmgva5
X-Proofpoint-ORIG-GUID: Jmtca65CtFoVRF70ZcRiOpfkhwZmgva5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/powerpc/kernel/vdso.c              |  6 +++---
 arch/powerpc/mm/book3s32/tlb.c          | 11 ++++++-----
 arch/powerpc/mm/book3s64/subpage_prot.c | 13 ++-----------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 717f2c9a7573..f70db911e061 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -114,18 +114,18 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_spec))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
=20
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..9ad6b56bfec9 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,14 +81,15 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
-	 * It is safe to go down the mm's list of vmas when called
-	 * from dup_mmap, holding mmap_lock.  It would also be safe from
-	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
-	 * but it seems dup_mmap is the only SMP case which gets here.
+	 * It is safe to iterate the vmas when called from dup_mmap,
+	 * holding mmap_lock.  It would also be safe from unmap_region
+	 * or exit_mmap, but not from vmtruncate on SMP - but it seems
+	 * dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	for_each_vma(vmi, mp)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..d73b3b4176e8 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,24 +149,15 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	for_each_vma_range(vmi, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
 }
 #else
--=20
2.35.1
