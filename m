Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AD454F41F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380390AbiFQJTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbiFQJTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:19:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B48085AEF3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:19:23 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-220-s7RJKPWvOuOU30OW3UVyvA-1; Fri, 17 Jun 2022 10:19:20 +0100
X-MC-Unique: s7RJKPWvOuOU30OW3UVyvA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 17 Jun 2022 10:19:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 17 Jun 2022 10:19:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Thread-Index: AQHYgbX7+B40USEpAkCPXvMJQcFna61TTqwg
Date:   Fri, 17 Jun 2022 09:19:17 +0000
Message-ID: <169e9522f5494a47bd99c6febf90d931@AcuMS.aculab.com>
References: <20220616143617.449094-1-Jason@zx2c4.com>
 <YqtAShjjo1zC6EgO@casper.infradead.org> <YqtDXPWdFQ/fqgDo@zx2c4.com>
 <YqtKjAZRPBVjlE8S@casper.infradead.org>
 <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
 <Yqtd6hTS52mbb9+q@casper.infradead.org>
 <CAHk-=wj_K2MnhC6N_LyY6ezmQyWzqBnfobXC354HJuKdqMePzA@mail.gmail.com>
 <CAHk-=whS3xhJ=quD5bzDb6JsAhKd0vem4K-U=DhUGf-tDJUMHg@mail.gmail.com>
 <CAHk-=wi28vwsG-JNJEz_kc=qwPkYtYfh_14eHOUZsaGESDBDBA@mail.gmail.com>
In-Reply-To: <CAHk-=wi28vwsG-JNJEz_kc=qwPkYtYfh_14eHOUZsaGESDBDBA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTYgSnVuZSAyMDIyIDIwOjE5DQo+IA0KPiBP
biBUaHUsIEp1biAxNiwgMjAyMiBhdCAxMjoxNCBQTSBMaW51cyBUb3J2YWxkcw0KPiA8dG9ydmFs
ZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gSW4gdGhhdCBzaXR1YXRp
b24sIHdlJ2QgcHJvYmFibHkganVzdCBzZWUgImxvbmcgbG9uZyIgYmVpbmcgMTI4LWJpdA0KPiA+
ICgiSTMyTFA2NExMMTI4IikuDQo+IA0KPiBMb29raW5nIGFyb3VuZCwgaXQgbG9va3MgbGlrZSBw
ZW9wbGUgcHJlZmVyICJsb25nIGxvbmcgbG9uZyIgKG9yIGluDQo+IHRoZSBrZXJuZWwsIGp1c3Qg
InUxMjgiKSBmb3IgdGhpcywgYmVjYXVzZSBzbyBtYW55IGhhdmUgYWxyZWFkeSBnb3R0ZW4NCj4g
dXNlZCB0byAibG9uZyBsb25nIiBiZWluZyA2NC1iaXQsIGFuZCAzMi1iaXQgYXJjaGl0ZWN0dXJl
cyAod2hlcmUNCj4gImxvbmciIGlzIDMyLWJpdCBhbmQgImxvbmcgbG9uZyIgaXMgNjQtYml0KSBh
cmUgc3RpbGwgcmVsZXZhbnQgZW5vdWdoDQo+IHRoYXQgcGVvcGxlIHdhbnQgdG8ga2VlcCB0aGF0
Lg0KDQpDaGFuZ2luZyAnbG9uZyBsb25nJyB0byAxMjggYml0cyB3aWxsIGJyZWFrIHRoaW5ncy4N
Ck11Y2ggbGlrZSBhIGNlcnRhaW4gT1MgdGhhdCBpcyBJTDMyUDY0TEw2NCBiZWNhdXNlIHRvbyBt
dWNoDQpjb2RlIHVzZWQgJ2xvbmcnIHRvIG1lYW4gMzJiaXRzIHdoZW4gaW50IHdhcyAxNiBiaXRz
LiANCg0KZ2NjIGFscmVhZHkgaGFzIHN1cHBvcnQgZm9yIDEyOGJpdCBpbnRlZ2VycyAob24gNjRi
aXQgc3lzdGVtcykNCmVtdWxhdGVkIHVzaW5nIHR3byA2NGJpdCByZWdpc3RlcnMgKF9fdTEyOCA/
PykNCg0KQW55dGhpbmcgd2FudGluZyB0aGVtIHByb2JhYmx5IHdhbnRzIHRoZW0gZXhwbGljaXRs
eSBhbmQgZXZlbiBkZWNpZGluZw0KdGhhdCB1aW50bWF4X3QgaXMgc3VkZGVubHkgMTI4IGJpdCB3
aWxsIHByb2JhYmx5IGJyZWFrIHRoaW5ncyENCg0KVGhlIG9ubHkgcGxhY2UgSSBjYW4gaW1hZ2lu
ZSAnbG9uZyBsb25nIGxvbmcnIGJlaW5nIHVzZWQNCmlzIGFzICIlbGxsZCIgaW4gcHJpbnRmIGZv
cm1hdHMuDQoNClNpbmNlICdzaG9ydCcgYW5kICdsb25nJyBhcmUgYm90aCB0eXBlcyBhbmQgcXVh
bGlmaWVycw0KeW91IGNhbiBoYXZlICdsb25nIGNoYXIsICdsb25nIHNob3J0JyBhbmQgJ3Nob3J0
IGxvbmcnLg0KVGhlc2UgY291bGQgYmUgaW50ZXJlc3Rpbmcgb24gYW4gSTY0TDI1NiBzeXN0ZW0g
Oi0pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

