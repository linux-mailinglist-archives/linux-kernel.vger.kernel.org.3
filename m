Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8472D5A897F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiHaX3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiHaX3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:29:44 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA2DA3F6;
        Wed, 31 Aug 2022 16:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT4Z4OhukqKgnTYjJt9+weZWgaY4nXAyDFVT+s73N/TC+D1FyIG/R7AqE4AVIY8XUWmF3JaWUmnboI7QHPwBOaENaFGv/MFnK9jAc+/DP3bVU8cIhgfiiBD9phBWyV9UTNZbAb3xcd8RWhUMKvF5jVxH8CqRSzp2awshgzVWWLwol7gNX0j+caEaw718Y7GJkA6IRtbTdR5i6y/6Mc+ktYSBQjkGgbN4uhnS6tkU+xZ5VxqxnE7JPP4EgRqkVCfqbnQjeHk1z+jAl1G9NaAZ1W08vUj0LUtfn1S7CAbXlxDG9PwAfrmJ/ABlAhIcd3pbZbH+/8viT1oWtaQ/Dlt0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE/mDBdM8dM8dDReWZgLihIEbKaE4178qwb+B7B48Ng=;
 b=NE8oH2W2BELaDYVCYfc8FdH9cJ3NTybMWbriRGnvajPkmUAsfcquKUwODW8O0Z7GhGABbDwDfkge+/w5V8Je9UvUN6710tr4lpJop8O3eobWujuHSsPE7ywHQYF0rn6xzXnaNo53iLwA6PpaiVSto5wZ5q5UKIFYJGZY5gej/zbLvQlyLLuR8TzAlfQnI7puQausxFkLVDM34+CckM9OFKkXOjPbCY6O7Q0YR8DI5ltBYcn/j4ifc6S/eb//ab6hfFkwXqiP/ORwI7z0egdobT7i6dBTswCKbWxWXF6yUS8L6vzRvwrEAghUVFYy0A9iNxOm2JiQ1BcoF/9YJ29ZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE/mDBdM8dM8dDReWZgLihIEbKaE4178qwb+B7B48Ng=;
 b=LJ47lFFw9S7eMG7eHxYoDViRA71cSxLJ+MrgxzKO/sH88EFqC4fG124GGl31/uyOniBXgInDRxWUPwxaS3MQ9N6DWJjonE1MggC11cPgHa4+Qv3qPZBHvAw1VxzaVHUxWlYo6KvGSOFcqxNJyMg7j3Fh8sv1HweYMzUJU8nnfpQ=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 23:29:36 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 23:29:36 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Brad Larson <brad@pensando.io>
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
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 17/17] mmc: sdhci-cadence: Support mmc hardware reset
Thread-Topic: [PATCH v6 17/17] mmc: sdhci-cadence: Support mmc hardware reset
Thread-Index: AQHYtM9MGCmT8rfLtEuz+oFybZ1VTK26wSwAgA74RIA=
Date:   Wed, 31 Aug 2022 23:29:36 +0000
Message-ID: <ed9e54d5-b069-9899-6664-b07dbd0a5d54@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-18-brad@pensando.io>
 <CAPDyKFoYdQirftoEQAMBwXKXqSo-tu9EUvL6B6vHCj6cDd14ug@mail.gmail.com>
