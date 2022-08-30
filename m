Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB15A625F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiH3LrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiH3LrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:47:06 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ED79C51B;
        Tue, 30 Aug 2022 04:47:06 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U9OIGf028243;
        Tue, 30 Aug 2022 07:46:41 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3j7fw888u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 07:46:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEgRJKTdYRfOBzaH4iNC3/CgEmEuSuWaHSoHzWdutoZSQFp+jCvKUu5dar99s5zj/qf1vKdwYF7M2D3d1vBiEjnNybDCqvVYv8hzFmTU5nVuBMZauN85IoFE730hqXGqyEhJHjpz7AlKc8ouyrnHyu3uSFsza5YketFTkD4hn8PX8BevI2jDfpTFse0/XiUeTo9ulmzMOaHYbIhzHwj3CpIXeexADZ29KlGBj6uOVeIzfWHOJyIBYUtvBQ8a7CAhK0fkGGTE19MUPv6I0XyhNwi4YCuNAyxUj+XrdQEw9pgqzE1j+AfqYkuFLTbTgTiOLp4gyeWMI9FYtPrI54dSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBNwjASx9BGKUcpPpsDuKPKX0Q3P5DIzpKr30iTS5Lk=;
 b=RB1y+LKECZSyGHtn467xf1fHpQQV3P7jWzNvk13x2UvOaTrxYneWZOGMiDUuRnJLOsjU42muJraqF/MBrH+RqlycqGruivEo6jHSDpz0ZucsmlccN4IEc3+Ot9LEcNHHNuVT+k7Jcn1BdEPV3P68FNAcNeTWxNcSNFXwUIkHIKImmt5wk6KBBVh43gjOsxZVFMDFKxcZ4iyqgYB5sP5IDRflXpYgsHAnKtL9oXuCSR0Ic9a0tKCEnJ4Y8WBaNX2zN+fTio0K+uIYShhQ1WGuVDfcMaPP3L5vM65ttWKq8JBf5f5cf/AGCuSO647IVXaaFeFwm1UfFt/HZqPzgehNaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBNwjASx9BGKUcpPpsDuKPKX0Q3P5DIzpKr30iTS5Lk=;
 b=YyhNiBBPKZVwiEHPrhZpCwtoV73PMakS5Vgu1IMLX0ffQ8lBksYAqNkxNhN1Vl2PSi/x9LplxVEhygaGP5/KJ6IgePSnLHoWcx7Dx29UDtcYYfxMgxJmDvI+4Fk1MeskRjM69mDokerRMWpM3p74E6cUDu+1pOQk5+JZeEyXmzI=
Received: from SN4PR03MB6784.namprd03.prod.outlook.com (2603:10b6:806:217::17)
 by SJ0PR03MB5853.namprd03.prod.outlook.com (2603:10b6:a03:2d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 11:46:38 +0000
Received: from SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe]) by SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe%3]) with mapi id 15.20.5566.016; Tue, 30 Aug 2022
 11:46:38 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 11/14] iio: ad7606: simplify using
 devm_regulator_get_enable()
Thread-Topic: [PATCH v3 11/14] iio: ad7606: simplify using
 devm_regulator_get_enable()
Thread-Index: AQHYtADN/0Q916d43E+uEs0Mg2tsBK3HY/Wg
Date:   Tue, 30 Aug 2022 11:46:38 +0000
Message-ID: <SN4PR03MB6784BE44D4A6DCECA0859C5F99799@SN4PR03MB6784.namprd03.prod.outlook.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <521c52f5a9bdc2db04d5775b36df4b233ae338da.1660934107.git.mazziesaccount@gmail.com>
In-Reply-To: <521c52f5a9bdc2db04d5775b36df4b233ae338da.1660934107.git.mazziesaccount@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNjcxOTBkYzQtMjg1OS0xMWVkLThiZmItZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDY3MTkwZGM2LTI4NTktMTFlZC04YmZiLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTE3MSIgdD0iMTMzMDYzMzM1OT?=
 =?iso-8859-1?Q?c1NDE4OTMzIiBoPSJRV21IdGpLcTB6WDhSYjdobHM2ajA4RitXc2s9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUExZkhFcFpyellBWUJnZjBjc0lsa3VnR0IvUnl3aVdTNERBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQUpyakpJUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59011f84-1a14-447b-961e-08da8a7d4c73
