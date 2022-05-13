Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B835C5264A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354674AbiEMObt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379420AbiEMO1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:27:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96D0E5E74F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:26:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-W4fZ4W5BNf20LvCgPbIqkA-1; Fri, 13 May 2022 15:26:54 +0100
X-MC-Unique: W4fZ4W5BNf20LvCgPbIqkA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 13 May 2022 15:26:54 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 13 May 2022 15:26:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexander Potapenko' <glider@google.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [RFCv2 00/10] Linear Address Masking enabling
Thread-Topic: [RFCv2 00/10] Linear Address Masking enabling
Thread-Index: AQHYZrnErY7g4wB/gUe/NECu92+S/a0cqjCAgAAA34CAADGTYA==
Date:   Fri, 13 May 2022 14:26:53 +0000
Message-ID: <ea7faf6e961141c7848e7587d5e369eb@AcuMS.aculab.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAG_fn=URUve59ZPWRawW+BN-bUy7U3QmFsfOz_7L8ndsL4kQFQ@mail.gmail.com>
 <8a47d0ee50b44520a6f26177e6fe7ec5@AcuMS.aculab.com>
 <CAG_fn=XUqzBWzuU0cmjUoSfHTv6pN=LCqGh7Ns8kgR6L169bPw@mail.gmail.com>
In-Reply-To: <CAG_fn=XUqzBWzuU0cmjUoSfHTv6pN=LCqGh7Ns8kgR6L169bPw@mail.gmail.com>
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

RnJvbTogQWxleGFuZGVyIFBvdGFwZW5rbw0KPiBTZW50OiAxMyBNYXkgMjAyMiAxMzoyNg0KPiAN
Cj4gT24gRnJpLCBNYXkgMTMsIDIwMjIgYXQgMToyOCBQTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IC4uLg0KPiA+ID4gT25jZSB3ZSBoYXZl
IHRoZSBwb3NzaWJpbGl0eSB0byBzdG9yZSB0YWdzIGluIHRoZSBwb2ludGVycywgd2UgZG9uJ3QN
Cj4gPiA+IG5lZWQgcmVkem9uZXMgZm9yIGhlYXAvc3RhY2sgb2JqZWN0cyBhbnltb3JlLCB3aGlj
aCBzYXZlcyBxdWl0ZSBhIGJpdA0KPiA+ID4gb2YgbWVtb3J5Lg0KPiA+DQo+ID4gWW91IHN0aWxs
IG5lZWQgcmVkem9uZXMuDQo+ID4gVGhlIGhpZ2ggYml0cyBhcmUgaWdub3JlZCBmb3IgYWN0dWFs
IG1lbW9yeSBhY2Nlc3Nlcy4NCj4gPg0KPiA+IFRvIGRvIG90aGVyd2lzZSB5b3UnZCBuZWVkIHRo
ZSBoaWdoIGJpdHMgdG8gYmUgaW4gdGhlIFBURSwNCj4gPiBjb3BpZWQgdG8gdGhlIFRMQiBhbmQg
ZmluYWxseSBnZXQgaW50byB0aGUgY2FjaGUgdGFnLg0KPiA+DQo+ID4gVGhlbiB5b3UnZCBoYXZl
IHRvIHVzZSB0aGUgY29ycmVjdCB0YWdzIGZvciBlYWNoIHBhZ2UuDQo+IA0KPiBTb3JyeSwgSSBk
b24ndCB1bmRlcnN0YW5kIGhvdyB0aGlzIGlzIHJlbGV2YW50IHRvIEhXQVNhbiBpbiB0aGUgdXNl
cnNwYWNlLg0KPiBMaWtlIGluIEFTYW4sIHdlIGhhdmUgYSBjdXN0b20gYWxsb2NhdG9yIHRoYXQg
YXNzaWducyB0YWdzIHRvIGhlYXANCj4gb2JqZWN0cy4gVGhlIGFzc2lnbmVkIHRhZyBpcyBzdG9y
ZWQgaW4gYm90aCB0aGUgc2hhZG93IG1lbW9yeSBmb3IgdGhlDQo+IG9iamVjdCBhbmQgdGhlIHBv
aW50ZXIgcmV0dXJuZWQgYnkgdGhlIGFsbG9jYXRvci4NCj4gSW5zdHJ1bWVudGF0aW9uIGluc2Vy
dGVkIGJ5IHRoZSBjb21waWxlciBjaGVja3MgdGhlIHBvaW50ZXIgYmVmb3JlDQo+IGV2ZXJ5IG1l
bW9yeSBhY2Nlc3MgYW5kIGVuc3VyZXMgdGhhdCBpdHMgdGFnIG1hdGNoZXMgdGhlIHRhZyBvZiB0
aGUNCj4gb2JqZWN0IGluIHRoZSBzaGFkb3cgbWVtb3J5Lg0KDQpEb2Vzbid0IHRoYXQgYWRkIHNv
IG11Y2ggb3ZlcmhlYWQgdGhhdCB0aGUgc3lzdGVtIHJ1bnMgbGlrZSBhIHNpY2sgcGlnPw0KSSBk
b24ndCBzZWUgYW55IHBvaW50IGFkZGluZyBvdmVyaGVhZCB0byBhIGdlbmVyaWMga2VybmVsIHRv
IHN1cHBvcnQNCnN1Y2ggb3BlcmF0aW9uLg0KDQo+IEEgdGFnIG1pc21hdGNoIGlzIHJlcG9ydGVk
IGFzIGFuIG91dC1vZi1ib3VuZHMgb3IgYSB1c2UtYWZ0ZXItZnJlZSwNCj4gZGVwZW5kaW5nIG9u
IHdoZXRoZXIgdGhlIGFjY2Vzc2VkIG1lbW9yeSBpcyBzdGlsbCBjb25zaWRlcmVkDQo+IGFsbG9j
YXRlZC4NCj4gQmVjYXVzZSBvYmplY3RzIHdpdGggZGlmZmVyZW50IHRhZ3MgZm9sbG93IGVhY2gg
b3RoZXIsIHRoZXJlIGlzIG5vDQo+IG5lZWQgdG8gYWRkIGV4dHJhIHJlZHpvbmVzIHRvIHRoZSBv
YmplY3RzIHRvIGRldGVjdCBidWZmZXIgb3ZlcmZsb3dzLg0KPiAoV2UgbWlnaHQgbmVlZCB0byBp
bmNyZWFzZSB0aGUgb2JqZWN0IGFsaWdubWVudCB0aG91Z2gsIGJ1dCB0aGF0J3MgYQ0KPiBkaWZm
ZXJlbnQgc3RvcnkpLg0KDQpIb3cgZG9lcyBhbGwgdGhhdCBoZWxwIGlmIGEgc3lzdGVtIGNhbGwg
KGVnIHJlYWQoKSkgaXMgZ2l2ZW4NCmFuIGludmFsaWQgbGVuZ3RoLg0KSWYgdGhhdCBsZW5ndGgg
aXMgY2hlY2tlZCB0aGVuIHRoZSAndW5tYXNrZWQnIGFkZHJlc3MgY2FuIGJlDQpwYXNzZWQgdG8g
dGhlIGtlcm5lbC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

