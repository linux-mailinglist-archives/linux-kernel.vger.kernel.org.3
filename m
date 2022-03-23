Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60AF4E53D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiCWODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbiCWODH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:03:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21BB57484E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:01:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-62-d9WQqktKNfuEPIK2YXUnUQ-1; Wed, 23 Mar 2022 14:01:34 +0000
X-MC-Unique: d9WQqktKNfuEPIK2YXUnUQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 23 Mar 2022 14:01:34 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 23 Mar 2022 14:01:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
CC:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sandy Harris <sandyinchina@gmail.com>
Subject: RE: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Thread-Topic: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Thread-Index: AQHYPnEnHr6Egf4vbEGW28icqj7YNKzM/Low
Date:   Wed, 23 Mar 2022 14:01:34 +0000
Message-ID: <7cde489e73c8448b95a1b7bc6ed1d75b@AcuMS.aculab.com>
References: <20220322191436.110963-1-Jason@zx2c4.com>
 <1648009787.fah6dos6ya.none@localhost>
 <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
In-Reply-To: <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
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

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkDQo+IFNlbnQ6IDIzIE1hcmNoIDIwMjIgMDQ6NDgNCi4u
Lg0KPiAtIFBsZW50eSBvZiB0aGluZ3MgYXJlIHNlZWRpbmcgdGhlIFJORyBjb3JyZWN0bHksIGFu
ZCBidWlsZHJvb3Qncw0KPiBzaGVsbCBzY3JpcHQgaXMganVzdCAiZG9pbmcgaXQgd3JvbmciLg0K
PiANCj4gT24gdGhhdCBsYXN0IHBvaW50LCBJIHNob3VsZCByZWl0ZXJhdGUgdGhhdCBidWlsZHJv
b3QncyBzaGVsbCBzY3JpcHQNCj4gc3RpbGwgaXNuJ3QgYWN0dWFsbHkgaW5pdGlhbGl6aW5nIHRo
ZSBSTkcsIGRlc3BpdGUgd2hhdCBpdCBzYXlzIGluIGl0cw0KPiBlY2hvOyB0aGVyZSdzIG5ldmVy
IGJlZW4gYSB3YXkgdG8gaW5pdGlhbGl6ZSB0aGUgUk5HIGZyb20gYSBzaGVsbA0KPiBzY3JpcHQs
IHdpdGhvdXQgY2FsbGluZyBvdXQgdG8gdmFyaW91cyBzcGVjaWFsIHB1cnBvc2UgaW9jdGwtYXdh
cmUNCj4gYmluYXJpZXMuDQoNClBlcmhhcHMgdGhlIHZlcnkgZmlyc3Qgd3JpdGUgYWZ0ZXIgYm9v
dCBjb3VsZCBiZSBhc3N1bWVkIHRvDQpiZSB2YWxpZCBpbml0aWFsaXNhdGlvbiBkYXRhPw0KKE9u
IHRvcCBvZiBhIGZldyBvdGhlciB0ZXN0cy4pDQoNClRoZW4gSSBuZWVkIGEgcGF0Y2ggYWdhaW5z
dCA1LjEwIDotKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

