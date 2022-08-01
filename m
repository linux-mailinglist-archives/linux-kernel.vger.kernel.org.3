Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76311587244
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiHAUVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHAUV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:21:28 -0400
X-Greylist: delayed 936 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 Aug 2022 13:21:26 PDT
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533B0B3;
        Mon,  1 Aug 2022 13:21:26 -0700 (PDT)
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
        by mx08-0063e101.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271JnLuP010322;
        Mon, 1 Aug 2022 21:04:23 +0100
Received: from ind01-max-obe.outbound.protection.outlook.com (mail-maxind01lp2168.outbound.protection.outlook.com [104.47.74.168])
        by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3hmsvx1r33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 21:04:22 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsqrzANNiGOo9XGJt+YL7/C41Iyl2ZAAYlFkbupQac0sYxkHO1+6eBCc40/rigHTxIx2r0Zkct8hMBKxuvy9ipikuqdHtKWYFrY0F2CnSyRgO8L+me73M/Ro2oX+7ouSOxDJseUNPC41sTlx4NJihBnoykWr21yg57mC7Dc0oDtUdGp4WVgdSR7VnnL2HP6FrWLl9P5L8hqsAv9BWDHxAyMBlBXT2FhnXf0gdUAl3sN8yNJwPtkoJ3jwk5pAN/0KRVODvP3quo7CDA/8VhfdrKkYjOAvA88OJ/gB1IMpAz1JlXkWPsJfWZq+TaPaVLfARxlQnkgEayL8myz9wGwuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4/KABjH03+LvwzyxfFBCRv/JKZIEerISotQ62Zhv6E=;
 b=Fh++YJBBX3AcgvmXZ5NPyrnQCPbxazeufBKsNAaZQc3qmRRY0gIno5do9CfkS6hPN+hZ6CEcYgZXt0Z0AFcMaWMpai5juR1AxEPN6UQfZfsokIzvHkOHSB2uMD6vj9H8PjkC9k0NYCnxhEFtZ8GLwixPtYcRiq6IZ9tEbldfHhFLf/KmMQghGGJr5g90LgYu91sJAf+NdmFCHMBlz3mM18HZ7SCoMdtyy4gftO9ZmvOlxjIq5XLa6Zk6PeDEVTnPGDXl0EgLKQWNlxYhG4QZXXArptJzomB2D/BWaOWQr7eUwzbB7TNOfYKu/Xou5zBmpj6+62tPB0BpuFEydiHebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4/KABjH03+LvwzyxfFBCRv/JKZIEerISotQ62Zhv6E=;
 b=PCY03sDj71H2x6UiWDTmCviyKruuZVHTJvpAbwtxsWUm9SO9qkHc3WLAw3bT063e51bgcm67qiXt1IE/5HGdE7B8+k/TFQJROLVxifF/QLmDtXx9Xg7F670KK9mK9jWnxVP+VfbJrufTqPFh8KGqdzEdKsgaKeMdRU4eaUPUS8k=
Received: from MAZPR01MB7261.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5b::9)
 by MA1PR0101MB1590.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:2b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 20:04:18 +0000
