Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D596548C6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354448AbiALPPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:15:31 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:21368 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354458AbiALPPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:15:30 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-89-tNDfIHeVOGSXjjHD7BfLmw-1; Wed, 12 Jan 2022 15:15:28 +0000
X-MC-Unique: tNDfIHeVOGSXjjHD7BfLmw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Wed, 12 Jan 2022 15:15:27 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Wed, 12 Jan 2022 15:15:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>
CC:     Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, carlos <carlos@redhat.com>
Subject: RE: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
Thread-Topic: [RFC PATCH v2 1/2] rseq: x86: implement abort-at-ip extension
Thread-Index: AdgHxNJPmHALYHCBSGGqQq0pyoAGXDSYsRN7NJggl0A=
Date:   Wed, 12 Jan 2022 15:15:27 +0000
Message-ID: <0088806280f54211b3f90b2c1a82a140@AcuMS.aculab.com>
References: <20220110171611.8351-1-mathieu.desnoyers@efficios.com>
 <20220111110556.inteixgtl5vpmka7@wittgenstein>
 <1626924888.21447.1641922985771.JavaMail.zimbra@efficios.com>
 <20220112084617.32bjjo774n7vvyct@wittgenstein>
 <1475639366.24565.1641998849957.JavaMail.zimbra@efficios.com>
 <71e7d09733df4a899d12b7ef25198bbc@AcuMS.aculab.com>
 <1953851780.24610.1641999934047.JavaMail.zimbra@efficios.com>
In-Reply-To: <1953851780.24610.1641999934047.JavaMail.zimbra@efficios.com>
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

RnJvbTogTWF0aGlldSBEZXNub3llcnMNCj4gU2VudDogMTIgSmFudWFyeSAyMDIyIDE1OjA2DQo+
IA0KPiAtLS0tLSBPbiBKYW4gMTIsIDIwMjIsIGF0IDk6NTggQU0sIERhdmlkIExhaWdodCBEYXZp
ZC5MYWlnaHRAQUNVTEFCLkNPTSB3cm90ZToNCj4gDQo+ID4+ICAqIFsqXSBUaGUgb3BlbnJpc2Ms
IHBvd2VycGM2NCBhbmQgeDg2LTY0IGFyY2hpdGVjdHVyZXMgZGVmaW5lIGEgInJlZHpvbmUiIGFz
IGENCj4gPj4gICogICAgIHN0YWNrIGFyZWEgYmV5b25kIHRoZSBzdGFjayBwb2ludGVyIHdoaWNo
IGNhbiBiZSB1c2VkIGJ5IHRoZSBjb21waWxlcg0KPiA+PiAgKiAgICAgdG8gc3RvcmUgbG9jYWwg
dmFyaWFibGVzIGluIGxlYWYgZnVuY3Rpb25zLg0KPiA+DQo+ID4gSSB3b25kZXIgaWYgdGhhdCBp
cyByZWFsbHkgd29ydGggdGhlIHRyb3VibGUgaXQgY2F1c2VzIQ0KPiA+IEJ5IHRoZSB0aW1lIGEg
ZnVuY3Rpb24gaXMgc3BpbGxpbmcgdmFsdWVzIHRvIHN0YWNrIHRoZSBjb3N0DQo+ID4gb2YgYSAl
c3AgdXBkYXRlIGlzIGFsbW9zdCBjZXJ0YWlubHkgbm9pc2UuDQo+ID4NCj4gPiBTb21lb25lIGNs
ZWFybHkgdGhvdWdodCBpdCB3YXMgYSAnZ29vZCBpZGVhICh0bSknLg0KPiANCj4gSSBtdXN0IGFk
bWl0IHRoYXQgSSd2ZSBiZWVuIHN1cnByaXNlZCB0byBsZWFybiBhYm91dCB0aGVzZSByZWR6b25l
cy4gVGhhbmtzIGZvcg0KPiBwb2ludGluZyB0aGVtIG91dCB0byBtZSwgaXQgd2FzIGNsZWFybHkg
YSBibGluZCBzcG90LiBJIHN1c3BlY3QgaXQgd291bGQgYmUgdXNlZnVsDQo+IHRvIGludHJvZHVj
ZSBwZXItYXJjaGl0ZWN0dXJlIEtFUk5FTF9SRURaT05FLCBVU0VSX1JFRFpPTkUgYW5kIENPTVBB
VF9VU0VSX1JFRFpPTkUNCj4gd2l0aCBhIGFzbS1nZW5lcmljIHZlcnNpb24gZGVmaW5pbmcgdGhl
bSB0byAwLCB3aXRoIHByb3BlciBkb2N1bWVudGF0aW9uLiBJdCB3b3VsZA0KPiBtYWtlIGl0IGNs
ZWFyZXIgdG8ga2VybmVsIGRldmVsb3BlcnMgd29ya2luZyBvbiBzdHVmZiBzaW1pbGFyIHRvIHNp
Z25hbCBoYW5kbGVyDQo+IGRlbGl2ZXJ5IHRoYXQgdGhleSBuZWVkIHRvIGNvbnNpZGVyIHRoZXNl
IGNhcmVmdWxseS4NCg0KVGhleSBjYW4gbmV2ZXIgYmUgdXNlZCBpbiBrZXJuZWwgLSBhbnkgSVNS
IHdvdWxkIG92ZXJ3cml0ZSB0aGVtLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

