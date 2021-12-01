Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBCC464FCE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350177AbhLAOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:37:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52960 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349961AbhLAOe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:57 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EP4q9018228;
        Wed, 1 Dec 2021 14:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jn9Utr4TwNJYInFMgz1AL8xIvyXnc9hBFbGkuuPp/zo=;
 b=uInq/HFj3r+BZmuocpcWERcEQ4HIMJw6P5cxashJMVFOzd7ZVj9OVr0oaCZ7Ich5m7Xj
 H3KU5MZ20gBEg/5Qzo2sDZSGllUajE7npkwewVJ2Jrvk68CJyYJ7Xji0Kr2DjiTIHjq2
 sfKnpwXTMikRy6F3DsNsyD9teESEATRQeRuQ73RnFhgtQbDvXjAGy1t4aeL/rSnoRkiA
 OdAzSCI9FTEvAvXRccOW3bqerB9qzrEkmKAp9O6PBCUF2PlEDhxNU7flus5IuUi2O2re
 t8jCt4p6IdZ5gJOh6uLa1Es5MJAfpEWdJt4XI59gs/0r5aaElZ4W1laE97H7j0QazRPC gA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyg0xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBMFH049269;
        Wed, 1 Dec 2021 14:29:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ckaqgkcte-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQHKpApLbYybjIA1ehV3SlxEozxykf/Mfyf1aeAB8H3QASpiin/Y2bCY2RjVQZ862il4fLVZcnAVLQE0OmwwiVJ2BUIgzDuyJpMMGQEGzlD4xNHTCeALfhJjS3sdJaCY6TOQCzMwxZiqED+QxGnfDG1SdWKWNUl2iPn9527sHKLIl5MXNTxf7v9Ca4c8o+0NKWg2ZsR5ouUm/BgPN+xXlt5g+gVprOIgQMHPhx+zM7P97+Y6a643GUEEsP9uKaNWnL98UdSEB0RUxZzmpwo1uJEOWYNb9JdRF1AYh6afn3FKxIukug2DJMZwHZYYzIZ3eytoUPX7ont7ADsK/EnSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn9Utr4TwNJYInFMgz1AL8xIvyXnc9hBFbGkuuPp/zo=;
 b=bXaoCLlA0jGR3FjJYHUb7+5Fvejy0BtxY8jllmXRSsglxqYOqb2QLbDjS6u0vce5gJQny4Lq7g+75wa96ueFS68S/RYlqWJF8SDdBDi9muTryNawsOcKyupmh8gc19+E71dKijv6Xctppw1qhT4AzkZy5BpFSjFBrFh8ROVTj/sQ55TYZDsFziWpnMMIEfYUC4+OXn3Y0j4Nb0vQvacVZL1L7hvwtK9eO6im8/PPxM+M7PpB4HotZDFaSJXCBfDhELUB9gXDSQoEtO+w9GGIlDevm3ZV9MWXjS1KxEUlHGp7Gx6k5/xdDMTR0vcVpowItT7ESnVNbuv2IviVjoh2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn9Utr4TwNJYInFMgz1AL8xIvyXnc9hBFbGkuuPp/zo=;
 b=TQGxfexdqxxmADrsndQJ1EXzNsDNyCbhVsU9hGwOzC5LLm5yM7S6XJwcWe/fwAYA2tZ6+QcRnRahIEsQsTy060sCgGUHEL++8nhLcok+rBDYrBnSo3hm0qyBzJPJx0919c4At4ja7yHGuuuQPKrW17ts2dSUXrk68uZh5FHubSQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:52 +0000
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
Subject: [PATCH v4 06/66] mm: Start tracking VMAs with maple tree
Thread-Topic: [PATCH v4 06/66] mm: Start tracking VMAs with maple tree
Thread-Index: AQHX5r/mD+pD2kMpi0SkA58fz4UERA==
Date:   Wed, 1 Dec 2021 14:29:50 +0000
Message-ID: <20211201142918.921493-7-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02046d1e-52a2-4a0f-a7c4-08d9b4d7098a
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB2768E996518F22A985A2A801FD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:381;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZGatw4DXj0Eey6m2qZrdacwBrwC+GpihbDYnAhNpChEl4Qkp4amlc2JnHfYkJ4+t4XaydisRldnvlJGjNyVU+cpKmLcgNe8ZwxLlw7x0NYPCQwnt/0mQYd/2RpggnD0A1DZieE3hz/CtZxgaLiQ63Z7q9PfUs8NQV4PRlSWRugjvIkg4AktxkgDh8bif4uSQZ/ELRVpCgFDHP2lEBPZnuPHV7G3aIMMyMo+qZkIwMxtn8YHUkebvOExPOOBwGQ+u484ew7THTTVrP+i3rBAy5Am/iAXywN7b0wL+iEDWwcsMUHfynOFxiYhwBUT7MbcNhqrX44QQB9c4zi2/ijzG9xOHdVPsipsCJh/nZfG6Hn5AtMG3sh/jn5ON9RHuHgxsfPFBxltbsmafGNMUpigWPZu3vHqhMqTxTmt/r8WcDqWC7F7wGo3dY6C/8TmBwgk8XbHIX19GdCt5UnTnES0FYfn0TVLgZm4eBUVb43Per+7L61Td3B+Hd9Fa/exwSS2/wMYlO2tMzSdNeHLWRidB7GwzL2WyEp5PQZDmL8aG3FYYWnrZ/IXIawed4dAxHxhU6DoKMFM/Ovo3jNxUdgq5VNlcnPiQXNA3YONrS+TYhFjVZOU0rS9wPLPxHX1sdSUUfkab/+flYmYNiI3gK/jGaLienWDPgXARprFrq6TMC/w+Bk3DFdCCCsKSmc90Lf5qTHVy1l/lwPZigzH5fKnu5oupKEbqXBz+m1vOStk60qAvw/D+OYzMWbrCwMjMWD31WtOCH4VCO4nOxlknmoAasT5yfu9h/T2HPe/BnsW+H4o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(30864003)(110136005)(316002)(36756003)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(966005)(6506007)(107886003)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cwLyaNtt7fvD5cjJqnh/mdjsuHuHv1cT0RMW5SdmhLpLBuCX2vq8pybjyk?=
 =?iso-8859-1?Q?nDSeu+U1KtpAvLALvABD98BpcGoxFNGOyR+S0iGuapSzxrMRPvXWawJJC+?=
 =?iso-8859-1?Q?2puYgqBwdMdnZPzqYrzVstRWgmgLNry9Rt3MYm+LpFooD+mGHZwjbNv3oC?=
 =?iso-8859-1?Q?24k3oziUds2YAMvntQ9hXoEdKyUxNj/A1FpmCIgxVlAfx41x39IPLpxye4?=
 =?iso-8859-1?Q?R/gZa4DQHCeVBWKDvoEUvUNIS+EgdEjoGS//Pz5g5WsvRMyxlt4eWx1YU5?=
 =?iso-8859-1?Q?q0NQ5BMuqSJ4geCNtNTw9NNznJeYcEY9xYfj5BqYmbGEI86SO+3rTHjsF+?=
 =?iso-8859-1?Q?QOxzXXcWRPKKAStuXSLpZ1mZmZ61GXLSOy4tB1yhWNvCgiIn4F3YcdQsxp?=
 =?iso-8859-1?Q?QbMYwghcstLqFM9Pk3f3Bzx6Z1zUkwDAnfDBDCP7BS+3+FKPFDj8dv+aql?=
 =?iso-8859-1?Q?uXOcxjlkCn3h5q9SsdhEoXAWM/1cI/DWUmv7hRe0pKzm7tQRGkFW+HV28c?=
 =?iso-8859-1?Q?VojBLLVzd6PZl7Nln98crisReWSJNs2l4NodGmQHIdIOed4ksmg2z5J5/h?=
 =?iso-8859-1?Q?N+Mth5NALcBlVApgw2N5kCa4Wws8sJKCVSO4DQnzQVRWvovjn4dxu56Om4?=
 =?iso-8859-1?Q?TF9LI5QuDX10UwJQh7p6ItYH6eSNZ979UppQSJ5mMrsARpV9dXTEMSQycG?=
 =?iso-8859-1?Q?y5Zayz+b8nEKyDB1yKgd2jX9HPGr6rMZWhr/vuT5kVP3HNVpguG6Yi+uId?=
 =?iso-8859-1?Q?ng+Pes33MjYXrhNM/QlzzkqInynsHUKH3IjK/qm8W4g3FJfg3jg9F8jWUH?=
 =?iso-8859-1?Q?dg6LuAQR4CuDoy+yRJkkgY39FumvrOtAsObA+Z6pfpyKpF2KolqjahN3j3?=
 =?iso-8859-1?Q?03DlWLERwdtwrXMfushRGHfLi4hZo1bj63pys/cPi7UtonNX1ZP/tEO1qq?=
 =?iso-8859-1?Q?i5L1/LyXmWCSmhnCrvJUSk7RsjjIfVzZ8AxcnQpUAIsVQDv4uo3M9FzmrY?=
 =?iso-8859-1?Q?2+lIEzHdETepPVykiboP/uBj55vo1O/Sr4fvW9HCS8dY3I8AVZutGolmLb?=
 =?iso-8859-1?Q?6GCQSLrqZvPVBk58rMb4eQQMOVe086QiUn41sOsoX6xU/Qxx04J9/SmKSa?=
 =?iso-8859-1?Q?U0DfcCIkn2A/vYLZf7hTCXQkYcbkwfnKiyJ0fx3V3wOyNHT1PiTi2SMnzw?=
 =?iso-8859-1?Q?X8hLouSikGoa/LBLLAWmMUSELk2BmzOBEcHsmUssB9E4gdabdNkiigaqIn?=
 =?iso-8859-1?Q?Gv2h4p9TB6oeDSA1mqoK1+Ct8ljC0PcY2k852dgm+XCSXPCJ5j/IZNLenI?=
 =?iso-8859-1?Q?pT9Yn6Te7wvpM2KW0RxkhuWiTYHTCls/foWWjxeAYskU4Hi0LbsV6jqLJ9?=
 =?iso-8859-1?Q?cK1OzV+i3/iAhhZP49dX3a0cKcgW6Pau0lJFad/jygPt95W5fMiaDCvIJX?=
 =?iso-8859-1?Q?t+kJdI2mr5yDEq6co2oGpx19lGCh8rVcM+mpnQ5/Q9Z9GOg1pCMvfD6Nzp?=
 =?iso-8859-1?Q?Nlx/maftfmyXLVk1iIFlDwAIMBKv+Z32lCKyJcJyvlWaYX3KjPmEiYQMaq?=
 =?iso-8859-1?Q?+485ez2Y6CVRp4k7p00dlOLyr0oOp2Wrg/Rcg6+atvthsffzjiWebJC5cq?=
 =?iso-8859-1?Q?AdTpX6iXSAdNXtkWYhT2bAk0GDq8lsVwnRPD6COVCggTlrr2GSHOpSNQIs?=
 =?iso-8859-1?Q?8f+XR73uwFqSheyKZZI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02046d1e-52a2-4a0f-a7c4-08d9b4d7098a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:50.9832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cSmM3Np6qWTua5RrDt1WHZF4oR3mI8708Ha9y98JYQiYV2E2XQlXY8B6qKvgsoCR4zQvzSJ+/vkf9MqbhrekQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-GUID: TYRx5Q6MQGw49-oJ4wse21wdANjSSXhP
