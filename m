Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAD24714E9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 18:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhLKRXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 12:23:31 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:39810 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbhLKRXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:23:30 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-156-9pJhWHy6NHa86b7WZNfOPw-1; Sat, 11 Dec 2021 17:23:28 +0000
X-MC-Unique: 9pJhWHy6NHa86b7WZNfOPw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Sat, 11 Dec 2021 17:23:27 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Sat, 11 Dec 2021 17:23:26 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Collingbourne' <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        "Alexander Potapenko" <glider@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>
Subject: RE: [PATCH v4 0/7] kernel: introduce uaccess logging
Thread-Topic: [PATCH v4 0/7] kernel: introduce uaccess logging
Thread-Index: AQHX7UpWadBINBQ4oUSeJNLk/BiYRKwtinPA
Date:   Sat, 11 Dec 2021 17:23:26 +0000
Message-ID: <fce9898e392f42a0830892a1735deb3e@AcuMS.aculab.com>
References: <20211209221545.2333249-1-pcc@google.com>
In-Reply-To: <20211209221545.2333249-1-pcc@google.com>
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

RnJvbTogUGV0ZXIgQ29sbGluZ2JvdXJuZQ0KPiBTZW50OiAwOSBEZWNlbWJlciAyMDIxIDIyOjE2
DQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2VzIGEga2VybmVsIGZlYXR1cmUga25v
d24gYXMgdWFjY2Vzcw0KPiBsb2dnaW5nLCB3aGljaCBhbGxvd3MgdXNlcnNwYWNlIHByb2dyYW1z
IHRvIGJlIG1hZGUgYXdhcmUgb2YgdGhlDQo+IGFkZHJlc3MgYW5kIHNpemUgb2YgdWFjY2Vzc2Vz
IHBlcmZvcm1lZCBieSB0aGUga2VybmVsIGR1cmluZw0KPiB0aGUgc2VydmljaW5nIG9mIGEgc3lz
Y2FsbC4gTW9yZSBkZXRhaWxzIG9uIHRoZSBtb3RpdmF0aW9uDQo+IGZvciBhbmQgaW50ZXJmYWNl
IHRvIHRoaXMgZmVhdHVyZSBhcmUgYXZhaWxhYmxlIGluIHRoZSBmaWxlDQo+IERvY3VtZW50YXRp
b24vYWRtaW4tZ3VpZGUvdWFjY2Vzcy1sb2dnaW5nLnJzdCBhZGRlZCBieSB0aGUgZmluYWwNCj4g
cGF0Y2ggaW4gdGhlIHNlcmllcy4NCg0KSG93IGRvZXMgdGhpcyB3b3JrIHdoZW4gZ2V0X3VzZXIo
KSBhbmQgcHV0X3VzZXIoKSBhcmUgdXNlZCB0bw0KZG8gb3B0aW1pc2VkIGNvcGllcz8NCg0KV2hp
bGUgYWRkaW5nIGNoZWNrcyB0byBjb3B5X3RvL2Zyb21fdXNlcigpIGlzIGdvaW5nIHRvIGhhdmUN
CmEgbWVhc3VyYWJsZSBwZXJmb3JtYW5jZSBpbXBhY3QgLSBldmVuIGlmIG5vdGhpbmcgaXMgZG9u
ZSwNCmFkZGluZyB0aGVtIHRvIGdldC9wdXRfdXNlcigpIChhbmQgZnJpZW5kcykgaXMgZ29pbmcg
dG8NCm1ha2Ugc29tZSBob3QgcGF0aHMgcmVhbGx5IHNsb3cuDQoNClNvIG1heWJlIHlvdSBjb3Vs
ZCBhZGQgaXQgc28gS0FTQU4gdGVzdCBrZXJuZWxzLCBidXQgeW91IGNhbid0DQpzZW5zaWJseSBl
bmFibGUgaXQgb24gYSBwcm9kdWN0aW9uIGtlcm5lbC4NCg0KTm93LCBpdCBtaWdodCBiZSB0aGF0
IHlvdSBjb3VsZCBzZW1pLXNlbnNpYmx5IGxvZyAnZGF0YScgdHJhbnNmZXJzLg0KQnV0IGhhdmUg
eW91IGFjdHVhbGx5IGxvb2tlZCBhdCBhbGwgdGhlIHRyYW5zZmVycyB0aGF0IGhhcHBlbg0KZm9y
IHNvbWV0aGluZyBsaWtlIHNlbmRtc2coKS4NClRoZSAndXNlciBjb3B5IGhhcmRlbmluZycgY29k
ZSBhbHJlYWR5IGhhcyBhIHNpZ25pZmljYW50IGltcGFjdA0Kb24gdGhhdCBjb2RlIChpbiBtYW55
IHBsYWNlcykuDQoNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

