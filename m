Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA704C450F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbiBYM6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiBYM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:58:10 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120077.outbound.protection.outlook.com [40.107.12.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDB3120EBE;
        Fri, 25 Feb 2022 04:57:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6k4jwNhGtSl6WtLYtWWgeeDWCnUoTQtIblmDyihBrULB6zDAME3zV61fpX8DxQW4GdX203ZgfxRIV617AkH7GObvM0rgoulderBq3uv+D9+Gsjkfcw2GeWPRUu38PW2tXT8mjL62py3jJ3Hnwp/ByM8mupj8/UZ/3NCBj2L+1J44K8SrLJXt3zq/7eM+2mmQWxCJERlqtMZ8GZ0atT27YHUmvv9UikPgMCnnngfRXmWmDcyXLznxo+CDkYN2rY+od3tD8gDTCd5vC2a8HppUPAUWTIUhsXgMt8qeAcrynt6MkNa+aTqG3wcyUzBvm0ULYKUQBRnxUpZ/cWwagGKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0m/9VvRV4y69b8Jx4wx7q9+oXS75Xe03KpSUN9mjxzk=;
 b=Xw+t3vBps1AUDhDnmP9cEP3GtRxWnfqgL526IYZ1en7dJ05EgUv18fESuNtgm18Dg6wO7Co8U0FOY8GOaLzVS2bupmP7yC+bNYvLHK1iW1nlhJwkfjrRuTTNAl/yGDhmSNMBOr37v/5bY2lvgArHQMqHqjcZNB0j5lunHMSiQVNhzys7ASTgtL7t0v4LlUVARn32iiao9O99F1lD3sCN0DamTU/w+ZI2Zpf9y4E1B+6lzLG6JSn1cfUtBs11XHaGQ8+aeJtxZEp+33ClxcyV81GfP/044piIMnksnF8Xt2CvikOcEmKa93y6AEaaqJ8C0UcqXgBF/TGC+lGkA+Xzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2540.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 12:57:34 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 12:57:34 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     Petr Mladek <pmladek@suse.com>, "cl@linux.com" <cl@linux.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v8 09/13] module: Move kallsyms support into a separate
 file
Thread-Topic: [PATCH v8 09/13] module: Move kallsyms support into a separate
 file
Thread-Index: AQHYJ/ZZRfC599+XvUO2sDt7Xl3WR6ykAICAgAADaYCAAA2CAIAAAy8AgAAgBwCAAAn0gA==
Date:   Fri, 25 Feb 2022 12:57:34 +0000
Message-ID: <aad10c3f-ecaf-c8fb-f1c6-81ba6f1c4f8d@csgroup.eu>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-10-atomlin@redhat.com> <YhieKf9EcS3GQSXG@alley>
 <f9449aa6-be9d-9021-66e7-fb0272909ee7@csgroup.eu> <YhisWkgZCK8dz5fl@alley>
 <CANfR36gsRw26C3M0hXGGK2w_05pC0rzkhg0-3Q+8tr_XxLiqiw@mail.gmail.com>
 <CANfR36iKJ6pHU5gm3HKqTPZ=FGsC5qX316UKt2sN0aMFEODA9w@mail.gmail.com>