X-Proofpoint-ORIG-GUID: TYRx5Q6MQGw49-oJ4wse21wdANjSSXhP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Start tracking the VMAs with the new maple tree structure in parallel
with the rb_tree.  Add debug and trace events for maple tree operations
and duplicate the rb_tree that is created on forks into the maple tree.

The maple tree is added to the mm_struct including the mm_init struct,
added support in required mm/mmap functions, added tracking in
kernel/fork for process forking, and used to find the unmapped_area and
checked against what the rbtree finds.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/x86/kernel/tboot.c     |   1 +
 drivers/firmware/efi/efi.c  |   1 +
 include/linux/mm.h          |   2 +
 include/linux/mm_types.h    |   3 +
 include/trace/events/mmap.h |  71 ++++++++++++
 init/main.c                 |   2 +
 kernel/fork.c               |   5 +
 mm/init-mm.c                |   2 +
 mm/internal.h               |  73 ++++++++++++
 mm/mmap.c                   | 220 +++++++++++++++++++++++++++++++++++-
 10 files changed, 378 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index f9af561c3cd4..859e8d2ea070 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -98,6 +98,7 @@ void __init tboot_probe(void)
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm =3D {
 	.mm_rb          =3D RB_ROOT,
+	.mm_mt          =3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, tboot_mm.mmap_lock=
),
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
 	.mm_count       =3D ATOMIC_INIT(1),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ae79c3300129..0b40291416ca 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -55,6 +55,7 @@ static unsigned long __initdata rt_prop =3D EFI_INVALID_T=
