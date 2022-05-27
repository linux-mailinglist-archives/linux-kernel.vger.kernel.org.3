Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5136535E71
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350519AbiE0Kje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbiE0Kjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:39:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5412AB0B;
        Fri, 27 May 2022 03:39:29 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8h8f6sbXz1JCT4;
        Fri, 27 May 2022 18:37:54 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 18:39:27 +0800
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 18:39:27 +0800
Received: from dggpemm500018.china.huawei.com ([7.185.36.111]) by
 dggpemm500018.china.huawei.com ([7.185.36.111]) with mapi id 15.01.2375.024;
 Fri, 27 May 2022 18:39:27 +0800
From:   "liuke (AQ)" <liuke94@huawei.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "marcoshalano@gmail.com" <marcoshalano@gmail.com>,
        "michael@michaelcullen.name" <michael@michaelcullen.name>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGRyaXZlcnM6IGlucHV0OiBEaXJlY3RseSB1c2Ug?=
 =?utf-8?Q?ida=5Falloc()/free()?=
Thread-Topic: [PATCH] drivers: input: Directly use ida_alloc()/free()
Thread-Index: AQHYcbSHLUrWQUvpK0y1LgSRmZdBNq0yiBRg
Date:   Fri, 27 May 2022 10:39:27 +0000
Message-ID: <9c53080c64424a5ba9d33e789dbd1180@huawei.com>
References: <20220527103740.3442548-1-liuke94@huawei.com>
 <159368be-82fa-f42c-9658-88cd0e1f1882@wanadoo.fr>
