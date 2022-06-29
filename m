Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2026B560471
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiF2PYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiF2PYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:24:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC6F1DA4C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:24:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TFDxux010301;
        Wed, 29 Jun 2022 15:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BeuhH4z9I1+8QKe9Z3IrTKg70qh+aWrGAkoZOsrEdmU=;
 b=Ty3QrhmBow+M6CH1SYkUV5rYJ1Z/4+ACibi+aLHvfUZ0pd5B3ATXfJujCFyW0qYT7dQe
 tvWZe+QQD3nOEFUS8A7ZYLC+L0+Glkv5mYsKQeyxdBFVfm/rZBr97b1xHvTXrwBd8RIn
 8sioCAyGz19eRbNbDi/8sDudyygvwuU0BCHhnmeDQxq1Dza1g7UeC7mYv1XaYixytXMd
 F4vEl9Vnmq+f0ntwIe2Jbs5k/rExgUjSLT9dbuB8+WgFcUNAn5mFCFzHDfh0ELErC4st
 aMiShqhGca2rH5/MFuQjOUADJOamh9dvysP450Kon4vRRMOFxIeP+HLBG1k3D/7ioUAQ 0w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52hk62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 15:23:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TFGsTO016936;
        Wed, 29 Jun 2022 15:23:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3duhd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 15:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVve+Ad2CL+tAOzvIAMMTDbvLe68AuyY/RtXryiYnVZk0V1806RTS+AAEEJJfryco17vpWE+CXnaD3brwBNL0VKJobhKt13Ih4YZqzuxsTlp9OlFcc0OO8Roa+GKM1j8Hnh/Ng/VH1rqnQgKcYzZ5udM543fRM5rSnqZXP6/iTIoJTcJ8eftbzKbLdrGES5aXEqLcpncGMsMxA8+eOoWsPSk5cwN3CtFyG/sJloIrn9Apjefer18V3U7VIWOYdc2IJFMAY2R0VcAdqeZGtTdROSUTFgXlX/HjcS/l0GervFKCpxCruEjB44edQye4kO2tV4ijrlYAZJBHOFhrS7pBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeuhH4z9I1+8QKe9Z3IrTKg70qh+aWrGAkoZOsrEdmU=;
 b=Pq80JK6Z0/12AGeEYoNDJ5axKSPP9qCuPc6iaJ3o6dNS4FkD8n9F6pB6gdI/uURAvpIEASd0DSMlLtr7DdS2/8AFvuZmTyPoiujWnNOHD421+2TI/mbK7z2TUSdxIWBoedvmgIqj6v9r/G5iiXOdq3Twm3CVtR/lz6zRDkiDIiE1i6nEw93Sah5VqPEwHmcfEHdUD8yxlsorZzHvH8tFoHYxrewQuyU1yK/g/vjZGjpvmk+NmoZhQX05suQ3SL7qNlgxR3GEwAc4AeP7gmlBNO1C+hX73D4FVUX4g3BKwJjdPi4HQGeDYr+GWnn8cevxFFlxi4sLUQghNe2+GuRS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeuhH4z9I1+8QKe9Z3IrTKg70qh+aWrGAkoZOsrEdmU=;
 b=OFbpBLHyb9e5GeJWT0lfVjQOvBrBhz4SbKDHErzJdm0qBwgyZP5YAQE/sU3GCo3dvdVNjKdNnNEb3BT9tvP2ws68FrDyEusjlz9bCqTmBGIAD3V+ZIJJJ4N5ECwbLh1OzzhnvRosyegz2h5nMA8qWifnfDwonVBzGCPgQeCurGM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR1001MB2382.namprd10.prod.outlook.com (2603:10b6:301:2f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 15:23:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 15:23:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH Fix 1/2] maple_tree: Fix mas_spanning_rebalance() corner case
Thread-Topic: [PATCH Fix 1/2] maple_tree: Fix mas_spanning_rebalance() corner
 case
