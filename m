Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA17F48EF39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243878AbiANR1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:27:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:42426 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229758AbiANR1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:27:46 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-23-2RAsF3bfN66dUH8_-mF0Rg-1; Fri, 14 Jan 2022 17:27:44 +0000
X-MC-Unique: 2RAsF3bfN66dUH8_-mF0Rg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 14 Jan 2022 17:27:43 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 14 Jan 2022 17:27:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: RE: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
Thread-Topic: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
Thread-Index: AQHYBunGGyLRC02Uk06ON333WcASqqxixRAg
Date:   Fri, 14 Jan 2022 17:27:43 +0000
Message-ID: <05ae373684334e6581294baa8afd3238@AcuMS.aculab.com>
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
Pg0KPiBPbiBUdWUsIEphbiAxMSwgMjAyMiBhdCAxOjI4IFBNIEphc29uIEEuIERvbmVuZmVsZCA8
SmFzb25AengyYzQuY29tPiB3cm90ZToNCj4gPiBJZiB5b3UncmUgcmVhbGx5IHF1aXRlIGNvbmNl
cm5lZCBhYm91dCBtNjhrIGNvZGUgc2l6ZSwgSSBjYW4gcHJvYmFibHkNCj4gPiBkbyBzb21lIHRo
aW5ncyB0byByZWR1Y2UgdGhhdC4gRm9yIGV4YW1wbGUsIGJsYWtlMnMyNTZfaG1hYyBpcyBvbmx5
DQo+ID4gdXNlZCBieSB3aXJlZ3VhcmQgYW5kIGl0IGNvdWxkIHByb2JhYmx5IGJlIG1hZGUgbG9j
YWwgdGhlcmUuIEFuZCB3aXRoDQo+ID4gc29tZSB0cml2aWFsIGxvb3AgcmUtcm9sbGluZywgSSBj
YW4gc2hhdmUgb2ZmIGFub3RoZXIgMjMwMCBieXRlcy4gQW5kDQo+ID4gSSBiZXQgSSBjYW4gZmlu
ZCBhIGZldyBvdGhlciB0aGluZ3MgdG9vLiBUaGUgcXVlc3Rpb24gaXM6IGhvdw0KPiA+IGltcG9y
dGFudCBpcyB0aGlzIHRvIHlvdT8NCj4gDQo+IEFuZCB3aXRoIGFub3RoZXIgdHJpY2sgKHNlZSBi
ZWxvdyksIGFub3RoZXIgZXh0cmEgMTAwMCBieXRlcyBvciBzbw0KPiBzaGF2ZWQgb2ZmLiBBc2lk
ZSBmcm9tIG1vdmluZyBibGFrZTJzMjU2X2htYWMsIEknbSBub3QgcmVhbGx5IHN1cGVyDQo+IGVu
dGh1c2lhc3RpYyBhYm91dCBtYWtpbmcgdGhlc2UgY2hhbmdlcywgYnV0IGRlcGVuZGluZyBvbiBo
b3cgaW1wb3J0YW50DQo+IHRoaXMgaXMgdG8geW91LCBtYXliZSB3ZSBjYW4gbWFrZSBzb21ldGhp
bmcgd29yay4gVGhlcmUgYXJlIHByb2JhYmx5DQo+IGFkZGl0aW9uYWwgcG9zc2liaWxpdGllcyB0
b28gd2l0aCB0aGUgY29kZS4NCg0KUXVpdGUgY2xlYXJseSB3aG9ldmVyIHdyb3RlIHRoZSB1bnJv
bGxlZCBsb29wcyBuZWVkcyB0aGVpciBoZWFkIGV4YW1pbmVkLg0KSXQgaXMgZXh0cmVtZWx5IHVu
bGlrZWx5IHRoYXQgYSBjcHUgaGFzIGVub3VnaCByZWdpc3RlcnMgdG8gaW1wbGVtZW50IGl0DQpl
ZmZlY2llbnRseS4NCihPZiBjb3Vyc2UsIGEgcGlwZWxpbmVkIGltcGxlbWVudGF0aW9uIG9uIGEg
ZmdwYSBpcyBhbm90aGVyIG1hdHRlci4pDQoNClNvIGV2ZXJ5IHJlYWQgb2YgdltdIGlzIGdvaW5n
IHRvIGJlIGEgbWVtb3J5IHJlYWQuDQpNdWNoIGJldHRlciB0byBkbyB0aGF0IHRoYW4gdG8gc3Bp
bGwgdmFsdWVzIHRoYXQgY2hhbmdlLg0KVGhlIG1lbW9yeSByZWFkcyB3b24ndCByZWFsbHkgaGl0
IHBlcmZvcm1hbmNlIGVpdGhlci4NClRoZXkgYWRkIGEgYml0IG9mIGxhdGVuY3kgLSBidXQgdGhh
dCB3aWxsIGJlIGhhbmRsZWQgYnkNCmluc3RydWN0aW9uIHNjaGVkdWxpbmcgLSBlaXRoZXIgYnkg
dGhlIGNvbXBpbGVyIG9mIGNwdSBoYXJkd2FyZS4NCg0KPiAtI2RlZmluZSBST1VORChyKSBkbyB7
IFwNCj4gLQlHKHIsIDAsIHZbMF0sIHZbIDRdLCB2WyA4XSwgdlsxMl0pOyBcDQo+IC0JRyhyLCAx
LCB2WzFdLCB2WyA1XSwgdlsgOV0sIHZbMTNdKTsgXA0KPiAtCUcociwgMiwgdlsyXSwgdlsgNl0s
IHZbMTBdLCB2WzE0XSk7IFwNCj4gLQlHKHIsIDMsIHZbM10sIHZbIDddLCB2WzExXSwgdlsxNV0p
OyBcDQo+IC0JRyhyLCA0LCB2WzBdLCB2WyA1XSwgdlsxMF0sIHZbMTVdKTsgXA0KPiAtCUcociwg
NSwgdlsxXSwgdlsgNl0sIHZbMTFdLCB2WzEyXSk7IFwNCj4gLQlHKHIsIDYsIHZbMl0sIHZbIDdd
LCB2WyA4XSwgdlsxM10pOyBcDQo+IC0JRyhyLCA3LCB2WzNdLCB2WyA0XSwgdlsgOV0sIHZbMTRd
KTsgXA0KPiAtfSB3aGlsZSAoMCkNCj4gLQkJUk9VTkQoMCk7DQo+IC0JCVJPVU5EKDEpOw0KPiAt
CQlST1VORCgyKTsNCj4gLQkJUk9VTkQoMyk7DQo+IC0JCVJPVU5EKDQpOw0KPiAtCQlST1VORCg1
KTsNCj4gLQkJUk9VTkQoNik7DQo+IC0JCVJPVU5EKDcpOw0KPiAtCQlST1VORCg4KTsNCj4gLQkJ
Uk9VTkQoOSk7DQoNClRoZSB2W10gdmFsdWVzIGNsZWFybHkgZG9uJ3QgY2hhbmdlIGluIHRoZSBh
Ym92ZS4NClVzZSA0IHNlcGFyYXRlIGFycmF5cyBzbyB5b3UgaGF2ZToNCg0KI2RlZmluZSBST1VO
RChyKSBkbyB7IFwNCglHKHIsIDAsIHZbMF0sIHdbMF0sIHhbMF0sIHlbMF0pOyBcDQoJRyhyLCAx
LCB2WzFdLCB3WzFdLCB4WzFdLCB5WzFdKTsgXA0KCUcociwgMiwgdlsyXSwgd1syXSwgeFsyXSwg
eVsyXSk7IFwNCglHKHIsIDMsIHZbM10sIHdbM10sIHhbM10sIHlbM10pOyBcDQoJRyhyLCA0LCB2
WzBdLCB3WzFdLCB4WzJdLCB5WzNdKTsgXA0KCUcociwgNSwgdlsxXSwgd1syXSwgeFszXSwgeVsw
XSk7IFwNCglHKHIsIDYsIHZbMl0sIHdbM10sIHhbMF0sIHlbMV0pOyBcDQoJRyhyLCA3LCB2WzNd
LCB3WzBdLCB4WzFdLCB5WzJdKTsgXA0KDQpOb3cgZG91YmxlIHRoZSBzaXplcyBvZiB2L3cveC95
IGFycmF5IGFuZCB3cml0ZSB0aGUgY29ycmVjdA0KdmFsdWVzIHdoZW4gdGhleSBhcmUgY3JlYXRl
ZC91cGRhdGVkIGFuZCB5b3UgZ2V0Og0KDQojZGVmaW5lIFJPVU5EKHIpIGRvIHsgXA0KCUcociwg
MCwgdlswXSwgd1swXSwgeFswXSwgeVswXSk7IFwNCglHKHIsIDEsIHZbMV0sIHdbMV0sIHhbMV0s
IHlbMV0pOyBcDQoJRyhyLCAyLCB2WzJdLCB3WzJdLCB4WzJdLCB5WzJdKTsgXA0KCUcociwgMywg
dlszXSwgd1szXSwgeFszXSwgeVszXSk7IFwNCglHKHIsIDQsIHZbNF0sIHdbNF0sIHhbNF0sIHlb
NF0pOyBcDQoJRyhyLCA1LCB2WzVdLCB3WzVdLCB4WzVdLCB5WzVdKTsgXA0KCUcociwgNiwgdls2
XSwgd1s2XSwgeFs2XSwgeVs2XSk7IFwNCglHKHIsIDcsIHZbN10sIHdbN10sIHhbN10sIHlbN10p
OyBcDQoNCk9oIC0gdGhhdCBpcyBhIG5pY2UgbG9vcC4uLg0KU28gd2UgZ2V0Og0KCWZvciAociA9
IDA7IHIgPCAxMDsgcisrKQ0KCQlmb3IgKGogPSAwOyBqIDwgODsgaisrKQ0KCQkJRyhyLCBqLCB2
W2pdLCB3W2pdLCB4W2pdLCB5W2pdKTsNCg0KV2hpY2ggaXMgbGlrZWx5IHRvIGJlIGp1c3QgYXMg
ZmFzdCBhcyBhbnkgb3RoZXIgdmVyc2lvbi4NCg0KWW91IG1pZ2h0IG5lZWQgdG8gZ2l2ZSB0aGUg
Y29tcGlsZXIgc29tZSBncmVhdCBiaWcgaGludHMNCmluIG9yZGVyIHRvIGdldCBzZW5zaWJsZSBj
b2RlLg0KUG9zc2libGUgbWFrZSB2W10gd1tdIHhbXSBhbmQgeVtdIGFsbCB2b2xhdGlsZSBhbmQg
cmVwbGFjZQ0KdGhlIGlubmVyIGxvb3AgYm9keSB3aXRoOg0KCQkJdl9qID0gdltqXTsgd19qID0g
eFtqXTsgeF9qID0geFtqXTsgeV9qID0geltqXTsNCgkJCUcociwgaiwgdl9qLCB3X2osIHhfaiwg
eV9qKTsNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

