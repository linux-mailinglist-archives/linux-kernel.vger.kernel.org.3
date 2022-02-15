Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913194B733F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiBOOrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiBOOo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:44:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57008111DC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:58 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhjbg005590;
        Tue, 15 Feb 2022 14:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rTMkow0d7Ov7Pa3q9o+CIvRRZsUyXUIs4fXzveyIiAQ=;
 b=Bma3kKP3W/AaDb6V2kapwsUJBJvwMZ5ub48Ezz2RbRviQaeK4oDT2JlinN+OndH2vrvi
 F6G9lVajGEoc6TxCk6ruQWTpSpNFYPniJxryepUWOitKw2cGDReBb2xDhwW9FJP13HBY
 baF0yg9E2LlL4+mAAV9U3O9ThG0k+J/zHTJNK04NqYrv0xNHHdSrIFFm20tbhRmf7uP+
 dbB43zFf1bVAsgTsZS4xSU0yg1R0j5V4Qucre0QtYFALF3Z3pemmf+ISk+PNm3ZHf54D
 sCF2sDg7EetMmf/7Rm58qOn9zpM6ceRlPSTtolNeXEqSB59UkmHw57wMO1Q5R/JooSEK JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e88hgh4gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4B145723;
        Tue, 15 Feb 2022 14:43:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/NPZOsGu1+9bG2KZSsNfUAb+y5qQ06Gnht7JPaygAh4lsWzTdD8w4jFBeet4Jy3qNqDtRivjNbCDHn2P/z7VVgDWybJOFrUsJhdt2XUiQ1C+OAmG7NtV3rhjRTReDsmX4IUMDvIry6ntPQrUZPFiUIonPSgZrzcXAAovUgib8d8YgKgZIgHXT29/F2pVfLc7xZ8xJJIh9OnA7kFtEyV7yx6FB40/SX8f6hbtGzd+giti/djFHP/jRiTjodPUMzXcfIFOrzfyCgd+d73BFpWnlBQ18rTPTo/RJQ8MMicyNjid3RLNly0UtnVwlqqcCYxfg088kwKBeogUxZHIRj0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTMkow0d7Ov7Pa3q9o+CIvRRZsUyXUIs4fXzveyIiAQ=;
 b=FSgUx3CJiYhQkSARKaUXkNymnwKwg9QqrhEyLpxUD3mEdi1vCAD/E/k4Ds4UlRtaaAFwnl49DOM/0ovTOzY9m9wwAiz5sHSY/LlT91r+GCurvkzvjdWZElu6bDP9VuQl01hQr8RZaOSFrzVBnuNB1FspY2l/hALCmjg00eceCQbtknry6ANEp3OHOWryIgBCvrS8R4m1qR0fFXrdkhMIFpV5B7rlCVC5jNZK+Gl4EY/nLI77boQF5Hn5ATFCnRyhH7FcMT2i96rPs7fqLhY6iGoVI8kgASNlCyWwf29naBt3vv627DPngauWi8rEPgSVVykhI2X/zPlw121vR9eCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTMkow0d7Ov7Pa3q9o+CIvRRZsUyXUIs4fXzveyIiAQ=;
 b=KYmVyVHlGW5BtaqnRH2U2pFSuODLZbn7Cvz9yY/n3vK9px0RQW6jcBWb9behV8zsEvauw/k3H0DxuOqLXkSfX1VVTWS1nYQFSNDyTG7m1G77772dsB6wZ+qNmrH2jYNws6XZKx7yU3wNeFW1advNhk/2xehdFFflCE9nk9PeKbA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 32/71] arm64: Remove mmap linked list from vdso
