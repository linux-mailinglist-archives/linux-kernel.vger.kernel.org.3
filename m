Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41F8498837
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245185AbiAXSWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:22:46 -0500
Received: from mail-eopbgr80117.outbound.protection.outlook.com ([40.107.8.117]:48885
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241782AbiAXSWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:22:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhqF6jHplVaE31kGgRy907mbdowX7l3IUNGxo17FMP2dYy+WGnacd40bdCsbGVWN4MXFBntgfhi3Ca+eYC3BGbqMzWwGfaBmiFTzIzcXtlaVfoi8iWSzj40xroKK6ps+63lGcmcDfgwrKjdor8ZyM/fa2WGFt96IW6S0Cl4wv0xMMPDN4KKA/m/lZI/bW3AsrXTwBJl2INviM/A7VJSMphJuhZPnwDewwmqkQEeokFv4DCFyVzzlUjF0YA+tSTMGD4RWKqnoIObcUcrV2OLKUR0X0+Q854WIdFHLUxCVE3W6UdGIAxYJFt3XYCbaFL/eJmjoEb5LalSpLdH9NMKEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIkk8nXnangC3O82xdydfvv1ZQxWxSva01sIEXzQIkI=;
 b=Wavll964JReWvHHguksP2dDIZD2rfqrz2gThmOaWCsk0Oxo09SRVh3gybsZUX/r+FySulio8D+KlYT2SF0fQglUyLmRWECb7eAUiZj/d9kEawS+GFZOMoJw43CdLWRYlEI42g8NqHTOfzMy0//gXJySTuPB6/3fo29wo8CJKjSGrgCqkCOacmojzwjbaodVsiVk8cXgaUtrji0ASRuw6yqHz3NYHkhAgYfHqr8zB5DGKLV7cqjyc8iaBrkUMlYJ8keAKxedttczAhj0yAvvFlgOxeZDN3bNNkDPk2zn8SrLrPdUR/Su+2NmASkBIc1k9ynmFvP4414YIYWqluacmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=habana.ai;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIkk8nXnangC3O82xdydfvv1ZQxWxSva01sIEXzQIkI=;
 b=jVacZID/hAGznIeiFAlZo32UB2M2lZaCA/LhR3USjo7vqM5d8ukCfjvbT2dMlw+PF8VL+60OcX3H9x+mVrOPQZQMcRuFslZ83udjKCDmhoC3uICg4HLlBJlA7Hc0Fkpp3oKiluFv1mDDPFHn0+DSHD1KwNGb6vHXdCsfTdjVR3+PnB/k2b+0eNHisHyw1fEh9V0BN76bDGZuh5huzlRFmTF5ydbO58hkCfVCy9MttJ3F17t5K1Ka0+05L0GzZ5nk5ffpP6NDoM7ANTJRtLGdvrxSMZ5X2KLUMpTyVy01+uBd+29QzBz/XJXCUrQPZfIraBZQrqkjXlviVdESdFBL/Q==
Received: from PR1PR02MB4761.eurprd02.prod.outlook.com (2603:10a6:102:e::31)
 by DB8PR02MB5626.eurprd02.prod.outlook.com (2603:10a6:10:ec::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 18:22:39 +0000
Received: from PR1PR02MB4761.eurprd02.prod.outlook.com
 ([fe80::98eb:4d33:ca89:4310]) by PR1PR02MB4761.eurprd02.prod.outlook.com
 ([fe80::98eb:4d33:ca89:4310%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 18:22:39 +0000
From:   Dani Liberman <dliberman@habana.ai>
To:     Hillf Danton <hdanton@sina.com>, Oded Gabbay <ogabbay@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 02/30] habanalabs: fix race when waiting on encaps signal
Thread-Topic: [PATCH 02/30] habanalabs: fix race when waiting on encaps signal
Thread-Index: AQHYD8pWgI9qcl0Y00K7eqwXvkteGaxvwGQAgAK+MuA=
Date:   Mon, 24 Jan 2022 18:22:39 +0000
Message-ID: <PR1PR02MB476183CADA89FEAAB743EAD4AF5E9@PR1PR02MB4761.eurprd02.prod.outlook.com>
References: <20220122195731.934494-1-ogabbay@kernel.org>
 <20220123002722.3057-1-hdanton@sina.com>
In-Reply-To: <20220123002722.3057-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=habana.ai;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fbe1e56-ba83-4c33-70ca-08d9df668137
x-ms-traffictypediagnostic: DB8PR02MB5626:EE_
x-microsoft-antispam-prvs: <DB8PR02MB5626948B098165E8A5457E58AF5E9@DB8PR02MB5626.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IC4oJUmgN+jp1XIk2Z30vuSz0JwWKFwjHMa8jmcrWai7uEUOANztgRR8q9flx/7a4tPswdzG6BOufbt5mjlY3A3sbDGN28J+Mk29/U+nHu9iTlw+zTdDidaQ8VF0vG70gTEJgryExJGZO931WCh7+Je42BBNPgTflX/fVsYzWqqyRHzoP1+lQadhhkYIXAIlmlXU9aQdNyY02pH+WlJQJw4G/xN9fRNvKTjpLcrhbbiIHY7d0qDcLtMWEWafuB1ZVFzMhrZ2RINopzMSVHF9oyA4WiNtMz2HIDkmNyNzCnxmaN43vBWk2x0E66jCL5pxWC/R9KnodkqiN5aYpsvuwQiL3jGs54MOKVQ0WE9Gw3wNew6L30W1p3A5wGElA6UsiSKTbTJlupoBIMPLI6xjNOBfSdVbvuoTYVBAaRvYeeTh9zVTtHeks6WoAvsyWpRw45M8yHoxYHWiZ7WmaToV+8ua6F2ZbOTM0TJJmCnj465V/cGagbwLwJ5vIf6U004gRfPQO1fbsqwzezTBIykVWqmaw/cYmmYgZhHQgdKmjxH80XocTWArcnvd28k2NqSgqS3wTK50IGknI1xe54d4yyE1XzJOgBKmbpC99RPUiQSn/M3bIr9YXlJhVNqK+1wC9ZpyuAWgq/aJW8pww3bae1WN9WFvPVQq5ERvjQDPYSNHODEHwj3EKjYb4/WOPDrFgPpRsYMMD41CNjmM6wsm6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR02MB4761.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(82960400001)(186003)(66946007)(9686003)(26005)(71200400001)(8676002)(83380400001)(33656002)(5660300002)(4326008)(52536014)(64756008)(66476007)(66556008)(110136005)(316002)(66446008)(8936002)(86362001)(6506007)(7696005)(122000001)(2906002)(38070700005)(508600001)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHhXclI3d0NDdUoxNVFvSi9Yb3BGQ0h2S0tVQ2tCU2Y5NzJYalFabGFSUm1o?=
 =?utf-8?B?K0huclhmd0VONXRDcksweVl5ZThvNllKY0xMNVQxNW1EZHhvc1NZVmNGRFlE?=
 =?utf-8?B?MEIrK0Y1SmxhMWhKODBELzFzL01iVEZRdXpXOUJrOWlDVjk0bXEzeFpqWjZS?=
 =?utf-8?B?Mmo5aXFuQlk0SEwrZm9vUjJjb1RkczZLV2VHT0JsazdOdk80QXlKeVJyOHZa?=
 =?utf-8?B?aGxjOHlSTlkvZXU1TmpwMi82S3Fub2VJd1ZFOWUzZ08rdDFlQ1ZNNEFKRVNo?=
 =?utf-8?B?V3IwaHVwVUVHWkZOcHBld2NXaDBFYmE5SzNSSkdGRkJKYTRmZjN0MFFhd0g2?=
 =?utf-8?B?Q1l5VVpid3lvU2l3WURpR0dESGl3QzZNMlB0SzgvWTJNQjdTNUxIWXQ0NkFw?=
 =?utf-8?B?V3RGUndsV3hLSXlpbzd1U0pLR0VzK09QdzJXWC9rM0c4NVZCTHJzOWc3akFw?=
 =?utf-8?B?eVNOMWpVSFFaNkxRdmYrNk53UlN5bkRJS2ZzS0RGNmVXWkxFeVR6MXdmY3NR?=
 =?utf-8?B?bFFuNDhZSEpUbTlnUXoxeXdqb3h6Y2d3Q2Nhb1A4cmtrSk1HcXZmN21IUnJq?=
 =?utf-8?B?U0tQaWVMNGpoMHdoNGhqL2Y0dnM5bFhWMWpKbkxMekhaWllkby9aejlJTjk2?=
 =?utf-8?B?TURwZ2VaTjA2MFlVQ3MzRlhNOWF3UjlzcnpZNlBPN0llUTV4cHhlT05QUE42?=
 =?utf-8?B?empReDY1MWVZeks4VVUxcmd5UHp0ditGOHNiUWdqNlVjaVJZd2luMUNNS1dW?=
 =?utf-8?B?cTFpdmV5VEYzaktVMDE2S3FmeTg1SzFDV0F4NEFFN3NuMTRCT0tMZ1JCOWgz?=
 =?utf-8?B?VmxmYkZtZENzdFEwT0xUYitqV1VaMWY4aWdKWWlDY3FTeldkRUtDNXAwRUhQ?=
 =?utf-8?B?NG1KdEVjTkVzcXIvT0QxaE5FYy9EVStUSGVHUEl0N0NwVWU5VEpiK294a1Zl?=
 =?utf-8?B?ZmZnRHZINUlwL05DcEVoMTFLdWR3UXZuMHhlOGU0cUp1WUlPWmg2R0lVYVk1?=
 =?utf-8?B?TU5qNktQanZTSnhjYUgvRS9uNS95NlZ5ZnJkaWh6a0tYOVhVdk0wNEFDem5s?=
 =?utf-8?B?ZG1EUXZXYXBPZUVoL2pkUXFWSTRHSnNnTGlJUXFScmVnd1U1WVk0S0tWNlU2?=
 =?utf-8?B?SVYwcFJXR3dvK01scVBEeFhCTlU4UTJkWmhEWHhabExFSkVRbVIvVVduREFz?=
 =?utf-8?B?T3dMNElvTCttZ2gwcVJ4c1JjM1QyeTJYOG1FalVsNWtlblpadWtLUU5obE5U?=
 =?utf-8?B?TGRrUXEvd3B0QzY4OStDbGY3T1RFaFZxQ0ZPYTRVbUVWRllQYWxmZ0ZZVHNY?=
 =?utf-8?B?QnVJZkxJQW5DcmZubDdEd2g5UlQyK0ViZUtMUE9MZHljUEFMckZ1UUorckoy?=
 =?utf-8?B?cXo4Q3pUMFQ1SnFGVEtmQWJrRnlPcDg0NWJiZGtpZ3ZPRGhIS2FGWkV2UkVq?=
 =?utf-8?B?c3hhSWZKa0dwbUFad3JjOEVtQW1hT0k5VFNLUThPUDY0eE1oenAxQkVGemxi?=
 =?utf-8?B?VmdWcVZVVVNPeTRjTWlUVTJXbld2djVRaVdZMzhQMkNIMkNtOTRJWGRIMDVn?=
 =?utf-8?B?RTBvcHZBOVI1dWYvbTQyaDE2enp6dlR6VzJnc21tT0IrdVhtQld0Q1FmNUhl?=
 =?utf-8?B?aDVOOHNpVklzNUNyd21xZXUxbExqbUdNWmJQRmlGaDVzT2NsYkxMRU5MeUxh?=
 =?utf-8?B?TVlQUWo4UUFMemhPeXVXdmZzc1hmZUM2a0Z3RXEwOFQzc0dwY0J5WHhWbllH?=
 =?utf-8?B?UG5pSGZ3SldsN2NwL2pidnRHdlZXcVpKSnhsM1pKeUxCT0VLSmI1YnVacUhQ?=
 =?utf-8?B?THJFSTdTYnprcEVkMGl5L0g0L2JlaHIzbjFxMk5zZitUZGVqSW9PM3R1a2Zo?=
 =?utf-8?B?dW8vSmcyR1R3M3MwL2pmZnNCUWwwT1lrTnN6QlAxcHBlT0JMUm9QMElzeVFD?=
 =?utf-8?B?MVdDeVMwTFFaUW9ta0kxRnZSbU5tM1lDUnoyWWV3bjZheEVBL05STzRQTjFi?=
 =?utf-8?B?MDBocEhBZlBRbFp2MUZpMzRvV3Y4VVpQRWtlTVdoZDVaS1RBTHZ4WnhsTWx5?=
 =?utf-8?B?Y3pxYmJtZFNMRHJtOUR5NG9CYzBwczNJRmsvazJUNEV1VVNQdlEwOVdtZmdv?=
 =?utf-8?B?UElwbFY2enBKYjg4dGF2eWl0cDEvb0UwWUFrMUU4UE9zYmtQR2pPZjVTWlhT?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1PR02MB4761.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbe1e56-ba83-4c33-70ca-08d9df668137
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 18:22:39.6250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ez4F/74jUGmzkIVTs+doHmALJXrYOI+ipJNgYIhOPxDZZ59X3v8d9vVXP7bkAzkzoxMsGrTfK3LBjnXKFhoT5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5626
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIFN1biwgMjMgSmFuIDIwMjIgMDI6MjcgKzAyMDAgSGlsbGYgRGFudG9uIHdyb3RlOg0K
PiBPbiBTYXQsIDIyIEphbiAyMDIyIDIxOjU3OjAzICswMjAwIE9kZWQgR2FiYmF5IHdyb3RlOg0K
PiA+IEBAIC0yMDYzLDEzICsyMDYzLDIyIEBAIHN0YXRpYyBpbnQgY3NfaW9jdGxfc2lnbmFsX3dh
aXQoc3RydWN0IGhsX2Zwcml2DQo+ICpocHJpdiwgZW51bSBobF9jc190eXBlIGNzX3R5cGUsDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgIGlkcCA9ICZjdHgtPnNpZ19tZ3IuaGFuZGxlczsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgaWRyX2Zvcl9lYWNoX2VudHJ5KGlkcCwgZW5jYXBzX3Np
Z19oZGwsIGlkKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVuY2Fw
c19zaWdfaGRsLT5jc19zZXEgPT0gc2lnbmFsX3NlcSkgew0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaGFuZGxlX2ZvdW5kID0gdHJ1ZTsNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIGdldCByZWZjb3VudCB0byBwcm90ZWN0IHJl
bW92aW5nDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiB0aGlz
IGhhbmRsZSBmcm9tIGlkciwgbmVlZGVkIHdoZW4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAqIG11bHRpcGxlIHdhaXQgY3MgYXJlIHVzZWQgd2l0aCBvZmZzZXQN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIHRvIHdhaXQgb24g
cmVzZXJ2ZWQgZW5jYXBzIHNpZ25hbHMuDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKi8NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGtyZWZfZ2V0KCZlbmNhcHNfc2lnX2hkbC0+cmVmY291bnQpOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqIFNpbmNlIGtyZWZfcHV0IG9mIHRoaXMgaGFuZGxlIGlzIGV4ZWN1dGVk
IG91dHNpZGUgdGhlDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KiBjdXJyZW50IGxvY2ssIGl0IGlzIHBvc3NpYmxlIHRoYXQgdGhlIGhhbmRsZSByZWZjb3VudA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogaXMgMCBidXQgaXQg
eWV0IHRvIGJlIHJlbW92ZWQgZnJvbSB0aGUgbGlzdC4gSW4gdGhpcyBjYXNlDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBuZWVkIHRvIGNvbnNpZGVyIHRoZSBo
YW5kbGUgYXMgbm90IHZhbGlkLiBUbyBlbnN1cmUNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAqIHRoYXQgdGhlIGhhbmRsZSBpcyB2YWxpZCwgaXRzIHJlZmNvdW50
IG11c3QgYmUgYmlnZ2VyDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKiB0aGFuIDEuDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ki8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChrcmVmX3Jl
YWQoJmVuY2Fwc19zaWdfaGRsLT5yZWZjb3VudCkgPiAxKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoYW5kbGVfZm91bmQgPSB0cnVlOw0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4g
LS0NCj4gPiAyLjI1LjENCj4gDQo+IFdvbmRlciB3aHkga3JlZl9nZXRfdW5sZXNzX3plcm8oKSBk
b2VzIG5vdCBmaXQgaGVyZSwgZ2l2ZW4gdGhlIGNoYW5jZQ0KPiBmb3IgYnVtcGluZyB6ZXJvIHJl
ZmNvdW50IHVwPw0KPiANCj4gSGlsbGYNCg0KVGhhbmtzLCB5b3UgYXJlIHJpZ2h0Lg0KSSB3aWxs
IHNlbmQgYW4gdXBkYXRlZCBwYXRjaCB3aXRoIHlvdXIgc3VnZ2VzdGlvbi4NCg0KRGFuaQ0K
