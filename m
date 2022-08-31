Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044CF5A85DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiHaSjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiHaSiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:38:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071E42F3B3;
        Wed, 31 Aug 2022 11:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd6OaBlNQMURQU4tkYqnIJahSCJ05VCoeC57flHAdVcYKzfItAV7jegqL6S0/+nWhlHS5dtyjuOepmY279PFkvjYE/+MDJP2FOmvRs8EAlt8sBGsmImd1AMVhBpWvdUf2vA98fv0r6ekCuT1RCXhjs91L3I3OKJMimdLja1Osgx+umA1fCPURZDkO1mV50cU3X62uUfx85H9/jLzeqXIPT5Eck5FPgvTA4d+jsrgkO6cvMaTmT8dJtPzU/qLj57qPKXayjq/MiW/CtMYP1tL3P5xnEsaDa46hwgnc8hIsL3LRo/TKiFJSuZ3xgLVTe3yQM0kWgkdywLIZDXj7IAwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c2ySm0uITnwid5+ddAmUy8s8GMFhw3IRLUD0yIt+Hs=;
 b=d9HY8l1Cb7BQfWFmwM146w8bzZHL2cpRmmhFK1YurVl/XM7v9X9R2gD2/ltj+u6m7rpmpU8Ympx3+EuG62NZT9NyaJ9NkEI26PgyOfH5Q/qnHQ5mmznqKaiN1hI5DJjgI0QLBVlPxmnw2rCfwWoOApJvENH4mnXI8PnynGkpkogUeuFFSXI3VHdgZhiO1fcj426QMdLgDIXcPvIkzHj8rnKKHEfD4jw6YiND+kL0l7NAdGg+Lka6BixBTvDAvRO6VvF3vUvXdokcWKp8ze4Agi98ZghgFKqMA6W0zkDijWMcbm146pOVZW9Q968lsTWp7+iNlTrRkBofWJ3rZqhAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c2ySm0uITnwid5+ddAmUy8s8GMFhw3IRLUD0yIt+Hs=;
 b=e1IK3iBO6VPWOVaKsgDFqBHJ7+Fxb7VdEpXDWHfHPB3gxIQN6Ii4b3I1Mb/AakItWZVt3dymcvwFJ0WSHVa83ROZA4uWgVTFciGdk/MGfjqTqcpRultMb/X+2slRjna8UfTqK0aqKJWZ17oxis7j8BagOsZNVYKgbLkImosRklw=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 18:35:31 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 18:35:31 +0000
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
Subject: Re: [PATCH v6 05/17] dt-bindings: mfd: syscon: Add
 amd,pensando-elba-syscon compatible
Thread-Topic: [PATCH v6 05/17] dt-bindings: mfd: syscon: Add
 amd,pensando-elba-syscon compatible
Thread-Index: AQHYtM84WsL7nKlbD0u639n+kFAlAK27PxCAgA4oNgA=
Date:   Wed, 31 Aug 2022 18:35:30 +0000
Message-ID: <56ff9f7e-d5f0-91fc-8cb2-971305cad059@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-6-brad@pensando.io>
 <565960af-2c16-b066-c846-78fcce73c070@linaro.org>
