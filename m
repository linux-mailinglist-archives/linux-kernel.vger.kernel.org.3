Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C334A464FE8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350402AbhLAOjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:39:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38754 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350025AbhLAOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:21 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DDP4Z010062;
        Wed, 1 Dec 2021 14:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AOeWOQP0G+SUtPMZjRHYL+pX/Z+e7nll5757Ht5Gbjo=;
 b=Tg2PhGt1VgdtUWmF4mi9lETAL2WJIIXpO7sSBaeemwJIH0ofZo4j4gVrdFietlB+y/7b
 +nIySUSNbyg9wdaoPWFoMtvZ3yGzVrKScxX2MQ3QatSbcrDXQqkarNchR4WlKaIuEIV6
 N0JwbV6qRoP8X1tbhshFKf3o2lQFSIwzn2cCQ5ZMre2zNA/I4dpciFGJcXVPRUUtSqDR
 XU4ipO//VrV/Bhuz6SbEpYE9SWyxrD8nKAYNB/s88Kr5U/x13eBpEckfRMfTjxZosmJx
 /cySHQW4cL5APYTBnVs54d24Rgj0unFCfExJB0XgAZIpIu+2sJMi4XJ6t1ka48C/Wuxr sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPV108922;
        Wed, 1 Dec 2021 14:30:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP2XmfBtIluEb49jAyo3u/NzfZaTpAXEgvm93NmjX5RssVhb2vpMWMwnQWFEplVTZi5DbOL6P3ZXu6B6IyySA6UDwPLIR28/PGARCzPLesIUfzIKdmkk68QU7UXmNlo09LoexnOifsV3CaKL0nwS68FzrA/GU63RivxwybH/YpxVbOwfRnercPtKzr3D8uRvQBwsl6norDb6tLCTyjwrT74TpwzVZZVpL//34A2YOlVjTpwXs7EHXW0OIxmsqs3mMA2CcSuSS7p588DHKrFXo9/WU8RIljNeId0PWkjupAHcB0xr47jxZCMlD/3/PmFhrWKJWAjTsba3O9s55CH3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOeWOQP0G+SUtPMZjRHYL+pX/Z+e7nll5757Ht5Gbjo=;
 b=AAj32hWu8lnzXuqa6wRSLcvMUf8NYzTzhXP5UZqBifro61MD3K8al/003DzANWjVo3QKnHPnDs7sG4Ur1ZCQX/VsIDXMbuIODJ1rvuF/9IVATk5qfQn5hP0tqsPquVRmvr0caA3xX8BPYhVvX0LPlOGRzKbj2KeWNoe7uAf0rjJinpiJOJ3by24BJrw2AeERu5WInT+nocPlWm0KpgFLuYINewPIXqW6ydA3cdcdyCe1O4CmCTPq2MMG3oNmgghk76svIOQkmFS/lC+zkvvVNPtY1y+CZAUj3mJcspwqdrEekIYxxlmL0NyroAOrNMGyij3QupEI9jpsUBQAJSDfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOeWOQP0G+SUtPMZjRHYL+pX/Z+e7nll5757Ht5Gbjo=;
 b=EVr7FVJhg+z0MmIN+omEp7zljI+hbVRHIO1PC0Pek44+gB9eXM0vJygnwtGRzBVo+2mnBidlRpADyyaIi5jgCIgxuNQnrLEVVnkKbOMtJVzNanCPdEPxUy8g+o/7IXYVbgCMMU5dxQFVaI8rIKDUi0pQ34L4n3Eys+In7lNt8Is=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:38 +0000
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
Subject: [PATCH v4 41/66] fs/proc/base: Use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v4 41/66] fs/proc/base: Use maple tree iterators in place
 of linked list
