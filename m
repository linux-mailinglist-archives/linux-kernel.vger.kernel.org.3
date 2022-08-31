Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67C55A893B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiHaWta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiHaWt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:49:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5940FD91E8;
        Wed, 31 Aug 2022 15:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvj8gISSs2MHwgP2hgXDlmyKHWgSyJ70tP7iIWsg+SOcn41xDb43df0G1XtPq5zVvYaUbZ1U2ea2qavcsresNaCtiyYJ/GeZabG52Qi2uOlFHO0b7pkgpyygQVkSjv2DdKUZbit66eWEXWXtbAO5olsnAmdRXdK9s6aRUpL613nqFtiSj4Gb4BVmaA+sjmAVNuk8zuHZ+iEtSu9t7Ytq3gxztL2mD6q3+m2AZMcOlWLwVcCEdsNBLTVw24TgjEfACHBUqUsc8jBemG1wQCKwLTQ0hBertaHqMmG8V7zMr0gQbaSQghpb1/bJtOw6ZekOeYDJ65TK3eDTKNvCxE/jKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCAr8wFiMettrCOJNP0qKqQ/c4Ie47cVhIP2ibn30bk=;
 b=HWviZi1aytqBb0zF/1R9c6Sg1hxwf66b2HGWKtE6kCs4DK1wrivt8X1G/rN4t/02YqGdh9w/SZPQQcs8m4dI2cC2w2s5ckolN/pnJOt1BEWovp5mt1s1Uh6yHuaXPfRaTa4iRSPlyVVsaQvCUmqCeIBxW5wfyt6Ptk7h4+QkU7rQ3vMFow0jPEsdY3NEoXklJ7skuCRzOYpOa958CQRKQaJgDoultQ2JDF6uW46mvFcZMt7rroLuZApkEd7Xt57PufOtpbXBwEtZeMo+F8y9huqzh6xLAR7t27ea06bFD0CpXx1Btmpp+AkUHaEvg7nZzI3xMw7+yp+QoZT2dxyhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCAr8wFiMettrCOJNP0qKqQ/c4Ie47cVhIP2ibn30bk=;
 b=KpVQ+mMRxAilCdhcJqERRoksU3FoMXWqAt+FZkbXm6VJQMtKovjiZmpo9l582HrR2NFN9v3skzpkHgeoU7kwX6zz8loD/aWrPHSqX0EdWks2HBgOi7kC7augQ2QsXLkAgdUAUfSuEf/bXUQ/ine6Hn0n99dyedtIz6lw9jAqeu8=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 22:49:20 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 22:49:20 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: Re: [PATCH v6 17/17] mmc: sdhci-cadence: Support mmc hardware reset
Thread-Topic: [PATCH v6 17/17] mmc: sdhci-cadence: Support mmc hardware reset
Thread-Index: AQHYtM9MGCmT8rfLtEuz+oFybZ1VTK26gOkAgA8tR4A=
Date:   Wed, 31 Aug 2022 22:49:19 +0000
Message-ID: <dcdc51bb-fc8d-04e5-2edb-903f7a531cb8@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-18-brad@pensando.io>
 <e4f16bcd11db29869c08f920d2bd9480fcdc076d.camel@pengutronix.de>
