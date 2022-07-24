Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE8057F286
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiGXB2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiGXB2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:28:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2060.outbound.protection.outlook.com [40.92.41.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E0819292;
        Sat, 23 Jul 2022 18:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGZSShOVlVOcKJCz2Tu66yPp0yUxC0wIiLVtqvkkVi1Ib4ArSo/6PWjQYyIGrW9XaVQZudt03fBM3fAgKeqiznrycUFmpxTyviJxfkw8wK7gnXOFAn9UAzEefnZPPV+/S0Tomtr/a5dwolnNe2MZ57Jih6+XnR/VFG9J579C5naifA0nsrU9dHxHqon+/RLy349m07fFLLcbEBvMLynWI4dakSVqbtklzwQFob/yLXzoHk2XP8taI4Aa2aCbpUx/44IFGXezHunsnDuHz7v27IwMGKWtd1Qjyk/byOxO9OBPzNR55D5iOcz/yYK2T28XXYTYwJCGkuM+pcyTjOs2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUD/YTgwmcSKD3PwnGxot2STClxFPOufsvGOPDNs9vw=;
 b=TDWgDsm2Lcn3fXLUKzXOs7hJJuwXJAn1ILAhisI1YOyZVHSklQ13JO0I5wBnaYDEZ6uNcnOcgMX0XmOMuqf0K7Z3IT5hcD/jf/vLgu/ba7TZcP3X1ZbFPob0RcVR9llo8PuLEm1mK6g+UgAFtOleOpi1lYNdLmVUVCLMPxq1USkNzQOv9IW7QeZC1zjWBCTw8YfPWOdKNeMW9uAU59Q6w/b/VRciOR5rk7av18wGWNJ61ki90ofz/idVhAPrji3a/A9lpk7R3s4gDQCk9F1Nc32fog9AQDuxt3uhwUXn9JsX/3efyDY1sFtGpxGYo/DLrDParOmAMDE8LNTnKrUv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUD/YTgwmcSKD3PwnGxot2STClxFPOufsvGOPDNs9vw=;
 b=Y55inLpSkUhu8snoZbJfPUzbWpViP6PrkjpUvMd/S3NGADpOkfHLpIQwhXys/+S6hSpdRsmkGGxgvA2K3HZ8I208mVvsgHuyyIleiiVjGMNEKb+qP+kbTSDi8Yzsns5aP2MWg6x9XNHc6R8OxaRmRAKNI3kClJuAg/a3omvCbbS9iwEUYbaAzv6WJFLCeLpJu7tMIKe4phlaQlFPzHtw8ZRpD7DQm2pKQYTZoytoqEUQeFVWmuWgefvswS3glDzc7pGHfZDFKkGthfaUUuH3Z7FUBmYOoumKfDIETd5bnoByWf5eflxbH0N/QdYlncDWTcy2wn1eeL5zfdUg9man9g==
Received: from MN2PR17MB3375.namprd17.prod.outlook.com (2603:10b6:208:13c::25)
 by CY4PR17MB2024.namprd17.prod.outlook.com (2603:10b6:903:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.22; Sun, 24 Jul
 2022 01:28:35 +0000
Received: from MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba]) by MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba%3]) with mapi id 15.20.5458.023; Sun, 24 Jul 2022
 01:28:35 +0000
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
Thread-Index: AQHYnetEdbV32htwsUehUnEKE6IRwa2MCk8AgACyeYCAAADDSg==
Date:   Sun, 24 Jul 2022 01:28:35 +0000
Message-ID: <MN2PR17MB3375B4CACF7EA20A0593F215B8929@MN2PR17MB3375.namprd17.prod.outlook.com>
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <e700eecf-e7e0-c2e7-9e20-b5d20df4b65f@gmail.com>
 <36084c97-b675-1400-52da-f74bf4b61930@wanyeetech.com>
