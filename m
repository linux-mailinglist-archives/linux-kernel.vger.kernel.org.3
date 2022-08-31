Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF865A894E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiHaXBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiHaXBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:01:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEF3C8778;
        Wed, 31 Aug 2022 16:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIcDJmLJlef9glRa6LG/O84KWsBw1nSfAWxUsnapDjqU4I8CDAFphox5yibssO5P4enS847v6k771YCza1K8xhfnBh+IrwRRcAH1cEZVPFwYPAjKfcNYFgUzLkhNkkoWwLnN7ALZV2uNF/vJV4Iz7aJhHiOQZcuDysHthikY/p294mcq41OcPsA+p9eDtJHHtlnxeiUlRRm8nxShZ0lZ2bJOOFSf7OfPV4S8TpV7vGOcEbn1EX5rSWYUj4vH6oOO8uRstN4aXlnWZeeUIebwM9Txciy6D7xBmVdfhIdDtZJSJyi/f7K2OgbBi+V45b6jdDyogEkYeaBmg9d6YR471w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNIuNUxkRSoS6GBfFBpSBpc9cpY/UHjDk44jO2D3tKs=;
 b=IldgNyfR9VtbMs3R8H6FWwtrsCX7O+Db1gmeekHnMMbKu310u5rsVswlxHbUCZE1UTjeB3JGCSP9JmerIRX+9mP/9LXvbytReEvKtnccs51U8DSbLESxaId1pofFzlgbZSqoPXc1q68JfHo5dnPX3L/usXHBSpdXHmdCZBpRI/FZc05ne3WmVO5a3VHd76a772QEm+A8hFUOuhD963dmrnA/r/7AYD04n0tt5FqhUpk2of5uE6QtshWwp548EPTLjCNz9h/rHzYa0AmG8MVd24hgXXGBgKeTUmKhnfz4b2zp5Pt+eA6SCYYoYNlw3WgDp3iZNvMw5NKKoWr4XngyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNIuNUxkRSoS6GBfFBpSBpc9cpY/UHjDk44jO2D3tKs=;
 b=QSSJeAeT0wBZvl93p0wjNdHaVEaUpspSAVcxucf5Q/w5V8q4uHsE/iuZ0UbgH+mqhuyUddlb3Ku6frNkfVVh6VXon199ZLEXGUMWd2b7uUfSm8TfMtrynUZ3olT5aYecT1YYpX2yhIvLbromxeI9b5Hjzcq/A6mAc0WOslCPfNc=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 23:01:27 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 23:01:27 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Rob Herring <robh@kernel.org>, Brad Larson <brad@pensando.io>
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
Thread-Index: AQHYtM86gXzQRkjAqk6/46/G7K6NoK26/IIAgA61EQA=
Date:   Wed, 31 Aug 2022 23:01:27 +0000
Message-ID: <554f33b4-d235-5516-e8ff-5bf80d63a9b9@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-7-brad@pensando.io>
 <20220822142544.GA3770388-robh@kernel.org>