In-Reply-To: <CAPDyKFoYdQirftoEQAMBwXKXqSo-tu9EUvL6B6vHCj6cDd14ug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f12550fa-dbf2-4dac-483c-08da8ba8aad0
x-ms-traffictypediagnostic: DM4PR12MB5119:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YIBamjgh8cAFMkdVaJqfZbSp3Ug5u/x05sqkIKOSM5z+mYVbHhix6TsUsZB6NBS+90xvBvd2Nm726QMpBpcPz7TyU4ecdQlVum1m4GK0aLMYMLH8gs1vI1ifE8BcP5QYzwbtCyAmZSNnES8/DoDHpZlk/BEbXl6zE6XcTSxs8zFgrz2yhmbcavGdEirXHVIwlt/ehrivyX2IRv1NX0fI0joIAFRCs2nmwhjwFWOiXcCpMHZRddIRtQ0+YTMuWtdzqsIE/TadJN8WcIEK6Qf2BHuFtyTiEtcw3/fMnDNbcf6Yzu+xeVlKrxspXKqEP+PTp8blD9zvyJAMulyYoWbUU9LKhrRmQ7QEYMBSk1naUuaSsORoBlhwysyK/scjAbit8G3chb+OxrPKj61HHMf+xfw/JKAgaxGmr3yEXnDrkEHxP3y+E7TD9dNO5ylmGgjAM2O8N1g79JMxaHgj9JqcyZFHkAhMOnEHa6RYG14TMONMm3SyiBU/Q3dz2TC5cG2COLxnspXPSVUm21axk+4O9jTDBpBIRrY2QHTXuO48PYPes+ben5fEoe366hoQ/4Mu2UGFpdHuYFZvmc9Hemyt1xg8jvJxumSRngBTPOb1Vjoku17hLYkjIdG1k5NpT6Lf3gR9EY7zzOK+M0pS6gC/SFuVs+xHllt5Cv9h/dbfmtJSrcYfxNXZSvLrAXmIqU3MphrGJML9lbfdBho8hzbT69gQw4LNl7/ak18XDXoBHd+/PgEpnQ61RzCmMTe1TuxGqW6953gAC58cvPLC09h4YjCXUAOJUfHxU5JlDuk0g6s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(31686004)(38100700002)(122000001)(4326008)(64756008)(76116006)(91956017)(316002)(8676002)(66476007)(66446008)(66556008)(86362001)(66946007)(31696002)(38070700005)(36756003)(83380400001)(6512007)(71200400001)(26005)(6486002)(6506007)(53546011)(478600001)(41300700001)(110136005)(7416002)(54906003)(8936002)(2616005)(2906002)(186003)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkoydFN4OEpkVmJKSmFaSEV5Z28rUVUyRXRpRC9VTDlIbEhWNFExa1JjUlN0?=
 =?utf-8?B?cUJqdUdYV0JEejRmZGlOS0VFVG1mUlFwb3hhOHg4bWFHRjdtQ0I2MW9jWmVv?=
 =?utf-8?B?THgvc1lpUnJ5VW1yd011a3pKcW1XbzZ2ejY1aW1PdDB6aDNvdlpuSTZwdS92?=
 =?utf-8?B?OFB3eGxONmhZSGJFc21mSFdNNDBMVWlRd2pjRDIzbmJySjdnQzNXbSt2L0ZV?=
 =?utf-8?B?U2FuWCtXZGI2TmgxQWhuWXFwdUNyTmpjOXV1SnZnRFcyMit5NS9qb3g3eHAy?=
 =?utf-8?B?aTd0VGFrRmNUVjBPaVZTTHJJUnZQb3A4QllxS001NkVhdGxhdHpBM3QvMWVo?=
 =?utf-8?B?Q2F3YkJ1a0YyWmJMSHk4VEJiY2JHVnNYdkIyNVFRK1hDd3NneTlxMnRPS3V5?=
 =?utf-8?B?cHJsTjdkUEJ5eSszckJrdjAzU2htUk9WRXV4TFBrNlN3c3FtSDN3SS9GVkxv?=
 =?utf-8?B?Z05BcGxVelNaQ09zR29OdW00ZFBYOGtYVkFyeEVQYmE5dTlGenJSRUdPNUEr?=
 =?utf-8?B?TlIvR3VnbUtUSVU1SDR1dWphR0xDNms2WW9MV2taa1llcnZWRU9MWXVtZE1i?=
 =?utf-8?B?ckdBTWFyRG5nRmNhQ0xaT0tvMS91cHFGRU10bzJuRm5yT3MrSkpsTkhZNk5L?=
 =?utf-8?B?eVR2VWdINjdBVklWbGU2TndSM2J3dkRjQ0pwWnBndzZRYzBabklMWlc3U0xa?=
 =?utf-8?B?NllRQ0E1bjY0ck91L0hYbXN5WE85YmVLQkQ4ZUZlL1JMdFZFeUJVelZUZjVs?=
 =?utf-8?B?OEhtYjZhTFRDYzBMNVNXWW5IaFdlbU1iQmlZeXNrN2tMdG82bkVXS0hObFY0?=
 =?utf-8?B?K1A2WEJCVjFNR0syakd4UWlJbmdSQnRJVTNjd1hCZjVXQUVuY0Q1VlBRL2or?=
 =?utf-8?B?MGNpQWF5WkV1ZU5tUUkvMkk4UHkzNzRFMExZK2EvNU5HNFJVRFhkZk1SR2NP?=
 =?utf-8?B?YndaanQ3U0JDNWpwQkRxMkFhTXlPb3poNC8yMXpKemZOYzhIWUVVNUlDMENm?=
 =?utf-8?B?VC9HM2Z4MU4xaDdUdkpnRkpxbG5yckk1V0NNLzVUTTFNbC9YSG9jdUVVOTVT?=
 =?utf-8?B?TkhyeGZmTjdsUUFlNFIyYyswU20rMDlBU1JOS213U0JhNW5QZ05PVFRnb0Rm?=
 =?utf-8?B?dkdzN1F5LzZkanRVTE5mNFhiVktnQVVUbG55RmZzSjVxb29UNFpJQVFjcGtT?=
 =?utf-8?B?WlNYb0VLeEVvOGlDd0R1YWwxMlU0MFAvT2dWZ0tITVYwTzJSZGd0ak1jRVBY?=
 =?utf-8?B?bExsdW1KU01id3MvTjF3ZFpadkRNV3R2cFdHQzA0Smk5dzU5ZFM1bUI5QkN1?=
 =?utf-8?B?dW5rcnYwa3BNOWpiL0pCTitEV1g4eUpodU1ab3FvRmNYRVpwUVZEcHJLQTRP?=
 =?utf-8?B?bXE2MlZRUHdKU2VYMVZIak9SZ0pLODRJTWdjRUloSXd3OUVpaGdaS2ZkQmdO?=
 =?utf-8?B?a1d5YXU0MmJRWkhWaGhmQWlrbkhza2UzaXdob2lZL2tLOHl2Z0ZaK2xuZWtN?=
 =?utf-8?B?bUgvaFRDTHVMNEYvUCt1OEt5ZFlGd2RiTjkzcTFFdDFrV3F3c3NYT0tGcFFN?=
 =?utf-8?B?RWt3SlY0a2ZMbCsyZ2dFMnA2ODZmc1cyNmVXOFZXU3VXMTJPZDR3U3hjb0Rx?=
 =?utf-8?B?aTFHeU12eUVXQXdlU0NoMzdzZmRYaTFta2pJNXJYY3IrRUhOU1pZQ2ljaXoz?=
 =?utf-8?B?Y3BNcHQ3dXNoYTdYYTNxaXdiQndXTGhYdlJHTExWT01zQittSTd6U1EvRFJa?=
 =?utf-8?B?c0RzL2VaTkVEZm9Hc1BEdlVZZ2VUZzl0M2JFSjBQaHZyTG13WHpiS1ErS3My?=
 =?utf-8?B?bDE1Zi9oVFVTUndYY3pZaDJHeWx4aitzV3h1UmNTbmFZdm1BdlFTZ0lOa09i?=
 =?utf-8?B?REhYS3ExTEhDS0d4Vm9McThHbXpjWThxVVgxdjR6eTNTellwbzhwVVM5WTIw?=
 =?utf-8?B?SDZRejFiRXk1cGhSKzIxSEVyZk55QXl1Z05lYSs0T0ROcTg5NnJ4ZHllSzRq?=
 =?utf-8?B?cVlUNVJpaXZPSlpnQlF5Z3B4ODUrcDYwbkVCNG9KQkE2bEtEMldmQUtEcHlS?=
 =?utf-8?B?Zkd0a0Q4eDcyWkNDdWlsSUVEYXJraUJJNEtvaGsvZE9td1FvMlBiSnRXdHJl?=
 =?utf-8?Q?5wso=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12059D70F452C446A34EBA542CB3383C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12550fa-dbf2-4dac-483c-08da8ba8aad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 23:29:36.2264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYTL6vQ3xG2LFX5nCo1V147KI8/KWFTyCRnsjVd1EsvwfJYNI4ep92xCh0/H9nNL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMi8yMiAzOjUzIEFNLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4gT24gU2F0LCAyMCBBdWcg
