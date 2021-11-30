Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46615462F55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhK3JPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:15:38 -0500
Received: from mail-sgaapc01on2116.outbound.protection.outlook.com ([40.107.215.116]:46817
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239975AbhK3JPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:15:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPU2+Nmwy/gYUBlEqHWerx5zaPtBfHg9RQiafKoJoEpPohhhmzaseDZJ5JUNl8HEsafCP4PJIGMKkGfX8kmybi9jwvFmVs1nmd1cs2totD6U4PU56AoKqsJsR9FNKprIXFhb3NI7rDs6fRDpHgx8HQ/YW/cTnwUwCyDmhlzBjuM7qCFi5J4Py2Mj5h2yXUmY6R/BunUr+fmi2mkx4zIWZg6X36jOu9+XLu9FpW4psmr/uBwippQFf1w7HWEFitPVXSlSQc2HAh1K0f82/hTlDFFzw0bdDyG4Qm1nnLw9Oi3fkh6k90i6X9/lapy4p4YFRq3Lb8RSFUaTd2AHAjnMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhgf5HWvsYaMgDQB7f1W3qliWsFVSY9Udij0Ud2rSgg=;
 b=XePd/nlzwVwZB+pMCvUM6q2JUxeU+kypIMp9aTOHzXXD6qtEYIh/T6hC0wmHRi40FQQSXfA13LNAWwayC1ZryvP3SBB1U7JB4L7BSB+8o4EfV+8ItXNp8bEYYo5Hv2OD62PN1HpKgCR6W7RqWVgK59ucXMDAKkN+z3fCVIUt7LaOQ04Pi0mCFAK07B6Vzabgn8VpHxbmIvqVKJzfhQtimKDvYTVbiRz231fh7dcAcnQfeaLNPHpeYuO3j61dfJvmlbzQ/wIvXCAStfuORsLzBH2LBAKoOfNS1ku6IzEaaZHp7yulDFQ8gk6nVTgVNsqpQi3o1cRXt2Nra3dN1xUrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhgf5HWvsYaMgDQB7f1W3qliWsFVSY9Udij0Ud2rSgg=;
 b=UjnTbkimL1sB7iFsHytWH5gielxkPyv1ht2js7gPnHEKFi8AV3vDqnsQqekfq7uRxBzdYVZlg0/mSBNXs/HNsjTxIMh4EqBB6d0Uv5gmdyjLrPUMHw6kIT7UmnXH5szhoWhouJWx6OthHMcNmHsxNyExmUwdjWISpxg7ujzHtCwHKGn/gFmAC7J4ULweOqh3pCbZw5gQJd9s2KY0LdG0bdoeLanGmwtqqxpsep9LqJy5c9Oxp7iypB8DnHt9d5C8rWe3UhqRFRe3mRisYPw2wCZvg/FGCw5S0LaeHUnaaBwM85BVAP1N/x/Gmus/Xcrv8hcYtiHQLuUUyvRP3rZsjg==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK2PR06MB3330.apcprd06.prod.outlook.com (2603:1096:202:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 30 Nov
 2021 09:12:15 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::7941:2fad:3c82:52eb]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::7941:2fad:3c82:52eb%3]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:12:15 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH] hwmon: (pwm-fan) Let ctx->pwm_value be assigned only in
 __set_pwm
Thread-Topic: [PATCH] hwmon: (pwm-fan) Let ctx->pwm_value be assigned only in
 __set_pwm
Thread-Index: AQHX5ZZIiry9UUnfAUqsCJRIYxGT8qwbo1UAgACsU4A=
Date:   Tue, 30 Nov 2021 09:12:15 +0000
Message-ID: <706A57A6-C34C-425B-B432-2CDF18A344B1@aspeedtech.com>
References: <20211130030046.3920-1-billy_tsai@aspeedtech.com>
 <20211130065526.jqm7ix62y6om7ovw@pengutronix.de>
