Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1589E493C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355215AbiASOlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:41:03 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:46991 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355175AbiASOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:41:02 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-56-LQ0FXddLOfCr6qw0uAVh6w-1; Wed, 19 Jan 2022 14:40:59 +0000
X-MC-Unique: LQ0FXddLOfCr6qw0uAVh6w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 19 Jan 2022 14:40:58 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 19 Jan 2022 14:40:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ard Biesheuvel' <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Miles Chen <miles.chen@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>
Subject: RE: [PATCH] lib/crypto: blake2s: fix a CFI failure
Thread-Topic: [PATCH] lib/crypto: blake2s: fix a CFI failure
Thread-Index: AQHYDS69GuHcqhw6yUKTzpetNPFOeaxqZdAw
Date:   Wed, 19 Jan 2022 14:40:58 +0000
Message-ID: <13f9d24879e34914b1135a4d2ae48d73@AcuMS.aculab.com>
References: <CAHmME9oX+4Ek81xy0nBOegqABH0xYqyONAqinsu7GZ7AaQaqYQ@mail.gmail.com>
 <20220119100615.5059-1-miles.chen@mediatek.com>
 <CAHmME9pQcUxs87EwQwBZNDA4ZzqugTggH+uiNPh=mv5zjp3g3A@mail.gmail.com>
 <CAHmME9pPKjRLmR6zpYFZT7rOOfHsG2ESnDi+QQrDJuGLo1X4JQ@mail.gmail.com>
 <CAHmME9oGTPS-gVyHQ4o=AxvMJrGH44_tyQ2KPQcfAKgcqC2SnA@mail.gmail.com>
 <CAMj1kXEo8kQNeoCdwvBkkW0UeYFQEJwkZ_nj06qjsBDF2Qu2pQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEo8kQNeoCdwvBkkW0UeYFQEJwkZ_nj06qjsBDF2Qu2pQ@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJkIEJpZXNoZXV2ZWwNCj4gU2VudDogMTkgSmFudWFyeSAyMDIyIDEyOjE5DQouLi4N
