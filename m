Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF8B4B528E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354783AbiBNOAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:00:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354768AbiBNOAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:00:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80AC9BCBF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:00:26 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-4-jIp7Nm6TP-K5pGUkKH9FTA-1; Mon, 14 Feb 2022 14:00:23 +0000
X-MC-Unique: jIp7Nm6TP-K5pGUkKH9FTA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 14 Feb 2022 14:00:23 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 14 Feb 2022 14:00:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        'Anshuman Khandual' <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v6] mm: Uninline copy_overflow()
Thread-Topic: [PATCH v6] mm: Uninline copy_overflow()
Thread-Index: AQHYIYjMC3FpzIXiNkq6GDkdEvYuRayS6GVggAAgDQCAAAPK4A==
Date:   Mon, 14 Feb 2022 14:00:22 +0000
Message-ID: <f487114af1444881b495e0002de491b2@AcuMS.aculab.com>
References: <e1723b9cfa924bcefcd41f69d0025b38e4c9364e.1644819985.git.christophe.leroy@csgroup.eu>
 <50eed483-9f0a-7aee-1bfd-e89106a80424@arm.com>
 <1157d90c7335458cab4ef471c63a1d52@AcuMS.aculab.com>
 <3b8270fa-b89b-30c6-c1b8-285645215276@csgroup.eu>
