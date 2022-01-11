Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA048B134
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349655AbiAKPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:47:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53358 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349554AbiAKPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:47:02 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-213-RicbFyfrMCWpx8UYA-IVfw-1; Tue, 11 Jan 2022 15:46:57 +0000
X-MC-Unique: RicbFyfrMCWpx8UYA-IVfw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 15:46:56 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Tue, 11 Jan 2022 15:46:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: RE: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
Thread-Topic: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
Thread-Index: AQHYBunGGyLRC02Uk06ON333WcASqqxd8NBA
Date:   Tue, 11 Jan 2022 15:46:56 +0000
Message-ID: <caed82818cdb466aade033501f57d183@AcuMS.aculab.com>
References: <20211223141113.1240679-1-Jason@zx2c4.com>
 <20211223141113.1240679-2-Jason@zx2c4.com>
 <CAMuHMdU0spv9X_wErkBBWQ9kV9f1zE_YNcu5nPbTG_64Lh_h0w@mail.gmail.com>
 <CAHmME9pZu-UvCK=uP-sxXL127BmbjmrD2=M7cNd9vHdJEsverw@mail.gmail.com>
 <Yd18+iQ8zicsSPa0@zx2c4.com>
In-Reply-To: <Yd18+iQ8zicsSPa0@zx2c4.com>
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

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkDQo+IFNlbnQ6IDExIEphbnVhcnkgMjAyMiAxMjo1MA0K
PiANCj4gT24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgMToyOCBQTSBKYXNvbiBBLiBEb25lbmZlbGQg
PEphc29uQHp4MmM0LmNvbT4gd3JvdGU6DQo+ID4gSWYgeW91J3JlIHJlYWxseSBxdWl0ZSBjb25j
ZXJuZWQgYWJvdXQgbTY4ayBjb2RlIHNpemUsIEkgY2FuIHByb2JhYmx5DQo+ID4gZG8gc29tZSB0
aGluZ3MgdG8gcmVkdWNlIHRoYXQuIEZvciBleGFtcGxlLCBibGFrZTJzMjU2X2htYWMgaXMgb25s
eQ0KPiA+IHVzZWQgYnkgd2lyZWd1YXJkIGFuZCBpdCBjb3VsZCBwcm9iYWJseSBiZSBtYWRlIGxv
Y2FsIHRoZXJlLiBBbmQgd2l0aA0KPiA+IHNvbWUgdHJpdmlhbCBsb29wIHJlLXJvbGxpbmcsIEkg
Y2FuIHNoYXZlIG9mZiBhbm90aGVyIDIzMDAgYnl0ZXMuIEFuZA0KPiA+IEkgYmV0IEkgY2FuIGZp
bmQgYSBmZXcgb3RoZXIgdGhpbmdzIHRvby4gVGhlIHF1ZXN0aW9uIGlzOiBob3cNCj4gPiBpbXBv
cnRhbnQgaXMgdGhpcyB0byB5b3U/DQo+IA0KPiBBbmQgd2l0aCBhbm90aGVyIHRyaWNrIChzZWUg
YmVsb3cpLCBhbm90aGVyIGV4dHJhIDEwMDAgYnl0ZXMgb3Igc28NCj4gc2hhdmVkIG9mZi4gQXNp
ZGUgZnJvbSBtb3ZpbmcgYmxha2UyczI1Nl9obWFjLCBJJ20gbm90IHJlYWxseSBzdXBlcg0KPiBl
bnRodXNpYXN0aWMgYWJvdXQgbWFraW5nIHRoZXNlIGNoYW5nZXMsIGJ1dCBkZXBlbmRpbmcgb24g
aG93IGltcG9ydGFudA0KPiB0aGlzIGlzIHRvIHlvdSwgbWF5YmUgd2UgY2FuIG1ha2Ugc29tZXRo
aW5nIHdvcmsuIFRoZXJlIGFyZSBwcm9iYWJseQ0KPiBhZGRpdGlvbmFsIHBvc3NpYmlsaXRpZXMg
dG9vIHdpdGggdGhlIGNvZGUuDQo+IA0KPiA9PT09DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL2Ny
eXB0by9ibGFrZTJzLWdlbmVyaWMuYyBiL2xpYi9jcnlwdG8vYmxha2Uycy1nZW5lcmljLmMNCj4g
aW5kZXggNzVjY2IzZTYzM2U2Li44ZTNjNjM3MjM2M2EgMTAwNjQ0DQo+IC0tLSBhL2xpYi9jcnlw
dG8vYmxha2Uycy1nZW5lcmljLmMNCj4gKysrIGIvbGliL2NyeXB0by9ibGFrZTJzLWdlbmVyaWMu
Yw0KPiBAQCAtNDYsNyArNDYsNyBAQCB2b2lkIGJsYWtlMnNfY29tcHJlc3NfZ2VuZXJpYyhzdHJ1
Y3QgYmxha2Uyc19zdGF0ZSAqc3RhdGUsIGNvbnN0IHU4ICpibG9jaywNCj4gIHsNCj4gIAl1MzIg
bVsxNl07DQo+ICAJdTMyIHZbMTZdOw0KPiAtCWludCBpOw0KPiArCWludCBpLCBqOw0KDQpVc2Ug
dW5zaWduZWQgaW50IGksIGo7DQpFbnN1cmVzIHRoZSAnJSA0JyBhcmUgZG9uZSBhcyAnJiAzJyBh
bmQgdGhlIGRpdmlkZXMgYXMgc2hpZnRzLg0KVW5sZXNzIHRoZSBjb21waWxlciBtYW5hZ2VzIHRv
IHRyYWNrIHRoZSB2YWxpZCB2YWx1ZXMgdGhhdCB3aWxsDQpldmVuIGdlbmVyYXRlIGJldHRlciBj
b2RlIG9uIHg4Ni02NC4NCihTYXZlcyBhIHNpZ24gZXh0ZW5zaW9uIHByaW9yIHRvIHRoZSBhcnJh
eSBpbmRleGVzLikNCg0KPiAgCVdBUk5fT04oSVNfRU5BQkxFRChERUJVRykgJiYNCj4gIAkJKG5i
bG9ja3MgPiAxICYmIGluYyAhPSBCTEFLRTJTX0JMT0NLX1NJWkUpKTsNCj4gQEAgLTc2LDI5ICs3
NiwxMSBAQCB2b2lkIGJsYWtlMnNfY29tcHJlc3NfZ2VuZXJpYyhzdHJ1Y3QgYmxha2Uyc19zdGF0
ZSAqc3RhdGUsIGNvbnN0IHU4ICpibG9jaywNCj4gIAliID0gcm9yMzIoYiBeIGMsIDcpOyBcDQo+
ICB9IHdoaWxlICgwKQ0KPiANCj4gLSNkZWZpbmUgUk9VTkQocikgZG8geyBcDQo+IC0JRyhyLCAw
LCB2WzBdLCB2WyA0XSwgdlsgOF0sIHZbMTJdKTsgXA0KPiAtCUcociwgMSwgdlsxXSwgdlsgNV0s
IHZbIDldLCB2WzEzXSk7IFwNCj4gLQlHKHIsIDIsIHZbMl0sIHZbIDZdLCB2WzEwXSwgdlsxNF0p
OyBcDQo+IC0JRyhyLCAzLCB2WzNdLCB2WyA3XSwgdlsxMV0sIHZbMTVdKTsgXA0KPiAtCUcociwg
NCwgdlswXSwgdlsgNV0sIHZbMTBdLCB2WzE1XSk7IFwNCj4gLQlHKHIsIDUsIHZbMV0sIHZbIDZd
LCB2WzExXSwgdlsxMl0pOyBcDQo+IC0JRyhyLCA2LCB2WzJdLCB2WyA3XSwgdlsgOF0sIHZbMTNd
KTsgXA0KPiAtCUcociwgNywgdlszXSwgdlsgNF0sIHZbIDldLCB2WzE0XSk7IFwNCj4gLX0gd2hp
bGUgKDApDQo+IC0JCVJPVU5EKDApOw0KPiAtCQlST1VORCgxKTsNCj4gLQkJUk9VTkQoMik7DQo+
IC0JCVJPVU5EKDMpOw0KPiAtCQlST1VORCg0KTsNCj4gLQkJUk9VTkQoNSk7DQo+IC0JCVJPVU5E
KDYpOw0KPiAtCQlST1VORCg3KTsNCj4gLQkJUk9VTkQoOCk7DQo+IC0JCVJPVU5EKDkpOw0KPiAt
DQo+ICsJCWZvciAoaSA9IDA7IGkgPCAxMDsgKytpKSB7DQo+ICsJCQlmb3IgKGogPSAwOyBqIDwg
ODsgKytqKQ0KPiArCQkJCUcoaSwgaiwgdltqICUgNF0sIHZbKChqICsgKGogLyA0KSkgJSA0KSAr
IDRdLCB2WygoaiArIDIgKiAoaiAvIDQpKSAlIDQpICsgOF0sDQo+IHZbKChqICsgMyAqIChqIC8g
NCkpICUgNCkgKyAxMl0pOw0KDQpJIHRoaW5rIEknZCBsb29rIGF0IGRvaW5nIFswLi4zXSB0aGVu
IFs0Li43XSB0byBzYXZlIGV4ZWN1dGlvbiB0aW1lLg0KDQpJIGFjdHVhbGx5IHdvbmRlciBob3cg
bGFyZ2UgYSBibG9jayB5b3UgbmVlZCB0byBiZSBwcm9jZXNzaW5nIHRvIGdldA0KYSBnYWluIGZy
b20gYWxsIHRoYXQgdW5yb2xsaW5nIG9uIGFyY2hpdGVjdHVyZXMgbGlrZSB4ODYtNjQuDQpUaGUg
J2NvbGQgY2FjaGUnIHRpbWluZyBtdXN0IGJlIGhvcnJpZC4NCk5ldmVyIG1pbmQgdGhlIHNpZGUg
ZWZmZWN0cyBvZiBkaXNwbGFjaW5nIHRoYXQgbXVjaCBvdGhlciBjb2RlIGZyb20gdGhlIEktY2Fj
aGUuDQoNClRoZXJlIGFyZW4ndCBlbm91Z2ggcmVnaXN0ZXJzIHRvIGhvbGQgYWxsIHRoZSB2W10g
dmFsdWVzIHNvIHRoZXknbGwNCmFsbCBiZSBtZW1vcnkgcmVhZHMgLSBhbmQgdGhlcmUgYXJlIHBy
b2JhYmx5IG90aGVycyBhcyB3ZWxsLg0KVGhlIG90aGVyIGluc3RydWN0aW9ucyB3aWxsIGhhcHBl
biBpbiBwYXJhbGxlbCAtIGV2ZW4gMyBvciA0IGZvciBlYWNoIG1lbW9yeSByZWFkLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