ABLE_ADDR;
=20
 struct mm_struct efi_mm =3D {
 	.mm_rb			=3D RB_ROOT,
+	.mm_mt			=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
 	.mm_users		=3D ATOMIC_INIT(2),
 	.mm_count		=3D ATOMIC_INIT(1),
 	.write_protect_seq      =3D SEQCNT_ZERO(efi_mm.write_protect_seq),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..9eae78a155be 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2610,6 +2610,8 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
+/* maple_tree */
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c3a6e6209600..d9ce412fca04 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -467,6 +468,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
+		struct maple_tree mm_mt;
 		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
@@ -655,6 +657,7 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
=20
+#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN)
 extern struct mm_struct init_mm;
=20
 /* Pointer magic because the dynamic array size confuses some compilers. *=
/
diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index 4661f7ba07c0..f5c1626f3bbb 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -42,6 +42,77 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->low_limit, __entry->high_limit, __entry->align_mask,
 		__entry->align_offset)
 );
+
+TRACE_EVENT(vma_mt_szero,
+	TP_PROTO(struct mm_struct *mm, unsigned long start,
+		 unsigned long end),
+
+	TP_ARGS(mm, start, end),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+			__field(unsigned long, start)
+			__field(unsigned long, end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+			__entry->start		=3D start;
+			__entry->end		=3D end - 1;
+	),
+
+	TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
+		  __entry->mm,
+		  (unsigned long) __entry->start,
+		  (unsigned long) __entry->end
+	)
+);
+
+TRACE_EVENT(vma_store,
+	TP_PROTO(struct mm_struct *mm, struct vm_area_struct *vma),
+
+	TP_ARGS(mm, vma),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+			__field(struct vm_area_struct *, vma)
+			__field(unsigned long, vm_start)
+			__field(unsigned long, vm_end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+			__entry->vma		=3D vma;
+			__entry->vm_start	=3D vma->vm_start;
+			__entry->vm_end		=3D vma->vm_end - 1;
+	),
+
+	TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
+		  __entry->mm, __entry->vma,
+		  (unsigned long) __entry->vm_start,
+		  (unsigned long) __entry->vm_end
+	)
+);
+
+
+TRACE_EVENT(exit_mmap,
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+	),
+
+	TP_printk("mt_mod %p, DESTROY\n",
+		  __entry->mm
+	)
+);
+
 #endif
=20
 /* This part must be outside protection */
diff --git a/init/main.c b/init/main.c
index bb984ed79de0..ed906a15a86c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -115,6 +115,7 @@ static int kernel_init(void *);
=20
 extern void init_IRQ(void);
 extern void radix_tree_init(void);
+extern void maple_tree_init(void);
=20
 /*
  * Debug helper: via this flag we know that we are in 'early bootup code'
@@ -997,6 +998,7 @@ asmlinkage __visible void __init __no_sanitize_address =
start_kernel(void)
 		 "Interrupts were enabled *very* early, fixing it\n"))
 		local_irq_disable();
 	radix_tree_init();
+	maple_tree_init();
=20
 	/*
 	 * Set up housekeeping before setting up workqueues to allow the unbound
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..cc9bb95c7678 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -604,6 +604,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		rb_link =3D &tmp->vm_rb.rb_right;
 		rb_parent =3D &tmp->vm_rb;
=20
+		/* Link the vma into the MT */
+		vma_store(mm, tmp);
+
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval =3D copy_page_range(tmp, mpnt);
@@ -1037,6 +1040,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 {
 	mm->mmap =3D NULL;
 	mm->mm_rb =3D RB_ROOT;
+	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
+	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index b4a6f38fb51d..7622ca24eeb7 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
@@ -28,6 +29,7 @@
  */
 struct mm_struct init_mm =3D {
 	.mm_rb		=3D RB_ROOT,
+	.mm_mt		=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, init_mm.mmap_lock),
 	.pgd		=3D swapper_pg_dir,
 	.mm_users	=3D ATOMIC_INIT(2),
 	.mm_count	=3D ATOMIC_INIT(1),
diff --git a/mm/internal.h b/mm/internal.h
index 3b79a5c9427a..7ec79cef3ea9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -382,6 +382,79 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) =3D=3D VM_WRITE;
 }
