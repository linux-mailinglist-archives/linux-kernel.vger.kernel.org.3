Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3405C58D4BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiHIHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiHIHik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:38:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 386F31EED3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 00:38:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-82-hpQrFnagMDiwY00xHxje_Q-1; Tue, 09 Aug 2022 08:38:36 +0100
X-MC-Unique: hpQrFnagMDiwY00xHxje_Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 9 Aug 2022 08:38:35 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 9 Aug 2022 08:38:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'H. Peter Anvin'" <hpa@zytor.com>,
        'Kanna Scarlet' <knscarlet@gnuweeb.org>,
        Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Bill Metzenthen <billm@melbpc.org.au>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Roth <michael.roth@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
Thread-Topic: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
Thread-Index: AQHYqC07pBmJLRD/dU+qGFItY3OGOq2gCd9AgAVHBYCAAOQGIA==
Date:   Tue, 9 Aug 2022 07:38:35 +0000
Message-ID: <88f681a6c18944588676f93be10ba1b2@AcuMS.aculab.com>
References: <20220804152656.8840-1-knscarlet@gnuweeb.org>
 <20220804152656.8840-2-knscarlet@gnuweeb.org> <Yuvrd2yWLnyxOVLU@zn.tnic>
 <20220804180805.9077-1-knscarlet@gnuweeb.org>
 <126271e264204581a42b079b51481740@AcuMS.aculab.com>
 <b71d4c4a-10be-a1f5-a95c-90b36e57230a@zytor.com>
In-Reply-To: <b71d4c4a-10be-a1f5-a95c-90b36e57230a@zytor.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
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

RnJvbTogSC4gUGV0ZXIgQW52aW4NCj4gU2VudDogMDggQXVndXN0IDIwMjIgMjA6MDANCj4gDQo+
IE9uIEF1Z3VzdCA1LCAyMDIyIDI6MjY6MDIgQU0gUERULCBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBBQ1VMQUIuQ09NPg0KPiB3cm90ZToNCj4gPkZyb206IEthbm5hIFNjYXJsZXQNCj4gPj4g
U2VudDogMDQgQXVndXN0IDIwMjIgMTk6MDgNCj4gPj4NCj4gPj4gT24gOC80LzIyIDEwOjUzIFBN
LCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+ID4+ID4gQm9udXMgcG9pbnRzIGlmIHlvdSBmaW5k
IG91dCB3aGF0IG90aGVyIGFkdmFudGFnZQ0KPiA+PiA+DQo+ID4+ID4gWE9SIHJlZyxyZWcNCj4g
Pj4gPg0KPiA+PiA+IGhhcyB3aGVuIGl0IGNvbWVzIHRvIGNsZWFyaW5nIGludGVnZXIgcmVnaXN0
ZXJzLg0KPiA+Pg0KPiA+PiBIZWxsbyBzaXIgQm9yaXNsYXYsDQo+ID4+DQo+ID4+IFRoYW5rIHlv
dSBmb3IgeW91ciByZXNwb25zZS4gSSB0cmllZCB0byBmaW5kIG91dCBvdGhlciBhZHZhbnRhZ2Vz
IG9mDQo+ID4+IHhvciByZWcscmVnIG9uIEdvb2dsZSBhbmQgZm91bmQgdGhpczoNCj4gPj4gaHR0
cHM6Ly9zdGFja292ZXJmbG93LmNvbS9hLzMzNjY4Mjk1LzcyNzUxMTQNCj4gPj4NCj4gPj4gICAi
eG9yIChiZWluZyBhIHJlY29nbml6ZWQgemVyb2luZyBpZGlvbSwgdW5saWtlIG1vdiByZWcsIDAp
IGhhcyBzb21lDQo+ID4+ICAgb2J2aW91cyBhbmQgc29tZSBzdWJ0bGUgYWR2YW50YWdlczoNCj4g
Pj4NCj4gPj4gICAxLiBzbWFsbGVyIGNvZGUtc2l6ZSB0aGFuIG1vdiByZWcsMC4gKEFsbCBDUFVz
KQ0KPiA+PiAgIDIuIGF2b2lkcyBwYXJ0aWFsLXJlZ2lzdGVyIHBlbmFsdGllcyBmb3IgbGF0ZXIg
Y29kZS4NCj4gPj4gICAgICAoSW50ZWwgUDYtZmFtaWx5IGFuZCBTbkItZmFtaWx5KS4NCj4gPj4g
ICAzLiBkb2Vzbid0IHVzZSBhbiBleGVjdXRpb24gdW5pdCwgc2F2aW5nIHBvd2VyIGFuZCBmcmVl
aW5nIHVwDQo+ID4+ICAgICAgZXhlY3V0aW9uIHJlc291cmNlcy4gKEludGVsIFNuQi1mYW1pbHkp
DQo+ID4+ICAgNC4gc21hbGxlciB1b3AgKG5vIGltbWVkaWF0ZSBkYXRhKSBsZWF2ZXMgcm9vbSBp
biB0aGUgdW9wIGNhY2hlLWxpbmUNCj4gPj4gICAgICBmb3IgbmVhcmJ5IGluc3RydWN0aW9ucyB0
byBib3Jyb3cgaWYgbmVlZGVkLiAoSW50ZWwgU25CLWZhbWlseSkuDQo+ID4+ICAgNS4gZG9lc24n
dCB1c2UgdXAgZW50cmllcyBpbiB0aGUgcGh5c2ljYWwgcmVnaXN0ZXIgZmlsZS4gKEludGVsDQo+
ID4+ICAgICAgU25CLWZhbWlseSAoYW5kIFA0KSBhdCBsZWFzdCwgcG9zc2libHkgQU1EIGFzIHdl
bGwgc2luY2UgdGhleSB1c2UNCj4gPj4gICAgICBhIHNpbWlsYXIgUFJGIGRlc2lnbiBpbnN0ZWFk
IG9mIGtlZXBpbmcgcmVnaXN0ZXIgc3RhdGUgaW4gdGhlIFJPQg0KPiA+PiAgICAgIGxpa2UgSW50
ZWwgUDYtZmFtaWx5IG1pY3JvYXJjaGl0ZWN0dXJlcy4pIg0KPiA+DQo+ID5Zb3UgbWlzc2VkIG9u
ZSwgYW5kIGFuIGFkZGl0aW9uYWwgY2hhbmdlOg0KPiA+DQo+ID5Vc2UgInhvciAlcmF4LCVyYXgi
IGluc3RlYWQgb2YgInhvciAlZWF4LCVlYXgiIHRvIHNhdmUNCj4gPnRoZSAncmVnJyBwcmVmaXgu
DQo+ID4NCj4gPglEYXZpZA0KPiA+DQo+ID4tDQo+ID5SZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
Cj4gPlJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo+ID4NCj4gPg0KPiANCj4gWW91
IG1lYW4gdGhlIG90aGVyIHdheSBhcm91bmQuLi4NCg0KTWF5YmUgOi0oDQpUaGUgMzJiaXQgdmVy
c2lvbnMgYXJlIGJlc3QuDQpTb21laG93IHRoZSByZWdpc3RlciBuYW1pbmcgY29udmVudGlvbiBl
bmRlZCB1cCBnZXR0aW5nIHNvcnQgb2YgJ2JhY2t3YXJkcycuDQoncmVnaXN0ZXInIGlzIGJpZ2dl
ciB0aGFuICdleHRlbmRlZCcuDQpJJ3ZlICdvbmx5JyBiZWVuIHdyaXRpbmcgeDg2IGFzbSBzaW5j
ZSAxOTgyIQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

