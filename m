Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D05473842
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbhLMXHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:07:53 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:27616 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234834AbhLMXHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:07:52 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-148-HjWL4iprNbOk-cYtT8YBng-1; Mon, 13 Dec 2021 23:07:44 +0000
X-MC-Unique: HjWL4iprNbOk-cYtT8YBng-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Mon, 13 Dec 2021 23:07:42 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Mon, 13 Dec 2021 23:07:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Collingbourne' <pcc@google.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        "Alexander Potapenko" <glider@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>
Subject: RE: [PATCH v4 0/7] kernel: introduce uaccess logging
Thread-Topic: [PATCH v4 0/7] kernel: introduce uaccess logging
Thread-Index: AQHX7UpWadBINBQ4oUSeJNLk/BiYRKwtinPAgANPzICAADN0UA==
Date:   Mon, 13 Dec 2021 23:07:42 +0000
Message-ID: <d160399eb8e6476496e0ae3fc61c0897@AcuMS.aculab.com>
References: <20211209221545.2333249-1-pcc@google.com>
 <fce9898e392f42a0830892a1735deb3e@AcuMS.aculab.com>
 <CAMn1gO5mBHR3-Wd2CyxQ8PYt8apTiWNOtFwKY4duwXvGwkZFWA@mail.gmail.com>
