Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C9D4DE423
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbiCRWoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241287AbiCRWoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:44:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3D46AA02F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:43:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-401-Kl5n9Y8SM8efMVGPAvZzlQ-1; Fri, 18 Mar 2022 22:43:14 +0000
X-MC-Unique: Kl5n9Y8SM8efMVGPAvZzlQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 18 Mar 2022 22:43:13 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 18 Mar 2022 22:43:13 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Juergen Gross" <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: RE: [PATCH v5] x86: use builtins to read eflags
Thread-Topic: [PATCH v5] x86: use builtins to read eflags
Thread-Index: AQHYOvTFBe9clLf+8ESM+1cEdgpAzqzFu3kw
Date:   Fri, 18 Mar 2022 22:43:13 +0000
Message-ID: <5794cceec50a4f1ebca069d5a31afcdf@AcuMS.aculab.com>
References: <20220210223134.233757-1-morbo@google.com>
 <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com>
 <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com>
 <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com>
 <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
 <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org>
 <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com>
In-Reply-To: <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTggTWFyY2ggMjAyMiAxODoxOQ0KPiANCj4g
T24gRnJpLCBNYXIgMTgsIDIwMjIgYXQgMTA6NTkgQU0gQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gSSBnZW5lcmFsbHkgYWdyZWUuICBJbiB0aGlzIHBh
cnRpY3VsYXIgY2FzZSwgdGhvdWdoLCBJIHdpbGwga2VlcCB1c2luZw0KPiA+IHRoZSBidWlsdGlu
IGluIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni9oZWxwZXJzLmggdW5sZXNzIHdlIGFjdHVh
bGx5DQo+ID4gaGl0IGJyZWFrYWdlLiAgVGhpcyBpcyBiZWNhdXNlIHRoaXMgaXMgKnVzZXIqIGNv
ZGUsIGl0IGlzIGNvbXBpbGVkIHdpdGgNCj4gPiB0aGUgcmVkem9uZSBlbmFibGVkLCBhbmQgdGhl
IGFzbSBjb2RlIHRvIGRvIHRoZSByaWdodCB0aGluZyB3aGVuIHRoZQ0KPiA+IHJlZHpvbmUgaXMg
ZW5hYmxlZCBpcyB0b28gaGFpcnkgZm9yIG1lIHRvIHdhbnQgdG8gZGVhbCB3aXRoIGl0Lg0KPiAN
Cj4gWWVhaCwgcmVkem9uaW5nIGlzIGEgcHJvYmxlbSBmb3IgInB1c2hmIi4NCj4gDQo+IE9yIHJh
dGhlciwgaXQncyBub3QgdGhlIHJlZHpvbmluZyBpdHNlbGYsIGJ1dCB0aGUgZmFjdCB0aGF0IHRo
ZQ0KPiBjb21waWxlciBtaWdodCB1c2UgdGhlIHdvcmQgdW5kZXIgdGhlIHN0YWNrIGZvciByYW5k
b20gb3RoZXIgdGhpbmdzLA0KPiBhbmQgdGhlIHB1c2hmIHdpbGwgdGhlbiBjb3JydXB0IHNvbWUg
bG9jYWwgdmFyaWFibGUgc3RvcmFnZS4NCj4gDQo+IEkgdGhpbmsgaXQgd291bGQgYmUgbG92ZWx5
IHRvIHNvbHZlIHRoYXQgaW4gaW5saW5lIGFzbSBpdHNlbGYgc29tZSB3YXkNCj4gLSBieSBtYXJr
aW5nIHRoZSBzdGFjayBwb2ludGVyIGNsb2JiZXJlZCBvciBzb21ldGhpbmcuDQoNClNvbWV0aGlu
ZyB0aGF0IGdlbmVyYXRlczoNCgltb3YJJXJheCwtOCglcnNwKQ0KCXB1c2hmDQoJeGNoZwklcmF4
LDAoJXJzcCkNCglhZGQJJXJzcCw4DQpzaG91bGQgd29yayB3aXRoIG9yIHdpdGhvdXQgYSByZWR6
b25lLg0KV2lsbCBiZSBhIGJpdCBzbG93ZXIgOi0oDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

