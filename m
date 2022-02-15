Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F994B735D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiBOOrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiBOOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A69104A6B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:03 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhv1V022185;
        Tue, 15 Feb 2022 14:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MmGflBQkJQ09wytC2Zwalav3W8P+NhN/2lNqTYtMJv8=;
 b=y13reiXmnLWpQd7j/7PbLhU1WUgQm4XS/ECKsYvp1sOHMXWrT+98c0qOPE3N432Vl9gz
 Zceuf/MIk2dQx+zeS65UcCpTSg4aZToB32xtHJc025To2bsPPphNCcL4gtUnSG2QHHtm
 wQCFkQQUAMYlZJXc81XW6n7R3DTo8/2N/sjIbrbX7CQ3OcGGKCHIHOS7fmCie/yTCKDU
 vH/hzWNzPut22Y8jttFgIZpmsLsrWL5g+//sNC4qzCkzoqTlKjdCHkFHuxdb4q4/817A
 48exTCVD9PrQl0s7DJuBlPv/JnS5QLa9ydJ1NzYc9PfiKLELZO1K2pw9CPTvq/VuTYUT cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4G145723;
        Tue, 15 Feb 2022 14:43:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=botUo/qq4g2zNfKPoIbIiT8ffDDIlFtTaTdrVhbuxmJE4hREvNMf1sqkC41zHvd02XjTl3PkV/9yUBNkFxCs38Mfe6alXJKqmySeEcq38AxEQIRY9ZGnflm3KEbW3zL9M8IrTLDcdgIvdRGOAlIWn4L3NOjcgBbFedw5q6VMWhN6+NgNa1x3kGICZVJsIM0ITlzs9v261ED/h8O2a3sOoo1eTMk/PaVMpnihhmlOqcDpAF/lTh6ToWY8w1w2RW2ZUGhuB660GMg2jy1tXcKBCCmg2y/pGWPlPK2nuSK32lOaoyfG0gykbfixgr/hOSomgCzSO8wvRes09am3dnFPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmGflBQkJQ09wytC2Zwalav3W8P+NhN/2lNqTYtMJv8=;
 b=WWEQFqVWimuzQEFGSXw3GQWGKQqV9FNOScMKS528+8ZmGtB4wDiVkqy09DzYuemwuwLe05HDhgc0rsBkBQvvvBtsnjkpxTMidSzYBBu874mlfujg4PAA/LXeNfvnrW39ZuHSOx4jHOTHkmberepqDK3Qosv6u9E5quemyELDXqbX0RcVmJPdwiS7z1n/uPTn+rl0tIb/lChprDeMKrU9myvkHAo05KQwSOZY9Fdai/9hErOmE0Kz1hbdhhF0p5sFLx3rsXc4WU1IewYCNsh7rWopvczn3BLu/lCLi3vSY+YRww9ivbGJmbYV5P7fi1FCUCxe6RUUYKygm8Us7Lk1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmGflBQkJQ09wytC2Zwalav3W8P+NhN/2lNqTYtMJv8=;
 b=zK25aO2MVNHEdLea7UIcXQ4c2XJAe4tPrw+dkiTpjqnitiRRhTrRRpMkRASexnTOYOApSeME6dHWQduIgICK8bvLb+bi8gBptld3N/5W60LtB6QWwsNpaUnJD9WvZzm//1yZUI4O/iDdHNgvMXvjoUAmfQPOrNmXytqyrwV58Fg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 36/71] x86: Remove vma linked list walks
