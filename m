Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFA5B00E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIGJt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIGJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:49:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD37392;
        Wed,  7 Sep 2022 02:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awIAH6GGVtjdQbJ7LvgNpJwwVeRb3SN48mjYopzeGxgD5EQ1odDRmL7yMw1AN65C2COc47mgGmpH7Kg8LtRx1u7wD60hNYkpJ9fNNBxtd40EOKW3zSUY8c29yiTonvnfvFSWHK+56PsiSrH93S98xokirlDehMzxkSzfpH4H/BEASlCBaQhGLpA7eWVO4QtyjRXZlfvUY3fC4T+boxjplPt7g5mbVX2zY2beU0fb6GvcAPN3htpLZFFnIUbQ0ClIaEtSAC/yj3oaLdEHKCgbs2ZjzdD7UduYYu4JDWSItxaZccV9nIldOFy7qOiLicTVir3JpYVJT6Oyav+wp9vSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9eRGwGSEHyRAsLNr50Nyu2TONktVzAEPulxLiSy/As=;
 b=g5vjKD66Md23KhjBnfe6JaWCD52AqrVDj176z5/aWTaVWej8LAmnyYO86v70TZUXw0kjZOowe+XxvhCat1hOpYwt8iR7cFVvvxP3/Tgh0OwwYa3vMo0srjI6+Fu3Eg4i3I24NLXsuF3Ah+12oqJCDXqQq2BWSATrMRdJgY6Z0v2NkUyJa0aq7za5jzz73yOliHd08zkQ6wDTdjs8vwKSrKQSqzogkJ9+Iauzq972VEu/sHRd1/YnqCN/DF8sNporBphIzAHJN+EPDjLrDCvbL3PgaEJocK/FqepT1+e9QAtPs16BJteOZE0mHpG8yK+zpMdjwTSnPvzQ2bgjHrrugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9eRGwGSEHyRAsLNr50Nyu2TONktVzAEPulxLiSy/As=;
 b=uedAs/+O3Fz8pFKBMmZSZJrbn/O+dnW2JYOBrTRc3tUdj+YLeZrucYEH4f7IeAyh21482rJDOgLqHE1yBXYIXRB2Ksapzh6E5CewJSckA0o9EOqAsrLkYuf9N+qsCwuE2vESJcLriBcdNiKC1vxyUK+6M+rgplBcHyKwKQbQ2Uk=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 09:49:19 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f5a1:c4e7:9c3e:3231]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f5a1:c4e7:9c3e:3231%4]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 09:49:12 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: mtd: spi-nor: Add reset-gpios
 property
Thread-Topic: [PATCH v2 1/2] dt-bindings: mtd: spi-nor: Add reset-gpios
 property
Thread-Index: AQHYvdS4ASUG0YLBMESpOo8Y2+hFjq3KNPqAgAAafiCAAA/rgIAJYM+A
Date:   Wed, 7 Sep 2022 09:49:12 +0000
Message-ID: <BY5PR12MB425896652F8056EAD47E1042DB419@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20220901072914.30205-1-sai.krishna.potthuri@amd.com>
 <20220901072914.30205-2-sai.krishna.potthuri@amd.com>
 <6b06f88e-128d-7ce6-b97b-b5cacfc4834d@linaro.org>
 <BY5PR12MB4258128603AA297DD8FAB168DB7B9@BY5PR12MB4258.namprd12.prod.outlook.com>
 <83444851-14ef-b293-6581-1307331fb1c4@linaro.org>
