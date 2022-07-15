Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5629157679D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiGOTnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGOTnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:43:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8FB7B351
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:43:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FH4aCt030500;
        Fri, 15 Jul 2022 19:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=CFz8liIYcWEzU05dtNJBl/R3bpiin88VXxvajT5ThE0=;
 b=tJ4JhPuywe1RuUhmyi3z98yq+Z2BVKqlfwHgrcZetSWOqY37zCypcPk5C2cor49zZt7e
 Q2EeSKqfxj279ghSXP2WqqtqhCOwtykEPLoKw6ER5O/Jjfcn2r6VIQYGOBgLs7paT1vI
 bbdNchJ32sDfcR21cYuWClOzu5rvTCjgHqZzTFz1V4Lkfir1Yv8Od5wm2m1blpGg1sQJ
 zi2vp/X9E2t7H3tZp5/NMSfEgPNKxbciWfrXTvDvEIWVQu6QqXlwtppf67YRJbaEKwhz
 gz2yVeaiMPZRl1rduqde+qYCkXlRjrmRAH2oBwLL3A7+uBlNvb3ksAzzS2UTEZmGtP+X ZA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sch0uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 19:43:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FJZrBs002820;
        Fri, 15 Jul 2022 19:43:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7047qukf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 19:43:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kww8X+MgQX2bY+ghmU+gp2shaShMclNW6TpvYlW/1nB+i2vgC/BNUHf7OpuktB2beZaRSdYhW9Eo9oIKv8BOCo9waIDFveMcEc2USR2scG60yePxhMO8NAYMMCnrTgJZFXfCtznpxNp5TPtVvRO+VFUnafMWvU3DGw5MWKqentQCvfLgigAM6ND2L6zj/hYF3drcTkkRcUscSoqnGHGcyXJHbHzOSMDb9wtyij9yECf39qH+OsUaNX5ONpGJbbCn/w3MLhVDBYs8IFRDqwU1tz/SF8AQbAz3zvlibepQARY3LUXbQ/JxUsletycOR5F3UR/vr/gnK3vXf7H/BOICNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFz8liIYcWEzU05dtNJBl/R3bpiin88VXxvajT5ThE0=;
 b=JwxzzIpL1yZTxuLrwzmZ3nqJne+7QYPP6A+f1tsImJuAzlBzhzVap4Ub46vAEm7hTq6Qbv5sPcdGfKW4AnCZL+kOAczpzlRxkNnXikFO/N5QM4ogVkUIVF4lgCSs9azNPYpVzTEFxb97Z3SW/1cAp5KPpCLSGToCBwRIiMkV927KmhlBa70nadl6Fx0blZhu9H98KW4PGA45bYxxMrRq78HBkDWM/qZYMne3GSxwI7g1Hxvq1cPmodsSU/bi3S/6puuvTIv49kJOLVsdt2flF45JU/U2LzWuf2wTjK7aq5YbE9MgVzY8SuYxb2t88AE/2G0/S+/quS363rTZjNWNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFz8liIYcWEzU05dtNJBl/R3bpiin88VXxvajT5ThE0=;
 b=IZHu/B4Yh8XObWUt1S8ew55swc/ARI6MI0HQc+YY1295R716hcJWxi6/HIFbHoKboRVhEkGARQvlP8UcnG4fJbsIBUGWvOaDUoCj5TXTj2uyX+AOon7yzhuc1x/deV04iLNSkbKxPIRGJKMg9MoY7k5mttpShcbi7eseqpbCbqA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5090.namprd10.prod.outlook.com (2603:10b6:208:322::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 19:43:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 19:43:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH Fix] maple_tree: Use metadata for mas_dead_leaves() walk
