Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743BA464C22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348829AbhLAK5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:57:17 -0500
Received: from mail-psaapc01on2139.outbound.protection.outlook.com ([40.107.255.139]:54849
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242437AbhLAK5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:57:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSfh/7ZM5PIvC/ayTcc6e/U7rHI6enbs+58icfc36GBs6cFNjcI0QY72rRiCiKlcgr41iQLZrqkrlo2waCpfbhUJv/cfo6B+BxUA/Uc3egzZmxDGRSfV+bat7KDggrZa8d0F6lT9aHzSY8Cnt9I1TnhTMR2TkCorEBK7X3twQ4RU9CSar19Pt4BM9udEc12qJFvH6O0U3xkiQ1g8S1KupI1mNzw5x+oTQmqu5mqe57NjsUZufW1T33oeYqQmCZPUQOlVPqUrZNA8WPV2HGTTtdXOTQ29AVc5/8r56RMjUXCuWJSVc3P1S2PiohZO822OphoGMimnPAry+nM8u5e31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbosMjVpsd9tflg8KKyoxFmnvmOOe1SewkoZNbi3jT0=;
 b=TxrXkgDZFWfpdXlBFgtLPezMTMrWViyhCmHUx76OOlog18n6oRmh5hID1ODUMWwXFs9P9qD4oyiyV+Kg/zjmO69JJd3v72ZuynxEG/Q90x1pP7E5zXvbPFy7S5nJlGtfjx/NvuoO653v/jBN2OKwSY0zJAf/CI3rRsfTGylnpPHZidIQmVv6wwOl9jqIRtszkyiwUy3ftZNTZLaR9m8myF3fiRTfqLf2pcK2anhLhMCeKhkFajujRxA4djNjABESwOupG7PiRiAhCQOeWcsCk3BUHooOusJLZVtLEPfQXdNJzYihDcjWxUaD+VI46IDZz1ayaZFJnrhZuqqKK8h4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbosMjVpsd9tflg8KKyoxFmnvmOOe1SewkoZNbi3jT0=;
 b=aLrU778YfjoYPBx1lXoy+ncN1xrecT3fQ0H6cDD0JqIQdOInKFrh/i+WHBoXm4lQMOwr1UWJmkOk70CEu1QzlbdgZY9NppTv3tVj6JTKxjYizlcGLhm5prQZ+BuiVjIAk42aS0EWHah2BIk6wv8E1eTomshXBqa/lhAemMuj8NDzAXvj2M6Fhuop66uXEhNgPVleJ9Qdqb85xrNUd6yyDQXEseGm4mlVjU0f2s00rQEBqWkjTFa28Q/NDpl/5NCYgCoiiv6d+DAQpGLl9cy8Pzn3ZlwhCA41e7oemLIJP/vQpqBycynJi8gVXOnLO8q+jgY7TNcYR0ZyjraDaQKYSQ==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK2PR06MB3540.apcprd06.prod.outlook.com (2603:1096:202:31::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 10:53:48 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::7941:2fad:3c82:52eb]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::7941:2fad:3c82:52eb%3]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 10:53:48 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v13 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v13 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHX5Ow7hsOaCLIIMEe2C8jlARJZF6wb1hKAgAGtoYD//9ldAIAAoqKA
Date:   Wed, 1 Dec 2021 10:53:48 +0000
Message-ID: <A49ACA24-D607-443F-8C96-4E2BEF902F8E@aspeedtech.com>
References: <20211129064329.27006-1-billy_tsai@aspeedtech.com>
 <20211129064329.27006-3-billy_tsai@aspeedtech.com>
 <e28a5d5de9b940717e6444f019eab63ab1bb0b75.camel@pengutronix.de>
 <CDB0374F-3835-4501-964E-DB771588114D@aspeedtech.com>
 <3b80b2a52362cbadb26052685566e2c1f75a0b68.camel@pengutronix.de>
