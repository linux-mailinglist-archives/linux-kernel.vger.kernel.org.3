Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8206B4B4F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352237AbiBNLrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:47:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352298AbiBNLjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:39:46 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0757A182
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:31:23 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-HZLmr3MgPfiUko5afxgPeg-1; Mon, 14 Feb 2022 11:31:20 +0000
X-MC-Unique: HZLmr3MgPfiUko5afxgPeg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 14 Feb 2022 11:31:20 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 14 Feb 2022 11:31:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Anshuman Khandual' <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v6] mm: Uninline copy_overflow()
Thread-Topic: [PATCH v6] mm: Uninline copy_overflow()
Thread-Index: AQHYIYjMC3FpzIXiNkq6GDkdEvYuRayS6GVg
Date:   Mon, 14 Feb 2022 11:31:20 +0000
Message-ID: <1157d90c7335458cab4ef471c63a1d52@AcuMS.aculab.com>
References: <e1723b9cfa924bcefcd41f69d0025b38e4c9364e.1644819985.git.christophe.leroy@csgroup.eu>
 <50eed483-9f0a-7aee-1bfd-e89106a80424@arm.com>
In-Reply-To: <50eed483-9f0a-7aee-1bfd-e89106a80424@arm.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5zaHVtYW4gS2hhbmR1YWwNCj4gU2VudDogMTQgRmVicnVhcnkgMjAyMiAwOTo1NA0K
Li4uDQo+ID4gV2l0aCAtV2lubGluZSwgR0NDIHRlbGxzOg0KPiA+DQo+ID4gCS9pbmNsdWRlL2xp
bnV4L3RocmVhZF9pbmZvLmg6MjEyOjIwOiB3YXJuaW5nOiBpbmxpbmluZyBmYWlsZWQgaW4gY2Fs
bCB0byAnY29weV9vdmVyZmxvdyc6IGNhbGwNCj4gaXMgdW5saWtlbHkgYW5kIGNvZGUgc2l6ZSB3
b3VsZCBncm93IFstV2lubGluZV0NCj4gPg0KPiA+IGNvcHlfb3ZlcmZsb3coKSBpcyBhIG5vbiBj
b25kaXRpb25hbCB3YXJuaW5nIGNhbGxlZCBieQ0KPiA+IGNoZWNrX2NvcHlfc2l6ZSgpIG9uIGFu
IGVycm9yIHBhdGguDQo+ID4NCj4gPiBjaGVja19jb3B5X3NpemUoKSBoYXZlIHRvIHJlbWFpbiBp
bmxpbmVkIGluIG9yZGVyIHRvIGJlbmVmaXQNCj4gPiBmcm9tIGNvbnN0YW50IGZvbGRpbmcsIGJ1
dCBjb3B5X292ZXJmbG93KCkgaXMgbm90IHdvcnRoIGlubGluaW5nLg0KPiA+DQo+ID4gVW5pbmxp
bmUgdGhlIHdhcm5pbmcgd2hlbiBDT05GSUdfQlVHIGlzIHNlbGVjdGVkLg0KPiA+DQo+ID4gV2hl
biBDT05GSUdfQlVHIGlzIG5vdCBzZWxlY3RlZCwgV0FSTigpIGRvZXMgbm90aGluZyBzbyBza2lw
IGl0Lg0KPiA+DQo+ID4gVGhpcyByZWR1Y2VzIHRoZSBzaXplIG9mIHZtbGludXggYnkgYWxtb3N0
IDRrYnl0ZXMuDQo+IA0KDQo+ID4gK3ZvaWQgX19jb3B5X292ZXJmbG93KGludCBzaXplLCB1bnNp
Z25lZCBsb25nIGNvdW50KTsNCj4gPiArDQo+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCBjb3B5X292
ZXJmbG93KGludCBzaXplLCB1bnNpZ25lZCBsb25nIGNvdW50KQ0KPiA+ICB7DQo+ID4gLQlXQVJO
KDEsICJCdWZmZXIgb3ZlcmZsb3cgZGV0ZWN0ZWQgKCVkIDwgJWx1KSFcbiIsIHNpemUsIGNvdW50
KTsNCj4gPiArCWlmIChJU19FTkFCTEVEKENPTkZJR19CVUcpKQ0KPiA+ICsJCV9fY29weV9vdmVy
ZmxvdyhzaXplLCBjb3VudCk7DQo+ID4gIH0NCg0KPiBKdXN0IHdvbmRlcmluZywgaXMgdGhpcyB0
aGUgb25seSBzdWNoIHNjZW5hcmlvIHdoaWNoIHJlc3VsdHMgaW4NCj4gYW4gYXZvaWRhYmxlIGJs
b2F0ZWQgdm1saW51eCBpbWFnZSA/DQoNClRoZSBtb3JlIGludGVyZXN0aW5nIHF1ZXN0aW9uIGlz
IHdoZXRoZXIgdGhlIGNhbGwgdG8gX19jb3B5X292ZXJmbG93KCkNCmlzIGFjdHVhbGx5IHNpZ25p
ZmljYW50bHkgc21hbGxlciB0aGFuIHRoZSBvbmUgdG8gV0FSTigpPw0KQW5kIGlmIHNvIHdoeS4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

