Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F7B57A18A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbiGSObB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiGSOad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:30:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4FB3A46F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:19:12 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-191-waRYl-RDNsiysdWy-ANi1Q-1; Tue, 19 Jul 2022 15:19:09 +0100
X-MC-Unique: waRYl-RDNsiysdWy-ANi1Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 19 Jul 2022 15:19:08 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 19 Jul 2022 15:19:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe JAILLET' <christophe.jaillet@wanadoo.fr>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: RE: [PATCH 2/3] ocfs2: Remove a useless spinlock
Thread-Topic: [PATCH 2/3] ocfs2: Remove a useless spinlock
Thread-Index: AQHYm1a23J7AKlhcsUK1MlCgSmBBPK2Fe4YggAAi+oCAAB+pQA==
Date:   Tue, 19 Jul 2022 14:19:08 +0000
Message-ID: <fe6c86050b3447758c09e1881582405f@AcuMS.aculab.com>
References: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
 <8ba7004d330cbe5f626539a8a3bff696d0c4285e.1658224839.git.christophe.jaillet@wanadoo.fr>
 <7b644e5d32d74d3d90dfc5b1786ae5b9@AcuMS.aculab.com>
 <29c3fbdd-7695-46c5-bb75-fe358c574ab3@wanadoo.fr>
In-Reply-To: <29c3fbdd-7695-46c5-bb75-fe358c574ab3@wanadoo.fr>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0b3BoZSBKQUlMTEVUDQo+IFNlbnQ6IDE5IEp1bHkgMjAyMiAxNDoyNQ0KPiAN
Cj4gTGUgMTkvMDcvMjAyMiDDoCAxMjoyNCwgRGF2aWQgTGFpZ2h0IGEgw6ljcml0wqA6DQo+ID4g
RnJvbTogQ2hyaXN0b3BoZSBKQUlMTEVUDQo+ID4+IFNlbnQ6IDE5IEp1bHkgMjAyMiAxMTowMg0K
PiA+Pg0KPiA+PiAnbm9kZV9tYXBfbG9jaycgaXMgYSBzcGlubG9jayBvbmx5IHVzZWQgdG8gcHJv
dGVjdCBjYWxscyB0byBzZXRfYml0KCksDQo+ID4+IGNsZWFyX2JpdCgpIGFuZCB0ZXN0X2JpdCgp
Lg0KPiA+Pg0KPiA+PiB7c2V0fGNsZWFyfV9iaXQoKSBhcmUgYWxyZWFkeSBhdG9taWMgYW5kIGRv
bid0IG5lZWQgdGhpcyBleHRyYSBzcGlubG9jay4NCj4gPj4gdGVzdF9iaXQoKSBvbmx5IHJlYWRz
IHRoZSBiaXRtYXAgZm9yIGEgZ2l2ZW4gYml0Lg0KPiA+Pg0KPiA+PiBSZW1vdmUgdGhpcyB1c2Vs
ZXNzIHNwaW5sb2NrLg0KPiA+DQo+ID4gSXQgbG9va3MgdG8gbWUgbGlrZSB0aGUgY2FsbGluZyBj
b2RlIGlzIHJhY3kNCj4gPiB1bmxlc3MgdGhlcmUgaXMgYW5vdGhlciBsb2NrIGluIHRoZSBjYWxs
ZXJzLg0KPiANCj4gVGhlIGNhbGwgY2hhaW5zIGFyZToNCj4gICAgb2NmczJfcmVjb3Zlcl9vcnBo
YW5zKCkNCj4gICAgICBvY2ZzMl9tYXJrX3JlY292ZXJpbmdfb3JwaGFuX2RpcigpDQo+ICAgICAg
ICBzcGluX2xvY2soJm9zYi0+b3NiX2xvY2spOwkJPC0tIG9zYl9sb2NrIHNwaW5sb2NrDQo+ICAg
ICAgICBvY2ZzMl9ub2RlX21hcF9zZXRfYml0KCkJCQk8LS0gdXNlcyBub2RlX21hcF9sb2NrDQo+
ICAgICAgICAuLi4NCj4gICAgICAgIHNwaW5fdW5sb2NrKCZvc2ItPm9zYl9sb2NrKTsNCj4gICAg
ICAuLi4NCj4gICAgICBvY2ZzMl9jbGVhcl9yZWNvdmVyaW5nX29ycGhhbl9kaXIoKQ0KPiAgICAg
ICAgb2NmczJfbm9kZV9tYXBfY2xlYXJfYml0KCkJCTwtLSB1c2VzIG5vZGVfbWFwX2xvY2sNCj4g
CQkJCQkJICAgIG9zYl9sb2NrIGlzIE5PVCB0YWtlbg0KPiANCj4gDQo+ICAgIG9jZnMyX2NoZWNr
X29ycGhhbl9yZWNvdmVyeV9zdGF0ZSgpDQo+ICAgICAgc3Bpbl9sb2NrKCZvc2ItPm9zYl9sb2Nr
KTsJCQk8LS0gb3NiX2xvY2sgc3BpbmxvY2sNCj4gICAgICAuLi4NCj4gICAgICBvY2ZzMl9ub2Rl
X21hcF90ZXN0X2JpdCgpCQkJPC0tIHVzZXMgbm9kZV9tYXBfbG9jaw0KPiAgICAgIC4uLg0KPiAg
ICAgIHNwaW5fdW5sb2NrKCZvc2ItPm9zYl9sb2NrKTsNCj4gDQo+IA0KPiBTbyB0aGUgY29kZSBs
b29rcyBhbHJlYWR5IHByb3RlY3RlZCBieSB0aGUgJ29zYl9sb2NrJyBzcGlubG9jaywgYnV0IEkN
Cj4gZG9uJ3Qga25vdyB0aGlzIGNvZGUgYW5kIG9jZnMyX21hcmtfcmVjb3ZlcmluZ19vcnBoYW5f
ZGlyKCkgbG9va3MgdHJpY2t5DQo+IHRvIG1lLiAoc28gc29tZSBvdGhlciBleWVzIGFyZSBtdWNo
IHdlbGNvbWUpDQo+IA0KPiA+IFdoaWxlIG1hcC0+bWFwIGlzIHByb3RlY3RlZCwgdGhlIHJlc3Vs
dCBvZiB0ZXN0X2JpdCgpDQo+ID4gaXMgc3RhbGUgLSBzbyBjYW4ndCBiZSB1c2VkIGZvciBtdWNo
Lg0KPiA+DQo+IA0KPiBBbnl3YXksIHNob3VsZCB0aGVyZSBiZSBhIGxvY2tpbmcgaXNzdWUsIGl0
IGlzIHRoZXJlIHdpdGggb3Igd2l0aG91dCBteQ0KPiBwYXRjaCwgcmlnaHQ/DQoNCkluZGVlZC4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

