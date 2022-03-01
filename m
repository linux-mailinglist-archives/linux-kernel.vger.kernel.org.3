Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7294C8EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiCAPRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiCAPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:17:09 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D513692A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:16:26 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-318-Vr7v5iKRMIKftw0gpJuxvQ-1; Tue, 01 Mar 2022 15:16:24 +0000
X-MC-Unique: Vr7v5iKRMIKftw0gpJuxvQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 1 Mar 2022 15:16:22 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 1 Mar 2022 15:16:22 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miguel Ojeda' <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Dan Li <ashimida@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
Thread-Topic: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
Thread-Index: AQHYLU7BTsy+Ydg2gUOh1XD7Md8Cb6yqo40Q
Date:   Tue, 1 Mar 2022 15:16:22 +0000
Message-ID: <4b7a3af66c54458681f00a55a84752ab@AcuMS.aculab.com>
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
 <CANiq72kXoonDYk095XvBwEtRCRNECd1iQOqJHE2cNcgLyUMfcQ@mail.gmail.com>
 <26a0a816-bc3e-2ac0-d773-0819d9f225af@linux.alibaba.com>
 <CAKwvOdkykPtGTL6ud8qJZHSHKV2eSbpnZE-G4oyymD9BiQKHdg@mail.gmail.com>
 <CANiq72m0O7ua3F3eqcEru9RuEWHQbG4SumRSoKCi50A8d-+HtA@mail.gmail.com>
In-Reply-To: <CANiq72m0O7ua3F3eqcEru9RuEWHQbG4SumRSoKCi50A8d-+HtA@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWlndWVsIE9qZWRhDQo+IFNlbnQ6IDAxIE1hcmNoIDIwMjIgMDk6MjkNCj4gDQo+IE9u
IE1vbiwgRmViIDI4LCAyMDIyIGF0IDExOjM1IFBNIE5pY2sgRGVzYXVsbmllcnMNCj4gPG5kZXNh
dWxuaWVyc0Bnb29nbGUuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9yIHNpbXBseSBhZGQgYSAjZGVm
aW5lIGZvciBfX25vc2NzIHRvIGluY2x1ZGUvbGludXgvY29tcGlsZXItZ2NjLmgNCj4gPiB3aXRo
IGFwcHJvcHJpYXRlIGd1YXJkIGFuZCBsZWF2ZSB0aGUgZXhpc3RpbmcgI2lmbmRlZiBpbg0KPiA+
IGluY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaCBhcyBpcy4gIEknZCBwcmVmZXIgdGhhdCB3
aGVuIHRoZQ0KPiA+IGNvbXBpbGVycyBkaWZmZXIgaW4gdGVybXMgb2YgZmVhdHVyZSBkZXRlY3Rp
b24gc2luY2UgaXQncyBhcyBleHBsaWNpdA0KPiA+IGFzIHBvc3NpYmxlLg0KPiANCj4gVGhlIGlk
ZWEgaXMgdG8gYXZvaWQgZGlmZmVyaW5nIGhlcmUgdG8gYmVnaW4gd2l0aCwgaS5lLiB0byB1c2Ug
dGhlDQo+IHNhbWUgY29kZSBmb3IgYm90aCBjb21waWxlcnMgKG9ubHkgd2hlbmV2ZXIgdGhhdCBp
cyBwb3NzaWJsZSwgb2YNCj4gY291cnNlKSwgdGh1cyBoYXZpbmcgYSBzaW5nbGUgYCNkZWZpbmVg
IGluIGEgc2luZ2xlIGZpbGUuDQo+IA0KPiBEbyB5b3UgdGhpbmsgd2Ugd2lsbCBoYXZlIHRvIGNo
YW5nZSBpbiB0aGUgZnV0dXJlIGZvciBzb21lIHJlYXNvbiwNCj4gdGh1cyBuZWVkaW5nIHRvIHNw
bGl0IGl0IGFnYWluPw0KDQpXaGF0IGhhcHBlbnMgaWYgYW4gb3V0IG9mIHRyZWUgbW9kdWxlIGlz
IGNvbXBpbGVkIHdpdGggdGhlIG90aGVyIGNvbXBpbGVyPw0KU3VyZWx5IHRoaXMgaXMgcGFydCBv
ZiB0aGUgQUJJIGFuZCBzaG91bGQgYmUgZGVmaW5lZCBmb3IgdGhlIGFyY2hpdGVjdHVyZT8NCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

