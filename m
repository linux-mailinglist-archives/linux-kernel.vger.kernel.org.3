Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA3534BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346691AbiEZIae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiEZIab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:30:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52C0DC3D1A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:30:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-97-sAqRUDcENEOl1Xa5Rq_sgg-1; Thu, 26 May 2022 09:30:27 +0100
X-MC-Unique: sAqRUDcENEOl1Xa5Rq_sgg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 26 May 2022 09:30:26 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 26 May 2022 09:30:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Waiman.Long@hp.com" <Waiman.Long@hp.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: RE: [PATCH 2/2] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF
 for X86_32 && X86_CMPXCHG64
Thread-Topic: [PATCH 2/2] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF
 for X86_32 && X86_CMPXCHG64
Thread-Index: AQHYcFSqEs/fOT4560eM/KOVu8Wcwa0w06LA
Date:   Thu, 26 May 2022 08:30:26 +0000
Message-ID: <48001b3d732b418eb5f36def228c2c9d@AcuMS.aculab.com>
References: <20220525144013.6481-1-ubizjak@gmail.com>
 <20220525144013.6481-3-ubizjak@gmail.com>
 <CAHk-=whXtP1XT2cVDFKK2-Xz5Z=7AFki4zwFzenm4bbf4iPJKg@mail.gmail.com>
In-Reply-To: <CAHk-=whXtP1XT2cVDFKK2-Xz5Z=7AFki4zwFzenm4bbf4iPJKg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjUgTWF5IDIwMjIgMTc6MzANCj4gDQo+IE9u
IFdlZCwgTWF5IDI1LCAyMDIyIGF0IDc6NDAgQU0gVXJvcyBCaXpqYWsgPHViaXpqYWtAZ21haWwu
Y29tPiB3cm90ZToNCj4gPg0KPiA+ICsgICAgICAgc2VsZWN0IEFSQ0hfVVNFX0NNUFhDSEdfTE9D
S1JFRiBpZiBYODZfNjQgfHwgKFg4Nl8zMiAmJiBYODZfQ01QWENIRzY0KQ0KPiANCj4gVWdoLiBU
aGF0IGxvb2tzIHBvaW50bGVzc2x5IGNvbXBsaWNhdGVkLiBYODZfNjQgYWxyZWFkeSBlbmFibGVz
DQo+IFg4Nl9DTVBYQ0hHNjQgYWZhaWssIHNvIHlvdSBjYW4ganVzdCBzYXkNCj4gDQo+ICAgICAg
ICAgc2VsZWN0IEFSQ0hfVVNFX0NNUFhDSEdfTE9DS1JFRiBpZiBYODZfQ01QWENIRzY0DQo+IA0K
PiB3aGljaCBpcyBtdWNoIGNsZWFyZXI6IENNUFhDSEdfTE9DS1JFRiBuZWVkcyBDTVBYQ0hHNjQs
IGFuZCB0aGUNCj4gS2NvbmZpZyBvcHRpb24gc2F5cyBleGFjdGx5IHRoYXQuDQo+IA0KPiBUaGF0
IHNhaWQsIHRoaXMgYWxzbyBtYWtlcyBtZSB3b25kZXIgaWYgd2Ugc2hvdWxkIGp1c3QgbWFrZSBj
bXB4Y2hnOGINCj4gcmVxdWlyZW1lbnQgdW5jb25kaXRpb25hbC4NCj4gDQo+IEdvb2dsaW5nIGFy
b3VuZCwgaXQgbG9va3MgbGlrZSBXaW5kb3dzIE5UIHN0b3BwZWQgYm9vdGluZyBvbiBDUFVzDQo+
IHdpdGhvdXQgY21weGNoZzhiIGluIHZlcnNpb24gNS4xLiBUaGF0IHdhcyBpbiAyMDAxLg0KPiAN
Cj4gSGVyZSB3ZSBhcmUsIDIxIHllYXJzIGxhdGVyLCBhbmQgd2Ugc3RpbGwgb3N0ZW5zaWJseSB0
cnkgdG8gc3VwcG9ydA0KPiBDUFVzIHdpdGhvdXQgaXQsIGJ1dCBJIGRvdWJ0IGl0J3Mgd29ydGgg
aXQuDQo+IA0KPiBTbyBtYXliZSB0aW1lIHRvIGp1c3Qgc2F5ICJ3ZSByZXF1aXJlIGNtcHhjaGc4
YiIuDQo+IA0KPiBJbiBmYWN0LCBJIHRoaW5rIHdlIGhhdmUgZWZmZWN0aXZlbHkgZG9uZSB0aGF0
IGFscmVhZHkgZm9yIHllYXJzLCBzaW5jZSB3ZSBoYXZlDQo+IA0KPiAgICAgY29uZmlnIFg4Nl9D
TVBYQ0hHNjQNCj4gICAgICAgICAgICAgZGVmX2Jvb2wgeQ0KPiAgICAgICAgICAgICBkZXBlbmRz
IG9uIFg4Nl9QQUUgfHwgLi4uDQo+IA0KPiBpb3csIGVuYWJsaW5nIFg4Nl9QQUUgd2lsbCBmb3Jj
ZS1lbmFibGUgQ01QWENIRzhCIGR1ZSB0byB0aGUgd2lkZXINCj4gcGFnZSB0YWJsZSBlbnRyaWVz
Lg0KPiANCj4gQW5kIEkgd291bGQgYXNzdW1lIHRoYXQgYWxsIGRpc3Ryb3MgYmFzaWNhbGx5IGRv
IHRoYXQgYW55d2F5IChidXQgSSBkbw0KPiBub3QgaGF2ZSBhIDMyLWJpdCBkaXN0cm8gYXJvdW5k
IHRvIGNoZWNrKS4NCj4gDQo+IEl0IHdvdWxkIG1lYW4gdGhhdCB3ZSB3b3VsZCBmaW5hbGx5IGRy
b3Agc3VwcG9ydCBmb3IgaTQ4NiAoYW5kDQo+IHBvc3NpYmx5IHNvbWUgUGVudGl1bSBjbG9uZXMs
IGJ1dCBhZmFpayBhIG51bWJlciBvZiB0aGVtIGRpZCBhY3R1YWxseQ0KPiBzdXBwb3J0IGNtcHhj
aGc4YiBldmVuIGlmIHRoZXkgZGlkbid0IHJlcG9ydCBpdCBpbiBjcHVpZCkuDQoNClBlcmhhcHMg
dGhlcmUgY291bGQgYmUgYSBub24tc21wIGltcGxlbWVudGF0aW9uIG9mIGNtcHhjaGc4Yg0KdGhh
dCBqdXN0IGRpc2FibGVzIGludGVycnVwdHM/DQoNCldoaWxlIEkgaGF2ZSB1c2VkIGEgZHVhbCA0
ODYgSSBkb3VidCBMaW51eCB3b3VsZCBydW4gZXZlcg0KaGF2ZSBvbiBpdC4gVGhlIHNhbWUgaXMg
cHJvYmFibHkgdHJ1ZSBmb3Igb2xkIGR1YWwgUGVudGl1bXMuDQoNCkkgdGhpbmsgdGhlcmUgYXJl
IHN0aWxsIHNvbWUgNDg2LWNsYXNzIGVtYmVkZGVkIGNwdSB0aGF0IGluY2x1ZGUNCmEgZmV3IG9m
IHRoZSBuZXdlciBpbnN0cnVjdGlvbnMgKHVzdWFsbHkgdGhpbmdzIGxpa2UgcmR0c2MpLg0KQnV0
IHRoZXkgd29uJ3QgYmUgc21wLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