In-Reply-To: <159368be-82fa-f42c-9658-88cd0e1f1882@wanadoo.fr>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.142]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgLCAgSSdsbCBiZSBjYXJlZnVsIG5leHQgdGltZSAuDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2
LS0tLS0NCuWPkeS7tuS6ujogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRA
d2FuYWRvby5mcj4gDQrlj5HpgIHml7bpl7Q6IDIwMjLlubQ15pyIMjfml6UgMTg6MjgNCuaUtuS7
tuS6ujogbGl1a2UgKEFRKSA8bGl1a2U5NEBodWF3ZWkuY29tPjsgZG1pdHJ5LnRvcm9raG92QGdt
YWlsLmNvbTsgbWFyY29zaGFsYW5vQGdtYWlsLmNvbTsgbWljaGFlbEBtaWNoYWVsY3VsbGVuLm5h
bWU7IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0K5Li76aKYOiBSZTogW1BBVENIXSBkcml2ZXJzOiBpbnB1dDogRGlyZWN0bHkgdXNlIGlk
YV9hbGxvYygpL2ZyZWUoKQ0KDQpIaSwNCg0KTGUgMjcvMDUvMjAyMiDDoCAxMjozNywga2VsaXUg
YSDDqWNyaXTCoDoNCj4gVXNlIGlkYV9hbGxvYygpL2lkYV9mcmVlKCkgaW5zdGVhZCBvZiBkZXBy
ZWNhdGVkDQo+IGlkYV9zaW1wbGVfZ2V0KCkvaWRhX3NpbXBsZV9yZW1vdmUoKSAuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBrZWxpdSA8bGl1a2U5NEBodWF3ZWkuY29tPg0KPiAtLS0NCj4gICBkcml2
ZXJzL2lucHV0L2lucHV0LmMgICAgICAgICB8IDggKysrKy0tLS0NCj4gICBkcml2ZXJzL2lucHV0
L2pveXN0aWNrL3hwYWQuYyB8IDYgKysrLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1
dC9pbnB1dC5jIGIvZHJpdmVycy9pbnB1dC9pbnB1dC5jIGluZGV4IA0KPiAxMzY1YzlkZmI1ZjIu
LjFlNGEyNzU3OTVmOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbnB1dC9pbnB1dC5jDQo+ICsr
KyBiL2RyaXZlcnMvaW5wdXQvaW5wdXQuYw0KPiBAQCAtMjYxOCwxNSArMjYxOCwxNSBAQCBpbnQg
aW5wdXRfZ2V0X25ld19taW5vcihpbnQgbGVnYWN5X2Jhc2UsIHVuc2lnbmVkIGludCBsZWdhY3lf
bnVtLA0KPiAgIAkgKiBsb2NraW5nIGlzIG5lZWRlZCBoZXJlLg0KPiAgIAkgKi8NCj4gICAJaWYg
KGxlZ2FjeV9iYXNlID49IDApIHsNCj4gLQkJaW50IG1pbm9yID0gaWRhX3NpbXBsZV9nZXQoJmlu
cHV0X2lkYSwNCj4gKwkJaW50IG1pbm9yID0gaWRhX2FsbG9jX3JhbmdlKCZpbnB1dF9pZGEsDQo+
ICAgCQkJCQkgICBsZWdhY3lfYmFzZSwNCj4gLQkJCQkJICAgbGVnYWN5X2Jhc2UgKyBsZWdhY3lf
bnVtLA0KPiArCQkJCQkgICBsZWdhY3lfYmFzZSArIGxlZ2FjeV9udW0gLSAxLA0KDQpZb3UgZ290
IG15IHBvaW50LCB0aGluZ3MgYXJlIGdvaW5nIGluIHRoZSByaWdodCBkaXJlY3Rpb24uDQpUaGlz
IG9uZSBpcyBjb3JyZWN0Li4uDQoNCj4gICAJCQkJCSAgIEdGUF9LRVJORUwpOw0KPiAgIAkJaWYg
KG1pbm9yID49IDAgfHwgIWFsbG93X2R5bmFtaWMpDQo+ICAgCQkJcmV0dXJuIG1pbm9yOw0KPiAg
IAl9DQo+ICAgDQo+IC0JcmV0dXJuIGlkYV9zaW1wbGVfZ2V0KCZpbnB1dF9pZGEsDQo+ICsJcmV0
dXJuIGlkYV9hbGxvY19yYW5nZSgmaW5wdXRfaWRhLA0KPiAgIAkJCSAgICAgIElOUFVUX0ZJUlNU
X0RZTkFNSUNfREVWLCBJTlBVVF9NQVhfQ0hBUl9ERVZJQ0VTLA0KDQouLi4gYnV0IHlvdSBtaXNz
ZWQgdGhlIC0xIGhlcmUuDQoNCkFsc28gbWF5YmUgYW4gZXhwbGFuYXRpb24gb2Ygd2h5IHRoaXMg
LTEgYXJlIGludHJvZHVjZWQgd291bGQgaGVscCByZXZpZXdlcnMuIChpZiBuZWVkZWQsIEkgdGhp
bmsgSSBhbHJlYWR5IHdyb3RlIHNvbWUsIGp1c3QgYXNrKQ0KDQpDSg0KDQo+ICAgCQkJICAgICAg
R0ZQX0tFUk5FTCk7DQo+ICAgfQ0KPiBAQCAtMjY0MSw3ICsyNjQxLDcgQEAgRVhQT1JUX1NZTUJP
TChpbnB1dF9nZXRfbmV3X21pbm9yKTsNCj4gICAgKi8NCj4gICB2b2lkIGlucHV0X2ZyZWVfbWlu
b3IodW5zaWduZWQgaW50IG1pbm9yKQ0KPiAgIHsNCj4gLQlpZGFfc2ltcGxlX3JlbW92ZSgmaW5w
dXRfaWRhLCBtaW5vcik7DQo+ICsJaWRhX2ZyZWUoJmlucHV0X2lkYSwgbWlub3IpOw0KPiAgIH0N
Cj4gICBFWFBPUlRfU1lNQk9MKGlucHV0X2ZyZWVfbWlub3IpOw0KPiAgIA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbnB1dC9qb3lzdGljay94cGFkLmMgDQo+IGIvZHJpdmVycy9pbnB1dC9qb3lz
dGljay94cGFkLmMgaW5kZXggMTgxOTBiNTI5YmNhLi5mYWZjMGQ1NzAzZGMgDQo+IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2lucHV0L2pveXN0aWNrL3hwYWQuYw0KPiArKysgYi9kcml2ZXJzL2lu
cHV0L2pveXN0aWNrL3hwYWQuYw0KPiBAQCAtMTQ1Niw3ICsxNDU2LDcgQEAgc3RhdGljIGludCB4
cGFkX2xlZF9wcm9iZShzdHJ1Y3QgdXNiX3hwYWQgKnhwYWQpDQo+ICAgCWlmICghbGVkKQ0KPiAg
IAkJcmV0dXJuIC1FTk9NRU07DQo+ICAgDQo+IC0JeHBhZC0+cGFkX25yID0gaWRhX3NpbXBsZV9n
ZXQoJnhwYWRfcGFkX3NlcSwgMCwgMCwgR0ZQX0tFUk5FTCk7DQo+ICsJeHBhZC0+cGFkX25yID0g
aWRhX2FsbG9jKCZ4cGFkX3BhZF9zZXEsIEdGUF9LRVJORUwpOw0KPiAgIAlpZiAoeHBhZC0+cGFk
X25yIDwgMCkgew0KPiAgIAkJZXJyb3IgPSB4cGFkLT5wYWRfbnI7DQo+ICAgCQlnb3RvIGVycl9m
cmVlX21lbTsNCj4gQEAgLTE0NzksNyArMTQ3OSw3IEBAIHN0YXRpYyBpbnQgeHBhZF9sZWRfcHJv
YmUoc3RydWN0IHVzYl94cGFkICp4cGFkKQ0KPiAgIAlyZXR1cm4gMDsNCj4gICANCj4gICBlcnJf
ZnJlZV9pZDoNCj4gLQlpZGFfc2ltcGxlX3JlbW92ZSgmeHBhZF9wYWRfc2VxLCB4cGFkLT5wYWRf
bnIpOw0KPiArCWlkYV9mcmVlKCZ4cGFkX3BhZF9zZXEsIHhwYWQtPnBhZF9ucik7DQo+ICAgZXJy
X2ZyZWVfbWVtOg0KPiAgIAlrZnJlZShsZWQpOw0KPiAgIAl4cGFkLT5sZWQgPSBOVUxMOw0KPiBA
QCAtMTQ5Miw3ICsxNDkyLDcgQEAgc3RhdGljIHZvaWQgeHBhZF9sZWRfZGlzY29ubmVjdChzdHJ1
Y3QgdXNiX3hwYWQgDQo+ICp4cGFkKQ0KPiAgIA0KPiAgIAlpZiAoeHBhZF9sZWQpIHsNCj4gICAJ
CWxlZF9jbGFzc2Rldl91bnJlZ2lzdGVyKCZ4cGFkX2xlZC0+bGVkX2NkZXYpOw0KPiAtCQlpZGFf
c2ltcGxlX3JlbW92ZSgmeHBhZF9wYWRfc2VxLCB4cGFkLT5wYWRfbnIpOw0KPiArCQlpZGFfZnJl
ZSgmeHBhZF9wYWRfc2VxLCB4cGFkLT5wYWRfbnIpOw0KPiAgIAkJa2ZyZWUoeHBhZF9sZWQpOw0K
PiAgIAl9DQo+ICAgfQ0KDQo=
