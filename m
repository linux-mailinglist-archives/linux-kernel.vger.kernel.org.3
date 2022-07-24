Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838E757F28A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbiGXB2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiGXB2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:28:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2046.outbound.protection.outlook.com [40.92.41.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C819292;
        Sat, 23 Jul 2022 18:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExpJiBPrepEGANWw7todUnxNB0CZY6OAIwtURL+nAfq3gsYbizntO8awFlckjD2uCmUcZLEiUhU4wBiHTI8RrjfXS3MsXvF4CqKW+mF7e+X154YV+T0Wrqo80taTD2imHwX7FiqIa33F8m5o4CPIlLa16UfbaH+nVnWl3iYuov4i3cDI8gMzPwqEbw3mxnrmsQmd8Ff4n4eV7+CSxs5J9XEN7q5Y277lKstnUwNkiJE+U6Pdhev63WpYZuvIWucYIgvauAG25rrdoRE3ZbGyspH/ToAviL98ZX430gtz6NoqqWedH/5uLIHSRN2KQFw6s59lGlAsL78h3L/6EiNe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUD/YTgwmcSKD3PwnGxot2STClxFPOufsvGOPDNs9vw=;
 b=QziZtLYlH+oJaRxRP9cIW+k+vceZSr4vPbw+qud5s6BrDMS9e94i0vtk49TJL6y2knpBGsA2Ua+sN2yDw+WubvA+kVeiufnBO1IHfdUs8B+5uo8suHjYzP1GpKPS5AiQZr6FJkXk9Kek0DfJ32fjZEWnn4WPSExOAjv7VRmDPMfCi1t45DI1QEBRNDAnzxuufW0sHFnwJaKQ5+3qV9+jXJgt8IuVwhkH9TXB4GZYHUerGz3AgNU8uBawMAvS8rRkDRPPIwcvzImFVq5hFTOE1x2ZCnwdnMw3QH1B/9LYYPyx5kNATpH2N1lVcNmcJy+2R3WeeyhjszCLCo1vXL0kgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUD/YTgwmcSKD3PwnGxot2STClxFPOufsvGOPDNs9vw=;
 b=Ss29uKcRqDJXHPZ0hmdWRrJX2CLuCQ25V0ZFRbYJp7bEksx6HFRx2GvlNGO2sbMuvPmG3p7KEoUk/eU/Na82li2wfeAMjySgRfoYfJsZnmI3jJWC7hu65AQQELL0/oIW+q2Ju1rcMQSjzwkb8/+88jeFKK9ByL0xmrS8EZxtni29NgKO6+MrBLQISPvJt1BvJSJ8IZoWGB0iT1VEKNsv8JBxKofi/3C9L4WE6wPc5Rvw87LxDn++RNklvmbH6tsobMyDQXqPukY0T8W34TVvfb5kWHlv0zHWqTfCEvwQbUmZtT840oxey3e+3KKa5jLswsQd6+3zIk8kQHznLx3ccQ==
Received: from MN2PR17MB3375.namprd17.prod.outlook.com (2603:10b6:208:13c::25)
 by CY4PR17MB2024.namprd17.prod.outlook.com (2603:10b6:903:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.22; Sun, 24 Jul
 2022 01:28:41 +0000
Received: from MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba]) by MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba%3]) with mapi id 15.20.5458.023; Sun, 24 Jul 2022
 01:28:41 +0000
From:   Vanessa Page <Vebpe@outlook.com>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
CC:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aidanmacdonald.0x0@gmail.com" <aidanmacdonald.0x0@gmail.com>,
        "paul@crapouillou.net" <paul@crapouillou.net>,
        "dongsheng.qiu@ingenic.com" <dongsheng.qiu@ingenic.com>,
        "aric.pzqi@ingenic.com" <aric.pzqi@ingenic.com>,
        "rick.tyliu@ingenic.com" <rick.tyliu@ingenic.com>,
        "jinghui.liu@ingenic.com" <jinghui.liu@ingenic.com>,
        "sernia.zhou@foxmail.com" <sernia.zhou@foxmail.com>,
        "reimu@sudomaker.com" <reimu@sudomaker.com>
Subject: Re: [PATCH 0/3] Add SFC support for Ingenic SoCs.
Thread-Topic: [PATCH 0/3] Add SFC support for Ingenic SoCs.
Thread-Index: AQHYnetEdbV32htwsUehUnEKE6IRwa2MCk8AgACyeYCAAADLMQ==
Date:   Sun, 24 Jul 2022 01:28:41 +0000
Message-ID: <MN2PR17MB3375133A5A0F9CCCEC201B92B8929@MN2PR17MB3375.namprd17.prod.outlook.com>
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <e700eecf-e7e0-c2e7-9e20-b5d20df4b65f@gmail.com>
 <36084c97-b675-1400-52da-f74bf4b61930@wanyeetech.com>
