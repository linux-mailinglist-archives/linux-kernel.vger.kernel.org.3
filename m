Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1794F1E70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382654AbiDDWJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379346AbiDDRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:01:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91B203DDE3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:59:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-153-svU6RoGOM7Wtws3q4TmOTA-1; Mon, 04 Apr 2022 17:59:26 +0100
X-MC-Unique: svU6RoGOM7Wtws3q4TmOTA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 4 Apr 2022 17:59:23 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 4 Apr 2022 17:59:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Skripkin' <paskripkin@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: staging: r8188eu: how to handle nested mutex under spinlock
Thread-Topic: staging: r8188eu: how to handle nested mutex under spinlock
Thread-Index: AQHYR5/sp6xWhoDQCkym8rTDVxAmY6zfcjRQgAByu4CAABWc8A==
Date:   Mon, 4 Apr 2022 16:59:23 +0000
Message-ID: <e1ab34f940234eecb91b9b262062eda5@AcuMS.aculab.com>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <4412825.cEBGB3zze1@leap> <26ac4c2d-91cf-656d-2b7e-21a95e500e70@gmail.com>
 <2029549.KlZ2vcFHjT@leap> <7d3d23c3-1839-3e6a-27bf-85bad384e5e4@gmail.com>
 <942c0fbd-f8b2-4cae-dd21-79bc55c54902@gmail.com>
 <26a91705-f721-03d1-f4c8-7f00ce0e65a8@gmail.com>
 <4ef1e90716e64fd78ebbc222bbb7e597@AcuMS.aculab.com>
 <3c8b6454-6b52-fe62-8db1-c76bdbeb2df0@gmail.com>
In-Reply-To: <3c8b6454-6b52-fe62-8db1-c76bdbeb2df0@gmail.com>
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

RnJvbTogUGF2ZWwgU2tyaXBraW4NCj4gU2VudDogMDQgQXByaWwgMjAyMiAxNzozOQ0KPiANCj4g
SGkgRGF2aWQsDQo+IA0KPiBPbiA0LzQvMjIgMTE6NTAsIERhdmlkIExhaWdodCB3cm90ZToNCj4g
Pj4NCj4gPj4gPiAJCXdoaWxlIChwd3Jwcml2LT5iSW5TdXNwZW5kICYmDQo+ID4+DQo+ID4+IEkn
dmUgbG9va2VkIGludG8gd2hhdCBnY2MxMSBwcm9kdWNlZCBmcm9tIHRoaXMgZnVuY3Rpb24gYW5k
IGxvb2tzIGxpa2UNCj4gPj4gbXkgY29tcGlsZXIgaXMgc21hcnQgZW5vdWdoIHRvIG5vdCBjYWNo
ZSB0aGF0IHZhbHVlLCBidXQgSSBhbSBhZnJhaWQgbm90DQo+ID4+IGFsbCBjb21waWxlcnMgYXJl
IHRoYXQgc21hcnQuDQo+ID4NCj4gPiBUaGUgY29tcGlsZXIgY2FuJ3QgY2FjaGUgdGhlIHZhbHVl
IGJlY2F1c2Ugb2YgdGhlIGZ1bmN0aW9uIGNhbGwuDQo+ID4NCj4gDQo+IEhtLCBJIGFtIGEgbmV3
YmllIGluIGNvbXBpbGVycywgc28gY2FuIHlvdSwgcGxlYXNlLCBleHBsYWluIChvciBnaXZlIGEN
Cj4gbGluayB0byBhbnkgcmVzb3VyY2Ugd2hlcmUgSSBjYW4gcmVhZCBhYm91dCBpdCkgaG93IGZ1
bmN0aW9uIGNhbGwgaGVyZQ0KPiBwcmV2ZW50IGNhY2hpbmcuDQo+IA0KPiBJSVVDIGNvbXBpbGVy
IGdlbmVyYXRlcyBjb2RlIHRoYXQgd29ya3Mgd2VsbCBpbiBzY29wZSBvZiBzaW5nbGUtdGhyZWFk
ZWQNCj4gYXBwbGljYXRpb24sIHNvIHdoeSBjYW4ndCBjb21waWxlciBjYWNoZSB0aGF0IHZhbHVl
IGluc3RlYWQgb2YgYWNjZXNzaW5nDQo+IG1lbW9yeSBvbiBlYWNoIGl0ZXJhdGlvbi4uLiBJc24n
dCByZWdpc3RlciBhY2Nlc3MgYSB3YXkgZmFzdGVyIHRoYW4gZXZlbg0KPiBjYWNoZSBoaXQ/DQoN
CkJlY2F1c2UgY2FsbHMgdG8gZXh0ZXJuYWwgZnVuY3Rpb25zIGFyZSBhbGxvd2VkIHRvIGNoYW5n
ZQ0KYW55IGRhdGEgdmlhICdvdGhlcicgcmVmZXJlbmNlcy4NCkZvciBpbnN0YW5jZSB0aGUgc3Ry
dWN0dXJlIHBvaW50ZXIgdGhlIGZ1bmN0aW9uIGhhcyBjb3VsZA0KYWxzbyBiZSBpbiBnbG9iYWwg
ZGF0YSBzb21ld2hlcmUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

