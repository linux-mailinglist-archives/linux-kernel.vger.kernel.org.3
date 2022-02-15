Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6660E4B7130
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiBOOrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbiBOOp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F355C117CB3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhxci006513;
        Tue, 15 Feb 2022 14:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wNNpUXAHnvfPczhaDRIEqp27wKGBx81nUV4wm7+kgrs=;
 b=teykoqYqY1OpVi2r8dbSANC2RZXh62/75szjfx9t9N9UfLd/NY23y11CL7lJ5hQyOnTT
 FZpUUnfvu3jfjcx9l7enI7ETmHhXJlUOGJyi31B2M8W/bYw5nVhunvbaI0BTManvS/Ut
 yXjIWwl+r8ibQyVDtF6omMGpZWuwnuEFC0v6UOf7IUKJsQ3AF3QDyLUR03mh0mfWeqCD
 y0njlb4Ek0touyJtPtNYD3VNsl2V8lOE2iTtPo7lqfgMeSZhcmH598Z6Umbc8ZbpYRxm
 rVE2n9u3LyjHPgxQ0ToJtSh4IHA3EI5BS5/1637oGMvNxZE6AXVqcJEY5UBUxWkBQrGi Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0hgdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8lj016243;
        Tue, 15 Feb 2022 14:44:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3e620x7vn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEgXCY3dqxoXdik8fz9E3qaOVpSAhh15LYniyREug1Zm/0Vw0zJRnv0BHzr1VciM6JvpXhH0ihdfUW8GGOtP6abAiiDUoLZAHT8hJiqEnXGXr8mGtMemf1pJD0+xBuEQDzBSZJvmL9vDMlqMKGeCqSKV5MYTM1GD21ubfbY3eaHdFGJ7zMVPISdon1eBXakM7Z5W1vjCzuVbZvMdwEVKfkcSRO/lYXDwovbwUgv5IxDXGx2dr6SOkYQebVoDRJZSykz0aT0c8uVCP2ppVGWSczGXKxzZ4ItboTfEQSv8E8mv/Len1kRUQorvTpuMsFH3g4wKX1my3mSwACV/4UKVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNNpUXAHnvfPczhaDRIEqp27wKGBx81nUV4wm7+kgrs=;
 b=FTPZAiMRxf/Y2R7YYolN40OvcxBKQEogwqx+ctcStT45DnKXMJQYTeQqZydO3cfqjEiWa7vENAW4/YUHKSC5aqKB+Zvs9ypJkuVrDyP+gqQ6k0GtgbbnlUQBk2fNxHz7lhxlBQ5P9AzRS5IwJT/VB0UarwCMQgailH4lGvkq8EtGJaOvasjP/C0spaJuLlFcl/euKv2FfdRnGs2hw5RpVX7bjOK7aR93JbzIWj7lGErIubzdyV7bhaDyJzSp7N9bbLE343XYDQ53T2moA7mqzOIvVRsAJANUfrslPLyZ6Gnws2DmE5iq+eyHGrUVdROQXnVx+EZTZF3RBgYeYhWs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNNpUXAHnvfPczhaDRIEqp27wKGBx81nUV4wm7+kgrs=;
 b=ab4S44tXkMJ1o0932wuK4aYGqsjtn23UCek8aDwnfbR+qlOYKHBa+TlprQIkp3b4BAmHKaJayiWXBYmPXkbJk4LEef6EUjWT/j9kpsDPYWLK1ImgA0+q6QAO0TC+xTWs74WqIhqptTG9ac/rceaOIA75EIOlqADizkyN9n8dlpk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:43:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 52/71] bpf: Remove VMA linked list
