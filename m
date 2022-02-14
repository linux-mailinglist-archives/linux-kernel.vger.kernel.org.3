Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0884B45A2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242897AbiBNJ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:26:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiBNJ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:26:31 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 150C260A8B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:26:23 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-313-sjXgZp0fOm66Vo-KMrSp4w-1; Mon, 14 Feb 2022 09:26:21 +0000
X-MC-Unique: sjXgZp0fOm66Vo-KMrSp4w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 14 Feb 2022 09:26:20 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 14 Feb 2022 09:26:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Helge Deller' <deller@gmx.de>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Subject: RE: [PATCH] fat: Use pointer to d_name[0] in put_user() for compat
 case
Thread-Topic: [PATCH] fat: Use pointer to d_name[0] in put_user() for compat
 case
Thread-Index: AQHYISaVap2r7qAO+E+IsFLjJVJIxKySvtowgAAIGvA=
Date:   Mon, 14 Feb 2022 09:26:20 +0000
Message-ID: <0ecb87dcc4cf42328f1f5a7d6abd08ed@AcuMS.aculab.com>
References: <YgmB01p+p45Cihhg@p100>
 <49a26b7a30254d9fb9653c2f815eaa28@AcuMS.aculab.com>
In-Reply-To: <49a26b7a30254d9fb9653c2f815eaa28@AcuMS.aculab.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDE0IEZlYnJ1YXJ5IDIwMjIgMDk6MTINCj4gDQo+
IEZyb206IEhlbGdlIERlbGxlcg0KPiA+IFNlbnQ6IDEzIEZlYnJ1YXJ5IDIwMjIgMjI6MTANCj4g
Pg0KPiA+IFRoZSBwdXRfdXNlcih2YWwscHRyKSBtYWNybyB3YW50cyBhIHBvaW50ZXIgaW4gdGhl
IHNlY29uZCBwYXJhbWV0ZXIsIGJ1dCBpbg0KPiA+IGZhdF9pb2N0bF9maWxsZGlyKCkgdGhlIGRf
bmFtZSBmaWVsZCByZWZlcmVuY2VzIGEgd2hvbGUgImFycmF5IG9mIGNoYXJzIi4NCj4gPiBVc3Vh
bGx5IHRoZSBjb21waWxlciBhdXRvbWF0aWNhbGx5IGNvbnZlcnRzIGl0IGFuZCB1c2VzIGEgcG9p
bnRlciB0byB0aGF0DQo+ID4gYXJyYXksIGJ1dCBpdCdzIG1vcmUgY2xlYW4gdG8gZXhwbGljaXRs
eSBnaXZlIHRoZSByZWFsIHBvaW50ZXIgdG8gd2hlcmUgc29tZXRpbmcNCj4gPiBpcyBwdXQsIHdo
aWNoIGlzIGluIHRoaXMgY2FzZSB0aGUgZmlyc3QgY2hhcmFjdGVyIG9mIHRoZSBkX25hbWVbXSBh
cnJheS4NCj4gDQo+IFRoYXQganVzdCBpc24ndCB0cnVlLg0KPiANCj4gSW4gQyBib3RoIHgtPmNo
YXJfYXJyYXkgYW5kICZ4LT5jaGFyX2FycmF5WzBdIGhhdmUgdGhlIHNhbWUgdHlwZQ0KPiAnY2hh
ciAqJy4NCj4gDQo+IFRoZSAnYnVnJyBpcyBjYXVzZWQgYnkgcHV0X3VzZXIoKSB0cnlpbmcgdG8g
ZG86DQo+IAlfX3R5cGVvZl9fKHB0cikgX19wdHIgPSBwdHI7DQo+IHdoZXJlIF9fdHlwZW9mX18g
aXMgcmV0dXJuaW5nIGNoYXJbbl0gbm90IGNoYXIgKi4NCj4gDQo+IEkndmUgdHJpZWQgYSBmZXcg
dGhpbmdzIGJ1dCBjYW4ndCBnZXQgX190eXBlb2ZfXyB0bw0KPiBnZW5lcmF0ZSBhIHN1aXRhYmxl
IHR5cGUgZm9yIGJvdGggYSBzaW1wbGUgdHlwZSBhbmQgYXJyYXkuDQoNCkFjdHVhbGx5IHRoZSBp
c3N1ZSBpcyB0aGF0IHB1dF91c2VyKCkgd3JpdGVzIGEgc2luZ2xlIHZhcmlhYmxlDQphbmQgbmVl
ZHMgYSBwb2ludGVyIHRvIG9uZS4NClNvIGNoYW5naW5nIHRvOg0KCXB1dF91c2VyKDAsICZhcnJh
eVswXSk7DQppcyBwcm9iYWJseSBmaW5lLg0KQnV0IHRoZSBkZXNjcmlwdGlvbiBpcyBhbGwgd3Jv
bmcuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

