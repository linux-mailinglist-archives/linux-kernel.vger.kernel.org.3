Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6665D58EFC3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiHJPwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiHJPwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:52:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6963961125;
        Wed, 10 Aug 2022 08:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPKz98pOe1q+MkBB+bqpfavhy9ZvuD/nX47icz415FHigOTX2yIqopiGGing/pJ5HJxMeiECenfP/gN3hIjSBQYi5CqdgFEr5Cw93o5/Z1p7mPQGsOLO4uD1E0jw7Eu5zLTTAciWle12QdeWbAY6IXLibjet75qnEvGw+2aR0AHYE/Ma1QYju18iVzOkI37ISyIIrK/na05UDxToU0kC8ZGwaCKGGoEgs5IKTdFAXF0RTuX2H6YR8zQQpAVmDcV65Xkelzq9iaexSnygRaEU0ySED98B5JxpVrF6DkWGonWfsPDnDDFa1+Fnhjj/KkeYHutkmcqQpTnWIBD3fPnFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIPE5SrVkvMzMfmD1hXtDd6PLNUY+OApdeH3i0LUvYw=;
 b=mWGDP9wq1yUOD5qMkExSshw6JwJCAKjlbQEm0Ii1UvVWBqlkh9KOTuuSJMWsbR5KSg1+DeL/5WYARlBtRMrKbXCATzR3XVxQIerBVi+OHagKgB3RNK8d+d4LdDl+/tCh6YU/5aaKaWKDT7zLZvQjbrE/wLEkV2G9wgFsCBbAgwO22roI2mFSP+3lT46mJLJTgVStro+I7M7UrG3iTPQNK5soLvMt0k0POuxAXp4a3MA4Iril66b8tORn6NqjiKeOGWnjy3/Ig/u0cjWgKJ52xgUenv75O0JoHqQi7g3oZ9r1xZVpa8rnTHxYc/7y9BKPssYxAarXmqBRjy23J/VQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIPE5SrVkvMzMfmD1hXtDd6PLNUY+OApdeH3i0LUvYw=;
 b=I78LIG2t8lqqE5E3odgedWPnQAfydENRCawwwJ4MaSdvZT24GKDnSruwyGAjcPqQMDM0Ht6Gs4W7+Mr2wDoSudFgibpUo32l09xahXubixh7qXxEJMVjpiWgDfMrigkuPXp64Ixzceqz9nuqURrw13UGtsyphKNH00wQI7aI4Bk=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM8PR04MB7924.eurprd04.prod.outlook.com (2603:10a6:20b:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 10 Aug
 2022 15:51:48 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 15:51:47 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v3 1/3] dt-bindings: gpio: Add imx scu gpio
 driver bindings
Thread-Topic: [EXT] Re: [PATCH v3 1/3] dt-bindings: gpio: Add imx scu gpio
 driver bindings
Thread-Index: AQHYrL17Pas5Q+nPyEWWoebmGoM+lq2oNm6AgAAHPuCAAAlqAIAAAVqw
Date:   Wed, 10 Aug 2022 15:51:47 +0000
Message-ID: <AM9PR04MB82740649ABFD62C0821D780589659@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220810133005.74653-1-shenwei.wang@nxp.com>
 <20220810133005.74653-2-shenwei.wang@nxp.com>
 <ec6fd9eb-f46d-afa9-b08b-15e202b3a624@linaro.org>
 <AM9PR04MB827495CB596427BD86A1522B89659@AM9PR04MB8274.eurprd04.prod.outlook.com>
 <40ca4f73-aed5-3e2a-7fb6-cd3a2cb74cb9@linaro.org>