Thread-Topic: [PATCH v6 52/71] bpf: Remove VMA linked list
Thread-Index: AQHYInphu3kqqueIhk6EGpNIts2g0g==
Date:   Tue, 15 Feb 2022 14:43:22 +0000
Message-ID: <20220215144241.3812052-52-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09274415-cb2a-4ae0-e2bf-08d9f09199c9
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB18630681BB102584C8E57429FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iBNG2YIk8b1iCWA9YbgBGxFG/LoPbyRgvC/qxSuZ2fLeb2hu9enbn9ipQoEm4Nqs9zmetGX5BfLMeMfnbQ+wGcaZKY/nWnO0aLqYcLJjXBG1KFe7gqGDPmg4K9f2wHkCTs+Ls66pqQGDTPLyvb25JnslqV3NP2fSMGU4XUEQqJL282a3Urzou9RgK+iWq+UcX9Y9bYaDyIwF+eb/BcGAPvTnjibR+LuT5qm/LxpSQk7kH/0muYojp34i2RzLRuJht0YsMTNJPdM2W8PHaySOgJYA7AzRhK+d0Ame9sSb/vQMzIIv+/z+g2ogwEdWMM9JnrC+wsBdvFPOveM71NcGfBjgNNcZLFJlha1zEjSFErpyRwX7F3XucVdLf8zuf+0q6bi+Z7TBVX+PeYnU5MMyb4Tg17Eb8GwEVNoCFXRgXVR4rpMeC/h+lyGXOkm8MX1emh0yuvLNkBU56bzngDoZQzBMn/F1j5sY4Dp+5b8zEpsYjs1jPv+ghiNb8p66I38a/qqybBmyCMW4wqallg0ANzjI0bMxeInCE9EbQOM3mmwAB1RSJKzh7PbkGRgmkMUdas39NLJTjpQbYK9fDB2ZKAN9WUo0n6oD5D2O/yUvqmY/BUeDHt7eH7O0XJTrGdFtJSSX7MZIQ0wcgaWr0WNKZHFGaVXRSuXIgQbB0olkWlgfEvW0OXkqqMZIMNU27DT5GYM0UhwNM3mJNgmQtLTONA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tP7H6RCKiw+5PIWaXBhBe1pBgyvJD5zNnPjEebnVrD0Co66d9/NMx0apw0?=
 =?iso-8859-1?Q?z5e/Ldsqh0avBjhpEj6PxmkE9JcXMq4IS4dZ54BqsVP7OgRe21cPKOmqiL?=
 =?iso-8859-1?Q?3/kijQcBkit5TN4uNMLi3sJX2JUGboCVdrqQ/vT8ZQPc0TOaclLcZ1sx8I?=
 =?iso-8859-1?Q?B53Yc77c2P+hT5oxUyqfE3rCFw9zCmQJPLuLk2eOR+AhSSEEKH2jAf7NUM?=
 =?iso-8859-1?Q?795iBIP3hv3FzSgjnlgNAq1vmrEoG/w5V8sBMeap+ajGQqbBW0zmqRJmFZ?=
 =?iso-8859-1?Q?/W2AjktZfoqUqT8tVHDAjMufQGKxPp1RnvAZguiRTYr7NPfc0ioMDU01/b?=
 =?iso-8859-1?Q?kX8mPGkr2pOM32TmADSS4mt2uB5bQm3Vaky/uLB+Ek5AEGmUbt3ROh3zHL?=
 =?iso-8859-1?Q?v8tpB8jmrnhwGoRJ/YPIPKD7+Cn5ZTrIy9fjlhu5sVdDhX+ugb6NXc27tz?=
 =?iso-8859-1?Q?dEBOmtPQJK+gsVdsj1CgJ01n5P7Nj1TSKcSq1DjpxfxqLqYAIRP+ppYJuD?=
 =?iso-8859-1?Q?oZ+TjuwmiOatdTxETbHNYOZayE5j6q8ZhvJWXAyJS2hJRegak6A1Hn6miu?=
 =?iso-8859-1?Q?GhqDy1Mh1neQUSnwMv6PP7VspAVaSQ1M1KY18b77Yz9kVHdfuUOfKztDS/?=
 =?iso-8859-1?Q?bx7wP6v42HlWw0In8fh5Neqg10RfQc5LhZIwv55tE6DZptQdyOBViAEbEG?=
 =?iso-8859-1?Q?ga8HN4XWse1VfqKeXUYs1+ZqFxgWcUEIj4MgqvZWbqFsD4oruVFlFgoCEX?=
 =?iso-8859-1?Q?8SW7UlN4uKBaXiDurQscDWGFMud/SrRRCF4i+WUhuJdjV1RsdugmFMB/I0?=
 =?iso-8859-1?Q?iaA0C+0xnI+NGxDskkeijor3qR46swgNBqjmUxr8mE+p7UkAeh9LS/bwHU?=
 =?iso-8859-1?Q?X9OAEYC1WcHvTvXze0l8o/l6YObC4RC7BhBl0uBiIYcGiecPsC/ZJFowLw?=
 =?iso-8859-1?Q?Y6o38brBUS8kP67h9bJNkUH8jmkMY0Fy09Y2riu5VHyWcXIpuRlnJe32zy?=
 =?iso-8859-1?Q?gaVi9GREnYTw/MBMdohSqPKTCK0ZVb8vH0tG4j+lMLH4Vrvx433s7ExxJA?=
 =?iso-8859-1?Q?ncTi5zHLPyNaOMKfPiAxNghbTbqebJNpc5btLFJV3cyowd3U3SfEEnCh6Z?=
 =?iso-8859-1?Q?H0HT+PZp9AusBDO1JSiKSVpyQqR3rMUNESgipNtekJBowGtFKFkyTRDeSy?=
 =?iso-8859-1?Q?phpQI8Na/R3VjeZWfOpQQVb1Ibmod+futKvAf7PqQY8MHkffqbYomAu79A?=
 =?iso-8859-1?Q?2EemvcaI78XZpb8O9npFA9D4UCoyVyd7XGRbPLbpmK0RgLeM9zgFxaqjwV?=
 =?iso-8859-1?Q?J3Geld8siQH7RMPoy2Pe+g1RzxPunM9Sbbj0BW2iDHk2qMj/guAepYnP43?=
 =?iso-8859-1?Q?6PTOoDFGXfNIe/sJ3IKlAwBKKjCWCUUnMAIvbbxSM5SfiZOODBk96Q5/uX?=
 =?iso-8859-1?Q?SnwcZiXm7sOAFrXz4RcJMT6/PQQfE8eSCO3+6LXKAOFBKK4N5U2hvHukTE?=
 =?iso-8859-1?Q?4nfzw4Zlbxoo5EjRkm2AFyl+GnFSNIdVqnaYZvZebKF7i9s0azx9pPPgbC?=
 =?iso-8859-1?Q?LPS9Iyz/FnKybkJaV8z28AUKvo980EtJ7bitJYQy50Dw7oJvaK2Kn6yJEg?=
 =?iso-8859-1?Q?zsDFdK+P1VkFBtDksynVq+i/9mT73blJpIH0TvCIgQbf7tPWay/+FT9vka?=
 =?iso-8859-1?Q?qeU5ZWvX5ls3PNPsg3o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09274415-cb2a-4ae0-e2bf-08d9f09199c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:22.6042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbL6ollCV7Zyj4HtodNnq6h/dieT10zwFwaHU5wz9M7CsmaNpIBTracte86/0Kmx1i4X/6u4cT8c2TSK+kCeBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: AAtiTjr19u0fCbVLHFjIx-NAnchHAyWn