Cj4gLSAgICAgICAgICAgICAgICgqY29tcHJlc3MpKHN0YXRlLCBpbiwgbmJsb2NrcyAtIDEsIEJM
QUtFMlNfQkxPQ0tfU0laRSk7DQo+ICsgICAgICAgICAgICAgICBpZiAoSVNfRU5BQkxFRChDT05G
SUdfQ1JZUFRPX0FSQ0hfSEFWRV9MSUJfQkxBS0UyUykpDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICgqY29tcHJlc3MpKHN0YXRlLCBpbiwgbmJsb2NrcyAtIDEsIEJMQUtFMlNfQkxPQ0tfU0la
RSk7DQo+ICsgICAgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJs
YWtlMnNfY29tcHJlc3NfZ2VuZXJpYyhzdGF0ZSwgaW4sIG5ibG9ja3MgLSAxLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQkxBS0UyU19CTE9DS19T
SVpFKTsNCg0KSXNuJ3QgdGhhdCBhIGNhbmRpZGF0ZSBmb3IgYSAnc3RhdGljIGNhbGwnID8NCg0K
QW5kLCBtYXliZSBhbGwgdGhlc2UgaW5saW5lZCBmdW5jdGlvbnMgc2hvdWxkIGJlIHJlYWwgZnVu
Y3Rpb25zPw0KTm8gcG9pbnQgaGF2aW5nIGFsbCB0aGUgYmxvYXQgb24gZXZlcnkgY2FsbCBzaXRl
Lg0KTXVjaCBiZXR0ZXIgdG8gY2FsbCBhIHJlYWwgZnVuY3Rpb24gYW5kIHVzZWQgdGhlIGNhY2hl
ZCBpbnN0cnVjdGlvbnMuDQoNCkFsdGhvdWdoLCBoYXZpbmcgbG9va2VkIGF0IHRoZSBzb3VyY2Ug
YW5kIHRoZSBnZW5lcmF0ZWQgY29kZSBmb3INCng4Ni02NCBhbmQgYXJtNjQgSSdtIG5vdCBzdXJl
IEknZCB3YW50IHRvIHRyeSB0byBnZW5lcmF0ZQ0Kb3B0aW1pc2VkIGFzc2VtYmxlciBmb3IgaXQu
DQooVW5sZXNzIHlvdSBjYW4gYSBpbnN0cnVjdGlvbiB0aGF0IGRvZXMgZXhhY3RseSB3aGF0IHRo
ZSBjb2RlIHdhbnRzLikNCg0KQmFzaWNhbGx5IHRoZSBjb21waWxlciBjYW4gbWVyZ2UgdGhlIGlu
c3RydWN0aW9ucyBmb3IgNCBvZiB0aGUNCkcoKSBleHBhbnNpb25zIHNvIHRoYXQgdGhleSBjYW4g
ZXhlY3V0ZSBpbiBwYXJhbGxlbCBvbiBhIG11bHRpLWlzc3VlDQpjcHUuIERvaW5nIHRoYXQgYnkg
aGFuZCB3aWxsIGJlIGVycm9yIHByb25lLg0KRWFjaCBHKCkgZXhwYW5zaW9uIGlzIHByZXR0eSBt
dWNoIGEgcmVnaXN0ZXIgZGVwZW5kZW5jeSBjaGFpbiwNCm5vdCBtdWNoIGNoYW5jZSBvZiBwYXJh
bGxlbCBleGVjdXRpb24uDQoNClRoZXJlIGFyZSBjbGVhcmx5IG9wdGltaXNhdGlvbnMgZm9yIHRo
ZSB0b3AvYm90dG9tIG9mIHRoZSBsb29wLg0KQnV0IHRoZXkgY2FuIGJlIGRvbmUgdG8gdGhlIGdl
bmVyaWMgQyB2ZXJzaW9uLg0KDQpUaGUgcmVhbCBwcm9ibGVtIGlzIGxhY2sgb2YgcmVnaXN0ZXJz
IC0gdGhlIGNvZGUgbmVlZHMgMTYgZm9yIHRoZQ0KdltdIGFycmF5IHBsdXMgYSBmZXcgZXh0cmFz
Lg0KU28gc29tZSBoYXZlIHRvIHNwaWxsIHRvIHN0YWNrLg0KDQpUaGUgdW5yb2xsZWQgY29kZSBp
cyBhYm91dCAxMjAwIGluc3RydWN0aW9ucyBvbiBhcm02NCBhbmQgeDg2LTY0Lg0KRWFjaCBvZiB0
aGUgMTAgcm91bmRzIHJlYWRzIGFsbCAxNiBvZiB0aGUgdTMyIGlucHV0IHZhbHVlcy4NClNvIHRo
YXQgaXMgYWJvdXQgOCAoMTIwMC8xNjApIGluc3RydWN0aW9ucyBmb3IgZWFjaCByZWFkLg0KV2hp
Y2ggbWVhbnMgdGhlcmUgaXMgcGxlbnR5IG9mIG1lbW9yeSBiYW5kd2lkdGggZm9yIG90aGVyDQpy
ZWFkcy4NCg0KU28gJ3JvbGxpbmcgdXAnIHRoZSByb3VuZHMgLSB3aGljaCBhZGRzIGluIHRoZSBi
bGFrZTJzX3NpZ21hW10NCnJlYWRzIGNvdWxkIGVhc2lseSBiZSAnYWxtb3N0IGZyZWUnLg0KQ2Vy
dGFpbmx5IG9uIHg4NiB3aGVyZSB5b3UgYXJlIGp1c3QgKHdlbGwgc2hvdWxkIGJlIGp1c3QpIGFk
ZGluZyBhbg0KZXh0cmEgbWVtb3J5IHVvcCBmb3IgZWFjaCBpbnB1dCBidWZmZXIgcmVhZHMuDQoN
CkknbSBub3Qgc3VyZSB0aGUgOCBHKCkgY2FsbHMgY2FuIGJlIGZvbGRlZCBpbnRvIHR3byBzZXRz
IG9mIDQNCndoaWxlIHN0aWxsIGdldHRpbmcgdGhlIGNvbXBpbGVyIHRvIGludGVybGVhdmUgdGhl
IGdlbmVyYXRlZCBjb2RlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

