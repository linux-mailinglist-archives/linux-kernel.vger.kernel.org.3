Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF5D52232D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348445AbiEJR6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiEJR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:58:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1B64185C82
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:54:16 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-266-F96tiV3zPg2IX62V845G_g-1; Tue, 10 May 2022 18:54:14 +0100
X-MC-Unique: F96tiV3zPg2IX62V845G_g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 10 May 2022 18:54:13 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 10 May 2022 18:54:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexei Starovoitov' <alexei.starovoitov@gmail.com>,
        Yury Norov <yury.norov@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: RE: [PATCH 08/22] bitops: introduce MANY_BITS() macro
Thread-Topic: [PATCH 08/22] bitops: introduce MANY_BITS() macro
Thread-Index: AQHYZI4d9Hmm0bRzBEetxNizirfpIq0YYlDw
Date:   Tue, 10 May 2022 17:54:13 +0000
Message-ID: <3be064fe804845e4aeaca8b1d45ddf0a@AcuMS.aculab.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
 <20220510154750.212913-9-yury.norov@gmail.com>
 <CAADnVQKcX2xEWCHu-DX0Cy_mvCL6E0aE_BF1Wo+U-vy_Bi2-3w@mail.gmail.com>
In-Reply-To: <CAADnVQKcX2xEWCHu-DX0Cy_mvCL6E0aE_BF1Wo+U-vy_Bi2-3w@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGVpIFN0YXJvdm9pdG92DQo+IFNlbnQ6IDEwIE1heSAyMDIyIDE3OjUxDQouLi4N
Cj4gKy8qIFJldHVybjogbm9uemVybyBpZiAyIG9yIG1vcmUgYml0cyBhcmUgc2V0ICovDQo+ICsj
ZGVmaW5lIE1BTllfQklUUyhuKSAgICAgICAgICAgKChuKSAmICgobikgLSAxKSkNCg0KWW91IGNh
bid0IGhhdmUgYSBtYWNybyB0aGF0IGV4cGFuZHMgaXRzIGFyZ3VtZW50IHR3aWNlLg0KDQouLi4N
Cj4gPiAgc3RhdGljIGlubGluZSBfX2F0dHJpYnV0ZV9fKChjb25zdCkpDQo+ID4gIGJvb2wgaXNf
cG93ZXJfb2ZfMih1bnNpZ25lZCBsb25nIG4pDQo+ID4gIHsNCj4gPiAtICAgICAgIHJldHVybiAo
biAhPSAwICYmICgobiAmIChuIC0gMSkpID09IDApKTsNCj4gPiArICAgICAgIHJldHVybiBuICE9
IDAgJiYgIU1BTllfQklUUyhuKTsNCj4gPiAgfQ0KPiANCj4gUGxlYXNlIGRvbid0LiBPcGVuIGNv
ZGVkIHZlcnNpb24gaXMgbXVjaCBlYXNpZXIgdG8gcmVhZC4NCg0KRXNwZWNpYWxseSBpZiB5b3Ug
cmVtb3ZlIGFsbCB0aGUgc3BhcmUgcGFyZW50aGVzaXMuDQoJcmV0dXJuIG4gJiYgIShuICYgKG4g
LSAxKSk7DQoNCkkgYmV0IGEgbG90IG9mIGNhbGxlcnMga25vdyB0aGUgdmFsdWUgaXMgbm9uLXpl
cm8uDQoNCkkgc3VzcGVjdCB5b3UnbGwgZmluZCBhdCBsZWFzdCBvbmUgY2FsbGVyIHRoYXQgdXNl
cw0KaXNfcG93ZXJfb2ZfMigpIGFzc3VtaW5nIGl0IGlzICEobiAmIChuIC0gMSkpIGFuZA0Kc28g
aXMgd3JvbmcgZm9yIHplcm8uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