=20
+/* Maple tree operations using VMAs */
+/*
+ * vma_mas_store() - Store a VMA in the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to store a VMA in the maple tree when the @mas has alread=
y
+ * walked to the correct location.
+ *
+ * Note: the end address is inclusive in the maple tree.
+ */
+static inline int vma_mas_store(struct vm_area_struct *vma, struct ma_stat=
e *mas)
+{
+	int ret;
+
+#ifdef CONFIG_DEBUG_MAPLE_TREE
+	/* Make sure no VMAs are about to be lost. */
+	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
+	struct vm_area_struct *vma_mas;
+	int count =3D 0;
+
+	mas_for_each(&test, vma_mas, vma->vm_end - 1) {
+		/* Rule out vma_expand */
+		if ((vma->vm_start !=3D vma_mas->vm_start) &&
+		    (vma->vm_end !=3D vma_mas->vm_end))
+			count++;
+	}
+
+	BUG_ON(count);
+
+	BUG_ON(mas->min > vma->vm_start);
+	BUG_ON(mas->index > vma->vm_start);
+#endif
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	ret =3D mas_store_gfp(mas, vma, GFP_KERNEL);
+	return ret;
+}
+
+/*
+ * vma_mas_remove() - Remove a VMA from the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to remove a VMA from the maple tree when the @mas has alr=
eady
+ * been established and points to the correct location.
+ * Note: the end address is inclusive in the maple tree.
+ */
+static inline int vma_mas_remove(struct vm_area_struct *vma, struct ma_sta=
te *mas)
+{
+	int ret;
+
+#ifdef CONFIG_DEBUG_MAPLE_TREE
+	/* Make sure no VMAs are about to be lost. */
+	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
+	struct vm_area_struct *vma_mas;
+	int count =3D 0;
+
+	mas_for_each(&test, vma_mas, vma->vm_end - 1)
+		count++;
+
+	BUG_ON(count !=3D 1);
+
+	BUG_ON(mas->min > vma->vm_start);
+	BUG_ON(mas->index > vma->vm_start);
+	BUG_ON(mas->min > mas->index);
+#endif
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	ret =3D mas_store_gfp(mas, NULL, GFP_KERNEL);
+	return ret;
+}
+
 /* mm/util.c */
 void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev);