Thread-Topic: [PATCH Fix] maple_tree: Use metadata for mas_dead_leaves() walk
Thread-Index: AQHYmIMccCW98/jR4km0kgJMNFpz+Q==
Date:   Fri, 15 Jul 2022 19:43:08 +0000
Message-ID: <20220715194258.1734056-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38b3a641-58a1-47cd-5144-08da669a3ecb
x-ms-traffictypediagnostic: BLAPR10MB5090:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7/8vKjxYiuBESFgy88hrgJKIxWxMcq0Km69rY1aEG3PnxRV/4+mIKIx+nNEHVSN15wGTz2ReIcyeWjjdORQGaiH4iOxwnVKwtW+8I8n9LfwjAViOslP4i93E8ZkADgZdrplJEvFFJAUjYoIanpRU8/3jMUj+01ztpZYB7/YHxVuXNLLUBDjFoaWM73o4U3YRwz/YyTWD3u6IBeSxh3Wvjnry45FQmXnNEmZiaIKRFH1oq4J2wHbjgNRuOlPqasnJ3xD4xQQ/fqM7RKA8mOnv045CipgTb+Vc4yGwxeIIJzvvgYivOUXxj9CymET8ZGrGCv+tP1Tc604A3D5ZqnSE6WrxdwYy2wtZttn7K/4kuxn72fZBCtY2kaza6tClVWEoF+hMmSbzh5L+a0/wKaAyYnYoh271kLeiRzAeGrI8Wcpc0ZymtxQTx7WSxPll7z30nwUxAPaaJpS+cdt8YShMhmVKhOFuVPAhLC2CLUpphC+Ljge6vmwKwe3w6tcF0Mo2A+X6Jamqi5vp+oQPQqL8O2S8ZuBtNyDhH1pPdDhRTbACnbJaimuda6rKiPjAKjHrTxRVEX/pGP2yCUGwQlg/Prtux62YwXW/6/ahNBDSZTGbmmL/5ErJKE+PDPTHHpM8bsGf/LmqXfcPqrGeQCkDVkxrIk3Ik7mdGx1Lw10oZjxgSyBt07YooVVOx6dlgBudQ5vmz3ZGdxdnhECeewWowu2X0QU2X8v1TyYLbHuwNf4/6YEPKH9hSD+DE+ywHVoXDI4s4UHcJk4m6mJOIVfaokHUE8ev5HCLNodshxwRh9UwbGYF251sWXn3tKunRlt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(376002)(346002)(396003)(2616005)(110136005)(316002)(38100700002)(86362001)(6506007)(26005)(36756003)(186003)(6512007)(1076003)(6486002)(122000001)(41300700001)(38070700005)(66446008)(2906002)(64756008)(91956017)(8676002)(66476007)(66556008)(76116006)(71200400001)(66946007)(44832011)(83380400001)(478600001)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kCo8ON4IfjDJSI4zGRf62Nbku18c5xZ/4zxJ0vIAva/NWCkU9uR1LR1UGu?=
 =?iso-8859-1?Q?GRa9NTzh3zWknKsIGkVjgKLp/6YmW2Fz8JREIMwmV/FvbJaZ7764HUv9+H?=
 =?iso-8859-1?Q?ir8Kc7+oKGGbPP5TZC3nTtik2BBM4Y46JjXlIUVTgTxUGxVf4iTDoM/5Hu?=
 =?iso-8859-1?Q?XR88RlYzK6X9YuNVsvv1am2joUpzaPLEhHqWnu3p2t7LfE/VN3ccm8XBEt?=
 =?iso-8859-1?Q?ywY7vNdcModiPqcIEPfbF2cCdr78twB2QIDOpRd++pZEkp1ssocB6UcY2o?=
 =?iso-8859-1?Q?U+5e9aHt66r/0QW2OTG0POIMeMPsVdG+uI/cjlS/s9esp4aiGuYnY2NZz2?=
 =?iso-8859-1?Q?h+tx4DSg9YT2dFVc/Rdl6Jqt56pBnpZvCTAM10ZzQAGxpRNhGan7s6DFDz?=
 =?iso-8859-1?Q?0Z0aXnkWQOtsR4sXKMoBHGixZkpaUvAmmLQAECbjfgISq1M34kQ7FcR0ih?=
 =?iso-8859-1?Q?29cfxc44/UB29CCR/BmT33fCKXHTLtoJI4OpFEeEXE8A1y9LpgBvd6bh3C?=
 =?iso-8859-1?Q?XntdaWz8uEzgNp1u8FH/t2DwvbMqDZnoj775gmY4ubPuyCl/0Wp6Oh3anp?=
 =?iso-8859-1?Q?vSIIXpWM7HUB1edyLPtBSHB7lqlV1FEus36PcZxpWWaLVroU7RTxltJemI?=
 =?iso-8859-1?Q?JXw6/xHCVWTHE1lRTEpxKeBxEG8r5NE7Y2PbbI2n92WNvszTAjNa/1dtfq?=
 =?iso-8859-1?Q?8zw/rBqM+xfrCKL491BLyZllvMeMNlxjSXk/KcyjFhvT342bjUvKN7KTWE?=
 =?iso-8859-1?Q?Gum28AjDuYuhiaaivQ6yr9TWuOuWex562oYHD1VbUIiBDHF5ezez2IA48Z?=
 =?iso-8859-1?Q?YeJz2vs8PMa7yc34WehoGYfzokUTscsdK2phXejSmqIDThsFY+chkgUnlW?=
 =?iso-8859-1?Q?7CNZgVDxeDrqdA8IKLphJf3sZzGrjoMXICVGYmAhEqvvYK68iuOLJYrWHG?=
 =?iso-8859-1?Q?INpiHh9Ah+bJN3lVN9Nk9tLTLtthWKketWFErBJbqJgCgnThPpbPig+UX8?=
 =?iso-8859-1?Q?LJq2pMVcnDUua3XRuCag8riINi1P2oOnmqbYbkZloThSofmgukKGk8Uk4t?=
 =?iso-8859-1?Q?5qo0zlzJPtv37IKg6kswf9674yjMHNTrTWrnwarKw+lGe1cLQNQRwSmOOa?=
 =?iso-8859-1?Q?5H3Hc8iMiR7xXIi1ySwCjP9hQQGiHgMCcA322STnyOY1u8PkywBw7WB7+R?=
 =?iso-8859-1?Q?qCMJH1K9OMW2Ioz4l+oDkXJKVKsotqa8fn6Qbe/FicjIjWshlpECbgDiNf?=
 =?iso-8859-1?Q?78qt3olUcESK+wMQe74azcZWBK+1kf1iwVuPgMAmSHEfZqoH6LR9tRMYlR?=
 =?iso-8859-1?Q?h4NQH9eoXggzjOpNkMVSa9buKfb5mPi98JXz0CXJjnOvjhWcltI/mrr+5j?=
 =?iso-8859-1?Q?d7aMU39LtgcT8zCEZrPVRcLEfYyNTvJNcvwwf87Cru7iYQYow8v7eOAyAT?=
 =?iso-8859-1?Q?ACtIK7WA0ptQ25Pg7yx3+toe/iZzRvCG03Cz9GnlObr4mOrXkE0InRcx+U?=
 =?iso-8859-1?Q?6HhvDdiStgTholWv/4gU5vygrrfzIluPdyU3qLng1KgzLxbDy8o0f//4gV?=
 =?iso-8859-1?Q?Maujhmw1h6DfHsYOIc+YGfwBfIDUxyDvdf6a9UDrE0zDkJwsu5NoaQ23Jm?=
 =?iso-8859-1?Q?xST03eVii8sfW4BvV9utMlpB8EkLUbYdfRc8JhcV4qC8GBszPC0p4XnQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b3a641-58a1-47cd-5144-08da669a3ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 19:43:09.0542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rK9lsLNPqqeuAOqAsMzgWw1IlTO1Lyul+/1klzLu5nGbG/xP+I9Qnn1nfjv0nr6iOn8lkSKyQNfxZYG+fxbWjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5090
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_10:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150086
X-Proofpoint-GUID: -0D1P-_VzmOVn3LZ1TDY8nFzW53Key8h
X-Proofpoint-ORIG-GUID: -0D1P-_VzmOVn3LZ1TDY8nFzW53Key8h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When walking the dead leaves, use the nodes metadata for the end of the
node.  This avoids needing to use tricks for BE/LE unions.

Fixes: d0aac5e48048 (Maple Tree: add new data structure)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 14e9ab14c1da..c661fda37665 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5390,15 +5390,12 @@ unsigned char mas_dead_leaves(struct ma_state *mas,=
 void __rcu **slots)
 	enum maple_type type;
 	void *entry;
 	int offset;
+	unsigned end =3D mas_data_end(mas);
=20
-	for (offset =3D 0; offset < mt_slot_count(mas->node); offset++) {
+	for (offset =3D 0; offset <=3D end; offset++) {
 		entry =3D mas_slot_locked(mas, slots, offset);
 		type =3D mte_node_type(entry);
 		node =3D mte_to_node(entry);
-		/* Use both node and type to catch LE & BE metadata */
-		if (!node || !type)
-			break;
-
 		mte_set_node_dead(entry);
 		smp_wmb(); /* Needed for RCU */
 		node->type =3D type;
--=20
2.35.1