MjAyMiBhdCAyMTo1OCwgQnJhZCBMYXJzb24gPGJyYWRAcGVuc2FuZG8uaW8+IHdyb3RlOg0KPj4g
RnJvbTogQnJhZCBMYXJzb24gPGJsYXJzb25AYW1kLmNvbT4NCj4+DQo+PiBBZGQgc3VwcG9ydCBm
b3IgbW1jIGhhcmR3YXJlIHJlc2V0IHdpdGggYSByZXNldC1jb250cm9sbGVyDQo+PiB3aGljaCB3
b3VsZCBuZWVkIHRvIGJlIGVuYWJsZWQgaW4gdGhlIGRldmljZSB0cmVlIHdpdGgNCj4+IGEgc3Vw
cG9ydGluZyBkcml2ZXIuICBUaGUgZGVmYXVsdCBpcyBkaXNhYmxlZCBmb3IgYWxsDQo+PiBleGlz
dGluZyBkZXNpZ25zLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEJyYWQgTGFyc29uIDxibGFyc29u
QGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1jYWRlbmNlLmMg
fCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MjkgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLWNhZGVuY2UuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktY2FkZW5jZS5jDQo+PiBpbmRl
eCBjNjYyYzYzZDQ5ZmEuLjM1ZDM3YjlhYmE2MyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktY2FkZW5jZS5jDQo+PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWNh
ZGVuY2UuYw0KPj4gQEAgLTEyLDYgKzEyLDcgQEANCj4+ICAgI2luY2x1ZGUgPGxpbnV4L21tYy9t
bWMuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9v
Zl9kZXZpY2UuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4+DQo+PiAgICNpbmNs
dWRlICJzZGhjaS1wbHRmbS5oIg0KPj4NCj4+IEBAIC03MCw2ICs3MSw3IEBAIHN0cnVjdCBzZGhj
aV9jZG5zX3ByaXYgew0KPj4gICAgICAgICAgc3BpbmxvY2tfdCB3cmxvY2s7ICAgICAgLyogd3Jp
dGUgbG9jayAqLw0KPj4gICAgICAgICAgYm9vbCBlbmhhbmNlZF9zdHJvYmU7DQo+PiAgICAgICAg
ICB2b2lkICgqcHJpdl93cml0ZWwpKHN0cnVjdCBzZGhjaV9jZG5zX3ByaXYgKnByaXYsIHUzMiB2
YWwsIHZvaWQgX19pb21lbSAqcmVnKTsNCj4+ICsgICAgICAgc3RydWN0IHJlc2V0X2NvbnRyb2wg
KnJzdF9odzsNCj4+ICAgICAgICAgIHVuc2lnbmVkIGludCBucl9waHlfcGFyYW1zOw0KPj4gICAg
ICAgICAgc3RydWN0IHNkaGNpX2NkbnNfcGh5X3BhcmFtIHBoeV9wYXJhbXNbXTsNCj4+ICAgfTsN
Cj4+IEBAIC00NTgsNiArNDYwLDIyIEBAIHN0YXRpYyB2b2lkIHNkaGNpX2NkbnNfaHM0MDBfZW5o
YW5jZWRfc3Ryb2JlKHN0cnVjdCBtbWNfaG9zdCAqbW1jLA0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgU0RIQ0lfQ0ROU19IUlMwNl9NT0RFX01NQ19IUzQwMCk7
DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIHZvaWQgc2RoY2lfbW1jX2h3X3Jlc2V0KHN0cnVjdCBt
bWNfaG9zdCAqbW1jKQ0KPiBOaXRwaWNrOiBQcm9iYWJseSBiZXR0ZXIgdG8gYmUgY29uc2lzdGVu
dCB3aXRoIHRoZSBwcmVmaXhlcyBmb3INCj4gZnVuY3Rpb24gbmFtZXMuIFNvLCBJIHN1Z2dlc3Qg
Y2hhbmdpbmcgdGhpcyB0bw0KPiAic2RoY2lfY2Ruc19tbWNfaHdfcmVzZXQiLg0KDQpDaGFuZ2lu
ZyB0byBzZGhjaV9jZG5zX21tY19od19yZXNldCgpLg0KDQoNCj4+ICt7DQo+PiArICAgICAgIHN0
cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCj4+ICsgICAgICAgc3RydWN0
IHNkaGNpX2NkbnNfcHJpdiAqcHJpdiA9IHNkaGNpX2NkbnNfcHJpdihob3N0KTsNCj4+ICsNCj4+
ICsgICAgICAgZGV2X2luZm8obW1jX2Rldihob3N0LT5tbWMpLCAiZW1tYyBoYXJkd2FyZSByZXNl
dFxuIik7DQo+IE1heWJlIGl0J3Mgc3VmZmljaWVudCB3aXRoIGRldl9kYmc/DQoNCkNoYW5naW5n
IHRvIGRldl9kYmcoKS4NCg0KDQo+PiArDQo+PiArICAgICAgIHJlc2V0X2NvbnRyb2xfYXNzZXJ0
KHByaXYtPnJzdF9odyk7DQo+PiArICAgICAgIC8qIEZvciBlTU1DLCBtaW5pbXVtIGlzIDF1cyBi
dXQgZ2l2ZSBpdCA5dXMgZm9yIGdvb2QgbWVhc3VyZSAqLw0KPj4gKyAgICAgICB1ZGVsYXkoOSk7
DQo+PiArDQo+PiArICAgICAgIHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQocHJpdi0+cnN0X2h3KTsN
Cj4+ICsgICAgICAgLyogRm9yIGVNTUMsIG1pbmltdW0gaXMgMjAwdXMgYnV0IGdpdmUgaXQgMzAw
dXMgZm9yIGdvb2QgbWVhc3VyZSAqLw0KPj4gKyAgICAgICB1c2xlZXBfcmFuZ2UoMzAwLCAxMDAw
KTsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyBpbnQgc2RoY2lfY2Ruc19wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICB7DQo+PiAgICAgICAgICBzdHJ1Y3Qgc2RoY2lf
aG9zdCAqaG9zdDsNCj4+IEBAIC01MjAsNiArNTM4LDE3IEBAIHN0YXRpYyBpbnQgc2RoY2lfY2Ru
c19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICAgICAgICAgaWYgKHJl
dCkNCj4+ICAgICAgICAgICAgICAgICAgZ290byBmcmVlOw0KPj4NCj4+ICsgICAgICAgaWYgKGhv
c3QtPm1tYy0+Y2FwcyAmIE1NQ19DQVBfSFdfUkVTRVQpIHsNCj4+ICsgICAgICAgICAgICAgICBw
cml2LT5yc3RfaHcgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZShk
ZXYsICJodyIpOw0KPj4gKyAgICAgICAgICAgICAgIGlmIChJU19FUlIocHJpdi0+cnN0X2h3KSkg
ew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihwcml2LT5yc3RfaHcp
Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCA9PSAtRU5PRU5UKQ0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcml2LT5yc3RfaHcgPSBOVUxMOw0KPj4gKyAg
ICAgICAgICAgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBob3N0LT5t
bWNfaG9zdF9vcHMuY2FyZF9od19yZXNldCA9IHNkaGNpX21tY19od19yZXNldDsNCj4+ICsgICAg
ICAgICAgICAgICB9DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICAgICAgICAgIHJldCA9IHNkaGNp
X2FkZF9ob3N0KGhvc3QpOw0KPj4gICAgICAgICAgaWYgKHJldCkNCj4+ICAgICAgICAgICAgICAg
ICAgZ290byBmcmVlOw0KPj4gLS0NCj4gT3RoZXIgdGhhbiB0aGUgY29tbWVudHMgYWJvdmUsIEkg
d29uZGVyIGFib3V0IHdoYXQgbWVyZ2luZyBzdHJhdGVneSB3ZQ0KPiBzaG91bGQgdXNlIGZvciB0
aGUgc2VyaWVzLiBJIGJlbGlldmUgaXQgbG9va3MgZmluZSBmb3IgbWUgdG8gcGljayB1cA0KPiB0
aGUgbW1jIHJlbGF0ZWQgcGF0Y2hlcywgdGh1cyB3ZSBjYW4gYXBwbHkgcGF0Y2hlcyBvbiBhIHBl
ciBzdWJzeXN0ZW0NCj4gYmFzaXMsIHJpZ2h0Pw0KDQoNClllcyBJIHRoaW5rIHNvIGFuZCBJJ2xs
IGJlIGxvb2tpbmcgZm9yIGd1aWRhbmNlIG9uIHRoaXMuDQoNCg0KUmVnYXJkcywNCkJyYWQNCg==