X-Proofpoint-GUID: AAtiTjr19u0fCbVLHFjIx-NAnchHAyWn
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

Use vma_next() and remove reference to the start of the linked list

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/bpf/task_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index d94696198ef8..9a0bbc808433 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -300,8 +300,8 @@ struct bpf_iter_seq_task_vma_info {
 };
=20
 enum bpf_task_vma_iter_find_op {
-	task_vma_iter_first_vma,   /* use mm->mmap */
-	task_vma_iter_next_vma,    /* use curr_vma->vm_next */
+	task_vma_iter_first_vma,   /* use find_vma() with addr 0 */
+	task_vma_iter_next_vma,    /* use vma_next() with curr_vma */
 	task_vma_iter_find_vma,    /* use find_vma() to find next vma */
 };
=20
@@ -401,10 +401,10 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
=20
 	switch (op) {
 	case task_vma_iter_first_vma:
-		curr_vma =3D curr_task->mm->mmap;
+		curr_vma =3D find_vma(curr_task->mm, 0);
 		break;
 	case task_vma_iter_next_vma:
-		curr_vma =3D curr_vma->vm_next;
+		curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	case task_vma_iter_find_vma:
 		/* We dropped mmap_lock so it is necessary to use find_vma
@@ -418,7 +418,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info=
 *info)
 		if (curr_vma &&
 		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
 		    curr_vma->vm_end =3D=3D info->prev_vm_end)
-			curr_vma =3D curr_vma->vm_next;
+			curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	}
 	if (!curr_vma) {
--=20
2.34.1
