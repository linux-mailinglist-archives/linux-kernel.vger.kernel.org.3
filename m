Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8424B4545
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242690AbiBNJMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:12:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiBNJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:12:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 544216005F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:12:05 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-225-3ObD8h0vMEC7W4ZlGhGL-Q-1; Mon, 14 Feb 2022 09:12:02 +0000
X-MC-Unique: 3ObD8h0vMEC7W4ZlGhGL-Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 14 Feb 2022 09:12:01 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 14 Feb 2022 09:12:01 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Helge Deller' <deller@gmx.de>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Subject: RE: [PATCH] fat: Use pointer to d_name[0] in put_user() for compat
 case
Thread-Topic: [PATCH] fat: Use pointer to d_name[0] in put_user() for compat
 case
Thread-Index: AQHYISaVap2r7qAO+E+IsFLjJVJIxKySvtow
Date:   Mon, 14 Feb 2022 09:12:01 +0000
Message-ID: <49a26b7a30254d9fb9653c2f815eaa28@AcuMS.aculab.com>
References: <YgmB01p+p45Cihhg@p100>
In-Reply-To: <YgmB01p+p45Cihhg@p100>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSGVsZ2UgRGVsbGVyDQo+IFNlbnQ6IDEzIEZlYnJ1YXJ5IDIwMjIgMjI6MTANCj4gDQo+
IFRoZSBwdXRfdXNlcih2YWwscHRyKSBtYWNybyB3YW50cyBhIHBvaW50ZXIgaW4gdGhlIHNlY29u
ZCBwYXJhbWV0ZXIsIGJ1dCBpbg0KPiBmYXRfaW9jdGxfZmlsbGRpcigpIHRoZSBkX25hbWUgZmll
bGQgcmVmZXJlbmNlcyBhIHdob2xlICJhcnJheSBvZiBjaGFycyIuDQo+IFVzdWFsbHkgdGhlIGNv
bXBpbGVyIGF1dG9tYXRpY2FsbHkgY29udmVydHMgaXQgYW5kIHVzZXMgYSBwb2ludGVyIHRvIHRo
YXQNCj4gYXJyYXksIGJ1dCBpdCdzIG1vcmUgY2xlYW4gdG8gZXhwbGljaXRseSBnaXZlIHRoZSBy
ZWFsIHBvaW50ZXIgdG8gd2hlcmUgc29tZXRpbmcNCj4gaXMgcHV0LCB3aGljaCBpcyBpbiB0aGlz
IGNhc2UgdGhlIGZpcnN0IGNoYXJhY3RlciBvZiB0aGUgZF9uYW1lW10gYXJyYXkuDQoNClRoYXQg
anVzdCBpc24ndCB0cnVlLg0KDQpJbiBDIGJvdGggeC0+Y2hhcl9hcnJheSBhbmQgJngtPmNoYXJf
YXJyYXlbMF0gaGF2ZSB0aGUgc2FtZSB0eXBlDQonY2hhciAqJy4NCg0KVGhlICdidWcnIGlzIGNh
dXNlZCBieSBwdXRfdXNlcigpIHRyeWluZyB0byBkbzoNCglfX3R5cGVvZl9fKHB0cikgX19wdHIg
PSBwdHI7DQp3aGVyZSBfX3R5cGVvZl9fIGlzIHJldHVybmluZyBjaGFyW25dIG5vdCBjaGFyICou
DQoNCkkndmUgdHJpZWQgYSBmZXcgdGhpbmdzIGJ1dCBjYW4ndCBnZXQgX190eXBlb2ZfXyB0bw0K
Z2VuZXJhdGUgYSBzdWl0YWJsZSB0eXBlIGZvciBib3RoIGEgc2ltcGxlIHR5cGUgYW5kIGFycmF5
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