diff --git a/mm/mmap.c b/mm/mmap.c
index bfb0ea164a90..c2f1431886d4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -375,7 +375,70 @@ static int browse_rb(struct mm_struct *mm)
 	}
 	return bug ? -1 : i;
 }
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+extern void mt_validate(struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt);
=20
+/* Validate the maple tree */
+static void validate_mm_mt(struct mm_struct *mm)
+{
+	struct maple_tree *mt =3D &mm->mm_mt;
+	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+
+	MA_STATE(mas, mt, 0, 0);
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if (xa_is_zero(vma_mt))
+			continue;
+
+		if (!vma)
+			break;
+
+		if ((vma !=3D vma_mt) ||
+		    (vma->vm_start !=3D vma_mt->vm_start) ||
+		    (vma->vm_end !=3D vma_mt->vm_end) ||
+		    (vma->vm_start !=3D mas.index) ||
+		    (vma->vm_end - 1 !=3D mas.last)) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+#ifdef CONFIG_DEBUG_VM
+			dump_vma(vma_mt);
+			pr_emerg("and next in rb\n");
+			dump_vma(vma->vm_next);
+#endif
+			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
+				 mas.index, mas.last);
+			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
+				 vma_mt->vm_start, vma_mt->vm_end);
+			pr_emerg("rb vma: %px %lu - %lu\n", vma,
+				 vma->vm_start, vma->vm_end);
+			pr_emerg("rb->next =3D %px %lu - %lu\n", vma->vm_next,
+					vma->vm_next->vm_start, vma->vm_next->vm_end);
+
+			mt_dump(mas.tree);
+			if (vma_mt->vm_end !=3D mas.last + 1) {
+				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
+						mm, vma_mt->vm_start, vma_mt->vm_end,
+						mas.index, mas.last);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_end !=3D mas.last + 1, mm);
+			if (vma_mt->vm_start !=3D mas.index) {
+				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
+						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
+		}
+		VM_BUG_ON(vma !=3D vma_mt);
+		vma =3D vma->vm_next;
+
+	}
+	VM_BUG_ON(vma);
+	mt_validate(&mm->mm_mt);
+}
+#else
+#define validate_mm_mt(root) do { } while (0)
+#endif
 static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ig=
