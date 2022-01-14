Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17C148EA9E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiANNZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:25:53 -0500
Received: from mail-gv0che01on2131.outbound.protection.outlook.com ([40.107.23.131]:4239
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235222AbiANNZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:25:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbO3KRb9xrQINwHDr6WrHDFnX4JVY2XnNjP2kHpY45HF4EyIBjCxtjbhxtkmQhmU9XrZYgzvNjtlLLpXWe3Iw1DrmBFmZZVRTFUh2SELPffa4B7C7Fd9hPOY4vgf8eIbRgd51ckoZSWtvX6fDxj4bhqwaOl2Kzu67fRg5ZM7ZZHjmrd19O7rYMp/NHW5b6Gfxcx8nOBigIU+tK8i+xfWUAEp1ML6ScZXcAnJZQOzPq+zPnUyJAyK3L9zfxwrjJb98XZiuBUTFnRMIQted3IjPVB+kI8RVHpJjvO1tqAKhp51jMWprezS0Lj2TCM7HmrehgjnZQ9FlW/W9KYbnl4mXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDTzTZc7v5FHP/aNTWJWf/DXtLRSe6KnjaVLFYrVx5U=;
 b=S1fTYE69bTMXkUGp///NkwBXdA0TM+OItcqL1pD/AsYu8qo02MDw87WftxJm7DqJk/K/r266w+gciSNHHTBTMN9kX1Ct3+NJw/3q7fJR/B3a79GHMRhe1X3BPZ/t2VBs6oYc13+yJP18F5z6ec0mY8Mgg+ixrMhfw6dSfBQdvi6kqkRxQaYMjOHs0Aw0V3cIs6UZRrssnPXM5QWTs+NCRy3t+HX6GrkQa7/TNJf6t3B/k15uFz4E5YtXYgmf0SuxORjR7t76Hy0HQKxZVA2NBZZT2n+LTwpWUSh/XsleB8uZtde6JNilGjA4VHz0/oznVJJ6+q8ce96Zh/6EMsLHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDTzTZc7v5FHP/aNTWJWf/DXtLRSe6KnjaVLFYrVx5U=;
 b=YDkA+/bB+SujrwWX8IW5dzR+j1U0Qx2rl8stgI8oQaJfGX+8BgTFY+yQUXgBIqgFUkl+UQikbLnRhOGSG58XzFsuSG6k28ejEbLLl/EF/tyx2cWnugJiWpVly8w5nLzhVYRBrOARU9+BFGFZp0cB3K//RwnvEioMK9WlgFCtItI=
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0443.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:31::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Fri, 14 Jan 2022 13:25:50 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee%8]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 13:25:50 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzk@kernel.org" <krzk@kernel.org>
CC:     "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v1 06/14] arm64: defconfig: build r8169 as a module
Thread-Topic: [PATCH v1 06/14] arm64: defconfig: build r8169 as a module
Thread-Index: AQHYA/D7eO6Fuirq10eoUTMNwfxxIaxb854AgAaY/YA=
Date:   Fri, 14 Jan 2022 13:25:50 +0000
Message-ID: <0b32fc4f62905122042539ab3856fb670cfa0355.camel@toradex.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
         <20220107180314.1816515-7-marcel@ziswiler.com>
         <c3962f91-7183-dd12-f645-629acd0cf076@kernel.org>