In-Reply-To: <83444851-14ef-b293-6581-1307331fb1c4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f61d80bc-e9df-45d7-4a1c-08da90b6383c
x-ms-traffictypediagnostic: BL1PR12MB5126:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tCzalySGAaAy1h3xK19PtJdpGN3P0g3SPeSkwOr1QdY0Mkfn1fEhf/Obg7Emd5Tt7YyuEC8eXzgacSS1KdPbc6JBDc8t6Ig0zkbkjGp7o2oLwHjxAcANTiRr+/uRxbgo4QAqUIoub3jUoGznH5ynE+nGZmfxwqWHT+g0CMXco1+jYOOwcPQIX62iF//iTOuQrmwUrHe1chOjhs44++e0owNbZTsq9Kl2SIC7eeO4J7p3fCuYLbRt7gmE/nyYhG4c59MDuMaJCrreBw5jcG4ZPtWVSHgWseBGB6H5wlwns/0ywiqP4Y2Km9j4vtUA2h9gav3+UnJ+OamckqiUTgWNlhwdEkGsPw04VIpzTxwXYUkG41+K7/k3nD+LqehZUdm8TgrBfhbk2eczR00kBgnmPi1yMj3EPWIms50pmcikKqLJ818biNVINwPBYPp+6/8nbzOjSpaTOxOup761FFDw4VpKzx97eVvhde2rPmxLURLRLIWXXfwNWnKVb6vK8F4X+7x2iSrIpoIVXSP4l/Irm5ZCUjLSgXNd7pvX3Hzn8P5IaxDuZMy0R6nweSExp3FC5B+RDFEmUaNJ64w0YnKx50acK5sqfaqo/myrUF3n1+IWQIUDaLcuJY0WhqMAbXDTbHTtc9v85aTyIUCYJzACU1z8R3jfByPF9Y6eVyiET9N9hIfSiUuzEcdiD5kCIP1q7RGrsMHvyruy/z+SnNgWJC7YnO+90QuG2mVqOkIxwJxgdpt9uiH9kE/USJrK0tiqxf2MXkesCOEfFE/kLPvx/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(26005)(83380400001)(9686003)(7416002)(2906002)(5660300002)(52536014)(33656002)(41300700001)(7696005)(6506007)(86362001)(71200400001)(53546011)(186003)(8936002)(478600001)(38070700005)(64756008)(66446008)(66476007)(76116006)(8676002)(66946007)(4326008)(55016003)(66556008)(110136005)(316002)(122000001)(38100700002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVFVd1Bod2h3NnpnY2c3cXp1NVNYRmRIWGZiS1I5WEg4bUZXSnZ3ZzhpeEhk?=
 =?utf-8?B?SmZRL1pPeWtTcWtFZW5xR3VTNWtZbllZQ1lya2YzUXZqbDlzYmlCTXFTZXN5?=
 =?utf-8?B?dXBYOTVDamNHS2NxbHZycHhhZzFrVTFnMHF0Y1UyTHU2RWNPN2g3a0tldHRP?=
 =?utf-8?B?Sll1Ni9Dc0RsZ2EwVG9wUFR3ZURWYmczTXVXdHRHUTBVODFNUTJUOVNCL1Uw?=
 =?utf-8?B?NjV6ajRwYUNIZnM1bnVoVGk3QlloU1FYdEI1R0JnV3dNQUU5azNDU0IrRE1a?=
 =?utf-8?B?WlRBZHhEMW1WLzRLUVpVQlc5TGp6V2pScG5HT2tHSzRpNnB2ZE5xbTljWGw0?=
 =?utf-8?B?SE1aSUZUOHdoUzhIcTFjT0w2SGhJaSt2MmVWRC9wQlZxZERwMXNQZ3k0MDc4?=
 =?utf-8?B?Ly9LRUgzSFNLTU5zcWpVNEFhbjZpNHBETm5IQlcvUHpVRWRQNnNBdWkzeCtF?=
 =?utf-8?B?a1J6NGVkTFlHVHlBUUxqcjh4NnVvanlneW9sWFRGUTUvMlM5OGg0L3FOMnRY?=
 =?utf-8?B?WmF2bjhndldsWkhCMXhwVlgrSXMzc2NoN1Nyb2JjWVZHakZSeUx2b0ZqQXhs?=
 =?utf-8?B?cURSWjZ3NzRFWUM1M1h5NmRCSDhUdTRUYS9tZE9idlF6U3NCU3VkN2lEbXgr?=
 =?utf-8?B?MW1ySlZaNlNQc0lKVmdLV1I1c2dWMWZSckluM2pNSkRXVXBoUzhFV2dYUloz?=
 =?utf-8?B?MzN2M3I0cFV1d2Q4SzJ0amQ2V3piUGtKSXZBS1VmVjFHNnpwdGc0VnNDSHVU?=
 =?utf-8?B?TVh0amNtZ08zRTdqNHVsdzFVVXdKeWVocTVTOUduZTQ2Z29FTGxZWWI1RmEz?=
 =?utf-8?B?Q2FIbjNDNXQ4ViswTmxtZnNVOW4xdmFVUXhCZkwwa2J0L1FxNlVJMGxlRUtQ?=
 =?utf-8?B?WU1PaHBWK0hGdklNU3Y0R25iRmdQNHpaMHppZXcwb25mRmJUaHVubkllRWJr?=
 =?utf-8?B?NFhNbjU5amtLU0REWC9Ca2FtanVIWU5DdU1kVmNCbkZCMzhXcVJlaVZJTUVr?=
 =?utf-8?B?Nm9jUmd2UnhJMnpJbFltcHR5TkgrY3VUaWNSclRyV0kraURkRmMwTzF2a3VZ?=
 =?utf-8?B?MHoyb25qTEQwRTIzTVJxVSsxLzIzSnNqNW1maUQxU2gvTVBiRkZyem8zWmti?=
 =?utf-8?B?bFFORG9yNUlldU5hQWFtL2lDV0hRcXpndTJmeHNpdER0UllyR2hzZVdTWDN3?=
 =?utf-8?B?U3JCVERZWjIyQ0ZmNE9wcHAwZFNZK0lDZHZ0aU1sdDVrVVF2eVlDeGszWGxX?=
 =?utf-8?B?MTBQZnNBbzhoTmp0TXpYL0ZuWXh2Tkw4Y3hjM25CK2pJWlZiWG40b29GRXox?=
 =?utf-8?B?aXo2S0hEZ2IrUTZ4bno1N1BCWGE5Tm96UW5VZ3lCZWNnYmxSdXFRN29GaVl0?=
 =?utf-8?B?YUVPR2djdXpOalAwdjNGNlQ3K1B3WVJPMG8xNjR4ZXdNS1Z0M1NValoyQkIv?=
 =?utf-8?B?MFFQTzk0UStHZVRsUjZaMk0vczVSSFJLS1VLSllpWDZ5ZnpjWVYyM0V0Rkg0?=
 =?utf-8?B?NjJaZytmV1RISFBUTjd3UmxEeXFGN3hVaTRzQUZLMncxbzk2ZFJYZTlnTjYz?=
 =?utf-8?B?ck1IZm5IOW9nSFlGdnU2QnFnemZTNU9RclNEV1lWNnBOOGh3MC9GZUl3S0Jn?=
 =?utf-8?B?QUZyMTJsaGZYNWF3Ulp3MjNQeUZWMUNVc3RiTGdWQk15Yy9HMmI5b1ZMZEpH?=
 =?utf-8?B?TWFWZFJPWlZtbklmaSt3Q2tvTUZmeHNXeFZ1cmxNL3UzTDB4NnJJQks0WmlR?=
 =?utf-8?B?b2ZISXBzWFBYYWJ5K1k0YUhNQTdiOTFCbjhXZWhiRS9lNjFNTlFVaXYwVCtD?=
 =?utf-8?B?b3JseHJ3bHVyS25NMjJmbUxsK1NwN3hkdEsvTXdJbzFsZ1NHOVRZSGVHU3ZE?=
 =?utf-8?B?N3lUQXFCS2tNampPY1lSUzkwU3FMeFIvVjE2Ylpwc0FwRGdVQy9lb1ErSGo0?=
 =?utf-8?B?VGlRQkU4TVhUSW02SmowWG9UckRoc1lRb1lKOUhBYVgydDNxbUFJTmNWVFJl?=
 =?utf-8?B?SzZXR25tcnVpc1U4SHB6bFJsK29Zc1IzK1lzNjFBaGxhakxPa1ZFQktuRWNp?=
 =?utf-8?B?aGQ5bjdoUjhsOHJLRStxRjgrY3greXdUbTNpc2dmVnlDMVBwci9WdGFHSitz?=
 =?utf-8?Q?Ac0g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61d80bc-e9df-45d7-4a1c-08da90b6383c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 09:49:12.7643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3gVr/2sWBMQOi+u56kCClHyNsRYV00sfoS22OGzH/f8Q6wM5DulziE5Jnt5r3mHCmh/x37xBF3SHrBkBN4CkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2Vu
