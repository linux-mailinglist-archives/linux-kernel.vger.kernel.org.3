Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1051D573305
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiGMJj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiGMJj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:39:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E0E6F54F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:39:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-220-jNhFV5uvMoyY8ZVNPGX1qw-1; Wed, 13 Jul 2022 10:39:48 +0100
X-MC-Unique: jNhFV5uvMoyY8ZVNPGX1qw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 13 Jul 2022 10:39:43 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 13 Jul 2022 10:39:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yu-Jen Chang' <arthurchang09@gmail.com>,
        Andrey Semashev <andrey.semashev@gmail.com>
CC:     "andy@kernel.org" <andy@kernel.org>,
        "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] lib/string.c: Optimize memchr()
Thread-Topic: [PATCH 2/2] lib/string.c: Optimize memchr()
Thread-Index: AQHYlf/m+SYzYfFyd0Sny8eSVHr68K18Ceug
Date:   Wed, 13 Jul 2022 09:39:43 +0000
Message-ID: <49a8be9269ee47de9fc2d0d7f09eb0b1@AcuMS.aculab.com>
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com>
 <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
 <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com>
 <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com>
 <CAD4RrFPfwu4Ascj5tdz8qq2Qgnu5GN2eHjVwMW5AqUa1H7JapA@mail.gmail.com>
In-Reply-To: <CAD4RrFPfwu4Ascj5tdz8qq2Qgnu5GN2eHjVwMW5AqUa1H7JapA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWXUtSmVuIENoYW5nDQo+IFNlbnQ6IDEyIEp1bHkgMjAyMiAxNTo1OQ0KLi4uDQo+ID4g
SSB0aGluayB5b3UncmUgbWlzc2luZyB0aGUgcG9pbnQuIExvYWRzIGF0IHVuYWxpZ25lZCBhZGRy
ZXNzZXMgbWF5IG5vdA0KPiA+IGJlIGFsbG93ZWQgYnkgaGFyZHdhcmUgdXNpbmcgY29udmVudGlv
bmFsIGxvYWQgaW5zdHJ1Y3Rpb25zIG9yIG1heSBiZQ0KPiA+IGluZWZmaWNpZW50LiBHaXZlbiB0
aGF0IHRoaXMgbWVtY2hyIGltcGxlbWVudGF0aW9uIGlzIHVzZWQgYXMgYSBmYWxsYmFjaw0KPiA+
IHdoZW4gbm8gaGFyZHdhcmUtc3BlY2lmaWMgdmVyc2lvbiBpcyBhdmFpbGFibGUsIHlvdSBzaG91
bGQgYmUNCj4gPiBjb25zZXJ2YXRpdmUgd3J0LiBoYXJkd2FyZSBjYXBhYmlsaXRpZXMgYW5kIGJl
aGF2aW9yLiBZb3Ugc2hvdWxkDQo+ID4gcHJvYmFibHkgaGF2ZSBhIHByZS1hbGlnbm1lbnQgbG9v
cC4NCj4gDQo+IEdvdCBpdC4gSSBhZGQgIHByZS1hbGlnbm1lbnQgbG9vcC4gSXQgYWxpZ25zIHRo
ZSBhZGRyZXNzIHRvIDggb3IgNGJ5dGVzLg0KDQpUaGF0IHNob3VsZCBiZSBwcmVkaWNhdGVkIG9u
ICFIQVNfRUZGSUNJRU5UX1VOQUxJR05FRF9BQ0NFU1MuDQoNCi4uLg0KPiAgICAgICAgIGZvciAo
OyBwIDw9IGVuZCAtIDg7IHAgKz0gOCkgew0KPiAgICAgICAgICAgICB2YWwgPSAqKHU2NCopcCBe
IG1hc2s7DQo+ICAgICAgICAgICAgIGlmICgodmFsICsgMHhmZWZlZmVmZWZlZmVmZWZmdWxsKQ0K
PiAmICh+dmFsICYgMHg4MDgwODA4MDgwODA4MDgwdWxsKSkNCj4gICAgICAgICAgICAgICAgIGJy
ZWFrOw0KDQpJIHdvdWxkIGFkZCBhIGNvdXBsZSBvZiBjb21tZW50cywgbGlrZToNCgkvLyBDb252
ZXJ0IHRvIGNoZWNrIGZvciB6ZXJvIGJ5dGUuDQoJLy8gU3RhbmRhcmQgY2hlY2sgZm9yIGEgemVy
byBieXRlIGluIGEgd29yZC4NCihCdXQgbm90IHRoZSBiaWcgNCBsaW5lIGV4cGxhbmF0aW9uIHlv
dSBoYWQuDQoNCkl0IGlzIGFsc28gd29ydGggbG9va2luZyBhdCBob3cgdGhhdCBjb2RlIGNvbXBp
bGVzDQpvbiAzMmJpdCBhcmNoIHRoYXQgZG9uJ3QgaGF2ZSBhIGNhcnJ5IGZsYWcuDQpUaGF0IGlz
IGV2ZXJ5dGhpbmcgYmFzZWQgb24gTUlQUywgaW5jbHVkaW5nIHJpc2N2Lg0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K

