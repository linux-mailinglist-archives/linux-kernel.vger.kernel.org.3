Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BCE572B37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiGMCNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGMCN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:13:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6D3CEB96
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 19:13:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CLDxQR003008;
        Wed, 13 Jul 2022 02:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=tG0GWvHwkjqSqHTxjLpeS5GZjF6JcQXL5jo37nNYviM=;
 b=FEbdODziBymBwEf6KSyMnDC30PjeIr7okARWkJAC4ksKstGbXIxc5ZbZ04vJNGGoRw2g
 E/V5DOMWVmVaY5lkMBT2EgOO0L/GSbAjBvvDNawHad504RLVzInIkXLq67m1qsYXGEwO
 591KwVrqT4SUVz6oc+HNWa9hp/Tdw7OstCBqbKdPQEjnxPsQmJmzG1N6yli5msgsuSog
 xLo1+SPe+AqLQ7DdHwY9Syuu+mCan8JYwCZhKVZhaThQ1V8s9ve/YERu1k9cHlMJA2HH
 jjLBR+kgQ8jdvAYDZ30QSHWE0IXA5FIUgNOQwJZvZg5mlpgaJGq764nztutcqOiF97mz OQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r18g4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 02:13:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26D2Alun002270;
        Wed, 13 Jul 2022 02:13:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h704421wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 02:13:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsktWNNSVvU+qZ0pD724QjpdBpG3BGNROK3/Q0J7fbK2RoNhG4zEoVs/y8e0nmOpdz3cfL6BKB8sZUDDLR1jB5Irjb0uAnKANNRjGjDao67L/Y3t2rtrP11xNn7+LM2B3kQ0RMtTScGRzCHS2cMS1lTmSXfUqVV9ra9sFjEioIGzq5CooeJAlePetYEwJqSPozKaGtTVyTY0dpxFMHAh/oMEjfHsSfGcgZS71Bl3JR8WopEdxwgMyYJIdbESYT7YhxHH+k3gmzCxejZXhkHwT4JU6Mtq43giq/82FAVR6eDGiej31HnLEZO5ueLGQfF/sU/2uHeJV0BTKlmhggC1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG0GWvHwkjqSqHTxjLpeS5GZjF6JcQXL5jo37nNYviM=;
 b=gBTC6K1xedBZqGnzzmjoCcNO7MOdNDkuTLcY3bXWCni+hMwt6Lv8+iy/VPMIQm5vHGJc5u0wD0vA2n4sHOXrPgPlqxNR7JFQdJrcxsQgAyAuiBnOgAtrqZp2zqlS8bXOWsrZYPf3wFwGYiAyRihR2ybnNsjP+AcGNU4DsYsG9BSQaaR0pOqD9m7H8aG+oZgUenR5ef8R6DjCkBr4oEu+stkZbfTXhhnh/X0HI438OrlfjowhDT7nkH5pbKYERgHOzYFKK7nL2xCKZc2q/odRauq+KiUQqyNE6wzTnQJA5JCrAaFQV9tfqM/u65CUBbjDPonGAhTzsVD3PP3+TGy5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG0GWvHwkjqSqHTxjLpeS5GZjF6JcQXL5jo37nNYviM=;
 b=ngM9L4YopCPTOw897d+PV/tI7jjChAJBA8jER+MhTJZ5f0IfkKei1rpyxHxuJoTnJlKeExpGPgFy4Dk3GoDFntVcfd2feMZoFcbLuhk6UTUYf9W2qXOeSYsZ6s0nKlLpsHJN9LkJADL3cXwyO+8dQgPCVpqf96fnk5A3DejMxpY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5341.namprd10.prod.outlook.com (2603:10b6:5:38d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 02:13:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 02:13:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH] maple_tree: Fix out of bounds access on mas_wr_node_walk()
Thread-Topic: [PATCH] maple_tree: Fix out of bounds access on
 mas_wr_node_walk()