Thread-Index: AQHX5r/xyY+1opa6LUOC0WVCKNxImw==
Date:   Wed, 1 Dec 2021 14:30:09 +0000
Message-ID: <20211201142918.921493-42-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dc53e03-4bed-46a7-3b31-08d9b4d7250c
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB45081979FCA74AD6A7308516FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IqG9YcArZucLRvE79piZ1zAXGrCavKbHFbYa60f3laMXHzTGyTkD8ylNMCOBq88EjniD6LY6+BHebAlO1HfS5ybx2w5DYc/goSaSEEszPXtatX25fNtD9wRZIXfZ5hi5VvACPUXmFmUOwQbekkBoqsgP6MJ4X7j1VSvyA07mMNYlmzPdIOS06HWCOZ1WBBXTVozYw5I61c+D6Eoh7RrU8xGtTIAjO9JWB6IVT4T8OaQ0R+NK9/W42D3Wqu6UfO1SFR/9IJ4QMI5mX/OXYe/jswPgyOkKbt4UR8+ckwUsztSjZGQ9xfwW6yuXvK9u0KkzsrDEO/gg+eeyVvAbea1xb4TTBIGM/Fe5kpdMg1QYN6VfBGJr/NX1md/x/uadxH4MRMBoCrjJLsM+FCZtA49vP9JubptHmDgh68g6qVUzsbm3oNxmLGcykUIBfmQLo84QprwgiG7qN4SGDf73+3Ei674VkGeAEIub3nE3yUHUzqHlCbFz3cMvJ9ec3FJehWhI55KzUNFeIklFZaBNr9ZtAIEDc7J06JonCpfiQ7dd5BX++gaJTA59Swp+uiZxbfly/1jh4LHkcTJOHFl+VC3wjtUEFFJXNpn9ST3OH0KQ3Ipr1hmnCF6YzEETC5IucZCA5td1dLzWpq+snohsGat8zK2sLsOtksTy741n8US3HUUTtRTi9xfKWaVWKjkMLEk88/Di+wuHKxaYRHR/BLCaMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(4744005)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y4K+kYZvlr76iuhyGhUP9ghA7SR713jf40yNmkr4obb2qQjzCM4D043RuI?=
 =?iso-8859-1?Q?xIo6sv0IzBn4QboqjlY3XRGuRZrkBKlX2jcVh2nXoNDEh85lIoG1cIX08o?=
 =?iso-8859-1?Q?ab1i/gz4PU7K3fQeffP7q1YybQz8zPPibk/G+Hwq3fRBr9lUCEJ97Ui38v?=
 =?iso-8859-1?Q?A3bmDaB0EMIn8NMhrwVH7hA49L2AX2S7kWWrwMra65tgwEGFl6uibX/zt5?=
 =?iso-8859-1?Q?kGhxzTXKlY5xyeNhvFEQzTFbnPao3iZBFxUvOYnKJF5AmhmzYCLguRQPrd?=
 =?iso-8859-1?Q?PV24uuAqYsbsPSD+a4ehhybwAd0f76OyJXfD6zO9ipyZxnvexE5Ifef47l?=
 =?iso-8859-1?Q?9To3mlX6yHk8G8qmHWL3iR68Lx1ra7Sqa8lBZoZ1E6iEltsh47wkGUBGoE?=
 =?iso-8859-1?Q?3wmTrSruMPycF/Qej8hNid3yqF5IroJ/CvOonl8EyEpSILHNQuLb/Vdg9S?=
 =?iso-8859-1?Q?KpWZDfLFuQcEFh1U/lD0B/jLoopn4aTmM6s78KFVGCanM+qYz8zXWkDOiN?=
 =?iso-8859-1?Q?Emi1brpNQODNdV4RMfdgpdSiLRQGBCxq+LX7/t78qacEK6JbKzU8Cf2/WQ?=
 =?iso-8859-1?Q?hgwNO+9V1xfz3iRhGMP1xI5B6vKs2PWFFYCmwpKjxaFv8PTWqWyTZ5XxgW?=
 =?iso-8859-1?Q?xVc9bx/W2gMN0zHm2NODwaIHzVKcaDv9wb8wPg6B3TLKP1zynm5TAvd8Gt?=
 =?iso-8859-1?Q?ehM1mi1cwSV4CAIW76aCJyIrko+0ttHvOP25gyarCw3fuOGq/w9BxvSAZs?=
 =?iso-8859-1?Q?OSVC0fqPyvi1br2VUxsGPrNIPm+NNXcMj6oqXBu/z/2/RH5mVPIFMeZUwY?=
 =?iso-8859-1?Q?f9P+EkpEWxL8BZlXxL1uKQrS/dnSuKIcaTwGNhnTTDWb38Mueq9VLl1Psb?=
 =?iso-8859-1?Q?J3O8wa/KZjA4F0v8XlL8dc4O+EzHRGP8ikXp0wyPPfrAeci6VImNIUpCit?=
 =?iso-8859-1?Q?ACOmNhWd19KnWo+7HMwm6dHQtpY+HQecjm9LFEXfk+eaMGzAMAogZfzrLe?=
 =?iso-8859-1?Q?opkWAoOsT6J8HddevZj/3tG7GAdwDjUbTzetVQv6Aymy74eORyWs4S1IlD?=
 =?iso-8859-1?Q?kLCLEYahbDGQ2r0q04sQhXHtLBNP/NoFGoPJK0lafPAkO8gI3IeD9InDtB?=
 =?iso-8859-1?Q?BtQVI0YM7LQ2yXmXnM9b/8KfOpYOSi2+43otfbq1VvPLDzJYnfbaDyO6MS?=
 =?iso-8859-1?Q?0XR9zMC5r8/AiYL3NPu3K4lrhbNXURMJb4R+lpruconXbqyO/ZzSns7CO+?=
 =?iso-8859-1?Q?Tx45ntBmqV+Ms6QbaFfOGIRF1QYR23KTzqSQ6FORp1GxFkmzuSSZ73b5D8?=
 =?iso-8859-1?Q?oPxisGTAUZUpe88tgV4pUGN/Oy2DS0RLbMzqGDnyaEnvghVM5OeYvG3D+q?=
 =?iso-8859-1?Q?9O9QstqatvQ2fVMnvg1+Z1cWF9p9977MxysFMwp2pO5P2boKHXzzHVSXh7?=
 =?iso-8859-1?Q?ja1Dk71jIzq2l/kPJW/zD57h2KMaSnfvsV02w3mwNnvNCUYXxsA9gniZiQ?=
 =?iso-8859-1?Q?+7eQDDjXJjHl8tA+nv0mE1QfkAhvdrWSnHi2fKihRn2wNUTWmndr1WInuw?=
 =?iso-8859-1?Q?606wfJ5dVZtpE1toqeVFrgUMuLrZDgZm6GobMovzXurd9knTgOMAUVGfKe?=
 =?iso-8859-1?Q?GMLa8puKJrb5VCHNZqnDn7/nc4B9C4LaBf0n6HRLmrsLYY4z6QlI1r98km?=
 =?iso-8859-1?Q?UD+0TmhgWS4/BP8EKlc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc53e03-4bed-46a7-3b31-08d9b4d7250c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:09.5406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8cQuIQNg4CuLMtoTRi8xVJ6orKXQLNcL4Bc2/0JaMHUeLbbLsPOctB38vOku70o0fYBoji3Ww/GFJL84loVAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: SjUfllOKfGfP5XDJMPA4kv8FZop_pmxK
X-Proofpoint-GUID: SjUfllOKfGfP5XDJMPA4kv8FZop_pmxK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 13eda8de2998..ea17ee988158 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2323,6 +2323,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2350,6 +2351,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	}
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2361,7 +2363,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
--=20
2.30.2
