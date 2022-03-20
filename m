Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C42D4E1D68
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 19:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbiCTSYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 14:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245631AbiCTSYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 14:24:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B7FDBA307
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 11:22:38 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-78-9I9hYJ2mP1O2tU6vbhRIkg-1; Sun, 20 Mar 2022 18:22:35 +0000
X-MC-Unique: 9I9hYJ2mP1O2tU6vbhRIkg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Sun, 20 Mar 2022 18:22:35 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Sun, 20 Mar 2022 18:22:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ammar Faizi' <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC PATCH v1 3/6] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Topic: [RFC PATCH v1 3/6] tools/nolibc: i386: Implement syscall with 6
 arguments
Thread-Index: AQHYPD5aHmXDAqFOcUemVcZ8MoFj5azIOuNwgAAkJgCAADQfYA==
Date:   Sun, 20 Mar 2022 18:22:35 +0000
Message-ID: <f99f135ffd1345d29f545938cdaa7973@AcuMS.aculab.com>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-4-ammarfaizi2@gnuweeb.org>
 <2e335ac54db44f1d8496583d97f9dab0@AcuMS.aculab.com>
 <263c1f21-c0d6-deb1-d45e-66fd35715447@gnuweeb.org>
In-Reply-To: <263c1f21-c0d6-deb1-d45e-66fd35715447@gnuweeb.org>
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW1tYXIgRmFpemkNCj4gU2VudDogMjAgTWFyY2ggMjAyMiAxNTowNA0KPiBPbiAzLzIw
LzIyIDg6MTAgUE0sIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBBbW1hciBGYWl6aQ0K
PiA+PiBTZW50OiAyMCBNYXJjaCAyMDIyIDA5OjM4DQo+ID4+DQo+ID4+IEluIGkzODYsIHRoZSA2
dGggYXJndW1lbnQgb2Ygc3lzY2FsbCBnb2VzIGluICVlYnAuIEhvd2V2ZXIsIGJvdGggQ2xhbmcN
Cj4gPj4gYW5kIEdDQyBjYW5ub3QgdXNlICVlYnAgaW4gdGhlIGNsb2JiZXIgbGlzdCBhbmQgaW4g
dGhlICJyIiBjb25zdHJhaW50DQo+ID4+IHdpdGhvdXQgdXNpbmcgLWZvbWl0LWZyYW1lLXBvaW50
ZXIuIFRvIG1ha2UgaXQgYWx3YXlzIGF2YWlsYWJsZSBmb3IgYW55DQo+ID4+IGtpbmQgb2YgY29t
cGlsYXRpb24sIHRoZSBiZWxvdyB3b3JrYXJvdW5kIGlzIGltcGxlbWVudGVkLg0KPiA+Pg0KPiA+
PiBGb3IgY2xhbmcgKHRoZSBBc3NlbWJseSBzdGF0ZW1lbnQgY2FuJ3QgY2xvYmJlciAlZWJwKToN
Cj4gPj4gICAgMSkgU2F2ZSB0aGUgJWVicCB2YWx1ZSB0byB0aGUgcmVkem9uZSBhcmVhIC00KCVl
c3ApLg0KPiA+DQo+ID4gaTM4NiBkb2Vzbid0IGhhdmUgYSByZWR6b25lLg0KPiA+IElmIHlvdSBn
ZXQgYSBzaWduYWwgaXQgd2lsbCB0cmFzaCAtNCglc3ApDQo+IA0KPiBPSywgSSBtaXNzZWQgdGhh
dCBvbmUuIFRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoaXMuDQo+IA0KLi4uDQo+ID4NCj4gPiBPbmUg
cG9zc2liaWxpdHkgbWlnaHQgYmUgdG8gZG86DQo+ID4gCXB1c2ggYXJnNg0KPiA+IAlwdXNoICVl
YnANCj4gPiAJbW92ICAlZWJwLCA0KCVzcCkNCj4gDQo+IERpZCB5b3UgbWVhbiBgbW92IDQoJWVz
cCksICVlYnBgPw0KPiANCj4gPiAJaW50ICAweDgwDQo+ID4gCXBvcCAgJWVicA0KPiA+IAlhZGQg
ICVlc3AsNA0KPiANCj4gSSB0aGluayB5b3VyIHNvbHV0aW9uIGlzIGJldHRlciB0aGFuIHRoZSB4
Y2hnIGFwcHJvYWNoICh3aXRoIHRoZSAzcmQgbGluZQ0KPiBmaXhlZCkuIFdpbGwgdGFrZSB0aGlz
IGluIGZvciB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpJdCBoYXMgdG8gYmUgc2FpZCB0aGF0IGFsdGhv
dWdoIEkndmUgYmVlbiB3cml0aW5nIHg4NiBhc20NCmZvciA0MCB5ZWFycyAoYW5kIG90aGVycyBm
b3IgbG9uZ2VyKSBJIGNhbiBuZXZlciBhY3R1YWxseQ0KcmVtZW1iZXIgdGhlIGV4YWN0IHN5bnRh
eCBvciBvcmRlciBvZiB0aGUgb3BlcmFuZHMhDQpQcm9iYWJseSBiZWNhdXNlIGl0IGlzIHJhbmRv
bWx5IGRpZmZlcmVudCBiZXR3ZWVuIGFzc2VtYmxlcnMuDQpZb3Ugd2FudCB0aGUgJ21lbW9yeSBy
ZWFkJyBpbnN0cnVjdGlvbjogOGIgL3IuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

