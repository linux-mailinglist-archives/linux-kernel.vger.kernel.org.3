Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2485AA0FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiIAUiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiIAUiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:38:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A3B72FFC;
        Thu,  1 Sep 2022 13:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7c+fwR/QZVyFhxTVN4k4KNL1npUf/qfHqaXIsTXOWdryvlmd66CG//3qjwnX1au74De4yistW4I9E9duXkdNBl7zLmWyN028adlj6QwIKgjSmMdRTXpbOoraH7qH7ukx/rZFooSf21tJvh47jT/Ifazu4xxFxB1bOtRyLBFMZnKnbXGs9y/Z0w+Jl/r3HDVd1jY0qMUr8qIvHNWfkcPNW0YfPTFxNATUC/Ydn1E6u4enn+FnOm4NqVdTe477QrxmvoKH3KKz88n/OrPFU2/6HJJzlwyXiSZQ2SQMgDVoW++FQs5o6AXOlWr6Zq9I04BsrtF9pY0aUtZUOJtH+LS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4TK5uKcMW7M4qoQ5sGK2+/pa9bMlHmkujTXgaupI3k=;
 b=T63vjyTl3xdFEBCW69B2gg4qY1JvorF/Ov2yhFZGzpmW+yO/R/GqWtr0QFiO3rXfMcngdLnUdixOLf0iyfo1lhMwKmusWKfDgFDw0z05QiZzcTdf7wIpVQtG8bK9BhMFdrKQ0uzKWlsTXnUNY1mpwbBOkuADJMsjfbzdqe3AohoQOWJmIbY161ypHy1Hs4qGRasKeNPwE8STXpxDW9txe7xgcz4XyOUvHny2V7jCCS9N7x3ivG8BxKOLXKF3j9tr4evpGiBR6LAJX3G0+echJ3H09FTpPdZcrvmtvGJrAIHJz2lkeXe47IvFIica/AyoXV1lFSxUIrawTfpDd4rAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4TK5uKcMW7M4qoQ5sGK2+/pa9bMlHmkujTXgaupI3k=;
 b=5iaNN+eL9T5w2V4Y/sbXTnuueORQ/NuKaBHGsicSv5Am0Nte52/5kS3wb6ovklSUG9gSwQN06aZounrZ44ugbj6JgPEw6/Zgl26wwsCRQwB5d8m6xAc6sfjtcHJ20Y5nDZLaSd0ZaAxx6SH9p5hOIQTl+J+tvSPz2aw+0MUAclk=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 1 Sep
 2022 20:37:57 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 20:37:57 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Larson, Bradley" <Bradley.Larson@amd.com>,
        Rob Herring <robh@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Thread-Topic: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Thread-Index: AQHYtM86gXzQRkjAqk6/46/G7K6NoK26/IIAgA61EQCAAItaAIAA3uMA
Date:   Thu, 1 Sep 2022 20:37:57 +0000
Message-ID: <b064ed4c-d5a7-614f-008e-61ff2ac27f88@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-7-brad@pensando.io>
 <20220822142544.GA3770388-robh@kernel.org>
 <554f33b4-d235-5516-e8ff-5bf80d63a9b9@amd.com>
 <936c5623-07b9-c49d-e113-fc056a4eb9bc@linaro.org>