Thread-Index: AQHYll4aW9UZx1DO8EydhVSI8CL9gQ==
Date:   Wed, 13 Jul 2022 02:13:12 +0000
Message-ID: <20220713021256.542856-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75ab44a5-1c90-41a5-3bbb-08da64753d27
x-ms-traffictypediagnostic: DS7PR10MB5341:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nxm0/Es/rKWonN5Wkwk92mtCHNz2S1lSPP8bGFQCG0B/7a2k2Xa0DD2Y/2xJYaHTtlez23qMCNe3kD5bL2IIyBbdSHjhM0QD9QQIL2nqMBE+H3dXW1KUuyBaOhYnQojl1y4NOOd+IYBgtCudQJs2p+EF6n5Q/twgU95LPpnOPpP06VkgNUqU3oE2+UIEgRyPulKsTswgkXgSksRtqa9coTIXwl9OqgCs5OZKyEU2wV4NQnDGhWACDpJS9DEulu3ApGYGIDe7Tf+swCxVKd7n2Im/r1prh/3heHUB549A+DfwtvSzlLMFzTuyKnfFcCVV+Xtb9r8uBXwNYDSlJ3lZaP3D+NMBWCl8FvUttKxkxxplqJJVdFmpNhE0GFn9msIHEj2qmN1crnOU+jhV5XbZvXa+/YZXr+99+jYU9VCD3Blsz62IA0dvKlan/HCV2/7dYrV0rFcXzIxKRMdyujf4skXek3PsoGC7GyBmO809m0Nw2q9mbkoCEtNbmsKNtEbrQ519iig/oL3Prwb4FapobgqldGr3nFr8hw026QUMcTVu54uX898/o7ZkfJ9Q0xV3FQSC2PcB4tAEHgjezdckuBMKMdCnNVsKNiO59KqyXDc8LHA6kxzxvJ+qewjMrNxIZnxEvY8I/TImhmm7rNKthSEBns7DNGo4VYTA2t0heSokSNHageL2MEbTraGxDoqE261eto0m62hYjLSOUw+MZ0AZuzIyx21rdWtKfRd+rApjOCfBVk9Zoj4xzdhOMM9wDGh0/KpfMSPKJBzld4QZHNpAfBjsrneuFG29BZI484Gl34Szg3hq3Ttgn0gc8f2A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(396003)(346002)(136003)(366004)(122000001)(38070700005)(71200400001)(64756008)(38100700002)(6506007)(8676002)(41300700001)(26005)(66476007)(4326008)(66946007)(316002)(76116006)(8936002)(66446008)(66556008)(6512007)(91956017)(1076003)(44832011)(86362001)(4744005)(83380400001)(2906002)(6486002)(5660300002)(186003)(2616005)(110136005)(478600001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9FHXnJ+nfj1sdh1Rthp7DWRq4x1glQGa6UMxF76jKvnRNDKrO5FdzUi5Hd?=
 =?iso-8859-1?Q?5JsT4Ig1Ml8+933WZUpC+NRsohni0QWyzL/lSn1CUhikScM4gU9N6Zz8aZ?=
 =?iso-8859-1?Q?LnAINU2tsUwC3Z9shWnr2r0Pkohh/m+xl2C0vxwHB3+1PrPOfOA4YhWIxv?=
 =?iso-8859-1?Q?CVQ8emEyH2X5eZte/iZd+isOAAFI2sghLdwvZ/vtGiBVjCU5lpC+UUkwJy?=
 =?iso-8859-1?Q?HoDm64a5tdD6gecKM/hJeg/xURnJsE0bhlQB/a+Ufas92YOoXspsE6wNU8?=
 =?iso-8859-1?Q?0laG5WGH1ZgAg4/uF25N8emaEhPC+OPjHCKhJBQlCYHIjMkJTj7WL8WawI?=
 =?iso-8859-1?Q?xxjv2c9k4tOFtWc+OwtZs5t05VFIhgMAy7FWOzMneJ5CUbQoTTFvNKmxDm?=
 =?iso-8859-1?Q?9A0BBn0fX164vL8k6A5paYVuXaCwPcnes41maXDp/S+yFj2Zl55fi0vxWU?=
 =?iso-8859-1?Q?UzYk/eiwJOOM3kXC2hdcC/DYE1Ja84Pd+gYWzb1azoqOILBVHn8mkNzbKn?=
 =?iso-8859-1?Q?Vt+XkWzXaLOf3t+nkOsrFjWd6KrBPmL8sJx0jAskt0U3L68O2DAGPH/Dgf?=
 =?iso-8859-1?Q?XLu4huTROO0/JKWVr2wz9ls3rAlxQNooTrCJCW0+2/Egc9xYNwliiT3jTN?=
 =?iso-8859-1?Q?3OnQjlr7Z8GxYhiqqmT/qbUCajobRi9VG9P9U7+jEqrWPLizBvvD0oUh7a?=
 =?iso-8859-1?Q?QWxwRAFYPGDias3Am5svXYtCTMxB0i+LtGDb5oASzpLSMlFgPdWPPNppdz?=
 =?iso-8859-1?Q?SE2v3X1tzTCuW+hPJ1LYryzxI98/8kkHEJqU8unyg494uF26Ho5IuebYOz?=
 =?iso-8859-1?Q?ktMPil8dazpJjz7nL216sPuHZ7KEa3NxYV5arPLTbbWNMDo8PvnW8PHRU9?=
 =?iso-8859-1?Q?B4zFCvRzoQfvlThdGCgtUFu15PdodrAeELMser+mDcr8hNfmTW5eFmeTAb?=
 =?iso-8859-1?Q?OPUOERQTviuWZeceowWK4CLBDEcbGGFxZEbb5xLpLNBxnF/EZo7azPGN0u?=
 =?iso-8859-1?Q?L9K8FgNZH73TMUU5ZQEGmk9z2X3GxPHZyp4Og06fZHAtfga3caXdHx6mdO?=
 =?iso-8859-1?Q?S9f2AjhYbY00ZYB5cwhVESksQIwGpwaqpK1QHGv2cKbxG/xz3k2g0rIDOB?=
 =?iso-8859-1?Q?Dnm/otIhc9IDjMfoKckGXs6+KGkW8HkSXvZHPMNc+57imyg/gGVzDKDQQj?=
 =?iso-8859-1?Q?sKKxnOLwVX4Zr8dSxWw/+einjLbG5nDFAW/+y528YWvgJulABx/u/Ybu1u?=
 =?iso-8859-1?Q?HrSJtqBULeca41XkxzMkX4PAwzGwvd/GT2Tz09XgVKLRcp5BqZ6XfmCa8B?=
 =?iso-8859-1?Q?yU/4m4b6LhCZTTWetsjedCYdDir7wfDr1TlCn7Ug8d4zZxONg28Bcr6d8U?=
 =?iso-8859-1?Q?fVh/eRE/O1ukyh2veYLc7ZOpGCRRoOmcEK/taKGp16a17VPQD5e5mK+CK+?=
 =?iso-8859-1?Q?miBY5E5LHhxwVfOAzq/u+vfq3rbsUHHtZQjVyogx8M3looTjEKynMQnrP+?=
 =?iso-8859-1?Q?/v2zD3QEfYJaNSc6rNUFcYGScIi8SLqlaWuv1pbyo9YVTuIl4x9/LLcZbx?=
 =?iso-8859-1?Q?ar9TCk5g+U7oeb0BIPsWgMHXQuz3CQtaDnvmJI5bxXcYKizoI5iLJY3Sfi?=
 =?iso-8859-1?Q?4NLqmLzo14m0upNIj2dFW3R1WpI8kL0uTe92+z8NjzC6pqI339leQ6yA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ab44a5-1c90-41a5-3bbb-08da64753d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 02:13:12.5966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vU0KPO2Tw+piL63/UjlhTRi/ucVS/n5dJ0mfqVnZRkcrjaRDoQCTSG4MDkvLhteLaCYFkS301mgj0Toc9+/D+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5341
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_14:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130008
X-Proofpoint-ORIG-GUID: aHNScOpVoHgOjM4GtLA9JKKVm1Y-8YzV
X-Proofpoint-GUID: aHNScOpVoHgOjM4GtLA9JKKVm1Y-8YzV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When walking the node, check to see if offset is within the range of
pivots before reading that pivot, otherwise return the max of the node.

Reported-by: Yu Zhao <yuzhao@google.com>
Fixes: d0aac5e48048 (Maple Tree: add new data structure)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 14e9ab14c1da..768707770926 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2254,10 +2254,10 @@ static inline void mas_wr_node_walk(struct ma_wr_st=
ate *wr_mas)
 					       wr_mas->pivots, mas->max);
 	offset =3D mas->offset;
 	min =3D mas_safe_min(mas, wr_mas->pivots, offset);
-	max =3D wr_mas->pivots[offset];
 	if (unlikely(offset =3D=3D count))
-		goto max; /* may have been set to zero */
+		goto max;
=20
+	max =3D wr_mas->pivots[offset];
 	index =3D mas->index;
 	if (unlikely(index <=3D max))
 		goto done;
--=20
2.35.1
