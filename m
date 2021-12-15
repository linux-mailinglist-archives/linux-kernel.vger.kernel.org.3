Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FF0475A60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243227AbhLOOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:14:34 -0500
Received: from mail-gv0che01on2131.outbound.protection.outlook.com ([40.107.23.131]:22426
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229563AbhLOOOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:14:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2NqoBU/qKfKwe6I7CLwLtiI/HCso1mfIfDvFMFFY34iDy5KISbeM7pJ0u4DpEmkeZQGIjR1DBk7baIGm0sSuzy59Mo8vk6enFlw/TzCQrgGGkYJRzCcNAR863ZCbuxPEQtT9F4bzghV8zATWDkFhQkPiMhm3RB8o4YbDW82xWH0M9JXWoITtUDNBHa90Zm1LVjIkZJLs8vwZZPALgAIdLeNwKIXqWR/RTmTzuk9TcUdhgNp9Qmtwtq+7LdA+PquledtumcSRVtoxCK7vp5MrcPgRF+YsR7itRYfdZ+HYMGVcp2KFW2Vs4fNbWDZTkDNiKQ6hxO+7Xt/qzolz3oB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQKUgJscRCfG4CG1uDLCJYDiDlgpUBgP/sDfGeCBeb0=;
 b=Ys8vfr0csh+4wYtvYxnvnCil/pdHR/7zMGaEIL3zRdrEjdoA/zmLtRL2qo7PZVUjSF31+4dCZeO1wZwrD46Vroqv+naqlQDULj/DjKWQhUxtYD6HUM4zfXlrTj7PA8LVxdtiK2iuvZQ7U+PkbBH2B6vsAkn83Q9YG61JQYi6vLXAh4kLW7ef+rij7+eX6/sKHhhnPX0Y0VfgeqDR5TpPumgS6ykShaq7SXRRefRjwZm2+j0m51PEWpH46yi0Nd3ITvolNfAWA3UbyWNomHW3zYrIpIWYapBCCSE+HtVLCzY9/KRnkRuc/4GI+XU49UAmz1lSf9euq3deNyTswa3l8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQKUgJscRCfG4CG1uDLCJYDiDlgpUBgP/sDfGeCBeb0=;
 b=SyR8sF3ka33nucK0sgn8VKAogjKZIXh6LmPP4Tn+9E0//4KAsOiwDc/lPXZZkKus8FwP0ET2M8afRCgxs0KAk0u9rXmLdNZloQEEs/iYaU2Th/GVZJjqDhWPEmfUia28T8ZpqyZiifYM4In+LGbJbBdg1q+GYebZfXCnEoM9N+s=
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0301.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Wed, 15 Dec 2021 14:14:30 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2de2:ea03:cafb:56c1]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2de2:ea03:cafb:56c1%6]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 14:14:30 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "kishon@ti.com" <kishon@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>
Subject: Re: linux-next: build failure after merge of the phy-next tree
Thread-Topic: linux-next: build failure after merge of the phy-next tree
Thread-Index: AQHX8bqV5MNcOiqp+kyIvR5Ddt4fHqwzmLEA
Date:   Wed, 15 Dec 2021 14:14:30 +0000
Message-ID: <82dcdd84d9111dcde3fb43504ffec5592e2c8356.camel@toradex.com>
References: <20211215134915.3622957-1-broonie@kernel.org>
In-Reply-To: <20211215134915.3622957-1-broonie@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04c2b58e-3e40-45f0-e852-08d9bfd53613
x-ms-traffictypediagnostic: ZRAP278MB0301:EE_
x-microsoft-antispam-prvs: <ZRAP278MB0301AD747B9C089A1A422183FB769@ZRAP278MB0301.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h44/UvUjMST/rChuk6uag9VB97MXeE/Rd9RCdfYa80CWjkSK+zP3zy4znyDu0Z5fg4LyBBEw0lS63gsphh581m0i7ITp5aTDmxzFVM3XDSa3eWEKYKP3/f8WRNQ8AZ36HJ/Q5mKghCiK6nNYiYsso31BrPX41o05VSwXbZJQKyIjnEjrR/v5eBLH1TzNtQ5HRXtRooSn0kMZX82O7Uf7yehS7UjtSi9LUawYLaZ86n55PRb4g1SggJcFHVugVCcSXFQgD73TJ4d7agWM4heVMlQ4I7JnpqUm7jgUw/lw9x5uznSo9MOanNygl+aAmSSQwkcJPIynV1fo4lWQICcwGIUMmZeh/deWzta8UP3y1drBAyB4+2cnPIYMwjZAiONqPDlszoeJoLfGZjswRBd2APU6OyB2OCNRV4EUqkEd1r9A88qW+gPc1uPsyO1rTpxA+U5QrCOPUdYO2CXVQK/p706YnMMZhVoqzmQYJ/31wg85FqCTzZqkf6QuNnblOCFM1Hp85Zs08i2XMZ7mWJ7yZxd2kCjw+U/Qp5KATg5/S9VjxFkrkVMA1e4HfYfwIfJtTHYvoDCMGazqdHBvxbt47wowIR0QC3hGAQZCWJNxJTPbihcS8ANuaN9YCsyBG+TX8ccaBAMylRTeKQThIxLW/BJsIIxkDJmNBnBoXC8uDdcrf+v6msddgeRwuRuQCiGVq166XouwR9Y0NoDDKvaEIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39840400004)(376002)(136003)(38070700005)(508600001)(122000001)(54906003)(36756003)(5660300002)(6512007)(110136005)(316002)(86362001)(26005)(6506007)(71200400001)(44832011)(8936002)(4001150100001)(8676002)(2906002)(186003)(2616005)(83380400001)(6486002)(91956017)(38100700002)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG5zWUhtWjE1Mjg3UG8xb0JSZ2pMa0p2NnNBL2p5ci9LR2NRUVAvOUxvVU1S?=
 =?utf-8?B?bjJHSGcyaVI4eUlraFJPZW9kRXN0a1lMNmQ3VGEzamdjb2NQNnd3VGlhaXJM?=
 =?utf-8?B?MmM1TG03TnFhVWxoQW95eFcrN0prdHFsQURKM2JJZmV4TFU1anBDT1RCMDdN?=
 =?utf-8?B?anRvNVJTU2hXWVdYMytmdzR6Qis0aWpXTlZxV0FhWTFTejIrMjRrVTQyMW5G?=
 =?utf-8?B?TndoZ1d3ekZiMjhMaFBBK2tkdm5DYytiWjYvMlZGZmU4RkZlLy9VNXpkK2xY?=
 =?utf-8?B?bUZiSmUwa0Fwd01OVUFBUjN2dktlVDNVZUJIcVdHSnBmUEg3dDkvTHlTY25B?=
 =?utf-8?B?RDQrL1lPVzl3ZE9QNnNpNDJzSVZpeHFYYWw2a01vMy9HUVdkdFBaVi9QSk11?=
 =?utf-8?B?TDZnd0R4WGtFcVNnV01BbXpKbm9VUGhzNjZydHdwdUp4cEhCVW5sRExEOVpE?=
 =?utf-8?B?ZTF3NHdncnl3cFZhVmllNEQrR3hVTDNqOEhEbmdQNmc1Y0lVMGdQdGs1WHh4?=
 =?utf-8?B?YldQbjJBQWVqVnZKSWZzckhydmZqRmVqY3pyOE5Xa1UzTzdLRzY4YVJIc2lp?=
 =?utf-8?B?SFlab3VHSFdmczRBUHdxZUU2R20zdzlya3VOUHVOczFRUzQ4NThuRHh0djlO?=
 =?utf-8?B?cXJTZXJvaWpoQzRRZW0vSXJWNUFlOG9aR21Tc1JhVzJmYXc0SGROaVRQUTl0?=
 =?utf-8?B?OWQ0cloyaXp2a1VvNDBjT256ZFpKcGcvZTFYd0svbkpOWWZYczlvSGxPNzgv?=
 =?utf-8?B?LzJyOEszSzhBMkt6QnlzSXlKV3lwekJLZkFRZmxvQUpqZkZFVFpPT1FrN2Vk?=
 =?utf-8?B?bXZseHJxdDNmY0pJSXkrUHVYMFJ1YnlDTEs5eEFvSFptTVJsQ0ZwTnZSVnBt?=
 =?utf-8?B?S1NtTkRpQjRUQnZJakNSS0xHbVBpS2FhV2FtZlNrQXQ1dTh3bFJJKzV3TG05?=
 =?utf-8?B?eXZTaHJkMmZVejlQSDBxaURDQTdLMU8xRSsweWcraXFnVVc5bzY2cHZGRE51?=
 =?utf-8?B?ZHJ6U0lmMWt4STlRb0JHcUFvMjZzYWZSWHNLRzdYOE9RWXVPcEVqL0xTQUo3?=
 =?utf-8?B?YnkvZm4xb3pxMmE4cW1mS1BPOGV5OVBvVlFEYndwTklpKzluNHdRdjE5bE55?=
 =?utf-8?B?aGhCbXorRXZ5c2JYc1M0bXkwazNuZ1FpN09RV0RPdmNwYXRYRmI2VlVvT1pt?=
 =?utf-8?B?RUNKK2NHTjFCUzN4QUZoa1IzUlM1ajBpWVJrQktPeDlEOVB2ZXJRdWpjMHJU?=
 =?utf-8?B?UUlSNWZmYzFrcjNtTHYxQjFWeEdkQ0JRaVc2c0lIc2tyVmlwWUNQbHB1N1I1?=
 =?utf-8?B?ZnlweS9EcURieTBwTGlWOFZUdFJhRnJsYXo5Yy9oaDl6Z2ZWSzRJcjhpWkVS?=
 =?utf-8?B?YjF1cnE1cHRQTWt1b2tOeURTTWZXS2lGQlN2MHRkZmdjcUkyMk54cjFUQlZU?=
 =?utf-8?B?TVpNeitJcEZQRnRvcmZHRWVlb1VSM2JicVNyMU8wVHN3OTI5eHZLWmpobWdy?=
 =?utf-8?B?SFVxUi8vUG93aVhsMVBpWmVpdzBqeEd6SjMzTHhlVDZYb2p0NlhJc2VERldu?=
 =?utf-8?B?eklxZ1lnNkxXTDFSUWZ0STVpVTNqZDdHR0Q2WFlPck9qZlF3dlVVY2M5N0FL?=
 =?utf-8?B?TlVxNEIwTHhFU0xqUzdnZHZJUzkvaDVZYnRYSDROUTU5WkR2MnpWMHlpZDFk?=
 =?utf-8?B?SzFqVkNMcFhTdkxpTGtNcE8rUWJ6aGFsRlJLU0xwZGREbUxlVy9XcENPNE52?=
 =?utf-8?B?ZTdlUkNoanlHWG9vSWRpYitnVlJxMWJoQUFpWE04V2d6Q3RLZ1NxWUZWYmoz?=
 =?utf-8?B?MW15Ym9HNEY0QlVnNnYxSzgwNi80QXVWNGpGRklKa0crTDJvbkpySmNBY1Uv?=
 =?utf-8?B?d0pYTDVLamJOVXM5RjdlK0RwNTRkMUVTZ0ZtWEtHR1lrakkvTDg2TXprUTQ0?=
 =?utf-8?B?enF0MjVDbm90UE5JQzFTQWM5MDhBRHRiSFZzS1lYZ1JvUU13UTVyd21rRWZ1?=
 =?utf-8?B?QkdaaG5FMkdVZnJkUXFqeU1nYjBNSlpNSHZvU2ExaU1sRlVqeSt5SE9qTi9o?=
 =?utf-8?B?MWFHTHBaKzBnL1ZUc2Uxa05QcHNQeHhwZTZNU1pWTm1Wd016cHl2ZXdTZ1F3?=
 =?utf-8?B?R2trNnkyRlNxMkU1eGZQWVBpSEVJZmd3NFVGT1ZvZE5mWUNMTkVxODZrNXgy?=
 =?utf-8?B?L3JtUzJwdmFuVnhZNXNOenpQNjloYkgwMXQ2aXVWRkI2WUNXczNjNFYrUnU0?=
 =?utf-8?Q?DDK1CIF4/Zc8lslSDe3nt/opU2kT2CnwjP5JYLxcEg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <973B2AE12486F84EABC0D07F62CFE75F@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c2b58e-3e40-45f0-e852-08d9bfd53613
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 14:14:30.4614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+hYZO/HHMqJhHUfYkrHO9zrOSOEum7vSWU11+ss2rnlCKJjyH6jdhKK4S/7ms3Ic8tcNcuMAA+mawd+dmMgEcidHisC7iIfODisIm+gcqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0301
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTEyLTE1IGF0IDEzOjQ5ICswMDAwLCBicm9vbmllQGtlcm5lbC5vcmcgd3Jv
dGU6DQo+IEhpIGFsbCwNCj4gDQo+IEFmdGVyIG1lcmdpbmcgdGhlIHBoeS1uZXh0IHRyZWUsIHRv
ZGF5J3MgbGludXgtbmV4dCBidWlsZCAoeDg2XzY0DQo+IGFsbG1vZGNvbmZpZykgZmFpbGVkIGxp
a2UgdGhpczoNCg0KSSBhZG1pdCBJIG5ldmVyIHRyaWVkIGJ1aWxkaW5nIGFueSBvZiB0aGlzIGFz
IGEgbW9kdWxlLiBJIGFzc3VtZSBuZWl0aGVyIGRpZCBSaWNoYXJkIChub3cgb24gQ0MpIG9yIGFu
eWJvZHkNCmVsc2UuDQoNCj4gL3RtcC9uZXh0L2J1aWxkL2RyaXZlcnMvcGh5L2ZyZWVzY2FsZS9w
aHktZnNsLWlteDhtLXBjaWUuYzogSW4gZnVuY3Rpb24gJ2lteDhfcGNpZV9waHlfaW5pdCc6DQo+
IC90bXAvbmV4dC9idWlsZC9kcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4bS1wY2ll
LmM6NDE6Mzc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbg0KPiAnRklF
TERfUFJFUCcgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQoNCkhtLCB0
aGF0IHNob3VsZCBjb21lIGZyb20gaW5jbHVkZS9saW51eC9iaXRmaWVsZC5oLiBIb3dldmVyLCB0
aGF0IHNlZW1zIG5vdCBleHBsaWNpdGx5IGluY2x1ZGVkLiBMaWtlbHksIGluIHRoZQ0KbW9kdWxl
IGNhc2UgaXQgbm8gbG9uZ2VyIGZpbmRzIGl0LiBUaGF0J3MgYSBwcm9ibGVtLg0KDQo+IMKgwqAg
NDEgfCAjZGVmaW5lIElNWDhNTV9HUFJfUENJRV9SRUZfQ0xLX0VYVCBGSUVMRF9QUkVQKElNWDhN
TV9HUFJfUENJRV9SRUZfQ0xLX1NFTCwgMHgyKQ0KPiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXn5+fn5+fn5+fg0KPiAvdG1wL25leHQvYnVpbGQvZHJpdmVycy9waHkvZnJlZXNjYWxlL3Bo
eS1mc2wtaW14OG0tcGNpZS5jOjg1Ojc6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybw0KPiAn
SU1YOE1NX0dQUl9QQ0lFX1JFRl9DTEtfRVhUJw0KPiDCoMKgIDg1IHzCoMKgwqDCoMKgwqAgSU1Y
OE1NX0dQUl9QQ0lFX1JFRl9DTEtfRVhUIDoNCj4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVh
dGVkIGFzIGVycm9ycw0KPiANCj4gQ2F1c2VkIGJ5IGNvbW1pdA0KPiANCj4gwqAgMWFhOTdiMDAy
MjU4YTE5MGQ3NyAoInBoeTogZnJlZXNjYWxlOiBwY2llOiBJbml0aWFsaXplIHRoZSBpbXg4IHBj
aWUgc3RhbmRhbG9uZSBwaHkgZHJpdmVyIikNCj4gDQo+IEkgaGF2ZSB1c2VkIHRoZSBwaHktbmV4
dCB0cmVlIGZyb20geWVzdGVyZGF5Lg0KDQpZZXMsIEkgYWxzbyBub3RpY2VkIGl0IGhhdmluZyBi
ZWVuIGFwcGxpZWQgdGhlcmUgbm93Lg0KDQpBbnl3YXksIGxldCBtZSBjb29rIHVwIGEgZml4IGZv
ciB0aGlzLiBUaGFua3MgZm9yIHJlcG9ydGluZy4NCg==
