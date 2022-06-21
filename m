Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71AB55350D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351955AbiFUO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349807AbiFUO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:57:02 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130070.outbound.protection.outlook.com [40.107.13.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD9927CF9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3JM0h9ukCbMPwuVsRheZHw+XaOJ0HwEvW9VDrXz8uwxUN+2dIh8FcEWS7Tups77nk5g05SrKbbTeDORte5x3chtz4pD4M2h/78w6UoaK2nwXlYqmvTz4d5Ysmdusznv6nJrd/+CiOqc84uefKBQXFc7X0kG+bp9/DIhWwPfJWdghP4Z/cMj/sU20CzzN6o5HtjnRVRbYiF0rMB63YV0Gxm2Ccez3J3WrjCjyj6WlB6wpBybxqbomHMF3yd9yOQ003OhjIeCHoyxgvgxg+R4nsm6WG7zDVncpwv3PtfLzWPASWRsRR5SMrjmsguTWzNNJbpyFPc0yI2JC07AjFav/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sTVEzKxS2aRvraVnX0nO5zDxl3X2bi54htC1O8xvKA=;
 b=KwF3q+TqQUH1WVj57kjinySVdk8zuEjTYw1v99cXwvRJnlq64HB5myLNNhFjFGUEsxFjhCXAATAO46akxirRY8txU+6yQJl024v+5t0vplBI3k5ChlWEVZQJG1R/zrvVm206HwVsOQ6LX2aO8bGs/oiuv/EgbOTpYSPOpahBAs469GqC4C8xfklUpNXEtaVnodKIo+wWx1ON3nQEVrzUjKa1JQHQ/hYcWnYcLLkpsWbB4Fz6HFLwmcHiILTdnkC7NhGbjicKFj+Zo63tbJNUsh0hWdutTeRo2gOom1h9ZKm9bA9cD/tmNcDEfjxNJJRk+jGeHOcFwwHmDXT5X/ObJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sTVEzKxS2aRvraVnX0nO5zDxl3X2bi54htC1O8xvKA=;
 b=amf/w5I6wVYMV6EJYa/1dqrpS5pQGZBYAixefNTouQK6NOc4WSXov0iTqXFiWjz6DvISboVHnGkp4W+3Hser2lOxdU2dXfsBhg0GK1VEu09YbePGiH0G+4ggJkYN6L4dvppPrQADVWv0hCQ00I9o5y9+lzBgU8xkPI+CWkWLyLI=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DB8PR04MB7178.eurprd04.prod.outlook.com (2603:10a6:10:12e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 14:56:58 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 14:56:58 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH RFC 1/2] regmap: add option to disable debugfs
Thread-Topic: [PATCH RFC 1/2] regmap: add option to disable debugfs
Thread-Index: AQHYhKwihmmQwo9gZ0uCTra8XCwz/61YZSEAgAAK2aCAAAFvAIAABRJAgAAc5ICAAVTlsA==
Date:   Tue, 21 Jun 2022 14:56:58 +0000
Message-ID: <DB9PR04MB847785E1861525FC1E4AD97280B39@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
 <20220620134758.1286480-2-aisheng.dong@nxp.com>
 <YrCM0reni+x/KWsG@sirena.org.uk>
 <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCXILblKsp6DuN3@sirena.org.uk>
 <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCznap77OyHu4bO@sirena.org.uk>
In-Reply-To: <YrCznap77OyHu4bO@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b419c44-ac72-4dc7-f62c-08da53964a65
x-ms-traffictypediagnostic: DB8PR04MB7178:EE_
x-microsoft-antispam-prvs: <DB8PR04MB7178F54F59D45430357DE4BC80B39@DB8PR04MB7178.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJXR0DXPdW5vMW7PhqE6NFFapxK37j90NgiFHe3MBfeeuXHVyMdAREOXqYSAU3BmJxYqEzPzrk6tQnh+aBr6XBetV8Ey0LUBD9oXxP/Jot1L8x4PQxImjhIGSPuPYHzZ65E5cdJzotZUbBJYnPbGwMJWxiw5Stca+tiWV6hMbv9qNJEIdg6/I+D4BvCWI3BBKyvsCdpDVm7RhGrrfbpUdEvBc6/LA+TXMPZYtki13Rywppqg4kk3m/t3JVGxQbZ3PsKKe1Jk77DXoqbjLYl0zcpyPLtqOvUP9nzYys7yMApK8TS/dW81kH/1fo20JVhJjBhb7GNyzMsY5ly1L6/8xqz/yu6HIdbk//JP51G2Noaf0KNcFh5YH170MxIooLlynuURZmfyZfUSLTBLKvWihltD5ek22USA5FDFhCb0yvQx777cjTFEcE9sISox5efQ1K5IQddZr+LWnFvkiQ7fGX628gyjq0BOBYs1tjBTYUcqMUCUVnIpQ43EyY0NnHR1nFeeVmgLGOr8omg1LZfOPDWPRr49PRMALjayap1R4eSNNeNNdzJouGtgQawSa3DDQ9kvTyX7o9Ut52h0IGTObYVgZc8d8/3dr/sopaihg0ePq6jejNt9wXow9Idow2BEBsaD/rLBd3p085yqRk1cABsQZ4QnSIl0+/Jd/79Qy8kTmj/BwMvgcSttV+/CxEjG/akF+DHnSzViGexpm7R5rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(6916009)(44832011)(5660300002)(33656002)(38100700002)(41300700001)(7696005)(2906002)(8936002)(26005)(122000001)(9686003)(86362001)(8676002)(38070700005)(4326008)(83380400001)(76116006)(6506007)(66946007)(66476007)(66556008)(55016003)(64756008)(316002)(478600001)(52536014)(71200400001)(186003)(66446008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2NDejB3SnpVcmVSZm83STBuWXpCdzdGWk04OGdNZkt5ZldKTHc2MGttcTIy?=
 =?utf-8?B?UHlvUHVQVXVjY3FPdlhicm04UG1NZCswR1ZHRVJIb3BlSlR0aGNCd2NrUi9B?=
 =?utf-8?B?THhjK2x4bXY2TE1qeDhEcEtMN2Q3TzJDRUovQ0lhQWU1ZWphMUtIRHBqMkts?=
 =?utf-8?B?V3pFMzdQaGRGQ0VOTHduQmZ6YTFZdUZXdmcxWmMrakZCQUtjR1BMQlhmbGpz?=
 =?utf-8?B?U3ozcmVOWml0MTIxdlljTS9VdU85cGQ1dmlCMWlBY1BwLzBzZVlNUllFbHR6?=
 =?utf-8?B?V3dNVjBvMUkyNUFmYUxYRUxjcVdUS2pEelI5TjNsUEZFcUMwK3RjR1R4Yk9a?=
 =?utf-8?B?amFPRU91NEtYZlYyNHM5ZHlwc0RlZnhZSFlrNmRVQzJncTZ5VjUwTTVoSG5G?=
 =?utf-8?B?bldCekdHTjNzRi9tV2ZqeE5BVlhxNVJUZ010YzFaVHhrUVY1RHJGM3dPTnJx?=
 =?utf-8?B?RnNNRFMzRy8xMldyNnlHM2FSUHZGMGtNOVoyZWtyS3dNTkVpTmxrK2huTVE0?=
 =?utf-8?B?WElwYmw4Mms2bzRDUysrZEJFblo2bmRGOUVrRTZNVjFwck4wYUFvZ0xiZytR?=
 =?utf-8?B?aHd2Z2pWM1QzZFBTQllvNlM0RVU1cnlUcGxjUk5ZNlVDUis2OWU3WG1GRk40?=
 =?utf-8?B?cmN6VS9Vc0xHRmRvaHlkMVJZWG5QVlM1clA3bnNxVVo1cHNxUGRxUXNTT0RY?=
 =?utf-8?B?dnAvZStRd1FlUGlWZFV3QzlYM05jYlA0ckJYQWF6WDJXNFZiTmt4K3pGL0lM?=
 =?utf-8?B?SmRzYTRPTWdxQ0JoRXpnVWlUTFBVQllDYzNTWTMrUjBvYklubVk0NGdPS0JU?=
 =?utf-8?B?SkR2VzIrdUs2Njl2Z0RCejNmYlh2Q3BHOGJCZHhkbmlTOWhNZDJiUFdSN3Q2?=
 =?utf-8?B?aTlkcnBKVFBPMXJPRmFtTDUzUVdVdTJHek5QeGQ2bTdMckROUTgvOCtIMjZB?=
 =?utf-8?B?M3dZcitEaXlualYyQ3BjbHNaVkErL3MzZXhudVpFVnFUTjJ3ZEIrS3BvNFJu?=
 =?utf-8?B?bTJUTmdxamRKZGVHa2V3Y04vbm93cmk0a1RjZGltK3A2cXFYRmVvYWlkRXEv?=
 =?utf-8?B?RGdJelQyVlpUWnlodVVKTC9ZSHRyUnVxZG9RNVJsWXNXQkVHaXNtVGMvdWh1?=
 =?utf-8?B?bjZ0K01MbXpQbUE4SjRzbFBkNzdDaGVSZzV6RytERmVoRW5QV1FLZGJyb1NO?=
 =?utf-8?B?ZDZFOFRVNHBvT0Ztd09FK1E3b0dpSXJSdEtTZ3RES3JPVmJLNjkyZDBEYUJj?=
 =?utf-8?B?YzZ3d0NaR0d1eWZZM2xId0RNNms0L0RKa0xxZEo0dTJKVktyY2MrYXpDdVRW?=
 =?utf-8?B?WUFpakRvdGErSndjWjlHeDMvZ280SWZZcjh6MlFlOEhqeGdVcG5Hck5DTXFr?=
 =?utf-8?B?ZklMeUxpYVhvYjZBbmI0ZGRvRDRtK1loTm8yU1M1SGhQajdXT0ZDdGUvL1RB?=
 =?utf-8?B?ZlpTL1RKYk5DS3NWcUNpbXZQc3llc1U1S2d5OGlhOEFWTW40aVVYNHhvSUtm?=
 =?utf-8?B?RUNoOG9HNWNPK3duSXVaVzhKZUNhUUR2dGdCSmRhSTRXMFlvUzloeEF4OG9I?=
 =?utf-8?B?T2lEWmJHOWdQekJyNzZEdDdaR1d5L0RkWllGSE4rdnBBN0tmeGxJb0pkd0p1?=
 =?utf-8?B?clJadkNidmlLdnpnTHpGZWR5V1hyUSt1aWhIQnFMUXpqNm8vMEs0QjRMa0wx?=
 =?utf-8?B?M1ZzNjYrck1TU3hCc29NdVYwNG1ROG1SVGlxdkpjendzbWhWRHNhbm1ONzBj?=
 =?utf-8?B?SE9uMXZzdVh3TE1KUUo2THZ0aUt1VmsvVlZ4NCtWTWh5SVgyWXpOMDdqWEc0?=
 =?utf-8?B?T1Z3d2RVNllhb2NqZS9DVXdaVmFBMEhVaWR6M0NiR1ByVitKdVJwS3VLVW53?=
 =?utf-8?B?RWRmejYvTTRhQUg3NjdXN3ZISG5XZmN0cVBHelJoQzl0U0J5TkhlK0ora2Y5?=
 =?utf-8?B?NXFaYWwrMG1CNDdKb0lVcWJiSmx0ZU45RXRRQmhWSmVVYkZjMll4dmNhOTNL?=
 =?utf-8?B?VFFabXNQNkp6T1RyV2FtODlsK0pDNVBVREh6YmhTSDB4K2lwZW9UVlBHMXA0?=
 =?utf-8?B?dEpJVlhiRWxRa0dpVi8xTEgydUh6K0tWNUE2ZW55dkhIQTcxUXkyME1DVjd5?=
 =?utf-8?B?MDBmS3ZTRWpRa2szT09VTnpUM2F6Q1VNZVd5SkdPblBHUndtYjB1S2lSb3Fz?=
 =?utf-8?B?dkpqTVU2OFl4V2dlOHVqWG9zWEprSWR0aER6bnBobjBUdHljR3I4MitrRzNB?=
 =?utf-8?B?UVdWbVBJd05SUHZQaWdmcHcvTmhlck5JNXpXbzhrWmV4ams0MFNOQnRDaFlC?=
 =?utf-8?B?Skx0ZDU4RjhIVldQU2FFTjk3OG5wekl2N2x2c2ZmUnBkS3NsQnVVQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b419c44-ac72-4dc7-f62c-08da53964a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 14:56:58.4273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hf/GcqWSzFfrdGlS9eRdilsbWD/z3Tq5FbeWNilYVKgBpCPrLPEjqNMVrhTbccSPPmnVdqP7GLgebmS99+Z1ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXks
IEp1bmUgMjEsIDIwMjIgMTo1MSBBTQ0KPiANCj4gT24gTW9uLCBKdW4gMjAsIDIwMjIgYXQgMDQ6
MTU6NDBQTSArMDAwMCwgQWlzaGVuZyBEb25nIHdyb3RlOg0KPiANCj4gPiA+IFRoZSBkcml2ZXIg
aXMgZ29pbmcgdG8gbmVlZCB0byBwb3dlciB0aGUgZGV2aWNlIGJhY2sgdXAgdG8gYWNjZXNzDQo+
ID4gPiB0aGUgdm9sYXRpbGUgcmVnaXN0ZXJzIHNvIGl0IGNhbiB0YWtlIHRoZSBkZXZpY2Ugb3V0
IG9mIGNhY2hlIG9ubHkNCj4gPiA+IG1vZGUgd2hlbiBpdCdzIGRvaW5nIHRoYXQgY2FuJ3QgaXQ/
DQo+IA0KPiA+IFNvcnJ5LCBJIGRpZG4ndCBxdWl0ZSBnZXQgaXQuDQo+ID4gVGhlcmUncyBubyBw
cm9ibGVtIGluIGRyaXZlciB0byBhY2Nlc3Mgdm9sYXRpbGUgcmVnaXN0ZXJzIGFzIGl0DQo+ID4g
dXN1YWxseSB3aWxsIHBvd2VyIHVwIGRldmljZSBmaXJzdCBieSBycG0uDQo+IA0KPiBTbyB0aGUg
cnVudGltZSBwb3dlciBtYW5hZ21lbnQgc2VlbXMgbGlrZSBhIGdvb2QgcGxhY2UgdG8gbWFuYWdl
IGNhY2hlDQo+IG9ubHkgbW9kZS4NCj4gDQo+ID4gQnV0IGZvciBkZWJ1Z2ZzLCBmcm9tIHdoYXQg
SSBzYXcgaW4gY29kZSwgaWYgdGhlcmUncyBhIHZvbGF0aWxlDQo+ID4gcmVnaXN0ZXIsIF9yZWdt
YXBfcmVhZCgpIHdpbGwgYnlwYXNzIGNhY2hlIGFuZCB0cnkgdG8gcmVhZCB0aGUgcmVnaXN0ZXIg
dmFsdWUNCj4gZnJvbSBIVy4NCj4gPiBUaGVuIHN5c3RlbSBtYXkgaGFuZyBhcyBubyBvbmUgcG93
ZXJlZCB1cCB0aGUgZGV2aWNlIGJlZm9yZS4NCj4gPiBBbnl0aGluZyBJIG1pc3NlZD8NCj4gDQo+
ID4gc3RhdGljIGludCBfcmVnbWFwX3JlYWQoc3RydWN0IHJlZ21hcCAqbWFwLCB1bnNpZ25lZCBp
bnQgcmVnLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCAqdmFsKSB7
DQo+ID4gICAgICAgICBpbnQgcmV0Ow0KPiA+ICAgICAgICAgdm9pZCAqY29udGV4dCA9IF9yZWdt
YXBfbWFwX2dldF9jb250ZXh0KG1hcCk7DQo+ID4NCj4gPiAgICAgICAgIGlmICghbWFwLT5jYWNo
ZV9ieXBhc3MpIHsNCj4gPiAgICAgICAgICAgICAgICAgcmV0ID0gcmVnY2FjaGVfcmVhZChtYXAs
IHJlZywgdmFsKTsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKHJldCA9PSAwKQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gICAg
ICAgICByZXQgPSBtYXAtPnJlZ19yZWFkKGNvbnRleHQsIHJlZywgdmFsKTsNCj4gDQo+IFRoYXQn
cyBub3Qgd2hhdCB0aGUgY29kZSBpcyB1cHN0cmVhbSwgdXBzdHJlYW0gYmV0d2VlbiB0aGUgY2Fj
aGVfYnlwYXNzDQo+IGNoZWNrIGFuZCB0aGUgcmVnX3JlYWQgd2UgaGF2ZQ0KPiANCj4gCWlmICht
YXAtPmNhY2hlX29ubHkpDQo+IAkJcmV0dXJuIC1FQlVTWTsNCj4gDQo+IAlpZiAoIXJlZ21hcF9y
ZWFkYWJsZShtYXAsIHJlZykpDQo+IAkJcmV0dXJuIC1FSU87DQo+IA0KDQpZZXMsIEkgcmVtb3Zl
ZCB0aGVtIGR1cmluZyBjb3B5JnBhc3RlIGZvciBhIG1vcmUgY2xlYW4gY29kZSBiZWZvcmUuDQoN
Cj4gc28gaWYgd2UgY2FuJ3Qgc2F0aXNmeSB0aGUgcmVhZCBmcm9tIHRoZSBjYWNoZSB0aGVuIHdl
J2xsIGhpdCB0aGUgY2FjaGVfb25seQ0KPiBjaGVjayBhbmQgcmV0dXJuIC1FQlVTWSBiZWZvcmUg
d2Ugc3RhcnQgdHJ5aW5nIHRvIGRvIGFueSBwaHlzaWNhbCBJL08uICBUaGUNCj4gZGVidWdmcyBj
b2RlIHdpbGwgaGFuZGxlIHRoYXQgZ3JhY2VmdWxseSwgaW5kaWNhdGluZyB0aGF0IGl0IGNvdWxk
bid0IGdldCBhIHZhbHVlDQo+IGZvciB0aGUgdm9sYXRpbGUgcmVnaXN0ZXIgYnkgc2hvd2luZyBh
bGwgWHMgZm9yIHRoZSB2YWx1ZS4gIElmIG5vbmUgb2YgdGhlIHJlZ2lzdGVycw0KPiBhcmUgY2Fj
aGVkIHRoZW4gdGhlIGZpbGUgd29uJ3QgYmUgdGVycmlibHkgdXNlZnVsIGJ1dCBpdCBhdCBsZWFz
dCBzaG91bGRuJ3QgY2F1c2UNCj4gYW55IGVycm9ycyB3aXRoIGFjY2Vzc2luZyB0aGUgZGV2aWNl
IHdoZW4gaXQncyBwb3dlcmVkIGRvd24uDQo+IA0KDQpUaGF0IG1lYW5zIHdlIGhhdmUgdG8gdXNl
IGNhY2hlX29ubHkgbW9kZSB0byB3b3JrYXJvdW5kIHRoZSBpc3N1ZSwgcmlnaHQ/DQpJIHNhdyB0
aGF0IGNhY2hlX29ubHkgbW9kZSBoYXMgdG8gYmUgZXhwbGljYXRlZCBlbmFibGUvZGlzYWJsZSBi
eSBkcml2ZXIsDQpjb21tb25seSB1c2VkIGluIGRldmljZSBycG0gaW4ga2VybmVsIHJpZ2h0IG5v
dy4NCg0KSG93ZXZlciwgdGhpbmdzIGFyZSBhIGxpdHRsZSBiaXQgY29tcGxpY2F0ZWQgb24gaS5N
WCB0aGF0IDEpIGlteCBibGtjdGwNCm5lZWRzIGZvbGxvdyBzdHJpY3QgcmVnaXN0ZXJzIHIvdyBm
bG93IGludGVybGVhdmVkIHdpdGggaGFuZHNoYWtlcyB3aXRoIHVwc3RyZWFtIGdwYw0KcG93ZXIg
b3BlcmF0aW9ucyBhbmQgZGVsYXkgbWF5IGJlIG5lZWRlZCBiZXR3ZWVuIHJlZ2lzdGVycyB3cml0
aW5nDQoyKSBibGtjdGwgaXRzZWxmIGRvZXMgbm90IGVuYWJsZSBydW50aW1lIHBtLCBpdCBzaW1w
bHkgY2FsbCBycG0gdG8gcmVzdW1lIHVwc3RyZWFtIHBvd2VyDQpkb21haW5zIGRldmljZXMgYW5k
IG5lY2Vzc2FyeSBjbG9ja3MgYmVmb3JlIHIvdyByZWdpc3RlcnMuDQoNCkZ1cnRoZXJtb3JlLCBj
dXJyZW50IGlteCBibGtjdGwgaXMgYSBjb21tb24gZHJpdmVyIHVzZWQgYnkgbWFueSBkZXZpY2Vz
IFsxXS4NCkludHJvZHVjaW5nIHZvbGF0aWxlIHJlZ2lzdGVycyBhbmQgY2FjaGUgbWF5IGJsb2F0
IHRoZSBkcml2ZXIgYSBsb3QgdW5uZWNlc3NhcmlseS4NCg0KVGhlIHNpbXBsZXN0IHdheSBmb3Ig
aS5NWCBjYXNlIG1heSBiZSBqdXN0IGRpc2FibGluZyBkZWJ1Z2ZzIGFzIGl0IGNhbid0IHJlZmxl
Y3QgdGhlIGFjdHVhbGx5DQpIVyBzdGF0ZSB3aXRob3V0IHBvd2VyLiBTbyB3ZSB3b3VsZCB3aXNo
IHRoZSByZWdtYXAgY29yZSBjb3VsZCBwcm92aWRlIGFuIG9wdGlvbiB0byB1c2Vycy4NCg0KQW5k
IEkgbm90aWNlZCB0aGF0IHN5c2NvbiBbMl0gc2VlbXMgaGF2ZSB0aGUgc2FtZSBpc3N1ZSBzaW5j
ZSB0aGUgZm9sbG93aW5nIGNvbW1pdDoNCg0KY29tbWl0IDliOTQ3YTEzZTdmNjAxN2YxODQ3MGY2
NjU5OTJkYmFlMjY3ODUyYjMNCkF1dGhvcjogRGF2aWQgTGVjaG5lciA8ZGF2aWRAbGVjaG5vbG9n
eS5jb20+DQpEYXRlOiAgIE1vbiBGZWIgMTkgMTU6NDM6MDIgMjAxOCAtMDYwMA0KDQogICAgcmVn
bWFwOiB1c2UgZGVidWdmcyBldmVuIHdoZW4gbm8gZGV2aWNlDQoNCiAgICBUaGlzIHJlZ2lzdGVy
cyByZWdtYXBzIHdpdGggZGVidWdmcyBldmVuIHdoZW4gdGhleSBkbyBub3QgaGF2ZSBhbg0KICAg
IGFzc29jaWF0ZWQgZGV2aWNlLiBGb3IgZXhhbXBsZSwgdGhpcyBpcyBjb21tb24gZm9yIHN5c2Nv
biByZWdtYXBzLg0KDQogICAgU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGF2aWRAbGVj
aG5vbG9neS5jb20+DQogICAgU2lnbmVkLW9mZi1ieTogTWFyayBCcm93biA8YnJvb25pZUBrZXJu
ZWwub3JnPg0KDQoNCjEuIGRyaXZlcnMvc29jL2lteC9pbXg4bS1ibGstY3RybC5jDQoyLiBkcml2
ZXJzL21mZC9zeXNjb24uYw0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gPiBPciB5b3UgbWVhbiBz
aW1wbHkgZm9yZ2V0dGluZyBhYm91dCB2b2xhdGlsZSByZWdpc3RlcnMgYW5kIGxldCBkZWJ1Z2Zz
DQo+ID4gdG8gcmVhZCB0aGUgc3RhbGUgdmFsdWUgZnJvbSBjYWNoZT8NCj4gDQo+IFdlIHNob3Vs
ZG4ndCBjYWNoZSBhbnl0aGluZyBmb3Igdm9sYXRpbGUgcmVnaXN0ZXJzLCBpZiB3ZSBhcmUgdGhl
biB0aGF0J3MgYW4NCj4gaXNzdWUuDQo=
