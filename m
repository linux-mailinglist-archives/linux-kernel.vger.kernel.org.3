Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7631C48C69D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354392AbiALO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:58:17 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:50768 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354382AbiALO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:58:16 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-138-PRd9B9jAPKiWgPy9P27ZCQ-1; Wed, 12 Jan 2022 14:58:14 +0000
X-MC-Unique: PRd9B9jAPKiWgPy9P27ZCQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Wed, 12 Jan 2022 14:58:14 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Wed, 12 Jan 2022 14:58:14 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
CC:     Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, carlos <carlos@redhat.com>
Subject: RE: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
Thread-Topic: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
Thread-Index: AdgHxNJPmHALYHCBSGGqQq0pyoAGXA==
Date:   Wed, 12 Jan 2022 14:58:14 +0000
Message-ID: <71e7d09733df4a899d12b7ef25198bbc@AcuMS.aculab.com>
References: <20220110171611.8351-1-mathieu.desnoyers@efficios.com>
 <20220111110556.inteixgtl5vpmka7@wittgenstein>
 <1626924888.21447.1641922985771.JavaMail.zimbra@efficios.com>
 <20220112084617.32bjjo774n7vvyct@wittgenstein>
 <1475639366.24565.1641998849957.JavaMail.zimbra@efficios.com>
In-Reply-To: <1475639366.24565.1641998849957.JavaMail.zimbra@efficios.com>
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

PiAgKiBbKl0gVGhlIG9wZW5yaXNjLCBwb3dlcnBjNjQgYW5kIHg4Ni02NCBhcmNoaXRlY3R1cmVz
IGRlZmluZSBhICJyZWR6b25lIiBhcyBhDQo+ICAqICAgICBzdGFjayBhcmVhIGJleW9uZCB0aGUg
c3RhY2sgcG9pbnRlciB3aGljaCBjYW4gYmUgdXNlZCBieSB0aGUgY29tcGlsZXINCj4gICogICAg
IHRvIHN0b3JlIGxvY2FsIHZhcmlhYmxlcyBpbiBsZWFmIGZ1bmN0aW9ucy4NCg0KSSB3b25kZXIg
aWYgdGhhdCBpcyByZWFsbHkgd29ydGggdGhlIHRyb3VibGUgaXQgY2F1c2VzIQ0KQnkgdGhlIHRp
bWUgYSBmdW5jdGlvbiBpcyBzcGlsbGluZyB2YWx1ZXMgdG8gc3RhY2sgdGhlIGNvc3QNCm9mIGEg
JXNwIHVwZGF0ZSBpcyBhbG1vc3QgY2VydGFpbmx5IG5vaXNlLg0KDQpTb21lb25lIGNsZWFybHkg
dGhvdWdodCBpdCB3YXMgYSAnZ29vZCBpZGVhICh0bSknLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

