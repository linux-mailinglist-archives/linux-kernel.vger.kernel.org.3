Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C215A8927
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiHaWli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiHaWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:41:22 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32D0E1151;
        Wed, 31 Aug 2022 15:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwuVLDbtPpbojzRhA1uNUYmX7C3k0v07y6nRCey+lGBWvUjrJa9i7XdwCcWM3MpOLfSYw+YDH6n56X2zbkXITX4EfnYXkCEjdYv3l9+q2KTzMc+JaWLwgqp24+RXv3KtawpxYI8Dmd+Fq6ubYCLYcrCbopex94eRn/REhrWxjXdyG+XouNWOQTzGtKKK0KFNbQadYdI2XXxGkm1LJJfAueI6KMgVpI9uJJ5MdOObrTPsinGwbYpXCGsVgp9B6fY02OafXgjs6+iF8cVQiIs6wfKqTJSmyazfYir7XQvGdgJ8AJjDAu4m0Vq+Y7NHv4CXP88Y2OZDUmuplaBC5SyWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jitr9/pSq4qgG5HNZT6YIkJ4LajmSNxxqG+jRhWDCUA=;
 b=K+S7U4BvUVWg1OT0bZSXBx0vm5cJSj+gFTj/iJBIZJJBGPO3YD9Dr4Zgj5iXXvQGVU2l2+jpzYogZII1FN1FXsaikLjY/YEtP4FZoDHni7rBC8xvpBQdpLxI0H+EvbfC1KmVvHGJN8t3HTWOBx2V4t8tF79kXJlyP4AunSr96zNLrF0+3bfVaRxOOyjX27Fnn4rk61oZN8oHL8YPUwBjhFiO9IIVlEUcADxzSGHB+86G9DNTxmW8oXVK9L9zIfs4Xv4bp3dYT66ISrON7skK5EiX3eRjrXU9Ga61Dy8VSur5+BaMwAUxdRwSJnZMS83woSsUtQ/LwawBXYomQE/C9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jitr9/pSq4qgG5HNZT6YIkJ4LajmSNxxqG+jRhWDCUA=;
 b=yN913YwEvcrFUofW2TVk4LJDtc6w3XPJ+x/VANwB7bVIZXc0p4uaXVj8bDdpjnb24bNM8iLrsxKWbhh6AVE3u67JvOeWuoTF2lQKRDZtn7K4wqQcbxycR1k8Dn2N6VlVjLhSmG8jJ7WsEE6Rada+D/haX0zl2OwaT52YL3AsIEo=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 22:40:42 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 22:40:42 +0000
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
Subject: Re: [PATCH v6 01/17] dt-bindings: arm: add AMD Pensando boards
Thread-Topic: [PATCH v6 01/17] dt-bindings: arm: add AMD Pensando boards
Thread-Index: AQHYtM8zMIabzh6LFEWH1V6IFYvy9627PNUAgA5u8oA=
Date:   Wed, 31 Aug 2022 22:40:42 +0000
Message-ID: <0e0d8a1d-1232-83ef-698a-97bca0498f03@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-2-brad@pensando.io>
 <9501750a-e382-e4ab-cf96-d1fc6ba1c6e5@linaro.org>
