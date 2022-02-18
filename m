Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A124BC18D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbiBRVLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:11:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiBRVLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:11:49 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 641FC1133D6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:11:30 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-217--zoMOBvpMVq-lx5Sa2SNmQ-1; Fri, 18 Feb 2022 21:11:27 +0000
X-MC-Unique: -zoMOBvpMVq-lx5Sa2SNmQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 18 Feb 2022 21:11:25 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 18 Feb 2022 21:11:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Cooper' <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>
Subject: RE: [PATCH 05/29] x86: Base IBT bits
Thread-Topic: [PATCH 05/29] x86: Base IBT bits
Thread-Index: AQHYJOs4MY/fho88+Uaa/a9ERSiwKKyZyEiAgAAEwLA=
Date:   Fri, 18 Feb 2022 21:11:25 +0000
Message-ID: <bf7f2867a77e4ebe8c44fd0577a3ac55@AcuMS.aculab.com>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.867389898@infradead.org>
 <96209eb7-f95c-41c5-12c1-da4dbbbf67f3@citrix.com>
In-Reply-To: <96209eb7-f95c-41c5-12c1-da4dbbbf67f3@citrix.com>
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

RnJvbTogQW5kcmV3IENvb3Blcg0KPiBTZW50OiAxOCBGZWJydWFyeSAyMDIyIDIwOjUwDQo+IA0K
PiBPbiAxOC8wMi8yMDIyIDE2OjQ5LCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gPiArLyoNCj4g
PiArICogQSBiaXQgY29udm9sdXRlZCwgYnV0IG1hdGNoZXMgYm90aCBlbmRicjMyIGFuZCBlbmRi
cjY0IHdpdGhvdXQNCj4gPiArICogaGF2aW5nIGVpdGhlciBhcyBsaXRlcmFsIGluIHRoZSB0ZXh0
Lg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGlubGluZSBib29sIGlzX2VuZGJyKGNvbnN0IHZvaWQg
KmFkZHIpDQo+ID4gK3sNCj4gPiArCXVuc2lnbmVkIGludCB2YWwgPSB+Kih1bnNpZ25lZCBpbnQg
KilhZGRyOw0KPiA+ICsJdmFsIHw9IDB4MDEwMDAwMDBVOw0KPiA+ICsJcmV0dXJuIHZhbCA9PSB+
MHhmYTFlMGZmMzsNCj4gPiArfQ0KPiANCj4gQXQgdGhpcyBwb2ludCwgSSBmZWVsIEkndmUgZWFy
bmVkIGFuICJJIHRvbGQgeW91IHNvIi4gOikNCj4gDQo+IENsYW5nIDEzIHNlZXMgc3RyYWlnaHQg
dGhyb3VnaCB0aGUgdHJpY2tlcnkgYW5kIGdlbmVyYXRlczoNCj4gDQo+IGlzX2VuZGJyOsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAj
IEBpc19lbmRicg0KPiDCoMKgwqDCoMKgwqDCoCBtb3ZswqDCoMKgICQtMTY3NzcyMTcsICVlYXjC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBpbW0gPSAweEZFRkZGRkZGDQo+IMKgwqDC
oMKgwqDCoMKgIGFuZGzCoMKgwqAgKCVyZGkpLCAlZWF4DQo+IMKgwqDCoMKgwqDCoMKgIGNtcGzC
oMKgwqAgJC05ODY5MzEzMywgJWVheMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjIGlt
bSA9IDB4RkExRTBGRjMNCj4gwqDCoMKgwqDCoMKgwqAgc2V0ZcKgwqDCoCAlYWwNCj4gwqDCoMKg
wqDCoMKgwqAgcmV0cQ0KDQpJIHRoaW5rIGl0IGlzIGVub3VnaCB0byBhZGQ6DQoJYXNtKCIiLCAi
PXIiICh2YWwpKTsNCnNvbWV3aGVyZSBpbiB0aGUgbWlkZGxlLg0KKEkgdGhpbmsgdGhhdCBpcyBy
aWdodCBmb3IgYXNtIHdpdGggaW5wdXQgYW5kIG91dHB1dCBpbiB0aGUgc2FtZQ0KcmVnaXN0ZXIu
KQ0KVGhlcmUgbWlnaHQgYmUgYSBISURFX0ZPUl9PUFRJTUlTRVIoKSBkZWZpbmUgdGhhdCBkb2Vz
IHRoYXQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

