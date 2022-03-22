Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054864E3FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbiCVNlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiCVNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:41:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D6451EEFE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:39:44 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-304-TpoBb9E-P5-0NQ4l7f4Q5Q-1; Tue, 22 Mar 2022 13:39:41 +0000
X-MC-Unique: TpoBb9E-P5-0NQ4l7f4Q5Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 22 Mar 2022 13:39:41 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 22 Mar 2022 13:39:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ammar Faizi' <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Topic: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Index: AQHYPdalMvftIu2CIkSH1LImoy2kmazLRP7AgAAjOSaAAABv0A==
Date:   Tue, 22 Mar 2022 13:39:41 +0000
Message-ID: <3b8984ecfbcd4c93aeb468d01728cd74@AcuMS.aculab.com>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
 <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
 <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
 <20220322121338.GD10306@1wt.eu>
 <81569a1c-a6d3-ceb2-a1f1-f229a024d684@gnuweeb.org>
 <20220322133413.GG10306@1wt.eu>
 <58cb5455-d065-b508-b328-20b57c3a67a7@gnuweeb.org>
In-Reply-To: <58cb5455-d065-b508-b328-20b57c3a67a7@gnuweeb.org>
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

RnJvbTogQW1tYXIgRmFpemkNCj4gU2VudDogMjIgTWFyY2ggMjAyMiAxMzozNw0KPiANCj4gT24g
My8yMi8yMiA4OjM0IFBNLCBXaWxseSBUYXJyZWF1IHdyb3RlOg0KPiA+PiBJIHR1cm5lZCBvdXQg
R0NDIHJlZnVzZXMgdG8gdXNlICJybSIgaWYgd2UgY29tcGlsZSB3aXRob3V0IC1mb21pdC1mcmFt
ZS1wb2ludGVyDQo+ID4+IChlLmcuIHdpdGhvdXQgb3B0aW1pemF0aW9uIC8gLU8wKS4gU28gSSB3
aWxsIHN0aWxsIHVzZSAibSIgaGVyZS4NCj4gPg0KPiA+IE9LIHRoYXQncyBmaW5lLiB0aGVuIHlv
dSBjYW4gcHJvYmFibHkgc2ltcGxpZnkgaXQgbGlrZSB0aGlzOg0KPiA+DQo+ID4gICAgICAgIGxv
bmcgX2FyZzYgPSAobG9uZykoYXJnNik7IC8qIE1pZ2h0IGJlIGluIG1lbW9yeSAqLyAgICBcDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcDQo+ID4gICAgICAgIGFzbSB2b2xhdGlsZSAoICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcDQo+ID4gICAgICAgICAgICAicHVzaGwgICUlZWJwXG5cdCIg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gICAgICAgICAgICAibW92bCAg
ICVbX2FyZzZdLCAlJWVicFxuXHQiICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gICAgICAg
ICAgICAiaW50ICAgICQweDgwXG5cdCIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQo+ID4gICAgICAgICAgICAicG9wbCAgICUlZWJwXG5cdCIgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcDQo+ID4gICAgICAgICAgICA6ICI9YSIoX3JldCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gICAgICAgICAgICA6ICJyIihfbnVtKSwgInIi
KF9hcmcxKSwgInIiKF9hcmcyKSwgInIiKF9hcmczKSwgICBcDQo+ID4gICAgICAgICAgICAgICJy
IihfYXJnNCksInIiKF9hcmc1KSwgW19hcmc2XSJtIihfYXJnNikgICAgICAgIFwNCj4gPiAgICAg
ICAgICAgIDogIm1lbW9yeSIsICJjYyIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwNCj4gPiAgICAgICAgKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwNCj4gPg0KPiA+IFNlZSA/IG5vIG1vcmUgcHVzaCwgbm8gbW9yZSBhZGRs
LCBkaXJlY3QgbG9hZCBmcm9tIG1lbW9yeS4NCj4gDQo+IFVnZ2guLi4gSSBjcmFmdGVkIHRoZSBz
YW1lIGNvZGUgbGlrZSB5b3Ugc3VnZ2VzdGVkIGJlZm9yZSwgYnV0IHRoZW4NCj4gSSByZWFsaXpl
ZCBpdCdzIGJ1Z2d5LCBpdCdzIGJ1Z2d5IGJlY2F1c2UgJVtfYXJnNl0gbWF5IGxpdmUgaW4gTigl
ZXNwKS4NCj4gDQo+IFdoZW4geW91IHB1c2hsICVlYnAsIHRoZSAlZXNwIGNoYW5nZXMsIE4oJWVz
cCkgbm8gbG9uZ2VyIHBvaW50cyB0byB0aGUNCj4gNi10aCBhcmd1bWVudC4NCg0KWWVwIC0gdGhh
dCBpcyB3aHkgSSB3cm90ZSB0aGUgJ3B1c2ggYXJnNicuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

