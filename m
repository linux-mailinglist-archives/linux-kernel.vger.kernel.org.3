Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A55466F5E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353668AbhLCB5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 20:57:51 -0500
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:25408
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235608AbhLCB5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:57:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG7I35aEpazVlIdpxfVCNKXEI154/Te6qnHfe/EcWfl2xZneJxcF5w7knHFdQtCyQsJHSK4VNUT7kjCnxXqXtBXXpS7jTDwayLB6I49iGRd8UTX/XctAEtz8kxmZRmeRbnJmcSOHRNKhOE33y2x+08qjjYEPgSaysMboz9cN9uFTamyzGKB5Pwl9QBmK1OnHwemsJOllyVRu5AuGBlYFCXGxwv/x7xqhXFiF4p9FuzidAboTM8QAzhUUqqXc9a0JkltKNYUdm1591Q3jYvyc6K5fjhvg+m07AjsIWPjFhH2GxqmAsWP5nD7sPIEfJ9wGohUQQbTCFcaw1KBTjroYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/q5vgDJANFX5Q9jm9VU+2+ovIdEKe+o6UvV5He9s5uc=;
 b=Nv+mUZSKgS8YNv/amwYLJiEMBI0eEgrP3096EVUU8RucQRKwN5Aa/NvU+Pl846TViLHA1TkJ1T2KT2dl5kxEnSleMf8rluYwT7OwRj8FnGNUJD+r+TuhlAZRApSw0sPsXQbqejoU0M1be4+jDUBc4o32ZzbvFVo24yqPDdwBIfRz9L/FboVygzx4S6GXL/97QbgWN/p9ViNdvrR1xiGxngc9DhQr+07LmoL45JEt8iUdraYvz0Lp8zr0y2M4o8hriqhwDedzI8QRbzV4DFQfllLeAJqtL1CiaUSIIP29ZqGeNgZGR9bLIgLvtt1V+tR13VtnvEwJOEuR5OYuyrwDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q5vgDJANFX5Q9jm9VU+2+ovIdEKe+o6UvV5He9s5uc=;
 b=d+KZbBws/DsSRDV3FbQC0hAG5uLgq9CJkWXsVgwkEildkyCPyhQRryUEf+Wc/d3Kpa0axF/+jNQV/0qKKqgfilTgwwOc3kqOXuTOEA9TBWtYPdOgSt5apEmek1VKgqeg9X+mlzO8pwB8TazvjIpW23TCox2XTYkqJIctpjCE4jU=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB5752.eurprd04.prod.outlook.com (2603:10a6:20b:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 01:54:20 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 01:54:20 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v13 06/13] media: amphion: add vpu v4l2 m2m
 support
Thread-Topic: [EXT] Re: [PATCH v13 06/13] media: amphion: add vpu v4l2 m2m
 support
Thread-Index: AQHX5c0K5fzguYirkUOkPOyaCvxH9qwfA2+AgAEAB1A=
Date:   Fri, 3 Dec 2021 01:54:20 +0000
Message-ID: <AM6PR04MB6341CDED2DB4CB01A49678A0E76A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
 <9797b40af0c58aa399b0355b9a020aef83f5e580.1638263914.git.ming.qian@nxp.com>
 <a26d2fab-30f1-9904-62fd-0d4c0dab6e18@xs4all.nl>
