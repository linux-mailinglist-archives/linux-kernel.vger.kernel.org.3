Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3BC544319
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbiFIFYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbiFIFYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:24:30 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2048.outbound.protection.outlook.com [40.107.113.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEFB340D1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbTPcU20++E1IU37ODwgFAbK2I/A7nnQKKhphHK+H/GT+J6kKfvoUyJzpaE/a3aocTLmQD02kzRDo5RB9+96Frwn5cF27ywGVIraSWCgRQ2VUidp8XwlxMbEuvPxgKc81cmFo5WdgT0T1ae0S5jBnpR3p7bi6hEf5ZzTW6ftUpsubyE6N+8lScsV+TVkF1ybeKL/kz1cJT49nQ0XQzF8T7ybERrSMDXaXHg8mOot73S22AOoywB0klTn5/WfIbjeSy2USeQR6r6CQcSS5eGCTg0qPbiAx5XUN5pR7KgDb2tqlo6ycB3qzu+bx9WEPpuRSCDAc9C/XawiexQF/3xGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9YuISLOWovl898xZxAQGDuglR3JPe86XDRQqowcEmI=;
 b=NlFyIS+PUhuiiGAAY8yOOLf9Y15hY0jwPObw884kFo1H7ip++X4Y9b2OMcAyEtY6NCw1UjzuON/Rr06e2V6eS7mkcHspFVs5NvGc8icfeIhNbXS6vaGPd2JEkYgw+RR4PN74dOXg/RxMtu5d4VcZsDdxEb+UsPqcxyUnR+Ig1JvCQnRDyIqCuvLfC5AarUhwrAM0zZQPUJ12ynLHsTKmbLuFGOtn3afI9YLkRT71LYE2SIdV1fVFSX85QJMNp0lY3M5hJQt3GHyV4cF/UX0tslKYobrUOBfCbOayhqvszZwE1BdGMC6qsOfDDtKm6gYPi6xcLY3jIgieZL+ltAA6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9YuISLOWovl898xZxAQGDuglR3JPe86XDRQqowcEmI=;
 b=cVyuQGgv3Cbies0xPjmVWWIB9HCUOdfOyYI1KmOnDjmmopih4vYdv+nTesP7Hmdmg5w+Mjps7VIagrebKb0+gQ3rrGPVT/S/FALTLid+GwrR+KOGd+Oyhh0sHRN4Ffyz6n2J6OEYBusk6hmIaBItXm0NV8xasZurNRaE/WdDBz8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB2801.jpnprd01.prod.outlook.com (2603:1096:603:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 05:24:22 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5314.020; Thu, 9 Jun 2022
 05:24:22 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Guan Jing <guanjing6@huawei.com>
CC:     "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSCAtbmV4dF0gbW3vvJpmaXggYnVpbGQgZXJyb3Igb2YgZGVm?=
 =?utf-8?Q?ined_but_not_used?=
Thread-Topic: =?utf-8?B?W1BBVENIIC1uZXh0XSBtbe+8mmZpeCBidWlsZCBlcnJvciBvZiBkZWZpbmVk?=
 =?utf-8?Q?_but_not_used?=
Thread-Index: AQHYe74m6SrkPmuygk+d++c0bi73Ra1GitsA
Date:   Thu, 9 Jun 2022 05:24:22 +0000
Message-ID: <20220609052420.GA1452839@hori.linux.bs1.fc.nec.co.jp>
References: <20220609050028.28645-1-guanjing6@huawei.com>
In-Reply-To: <20220609050028.28645-1-guanjing6@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d073d4b-b0bb-4a59-0f2d-08da49d84f7b
x-ms-traffictypediagnostic: OSAPR01MB2801:EE_
x-microsoft-antispam-prvs: <OSAPR01MB28014CCFD01EC5440B31D9FEE7A79@OSAPR01MB2801.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PVu4JBIQnxlIFHk9px7THZ4gTf1SObh5zy4VIqhVoU94PBwjXWmQlL+k8McP9WHzoeHv36OWGEEk1q43HNXJDkTzijuHZiFJv2rxub5uqMu3VACjAItpzJVwrP1Gt1MA7TrpHJ2+2SVZgj/lHqF6n/Lbo/ymuEsxXKqfhperQRhj30SfC1fEX1ZLVzSVzefLQvIfTuvyQjlcD7SCReIne515fM2vX1UVXPphGFVCoWoFd6ItP+HpkXymgzt6MsmUtpQBal5mk6eMyHYdDnCha1VsWzG100Hk45gw5llikhbEvHhuU6GXsIuMZO4OnyF0oMtdwRb5oQ9midgsEYqIxBpwwg02FlEpjunFueCfVsb0A7pIo5kQnpDs7jUI4JPIk/kxVBEZNvBhrLxtGsOk2oX3OXnpP3WWdEf1Y/MUEFXWDMotFvEDDwnrKgEMWWnKaF+z7e9jrIW76OwBsgrFJv1g4xikCxljIFDFhihUu/4KN0Rrs2S/dJ5ud08ShfjZg5IHDUiNStiEWEppGqbmcVFh1eJdzIKP3T0ZLJgx3hdVpm+NYK1gWaib4J6vllPspaz//FVazqF0OHqPiCR0+jWVJDMMWg7bZYeJOXNuVtxQ+1EDtZ0rr1J0XpU3uqhBm36wLaQhidWQKYK0Soy7YFRDBO8UhdHEK+1i/1LzrqH15a57vPr3abIIEx1jSbtlYFaEQT0aADVLcszLSsgwNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6506007)(83380400001)(26005)(9686003)(6512007)(38100700002)(55236004)(122000001)(82960400001)(508600001)(6486002)(38070700005)(71200400001)(85182001)(316002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(8936002)(5660300002)(6916009)(86362001)(1076003)(33656002)(2906002)(54906003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmpUWlh0WURMRGNLc0J5UnYrdFdLdUt3eWtOemRIY1ZadFZPc0ZjS3FhRitq?=
 =?utf-8?B?WEtYUUZqT3JhT1pGckZ1QUFJdlJYeW0xYTNXL2VnR3FQRndrelp4RTBkYkpu?=
 =?utf-8?B?dGtlemlCTDBoYzZ1WkY5S2cxMEluNTA1ZkFXRmo3VENBcFlvcU1vT0locSsx?=
 =?utf-8?B?cDBpZUlrRUJCM0x3cVd5d05BVWsyYnZadXNBRUxKZ09RZGRYWUZhRmtMVTlu?=
 =?utf-8?B?WHIwZy9hTDcrMlpZc2VFeHNQUThGL0ZZOHYySFowMGZzL21oUVU2dHkrcTRT?=
 =?utf-8?B?YjhGc2RkU3pSZldta0tUUmltVkdNeit5elluaE1RSTN6K3lZbmZDZXZNZVFy?=
 =?utf-8?B?VUY1VWhDQTNUS1AzQnl2dlhFZlRUNnNFU2djSERoWHNuTTFBLzRTOTBpWUYr?=
 =?utf-8?B?YjlvbWtLNmw0UEhPN3BJdk9iVUhhWTJoMGh0UFl3RjhwcjZKUGhyQTRkNWVN?=
 =?utf-8?B?N3hYTUhaRFlxejJoU1o2Ymx0OXEvK2FWeHN2WVBpRWZjcmJIcXhvT01ONmUv?=
 =?utf-8?B?c1VpRklyLy8rWE4vSDRKSTJOaUJMUzJVUE9kWjlSUHpXK1p3dk5oNWNsMVVw?=
 =?utf-8?B?WDcyaGVGUWdiUzVBeUdjNFZHWjBIcmpaWXNWWUhIdCthZlplVVpuMVhtbklI?=
 =?utf-8?B?MnRIUlhDeEF2SU91U1pqQm0wbUExUkxIeVZqNlp4MzVpV1VBSWcvbXR6Tmhy?=
 =?utf-8?B?RXdpK292QXRKM0FMbFlIOXMvblUwSXErRkNSZytGMHV2cURsak1qYjJrcDJu?=
 =?utf-8?B?dmhia0lvUEpnTEZSV0N5TmVka3JtblBiN2FNYnVxOGQyS1VoU1JRTnI4Nk9B?=
 =?utf-8?B?Y1ZxRVNLNklrRmh2eU51bXdmV2dXVDBtTmk1amNBY2JIazJvamdBUzhjTHM3?=
 =?utf-8?B?WXUzTml6Um16c0d0elh3SkVBQzFqanJzQ2VtNFZwTTF6QnRCeWFmWnFKOE1m?=
 =?utf-8?B?S3RyZnBFb1pvYzFGS0pIcnM2TjRoaDJiVnhNRlNpaVIxb3VaNVVOaUNud1ZU?=
 =?utf-8?B?Smloc1czbUNKZ1E2cklXcHg1d2Iyc3dWZnhPMlVieFdCL0tKaXpZSG9waUw3?=
 =?utf-8?B?VUZoa01ybU5EWXVXVmVmTlptOFljckVZVFE0SW1VWEJFeWhqbEpIOFRnWWlH?=
 =?utf-8?B?U0hJT2l2a1Y2UnpudUpTc0MvTFRLMTNUTk90Q3l1ak5RejFrSmZVVWQ5YU15?=
 =?utf-8?B?djVyYmlBNzl5eUsxcmcwZHFUVUhTY2E1ekkwMDUydy95YnByVk5NV2g2dGZW?=
 =?utf-8?B?YzNhZktQQ1NJR1VXeXlzdmdSQzRZdlY5SDdPcjJnNnZrbHpDNVY5by9VYXlv?=
 =?utf-8?B?NXVlU3ZqNk0vc0NVYkZVR281alV6K0thWnJUMlZVOGdEYWNDbVZDQkNxazZS?=
 =?utf-8?B?bWI4alh5eTF2N2VzdE5YNUNZSUwzNzBTQllITlNobndxaXFXSmxzMXQ3S3Qx?=
 =?utf-8?B?QnRJaFgydis4RjVHNUFCVmNhSStpaWxJamxvTnhTOWRGUFprWGhmUG5zb0lI?=
 =?utf-8?B?Nm1UMWhKamNWM3ZTS3c1eGtCd1MvZkxqSG9uNlZTOXJKZGRCaFpnbEdoQVp0?=
 =?utf-8?B?ZU9RcERmVkhuUmpXLzlmbndURmFqanlTMWNJVDdKQ0JST0FKTUEvdDZSVXZy?=
 =?utf-8?B?ODdWM05zU25QTFhxSmJRME11c2kvMSt0ZGxHT0RCcEtNUHVTNkRhbGtCSHpp?=
 =?utf-8?B?WWYzWENSTHg5eFJJbWRtL2loZkpqUEpDd2VxdzJNWW9WZzBhNnN6M2pJcjd3?=
 =?utf-8?B?WG1XVGJyUGRxQ0hzRDF1MXZWTi9INDM3Y1llamNQQ21GdnFDZWJLdFVKMUJY?=
 =?utf-8?B?aklpU3ZSVENRODYvYzZzM2trK294djl4bnRDMEUyZXUrbkRxMlNTOTBnV0N3?=
 =?utf-8?B?bGwwWXRlaW5KRUQwcDllNW9udWpRYTVnY2tySDZ5TXFUU2kyMW1sdnVmMXhZ?=
 =?utf-8?B?YmZ3ZS9WSE1SRGIzT3MwZVRBeHRyd3hZWk1WZ3R4VEc2Y1VVT0pjYjE4OWor?=
 =?utf-8?B?UXo3ck13a0N4RE1vTVRYcWY0dnk0WFJwaVpYOGw1N1pZYkdjY05LWGRFMjN6?=
 =?utf-8?B?bFF1NWZmQm1BbEZVQ2VJaHlFeVliUGl1MnVobjZUbUo1bkhRRTBQS0R1bGR3?=
 =?utf-8?B?ZUlNSVFQNVppQ2tTemU1dWRGKzJQN1h6K2FpRjJuelpLS1pBNTRkV1pNZXF3?=
 =?utf-8?B?Mndhd0w3RmI5Rk0zRTBhN0NIS2VDcEJ2djlSMG43Vk1TR2hjTStDQ1FnYzYy?=
 =?utf-8?B?dEtBMzA3aFJDNXkrTWRuUncvSVhlSmg0V1c2MmRjcjRxTTNYaU5RY21zTkdY?=
 =?utf-8?B?NmlOUEZUWjNzL0FHajJaNElCVU8vSkdSbm5GU05pd3g0dEJBN0l2Wm5lQlda?=
 =?utf-8?Q?7QjKbIfVq2LSBMtE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C260F3A085A6347880CF4994452C8A8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d073d4b-b0bb-4a59-0f2d-08da49d84f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 05:24:22.1418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46kNvQ7mIDvFNyndurmygcZ6lXPipLgV/uMYgH0DzapsXgPLyFT5biq6krhPEeQKZt1qiylqhevmDBFSBOir5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2801
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdW4gMDksIDIwMjIgYXQgMDE6MDA6MjhQTSArMDgwMCwgR3VhbiBKaW5nIHdyb3Rl
Og0KPiBJZiBDT05GSUdfSFVHRVRMQl9QQUdFIGlzIG5vdCBzZXQgYW5kIENPTkZJR19GU19EQVg9
eS4NCj4gVXNlIGNvbW1hbmQgIm1ha2UgQVJDSD1hcm02NCBDUk9TU19DT01QSUxFPWFhcmNoNjQt
bGludXgtZ251LSIgdG8NCj4gYnVpbGQsIHdpbGwgZmFpbDoNCj4gDQo+IG1tL21lbW9yeS1mYWls
dXJlLmM6NTY4OjEzOiBlcnJvcjog4oCYY29sbGVjdF9wcm9jc19mc2RheOKAmSBkZWZpbmVkDQo+
IGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtZnVuY3Rpb25dDQo+IAlzdGF0aWMgdm9pZCBj
b2xsZWN0X3Byb2NzX2ZzZGF4KHN0cnVjdCBwYWdlICpwYWdlLA0KPiAgICAgICAgICAgICAgXn5+
fn5+fn5+fn5+fn5+fn5+fg0KPiBjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVy
cm9ycw0KPiBtYWtlWzFdOiAqKiogW21tL21lbW9yeS1mYWlsdXJlLm9dIEVycm9yIDENCj4gbWFr
ZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCj4gbWFrZTogKioqIFtt
bV0gRXJyb3IgMg0KPiBtYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0K
PiANCj4gc28gZXh0ZW5kaW5nICIjaWZkZWYgQ09ORklHX0hVR0VUTEJfUEFHIiB0byBjb3Zlcg0K
PiBjb2xsZWN0X3Byb2NzX2ZzZGF4KCkgd291bGQgYmUgYSBzaW1wbGUgcmVzb2x1dGlvbi4NCg0K
VGhhbmsgeW91IGZvciByZXBvcnRpbmcuIEkgdGhpbmsgdGhhdCBjb2xsZWN0X3Byb2NzX2ZzZGF4
KCkgc2VlbXMgdG8gbm90DQpkZXBlbmQgb24gaHVnZXRsYiwgc28gcHJvYmFibHkgbWZfZGF4X2tp
bGxfcHJvY3MoKSBzaG91bGQgYmUgZGVmaW5lZCBvdXRzaWRlDQoiI2lmZGVmIENPTkZJR19IVUdF
VExCX1BBR0UiPw0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGkNCg0KPiANCj4gUmVwb3J0ZWQt
Ynk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPg0KPiBGaXhlczogMTQzYWM1Y2Q3Mjg5
ICgibW06IGludHJvZHVjZSBtZl9kYXhfa2lsbF9wcm9jcygpIGZvciBmc2RheCBjYXNlIikNCj4g
U2lnbmVkLW9mZi1ieTogR3VhbiBKaW5nIDxndWFuamluZzZAaHVhd2VpLmNvbT4NCj4gLS0tDQo+
ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgNTYgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMjgg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21t
L21lbW9yeS1mYWlsdXJlLmMNCj4gaW5kZXggNTQ1ZjQwMmM0ODkwLi45NTJmMTE3ZTQ1ODQgMTAw
NjQ0DQo+IC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1
cmUuYw0KPiBAQCAtNTYxLDM0ICs1NjEsNiBAQCBzdGF0aWMgdm9pZCBjb2xsZWN0X3Byb2NzX2Zp
bGUoc3RydWN0IHBhZ2UgKnBhZ2UsIHN0cnVjdCBsaXN0X2hlYWQgKnRvX2tpbGwsDQo+ICAJaV9t
bWFwX3VubG9ja19yZWFkKG1hcHBpbmcpOw0KPiAgfQ0KPiAgDQo+IC0jaWZkZWYgQ09ORklHX0ZT
X0RBWA0KPiAtLyoNCj4gLSAqIENvbGxlY3QgcHJvY2Vzc2VzIHdoZW4gdGhlIGVycm9yIGhpdCBh
IGZzZGF4IHBhZ2UuDQo+IC0gKi8NCj4gLXN0YXRpYyB2b2lkIGNvbGxlY3RfcHJvY3NfZnNkYXgo
c3RydWN0IHBhZ2UgKnBhZ2UsDQo+IC0JCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBw
Z29mZl90IHBnb2ZmLA0KPiAtCQlzdHJ1Y3QgbGlzdF9oZWFkICp0b19raWxsKQ0KPiAtew0KPiAt
CXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hOw0KPiAtCXN0cnVjdCB0YXNrX3N0cnVjdCAqdHNr
Ow0KPiAtDQo+IC0JaV9tbWFwX2xvY2tfcmVhZChtYXBwaW5nKTsNCj4gLQlyZWFkX2xvY2soJnRh
c2tsaXN0X2xvY2spOw0KPiAtCWZvcl9lYWNoX3Byb2Nlc3ModHNrKSB7DQo+IC0JCXN0cnVjdCB0
YXNrX3N0cnVjdCAqdCA9IHRhc2tfZWFybHlfa2lsbCh0c2ssIHRydWUpOw0KPiAtDQo+IC0JCWlm
ICghdCkNCj4gLQkJCWNvbnRpbnVlOw0KPiAtCQl2bWFfaW50ZXJ2YWxfdHJlZV9mb3JlYWNoKHZt
YSwgJm1hcHBpbmctPmlfbW1hcCwgcGdvZmYsIHBnb2ZmKSB7DQo+IC0JCQlpZiAodm1hLT52bV9t
bSA9PSB0LT5tbSkNCj4gLQkJCQlhZGRfdG9fa2lsbCh0LCBwYWdlLCBwZ29mZiwgdm1hLCB0b19r
aWxsKTsNCj4gLQkJfQ0KPiAtCX0NCj4gLQlyZWFkX3VubG9jaygmdGFza2xpc3RfbG9jayk7DQo+
IC0JaV9tbWFwX3VubG9ja19yZWFkKG1hcHBpbmcpOw0KPiAtfQ0KPiAtI2VuZGlmIC8qIENPTkZJ
R19GU19EQVggKi8NCj4gLQ0KPiAgLyoNCj4gICAqIENvbGxlY3QgdGhlIHByb2Nlc3NlcyB3aG8g
aGF2ZSB0aGUgY29ycnVwdGVkIHBhZ2UgbWFwcGVkIHRvIGtpbGwuDQo+ICAgKi8NCj4gQEAgLTE1
NDAsNiArMTUxMiwzNCBAQCBzdGF0aWMgaW50IHRyeV90b19zcGxpdF90aHBfcGFnZShzdHJ1Y3Qg
cGFnZSAqcGFnZSwgY29uc3QgY2hhciAqbXNnKQ0KPiAgfQ0KPiAgDQo+ICAjaWZkZWYgQ09ORklH
X0hVR0VUTEJfUEFHRQ0KPiArI2lmZGVmIENPTkZJR19GU19EQVgNCj4gKy8qDQo+ICsgKiBDb2xs
ZWN0IHByb2Nlc3NlcyB3aGVuIHRoZSBlcnJvciBoaXQgYSBmc2RheCBwYWdlLg0KPiArICovDQo+
ICtzdGF0aWMgdm9pZCBjb2xsZWN0X3Byb2NzX2ZzZGF4KHN0cnVjdCBwYWdlICpwYWdlLA0KPiAr
CQlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywgcGdvZmZfdCBwZ29mZiwNCj4gKwkJc3Ry
dWN0IGxpc3RfaGVhZCAqdG9fa2lsbCkNCj4gK3sNCj4gKwlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYTsNCj4gKwlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzazsNCj4gKw0KPiArCWlfbW1hcF9sb2Nr
X3JlYWQobWFwcGluZyk7DQo+ICsJcmVhZF9sb2NrKCZ0YXNrbGlzdF9sb2NrKTsNCj4gKwlmb3Jf
ZWFjaF9wcm9jZXNzKHRzaykgew0KPiArCQlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQgPSB0YXNrX2Vh
cmx5X2tpbGwodHNrLCB0cnVlKTsNCj4gKw0KPiArCQlpZiAoIXQpDQo+ICsJCQljb250aW51ZTsN
Cj4gKwkJdm1hX2ludGVydmFsX3RyZWVfZm9yZWFjaCh2bWEsICZtYXBwaW5nLT5pX21tYXAsIHBn
b2ZmLCBwZ29mZikgew0KPiArCQkJaWYgKHZtYS0+dm1fbW0gPT0gdC0+bW0pDQo+ICsJCQkJYWRk
X3RvX2tpbGwodCwgcGFnZSwgcGdvZmYsIHZtYSwgdG9fa2lsbCk7DQo+ICsJCX0NCj4gKwl9DQo+
ICsJcmVhZF91bmxvY2soJnRhc2tsaXN0X2xvY2spOw0KPiArCWlfbW1hcF91bmxvY2tfcmVhZCht
YXBwaW5nKTsNCj4gK30NCj4gKyNlbmRpZiAvKiBDT05GSUdfRlNfREFYICovDQo+ICsNCj4gIC8q
DQo+ICAgKiBDYWxsZWQgZnJvbSBodWdldGxiIGNvZGUgd2l0aCBodWdldGxiX2xvY2sgaGVsZC4N
Cj4gICAqDQo+IC0tIA0KPiAyLjE3LjE=
