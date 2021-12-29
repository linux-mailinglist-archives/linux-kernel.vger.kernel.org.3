Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29504480EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 03:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbhL2CXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 21:23:34 -0500
Received: from mail-co1nam11on2106.outbound.protection.outlook.com ([40.107.220.106]:4736
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229620AbhL2CXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 21:23:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erxLNE6c/8rmX8kpCJLdulfhWUgv6pAhefH8gMPAu0Z6n5hUm5TOpeavsWPaau/Do4hnXRwSl3uvi6Zk5gkVCXQsxcOTq+u/poPYZuFSBXPYg7X73VvgC7wC5CgcGMYCVk94sXacQdyATJ9W5wMi8MhgRwcCPVIDn9lbS2Kjj1TLgqU/pTAybw5mjaTTV6BziDnK4Bm2C4omSG6MHpFoOyHp+iNdgnMk7hCwUu5zLyvfuebBMnqZaHPyL+6IiS8bIz4x4Z/+7sbeC4XJX4qlMFd94XSs18dxxgGKJFsip4+4JvJQBGMQJfe2CNJlGwqBioIOv0lagRjB+1G/zs+vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBEZMh3iXb1H56glXQA7ad9WHmy3164IHRz0xfCl7i0=;
 b=Dd4AJi+d9amOr8WlK5jF1GpnHnr7XSxrlNRbMjpQR5Wnl2eSxWx7d3FebicKHcSiXA9G69MaxwXcOFkLS/JM+K7a0jh55fzgEEuevgZQENyZu3oZVtGbfIq9lWR4dz/HyRa0cNUirfhLKgSg+G40v6sXQQ7/I/Z9XAeTJdyIl9m0G279e+OyYqSuNcYDH1lLQkHrDr7rx8ziG4EyWv7/13fy/aMESQRITDgxOk/dgRprsbU/Bwc558TyWxeySkTFdzdxHcvA3U68Q8K1kY+SU91/BYjQbylnAxdSuwqVjUpZkzwXnAHXgFwqYGMd8141nmpQTOEQxHP7uFNvbwMm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBEZMh3iXb1H56glXQA7ad9WHmy3164IHRz0xfCl7i0=;
 b=GuLZYhXPjr96JERWE9lE43WL9VkxM1auvedPRrAFcR+TN2hooq/+Zuq5BPZbMUr9327PYTsKiOct+5zNJLhrX1m0iJldqDdrkzvETTqELkTxSPvdDu06QQQSodWxFwLJY93AYMDVj6vPzYad/OBCs1xbkergHhVBILCyYcM7FOc=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB1800.namprd22.prod.outlook.com (2603:10b6:610:8a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Wed, 29 Dec
 2021 02:23:31 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::fdc5:67a7:8092:3db2]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::fdc5:67a7:8092:3db2%5]) with mapi id 15.20.4823.023; Wed, 29 Dec 2021
 02:23:31 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>
