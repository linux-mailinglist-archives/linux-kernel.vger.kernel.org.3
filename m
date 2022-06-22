Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8471554844
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbiFVITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242231AbiFVIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:18:57 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130047.outbound.protection.outlook.com [40.107.13.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4996438185
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsJBjgo2c8TFjaRrlH2csy2E5kVlTVIL2V7lxFuSbt/Ta2my2cKzl4azhqrXiCujxr2333jCZuRXTKP/aQl/xPPepLiihYlZCyzirWfXI/aBkziKjq+Xh9WVBNuDnxEeSGP8DXwC1rWo0eOCBKOjcNw3uHmkV8+zKmTyWYrz4zfKJ4Cp98rwFywFAY4Io2D9WPmNR4E8dp9ctG+x5R+0emPCLbbtieJFKgyER0j7efh6S0RIe/VIRsO7LhyEWh/EkH0NwRoK+2ttLlp29imCXQd/9/QsdNk/DDcr32iDOvutL/2D/uh76GQYxDemxKOgKxDxBQCuoiCGozKJC4z3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fne2subBxTuLOGaE8lk33BxMNiuJDDPMQsgDs8EVQvo=;
 b=EUQD60RhMxhfaBxsDCas12LtDZkKgV4K9HZvv2Fldu6WWSnLCwEuzn/cbs+rQ/SMG4dOtO5VZlcbDvdT3ADeWNitwPrQrb5vaFVdH56zFBUf3EQWaH6RdR2LzQdz55D3jE1R4ND44NSJG3F08gq/q7A807Tb0sGhZ/T0ylzndg0H3alJAH51ARewWT1nKc565yX1YV6D2RkF+Ojgw7jw8SXXuhFTpaYGHuc7J/GX6q4UKm9+Lag8p0B5Ha6qrAWDD6Fsee8jUzsC7lyatkL5sHNjb82EQ0ensKvhuYa1nDGfeCj/PZyYwrs1TAfM/M502jOC0KL8LM0zwpFxKRoLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fne2subBxTuLOGaE8lk33BxMNiuJDDPMQsgDs8EVQvo=;
 b=H0QMQIYxYlRkM4mj6yIa4/d/NwmnN3jBMsFDc8dfGEIMhPuv/xKzbXOYmNcndphsszYq4Z/icOfRVpcpYTxnoGkxrjKL/ipUfFVIGT6LfYWEROMLSGgqvqv5GcJUgHngn2YGbvYo+iL/OeDH++JHTofbNWmNodW4QuiaAaM8hEw=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by PAXPR04MB9491.eurprd04.prod.outlook.com (2603:10a6:102:2c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 08:18:53 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72%7]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 08:18:53 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH RFC 1/2] regmap: add option to disable debugfs
Thread-Topic: [PATCH RFC 1/2] regmap: add option to disable debugfs
Thread-Index: AQHYhKwihmmQwo9gZ0uCTra8XCwz/61YZSEAgAAK2aCAAAFvAIAABRJAgAAc5ICAAVTlsIAAFmQAgAAqm0CAAOvRAIAAAeag
Date:   Wed, 22 Jun 2022 08:18:52 +0000
Message-ID: <DB9PR04MB8477E77D4F6C8F7886418FD180B29@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
         <20220620134758.1286480-2-aisheng.dong@nxp.com>
         <YrCM0reni+x/KWsG@sirena.org.uk>
         <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
         <YrCXILblKsp6DuN3@sirena.org.uk>
         <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
         <YrCznap77OyHu4bO@sirena.org.uk>
         <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
         <YrHkXH1M4NydBfQT@sirena.org.uk>
         <DB9PR04MB84772F73D4AA1B49F87BECCF80B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <abbc4d80377dcf5393afa143f9d3542cd2cd45a7.camel@pengutronix.de>
