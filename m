Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206BC4CA05F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiCBJNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbiCBJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:12:59 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC84691AF5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:12:13 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-278-MEmbiGbIPIyUOgTOJzWK-g-1; Wed, 02 Mar 2022 09:12:11 +0000
X-MC-Unique: MEmbiGbIPIyUOgTOJzWK-g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 2 Mar 2022 09:12:03 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 2 Mar 2022 09:12:03 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vitaly Wool' <vitaly.wool@konsulko.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH 6/9] mm/z3fold: move decrement of pool->pages_nr into
 __release_z3fold_page()
Thread-Topic: [PATCH 6/9] mm/z3fold: move decrement of pool->pages_nr into
 __release_z3fold_page()
Thread-Index: AQHYJXLUWbfrUcWr0kay123DGS2luaybEHRggAJBAQCAAB+8MIAOY9mAgAALC+A=
Date:   Wed, 2 Mar 2022 09:12:02 +0000
Message-ID: <bd5c8187c4034016a22977c9ca54c1b0@AcuMS.aculab.com>
References: <20220219092533.12596-1-linmiaohe@huawei.com>
 <20220219092533.12596-7-linmiaohe@huawei.com>
 <dba43259e1fe4e36a0bdbe97efaaca2f@AcuMS.aculab.com>
 <baeab92c-d966-2dc2-d952-c7f3faf2a229@huawei.com>
 <03647389a32045f38ec18b090548a26d@AcuMS.aculab.com>
 <CAM4kBBLoaESLRr28kZ901e-nikDbnQnUu9h47OsA2phxp-pvuA@mail.gmail.com>
In-Reply-To: <CAM4kBBLoaESLRr28kZ901e-nikDbnQnUu9h47OsA2phxp-pvuA@mail.gmail.com>
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

PiA+IEF0b21pYyBvcGVyYXRpb25zIGFyZW4ndCBtYWdpYy4NCj4gPiBBdG9taWMgb3BlcmF0aW9u
cyBhcmUgKGF0IGJlc3QpIG9uZSBzbG93IGxvY2tlZCBidXMgY3ljbGUuDQo+ID4gQWNxdWlyaW5n
IGEgbG9jayBpcyB0aGUgc2FtZS4NCj4gPiBSZWxlYXNpbmcgYSBsb2NrIG1pZ2h0IGJlIGNoZWFw
ZXIsIGJ1dCBpcyBwcm9iYWJseSBhIGxvY2tlZCBidXMgY3ljbGUuDQo+ID4NCj4gPiBTbyBpZiB5
b3UgdXNlIHN0YXRlX2xvY2sgdG8gcHJvdGVjdCBwYWdlc19uciB0aGVuIHlvdSBsb3NlIGFuIGF0
b21pYw0KPiA+IG9wZXJhdGlvbiBmb3IgdGhlIGRlY3JlbWVudCBhbmQgZ2FpbiBvbmUgKGZvciB0
aGUgdW5sb2NrKSBpbiB0aGUgaW5jcmVtZW50Lg0KPiA+IFRoYXQgaXMgZXZlbiBvciBtYXliZSBh
IHNsaWdodCBnYWluLg0KPiA+IE9UT0ggYSA2NGJpdCBhdG9taWMgaXMgYSBQSVRBIG9uIHNvbWUg
MzJiaXQgc3lzdGVtcy4NCj4gPiAoSW4gZmFjdCBhbnkgYXRvbWljIGlzIGEgUElUQSBvbiBzcGFy
YzMyLikNCj4gDQo+IEl0J3MgYWN0dWFsbHkgKnN0YWxlX2xvY2sqIGFuZCBpdCdzIHZlcnkgbWlz
bGVhZGluZyB0byB1c2UgaXQgZm9yIHRoaXMuDQo+IEkgd291bGQgYWN0dWFsbHkgbGlrZSB0byBr
ZWVwIGF0b21pY3MgYnV0IEkgaGF2ZSBubyBwcm9ibGVtIHdpdGgNCj4gbWFraW5nIGl0IDMyLWJp
dCBmb3IgMzItYml0IHN5c3RlbXMuIFdvdWxkIHRoYXQgd29yayBmb3IgeW91IGd1eXM/DQoNCkl0
IHdvdWxkIGJlIGJldHRlciB0byByZW5hbWUgdGhlIGxvY2suDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

