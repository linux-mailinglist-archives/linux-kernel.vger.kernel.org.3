Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4363D527FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbiEPIc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiEPIcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:32:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65DE6E097
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:32:22 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-170-zoDI43liMzmQsfEc1mcSeQ-1; Mon, 16 May 2022 09:32:19 +0100
X-MC-Unique: zoDI43liMzmQsfEc1mcSeQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 16 May 2022 09:32:18 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 16 May 2022 09:32:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sami Tolvanen' <samitolvanen@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Thread-Topic: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Thread-Index: AQHYZwdlgt4N7xLw0EK8voqNmmoVIa0hK0vA
Date:   Mon, 16 May 2022 08:32:18 +0000
Message-ID: <f65c01979b884174965802a13cf6b077@AcuMS.aculab.com>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
In-Reply-To: <20220513202159.1550547-21-samitolvanen@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2FtaSBUb2x2YW5lbg0KPiBTZW50OiAxMyBNYXkgMjAyMiAyMToyMg0KPiANCj4gV2l0
aCBDT05GSUdfQ0ZJX0NMQU5HLCB0aGUgY29tcGlsZXIgaW5qZWN0cyBhIHR5cGUgcHJlYW1ibGUN
Cj4gaW1tZWRpYXRlbHkgYmVmb3JlIGVhY2ggZnVuY3Rpb24gYW5kIGEgY2hlY2sgdG8gdmFsaWRh
dGUgdGhlIHRhcmdldA0KPiBmdW5jdGlvbiB0eXBlIGJlZm9yZSBpbmRpcmVjdCBjYWxsczoNCj4g
DQo+ICAgOyB0eXBlIHByZWFtYmxlDQo+ICAgX19jZmlfZnVuY3Rpb246DQo+ICAgICBpbnQzDQo+
ICAgICBpbnQzDQo+ICAgICBtb3YgPGlkPiwgJWVheA0KDQpJbnRlcmVzdGluZyAtIHNpbmNlIHRo
aXMgY29kZSBjYW4ndCBiZSBleGVjdXRlZCB0aGVyZSBpcyBubw0KcG9pbnQgYWRkaW5nIGFuIGlu
c3RydWN0aW9uICdwcmVmaXgnIHRvIHRoZSAzMmJpdCBjb25zdGFudC4NCiANCj4gICAgIGludDMN
Cj4gICAgIGludDMNCj4gICBmdW5jdGlvbjoNCj4gICAgIC4uLg0KPiAgIDsgaW5kaXJlY3QgY2Fs
bCBjaGVjaw0KPiAgICAgY21wbMKgIMKgIDxpZD4sIC02KCVyMTEpDQo+ICAgICBqZSAgICAgIC5M
dG1wMQ0KPiAgICAgdWQyDQo+ICAgLkx0bXAxOg0KPiAgICAgY2FsbCAgICBfX3g4Nl9pbmRpcmVj
dF90aHVua19yMTENCj4gDQo+IERlZmluZSB0aGUgX19DRklfVFlQRSBoZWxwZXIgbWFjcm8gZm9y
IG1hbnVhbCB0eXBlIGFubm90YXRpb25zIGluDQo+IGFzc2VtYmx5IGNvZGUsIGFkZCBlcnJvciBo
YW5kbGluZyBmb3IgdGhlIENGSSB1ZDIgdHJhcHMsIGFuZCBhbGxvdw0KPiBDT05GSUdfQ0ZJX0NM
QU5HIHRvIGJlIHNlbGVjdGVkIG9uIHg4Nl82NC4NCj4gDQouLi4NCj4gKw0KPiArCS8qDQo+ICsJ
ICogVGhlIGNvbXBpbGVyIGdlbmVyYXRlcyB0aGUgZm9sbG93aW5nIGluc3RydWN0aW9uIHNlcXVl
bmNlDQo+ICsJICogZm9yIGluZGlyZWN0IGNhbGwgY2hlY2tzOg0KPiArCSAqDQo+ICsJICogwqAg
Y21wbMKgIMKgIDxpZD4sIC02KCVyZWcpCTsgNyBieXRlcw0KDQpJZiB0aGUgPGlkPiBpcyBiZXR3
ZWVuIC0xMjggYW5kIDEyNyB0aGVuIGFuIDhiaXQgY29uc3RhbnQNCihzaWduIGV4dGVuZGVkKSBt
aWdodCBiZSB1c2VkLg0KUG9zc2libHkgdGhlIGNvbXBpbGVyIGZvcmNlcyB0aGUgYXNzZW1ibGVy
IHRvIGdlbmVyYXRlIHRoZQ0KbG9uZyBmb3JtLg0KDQpUaGVyZSBjb3VsZCBhbHNvIGJlIGEgUkVY
IHByZWZpeC4NClRoYXQgd2lsbCBicmVhayBhbnkgY29kZSB0aGF0IHRyaWVzIHRvIHVzZSAlcmVn
Lg0KDQo+ICsJICogICBqZSAgICAgIC5MdG1wMQkJOyAyIGJ5dGVzDQo+ICsJICogICB1ZDIJCQk7
IDwtIGFkZHINCj4gKwkgKiAgIC5MdG1wMToNCj4gKwkgKg0KPiArCSAqIEJvdGggdGhlIHR5cGUg
YW5kIHRoZSB0YXJnZXQgYWRkcmVzcyBjYW4gYmUgZGVjb2RlZCBmcm9tIHRoZQ0KPiArCSAqIGNt
cGwgaW5zdHJ1Y3Rpb24uDQo+ICsJICovDQo+ICsJaWYgKGNvcHlfZnJvbV9rZXJuZWxfbm9mYXVs
dChidWZmZXIsICh2b2lkICopcmVncy0+aXAgLSA5LCBNQVhfSU5TTl9TSVpFKSkNCj4gKwkJcmV0
dXJuOw0KPiArCWlmIChpbnNuX2RlY29kZV9rZXJuZWwoJmluc24sIGJ1ZmZlcikpDQo+ICsJCXJl
dHVybjsNCj4gKwlpZiAoaW5zbi5vcGNvZGUudmFsdWUgIT0gMHg4MSB8fCBYODZfTU9EUk1fUkVH
KGluc24ubW9kcm0udmFsdWUpICE9IDcpDQo+ICsJCXJldHVybjsNCg0KU2luY2UgeW91IGFyZSBs
b29raW5nIGZvciBhIHZlcnkgc3BlY2lmaWMgb3Bjb2RlIHdoeSBib3RoZXINCmNhbGxpbmcgaW5z
bl9kZWNvZGVfa2VybmVsKCkgLSBqdXN0IGNoZWNrIGZvciB0aGUgcmVxdWlyZWQgKG1hc2tlZCkN
CmJ5dGUgdmFsdWVzLg0KDQo+ICsNCj4gKwkqdHlwZSA9IGluc24uaW1tZWRpYXRlLnZhbHVlOw0K
PiArDQo+ICsJb2Zmc2V0ID0gaW5zbl9nZXRfbW9kcm1fcm1fb2ZmKCZpbnNuLCByZWdzKTsNCg0K
R2l2ZW4gdGhlIGV4cGVjdGVkIGluc3RydWN0aW9uLCBpc24ndCB0aGF0IC02ID8/DQo+ICsJaWYg
KG9mZnNldCA8IDApDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCSp0YXJnZXQgPSAqKHVuc2lnbmVk
IGxvbmcgKikoKHZvaWQgKilyZWdzICsgb2Zmc2V0KTsNCg0KV1RGIGlzIHRoYXQgY2FsY3VsYXRp
bmc/Pw0KDQo+ICt9DQouLi4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