In-Reply-To: <abbc4d80377dcf5393afa143f9d3542cd2cd45a7.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93886b4b-c47c-4d19-8587-08da5427d7ef
x-ms-traffictypediagnostic: PAXPR04MB9491:EE_
x-microsoft-antispam-prvs: <PAXPR04MB94912E3B2AE5C059CFEBCEA780B29@PAXPR04MB9491.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6NsfhhJHFJY87IAczPRhjRvLVWagLLjU0l1sTNYsVdiLVnZgokF1QXVrucBO4c+Sb+3AceGsw8xpegYw22nu+VjdUGeDCszJynJJyRmP10qgrY8twywzRDKvfNDFNpdrpOsKDSmK8QGWm75qb7/Ik3d1rfe+5lq97M+lyde+dVTHy0AKVsUUDI5ILEGzMNSsNcAy0BQCTUy+OOOLBZBFSG+YqcN1daPYY8xL2gOYQczqE6vAwBDynRDd0XLBlPuO9zBL9oUpRIfOQNMqGQ0worMapwFpVA+srIk0HGfknQN/k8cT28XdfMdjksXO10C5oKrzM6qSAWvFU2norv++VCuISick9TrjC8ez6oOfSti/njDWYAgmPwCiWuoP1OQmOp8kXl7yVAJ/nyJdWlbaQzQx93xb0r1UM7KpPEW7N7ZfAY8FSwhQccfUrt1kJrJM9megBUvXIgW1di3VIOpmKFLGDRg9a6BmegwgUb1lpCHEZnDGn5E3gN9Kxlt9d2yiZyuptb1QRfFt1AgUcPOqFj0pKF8XZ3vHEKc6UusLgA4UsE12sIrcR2QegnpqgRVy9TrSFogLiRs9+NqOQZHtAXfTllSPE5ei/ouGsEm3n/ZUVHdt57r0rgr2sM0fK6uJd9PpArI+u9FlGZzDfnpP5iFSiMIs6gaFxSWSdiKXKI56jIzBGOUdnyuvColonvJ4f/DaDmxx0x8R0HRKi3jGDwUqSiJcqqKJBeQrEN9RunuBCFh7FD2dLWXRzcm1y0POB14PBiZDdIejyXKUiS2IsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(83380400001)(478600001)(86362001)(41300700001)(71200400001)(55016003)(9686003)(186003)(33656002)(2906002)(5660300002)(316002)(54906003)(52536014)(26005)(44832011)(8936002)(66556008)(7696005)(122000001)(64756008)(6506007)(8676002)(38070700005)(110136005)(66446008)(4326008)(66476007)(76116006)(38100700002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qnc2QUNuYVdFR1lKU1BNOUFKdnkyNmYrKzVHUmVndERzeU51WU94a0VuT1Fs?=
 =?utf-8?B?RUhudVB5U0crZmpXSWVmd2ZZSGtvMFNEQ2JkOUZzZFRnWUYyK3NTOWdwYXNS?=
 =?utf-8?B?THhEWThmZTY1eUxHbzFMc0JhN210cisyci9BMUJIY0E5RzNZOUYvVFFvR1Qz?=
 =?utf-8?B?UUZZMHRTZ293TnQzd0JLaXdkZmpqNXlxc2E4WDdTbGNnNEpGR0p5WWNEUm5w?=
 =?utf-8?B?NG1NdlNJWW1QdmtncWRGSm16b01FNm1aMTBTMDBqTDdSTEdKUWF6Qm16OG95?=
 =?utf-8?B?MnJqOTNoTHdBMlVSNjRhMUE4K0xqYUhkRm9sWjN2K0JMZFNrSlBOeUxrZjBQ?=
 =?utf-8?B?WXUyNXJycldrNUZ4ZW5ma2pnV1lXSVQ1bER4YzUrS2FHc2xtNW0xWjdrTms0?=
 =?utf-8?B?Vm1jOEpJSC9OakcxLzY1d2w2YkRNWEt2RElMb2kwdGUzSURtRDlZc2FhNm5L?=
 =?utf-8?B?N2Y5NUhLOGNoc1lUTGhDSE1jTG9YYVMwSzRobW9LZ3JteFFpRjVoc1Jja2s1?=
 =?utf-8?B?alN3a0hETjVJWGwyRXkvUjd1Nlk0RENTaGlpZUhUdE1VTUY0TXBuY0UvalBz?=
 =?utf-8?B?bmUwVjZrcHFwalp5RmZ2emt2VHQ2NWR3Nm4vR05qcGJzSGl2a3I0Vmh3bXFz?=
 =?utf-8?B?T3ZGdlBNSG5RcEpFNiswNERZUklkellQbWVocTVQQjZkUnV2R2pqZGxJUC90?=
 =?utf-8?B?S0FQd2dhajN2UG54WW1EVm9SaWVWenBvbEdRZG4yYnhaNW42UFBOODRwRXJT?=
 =?utf-8?B?MDlpaXBtcnJxTmRFeENVMndwdFJIbTc4V29kUEtCUnZvOHBvTFBCQm16L3kw?=
 =?utf-8?B?azAvZkd5M0JTRzJidWE4Y3hybWFybWdObmNpZGhydERXN3laaXBCQ0VFOWY1?=
 =?utf-8?B?OU1ESWFxd3JNQlJwS0hBS0MvN093K2ZGZFcwMG1DNWVaU3k5RjZvSXpySGdJ?=
 =?utf-8?B?UUF4NXZ6azVGbTRiM3E3YmU2MFdzb1lNL0xLWk0xWFZWRTM3clRROVNrU3N1?=
 =?utf-8?B?YUM2Mm1LWmJxTTRPMUhlbmw5TUxMQ3AzUFYxS2V3REhtbkQ2L1lrL1NhVWRY?=
 =?utf-8?B?dmZrZnNvTUJVc0x1UXF5dlpNQ1BVZ0ZjazdwajYyN2tLbUFwWkovY3NTcWR1?=
 =?utf-8?B?YWsxMjBVdlRHMnVhTW4wSVkzcUhsRzFCVHBpMDh0WHFCRlRvUHNTUkkzWUdN?=
 =?utf-8?B?RWQ4RS9GNUhvNGJ1NUc5US9FS2FXWTk3M3lCVjlhZHIwU2cvYThlNkY1N1ND?=
 =?utf-8?B?aVZlWEZTR25rVWZneHlQbjIyeFM3VU1qS2t4Z3hmN2RvWDJ1M0lFdldxVzJh?=
 =?utf-8?B?d2RCWjJvdzBZeDNjQmQ0ZWtjRFV1U0hJMzNzMG9mQ0c2ZEdmbDlTbmVmS0hV?=
 =?utf-8?B?WVU3Nm1ZdkRJRnpRUFBza05lalRJOHEvTU9ZVDdKZ1FPaUNtYzVQcWNpL1dP?=
 =?utf-8?B?TEMzTHlIdGxub09iY2s1SW42MXZac25VLzBBRTRoU0w1VlBCS3RDaE45VWZ0?=
 =?utf-8?B?QnoxRUdORWorNjN1YjhpOVlsN21kZTA1NnhvZUl4dlpGcmE5TWJOWm56QmlU?=
 =?utf-8?B?d2pRRlFaQU1hcUtFSVpBUFFXRDk1UjVNOTlzczBFbXhsYWFWS2xFMXdZeWMy?=
 =?utf-8?B?RWpqYVdaWjN0cE5DQmVjMHlMWkxQR3pzZ2RVdjFCZ3BoUmR0eEtaY1NwNmV4?=
 =?utf-8?B?SUVDbDZsbjRBVGI1azlPSDFqWGFJTG8vZzl3dHpiQ0JKcFgxdFVxWVoweXN2?=
 =?utf-8?B?NFBHYWlqVm5CWldrZEs2bUdkbkdvOFlweEh6akZMVUUxQjI3VTYrZ0NyZE5G?=
 =?utf-8?B?K284L00rSmp0QzdBOGZkRyt3aTBCb0ZGdmFuT3VjcTZaOVd4Z2FmYUNUOFZX?=
 =?utf-8?B?NU83M0lSU2Q4N2dkbm5jTCtGNVB1UEhTR2tURGN4VklENnpYUWJncmlJWUNn?=
 =?utf-8?B?UTVSK2hhbXRBV3dudUFYNWtFWE1QbjBvaWFVNjk0QWI2cVArVkNjeUpXVmFo?=
 =?utf-8?B?TXBTTVBBYjJBc1BEWmNaRzJFNlJCVHR5VjN2OVAwRUdVV2Yva0pBeVA5L1d6?=
 =?utf-8?B?MjF3b2dHWms4SlEwL3pkZmZNWHF6REFlSTI5VE0zK3NKWHNINTZmTW1qOEl4?=
 =?utf-8?B?TlJldE1LNHBWWTRKYjljcGhjR1FhUEZESmhJUFNtRWttTWkyYkpJVld2a1Fk?=
 =?utf-8?B?aE1ZL2pIYlNVNTE2QmRnMjJDWFNxSVp6S2VoUGxZa1lqeDgxTEtvWE9veFBQ?=
 =?utf-8?B?TlNWMFp3cDU3Q1BiMTRuZWlvc2ErUHRoWHlRWU9Qd08zTGNXMUduOGFTVWZm?=
 =?utf-8?B?YVZsM0hlRHBrNGhzRTkvMTZsK0p5alFYdm16OURyTWVSY294cVdPdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93886b4b-c47c-4d19-8587-08da5427d7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 08:18:52.9134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Z8fgL+VzmIdUdemw3fL0rBItXo5zEirFCbd4rUHYqUT4nr/iXBzav4Gt1kjUE4/tohCXTr98wBqJmkbUZ6Otw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBKdW5lIDIyLCAyMDIyIDQ6MDggUE0NCj4gDQo+IEhpIEFpc2hlbmcsIGhpIE1hcmss
DQo+IA0KPiBBbSBEaWVuc3RhZywgZGVtIDIxLjA2LjIwMjIgdW0gMTg6MTYgKzAwMDAgc2Nocmll
YiBBaXNoZW5nIERvbmc6DQo+ID4gPiBGcm9tOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5v
cmc+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBKdW5lIDIxLCAyMDIyIDExOjMyIFBNDQo+ID4gPg0K
PiA+ID4gT24gVHVlLCBKdW4gMjEsIDIwMjIgYXQgMDI6NTY6NThQTSArMDAwMCwgQWlzaGVuZyBE
b25nIHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gPiBzbyBpZiB3ZSBjYW4ndCBzYXRpc2Z5IHRoZSBy
ZWFkIGZyb20gdGhlIGNhY2hlIHRoZW4gd2UnbGwgaGl0DQo+ID4gPiA+ID4gdGhlIGNhY2hlX29u
bHkgY2hlY2sgYW5kIHJldHVybiAtRUJVU1kgYmVmb3JlIHdlIHN0YXJ0IHRyeWluZyB0bw0KPiA+
ID4gPiA+IGRvIGFueSBwaHlzaWNhbCBJL08uICBUaGUgZGVidWdmcyBjb2RlIHdpbGwgaGFuZGxl
IHRoYXQNCj4gPiA+ID4gPiBncmFjZWZ1bGx5LCBpbmRpY2F0aW5nIHRoYXQgaXQgY291bGRuJ3Qg
Z2V0IGEgdmFsdWUgZm9yIHRoZQ0KPiA+ID4gPiA+IHZvbGF0aWxlIHJlZ2lzdGVyIGJ5IHNob3dp
bmcgYWxsIFhzIGZvciB0aGUgdmFsdWUuICBJZiBub25lIG9mDQo+ID4gPiA+ID4gdGhlIHJlZ2lz
dGVycyBhcmUgY2FjaGVkIHRoZW4gdGhlIGZpbGUgd29uJ3QgYmUgdGVycmlibHkgdXNlZnVsDQo+
ID4gPiA+ID4gYnV0IGl0IGF0IGxlYXN0IHNob3VsZG4ndCBjYXVzZSBhbnkNCj4gPiA+IGVycm9y
cyB3aXRoIGFjY2Vzc2luZyB0aGUgZGV2aWNlIHdoZW4gaXQncyBwb3dlcmVkIGRvd24uDQo+ID4g
Pg0KPiA+ID4gPiBUaGF0IG1lYW5zIHdlIGhhdmUgdG8gdXNlIGNhY2hlX29ubHkgbW9kZSB0byB3
b3JrYXJvdW5kIHRoZSBpc3N1ZSwNCj4gPiA+ID4gcmlnaHQ/DQo+ID4gPiA+IEkgc2F3IHRoYXQg
Y2FjaGVfb25seSBtb2RlIGhhcyB0byBiZSBleHBsaWNhdGVkIGVuYWJsZS9kaXNhYmxlIGJ5DQo+
ID4gPiA+IGRyaXZlciwgY29tbW9ubHkgdXNlZCBpbiBkZXZpY2UgcnBtIGluIGtlcm5lbCByaWdo
dCBub3cuDQo+ID4gPg0KPiA+ID4gWWVzLg0KPiA+ID4NCj4gPiA+ID4gSG93ZXZlciwgdGhpbmdz
IGFyZSBhIGxpdHRsZSBiaXQgY29tcGxpY2F0ZWQgb24gaS5NWCB0aGF0IDEpIGlteA0KPiA+ID4g
PiBibGtjdGwgbmVlZHMgZm9sbG93IHN0cmljdCByZWdpc3RlcnMgci93IGZsb3cgaW50ZXJsZWF2
ZWQgd2l0aA0KPiA+ID4gPiBoYW5kc2hha2VzIHdpdGggdXBzdHJlYW0gZ3BjIHBvd2VyIG9wZXJh
dGlvbnMgYW5kIGRlbGF5IG1heSBiZQ0KPiA+ID4gPiBuZWVkZWQgYmV0d2VlbiByZWdpc3RlcnMg
d3JpdGluZw0KPiA+ID4gPiAyKSBibGtjdGwgaXRzZWxmIGRvZXMgbm90IGVuYWJsZSBydW50aW1l
IHBtLCBpdCBzaW1wbHkgY2FsbCBycG0gdG8NCj4gPiA+ID4gcmVzdW1lIHVwc3RyZWFtIHBvd2Vy
IGRvbWFpbnMgZGV2aWNlcyBhbmQgbmVjZXNzYXJ5IGNsb2NrcyBiZWZvcmUNCj4gPiA+ID4gci93
DQo+ID4gPiByZWdpc3RlcnMuDQo+ID4gPg0KPiA+ID4gSSdtIG5vdCBzdXJlIEkgZnVsbHkgdW5k
ZXJzdGFuZCB0aGUgaXNzdWUgaGVyZT8gIElmIHRoZSBkcml2ZXIgY2FuDQo+ID4gPiBzYWZlbHkg
bWFuYWdlIHRoZSBoYXJkd2FyZSBzdXJlbHkgaXQgY2FuIHNhZmVseSBtYW5hZ2UgY2FjaGUgb25s
eQ0KPiA+ID4gbW9kZSB0b28/ICBJZiB0aGVyZSBhcmUgZHVwbGljYXRlIHJlc3VtZXMgdGhlbiBj
YWNoZSBvbmx5DQo+ID4gPiBlbmFibGUvZGlzYWJsZSBpcyBhIGJvb2xlYW4gZmxhZyByYXRoZXIg
dGhhbiByZWZjb3VudGVkIHNvIHRoYXQNCj4gPiA+IHNob3VsZG4ndCBiZSBhIHByb2JsZW0uDQo+
ID4gPg0KPiA+DQo+ID4gSSBzdGlsbCBjYW4ndCBzZWUgYW4gZWFzeSBhbmQgc2FmZSB0byB3YXkg
dG8gZG8gaXQuDQo+ID4gV2hhdCBJJ20gd29uZGVyaW5nIGlzIHdoZXRoZXIgaXQncyB3b3J0aCB0
byBkbyBpdCBpZiBuZWVkIHRvDQo+ID4gaW50cm9kdWNpbmcgY29uc2lkZXJhYmxlIGNvbXBsZXhp
dGllcyBpbiBkcml2ZXIgdG8gb3ZlcmNvbWUgdGhpcyBpc3N1ZQ0KPiA+IGlmIGl0IGNhbiBiZSBz
aW1wbHkgZGlzYWJsZWQuDQo+ID4gQW55d2F5LCBJIHdpbGwgdHJ5IHRvIGludmVzdGlnYXRlIGl0
Lg0KPiA+DQo+ID4gPiA+IEZ1cnRoZXJtb3JlLCBjdXJyZW50IGlteCBibGtjdGwgaXMgYSBjb21t
b24gZHJpdmVyIHVzZWQgYnkgbWFueQ0KPiA+ID4gPiBkZXZpY2VzDQo+ID4gPiBbMV0uDQo+ID4g
PiA+IEludHJvZHVjaW5nIHZvbGF0aWxlIHJlZ2lzdGVycyBhbmQgY2FjaGUgbWF5IGJsb2F0IHRo
ZSBkcml2ZXIgYQ0KPiA+ID4gPiBsb3QNCj4gPiA+IHVubmVjZXNzYXJpbHkuDQo+ID4gPg0KPiA+
ID4gWW91IGRvbid0IGFjdHVhbGx5IG5lZWQgdG8gaGF2ZSBhIGNhY2hlIHRvIHVzZSBjYWNoZSBv
bmx5IG1vZGUsIGlmDQo+ID4gPiB0aGVyZSBhcmUgbm8gY2FjaGVkIHJlZ2lzdGVycyB0aGVuIHlv
dSdsbCBqdXN0IGdldCAtRUJVU1kgb24gYW55DQo+ID4gPiBhY2Nlc3MgdG8gdGhlIHJlZ2lzdGVy
cyBidXQgdGhhdCdzIGhvcGVmdWxseSBmaW5lIHNpbmNlIGF0IHRoZQ0KPiA+ID4gbWludXRlIHRo
aW5ncyB3aWxsIGp1c3QgZmFsbCBvdmVyIGFueXdheS4NCj4gPiA+IFlvdSBzaG91bGRuJ3QgZXZl
biBuZWVkIHRvIGZsYWcgcmVnaXN0ZXJzIGFzIHZvbGF0aWxlIGlmIHRoZXJlJ3Mgbm8NCj4gPiA+
IGNhY2hlIHNpbmNlIGl0J3Mgbm90IHJlYWxseSByZWxldmFudCB3aXRob3V0IGEgY2FjaGUuDQo+
ID4gPg0KPiA+DQo+ID4gQWZ0ZXIgYSBxdWljayB0cnkgaW5pdGlhbGx5LCBJIGZvdW5kIHR3byBp
c3N1ZXM6DQo+ID4gMS4gVGhlcmUncyBhIHdhcm5pbmcgZHVtcCBpZiB1c2luZyBjYWNoZV9vbmx5
IHdpdGhvdXQgY2FjaGUgdm9pZA0KPiA+IHJlZ2NhY2hlX2NhY2hlX29ubHkoc3RydWN0IHJlZ21h
cCAqbWFwLCBib29sIGVuYWJsZSkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqBtYXAtPmxvY2sobWFw
LT5sb2NrX2FyZyk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoFdBUk5fT04obWFwLT5jYWNoZV9ieXBh
c3MgJiYgZW5hYmxlKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgLi4uDQo+ID4gfQ0KPiA+IDIuIEl0
IHNlZW1zIF9yZWdtYXBfd3JpdGUoKSBkaWQgbm90IGhhbmRsZSBjYWNoZV9vbmx5IGNhc2Ugd2Vs
bA0KPiA+IHdpdGhvdXQgY2FjaGUuDQo+ID4gSXQgbWF5IHN0aWxsIHdyaXRlcyBIVyBldmVuIGZv
ciBjYWNoZV9vbmx5IG1vZGU/DQo+ID4NCj4gPiBJIGd1ZXNzIHdlIG1heSBuZWVkIGZpeCB0aG9z
ZSB0d28gaXNzdWVzIGZpcnN0IGJlZm9yZSB3ZSBjYW4gc2FmZWx5DQo+ID4gdXNlIGl0Pw0KPiA+
DQo+IFdoeSB3b3VsZCB5b3Ugd3JpdGUgdG8gYSBjYWNoZSBvbmx5IHJlZ21hcC4gVGhlIGRlYnVn
ZnMgaW50ZXJmYWNlIG9ubHkNCj4gYWxsb3dzIHRvIGR1bXAgdGhlIHJlZ2lzdGVycywgbm8/DQoN
CkkgbWVhbiB0aGUgX3JlZ21hcF93cml0ZSgpIGNhbGxlZCBpbiBkcml2ZXIgZXZlbiB3ZSBjbGFp
bSBpdCdzIGNhY2hlIG9ubHkuDQpOb3QgZHVtcGluZyByZWdpc3RlcnMgZnJvbSBkZWJ1Z2ZzLg0K
DQo+IA0KPiBJIHRoaW5rIGl0IHdvdWxkbid0IGJlIHRvbyBoYXJkIHRvIGZpeCB0aGlzIGZvciB0
aGUgYmxrLWN0cmwgZHJpdmVycy4NCj4gSSdsbCBnaXZlIGl0IGEgdHJ5IHRvZGF5Lg0KPiANCg0K
R3JlYXQsIGxvb2tpbmcgZm9yd2FyZCB0byBzZWUgaXQuDQoNCj4gPiA+ID4gVGhlIHNpbXBsZXN0
IHdheSBmb3IgaS5NWCBjYXNlIG1heSBiZSBqdXN0IGRpc2FibGluZyBkZWJ1Z2ZzIGFzIGl0DQo+
ID4gPiA+IGNhbid0IHJlZmxlY3QgdGhlIGFjdHVhbGx5IEhXIHN0YXRlIHdpdGhvdXQgcG93ZXIu
IFNvIHdlIHdvdWxkDQo+ID4gPiA+IHdpc2ggdGhlDQo+ID4gPiByZWdtYXAgY29yZSBjb3VsZCBw
cm92aWRlIGFuIG9wdGlvbiB0byB1c2Vycy4NCj4gPiA+DQo+ID4gPiBUaGUgZ29hbCBoZXJlIGlz
IHRvIGRlc2NyaWJlIHRoZSByZWdtYXAgaXRzZWxmIHNvIHRoYXQgdGhlcmUncyBsZXNzDQo+ID4g
PiBmcmFnaWxpdHkgYXMgdGhpbmdzIGNoYW5nZSBhbmQgd2UgZG9uJ3QgbmVlZGxlc3NseSBkaXNh
YmxlIGFueXRoaW5nDQo+ID4gPiBlbHNlIHRoYXQgaGFwcGVucyB0byBiZSBhZGRlZCB0byBkZWJ1
Z2ZzIGluIHRoZSBmdXR1cmUgZHVlIHRvIGhhdmluZw0KPiA+ID4gYW4gb3Zlcmx5IGdlbmVyaWMg
ZmxhZywgYW5kIHdlIGdldCB0aGUgYWJpbGl0eSB0byBkaXJlY3RseSBjYXRjaA0KPiA+ID4gYWNj
ZXNzIHRvIHRoZSBoYXJkd2FyZSB0aGF0IG1pc3NlcyBkb2luZyBwb3dlciBtYW5hZ2VtZW50IHBy
b3Blcmx5DQo+ID4gPiB3aGlsZSB3ZSdyZSBhdCBpdC4NCj4gPiA+DQo+ID4gPiBXZSBhbHJlYWR5
IGhhdmUgYSB3YXkgdG8gZGVzY3JpYmUgaXQgYmVpbmcgdW5zYWZlIHRvIGFjY2VzcyB0aGUNCj4g
PiA+IGhhcmR3YXJlLCB3ZSBtYXkgYXMgd2VsbCB1c2UgaXQuDQo+ID4gPg0KPiA+ID4gPiBBbmQg
SSBub3RpY2VkIHRoYXQgc3lzY29uIFsyXSBzZWVtcyBoYXZlIHRoZSBzYW1lIGlzc3VlIHNpbmNl
IHRoZQ0KPiA+ID4gPiBmb2xsb3dpbmcNCj4gPiA+IGNvbW1pdDoNCj4gPiA+DQo+ID4gPiA+IGNv
bW1pdCA5Yjk0N2ExM2U3ZjYwMTdmMTg0NzBmNjY1OTkyZGJhZTI2Nzg1MmIzDQo+ID4gPiA+IEF1
dGhvcjogRGF2aWQgTGVjaG5lciA8ZGF2aWRAbGVjaG5vbG9neS5jb20+DQo+ID4gPiA+IERhdGU6
ICAgTW9uIEZlYiAxOSAxNTo0MzowMiAyMDE4IC0wNjAwDQo+ID4gPg0KPiA+ID4gPiDCoMKgwqDC
oHJlZ21hcDogdXNlIGRlYnVnZnMgZXZlbiB3aGVuIG5vIGRldmljZQ0KPiA+ID4NCj4gPiA+ID4g
wqDCoMKgwqBUaGlzIHJlZ2lzdGVycyByZWdtYXBzIHdpdGggZGVidWdmcyBldmVuIHdoZW4gdGhl
eSBkbyBub3QgaGF2ZQ0KPiA+ID4gPiBhbg0KPiA+ID4gPiDCoMKgwqDCoGFzc29jaWF0ZWQgZGV2
aWNlLiBGb3IgZXhhbXBsZSwgdGhpcyBpcyBjb21tb24gZm9yIHN5c2Nvbg0KPiA+ID4gPiByZWdt
YXBzLg0KPiA+ID4NCj4gPiA+IFRoYXQncyBhIGRpZmZlcmVudCB0aGluZywgdGhhdCdzIGR1ZSB0
byB1cyBuYW1pbmcgdGhlIGRpcmVjdG9yeQ0KPiA+ID4gYWZ0ZXIgdGhlIHN0cnVjdCBkZXZpY2Ug
YnV0IHN5c2NvbnMgYmVpbmcgY3JlYXRlZCBiZWZvcmUgd2UgaGF2ZQ0KPiA+ID4gdGhhdCBzdHJ1
Y3QgZGV2aWNlIGF2YWlsYWJsZS4NCj4gPg0KPiA+IFllcywgYnV0IHN5c2NvbiBoYXMgdGhlIHNh
bWUgaXNzdWUgdGhhdCB0aGUgc3lzdGVtIG1heSBoYW5nIGlmIGR1bXANCj4gPiByZWdpc3RlcnMg
dGhyb3VnaCBkZWJ1Z2ZzIHdpdGhvdXQgcG93ZXIgb24uDQo+ID4gSG93IHdvdWxkIHlvdSBzdWdn
ZXN0IGZvciB0aGlzIGNhc2UgYXMgc3lzY29uIGlzIGFsc28gYSBjb21tb24gZHJpdmVyPw0KPiA+
DQo+IFRoaXMgaXMgYSBnZW5lcmFsIGlzc3VlLiBJZiBzb21ldGhpbmcgdXNlcyBhIHN5c2NvbiB0
aGF0IGlzIGluc2lkZSBhDQo+IHBvd2VyLWRvbWFpbiB3aGVyZSB0aGUgcnVudGltZSBQTSBpcyBj
b250cm9sbGVkIGJ5IHNvbWUgb3RoZXIgZW50aXR5LCBob3cNCj4gaXMgaXQgc2FmZSB0byB1c2Ug
dGhlIHN5c2NvbiBhdCBhbGw/IEV2ZXJ5IGFjY2VzcyBtaWdodCBlbmQgdXAgbG9ja2luZyB1cCB0
aGUNCj4gc3lzdGVtLiBTbyB0aG9zZSBzeXNjb25zIHJlYWxseSBuZWVkIHRvIGxlYXJuIHNvbWUg
a2luZCBvZiBydW50aW1lIFBNDQo+IGhhbmRsaW5nLg0KDQpUaGUgcmVnbWFwIGNvcmUgZG9lcyBu
b3Qgc3VwcG9ydCBydW50aW1lIHBtLg0KSXQgbWF5IGJlIHVuc2FmZSB0byBkdW1waW5nIHJlZ2lz
dGVycyB0aHJvdWdoIGRlYnVnZnMuDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiANCj4gUmVnYXJk
cywNCj4gTHVjYXMNCj4gDQoNCg==