In-Reply-To: <3b8270fa-b89b-30c6-c1b8-285645215276@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAxNCBGZWJydWFyeSAyMDIyIDEzOjIxDQo+
IA0KPiBMZSAxNC8wMi8yMDIyIMOgIDEyOjMxLCBEYXZpZCBMYWlnaHQgYSDDqWNyaXTCoDoNCj4g
PiBGcm9tOiBBbnNodW1hbiBLaGFuZHVhbA0KPiA+PiBTZW50OiAxNCBGZWJydWFyeSAyMDIyIDA5
OjU0DQo+ID4gLi4uDQo+ID4+PiBXaXRoIC1XaW5saW5lLCBHQ0MgdGVsbHM6DQo+ID4+Pg0KPiA+
Pj4gCS9pbmNsdWRlL2xpbnV4L3RocmVhZF9pbmZvLmg6MjEyOjIwOiB3YXJuaW5nOiBpbmxpbmlu
ZyBmYWlsZWQgaW4gY2FsbCB0byAnY29weV9vdmVyZmxvdyc6IGNhbGwNCj4gPj4gaXMgdW5saWtl
bHkgYW5kIGNvZGUgc2l6ZSB3b3VsZCBncm93IFstV2lubGluZV0NCj4gPj4+DQo+ID4+PiBjb3B5
X292ZXJmbG93KCkgaXMgYSBub24gY29uZGl0aW9uYWwgd2FybmluZyBjYWxsZWQgYnkNCj4gPj4+
IGNoZWNrX2NvcHlfc2l6ZSgpIG9uIGFuIGVycm9yIHBhdGguDQo+ID4+Pg0KPiA+Pj4gY2hlY2tf
Y29weV9zaXplKCkgaGF2ZSB0byByZW1haW4gaW5saW5lZCBpbiBvcmRlciB0byBiZW5lZml0DQo+
ID4+PiBmcm9tIGNvbnN0YW50IGZvbGRpbmcsIGJ1dCBjb3B5X292ZXJmbG93KCkgaXMgbm90IHdv
cnRoIGlubGluaW5nLg0KPiA+Pj4NCj4gPj4+IFVuaW5saW5lIHRoZSB3YXJuaW5nIHdoZW4gQ09O
RklHX0JVRyBpcyBzZWxlY3RlZC4NCj4gPj4+DQo+ID4+PiBXaGVuIENPTkZJR19CVUcgaXMgbm90
IHNlbGVjdGVkLCBXQVJOKCkgZG9lcyBub3RoaW5nIHNvIHNraXAgaXQuDQo+ID4+Pg0KPiA+Pj4g
VGhpcyByZWR1Y2VzIHRoZSBzaXplIG9mIHZtbGludXggYnkgYWxtb3N0IDRrYnl0ZXMuDQo+ID4+
DQo+ID4NCj4gPj4+ICt2b2lkIF9fY29weV9vdmVyZmxvdyhpbnQgc2l6ZSwgdW5zaWduZWQgbG9u
ZyBjb3VudCk7DQo+ID4+PiArDQo+ID4+PiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBjb3B5X292ZXJm
bG93KGludCBzaXplLCB1bnNpZ25lZCBsb25nIGNvdW50KQ0KPiA+Pj4gICB7DQo+ID4+PiAtCVdB
Uk4oMSwgIkJ1ZmZlciBvdmVyZmxvdyBkZXRlY3RlZCAoJWQgPCAlbHUpIVxuIiwgc2l6ZSwgY291
bnQpOw0KPiA+Pj4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfQlVHKSkNCj4gPj4+ICsJCV9fY29w
eV9vdmVyZmxvdyhzaXplLCBjb3VudCk7DQo+ID4+PiAgIH0NCj4gPg0KPiA+PiBKdXN0IHdvbmRl
cmluZywgaXMgdGhpcyB0aGUgb25seSBzdWNoIHNjZW5hcmlvIHdoaWNoIHJlc3VsdHMgaW4NCj4g
Pj4gYW4gYXZvaWRhYmxlIGJsb2F0ZWQgdm1saW51eCBpbWFnZSA/DQo+ID4NCj4gPiBUaGUgbW9y
ZSBpbnRlcmVzdGluZyBxdWVzdGlvbiBpcyB3aGV0aGVyIHRoZSBjYWxsIHRvIF9fY29weV9vdmVy
ZmxvdygpDQo+ID4gaXMgYWN0dWFsbHkgc2lnbmlmaWNhbnRseSBzbWFsbGVyIHRoYW4gdGhlIG9u
ZSB0byBXQVJOKCk/DQo+ID4gQW5kIGlmIHNvIHdoeS4NCj4gPg0KPiB1bnNpZ25lZCBsb25nIHRz
dF9jb3B5X3RvX3VzZXIodm9pZCBfX3VzZXIgKnRvLCB1bnNpZ25lZCBsb25nIG4pDQo+IHsNCj4g
CXJldHVybiBjb3B5X3RvX3VzZXIodG8sICZqaWZmaWVzXzY0LCBuKTsNCj4gfQ0KPiANCj4gV2l0
aCB0aGUgcGF0Y2g6DQo+IA0KPiAwMDAwM2M3OCA8dHN0X2NvcHlfdG9fdXNlcj46DQo+ICAgICAg
M2M3ODoJMjggMDQgMDAgMDggCWNtcGx3aSAgcjQsOA0KPiAgICAgIDNjN2M6CTdjIDg1IDIzIDc4
IAltciAgICAgIHI1LHI0DQo+ICAgICAgM2M4MDoJNDEgODEgMDAgMTAgCWJndCAgICAgM2M5MCA8
dHN0X2NvcHlfdG9fdXNlcisweDE4Pg0KPiAgICAgIDNjODQ6CTNjIDgwIDAwIDAwIAlsaXMgICAg
IHI0LDANCj4gCQkJM2M4NjogUl9QUENfQUREUjE2X0hBCWppZmZpZXNfNjQNCj4gICAgICAzYzg4
OgkzOCA4NCAwMCAwMCAJYWRkaSAgICByNCxyNCwwDQo+IAkJCTNjOGE6IFJfUFBDX0FERFIxNl9M
TwlqaWZmaWVzXzY0DQo+ICAgICAgM2M4YzoJNDggMDAgMDAgMDAgCWIgICAgICAgM2M4YyA8dHN0
X2NvcHlfdG9fdXNlcisweDE0Pg0KPiAJCQkzYzhjOiBSX1BQQ19SRUwyNAlfY29weV90b191c2Vy
DQo+IA0KPiAgICAgIDNjOTA6CTk0IDIxIGZmIGYwIAlzdHd1ICAgIHIxLC0xNihyMSkNCj4gICAg
ICAzYzk0Ogk3YyAwOCAwMiBhNiAJbWZsciAgICByMA0KPiAgICAgIDNjOTg6CTM4IDYwIDAwIDA4
IAlsaSAgICAgIHIzLDgNCj4gICAgICAzYzljOgk5MCAwMSAwMCAxNCAJc3R3ICAgICByMCwyMChy
MSkNCj4gICAgICAzY2EwOgk5MCA4MSAwMCAwOCAJc3R3ICAgICByNCw4KHIxKQ0KPiAgICAgIDNj
YTQ6CTQ4IDAwIDAwIDAxIAlibCAgICAgIDNjYTQgPHRzdF9jb3B5X3RvX3VzZXIrMHgyYz4NCj4g
CQkJM2NhNDogUl9QUENfUkVMMjQJX19jb3B5X292ZXJmbG93DQo+ICAgICAgM2NhODoJODAgYTEg
MDAgMDggCWx3eiAgICAgcjUsOChyMSkNCj4gICAgICAzY2FjOgk4MCAwMSAwMCAxNCAJbHd6ICAg
ICByMCwyMChyMSkNCj4gICAgICAzY2IwOgk3YyBhMyAyYiA3OCAJbXIgICAgICByMyxyNQ0KPiAg
ICAgIDNjYjQ6CTdjIDA4IDAzIGE2IAltdGxyICAgIHIwDQo+ICAgICAgM2NiODoJMzggMjEgMDAg
MTAgCWFkZGkgICAgcjEscjEsMTYNCj4gICAgICAzY2JjOgk0ZSA4MCAwMCAyMCAJYmxyDQo+IA0K
PiANCj4gV2l0aG91dCB0aGUgcGF0Y2g6DQo+IA0KPiAwMDAwM2M4OCA8dHN0X2NvcHlfdG9fdXNl
cj46DQo+ICAgICAgM2M4ODoJMjggMDQgMDAgMDggCWNtcGx3aSAgcjQsOA0KPiAgICAgIDNjOGM6
CTdjIDg1IDIzIDc4IAltciAgICAgIHI1LHI0DQo+ICAgICAgM2M5MDoJNDEgODEgMDAgMTAgCWJn
dCAgICAgM2NhMCA8dHN0X2NvcHlfdG9fdXNlcisweDE4Pg0KPiAgICAgIDNjOTQ6CTNjIDgwIDAw
IDAwIAlsaXMgICAgIHI0LDANCj4gCQkJM2M5NjogUl9QUENfQUREUjE2X0hBCWppZmZpZXNfNjQN
Cj4gICAgICAzYzk4OgkzOCA4NCAwMCAwMCAJYWRkaSAgICByNCxyNCwwDQo+IAkJCTNjOWE6IFJf
UFBDX0FERFIxNl9MTwlqaWZmaWVzXzY0DQo+ICAgICAgM2M5YzoJNDggMDAgMDAgMDAgCWIgICAg
ICAgM2M5YyA8dHN0X2NvcHlfdG9fdXNlcisweDE0Pg0KPiAJCQkzYzljOiBSX1BQQ19SRUwyNAlf
Y29weV90b191c2VyDQo+IA0KPiAgICAgIDNjYTA6CTk0IDIxIGZmIGYwIAlzdHd1ICAgIHIxLC0x
NihyMSkNCj4gICAgICAzY2E0OgkzYyA2MCAwMCAwMCAJbGlzICAgICByMywwDQo+IAkJCTNjYTY6
IFJfUFBDX0FERFIxNl9IQQkucm9kYXRhLnN0cjEuNCsweDMwDQo+ICAgICAgM2NhODoJOTAgODEg
MDAgMDggCXN0dyAgICAgcjQsOChyMSkNCj4gICAgICAzY2FjOgk3YyAwOCAwMiBhNiAJbWZsciAg
ICByMA0KPiAgICAgIDNjYjA6CTM4IDYzIDAwIDAwIAlhZGRpICAgIHIzLHIzLDANCj4gCQkJM2Ni
MjogUl9QUENfQUREUjE2X0xPCS5yb2RhdGEuc3RyMS40KzB4MzANCj4gICAgICAzY2I0OgkzOCA4
MCAwMCAwOCAJbGkgICAgICByNCw4DQo+ICAgICAgM2NiODoJOTAgMDEgMDAgMTQgCXN0dyAgICAg
cjAsMjAocjEpDQo+ICAgICAgM2NiYzoJNDggMDAgMDAgMDEgCWJsICAgICAgM2NiYyA8dHN0X2Nv
cHlfdG9fdXNlcisweDM0Pg0KPiAJCQkzY2JjOiBSX1BQQ19SRUwyNAlfX3dhcm5fcHJpbnRrDQo+
ICAgICAgM2NjMDoJODAgYTEgMDAgMDggCWx3eiAgICAgcjUsOChyMSkNCj4gICAgICAzY2M0Ogkw
ZiBlMCAwMCAwMCAJdHd1aSAgICByMCwwDQo+ICAgICAgM2NjODoJODAgMDEgMDAgMTQgCWx3eiAg
ICAgcjAsMjAocjEpDQo+ICAgICAgM2NjYzoJN2MgYTMgMmIgNzggCW1yICAgICAgcjMscjUNCj4g
ICAgICAzY2QwOgk3YyAwOCAwMyBhNiAJbXRsciAgICByMA0KPiAgICAgIDNjZDQ6CTM4IDIxIDAw
IDEwIAlhZGRpICAgIHIxLHIxLDE2DQo+ICAgICAgM2NkODoJNGUgODAgMDAgMjAgCWJscg0KDQpJ
IG1ha2UgdGhhdCAzIGV4dHJhIGluc3RydWN0aW9ucy4NClR3byBhcmUgbmVlZGVkIHRvIGxvYWQg
dGhlIGZvcm1hdCBzdHJpbmcuDQpOb3Qgc3VyZSB3aHkgdGhlIHRoaXJkIGdldHMgYWRkZWQuDQoN
Ck5vdCByZWFsbHkgc2lnbmlmaWNhbnQgaW4gdGhlIDEyLTE1IHRoZSBlcnJvciBjYWxsIGFjdHVh
bGx5IHRha2VzLg0KQWx0aG91Z2ggYSBsb3Qgb2YgdGhvc2UgYXJlIGp1c3QgZ2VuZXJhdGluZyB0
aGUgc3RhY2sgZnJhbWUNCmluIG9yZGVyIHRvIGNhbGwgdGhlIGVycm9yIGZ1bmN0aW9uIC0gYW5k
IHdvdWxkbid0IGJlIHRoZXJlIGluDQphIGxlc3MgdHJpdmlhbCBleGFtcGxlLg0KDQpNb3JlIGlu
dGVyZXN0aW5nIHdvdWxkIGJlIGNoYW5naW5nIGNvcHlfb3ZlcmZsb3coKSB0byByZXR1cm4gdGhl
IHNpemUuDQpTbyBjb3B5X3RvX3VzZXIoKSBiZWNvbWVzOg0KDQoJaWYgKHNpemVfdmFsaWQoKSkN
CgkJcmV0dXJuIF9jb3B5X3RvX3VzZXIoKTsNCglyZXR1cm4gY29weV9vdmVyZmxvdygpDQoNCklu
IHlvdXIgZXhhbXBsZSB0aGF0IHdvdWxkIGdlbmVyYXRlIGEgdGFpbCBjYWxsIGluIHRoZSBlcnJv
ciBwYXRoLg0KSXQgYWxzbyBhdm9pZHMgaGF2aW5nIHRvIHNhdmUgdGhlIHRyYW5zZmVyIGxlbmd0
aC4NCg0KUGxhdXNpYmx5IHlvdSdsbCBnZXQgc21hbGxlciBjb2RlIGJ5IG1ha2luZyB0aGUgcHJv
dG90eXBlcw0Kb2YgX2NvcHlfdG9fdG9fdXNlcigpIGFuZCBjb3B5X292ZXJmbG93KCkgbWF0Y2gu
DQpCdXQgY29tcGlsZXJzIGRvbid0IGxpa2UgZ2VuZXJhdGluZyB0aGU6DQoJKGNvbmQgPyBhIDog
YikoYXJncykNCmFzc2VtYmxlciB0aGF0IHdvdWxkIHJlYWxseSBiZSBuZWVkZWQuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