In-Reply-To: <936c5623-07b9-c49d-e113-fc056a4eb9bc@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4b5683a-63c4-4629-8550-08da8c59da81
x-ms-traffictypediagnostic: MN2PR12MB4390:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OCt5SHxymXDjFCIXWz3O6EMe1eaCIz6NMKykxl61TBhrKXurHHXQ+Ltk7DE0pgSNoQ0r/wVoDCXGY4RpAdqwchy74XlcpYmi/2YtGyW9LySyj7D6QbUznq5IJO6F+m3CXbGroYK6CcGIAExcDqq8E1llKmHsRj4i2sn01wNne6St0lX4dmcYiPReTvY+1E7dUfU7IjGwI0Fw8nvDGyVkGycnOvrDoz3+wm9S2si9uaqMLhp4KRLFUVErp3DQEWPlJLxR4DuJlyzfWmPlG2ugJ42yNj8+rZlsYuOGKAoS6E1HzZJKBHzz7iecRoSJ5CSG6sNk1bs4fi6r/43ecs92FezkistdB1PEyUQDP+t2fLGI4Eomu0K3wrKAfWKvJYMFif6K0IgE8z5jTVnjYWwiw6aG4Gaf/Ie++P0RePb+YKfdACBR6zU5NSsTUCBZyyBB4wa2pxDuOP4hlCyIm5Vo3xlweFQWC6SpDItczkOfgVcS8+Lv2ENZ3CglPF8v7rtjctpWcz/IScHUzCHqIQAx+uMcAktySiurrvCNUssNsF0HIeIuiMhWQTatVCGyNWzE44D70jffP0PmBi61H5CuF4O7z4UWlPPXZvUKu0hFpl8o4ImeQP3u63PZLlReYAxnkDSvimPonAjLfntI62VLASf2RfESiilr/stCq5tdmJXihiK5TwWJLBYtEXa7Lp2vVTn04usxoTm9HbrCuUd0qR2oTayvsGkBeqB+zlQ6dtJ0C7UJD5q0myxi2YmhNrnzWb0lfQL+wi5HZ3D8rFV925AsYbeN//Qby12I85nvolk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(86362001)(2616005)(31696002)(186003)(5660300002)(41300700001)(8936002)(7416002)(2906002)(6512007)(53546011)(6506007)(38070700005)(38100700002)(122000001)(76116006)(36756003)(54906003)(478600001)(66946007)(6486002)(91956017)(31686004)(66556008)(83380400001)(66476007)(4326008)(66446008)(8676002)(64756008)(316002)(110136005)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjViUU5HN2Y4cGxMdnJROFdyRmJyWExTTCs0LzVOVXJhMngyR0xXMzRNS3Ji?=
 =?utf-8?B?bk9md2dZOEFFTUZJbTlwUGE3SW1FNHNwazVLZ2hTTjdEVDN6N3hxTmh6dEYr?=
 =?utf-8?B?bWRycEdOUTVPMU5xZnlPeiswYitPeVN4QzZNY3ppWlZaTVplU1VIWkN1OVNS?=
 =?utf-8?B?dmpLZWRQNi9KdXdxZUNCRXVxVzNVS3hRNWhkSjJsdTBjQ1Q1Qk16NllKNk10?=
 =?utf-8?B?U2gvRWZ3VHBqSjdWSTlBVVp0bmE1cWQ4LzlwWWNDUGtyOWpDam9tSFNnNDZy?=
 =?utf-8?B?aHpmS2p2Vm8yaXZkV2Ziek5iVTJHc2pZMmp4YktIdU82aHFtUXNVZVE0eGlD?=
 =?utf-8?B?RVFSUWhCbHU0QUQ4K3UyTUVONm03V1pxMmpFUWVqa1VXb3VmTzZ3YTZ2WkU1?=
 =?utf-8?B?SEtjRjErZFU1YWdSUGZVMEpJM0x0SHk1QWRVT3Nlek1kcUJFeTRQb3Y2Zlhz?=
 =?utf-8?B?c3preU9oKzRrdWxWWVFwR21Ib1k5Y0ZNZWdpYkQrOUpGTGNLR3VzTUZGbHJI?=
 =?utf-8?B?TkFnYnN5bllqWXhNN0dIU1U3U1M1WUVvU2FVWFd0SEtYcmNCekhmY3VrT0lv?=
 =?utf-8?B?Sm5vS1dHUnRrUFJtczZsSjVYQ2hKOTI5bWZBSDFhM0VCZnE5R1RLbVZZKzMy?=
 =?utf-8?B?dGlrN1JRSWxINzBUTjhuM0ZicUxoNzlLZFJMVkpZRFB6NGErNG02Y1Z2T3hI?=
 =?utf-8?B?UG02djZ5Y3NmcldZV24zamxRc0hzNXRFM0tjV2FxalVKVnhqa21kSWh3cWJj?=
 =?utf-8?B?M3VEaFZRTlhsUm9DaFZnMlQrelQxUTQxVGJUTVlPQXpYZHJObDhXdlFkU0lF?=
 =?utf-8?B?a242Y0F0b0p5TnlJSHRsQ0RLNFJyekFWbysyMlFkb0luZzZFOHhHcUxiQU5K?=
 =?utf-8?B?Q2tRd21TSTV6cTdDMGRhcUFJTDJTSFloZWhzMmpxWkhmY0wxcmo4L1NJQmhT?=
 =?utf-8?B?Y0pEWW5jQnhidVUzT2NHVHpVR1NEQVdRWlNKeFhQMW9xRnlyd0txckNlRFFM?=
 =?utf-8?B?L3EyN2FBdktkM1NMUGQ5SzNHQUJzL3Jkd0hFOEVvdW53Zm45TUd0Vi9qWWxq?=
 =?utf-8?B?SS9jRzJVTHMxZENzdS9QRldxQ0dRRWdzQjNkc3JzWkc4ekVsM1J6b2lEeTRm?=
 =?utf-8?B?U08rQWszMmdRZlNJSm5XTndKUmVFVTlEdnNZVUkzem5WNDYzZko2NGdvZFFo?=
 =?utf-8?B?WUhseFNtTTJDam9PTnl3NVlLY1M3WnZsT0tiSmtRcTArdGNwbDFRV0oyYWRt?=
 =?utf-8?B?cGxxb2pNZmxVeXorM01oMjJDWFlSSEg4OWNJTUpxbzB6UjRiNnpqOWt6dlNo?=
 =?utf-8?B?N0h2ODEzZFYvRHdoRVRnZlNBankraTFPUVAydUhGc2FtOWw4a09zRDNpTFRH?=
 =?utf-8?B?Q0Z1NHZTTTd4Zkt0UUwvamV3YjNINk9YS3FhVWRnekx5NGpoa2hGKzVNODVh?=
 =?utf-8?B?RjIyRmYrTlZXVkNqTVBVS2o3U0lqRDBHZitDb1BONEJpQWVQb0g0bXFOZzIy?=
 =?utf-8?B?bGwvczRqZFlJdk0zYitzMVlTOTRMdkRoM25wN1R2SHNUbGlmVWNSYndlNWJU?=
 =?utf-8?B?UTRaVGhrcnhCdGNXQnFlRk5GeGpUTHkwSmVTNGo4ckpVN29xUVBKQ2I2YVV1?=
 =?utf-8?B?eldTS3hDQ2NPdFNzSHJRQ0MzQzcxYWFUZ2w2bVJzRVVLN1BYWVIyeGlxK2N2?=
 =?utf-8?B?WUxJeFBaYkNKVzhkaWtheXd1Yk5EQUFTTXJvTkpMU2M4SGQ4dWxlOUhHbGRt?=
 =?utf-8?B?cGhMWFc4U20vS2FNOXNlajJzZ21xVzlRUFZ1THJDWG13Mm9xbHhpbFNGY0s0?=
 =?utf-8?B?WDlncmxsZTlLd2Z1c2x3ajZTUkZPaldMcUdCUmNkV1NkTDBiclJnUGtXTTBw?=
 =?utf-8?B?OUVVZldkSjZjYStOQWZqcnBHUVlWWlAxM0M4VkVHejhESnZYMWZla3VGaDYx?=
 =?utf-8?B?K29wODFRZTYwdU1uMHlNNUV0NGdIMmxUWXdkZk0wME5NTXFGZmp1aVhrb0NG?=
 =?utf-8?B?bm5MWGZNVjJPbjNIR3hoN0lwb2MyOXdLb2tTRnA1em41RDJ1ZzdPYm9LV1pW?=
 =?utf-8?B?Y0JjMlNsb2tVc0dwWTBJRXYxWmhwVUNFNXR3bkxPeG92QW42QmFGV29kNE9H?=
 =?utf-8?B?dGtyYUhiSy9NOWpGMUcweEZmZTFEREJQa2dOeXhjVlpseEIrL2ZyN1Q2OHNM?=
 =?utf-8?Q?f+aTst43rQrDMjOICStN4LI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2FF903C3D82A247841091D92A230160@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b5683a-63c4-4629-8550-08da8c59da81
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 20:37:57.1777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6W4H9zGcjsWxt/ZvrjtPRz7efQ6Fg6wjHsutu3NopWVLRwbavUMcr5yGpQh4O+Ob
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xLzIyIDEyOjIwIEFNLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAwMS8w
OS8yMDIyIDAyOjAxLCBMYXJzb24sIEJyYWRsZXkgd3JvdGU6DQo+Pj4+ICsgIGlzIGltcGxlbWVu
dGVkIGJ5IGEgc3ViLWRldmljZSByZXNldC1jb250cm9sbGVyIHdoaWNoIGFjY2Vzc2VzDQo+Pj4+
ICsgIGEgQ1MwIGNvbnRyb2wgcmVnaXN0ZXIuDQo+Pj4+ICsNCj4+Pj4gK21haW50YWluZXJzOg0K
Pj4+PiArICAtIEJyYWQgTGFyc29uIDxibGFyc29uQGFtZC5jb20+DQo+Pj4+ICsNCj4+Pj4gK3By
b3BlcnRpZXM6DQo+Pj4+ICsgIGNvbXBhdGlibGU6DQo+Pj4+ICsgICAgaXRlbXM6DQo+Pj4+ICsg
ICAgICAtIGVudW06DQo+Pj4+ICsgICAgICAgICAgLSBhbWQscGVuc2FuZG8tZWxiYXNyDQo+Pj4+
ICsNCj4+Pj4gKyAgc3BpLW1heC1mcmVxdWVuY3k6DQo+Pj4+ICsgICAgZGVzY3JpcHRpb246IE1h
eGltdW0gU1BJIGZyZXF1ZW5jeSBvZiB0aGUgZGV2aWNlIGluIEh6Lg0KPj4+IE5vIG5lZWQgZm9y
IGdlbmVyaWMgZGVzY3JpcHRpb25zIG9mIGNvbW1vbiBwcm9wZXJ0aWVzLg0KPj4gQ2hhbmdlZCB0
byAic3BpLW1heC1mcmVxdWVuY3k6IHRydWUiIGFuZCBtb3ZlZCB0byBlbmQgb2YgcHJvcGVydGll
cy4NCj4gVGhlbiB5b3Ugc2hvdWxkIHJhdGhlciByZWZlcmVuY2Ugc3BpLXBlcmlwaGVyYWwtcHJv
cHMganVzdCBsaWtlIG90aGVyDQo+IFNQSSBkZXZpY2VzLg0KDQoNCldpbGwgbG9vayBhdCB0aGlz
IGRlcGVuZGVudCBvbiB0aGUgcmVzdWx0IG9mIGJlbG93DQoNCg0KPj4+PiArDQo+Pj4+ICsgIHJl
ZzoNCj4+Pj4gKyAgICBtYXhJdGVtczogMQ0KPj4+PiArDQo+Pj4+ICsgICcjYWRkcmVzcy1jZWxs
cyc6DQo+Pj4+ICsgICAgY29uc3Q6IDENCj4+Pj4gKw0KPj4+PiArICAnI3NpemUtY2VsbHMnOg0K
Pj4+PiArICAgIGNvbnN0OiAwDQo+Pj4+ICsNCj4+Pj4gKyAgaW50ZXJydXB0czoNCj4+Pj4gKyAg
ICBtYXhJdGVtczogMQ0KPj4+PiArDQo+Pj4+ICtyZXF1aXJlZDoNCj4+Pj4gKyAgLSBjb21wYXRp
YmxlDQo+Pj4+ICsgIC0gcmVnDQo+Pj4+ICsgIC0gc3BpLW1heC1mcmVxdWVuY3kNCj4+Pj4gKw0K
Pj4+PiArcGF0dGVyblByb3BlcnRpZXM6DQo+Pj4+ICsgICdecmVzZXQtY29udHJvbGxlckBbYS1m
MC05XSskJzoNCj4+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy9yZXNldC9hbWQscGVuc2FuZG8tZWxi
YXNyLXJlc2V0LnlhbWwNCj4+Pj4gKw0KPj4+PiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNl
DQo+Pj4+ICsNCj4+Pj4gK2V4YW1wbGVzOg0KPj4+PiArICAtIHwNCj4+Pj4gKyAgICAjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPj4+PiArDQo+
Pj4+ICsgICAgc3BpIHsNCj4+Pj4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+Pj4+
ICsgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4+PiArICAgICAgICBudW0tY3MgPSA8ND47
DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAgc3lzYzogc3lzdGVtLWNvbnRyb2xsZXJAMCB7DQo+Pj4+
ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gImFtZCxwZW5zYW5kby1lbGJhc3IiOw0KPj4+PiAr
ICAgICAgICAgICAgcmVnID0gPDA+Ow0KPj4+PiArICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+Pj4+ICsgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4+Pj4gKyAgICAg
ICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDEyMDAwMDAwPjsNCj4+Pj4gKw0KPj4+PiArICAg
ICAgICAgICAgcnN0YzogcmVzZXQtY29udHJvbGxlckAwIHsNCj4+Pj4gKyAgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gImFtZCxwZW5zYW5kby1lbGJhc3ItcmVzZXQiOw0KPj4+PiArICAgICAg
ICAgICAgICAgIHJlZyA9IDwwPjsNCj4+PiBXaGF0IGRvZXMgMCByZXByZXNlbnQgaGVyZT8gQSBy
ZWdpc3RlciBhZGRyZXNzIHdpdGhpbiAnZWxiYXNyJyBkZXZpY2U/DQo+PiBSZW1vdmVkLCBJIHJl
Y2FsbCBhIGNoZWNrIHRocmV3IGEgd2FybmluZyBvciBlcnJvciB3aXRob3V0IHJlZy4NCj4+DQo+
Pj4gV2h5IGRvIHlvdSBuZWVkIGEgY2hpbGQgbm9kZSBmb3IgdGhpcz8gQXJlIHRoZXJlIG90aGVy
IHN1Yi1kZXZpY2VzIGFuZA0KPj4+IHlvdXIgYmluZGluZyBpcyBpbmNvbXBsZXRlPyBKdXN0IHB1
dCAnI3Jlc2V0LWNlbGxzJyBpbiB0aGUgcGFyZW50Lg0KPj4gV2l0aG91dCBhIHJlc2V0LWNvbnRy
b2xsZXIgbm9kZSBhbmQgYm9vdGluZyB0aGUgZnVuY3Rpb24NCj4+IF9fb2ZfcmVzZXRfY29udHJv
bF9nZXQoLi4uKSBmYWlscyB0byBmaW5kIGEgbWF0Y2ggaW4gdGhlIGxpc3QgaGVyZQ0KPiBUaGF0
J3Mgbm90IGFjdHVhbGx5IHRoZSBhbnN3ZXIgdG8gdGhlIHF1ZXN0aW9uLiBUaGVyZSB3YXMgbm8g
Y29uY2VybnMNCj4gd2hldGhlciB5b3UgbmVlZCBvciBub3QgcmVzZXQgY29udHJvbGxlci4gVGhl
IHF1ZXN0aW9uIHdhcyB3aHkgZG8geW91DQo+IG5lZWQgYSBjaGlsZCBkZXZpY2UgaW5zdGVhZCBv
ZiBlbGJhc3IgYmVpbmcgdGhlIHJlc2V0IGNvbnRyb2xsZXIuDQo+DQo+IFlvdXIgYW5zd2VyIGRv
ZXMgbm90IGNvdmVyIHRoaXMgYXQgYWxsLCBzbyBhZ2FpbiAtIHdoeSBkbyB5b3UgbmVlZCBhDQo+
IGNoaWxkIGZvciB0aGlzPw0KPg0KDQpJZiB0aGUgcGFyZW50IGJlY29tZXMgYSByZXNldC1jb250
cm9sbGVyIGNvbXBhdGlibGUgd2l0aA0KImFtZCxwZW5zYW5kby1lbGJhc3ItcmVzZXQiIHRoZW4g
dGhlIC9kZXYgbm9kZSB3aWxsIG5vdCBiZSBjcmVhdGVkDQphcyB0aGVyZSBpcyBubyBtYXRjaCB0
byAiYW1kLHBlbnNhbmRvLWVsYmFzciIgZm9yIGNzMC7CoCBGb3IgY3MwIGludGVybmFsDQp0byBs
aW51eCB0aGUgcmVzZXQtY29udHJvbGxlciBtYW5hZ2VzIG9uZSByZWdpc3RlciBiaXQgdG8gaGFy
ZHdhcmUgcmVzZXQNCnRoZSBtbWMgZGV2aWNlLsKgIEEgdXNlcnNwYWNlIGFwcGxpY2F0aW9uIG9w
ZW5zIHRoZSBkZXZpY2Ugbm9kZSB0byBtYW5hZ2UNCnRyYW5zY2VpdmVyIGxlZHMsIHN5c3RlbSBs
ZWRzLCByZXBvcnRpbmcgdGVtcHMgdG8gaG9zdCwgb3RoZXIgcmVzZXQNCmNvbnRyb2xzLCBldGMu
wqAgTG9va2luZyBhdCBmdXR1cmUgcmVxdWlyZW1lbnRzIHRoZXJlIGxpa2VseSB3aWxsIGJlIG90
aGVyDQpjaGlsZCBkZXZpY2VzLg0KDQpHb2luZyBkb3duIHRoaXMgcGF0aCB3aXRoIG9uZSBjb21w
YXRpYmxlIHNob3VsZCByZXNldC1lbGJhc3IuYyBqdXN0IGJlDQpkZWxldGVkIGFuZCBmb2xkIGl0
IGludG8gdGhlIHBhcmVudCBkcml2ZXIgcGVuc2FuZG8tZWxiYXNyLmM/IFRoZW4gSQ0Kd29uZGVy
IGlmIGl0IGV2ZW4gYmVsb25ncyBpbiBkcml2ZXJzL21mZCBhbmQgc2hvdWxkIGp1c3QgYmUgbW9k
aWZpZWQNCmFuZCBwdXQgaW4gZHJpdmVycy9zcGkuDQoNClJlZ2FyZHMsDQpCcmFkDQo=
