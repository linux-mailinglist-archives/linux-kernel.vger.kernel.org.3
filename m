Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267664E428E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiCVPM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbiCVPM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:12:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03EC526579
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:11:26 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-38-m6P3iw8WNlquIKDhm_nF4w-1; Tue, 22 Mar 2022 15:11:23 +0000
X-MC-Unique: m6P3iw8WNlquIKDhm_nF4w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 22 Mar 2022 15:11:23 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 22 Mar 2022 15:11:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alviro Iskandar Setiawan' <alviro.iskandar@gnuweeb.org>
CC:     Willy Tarreau <w@1wt.eu>, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Topic: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Index: AQHYPdalMvftIu2CIkSH1LImoy2kmazLRP7AgAAL3z2AABVNYIAAFcoAgAAGBOA=
Date:   Tue, 22 Mar 2022 15:11:23 +0000
Message-ID: <3d2cfdeecddc45dc8e4beada305b5948@AcuMS.aculab.com>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
 <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
 <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
 <20220322121338.GD10306@1wt.eu>
 <22fd9709b3a64a548226741b682ca155@AcuMS.aculab.com>
 <CAOG64qP=Hn+Z6zO2pEafE4acLiGig79OCPQCAktb4bhV6DFBAg@mail.gmail.com>
In-Reply-To: <CAOG64qP=Hn+Z6zO2pEafE4acLiGig79OCPQCAktb4bhV6DFBAg@mail.gmail.com>
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

RnJvbTogQWx2aXJvIElza2FuZGFyIFNldGlhd2FuDQo+IFNlbnQ6IDIyIE1hcmNoIDIwMjIgMTQ6
NDgNCj4gDQo+IE9uIFR1ZSwgTWFyIDIyLCAyMDIyIGF0IDg6MzcgUE0gRGF2aWQgTGFpZ2h0IHdy
b3RlOg0KPiA+IGR1bm5vLCAnYXNtJyByZWdpc3RlciB2YXJpYWJsZXMgYXJlIHJhdGhlciBtb3Jl
IGhvcnJpZCBhbmQNCj4gPiBzaG91bGQgcHJvYmFibHkgb25seSBiZSB1c2VkIChmb3IgYXNtIHN0
YXRlbWVudHMpIHdoZW4gdGhlcmUgYXJlbid0DQo+ID4gc3VpdGFibGUgcmVnaXN0ZXIgY29uc3Ry
YWludHMuDQo+ID4NCj4gPiAoSSdtIHN1cmUgdGhlcmUgaXMgYSBjb21tZW50IGFib3V0IHRoYXQg
aW4gdGhlIGdjYyBkb2NzLikNCj4gDQo+IEkgZG9uJ3QgZmluZCB0aGUgY29tbWVudCB0aGF0IHNh
eXMgc28gaGVyZToNCj4gaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djYy9Mb2NhbC1S
ZWdpc3Rlci1WYXJpYWJsZXMuaHRtbA0KDQpJJ3ZlIHByb2JhYmx5IGluZmVycmVkIGl0IGZyb206
DQogICAgIlRoZSBvbmx5IHN1cHBvcnRlZCB1c2UgZm9yIHRoaXMgZmVhdHVyZSBpcyB0byBzcGVj
aWZ5IHJlZ2lzdGVycyBmb3INCiAgICBpbnB1dCBhbmQgb3V0cHV0IG9wZXJhbmRzIHdoZW4gY2Fs
bGluZyBFeHRlbmRlZCBhc20gKHNlZSBFeHRlbmRlZCBBc20pLg0KICAgIFRoaXMgbWF5IGJlIG5l
Y2Vzc2FyeSBpZiB0aGUgY29uc3RyYWludHMgZm9yIGEgcGFydGljdWxhciBtYWNoaW5lIGRvbuKA
mXQNCiAgICBwcm92aWRlIHN1ZmZpY2llbnQgY29udHJvbCB0byBzZWxlY3QgdGhlIGRlc2lyZWQg
cmVnaXN0ZXIuIg0KDQpIZXJlIGlzIGlzbid0IG5lY2Vzc2FyeSBiZWNhdXNlIHRoZSByZXF1aXJl
ZCBjb25zdHJhaW50IGV4aXN0Lw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

