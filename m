Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5147C55D4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiF0IZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiF0IZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:25:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73A696178
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:25:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-54-1jANicmsPmWfA7kUguPDXg-1; Mon, 27 Jun 2022 09:25:27 +0100
X-MC-Unique: 1jANicmsPmWfA7kUguPDXg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 27 Jun 2022 09:25:26 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 27 Jun 2022 09:25:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: RE: [RFC[ Alloc in vsprintf
Thread-Topic: [RFC[ Alloc in vsprintf
Thread-Index: AQHYiZoSZNRPYrXujUmM6V+Dm+02461i46rg
Date:   Mon, 27 Jun 2022 08:25:26 +0000
Message-ID: <a723f5dda62a4c448dd292a3b917fe6d@AcuMS.aculab.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
 <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
 <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
 <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
 <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
 <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
 <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
 <CAHk-=whwyxSpzgr+roEr7_V5wVenw9fV3EOAZhAYCAuRdEyChQ@mail.gmail.com>
In-Reply-To: <CAHk-=whwyxSpzgr+roEr7_V5wVenw9fV3EOAZhAYCAuRdEyChQ@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjYgSnVuZSAyMDIyIDIxOjE5DQouLg0KPiBU
aGF0IGRvZXMgcmVxdWlyZSB0ZWFjaGluZyB0aGUgc3ByaW50X3N5bWJvbCgpIGZ1bmN0aW9ucyB0
aGF0IHRoZXkNCj4gbmVlZCB0byB0YWtlIGEgImxlbmd0aCBvZiBidWZmZXIiIGFuZCByZXR1cm4g
aG93IG11Y2ggdGhleSB1c2VkLCBidXQNCj4gdGhhdCB3b3VsZCBzZWVtIHRvIGJlIGEgc2Vuc2li
bGUgdGhpbmcgYW55d2F5LCBhbmQgd2hhdCB0aGUgY29kZQ0KPiBzaG91bGQgYWx3YXlzIGhhdmUg
ZG9uZT8NCg0KSXQgbmVlZHMgdG8gcmV0dXJuIHRoZSAnbGVuZ3RoIGl0IHdvdWxkIGhhdmUgdXNl
ZCcuDQpXaGlsZSBvY2Nhc2lvbmFsbHkgdXNlZnVsIEknbSBwcmV0dHkgc3VyZSB0aGlzIGlzIGFj
dHVhbGx5DQphIHNpZGUgZWZmZWN0IG9mIHRoZSB3YXMgdGhhdCBsaWJjIHNucHJpbnRmKCkgd2Fz
IG9yaWdpbmFsbHkNCmltcGxlbWVudGVkIChzcHJpbnRmKCkgaGFkIGFuIG9uLXN0YWNrIEZJTEUp
Lg0KDQpJbiBhbnkgY2FzZSBpdCBtaWdodCBiZSBzaW1wbGVzdCB0byBwYXNzIGFsbCB0aGVzZSBm
dW5jdGlvbnMNCnRoZSB3cml0ZSBwb2ludGVyIGFuZCBidWZmZXIgbGltaXQgYW5kIGhhdmUgdGhl
bSByZXR1cm4gdGhlDQpuZXcgd3JpdGUgcG9pbnRlci4NCkl0IGlzIGxpa2VseSB0byBnZW5lcmF0
ZSBtdWNoIGJldHRlciBjb2RlIHRoYXQgcGFzc2luZw0KYSBzdHJ1Y3R1cmUgYnkgcmVmZXJlbmNl
Lg0KDQpPbmx5IHRoZSBvcmlnaW5hbCBjYWxsZXIgbmVlZHMgdG8ga25vdyB3aGVyZSB0aGUgYnVm
ZmVyIHN0YXJ0cy4NClRoZSBvcmlnaW5hbCBjYWxsZXIgaXMgYWxzbyB0aGUgb25seSBwbGFjZSB0
aGF0IG5lZWRzIHRvDQplbnN1cmUgdGhhdCB0aGUgc3RyaW5nIGlzIGNvcnJlY3RseSB0ZXJtaW5h
dGVkLg0KDQpZb3UnZCBnZXQgaGVscGVycyBsaWtlOg0KDQpjaGFyICphZGRfY2hhcihjaGFyICp3
cCwgY29uc3QgY2hhciAqbGltLCBjaGFyIGFkZCkNCnsNCglpZiAobGltIDwgd3ApDQoJCSp3cCA9
IGFkZDsNCglyZXR1cm4gd3AgKyAxOw0KfQ0KDQpjaGFyICphZGRfY2hhcnMoY2hhciAqd3AsIGNv
bnN0IGNoYXIgKmxpbSwgY29uc3QgY2hhciAqYWRkLCBsb25nIGludCBjb3VudCkNCnsNCglsb25n
IGludCBzcGFjZSA9IGxpbSAtIHdwOw0KCWxvbmcgaW50IGk7DQoNCglpZiAoc3BhY2UgPiBjb3Vu
dCkNCgkJc3BhY2UgPSBjb3VudDsNCglmb3IgKGkgPSBpOyBpIDwgc3BhY2U7IGkrKykNCgkJd3Bb
aV0gPSBhZGRbaV07DQoJDQoJcmV0dXJuIHdwICsgY291bnQ7DQp9DQoNCmNoYXIgKmFkZF9zdHIo
Y2hhciAqd3AsIGNvbnN0IGNoYXIgKmxpbSwgY29uc3QgY2hhciAqYWRkKQ0Kew0KCXdoaWxlICgq
YWRkKSB7DQoJCWlmICh3cCA+PSBsaW0pDQoJCQlyZXR1cm4gd3AgKyBzdHJsZW4oYWRkKTsNCgkJ
KndwKysgPSAqYWRkKys7DQoJfQ0KCQ0KCXJldHVybiB3cDsNCn0NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

