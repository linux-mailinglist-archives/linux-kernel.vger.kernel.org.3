Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6D4B70B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiBOOsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239116AbiBOOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C6113AEC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:05 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhgfO030891;
        Tue, 15 Feb 2022 14:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2CCJdh/9xjQymCpcnQUZr4LjF/xTa+r0k4UdqWcj4sc=;
 b=tFEaxPJv9waHj25Nj5hV3Q37jY0Q6N/u4GWIGHgQ2gls8516HeAYr47vZ6nTSYcs0aVT
 HccqZqtpU0bkF1g+XFO0OidfsdGEELFpBrNa8E393w6dhW/+orln+JeJpplv4576Bpp2
 TEtsOWYEBubf6lTotrOfvu9l8A0lT7ih5OQIpcguEowqUwNN11LmtZb1pTGBRQWxbyfh
 RUvXlx7kNLd9tmFUJVcHWFgEpB2Dgc1OAWWQzwYNTWzEbw4MeTWV7GD9d2OvEJk74QGC
 vQ59zEyd7VO7pY79MccCWxQ6iWFK1DTU9Iq8ZWOjVvPFLPKCmcUoKjjCjBj3/6e2PJdS AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psats-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4L145723;
        Tue, 15 Feb 2022 14:43:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKVbLz68Y474VWniR/EDFyuCicQq0hVPBJiEnYKaqTPTplqa6w0YjoYmuGHPlvwvPdRpV2Tm4FjNguNX0mxAQYx9GUojYqjpeBITzf+A/IIcqBM0UAwBIKgXFgrKURuxIL7hoI5Q6lU5V93/bvjxmuFl4v+l1CnWFadDS+zeJAQC7aGXd3+Evj4FyTkLaL7yHD0MdqCZzSr4StajRe8T3sRtaeaI3SJrRPiTkPQzm5zR0ZcSeBkTCPOsA/4speIk2uTPMVbzfU0L9KxesKzKQw+8MK2Gt0WNwC1ZxQVWaa9rG32TUbi7DViQCBBfScG7wNSze60pJLR3pKauC9MInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CCJdh/9xjQymCpcnQUZr4LjF/xTa+r0k4UdqWcj4sc=;
 b=fpl9nVgmW5AE3Y6bFUX3B1Nh8qQ/79f6qoNWwsUhJJcBaQwyJnSA1IZTks4qWBSrOEoIZqWj2vKpEx+TBbFDuzcg0/UBeP3Cua9o++QhaozwvTmuPgA3L+OWQUXT9PikEqdqXXN+bDVUxPFbYtUekDcZyymef0ucGvyheegATDIq1ddLVcariVBRZSln84pd3EC1HCzxs5Jl7B5VY/a1fgfKpmLgSEmU/BiyUd13qOxEy1GXbV8vcmUDvdlm0Yo0aAUqky1dcCnG+eB2yvGWA9LYjQxzneTlEct1J9iS/W0rTwGuolpSdyuuRl05RjXl7AbUu/3EtfqhJARxq78Wfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CCJdh/9xjQymCpcnQUZr4LjF/xTa+r0k4UdqWcj4sc=;
 b=gwrxdvGvLx6UgaVYPkFRuKQXhooyKtRpJjbeiWsjXyv8kce30V/IffytpvCrZKj2Hczm36QX3Z7qJdOx4S7deOhKctCutn7XZiMskokm2kuiKRxeRvmURfWs3jwnpKUnFZ27SpFXNX4iP696AuZs+Fn4AapFp1iOiGryN8S23VM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 41/71] binfmt_elf: Remove vma linked list walk
