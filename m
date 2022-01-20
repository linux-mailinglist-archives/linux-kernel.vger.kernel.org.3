Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E698494E60
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbiATMyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:54:18 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:30089 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245222AbiATMxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:53:17 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-XSo6eQ28MlKlbqVx3cst0g-1; Thu, 20 Jan 2022 12:53:13 +0000
X-MC-Unique: XSo6eQ28MlKlbqVx3cst0g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 20 Jan 2022 12:53:11 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 20 Jan 2022 12:53:11 +0000
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
Thread-Index: AQHYDePReMzknTU7UkCjQWPLhaJn7Kxr3G8g
Date:   Thu, 20 Jan 2022 12:53:11 +0000
Message-ID: <f16cf10425a14c2e8183d5c90667ce72@AcuMS.aculab.com>
References: <20220120073911.99857-8-guoren@kernel.org>
 <CAK8P3a1UvqsS-D7cVXBkp4KCRWDfquQ6QTkvrQ=FqLxhsAi7Rw@mail.gmail.com>
In-Reply-To: <CAK8P3a1UvqsS-D7cVXBkp4KCRWDfquQ6QTkvrQ=FqLxhsAi7Rw@mail.gmail.com>
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

PiA+IExpbWl0IDMyLWJpdCBjb21wYXRpYmxlIHByb2Nlc3MgaW4gMC0yR0IgdmlydHVhbCBhZGRy
ZXNzIHJhbmdlDQo+ID4gKHdoaWNoIGlzIGVub3VnaCBmb3IgcmVhbCBzY2VuYXJpb3MpLCBiZWNh
dXNlIGl0IGNvdWxkIGF2b2lkDQo+ID4gYWRkcmVzcyBzaWduIGV4dGVuZCBwcm9ibGVtIHdoZW4g
MzItYml0IGVudGVyIDY0LWJpdCBhbmQgZWFzZQ0KPiA+IHNvZnR3YXJlIGRlc2lnbi4NCg0KRWg/
DQpJIHRob3VnaHQgbmVhcmx5IGFsbCB0aGUgb3RoZXIgMzJiaXQgdW5peCBwb3J0cyAob2YgYW55
IGZsYXZvdXIpDQpwdXQgdGhlIHVzZXIta2VybmVsIGJvdW5kYXJ5IGF0IDNHQi4NCihBcGFydCBm
cm9tIHNvbWUgdmVyeSBvbGQgc3BhcmMgb25lcyB0aGF0IHVzZSAzLjVHQi4pDQoNCjJHQiBpcyB1
c2VkIGJ5IFdpbmRvd3MuDQoNCkkgdGhpbmsgdGhlIHg4Ni02NCAzMmJpdCBjb21wYXQgY29kZSBl
dmVuIHB1dHMgdGhlIGJvdW5kYXJ5IGF0IDRHQi4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

