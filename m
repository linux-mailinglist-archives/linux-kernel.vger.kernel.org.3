Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC45A85E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiHaSlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiHaSkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:40:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29320FB2BC;
        Wed, 31 Aug 2022 11:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5gLwuC1/aUbZCLgUmiIdI5XrNIIZap281dE/XnTdtMJBH1+IOzVu4XC6jx1mF9gxp7MKxTvrBhbu1qeNCcfZo1MYIZsZVsUCtEvLR+Of7E1qTM53gueBww2o78nY9qyXdu64ogvYi2kxO7mtD9C1J/viEqkY09Ak0+D2lB3Q4UO4druaVuhXdis5kl3GCbnD+ZUs9lcB+4e2YgldgrZkHQ8WAts61F/yddGXnUD1QDEfvlILtKVViINOl6PVPsr3deBWr/nkCZM+/EOkEuX5I88dLr51qxuZB2kXGdkTTCalxK8idr/qIvF8uxq+xpPG8EopCTfS/LxyzINBIPmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VirBbE/vzSNS6Pl4Z/98WOXU/OfuYItF6RfgzT5dFK8=;
 b=J8Ms8b8QMuFAxvtfl/lGMp6YnIH+DM+Q1G8GNEUIGAMFZu9rxlp9p6LRQ1RTEZuUs1DiyA39MmsZJM3t0OjYkz5YKonqVkCiuBfEymMTG+uEkBKDVwVMmJb7L1Av1iPsnU4XjM/wGFv/gGnGDILoYiEUOGnkR678R1A6daENF6mEfuwtjfC1n8dhNJO9ht3dQM1BjpfEcHzVQgnP31+Ne2Ae3lyxRGq/rQFrnmbHm1veyOETKq6ysGuJ7PXL6l18hGG1a7U3tV6s2ooaKrNndV3Duk8qx9QPkVArBDUJTDmKF14DC1kCUDfjE+TeSL3+JyW4TIsUyGYM4wl54AMcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VirBbE/vzSNS6Pl4Z/98WOXU/OfuYItF6RfgzT5dFK8=;
 b=kdVm122nCoGGenkcyUxX9Mn54E8foL6Nrt1Ko3DqawKbK+aOeQnejCXmZSA3TPMEW6wl8QMxlXCJ4ZQo8T9b7WY4dV81NURahH1K347R9AkxtqOgLG8gRU3b0OWlFUatEVh6jQBRGKeuAvKokuqxQXKGciJqeV2FVaOqfDxapTQ=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 18:37:48 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 18:37:48 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Brad Larson <brad@pensando.io>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 03/17] dt-bindings: spi: cdns: Add compatible for AMD
 Pensando Elba SoC
Thread-Topic: [PATCH v6 03/17] dt-bindings: spi: cdns: Add compatible for AMD
 Pensando Elba SoC
Thread-Index: AQHYtM81ZsYE7nBWZUiWU+CbSCLFkq27PqeAgA4pQoA=
Date:   Wed, 31 Aug 2022 18:37:48 +0000
Message-ID: <bf88b23f-954a-c245-15bb-20696eee7ed9@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-4-brad@pensando.io>
 <f5561edc-f2fc-05c6-8f24-e0b362989302@linaro.org>
