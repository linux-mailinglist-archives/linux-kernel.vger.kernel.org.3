Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8870F4E8C68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 05:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbiC1DDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 23:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiC1DDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:03:45 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859C0DEB0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 20:02:04 -0700 (PDT)
Received: from IT-EXMB-1-126.meizu.com (172.16.1.126) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 28 Mar
 2022 11:02:03 +0800
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by
 IT-EXMB-1-126.meizu.com (172.16.1.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 28 Mar 2022 11:02:02 +0800
Received: from IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575]) by
 IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575%3]) with mapi id
 15.01.2308.014; Mon, 28 Mar 2022 11:02:02 +0800
From:   =?gb2312?B?sNe6xs7E?= <baihaowen@meizu.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSB4ODYvbW06IERpcmVjdGx5IHJldHVybiBpbnN0ZWFk?=
 =?gb2312?Q?_of_using_local_ret_variable?=
Thread-Topic: [PATCH] x86/mm: Directly return instead of using local ret
 variable
Thread-Index: AQHYQklWC0wgfekFQ0emsDzmtoY3X6zTkiiAgACJiOM=
Date:   Mon, 28 Mar 2022 03:02:02 +0000
Message-ID: <b1f92ed707eb469aa626fe0be03eaf96@meizu.com>
References: <1648433573-25735-1-git-send-email-baihaowen@meizu.com>,<347c75b8-3a48-0758-892a-0d0ac139f740@intel.com>
In-Reply-To: <347c75b8-3a48-0758-892a-0d0ac139f740@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.137.70]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciBwb2ludGluZyBteSBtaXN0YWtlbi4NCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCreivP7IyzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGlu
dGVsLmNvbT4NCreiy83KsbzkOiAyMDIyxOoz1MIyOMjVIDEwOjQ5OjE5DQrK1bz+yMs6ILDXusbO
xDsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyBsdXRvQGtlcm5lbC5vcmc7IHBldGVyekBp
bmZyYWRlYWQub3JnDQqzrcvNOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrW98ziOiBS
ZTogW1BBVENIXSB4ODYvbW06IERpcmVjdGx5IHJldHVybiBpbnN0ZWFkIG9mIHVzaW5nIGxvY2Fs
IHJldCB2YXJpYWJsZQ0KDQpPbiAzLzI3LzIyIDE5OjEyLCBIYW93ZW4gQmFpIHdyb3RlOg0KPg0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vcGZfaW4uYyBiL2FyY2gveDg2L21tL3BmX2luLmMN
Cj4gaW5kZXggM2Y4M2UzMS4uNGVmZjNlZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvbW0vcGZf
aW4uYw0KPiArKysgYi9hcmNoL3g4Ni9tbS9wZl9pbi5jDQo+IEBAIC0xMzAsNyArMTMwLDYgQEAg
ZW51bSByZWFzb25fdHlwZSBnZXRfaW5zX3R5cGUodW5zaWduZWQgbG9uZyBpbnNfYWRkcikNCj4g
ICAgICAgdW5zaWduZWQgY2hhciAqcDsNCj4gICAgICAgc3RydWN0IHByZWZpeF9iaXRzIHByZjsN
Cj4gICAgICAgaW50IGk7DQo+IC0gICAgIGVudW0gcmVhc29uX3R5cGUgcnYgPSBPVEhFUlM7DQo+
DQo+ICAgICAgIHAgPSAodW5zaWduZWQgY2hhciAqKWluc19hZGRyOw0KPiAgICAgICBwICs9IHNr
aXBfcHJlZml4KHAsICZwcmYpOw0KPiBAQCAtMTQxLDcgKzE0MCw3IEBAIGVudW0gcmVhc29uX3R5
cGUgZ2V0X2luc190eXBlKHVuc2lnbmVkIGxvbmcgaW5zX2FkZHIpDQo+ICAgICAgIENIRUNLX09Q
X1RZUEUob3Bjb2RlLCBpbW1fd29wLCBJTU1fV1JJVEUpOw0KPg0KPiAgZXhpdDoNCj4gLSAgICAg
cmV0dXJuIHJ2Ow0KPiArICAgICByZXR1cm4gT1RIRVJTOw0KPiAgfQ0KPiAgI3VuZGVmIENIRUNL
X09QX1RZUEUNCj4NCg0KRG9lcyB0aGlzIGV2ZW4gY29tcGlsZT8gIFRha2UgYSBsb29rIGF0IHRo
aXMgbWFjcm86DQoNCj4gI2RlZmluZSBDSEVDS19PUF9UWVBFKG9wY29kZSwgYXJyYXksIHR5cGUp
IFwNCj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShhcnJheSk7IGkrKykgeyBc
DQo+ICAgICAgICAgICAgICAgICBpZiAoYXJyYXlbaV0gPT0gb3Bjb2RlKSB7IFwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgcnYgPSB0eXBlOyBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IGdvdG8gZXhpdDsgXA0KPiAgICAgICAgICAgICAgICAgfSBcDQoNCkl0IHVzZXMgJ3J2Jy4NCg0K
