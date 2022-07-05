Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA05667F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiGEK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiGEK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:28:33 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00073.outbound.protection.outlook.com [40.107.0.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE7C1409C;
        Tue,  5 Jul 2022 03:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQ5G1lqBj4yOuod6LTOTe7m/pkj/PaWNic1bk1Pc9URFrBEdTBDmEX8S97XcaGHuNngGEej5lWLLQf2Ol0yXAD/hVMul2xoHVgPgS9g7ljYIY8gKLtIuv600IPQnjRII4Gd9flmu2S+/nKy2dptRzdTeGBl1L8r5Kl61md9XYNEAyiAZT00wI6wsvlK+fQC/ORdzhYPBy5oUL+RFuIg1nQEc4OcupQmN0SwC2UIQQAf1bqj8Uf9FiuUZ+HL9ebwiOywn+2mKkU7dQV4Efe2dcJLdB1Sw/PcOzsxI1mgkXSVZEgDB6dNwJjE8hkdNz/cHcVuwPzCnPxFBgGoK2ytA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0nkbE1Ej2K2EvGgNU+xxmX9fJdWMhTUL2vBNcqeyrA=;
 b=K1eedbeGHnoZdDIUWSL7Ae9jA/3gPewxC4ayquVaetFhO8ABMUN3rbGbbhfg1kZEg61w/seJAZ1MNJpBj1zaUCL103cfC3euURiiXrms8bnTIFkQ0ilRwSVJGQBazY3S8ri6kaOxpY7Bm6vWQBuTRn/bRYTq4odnKMgpGXPppFSoZwOx+DCRjFwxEsQLGdWM0DzpszWU2X3YR1TwUxkkRbUHM+BVCdDQvvmTpxLPrUvXJlVU7MlUYxPlX6XtN2OQ0nVvRu8kbaOVm5nu0RkRYEESWBmGQZOkNpUWX3/e9+RA7TLOZ2AMOAExgmuGBDeym5LqzT/QcwHoXeTvXnyc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0nkbE1Ej2K2EvGgNU+xxmX9fJdWMhTUL2vBNcqeyrA=;
 b=nvBJyc6BliV7tfkT4kIXTdsKGoVtxO8ddhF741AP5z0+dkuZHgEpgZBnC83vFGJvl89JqawZ8DzJv85t5atTeXtGWrsbeS2Ea0FtSN0/u3ScoyaDRNWoe3dIcJ1J7mHRuTw3ZGJzpMjaS+t+3RvbEm25wYMv8CpFWP16JC3KjQM=
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27)
 by AM6PR04MB4151.eurprd04.prod.outlook.com (2603:10a6:209:44::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 10:28:28 +0000
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::7860:3ed5:c3f9:af55]) by VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::7860:3ed5:c3f9:af55%4]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 10:28:28 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "ashish.kumar@nxp.com" <ashish.kumar@nxp.com>,
        "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Han Xu <han.xu@nxp.com>,
        "singh.kuldeep87k@gmail.com" <singh.kuldeep87k@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "zhengxunli@mxic.com.tw" <zhengxunli@mxic.com.tw>
Subject: RE: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Thread-Topic: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Thread-Index: AQHYkFFzIQJYAQOANkeHbugQ9MK9oq1viBIAgAAJGvA=
Date:   Tue, 5 Jul 2022 10:28:28 +0000
Message-ID: <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-7-git-send-email-haibo.chen@nxp.com>
 <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