In-Reply-To: <CANfR36iKJ6pHU5gm3HKqTPZ=FGsC5qX316UKt2sN0aMFEODA9w@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bba4c6ff-a8ad-4405-cd5d-08d9f85e647a
x-ms-traffictypediagnostic: MRZP264MB2540:EE_
x-microsoft-antispam-prvs: <MRZP264MB2540C4D4D6380F1B993FA2E9ED3E9@MRZP264MB2540.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfDJR6AGGXvwQSdjFLvKoo700f7ABiVI5s4lOnK8u6snHEb62T8Qem4IXUO/D6fxWn2mgvmqw+XxWV8UmB4FyAWqtU3PO9ZANQkMLMTtdrlDQTKxdD04TfSXkHfG/TJMpEY8689d0H8zmCgCgWIKvNjuuhSoIInKnSpZ1onLYGS55REzuEXqIQg3Pg8ite+DEZoHud8EGI0KhBic+7bJy8MMkCJxs/TkXgEO+J8CONdh+vdQF5nPdyHWQI7JjWPHB7HFNqpGW+kvTqq9yFLLj1seOh6cAV/dXus1kRXS+XxyTkjLVekLM+WzOkla3NQ9ZjzrkRYptdCMe28SsFScqHXLRPL9a3qSBag/lIyFCmDLoA/+vqyxgcpv4HE/q/uN38xaC0OjHwfr4ZysaI0odYK2W4IqQ9DqJQzBvvGxjOti8hqjPIf2HugvdH88+wS6cFtZNIHm/DB32VVlYswLbke2J8JkEae0vVzEoBFnzPSIE3EaxNMjr8H1IFHhUI1t3+jtxcdRnyAtdVw6fs9qwvO3VqW/p6MF33OIUMdbvKrJSLr20UHQZphmnp9aNtLZLSxQMYvGz/jJiDH1jdgCFkS/l7nKmrM1LGPC7qmnQE+hZm26ABqvWUIRoXLmB9+/qgca/D3EClApJ7igbFajiHAE9LqMVmfhmTitER4BLcqYXMB5lG73rc1CVGW8Fjmfu9Z6j6utYPEX4OwrlKo2mYjYw8GiDM79ti5AMDqjLFPwsp6XEJAGejIH86IlmCnqoPZHwcNMW/5TquElEg3JW7gzKagoUQLXszhHOqvrQC1KvsZ+8tQQU4u80DnZC5rsTB53JBvmImGeJ7GR1Y6UkdYYHply3Br+9xN/UcKvHhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(8936002)(44832011)(83380400001)(36756003)(6512007)(6506007)(7416002)(4326008)(5660300002)(86362001)(71200400001)(2616005)(66946007)(66556008)(66476007)(66446008)(8676002)(64756008)(76116006)(2906002)(26005)(186003)(31696002)(508600001)(91956017)(38070700005)(38100700002)(31686004)(66574015)(966005)(122000001)(110136005)(54906003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmxCalJScnZpREtlS21wNzhUdk9vOVNtbWUyWHpMM0NlczVqUGI0NDNnejJr?=
 =?utf-8?B?emZWWlU2TERaNVVnZHVVR0VHamNjc3BGQUJUUHZ4Z2hzc2dYNXU0R1gvaVJy?=
 =?utf-8?B?YmJidFZUYlpPVjlhMVdWL0h0NDVnL3FzMlA4QitxR2RQYjVyRUZWSzBmaWp2?=
 =?utf-8?B?Y0psMlNFcHczelhSdlQ3OEdVOHpWZ1JqaXU3YWNtcVg0NFJJNER3SHFBR3VX?=
 =?utf-8?B?ODdDaWxmM0owajZJd29XWWlHQmxGQk5zTk1YK3NXbk9hNGZlRjRVSzJVUzBQ?=
 =?utf-8?B?WDVDRkxqZTdSZ0lERXJ5Skp0T29NV3c0enlnTlppaFdUWU02VEVGS3NhYU9K?=
 =?utf-8?B?WkcwT2NtWjI3cU96andnNHUzSDJSNHRZZ283NStHMnNuWFlwOG1vWkR3Q2tP?=
 =?utf-8?B?bk1mbWhRZ0xWTzRZcEp2SkxoWUNvSEdFZ2pxRDdUeHhlVTlEUzhQczk2RUI1?=
 =?utf-8?B?Rlh3UmFtSWN3RkdOa2JBUTAvSEc5MkdaNFpvM2RhcWJFKzhxdDVvZWQxbStZ?=
 =?utf-8?B?RkJUTHBXNVJrd0M4b0N3YWJsdHQ5STU0K1VuZ0pubG5yc0JPUnllQWJsNXlE?=
 =?utf-8?B?ZHlDQ1ZxQWZ3NEZocGVGVFRuenBnd0QrSVROdElGUzBWNGpOMmIvRnF5MWlu?=
 =?utf-8?B?ZmgwMG9nelRaV1lvU3NrNmxaMkE1c1IwTmdHM01udXJpR1REdWczZTNjWmJw?=
 =?utf-8?B?WU5ORHZMNGZvOWNyNUFLQnQwdmpjcFVFUnN2SkdIUDBoTGM3aTY5SDJkb3hZ?=
 =?utf-8?B?VDFBZjg1d2ZVc29rcng3N01SOU44TnNkelpMK1pnTmczTnoxVXVxY1psaHNL?=
 =?utf-8?B?Tk5iWWMzMks5SzA4TzBlalhZd1E4NFNOQWtPZHl5c256WCtVVWRiSzRZZ2VM?=
 =?utf-8?B?MlViejN2NFkrT01STDNpc0d0ZUloWTJMOERFNVlWc1k4S3Z0cTFJUm43ZUgr?=
 =?utf-8?B?cmpxZzIyOU9LWi81RjZtOWdMRDJkUC9CUnBtQkI1RW1SdFhPdE42Rm5CUC9n?=
 =?utf-8?B?TnZGYTRLWkZSZE53Zmtab2JWZDVkck1oNWxGUG9PN1hCTHNueXZORFNNSVVl?=
 =?utf-8?B?OHdpZUJLN0txaVhPekZPWUdNdVFZM0xoUjlXa2E5UUx5YVFocWp5UHNXM3FR?=
 =?utf-8?B?b2xSYW95WnQ5MndMNWg4YWQ1cU9tNkQ3dkg5Rzg0RlNsbDFaVXlaeFRBaXhZ?=
 =?utf-8?B?VEdIN2k4cGM2VVMwZHF1WkVMRGx4NlBHWjM5emgwZ1VqQXY5MHZHa0QzMkUw?=
 =?utf-8?B?NjEzcXZiZ1BrV0dXMnduVmZjS0tNNHlTRzhaaTA5ajA4dHFLZ0VteWVvZkt3?=
 =?utf-8?B?VHgzb21JL21KYmtJcERmOWowR09DNGdzYk1SSG1RTmM1dGVKNnZobGpTeXJK?=
 =?utf-8?B?dWNuenFvbU00Ni9hSmlZcSsxQU9rSXYzMnJOUXBSWE1OdEdFc2VyTGVqOWpq?=
 =?utf-8?B?c1BDOFdoSG5WRmlkYVBBRWtjOG5FV2l0V0FHT2xscHVYd3hiU2srUVpDekJk?=
 =?utf-8?B?M25ZaWhKWEorckZsVTgxeUZoSGNLQnZDai8yZmRnSHovQ0ljcUgzZjRabXZ2?=
 =?utf-8?B?VnJqdzZlSHhjRmxyRGN3Y3FnSXp1WndRNGwwY2M1a0pwM2IxQUZpa0NOUk5l?=
 =?utf-8?B?NmJMRDJVVTN5LzBxamNuUWQ4YzlvR2JCYlV5bG5tOGNRYnV2bFZhcGUvYzBj?=
 =?utf-8?B?a1c1a1N0L09IQVRxVmppK1lLNHJwYXR4WUlOZ1hyRUhNRmhkcnRQTmRLQ1VW?=
 =?utf-8?B?YlRoaDdiM1JLQ2RFa1lhdzEyWTR2ZXBOcndkTVVaWkFYTXFpbGFONUp5RTdv?=
 =?utf-8?B?ZW0rbklmb3I2dzZHYVU2anhEbFlrNGRiNTJZVnN4dG5JZTJYMHRFRzZSTGZt?=
 =?utf-8?B?N01CbFUvZXhwYmRlM1lzTGxMOGU0TWVQaHIxN0dxZjBRRDQvVThKcytkbjNG?=
 =?utf-8?B?dGZQQ2hwdGJpKy84VmxCSFdCWlBTWEJjVDdDMHRTQzFoc3krcC9QeGZidk5o?=
 =?utf-8?B?VXQxbXhzV01GS0N2S0VHYjhKcFJWQy96Y1FNcFo2Z2hVOTd3LzVTNmt3anFP?=
 =?utf-8?B?VGhzQWt3VENHQnhYYnUvTzJNYWJ2L2pVQklROWNJa3VlQm1QQVFNcGZFcXpD?=
 =?utf-8?B?M09ISGVTRk1Zc2hZMVZ4UmtWZXNWb3lkSEtzK0t3dXdSdWdwTEZmTWwvRytP?=
 =?utf-8?B?NGZJNVd5bXNBQThlMWRBWURmZnFrVmtzZVFIcGZHY3VYem04Y2lxMjliU3Uv?=
 =?utf-8?Q?UYCq48z8wZIFFIPMwg1RTNWXki69xuze/IbEAOy0UA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5C28B541FDE1548B7147583893CC3E6@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bba4c6ff-a8ad-4405-cd5d-08d9f85e647a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 12:57:34.5551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6SHAsKFRufx3aqG7ZTU5kXEjqqcDzTAUBRNrX0n0VyE/LdXdgPC6uKUaM1x+kR2jUt/SJB0a8bRrqlNcKgb8ietplTMyYphif9Yrasd7b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2540
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI1LzAyLzIwMjIgw6AgMTM6MjEsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBP
biBGcmkgMjAyMi0wMi0yNSAxMDoyNyArMDAwMCwgQWFyb24gVG9tbGluIHdyb3RlOg0KPj4gT24g
RnJpIDIwMjItMDItMjUgMTE6MTUgKzAxMDAsIFBldHIgTWxhZGVrIHdyb3RlOg0KPj4+IHJjdV9k
ZXJlZmVyZW5jZV9zY2hlZCgpIG1ha2VzIHNwYXJzZSBoYXBweS4gQnV0IGxvY2tkZXAgY29tcGxh
aW5zDQo+Pj4gYmVjYXVzZSB0aGUgX3JjdSBwb2ludGVyIGlzIG5vdCBhY2Nlc3NlZCB1bmRlcjoN
Cj4+Pg0KPj4+ICAgICAgcmN1X3JlYWRfbG9ja19zY2hlZCgpOw0KPj4+ICAgICAgcmN1X3JlYWRf
dW5sb2NrX3NjaGVkKCk7DQo+Pg0KPj4gSGkgUGV0ciwNCj4+DQo+Pj4NCj4+PiBUaGlzIGlzIG5v
dCB0aGUgY2FzZSBoZXJlLiBOb3RlIHRoYXQgbW9kdWxlX211dGV4IGRvZXMgbm90DQo+Pj4gZGlz
YWJsZSBwcmVlbXRpb24uDQo+Pj4NCj4+PiBOb3csIHRoZSBjb2RlIGlzIHNhZmUuIFRoZSBSQ1Ug
YWNjZXNzIG1ha2VzIHN1cmUgdGhhdCAibW9kIg0KPj4+IGNhbid0IGJlIGZyZWVkIGluIHRoZSBt
ZWFudGltZToNCj4+Pg0KPj4+ICAgICArIGFkZF9rYWxsc3ltcygpIGlzIGNhbGxlZCBieSB0aGUg
bW9kdWxlIGxvYWRlZCB3aGVuIHRoZSBtb2R1bGUNCj4+PiAgICAgICBpcyBiZWluZyBsb2FkZWQu
IEl0IGNvdWxkIG5vdCBnZXQgcmVtb3ZlZCBpbiBwYXJhbGxlbA0KPj4+ICAgICAgIGJ5IGRlZmlu
aXRpb24uDQo+Pj4NCj4+PiAgICAgKyBtb2R1bGVfa2FsbHN5bXNfb25fZWFjaF9zeW1ib2woKSB0
YWtlcyBtb2R1bGVfbXV0ZXguDQo+Pj4gICAgICAgSXQgbWVhbnMgdGhhdCB0aGUgbW9kdWxlIGNv
dWxkIG5vdCBnZXQgcmVtb3ZlZC4NCj4+DQo+PiBJbmRlZWQsIHdoaWNoIGlzIHdoeSBJIGRpZCBu
b3QgdXNlIHJjdV9yZWFkX2xvY2tfc2NoZWQoKSBhbmQNCj4+IHJjdV9yZWFkX3VubG9ja19zY2hl
ZCgpIHdpdGggcmN1X2RlcmVmZXJlbmNlX3NjaGVkKCkuIFRoYXQgYmVpbmcgc2FpZCwgSQ0KPj4g
c2hvdWxkIGhhdmUgbWVudGlvbmVkIHRoaXMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPj4NCj4+
PiBJTUhPLCB3ZSBoYXZlIHR3byBwb3NzaWJpbGl0aWVzIGhlcmU6DQo+Pj4NCj4+PiAgICAgKyBN
YWtlIHNwYXJzZSBhbmQgbG9ja2RlcCBoYXBweSBieSB1c2luZyByY3VfZGVyZWZlcmVuY2Vfc2No
ZWQoKQ0KPj4+ICAgICAgIGFuZCBjYWxsaW5nIHRoZSBjb2RlIHVuZGVyIHJjdV9yZWFkX2xvY2tf
c2NoZWQoKS4NCj4+Pg0KPj4+ICAgICArIENhc3QgKHN0cnVjdCBtb2Rfa2FsbHN5bXMgKiltb2Qt
PmthbGxzeW1zIHdoZW4gYWNjZXNzaW5nDQo+Pj4gICAgICAgdGhlIHZhbHVlLg0KPj4NCj4+IEkg
cHJlZmVyIHRoZSBmaXJzdCBvcHRpb24uDQo+Pg0KPj4+IEkgZG8gbm90IGhhdmUgc3Ryb25nIHBy
ZWZlcmVuY2UuIEkgYW0gZmluZSB3aXRoIGJvdGguDQo+Pj4NCj4+PiBBbnl3YXksIHN1Y2ggYSBm
aXggc2hvdWxkIGJlIGRvbmUgaW4gYSBzZXBhcmF0ZSBwYXRjaCENCj4+DQo+PiBBZ3JlZWQuDQo+
IA0KPiBMdWlzLA0KPiANCj4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgaXQgbWlnaHQgYmUg
Y2xlYW5lciB0byByZXNvbHZlIHRoZSBhYm92ZSBpbiB0d28NCj4gc2VwYXJhdGUgcGF0Y2hlcyBm
b3IgYSB2OSBpLmUuIGEpIGFkZHJlc3MgdGhlIHNwYXJzZSBhbmQgbG9ja2RlcCBmZWVkYmFjaw0K
PiBhbmQgYikgcmVmYWN0b3IgdGhlIGNvZGUsIGJlZm9yZSB0aGUgbGF0ZXN0IHZlcnNpb24gWzFd
IGlzIG1lcmdlZCBpbnRvDQo+IG1vZHVsZS1uZXh0LiBJIGFzc3VtZSB0aGUgcHJldmlvdXMgaXRl
cmF0aW9uIHdpbGwgYmUgcmV2ZXJ0ZWQgZmlyc3Q/DQo+IA0KPiBQbGVhc2UgbGV0IG1lIGtub3cg
eW91ciB0aG91Z2h0cw0KPiANCj4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MjAyMjIxNDEzMDMuMTM5MjE5MC0xLWF0b21saW5AcmVkaGF0LmNvbS8NCj4gDQoNCkkgd291bGQg
ZG8gaXQgdGhlIG90aGVyIHdheTogZmlyc3QgbW92ZSB0aGUgY29kZSBpbnRvIGEgc2VwYXJhdGUg
ZmlsZSwgDQphbmQgdGhlbiBoYW5kbGUgdGhlIHNwYXJzZSBfX3JjdSBmZWVkYmFjayBhcyBhIGZv
bGxvd3VwIHBhdGNoIHRvIHRoZSBzZXJpZXMuDQoNClJlZ2FyZGluZyBtb2R1bGUtbmV4dCwgQUZB
SUNTIGF0IHRoZSBtb21lbnQgd2Ugc3RpbGwgaGF2ZSBvbmx5IHRoZSAxMCANCmZpcnN0IHBhdGNo
ZXMgb2YgdjYgaW4gdGhlIHRyZWUuIEkgZ3Vlc3MgdGhlIHdheSBmb3J3YXJkIHdpbGwgYmUgdG8g
DQpyZWJhc2UgbW9kdWxlLW5leHQgYW5kIGRyb3AgdGhvc2UgcGF0Y2hlcyBhbmQgY29tbWl0IHY5
IGluc3RlYWQuDQoNCkNocmlzdG9waGU=
