Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3235654F7D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiFQMvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiFQMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:51:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48E9437BE8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:51:20 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-155-h3wWc7x7P72brAvjq1zRbg-1; Fri, 17 Jun 2022 13:51:17 +0100
X-MC-Unique: h3wWc7x7P72brAvjq1zRbg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 17 Jun 2022 13:51:15 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 17 Jun 2022 13:51:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Kees Cook" <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Subject: RE: [PATCH] usercopy: use unsigned long instead of uintptr_t
Thread-Topic: [PATCH] usercopy: use unsigned long instead of uintptr_t
Thread-Index: AQHYgY56+B40USEpAkCPXvMJQcFna61SGkAAgAADqACAAAiSAIAACqGAgAAMdQCAAANVgIAAJpIAgADVkYCAADQtAIAAGqDA
Date:   Fri, 17 Jun 2022 12:51:15 +0000
Message-ID: <2b4f67aed7c64abe83eb868c351656dc@AcuMS.aculab.com>
References: <20220616143617.449094-1-Jason@zx2c4.com>
 <YqtAShjjo1zC6EgO@casper.infradead.org> <YqtDXPWdFQ/fqgDo@zx2c4.com>
 <YqtKjAZRPBVjlE8S@casper.infradead.org>
 <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
 <Yqtd6hTS52mbb9+q@casper.infradead.org>
 <CAHk-=wj_K2MnhC6N_LyY6ezmQyWzqBnfobXC354HJuKdqMePzA@mail.gmail.com>
 <CAHk-=whS3xhJ=quD5bzDb6JsAhKd0vem4K-U=DhUGf-tDJUMHg@mail.gmail.com>
 <CAMuHMdXxAwbCQPn4jg8X=_p5cYkpvNE4bXfQHWk2vz2Y6hL2-w@mail.gmail.com>
 <ec7f0c59-f67e-1d7e-c0b3-b0a409623e98@csgroup.eu>
In-Reply-To: <ec7f0c59-f67e-1d7e-c0b3-b0a409623e98@csgroup.eu>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAxNyBKdW5lIDIwMjIgMTI6MDYNCj4gDQo+
IExlIDE3LzA2LzIwMjIgw6AgMDk6NTgsIEdlZXJ0IFV5dHRlcmhvZXZlbiBhIMOpY3JpdMKgOg0K
PiA+PiBCdXQgaXQgdGhlbiBjYXVzZXMgcG9pbnRsZXNzIHByb2JsZW1zIHdoZW4gcGVvcGxlIGNh
bid0IHJlYWxseSByZWx5IG9uDQo+ID4+IG1vcmUgdGhhbiAzMiBiaXRzIGZvciBhdG9taWMgYml0
IG9wZXJhdGlvbnMsIGFuZCBvbiA2NC1iaXQNCj4gPj4gYXJjaGl0ZWN0dXJlcyB3ZSB1bm5lY2Vz
c2FyaWx5IHVzZSAibG9uZyIgYW5kIHdhc3RlIHRoZSB1cHBlciBiaXRzLg0KPiA+DQo+ID4gV2Vs
bCwgYXRvbWljIHdvcmtzIHVwIHRvIG5hdGl2ZSB3b3JkIHNpemUsIGkuZS4gbG9uZy4NCj4gPg0K
PiANCj4gcG93ZXJwYzY0IGhhcyBhIHBhaXIgb2YgaW5zdHJ1Y3Rpb25zIHRvIHBlcmZvcm0gMTI4
Yml0cyBhdG9taWMNCj4gb3BlcmF0aW9ucyA6IGxxYXJ4IC8gc3RxY3guDQoNCkFzIGRvZXMgeDg2
LTY0IChhbmQgMzJiaXQgaGFzIGEgNjRiaXQgYXRvbWljIGNvbXBhcmUrZXhjaGFuZ2UpLg0KDQpB
bm5veWluZ2x5IHRoZSB4ODYtNjQgZG9lc24ndCBoYXZlIDEyOGJpdCByZWFkL3dyaXRlIHJlZ2lz
dGVyDQpwYWlyIGluc3RydWN0aW9ucyB0aGF0IHdvdWxkIGdlbmVyYXRlIGEgMTI4Yml0IFBDSWUg
VExQLg0KWW91IGNhbiB1c2UgQVZYIGluc3RydWN0aW9ucyB0byBnZW5lcmF0ZSBsYXJnZSBUTFAg
LSBidXQgbm90DQppbiB0aGUgbGludXgga2VybmVsIC0geW91IHdhbnQgMSBiaWcgcmVnaXN0ZXIu
DQoNCkV2ZW4gdGhlIGh1bWJsZSA2ODAyMCBoYXMgYSBjYXMyIGluc3RydWN0aW9uIHRoYXQgd2ls
bCBkbyBhDQo2NGJpdCBhdG9taWMgb3BlcmF0aW9uLg0KSSBkaWQgbWFuYWdlIHRvIHVzZSBpdCBv
bmNlLCBidXQgaXQgaXMgZWFzaWVyIHRvIGRpc2FibGUgaW50ZXJydXB0cy4NCkknbSBub3Qgc3Vy
ZSBob3cgbWFueSBTTVAgNjgwMjAgc3lzdGVtcyB3ZXJlIGV2ZXIgYnVpbHQuDQpZb3UnZCBuZWVk
IGEgbWF0Y2hlZCBwYWlyIG9mIGNwdSAob3IgZXh0cmVtZSBjYXJlKSBzaW5jZSBpdA0KdGVuZHMg
dG8gc3RhY2sgbWljcm9jb2RlIGRhdGEgb24gbWlkLWluc3RydWN0aW9uIGZhdWx0cy4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