In-Reply-To: <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 482f38fe-cd93-463f-1bf5-08da5e7119f4
x-ms-traffictypediagnostic: AM6PR04MB4151:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWWCA3gWZJhaeUNg77EawQJ/UU++KrbCHr52mjOuOfYRGCE36EipjbQQm1zr0LSdtqL3Guc/l2S0BM2DboDWXSEz0MBDku5h+t/hh05Lg14a9nMQsxkKSG4DuzMUhi1PCHCqbTxOAz6/e7B+t3U1tJtUwUsIzVL0Mc034R4kD2OrT6KjFjcn4CGn4XVrF6mbEnLY2KDSCdMQRC1PxbRNlq+zRkwPSYxjseraeJLKs/jO33CFOzp3eCJDmCNFZrY2Ej63+Z48kHhvAfhL+U51C/xLTpgxZGeWuVgAt46i6wlu+xU3ZxCPgwrJ1HBbYnEzdgzZFDh9vyYH8yd9t0uh7MfFiiYN1QJwooOTAfaR6ENMoss5LIANlzZSGY8xAR5PII0nGL1tvF+DHbf+pxNXBm/Ablre51mOeQbWu/+i2Vz4hRB6mnRETJVo0Q59AebkzO4HTCqXhq0ooZxaOb7BxdNafqaaPfsy2SgaJJJ3jRAg37NpC0ocl89mv9Jzek/dBNfluV1xxdDw6gG4GfANEaAReWBayGS4vldYQMnFVxMdvD4DuvSHbKrMem+QGqWrW3Bl3MCr04yFvJ4JqGNwn2BSg+HGEbFXBms2AdQMHu9pumuos7l+TxJU03mnIK8YwPsZPqNtiwhWqEDdO6z1OBHhmUJmzJo9pMb+oH9IBsXH90grPHAWThNlkg2qp5QB3uhNq09SXT9TzE5apjVgWp6sLCk9WOQe0RV+N8yA+w9OfdMMdj8CM5HfRTh02Qtn75oGrxHmJnZY9oybDWbTr7lPLE0mfEvnNol0xydEjh9jZ76a7hHipiLgfaQRMuLqF3af+cM+xc0GRLvGHwRusw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(7416002)(8936002)(478600001)(86362001)(52536014)(5660300002)(6506007)(7696005)(53546011)(9686003)(2906002)(41300700001)(33656002)(26005)(38100700002)(921005)(122000001)(38070700005)(83380400001)(186003)(55016003)(71200400001)(316002)(76116006)(110136005)(54906003)(64756008)(8676002)(66556008)(66446008)(66946007)(66476007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K05RRlNwaXJ3OFM5akFOY2xSQzdyalZWNy9JakxSZk05elpxYkdJNTF5NXFm?=
 =?utf-8?B?TnBPcDFhUG1ZUkI5RThsUCtyV3NvQUlWcXVsV2NtT3VvbnRJeDVpRHF0Sjdz?=
 =?utf-8?B?VTZpSUNTUDhyZ094cGVvZ1pORGhaSDdzZ2oxemQ5RXJJdFlteHJ5VitIYmNz?=
 =?utf-8?B?dVhqV00rVTE2eTEyaDVCUXZzNHVKRmJBMjZSR1F5Z24wc1BSQ1UyOXBRak42?=
 =?utf-8?B?ZytCK1lHZThtNjk1Y3BjczlUZXJsb3R5RzNPdjZNcHplSDBrOWdOUXF5UnhP?=
 =?utf-8?B?RHBjV29LaHRubmErdysrOFJCR2UwVzRKNnJNR0g0blU3S0tXeDlHMWxSQkw3?=
 =?utf-8?B?YURpVFJTSk1mUnlmVlFMaWw5R2xnZkdXV0sxVnNNK1ZVWk1zeU4vaGFyOHN0?=
 =?utf-8?B?OW9uZVQzV29FWG1nUlIwTDhlL01MOGV2ZXNtQVc5NDBnT0pjV1FvTzFNV1hl?=
 =?utf-8?B?b2NCVk9Ha3Y1SFlkV2lKWWpPM2NMNmNrdHFTQjVSSFc5aEhlcnFWQXR1NU9y?=
 =?utf-8?B?SlhJb1FCUDFQSVJMb3lSeTFWczRmOWJ0NU03Q0hpbjlkQnR6WkhuOU0wZFAr?=
 =?utf-8?B?SWQwWkt0V05CcFIzKzkrYnFnc0J4K2xYUXlMcmJXamk1WVU5c3o3T3dZb2pX?=
 =?utf-8?B?TVFrcnhQSXVCUHdyMmt4SWtEcTFsOUd5a3p6WklkZUd3UkRaMXBWQVVib3R1?=
 =?utf-8?B?NHdZYTlPV1NjQW9RWUZRV1gxY3VJcWRMMDNzaUluSlVxa2pTa2hic0tmYjlq?=
 =?utf-8?B?dDlqL1hCNHhDYWdFVm5HVzlMcXRxZllCWjJxREtoUlQ2Y002ZGlFbkl4aVJp?=
 =?utf-8?B?cnBKSXh6blhXb2E2c0xPbEFOYi9MdFhDSi8xVXpxMkhZZWRqTVprcG85ZU5O?=
 =?utf-8?B?UTJ4c1hnT3BOWko2NUVEUE8zNlV3OTNFT1dpL1ErTFBYK2Z4L2xyVnJJWHJl?=
 =?utf-8?B?VnEvTWtpUzhEL2grQ0hJT0xiZFJiU1UrZXI1aFRVcFhaUkF5Z2sxdTl3WTZF?=
 =?utf-8?B?S3ZoNjFCUnhwN25nRmtzekVXeFVBMGpsYlI0RU80RFA2MzVlZ3BkZWlHKytD?=
 =?utf-8?B?ck91b3BsR1A1UDhqRyt2MXA3UjJ4Y0x1TWpMMDQwTVVZaWJiRGlVVGp5RjRS?=
 =?utf-8?B?Yy8xT2lMQmFGb2JvNE9tbHBhZlJPeEdVNkZrOVFPYWphdlF6M25rVGwxWHh6?=
 =?utf-8?B?MjA0VVJVRWgwUGFYb1dLekZLRzY5WXBCNE1PTEYwamlpL3d6ZGtOUW5lNDlm?=
 =?utf-8?B?U0RqSDQyS1A4NGFlM3RTalZYVTdEUGJrYzlrTjhIZFZ5RFowamExeGVTQjR1?=
 =?utf-8?B?aTNHRHJQT2xWOG84NTUyV3cvc3lWTUtmYnVZOGlraFJ2aTh6RSthNHIxd2F0?=
 =?utf-8?B?TmZ0VGdWNkFIbXoybmhwRXdXUXZxVFdwNm94L1orYk9qakQ3aXBZd0Ftb3Jm?=
 =?utf-8?B?bDFIWTRjUzM2NlVoRHV6NnE3WWJPcVJMaE13d05SVnVJRU9INVhYYkZpQTZy?=
 =?utf-8?B?UmFuMHZJZWpYdyt6OU9CK1hKbmx1K2l2NmNjZFFBc3UvY29hTHFQMitkZG8r?=
 =?utf-8?B?R2FqZkRBK2ZJd1A2bGZaR2w5QStIMFB0MWcrbGt2ekQrOEVWUC9oK0VuUmJy?=
 =?utf-8?B?QmlwclNYZXd3bytkRUJhV0s4Ly9HemdMV1B6Q3d2cTFoVFNHWGlWWUFkUkN4?=
 =?utf-8?B?amx5Y05oYVNmSG9RZWxxeW1Ldnl3dE5wdEsrYWlmRk1vVnpiNC9FS3hId0JK?=
 =?utf-8?B?enpWQSt4cnBvcjE4SFVrMzFvSGJTNjRYZnZzUFFzYkNhYTBlakt6VzBmeExU?=
 =?utf-8?B?Q0NGT1B0OGN4aklqdTZnd05YZTBoTm9lTTVleFpsb1RHcmdHMjhjbFRKRTZ0?=
 =?utf-8?B?U2M3c2xXMy9NdUM3RGNTc2lJbjZmSnU3ekgrd0ZSWEM4OGRsN1dqeTlmV2h2?=
 =?utf-8?B?U1FlRGVvcUwrUW15NWxJd3QyRWZrWmwxWDNwZUFLYkF6V3JZR3lWekprSlc0?=
 =?utf-8?B?Z3VsSlhwTmZBbkMycjBFTzNndklxbnY5TVJpbkZoeUxkQnBDSVRNRm1LSUt5?=
 =?utf-8?B?Z05hVEtNOUJ2enZJWk0zeVNQUTRCNlliZGJFcEpHNnZlMCtRQUNoMHA2WDBH?=
 =?utf-8?Q?V4LVfMoz2LbW5bElDlWc0i9Yr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482f38fe-cd93-463f-1bf5-08da5e7119f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 10:28:28.5465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/XK90g2fzT0+H/lyCTN70buNzhNOERjBoH5y7jBaoLkNSlhZLA7gtPpwwZoN90MxiEMOjo51U+YZ/6p+HAF0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjLlubQ35pyINeaX
pSAxNzo0OA0KPiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgYXNoaXNoLmt1
bWFyQG54cC5jb207DQo+IHlvZ2VzaGdhdXIuODNAZ21haWwuY29tOyBicm9vbmllQGtlcm5lbC5v
cmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8u
b3JnOyBIYW4gWHUgPGhhbi54dUBueHAuY29tPjsNCj4gc2luZ2gua3VsZGVlcDg3a0BnbWFpbC5j
b207IHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbTsNCj4gcC55YWRhdkB0aS5jb207IG1pY2hh
ZWxAd2FsbGUuY2M7IG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb207DQo+IHJpY2hhcmRAbm9kLmF0
OyB2aWduZXNockB0aS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0KPiBDYzogbGludXgtc3BpQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBmZXN0ZXZhbUBn
bWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IHpoZW5neHVubGlAbXhpYy5jb20udHcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAwNy8xMV0gZHQtYmluZGluZ3M6IHNwaTogc3BpLW54cC1mc3BpOiBh
ZGQgYSBuZXcgcHJvcGVydHkNCj4gbnhwLGZzcGktZGxsLXNsdmRseQ0KPiANCj4gT24gMDUvMDcv
MjAyMiAxMToxMSwgaGFpYm8uY2hlbkBueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IEhhaWJvIENo
ZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBvbmUgb3B0aW9uYWwgcHJvcGVy
dHkgbnhwLGZzcGktZGxsLXNsdmRseQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hl
biA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1ueHAtZnNwaS55YW1sIHwgNiArKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLW54cC1mc3BpLnlhbWwNCj4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1ueHAtZnNwaS55YW1sDQo+
ID4gaW5kZXggMWI1NTJjMjk4Mjc3Li42YmQ2MTU2NTY4NmEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktbnhwLWZzcGkueWFtbA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLW54cC1mc3Bp
LnlhbWwNCj4gPiBAQCAtNDUsNiArNDUsMTIgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgLSBj
b25zdDogZnNwaV9lbg0KPiA+ICAgICAgICAtIGNvbnN0OiBmc3BpDQo+ID4NCj4gPiArICBueHAs
ZnNwaS1kbGwtc2x2ZGx5Og0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVm
aW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBTcGVj
aWZ5IHRoZSBETEwgc2xhdmUgbGluZSBkZWxheSB2YWx1ZS4NCj4gDQo+IFdoYXQgYXJlIHRoZSB1
bml0cz8NCg0KRG8geW91IG1lYW4gaGVyZSBuZWVkIHRvIGdpdmUgbW9yZSBkZXRhaWwgZXhwbGFp
biBhYm91dCB0aGlzIHByb3Blcml0eT8NCg0KSG93IGFib3V0IGNoYW5nZSBsaWtlIHRoaXM/DQog
ICBTcGVjaWZ5IHRoZSBETEwgc2xhdmUgbGluZSBkZWxheSB2YWx1ZS4gVGhlIGRlbGF5IHRhcmdl
dCBmb3Igc2xhdmUgZGVsYXkgbGluZSBpczogKChueHAsZnNwaS1kbGwtc2x2ZGx5KzEpICogMS8z
MiAqIGNsb2NrIGN5Y2xlIG9mIHJlZmVyZW5jZSBjbG9jayAoc2VyaWFsIHJvb3QgY2xvY2spLiBU
aGUgcmFuZ2Ugb2YgdGhpcyB2YWx1ZSBpcyAwfjE2Lg0KDQoNCkJlc3QgUmVnYXJkcw0KSGFpYm8g
Q2hlbg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
