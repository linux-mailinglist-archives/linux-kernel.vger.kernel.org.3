Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBF84B53E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352214AbiBNO5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:57:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiBNO5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:57:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2BF2C4C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:57:08 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-214-fl88X-xMPqWO--GZQOB3Tw-1; Mon, 14 Feb 2022 14:57:06 +0000
X-MC-Unique: fl88X-xMPqWO--GZQOB3Tw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 14 Feb 2022 14:57:05 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 14 Feb 2022 14:57:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Geert Uytterhoeven' <geert@linux-m68k.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Joshua Kinard <kumba@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Lennart Poettering" <mzxreary@0pointer.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: RE: [PATCH RFC v0] random: block in /dev/urandom
Thread-Topic: [PATCH RFC v0] random: block in /dev/urandom
Thread-Index: AQHYIa/RMksFr1LZVEWsiQom7rZ3n6yTITWQ
Date:   Mon, 14 Feb 2022 14:57:05 +0000
Message-ID: <63afd299c8df4495b27456a7f92aec75@AcuMS.aculab.com>
References: <20220211210757.612595-1-Jason@zx2c4.com>
 <fcab986b-d0bd-c798-de17-266abcdc7da2@gentoo.org>
 <CAHmME9ooEbgiv3DRk87ei+rUoVNMJthY7UuG_xCgm=kfMZAajw@mail.gmail.com>
 <CAMuHMdXDj+BVCs4Syg39vjnHGKcwJnCgDxrGoOiEFM_T4ojwPg@mail.gmail.com>
In-Reply-To: <CAMuHMdXDj+BVCs4Syg39vjnHGKcwJnCgDxrGoOiEFM_T4ojwPg@mail.gmail.com>
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

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuDQo+IFNlbnQ6IDE0IEZlYnJ1YXJ5IDIwMjIgMTQ6MjYN
Ci4uLg0KPiBJJ20gYWZyYWlkIHlvdSBtaXNzZWQgb25lIGltcG9ydGFudCBkZXRhaWwuICBZb3Ug
d3JvdGU6DQo+IA0KPiA+IE9uIGV2ZXJ5IHBsYXRmb3JtLCByYW5kb21fZ2V0X2VudHJvcHkoKSBp
cyBjb25uZWN0ZWQgdG8gZ2V0X2N5Y2xlcygpLA0KPiA+IGV4Y2VwdCBmb3IgdGhyZWU6IG02OGss
IE1JUFMsIGFuZCBSSVNDLVYuDQo+IA0KPiBUaGUgZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiBpbiBp
bmNsdWRlL2FzbS1nZW5lcmljL3RpbWV4LmggaXM6DQo+IA0KPiAgICAgc3RhdGljIGlubGluZSBj
eWNsZXNfdCBnZXRfY3ljbGVzKHZvaWQpDQo+ICAgICB7DQo+ICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiAgICAgfQ0KPiANCj4gU2V2ZXJhbCBhcmNoaXRlY3R1cmVzIGRvIG5vdCBpbXBsZW1lbnQg
Z2V0X2N5Y2xlcygpLCBvciBpbXBsZW1lbnQgaXQNCj4gd2l0aCBhIHZhcmlhbnQgdGhhdCdzIHZl
cnkgc2ltaWxhciBvciBpZGVudGljYWwgdG8gdGhlIGdlbmVyaWMgdmVyc2lvbi4NCg0KQWRkIHRv
IHRoZSBsaXN0IG5pb3MyIGFuZCBvbGQgeDg2IChJIHRoaW5rIHJkdHNjIGlzIGEgcGVudGl1bSBp
bnN0cnVjdGlvbikNCkkgY2FuJ3Qgc2VlIGl0IGluIG15IDM4NiBib29rLCBhbmQgaSBkb24ndCB0
aGluayA0ODYgYWRkZWQgaXQuDQoNCkknbSBub3Qgc3VyZSBpZi93aGVuIHNwYXJjIGFkZGVkIG9u
ZS4NCkkgZG9uJ3QgcmVtZW1iZXIgaXQgYmVpbmcgdGhlcmUgaW4gdGhlIGxhdGUgMTk4MHMuDQoN
Cm5pb3MyIChzb2Z0IGNwdSBvbiBBbHRlcmEvSW50ZWwgZnBnYSkgaXMgYW5ub3lpbmcuDQpUaGVy
ZSBpcyBhICdyZWFkIGNvbnRyb2wgcmVnaXN0ZXInIGluc3RydWN0aW9uIGFuZCBwbGVudHkgb2Yg
c3BhY2Ugb25lcy4NCkJ1dCB5b3UgY2FuJ3QgZGVmaW5lIHlvdXIgb3duIGFuZCBvbmUgaXNuJ3Qg
YSBjbG9jayBjb3VudGVyLg0KWW91IGNhbiBhZGQgb25lIGFzIHRoZSByZXN1bHQgb2YgYSBjdXN0
b20gaW5zdHJ1Y3Rpb24uDQooRXZlbiB0aGUgc2FtZSBjdXN0b20gaW5zdHJ1Y3Rpb24gdGhhdCBk
b2VzIGJ5dGVzd2FwLikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