In-Reply-To: <f5561edc-f2fc-05c6-8f24-e0b362989302@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bce7574e-03a7-4ac4-e367-08da8b7fe758
x-ms-traffictypediagnostic: BL0PR12MB4898:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +QsvJwDfApXQFzC8UiajUftu26FzZ2Lt7LQTRe/XXdMwq5gIHOEyvapaqYED/qD8Q4hHonYTZdieUEFKDAGBxu5OOkdXSd69+qMfbuAyKBT/k/uJQr+eCFrYOEV0z2yEA6xBOkH4HhNtxOHMN7a5WmiT+n+BDDkEkRxQFxp7emCa1fk3Tugiv7DoXrkPdClWvGOx6jWeyUd343eJh4fLtsJCIn5mromFtPMHmjLgs8LvoiTuu5dW6yeXUddRk8dVFmWEhzTHjs3IUIjTNVwvCdBQv44xZr4yYFEAdfwnjkCELsr26/hXR8Ilw3usxA41CqMtgNBtr79MTHnYVthOWiLUR/aDXbW7aLuMDmaqukKv5Sc7lkp+9uWKP1USULHKFjDnyqtoSmmiZtgeOIsZvhM+TQHDkqH5/My2FMf4QRECABpWnSZfuO1mT3uLRoMTkyO3V1ss8MYoBRo8zj9jsRz6OwxznXZ5cX1RUAUEL3fvlSwfoWq9OHYVwFC7d5swFyMfbsD1ucE97rajh9S1QsJVsSQ8WL/b3SLYzXH4tE3wMVkI8D3fGS2DKwHBiEeRq30pjOH5U9iCvpRu4e3IHGZSViE1uIGO5yOxYRQ5J21GklVR3J8217kmTWj1KRCeWFMonpKV1OUCT6xTzM11V7Ngs4d13qvP3lHIksMPLwGA3T4WK7DdDLM/RQSoi02WA7JklXr3PKW54zGlAPjEWwvsh56UdBj145VaUTLTcC5TN3JT4/JBwKrkZEf97XNFdk6jMc04IOuLCpHWrXezY4jRZR30azcuLBry5SmIT6voPrHQKctRQTiS0+t10exz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(38100700002)(122000001)(66556008)(91956017)(4326008)(31686004)(76116006)(316002)(8676002)(66946007)(66476007)(66446008)(45080400002)(64756008)(86362001)(31696002)(38070700005)(36756003)(83380400001)(6512007)(71200400001)(6506007)(26005)(966005)(53546011)(41300700001)(6486002)(478600001)(54906003)(110136005)(7416002)(186003)(2616005)(5660300002)(8936002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVJCUWRDdjNEMTFxd1k2Z3hMVXdWSjlzN3ErdHYrQ2ZuU1piWk12SXF3TG9q?=
 =?utf-8?B?bk1HcFFjR21GakNzNlV6TkZvMis3TFljTDJQT2Y5L1NvVVNMVU5kZFFDUCti?=
 =?utf-8?B?Mzh3YlVvckM0V2N5OEswOW1DYkRTeGVNNmZwWERVdjhReVR0UEMxbmZIT3RT?=
 =?utf-8?B?ODA0dmQvaHpqU3ZHZlRQVG9qYlVYcXVIZjllK3BJbmtWU1BURkptMWxQa05F?=
 =?utf-8?B?NFdTVnFVMzhVVjlpeDJOU1NHSWVBZ0RpSy9YcXZTaHpicWpseGZNRFdwcDRj?=
 =?utf-8?B?VHhNKzcxZS9QMXFmTlJSSXlmUEdsblFoR1JVVTJndFNGcEpBWUo3Rmc2MnMx?=
 =?utf-8?B?aGo0ZmpuOFdZWCtVb2h5VjVZR3FSaldHKzFZNElDNE1vLzZEdGJoaHdKRFlX?=
 =?utf-8?B?WHB6NkZ3bHFMbmJiTlYvM2c5blNISU5TMlZscDEzbG5hRkNrTWZhRU5JWWJL?=
 =?utf-8?B?MlY0R0o2SEd1RWZQcENLM245NFVkWFl2VHJ2MTdYN1ZQU0NyTFdCMWNYR2ln?=
 =?utf-8?B?VzdRV3NRV0Vmb1pJeWFkdlo4Q3BGYkR0VmgrcWt0UDhBWDgwVjlFZzJJMk1n?=
 =?utf-8?B?RXhrcnlheXJXVlpGYkVKOGIxUWdyWGlLMzc0SGRGbWJJTEJVc1Q3MXRZaWtn?=
 =?utf-8?B?OHhKd3B0cU80MXh0eTJ4SU14cjlmL1dXUXJDM1V4QzJRamRJckpLVW0xRHh3?=
 =?utf-8?B?ZW5sbWUvd0dvZEtDUktlVVZ0SVBoWG9aWGJQOHlieFNETUVTcGFHYlNZekxW?=
 =?utf-8?B?Znh5WFZNcUw5NWJodWU0Vk1QTnBvQnQ5RDluUmhjbFNoLzR3NzN3V1BKTk1x?=
 =?utf-8?B?cTFUMDZuTVgwVlNLNXdkbkgvYVdUdEhwc1M2YTBWQTFxREFUekZZNTlvQUFq?=
 =?utf-8?B?L2YrVjJYcC95RFZaWVdYUyt5OVkrTERKL1ptUVU0T3M2am5xN2txWG93ekVN?=
 =?utf-8?B?OWRKNjk4WHlabmFjaVlRWGU1UTh0OE9yTHBRbkN6OSt4WjdGSkRYUURCYnFr?=
 =?utf-8?B?Y05RODZrUXhWYlNSRGM4L2hncGozSzJQd0IwTWwvazNRUmYvODQ0NWkrRGpX?=
 =?utf-8?B?bG1yT09Zd2VxeUtNTktFMFZHTlVGZFlMWm1LcWJiRkI0Wlp4VXVlUDg0aC9U?=
 =?utf-8?B?K1FKblB5VjlEODkyNmM4UVdrT3pqNXhMSHh3T1k2djA1L3BRRGJnUFkyb1Zl?=
 =?utf-8?B?dDJKbVdMRm5GOTErUUZtNEN2cVhyblVveG1JY1FCSmwrOVM1YXoxZVRsK05H?=
 =?utf-8?B?WktVUkpWdlJVME1Id1FIckhVSTVrQTJYS1ZoeDUrL3hOMWJPVldvVnk4WEJn?=
 =?utf-8?B?SThBOEV1cWZ5SHdHQ1k3a0pUbGM1MmZXZmFsSGJINmhzVWl0QTJWRDNIbWdp?=
 =?utf-8?B?QTNhcEFxTDJjWEduNXhnNFEwd2ZudVI2dzBXUndDT1RDakZIeFNoQWI2US92?=
 =?utf-8?B?T1B4aVhpZVl3cWZWMDhBb0ROMmlUa0tEaFhJU2tBT3MzYjZlSDJoVitJdmIw?=
 =?utf-8?B?SU9rOGtUOUJVNGdRVFhQYVQ3ajUvbnJ3WkJiUzZoTEhrV2ZlQkt4aDg5STNV?=
 =?utf-8?B?TVhTd2lxTjJUN1NIWGEyZnVES2pFS2ZFaVFJSmV2SmlIVUNvMDA1VVFHaVc3?=
 =?utf-8?B?VG9qUXRublRUbUdIYVlLZ3pzaVNBOHVRZkE1YXUvMVFnbjhDcWJDMTdDV1VH?=
 =?utf-8?B?V3ZRWXhtcDhUY2dZSzJ3bjZsZ1hGWXArbnQ4V3FpbUNzNzRLckxneUNTSmcw?=
 =?utf-8?B?cnRzQmI5SEY0eCtlamVELzBQdGxMcGxmNFZ2Nm1EbVU2ZHU4b3ZJVWxLYVMv?=
 =?utf-8?B?UHVXNSt5dU5tbnhteW1RZ3VIWjBTZnRRZ1RpSytWeHNBSVEvSHRjcWFpRWE4?=
 =?utf-8?B?Q1ZxU0x2TFh6c3ZoS2VodVRWQjRQLyt1djZGTDZKYWRLOGgvbHkxS1I5dzIz?=
 =?utf-8?B?eGpBMFgrVThTYlB5RDFGK1JwM3FYMkJ5QkVqektrRDZnVThSNEErUjhSTXMv?=
 =?utf-8?B?RFJLUXJkOVFOOSt2N1RSQ0NsYUVLQ1h1MFZLakduU0pOZksxRkpjTEwyZDI0?=
 =?utf-8?B?eVJ1b0hDaFYzY0tRWU9YUGhGU2FnczdCTTBLTWZrUm1aNS84ZE9DK01zVTkz?=
 =?utf-8?Q?3zOs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11A396C32431E946B27FFBE3BE8340AF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce7574e-03a7-4ac4-e367-08da8b7fe758
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 18:37:48.4191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTkvlxeMvVl09A6OeWzk6mrL4E93lbZhR+T7qsxNAh02oUSNlvWemiEtFBhR01A+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMi8yMiAxMToyMiBBTSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gW0NBVVRJ
T046IEV4dGVybmFsIEVtYWlsXQ0KPg0KPiBPbiAyMC8wOC8yMDIyIDIyOjU3LCBCcmFkIExhcnNv
biB3cm90ZToNCj4+IEZyb206IEJyYWQgTGFyc29uIDxibGFyc29uQGFtZC5jb20+DQo+Pg0KPj4g
RG9jdW1lbnQgdGhlIGNhZGVuY2UgcXNwaSBjb250cm9sbGVyIGNvbXBhdGlibGUgZm9yIEFNRCBQ
ZW5zYW5kbw0KPj4gRWxiYSBTb0MgYm9hcmRzLiAgVGhlIEVsYmEgcXNwaSBmaWZvIHNpemUgaXMg
MTAyNC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCcmFkIExhcnNvbiA8YmxhcnNvbkBhbWQuY29t
Pg0KPiBQbGVhc2UgYWRkIEFja2VkLWJ5L1Jldmlld2VkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5l
dyB2ZXJzaW9ucy4gSG93ZXZlciwNCj4gdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVz
ICpvbmx5KiB0byBhZGQgdGhlIHRhZ3MuIFRoZSB1cHN0cmVhbQ0KPiBtYWludGFpbmVyIHdpbGwg
ZG8gdGhhdCBmb3IgYWNrcyByZWNlaXZlZCBvbiB0aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0KPg0K
PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZlbGl4aXIuYm9vdGxpbi5jb20lMkZsaW51eCUyRnY1LjE3JTJGc291cmNlJTJG
RG9jdW1lbnRhdGlvbiUyRnByb2Nlc3MlMkZzdWJtaXR0aW5nLXBhdGNoZXMucnN0JTIzTDU0MCZh
bXA7ZGF0YT0wNSU3QzAxJTdDYnJhZGxleS5sYXJzb24lNDBhbWQuY29tJTdDN2E4MzA4ZDIzMjBk
NGVhZmVkZTUwOGRhODQ2YjQ5MjglN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3
QzAlN0MwJTdDNjM3OTY3ODkzNTY5MTg0OTkxJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJ
am9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1u
MCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPU9LS3Zwa3dNOFZ2VFk2WWhoS3Jta3FTTEFP
WVJIeHg4SDkwVUZnNEZ1cE0lM0QmYW1wO3Jlc2VydmVkPTANCj4NCj4gSWYgYSB0YWcgd2FzIG5v
dCBhZGRlZCBvbiBwdXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5IGFuZCB3aGF0IGNoYW5nZWQuDQoN
CldpbGwgZG8gYW5kIHRoYW5rcyBmb3IgdGhlIHJlbWluZGVyLg0KDQpSZWdhcmRzLA0KQnJhZA0K