In-Reply-To: <20211130065526.jqm7ix62y6om7ovw@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09094648-e4ea-42d5-81aa-08d9b3e180ab
x-ms-traffictypediagnostic: HK2PR06MB3330:
x-microsoft-antispam-prvs: <HK2PR06MB3330926E8706D9809475359F8B679@HK2PR06MB3330.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:416;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ARnja1wOHlwmEqRa0cPvsxwjH4spWMtrzkF3Mw87k0+a56l9G78b0AZEhe6iK4K0cJyI4VMJfX5SZSqnWf7iBhIOn9HSY1RXeAP8fqinTk4UZCiRuMh35EbwRBOp8EluRbeRMbmu1X1XYnu3RpgQxHAR7p/rVpaUQkNfn0iluF1K+jVlT1j93ZcLBitOLJpQY3UJOnXgT22sSWRN2PyjQCCyrz4hQBLxv9xggjAGlTpkzlWsJQHXyagB7xqP2AVABNEqeECU69uFv2KI8MvrqtqiCWHUoIt2DeatskhVqN8eoo7nwR7pfu5gjKUbEMS0fS+Mlqbg5MV8JjeGnXLva9bmhPUJIdlK5Vw1E94QJxSS4otkIw33fZzpdGE/9Nc7Eq2jQPkF4Fownk/0R4q4Y0rfF5W6D0Z9o49myCTMAc2oPIBw9Uayk7k6WgpT9Q22nTJRZd8vxwrySYYwbsgMgBlyaWvL/6lp4myG4Qyb8AjgPH0GvztbQmE65L+M2DiPSm9YkYkC9DaApP+ToBuoNiv9qHdU0Ebl+AriXcxEZNNmJASYgW+/yhpxYWW2w5PchOm+cVM6YZNq5nGYF6n7ImJVR3K86QBte3XLylJ014soIBAvJ0LhU+FnLBpDT3Ja5/8XRw1/6JfxmrxS8rWSAIILXypOR30a+27NsZD33EjfYZfR2R+n1HhXI9CciFRhgyyUfsANkcOhtS/tHlVhITus/ZUub38ctmHoD66B9YuE8591JR5rI9T71nmZBe2u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39850400004)(366004)(346002)(136003)(66946007)(4326008)(38100700002)(54906003)(66476007)(316002)(76116006)(122000001)(6916009)(36756003)(26005)(33656002)(86362001)(38070700005)(83380400001)(186003)(508600001)(107886003)(8676002)(6486002)(8936002)(66446008)(71200400001)(64756008)(2616005)(6512007)(6506007)(53546011)(2906002)(66574015)(5660300002)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ylc1S08wMU4wQ29nVGpyMnJ6S1NDdU8waHRFRXU2bW03TzV5TmRmd1A0QnNP?=
 =?utf-8?B?U2h5N2FiUjliZ3VtcHhLa202SGVTc2NEWFl2ZHBxZmpXa1RXbHM4dXU4Wm10?=
 =?utf-8?B?T1JwY1lqSkZ2MWdpanljbWxQNmtuVHExNEtsOE0yUmtjSWtJTCtmV1JNWGps?=
 =?utf-8?B?QjYycVdDSEZtNDlqbEM2a1RVaGh4VHBkVUI3aFI3MWJodVZZbHA3ZEdJRFVu?=
 =?utf-8?B?U21kWm1CK3QrT3o3WC95MnR0M1ZKcjZucUU3VTJNTEFoQ0JzbkpWcG05RDRD?=
 =?utf-8?B?ZzVJYWlTd0dZa1p4QWt2VEFaM1d6MEVldmp0QXQ3MnZidTFVclkxbW5sMVZk?=
 =?utf-8?B?RExsVlBoa1NaSFZNWXc2bnkybmF3eTZnVkdrY3Z2MFdPWTc5eFFGay91c2sw?=
 =?utf-8?B?Ti9qMGRsL1RwR1NNUmpzam5WdExNVnNGZk9WVGpnQ3UrcEFRcU14RTZIVVhy?=
 =?utf-8?B?NnlTQjVjSmVOS1BrblZJdFVwcG54Y2VSL2k1Sk9hMTBKaFdrQ0hzM2llS0hx?=
 =?utf-8?B?Q0hsSVRqT3cvSTk5MUF2WDltSkwwcVRXSi81YjFTY1hmdGdvQnBwUWNCOWlW?=
 =?utf-8?B?alpFSGlXc1UrVzk3eU1UWGh0cDlIR1hpZElta2tUUWJaV1hJdTM4WUVzWU1R?=
 =?utf-8?B?T0pHMVV6RXVGQkxNdmJDZzdVSU1xY2YwZnNLaEZ5R252emdGbmtQbE1rWHRm?=
 =?utf-8?B?ZVN2Qk5MMU9VMHRZaGI0NXkvMk96V2dTc3BXbkZ1am82aU9DSVNDakxpRmNo?=
 =?utf-8?B?SWxBUDh6NnIxVUlqQ1NnYjIzSGRGWUJoY1JzOHV5aVpHd2NFdFlTVU85Zm15?=
 =?utf-8?B?TzJWTTE0c2RwMzZrWGNjRW9pSXhNUExOeXlqcnNZOEg0aUliejZrRnhVcGx4?=
 =?utf-8?B?eW95TmIrMkRYaDZML2lnV1BTQUNHTXJWdFJESDRRZ21USTIvbjAvNGRtQ0Uv?=
 =?utf-8?B?dTMxNklDMHB3OXI3SzArM3l4aEkrbGQ3eFhIUlNXZkV0Qk5Cc25kSjY5K0p1?=
 =?utf-8?B?bzFLTkFDYlZKSjhUWUtCV3pDeTQ2U3ZNQllteXpCMEtjM094M1M3WlZLK0RP?=
 =?utf-8?B?NXdwQm51eDk4Sm1xRVAyaEtEQVZYY3Z1OHdJeWhmazFManBSdkswdm83WUIy?=
 =?utf-8?B?YmxYYmE0K1lwMEZaQVhBaU9nWFB1TkdJNlgwQ1lHV3NCbFcza2REVERFazdT?=
 =?utf-8?B?RkQrR2xKOWZKUVNPeUlZZ1dJUThkcFdlREJCOWswOHlVN2RwV0tXU2RJVUJh?=
 =?utf-8?B?T3VISWFzaUx2MVR5Y0Z0N3ZlMmE1QUlPQkt5dkFTUWFNQnlIakNmdXREU3pk?=
 =?utf-8?B?NzBwYWd5TXRkK1NtbDlLQ0ZJYmJvd1BPTmI5QUYxTTdIandlVGhoLy93T3VO?=
 =?utf-8?B?NjNIZWZQeDBXN25sakVhbzYrd3YwVFJIMHJDdHBuM2tXSGpkdFgrMHlhM3pX?=
 =?utf-8?B?L3BVdmM1d1JRUXFDbGtHUy9xOTdBZC9MTmlXaUprRDAybFdHTmx1S045V0FY?=
 =?utf-8?B?OFZkNUhRQWhndEgzdFQzb2R4UFh4UTkzM0F1ZmZkN1lWOG1jdy85Z0VDZ3Zt?=
 =?utf-8?B?NUJ6MzVMeGJXNWxlUmNyd0hKbkpzcE9ydG0rdVdxMVNOZjMyM0REQnAxa2Js?=
 =?utf-8?B?OCt3Zzh6ZzJ0ektLRU5iRnVpb0FOQm0rUmlpc0VBK1o5RVFpeXpmdllxNlo2?=
 =?utf-8?B?MTFrOHZXcm9TM1YwakMvQzEyTVF6NXVGbzkrSDhyczZGZTViZTVYYkYzKzVZ?=
 =?utf-8?B?NFFNV29IT1d4ajhKbjZmT3hsanJCR1VJRUZKWjZURGtMei9VWXJQY0R0SkZP?=
 =?utf-8?B?M2dMWFRUUkVGbi9hZHNKUDU5MW1EYjBYTWg1ZDVrSEl2akdsaEZlUm5ERU5U?=
 =?utf-8?B?V1oxcitiVjJwSjVIKzZyOFRwRjUwLzA0VGdOckkwNnRzL3JtalNnZlVUeU1z?=
 =?utf-8?B?Zk5aR1dXeVB0MC9tWkc1c0dxODluMkN0U2FFTlowRG9NcjRLV1NrWlV4RmR4?=
 =?utf-8?B?UmtiR0RFOHphRW41T0tPMVFhZW9wcEx5ZWpONThycXcrU3pUdjJ5TG5UTVlS?=
 =?utf-8?B?OWZURTQrc0FyVllLSXh6RXpad0VUc3RGZlFwa29zT2VHelZxcTVNNGhxSzlB?=
 =?utf-8?B?THlkSURPM1l1N0JOZkFCY2ovd1A4bWJRMHk1azlSTkxXSEE0UkgrdXBFb3FY?=
 =?utf-8?B?OUxMWU1oNmY2K2R1WHZvLzI2L29qQXlma2tya3A2Z1N2b3NVcTJheU9xTHF2?=
 =?utf-8?Q?3xdZEYD8EBpNnJzfrmyjIZiDFqGCh+r6xU48z4Eiek=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC07E5FB57104D47A4EA84B6BB05F905@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09094648-e4ea-42d5-81aa-08d9b3e180ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 09:12:15.6573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xfzkxnv7DwT98vg+9AHI2LqGfspLwpdg56vpEgC9QBEm4csvBd2UvpvAVS7Ioz9uWbuBH2+69sGSCSfNMtZdjFdyHjRFrnWgMFEJ0LjUPqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3330
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVXdlLA0KDQpPbiAyMDIxLzExLzMwLCA0OjIxIFBNLCAiVXdlIEtsZWluZS1Lw7ZuaWciIDx1
LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOg0KDQogICAgSGVsbG8sDQoNCiAg
ICBPbiBUdWUsIE5vdiAzMCwgMjAyMSBhdCAxMTowMDo0NkFNICswODAwLCBCaWxseSBUc2FpIHdy
b3RlOg0KICAgID4gICA+IFRoaXMgcGF0Y2ggaXMgdXNlZCB0byBmaXggdGhlIGJ1ZyB3aGVuIHB3
bV9mYW5fcHJvYmUgdGhlIHB3bV92YWx1ZSB3aWxsDQogICAgPiAgID4gYmUgb3V0IG9mIHN5bmMg
d2l0aCB0aGUgUFdNIGhhcmR3YXJlIGRyaXZlcnMuDQogICAgPiAgID4gDQogICAgPiAgID4gRml4
ZXM6IDg2NTg1YzYxOTcyZiAoImh3bW9uOiAocHdtLWZhbikgc3RvcCB1c2luZyBsZWdhY3kgUFdN
IGZ1bmN0aW9ucyBhbmQgc29tZSBjbGVhbnVwcyIpDQogICAgPiAgID4gU2lnbmVkLW9mZi1ieTog
QmlsbHkgVHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4NCiAgICA+ICAgPiAtLS0NCiAg
ICA+ICAgPiAgZHJpdmVycy9od21vbi9wd20tZmFuLmMgfCAyIC0tDQogICAgPiAgID4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KICAgID4gICA+IA0KICAgID4gICA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2h3bW9uL3B3bS1mYW4uYyBiL2RyaXZlcnMvaHdtb24vcHdtLWZhbi5jDQog
ICAgPiAgID4gaW5kZXggMTc1MThiNGNhYjFiLi5mMTJiOWEyOGEyMzIgMTAwNjQ0DQogICAgPiAg
ID4gLS0tIGEvZHJpdmVycy9od21vbi9wd20tZmFuLmMNCiAgICA+ICAgPiArKysgYi9kcml2ZXJz
L2h3bW9uL3B3bS1mYW4uYw0KICAgID4gICA+IEBAIC0zMzYsOCArMzM2LDYgQEAgc3RhdGljIGlu
dCBwd21fZmFuX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogICAgPiAgID4g
IAkJCXJldHVybiByZXQ7DQogICAgPiAgID4gIAl9DQogICAgPiAgID4gIA0KICAgID4gICA+IC0J
Y3R4LT5wd21fdmFsdWUgPSBNQVhfUFdNOw0KICAgID4gICA+IC0NCiAgICA+ICAgPiAgCXB3bV9p
bml0X3N0YXRlKGN0eC0+cHdtLCAmY3R4LT5wd21fc3RhdGUpOw0KDQogICAgPiAgIEFoLCBJIHNl
ZS4gVGhlIGVmZmVjdCBpcyB0aGF0IHRoZSBGQU4gaXMgc3VwcG9zZWQgdG8gYmUgcnVubmluZyBh
dCBmdWxsDQogICAgPiAgIHNwZWVkIGFmdGVyIHByb2JlLCBidXQgdGhpcyBpc24ndCBhc3NlcnRl
ZC4NCg0KICAgID4gICBTbyB0aGUgcGF0Y2ggaXMgZmluZSwgYnV0IEkgc3VnZ2VzdCB0byBtYWtl
IHRoZSBjb21taXQgbG9nIGEgYml0IG1vcmUNCiAgICA+ICAgZnJpZ2h0ZW5pbmcuIFNvbWV0aGlu
ZyBsaWtlOg0KDQogICAgPiAgIAlod21vbjogKHB3bS1mYW4pIEVuc3VyZSB0aGUgZmFuIGdvaW5n
IG9uIGluIC5wcm9iZSgpDQoNCiAgICA+ICAgCUJlZm9yZSBjb21taXQgODY1ODVjNjE5NzJmICgi
aHdtb246IChwd20tZmFuKSBzdG9wIHVzaW5nIGxlZ2FjeQ0KICAgID4gICAJUFdNIGZ1bmN0aW9u
cyBhbmQgc29tZSBjbGVhbnVwcyIpIHB3bV9hcHBseV9zdGF0ZSgpIHdhcyBjYWxsZWQNCiAgICA+
ICAgCXVuY29uZGl0aW9uYWxseSBpbiBwd21fZmFuX3Byb2JlKCkuIEluIHRoaXMgY29tbWl0IHRo
aXMgZGlyZWN0DQogICAgPiAgIAljYWxsIHdhcyByZXBsYWNlZCBieSBhIGNhbGwgdG8gX19zZXRf
cHdtKGN0LCBNQVhfUFdNKSB3aGljaA0KICAgID4gICAJaG93ZXZlciBpcyBhIG5vb3AgaWYgY3R4
LT5wd21fdmFsdWUgYWxyZWFkeSBtYXRjaGVzIHRoZSB2YWx1ZSB0bw0KICAgID4gICAJc2V0Lg0K
DQogICAgPiAgIAlBZnRlciBwcm9iZSB0aGUgZmFuIGlzIHN1cHBvc2VkIHRvIHJ1biBhdCBmdWxs
IHNwZWVkLCBhbmQgdGhlDQogICAgPiAgIAlpbnRlcm5hbCBkcml2ZXIgc3RhdGUgc3VnZ2VzdHMg
aXQgZG9lcywgYnV0IHRoaXMgaXNuJ3QgYXNzZXJ0ZWQNCiAgICA+ICAgCWFuZCBkZXBlbmRpbmcg
b24gYm9vdGxvYWRlciBhbmQgcHdtIGxvdy1sZXZlbCBkcml2ZXIsIHRoZSBmYW4NCiAgICA+ICAg
CW1pZ2h0IGp1c3QgYmUgb2ZmLg0KDQogICAgPiAgIAlTbyBkcm9wIHNldHRpbmcgcHdtX3ZhbHVl
IHRvIE1BWFhfUFdNIHRvIGVuc3VyZSB0aGUgY2hlY2sgaW4NCiAgICA+ICAgCV9fc2V0X3B3bSBk
b2Vzbid0IG1ha2UgaXQgZXhpdCBlYXJseSBhbmQgdGhlIGZhbiBnb2VzIG9uIGFzDQogICAgPiAg
IAlpbnRlbmRlZC4NCg0KICAgID4gICAJQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCiAgICA+
ICAgCUZpeGVzOiA4NjU4NWM2MTk3MmYgKCJod21vbjogKHB3bS1mYW4pIHN0b3AgdXNpbmcgbGVn
YWN5IFBXTSBmdW5jdGlvbnMgYW5kIHNvbWUgY2xlYW51cHMiKQ0KT2ssIEkgd2lsbCB1c2UgdGhp
cyBjb21taXQgbG9nIGFuZCByZXNlbmQgdGhlIHBhdGNoLg0KDQpCZXN0IFJlZ2FyZHMsDQpCaWxs
eSBUc2FpDQoNCg==
