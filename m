Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957E2465000
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350816AbhLAOkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:40:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51690 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350093AbhLAOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:26 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EHCNX012055;
        Wed, 1 Dec 2021 14:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=g4ZPK72ANVR1hW1fur09fjlaYAltBhHB5n5IQIc5Jaw=;
 b=mNyhCaq5jRdD+0jYZ0GXU2Ospuylp40SBl2COmRFtnEdcv5bD011v8QRuNKVy5oF65It
 m1i0t9Y0Ta+0fjy/yzG6rTVEov3PwpVnCkce4/Zkzd/ie+gEC7dyX3ALCyZPCDQ+s57D
 5uFVwOo7TmzQuEd18qnX6NjF/pyGgBq4dG3R2TgWgQ0912coR+HMhyhxbpjqqsbjacGZ
 X8VS2mmOmd8yTUifs5dVEjLS+SmYcizwv6z+vg56eXHUSO6MdSckz76E2TuIzreDIl4/
 k1K0LNf2rikHKyrWuxzq+UsUF55HGjBpx7ezKWL5iumbohhoUlAm6NC3XAXiNUdaDM52 Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1h0x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPT108922;
        Wed, 1 Dec 2021 14:30:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd1hfPTP0ROH65MK4J2fbER4Z3M9M0KfSOeaqNbRqTx1+9uBnMjUYe72roPp9NJsv9RXppqKbmxrYgsmkCB1VJY6Pexcp8KnLhUl40rW/xoE+LfsVOCzNfeWBE2RCErQcfZ5+n8r29dghY0ehYz5QwjTpdMnFDqxxksgFznCY0hjz8ZhIlje2mEeJk0jhwfrz+/fc7nv2D+evn4DkkQCTNVBTJ9TkDot1JoZXL1jSf4qC56k7EmQ0M/unDKpuI3S5qaCgd1Fg7ULaWaxHH1dRofUaDiUUz8dDhI0WpXZm5ZlKYvFwzptXvWPtoYw/2LHVX5fyoR5YskJJxG0HSljHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4ZPK72ANVR1hW1fur09fjlaYAltBhHB5n5IQIc5Jaw=;
 b=J0fw7fP7g6A/l7lsnCgQn1Mw0sSHiweBCfiBHWmKK/7KGEYm4fgjwzhNicDNbZMmr4IQmHpOAN7tTg54/KlNfZ1MziOcS6UsAv2E9jr510VG4xe7Uj61dt1oSeVLx+BwWWyy8R9xsw6ylhAsl4+bM1krb3OYTOiJfp7+QjK5i3Nw8hoHG3j79uiH6RQYWd4Li6Ay0Ptj/3MOZLODe5XJkBJKFNog2WENCbPhwVRAFcZLKn7zU3Bmp9fveg5u0r0J1AzeZsaXEtD/VZ/5hDo0LN0/SVp2f5kWVfmzk68QvNnHl8r4s60uN7OtY2kzkV8jD4244RH1Y/Vcv9oZt9u8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4ZPK72ANVR1hW1fur09fjlaYAltBhHB5n5IQIc5Jaw=;
 b=VbKOyaIDQFySs1ARHwH3vuoO6hdjv/3Oj2hjPex7+F7Tnnke1d1xuNGVrLKsJh0irDxVkfxnk1HM1RRi2bWgylySBPMzkIsU+khclYfAEM7PSxTjs5z242+CsLD/tBw4y92Pwx3rlQUBDbLC1duaQ4nRicoZyj6fKbfpsQKV+7A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:37 +0000
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
Subject: [PATCH v4 37/66] binfmt_elf: Remove vma linked list walk
Thread-Topic: [PATCH v4 37/66] binfmt_elf: Remove vma linked list walk
Thread-Index: AQHX5r/wn1N9IGnfpkWQcvrwR0Butg==
Date:   Wed, 1 Dec 2021 14:30:07 +0000
Message-ID: <20211201142918.921493-38-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e57cd4d9-38b5-4ebe-b023-08d9b4d72492
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508A07091D2D12764A5E8F5FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DZmW/HCMxqz9lSJ8ieim+Sx8YSg6oHpxpDVYzqYfyYApSj2tFFFkpVn9edb9jiZt+iKz0vEC0Grxu4zYURe/y3hos9McOiNfcx/zjub/TjBQua0jtXv2iM2KOP6U3UpES4qfoYNTCcMi9h98MI19sE4RVRkuCaogZi3zbB7qMMKRbYo0yrp+A3oQjanlVtCOqJUWrMhIuj0yW8eXaOsMjN2odZGheh//bcxQzR9dr6B9h35AJz5AUkumYqJBtDdpvWGL2e+3uqw1Jw59AZ2rhFmglQ/TDJA6vi+R/6PVa5cEBnAYyMysvUp5ZV/56ZhT4FOUhlIEPOY5VC+kBWPa5Feaa9RWsy3f2tel8fGvVralqvVXFI8pSw7mDpigT53PHLUW0lT6yx5PvlDMt/hWJCSaVpxgYs5F7f6x3GrMOYhVHTkhEz276XY6gQuYBYvFRKFHWivyh7m1eLjZ9PHjc3HgNJS4CE59dx2PXNL8+721gVXLjYphqV3XQipksI0GuFBZjkDdqM2PU7srtZLaRKrhpfspPVO+qFQ2KS94U2LQiyvScEyKSb8RsdkWoIGro5sLXC9BhZYsC281wisrN1IjP28KpPi4RWMewSjJV3hlhvrlNtO0TO3BnIreYnLpX2z0uXZkPYXabhfcIzK+k7lRhupzcrXpZmJcqtDYTvqAmQL91VT5H4n2U2AgPuWsJiHbZhbAQNmCWh1erFd/bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(4744005)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0cjj+efw0E7xfJiA9TZcBZcqDdkys3eGDaBzKV1t5MqMvPOU6l4X08eO7u?=
 =?iso-8859-1?Q?0TqMcK5TYYL7WAvPfZUgIlIfSTW5tTdtoXN2X+vaz2fvcGIc2DYsoDuvdh?=
 =?iso-8859-1?Q?4aoPbWq6z00/oTiRlnKGJBP6zTeyCEGORDb0xbBbkfwTy/AxZ0iC+iVKEz?=
 =?iso-8859-1?Q?Pq3/sk6n8/uMSIvFg1TsVWKVhn+RZMwVzhKU+oMtLq3N+wMaY8/PcHfvJV?=
 =?iso-8859-1?Q?ZDkIdUs3AIdveO6S4ctb6WBTpvMdGxs+DKs0ZVvdkuMuzHePdpbhp23eXt?=
 =?iso-8859-1?Q?se7pRkrWBhhm91c5UyMU9mArwBGPltq1QjGuuQfH25szJoJV1Pq9hVRKcI?=
 =?iso-8859-1?Q?NTDg8e5nKIIKfCqj2rMH8RDOScRYkvIqEd0i7sejxXqHApG2KtuOY2dnpY?=
 =?iso-8859-1?Q?EYIo8SZyGTuxpUpf39v5lbqmVCCURFy8YGfo0Nw5mP3xH2JGYmbaqLtiTg?=
 =?iso-8859-1?Q?oUmYpHsgy+Z+XFBycc6elO/gLJ1OoL/Vp+tfZIcaXoRBEpUmWSmfXAcfvZ?=
 =?iso-8859-1?Q?yKRpBmTFDwS4TV9/zd7bbeomh3WFErvHYQfNSV7sm4YLdz35I9zi4xHJ1p?=
 =?iso-8859-1?Q?vhaPe2xrU1Z1W8HRxiHE0Nvtc8+YLKwhM69LpNGCYtMg1aEXBOAKUaOUml?=
 =?iso-8859-1?Q?Ndo94nrK/SDlDfoVEsTnAA1etQ23Fv0X2jwhINSPyifQgKXVr+7/dfB2W8?=
 =?iso-8859-1?Q?g20XjKZUhPEsKH0MeZLTiXLz3MXDsF7CDgik4yijX+y5qcZeayT9xG+Ryj?=
 =?iso-8859-1?Q?mZRSiDgPxrwjSxC+A6095cxAyvICyXeZkZmPLx6h1Qlktwoq5t1OyEhvPe?=
 =?iso-8859-1?Q?yg90G8eoyDZy+1Bs0eE39D+D0zjHir39F1Ma7UhRI+LC+YnjRAEzinzjtL?=
 =?iso-8859-1?Q?qZRS67m5ZwMqpKdgpfDV7cCJmvAOm22plEA9KJJ4VBKl3W5TxTP8SkJcfj?=
 =?iso-8859-1?Q?P/saNXeyjwRwpCTbxv4IvIMxLcEF8M+mk+X5CkwHvnj6Ys8gAYFPLgLcTf?=
 =?iso-8859-1?Q?sVloYIaWSm+FVDMNJL40vGpo/CNN8qQ2/ilG15jgXibQI4E7oUIJCWyog7?=
 =?iso-8859-1?Q?oS35Zc/TvzQL3mRor6jywQlnR2f+dDMIGbTJvgVs391F+Egz+bhG22pqOo?=
 =?iso-8859-1?Q?eUPM2cdI8c75dSDeZWvwTPfNj3gpPcX1++x2geZU4gKWKVg1mF6LOKehoa?=
 =?iso-8859-1?Q?lPR/RpDB1uM3qMfczWZFAA21AW5/J3GFuCojLtXUYJSiLuBOmWaQDggPxY?=
 =?iso-8859-1?Q?iLQI6Y8WzXrHdCgBf+OiiI2ZeuytHrcRaZMEIRnoftgRElWQrNd1pF75Ey?=
 =?iso-8859-1?Q?MglTGG641dtNSCkjHrwEfRj8qaE2yLOVUbykhGMteDWFxP7Kw2NAnQI4aP?=
 =?iso-8859-1?Q?WkjDod9FHk7Dh/+p4Zj5uTCKlvAs7sIGRuYN0jMs5l9nW9rxqAfgvL0aLr?=
 =?iso-8859-1?Q?I2PfbHGcLDCUkM6spMtFE4LBrIxTi9plvsrpS+PS85pngRTFo0su2NIa3E?=
 =?iso-8859-1?Q?gRHLOkspOv4nKQyzDlPuMnGTAvdMFVxkYGjYxSZdgLAdzYp0dqYhGLdzDf?=
 =?iso-8859-1?Q?Gw52jJDkVabOnA2Z+uZFbVYxoIZKW1MF40bkioEaHGJs5sr+7Ow+A/G1Jh?=
 =?iso-8859-1?Q?YPjU191MHkPHoq3Tu/HLzyDTG+0ZNsx8ldZsqb28LXH8QI2YmUl6sUTitp?=
 =?iso-8859-1?Q?d0SF98mE8CYeZVbK0QM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57cd4d9-38b5-4ebe-b023-08d9b4d72492
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:07.9355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PnPKeENBDcdyRYQZDWK1uDbzeZRpKLpT5VeR8O/GXwM0JnVAbbm1aPcvi4PE6UPJbHMuO89b7BNvw5O7+LljYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: w6M1wOsGaQJlt8Do4BWPTI3SpLR2pqif
X-Proofpoint-GUID: w6M1wOsGaQJlt8Do4BWPTI3SpLR2pqif
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/binfmt_elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f8c7f26f1fbb..d41cca755ff9 100644
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
@@ -1651,7 +1652,7 @@ static int fill_files_note(struct memelfnote *note)
 	name_base =3D name_curpos =3D ((char *)data) + names_ofs;
 	remaining =3D size - names_ofs;
 	count =3D 0;
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		struct file *file;
 		const char *filename;
=20
--=20
2.30.2