Thread-Topic: [PATCH v6 32/71] arm64: Remove mmap linked list from vdso
Thread-Index: AQHYInpcxerRvkkhe0+F8cwix2Bt8g==
Date:   Tue, 15 Feb 2022 14:43:14 +0000
Message-ID: <20220215144241.3812052-32-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b49ae2e-45ab-4500-91d2-08d9f0919513
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB55784FE1264BC024AA7E4CF8FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +tD3FTBKA70ouSBlinQiNlhY0moWwM/Xt5RIsSJJffctEHR8fXPtXK8yQ93b4QMlQpyU2aP7cxIYWqHaD9z+bQaIq7EJ/C3EF4CmNYQdSddRUyKDRriUXuk46kW35VAVMPIiZA56yqfwRnTJxTMWeNDvUiOhCKhBsomWVdGmftMTQsA/hvfCT1ne9x4FK2PiMGSXIg3f+KgA/7Ng0v2Q7CwGtSH+yg46wDj7EUwrd0ZiNftnj1khi9gPZmVFXasUBHQcHX7loT8KWyxcFSvTBux5JU592cDIPXqbztp53S5Elt+DJ4R5aitioFjOeLtvy35iklBJts8P6XcB2leParq/6tjjjtHAaFSTZajvPubwCFaisRqE28orAui/fDKdU7znHrnU9asvtIKFp4Zhm+e5uPeBR1aQxcleOzr0E2pUZbJefa4A4RpTFSLsrbCa11pFmYfguz5/bMq+peOUGQm4WacVOncAJ8o2hlMqRN+djxqry2QYfNUS8HbKk1Az161dCa5zVNLucLH++utFv2yidhsbUvaoVGqwu3ewZCI7Q1RNRBUHakeeVBC63l4ika+ejFn0rgjynDZQHDTu4VxLDFKh6AfyQH03Xq1RDYgbgm/620Pdbc66amDrV2X03uYh3VlLjtDwVGbGbH5m1nctEWQxHRt1Qu0fvkDVVvQg/lthcA6gRQHCTfHQAXrugXEwsckOlrOoW+vH1sMv9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(4744005)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?inzhqZdCxBmUzebZVWHvfES7PlQn2dFpatE98OwzsK6SS2/OyTeiJpuTsy?=
 =?iso-8859-1?Q?cg//8cNr73vgzEaR+rOZL2YMcFOtLz9bX9Y3HR4IcTHzOiE3TBKQStIxxt?=
 =?iso-8859-1?Q?g+ulg8MUyoOxWDapDi1g7kvSWoycxbL5agzro7GVR8DzSOSskrxeUjdH19?=
 =?iso-8859-1?Q?TiLXxGbzV8omPJZ6XjKpuwvD3M23LjwRXeMJJbcfNWkr2aNES7Y4ZKvo0y?=
 =?iso-8859-1?Q?vd73Rz/aR2Z63Jc2N2LTa4wnXloTKBHRP8JyVDmgwG48VFY3N6rusDwH4Z?=
 =?iso-8859-1?Q?Pcm+0DLGCFWzdH0AQ+LKdGVjDbVaeVEPCyNXOxxXJ6sSq0KeKV3mlbweBe?=
 =?iso-8859-1?Q?9LxEHdu3qCJHBxKDyNtvhfdYraeOOWkGQ3NGW94ctVeLRrpjxYOFAzNJ/s?=
 =?iso-8859-1?Q?e44CV1BNssXCI8NWSCtF0N6iDiE5xYDaPwWzTCvl6m7T5dJbFI5DJlC1cS?=
 =?iso-8859-1?Q?qSbsX1bU/NoCQC+kQMbmlRqyHXVKmOgA31Gds7Jgkl6jkksAGz3ZYHwB3y?=
 =?iso-8859-1?Q?A29Byj72J5OKfr+YWfSxIRmKUgj0i9DkdToflcot046RVgLaKcw8we4p8S?=
 =?iso-8859-1?Q?3TRRkThdB9PSUQhn02azW7zI4288usDZGgyUbwN3nYQ7sn65OX2k5Q9SSx?=
 =?iso-8859-1?Q?K+AD0oU7sD0klv6LlLqldFo3po0H2w7PelJ4IcWBfoqRniv2a9TIFOhAc8?=
 =?iso-8859-1?Q?PCylFxn+4gnoBa/FPJIkL0PyWs/lgsEJheWE9fc2ShZdVDPzWRO43grN/7?=
 =?iso-8859-1?Q?om5C7yv1dmue2zXHv6eDlxDBJncQn6fFjBu8HBWwJRE9YhwmLJYZJpb3ro?=
 =?iso-8859-1?Q?tufXaH1nGWFjKKM50tNgJQMhZOxp0WLwroXBkd9RjCVAQKJq5I7WAx8/rF?=
 =?iso-8859-1?Q?/TVlH7rJpp7sPBYT1nVm7Xx5vasQlJhPGMXOIEFkeBqNwtGvOyrQ8Hsb9a?=
 =?iso-8859-1?Q?lZnE+/NjGaCPD2soy8LBfiOmDsQLeY86UxlUGhECZGXevzExUbDEwsfQCh?=
 =?iso-8859-1?Q?faMm0O2BPEoAN/0KuEAda20IAQEbc/hG5Nz+4VLD9hZaTwsBUDVn18uV1M?=
 =?iso-8859-1?Q?QuxW1+D3nKtoevZ31cCyGOZVZJ1ZsTOyujL1txctlj3+G/PhZukLUiA7J1?=
 =?iso-8859-1?Q?AcgCrYpttTvpjUNOa40Tc0ztTgNDNhJiJa7af8FKCvwaY/JjYO23szH8+e?=
 =?iso-8859-1?Q?Lj+loiUSGfbb1APeyaRQA4RfGF3E+wBIPUSEUeIcfVJ2p31OAZIpGtuyxc?=
 =?iso-8859-1?Q?pv4TGqzpqfZuLBTSHnedjcyqvRe/28NtODGV0MrmGNgHZLURpLV4xxpup/?=
 =?iso-8859-1?Q?rSxRacGDtj8s0mkuJS8wcusR7Ir2HnjghzmgeBKN4upMNlErFQ/ztbU+Sk?=
 =?iso-8859-1?Q?m7WsWqrlu3rAUaNVu3an6+PvtGrMCxvYZHlT/FEmvjl2U0uY0WVwqzkL2V?=
 =?iso-8859-1?Q?kIS74rFk2veuDeXlLVjmXbs8oxsmWWiXJ6Au6GHjgr6bJXqiEy8oJyutBi?=
 =?iso-8859-1?Q?E4o9R1ytrnSw6o02rdHku+GaQXJ3bKpJM/aGYn0pV2E6MNOCNNChECUnd9?=
 =?iso-8859-1?Q?aUJgTSGEtwhdg1TOrjuW4P61q1Wt/CaiXmGzOLW4lRltQmEDSLyW6dsNBL?=
 =?iso-8859-1?Q?eqA8wKfdBcldhJLhnu7YP9XtjxZ7GLU/PO8EGYCPU86tYy4u5fRpY5oxLy?=
 =?iso-8859-1?Q?vBOdtpuO8ytiycUPSw4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b49ae2e-45ab-4500-91d2-08d9f0919513
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:14.8703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bTX/+oZe2nuqP018+M8X64hWYnxFvmKt4wzeC4w8H5xXVre4m8Yt0U9iE/9MApuwO5PvxY9H1pyaAfo4GRGjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: 3PE91nrO3MKdassu1eZqdIfTWG7wfhBp
X-Proofpoint-ORIG-GUID: 3PE91nrO3MKdassu1eZqdIfTWG7wfhBp
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
 arch/arm64/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..a8388af62b99 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
--=20
2.34.1