Subject: Re: [PATCH] configfs: fix a race in configfs_lookup()
Thread-Topic: [PATCH] configfs: fix a race in configfs_lookup()
Thread-Index: AQHX/FRfoq+mUDlHU0uSqobv5dYzIqxIvXoA
Date:   Wed, 29 Dec 2021 02:23:31 +0000
Message-ID: <AE8DCEC7-6056-4D70-9EA6-F312350BA767@purdue.edu>
References: <20210820213243.786-1-sishuai@purdue.edu>
In-Reply-To: <20210820213243.786-1-sishuai@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dd00d8c-9e86-4c2c-80ec-08d9ca723507
x-ms-traffictypediagnostic: CH2PR22MB1800:EE_
x-microsoft-antispam-prvs: <CH2PR22MB18005447DCD00225060DB55BDF449@CH2PR22MB1800.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:163;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KIo/H3+Royytf5MApl2UuFaIMLuM4meg5K4iCQxerRfrQ1VSElfGEGoWH5kTASyaMkx5GYY8XCdu6njWLCDoDOcvWCyXfitf9wMXaFFkq/o730ib2AmkMjJhFKAX+qsyEPzc/2tyTJ+KSc5MTmCOa6JSECcP0kNUJ1mnFhRwN5Pg+H3oHM9RwUWldTlpeyF1R5t5Qe94zHSXJNSMcXrEyEZZVV3iUHD1E4c/ZNT8PN+vuGGQdPxSY4hEWuclJeFvK7Bv2yp3ia8Bg9tzGZbyRXOdThzahvJreXsqtJdK50ma5iHsOB3Q+QedIe1CFiML0RC/pPx6MBpiaxNZqrJhDcTmL6b69ewpJpWOJbJ+J2+1XsEMG4YphHKwnN4ngEjJ6M5AfU34ThhGSVHJnu0IZJlZCJqTuJmUSJO/VNV4elc0LeHpXTevShHury6aJYhDAXbAGKc/1pA2k7h/5ID8Qy8GlcmKdsj6rAYtTdUYR8sqRD05Xx48+Ykiifoacg273iktllnz9uvI1c0vxIfPLqascYTMYVdjVpK/B9rzUSAdwT3bjWUSErBnfoPd5PhoOLUKIm3X3B2S9fWgdJot8p742yphhuIjyKxTZlBXPw/PJDxI/trp+ZQaw/zrjPuknERreO+oAIvP9vw/+dKd3tVTSULDjdohvVzQ2bTvfVKoaWw//O9eqif91qJBe9VdS0k2tSeTOihaDwlUTkhXlsBo6guTHv7WRvIKoDIook0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(2616005)(75432002)(26005)(83380400001)(316002)(38070700005)(76116006)(66446008)(66946007)(64756008)(66556008)(91956017)(66476007)(186003)(8676002)(54906003)(53546011)(8936002)(6506007)(33656002)(508600001)(2906002)(6486002)(71200400001)(38100700002)(86362001)(122000001)(5660300002)(786003)(36756003)(4326008)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWw5UHB3N1hWdWtsR0lNSjZ5M2RFWjZWanQxekYyWFZjR29wWmhNeVVQTjhh?=
 =?utf-8?B?dldOWWxQR1M5Q2JqdHVyRWFUdlZWcC9IWC9mdGc4Y3NlZGVNelZ5V3hIa2xG?=
 =?utf-8?B?UDhTWU5yQ05CZ2t0V05mRVpaejM4RHF5cVY4K2ZLZjdVMlZuQWF4bms0ZFJ6?=
 =?utf-8?B?WWhmQkc5YVJyN3lDWk01dE5tWnBJUk1KUjFiNVNYbVZRNGJJUzJmaXpJRmNV?=
 =?utf-8?B?eGNTVGttTDNvbU1qeHhtcWZDbzBTd1BoVGNxczJ5emJmbmR3N1VLVTZBZWtX?=
 =?utf-8?B?Z1JZV2E1N2xrakcwTlVWRi9RL1VxN2IxejJjblVmRUFCeTZObmw1bW9yaWFB?=
 =?utf-8?B?VGZnU3VVOHVuYUxhUTlPN0Fya0N3OE1tNWJlVGpySjRkOEJIWDFNUWlRTUEx?=
 =?utf-8?B?ZCtyOXNlVGJVb0t0Wmw1OFBHV3NKV2NrM1hUYUd1aGIvblptN0hqOXhRMFBV?=
 =?utf-8?B?SlNveWp6TitFaUV1dzYrd3c4eFBweTE2aXlqRGVBMEgyL3ZvRTgwT0VIZkUy?=
 =?utf-8?B?c3pQeHUzd0p5ZytZczh2eUd6K2RHcUFPR2x4U1FMYXdCMCtIRE5hYUNTR0Jj?=
 =?utf-8?B?cUNXZkhZMUIvSWdzdWpOVUV6ay8yWm80YVhKVEhlR1VHWDY5TmUyS3BRL1hX?=
 =?utf-8?B?cjFqT2pDRFZGdDVQdVJpakZ6RHVJdkt6Z1RvZGlBOHdjTnlLRkhRZTJXSWRE?=
 =?utf-8?B?U3VFSkVPSHA3aTgzSkpycmM3VXJNdERNL2hzZVJuWHlKUCtkWTJMWmJoZEc3?=
 =?utf-8?B?MUdmbTFPWDhNNXl5Wi9SczdkSlhRNGVmLzhLL0hOdFNlZjBRUUxONlVReHNr?=
 =?utf-8?B?bWFiMXAzWVEvS0E5Vm9VVUlzN0FhUjJTQTJndHRmaGpURGxCTm9TMk0rU3Qx?=
 =?utf-8?B?Mm1PTjNvRjdiVEE0dXNrTFRrUWJSME5VazR3OHljNzdVKy96dFo5eEdCdDdj?=
 =?utf-8?B?dXF5cjhkSkF4bFZ4VTE2c0VCazYyM0xaQ2lickNGRmpvWDc3TnRPWElrL1lr?=
 =?utf-8?B?QjgzS2dxcXFISi9RNEJycUFHQ3JUTmhRSEtpL1cySmZINlhwUCtUUDJXbkYx?=
 =?utf-8?B?T3NnaHhoM0FnZzErZC9YTnVhS21USWppWmFROU9PVzV1RzNPWnY5YmF5QjdW?=
 =?utf-8?B?Qk9XUWNIMk05eUlCNHlqVWdhWmlVZTlGNEFnRnFRN2l0Wktvd1UrNEFucEpJ?=
 =?utf-8?B?L3E4UnY5SFFibTdvKzlLZHFqTEJqaS9scWVOcU54Mlg2K1FzcXVuRWEwUUZh?=
 =?utf-8?B?TFdLVGlwMHlQRUV1T1dITTRYYi9GU1FQK2k3SmpWUFo1RVNrWWZodTZBSW1U?=
 =?utf-8?B?SW5mcDdMcGYvQmRTbzMzay8rSXNjRVg5SURHbFh2NTR1cG03eHRnRWpjTUpW?=
 =?utf-8?B?WGhuYlpDL1M0bTN6cXBWNHhiQncxMWFFZnZiOU0yZm1UQkxJbFlUTGliMGhn?=
 =?utf-8?B?K3Q5OSs3TitKYjF5bzJtOXB4R3ArR3hOSTQ1QmhGVGE4bUFmZDJlaWJRWnMx?=
 =?utf-8?B?YkxCQXFRN1VkeXpZVmlWUnB1Z0VHVWdQQzF4Rm9wRlBZUEpEQmRac3BidjVO?=
 =?utf-8?B?QXVSOHZmbW53RzF6SEpMNmlxSkNvYkZmbFhSTmttNjg5OGRlZHdPTFd6YWpv?=
 =?utf-8?B?RS91T3FjdVl3VDF4Ni9IcHVDRTJza2Y1K0dvU2M5cWx4SFpiREZGRUtaTE5C?=
 =?utf-8?B?TzFaOHZLQTlyY0xnT0tZdmU2SkY3QlBXYVhsamYzRlhHdWRERkZhckhvVWph?=
 =?utf-8?B?YzZPbldnOFI0bTM5V0poVFVVb2g2M2NaNjRKOHMvdWZZbFh5ZU54NnFqc0FM?=
 =?utf-8?B?cnRjYSt4ZElxRWRWS2ljN0J3VCtMazB1dzJkVFZ4SFc1ZHluWnl3YWFtTG1i?=
 =?utf-8?B?ZktmS0cyZ2dMVUFEQ2NuME0yWVA0dmdQV05FMktkRThTbEpFS2dOT3F4TGk5?=
 =?utf-8?B?L3JjcXhWUDRYWjVFMVpGcVpyd0dLMDRkS1NKVklEN2JSRmxnS2d3d3lrZU01?=
 =?utf-8?B?bUNpenBTUFA1NklVMkVwNnN4Y291T2JzTWdUNTNFdTZnMXoyQnJRNHdVRWRQ?=
 =?utf-8?B?OURXT210M0wyRmhiN1U4VWFocGN0dDVXMXp4TElPcFFyaHNlVnRjTUFEVDRD?=
 =?utf-8?B?NVM2Uk5GdERNaS9OVGd4NXNabEM3YURTM2VNeHowT0JsT2dyNS9jdnFOa2VS?=
 =?utf-8?Q?R+uOYjZL6VS0b5xyj5TT3WQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C15A17129EF874DBF6D4101BE2118ED@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd00d8c-9e86-4c2c-80ec-08d9ca723507
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 02:23:31.2839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSCLaiSanV7ZABwJA5qH/F1q9vxRIidSYVjw9em9GSjUatAjLWc4SE/++pLTuZS/mVtqU2o4522RtahV9WKNoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1800
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIHRoaXMgZW1haWwgd2FzIGRlbGF5ZWQgYnkgc2V2ZXJhbCBtb250aHMgZHVlIHRvIHNv
bWUgbmV0d29yayANCmlzc3VlcyBvbiBteSBtYWNoaW5lLiANCg0KUGxlYXNlIHNpbXBseSBpZ25v
cmUgaXQsIHNpbmNlIHRoZSBidWcgbWVudGlvbmVkIGlzIGZpeGVkIGFscmVhZHkgYnkgDQp0aGUg
Y29tbWl0IGM0MmRkMDY5YmU4ZGZjOWIyMjM5YTVjODllNzNiYmQwOGFiMzVkZTAuDQoNCj4gT24g
RGVjIDI4LCAyMDIxLCBhdCA4OjM1IFBNLCBTaXNodWFpIEdvbmcgPHNpc2h1YWlAcHVyZHVlLmVk
dT4gd3JvdGU6DQo+IA0KPiDvu79Gcm9tOiBzaXNodWFpZ29uZyA8c2lzaHVhaUBwdXJkdWUuZWR1
Pg0KPiANCj4gV2hlbiBjb25maWdmc19sb29rdXAoKSBpcyBleGVjdXRpbmcgbGlzdF9mb3JfZWFj
aF9lbnRyeSgpLA0KPiBpdCBpcyBwb3NzaWJsZSB0aGF0IGNvbmZpZ2ZzX2Rpcl9sc2VlaygpIGlz
IGNhbGxpbmcgbGlzdF9kZWwoKS4NCj4gU29tZSB1bmZvcnR1bmF0ZSBpbnRlcmxlYXZpbmdzIG9m
IHRoZW0gY2FuIGNhdXNlIGEga2VybmVsIE5VTEwNCj4gcG9pbnRlciBkZXJlZmVyZW5jZSBlcnJv
cg0KPiANCj4gVGhyZWFkIDEgICAgICAgICAgICAgICAgICBUaHJlYWQgMg0KPiAvL2NvbmZpZ2Zz
X2Rpcl9sc2VlaygpICAgIC8vY29uZmlnZnNfbG9va3VwKCkNCj4gbGlzdF9kZWwoJmN1cnNvci0+
c19zaWJsaW5nKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50
cnkoc2QsIC4uLikNCj4gDQo+IEZpeCB0aGlzIGJ1ZyBieSB1c2luZyBsaXN0X2Zvcl9lYWNoX2Vu
dHJ5X3NhZmUoKSBpbnN0ZWFkLg0KPiANCj4gUmVwb3J0ZWQtYnk6IFNpc2h1YWkgR29uZyA8c2lz
aHVhaUBwdXJkdWUuZWR1Pg0KPiBTaWduZWQtb2ZmLWJ5OiBzaXNodWFpZ29uZyA8c2lzaHVhaUBw
dXJkdWUuZWR1Pg0KPiAtLS0NCj4gZnMvY29uZmlnZnMvZGlyLmMgfCA0ICsrLS0NCj4gMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9mcy9jb25maWdmcy9kaXIuYyBiL2ZzL2NvbmZpZ2ZzL2Rpci5jDQo+IGluZGV4IGFjNWUw
YzBlOTE4MS4uOGY1ZDAzMDlmYjRhIDEwMDY0NA0KPiAtLS0gYS9mcy9jb25maWdmcy9kaXIuYw0K
PiArKysgYi9mcy9jb25maWdmcy9kaXIuYw0KPiBAQCAtNDUyLDcgKzQ1Miw3IEBAIHN0YXRpYyBz
dHJ1Y3QgZGVudHJ5ICogY29uZmlnZnNfbG9va3VwKHN0cnVjdCBpbm9kZSAqZGlyLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGZsYWdzKQ0KPiB7DQo+ICAgIHN0cnVjdCBj
b25maWdmc19kaXJlbnQgKiBwYXJlbnRfc2QgPSBkZW50cnktPmRfcGFyZW50LT5kX2ZzZGF0YTsN
Cj4gLSAgICBzdHJ1Y3QgY29uZmlnZnNfZGlyZW50ICogc2Q7DQo+ICsgICAgc3RydWN0IGNvbmZp
Z2ZzX2RpcmVudCAqc2QsICp0bXA7DQo+ICAgIGludCBmb3VuZCA9IDA7DQo+ICAgIGludCBlcnI7
DQo+IA0KPiBAQCAtNDY4LDcgKzQ2OCw3IEBAIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICogY29uZmln
ZnNfbG9va3VwKHN0cnVjdCBpbm9kZSAqZGlyLA0KPiAgICBpZiAoIWNvbmZpZ2ZzX2RpcmVudF9p
c19yZWFkeShwYXJlbnRfc2QpKQ0KPiAgICAgICAgZ290byBvdXQ7DQo+IA0KPiAtICAgIGxpc3Rf
Zm9yX2VhY2hfZW50cnkoc2QsICZwYXJlbnRfc2QtPnNfY2hpbGRyZW4sIHNfc2libGluZykgew0K
PiArICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShzZCwgdG1wLCAmcGFyZW50X3NkLT5zX2No
aWxkcmVuLCBzX3NpYmxpbmcpIHsNCj4gICAgICAgIGlmIChzZC0+c190eXBlICYgQ09ORklHRlNf
Tk9UX1BJTk5FRCkgew0KPiAgICAgICAgICAgIGNvbnN0IHVuc2lnbmVkIGNoYXIgKiBuYW1lID0g
Y29uZmlnZnNfZ2V0X25hbWUoc2QpOw0KPiANCj4gLS0gDQo+IDIuMTcuMQ0KPiANCg==