nore)
 {
 	struct rb_node *nd;
@@ -430,6 +493,7 @@ static void validate_mm(struct mm_struct *mm)
 }
 #else
 #define validate_mm_rb(root, ignore) do { } while (0)
+#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif
=20
@@ -674,11 +738,42 @@ static void __vma_link_file(struct vm_area_struct *vm=
a)
 	}
 }
=20
+/*
+ * vma_mt_szero() - Set a given range to zero.  Used when modifying a
+ * vm_area_struct start or end.
+ *
+ * @mm: The struct_mm
+ * @start: The start address to zero
+ * @end: The end address to zero.
+ */
+static inline void vma_mt_szero(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
+{
+	MA_STATE(mas, &mm->mm_mt, start, end - 1);
+
+	trace_vma_mt_szero(mm, start, end);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+}
+
+/*
+ * vma_store() - Store a given vm_area_struct in the maple tree.
+ * @mm: The struct_mm
+ * @vma: The vm_area_struct to store in the maple tree.
+ */
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end - 1);
+
+	trace_vma_store(mm, vma);
+	mas_store_gfp(&mas, vma, GFP_KERNEL);
+}
+
 static void
 __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *prev, struct rb_node **rb_link,
 	struct rb_node *rb_parent)
 {
+	vma_store(mm, vma);
 	__vma_link_list(mm, vma, prev);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
@@ -751,6 +846,9 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
=20
+	validate_mm(mm);
+	validate_mm_mt(mm);
+
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
@@ -876,17 +974,28 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
+		unsigned long old_start =3D vma->vm_start;
 		vma->vm_start =3D start;
+		if (old_start < start)
+			vma_mt_szero(mm, old_start, start);
 		start_changed =3D true;
 	}
 	if (end !=3D vma->vm_end) {
+		unsigned long old_end =3D vma->vm_end;
 		vma->vm_end =3D end;
+		if (old_end > end)
+			vma_mt_szero(mm, end, old_end);
 		end_changed =3D true;
 	}
+
+	if (end_changed || start_changed)
+		vma_store(mm, vma);
+
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
+		vma_store(mm, next);
 	}
=20
 	if (file) {
@@ -900,6 +1009,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		/*
 		 * vma_merge has merged next into vma, and needs
 		 * us to remove next before dropping the locks.
+		 * Since we have expanded over this vma, the maple tree will
+		 * have overwritten by storing the value
 		 */
 		if (remove_next !=3D 3)
 			__vma_unlink(mm, next, next);
@@ -1019,6 +1130,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
+	validate_mm_mt(mm);
=20
 	return 0;
 }
@@ -1166,6 +1278,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
+	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1241,6 +1354,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma_merge(area, vm_flags);
 		return area;
 	}
+	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1722,6 +1836,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
+	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1869,6 +1984,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1885,6 +2001,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -1901,12 +2018,21 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	rcu_read_lock();
+	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+			   length);
+	rcu_read_unlock();
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+
 	/* Adjust search limits by the desired length */
 	if (info->high_limit < length)
 		return -ENOMEM;
@@ -1988,20 +2114,39 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
=20
 	VM_BUG_ON(gap_start + info->length > info->high_limit);
 	VM_BUG_ON(gap_start + info->length > gap_end);
+
+	VM_BUG_ON(gap !=3D gap_start);
 	return gap_start;
 }
=20
+static inline unsigned long top_area_aligned(struct vm_unmapped_area_info =
*info,
+					     unsigned long end)
+{
+	return (end - info->length - info->align_offset) & (~info->align_mask);
+}
+
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	validate_mm_mt(mm);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	rcu_read_lock();
+	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+		   length);
+	rcu_read_unlock();
+	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
+	gap -=3D info->align_offset & info->align_mask;
+
 	/*
 	 * Adjust search limits by the desired length.
 	 * See implementation comment at top of unmapped_area().
@@ -2087,6 +2232,32 @@ static unsigned long unmapped_area_topdown(struct vm=
_unmapped_area_info *info)
=20
 	VM_BUG_ON(gap_end < info->low_limit);
 	VM_BUG_ON(gap_end < gap_start);
+
+	if (gap !=3D gap_end) {
+		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
+		       mm, gap, gap_end);
+		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
+		       info->low_limit, length);
+		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
+		       mas.last);
+		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
+		       info->align_mask, info->align_offset);
+		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
+		       find_vma(mm, mas.index), vma);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		{
+			struct vm_area_struct *dv =3D mm->mmap;
+
+			while (dv) {
+				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
+				dv =3D dv->vm_next;
+			}
+		}
+		VM_BUG_ON(gap !=3D gap_end);
+	}
+
 	return gap_end;
 }
=20
@@ -2300,7 +2471,6 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 		vmacache_update(addr, vma);
 	return vma;
 }
-
 EXPORT_SYMBOL(find_vma);
=20
 /*
@@ -2381,6 +2551,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	unsigned long gap_addr;
 	int error =3D 0;
=20
+	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2457,6 +2628,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
 	validate_mm(mm);
+	validate_mm_mt(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2471,6 +2643,7 @@ int expand_downwards(struct vm_area_struct *vma,
 	struct vm_area_struct *prev;
 	int error =3D 0;
=20
+	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2524,6 +2697,8 @@ int expand_downwards(struct vm_area_struct *vma,
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
+				/* Overwrite old entry in mtree. */
+				vma_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2665,6 +2840,7 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct vm_area_struct *vma,
=20
 	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev =3D NULL;
