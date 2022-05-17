Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8CB529B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbiEQH4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbiEQH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:56:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D668921808
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:56:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-89-AbgIZabJO0GTyUNJIXZG-Q-1; Tue, 17 May 2022 08:56:06 +0100
X-MC-Unique: AbgIZabJO0GTyUNJIXZG-Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 17 May 2022 08:56:05 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 17 May 2022 08:56:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sami Tolvanen' <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Thread-Topic: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Thread-Index: AQHYZwdlgt4N7xLw0EK8voqNmmoVIa0hK0vAgAB8yACAAF6CUIAADPZSgACjHQA=
Date:   Tue, 17 May 2022 07:56:05 +0000
Message-ID: <161477674eb04ebe94a4905070bc9f97@AcuMS.aculab.com>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <f65c01979b884174965802a13cf6b077@AcuMS.aculab.com>
 <CABCJKueo+cw1DHH6N2dUjD-U7OKqmkJUyimm0ychv1drt5U9Rg@mail.gmail.com>
 <19b3e040302d4d8aa240eee43427dfaa@AcuMS.aculab.com>
 <20220516214414.GR76023@worktop.programming.kicks-ass.net>
 <CABCJKucPMgMQ-D_yByvMSx6yutjsBXGAwirmheOYejWHARi9iQ@mail.gmail.com>
In-Reply-To: <CABCJKucPMgMQ-D_yByvMSx6yutjsBXGAwirmheOYejWHARi9iQ@mail.gmail.com>
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

RnJvbTogU2FtaSBUb2x2YW5lbg0KPiBTZW50OiAxNiBNYXkgMjAyMiAyMzowMw0KPiANCj4gT24g
TW9uLCBNYXkgMTYsIDIwMjIgYXQgMjo0NCBQTSBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCBNYXkgMTYsIDIwMjIgYXQgMDk6MzI6
NTVQTSArMDAwMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+DQo+ID4gPiA+IFRoZSBjb21waWxl
ciBhbHdheXMgZ2VuZXJhdGVzIHRoaXMgc3BlY2lmaWMgaW5zdHJ1Y3Rpb24gc2VxdWVuY2UuDQo+
ID4gPg0KPiA+ID4gWWVzLCBidXQgdGhlcmUgYXJlIHNldmVyYWwgd2F5cyB0byBlbmNvZGUgJ2Nt
cGwgaW1tLC02KHJlZyknLg0KPiA+DQo+ID4gWWVzLCBidXQgd2UgZG9uJ3QgY2FyZS4gVGhpcyAq
YWx3YXlzKiB1c2VzIHRoZSAzMmJpdCBpbW1lZGlhdGUgZm9ybS4NCj4gPiBFdmVuIGlmIHRoZSBp
bW1lZGlhdGUgaXMgc21hbGwuDQo+IA0KPiBZZXMsIHRoYXQgcGFydCBpcyBub3QgYSBwcm9ibGVt
LCBidXQgaXQncyBhIHZhbGlkIHBvaW50IHRoYXQgTExWTQ0KPiBtaWdodCBub3QgYWx3YXlzIHVz
ZSByOC1yMTUgaGVyZSwgc28gSSB3aWxsIGhhdmUgdG8gY2hlY2sgZm9yIHRoZSBSRVgNCj4gcHJl
Zml4IGJlZm9yZSBibGluZGx5IGF0dGVtcHRpbmcgdG8gZGVjb2RlIHRoZSBpbnN0cnVjdGlvbi4N
Cg0KQXJlIHlvdSBhbGxvd2luZyBmb3IgdGhlIFJFWCBwcmVmaXggYXQgYWxsPw0KVGhlIGVuY29k
aW5nIG9mOg0KPiA+ID4gKyAgICAgICogICBjbXBsICAgIDxpZD4sIC02KCVyZWcpICAgICA7IDcg
Ynl0ZXMNCmlzDQoJPG9wY29kZT48bW9kL1RUVC9ybT48b2ZmOD48aW1tMzI+DQp3aGljaCBpcyA3
IGJ5dGVzIHdpdGhvdXQgdGhlIFJFWC4NCklmIHJlZyBpcyByMTEgdGhlcmUgaXMgYW4gZXh0cmEg
UkVYIGJ5dGUgLSBmb3IgOCBpbiB0b3RhbC4NCg0KV2l0aG91dCB0aGUgUkVYIGJ5dGUgdGhlIGRl
Y29kZSB3aWxsIGJlIHVzaW5nICVieC4NClNvIHRoZSB0ZXN0aW5nIHNob3VsZCBhbGwgaGF2ZSBm
YWlsZWQuDQpXaGljaCBtZWFucyB0aGF0IHNvbWV0aGluZyBlbHNlIGlzIHdyb25nIGFzIHdlbGwu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

