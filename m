Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D64F1164
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbiDDIw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbiDDIw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:52:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8165F1E3D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:51:01 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-235-1Y4JqQ3oPCehEbsc0F2AAw-1; Mon, 04 Apr 2022 09:50:58 +0100
X-MC-Unique: 1Y4JqQ3oPCehEbsc0F2AAw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 4 Apr 2022 09:50:56 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 4 Apr 2022 09:50:56 +0100
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
Thread-Index: AQHYR5/sp6xWhoDQCkym8rTDVxAmY6zfcjRQ
Date:   Mon, 4 Apr 2022 08:50:56 +0000
Message-ID: <4ef1e90716e64fd78ebbc222bbb7e597@AcuMS.aculab.com>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <4412825.cEBGB3zze1@leap> <26ac4c2d-91cf-656d-2b7e-21a95e500e70@gmail.com>
 <2029549.KlZ2vcFHjT@leap> <7d3d23c3-1839-3e6a-27bf-85bad384e5e4@gmail.com>
 <942c0fbd-f8b2-4cae-dd21-79bc55c54902@gmail.com>
 <26a91705-f721-03d1-f4c8-7f00ce0e65a8@gmail.com>
In-Reply-To: <26a91705-f721-03d1-f4c8-7f00ce0e65a8@gmail.com>
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

RnJvbTogUGF2ZWwgU2tyaXBraW4NCj4gU2VudDogMDMgQXByaWwgMjAyMiAyMjoxNQ0KPiANCj4g
SGkgTWljaGFlbCwNCj4gDQo+IE9uIDQvMy8yMiAyMzo1MSwgTWljaGFlbCBTdHJhdWJlIHdyb3Rl
Og0KPiA+Pg0KPiA+PiBJTU8sIHRoZSBiZXN0IGFuc3dlciBpcyBqdXN0IHJlbW92ZSB0aGlzIGxv
b3AsIHNpbmNlIGl0IGRvZXMgbm90aGluZy4gT3INCj4gPj4gcmVkZXNpZ24gaXQgdG8gYmUgbW9y
ZSBzYW5lDQo+ID4+DQo+ID4+IEl0IHdhaXRzIGZvciBwc19wcm9jZXNzaW5nIHRvIGJlY29tZSAw
IGZvciAzMDAwIG1zLCBidXQgaWYgMzAwMCBtcw0KPiA+PiBleHBpcmVzLi4uIGV4ZWN1dGlvbiBn
b2VzIGZvcndhcmQgbGlrZSBhcyBwc19wcm9jZXNzaW5nIHdhcyAwIGZyb20gdGhlDQo+ID4+IGJl
Z2lubmluZw0KPiA+Pg0KPiA+PiBNYXliZSBpdCdzIHNvbWV0aGluZyBodyByZWxhdGVkLCBsaWtl
IHdhaXQgZm9yIDMwMDAgbXMgYW5kIGFsbCB3aWxsIGJlDQo+ID4+IG9rLiBDYW4ndCBzYXkuLi4N
Cj4gPj4NCj4gPg0KPiA+IEhpIFBhdmVsLA0KPiA+DQo+ID4gc2FtZSB3aXRoIHRoZSBsb29wIHRo
YXQgZm9sbG93czoNCj4gPg0KPiA+IAkvKiBTeXN0ZW0gc3VzcGVuZCBpcyBub3QgYWxsb3dlZCB0
byB3YWtldXAgKi8NCj4gPiAJaWYgKHB3cnByaXYtPmJJblN1c3BlbmQpIHsNCj4gDQo+IAkgICBe
Xl5eDQo+IA0KPiBidHcsIHRoaXMgcGFydCBpcyB1c2VsZXNzIHRvDQo+IA0KPiANCj4gPiAJCXdo
aWxlIChwd3Jwcml2LT5iSW5TdXNwZW5kICYmDQo+IA0KPiBJJ3ZlIGxvb2tlZCBpbnRvIHdoYXQg
Z2NjMTEgcHJvZHVjZWQgZnJvbSB0aGlzIGZ1bmN0aW9uIGFuZCBsb29rcyBsaWtlDQo+IG15IGNv
bXBpbGVyIGlzIHNtYXJ0IGVub3VnaCB0byBub3QgY2FjaGUgdGhhdCB2YWx1ZSwgYnV0IEkgYW0g
YWZyYWlkIG5vdA0KPiBhbGwgY29tcGlsZXJzIGFyZSB0aGF0IHNtYXJ0Lg0KDQpUaGUgY29tcGls
ZXIgY2FuJ3QgY2FjaGUgdGhlIHZhbHVlIGJlY2F1c2Ugb2YgdGhlIGZ1bmN0aW9uIGNhbGwuDQoN
ClF1aXRlIHdoZXRoZXIgdGhlIGNvZGUgaXMgaW4gYW55IHdheSBzYW5lIGluIGFub3RoZXIgbWF0
dGVyLg0KDQpZb3UgZGVmaW5pdGVseSBjYW5ub3Qgc2xlZXAgd2l0aCBhIHNwaW5sb2NrIGhlbGQu
DQpJbWFnaW5lIHdoYXQgaGFwcGVucyBpZiBhbm90aGVyIHByb2Nlc3MgdHJpZXMgdG8gYWNxdWly
ZSB0aGUNCnNwaW5sb2NrIHdoaWxlIHlvdSBhcmUgc2xlZXBpbmcuDQpJdCB3aWxsIHNwaW4gZm9y
ZXZlci4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