In-Reply-To: <36084c97-b675-1400-52da-f74bf4b61930@wanyeetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [IRd6pvU5H0aQprEY6ugwtuN8NiPR7h3tnN6Fq6oN4G8tOJqzd98gDrWF6N57OT7L54iiU2M9qUQ=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ee30006-668b-450f-a1ad-08da6d13d793
x-ms-traffictypediagnostic: CY4PR17MB2024:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TS96vKKP6T4a52HS9chxg750Dg4fK1Y3HvD+qTpBzk+Av09foCPpEiAf2DJexRywf1oFYQRWLNZmGpJyjQuSsuJXAKM4F11He8hgnBb/ZiXpIHbipd/70Aq0/TVYCr5/OUm85yefjl1sck1MwOuNVw+SAI1SrKkHMyPv1W2gHQ4Gk9nRFxLg4wNjf7Yz8LGNiXFD7KasdTOpYyI949DQM6HK/guim8TrI1B8d+EqAlyzAWFgnC5s2/wy/rcx/n7+uEcuyftSDohmZnWASyLVc3hgwLVJPfA4F6GE3e+xLr6Xx55fmIhiapOajANnbWKk98c8QCptHUlbevK8wGeCgITmmYlF4yZuXgTG9fA4IAoQ4bMZn2N4/TY9Xt7xldxQ6odl3kOORxvV3mjc3wb8e91hAS+EQ7Z/5q7vULFvQJdKV8ZbdU+Ane3hsTA+cbVAuFCfuTfat/945fealYklo5ai4Yd1ymMAysvX/e8N+9oQ4h/9lPbEuqVNPqNXHvPS3WnoWpjDgsn2A0jCLfiF9PP3dBMNM7Z82M/BKt51ebYIHA0aiBgdxQu8pl9JqNZChdw716UBKhuM+iQ/axRP/B3KZ57EMJu4qTUJXmG48Pyl2d3RpmVoUtmG7FrZPS8dcRA1Elc2T2Mcth0XYshOqTMD7YFSDrAiqVwpMUrN36vQ4CkxeelKSX5B4b7MF6Yl
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnpWU3lTUVlld2lPOG5Oa08wZ3Ard2FXWVVXV3VVcTkvMDQ0Vmo1TW4xa2Jr?=
 =?utf-8?B?TmZjS3ZRM0VRM1FabjJmRmhKdGEveXFTa1Ftd3pRM1ZCLzdYRWRTZk00YXJV?=
 =?utf-8?B?bEY5bDl5VEtlZ0NtakR4TXRoekxOU1hRMDVhcnBwcXJBbStKVVJQaGhMUEZ0?=
 =?utf-8?B?RVpuN01jSUhDMmVYaE56cTcvM1JwR21laThORG9OSmhwZWlONUZUNk1rS0p4?=
 =?utf-8?B?V3hyQnVVUE9UKzJsamVINzd1Y09seDZjNENpMVVRVW4xVExIWWxuSzc1NC9x?=
 =?utf-8?B?MTk4VGpBWVRtLzZIaEpNOTJ0OGdyekg0VVJsS1N5R1E5cDVGU1orczhwL3g0?=
 =?utf-8?B?L29aUDRMbmRQaUI3TXBMbTdhNFJJOUQ1T0Z2QkJDejRiS2FWVjFiY2pKMFlR?=
 =?utf-8?B?Lzc2WjBNN0MwTVF3QTBPOVdJbUt4ZFFaTkFjYUdTS3RkUkFGQXRDdlZJbEw1?=
 =?utf-8?B?M3NSbjQ1VnEyeDU5TU13V1lpVThiN3ZoOFlvYVl4Q1ZJeTcvWmlKeVE0d0Rr?=
 =?utf-8?B?Y2VheS90TGVHYkdVTWhuZlBaREF5RkRycFpDWEFpM3QxMU5NU3U3YXNFMmhn?=
 =?utf-8?B?cVdwSlFMbElVeU1tZVpKODlNeGF4cTBKUENZTjZFU0lVaE82MWU2RkE2Vm9N?=
 =?utf-8?B?dFdCeEdJZ2kwWUsyTytTRURkVERBNjBtSFhLWkZ1Ynd1MW5UMm1YZVNVRUIy?=
 =?utf-8?B?U2MwZng2UGs0dU1VTkY1T1JldVVzTHhaTWdydVZoODFnako2aElBalFScGsw?=
 =?utf-8?B?bVlmSzdXMmxGOGZDYThsWkdmd2RZcDZVbmhVUWk1SDRORnp6bzU5NFhQRnk0?=
 =?utf-8?B?RlN1MGxGN2ZhVlk5REdGeGdDbnZ4QWxabzUyRS9qbm1GYzZ2Mm4zM3JCUSt1?=
 =?utf-8?B?SC9Lamt1NHl0dDVMSERmS3pORS9tYXFWcUxGQ2J5bkxjVXhRaFVkK2pWZ0t0?=
 =?utf-8?B?ejBsSkM0UmxtZFEyUDFuZHdyUEF4U2pEL1AvNkZBcUF2NENEMXVLd09IREc0?=
 =?utf-8?B?S0M5NkpMcE9QQkpUT2RkcGJlTE1lVWtvZmFlTytmY1ZNK3ZZQmplMU5NVllq?=
 =?utf-8?B?bGFoUkptN01hYTFhb1Q5NmJ5OXJ0UW5aZWErMUhTU1JrUytRWlBNdkNhaUx5?=
 =?utf-8?B?L3VZcGhSZHhqZTQ4WDIrcHlTWXIrVllhWFBsb0RVVDRKU0xlZ3VYRHA2QmJP?=
 =?utf-8?B?TGJXZ1VLMG9uNkh0R0pqMkVXc1dCcEF3eGxXcHhrNXF1Y3kvazdFWE5xZUwx?=
 =?utf-8?B?anNGUnJYWVdIVjRTbTZiV2g0eE04Y2tDUmxBOFV2RmtjbVA0VkFoSTl2Njgw?=
 =?utf-8?B?azAxdXpPTVd4ejViTTVkejI3RmZiWkIvMG90MHl1clg3K3RSenZIUnh5OFZR?=
 =?utf-8?B?ZHRwVmxYUHlCMU9sbzBJclZDV3gybElvUVBzMFJPM21saUhESE9uZ3lKa3VV?=
 =?utf-8?B?d0RFa0p3VGc3dW9reWZHcmd6YWJRN1N0VDZGSGdacFdVR1BsTlBzS0RWY1Rq?=
 =?utf-8?B?Ly9GZ2UybCtYcXZQdEZTVjJrckFuRFhUWnVQc2ZXUzdOejNzL0FzbzFuK0JC?=
 =?utf-8?B?YWo3ejNXdldCTmlKTG9aLzRqbTByOHlwV1hvWTZ4cVZqTEtMZ1ViVDhhbXhP?=
 =?utf-8?B?ZHNJMHplMHhOcERlT0JiN0pTOXhJdU1RdGcxaEwydFF1U1diUUorcVNsUHlM?=
 =?utf-8?B?andoYkxLSzZVN2xzK1pWSUJNa0tnaThBWWt3a3dZbFF0dFJyRmRza2NSa25X?=
 =?utf-8?B?TUVQQXZpMGJKSEpvRmdlYlRHQ0VIMmZvRGxoSTlZaFdTOUMvTHRSOFp0aE1O?=
 =?utf-8?B?aWZzclNrYTZIMy96aXdCUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB3375.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee30006-668b-450f-a1ad-08da6d13d793
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 01:28:41.4616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR17MB2024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mjg4ICAgICAgICAgICAgICAgICAgICBvcC0+ZHVtbXkubmJ5dGVzICogOCAvIG9wLT5kdW1teS5i
dXN3aWR0aCk7DQogIDI4OSAgICANCiAgMjkwICAgICAgICBpZiAob3AtPmRhdGEubmJ5dGVzID4g
MCkNCiAgMjkxICAgICAgICAgICAgdmFsIHw9IFRSQU5fQ09ORl9EQVRBX0VOOw0KICAyOTIgICAg
DQogIDI5MyAgICAgICAgd3JpdGVsKHZhbCwgc2ZjLT5iYXNlICsgU0ZDX1JFR19UUkFOX0NPTkYo
MCkpOw0KICAyOTQgICAgICAgIHdyaXRlbChvcC0+ZGF0YS5uYnl0ZXMsIHNmYy0+YmFzZSArIFNG
Q19SRUdfVFJBTl9MRU4pOw0KICAyOTUgICAgDQogIDI5NiAgICAgICANCg0KU2VudCBmcm9tIG15
IGlQaG9uZQ0KDQo+IE9uIEp1bCAyMywgMjAyMiwgYXQgOToyNyBQTSwgWmhvdSBZYW5qaWUgPHpo
b3V5YW5qaWVAd2FueWVldGVjaC5jb20+IHdyb3RlOg0KPiANCj4g77u/SGkgVG9tYXN6LA0KPiAN
Cj4+IE9uIDIwMjIvNy8yMyDkuIvljYgxMDo0NywgVG9tYXN6IE1hY2llaiBOb3dhayB3cm90ZToN
Cj4+IFcgZG5pdSAyMi4wNy4yMDIyIG8gMTg6NDgsIOWRqOeQsOadsCAoWmhvdSBZYW5qaWUpIHBp
c3plOg0KPj4+IDEuVXNlIHRoZSBzcGktbWVtIHBvbGwgc3RhdHVzIEFQSXMgaW4gU1BJLU5PUiB0
byByZWR1Y2UgQ1BVIGxvYWQuDQo+Pj4gMi5BZGQgU0ZDIHN1cHBvcnQgZm9yIHRoZSBYMTAwMCBT
b0MsIHRoZSBYMTYwMCBTb0MsIGFuZCB0aGUgWDIwMDAgU29DIGZyb20gSW5nZW5pYy4NCj4+PiAN
Cj4+PiBMaXUgSmluZ2h1aSBhbmQgQWlkYW4gTWFjRG9uYWxkIHByb3ZpZGVkIGEgbG90IG9mIGFz
c2lzdGFuY2UgZHVyaW5nIHRoZSBkZXZlbG9wbWVudCBvZiB0aGlzIGRyaXZlci4NCj4+PiANCj4+
PiDlkajnkLDmnbAgKFpob3UgWWFuamllKSAoMyk6DQo+Pj4gICBtdGQ6IHNwaS1ub3I6IFVzZSB0
aGUgc3BpLW1lbSBwb2xsIHN0YXR1cyBBUElzLg0KPj4+ICAgZHQtYmluZGluZ3M6IFNQSTogQWRk
IEluZ2VuaWMgU0ZDIGJpbmRpbmdzLg0KPj4+ICAgU1BJOiBJbmdlbmljOiBBZGQgU0ZDIHN1cHBv
cnQgZm9yIEluZ2VuaWMgU29Dcy4NCj4+PiANCj4+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
c3BpL2luZ2VuaWMsc2ZjLnlhbWwgICAgICAgfCAgNjQgKysNCj4+PiAgZHJpdmVycy9tdGQvc3Bp
LW5vci9jb3JlLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDIgKy0NCj4+PiAgZHJpdmVy
cy9zcGkvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKw0KPj4+
ICBkcml2ZXJzL3NwaS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
MSArDQo+Pj4gIGRyaXZlcnMvc3BpL3NwaS1pbmdlbmljLXNmYy5jICAgICAgICAgICAgICAgICAg
ICAgIHwgNjYyICsrKysrKysrKysrKysrKysrKysrKw0KPj4+ICA1IGZpbGVzIGNoYW5nZWQsIDc2
OCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvaW5nZW5pYyxzZmMueWFtbA0K
Pj4+ICBjcmVhdGUgbW9kZSAxMDA3NTUgZHJpdmVycy9zcGkvc3BpLWluZ2VuaWMtc2ZjLmMNCj4+
PiANCj4+IEV2ZW4gdG91Z2ggaXQncyBzdGlsbCBlYXJseSBpbiByZXZpc2lvbiBwcm9jZXNzLCBJ
J2xsIGFkZCBteQ0KPj4gVGVzdGVkLWJ5OiBUb21hc3ogTWFjaWVqIE5vd2FrIDx0bW41MDVAZ21h
aWwuY29tPg0KPj4gDQo+PiBUaGUgdGVzdCB3YXMgcGVyZm9ybWVkIHdpdGggRGFtYWkgRE02Mjkx
QSBTb0Mgd2hpY2ggaXMgYSBJbmdlbmljIFgxMDAwIElQDQo+PiBidXQgd2l0aCAyNTYgTWlCIFJB
TS4gTm8gYnVncyB5ZXQgb2JzZXJ2ZWQgb24gbXkgc2lkZS4NCj4gDQo+IA0KPiBUaGFua3MgZm9y
IHlvdSB0ZXN0IQ0KPiANCj4gDQo+PiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eCBNVEQgZGlzY3Vzc2lvbiBtYWls
aW5nIGxpc3QNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1tdGQvDQo=
