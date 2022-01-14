Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7716148EE1B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbiANQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:30:48 -0500
Received: from mail-gv0che01on2110.outbound.protection.outlook.com ([40.107.23.110]:3041
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230367AbiANQar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:30:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jN9C9HVDUa1ryShkocAMHshGwuJBDG27XeYOlUjJhY4LIKJLRKxPM745SYPMks8yLIxwCH/O4w6r8hkeetS9lbUCnlEINS3+12qpM2hWXSo0oPOHGeMhlP/+wOZKNd0KNXSsYgYqklMkeHeHAJUP6FxS8VgRCTh7so0ircVG5msHxi/7ccedjzlFSiPR8fQv3BpwgWymDqVZdpnTyWBAV5SmeB+2ZegdMlBlFLQn9paq+6eU9O9qSf5uGQ1ksQPmMkOESSLLEFAKfZZxIFsOo2PkNhAS//diry6vvSd5liCKEVlxO9o81SafGLNbYQQiUJw6Fw2IiddND5fI29vYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/LXVZWZTSv8N7SL7PjIaymX3WTUedWFF8UNEPehi4g=;
 b=KiN22VxDxssn4YMm1J/vudndrsu/eNfJg0KyLEXze6IdpZBJtsSZ7/QbvgLGmx2A2Mjb8IiQke7yUWXp6ei87FzHOGDBImvCQSDxfuFOrEtwIkecaC/Gf46dCNiGOHSMpGX3h40c7yf3SR5yxhDZs8WzsH8iFVHMEiudLxqXnMq26jdqN3Etp74PytUmjUYDCnVLdx4lVGhxSP0abNKEyredjfVaD86kcmhZSsv+5ea85jwsmWv2Cmo6ibrCIkazydtogTJ3hyQLh8/OJPIgZjQ6YUVXqbT2mjT1sCAn7SqhXBkZC+vKCgQZGrnhg5gRpHryAz1et9fFZnjovH1ZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/LXVZWZTSv8N7SL7PjIaymX3WTUedWFF8UNEPehi4g=;
 b=RxzstMRiWeKx7BJFaffFn5cwX5umQS8LW9TtRiQlLu4I6Spo+qF4CPjYCC7GYu79qx9n0729v4HR7UuXr0hwtIc8N/Ba7fjXYfo5Np+XLNHzoJU3LlylR1V2y5fTxi52zOPrXbZ4TrMjGF8wLMoagkbiJL7JDPzCM5Bt1Di/6mQ=
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0491.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:32::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Fri, 14 Jan 2022 16:30:44 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee%8]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 16:30:44 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>
CC:     "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v1 05/14] arm64: defconfig: build imx-sdma as a module
Thread-Topic: [PATCH v1 05/14] arm64: defconfig: build imx-sdma as a module
Thread-Index: AQHYA/D5bpMH2+TejEql5JiV4ATFqqxhUuGAgAE9iYCAAC38AIAAAd8A
Date:   Fri, 14 Jan 2022 16:30:44 +0000
Message-ID: <13b010060c0b182d7a2c2c09e74805503e6093ee.camel@toradex.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
         <20220107180314.1816515-6-marcel@ziswiler.com>
         <06d3ff4c-3c82-1b04-3dc7-3a6effe4cc3e@i2se.com>
         <0d9e38ad27cf0bebc73e104d8ea462e7cf319e40.camel@toradex.com>
         <d2666a27-a420-5808-6b78-ae77468dae3d@i2se.com>