In-Reply-To: <CAMn1gO5mBHR3-Wd2CyxQ8PYt8apTiWNOtFwKY4duwXvGwkZFWA@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGV0ZXIgQ29sbGluZ2JvdXJuZQ0KPiBTZW50OiAxMyBEZWNlbWJlciAyMDIxIDE5OjQ5
DQo+IA0KPiBPbiBTYXQsIERlYyAxMSwgMjAyMSBhdCA5OjIzIEFNIERhdmlkIExhaWdodCA8RGF2
aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGV0ZXIgQ29sbGlu
Z2JvdXJuZQ0KPiA+ID4gU2VudDogMDkgRGVjZW1iZXIgMjAyMSAyMjoxNg0KPiA+ID4NCj4gPiA+
IFRoaXMgcGF0Y2ggc2VyaWVzIGludHJvZHVjZXMgYSBrZXJuZWwgZmVhdHVyZSBrbm93biBhcyB1
YWNjZXNzDQo+ID4gPiBsb2dnaW5nLCB3aGljaCBhbGxvd3MgdXNlcnNwYWNlIHByb2dyYW1zIHRv
IGJlIG1hZGUgYXdhcmUgb2YgdGhlDQo+ID4gPiBhZGRyZXNzIGFuZCBzaXplIG9mIHVhY2Nlc3Nl
cyBwZXJmb3JtZWQgYnkgdGhlIGtlcm5lbCBkdXJpbmcNCj4gPiA+IHRoZSBzZXJ2aWNpbmcgb2Yg
YSBzeXNjYWxsLiBNb3JlIGRldGFpbHMgb24gdGhlIG1vdGl2YXRpb24NCj4gPiA+IGZvciBhbmQg
aW50ZXJmYWNlIHRvIHRoaXMgZmVhdHVyZSBhcmUgYXZhaWxhYmxlIGluIHRoZSBmaWxlDQo+ID4g
PiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3VhY2Nlc3MtbG9nZ2luZy5yc3QgYWRkZWQgYnkg
dGhlIGZpbmFsDQo+ID4gPiBwYXRjaCBpbiB0aGUgc2VyaWVzLg0KPiA+DQo+ID4gSG93IGRvZXMg
dGhpcyB3b3JrIHdoZW4gZ2V0X3VzZXIoKSBhbmQgcHV0X3VzZXIoKSBhcmUgdXNlZCB0bw0KPiA+
IGRvIG9wdGltaXNlZCBjb3BpZXM/DQo+ID4NCj4gPiBXaGlsZSBhZGRpbmcgY2hlY2tzIHRvIGNv
cHlfdG8vZnJvbV91c2VyKCkgaXMgZ29pbmcgdG8gaGF2ZQ0KPiA+IGEgbWVhc3VyYWJsZSBwZXJm
b3JtYW5jZSBpbXBhY3QgLSBldmVuIGlmIG5vdGhpbmcgaXMgZG9uZSwNCj4gPiBhZGRpbmcgdGhl
bSB0byBnZXQvcHV0X3VzZXIoKSAoYW5kIGZyaWVuZHMpIGlzIGdvaW5nIHRvDQo+ID4gbWFrZSBz
b21lIGhvdCBwYXRocyByZWFsbHkgc2xvdy4NCj4gPg0KPiA+IFNvIG1heWJlIHlvdSBjb3VsZCBh
ZGQgaXQgc28gS0FTQU4gdGVzdCBrZXJuZWxzLCBidXQgeW91IGNhbid0DQo+ID4gc2Vuc2libHkg
ZW5hYmxlIGl0IG9uIGEgcHJvZHVjdGlvbiBrZXJuZWwuDQo+ID4NCj4gPiBOb3csIGl0IG1pZ2h0
IGJlIHRoYXQgeW91IGNvdWxkIHNlbWktc2Vuc2libHkgbG9nICdkYXRhJyB0cmFuc2ZlcnMuDQo+
ID4gQnV0IGhhdmUgeW91IGFjdHVhbGx5IGxvb2tlZCBhdCBhbGwgdGhlIHRyYW5zZmVycyB0aGF0
IGhhcHBlbg0KPiA+IGZvciBzb21ldGhpbmcgbGlrZSBzZW5kbXNnKCkuDQo+ID4gVGhlICd1c2Vy
IGNvcHkgaGFyZGVuaW5nJyBjb2RlIGFscmVhZHkgaGFzIGEgc2lnbmlmaWNhbnQgaW1wYWN0DQo+
ID4gb24gdGhhdCBjb2RlIChpbiBtYW55IHBsYWNlcykuDQo+IA0KPiBIaSBEYXZpZCwNCj4gDQo+
IFllcywgSSByZWFsaXNlZCBhZnRlciBJIHNlbnQgb3V0IG15IHBhdGNoIChhbmQgd2hpbGUgd3Jp
dGluZyB0ZXN0DQo+IGNhc2VzIGZvciBpdCkgdGhhdCBpdCBkaWRuJ3QgY292ZXIgZ2V0X3VzZXIo
KS9wdXRfdXNlcigpLiBJIGhhdmUgYQ0KPiBwYXRjaCB1bmRlciBkZXZlbG9wbWVudCB0aGF0IHdp
bGwgYWRkIHRoaXMgY292ZXJhZ2UuIEkgdXNlZCBpdCB0byBydW4NCj4gbXkgaW52YWxpZCBzeXNj
YWxsIGFuZCB1bmFtZSBiZW5jaG1hcmtzIGFuZCB0aGUgcmVzdWx0cyB3ZXJlIGJhc2ljYWxseQ0K
PiB0aGUgc2FtZSBhcyB3aXRob3V0IHRoZSBjb3ZlcmFnZS4NCj4gDQo+IEFyZSB5b3UgYXdhcmUg
b2YgYW55IGJlbmNobWFya3MgdGhhdCBjb3ZlciBzZW5kbXNnKCk/IEkgY2FuIHRyeSB0bw0KPiBs
b29rIGF0IHdyaXRpbmcgbXkgb3duIGlmIG5vdC4gSSB3YXMgYWxzbyBwbGFubmluZyB0byB3cml0
ZSBhDQo+IGJlbmNobWFyayB0aGF0IHVzZXMgZ2V0cmVzdWlkKCkgYXMgdGhpcyB3YXMgdGhlIHNp
bXBsZXN0IHN5c2NhbGwgdGhhdA0KPiBJIGNvdWxkIGZpbmQgdGhhdCBkb2VzIG11bHRpcGxlIHB1
dF91c2VyKCkgY2FsbHMuDQoNCkFsc28gbG9vayBhdCBzeXNfcG9sbCgpIEkgdGhpbmsgdGhhdCB1
c2VzIF9fcHV0L2dldF91c2VyKCkuDQoNCkkgdGhpbmsgeW91J2xsIGZpbmQgc29tZSBvZiB0aGUg
c29ja2V0IG9wdGlvbiBjb2RlIGFsc28gdXNlcyBnZXRfdXNlcigpLg0KDQpUaGVyZSBpcyBhbHNv
IHRoZSBjb21wYXQgY29kZSBmb3IgaW1wb3J0X2lvdmVjKCkuDQpJSVJDIHRoYXQgaXMgYWN0dWFs
bHkgZmFzdGVyIHRoYW4gdGhlIG5vbi1jb21wYXQgdmVyc2lvbiBhdCB0aGUgbW9tZW50Lg0KDQpJ
IGRpZCBzb21lIGJlbmNobWFya2luZyBvZiB3cml0ZXYoIi9kZXYvbnVsbCIsIGlvdiwgMTApOw0K
VGhlIGNvc3Qgb2YgcmVhZGluZyBpbiB0aGUgaW92ZWMgaXMgc2lnbmlmaWNhbnQgaW4gdGhhdCBj
YXNlLg0KTWF5YmUgSSBvdWdodCB0byBmaW5kIHRpbWUgdG8gc29ydCBvdXQgbXkgcGF0Y2hlcy4N
Cg0KRm9yIHNlbmRtc2coKSB1c2luZyBfX2NvcHlfZnJvbV91c2VyKCkgdG8gYXZvaWQgdGhlIHVz
ZXItY29weQ0KaGFyZGVuaW5nIGNoZWNrcyBhbHNvIG1ha2VzIGEgbWVhc3VyYWJsZSBkaWZmZXJl
bmNlIHdoZW4gc2VuZGluZyBVRFANCnRocm91Z2ggcmF3IHNvY2tldHMgLSB3aGljaCB3ZSBkbyBh
IGxvdCBvZi4NCg0KSSB0aGluayB5b3UnZCBuZWVkIHRvIGluc3RydW1lbnQgdXNlcl9hY2Nlc3Nf
YmVnaW4oKSBhbmQgYWxzbyBiZSBhYmxlDQp0byBtZXJnZSB0cmFjZSBlbnRyaWVzIChmb3IgbXVs
dGlwbGUgZ2V0X3VzZXIoKSBjYWxscykuDQoNCllvdSByZWFsbHkgZG9uJ3QgaGF2ZSB0byBsb29r
IGZhciB0byBmaW5kIHBsYWNlcyB3aGVyZSBjb3B5X3RvL2Zyb21fdXNlcigpDQppcyBvcHRpbWlz
ZWQgdG8gbXVsdGlwbGUgZ2V0L3B1dF91c2VyKCkgb3IgX19nZXQvcHV0X3VzZXIoKSAob3IgYXJl
IHRoZXkNCnRoZSAnbm9mYXVsdCcgdmFyaWFudHM/KQ0KVGhvc2UgYXJlIGFsbCBob3QgcGF0aHMg
LSBhdCBsZWFzdCBmb3Igc29tZSB3b3JrbG9hZHMuDQpTbyBhZGRpbmcgYW55dGhpbmcgdGhlcmUg
aXNuJ3QgbGlrZWx5IHRvIGJlIGFjY2VwdGVkIGZvciBwcm9kdWN0aW9uIGtlcm5lbHMuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

