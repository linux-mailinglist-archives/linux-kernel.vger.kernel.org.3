Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2505292E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347113AbiEPVdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiEPVdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:33:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E8183FDBB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:32:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-258-XPGIMpHAPt6Ggx_0Nc-b8Q-1; Mon, 16 May 2022 22:32:56 +0100
X-MC-Unique: XPGIMpHAPt6Ggx_0Nc-b8Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 16 May 2022 22:32:55 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 16 May 2022 22:32:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sami Tolvanen' <samitolvanen@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Thread-Topic: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Thread-Index: AQHYZwdlgt4N7xLw0EK8voqNmmoVIa0hK0vAgAB8yACAAF6CUA==
Date:   Mon, 16 May 2022 21:32:55 +0000
Message-ID: <19b3e040302d4d8aa240eee43427dfaa@AcuMS.aculab.com>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <f65c01979b884174965802a13cf6b077@AcuMS.aculab.com>
 <CABCJKueo+cw1DHH6N2dUjD-U7OKqmkJUyimm0ychv1drt5U9Rg@mail.gmail.com>
In-Reply-To: <CABCJKueo+cw1DHH6N2dUjD-U7OKqmkJUyimm0ychv1drt5U9Rg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2FtaSBUb2x2YW5lbg0KPiBTZW50OiAxNiBNYXkgMjAyMiAxNzozOQ0KPiANCj4gT24g
TW9uLCBNYXkgMTYsIDIwMjIgYXQgMTozMiBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFNhbWkgVG9sdmFuZW4NCj4gPiA+IFNl
bnQ6IDEzIE1heSAyMDIyIDIxOjIyDQo+ID4gPg0KPiA+ID4gV2l0aCBDT05GSUdfQ0ZJX0NMQU5H
LCB0aGUgY29tcGlsZXIgaW5qZWN0cyBhIHR5cGUgcHJlYW1ibGUNCj4gPiA+IGltbWVkaWF0ZWx5
IGJlZm9yZSBlYWNoIGZ1bmN0aW9uIGFuZCBhIGNoZWNrIHRvIHZhbGlkYXRlIHRoZSB0YXJnZXQN
Cj4gPiA+IGZ1bmN0aW9uIHR5cGUgYmVmb3JlIGluZGlyZWN0IGNhbGxzOg0KPiA+ID4NCj4gPiA+
ICAgOyB0eXBlIHByZWFtYmxlDQo+ID4gPiAgIF9fY2ZpX2Z1bmN0aW9uOg0KPiA+ID4gICAgIGlu
dDMNCj4gPiA+ICAgICBpbnQzDQo+ID4gPiAgICAgbW92IDxpZD4sICVlYXgNCj4gPg0KPiA+IElu
dGVyZXN0aW5nIC0gc2luY2UgdGhpcyBjb2RlIGNhbid0IGJlIGV4ZWN1dGVkIHRoZXJlIGlzIG5v
DQo+ID4gcG9pbnQgYWRkaW5nIGFuIGluc3RydWN0aW9uICdwcmVmaXgnIHRvIHRoZSAzMmJpdCBj
b25zdGFudC4NCj4gDQo+IFRoZSByZWFzb24gdG8gZW1iZWQgdGhlIHR5cGUgaW50byBhbiBpbnN0
cnVjdGlvbiBpcyB0byBhdm9pZCB0aGUgbmVlZA0KPiB0byBzcGVjaWFsIGNhc2Ugb2JqdG9vbCdz
IGluc3RydWN0aW9uIGRlY29kZXIuDQo+IA0KPiA+ID4gICAgIGludDMNCj4gPiA+ICAgICBpbnQz
DQo+ID4gPiAgIGZ1bmN0aW9uOg0KPiA+ID4gICAgIC4uLg0KPiA+ID4gICA7IGluZGlyZWN0IGNh
bGwgY2hlY2sNCj4gPiA+ICAgICBjbXBsICAgIDxpZD4sIC02KCVyMTEpDQo+ID4gPiAgICAgamUg
ICAgICAuTHRtcDENCj4gPiA+ICAgICB1ZDINCj4gPiA+ICAgLkx0bXAxOg0KPiA+ID4gICAgIGNh
bGwgICAgX194ODZfaW5kaXJlY3RfdGh1bmtfcjExDQo+ID4gPg0KPiA+ID4gRGVmaW5lIHRoZSBf
X0NGSV9UWVBFIGhlbHBlciBtYWNybyBmb3IgbWFudWFsIHR5cGUgYW5ub3RhdGlvbnMgaW4NCj4g
PiA+IGFzc2VtYmx5IGNvZGUsIGFkZCBlcnJvciBoYW5kbGluZyBmb3IgdGhlIENGSSB1ZDIgdHJh
cHMsIGFuZCBhbGxvdw0KPiA+ID4gQ09ORklHX0NGSV9DTEFORyB0byBiZSBzZWxlY3RlZCBvbiB4
ODZfNjQuDQo+ID4gPg0KPiA+IC4uLg0KPiA+ID4gKw0KPiA+ID4gKyAgICAgLyoNCj4gPiA+ICsg
ICAgICAqIFRoZSBjb21waWxlciBnZW5lcmF0ZXMgdGhlIGZvbGxvd2luZyBpbnN0cnVjdGlvbiBz
ZXF1ZW5jZQ0KPiA+ID4gKyAgICAgICogZm9yIGluZGlyZWN0IGNhbGwgY2hlY2tzOg0KPiA+ID4g
KyAgICAgICoNCj4gPiA+ICsgICAgICAqICAgY21wbCAgICA8aWQ+LCAtNiglcmVnKSAgICAgOyA3
IGJ5dGVzDQo+ID4NCj4gPiBJZiB0aGUgPGlkPiBpcyBiZXR3ZWVuIC0xMjggYW5kIDEyNyB0aGVu
IGFuIDhiaXQgY29uc3RhbnQNCj4gPiAoc2lnbiBleHRlbmRlZCkgbWlnaHQgYmUgdXNlZC4NCj4g
PiBQb3NzaWJseSB0aGUgY29tcGlsZXIgZm9yY2VzIHRoZSBhc3NlbWJsZXIgdG8gZ2VuZXJhdGUg
dGhlDQo+ID4gbG9uZyBmb3JtLg0KPiA+DQo+ID4gVGhlcmUgY291bGQgYWxzbyBiZSBhIFJFWCBw
cmVmaXguDQo+ID4gVGhhdCB3aWxsIGJyZWFrIGFueSBjb2RlIHRoYXQgdHJpZXMgdG8gdXNlICVy
ZWcuDQo+IA0KPiBUaGUgY29tcGlsZXIgYWx3YXlzIGdlbmVyYXRlcyB0aGlzIHNwZWNpZmljIGlu
c3RydWN0aW9uIHNlcXVlbmNlLg0KDQpZZXMsIGJ1dCB0aGVyZSBhcmUgc2V2ZXJhbCB3YXlzIHRv
IGVuY29kZSAnY21wbCBpbW0sLTYocmVnKScuDQpGaXJzdGx5IHlvdSBjYW4gdXNlICc4MSAvNyBp
bW0zMicgb3IgJzgzIC83IGltbTgnIHdoZXJlIGltbTggaXMgc2lnbiBleHRlbmRlZC4NCih0aGUg
LzcgMS83L2luZGV4X3JlZyBmb3IgYSBzaWduZWQgOCBiaXQgb2Zmc2V0KS4NCkJ1dCB0aGF0IG9u
bHkgd29ya3MgZm9yIHRoZSBvcmlnaW5hbCAzMmJpdCByZWdpc3RlcnMuDQpGb3IgdGhlIDY0Yml0
IHI4IHRvIHIxNSBhbiBleHRyYSBSRVggcHJlZml4IGlzIHJlcXVpcmVkLg0KVGhhdCBtYWtlcyB0
aGUgaW5zdHJ1Y3Rpb24gOCBieXRlcyAoaWYgaXQgbmVlZHMgYSBmdWxsIDMyYml0IGltbWVkaWF0
ZSkuDQoNClNvIGlmIHRoZSByZWdpc3RlciBpcyAlcjExIHRoZXJlIGlzIGFuIGV4dHJhIFJFWCBi
eXRlLg0KSWYgdGhlIDxpZD4gaXMgYSBoYXNoIGFuZCBoYXBwZW5zIHRvIGJlIGJldHdlZW4gLTEy
OCBhbmQgMTI3DQp0aGVuIHRoZXJlIGFyZSB0aHJlZSBsZXNzIGJ5dGVzLg0KDQpTbyBkZWNvZGlu
ZyBmcm9tIHJlZ3MtPmlwIC0gMCBpc24ndCBhbHdheXMgZ29pbmcgdG8gZ2l2ZQ0KeW91IHRoZSBz
dGFydCBvZiB0aGUgaW5zdHJ1Y3Rpb24uDQoNCj4gDQo+ID4gPiArICAgICAgKiAgIGplICAgICAg
Lkx0bXAxICAgICAgICAgICAgIDsgMiBieXRlcw0KPiA+ID4gKyAgICAgICogICB1ZDIgICAgICAg
ICAgICAgICAgICAgICAgICA7IDwtIGFkZHINCj4gPiA+ICsgICAgICAqICAgLkx0bXAxOg0KPiA+
ID4gKyAgICAgICoNCj4gPiA+ICsgICAgICAqIEJvdGggdGhlIHR5cGUgYW5kIHRoZSB0YXJnZXQg
YWRkcmVzcyBjYW4gYmUgZGVjb2RlZCBmcm9tIHRoZQ0KPiA+ID4gKyAgICAgICogY21wbCBpbnN0
cnVjdGlvbi4NCj4gPiA+ICsgICAgICAqLw0KPiA+ID4gKyAgICAgaWYgKGNvcHlfZnJvbV9rZXJu
ZWxfbm9mYXVsdChidWZmZXIsICh2b2lkICopcmVncy0+aXAgLSA5LCBNQVhfSU5TTl9TSVpFKSkN
Cj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ID4gKyAgICAgaWYgKGluc25fZGVjb2Rl
X2tlcm5lbCgmaW5zbiwgYnVmZmVyKSkNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+
ID4gKyAgICAgaWYgKGluc24ub3Bjb2RlLnZhbHVlICE9IDB4ODEgfHwgWDg2X01PRFJNX1JFRyhp
bnNuLm1vZHJtLnZhbHVlKSAhPSA3KQ0KPiA+ID4gKyAgICAgICAgICAgICByZXR1cm47DQo+ID4N
Cj4gPiBTaW5jZSB5b3UgYXJlIGxvb2tpbmcgZm9yIGEgdmVyeSBzcGVjaWZpYyBvcGNvZGUgd2h5
IGJvdGhlcg0KPiA+IGNhbGxpbmcgaW5zbl9kZWNvZGVfa2VybmVsKCkgLSBqdXN0IGNoZWNrIGZv
ciB0aGUgcmVxdWlyZWQgKG1hc2tlZCkNCj4gPiBieXRlIHZhbHVlcy4NCj4gDQo+IEJlY2F1c2Ug
SSBuZWVkIHRvIGRlY29kZSBib3RoIHRoZSBpbW1lZGlhdGUgdmFsdWUgYW5kIHRoZSByZWdpc3Rl
cg0KPiBmcm9tIHRoYXQgaW5zdHJ1Y3Rpb24uDQo+IA0KPiA+ID4gKw0KPiA+ID4gKyAgICAgKnR5
cGUgPSBpbnNuLmltbWVkaWF0ZS52YWx1ZTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIG9mZnNldCA9
IGluc25fZ2V0X21vZHJtX3JtX29mZigmaW5zbiwgcmVncyk7DQo+ID4NCj4gPiBHaXZlbiB0aGUg
ZXhwZWN0ZWQgaW5zdHJ1Y3Rpb24sIGlzbid0IHRoYXQgLTYgPz8NCj4gDQo+IE5vLCB0aGlzIGlz
IHRoZSByZWdpc3RlciBvZmZzZXQuDQoNCkhtbW0uLi4uIHN0cmFuZ2UgZnVuY3Rpb24gbmFtZS4u
Lg0KPiANCj4gPiA+ICsgICAgIGlmIChvZmZzZXQgPCAwKQ0KPiA+ID4gKyAgICAgICAgICAgICBy
ZXR1cm47DQo+ID4gPiArDQo+ID4gPiArICAgICAqdGFyZ2V0ID0gKih1bnNpZ25lZCBsb25nICop
KCh2b2lkICopcmVncyArIG9mZnNldCk7DQo+ID4NCj4gPiBXVEYgaXMgdGhhdCBjYWxjdWxhdGlu
Zz8/DQo+IA0KPiBJdCdzIHJlYWRpbmcgdGhlIHJlZ2lzdGVyIHZhbHVlIGZyb20gcHRfcmVncy4N
Cj4gDQo+IFNhbWkNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