In-Reply-To: <a26d2fab-30f1-9904-62fd-0d4c0dab6e18@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57a817f1-bfd6-47eb-7a3c-08d9b5ffd28e
x-ms-traffictypediagnostic: AM6PR04MB5752:
x-microsoft-antispam-prvs: <AM6PR04MB57523EF00562A2D69A724A57E76A9@AM6PR04MB5752.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqkHtCa+cuqb+jVytNJ8lCwzmNZLbUsdO3bVoa5A4PxYx8NcDjcht/r94Vf+Olb6con75MgMB8Ug1dmqsikPaiYKpd9cV+RxOx1Yfx7M1CaOcTomkweqHr8dktUy7CDNNG3krv+guzQ1m+MjAMYzoU4XOZcep7IfuRp1ZD5kx2tI0b4RuVyD/nHdl1TuuKUSBGyqQdPWlQVjX+rJulel9Az6u7iRuRto0KeEMIj37lTCtEnwCOYOzjOybaA+Jb4bDyU7ON0f3DvREkZeeufYJlyBBqchMFMZjPiEvtjGlU3kOfhDyqKsXxb5xI8MTLik/ol8gvt1wnbl18WsZguw/rrpPG7VtA7vEn7Cgs1KjxWKO/8ORITOxpsc2DiW+gcY99skFpZDQy1reLZnj1+B9dvtdlHGwBI9Wd4aYoqskh4JeWzp4vp1qkuNfFJJwFZK8PlwnbQKHhssRGsfgVXfQdKhDTd18szO7G8hg4yS0VXWjUtbplJKLx/LPGbOjTw+edaF5aZ4zRa3syHk3NPel/SusPpXr819vQJv/eL5rIn0xFbyC9kqGiNo88FsiTGwXFBQLYgl/470woHY1kilkN7v6pbQbfSQjyv9rfZuw3aGHXUu6q5KdTd5nRO6V861gXd/v8pO9rZPOBAxsD21Um63wMkEcMP0WjnzObjVsVhwpymZxBrqwWOM12rc6tQO7yO5d+PG/TkkMGpg/zvAQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(9686003)(38070700005)(122000001)(4326008)(6506007)(83380400001)(316002)(7416002)(110136005)(8936002)(76116006)(86362001)(66476007)(64756008)(66446008)(66556008)(66946007)(186003)(54906003)(71200400001)(508600001)(7696005)(38100700002)(2906002)(5660300002)(55016003)(8676002)(33656002)(44832011)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzJVbnNOZkVxU0I4V0d4SHRLenpCL2hBZC9hVUlqN3owY2hteFpLSzhsVFVD?=
 =?utf-8?B?c0creG9CeWZIN2xyb1ZBYmJaNmJKTUxNOU5Gd0p1ajAzVjNsMHBmTHNMemVB?=
 =?utf-8?B?Qkg2djNKalhyWGZXMXFCMkJNU01neUVwQmsrQnF6L3RFOVlJaC9oa3hnNGlt?=
 =?utf-8?B?YzNIenFvS0k0RFR6SW5VcWJneUgwOEJOQmNPZlpjVzcyOWY4YXFjSTdMaDhi?=
 =?utf-8?B?a1FQeHZXTGlGL2hsbldyQnJMdEg5a21KdWVtUkhUUDBqUXdQR3dGY1hkTWtP?=
 =?utf-8?B?c1huM3NBRWZhUk10TCtOU2hqd28wVGlieHh6KzU3ZGNvQ2UvVVRJa3NyeFFu?=
 =?utf-8?B?Y2dsM3hCR3B2Qysyd21SMlI5OGo1RkRoaE9ZZFV6SmN5c0d5VkRyMnZTK2pM?=
 =?utf-8?B?UHAzV1p0S2szTDk0RlVPT2ZsTmZ4akhvditydHZrWE1pRnB5bURzZ3hYR2R4?=
 =?utf-8?B?VlFNUmFFUWt6b1NMcS9oZTRIYzRCQytHN1NkUVpadThJeHN4QU55bmVmWENH?=
 =?utf-8?B?NkhxNkJnRDhwYVBOa0hDUTkvZFpnYXVwc0Q2RTg4Z0NBOTA0NUxnTnhtWDBQ?=
 =?utf-8?B?RmI3a3lsQTFSUHF2ME9wZlZ3bkFoT2NTUm4wMk5xQU41RnNPZDFNWXFtZ1FF?=
 =?utf-8?B?ZnpsZ3VDaGFTV1N6cURXOS9aVGFFQXoyWDNVMmdGYXg0ajB2cHdNdUlJa25U?=
 =?utf-8?B?MTljc2U3amlNWmZycjlrTy9tQnBOOWhnbE9hai95c0oyM2FyT080Mk9aRkY1?=
 =?utf-8?B?MUtGZVBxZ3BSMmlacjZHRG9FZmJadGI3czZYZ3FkRnJUY0ZneHZsaFBYdmwz?=
 =?utf-8?B?eEQ5TzNxb0lGb1NGN2MyOVdrMWZwaVQzTUQ4OGVCc29JNE1Vd21abThtblNy?=
 =?utf-8?B?aE5hdUlYcTBlY3pDVnZwdnRNL0hwa3BDMUJkbFgrL0UySCtoeXdEWXpOc2dB?=
 =?utf-8?B?UkdXMGtPZ0xwMEhaK1JuTlN0SEovenN1Vk93b21UYTdpbTlnMHI4VXFIQzZz?=
 =?utf-8?B?MGZtM3lsZmRRNDc0cFdmdWF6ZVRKY28ra0VJWHM0eUtKZStBMlkzdXRKK2Rw?=
 =?utf-8?B?b3RVNGltVVhyNTVZZVdkNTlPWGpQSjZpNzY3V2YvZXFLMXc0T244eFhJSGNL?=
 =?utf-8?B?Y3lDMklaVjNhZzBUWnAvZFo3Tk53aXR2dENJbWk3K2pjWXd6dnJtczZNY3d0?=
 =?utf-8?B?TThlMlpXN1NFZUh1c0kvVEZQZHJwV3RtVU9MMUFYQitCVzhyWVhVcGx4SnVl?=
 =?utf-8?B?RWhWditNbGRoQ0VJVDFpUHZFTjJYSTd1MkozZkdvU0ZrWUFBUStFS3dlSUxh?=
 =?utf-8?B?OWZ0R2pkdmlISUxzSHMxL2svMmdFcENPaFkxRWF6WncvU1lyOTJ4bzdsN01k?=
 =?utf-8?B?NlBVY2tFamVwUVRRR0RjelBMaWxPUDRocjg0eGFhWC94eXNGcEhEcXM2cjR4?=
 =?utf-8?B?STNzZE9MWVQ1RVdwMTZGTkJYNWFzSG14WEVFRHdqb1NWSmNXanYxdDUwRHhJ?=
 =?utf-8?B?SWRabVF2Q2lMVGM3ZVdSNVViZlZmdkVDa3lwSUpmZGdoNjdXUjlFVEN6V3ln?=
 =?utf-8?B?MHVFcjk3dG9GcVBXQmszazI4VzNiemJja1dvK29JblNCb2lYSUZCeGhjUFlT?=
 =?utf-8?B?T2x4Y1NFWUQ3TGZKajdYQkN3c2R5cktkaXN5UVRKTng1eHBocWhGZTV5YW1o?=
 =?utf-8?B?bTd5SmZnRjVlVzI0bFZzTDBSTm9TUm9OeHhUdE9XdGZGbDRPdkpWMklqWXhX?=
 =?utf-8?B?YzA2ZFhkcEczMGZFZEUzeC83N2lQUllKYVNKbXMyUXoyYTREZGVPL09HTmlR?=
 =?utf-8?B?QUdYODNacUQxU1NSUXJuQy9SQ3JKb3g2SW5YbVhOMjdMaWptanBoRVZLSWZ2?=
 =?utf-8?B?cE1IaHozMkxZZnFMUXlpajJGQ2RwcGhNMjlTZ2RXamNubk5wL3lGVlNzalI1?=
 =?utf-8?B?UGNwdVFJK1JJYzJVeHdWZkNWNEtsQ3FERWcxY1hIaXdaeStNZ0k4QnVvUjFr?=
 =?utf-8?B?UzRDZC9Kc2xuR2dHUVplSEtCbXpkVjJndUt0WXVoTnVwY2xQYmd5L1k0MTVx?=
 =?utf-8?B?cW5ZNWE4Z3NQM1cxQTdSNG1QYmdrSWl0b0xvMzlkMUJHYmR4bjRnb0ppSFRC?=
 =?utf-8?B?dUkreXlGMlV0Q3A5dzJwaEJRVGFXOGJ5bnY2V201K2FSZ2pwUVNVK0Z3RldG?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a817f1-bfd6-47eb-7a3c-08d9b5ffd28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 01:54:20.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9Q382ckhATcN/PX6QXOp7pvRwqCMrk4/H1Ui8EvtnKE7mnv6zdrE/oJXi8XLNDUYCcrZwhgY/xDadg/FqqwNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5752
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsNCj4gPiAraW50IHZwdV92NGwyX29wZW4oc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCB2
cHVfaW5zdCAqaW5zdCkNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCB2cHVfZGV2ICp2cHUgPSB2
aWRlb19kcnZkYXRhKGZpbGUpOw0KPiA+ICsgICAgIHN0cnVjdCB2cHVfZnVuYyAqZnVuYzsNCj4g
PiArICAgICBpbnQgcmV0ID0gMDsNCj4gPiArDQo+ID4gKyAgICAgV0FSTl9PTighZmlsZSB8fCAh
aW5zdCB8fCAhaW5zdC0+b3BzKTsNCj4gPiArDQo+ID4gKyAgICAgaWYgKGluc3QtPnR5cGUgPT0g
VlBVX0NPUkVfVFlQRV9FTkMpDQo+ID4gKyAgICAgICAgICAgICBmdW5jID0gJnZwdS0+ZW5jb2Rl
cjsNCj4gPiArICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICBmdW5jID0gJnZwdS0+ZGVjb2Rl
cjsNCj4gPiArDQo+ID4gKyAgICAgYXRvbWljX3NldCgmaW5zdC0+cmVmX2NvdW50LCAwKTsNCj4g
PiArICAgICB2cHVfaW5zdF9nZXQoaW5zdCk7DQo+ID4gKyAgICAgaW5zdC0+dnB1ID0gdnB1Ow0K
PiA+ICsgICAgIGluc3QtPmNvcmUgPSB2cHVfcmVxdWVzdF9jb3JlKHZwdSwgaW5zdC0+dHlwZSk7
DQo+ID4gKyAgICAgaWYgKGluc3QtPmNvcmUpDQo+ID4gKyAgICAgICAgICAgICBpbnN0LT5kZXYg
PSBnZXRfZGV2aWNlKGluc3QtPmNvcmUtPmRldik7DQo+ID4gKyAgICAgbXV0ZXhfaW5pdCgmaW5z
dC0+bG9jayk7DQo+ID4gKyAgICAgSU5JVF9MSVNUX0hFQUQoJmluc3QtPmNtZF9xKTsNCj4gPiAr
ICAgICBpbnN0LT5pZCA9IFZQVV9JTlNUX05VTExfSUQ7DQo+ID4gKyAgICAgaW5zdC0+cmVsZWFz
ZSA9IHZwdV92NGwyX3JlbGVhc2U7DQo+ID4gKyAgICAgaW5zdC0+cGlkID0gY3VycmVudC0+cGlk
Ow0KPiA+ICsgICAgIGluc3QtPnRnaWQgPSBjdXJyZW50LT50Z2lkOw0KPiA+ICsgICAgIGluc3Qt
Pm1pbl9idWZmZXJfY2FwID0gMjsNCj4gPiArICAgICBpbnN0LT5taW5fYnVmZmVyX291dCA9IDI7
DQo+IA0KPiBBc3N1bWluZyB0aGlzIG1lYW5zIHRoZSBtaW5pbXVtIG51bWJlciBvZiBidWZmZXJz
IG5lZWRlZCwgd2h5IGlzDQo+IG1pbl9idWZmZXJzX25lZWRlZCBzZXQgdG8gMSB3aGVuIGluaXRp
YWxpemluZyB0aGUgdmIyX3F1ZXVlIHN0cnVjdHM/DQoNCkluIG15IG9waW5pb24sIHRoZSBtaW5f
YnVmZmVyc19uZWVkZWQgZGV0ZXJtaW5lIHdoZW4gdmIyX3N0YXJ0X3N0cmVhbWluZyB3aWxsIGJl
IGNhbGxlZCwNCkxpa2UgdGhlIGZvbGxvd2luZyBjb2RlOg0KaWYgKHEtPnF1ZXVlZF9jb3VudCA+
PSBxLT5taW5fYnVmZmVyc19uZWVkZWQpIHsNCiAgICAgICAgLi4uIC4uLg0KICAgICAgICByZXQg
PSB2YjJfc3RhcnRfc3RyZWFtaW5nKHEpOw0KICAgICAgICAuLi4gLi4uDQp9DQpJIGhvcGUgZHJp
dmVyIHN0YXJ0cyBhIHZwdSBpbnN0YW5jZSB3aGVuIDEgZnJhbWUgaXMgcXVldWVkLCBzbyBJIHNl
dCB0aGUgbWluX2J1ZmZlcnNfbmVlZGVkIHRvIDEuDQpBbmQgdGhlIG1pbl9idWZmZXJfY2FwIG1l
YW5zIHRoZSBtaW5pbXVtIHZiMiBidWZmZXIgY291bnQsIGFuZCBpdCB3aWxsIGNoYW5nZWQgYWNj
b3JkaW5nIHRvIHRoZSBzdHJlYW0sDQpJIGp1c3Qgc2V0IGRlZmF1bHQgdmFsdWUgdG8gMiwgaXQg
d2lsbCBiZSBjaGFuZ2VkIGFmdGVyIHZwdSBwYXJzZWQgdGhlIHN0cmVhbSBpbmZvLg0KDQo+IA0K
PiA+ICsgICAgIHY0bDJfZmhfaW5pdCgmaW5zdC0+ZmgsIGZ1bmMtPnZmZCk7DQo+ID4gKyAgICAg
djRsMl9maF9hZGQoJmluc3QtPmZoKTsNCj4gPiArDQo+ID4gKyAgICAgcmV0ID0gY2FsbF92b3Ao
aW5zdCwgY3RybF9pbml0KTsNCj4gPiArICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAg
Z290byBlcnJvcjsNCj4gPiArDQo+ID4gKyAgICAgaW5zdC0+ZmgubTJtX2N0eCA9IHY0bDJfbTJt
X2N0eF9pbml0KGZ1bmMtPm0ybV9kZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpbnN0LCB2cHVfbTJtX3F1ZXVlX2luaXQpOw0KPiA+ICsgICAgIGlmIChJU19F
UlIoaW5zdC0+ZmgubTJtX2N0eCkpIHsNCj4gPiArICAgICAgICAgICAgIGRldl9lcnIodnB1LT5k
ZXYsICJ2NGwyX20ybV9jdHhfaW5pdCBmYWlsXG4iKTsNCj4gPiArICAgICAgICAgICAgIHJldCA9
IFBUUl9FUlIoZnVuYy0+bTJtX2Rldik7DQo+ID4gKyAgICAgICAgICAgICBnb3RvIGVycm9yOw0K
PiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgaW5zdC0+ZmguY3RybF9oYW5kbGVyID0gJmlu
c3QtPmN0cmxfaGFuZGxlcjsNCj4gPiArICAgICBmaWxlLT5wcml2YXRlX2RhdGEgPSAmaW5zdC0+
Zmg7DQo+ID4gKyAgICAgaW5zdC0+c3RhdGUgPSBWUFVfQ09ERUNfU1RBVEVfREVJTklUOw0KPiA+
ICsgICAgIGluc3QtPndvcmtxdWV1ZSA9IGFsbG9jX3dvcmtxdWV1ZSgidnB1X2luc3QiLCBXUV9V
TkJPVU5EIHwNCj4gV1FfTUVNX1JFQ0xBSU0sIDEpOw0KPiA+ICsgICAgIGlmIChpbnN0LT53b3Jr
cXVldWUpIHsNCj4gPiArICAgICAgICAgICAgIElOSVRfV09SSygmaW5zdC0+bXNnX3dvcmssIHZw
dV9pbnN0X3J1bl93b3JrKTsNCj4gPiArICAgICAgICAgICAgIHJldCA9IGtmaWZvX2luaXQoJmlu
c3QtPm1zZ19maWZvLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluc3QtPm1z
Z19idWZmZXIsDQo+ID4gKw0KPiByb3VuZHVwX3Bvd19vZl90d28oc2l6ZW9mKGluc3QtPm1zZ19i
dWZmZXIpKSk7DQo+ID4gKyAgICAgICAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIGRlc3Ryb3lfd29ya3F1ZXVlKGluc3QtPndvcmtxdWV1ZSk7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIGluc3QtPndvcmtxdWV1ZSA9IE5VTEw7DQo+ID4gKyAgICAgICAgICAg
ICB9DQo+ID4gKyAgICAgfQ0KPiA+ICsgICAgIHZwdV90cmFjZSh2cHUtPmRldiwgInRnaWQgPSAl
ZCwgcGlkID0gJWQsIHR5cGUgPSAlcywgaW5zdCA9ICVwXG4iLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBpbnN0LT50Z2lkLCBpbnN0LT5waWQsDQo+IHZwdV9jb3JlX3R5cGVfZGVzYyhpbnN0
LT50eXBlKSwgaW5zdCk7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiAwOw0KPiA+ICtlcnJvcjoN
Cj4gPiArICAgICB2cHVfaW5zdF9wdXQoaW5zdCk7DQo+ID4gKyAgICAgcmV0dXJuIHJldDsNCj4g
PiArfQ0KPiA+ICsNCg==