In-Reply-To: <c3962f91-7183-dd12-f645-629acd0cf076@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcf8697a-42c4-4703-6094-08d9d76161c8
x-ms-traffictypediagnostic: ZR0P278MB0443:EE_
x-microsoft-antispam-prvs: <ZR0P278MB04431B4074E44BFF1F6A7DC2FB549@ZR0P278MB0443.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AdzO+W9HliG6tnfRIACjibxoYiKSMs0ZTFaKkxt9ieO9ZMIQCQKq1kus2GOG1UZpW/meym+KLMMFjdzFhT/xmrFGO/kOe9HMk8WtPcTwVa0CEw4njzz9ltOzQVzjW4upTD91YQ5g2MAcG63q7Ajz9cXX6eAqeYneme8teorxcsHI808xl4LFrMLq4IGDgZd1wpauu1SkIhQksNwTINV8Ez2fgQz4hYEb4x5HfNVxkHdxR4YMSunXsml/s2O8ea0LZPw+r0kCWhsvtw81AQJh983C61pGRUUSWXNY9+Yt7v0ovgxzYuMDZPbRzTcyzNANjwn6ifKtznc7ScXYelsfkTarnWbhFx1tiScemtV4om61Yc3/4C5IDcc6rD3v1qtgTmMx1BOuQohcLXHAZjlbWL2xY1oZbIMhC/YMYqKPAt+cAZokeKMJ4RM4dKg+nZC2M6JRuq2hFSnEVfE1knXHUtbCn0A2x1CD8F7ZEzPE1ZcLrVSVqJmSKpL3byCwF3NDJ5kneHLF6U98WarP6WxZK/GiTGoP3j1cHnkl/8wtjZqMxN6LPTnjYX6FCAikXTIlmUMKhDKUcnUYXn1ZGZX/2TX8Dyz0LJvHhG25Cr7HecWV6bL9LrSQv6xhHGrCjeK10hx3L30HnMGCIZ1EiYKWZ6aYulLW3OuaenRam1MrBCwNCs7xL3F8FnOHK3TFTssWbi8OzQVL2OPidhbdgoMpBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39850400004)(346002)(376002)(6512007)(2616005)(5660300002)(4744005)(44832011)(7416002)(86362001)(122000001)(38070700005)(36756003)(26005)(2906002)(38100700002)(66476007)(66946007)(54906003)(316002)(110136005)(66446008)(64756008)(66556008)(186003)(71200400001)(6506007)(8936002)(6486002)(508600001)(4326008)(53546011)(8676002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmpEMFZxYUJ1eituajNWNUsrWDlNYTllZkpSN2JhdjMxSWloSDZEZ3hqWWIy?=
 =?utf-8?B?bUFjS2JHSDZhenpWUGo4Nm5NNWZHdDZhMFV1cE82RE1zUlVZSStBb2lERUFu?=
 =?utf-8?B?ZzlpQlJUTlMzRXd6UVMxZUN3S3lOREx1bTJNQW1MbTgzU3JUMVZMVTNqd0Nj?=
 =?utf-8?B?NEVMemhJenloQ3FuaGR5OG5QVkdaejEydzBJQ212NWUvWFVVdG5tT0FZUE4x?=
 =?utf-8?B?aHRnR2J5dlNRYUl6Y0FnaytkcnNNMXptWU5NTDQrS1BDR3VZUEFOYmRHRXZM?=
 =?utf-8?B?Q29GMEpxMWU3RjBRMDFLV1JobUVPbTJQZjBhL3dhQ2hlRkR3T3h6M3phcXlu?=
 =?utf-8?B?Rjg1bVd5MnNoc0x3SVBRdWlGRzcyV3ZFN05sZW5Wb1pjZXVwM0tCWkUrSk91?=
 =?utf-8?B?S3BESWNQSEdPZnU2UmdSYlhRTFk4Rnc5QXg4Q1MrOTFWcnRFRStCTHVlMTFv?=
 =?utf-8?B?RS9NeTBKTG50SzNrZzI5djNXZzNIeWNLclh5TUVHajNuLzlZYi91azVOVHRy?=
 =?utf-8?B?ZFdWT1YrZVpRVit0eTd5bVcxWmdoNVZpampxSDVjM0VrVm5YelAxZjJWWmtH?=
 =?utf-8?B?RFJ0OWV4b0tlOWw3Z0RZUFZYMFFoV2t2ZllkWEV5cE1UOFp6OFNjU0laeFpS?=
 =?utf-8?B?SldzK28yWjZOVXZUSVhNTEtuZm5MNWR2dEFsRjhzUDRwbHlZbzJkb3BuZXFC?=
 =?utf-8?B?NFdrcnFxSlJwQ0ZzaWoyQ2kwZVViWGh2V2EzUjRPNGFxN2ZRQ1VhTjV4WlVF?=
 =?utf-8?B?MFVBRlBjdU5KUXV4MUNFNUlYZWZmNVluMEZZNFBwVEthMENpeWtVWXZvdm9O?=
 =?utf-8?B?eGwwNVJONmFzZjVCRHhqM0FxTUlmbk90SWcvZDNJTy9zOGRLaHFBYmdnelFH?=
 =?utf-8?B?UFZUL0RFVmNtREpabVI4dHhJaXhJbVJkSmNtN2ZVSmMwbzhqRnh3WEZTT1NU?=
 =?utf-8?B?UVZUSDNvWjlpN0M2c0tyeUcyUWdrUUc1cVY4cUw3V0ZxYnNGYnRCWkR6dy9o?=
 =?utf-8?B?VVpZUnZON0tNT3lpa1U3ZHBnS0lMTlVYNXFld2ZKRG9zZTRrTkZWaWxUVlBM?=
 =?utf-8?B?dTNNbG1mbWhPWnJjVGJDK1p1aFhTZjFyYnNIQ3FXWjVZaHZCVTRPMjh3Qlow?=
 =?utf-8?B?Smc4RDdwQ3d4S1NqRVcraXNNRnI3Nnp4N2NDanZBTUlRdzRPVnZ4THRLbk8v?=
 =?utf-8?B?ZXhGTEkyZ0RVaG9JM2RHNFRDUHpFY0xmMnRrTGY1N2NVam1kWHV3TnNxMDUw?=
 =?utf-8?B?M1dXY0tsOG9Hc0NMU3UveE55ME9Ic1VnV2RGSVhYRWp4NHk5YzVLeVVpSWNS?=
 =?utf-8?B?cS8zVlJ6ZWoySEZaNFZ5NXlMUDR1OGNsUjNHTjI5RHFwWVN6QjdIUkoyNFht?=
 =?utf-8?B?cUcxbHJhWkdESEM3d2phK2h4aERaSzREckYyS1FKbmdsVXVWUzE4cmZVWDd1?=
 =?utf-8?B?enAxYmh1S2xlRWVRbDVER1BvSmlpcER3OWljVkQ4dTU2T0t1d21PWHNMSE05?=
 =?utf-8?B?UXV3YUZGRnVkZzR6ZFNhV0NKUmE0OEU2d3NkaWZPMHFMQUh2aGNoRVhXcWxO?=
 =?utf-8?B?cC94RExsdnlEanV2LzNQYkJTV3EveGYxejg5dnhCVk5KSnZ4NmFXRzAwbEZy?=
 =?utf-8?B?bHJoQWpGN1VMM0hqYjJ1dnR6S2RFR2hRc2ExeVpEb2lTM1FWcnlCQ2RsUmRs?=
 =?utf-8?B?dWxpdytEL2F4S1VQTTdSV1dzYkFheFM2MjN0UmhMZzcxYnlkOXNQTHVGYUxH?=
 =?utf-8?B?Z2wzbksvOG9lVVhxUE04cHR4U09nYmFpS3BCdjhEeVVFYmlRQUJiZDFCWTN2?=
 =?utf-8?B?Smc5VEJuNjNCL1ViMDdLV3VvRDVRTVVuaUMvNytSOHl3YmdCMmtzcW9ZWjVl?=
 =?utf-8?B?ZmlWNXF4N1Z1NER3b2tKRjBPNmJ2TG93b1F6MEF4elpPVzdQUkhtL0JoSVp4?=
 =?utf-8?B?czdYeHVkYmZFdFJwRDhWLzdsV2pJTjRJeFdXdFZCY3hpWnQ2alM3aDJmOFBD?=
 =?utf-8?B?UEVsQVRGQm9TOVJ0UVhBRXJZejB2N21TdVdScDZuT3hSTy9sUytXcnU4Smxw?=
 =?utf-8?B?S2Z6bzlmdkNNSng0NDlYbG5ZYUcwWTFNUXlEMkVqR1lCSlc2eXB5VktsaWo5?=
 =?utf-8?B?V0szQ3N1b0M2bFZocVJLSXR2c3hidUtXV0RzeDV4LzZOa0hCWXRmYjJORnNI?=
 =?utf-8?B?WDdjOG1HVUZwNFNIMzdKQVVuNnBkeGFIV1I2NGwrTm9RMTdiWEE4MVZYRXhC?=
 =?utf-8?Q?OpXvI923N621og5tjke4mW648Us87lUm3AizjfSBoA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5A5B734838DC14C94537C16CD67DD0A@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf8697a-42c4-4703-6094-08d9d76161c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 13:25:50.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfIbfZiFvma2Nsx1MVnRibOoaD8igsvB/R0040C5dn04r2Bom8AZO4ydwlDfaW6DFfU7rHyYBpaxj4c13tj4P41dBaK0ySgo0p3BLbZ75JA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0443
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTEwIGF0IDA5OjQwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAwNy8wMS8yMDIyIDE5OjAzLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4g
RnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4g
DQo+ID4gQnVpbGQgUmVhbHRlayBHaWdhYml0IEV0aGVybmV0IGRyaXZlciBhcyBhIG1vZHVsZS4N
Cj4gDQo+IFdoeT8NCj4gDQo+IFdlIHNlZSB3aGF0IHRoZSBwYXRjaCBkb2VzIGVhc2lseSwgc28g
bm8gcmVhbGx5IG5lZWQgb2YgZXhwbGFpbmluZyBpdC4NCj4gV2hhdCBpcyBuZWVkZWQgaGVyZSBp
cyB0byBleHBsYWluIHdoeSBkbyB5b3UgZG8gaXQ/IFdoYXQgYm9hcmQgbmVlZHMgaXQ/DQoNClll
cywgSSB3aWxsIGRvIHNvIGluIHYyLiBUaGFua3MhDQoNCltzbmlwXQ0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=