In-Reply-To: <20220822142544.GA3770388-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b928ba15-6e45-4e5a-4160-08da8ba4bc04
x-ms-traffictypediagnostic: MN2PR12MB4439:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VkqWLkdBnsXjJjAv0WpQ8CKyu6zrG8rYNY1+rkdwpTBVoZbAJ8hqAYczTY6Zh9lbJsIubIebJRzSI+L2fPJIphafxW46zGkDVSlmUcRGtxlD+ux00Pj5C0l2HQYNkRP3OzTeY9yH2dPaFrQ8jor5TIJVhEpYwBVkd3WuyrW7mMsknptCl1osy0uLIS8uZ4IsQ9P0plPKvHTOF2gKgys19MXtQD2F/V9KbOGMgOLs1ZG2kK5Hj9dhkaq251wARZg3H/i1NAeOPfTLMfvj/J3etO7p+086UzOi0WGt2KXWZpqDLxw6PuGtUPY42G99HU0PdokNm6NgdVYhhoL6XI7ttnwTWRDav7gbUgKPB88CpWbcqeOZDkGwD67O8h8KTqr8zA1MI/Ybu7OXE//QqrP3tD+OyYRUEee5t+ugGKOqst12wiMmuHRVetvmaHI2KIopPzSriI7nYWOhH+fmRN8N59muq31i+EqCtIqsfz9lbBs1Q4Bo04kGHGvG/u8nnYAxGQWpw2l5I7OXRmtHVfc9MWmfNZEYf41f+f84RWywTgHqFxYNXwbSpsAU2mlDVh2vU9lZKL0tkT9yo4+FFHG3/iRZua0J1DCj9ff2sJrHqvH/A8lYBZ9316Becvg2vVJbHc/QuPP1w9XRSqrfjI45rXJycuh3hz6aN+/6gGttp3oLkpR7MlQEMA31z9aBE9iLXjS+dVW571Y9tuZRsXpOaQZGetzpdmZlj7jhY3AbFSH1+HU1oTNrNPw0NoWpWniOMcN5XEG5+iaBWa9eHIjsRNONFi2mr06QWvOi+C5LrWx9IS7kSqWUZwsiPGkAInHLj+jAayHTXmdiHtE6FnqL5EIk/aDhDwwNJeOmCcTInr8T/mmVhR8j91kY6IIRD9MA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(31696002)(86362001)(41300700001)(8936002)(7416002)(5660300002)(26005)(186003)(53546011)(2616005)(6506007)(6512007)(66946007)(2906002)(83380400001)(316002)(71200400001)(38100700002)(54906003)(31686004)(8676002)(122000001)(36756003)(110136005)(38070700005)(66476007)(4326008)(45080400002)(478600001)(966005)(76116006)(66556008)(64756008)(66446008)(91956017)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTFXR0tpV3VwUHhnRDNMaW9yeEdKT1MzNmowUU1LVnVZTE1FdXN3djUyam53?=
 =?utf-8?B?S0p1K1ZjWmRLKytJSmpmNzZ1ZUgvdVRZZGJmVnh4RmY5bUhQMjJPMHExZUlM?=
 =?utf-8?B?MUQ4elI0dDNGVGk0Nnl4Q3JkaDZHRnc1YTJaVTBwTVVJMjVTdi9HR2F1SlM1?=
 =?utf-8?B?Z0swQzFZVmFIdzZDQWZXTXZIWDY3bUh3cW8vRlJnZEhqQjJZWmdnbVh2TXBC?=
 =?utf-8?B?ZXZBZXNmNnkybThWZDRnOEk5UkcvODRTQ3o3djRnUlN6cnFkc2xKS2tITWx2?=
 =?utf-8?B?ei9vWXRZVWE3N1F2dG9NZjNxVjhCZzluN0dEZDlqTUtLaVFIK0I0Vm9kVFh0?=
 =?utf-8?B?UDFsWnpoNUgwSXQ3VVpNcG8yMVlqYmVOT3ZxSDFES01OR090WGVuUDRDYlU1?=
 =?utf-8?B?NjNSWUJrRXc1RTdxM1ZNOGlGMEFPd3lDVDlTQU9zS0ZOelkyVUVLeXhuYzN1?=
 =?utf-8?B?MDY0b0J3VHVidWZ3QlRtM2h1K1VUdTUvb05qSko0R2NNQ2ZrWis5elVNSHZV?=
 =?utf-8?B?VUFmTHhZLzdxR0QvTVJ5b1RBQjlVZjRBdHJ4QTFKaXNVbDlOVmFtWHR3VW9y?=
 =?utf-8?B?N05icnVobnJKd2oxLzk2d3luYitTYWVWd2s4b1hYWUIvRG1DRUk5Q0l0dks1?=
 =?utf-8?B?UnI3b1JmR0xzSEpMeTdGUXZHU3luWk1OSjkwWjdMQ3lhZ3UxejNEYkRHSzNG?=
 =?utf-8?B?RStlVEdxTjlNQkRJK2xBL2ZURUx3WUxtWHZjZDhFSzhvWGtqZEZtN2pBc1Vk?=
 =?utf-8?B?bWxOU0V6Q2hWV2dxYTBEaWh2dGNSVHUyWGt2UDZHemFJVFlCakdEZ3ZFQXMv?=
 =?utf-8?B?WFhyL2xmcFFwbWJIdU9qZW4rcFBuQ0F2SGxGZjZTaktreUMvMG1pWkhNWDFo?=
 =?utf-8?B?dlU4Y3BsRW4wZm55WEJyRGkxWjA2ZmY3ekdKRWxDUVBucWl5a2FiUmVUdHZp?=
 =?utf-8?B?cmRaZW9rOXV2cFJ1elhzK0VlT054d2FMY1JVRFJrKzVUcHV2KzFwODFaR3Vi?=
 =?utf-8?B?T0V3UStnNDVJSXBrM2NCN1NCNm84VGJzdUhBVEF0dXk0NVdKQ3hPSTV6S1My?=
 =?utf-8?B?SEZ3YU9nN0tvczFMdThuKzJoYVdpQmNxMG93RmRuQ0JlejFmOFVTNWpNYi83?=
 =?utf-8?B?ayt3U0NVZjluaHFLZy9KbmZlWTM5QnVqa1FEeTFLK0pSMVlWNFg1RHFiMW5h?=
 =?utf-8?B?WnZDc3ltTlRIcWZpSVExdE5GTXZGdncrSTF2ckt2MVZNUG9hMTgxd1BIZmtT?=
 =?utf-8?B?Q3R3QXg5R1VCQUJudVZFUzVPelIxT3F3REU5bDBadGQ1TFJjdzNTb0ZmRzcv?=
 =?utf-8?B?V0NqYXJ1N1greGNQWm9QNm53S0JXT0drZm80VkhIb3FDOWtwOHpPaXdIWEIr?=
 =?utf-8?B?c2ZjazMrZXkrREh3WnNWMitYdnZ4SDZaUjlEdUhJRC9GWFVTMERwbFZMbElY?=
 =?utf-8?B?bVg0Q3NjVGxzbjJiYkduS0xKVDgvNW9BOXRsZmJLNGJPQlREZGFBTGdrK2hG?=
 =?utf-8?B?MXhEbFJpcE1qUWFFQ0VpVnVhRDBZdHlwVGROaVAvZHJkb05abHFCTkNrUFRx?=
 =?utf-8?B?V25TQUFYeC9WRUNVQmplM2VaYTA1UTRSRTVCV0IvUjFmTHpYSVdBai9CNkZT?=
 =?utf-8?B?WGZUSjhJSjlrcTNmd1BhN25TTitKQXIzUHJQSTN4Z0svMnhET0tnb0NXWmow?=
 =?utf-8?B?Yml5cjZadUh3NlYwRXlkQUJQandOakk4UXBTbGtqVzBTenhzOWpQQ1JYVkhm?=
 =?utf-8?B?bUxmdkxyOG9ycXVjZlI4bEVXK3lkQzVXUEh0L1dDNEJhVkhCSGVoNE1ERm9R?=
 =?utf-8?B?MkkwOXFCY0ZJUlBJOCtDTDV1OUlIYjdsRm9hK1NGYTFaM1ljajdqRDNRNm9l?=
 =?utf-8?B?WmRJUE5TRFkyaXVzTXZhbVp2di9STXIrbkZra2wwZlAwNWpKbTV2VldMRUZk?=
 =?utf-8?B?TkVadU13SkN4ZDE5aU9TZ3hEZkJzQitQYlR5c1FuMlJPak1YdDFGWVlIRDJ4?=
 =?utf-8?B?ajREWnJJdDAzWUJZS1BXQ21EMzBGQkxEV1J3R255S1lpRDdWa29UVWkxTE05?=
 =?utf-8?B?Uk9LQU5rTUZadytaZTYrU2sxanJGWGpsVXcxTHpCZVl5S2V1dFp6SFRQS244?=
 =?utf-8?Q?vUFY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA14840579484D4CB933976C48F4C687@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b928ba15-6e45-4e5a-4160-08da8ba4bc04
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 23:01:27.1326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCGTsnEBOqduY0B6y4+jwrFDjP8hOz+BQEHgdz1KvRptPDomKW0pp2+TmykEsEnx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMi8yMiA3OjI1IEFNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gU2F0LCBBdWcgMjAs
IDIwMjIgYXQgMTI6NTc6MzlQTSAtMDcwMCwgQnJhZCBMYXJzb24gd3JvdGU6DQo+PiBGcm9tOiBC
cmFkIExhcnNvbiA8YmxhcnNvbkBhbWQuY29tPg0KPj4NCj4+IEFkZCBzdXBwb3J0IGZvciB0aGUg
QU1EIFBlbnNhbmRvIEVsYmEgU29DIFN5c3RlbSBSZXNvdXJjZSBjaGlwDQo+PiB1c2luZyB0aGUg
U1BJIGludGVyZmFjZS4gIFRoZSBFbGJhIFNSIGlzIGEgTXVsdGktZnVuY3Rpb24gRGV2aWNlDQo+
PiBzdXBwb3J0aW5nIGRldmljZSByZWdpc3RlciBhY2Nlc3MgdXNpbmcgQ1MwLCBzbWJ1cyBpbnRl
cmZhY2UgZm9yDQo+PiBGUlUgYW5kIGJvYXJkIHBlcmlwaGVyYWxzIHVzaW5nIENTMSwgZHVhbCBM
YXR0aWNlIEkyQyBtYXN0ZXJzIGZvcg0KPj4gdHJhbnNjZWl2ZXIgbWFuYWdlbWVudCB1c2luZyBD
UzIsIGFuZCBDUzMgZm9yIGZsYXNoIGFjY2Vzcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCcmFk
IExhcnNvbiA8YmxhcnNvbkBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9iaW5kaW5ncy9tZmQv
YW1kLHBlbnNhbmRvLWVsYmFzci55YW1sICAgICB8IDk3ICsrKysrKysrKysrKysrKysrKysNCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDk3IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYW1kLHBlbnNhbmRvLWVs
YmFzci55YW1sDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tZmQvYW1kLHBlbnNhbmRvLWVsYmFzci55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21mZC9hbWQscGVuc2FuZG8tZWxiYXNyLnlhbWwNCj4+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmRlZDM0N2MzMzUyYw0KPj4gLS0t
IC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21m
ZC9hbWQscGVuc2FuZG8tZWxiYXNyLnlhbWwNCj4+IEBAIC0wLDAgKzEsOTcgQEANCj4+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IG9yIEJTRC0yLUNsYXVzZSkNCj4+
ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGZGV2aWNldHJlZS5vcmclMkZz
Y2hlbWFzJTJGbWZkJTJGYW1kJTJDcGVuc2FuZG8tZWxiYXNyLnlhbWwlMjMmYW1wO2RhdGE9MDUl
N0MwMSU3Q0JyYWRsZXkuTGFyc29uJTQwYW1kLmNvbSU3Q2QwMmMxODNmOWEyOTQ5MjE4MGZiMDhk
YTg0NGEzNDU4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYz
Nzk2Nzc1MTU3MTM1ODE4NSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAw
JTdDJTdDJTdDJmFtcDtzZGF0YT1XSGtBNnRQYmFEYW5RdU1TYUFpV1VHM2ZCVGZEVmxXWE1kZWFP
NXQlMkYzT2slM0QmYW1wO3Jlc2VydmVkPTANCj4+ICskc2NoZW1hOiBodHRwczovL25hbTExLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmljZXRy
ZWUub3JnJTJGbWV0YS1zY2hlbWFzJTJGY29yZS55YW1sJTIzJmFtcDtkYXRhPTA1JTdDMDElN0NC
cmFkbGV5LkxhcnNvbiU0MGFtZC5jb20lN0NkMDJjMTgzZjlhMjk0OTIxODBmYjA4ZGE4NDRhMzQ1
OCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc5Njc3NTE1
NzEzNTgxODUlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pR
SWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3
QyZhbXA7c2RhdGE9RkRpZzMxbHVxZW80cE9aWGZ1T0FHaU9MaTBrVnFGVThFeG5CaTVnb3JsWSUz
RCZhbXA7cmVzZXJ2ZWQ9MA0KPj4gKw0KPj4gK3RpdGxlOiBBTUQgUGVuc2FuZG8gRWxiYSBTb0Mg
UmVzb3VyY2UgQ29udHJvbGxlciBiaW5kaW5ncw0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOiB8DQo+
PiArICBBTUQgUGVuc2FuZG8gRWxiYSBTb0MgUmVzb3VyY2UgQ29udHJvbGxlciBpcyBhIHNldCBv
Zg0KPj4gKyAgbWlzY2VsbGFuZW91cyBjb250cm9sL3N0YXR1cyByZWdpc3RlcnMgYWNjZXNzZWQg
b24gQ1MwLA0KPj4gKyAgYSBkZXNpZ253YXJlIGkyYyBtYXN0ZXIvc2xhdmUgb24gQ1MxLCBhIExh
dHRpY2UgcmQxMTczDQo+PiArICBkdWFsIGkyYyBtYXN0ZXIgb24gQ1MyLCBhbmQgZmxhc2ggb24g
Q1MzLiAgVGhlIC9kZXYgaW50ZXJmYWNlcw0KPj4gKyAgY3JlYXRlZCBhcmUgL2Rldi9wZW5zcjAu
PENTPi4gIEhhcmR3YXJlIHJlc2V0IG9mIHRoZSBlTU1DDQo+IC9kZXYgaXMgYSBMaW51eCB0aGlu
ZyBhbmQgbm90IHJlbGV2YW50IGZvciB0aGUgYmluZGluZ3MuDQo+DQoNClJlbW92ZWQgbWVudGlv
biBvZiB0aGUgZGV2IGludGVyZmFjZXMNCg0KDQo+PiArICBpcyBpbXBsZW1lbnRlZCBieSBhIHN1
Yi1kZXZpY2UgcmVzZXQtY29udHJvbGxlciB3aGljaCBhY2Nlc3Nlcw0KPj4gKyAgYSBDUzAgY29u
dHJvbCByZWdpc3Rlci4NCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gQnJhZCBMYXJz
b24gPGJsYXJzb25AYW1kLmNvbT4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0
aWJsZToNCj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAgLSBlbnVtOg0KPj4gKyAgICAgICAgICAt
IGFtZCxwZW5zYW5kby1lbGJhc3INCj4+ICsNCj4+ICsgIHNwaS1tYXgtZnJlcXVlbmN5Og0KPj4g
KyAgICBkZXNjcmlwdGlvbjogTWF4aW11bSBTUEkgZnJlcXVlbmN5IG9mIHRoZSBkZXZpY2UgaW4g
SHouDQo+IE5vIG5lZWQgZm9yIGdlbmVyaWMgZGVzY3JpcHRpb25zIG9mIGNvbW1vbiBwcm9wZXJ0
aWVzLg0KDQpDaGFuZ2VkIHRvICJzcGktbWF4LWZyZXF1ZW5jeTogdHJ1ZSIgYW5kIG1vdmVkIHRv
IGVuZCBvZiBwcm9wZXJ0aWVzLg0KDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1z
OiAxDQo+PiArDQo+PiArICAnI2FkZHJlc3MtY2VsbHMnOg0KPj4gKyAgICBjb25zdDogMQ0KPj4g
Kw0KPj4gKyAgJyNzaXplLWNlbGxzJzoNCj4+ICsgICAgY29uc3Q6IDANCj4+ICsNCj4+ICsgIGlu
dGVycnVwdHM6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+PiAr
ICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVnDQo+PiArICAtIHNwaS1tYXgtZnJlcXVlbmN5DQo+
PiArDQo+PiArcGF0dGVyblByb3BlcnRpZXM6DQo+PiArICAnXnJlc2V0LWNvbnRyb2xsZXJAW2Et
ZjAtOV0rJCc6DQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3Jlc2V0L2FtZCxwZW5zYW5kby1lbGJh
c3ItcmVzZXQueWFtbA0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4g
Kw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+PiArDQo+PiArICAgIHNwaSB7DQo+
PiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsgICAgICAgICNzaXplLWNlbGxz
ID0gPDA+Ow0KPj4gKyAgICAgICAgbnVtLWNzID0gPDQ+Ow0KPj4gKw0KPj4gKyAgICAgICAgc3lz
Yzogc3lzdGVtLWNvbnRyb2xsZXJAMCB7DQo+PiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJh
bWQscGVuc2FuZG8tZWxiYXNyIjsNCj4+ICsgICAgICAgICAgICByZWcgPSA8MD47DQo+PiArICAg
ICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiArICAgICAgICAgICAgI3NpemUtY2Vs
bHMgPSA8MD47DQo+PiArICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTIwMDAwMDA+
Ow0KPj4gKw0KPj4gKyAgICAgICAgICAgIHJzdGM6IHJlc2V0LWNvbnRyb2xsZXJAMCB7DQo+PiAr
ICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYW1kLHBlbnNhbmRvLWVsYmFzci1yZXNldCI7
DQo+PiArICAgICAgICAgICAgICAgIHJlZyA9IDwwPjsNCj4gV2hhdCBkb2VzIDAgcmVwcmVzZW50
IGhlcmU/IEEgcmVnaXN0ZXIgYWRkcmVzcyB3aXRoaW4gJ2VsYmFzcicgZGV2aWNlPw0KDQpSZW1v
dmVkLCBJIHJlY2FsbCBhIGNoZWNrIHRocmV3IGEgd2FybmluZyBvciBlcnJvciB3aXRob3V0IHJl
Zy4NCg0KPiBXaHkgZG8geW91IG5lZWQgYSBjaGlsZCBub2RlIGZvciB0aGlzPyBBcmUgdGhlcmUg
b3RoZXIgc3ViLWRldmljZXMgYW5kDQo+IHlvdXIgYmluZGluZyBpcyBpbmNvbXBsZXRlPyBKdXN0
IHB1dCAnI3Jlc2V0LWNlbGxzJyBpbiB0aGUgcGFyZW50Lg0KDQpXaXRob3V0IGEgcmVzZXQtY29u
dHJvbGxlciBub2RlIGFuZCBib290aW5nIHRoZSBmdW5jdGlvbiANCl9fb2ZfcmVzZXRfY29udHJv
bF9nZXQoLi4uKSBmYWlscyB0byBmaW5kIGEgbWF0Y2ggaW4gdGhlIGxpc3QgaGVyZQ0KDQogwqDC
oMKgwqDCoMKgwqAgbGlzdF9mb3JfZWFjaF9lbnRyeShyLCAmcmVzZXRfY29udHJvbGxlcl9saXN0
LCBsaXN0KSB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhcmdzLm5wID09
IHItPm9mX25vZGUpIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJjZGV2ID0gcjsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGJyZWFrOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQogwqDC
oMKgwqDCoMKgwqAgfQ0KDQp3aGVyZSBpbiBzZGhjaV9jZG5zX3Byb2JlKC4uLikgdGhpcyBsb29r
dXAgZmFpbHMNCg0KIMKgwqDCoCDCoMKgwqAgcHJpdi0+cnN0X2h3ID0gZGV2bV9yZXNldF9jb250
cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUoZGV2LCANCiJodyIpOw0KDQp3aGljaCByZXN1bHRz
IGluIGEgbm9uLWZ1bmN0aW9uaW5nIG1tYyBoYXJkd2FyZSByZXNldC4NCg0KDQo+PiArICAgICAg
ICAgICAgICAgICNyZXNldC1jZWxscyA9IDwxPjsNCj4+ICsgICAgICAgICAgICB9Ow0KPj4gKyAg
ICAgICAgfTsNCj4+ICsNCj4+ICsgICAgICAgIGkyYzE6IGkyY0AxIHsNCj4+ICsgICAgICAgICAg
ICBjb21wYXRpYmxlID0gImFtZCxwZW5zYW5kby1lbGJhc3IiOw0KPiBZb3UgY2FuJ3QgcmV1c2Ug
dGhlIHNhbWUgY29tcGF0aWJsZSB0byByZXByZXNlbnQgZGlmZmVyZW50IHRoaW5ncy4NCg0KDQpD
aGFuZ2VkIHRvIHN5c3RlbS1jb250cm9sbGVyQDEgYW5kIGFkanVzdGVkIGRlc2NyaXB0aW9uIGFi
b3ZlDQoNCg0KPj4gKyAgICAgICAgICAgIHJlZyA9IDwxPjsNCj4+ICsgICAgICAgICAgICBzcGkt
bWF4LWZyZXF1ZW5jeSA9IDwxMjAwMDAwMD47DQo+PiArICAgICAgICB9Ow0KPj4gKw0KPj4gKyAg
ICAgICAgaTJjMjogaTJjQDIgew0KPj4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYW1kLHBl
bnNhbmRvLWVsYmFzciI7DQo+IEFzIHRoaXMgaXMgYSBMYXR0aWNlIFJEMTE3MywgSSB3b3VsZCBl
eHBlY3QgYSBjb21wYXRpYmxlIGJhc2VkIG9uIHRoYXQuDQo+DQoNClNhbWUgYXMgYWJvdmUsIGNo
YW5nZWQgdGhpcyB0byBzeXN0ZW0tY29udHJvbGxlckAyDQoNCg0KPj4gKyAgICAgICAgICAgIHJl
ZyA9IDwyPjsNCj4+ICsgICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDwxMjAwMDAwMD47
DQo+PiArICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmcG9ydGE+Ow0KPj4gKyAgICAg
ICAgICAgIGludGVycnVwdHMgPSA8MCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPj4gKyAgICAgICAg
fTsNCj4+ICsNCj4+ICsgICAgICAgIGZsYXNoQDMgew0KPj4gKyAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAiYW1kLHBlbnNhbmRvLWVsYmFzciI7DQo+IElzbid0IHRoaXMgYSBmbGFzaCBkZXZpY2U/
DQoNCg0KQSB1c2Vyc3BhY2UgdXRpbGl0eSB1bmRlcnN0YW5kcyBob3cgdG8gcHJvZ3JhbSB0aGlz
IGludGVybmFsIGZsYXNoLsKgIA0KQ2hhbmdlZCB0byBzeXN0ZW0tY29udHJvbGxlckAzDQoNClJl
Z2FyZHMsDQpCcmFkDQo=