dDogVGh1cnNkYXksIFNlcHRlbWJlciAxLCAyMDIyIDM6NTggUE0NCj4gVG86IFBvdHRodXJpLCBT
YWkgS3Jpc2huYSA8c2FpLmtyaXNobmEucG90dGh1cmlAYW1kLmNvbT47IFR1ZG9yIEFtYmFydXMN
Cj4gPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT47IFByYXR5dXNoIFlhZGF2IDxwcmF0eXVz
aEBrZXJuZWwub3JnPjsNCj4gTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz47IE1pcXVl
bCBSYXluYWwNCj4gPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+OyBSaWNoYXJkIFdlaW5iZXJn
ZXIgPHJpY2hhcmRAbm9kLmF0PjsNCj4gVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGku
Y29tPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3ps
b3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz4NCj4gQ2M6IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHNhaWtyaXNobmExMjQ2OEBnbWFpbC5jb207
IGdpdCAoQU1ELVhpbGlueCkNCj4gPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDEvMl0gZHQtYmluZGluZ3M6IG10ZDogc3BpLW5vcjogQWRkIHJlc2V0LWdwaW9zDQo+IHBy
b3BlcnR5DQo+IA0KPiBPbiAwMS8wOS8yMDIyIDEzOjE4LCBQb3R0aHVyaSwgU2FpIEtyaXNobmEg
d3JvdGU6DQo+ID4gSGkgS3J6eXN6dG9mLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dz
a2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxLCAyMDIyIDE6
MjYgUE0NCj4gPj4gVG86IFBvdHRodXJpLCBTYWkgS3Jpc2huYSA8c2FpLmtyaXNobmEucG90dGh1
cmlAYW1kLmNvbT47IFR1ZG9yDQo+ID4+IEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlw
LmNvbT47IFByYXR5dXNoIFlhZGF2DQo+ID4+IDxwcmF0eXVzaEBrZXJuZWwub3JnPjsgTWljaGFl
bCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz47IE1pcXVlbA0KPiA+PiBSYXluYWwgPG1pcXVlbC5y
YXluYWxAYm9vdGxpbi5jb20+OyBSaWNoYXJkIFdlaW5iZXJnZXINCj4gPj4gPHJpY2hhcmRAbm9k
LmF0PjsgVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGkuY29tPjsgUm9iIEhlcnJpbmcN
Cj4gPj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPj4gPGty
enlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz4NCj4gPj4gQ2M6IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+ID4+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHNhaWtyaXNobmExMjQ2OEBnbWFpbC5jb207IGdpdCAo
QU1ELVhpbGlueCkNCj4gPj4gPGdpdEBhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDEvMl0gZHQtYmluZGluZ3M6IG10ZDogc3BpLW5vcjogQWRkDQo+ID4+IHJlc2V0LWdwaW9z
IHByb3BlcnR5DQo+ID4+DQo+ID4+IE9uIDAxLzA5LzIwMjIgMTA6MjksIFNhaSBLcmlzaG5hIFBv
dHRodXJpIHdyb3RlOg0KPiA+Pj4gU1BJLU5PUiBmbGFzaGVzIGhhdmUgUkVTRVQgcGluIHdoaWNo
IGNhbiBiZSB0b2dnbGVkIHVzaW5nIEdQSU8NCj4gPj4+IGNvbnRyb2xsZXIsIGZvciB0aG9zZSBw
bGF0Zm9ybXMgcmVzZXQtZ3Bpb3MgcHJvcGVydHkgY2FuIGJlIHVzZWQgdG8NCj4gPj4+IHJlc2V0
IHRoZSBmbGFzaCBkZXZpY2UuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNo
bmEgUG90dGh1cmkgPHNhaS5rcmlzaG5hLnBvdHRodXJpQGFtZC5jb20+DQo+ID4+PiAtLS0NCj4g
Pj4NCj4gPj4gWW91IHN0aWxsIG1pc3MgdGhlIHVzZXIgKERUUykgb2YgdGhpcyBjaGFuZ2UuLi4N
Cj4gPiBEbyB5b3UgbWVhbiB0byBoYXZlIHRoaXMgcHJvcGVydHkgaW4gZXhhbXBsZSBEVFMgaW4g
dGhpcyB5YW1sPw0KPiANCj4gTm8sIEkgd2FudCB0byBzZWUgaW4tdHJlZSBEVFMgdXNpbmcgaXQu
DQpBcyBNaWNoYWwgU2ltZWsgdGFsa2VkIHRvIHlvdSBhYm91dCB0aGlzIG92ZXIgSVJDLCBhcyBv
ZiBub3cgd2UgZG9u4oCZdCBoYXZlDQphIERUUyBpbiB0aGUgbWFpbmxpbmUgdHJlZSBmb3IgWGls
aW54IFZlcnNhbCBwbGF0Zm9ybSBidXQgd2UgaGF2ZSBhIHBsYW4gdG8gZG8gaXQuDQpGb3IgdGlt
ZSBiZWluZyBpIHdpbGwgYWRkIHRoaXMgcHJvcGVydHkgaW4gdGhlIGV4YW1wbGUgZHRzIGluIHRo
aXMgeWFtbCBmaWxlLg0KDQpSZWdhcmRzDQpTYWkgS3Jpc2huYQ0K
