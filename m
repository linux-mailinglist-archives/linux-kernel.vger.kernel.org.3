Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF327592BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242013AbiHOK1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiHOK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:27:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3883612630
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:27:01 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-96-q6HvjIzxO4mJGhjAcbkxEQ-1; Mon, 15 Aug 2022 11:26:59 +0100
X-MC-Unique: q6HvjIzxO4mJGhjAcbkxEQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Mon, 15 Aug 2022 11:26:58 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Mon, 15 Aug 2022 11:26:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH] random: use raw spinlocks for use on RT
Thread-Topic: [PATCH] random: use raw spinlocks for use on RT
Thread-Index: AQHYrY2F26TYPPoB0EScME6stgsv+62vxCYg
Date:   Mon, 15 Aug 2022 10:26:58 +0000
Message-ID: <cec92c1b79be45c6b70bc890a07764cd@AcuMS.aculab.com>
References: <20220801142530.133007-1-Jason@zx2c4.com>
 <YufkZU9kGkHHUhAK@linutronix.de> <YvRKm/IpbUID18FK@zx2c4.com>
 <YvSsf5uds7zGgWPX@linutronix.de> <YvUQJTDREXSAA9J6@zx2c4.com>
In-Reply-To: <YvUQJTDREXSAA9J6@zx2c4.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
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

Li4uDQo+IFNvIHdoeSBkb24ndCB3ZSBhY3R1YWxseSBmaXggdGhpcywgc28gd2UgZG9uJ3QgaGF2
ZSB0byBrZWVwIGNvbWluZyB1cA0KPiB3aXRoIGhhY2tzPyBUaGUgcXVlc3Rpb24gaXM6IGRvZXMg
dXNpbmcgcmF3IHNwaW5sb2NrcyBvdmVyIHRoaXMgY29kZQ0KPiByZXN1bHQgaW4gYW55IHJlYWwg
aXNzdWUgZm9yIFJUIGxhdGVuY3k/IElmIHNvLCBJJ2QgbGlrZSB0byBrbm93IHdoZXJlLA0KPiBh
bmQgbWF5YmUgSSBjYW4gZG8gc29tZXRoaW5nIGFib3V0IHRoYXQgKG9yIG1heWJlIEkgY2FuJ3Qp
LiBJZiBub3QsIHRoZW4NCj4gdGhpcyBpcyBhIG5vbiBwcm9ibGVtIGFuZCBJJ2xsIGFwcGx5IHRo
aXMgcGF0Y2ggd2l0aCB5b3VyIGJsZXNzaW5nLg0KPiANCj4gSWYgeW91IGRvbid0IHdhbnQgdG8g
c3BlbmQgdGltZSBkb2luZyBsYXRlbmN5IG1lYXN1cmVtZW50cywgY291bGQgeW91DQo+IGluc3Rl
YWQgc2hhcmUgYSBkb2N1bWVudCBvciBzaW1pbGFyIHRvIHRoZSB0eXBlIG9mIG1ldGhvZG9sb2d5
IHlvdQ0KPiB1c3VhbGx5IHVzZSBmb3IgdGhhdCwgc28gSSBjYW4gZG8gdGhlIHNhbWU/IEFuZCBh
dCB0aGUgdmVyeSBsZWFzdCwgSSBhbQ0KPiBzaW1wbHkgY3VyaW91cyBhbmQgd2FudCB0byBrbm93
IG1vcmUgYWJvdXQgdGhlIFJUIHdvcmxkLg0KDQpJJ2QgaGF2ZSB0aG91Z2h0IHRoYXQgdGhlIG1h
am9yaXR5IG9mIGtlcm5lbCBzcGlubG9ja3MgYXJlDQpoZWxkIGZvciBtdWNoIGxlc3MgdGhhbiB0
aGUgdGltZSB0YWtlbiB0byBkbyBhIGNvbnRleHQgc3dpdGNoLg0KU28gY29udmVydGluZyB0aGVt
IHRvIHNsZWVwIGxvY2tzIGlzIGFsd2F5cyBnb2luZyB0byBoYXJtDQpsb2NrIGFjcXVpc2l0aW9u
IHRpbWUuDQoNClRoZSBvdGhlciBwcm9ibGVtIHRoZSBpcyBpbmhlcmVudCB3aXRoIHNsZWVwIGxv
Y2tzIGlzIHByaW9yaXR5DQppbnZlcnNpb24uDQpJJ3ZlIGhhdmUgdGVycmlibGUgcHJvYmxlbXMg
Z2V0dGluZyBhIG11bHRpdGhyZWFkZWQgUlQgYXBwbGljYXRpb24NCnRvIHJ1biByZWxpYWJseS4N
ClRoZSBtYWluIGZpeCByZXF1aXJlZCByZW1vdmluZyBBTEwgdGhlIG11dGV4IGZyb20gdGhlIGhv
dCBwYXRocy4NCkJhc2ljYWxseSB5b3UgY2FuJ3QgZW5zdXJlIHRoYXQgbXV0ZXggYXJlIG9ubHkg
aGVsZCBmb3Igc2hvcnQNCnBlcmlvZHMgKGFuIGV0aGVybmV0IGhhcmR3YXJlIGludGVycnVwdCBh
bmQgdGhlbiB0aGUgc29mdGludCBjb2RlKQ0Kd2lsbCBtZWFuIHRoZSBtdXRleCBpcyBoZWxkIGZv
ciBmYXIgdG9vIGxvbmcuDQpUaGlzIG1lYW5zIHlvdSBjYW4ndCB1c2UgbGlua2VkIGxpc3RzIHVu
bGVzcyB0aGV5IGNhbiBiZSBtYW5hZ2VkDQp3aXRoIGNtcHhjaGcgKGV0YykuDQoNCk5vdyB0aGVy
ZSBtYXkgYmUgc29tZSBrZXJuZWwgc3BpbmxvY2tzIHRoYXQgYXJlIGhlbGQgZm9yICd0b28gbG9u
ZycNCmJ1dCB0aGV5IHNob3VsZCBwcm9iYWJseSBiZSBjaGFuZ2VkIGFueXdheS4NCg0KTWFraW5n
IHRoZSBrZXJuZWwgJ21vc3RseSBwcmUtZW1wdGFibGUnICh3aGljaCBpc24ndCByZWFsbHkgdGhh
dA0KbXVjaCBkaWZmZXJlbnQgZnJvbSBTTVApIHdvdWxkIGZpeCBhIGxvdCBvZiBSVCBpc3N1ZXMg
KGxpa2UgUlQNCnByb2Nlc3NlcyBub3QgYmVpbmcgc2NoZWR1bGVkIGJlY2F1c2UgYSBsb3cgcHJp
b3JpdHkgcHJvY2Vzcw0KaW4gcnVubmluZyBpbiBrZXJuZWwgb24gdGhlIHNhbWUgY3B1KSB3aXRo
b3V0IHRoZSBjb21wbGV0ZQ0Kc2NoZWR1bGluZyB0cmFpbi13cmVjayBvZiBtYWtpbmcgZXZlcnkg
c3BpbmxvY2sgYSBzbGVlcGxvY2suDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