Received: from MAZPR01MB7261.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::48e9:9403:b83f:a962]) by MAZPR01MB7261.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::48e9:9403:b83f:a962%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 20:04:18 +0000
From:   James Cowgill <james.cowgill@blaize.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andre Przywara <andre.przywara@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>
CC:     James Cowgill <james.cowgill@blaize.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwrng: arm-smccc-trng - fix NO_ENTROPY handling
Thread-Topic: [PATCH] hwrng: arm-smccc-trng - fix NO_ENTROPY handling
Thread-Index: AQHYpeHiyPoPvuRfgUyMtx6AkrBadA==
Date:   Mon, 1 Aug 2022 20:04:18 +0000
Message-ID: <20220801200338.261264-1-james.cowgill@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96e2fa3d-60db-43e5-fe0b-08da73f90486
x-ms-traffictypediagnostic: MA1PR0101MB1590:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AnS28vZlkw+qR7hQIZ3tW2zzf6VcryJbiD/doPvAomx5YJrrSOaWvJ2AsqI9ARi7Hs4BqWunUvXYN+j+2BAnImNnm8HgzWBNdkEEMQea7DZz7mW10ixJjbYCHMj4MAjsd7CbdE+jDtb75AjQzkvvURro5h9G8dvOh3EbnEF7Kv1cbWc0D5qIYpPgDmvgPrlNGIvIm9drf3kZQ/t9gaUEjgwyXXr7CSmJXfvaKtKbY88Pfv8s7EbfN1US16RnbTYHje1CjcAi7NQayvzMyEbZsVQHiAbcD+D0qSfG8/XzBEVHOJg9rPF8C7L1Ra6gc1+XqyY9mqfA5fUlFdGIZEWpG/gOWTi2toLD0Srx3tdifOdOnCeNlNn1VFawlnV3UGt3Pu/3WUEN4cGhcM8rPM4+vo3AHflOcMoZEXqGIqGJlz+q5uQRJsQkjUmpl4euWKKbYRuxVumUy4VIxQR1f/1PajpaekfE10jnpbaUs+lTvvF73bbjOZvLqBFj4xxC/foQVFxv2ysEuihh4YBSUw1qni41SE5Gn8tWOEU/MQbxw6nAFRJrwaPtYYOw0ljckbtkNZMyg5wVkBj40L7lUKPb1xq27eMRidSdtx53ILz4cnjMV20h96hi35FI9LKXgD2iaaND1iHyaQqN2vEEGshjvyW+vkYoOZtgOfkl+bRIsXSrAc3j2XpyGIjJJwl+ZJuI0JwaDL13KO3Viu4yWnaVoMtH35HV3bN19K5C7V+AQ/r86nEAPxOSFqFLd9PPknaewRRh7EuJiQtuR3PYIQuWOwREsRhUpl2017z/5u6QG4DEo+kppTsvVz75NXO+HYRB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB7261.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39840400004)(396003)(366004)(376002)(8676002)(64756008)(4326008)(66476007)(66446008)(66556008)(71200400001)(5660300002)(36756003)(44832011)(41300700001)(478600001)(66946007)(76116006)(91956017)(54906003)(110136005)(8936002)(316002)(6486002)(186003)(1076003)(2906002)(26005)(2616005)(6506007)(38070700005)(83380400001)(6512007)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?REr3+gL/IB8kNdW976XoWKMLBIsVMgjlpAnsypkTAEGs+qVahH20lsHihz?=
 =?iso-8859-1?Q?hkeHM6E0lM2tKF0arOP3BPULdW9jZxDwypu5EipjEqjUh0u3ltSVuTTRVp?=
 =?iso-8859-1?Q?shAADqGcifvZ5kQbt1vGaOvqK+UflVaZx2bJHqX2hCABKyTgcRcjggr9Iv?=
 =?iso-8859-1?Q?PRJBjalbxxMKW3fm92JayXnjP2T0zIxV6Na/kedAVEV80yY5ofwzaXEqbW?=
 =?iso-8859-1?Q?+190Krnx+p9Lw+S0w5jQ/Lx0Wnj4PYb+yjpBkdpGjeDS6Sk5djiSIWfPKl?=
 =?iso-8859-1?Q?52FBnTp1y+22de3x2TzluJ6zX6S2KnEO3g7IVzBUxoUsN3pehhBFbz9rw+?=
 =?iso-8859-1?Q?9J4FvVuuq5pWNkFilgZESp4iTdHRrHNIuiUz8gdvt1LfhQzITpjHf+eXpA?=
 =?iso-8859-1?Q?pTeCyGLdtgy3rRrtgiAOG/0z4G8wfzY13huoAiF8Uhd51pTiUHAWcRsYPQ?=
 =?iso-8859-1?Q?/cWKasphXXpL6Qy/cbwiQhkrUBjs7yPNiBz0yu440n6GsuqWpn048FsUwI?=
 =?iso-8859-1?Q?o/bx7dFjWyhLvtnJFuHebEl1QEC6A+6le5QlbFMT714/9n7XUXA45Uue4r?=
 =?iso-8859-1?Q?KA4/m0oz8IRa9bIBfgfoMm2wuX1pOp5wRywe++b/x9HP09cQmqkmTK9nuj?=
 =?iso-8859-1?Q?GjIxE8303eW379NP+QXQtBUbpC6VA4HXjM6ULDHgfFnxhCO6AkQaigClkh?=
 =?iso-8859-1?Q?jH6/KlaBkvpi+MKSmaiandQ2g8T+X/ctelI6CZ+aAQfuhHgTWTGgIw0zj8?=
 =?iso-8859-1?Q?kvt24JD4gczYLiIx0ym2Zu3pSTFZBBkdV0wAeYtDIrEnr6mlCtgwC5jXPI?=
 =?iso-8859-1?Q?r2+zjYnLFULSeN+TJtcrS7x0kwzPtdOT44F6svutxqFgtEf+qDowt3Ch4A?=
 =?iso-8859-1?Q?ivGmtTQ72xlTMNfenklheZcDW/Ju110uXInf6gFYBcDD72/+X9JqWioOhu?=
 =?iso-8859-1?Q?cZIZEMkLufVhFDcG6DDvSripf4Ym+nv8EjaPpQjOq47X0lkhw7XuKhofuD?=
 =?iso-8859-1?Q?G36fAhkN92mX8IBETWwZRKJgCyUZYe+kZuz4j0Ha79mXksPj3AwbRer3b3?=
 =?iso-8859-1?Q?RKUz3Q75NO11vjuZ8VXX3h4Izj1a74yzWdtG0Mafmxy1i5zfnOa2TT7O+q?=
 =?iso-8859-1?Q?xOEAvWZDcfDtFsJTXA5BFE5vGvEFwJbQK9zDiay5I56DPWRgUhOWO3vBq1?=
 =?iso-8859-1?Q?XhhqAKXaeqn2FCf2N8ZUyjrFULt3PrsRFCx9n9kYalIHPLyFlH0XlLAB+l?=
 =?iso-8859-1?Q?C8SWQ7AI9K+NojBi09LQy6taAlygHu7DQ8G0ZkmiIgLEUAZnZM1fAw4FQL?=
 =?iso-8859-1?Q?fPLTrhV4ZG562SBEGm6WVpCFqMZRJj6lcTTMOc2sj6UjXDNDati7SYSjgD?=
 =?iso-8859-1?Q?IzjlbeHfySlxUaCZnuy/mPSHTl6g/w4tGWsoC+geWC/dkQbhZjkgAp5gCs?=
 =?iso-8859-1?Q?NIHZdH2llzhNG2k6wJDlqEz9E0sFEVRVzZoXI1tNiXSRCL+gvVlZsuOJh0?=
 =?iso-8859-1?Q?QI0by4BSs7VZgf0qEtH4+YA/NxGsbbXZOkJpvGuncyXASYsMSDjl6LIUbn?=
 =?iso-8859-1?Q?jy/Sc4ddtAO/82pVTeite5fNUCAt6pIMRWyB0yfRDe26gBpDaWMBAW2E+U?=
 =?iso-8859-1?Q?jMM9NcVWCVZINjZQHyRPfF1B69pNgJMJpB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB7261.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e2fa3d-60db-43e5-fe0b-08da73f90486
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 20:04:18.6196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nz7MFAdxe/DKwNpabqCAj2USmBno5EYgLrpCLEhETz9Iw98PFRfQQyBpW9xbO9VgRafSB0DPitxmt4KeGCP2h2hFPw4WawsPFZPkp+LhVHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR0101MB1590
X-Proofpoint-GUID: ZEAumRtwUn1S74ufTb-MBbLDIbYf5bzJ
X-Proofpoint-ORIG-GUID: ZEAumRtwUn1S74ufTb-MBbLDIbYf5bzJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_10,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=911 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010099
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMCCC_RET_TRNG_NO_ENTROPY switch arm is never used because the
NO_ENTROPY return value is negative and negative values are handled
above the switch by immediately returning.