Thread-Topic: [PATCH v6 36/71] x86: Remove vma linked list walks
Thread-Index: AQHYInpdt9lkVlQNqki68lJ6ksgcHQ==
Date:   Tue, 15 Feb 2022 14:43:16 +0000
Message-ID: <20220215144241.3812052-36-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7ccac0e-a1ba-4109-e658-08d9f09195ee
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB55789F54D75D37739A417E7BFD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zPqqpGbU/EXci/Vk9VVsqoAMGAWsO9iImlRNz5rOSdIEFJ+PSIKDaFNsvFCD4cDt8E8qOq5ebXh+B5exSg1W8aCw1sYbRB5k1ndpvkm7JuNpCmEFe7mNN/a45EMzEdhUMGgDT7x9/A1j8YziSqufNOA2dYfFFskIuI6rfzmxzVlEnONOWAxbzxQpNkfN+1a97nF9w283leL9E1Tpp35P5c4zHDjJxPzlVW2TnxNXJIklhgnp2txxQN2wFhHoT4B6CmBzPMHadOSG/tNKLfJmmL29UnREQ2qtWUZFXNWgzzVVPdTERDbx1npSJN3SXFWNlY3DmQN0Ov0bONyvmbZg6a0HCws2aczq03csYdorcP5tI5TNRW5TZ+Ilemr9kup9XtBB/mcRpB46eph9T23Bl5XCZYTPTKqicU9I/Bl51oWmP+0gckQj6Mdk3SvqvLQAoxLRRAKuoDgGvYtAIM1Gd3ZdwGymZKxzAOxvIkDxt/IpuyJaVBEJsKI7RcMhlwxWmYltcakLp/W/1POWXz5E/YNBV67pFGM1zr75dQQ4P7tTBgvtii+Rtk1h51J4uKLLN4Xh9xy9satiMiKwr0XiTxRdIPUiNMkV7T0+NEeLr+00kW/GrkRBozCruPxPfu3CzjOPlCTz7LQmdoYhIgh7qso+DE9zIST/o8bt22hQDXPqYOn8OVHWFgitbiNiyB5ZBFinngiU2+0l3EFAWb+VcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l+7ay8mldsDx+GzP2otYxWZ27hhHY12FPJZVYmcqBUGmHhHmZX0zufEAW0?=
 =?iso-8859-1?Q?0IDx+nzV1rH08rRC/lWOAeslMfB3E9H01mrlswkIL+k+DFnN2XX8pJcI+5?=
 =?iso-8859-1?Q?pvNboAUdthpZENTpY1EN1i6Wf4pWJTpHrkijTvvsRRATCrdn62x5XKl/b8?=
 =?iso-8859-1?Q?dEmsX2vSLVZpni7CzqtaQuPQpjp11gqUc9trRlGEWsHwpDDV4i85xvz+pF?=
 =?iso-8859-1?Q?d+mENnVE+tUCRLH2m5Xjek9CVwDPHx1h54+VDWQ/UuTudunrZPTWeyPTqL?=
 =?iso-8859-1?Q?ROTKHZ+EdZJ9szJbrHf92/Fuyo/kN4Vyjmm0mu0eE3gT9hIAM5VqpB3Wb+?=
 =?iso-8859-1?Q?OZ2BQoy+6FfVp1NevE8Cj4+lhGEZDdwhIgBktRK/srRvn/WWaRB6eq63kn?=
 =?iso-8859-1?Q?HMeUMREZPdQzx/MjDVa+QlJIF6abIFZ/g8IbPdxYxod19r7auSMQgQHEBI?=
 =?iso-8859-1?Q?gdqrzCERRXbtCN1jZtdO8O25gzWQHhc7c4p3TOm/L74qmwHb8tWTgANvfq?=
 =?iso-8859-1?Q?BbYORFU4VgqhyGiEODUUrvvwiw2d0UtadFMght3Zfu7taKPTnNCBINRGyv?=
 =?iso-8859-1?Q?KmhuHJFrWD/sUu5Fvc4/QLk++C1sYoBPffyhXMgCkE2Pwoth/kQrEcFgNZ?=
 =?iso-8859-1?Q?Iq1z72xi6arir44vKMdHZ3EsIv/w9rdan6nw7C+WDKp6h7/T1vqLgjQAXl?=
 =?iso-8859-1?Q?gli4xB0ChyC5+mDbxmR2UXdFWLb3xr6ux+RZpAz41ucIQTcF/M8exiL6Fj?=
 =?iso-8859-1?Q?h7ghb6BHpcMK50ILyYXIxxpVfTUJvzmHQ8/UcEQsvLCnYi6L4Hehq69XYM?=
 =?iso-8859-1?Q?lz8qm8F6f9e6SXddlCyaAt2feUI8/Mh5leoKMitR4O+BL4cJl0XbDwpW9L?=
 =?iso-8859-1?Q?eh4x+hOgjKzE1xI1E43CAkso0asXlYT2IxXJyn6s1y8iBZqtdzkW6Px7Q+?=
 =?iso-8859-1?Q?Gj/PugzpDLUXinSBg5bt1NpuHLiHJQWLjGx4y24mw4RmoRF/imgwPzTd+1?=
 =?iso-8859-1?Q?W4rQi3GQtGyi9VSVxfhzNvje3LGPHWXjn/BOshuFGWp5dJs0KF/X/CWndJ?=
 =?iso-8859-1?Q?BbUPB5vrYEYxvAXe0r0GlC7IUBTjRsOVLIcfjZaeSInB+bQ+dZ/WVtWxGD?=
 =?iso-8859-1?Q?B+TNiOdnWOvJuJVGzeNQymsGxK1eVgx6fD0kCu0gSVL5x8BSZgmNwWXhUT?=
 =?iso-8859-1?Q?ay8yK9MMlxekqdfW845Q1d8s3PjW+QNKVaY0FWf6qMn7RSsfalh38CaGje?=
 =?iso-8859-1?Q?8h0qWCIjkB26/lVhioeACLWVKuNZ3hf/xQqpov9PO5se238Oq822Uk4xAl?=
 =?iso-8859-1?Q?9EB6ui1Ld+PCsD5rntZjNg2z03eO0A/+StEmKjTR9SW3JlM/e7qsBX//rX?=
 =?iso-8859-1?Q?LKooNgT6S8u0/k5oizLiqHDzCjPzJ5p9vZkfxS9Wtv6yLlax2mHEOs2kki?=
 =?iso-8859-1?Q?IzMLC0bXpAHtuCRAcrXhv+wF+W0t14euV2GlmjZgNq6ZT9gDsvGMs6qNgi?=
 =?iso-8859-1?Q?OH2BB3RAjYy0lftNk8+rmF+xzle032fKsbF911y6Z1Drd8lDiwU1rDP4w+?=
 =?iso-8859-1?Q?IKeWjkyWwwsBuKRp0+XatB6CDysSNa2aS1rYJdifZ5PHkS5VIylY9z6tlc?=
 =?iso-8859-1?Q?TPfMDIOYwtx96V8UOURAqa75suj2HVtMbPKMtVtgLdvxMSCUhL4Xg0ecu3?=
 =?iso-8859-1?Q?Sp6Om+AwoLkbfP7JPZM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ccac0e-a1ba-4109-e658-08d9f09195ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:16.3233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yENd90lbSE5kXbLwrxD8mu1iA9/0ounE0l64WTq2KTPWyexwRprcw6zzcuB5rZlNSU4N0thU35qYCyMsqBGlyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: DRS-kmOgNtqHASZhyyTlZVmjIi02W8D-
X-Proofpoint-ORIG-GUID: DRS-kmOgNtqHASZhyyTlZVmjIi02W8D-
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
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
2.34.1