In-Reply-To: <e4f16bcd11db29869c08f920d2bd9480fcdc076d.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10227afe-b840-4459-40b8-08da8ba30a94
x-ms-traffictypediagnostic: PH7PR12MB6658:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /8TerNs+Q+nIx1S5WEuJM0eHorRlxDwqXuKmKNU+1YHmftLPOZAl6/6oxGshqHFaTSoZ2K/TlUcPZ89HadqIiab4xrTr2MXiS3f97K5b/TMIRLRBEzVnUwmO2ifNouzGP6KWErvTwFCx9eXbpG7fb7Fm7DzQcL3xrWS4+Yz1scNTIHkKT8TEqIjZAkSZNrxF28vgcOgUncemQZILO0JLOcDv1vEWh0C5VToRes6NCTXA2MxOcgkZDhnHFEhIeGTDgqAy15adu5Hmh2O6xMoLVxZPZsQBkpSQVTpIv4E8KI6J4cwjKSHdD67X1GjYSfHGWWMtUUjk3PTuMOSMiLyB46yzmIJq8g+u2JtM4qQlM4S+yu6aNS81a2Y0eE/WpDUbMvkeeKDSrKmwlOzD3k22uypSmq0B1dq/vrzwjudrbC3pndVrMLHjxakLT74JK1b+xMblFVcMW/+Q0SX2gF2Hi5qvujp3wiNJWuwxgZXbSfsD0SZiJkrDedMW4+qIay+ycGV//ZCLKmMxOXUEUhfCYZ70IfOuQq+pfulubVmEf1M+T8IcAMgMVnbVQpTQ72BJj9FVzUVSOBkNB1Mgt6kMUJZLtlsIr+6ZpR/nVJaBkL2FUQ2rrbQv2W2Je39CEFwyPwGtut74tgJy+fENH3NheK4g2rG+UrfbfgwNupSOLcaqwrj3qUFp3pzP6xllJWTPW3z5HJRUG5Y8r0EEZekg5C4AzRsI08vKwfw8f1X3l823G79iH7EpJ7KhraaA5ypRpJWvRirVUeEPk4vU8SjPJ2c4qH2W0XBUz3DbVoPdSuM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(6486002)(53546011)(5660300002)(7416002)(8936002)(6512007)(6506007)(26005)(41300700001)(478600001)(36756003)(31686004)(71200400001)(2906002)(86362001)(4326008)(110136005)(8676002)(31696002)(54906003)(186003)(38070700005)(66476007)(66946007)(66556008)(76116006)(91956017)(64756008)(38100700002)(2616005)(316002)(66446008)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmYxTjgrUjFIL3U2dDRGT3RBNEFrdVo1U2d6Qzk3L3NJNUlCMURMRkE3R2xt?=
 =?utf-8?B?ZEpHdjVvaVgydWV6eDlkdU11OTVEZWI5KzMxQno4MTFKSGx6RXR1WW1RbjYr?=
 =?utf-8?B?bGpacDlZTUhTNzFiWU9GeDdMZUJuYlhhNHFhWEtuOU1QZytlcTB0eVB3WUtL?=
 =?utf-8?B?SnBTQ0tXLzBDZ1VIbWFMa0ZIWlJ4Vjk2S1Y4b1graDE0eUhuT2FEaWE5a3VX?=
 =?utf-8?B?cTVqSjN1MExkd09CVlNPSlVONFJ5anV0SlRlaWFmZUpha0hTa2UvUXZUY3h0?=
 =?utf-8?B?c1VqR01nT2dhdU1jeDBWNVFZeWJhZW91TFAwZVc1V0RzcWlKbERRblNlNFVj?=
 =?utf-8?B?U1E0dHZ6Ukc2RXVYcWM0N2xxU0ttTjZIemI3RzlQWG83TDFyTWpDa0RaMHNV?=
 =?utf-8?B?b2dERUM3NjVINTVEOTBaSFVoVWJXSnVVTFp6RmgrR1lNM1hMRUdqMmdLRDZr?=
 =?utf-8?B?dTdCcE1EUXhrWWdVZTdxSHhQSjdZVGpoRTNFbjRjVklWZGlaU0dNV3lxUUl1?=
 =?utf-8?B?NzlROE9TdUVGQ0Q2MGE2NGJvdVJCSXN0MDJpdkxBWTUyT0RWZGtGNzFZSlh1?=
 =?utf-8?B?SWZxOGY1M1hzdFFIUksrUytQaGdqL05FWmUvS04xZ1JqMUYrNGNtZVVaWXdO?=
 =?utf-8?B?U3dmVHRLM2h6VmRzMHFvS0ZYOEVmTnJJZ3RZdlBBMVdFVEtXQkNBR1lEVnl2?=
 =?utf-8?B?eHZsL2E5R0hHc0tIQWhOZFVxUlZTcFY2b0VEQm9keU1CUG9sVVpqK1Q2azMv?=
 =?utf-8?B?dng2V0RBOVdDb0tKeU5VdFJYZERnT0ZMdUQ0TWVBL3ZHNi9palU1YnhzVUFC?=
 =?utf-8?B?ME1RQ2VocG1yb2luZkVkM3B5YXRVRlFCVTZMOW4vdlV1eHc1L3BNVHR6UlBy?=
 =?utf-8?B?dUpCbDhvaXhLdnYycEdrS05HbE12L3RwNWFPTUJKenR0ZlAxT2RhQVRvc1Nq?=
 =?utf-8?B?cjFyamJWaUpSdWFVYUJCVm5DdE1SbnUyS0VLNW15bnJIL3NaR1VVN01TT2dL?=
 =?utf-8?B?RlBidGJocW9ncWJVc2V3aDFKL2IzelhrRVFweG5sblk4aHo4bFp4cUNDajJl?=
 =?utf-8?B?YkpQL3E0UzBwOFU2SERwb0JXSGhyZzVYWGNQNzFGa3BJanN6S3lXN3g1U2NU?=
 =?utf-8?B?WXdTOWptQ3pWdEZ3a2RudGxOWXE2Q29EZ0tuNnBXRkl0QXI4YW50amI5MWM5?=
 =?utf-8?B?bnQweE9POVQyL285VHp5eHQvVGhMcm90SGkzMXJOc2dQa3V2ZWRnNUQwTmV6?=
 =?utf-8?B?R29MYUVSK2NGQi84VEo4dHFUQlE1QVdLbWVhTU5mVms2TTl5TFNWb2pOQStN?=
 =?utf-8?B?SytuSG44SFFhM0lxZ2RhbWZ0R3FsaUowWmFRNnBtOWFXZGM4QlpHYXpwSk9E?=
 =?utf-8?B?bUt6alF1dmxQUk14MzNqcmVFRlVoeU1LRzUwcEI3d2I5YkRqNlFydGZ1U1dt?=
 =?utf-8?B?UWp6dFltNmNFSVhZODZHOFA4Z0FHeTJRR01hVk14RDl4NGtab2JxVjdXYW5Q?=
 =?utf-8?B?NDNoSSsyRGlaYkdiM1ZHSkVZWllwalVZeC9mWHZ1M1BEWU5MTWpITE9SOExL?=
 =?utf-8?B?U1ZWaHZQdXExTjRRWTZBQ3BESHl5bSt6aFBTZ1YzeEYzL2JyNVljTkVjNFdm?=
 =?utf-8?B?T1B1WnRKeDNDVjVxaVF4NGxnMnBoMUxBcVZhaDN0TkpTZEhnTWdGaGZRY3gr?=
 =?utf-8?B?ai9rVi93K1ZBemxBMEVGQTRPTHBIeEl1RndQSzFDN2RBOWFyb3BqS21zNkMy?=
 =?utf-8?B?eWkwQllFS1Z1Z3NoSlBlZTRDWWMxM2dnNDk2MzBqcUg0MXRpZ25GRnJwYkov?=
 =?utf-8?B?Q3lQc3ZTVTJVWldpSy9TWWlVUVNsOEI5ODUyWWl0N0hSbmJpRE9xaVhkUnpO?=
 =?utf-8?B?K1VuQ29KYzRvM2JRNFlKNlJnVm9iSGtBQWxyZGIxK1ZGTE9vZ1d4STlTSzlE?=
 =?utf-8?B?TEh4a3I1cTdxZUo2UW1vQmhVcXNWNVlFdFR2eUFFVmlGcS9GeEdFcFBEbHNW?=
 =?utf-8?B?VWJSSmdETXJYV0lTaEVxWU9uRDU4d1NHWERNbm1BTk5pbnZBRW0rT0UrcWFj?=
 =?utf-8?B?OFB4bzJNWnk2UFc4M3hPazIzQ0Y1ZDFxSjc4WmhnbnZ0NmVoVEt1OWw2ejRv?=
 =?utf-8?Q?Hn2Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1859D4C36794E14A88CE1D67CB4883A4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10227afe-b840-4459-40b8-08da8ba30a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 22:49:19.9295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgmuCKzKIKMM20qwllr3wQIMt+ORRVFggtdOXNYtqMTvKI12e1ZngqnLYTZnQLcL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMi8yMiAxMjowMyBBTSwgUGhpbGlwcCBaYWJlbCB3cm90ZToNCj4gSGkgQnJhZCwNCj4N