Thread-Topic: [PATCH v6 41/71] binfmt_elf: Remove vma linked list walk
Thread-Index: AQHYInpe7lsdacqBgkiSlydqswpz3g==
Date:   Tue, 15 Feb 2022 14:43:18 +0000
Message-ID: <20220215144241.3812052-41-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e496f976-46d3-4019-496b-08d9f091971b
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5578F900E4705EF29A71F621FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvjefRN0uTAguBi/0qaCmJN8+ft03gx9Nm4wE4Vf2TofJw2ickIgvXTZfclGVj3EXP1RBsNiXRNUeB7Cj1LN10DkS3q6Fd2+OMoG+z9+Chc/NHNQOo6fZO1d7jgcsz64s46LdLwUjVULDyPFg5/V1QNEC7ON3s6tiHVvXvuG4n2Ggu7QU+b86dAhnX1HUloBmWdGjAnx/RcKjU6XN7XaF4q8A7ulka4K/aNgmN+h3cJACRIhEQlftfcGZ/CedcSDS5PG6sUCa+u8y9qn3Eahh6r+kh4CnRilId3tzVu9km6UOPQT1BwrFvalF99kH6t+VyBPGugfJCSwdkC4CuC1buG7JgBYYlHETQu5VT4JpkZPZnAiVr7O+AKgf8WcEkuU2W/c1CyVgkzKaofSnA7KWqrOYbaHAAGyrevqFedIXp5LqtBDK4IQfsqvrGDzvPLsuZa9261+s6stVIcHAZFDbTVA5EVn99hCEvsGNo33a1dVnPW9SESRATOg8j8ABFk4uusl2wxI1zUGDBCCJ/UNKmgmEfABJCeqJDpzj2qaXTdwMhVROg9vbxje6H84PFTqnC4YoyUOwSdNPsnWXKIERfRr75bFZfArf2Vz0mt2UkCMWhWCJAx5F4CTVa8UIn2q8DTBIQFx8nv+WRiUb/Sk055a4VBKov+1gO6KDKupHxntfJ0xegxG3smz9v0BoBQVLwVveyECZ43a3GHlOs+2aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(4744005)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j9PiwII6u6kgvKwf5NbRytGItV0R/2vqo4xGXmhuhBm/e5WiRTrJz9sU5Z?=
 =?iso-8859-1?Q?kVCmXP/YJQyEXQub59wTT3hIJr5zqh7DSEkNQEfWLPdQ+m12qbT4NZzCh8?=
 =?iso-8859-1?Q?FyrfuFialIancKGU65Du7AF0qBc2y9jL4SsMW6O/EyJIfN3sKvwaw5zcwK?=
 =?iso-8859-1?Q?9fPLKnuVPhoTm7+twbIpuYbN2a7X1MxQWeszcYLmXTWPua1Q71c1OfxQMv?=
 =?iso-8859-1?Q?uxjuxGXcyWWUXeBOFFoW7djjsZXTIpRaCYAI0NnujY0/+b0rkcGe1Z8651?=
 =?iso-8859-1?Q?7GVBmY6PSnYj4FQWVyNCwf4oJ/sBl3r+Q7kr/JCQxKITXZWolrbnqOqCED?=
 =?iso-8859-1?Q?sr8vFxhrL2CRiBIwkqJVWemPvMG19BBuD2yyQcXKK3eMOo46ZAvbENAIAA?=
 =?iso-8859-1?Q?gpr4UpB65jkdKYUwF60nNqj098PzjQ8Z4cfXtXc5fC3s4U8fXgjeCUi+8y?=
 =?iso-8859-1?Q?gTNHEj3R2pKTFB9Q88MYZu84Puh9Dp4YLgowmMz0WTybFnpgAwgZJIGW5x?=
 =?iso-8859-1?Q?Sm7arLOxsqStGp+Ag9DTNq9ofDT0OQu3XedN4MFJMENDviThdEcH511vVf?=
 =?iso-8859-1?Q?w4POD0fZeAu9aQ9PYMBjMHgR8mxi8hMl2CUZ4PdDNIpI1l5NkqwaEqFzDy?=
 =?iso-8859-1?Q?MNQwZz4ZEXg1FayKRgitM7gTk1miZ0KXKHYVekMEo/XZTu3zio0aJqfzVk?=
 =?iso-8859-1?Q?v4up0TnKr1RURAvHO/pW12W720R+8iCSyBvooGCNA5f2GlKRkMAKF3prod?=
 =?iso-8859-1?Q?ZYP3PyOWiylRK+dZT3rjFJ0geLlC1prvWJRzfUEzq3dcvHnr8dB6xcwbja?=
 =?iso-8859-1?Q?2+LHjQiB8eePfP+vGUpuimDdN8fXK+deUZgod977XOdOgiRYbsE2l4uCP5?=
 =?iso-8859-1?Q?PwuWBfEVDhzFLGpo2bF37N0dClEBnxvirq/WHkcePNomOf5Iz+aJvImfpV?=
 =?iso-8859-1?Q?UdBK0PcT4raPcPD+er1vwE7L6kQb2bAT4WI2jg3f4jRwR8VbhrUmzPHfzf?=
 =?iso-8859-1?Q?hBpWLufen07kTmZe1lrJHjLYDLe1VnwxE2vCyvBrVtniV+tR5x6uRsl98u?=
 =?iso-8859-1?Q?gdGcj1/KhDlKBIhmnBJhW6rcG36XdSqurJwkkb2v6z775xYIWQVM7VccYu?=
 =?iso-8859-1?Q?Pbj9bnSdolZgCaE6s7NBLR3B9TDxY98kwYyV+Ro/1JRERN0HEJJdTAPbRk?=
 =?iso-8859-1?Q?/eV1D8GlJNcVA5GSuHIi7NCTTocEXEfHT9w/YJMWWPAWQ3rCd+r5KYytIC?=
 =?iso-8859-1?Q?SMeRu33bMhPfsoQsltSKGPIDIIDiPIuneu2YTtQd7H8Zn367QrM3i2EA7O?=
 =?iso-8859-1?Q?b+CJIeh2GjgVea3eZrjuvVFEsQvBwfgixAstlMUKYXMFqN6RECihJtH+ln?=
 =?iso-8859-1?Q?hGEljKyLe7pybc19kUnRbEMcg/prbYzUDYRhW3Zsp0XIm7+J+4Lg2H5EOg?=
 =?iso-8859-1?Q?dVGGLeoy2GiZAEFwoP9iBNwqMoFabTr8SyTMF6wwAG2DHLaO6rNmEzUfFn?=
 =?iso-8859-1?Q?kRRNKbguLkp8/o9ITFzYZGrXVegMV85Z6ZnaNvnmR6ETd3WCT7OxjDY+rK?=
 =?iso-8859-1?Q?4YZB2hP8t0eTiJz7D+FFraxip7GSoJMJZMNf85bSnicl6it0quKheOAE77?=
 =?iso-8859-1?Q?KkB7wIFHB1wskhAgZV7w/MmgXmFOoKqV99w789Pn23WhMF62lBUuG6Bws+?=
 =?iso-8859-1?Q?ninGaPvJFkyNnKq9NHc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e496f976-46d3-4019-496b-08d9f091971b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:18.2451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojLAJrJjaB74Fb/lbVql3DnTC5zMTggX0g2KijsdI0NysZcAwy9Kb2M9zmTQIlEndRDnQkDOWrAaIjgGUUljAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: 28-uBVO9F_fTT5VznppCiSWcbDK7olY3
X-Proofpoint-ORIG-GUID: 28-uBVO9F_fTT5VznppCiSWcbDK7olY3
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
 fs/binfmt_elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f15efed29d3d..13ef8ca2e52b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1622,6 +1622,7 @@ static void fill_siginfo_note(struct memelfnote *note=
, user_siginfo_t *csigdata,
 static int fill_files_note(struct memelfnote *note)
 {
 	struct mm_struct *mm =3D current->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	unsigned count, size, names_ofs, remaining, n;
 	user_long_t *data;
@@ -1652,7 +1653,7 @@ static int fill_files_note(struct memelfnote *note)
 	remaining =3D size - names_ofs;
 	count =3D 0;
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		struct file *file;
 		const char *filename;
=20
--=20
2.34.1
