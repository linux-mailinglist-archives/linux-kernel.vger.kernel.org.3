Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485DB4F612F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiDFOF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiDFOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:05:13 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30074.outbound.protection.outlook.com [40.107.3.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F8FFC124;
        Wed,  6 Apr 2022 02:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihgk+FCOxpYg3tw9SO3fhRKoGlu49S0xAlff7DXqnc75HW9qX1ofqXhd7qgvhxAZb2OKIcQVvxmiDTUzWAMge92Pi1n6BJL3F7j8ZVv0aakLbX7e8mCUrkieJDyvaqHAZGvgUIXgxdrn3vY/cdJrAuszrwTItFu8NadRV1UkB6Lu3+eeGIK+wjyn6KAOMWfHsqbP0TV21gz35KDbxzk7HELndy/3tsshC7pExxN7q4h9OYV0ZLemOlHx+hAmcn01n0ubPg7WvRl8mPw9dhOgR92ddzZlrUH87JVDzqFYA7Mzfh13cJHsgTQF3/luxQYkEq2B7SmHZreH8wwxHZJgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcmXDcpJRDNXs9wiUVYYPTCWtxe1xwUUycWaby+1a60=;
 b=IHkbeLO9A7egSaguj1TEDQY0Y51OLguby0njE9KWdMOmllEGkFNUEQfGiTqk6CMwX5xfFi5PXXdbbdeiwCnpcKxPGPciPoY4r7gO0Xh1mZrBKk6Whewq4XyP0Ee0ixAkHvrQCV6WksIP4z34Mr9JHR0HQpieo9jUsYOUbinvAQaCzXN9WRrdSBCQFirDI4wCCx1LCCycKJYFaq46nxmtafbfncGHDYZn7RmFgiHNoIVfRdWI0VLhoGTy9+kl5bT3Do8UPrJj5xjGc5nZAmHjdb8FxWMuPGrFNnMKOw0+mGDAokYRW+DjgFwiHaU7VZGq62RwHWPySnROj4ToSZxjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcmXDcpJRDNXs9wiUVYYPTCWtxe1xwUUycWaby+1a60=;
 b=UdmpSQU6wAAZHRkdE9FQpiaJ9FY9RuFQFBDChSmydFKjRNlT7t7mcVAnGz5EbkY66RuP61kqJxfDxUNZUZ/INb8SwtLkQKB3E5NJSgK/8wHRJYDWriqkc5+SsVp/t+UAPh99BRxsMq78WbEKZB/yotI2J0NOj7cHwomyGvsGYns=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR0402MB2776.eurprd04.prod.outlook.com (2603:10a6:4:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 09:33:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 09:33:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "djakov@kernel.org" <djakov@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] arm64: dts: imx8mp: add noc node
Thread-Topic: [PATCH 2/5] arm64: dts: imx8mp: add noc node
Thread-Index: AQHYSY9dti0eMSm6kU+wdA4kB+NhQKzilY0AgAAJncA=
Date:   Wed, 6 Apr 2022 09:33:29 +0000
Message-ID: <DU0PR04MB941704803BDEA0BD9544F80F88E79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
 <20220406082330.2681591-3-peng.fan@oss.nxp.com>
 <Yk1V9vyyilj9lRY8@pendragon.ideasonboard.com>
In-Reply-To: <Yk1V9vyyilj9lRY8@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf9bb9ca-702f-4099-de3d-08da17b08239
x-ms-traffictypediagnostic: DB6PR0402MB2776:EE_
x-microsoft-antispam-prvs: <DB6PR0402MB2776F70814B7608626963E4F88E79@DB6PR0402MB2776.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92w+ZHsnrnI1wlzy4xZdMd03P6xR3x2QXSPJRA8ky9nzC+23oQu4K8JM1jS0rmJJwhsicJRu4lK1xzuIm0zoHylSVRuxcSc/FzLOPsyoMOl4NXeB//sgS1uBnnI7IPxVp0E4DIy9TeMie0edBIFUAle3o4nuuhI3j2M0sIzQiaHtssTbC7ga6aAHXA1cWM6bmbWv3XEnSPgHk8k6GR1JtVT8HAq0LbqJ2a7+2i4o7oFRVnTujgMVWtCmV9mxUIRVujgEbZExj7UaGhpyyjsXmKbnU89W5B1GSPs/aPvWk61YPe+2h5lENNiNviEmCHoXkwQcAsAr1H1lv+4tFNa5DsRvgG500jOwdYt+iGy1xtbkMqBkpeG/l4EmO8l75imPkfFssUKKD1Jnerz08Ph3Tf7MYN5BxIjImEoqYNjl0QwXj3oJoQ51RbglI3kTrojmYF5FKPbs0iLShW3qQQLyvKPwzdlAGirzSdcC4FxRNU8b9i2DGwR1kyt668pqY5W5h5psPyRMGA5RGe49Btl6Ap5HHkr0IJf5R9D5ATYIeNfgH2W0Qz88SEkMTQCi4tUoZyCc6bHh9BEF1M4IMTBTnVa1o0pXIUscPHh8GiQX9zaiw+DNUX6LI9UB3zbo8awRxGIZHT3JjPTRERqMb8GRmDpyRIHm/vzSTHv8eN5JMCEq1S2AA1Aj9qGDQjjEnI411AxnWM6XNoxYDkRemKuEs2argl1pKWtwwJiRtjpTwjA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(508600001)(64756008)(7696005)(38100700002)(66556008)(5660300002)(122000001)(38070700005)(6506007)(33656002)(66946007)(66446008)(110136005)(4326008)(9686003)(76116006)(55016003)(26005)(8676002)(186003)(7416002)(71200400001)(86362001)(54906003)(316002)(8936002)(83380400001)(52536014)(2906002)(44832011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1NONWRXM1NKV1ljcG10QW5YSjFGeUt0MmtpZEx0ZjJramZtVGRrbjd6ZnpQ?=
 =?utf-8?B?bDlwTWxjNUF2Vk5KTHRhNFlvK2lmdmJLSUlxNVF2dWdnSlNlR21SdXVEcWgr?=
 =?utf-8?B?TjRCeUxGZCtsR3lBU2FseFRFL3IvMmhidWdZUUN4cDcwVVN5ck5DeDRzVk1Y?=
 =?utf-8?B?eVlJUnhrMGZMZ0s1bXBHQ2wvOFl0cTcyNjA3bS9JdFZsTE1HZ1dvZzV4L0hU?=
 =?utf-8?B?eUxGTWF5ZnI2dWhlems2S2lmMnlKTGJuaUVJMWhBRlU2dXlSZ1VPRWt3NzNW?=
 =?utf-8?B?aGtHZ1M4Ni9ob01OZy9zMHd4bFIwbGEzY0I3Q09MRzRDS1lWSS9rSHkrM0Jw?=
 =?utf-8?B?TXlqUG9ubFhOcWtmcGpVeERWZUVVdFZQODMyRHl0Sng1REhIcG1EcjkxSUxk?=
 =?utf-8?B?R0Z4bDdtNHAxZ0tXSGo1dWNNUXlWT2NxVmpFVnV6b1VFTEZnWHdqald4Y0sv?=
 =?utf-8?B?TmxXbk9hT0FKcHFsUVEwcE5qNnpuWHlxT2RWZGZJT2c0NFZqQUlMeUZ2cEY2?=
 =?utf-8?B?ckdlUzZYZG9jdDdsYUV3anZTTGhNdTNjSTNVcW9yaGxWcDF5VHA1dEE0MTEr?=
 =?utf-8?B?UDJHMWNERGpHbjdFWVBMaXFlWUpPeU4rOFRTZDlBaWpTRW53LytRdUJtdEFm?=
 =?utf-8?B?S203VGVwdERjYXpEUFIyTmVIZTY0OTFwMm9LejJzeXorQzRSbVEweEFWTDZV?=
 =?utf-8?B?dnpaSUQzTjlwSUE2MkNGZldWOXgwTGo3SWZlcWRoQURXd0hwOUd5alBJQ2hY?=
 =?utf-8?B?Q3c2eUVuWWo2bFNOWDNDRVppSHA1RG5Tb3o4eDN4dmdxRHVUTGxSUFBwODl2?=
 =?utf-8?B?ZmE1WmZrTFJZQTYvNDlrZzEwM1oycVZYWUI3M25zbFFSV3NvUDZTRTFjeVVs?=
 =?utf-8?B?M3RzdmRrNVJOSy9VSjZtL1djamhVMHRaenU1c0hTWDRKVDlhL0pWN3RkQmMy?=
 =?utf-8?B?RnJJUzJuU2l1MGg3TzJpNDcwYlZBQURPeUM3QmJENkZXajZCSEUxZ2hLSUJH?=
 =?utf-8?B?NXVneTFPNFhlWlh0UlpYbFhYMFpycDhmOUZSY1FMbHRRRWpYTjg3ajYyL20y?=
 =?utf-8?B?U1hoMmRpbUhZUk9DRitpVE1oN0lGNzhSbWJvUndTQzFyejdsblI3RzQ2cGxW?=
 =?utf-8?B?SkdqSGZqenhXVE1vY1lUL205dkhrV25oTzNDY0d6TlkwZUY5MndJUlFsZGww?=
 =?utf-8?B?dUNJSHJXZURMS2RobTZUNTY3cEUxd2doTFNXRkVYaFdtNzJ1SnJZYnI2UHZp?=
 =?utf-8?B?TGxKaVozNmJCemUzZ3krbWpUVm5PbFppZWNVZ2RVMWowdDYzN3NacWlveGI4?=
 =?utf-8?B?Yno4RjJXN2t6ZURaZFNIc1FzaXhsbUp5RWVVWVdaUWU1Z2RYc2diV3lDWGl1?=
 =?utf-8?B?VVFnRUJQT0NhUTFnUWd3cUVrMTVqOUwyaVViVldXSi85bkFTRXJ2emI3V20v?=
 =?utf-8?B?S2R3NStvMFRyR0RBZFRJbjFkZVM2Q0x6TzR3NHY1RXdNandQUXM4TzZtZ3Rh?=
 =?utf-8?B?b3REYjNTL3JHRkMxc01UTDIxYm1EWklVQTRiQ2U0VENGWjY5SWR1dnQ0OC9w?=
 =?utf-8?B?VWhEc040U2pBeUprQlVacmxoTk1OekJLOExDMXZBTmp5eWNoZmZmWUN3RlVk?=
 =?utf-8?B?cXFodmhXN1hNdTZlTmJ5WEJVSUJWbjc3YjdGaVZ5ajl0VkgySUlOOUlvUHds?=
 =?utf-8?B?Q1ZERk9rVVhyZklPSE05Umt1dWRidld3aEdZZEJOTE8zVTdneUMxUHIrQm9v?=
 =?utf-8?B?VTdjL09ieVAzRTFlczZLWkltNm9tUDkzQkRNSkNKZHJaRnNNb3lTUWIwS0xi?=
 =?utf-8?B?RVZxSXZOcEFUeGJ4U05XUTNCcGtzVFZSaE1vZ2pURW1OS3lacTBUZ29lSysr?=
 =?utf-8?B?SFVaZlgwRTJiYWdnSXZFZ1gwNHd3M3VVbVNjWUVIQ2NZSnlNUnVYWHo2TWdD?=
 =?utf-8?B?d3RXUFMya2g5N1ZiYWtORXp6MmFERU9wMTRxWDNmK0RjY0ltcXJWdlJpeG5X?=
 =?utf-8?B?dG9wNHhIdnNLVjlVcTllYTI3R3hBd202ZDZ4clc1a05WNUpqMUxGUnJXazlm?=
 =?utf-8?B?TVN6N0N2ZEsybEt1cGhzK2R4dFZHQTFGMnNMUDNjYW1EN3hFU1lsV1VPSFhS?=
 =?utf-8?B?TDgrN0p6OGcrdjBSWjBYZWpMVlM2aElFZXV3WU1VcURNd2hqaGlLcWhsWFJs?=
 =?utf-8?B?WU5tTVp2OENSOUFpaXZma2l4TlNRSU9XMHY1YnBNc0t4VTErK2liMjRWYzlX?=
 =?utf-8?B?WDhTL1Z0dHhZdFIxNzhtNVdiRHRJem1rMXJkYkZCbWhOdUJSdFlRdFFZOG0x?=
 =?utf-8?B?SVBudTR3RjNpTmxqNHpqNDRBbEVMYXMrdDVTSnpIWjVveTJnV0FwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9bb9ca-702f-4099-de3d-08da17b08239
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 09:33:29.2391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttTvoP1ZD1gjU22smH0Qwcx4Axkwo4X2kPHihBXXuqTdra0gHJrbeDZf5/4GMtijTQMYDAIhX92EUFKXmvOo8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2776
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNV0gYXJtNjQ6IGR0czogaW14OG1wOiBhZGQgbm9jIG5v
ZGUNCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCj4gDQo+
IE9uIFdlZCwgQXByIDA2LCAyMDIyIGF0IDA0OjIzOjI3UE0gKzA4MDAsIFBlbmcgRmFuIChPU1Mp
IHdyb3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4g
QWRkIGkuTVg4TVAgbWFpbiBub2Mgbm9kZQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcC5kdHNpIHwgNyArKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1wLmR0c2kNCj4gPiBpbmRleCBlOWU1NWZkZDc2NTIuLmJlOTAyZjgxNTVlOCAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0K
PiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ID4g
QEAgLTEwMTUsNiArMTAxNSwxMyBAQCBncHUyZDogZ3B1QDM4MDA4MDAwIHsNCj4gPiAgCQkJcG93
ZXItZG9tYWlucyA9IDwmcGdjX2dwdTJkPjsNCj4gPiAgCQl9Ow0KPiA+DQo+ID4gKwkJbm9jOiBp
bnRlcmNvbm5lY3RAMzI3MDAwMDAgew0KPiA+ICsJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXAt
bm9jIiwgImZzbCxpbXg4bS1ub2MiLCAic3lzY29uIjsNCj4gPiArCQkJcmVnID0gPDB4MzI3MDAw
MDAgMHgxMDAwMDA+Ow0KPiANCj4gSSBjYW4ndCBjb21tZW50IG9uIHRoaXMsIGFzIHRoZSBtZW1v
cnkgaXMgZG9jdW1lbnRlZCBhcyByZXNlcnZlZCBpbiB0aGUNCj4gcmVmZXJlbmNlIG1hbnVhbCwg
YnV0IEkgaGF2ZSBubyByZWFzb24gbm90IHRvIHRydXN0IHlvdSA6LSkNCg0KdGhhbmtzLiBTYWRs
eSwgSSBoYXZlIGFza2VkLCBidXQgdGhlIE5vQyBkb2Mgd2lsbCBub3QgYmUgcHVibGljLg0KDQo+
IA0KPiA+ICsJCQljbG9ja3MgPSA8JmNsayBJTVg4TVBfQ0xLX05PQz47DQo+IA0KPiBUaGVyZSdz
IGFsc28gYSBOT0NfV1JBUFBFUiBjbG9jayBkb2N1bWVudGVkIGluIHRoZSByZWZlcmVuY2UgbWFu
dWFsLA0KPiBhbmQgYWxzbyBhIE5PQ19JTyBjbG9jay4gQXJlIHRob3NlIHJlbGF0ZWQsIGRvIHdl
IG5lZWQgdG8gY2FyZSBhYm91dCB0aGVtID8NCg0KVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91
dCwgeWVzLCB3ZSBuZWVkIE5PQ19JTyBjbGsuDQpCdXQgc2luY2UgTk9DIGFuZCBOT0NfSU8gY2xr
IGFyZSBib3RoIGNyaXRpY2FsIGNsaywgSSBub3QgbWV0IGlzc3VlIDopDQoNClRoYW5rcywNClBl
bmcuDQoNCj4gDQo+ID4gKwkJCSNpbnRlcmNvbm5lY3QtY2VsbHMgPSA8MT47DQo+ID4gKwkJfTsN
Cj4gPiArDQo+ID4gIAkJYWlwczQgew0KPiA+ICAJCQljb21wYXRpYmxlID0gImZzbCxhaXBzLWJ1
cyIsICJzaW1wbGUtYnVzIjsNCj4gPiAgCQkJcmVnID0gPDB4MzJjMDAwMDAgMHg0MDAwMDA+Ow0K
PiANCj4gLS0NCj4gUmVnYXJkcywNCj4gDQo+IExhdXJlbnQgUGluY2hhcnQNCg==
