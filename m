Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5A34B543A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiBNPKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:10:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345997AbiBNPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:10:26 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 498A64925B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:10:18 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-258-AVWgJYqWMTG82rPADC-iHg-1; Mon, 14 Feb 2022 15:10:15 +0000
X-MC-Unique: AVWgJYqWMTG82rPADC-iHg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 14 Feb 2022 15:10:14 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 14 Feb 2022 15:10:14 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        'Anshuman Khandual' <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v6] mm: Uninline copy_overflow()
Thread-Topic: [PATCH v6] mm: Uninline copy_overflow()
Thread-Index: AQHYIYjMC3FpzIXiNkq6GDkdEvYuRayS6GVggAAgDQCAAAPK4IAAFyuAgAAA83A=
Date:   Mon, 14 Feb 2022 15:10:14 +0000
Message-ID: <05aa3859a0a24a0bb5e3c0affe1eb8b2@AcuMS.aculab.com>
References: <e1723b9cfa924bcefcd41f69d0025b38e4c9364e.1644819985.git.christophe.leroy@csgroup.eu>
 <50eed483-9f0a-7aee-1bfd-e89106a80424@arm.com>
 <1157d90c7335458cab4ef471c63a1d52@AcuMS.aculab.com>
 <3b8270fa-b89b-30c6-c1b8-285645215276@csgroup.eu>
 <f487114af1444881b495e0002de491b2@AcuMS.aculab.com>
 <ae9c5df2-0096-fec6-4416-cbbcc99f33ce@csgroup.eu>