In-Reply-To: <36084c97-b675-1400-52da-f74bf4b61930@wanyeetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [/u7d6cNbrs6jLta4s4NkR9dMmKZbEReHOb03zz+JhawUZSMUMxHT7cOCi6deC9XEwqr0xF3Dl1o=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85b6d2f0-20c8-4200-2c62-08da6d13d400
x-ms-traffictypediagnostic: CY4PR17MB2024:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QdCrYMhkwjjpCO3CqokoVPtUwKWMx88pwGbxkyX741wWyTXK1VQotTaq65xmw7ahE/fNewY8Chx/q8z0bs/PWmSkbflbjlRPb0MYhEbfJPYHpYuB+U1PyE/ShuZ7m3USpjsPU3aDPMdx0SoenL8b6h/E1n8WFw94kc+q1LfZgSvAmfF+TQ/WqhSyAQcH1sXeptUVyL2v0D0JanTDGGEYLkjE0Y3i3VD8DbnrlDBroUi9OIV6hpGooL/VU83/9HI3Q9XbTOZHLUcxrNSBjdS3nXHn0Cvx+wXJgv1ERas50Bgxt2QqTpUGlov/Zt5UMCLquDcGaqeloDld3U7kQo/7HNo6crS56tSS09aBZyk4/h+dOH3PPZcRmZEWM4ShzjwGAmJEztl4u+J7t4ei8c6P5YChX/GTx3wBHXRfwv+pT5eu7bQZJrzJrCMeaw1aEUENJRfus+f7fC89Yj7tpwF754YR2gRpsgJfw19csdqyfw+A8mOGDk3nuXomlm8fmHEERj5x8dYMN1OE/rkHfvwYspTP4/FInCy+pWFDtvev+Tg6aNqyQmhgEORqrTP9TEeU3hmO1xwIBZ8kIN9+Jgq+49HO6FYlwxqFPvB3l6Q3YBlSvsPRiQFkOUlyC3BGfg5G22FuFK/3ubOOH9N/76pNsC8NgCe38kBBjTs7JBmCoJgMcBp2H5Z/iomJxeqQOAvU
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXlUOVIwQ0szZEY1dmFLR2cyRzlTWTh0NzVsaThOT3NEM2pLWlgzVHFvRTZp?=
 =?utf-8?B?eTYvM3NmRDZzeEhxOHI4TXVwRU8rKzdDRmkrK204YWVHOVBuRmRnREQyL2o2?=
 =?utf-8?B?K2R3Vmp6Qi9PSlF0OXdtODNGSVpDYkhSNEtGYWFxOW9aZTlxcDdlTDNxNSs4?=
 =?utf-8?B?bEY2cnpMN3ZpcDdYWHpSdG5UaGlUWVNvNDdVWmZDN0R3bm82amJENzBVZzJ6?=
 =?utf-8?B?bTBibzlCQXo5QTh6ZStjaHlTMG5YTnJhQVNmZytFMG5pQVR2a3NkbUQxb1BO?=
 =?utf-8?B?ZkcyenpOLzRYay94eERRNHRCWW5hZTM3TlpRV2hBdHdUU3ZJWWFPYzV6T1Y3?=
 =?utf-8?B?Y2dCdW9Ob3VrNjZNaDBiZkxacGIya3JyQlE5dGE5ZWZqR1cyalZIdktrYmtN?=
 =?utf-8?B?SmlKK3dlRFZUYlk0VWhUZUZ2WjBRWDIvcDFsaDJnMk5jVlJxNlpiODlXeEpP?=
 =?utf-8?B?ZmV3Q3JJaU1VdVREaDMxRzNHVnZxU2dKem9FMDlCeGw3ZmhiQmZxdnY3YzRm?=
 =?utf-8?B?cGtjSHlEWG04THpwc3VhbUFOZUJJRmRGQWZ5N1I4Njl5VHRSVTJTNzBWQXJ0?=
 =?utf-8?B?ME5tak5yVjBpYXBWMlRkMmNpK1NESEVNVXBybFRhVXlqR3dibDdoUzNFQlFp?=
 =?utf-8?B?K0xtZ0xTbkZTYi8zNVVoenRNT1hvSWFBanBwWG1SaFVUbWoyNDBsSVhDY3JP?=
 =?utf-8?B?MTJMQTdtanJSMjdTUjVCcytTaWdsQUd5Z00vT1RZZXVMRDF5TTZTTE9BQlJ4?=
 =?utf-8?B?VkJEV1hoSi84ZUZPcWFHd0dvYTBLWDBhQmQrVFAwWngxR3VHd3RXTUhweFJQ?=
 =?utf-8?B?OWpCMnhybGM2NU5NMjc4Z011NklOOWU1cWhrYWVibXVQeldYL1hmWHlHZnhH?=
 =?utf-8?B?a1NjaHhzYmFDdEhIMU1QOFdUeis4ZWxOM0Q2ekRrNlByekJxNXJMT2Uyckxw?=
 =?utf-8?B?VEVIemhnMngzUnV2MDduU3dUY3NWaEkvcmxCRkROeXd5Rk9uREU1c2YyTytG?=
 =?utf-8?B?UFpZaWozOWUrWHVIbkUxMlZBaVNwcFhUd2V0c3lPRVNuS2NIdjJMd2gxZGxU?=
 =?utf-8?B?bGgvZDBRNm43QjM3UHcrRkoxcUMzY2lRY0ZSb0lSRDZZcHIveVRiWVlVZ0or?=
 =?utf-8?B?eUVnWkc4eWVWUUlSMEtaZzV3ZUppYTF6WHdNYTNNK01NZGd2S3l3UlZWYmto?=
 =?utf-8?B?RHkrVm1LZHNnZkpUb0JmYU9SVU91eVVWaWp6ZERRQnFkNnV1MkhTS2I5VXIw?=
 =?utf-8?B?cEZhTURCd2NQVHJQbHE0YTFETzJXZERqQm5VOUtjaElGY3lTSzJ5U29OZ2Mz?=
 =?utf-8?B?OE96dEt1Q01BNEVCSmptVVIzMHoyNmZiTWRVQkQ3UUJuQ1dRMVphL0lNNmRK?=
 =?utf-8?B?ZTI2NCtwb25GdG1pdTFEcmFSRzZqN09PdmFQRmNFaWtsdTd3UGpnQU1NT3Ri?=
 =?utf-8?B?TnR0MWJKWm9ZYmhNaHQxcFoxV1g3R25YTGd5Z1VpZnhFckRseXdHRjB1K21J?=
 =?utf-8?B?THJrSy9TUEZ1YktTTVJoNTVPSkxiY2hRR1hJcEFkMGxSNHpSdTVPVWlMcDE3?=
 =?utf-8?B?cExYYzlMVC9PalJuUHJmZ01CQ0xyMGRiM0xwTVQwaGJ2a2FnaHIxUkRvZy9q?=
 =?utf-8?B?cEpsTlkrYmJ5NmFhdCtYcHhKVm5qNmg3SFBveTZXNDFhWCt4RUcwdjgzMWtU?=
 =?utf-8?B?eUZibk1YNzIwb1MzVDdQVHBsZ0dkVjcyNm90VlBlV2xIRm1GVExrNXV0RmU4?=
 =?utf-8?B?aVdabkxPYjFaeDdFMEJ0ek84ZmUvTkp0UkFkTHZ4Wmw2YVMxbWlBV3R4MFRs?=
 =?utf-8?B?VFRhWXV0RGVCM2hSTnFTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB3375.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b6d2f0-20c8-4200-2c62-08da6d13d400
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 01:28:35.4621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR17MB2024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