In-Reply-To: <d2666a27-a420-5808-6b78-ae77468dae3d@i2se.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 476a8649-88aa-4ab2-e2aa-08d9d77b36c0
x-ms-traffictypediagnostic: ZR0P278MB0491:EE_
x-microsoft-antispam-prvs: <ZR0P278MB049184BB54789701F44EFC6CFB549@ZR0P278MB0491.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7YIcw62gkQu/w2vBB3JEfMQvHDLFNZ0VgXRjwG/Gx/xlvxf2sdjsx3E8Q3C+24gm9ZaituGirVyMwntShKQZpWL8/9589gC4hUCAtQk0tyqVbT8ghlzn7o36QC4tAOiv7Fg4XarmF7pzx9+JG11vG2K31gokyzXbO+QJA9fH0hXVTY6NNn3K66HMISk9BkSeKUNCTEH5t8Yx79KvSfm6htP8TQG/WQQEacuVtTnVbGMEp9OAgPkisMSpNSKcCIYJVdGqcwpdoGeEF6rY5ZARqbIMewumk28S/SjUkZbj1XxaYHOd69UzNbkZM4sdaWGS3/Cq6071Ee6RAENkRtOF0Yjy3qRGBq36GpRdEcNqdRF1hHWm4QunppvjqMhsX/5Pn6z14Tgve7rhBAUUfB6H6M2bdwmdNTY2ne5/vRp3d2g7+KNgy2+SWlbOb5c5DxPKklXFKwbXU/AiGaiWOkcamMJ7JgFke8tMICD0ClPxuhY2npC4qn7QVFo+PGlUkSG1H7K063GoVwA6fTboZBW/8HPlBh+MXeSTIELUV8vvLkGNjB4h16F6rJgCgmuflMB7v3ZML/yjcoRAjgZ+ENJyG3UOmDjb4ZRNeFf94jFVXf/5fgjZBgDkEhsLpf4lP5XqAwgf5hd/91f7jtSujGh60/L+vevFaImeeeZyu/oEjIe2TPET3GbJFGMmce691z1I6c+KCjUe3oLaR6SgQTO3Ls7GEdm3gFnKp/aXs1GNUuKBCQ/sO670obuXO80TZ6t2X5oed0rR/91Eg5xI+kqhQ9Pfxaw9QTEHcQUI6P+9O4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(366004)(66446008)(966005)(44832011)(83380400001)(6486002)(110136005)(86362001)(2906002)(5660300002)(71200400001)(54906003)(122000001)(8936002)(316002)(4326008)(7416002)(64756008)(6506007)(66476007)(2616005)(6512007)(508600001)(26005)(186003)(8676002)(76116006)(38100700002)(36756003)(38070700005)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M29MZ3BoZTZTRjgyblYxL05hVFF2MndTYk9HOHUzNlNQbXNKNTJZWHRKd2FE?=
 =?utf-8?B?U2loNTBKbldhd3ppcDJOY3I2SW05b0p2dm9aL25NYW1SdnpJTDk2QU9WTng2?=
 =?utf-8?B?VnUzRmFIM2pNMkNQRWpJK2d6dnNBWlZLdlNSaWpuZFFzNkZOeDhMb3EzMEpH?=
 =?utf-8?B?dVJlY0RSdW1IV1RBdmlPNEZ1eDBHYWUvNlRvMWpqVzROazBjM1NPc2V5Wmgr?=
 =?utf-8?B?MkpQUWdhSjFxbXJvMVJGSFFFNVAxRW1iR2t5RVlkd285SExxU3I1eTNoUzhZ?=
 =?utf-8?B?KzVDYnhLSXdYS2JkU09QTXpFL2dxMnF3YkJkdVRCQ0xPUGw5OU04MTJFall1?=
 =?utf-8?B?T29ZbHZPSWhvSk9aOG1Ib1YydE9JSm4yd05VVWcvMjBlRXVxSDhUVjZ5dEtH?=
 =?utf-8?B?cXFuVEFwK0o4ZlNjYlhYWlFQYkVab3Zvdm5TczU4TzFUbFA0WnBIRzIrUHZC?=
 =?utf-8?B?SE1tL1QyYzdVZXFnMEpIYVVFQzYzSG9VM0REbVl2aE50eDNZQWVDN0FNbGhH?=
 =?utf-8?B?cEdqQkk5QzNlUHlxdGUxZG5NMklWa2Vvai9NS0lwRXZpU3NHZEFBYUJYK01X?=
 =?utf-8?B?citGODBLdTdIcDF2SUtoSUFoQXNnVFNLTHBQdnNaM1lWMnFQb2hMNFBkQjZ2?=
 =?utf-8?B?eUFUcDQwSjRNVzVWNkdsZlAyZk1lMGNXdkhjSXdTa01oa1dxSk9naEswV3hJ?=
 =?utf-8?B?ajlaaG05NXgzZTRCK283NGtDeVk3ZURhazRMN2FyWXYzUzhJSWhIYTVkcW1s?=
 =?utf-8?B?bEJXZzJGZytPV1QvYnlEYmJBVWdCMnFRZnVWYU5HcUFGUnBpajB1SGpoL3dK?=
 =?utf-8?B?SWdyVnNTNFozOXhoZCtaMVYxSGpqOEVuNGxMSDBRbEVZakV3Yk1UdjNiK0R5?=
 =?utf-8?B?VGF1Y1d4dkQxRU9iclJ4M21ZR0tOcUROLzJ1c1VWOUY0dEcxOCtuVjFKUEZ6?=
 =?utf-8?B?RllieGNkVXJKNW43MVlBNDFPcTFnRmtVZSs0Q2J6N1hrYk1XakVQUXB5d29Y?=
 =?utf-8?B?SkhvckxhZnBMWUY0cWZvR3lqT0ozeTh2QTFPaTlNVFdLUVZuSWgvR09LSDZT?=
 =?utf-8?B?cUtTV3U1V3lrV1lXa3d1SERWMk1rbDZodnBYSlNCMXM3UEFscU9YUitmUkhv?=
 =?utf-8?B?aU00NWU4dGptM1hKODViM2hTdkw1dXJsOWtCS2RLbDZBK1NpR0JqcmE5TXAw?=
 =?utf-8?B?bjVXQkg5MURpb2RzVXpERjlhV2p1YjUvQXhDSGNBU0VGTWxpaWh6VWhjVi9m?=
 =?utf-8?B?T2lYNktyN2I5Q0x6QkVvY3hORE9JRHVxU3pFQ0xTSmMycnhkSzU1M2YrdnV5?=
 =?utf-8?B?SUZYOTJLajBmU0UxeHJ2aXAvS3FGaXdQSUJ6a0djSjN4TmFZcHJSRG40dzhi?=
 =?utf-8?B?YlFPblV1ZDhvS0xWZVN1azZDN1FMYllLazJLM3pYdDZTaEE3cG94VVM0WWR2?=
 =?utf-8?B?UlRLVVNJUU9oSDVyZzRRUkFsc2d0eUlWcG5GclA1VlpTVmFtWGQzQ05XVU9X?=
 =?utf-8?B?QkZYbTJ0VTkvNU1oRnlLUnl3MitlMlpFV1NWQlIrbitoQVVYZlhJRFFXRms5?=
 =?utf-8?B?Q010YWVXNEFVQUxwdG5ZZklwZW9mTEpVYlBMZUJHc0d6MjduSFpOT1FGWThm?=
 =?utf-8?B?ZXNlNDhsOEh4UFg2TjFneDhUL1FCUitqaXdPNW1MdnVuQmhRa2hUNjdCb01v?=
 =?utf-8?B?QUxBQ0VETTJ4YmhPc3I3aHZoNHUzdmhTWlphMjVJdWR0QisxODJOQWJlbnRa?=
 =?utf-8?B?Sm92OGI4MkhNWkg3L05lRVNnVWtjZHZWOVR3aDU1QVczQ2FWTEpqL3hreFBU?=
 =?utf-8?B?ZXBrdkErSXhOeHc3ZmtuQmxSbjJPcVJaZWdEVzkrcDRLeUg5cE9sT1k1UUZ2?=
 =?utf-8?B?cVNSdTJxWFFIZ1gyZCs3bHdBY2UxK1c3S3k3TnZ0ZmVmODZPb0QreWRKL0tW?=
 =?utf-8?B?anFjYUsxbXZoVXRPTHRZanQvK0l0bmpMOTFkOXF6UHRFNVdVb0phMmFUWEZQ?=
 =?utf-8?B?WlpsNGt5V0didE0yTWVMVmwvOWRCK1FkVFk3cVl2d2lKYkN5QTduSXZWenZ1?=
 =?utf-8?B?MVI3Zkl0QVljWk16d0hCN1FWMnhPNGxoVU5reFN4cmVIckZybFBnYXhLeWI0?=
 =?utf-8?B?WGZkUWtVdEdYUTkxTmcwNmtVTUVueDEzQ3pxVFk1b0NhcXFnME9WVWdacmNN?=
 =?utf-8?B?OEFGVWgrTUZXSkxabG02N1FyQSsyWVlCSVUrS3ZxNUN5Zml5Zlg3L1BmaUx0?=
 =?utf-8?Q?d5mBDlPQRWiP7AOCj4/ZX7O/F46JU7L9zyfEEnufl4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A66A4EB77A77104A9C243F7FE2C33D5C@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 476a8649-88aa-4ab2-e2aa-08d9d77b36c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 16:30:44.8727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3Os+AI6AX7VUE/5ffaBumhWqAuXFkDjyOcbMBsuIOsDHLLLBsbOq1TbUhXPVO63xsU7EPaMy1DxC1JCDTYceOHt0NBMQAcqfM5Z+YU1VoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0491
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlZmFuDQoNCk9uIEZyaSwgMjAyMi0wMS0xNCBhdCAxNzoyNCArMDEwMCwgU3RlZmFuIFdh
aHJlbiB3cm90ZToNCj4gSGkgTWFyY2VsLA0KPiANCj4gQW0gMTQuMDEuMjIgdW0gMTQ6Mzkgc2No
cmllYiBNYXJjZWwgWmlzd2lsZXI6DQo+ID4gSGkgU3RlZmFuDQo+ID4gDQo+ID4gT24gVGh1LCAy
MDIyLTAxLTEzIGF0IDE5OjQyICswMTAwLCBTdGVmYW4gV2FocmVuIHdyb3RlOg0KPiA+ID4gSGkg
TWFyY2VsLA0KPiA+ID4gDQo+ID4gPiBBbSAwNy4wMS4yMiB1bSAxOTowMyBzY2hyaWViIE1hcmNl
bCBaaXN3aWxlcjoNCj4gPiA+ID4gRnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2ls
ZXJAdG9yYWRleC5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGF2b2lkcyBmaXJtd2FyZSBs
b2FkIGVycm9yIGFuZCBzeXNmcyBmYWxsYmFjayByZXBvcnRlZCBhcyBmb2xsb3dzOg0KPiA+ID4g
PiANCj4gPiA+ID4gW8KgwqDCoCAwLjE5OTQ0OF0gaW14LXNkbWEgMzAyYzAwMDAuZG1hLWNvbnRy
b2xsZXI6IERpcmVjdCBmaXJtd2FyZSBsb2FkDQo+ID4gPiA+IMKgZm9yIGlteC9zZG1hL3NkbWEt
aW14N2QuYmluIGZhaWxlZCB3aXRoIGVycm9yIC0yDQo+ID4gPiA+IFvCoMKgwqAgMC4xOTk0ODdd
IGlteC1zZG1hIDMwMmMwMDAwLmRtYS1jb250cm9sbGVyOiBGYWxsaW5nIGJhY2sgdG8gc3lzZnMN
Cj4gPiA+ID4gwqBmYWxsYmFjayBmb3I6IGlteC9zZG1hL3NkbWEtaW14N2QuYmluDQo+ID4gPiB1
bmZvcnR1bmF0ZWx5IHRoaXMgaXNuJ3QgYW4gZXhwbGFuYXRpb24gd2h5IHRoaXMgc29sdmUgdGhl
IGlzc3VlLiBJdA0KPiA+ID4gbG9va3MgbGlrZSB0aGF0IHRoZSBTRE1BIGZpcm13YXJlIGlzIG5v
dCBhdmFpbGFibGUgZm9yIHRoZSBrZXJuZWwuIEJ1aWxkDQo+ID4gPiB0aGUgZHJpdmVyIGFzIGEg
bW9kdWxlIGhpZGUgdGhlIGlzc3VlIGFuZCBqdXN0IGxvYWQgaXQgaWYgdGhlIHJvb3RmcyBpcw0K
PiA+ID4gYXZhaWxhYmxlLg0KPiA+IFdlbGwsIGl0IHNlZW1zIHRvIGRlZmF1bHQgdG8gc29tZSBi
dWlsdC1pbiBmaXJtd2FyZSB3aGljaCwgdW5mb3J0dW5hdGVseSwgbWlnaHQgaGF2ZSBzb21lIHNl
dmVyZSBrbm93bg0KPiA+IGVycmF0YQ0KPiA+IGFueXdheS4NCj4gY2FuIHlvdSBwbGVhc2UgZXhw
bGFpbiB3aGF0IHlvdSBtZWFuIHdpdGggYnVpbHQtaW4gZmlybXdhcmU/IEFGQUlLIHRoZXJlDQo+
IGlzIGEgZmlybXdhcmUgaW4gdGhlIFNvQyBST00sIGJ1dCB0aGVyZSBpcyBhbHNvIHRoZSBvcHRp
b24gdG8gYXBwZW5kDQo+IGZpcm13YXJlIGZpbGVzIHRvIHRoZSBrZXJuZWwgaW1hZ2UgKHJlZ2Fy
ZGxlc3Mgb2YgaW5pdHJhbWZzIGFuZCBzbyBvbikuDQoNClllcywgc29ycnkuIEkgc2hvdWxkIGhh
dmUgd29yZGVkIGl0IGRpZmZlcmVudGx5LiBJIHJlYWxseSBtZWFudCB0aGUgb25lIHRoYXQgY29t
ZXMgd2l0aCB0aGUgU29DIFJPTS4NCg0KQW5kIHllcywgaXQgbWF5IGJlIGFwcGVuZGVkIHRvIHRo
ZSBrZXJuZWwgaW1hZ2UgYnV0IHRoYXQgd291bGQgcmVxdWlyZSBjaGFuZ2VzIHRvIGhvdyBvbmUg
Z29lcyBhYm91dCBidWlsZGluZw0KaXQgd2hpY2gsIGF0IHRoYXQgdGltZSwgb25lIGNvdWxkIHNp
bXBseSBhbHNvIGNoYW5nZSB0aGF0IGNvbmZpZ3VyYXRpb24uDQoNCkhvd2V2ZXIsIGZvciBhIGdl
bmVyaWMgY2FzZSwgbGlrZSBJIGFzc3VtZSB0aGlzIGRlZmNvbmZpZyBpcyBzdXBwb3NlZCB0byBi
ZSB1c2VkLCBoYXZpbmcgaXQgYXMgYSBtb2R1bGUgc2VlbXMNCm11Y2ggbW9yZSBzdHJhaWdodCBm
b3J3YXJkLg0KDQo+IEZvciBpbnN0YW5jZSB0aGUgTlhQIHZlbmRvciBrZXJuZWwgb2YgdGhlIGku
TVg2VUxMICh1c2VzIHRoZSBzYW1lIGRyaXZlcg0KPiB3aXRoIGEgZGlmZmVyZW50IGZpcm13YXJl
IGZpbGUpIGFwcGVuZGVkIHRoZSBuZWNlc3NhcnkgZmlybXdhcmUgcGVyDQo+IGRlZmF1bHQuDQoN
Clllcywgd2Uga25vdyBhbGwgYWJvdXQgdGhvc2UgImdyZWF0IiB2ZW5kb3Iga2VybmVscyA7LXAu
DQoNCj4gQnV0IHllcywgdGhlIGV4dGVybmFsIGZpcm13YXJlIHNob3VsZCBiZSBwcmVmZXJyZWQu
DQo+ID4gDQo+ID4gPiBXaGF0IG1ha2VzIHlvdSBzdXJlIHRoYXQgdGhlIGRyaXZlciBpcyBub3Qg
Y3JpdGljYWwgZm9yIG90aGVyIGJvYXJkcw0KPiA+ID4gZHVyaW5nIGJvb3Q/DQo+ID4gVGhhdCBp
cyBhIGdvb2QgcXVlc3Rpb24uIEkgcmVtZW1iZXIgdGhhdCB0aGVyZSB3YXMgc29tZSBtb3JlIGRp
c2N1c3Npb24gYmFjayB3aGVuIEkgcHJvcG9zZWQgdGhlIHNhbWUNCj4gPiBjaGFuZ2UNCj4gPiBm
b3IgaW14X3Y2X3Y3X2RlZmNvbmZpZyBpbiB0aGUgMzItYml0IEFybSB3b3JsZC4gV2hpbGUgbm9i
b2R5IHdhcyBhYmxlIHRvIGZ1bGx5IGFuc3dlciBpdCBhbGwgaXQgZGlkIGdldA0KPiA+IGFjY2Vw
dGVkIGJ5IHRoZSBpLk1YIG1haW50YWluZXIgYmFjayBpbiB0aGUgZGF5IFsxXS4gSSB3aWxsIG1l
bnRpb24gdGhhdCBpbiB2Mi4NCj4gDQo+IE9rYXksIGluIHRoaXMgY2FzZSB0aGUgY2hhbmdlIHNo
b3VsZCBiZSBmaW5lLg0KPiANCj4gVGhhbmtzDQoNClRoYW5rIHlvdS4NCg0KPiA+IFsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjEwOTIwMTQ0OTM4LjMxNDU4OC02LW1hcmNlbEB6
aXN3aWxlci5jb20vDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCj4gPiANCj4g
PiA+IEJlc3QgcmVnYXJkcw0KPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmNlbCBa
aXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gDQo+ID4gPiA+IMKgYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyB8IDIgKy0NCj4gPiA+
ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+
ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIGIv
YXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KPiA+ID4gPiBpbmRleCAzYzgxMDZjNTc3NmEu
LmExODc4NWE4MjdkYyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9jb25maWdzL2Rl
ZmNvbmZpZw0KPiA+ID4gPiArKysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4g
PiA+IEBAIC05MTUsNyArOTE1LDcgQEAgQ09ORklHX0RNQURFVklDRVM9eQ0KPiA+ID4gPiDCoENP
TkZJR19ETUFfQkNNMjgzNT15DQo+ID4gPiA+IMKgQ09ORklHX0RNQV9TVU42ST1tDQo+ID4gPiA+
IMKgQ09ORklHX0ZTTF9FRE1BPXkNCj4gPiA+ID4gLUNPTkZJR19JTVhfU0RNQT15DQo+ID4gPiA+
ICtDT05GSUdfSU1YX1NETUE9bQ0KPiA+ID4gPiDCoENPTkZJR19LM19ETUE9eQ0KPiA+ID4gPiDC
oENPTkZJR19NVl9YT1I9eQ0KPiA+ID4gPiDCoENPTkZJR19NVl9YT1JfVjI9eQ0KPiA+IENoZWVy
cw0KPiA+IA0KPiA+IE1hcmNlbA0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQo+ID4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gPiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCg0KQ2hlZXJzDQoN
Ck1hcmNlbA0K