Fix by handling errors using a default arm in the switch.

Fixes: 0888d04b47a1 ("hwrng: Add Arm SMCCC TRNG based driver")
Signed-off-by: James Cowgill <james.cowgill@blaize.com>
---
 drivers/char/hw_random/arm_smccc_trng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/arm_smccc_trng.c b/drivers/char/hw_rand=
om/arm_smccc_trng.c
index b24ac39a903b..e34c3ea692b6 100644
--- a/drivers/char/hw_random/arm_smccc_trng.c
+++ b/drivers/char/hw_random/arm_smccc_trng.c
@@ -66,33 +66,33 @@ static int smccc_trng_read(struct hwrng *rng, void *dat=
a, size_t max, bool wait)
 	unsigned int copied =3D 0;
 	int tries =3D 0;
=20
 	while (copied < max) {
 		size_t bits =3D min_t(size_t, (max - copied) * BITS_PER_BYTE,
 				  MAX_BITS_PER_CALL);
=20
 		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND, bits, &res);
-		if ((int)res.a0 < 0)
-			return (int)res.a0;
=20
 		switch ((int)res.a0) {
 		case SMCCC_RET_SUCCESS:
 			copied +=3D copy_from_registers(buf + copied, &res,
 						      bits / BITS_PER_BYTE);
 			tries =3D 0;
 			break;
 		case SMCCC_RET_TRNG_NO_ENTROPY:
 			if (!wait)
 				return copied;
 			tries++;
 			if (tries >=3D SMCCC_TRNG_MAX_TRIES)
 				return copied;
 			cond_resched();
 			break;
+		default:
+			return -EIO;
 		}
 	}
=20
 	return copied;
 }
=20
 static int smccc_trng_probe(struct platform_device *pdev)
 {
--=20
2.36.1