Thread-Index: AQHYi8w8wUJAbEifSk+iBng4IIc/BA==
Date:   Wed, 29 Jun 2022 15:23:50 +0000
Message-ID: <20220629152340.3451959-2-Liam.Howlett@oracle.com>
References: <20220629152340.3451959-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220629152340.3451959-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f4e30d2-c908-445f-f4b1-08da59e35ed8
x-ms-traffictypediagnostic: MWHPR1001MB2382:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: arqIZ1yvPTNQ0GRmQ5YJVfU9ljZ9esxvlGF5Oeb071Xy0MGVANObzn3RrVpyq0JtMvj/OxjnPfHAH4wwxoj+ocRJ1YrI8UQQFGYrHjLvwDmDaPQGrgnjiGSM9ORf7v6OcY+3/nlHN2w7JgYYO5qlM8lIizO0+vyxkbzfipCcoLo3AY05veAXhFS5IRODb65ZLuhI74LhsGAWVIzETm92hXx1NJArsmGN2sKUgAo3z0XMo0SdV/7hKJYarFK/lNUZnNPNM7qsvb263Y76VApANtSl6vf5rhmXv1uQLlbTbnpVdT7ySuUpgnyCwpl6jP/+fBgHAr6ycvhjas2RjQ+sYPnspCcoUjo5AIM/6vXOFfkDkHPd2m1f97I7mteZvaYzqpjHHgO+Oj/3D+/PAGCP3J9HXeaZM2+pxByxOGV7Az0hnm73fLUu3qI4qyNeN8cn+tnm0AUC3i1FkQsIhp2hScF0xqTXgDNQ2hNADZa/qapKcHbB855p/L6DnoyqbKgilTueYCwsOW46/S9ecOjHwS49w9B71vpYMLgjvULCfoSFoZApMB6Op2B+0jYpRb3zv/SnhzekIfXAzFpmatGUsaopXEqlPiFpAgWER1BFd+rJzacnnn+IX3e1J9HIce1sYkD3Ul5cBILd8E4488AVNknPtaHyGRKnQQDIQDS2wH1gHXwVqX6XGlyr6uur+hoCbTznVgW2MBsakCYEV7KSCMQvxII6fvSPZCp431uSs4CUqRmoOzORstROAD2XK/VKHJlO6WjHlzZAvlh4BfxecRg3qpS6zHSkpoKb58nBTRI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(39860400002)(396003)(136003)(6512007)(2616005)(186003)(26005)(1076003)(83380400001)(36756003)(38100700002)(6506007)(2906002)(41300700001)(38070700005)(110136005)(122000001)(44832011)(5660300002)(8936002)(478600001)(64756008)(91956017)(71200400001)(6486002)(76116006)(4326008)(8676002)(66556008)(66446008)(66476007)(66946007)(316002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+KO5TF2yoF42QcdMQEtWsRSaT2VnZtqeRFl+HBKoxTjq+nImNbKz2CYh6f?=
 =?iso-8859-1?Q?++EG0VvZZvVracL+5Q2Su5B1pjO9DwXVRmILe9xaeMn+8BQh0xOhJEGlO2?=
 =?iso-8859-1?Q?NpI+mtLg8HJRod/luQeS8SnIc9iTu9r+YvlosbYRMBCMQ2FwprYGBnq+x0?=
 =?iso-8859-1?Q?N8CbOuzdpJqBT52J25kMjxpXvUka7gSiWqQ0ULXm3In5adcMb4G0UbQvDh?=
 =?iso-8859-1?Q?qIYHRFxGmtnAtTAAWadr48i+Z9zcNAaQD4a98x0OsUZniXWZINC4eBsY9L?=
 =?iso-8859-1?Q?KyWh1JJbC6hUQk+QCK746ixCsKNfqrW/0d0UmGsP4QlSacKIU5GMx+sNUh?=
 =?iso-8859-1?Q?R3PeRL1GNGz9AnffssX3EP7+owHdEwKAC5Xy6qDwz8A/q+XZEXN6HTY/j/?=
 =?iso-8859-1?Q?0mg9b+90Eaf04B6vERF0HGMo8C39kBDYGM8+kWn5Sb//7n04PwIBiA/+R6?=
 =?iso-8859-1?Q?gK3MkM7ddEqfpi2bwaHqxIRKmiCVTUA1FmHRi/4MzRH2KbxKoOaT0Bqj+i?=
 =?iso-8859-1?Q?6IbqNT6cE1mf45VXvHhmx9PYOdtdLaLPYj1cpujGEftQIzX6vLXhz7BZwg?=
 =?iso-8859-1?Q?yc3v4QbwxcAvf9f6lmfgVstL0lUQZoJy/8WM13lBdS7IwwhwqCpgaqjbHO?=
 =?iso-8859-1?Q?+ztIPC9HQ+QNEpXgJp6734GcaxgktGbFlBWEsB4vJE/81YviQ05qW90nFI?=
 =?iso-8859-1?Q?REHXeyq5RZ6EYTt9q0lKSpfu1zGTlJfA1dPXAjXeVKE6BahKURpGCyypWg?=
 =?iso-8859-1?Q?hb44YFjoDhI5xayYJ5O+ueZx7H0BoNcaxGf/fSr/+ry7EAL9qRRIwHaIKV?=
 =?iso-8859-1?Q?jQAL8lfoOw5fLLB552UlCgF/ZHNB/BnnGBcXlmfayGlp/TLTdQwfZbAwNV?=
 =?iso-8859-1?Q?MwgrxoJr35peF5V5aXjP5FCPpxmDBlRvWNzfdOpqA7ta2QU2A2kICyrRP6?=
 =?iso-8859-1?Q?ey6EJMEJd4Z5RRybhgY52b16KVli5xYqfm4nM9P5Y6MTnDIBh6UkkeNbmC?=
 =?iso-8859-1?Q?IxH7IFFkUBdZHDBmwAu3hNu9XugbtqiPo54rhOtMVDKuzHNbVDgSuHwKQ+?=
 =?iso-8859-1?Q?LCsG7Y2RV/2FHjUmU2FYIPp9uy0ekCUIoNbrxqwoqX5S2maR9OYdKZ43wq?=
 =?iso-8859-1?Q?ctHHyVUQv3hq+jbe5hSGcogl9/sy23U1TYT927BWyDswzsrZgCdUciA+Pw?=
 =?iso-8859-1?Q?iBdd+T0iz0hjpTWNZdxBGkppJnBDVCz5LM1SlIIdzrr7hz8e04lL/+p9D0?=
 =?iso-8859-1?Q?LjIHSwUQ1ItnPRjFvrwuKD9+h9s86QouoGMyOpnPl0l4qR2gW6zOQiLcgZ?=
 =?iso-8859-1?Q?FOj4JF9iMMaynvZSscDaGGnWchLkd7K76cAfgSKfWfNX7mAQpM6tZZJjge?=
 =?iso-8859-1?Q?K0oWFiWvt3bHsVPaMiWp0WE6AApqt4ZcYOdOvOtM5rnNEjvzxj79BXMiyh?=
 =?iso-8859-1?Q?tgqR04KJThoEvPdUUX49lMITmOPQwqdTFJaqy5OmY0gGZF09bo5qDL6L7M?=
 =?iso-8859-1?Q?yd87OH6hXnJ/cmPVGAy7Sp8n5jwnA9ovBB48pIYd6RV44ua/VlU71WNLSF?=
 =?iso-8859-1?Q?mZH9dT3LW6iKoKLdB30+ErCAsVXtoKuKRP5LKdJFGAJXGngPU3SBajFBkc?=
 =?iso-8859-1?Q?9Rdo6uIXejtr93QvIG3sB84QN3eGZgLO1XY5rdGVuGcfjHqZ4MUr1Ntg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4e30d2-c908-445f-f4b1-08da59e35ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 15:23:50.7415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CX7Ta7m4K1SNWOBJu7wVwRzjwdz5sJUFExBjatB16GmkghB641xVaUwBoSR+1q2+hOurR9Cn6FBifziiz+06w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2382
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_17:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290056
X-Proofpoint-ORIG-GUID: qOt2pg-uVGLEPC-bYE4SqmSwjzeyiVrI
X-Proofpoint-GUID: qOt2pg-uVGLEPC-bYE4SqmSwjzeyiVrI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a node is insufficient during a spanning rebalance loop and
mast_spanning_rebalance() is called to combine neighbouring nodes, the
loop should not terminate regardless of if neighbours exist or not.
This will allow the data to be stored in the correct node.

Reported-by: Yu Zhao <yuzhao@google.com>
Fixes: 37a4d714b7d9 (maple_tree: fix underflow in mas_spanning_rebalance())
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d8457122ca5d..2cccd8f2153f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3029,8 +3029,7 @@ static int mas_spanning_rebalance(struct ma_state *ma=
s,
 		if (mas_is_root_limits(mast->orig_l))
 			break;
=20
-		if (!mast_spanning_rebalance(mast))
-			break;
+		mast_spanning_rebalance(mast);
=20
 		/* rebalancing from other nodes may require another loop. */
 		if (!count)
@@ -6521,6 +6520,7 @@ static inline void *mas_first_entry(struct ma_state *=
mas, struct maple_node *mn,
 	max =3D mas->max;
 	mas->offset =3D 0;
 	while (likely(!ma_is_leaf(mt))) {
+		MT_BUG_ON(mas->tree, mte_dead_node(mas->node));
 		slots =3D ma_slots(mn, mt);
 		pivots =3D ma_pivots(mn, mt);
 		max =3D pivots[0];
@@ -6531,6 +6531,7 @@ static inline void *mas_first_entry(struct ma_state *=
mas, struct maple_node *mn,
 		mn =3D mas_mn(mas);
 		mt =3D mte_node_type(mas->node);
 	}
+	MT_BUG_ON(mas->tree, mte_dead_node(mas->node));
=20
 	mas->max =3D max;
 	slots =3D ma_slots(mn, mt);
--=20
2.35.1