In-Reply-To: <565960af-2c16-b066-c846-78fcce73c070@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98cf2989-1833-4c5a-a34c-08da8b7f9560
x-ms-traffictypediagnostic: SJ0PR12MB5407:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: InXaOerxrVY3LpejhP3jjMkTFUn9OUK8MK+ZH1vS0keL637FaGSZfvYGUsnqfRc6rzQ9f0cTr/mNAALD5VJFOC+d2Mdek4yLzsl8JwfqcIwR0IZxXfbIsX5qRMnggdeiQ2z2dmY40SqPhZA7VS2mKSHMtxkS+Y4JNcsAO+40m4duXafxTEddw7RKTrZ1Cg+sADjCVookBAQCvJonaRmwAkTgYVNPuS2xTzgIt9BSfWnVIOLML7v2q+OR3jwPN698rSatQ3W5qbWPFiaEC+prb+J+6omQ8ITyAnuPWG4O7RwYjXDn27Tw1oOEyT8yfWIWRl9vj4VtDPEhJt8uFj3/0KEcUNbKPie1v3ixz8AJF4CKzNaqHJLG1Etxk9NX//jDBFtM3oR0ImSwz1BHpiqu9+jh6JBdE5jT/h9MwvsuTSmCXPoyUxa6FkyrBb2spYlVuXbkqGCOcxC2Y7ULqIrtJVdydfk5kEHBvfnv93lGqwu7aH/KGd5wjPnpxLfdb0Qa/Axv0ckxHFcecj1hYqQUX7pElqkggXHQwWOukWYORGYAyukVSYKaYQM2BStMzGj54JLCJX5sOfteorlTemg9hg1dXtaxgoQQk6/QbbzVrt5yoN5b3w/udwQVOLXivMhhCmSvHm4Ty37b4gEoJYmJJrOFlyIeTzahmeGRwSfN4uDT4jWzrqMakDnCMwlqDymvKJTHp3Z6a6gvbfpgZmp445D13mbx5A5cJLDxiaSMsrjdVxxiC9vZUyPSBtOaTojKlAU0rRwNIqIfNrSfU3Z82A8mMwsLWWNuGJRM598djgRMEVLUce8E+kgxiYCxBsq1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(36756003)(26005)(31696002)(86362001)(38070700005)(41300700001)(186003)(2616005)(83380400001)(6506007)(6512007)(53546011)(71200400001)(110136005)(54906003)(966005)(316002)(4326008)(5660300002)(66556008)(66946007)(66476007)(8676002)(66446008)(6486002)(45080400002)(91956017)(76116006)(478600001)(64756008)(38100700002)(7416002)(31686004)(122000001)(2906002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aENrQ2hVaUk2SDZTanQ1dkZxUzl5Rmp1LzNNVktBM1dOYlZtbndOREN4eUQv?=
 =?utf-8?B?bXBkQ2FHTUYvZ1RxS1BLUWtiTGZuVEM1QWFXSXlla21CdmVVK254UDB2TXZ4?=
 =?utf-8?B?V2JHY3RITW5KTVVoMDZZNDB0SnQ2K04xbnJrNjQzRHBzOHBjZ3RHU3ovL1M3?=
 =?utf-8?B?M3VFRUNSdlF5T0pBVEVIejJhTXpqVC9wSWFKOGZzNTI5Y0puUU5LNTNpNFVZ?=
 =?utf-8?B?NTRZTThNQUlWaHRwNnlNdzlSSWRtOEttS1B2djVHZStCbjdHN0Qrd0NEVCs5?=
 =?utf-8?B?cE42U0ZBc1ZhTVlyN2gyK2NRbExVZS9lQVNuKzl3emNxVjg4WEF4eFVYK2Z2?=
 =?utf-8?B?UVJ5cU5nYm8reFY1M0xIRW1BdmhNR1R2VHplQ0FibDZzbjBxOE96UUZsa3pl?=
 =?utf-8?B?T3JDd2pNdmFiaHMrNDBXTTdBRjNZaGFsMUlVTjUrZXo2UHBROXRQVXZIaFdk?=
 =?utf-8?B?TlN3dVdpekVxQ3hvT053VkExOGZTdXZ6WnloVkYwMVg5UWpWUTBhbnBZUzNO?=
 =?utf-8?B?VTJDMUdzSWFzZTRNQmV1RlN2NGVrckFNaXBQTk1GOUlyVlJvQ2JSRXBHU1Fy?=
 =?utf-8?B?OVRBK3BhOGM5UEhtUGdqTVRoMzNhYnRUaWg4TEt5WWtRem15b1Q0KytNWkpp?=
 =?utf-8?B?R1AybEZLb05RNDIweXpmT081TkdRcnZ1MjZ0eHRKVWRZL0xKY1lyUG9TVTNO?=
 =?utf-8?B?S2JXYjFCZ25BRkFLbHBYMVFiOW9IY3g3UnZvMGhDemdZaGRUcVV5TytWZjFh?=
 =?utf-8?B?RjRCaHpQeGdIUFA2c29KZlNHdzJjTW50WFZLVVVxVUtCWXFEK0JqWHZwaFdY?=
 =?utf-8?B?S1poSXdsS2RLZDc2VktBaDFLbHhUVDEwUU9wbmNTeml0RVMvWUQzcXppb1J1?=
 =?utf-8?B?NHFXREZXdWkzWmdHSEpLWEdEVTFqMzZTZndhMWh5alZUWmZkbjdDV25tZmVl?=
 =?utf-8?B?VytoL2Fzc1FXV1MyV1dBcG1nVWVXNE44bTdna0pETGRhMnM0VTU3T0E1RkFK?=
 =?utf-8?B?VDhVWWhtR3I1WFVKRDRDMjNYZ2NBdTRxTFltZmRVd2d3Uzk2Smo2em0zNTNO?=
 =?utf-8?B?OGl1ME8yN0R0Q1BpN2k4alR6MklsZVQ0ZWwvUllhdk9CcmhUclhUamdnd21O?=
 =?utf-8?B?QTN4UE12Sm5mY2xCWm9YMEM0SVVRNTZXcGZWV0hpU2N4cGFwVWhhdVQ5dE9V?=
 =?utf-8?B?V21GQlp1NWtSUGIzclRHZ1kzcjFwVExJUm84cXdTQXRLaTAyTS93N1ZaOEJH?=
 =?utf-8?B?SVBXTVZaZCtPOUhMRC9XTHk3VjdZN01kOUw3YWhRYTFRQ0gvT2RiQXZ6aGcx?=
 =?utf-8?B?M2VCOVFkL0gxWkhUSWY5ZWltVm1raGU3bE02MlhXbU9lK0tPRzlobXdwY2Zp?=
 =?utf-8?B?WHoxb3V4dXZUakZVTnZ6R21pVzFXWW1tRVZmT0JwdjFTRzBEUWJyeGJONjVD?=
 =?utf-8?B?cWFaSHBvTHpIWFZnYVpDSk8xc3lPVGpYZDVtU0dVUm1Sd0JtUWk1dnJKU2Mr?=
 =?utf-8?B?b2JrWC94eEZnSmhqVmJUNVp5VXZtV2ttejZHamE1L3VCVHp2YjN0UXl1bktw?=
 =?utf-8?B?aUxCRkswZHJrQUdSMjU0cVZWbytqekYxa2xteHJrRXhmTDJsVEc0bFFLTWwv?=
 =?utf-8?B?RytFcjhHaVFiSnhlWDNhZVV3NVBPYUlpT0FoUGExNDgxaENsWW5GTkwxaDgz?=
 =?utf-8?B?Tm9kaExzWkQ0c0FoWWhDbXlaNTU3RmlrTjhkdmJ2Y3JOY21PdDVCdWxsMjVP?=
 =?utf-8?B?YnBCcy90ckxtOHJRTlZtZWRMQitnVnhvUDk0Z25PZGx4Ky9jNkxiY3pGd3pW?=
 =?utf-8?B?MG5JVWxkSlM1Wlc4TzV1K3g4WmF3a0ZlRjh1dDI2MDZQaVZ0ZnI3Y29YVm00?=
 =?utf-8?B?VEtDSDcxR0RwVTl2bnM4VXZxOHJoTjNaM0IwY0RpZjNYV0twUUNFT1ZQbHBE?=
 =?utf-8?B?L2NHQ0tPWFZxbU04UEhkcXBzSmFrYjhxZ1NpeWFudmxOalRyZ1pMWmdETHhC?=
 =?utf-8?B?MStzdEFacS9SeG1ZVVRCMjFxV2ZYMG5lTUZxSU94OHFGRHkrdXpHQWd5cUtw?=
 =?utf-8?B?L1UvUG1QcDlsQVV3dEZVMjZXbHVEQTlzMTRkNTEwSmpqaGdMcmg1dkFEZ2NY?=
 =?utf-8?Q?DfUQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40DCAEEC3EA4EA4493096B9DA404DC53@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cf2989-1833-4c5a-a34c-08da8b7f9560
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 18:35:30.9123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JFpjO940Q+b2AfaUy89mPlZ0XozXTAkilbOQOyBlNcIlufzqn1F2Ap3mD6r6NfP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMi8yMiAxMToyMyBBTSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gW0NBVVRJ
T046IEV4dGVybmFsIEVtYWlsXQ0KPg0KPiBPbiAyMC8wOC8yMDIyIDIyOjU3LCBCcmFkIExhcnNv
biB3cm90ZToNCj4+IEZyb206IEJyYWQgTGFyc29uIDxibGFyc29uQGFtZC5jb20+DQo+Pg0KPj4g
QWRkIHRoZSBBTUQgUGVuc2FuZG8gRWxiYSBTb0Mgc3lzdGVtIHJlZ2lzdGVycyBjb21wYXRpYmxl
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEJyYWQgTGFyc29uIDxibGFyc29uQGFtZC5jb20+DQo+
IFBsZWFzZSBhZGQgQWNrZWQtYnkvUmV2aWV3ZWQtYnkgdGFncyB3aGVuIHBvc3RpbmcgbmV3IHZl
cnNpb25zLiBIb3dldmVyLA0KPiB0aGVyZSdzIG5vIG5lZWQgdG8gcmVwb3N0IHBhdGNoZXMgKm9u
bHkqIHRvIGFkZCB0aGUgdGFncy4gVGhlIHVwc3RyZWFtDQo+IG1haW50YWluZXIgd2lsbCBkbyB0
aGF0IGZvciBhY2tzIHJlY2VpdmVkIG9uIHRoZSB2ZXJzaW9uIHRoZXkgYXBwbHkuDQo+DQo+IGh0
dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmVsaXhpci5ib290bGluLmNvbSUyRmxpbnV4JTJGdjUuMTclMkZzb3VyY2UlMkZEb2N1
bWVudGF0aW9uJTJGcHJvY2VzcyUyRnN1Ym1pdHRpbmctcGF0Y2hlcy5yc3QlMjNMNTQwJmFtcDtk
YXRhPTA1JTdDMDElN0NCcmFkbGV5LkxhcnNvbiU0MGFtZC5jb20lN0M0M2JhZDkzZjViMzA0MThj
ZDA4OTA4ZGE4NDZiN2M4YiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3
QzAlN0M2Mzc5Njc4OTQ0NjEwMDMwNTclN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lN
QzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNE
JTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9UUduTTlwYnQ2JTJCSldlTGpHTjUyZ3J4M0olMkZV
Rmx3UkpRTUw3VWJKYWdGZFklM0QmYW1wO3Jlc2VydmVkPTANCj4NCj4gSWYgYSB0YWcgd2FzIG5v
dCBhZGRlZCBvbiBwdXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5IGFuZCB3aGF0IGNoYW5nZWQuDQpX
aWxsIGRvIGFuZCB0aGFua3MgZm9yIHRoZSByZW1pbmRlci4NCg0KUmVnYXJkcywNCkJyYWQNCg==