Cj4gT24gU2EsIDIwMjItMDgtMjAgYXQgMTI6NTcgLTA3MDAsIEJyYWQgTGFyc29uIHdyb3RlOg0K
PiBbLi4uXQ0KPj4gK3N0YXRpYyB2b2lkIHNkaGNpX21tY19od19yZXNldChzdHJ1Y3QgbW1jX2hv
c3QgKm1tYykNCj4+ICt7DQo+PiArICAgICBzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IG1tY19w
cml2KG1tYyk7DQo+PiArICAgICBzdHJ1Y3Qgc2RoY2lfY2Ruc19wcml2ICpwcml2ID0gc2RoY2lf
Y2Ruc19wcml2KGhvc3QpOw0KPj4gKw0KPj4gKyAgICAgZGV2X2luZm8obW1jX2Rldihob3N0LT5t
bWMpLCAiZW1tYyBoYXJkd2FyZSByZXNldFxuIik7DQo+PiArDQo+PiArICAgICByZXNldF9jb250
cm9sX2Fzc2VydChwcml2LT5yc3RfaHcpOw0KPj4gKyAgICAgLyogRm9yIGVNTUMsIG1pbmltdW0g
aXMgMXVzIGJ1dCBnaXZlIGl0IDl1cyBmb3IgZ29vZCBtZWFzdXJlICovDQo+PiArICAgICB1ZGVs
YXkoOSk7DQo+IEF0IGEgZ2xhbmNlLCB0aGlzIHNlZW1zIGV4Y2Vzc2l2ZS4gSXMgdGhlcmUgYSBy
ZWFzb24gOSB1cyBpcyBiZXR0ZXINCj4gdGhhbiwgc2F5LCAyIG9yIDM/DQoNClllcywgM3ggdGhl
IG1pbmltdW0gc2hvdWxkIGJlIGZpbmUuIENoYW5nZWQgdG8gMyB1c2VjLg0KDQoNCj4gWy4uLl0N
Cj4+IEBAIC01MjAsNiArNTM4LDE3IEBAIHN0YXRpYyBpbnQgc2RoY2lfY2Ruc19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICAgICAgIGlmIChyZXQpDQo+PiAgICAgICAg
ICAgICAgICBnb3RvIGZyZWU7DQo+Pg0KPj4NCj4+DQo+Pg0KPj4gKyAgICAgaWYgKGhvc3QtPm1t
Yy0+Y2FwcyAmIE1NQ19DQVBfSFdfUkVTRVQpIHsNCj4+ICsgICAgICAgICAgICAgcHJpdi0+cnN0
X2h3ID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUoZGV2LCAiaHci
KTsNCj4gVGhpcyBzaG91bGQgYmUgZGVzY3JpYmVkIGluIGNkbnMsc2RoY2kueWFtbCBmaXJzdC4N
Cg0KQWRkaW5nIHRoaXMgdG8gY2RucyxzZGhjaS55YW1sIGFuZCBydW5uaW5nIHRocm91Z2ggc2No
ZW1hIGNoZWNrZXIuDQoNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvY2RucyxzZGhjaS55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbW1jL2NkbnMsc2RoY2kueWFtbA0KQEAgLTExNCw2ICsxMTQsMTYgQEAgcHJvcGVydGllczoN
CiDCoMKgwqDCoCBtaW5pbXVtOiAwDQogwqDCoMKgwqAgbWF4aW11bTogMHg3Zg0KDQorwqAgcmVz
ZXQtbmFtZXM6DQorwqDCoMKgIGl0ZW1zOg0KK8KgwqDCoMKgwqAgLSBjb25zdDogaHcNCisNCivC
oCByZXNldHM6DQorwqDCoMKgIGRlc2NyaXB0aW9uOg0KK8KgwqDCoMKgwqAgb3B0aW9uYWwuIHBo
YW5kbGUgdG8gdGhlIHN5c3RlbSByZXNldCBjb250cm9sbGVyIHdpdGggbGluZSBpbmRleA0KK8Kg
wqDCoMKgwqAgZm9yIG1tYyBodyByZXNldCBsaW5lIGlmIGV4aXN0cy4NCivCoMKgwqAgbWF4SXRl
bXM6IDENCisNCiDCoHJlcXVpcmVkOg0KIMKgwqAgLSBjb21wYXRpYmxlDQoNCg0KUmVnYXJkcywN
CkJyYWQNCg==