In-Reply-To: <9501750a-e382-e4ab-cf96-d1fc6ba1c6e5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6dc5422-c00f-46e9-0b40-08da8ba1d638
x-ms-traffictypediagnostic: DM6PR12MB4957:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fj5zWeDhe/leF1u9EtdY1m21rYydxDSo6M2qKWz4PBwyWJWfN26ketAt8gXT0LrJ/4WtgKXJ4E4JmHxF75Nrc62Fb3j8jv0/2Mk+ElJga+Ap8hwKI9erjRRY8NCqbSdL5Oc+5tkOFBAWj0EC4B3ickBAuNUJsxoADzA7VALF9rorcFdTI8P9sY9qGW3Oofn/o469LAPBskrKKE/LZFeWLjti4dlt/EtRLgaYsx/I0EC/NSVVPtJQPD7sQ7kISchXMBjF91JHN10yypgUncO4K8ndFlRkqcvw7KTC+86Ly94903mKKIdQ5knkXOkANb7WRb7W+xMbJzQKXphiZ3o7l8q9rprAn+46XLYpoBIc3FBu8PthQJS9K4MDdhCuG/dcjowGxOXRHM3s12D8hRzrm6VZar6fcGbfbKH82hdUulHwEuTNolfkjCEpAFxZ76ozwO+2ngZaTeZQ2vVgi7+ZSf9DEH1wdMXzZjJS4YIlTRUL3HyO50FJ0SzzYK6liVVTUie0lM4Wy0CmgRE4DjAEfyR5zhqKy6MGnIvRvMkCwUgv1kCR0FczJ+ES6EPMY6KdtsYKtZ5AvOko//6n05qhUy7zXHNoXcBq/1RnQsC7Ivgp07APzL1qnYjfh8y11Kb8Gtg5Hi0lf68Ia1y/psq21uuP2ZNdWoecQnvUN0Dvn58xzcWuJfCUxlYy/Z1XDtiSF2e3RoGkKPfoIKwlb9Mp+71pN1cua9QA1X3j5ZmqPl8bBJbs54XtqkYqme44M+7KZgK/ZoFxHLu0olTKooDGsagghs/jAdodZcs/GiCLBRFT/JyRhPW65D8LmxADQTrVH8EpwrqkY4cIv+zQCds28Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(8936002)(5660300002)(478600001)(38100700002)(7416002)(45080400002)(966005)(6486002)(71200400001)(110136005)(54906003)(31686004)(6506007)(53546011)(316002)(41300700001)(6512007)(66446008)(2616005)(86362001)(64756008)(26005)(83380400001)(2906002)(66946007)(76116006)(66556008)(91956017)(66476007)(122000001)(36756003)(31696002)(186003)(8676002)(4326008)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmVLellkQUdtQWNOWTd2MGVicEhoRTJ3eTgyajdCZjNkMnZzaHVUNWxKaFJW?=
 =?utf-8?B?MnZLTG9LTWYxT2hoM1gwTmdlSnR3bEhHQStNeDZ0UHBHelR5VkoyVUdQbnBR?=
 =?utf-8?B?MTVFN3ZabmhpVmNzdHlnR2ZqMkluNDJOS3VuYXpoY1NSL1Y0OG9NRjdPWnZN?=
 =?utf-8?B?RzJwTVVLTnF0OXV3V3RGUzN5eU5EcVhmRE40WGZseFliWHJaYzRmdUdzVFFB?=
 =?utf-8?B?dGF5Vk5JaytwUEROSnlqMnVRU0pMSDMwbjNKN2RLRy9vTkNvOUxBZFMxQVRl?=
 =?utf-8?B?VDVBT09LY1dqNGJ2ODRpeDlmNnBUVzExSlRsY1hwdGJxRWZGbnRtV0JneGpE?=
 =?utf-8?B?ZUJWaGtKK0xSYi9oYjQyMnJGdThTZkpVN0ljZGl4dTcrcW5pRmxnaGZwUDVa?=
 =?utf-8?B?NStSbXZQWUliM0N0OWtSQ3d5SG5EMmdsaHpkemJEcjFQU3J4WmhtS1FSekUz?=
 =?utf-8?B?am5RTnNKcVNwdWtlSzZZY1hNc01GYUpRSTJMWllkRVFNV0ZZTXlydWdUN0lz?=
 =?utf-8?B?NzZMRHUzSzJrVVNLdHNaWE9kYTV0YWpzR1JvMVkxd0xvYzZSaGtqTWVzMEtq?=
 =?utf-8?B?SmZnMlVtUFlhckNPOE5YbERHTmFQL2FZVS9RUjBSYlBZMDBGYUhyWjAwZDNa?=
 =?utf-8?B?SEZCZ3o4blJXUEdXNGl4OElBNEVhVThwQjJnQ3JrbGNvTmpJYzFkQmh6cXIz?=
 =?utf-8?B?Y1NEMGlxSzFJV0M5d3gzdFdTWWNXbHhCMS9HVFRGdSthRHNXRlQ2elN3RVdK?=
 =?utf-8?B?Y3RXT3NIeFoxdGwzMGJQVVBlYWl1TWl0TWZGQm5Za1hSTTBteWVZMWtVUnd4?=
 =?utf-8?B?bUw2MVkyVmhlOFhUQ2tMMTRvUzNNSHVqUmdiYzVsTlhzd21PWDlNemthc3Fv?=
 =?utf-8?B?ZFFnanY2NWZWRFBlSGRza3hZb1pVRk5qdlJOK1JHL29uWnQwSWxmTmpnZk5m?=
 =?utf-8?B?MWRkK2F0bGpRQWxaTS9TUy9JVzZzcXkvQm9vWC91SGxpV3RPWVUyWm9kOVhp?=
 =?utf-8?B?ZmYvV05KWFhQUHVLYzUxVWJEdDZXN3Zqd1JDVERrR09Yb3kzbUhaSzVteUt4?=
 =?utf-8?B?cXpyVlZGZk92NmpsL1gvaGwxRktyTVZpUUd4dmR2azFFTUsxZzRmNWkxazhJ?=
 =?utf-8?B?ZjFSbXNMazBsL1pRTVdBOFhJSk96SDlmNGszdmJIbkNMa2lNTElkNUgrQ25G?=
 =?utf-8?B?QnhSb25GVG9QaE13QmlpMkRyd1dPM1pCbk1kVnMyVHBaOCtSdlFOZmVVM2Yv?=
 =?utf-8?B?L0M2b1RBV2xQOUxJUmEzMWZjNTVWVzdpejBDbFBrQzZBaHJ0Y2pWenQxNW5O?=
 =?utf-8?B?WXVobkV2R1pKL0I0UjBKZG00UVFmSzU5WXpPQmVLL3BLZ2lhZW5VRlFjMG13?=
 =?utf-8?B?RHNaRmdrSFcwM1BKNTBtdnVsZEJQdEhMVUh6RWFySWp0L2wxbGVibDBXUUc0?=
 =?utf-8?B?cFZlNUZmbzkvWTVGNlkzdHJ3amxwZllkSlFYUzcyTjkwekJUcTJPaXhNSmpv?=
 =?utf-8?B?MmhCdmtlMmRxVFY4Z0NURk1sd3pMdDArQjIrMlF1ejNQb2hYQjN0WVRTdXNP?=
 =?utf-8?B?dXoxWEVGVWNYL0R2czRCWjB6dUJyR2NVMXFnaHdRT0NmS2lKanZTT0NkYS9v?=
 =?utf-8?B?c2hxanp1US9YWUdOWHVocmhuNExUOVJPZXRRZ2t2dXlOTis4OFozSWYzMlp3?=
 =?utf-8?B?cDNxN09LcDY0VVU4VXlTL0wxZnR2RTdOY1BTeUtmUWZDUUZIVmtQWG4rTmRP?=
 =?utf-8?B?eUVXWHZiQlREc1prdGRXNkZud3YrQVFKWTdpZUY1WEFybUhjUURkUTlzQlVZ?=
 =?utf-8?B?U0Z2RjZIV1pUTmlIUjZvWmFTaTZlYW1JZ0JiMDVNTW84SkxFeEVjUW1LZVNT?=
 =?utf-8?B?TmhZRmNHQ0RuYUJ5aUFnMjhRRmNVd1dMZzlWREtNWHJpR3ZRY3BjS2tsMSs1?=
 =?utf-8?B?UnBxNDRKQTZQbWZTeU8yT2tSRGVaN3B1WTRGNGlRZDluaTJwd3hXVVg4OVV4?=
 =?utf-8?B?VW9mb0JzRXNEREZ1WjBaSnQxSXJnaUc4Mk1PeHpYSkR4eEh4dFFwMEgrOTk4?=
 =?utf-8?B?TXphQ3Q4UGVCWlc0MWtqOGJTSU1NTkIrNHJSSVRabjFhK2xIZkNkaWMzTWNV?=
 =?utf-8?Q?Gf0U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F56C603FDB7F4644A8D5DB054854E938@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dc5422-c00f-46e9-0b40-08da8ba1d638
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 22:40:42.6026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKPbI24I010FCLnFVivT8REe68S61q+hbWY856JNLvKXBx5r3wCNGdilzolbavdC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMi8yMiAxMToxNSBBTSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMjAv
MDgvMjAyMiAyMjo1NywgQnJhZCBMYXJzb24gd3JvdGU6DQo+PiBGcm9tOiBCcmFkIExhcnNvbiA8
YmxhcnNvbkBhbWQuY29tPg0KPj4NCj4+IERvY3VtZW50IHRoZSBjb21wYXRpYmxlIGZvciBBTUQg
UGVuc2FuZG8gRWxiYSBTb0MgYm9hcmRzLg0KPiBEaWRuJ3QgeW91IGdldCBoZXJlIHRhZ3M/DQo+
DQo+IFBsZWFzZSBhZGQgQWNrZWQtYnkvUmV2aWV3ZWQtYnkgdGFncyB3aGVuIHBvc3RpbmcgbmV3
IHZlcnNpb25zLiBIb3dldmVyLA0KPiB0aGVyZSdzIG5vIG5lZWQgdG8gcmVwb3N0IHBhdGNoZXMg
Km9ubHkqIHRvIGFkZCB0aGUgdGFncy4gVGhlIHVwc3RyZWFtDQo+IG1haW50YWluZXIgd2lsbCBk
byB0aGF0IGZvciBhY2tzIHJlY2VpdmVkIG9uIHRoZSB2ZXJzaW9uIHRoZXkgYXBwbHkuDQo+DQo+
IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmVsaXhpci5ib290bGluLmNvbSUyRmxpbnV4JTJGdjUuMTclMkZzb3VyY2UlMkZE
b2N1bWVudGF0aW9uJTJGcHJvY2VzcyUyRnN1Ym1pdHRpbmctcGF0Y2hlcy5yc3QlMjNMNTQwJmFt
cDtkYXRhPTA1JTdDMDElN0NCcmFkbGV5LkxhcnNvbiU0MGFtZC5jb20lN0NmYTNjMmE2MTg1MzQ0
NzljM2IyYjA4ZGE4NDZhNWViZCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdD
MCU3QzAlN0M2Mzc5Njc4ODk2NjY3Nzc5NDklN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lq
b2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4w
JTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9VkZIUGZHZnRwaUVHaW9sTzVDMXlTRHZMc2VY
WkhrWlpFd1NvR3I3bzFVTSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPg0KPiBJZiBhIHRhZyB3YXMgbm90
IGFkZGVkIG9uIHB1cnBvc2UsIHBsZWFzZSBzdGF0ZSB3aHkgYW5kIHdoYXQgY2hhbmdlZC4NCg0K
SSBzaG91bGQgaGF2ZSBhZGRlZC9jYXJyaWVkIGZvcndhcmQgdGhlIHRhZ3MsIHRoYW5rcyBmb3Ig
dGhlIHJlbWluZGVyLg0KDQpSZWdhcmRzLA0KQnJhZA0K