x-ms-traffictypediagnostic: SJ0PR03MB5853:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aZGNTy6xVSbe5wCbP3R4MzPzwH8NEebo/c8lpau6V5V69ubhtljnPoCBIr5nsqYLe79j3/e7aD9y+q+/Tj05oldG9HNmWGykajznL8j+xbRSGzsHXHa4p694YjOcrDFBBR41Prjt073ou5vN48bBh51fpAgPjfOkVJs/TPIaRSoyJN+e2Ez3IOGUS/pJ83kMgAD+XqoU+yrIclfZ76I+vsS2B02yhS4vXFZCdBAu8Mf4W3P0JE4zJasWyCbxrTqIY7FDtMjfUI7TI7mmDJu5lL+XW5eEgBon5/PxhrOebihKqJHtZMhEuFG/rhsBaJkC8xKK3wL5PYkeqZzg1CgH+Cc6m7dVe5u0yjW65hkCRvVo/yT9yCo8xXYyT5Gf+nD2lhRlwGW++BdxYSkqnVPk6bgsV/bqWPOO6ruYoz6kEABhIwCNQQODwijT66vf5MLlyRQptuww5SeFrbuKc0dhmtYwvJSiEaM8U9BQTxBkOjTcs1CVOgv0Jb7q5ivFaUctKoJ7exftgExZwWk2f2ZqjlHNyLrbKmFwLxgopzyINDXb92w+tbaRr3BtAEagCamOQOFGHCLDFHm4HjbfssHTu+CWkesq054k1iLeCiv9UI3D0VA4wJwR0eCs8ObucEz/9tzjNX55CXWYais5raAnsbCbxBfRgxeWIgerAXpP7NArwz9DNOMzUtI+ETVOg8yp7VmWiBwYKNC6XqWQvyv08iJRnXYGJ5PTRkYgpevcWK6byng1nnWP9c8AZwC1XUdgu2puf1l1U2nmFefbNQNcUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR03MB6784.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(33656002)(186003)(71200400001)(316002)(7696005)(9686003)(2906002)(53546011)(83380400001)(4744005)(6506007)(38070700005)(55016003)(122000001)(8936002)(478600001)(5660300002)(41300700001)(52536014)(38100700002)(66476007)(54906003)(86362001)(110136005)(66946007)(4326008)(66556008)(66446008)(64756008)(76116006)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oygkEZ57NhAaljJPWe4sSQnINFU7mX/mOr9KBBIlZOTlwCwdVnBki4sBGp?=
 =?iso-8859-1?Q?/ZaNHlVuzbjezOdFCCcWdPSCWkXSfHW6CqILOjTAh0DBMWGuTTxUTqzZpu?=
 =?iso-8859-1?Q?3N9Ue1aj3l55mlEEjwLxFlJQ9GclgsHcJUzCqVVof/2qWt4cfnC6FaoX+x?=
 =?iso-8859-1?Q?UBTGcapnYWTQmGZI1UI9sbCDKSUwb3HOY6Af1G1DdYR1uhgL4gj54mn7dE?=
 =?iso-8859-1?Q?J+nRAdCTHVguWxPFM/50R2a4NeTtBm1BPcg9F2hZF/VlZr14wE3QJuJSTD?=
 =?iso-8859-1?Q?Ae8zn0kZuFEHg3B8TytIqjQ1bNjKCZ/miIcbyjn8rCckdiipVvwegubqYr?=
 =?iso-8859-1?Q?3yS8IoJr9xhiVvFSlajyUqYJi8MpgWD3Paj456kkmWegIVWME+uPyMXod7?=
 =?iso-8859-1?Q?AKEigs24072RrY867MzCoVUh3u7t0iiqEgJkC2ZaNaA/FaeU41Qc+8G/vt?=
 =?iso-8859-1?Q?JR+nLpOoZWuz4BAfSFDLdq9/xqpGXHcnoXsilL7VxLHREdnFUxU4ueOhjY?=
 =?iso-8859-1?Q?i1faOlQBZ+9edXB6uXDnEuq2ffrhX7xD6Ln5H/F4XKtmU/9zXKTLJ5VHuN?=
 =?iso-8859-1?Q?ikIKBWHZyvtZt3Gi2sy3NGcdwwcyims2m78XfbI2BfwZQAziW+OkmcQtnB?=
 =?iso-8859-1?Q?sPsR/ga2doGEdmDxD8KI30qnz+GxCelT8d5ip1urxIjxYA0mJqzc1XOygF?=
 =?iso-8859-1?Q?oN/rSOY9GPDKNbSWi54TwPQEzjqwa1dex4N4dZDFWGfKj1oDH4q328//gK?=
 =?iso-8859-1?Q?Gvo6Nw+r3wW00Q0Ec/eTDOfwIyPfcFn37Jc9n7WWrrAM2AHJhf1jKNDGaA?=
 =?iso-8859-1?Q?KOpE+ahZaJppk+BCsJqXr3wRdKSMHMiL4QPdGT5/0Mv5L3jnoK/97lO28w?=
 =?iso-8859-1?Q?6QoH5NldbReebf672QXNeWxximksk/TioIqKPq+Y9AyYCVdNn8wGaeUXWA?=
 =?iso-8859-1?Q?wWy+2BFIzYuBou6kGPU2/8cEr8rP7TpBTweb1d3Ama+wsErX4iQKJaZGdS?=
 =?iso-8859-1?Q?Pp0CSaiWGdQUSKfXl5Knd1KOuikpveEseIyUa7pKadPbD1F/U2MsmfFdv8?=
 =?iso-8859-1?Q?Lp1F2+0HDKaF2+uUuJLpWYu9b7kgU5ODNIjaTvIRyAog4bEZLly8oZRNeK?=
 =?iso-8859-1?Q?hJKZUlohduTYIZMAdoMJL7EjxFO2Q/JDT+OpGq+WD0IxqW4Eej7+3Rnb0d?=
 =?iso-8859-1?Q?TkZ4p77oskmM1tysvC4QfPzSxrH6zMzzSn0ziSPRbHTw+G3L4kw9wXeojG?=
 =?iso-8859-1?Q?WA58DEWy3Bxhv8oliySvlqHc4L6nAIw20QrXn4OIsBu7g6ThdZkb+zHT1B?=
 =?iso-8859-1?Q?GYZF0qMYS3bnx73RABgC6Oz8AVkiH3v7EkdfRvEHy8k+1N4+Q3kVA+GKs9?=
 =?iso-8859-1?Q?Y5q2fHO3yBgSCua0TLgO0TIkXm0CLAj+PAsQbPv/Z7RJiuCKhHmvWLeBMp?=
 =?iso-8859-1?Q?FoQ5QG2vBGibwgcd71LoTxfbXZDnV1ZAFd4aiN8O3lYgUkc6/DYNbL0kFL?=
 =?iso-8859-1?Q?O/Z3XdNWk5BzHYPwZ5XWs2wcWKL6+KvymrEdIKs7ehoE40+QR4vVRP+CZZ?=
 =?iso-8859-1?Q?PGf1c5KWl0sXo9aCt4lm5ZYxAfoz4t81DlGrLAT0Ac/3s1VDiroAIWezhR?=
 =?iso-8859-1?Q?nRzPNeBqXT4bHBUOp70DImF+3/EdAR+KdbMcJ/N/AlXu51ePFoOiLBZ4rc?=
 =?iso-8859-1?Q?J6lzA1f8CHtm5l7ma3UTm1a0bX7HpzkmOsLgLjbs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR03MB6784.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59011f84-1a14-447b-961e-08da8a7d4c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 11:46:38.3910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ea4OQP3t0cxgKwdU7JqOBK2xmlwUMd6ZoEtpK3xY+YIIGhyeSfJVaGANyIITSMI8z7pqh0UrNpvfCgdnr+iFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5853
X-Proofpoint-ORIG-GUID: ebnYtGt62cKxwxv1Q_aPrvA_mipGpwBR
X-Proofpoint-GUID: ebnYtGt62cKxwxv1Q_aPrvA_mipGpwBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_06,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=867 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300058
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> Sent: Friday, August 19, 2022 9:20 PM
> To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v3 11/14] iio: ad7606: simplify using
> devm_regulator_get_enable()
>=20
> [External]
>=20
> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> add_action_or_reset(regulator_disable)' and use the
> devm_regulator_get_enable() and drop the pointer to the regulator.
> This simplifies code and makes it less tempting to add manual control
> for the regulator which is also controlled by devm.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---

The commit message could state that while doing the change, dev_err_probe()
was also introduced. Bah, anyways:

Acked-by: Nuno S=E1 <nuno.sa@analog.com>