In-Reply-To: <ae9c5df2-0096-fec6-4416-cbbcc99f33ce@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAxNCBGZWJydWFyeSAyMDIyIDE0OjU4DQou
Li4NCj4gPiBJIG1ha2UgdGhhdCAzIGV4dHJhIGluc3RydWN0aW9ucy4NCj4gPiBUd28gYXJlIG5l
ZWRlZCB0byBsb2FkIHRoZSBmb3JtYXQgc3RyaW5nLg0KPiA+IE5vdCBzdXJlIHdoeSB0aGUgdGhp
cmQgZ2V0cyBhZGRlZC4NCj4gDQo+IFRoaXJkIGluc3RydWN0aW9uIGlzICd0d3VpJywgdG8gJ3Ry
YXAnIGFuZCBnZXQgdGhlIHdhcm5pbmcgb29wcy4NCg0KSSB3b25kZXJlZCB3aGF0IHRoYXQgZGlk
IDotKQ0KQWx0aG91Z2ggeW91IHJlYWxseSB3YW50IHRoZSAtLSBjdXQgaGVyZSAtLSB0byBjb250
YWluIHRoZSBwcl93YXJuKCkuDQpEb2Vzbid0IFdBUk4oKSBkbyB0aGF0IGZvciB5b3U/DQoNCkkg
d2FzIGxvb2tpbmcgYXQgdGhhdCBsYXN0IHdlZWsgYmVjYXVzZSB0aGUgJ3NjaGVkdWxpbmcgd2hp
bGUgYXRvbWljJw0KdHJhY2UgaXMgIkJVRzogeHh4eCIgYnV0IGRvZXNuJ3QgaGF2ZSB0aGUgJy0t
LSBjdXQgaGVyZSAtLSIgbWFya2VyLg0KDQo+ID4gTm90IHJlYWxseSBzaWduaWZpY2FudCBpbiB0
aGUgMTItMTUgdGhlIGVycm9yIGNhbGwgYWN0dWFsbHkgdGFrZXMuDQo+ID4gQWx0aG91Z2ggYSBs
b3Qgb2YgdGhvc2UgYXJlIGp1c3QgZ2VuZXJhdGluZyB0aGUgc3RhY2sgZnJhbWUNCj4gPiBpbiBv
cmRlciB0byBjYWxsIHRoZSBlcnJvciBmdW5jdGlvbiAtIGFuZCB3b3VsZG4ndCBiZSB0aGVyZSBp
bg0KPiA+IGEgbGVzcyB0cml2aWFsIGV4YW1wbGUuDQo+IA0KPiANCj4gWWVzLCBhZnRlciBsb29r
aW5nIG9uY2UgbW9yZSwgbWF5YmUgbWFraW5nIGl0IF9fYWx3YXlzX2lubGluZSB3b3VsZCBiZQ0K
PiBlbm91Z2guDQo+IA0KPiBUaGUgc3RhcnRpbmcgcG9pbnQgd2FzIHRoYXQgSSBnb3QgYWxtb3N0
IDUwIHRpbWVzIGNvcHlfb3ZlcmZsb3coKSBpbiBteQ0KPiB2bWxpbnV4LCBlYWNoIGhhdmluZyBp
dHMgb3duIGZvcm1hdCBzdHJpbmcgYXMgd2VsbC4NCg0KRGlkbid0IHRoZSBsaW5rZXIgbWVyZ2Ug
dGhlIGZvcm1hdCBzdHJpbmdzPw0KVGhleSBvdWdodCB0byBlbmQgdXAgaW4gc3RyZGF0YS5yby4x
IChvciB3aGF0ZXZlciBpdCBpcyBjYWxsZWQpDQphbmQgdGhlIGxpbmtlciBtZXJnZSB0aGUgcmVm
ZXJlbmNlcy4NCg0KPiBTbyBteSBwYXRjaCByZWR1Y2VkIHZtbGludXggc2l6ZSBieSAzOTA4IGJ5
dGVzLg0KPiANCj4gQnV0IHdpdGggX19hbHdheXNfaW5saW5lIEkgZ2V0IGEgcmVkdWN0aW9uIGJ5
IDM1NjAgd2hpY2ggaXMgYWxtb3N0IHRoZSBzYW1lLg0KPiANCj4gU28gaWYgeW91IHByZWZlciwg
SSBjYW4ganVzdCBtYWtlIGNvcHlfb3ZlcmZsb3coKSBfX2Fsd2F5c19pbmxpbmUgYW5kIHZvaWxh
Lg0KDQpJIHN1c3BlY3QgI2RlZmluZSBfX2lubGluZSBfX2Fsd2F5c19pbmxpbmUgaXMgdGhlIHdh
eSB0byBnby4NClByb2JhYmxlIGFsb25nIHdpdGggLVdpbmxpbmUuDQoNClRoZSBrZXJuZWwgc2hv
dWxkbid0IGhhdmUgaW5saW5lIHNwcmlua2xlZCB3aGVyZSBpdCBpc24ndCBuZWVkZWQuDQoNCj4g
PiBNb3JlIGludGVyZXN0aW5nIHdvdWxkIGJlIGNoYW5naW5nIGNvcHlfb3ZlcmZsb3coKSB0byBy
ZXR1cm4gdGhlIHNpemUuDQo+ID4gU28gY29weV90b191c2VyKCkgYmVjb21lczoNCj4gPg0KPiA+
IAlpZiAoc2l6ZV92YWxpZCgpKQ0KPiA+IAkJcmV0dXJuIF9jb3B5X3RvX3VzZXIoKTsNCj4gPiAJ
cmV0dXJuIGNvcHlfb3ZlcmZsb3coKQ0KPiANCj4gWWVzIHRoYXQncyBzb21ldGhpbmcgdG8gdHJ5
LCBhbGx0aG91Z2ggaXQgbWVhbnMgY2hhbmdpbmcgYWxsIGNhbGxlcnMgb2YNCj4gY2hlY2tfY29w
eV9zaXplKCkuDQoNCllvdSBjb3VsZCB1c2UgYSBkaWZmZXJlbnRseSBuYW1lZCBmdW5jdGlvbiBz
byB0aGV5IGNhbiBiZSBjaGFuZ2VkIGluIHN0YWdlcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