In-Reply-To: <40ca4f73-aed5-3e2a-7fb6-cd3a2cb74cb9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba086713-97d2-4888-531e-08da7ae83bb3
x-ms-traffictypediagnostic: AM8PR04MB7924:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VpTjAGOe63NAOk75EgXSAhEOIui2deOU4ObRtzyJgVFQiDigbgfoSbR4++jkINjkHzZwbUcADDyvDbXGXy4dSvT34pIPzi5m6100d0UUfQdIeNa1Ohg764lZDZ9LyDPKcZ6gQOgks5LjY7DYqD5fy5AS9c+z/DJdQ+oqxOvcBV5AVry9Tz0fj6LAKAzO+eL76ocZsrT0ZcnxN2sVlhQMoVF2zMCeP6KcsxgmJ9KUyf5foXZaM+T6oB06f0P62jtG6QstILw8Mjq+Re6THPPOP/jTVW4om8rYJDgSMq5pg+vRHdKggPuK0Nci5hCupIEmrp39qp3mp+o7pJi89yX+hABlcUs43iA1hGIphDlSYGSNKWewem1n4f+J/4k03KPE9oRBytuGU8djUhmpAP2TWoQPGx51x4OgsIIbOyjb9eT4e7dlVaASLqIFrZ0i1l0z1s6gwg/kqAAmEFjlyfr3TdNfj1eKNYMMBO5U8QDPvZPvFgpcnO/upfdiE4Y3Fo+R7pof9KUdM9eQPbfeu4r91gvl7AWaQ9Uys43bIEotd47Bvuw9yaMfvSmeWkvQ4u71uA29zVWuYTUes16owcP9DZRYKZAkbe05FiDeCgi5VIBMguSN3FGdBUFAcXH5YQfPaNSVMcxzkhtCUqbl1rCkXDefZQcQpCq5TSbTWpsOHBw/g0/ZUNM+xgfX4UipGr1us0ETbZcoO8Y5jQIIWZTHymTKW4rVM7BFMDixzfj2y18PVp89WR0eJNUqfCIE5bkzwR2q4A7wpJxFcMTIqxI7wmVCmk5OSibXFPnlKfiLlIYWUNrkROeuOX6BtBygo0BfY05jF5c8FEn+jFjGuPhZSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(122000001)(53546011)(55236004)(186003)(83380400001)(921005)(38100700002)(5660300002)(44832011)(52536014)(7416002)(8936002)(76116006)(66946007)(66556008)(66476007)(9686003)(66446008)(64756008)(4326008)(55016003)(2906002)(478600001)(8676002)(71200400001)(6506007)(26005)(54906003)(6636002)(316002)(41300700001)(33656002)(110136005)(86362001)(7696005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG43SFJPdEhodXA5cjZlZTVkbGxQMWtWWHJPaVB2a1hzTlIvTk5DWHJXOGlF?=
 =?utf-8?B?eHhWZ2NBR2swS2FqNGNyLzB3RkRnSHBOMXFkNDFuVFJNRmUraG9jQlFvd25w?=
 =?utf-8?B?eCtmcXgxaFhNQi9IdnJ6UHY0aERKWHRxbitybHFaTXRvQ1lXZ2RKcndvVG1h?=
 =?utf-8?B?V3c4cVJTV0dGTXdaU1lYbEFsa1A5Y1BHQVZNYlVjcnhleFRXNjBjdlN5VS9x?=
 =?utf-8?B?R0lGOHYwOWY0NVptcS9nemJGVnl2RElrYTNyRUpjK1ZvTWZNQnBtVlZ0ajlN?=
 =?utf-8?B?QVVPdEhRdlNtVjZJdkxLQjRhV2xqbWtya0NLTElNOC9tY0o4TTdhUS9uWmhT?=
 =?utf-8?B?WDc2eitYUldYdmZyL3p5OVVhWDhkYzJPazhhQmh5ZkJBSERMajlvTE5zRUFx?=
 =?utf-8?B?alV0Nm5xS3FEV1RPdWdLcUQyR0F1Rm9tMUt6YkhOanFHdkZSOEJFcmo5T3pw?=
 =?utf-8?B?SmtVd2NPYVlwbnE0RFQrblFTbHlJSWl4Yi8wNUZERWRPbnNsRGRpeUdZUWJm?=
 =?utf-8?B?OEZiWExaeHFqRUYySlN2Y1laakNPY3lMajBVRlVtQlFIY1NWV3RpNytqRENB?=
 =?utf-8?B?STdsM3VReURnRFVlbWN5TzNuV01DVXVWd1F6ZFV0YnNQNE9Kb0ZnblZlVlA5?=
 =?utf-8?B?TzZnR2I4aVJnMVVWR2Y1VlBMWE0rUC9VbUtuSmN1QVl5WXFVbEVHbE40UXpr?=
 =?utf-8?B?VlhWVkhJN3ZBRVhKbWwvakFmUUt2OXRrcW1kdnFPLzVNcUsrenQ1dzJFSGEx?=
 =?utf-8?B?NGU4RnJIK1N0NTlLRXM1Ui9yVWpWNlJnaU52ME41UnVSamV1aFYwMWhta05M?=
 =?utf-8?B?NThCTkUrS2xHS3JiUFcxVnBlTjJSYS9uc1l0aWhkY2EwSXRBdWxoOWpvVktH?=
 =?utf-8?B?MG1FL1NIUVRPbWt0bVFMTnJYOTlzVExHU0Z0bGRwckVXK1pzYUtrM1B3U21x?=
 =?utf-8?B?ZmpsUWt2dU1wN3BNZWpjS3dFbDFzK0VuTWlya01wS0djNFhRakJoWWhFNzBk?=
 =?utf-8?B?SmcvYzA1ZnBkZlVkZnJxbHVKMnVRakUwL1pXZnR0U29weGE2M282cys0SDlp?=
 =?utf-8?B?MThpSGUvZVlrMlROYW80QUp0UFVvaFh2TnZpd3ZzS2FEYXBtRVpqYnR6cW4x?=
 =?utf-8?B?c1JvRkpGVGtWbzdaOHpWbllCRUZkWGtuaFkzK3FhRWZRRlY4Q0Z1RURCeGNI?=
 =?utf-8?B?UmkyemFycnVqbVZnbnFENWptMDJvdHlENys5UEVub00xT21ibExDVnpMcDds?=
 =?utf-8?B?aktXbkFhZzBnaFNCaEw0U1E5ek1PRHl0aFZkc254dC9sTEdMSlZmVFpoZFo2?=
 =?utf-8?B?aHhmY2NYeHZJczU1N1NIZlUwZFQ2U1JIL1lPWU55dGZVdkVMMUVxWnhQOUlw?=
 =?utf-8?B?ckUvMkprRzhRcmtTaytvZkpsaWFCeDhtNGkwcjNhQ1hjVWhTZTVVN1o2N1Z3?=
 =?utf-8?B?MzdpdTZkWWViUlRiY1FHZVkwbEViNEgyMmpnZjE5dGZuS2pzTEJJYkVrZmhv?=
 =?utf-8?B?aVdMSGZ0cGYwM1I4dzJqTFBiWmlEZVFRbEZZN2V5N3B3Q2lXd0tldUZaZ2lB?=
 =?utf-8?B?QmovOXBacDJLci96OFkvbDVVSTQ4ZVBrTlF3Ym11empFVFZSUEVrOGx3ekRw?=
 =?utf-8?B?T0E1b2Q2OTVRQ1NNZDNoVnkyZWxxUXp3QzAzQUFRc1h6UkpWZ05xUGI3ZGUx?=
 =?utf-8?B?WDA5Y3hLMnNqZEUyWEZuSjY5UU9oTjJwZVlBUU5mZSt4RkhYbjlaYzhkQVgz?=
 =?utf-8?B?QnpFMFR4UC8zeUNZTUcvVklPaWxBZnBFUThDdjlMcWpod1J3TUNaZXJWZm5t?=
 =?utf-8?B?WlFBcmFCVzNaVXNaNGluOG1Fb0JMa2JWeTJHbjNQOVdxUTllMHVUK2tieThQ?=
 =?utf-8?B?SE9HSnhtNnByUkRJb0J6QklHTjNPekZjOVB1TVd6eWtHdjZyTWV3VE9EN01q?=
 =?utf-8?B?R3VmOGt1RGcvVTlSbWhRaW9Zb1RMRnVDWXgzQ2dWVEpOUGlxc2lDbFV3dWtl?=
 =?utf-8?B?dGMwMFZCZGpEcnFFMjQ4NEVNZENKU2FSUys4TXZWeFdwODR1Y1FqRGdYeDNK?=
 =?utf-8?B?R2RycHlyK3RkRFgxOXFRdllWdGZ1N1lhd3J0L2k4STYvYlUybmRzQ2gwR0dD?=
 =?utf-8?Q?iHpI6n/tGs69BVgcq4tt2bnxa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba086713-97d2-4888-531e-08da7ae83bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 15:51:47.8487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSccvmL3zQWOF2TI7JRIE+7cCU/3VjW7hJah6vbcq810pjXCX4pKcoFJHx3mAgKqZlD2nGiI/hywjcx7CNPMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7924
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEF1Z3VzdCAxMCwgMjAyMiAxMDo0NiBBTQ0KPiBUbzogU2hlbndlaSBXYW5nIDxzaGVud2VpLndh
bmdAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStk
dEBsaW5hcm8ub3JnOyBsaW51cy53YWxsZWlqQGxpbmFyby5vcmc7IGJyZ2xAYmdkZXYucGw7DQo+
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlt
eEBueHAuY29tPg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBncGlvQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1
YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYzIDEvM10gZHQtYmluZGluZ3M6IGdwaW86IEFk
ZCBpbXggc2N1IGdwaW8gZHJpdmVyDQo+IGJpbmRpbmdzDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1h
aWwNCj4gDQo+IE9uIDEwLzA4LzIwMjIgMTg6MjMsIFNoZW53ZWkgV2FuZyB3cm90ZToNCj4gPg0K
PiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRv
ZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDog
V2VkbmVzZGF5LCBBdWd1c3QgMTAsIDIwMjIgOTo0NiBBTQ0KPiA+PiBUbzogU2hlbndlaSBXYW5n
IDxzaGVud2VpLndhbmdAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gPj4ga3J6eXN6
dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBsaW51cy53YWxsZWlqQGxpbmFyby5vcmc7DQo+
ID4+IGJyZ2xAYmdkZXYucGw7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7DQo+ID4+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBk
bC1saW51eC1pbXgNCj4gPj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiA+PiBDYzogZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiA+PiBncGlvQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiA+PiBpbXhAbGlzdHMubGludXguZGV2DQo+ID4+IFN1YmplY3Q6IFtFWFRdIFJl
OiBbUEFUQ0ggdjMgMS8zXSBkdC1iaW5kaW5nczogZ3BpbzogQWRkIGlteCBzY3UgZ3Bpbw0KPiA+
PiBkcml2ZXIgYmluZGluZ3MNCj4gPj4NCj4gPj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+ID4+DQo+
ID4+IE9uIDEwLzA4LzIwMjIgMTY6MzAsIFNoZW53ZWkgV2FuZyB3cm90ZToNCj4gPj4+IEFkZCBi
aW5kaW5nIGRvY3VtZW50IGZvciB0aGUgaW14IHNjdSBncGlvIGRyaXZlci4NCj4gPj4+DQo+ID4+
PiBTaWduZWQtb2ZmLWJ5OiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0BueHAuY29tPg0KPiA+
Pj4gLS0tDQo+ID4+PiAgLi4uL2JpbmRpbmdzL2dwaW8vZnNsLGlteC1zYy1ncGlvLnlhbWwgICAg
ICAgIHwgNDAgKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4gK3Byb3BlcnRpZXM6DQo+ID4+PiAr
ICBjb21wYXRpYmxlOg0KPiA+Pj4gKyAgICBlbnVtOg0KPiA+Pj4gKyAgICAgIC0gZnNsLGlteDhx
eHAtc2MtZ3Bpbw0KPiA+Pj4gKyAgICAgIC0gZnNsLGlteC1zY3UtZ3Bpbw0KPiA+Pg0KPiA+Pg0K
PiA+PiBUaGlzIGlzIHRvbyBnZW5lcmljIGNvbXBhdGlibGUgYW5kIGl0IGV2ZW4gY29uZmxpY3Rz
IHdpdGggdGhlIGFib3ZlLi4uDQo+ID4+IFlvdXIgZHJpdmVyIGJpbmRzIHRvIGJvdGggd2l0aG91
dCBkcml2ZXIgZGF0YSB3aGljaCBpcyBldmVuIG1vcmUgY29uZnVzaW5nLg0KPiA+PiBNYWtlIHRo
ZSBjb21wYXRpYmxlIHNwZWNpZmljIGZvciBvbmUsIGdpdmVuIFNvQy4NCj4gPj4NCj4gPg0KPiA+
IE9oLCB0aGF0J3MgbXkgYmFkLiBJdCBpcyBhIHR5cG8uIFRoZSBnZW5lcmljIGNvbXBhdGlibGUg
c2hvdWxkIGJlICJmc2wsaW14LXNjLQ0KPiBncGlvIi4NCj4gPiBTbyBmYXIgdGhlcmUgaXMgbm8g
ZHJpdmVyIGRhdGEgcmVxdWlyZWQgZm9yIGJvdGggaW14OHF4cCBhbmQgaW14OGR4bCwNCj4gPiBi
dXQgaXQgbWlnaHQgYmUgcmVxdWlyZWQgc29tZXRpbWVzIGxhdGVyIGluIGNhc2UgdGhlIHNjdSBm
aXJtd2FyZSBpcw0KPiBjdXN0b21pemVkIGZvciBhIHNwZWNpZmllZCB1c2UgY2FzZS4NCj4gPiBU
aGF0J3Mgd2h5IEkgcHV0IHRoZSBnZW5lcmljIG9uZSBoZXJlLg0KPiANCj4gVGhhdCdzIG5vdCBh
IHByb3BlciByZWFzb24gdG8gYWRkIGdlbmVyaWMgb25lLiBFaXRoZXIgYWxsIGltcGxlbWVudGF0
aW9ucyBhcmUNCj4gY29tcGF0aWJsZSBvciBub3QuIElmIHlvdSBhcmUgdW5zdXJlLCB0aGlzIHNo
b3VsZCBiZSBhc3N1bWVkIGFzIG5vdCBhbmQganVzdCB1c2UNCj4gc3BlY2lmaWMgY29tcGF0aWJs
ZS4gSWYgeW91IGFyZSAxMDAlIHN1cmUsIHRoZW4gdXNlIGZhbGxiYWNrLCBub3QgdHdvDQo+IGNv
bXBhdGlibGVzLCBhbmQgcHJvcGVybHkganVzdGlmeSBpdC4NCj4gDQoNCk9rYXkuIEkgd2lsbCBv
bmx5IGtlZXAgImZzbCxpbXg4cXhwLXNjLWdwaW8iIGZvciBub3cuDQoNClRoYW5rcywNClNoZW53
ZWkNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
