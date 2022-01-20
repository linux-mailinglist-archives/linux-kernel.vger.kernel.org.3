Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6F04951BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376591AbiATPqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:46:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53994 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376526AbiATPqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:46:23 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-193-7WTwajXxOa6GXzO1g1m_hA-1; Thu, 20 Jan 2022 15:46:20 +0000
X-MC-Unique: 7WTwajXxOa6GXzO1g1m_hA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 20 Jan 2022 15:46:18 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 20 Jan 2022 15:46:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>, Guo Ren <guoren@kernel.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "inux-parisc@vger.kernel.org" <inux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: RE: [PATCH V3 07/17] riscv: compat: Re-implement TASK_SIZE for
 COMPAT_32BIT
Thread-Topic: [PATCH V3 07/17] riscv: compat: Re-implement TASK_SIZE for
 COMPAT_32BIT
Thread-Index: AQHYDePReMzknTU7UkCjQWPLhaJn7Kxr3G8ggAAj9ueAAAuaMA==
Date:   Thu, 20 Jan 2022 15:46:18 +0000
Message-ID: <01a8da9e5a374373a922e569a1e10ee8@AcuMS.aculab.com>
References: <20220120073911.99857-8-guoren@kernel.org>
 <CAK8P3a1UvqsS-D7cVXBkp4KCRWDfquQ6QTkvrQ=FqLxhsAi7Rw@mail.gmail.com>
 <f16cf10425a14c2e8183d5c90667ce72@AcuMS.aculab.com>
 <CAJF2gTRwh40xDBkoRJWZEUketKFDAy7_z=-WW7E=T46yH4zPvw@mail.gmail.com>
 <CAK8P3a3FLnqibdXCGR8c+mm92HSiuvocZDeW8MyoTO_L1sYT=w@mail.gmail.com>
In-Reply-To: <CAK8P3a3FLnqibdXCGR8c+mm92HSiuvocZDeW8MyoTO_L1sYT=w@mail.gmail.com>
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

Li4uDQo+IE9uZSBleGFtcGxlIG9mIHNvZnR3YXJlIHRoYXQgcnVucyBpbnRvIHZpcnR1YWwgbWVt
b3J5IHNpemUgbGltaXRhdGlvbnMgaXMNCj4gdGhlIGdudSBsaW5rZXIgd2hlbiBidWlsZGluZyBs
YXJnZSBhcHBsaWNhdGlvbnMsIGJ1dCBpdCdzIHVubGlrZWx5IHRoYXQgeW91J2xsDQo+IGFjdHVh
bGx5IG5lZWQgdG8gcnVuIGFwcGxpY2F0aW9ucyB0aGF0IHJ1biBpbnRvIHRoaXMsIHdoaWxlIGFs
c28gbmVlZGluZyB0bw0KPiBidWlsZCB0aGVtIG5hdGl2ZWx5Lg0KDQpUaGVyZSBhcmUgYWxzbyBk
YXRhYmFzZSBwcm9ncmFtcyB0aGF0IHdhbnQgdG8gbW1hcCgpIGxhcmdlIHNwYXJzZSBmaWxlcy4N
ClRvIHNvbWUgZXh0ZW50IHRoYXQgaXMgd2hlcmUgdGhlIHByZXNzdXJlIGZvciA2NGJpdCBhZGRy
ZXNzZXMgY29tZXMgZnJvbS4NCg0KV2hpbGUgKEkgdGhpbmspIG1vc3Qgb2YgdGhlIGN1cnJlbnQg
cmlzY3Ygc3lzdGVtcyBhcmUgJ3RveScgb25lcw0KdGhlcmUgYXJlIGRlZmluaXRlbHkgcHJlc3Mg
cmVwb3J0cyBvZiBzb21lIHF1aXRlIGhpZ2ggcG93ZXIgc3lzdGVtcy4NCg0KSSBzdXNwZWN0IHRo
ZXkgYXJlIGxlc3MgJ3RveScgdGhhbiB0aGUgQWx0ZXJhIChJbnRlbCkgTmlvcyBwcm9jZXNzb3Jz
DQp3ZSB1c2Ugb24gb3V0IGZwZ2EgLSB5b3UgY2FuIHJ1biBsaW51eCBvbiB0aGUgTmlvcyBjcHUs
IGJ1dCB5b3UgcHJvYmFibHkNCmRvbid0IHJlYWxseSB3YW50IHRvIGRvIHNvLg0KQmV0dGVyIHRv
IGZpbmQgYW4gZnBnYSB3aXRoIGEgJ3Byb3BlcicgQVJNIGNvcmUgaW4gdGhlIGNvcm5lci4NCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