In-Reply-To: <3b80b2a52362cbadb26052685566e2c1f75a0b68.camel@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5e89e0f-003c-4887-1e43-08d9b4b8dacb
x-ms-traffictypediagnostic: HK2PR06MB3540:
x-microsoft-antispam-prvs: <HK2PR06MB3540B30038C59255E6118D708B689@HK2PR06MB3540.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 589e01EX7MbLI+0h3WLCjzOTKQL/TJv25jTVdCLy5pDiVTlFetr67s0ttGzgMzqHlTv/bw70sHrqJqS9HBYLYIkyjgdaUFOlxRttm9DbEdPYGAyuSS8VySjqfj+Chcz85vb1c5tpBL4+J5kDcDKn7Q7SO/r82k58fH6Z126QB+hyt9egEcNjldp92WW/+3/gIreIyL7vYn+USCYUdqfyFELogFAEl3lrLdCPEYtfuxg1Zi7T87A/jHfNG6zWV8NzTq+4/58ZnJsEHIhhDhGHB9yOQ1NJlC/69MmWF0Le5njCNbV5JI79RAdfIoVa8nOu+6TSM34NoXvZBRgsXHfFe2cGQTzguVA5wzO9WzmDZO3trhyay5+slz+fW/P8uIyIqLBywF4qrag5LjnLU6VAIZak5CJF0vIiebsZIdKxG1AKJqM5z/JVPVA3/P4xQsrdIiKUZdoL+IZcH4jai4z4kWxrevKhjsE+hi3BjxWLRBSWAnRnlTtEkQfbnF7cOmzs4k4T8elZnYdIURgmKLHr2Kul5fNkkESkxD2DPfz9VW4TuWDXq8UK2w4tG4WrEs//JX9r8T8h/4YHV4AsA56TFM9rqF0xrFRkBvDlA5iNrxAjSd+ZY8OxDXYT3L0iwGFVHM3FlPICyXLcuTjViHCDe1a6CCaST69F0hP9DYlAm/i1J83q0RjzL3xp9uRL/mExotLzRQLkoIcE2UPD1JID+cXlEF+THjgi+71ptNZiNt2e/0BnfE2KLoAl4zZNI8NUPijvrCtHoaf/dhdDwnXkEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39840400004)(136003)(366004)(346002)(396003)(8676002)(2906002)(33656002)(83380400001)(107886003)(2616005)(508600001)(66446008)(66476007)(66556008)(122000001)(4001150100001)(8936002)(186003)(38070700005)(76116006)(921005)(66946007)(71200400001)(7416002)(6512007)(316002)(6486002)(4326008)(64756008)(38100700002)(53546011)(6506007)(36756003)(5660300002)(86362001)(26005)(110136005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkxIV29lNnNxSEJJekFFYy9LNjh5NVBTVm0zNWZKTmtXRUNFTDdUb1dSV1My?=
 =?utf-8?B?NXlKdFJWOTROUWs2aXNCc3JYV21zZmE1bkw2ZG5KUWFDZHVDTnNPUHJlaVY4?=
 =?utf-8?B?SWpielFGNEZTS1Z6dG5hTWNXSjQ1cnIyd1ZudFhodEtjVENSWlBjckdYNTJw?=
 =?utf-8?B?bUdyL3hySlZIZkcxTTFoeUttWFJUOWVpM3NYZDdWYUN2MHIrVXZzaUZnNjVD?=
 =?utf-8?B?K0kwVEJzaHdRQjd2VnlSNmt3S3EzcXRmWWFoZkVlU0ZUby9FbUZqQkhBU1Q5?=
 =?utf-8?B?dzRpazZOaGErWnRvaWIxSWRIRXBKYTNzUHRrQ2R2azhTbStxTWFHb3IrNUJm?=
 =?utf-8?B?Y2JUQlJKcm1rRFVNZW5Ha09yMUQybjhtWEJtUlFWY3A4WUpPRDVpUFBkQzhq?=
 =?utf-8?B?eGpGQnNQSW56aFFabFdqc3ZzempFRkxMd2xLZkhiV2h4L3dQRHhRWkYwTDRP?=
 =?utf-8?B?NW5qelgzV0JXeWF5RmMxSmJFc1E2Q1A5Wjdna2tJNmVVY3dmWEQvd1lRUnk0?=
 =?utf-8?B?dkFSWW90QnpqN3lER3BndTNSWG9IMExxbmcyalFmdlRMa0ZqbmxYcUlFWVA4?=
 =?utf-8?B?bG9NWHhRd1Bqa3JtYTlzTUhJV3lDaGtUbHlIU3ZmL2RLSEpiWnFtQnJNWXNX?=
 =?utf-8?B?N0h4eEdpcmxBUXpnYlQ4azhVQU00cXA1NG1Wa1ZBRmhDSXdqaTgvQ216R0ZF?=
 =?utf-8?B?SW5GTzNZUCswS0RIcXZheWd6QXo4blVPaU5GeEJDclEwUHBNNWUzTm14cmFq?=
 =?utf-8?B?Yjk1Z3AvNzRDVTlSZGZqb3pTRFpOWmdRam1NdnF0ZmxmakhvKzgwaWpQL0Y2?=
 =?utf-8?B?dW41VTBEMTZaVEkvUWUwM1dJR2FkajNNbG9rNlh6OGcxeFpaK0dYVUxSSUwv?=
 =?utf-8?B?cXNQbnFNanlWWWZDa2lZU1FnZndYZll6SXJBUU0rTkpaZ0RQd3NoZkVPcklj?=
 =?utf-8?B?ZGtGZThmcnZhTUdYWEJoamFaeVdoV3psL0xwZnJwdEFOSVFpWktvM3ZNNGN2?=
 =?utf-8?B?elJXR2hNSjFrek1IZFY1OEdrL3pldndwY3BnNE1BZmJXQWo0Tm51eFlTNlE3?=
 =?utf-8?B?N0JXTTFPeWlsTVhURkVrbTR3aFdIcnhpNFlmbkx1em9KVVdIeHcwdXdubTYw?=
 =?utf-8?B?RXBFZVE1VGI0L2lQOEtXK0xlQmRrL0RLU29BY1dtVlMwWXdIR3VmMU5qK3FM?=
 =?utf-8?B?cjhWN1FadkYyQU1zSktoQjF0TzlTV2c3WG1tbzk3R0hpUlhBMWNKVDNUUmQ5?=
 =?utf-8?B?WTdpMmhwKzNwRnFzREU2V1o3Mzl4Z1hRT2xCcFhHbDNYZXU2T21mM2Erc3Mx?=
 =?utf-8?B?WFRHV3JZcUlHQUMzeTR0Y1dQSzJ5TkozOGpjdXdtYVBJZGJVTmVvOUdCVFN4?=
 =?utf-8?B?czdSVHF0NzZ3Z0k1R1p4c2MwK0kyaHJRUHhMWHRIeXRQcVExTloxcXJkN2VJ?=
 =?utf-8?B?cTMvQ2N5WkZlUFhwT3NySzB4bXN6Q1Vuc295TWt0ZlNPZkNVbkNpTGtMa29L?=
 =?utf-8?B?d01FdDFZK1VWVFJQRW04L3NsaUNyTkcxeGM2UXRzRnpVbVlZb2lndVVNZFQ5?=
 =?utf-8?B?dDZHZ0drbk14Q1FvQldZOVd3QWZDR004M2NyS25Bb2xucysxSHJ3RE05ZGYw?=
 =?utf-8?B?eXlqaWxRZy95OWRIYVB3ek5wcFFydmJobWtIWVFLWkU5WXByaTFGbVE4WTlI?=
 =?utf-8?B?VlVEYUUwUWdzRy9TM01VYU5KdmRyVzVoeFNSTHlxbmZoWHFlc2o4TFQ5REVa?=
 =?utf-8?B?UmZIdUExT0Q2Q2ZTWmVKTVMxR3Y2SDN6TW9yb0crc1VKM3c2RUU2aStLdUto?=
 =?utf-8?B?UGY0UWZnb05XLzlaeVVOQ0ZXU3ZOSG5KOG5OMVZodDhkVDZGOFZ3WFZ5ZGl2?=
 =?utf-8?B?ZCtNWTFiVlc3UlpDdTFhUFZwWERSa1Y4RHo2NnNtMkNTcXNjUCswbkxyZTZs?=
 =?utf-8?B?cU52bEtQMnpVUzBGUUg2TEo2YXBaRlgxY3E3V2hObEx3ckNEMHd1MDEwSTMz?=
 =?utf-8?B?R0JtZitXL09KUUYraTM1dEJnSUVJK04xcjVaajIxZEpJcWR5NzZXY3lqL0lS?=
 =?utf-8?B?eXpSd2FaK25HTjdCQkhBQ1oyQytCNnA5b2ZwYTBBSjJjRndMRW4zZ0JOSWUz?=
 =?utf-8?B?ZEplLzBrYkJWWWl5R0FCcjZsamlPU1d2bU5RTHRJeHVmVXRwWEpvTmd4ZU9R?=
 =?utf-8?B?NS9pZ3RHOVhQcTdqejBKR2d5QkV6WnVFeU8vWXQwSFcvdWtOUzg2dFlwTENh?=
 =?utf-8?Q?YfvHi/ZgInzTkpGDyUoKhdOFQRTepImKcYSEFkadyE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <062BD49EB84E0D4CB5535852906CFB47@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e89e0f-003c-4887-1e43-08d9b4b8dacb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 10:53:48.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cjX57ETdajYxajPm+j7u1PY2cOjjNtf0G/Nc09T49tmOdvIA2CZDyNeXjolWLulJVJWOlWoio8Bi9ZouzHA+NKlvwOCG2zzJditmyHPg/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3540
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcCwNCg0KT24gMjAyMS8xMi8xLCA1OjEyIFBNLCAiUGhpbGlwcCBaYWJlbCIgPHAu
emFiZWxAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOg0KDQogICAgSGkgQmlsbHksDQoNCiAgICBPbiBX
ZWQsIDIwMjEtMTItMDEgYXQgMDM6MzAgKzAwMDAsIEJpbGx5IFRzYWkgd3JvdGU6DQogICAgPiAg
ID4gSGkgUGhpbGlwcCwNCiAgICA+ICAgPiANCiAgICA+ICAgPiBPbiAyMDIxLzExLzMwLCA1OjUy
IFBNLCAiUGhpbGlwcCBaYWJlbCIgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOg0KICAg
ID4gICA+IA0KICAgID4gICA+ICAgICBPbiBNb24sIDIwMjEtMTEtMjkgYXQgMTQ6NDMgKzA4MDAs
IEJpbGx5IFRzYWkgd3JvdGU6DQogICAgPiAgID4gICAgIFsuLi5dDQogICAgPiAgID4gICAgID4g
ICA+ICsJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHByaXYtPmNsayk7DQogICAgPiAgID4gICAg
ID4gICA+ICsJaWYgKHJldCkNCiAgICA+ICAgPiAgICAgPiAgID4gKwkJcmV0dXJuIGRldl9lcnJf
cHJvYmUoZGV2LCByZXQsICJDb3VsZG4ndCBlbmFibGUgY2xvY2tcbiIpOw0KICAgID4gICA+ICAg
ICA+ICAgPiArDQogICAgPiAgID4gICAgID4gICA+ICsJcmV0ID0gcmVzZXRfY29udHJvbF9kZWFz
c2VydChwcml2LT5yZXNldCk7DQogICAgPiAgID4gICAgID4gICA+ICsJaWYgKHJldCkgew0KICAg
ID4gICA+ICAgICA+ICAgPiArCQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiQ291bGRuJ3QgZGVh
c3NlcnQgcmVzZXQgY29udHJvbFxuIik7DQogICAgPiAgID4gICAgID4gICA+ICsJCWdvdG8gZXJy
X2Rpc2FibGVfY2xrOw0KICAgID4gICA+ICAgICA+ICAgPiArCX0NCiAgICA+ICAgPiANCiAgICA+
ICAgPiAgICAgPiAgIElzIHRoZXJlIGFueSByZWFzb24gdG8ga2VlcCB0aGUgY2xvY2tzIHJ1bm5p
bmcgYW5kIHRoZSBjb250cm9sbGVyIG91dCBvZg0KICAgID4gICA+ICAgICA+ICAgcmVzZXQgd2hp
bGUgdGhlIFBXTSBvdXRwdXRzIGFyZSBkaXNhYmxlZD8NCiAgICA+ICAgPiANCiAgICA+ICAgPiBD
YW4geW91IHRlbGwgbWUgYWJvdXQgeW91ciBjb25jZXJucyB3aXRoIHRoaXMgcHJvY2Vzcz8NCg0K
ICAgID4gICBObyBwYXJ0aWN1bGFyIGNvbmNlcm5zLCBqdXN0IGN1cmlvc2l0eS4NCg0KICAgID4g
ICA+IEluIG15IG9waW5pb24sIHRoZXkgYXJlIHVzZWQgdG8gcHJvdmlkZSB0aGUgY2xvY2sgYW5k
IGRlLWFzc2VydCB0aGUgcmVzZXQgb2YgdGhlIFBXTSBlbmdpbmUuIElmIHdlIGRpZG4ndCByZWxl
YXNlDQogICAgPiAgID4gdGhlbSBpbiBwcm9iZSBzdGFnZSB0aGUgQ1BVIGNhbid0IGFuZCBzaG91
bGRuJ3QgcmVhZCB0aGUgcmVnaXN0ZXIgb2YgdGhlIFBXTSBlbmdpbmUgd2hlbiBjYWxsIHRoZSBn
ZXRfc3RhdGUuDQogICAgPiAgID4gQXNzdW1lIHRoYXQgd2Ugd2FudCB0byBhZGp1c3QgdGhlbSBk
eW5hbWljYWxseSwgdGhlIGRyaXZlciBuZWVkcyB0byBhZGQgbW9yZSBjb25kaXRpb25zIHRvIGNo
ZWNrIGFuZCBrZWVwIHRoZSBzdGF0dXMNCiAgICA+ICAgPiBvZiBlYWNoIFBXTSBjaGFubmVsLCB3
aGljaCBpcyBub3QgYSBnb29kIGRlYWwgZm9yIHRoZSBzZXJ2ZXIgcGxhdGZvcm0uDQoNCiAgICA+
ICAgVGhhbmtzLiBJIGRvbid0IGtub3cgdGhlIGhhcmR3YXJlLCBzbyBJIGhhdmUgbm8gaWRlYSB3
aGV0aGVyIGRpc2FibGluZw0KICAgID4gICB0aGUgY2xvY2tzIHdvdWxkIGV2ZW4gc2F2ZSBhIG1l
YXN1cmFibGUgKGxldCBhbG9uZSBhcHByZWNpYWJsZSkgYW1vdW50DQogICAgPiAgIG9mIHBvd2Vy
Lg0KDQogICAgPiAgIEkndmUganVzdCBzZWVuIG90aGVyIFBXTSBkcml2ZXJzIHVzZSBydW50aW1l
IFBNIG9yIGVuYWJsZS9kaXNhYmxlIGNsb2Nrcw0KICAgID4gICBkeW5hbWljYWxseSwgYW5kIHdv
bmRlcmVkIHdoeSB0aGlzIG9uZSBkb2Vzbid0Lg0KDQpUaGFua3MgZm9yIHRoZSBoZWFkcyB1cCwg
SSB0aGluayB0aGF0IGZvciB0aGUgdXNhZ2Ugd2UgZG9uJ3QgbmVlZCB0byBpbXBsZW1lbnQgdGhh
dC4NCg0KQmVzdCBSZWdhcmRzLA0KQmlsbHkgVHNhaQ0KDQoNCg0K
