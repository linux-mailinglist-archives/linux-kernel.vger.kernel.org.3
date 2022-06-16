Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04A854DCCC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359487AbiFPIYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiFPIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:24:19 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2180.outbound.protection.outlook.com [40.92.62.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FCB248EA;
        Thu, 16 Jun 2022 01:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1MEGH6Xn9V4NFcR8bzJml4WCt/pkAGc0FJQOG3jE/TJavoIALOXXoK1y0P/MNlK2KHTak6ZPD8ruxCHZ3gLceuNCnYFvMQvLk28jRgFoh9DBjMVrjM/D0+jPq71+vSPutHfHP+D5O6y4kzZBRmTjFizcJjhun3Fd67R3qRNY6pggjKhEgTSZHp015V6JtTq8W3bpCQvKoAh5g0GbDI2r9/+n2tBRNSdIj3o2CYtN7DaE3V5Tn8debLj4sDBox73/84I6zonJt3zYLCYbc+pkLfUBx1V7YR61gq8qqC5CiR97ZdKdjV7lyllkDEKIuzIbqPK8y2N3YS2aRar5SYrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFHV/AEp5wDJQYEtcG1BKAKpJT+ux9mUl/b444rNGC8=;
 b=bBmR98nGUKWI68GTBMM9PKMXyWPWgCJ4pcvZjLFKyWjhAq71ISER3hxb1hx/uC6CrVNHC9LUNH8Paev5rEUf+0KSYK949Uc2pFuCh7lUlS657JNZ26KuFrbgIhMnKWF5ip8e3WexbMMlEB+ROB0hSeRdcUnek6vzBJqMqm075ws0OYpjwBQZchN1zG7szy3GYfRiknc4ib9eEDiQW/ofmKbPXbxjc4XoixyNA1FGypANCFSHy4LHw+J1MGu0jQiR2AMmYJicHfIEgSOxilcjXRycbkoD6okfQTlIuzEK56S50PVQowDb/Zl/iG611aOW0LuMccxG7wJyRc3TOlzFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFHV/AEp5wDJQYEtcG1BKAKpJT+ux9mUl/b444rNGC8=;
 b=PDzTssSDjD/BBbntNLqCsHigf8PMVpz34BkVZ71pbzPsamMeiDb9tcv0WgG5UcQX3Yk+Wl2ym0wlIhvSbtduydebLRcj1FqflpsydzNwJ3rCVHJHxwrVLaCua+B6Ll4FZCKjO7g6JuwRe4rF9jrL3cNUytmi2w0WuYJRxnZT840LJve42YKDlttCSJY+wGVKb4pV3HOM52pcHTysqtZyEu1tJh9VslU/e7viyTfS6DqDApb8FEaznOO8shjsy5eaLRBzqsFzvbp73bjm04JBZLDHwm05Mvk9yW4nwkCWGmHTRC1rf1DvkS7HYOvG4gIcYSoR8aL+DNOrWAuXNBBOCQ==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by ME3P282MB1185.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 08:24:14 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 08:24:14 +0000
From:   =?utf-8?B?6LCtIOawuOaelw==?= <yonglin.tan@outlook.com>
To:     "mani@kernel.org" <mani@kernel.org>
CC:     "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_hemantk@quicinc.com" <quic_hemantk@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhi@lists.linux.dev" <mhi@lists.linux.dev>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2Ml0gYnVzOiBtaGk6IGhvc3Q6IEFk?=
 =?utf-8?Q?d_support_for_Quectel_EM120_FCCL.?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIGJ1czogbWhpOiBob3N0OiBBZGQgc3VwcG9y?=
 =?utf-8?Q?t_for_Quectel_EM120_FCCL.?=
Thread-Index: AQHYaO+WFfW+clH/tU2JDoy2Ki03Sa0rw1EQgAJTigCAI8t3wA==
Date:   Thu, 16 Jun 2022 08:24:14 +0000
Message-ID: <MEYP282MB237493839457B8A8D86E3EF6FDAC9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB2374837FFCB18B12BFDEDE80FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
 <MEYP282MB23746F19B1CF42D811D43AFCFDD49@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
 <20220524134418.GB5745@thinkpad>
In-Reply-To: <20220524134418.GB5745@thinkpad>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [koqtz3WhbxoLKVt67Xv97hCMNay9u4NU]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 965a04f8-fe04-4187-6a80-08da4f719924
x-ms-traffictypediagnostic: ME3P282MB1185:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yN75A7TmMKaENj94wn0XrJjp9MRBFZnCFpm1GrVXIA6BPfm3h5sAC6lcw71kH2hmg63rnGm14wg6Lfff12eA2qhlpdRJ9wpZ9sxieZ2Rxme5T0c1e7nzVzjUvtxKXN33aYINfTvMjcd4TzG9GnhGqHIUPq2jlg6Z/unrTAQTswPH79q6Atn3YgfCKCdys2pfsF4WTXBefVPAMTceW/KMAxSgH4/lgh3x8Rya5gLNjRElbPi/jV8Rsi+YMZVqatz1V+Q7E1pmGNu7uFcntj6R0Qn2YkqJ5v8uHADNz/m818NVfnqTwAblXHPDCiiCfYw23v4MLM9gC9yYih3vVacXBSqsqaVa2jGoDoqkzNeLITYBA6OgqQ8KUn0Ynid4z4Y3BAdu3JrhkeI6jMiqUVTACtQkJLR5KfizX8xew+FjF8l0caawfPpRjOSNzp88MCgaNbc+nAswLlpqBHO1mCLUhji8WXgD1qc5IWBu3fYTYmmWOseOSb0Bj++IsCjMkvEdDDw+mWHY7P4KRxuVSklBy619+N+73y02BgRfDDQ0KJr2du2eVxHtNdmu6ph8+NOqjGX1NCo949yGiraAmYLFcw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEtYVlU1TDRkbWliVWFUcVhHWGE2RTlDd1dzMXhWY0g3RlBDQWU0OHNoY2lt?=
 =?utf-8?B?L3lTUnFBOC8xcmxadW9STGE4bWNuUEtKSDQ2enJHQ3pYOFdNSDRGRDJ1MFpr?=
 =?utf-8?B?WlJLQmtlZnkvNExPclhQN1dTa0VCWU0yZVdCOTF1U1BSN3hWK0hFY1Z5N1Bu?=
 =?utf-8?B?M29oTkVjSElpYWU2cTAwNGhZSXBUVUIvaHh6Y3A5WmtKZDk0eWRRTkpBSEtN?=
 =?utf-8?B?cmJPc3FHWUdPRHVXaVNZejlDK1Z6K3QxWVV0SHdySUVuQkdhRVhYMjMwbFNl?=
 =?utf-8?B?a041clhjeldsaTJUWk9kd0toY1ZWMDhiak5LZHhqOHRWRThtY21UOGZNMkZJ?=
 =?utf-8?B?TlAzYUx3MVZ0d0lqZSs2emRXYkJzcHFrbUkwdkhGK2ltaDlLdVd1TzFHMWdL?=
 =?utf-8?B?ZlE3OWdFeVYvSUY1ZnVoeEthUkxEZ3R6bzZoT2t4cHg1MXhBNXN2MHIwd0VW?=
 =?utf-8?B?cEVkdUQrb0hGU3pFb3hwdG15bW9aWjNPN1NueFFkOVM4amZ0WHFBeWlaQVdR?=
 =?utf-8?B?RytuMzdzZ2ZKSU0wZ0lVYkVnZU1tdnRHTmI3SFZBR0FiZTR6ZEh3dk1sT210?=
 =?utf-8?B?Wmc0dS8vZU5HTHBFNEJzeTVxZEgvRnZ1QWc1ODBtVHVLRjVZOGoraVAySDZr?=
 =?utf-8?B?Q1Rnb0dBTDREYk8vQ05VUms0N2FjNmJBMVFUMXJIY0VJMGJCTzE4L2lYeXRS?=
 =?utf-8?B?b2xST0RQa29iMW5CM0NJSTJCUWVnTXFNMldPM3JlOU0yM0ZZQWdXVUJzSVhV?=
 =?utf-8?B?MXJLcWNBWjNtd1lWV0ttUGlRUzY4bFM5UFRRUU1lWjNLYkxRcW9NVUpoVHZx?=
 =?utf-8?B?ODMxd05uSHhVOWVobjRLQ0M2S0I2SHZQZDJYMFFRR0pmWnlMUzlkQ2Q3bkQx?=
 =?utf-8?B?ZytMZWtPenZ5N1NNc3RPTFBhTy95TkJ6SEFBZHpib2ZmcEI1QWV6VlBJV2JK?=
 =?utf-8?B?Nk1aZ1V4Q1RqUnFVNnhnd2NIbkJNREFXR1lhRko4T3FCYnhmMXh2c0gvUmtJ?=
 =?utf-8?B?YlE0Y20rR3BuWjNrbHhlTHRqbWVKNGljUUNvL3BibTJWaG83a3hyZU5WM2lz?=
 =?utf-8?B?b1BQVkpzVm9kQlBlb0NvdG9rMVN3MnBXR0RoR3puTk1RZHBaaGFGYzR5VkdE?=
 =?utf-8?B?NlBubG1LbHRiY0NHSkg3YUtMMVptUFpKLzVtY1AvZFdzbDk5Z2FpVHJYQnZP?=
 =?utf-8?B?YTltcythWmdNVjF0SEZtRzJKMlJjc3lwYVVsUUx6cDVBc01PUnpFUG45OElt?=
 =?utf-8?B?R2lURFZVTldmVUovUlNNVEd0YmF0UDdCZkI5VFZIV1VHVWI2YWc5R2ZaeFB5?=
 =?utf-8?B?Ti8yZFYxSnhwTmdLQmhZK09NNk14RDljczcybU5sM2xjUStnbUsveGVRRUJD?=
 =?utf-8?B?U1BNUEJRSTJpeTRkbTRUeUErblI5eE1YUVJ6dnpmSEJiMVJaZkw0VHVZMUR2?=
 =?utf-8?B?cDFXWmFTQ21mdFBwOEl5MmNROU5rWmc0UkJzZC9leEVTeVZmNnVrUWUxSWY2?=
 =?utf-8?B?ZU01U1NyWXV3NGhXdnB5RFpTZGFUVTBiTG80N2Vwb1lUbG90cmFBclJMZkMv?=
 =?utf-8?B?QVh1Z01Fd0tQaVBwTXVxcGRKZ3kveitZSTc2UVFwWjF3Z3QxYUF2WmdqbGIv?=
 =?utf-8?B?dlRlOTlUZ2twQWs5ZUN2Q2I3SzBXb3R5cHdaaE5tQXJ2czBHcHdHalBmTWUr?=
 =?utf-8?B?R0Rac0FBOCsrR0VoZ1dYODMvWUxneE03b2dMZit2SmdWQnVVN0RqR29OMHlE?=
 =?utf-8?B?WlJ1UVFTa3JsWGVMaDdZUVJUWnBBNVovMlNyYmR1QTY5WFl4dVRRMWdETzBm?=
 =?utf-8?B?WTlFN3NyTk1WblU0NG4xMC9UdlMwdmZwVUVod3dST3dBaEw2bEdQblgvVUlK?=
 =?utf-8?B?NCt6Ky8zcXYxUWFPZlVZRVY4bFk4NFN5U0Z2Z1laQTNLK29iWWlBOGVvaWFZ?=
 =?utf-8?Q?Dg+Jwt5RgiA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 965a04f8-fe04-4187-6a80-08da4f719924
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 08:24:14.5232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBNYW5pLA0KDQpTb3JyeSB0byBib3RoZXIgeW91IGFnYWluLCBhbnkgcHJvZ3Jlc3MgZm9y
IHRoaXMgcGF0Y2g/IA0KRG8geW91IG5lZWQgbWUgdG8gcmVzZW5kIHRoZSBwYXRjaCB0byB5b3U/
DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogbWFuaUBrZXJuZWwub3JnIDxt
YW5pQGtlcm5lbC5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDIy5bm0NeaciDI05pelIDIxOjQ0DQrm
lLbku7bkuro6IOiwrSDmsLjmnpcgPHlvbmdsaW4udGFuQG91dGxvb2suY29tPg0K5oqE6YCBOiBs
b2ljLnBvdWxhaW5AbGluYXJvLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHF1aWNf
aGVtYW50a0BxdWljaW5jLmNvbTsgbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1oaUBsaXN0cy5saW51eC5kZXYNCuS4u+mimDogUmU6
IOWbnuWkjTogW1BBVENIIHYyXSBidXM6IG1oaTogaG9zdDogQWRkIHN1cHBvcnQgZm9yIFF1ZWN0
ZWwgRU0xMjAgRkNDTC4NCg0KT24gTW9uLCBNYXkgMjMsIDIwMjIgYXQgMDI6MTQ6MTVBTSArMDAw
MCwg6LCtIOawuOaelyB3cm90ZToNCj4gSGkgTWFuaSwNCj4gDQo+IERvIHlvdSBoYXZlIGFueSBj
b25jZXJuIGFib3V0IHRoaXMgcGF0Y2g/IA0KDQpNZXJnZSB3aW5kb3cgZm9yIDUuMTkgaXMgb3Bl
biBub3cuIEknbGwgc3RhcnQgcGlja2luZyB1cCBwYXRjaGVzIG9uY2UgaXQgY2xvc2VzIChhcHBy
b3guIDIgd2Vla3MpLg0KDQpUaGFua3MgZm9yIHRoZSBwYXRpZW5jZSENCg0KVGhhbmtzLA0KTWFu
aQ0KDQo+IA0KPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogWW9uZ2xpbiBU
YW4gPHlvbmdsaW4udGFuQG91dGxvb2suY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjLlubQ15pyI
MTbml6UgMTQ6MzgNCj4g5pS25Lu25Lq6OiBtYW5pQGtlcm5lbC5vcmc7IGxvaWMucG91bGFpbkBs
aW5hcm8ub3JnOyANCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHF1aWNfaGVtYW50a0Bx
dWljaW5jLmNvbQ0KPiDmioTpgIE6IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyANCj4gbWhpQGxpc3RzLmxpbnV4LmRldjsgWW9uZ2xp
biBUYW4gPHlvbmdsaW4udGFuQG91dGxvb2suY29tPg0KPiDkuLvpopg6IFtQQVRDSCB2Ml0gYnVz
OiBtaGk6IGhvc3Q6IEFkZCBzdXBwb3J0IGZvciBRdWVjdGVsIEVNMTIwIEZDQ0wuDQo+IA0KPiBU
aGUgcHJvZHVjdCdzIGVudW1lcmF0aW9uIGFsaWduIHdpdGggcHJldmlvdXMgUXVlY3RlbCBFTTEy
MFItR0wsIHNvIA0KPiB0aGUgRU0xMjAgRkNDTCB3b3VsZCB1c2UgdGhlIHNhbWUgY29uZmlnIGFz
IFF1ZWN0ZWwgRU0xMjBSLUdMLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWW9uZ2xpbiBUYW4gPHlv
bmdsaW4udGFuQG91dGxvb2suY29tPg0KPiAtLS0NCj4gDQo+IFYyOg0KPiBGaXhlZCB0aGUgZm9y
bWF0IGVycm9ycyBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uDQo+IA0KPiAgZHJpdmVycy9idXMv
bWhpL2hvc3QvcGNpX2dlbmVyaWMuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2Vu
ZXJpYy5jIA0KPiBiL2RyaXZlcnMvYnVzL21oaS9ob3N0L3BjaV9nZW5lcmljLmMNCj4gaW5kZXgg
ODQxNjI2Ny4uMGE2NDY5YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9idXMvbWhpL2hvc3QvcGNp
X2dlbmVyaWMuYw0KPiArKysgYi9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jDQo+
IEBAIC01NTcsNiArNTU3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIG1o
aV9wY2lfaWRfdGFibGVbXSA9IHsNCj4gIAkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190
KSAmbWhpX3F1ZWN0ZWxfZW0xeHhfaW5mbyB9LA0KPiAgCXsgUENJX0RFVklDRSgweDFlYWMsIDB4
MTAwMiksIC8qIEVNMTYwUi1HTCAoc2R4MjQpICovDQo+ICAJCS5kcml2ZXJfZGF0YSA9IChrZXJu
ZWxfdWxvbmdfdCkgJm1oaV9xdWVjdGVsX2VtMXh4X2luZm8gfSwNCj4gKwl7IFBDSV9ERVZJQ0Uo
MHgxZWFjLCAweDIwMDEpLCAvKiBFTTEyMFItR0wgZm9yIEZDQ0wgKHNkeDI0KSAqLw0KPiArCQku
ZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZtaGlfcXVlY3RlbF9lbTF4eF9pbmZvIH0s
DQo+ICAJLyogVDk5VzE3NSAoc2R4NTUpLCBCb3RoIGZvciBlU0lNIGFuZCBOb24tZVNJTSAqLw0K
PiAgCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0ZPWENPTk4sIDB4ZTBhYiksDQo+ICAJCS5k
cml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkgJm1oaV9mb3hjb25uX3NkeDU1X2luZm8gfSwN
Cj4gLS0NCj4gMi43LjQNCj4gDQoNCi0tIA0K4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCu
muCupOCuvuCumuCuv+CuteCuruCvjQ0K