+	vma_mt_szero(mm, vma->vm_start, end);
 	do {
 		vma_rb_erase(vma, &mm->mm_rb);
 		mm->map_count--;
@@ -2703,6 +2879,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
+	validate_mm_mt(mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2755,6 +2932,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
+	validate_mm_mt(mm);
 	return err;
 }
=20
@@ -3026,6 +3204,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
+	validate_mm_mt(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3083,6 +3262,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
+	validate_mm_mt(mm);
 	return 0;
 }
=20
@@ -3153,6 +3333,13 @@ void exit_mmap(struct mm_struct *mm)
 		mmap_write_unlock(mm);
 	}
=20
+	/*
+	 * Actually taking the mmap semaphore here costs 3% performance on
+	 * a large machine:
+	 * https://lore.kernel.org/lkml/20170725151754.3txp44a2kbffsxdg@node.shut=
emov.name/
+	 * Lockdep will complain about not holding the mmap_lock, so we lie.
+	 */
+	rwsem_acquire(&mm->mmap_lock.dep_map, 0, 0, _THIS_IP_);
 	if (mm->locked_vm)
 		unlock_range(mm->mmap, ULONG_MAX);
=20
@@ -3181,6 +3368,11 @@ void exit_mmap(struct mm_struct *mm)
 		vma =3D remove_vma(vma);
 		cond_resched();
 	}
+
+	trace_exit_mmap(mm);
+	__mt_destroy(&mm->mm_mt);
+	rwsem_release(&mm->mmap_lock.dep_map, _THIS_IP_);
+
 	vm_unacct_memory(nr_accounted);
 }
=20
@@ -3192,10 +3384,25 @@ int insert_vm_struct(struct mm_struct *mm, struct v=
m_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
+	unsigned long start =3D vma->vm_start;
+	struct vm_area_struct *overlap =3D NULL;
=20
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		return -ENOMEM;
+
+	overlap =3D mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
+	if (overlap) {
+
+		pr_err("Found vma ending at %lu\n", start - 1);
+		pr_err("vma : %lu =3D> %lu-%lu\n", (unsigned long)overlap,
+				overlap->vm_start, overlap->vm_end - 1);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		BUG();
+	}
+
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
 		return -ENOMEM;
@@ -3235,7 +3442,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma =3D true;
+	unsigned long index =3D addr;
=20
+	validate_mm_mt(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3247,6 +3456,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
=20
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
+	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
+		BUG();
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx);
@@ -3290,6 +3501,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks =3D false;
 	}
+	validate_mm_mt(mm);
 	return new_vma;
=20
 out_free_mempol:
@@ -3297,6 +3509,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
+	validate_mm_mt(mm);
 	return NULL;
 }
=20
@@ -3433,6 +3646,7 @@ static struct vm_area_struct *__install_special_mappi=
ng(
 	int ret;
 	struct vm_area_struct *vma;
=20
+	validate_mm_mt(mm);
 	vma =3D vm_area_alloc(mm);
 	if (unlikely(vma =3D=3D NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3454,10 +3668,12 @@ static struct vm_area_struct *__install_special_map=
ping(
=20
 	perf_event_mmap(vma);
=20
+	validate_mm_mt(mm);
 	return vma;
=20
 out:
 	vm_area_free(vma);
+	validate_mm_mt(mm);
 	return ERR_PTR(ret);
 }
=20
--=20
2.30.2
