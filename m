Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337134AD47A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353354AbiBHJOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbiBHJOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:14:53 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E768C0401F0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:14:52 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-20-tTBzvubUOWqiQLjk6umxoA-1; Tue, 08 Feb 2022 09:14:49 +0000
X-MC-Unique: tTBzvubUOWqiQLjk6umxoA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 8 Feb 2022 09:14:49 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 8 Feb 2022 09:14:49 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] x86: use builtins to read eflags
Thread-Topic: [PATCH v3] x86: use builtins to read eflags
Thread-Index: AQHYHG/CSK+t8Kagc0eLuNqaUHH4EKyJWp+w
Date:   Tue, 8 Feb 2022 09:14:49 +0000
Message-ID: <0d93ea4d847b42ca9c5603cb97cbda8a@AcuMS.aculab.com>
References: <20211229021258.176670-1-morbo@google.com>
 <20220204005742.1222997-1-morbo@google.com>
 <CAKwvOdk=VdDo1fhWJVa4eO0UjuQwtV9kC-cJd0J9-6guU2vafA@mail.gmail.com>
In-Reply-To: <CAKwvOdk=VdDo1fhWJVa4eO0UjuQwtV9kC-cJd0J9-6guU2vafA@mail.gmail.com>
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

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAwNyBGZWJydWFyeSAyMDIyIDIyOjEyDQo+
IA0KPiBPbiBUaHUsIEZlYiAzLCAyMDIyIGF0IDQ6NTcgUE0gQmlsbCBXZW5kbGluZyA8bW9yYm9A
Z29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBHQ0MgYW5kIENsYW5nIGJvdGggaGF2ZSBidWls
dGlucyB0byByZWFkIGFuZCB3cml0ZSB0aGUgRUZMQUdTIHJlZ2lzdGVyLg0KPiA+IFRoaXMgYWxs
b3dzIHRoZSBjb21waWxlciB0byBkZXRlcm1pbmUgdGhlIGJlc3Qgd2F5IHRvIGdlbmVyYXRlIHRo
aXMNCj4gPiBjb2RlLCB3aGljaCBjYW4gaW1wcm92ZSBjb2RlIGdlbmVyYXRpb24uDQo+ID4NCj4g
PiBUaGlzIGlzc3VlIGFyb3NlIGR1ZSB0byBDbGFuZydzIGlzc3VlIHdpdGggdGhlICI9cm0iIGNv
bnN0cmFpbnQuICBDbGFuZw0KPiA+IGNob29zZXMgdG8gYmUgY29uc2VydmF0aXZlIGluIHRoZXNl
IHNpdHVhdGlvbnMsIGFuZCBzbyB1c2VzIG1lbW9yeQ0KPiA+IGluc3RlYWQgb2YgcmVnaXN0ZXJz
LiBUaGlzIGlzIGEga25vd24gaXNzdWUsIHdoaWNoIGlzIGN1cnJlbnRseSBiZWluZw0KPiA+IGFk
ZHJlc3NlZC4NCg0KSG93IG11Y2ggcGVyZm9ybWFuY2Ugd291bGQgYmUgbG9zdCBieSBqdXN0IHVz
aW5nICI9ciI/DQoNCllvdSBnZXQgdHdvIGluc3RydWN0aW9ucyBpZiB0aGUgYWN0dWFsIHRhcmdl
dCBpcyBtZW1vcnkuDQpUaGlzIG1pZ2h0IGJlIGEgbWFyZ2luYWwgY29kZSBzaXplIGluY3JlYXNl
IC0gYnV0IG5vdCBtdWNoLA0KSXQgbWlnaHQgYWxzbyBzbG93IHRoaW5ncyBkb3duIGlmIHRoZSBl
eGVjdXRpb24gaXMgbGltaXRlZA0KYnkgdGhlIGluc3RydWN0aW9uIGRlY29kZXIuDQoNCkJ1dCBv
biBJbnRlbCBjcHUgJ3BvcCBtZW1vcnknIGlzIDIgdW9wcywgZXhhY3RseSB0aGUgc2FtZQ0KYXMg
J3BvcCByZWdpc3RlcicgJ3N0b3JlIHJlZ2lzdGVyJyAoYW5kIEkgdGhpbmsgYW1kIGlzIHNpbWls
YXIpLg0KU28gdGhlIGFjdHVhbCBleGVjdXRpb24gdGltZSBpcyBleGFjdGx5IHRoZSBzYW1lIGZv
ciBib3RoLg0KDQpBbHNvIGl0IGxvb2tzIGxpa2UgY2xhbmcncyBidWlsdGluIGlzIGVmZmVjdGl2
ZWx5ICI9ciIuDQpDb21waWxpbmc6DQpsb25nIGZsOw0Kdm9pZCBuYXRpdmVfc2F2ZV9mbCh2b2lk
KSB7DQogICAgICAgZmwgPSBfX2J1aWx0aW5faWEzMl9yZWFkZWZsYWdzX3U2NCgpOw0KfQ0KTm90
IG9ubHkgZ2VuZXJhdGVzIGEgc3RhY2sgZnJhbWUsIGl0IGFsc28gZ2VuZXJhdGVzOg0KcHVzaGY7
IHBvcCAlcmF4OyBtb3YgbWVtLCAlcmF4Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

