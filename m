Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323E8487EE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiAGW1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:27:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:48847 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230394AbiAGW1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:27:20 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-219-GzmGcsiPPsqXIUsDuFKxjQ-1; Fri, 07 Jan 2022 22:27:18 +0000
X-MC-Unique: GzmGcsiPPsqXIUsDuFKxjQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 7 Jan 2022 22:27:17 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 7 Jan 2022 22:27:17 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fw@deneb.enyo.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>
Subject: RE: [RFC PATCH] rseq: x86: implement abort-at-ip extension
Thread-Topic: [RFC PATCH] rseq: x86: implement abort-at-ip extension
Thread-Index: AdgEFboSAErst/O1Thaz4M9J8smUeQ==
Date:   Fri, 7 Jan 2022 22:27:17 +0000
Message-ID: <701ff3888b3f42f4a6a1dded84b79078@AcuMS.aculab.com>
References: <20220107170302.8325-1-mathieu.desnoyers@efficios.com>
 <87a6g7ny0j.fsf@mid.deneb.enyo.de>
 <1968088162.13310.1641584935813.JavaMail.zimbra@efficios.com>
 <1300078200.13848.1641590867024.JavaMail.zimbra@efficios.com>
In-Reply-To: <1300078200.13848.1641590867024.JavaMail.zimbra@efficios.com>
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

PiBUaGF0IGJlaW5nIHNhaWQsIHRoZXJlIG1pZ2h0IGJlIGFuIGFyY2hpdGVjdHVyZSBhZ25vc3Rp
YyBhbHRlcm5hdGl2ZSBhdmFpbGFibGUuDQo+IE9uIGFib3J0IG9mIGEgUlNFUV9DU19GTEFHX0FC
T1JUX0FUX0lQIGNyaXRpY2FsIHNlY3Rpb24sIHdlIGNvdWxkIGxldCB0aGUga2VybmVsDQo+IGRl
Y3JlbWVudC9pbmNyZW1lbnQgdGhlIHN0YWNrIHBvaW50ZXIgdG8gbWFrZSByb29tIGZvciBhIHBv
aW50ZXIgKGRlcGVuZGluZyBpZiB0aGUNCj4gc3RhY2sgZ3Jvd3MgZG93biBvciB1cCkuIEl0IHdv
dWxkIHRoZW4gc3RvcmUgdGhlIGFib3J0LWF0LWlwIHZhbHVlIGF0IHRoZSB0b3Agb2YNCj4gc3Rh
Y2suDQoNClN0YWNrIHJlZHpvbmUgaW4gYSBsZWFmIGZ1bmN0aW9uPw0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

