Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1872F4C8884
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiCAJtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiCAJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:49:14 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCE1D8C7E6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:48:31 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-4-_kwR_xRLO7eUfka9jM6qhg-1; Tue, 01 Mar 2022 09:48:29 +0000
X-MC-Unique: _kwR_xRLO7eUfka9jM6qhg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 1 Mar 2022 09:48:28 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 1 Mar 2022 09:48:28 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Masahiro Yamada' <masahiroy@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michal Marek" <michal.lkml@markovi.net>
Subject: RE: [PATCH v2] fixdep: use fflush() and ferror() to ensure successful
 write to files
Thread-Topic: [PATCH v2] fixdep: use fflush() and ferror() to ensure
 successful write to files
Thread-Index: AQHYLPcP7Y0QFZ9bvkmwHjXtsXkLWaypyorwgABysACAAAsbwA==
Date:   Tue, 1 Mar 2022 09:48:28 +0000
Message-ID: <723970e562d04b22899fe3855d599cab@AcuMS.aculab.com>
References: <20220225144245.182659-1-masahiroy@kernel.org>
 <CAKwvOd=WjnHSHKLVRJifHxV2tyDsLTkek80NWU=do=FSHhNLug@mail.gmail.com>
 <67b75a36cf874dfea0871649ccd268d3@AcuMS.aculab.com>
 <CAK7LNARKxd-kr3pABzTC2+uGhEKbyLtXDCSoxn56P0go--bg1A@mail.gmail.com>
In-Reply-To: <CAK7LNARKxd-kr3pABzTC2+uGhEKbyLtXDCSoxn56P0go--bg1A@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFzYWhpcm8gWWFtYWRhDQo+IFNlbnQ6IDAxIE1hcmNoIDIwMjIgMDk6MDYNCj4gDQo+
IE9uIFR1ZSwgTWFyIDEsIDIwMjIgYXQgMTE6MjggQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgcmV0dXJuIHZhbHVlIGZyb20gZnBy
aW50ZigpIGlzIG5vcm1hbGx5IHRoZSBudW1iZXIgb2YgYnl0ZXMgd3JpdHRlbiB0bw0KPiA+IHRo
ZSBpbnRlcm5hbCBidWZmZXIgKDhrIGluIGdsaWJjPykNCj4gPg0KPiA+IE9ubHkgaWYgdGhlIGJ1
ZmZlciBpcyBmdWxsIGFuZCBhbiBhY3R1YWwgd3JpdGUoKSBpcyBkb25lIGRvIHlvdSBnZXQgYW55
IGluZGljYXRpb24gb2YgYW4gZXJyb3IuDQo+ID4NCj4gPiBTbyB5b3UgY2FuIHVzZSB0aGUgZXJy
b3IgcmV0dXJuIGZyb20gZnByaW50ZigpIHRvIHRlcm1pbmF0ZSBhIGxvb3Ag4oCTIGJ1dCBpdCB1
c3VhbGx5DQo+ID4ganVzdCBpc27igJl0IHdvcnRoIHRoZSBlZmZvcnQuDQo+ID4NCj4gPiBUaGUg
ZXJyb3Igc3RhdHVzIHJldHVybmVkIGJ5IGZlcnJvcigpIGlzIOKAmHN0aWNreeKAmSwgc28geW91
IG5lZWQgb25seSBjaGVjayBvbmNlLg0KPiA+DQo+ID4gQnV0IHlvdSBuZWVkIHRvIGNoZWNrIGJl
Zm9yZSBmY2xvc2UoKS4NCj4gPg0KPiA+IFNpbmNlIGZjbG9zZSgpIGhhcyB0byB3cml0ZSBvdXQg
dGhlIGJ1ZmZlciDigJMgdGhhdCB3cml0ZSBjYW4gYWxzbyBmYWlsLg0KPiA+DQo+ID4gSeKAmW0g
bm90IHN1cmUgd2hldGhlciBmY2xvc2UoKSByZXR1cm5zIGFuZCBlcnJvciBpbiB0aGF0IGNhc2Us
IGJ1dCBhZGRpbmcgZmZsdXNoKCkNCj4gPiBtYWtlcyB0aGUgY29kaW5nIGVhc2llci4NCj4gDQo+
IA0KPiBJIGp1c3QgY2hlY2tlZCB0aGlzLg0KPiANCj4gZmNsb3NlKCkgcmV0dXJucyAtMSBpZiBp
dCBmYWlscyB0byBmbHVzaCB0aGUgYnVmZmVyLg0KDQpCdXQgeW91IHN0aWxsIG5lZWQgdG8gY2hl
Y2sgZmVycm9yKCkgYmVmb3JlIGl0Lg0KU28geW91IG1pZ2h0IGFzIHdlbGwgZG8gZmZsdXNoKCk7
IGlmIChmZXJyb3IoKSk7IGZjbG9zZSgpOw0KDQpUaGVuIHRoZXJlIGlzIG9ubHkgb25lIGVycm9y
IGV4aXQgcGF0aC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

