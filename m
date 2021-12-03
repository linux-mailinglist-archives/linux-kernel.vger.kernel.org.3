Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351DD4673DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379550AbhLCJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:23:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:29123 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351316AbhLCJX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:23:29 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91--7c1WWoYN2uhy3DyISQqag-1; Fri, 03 Dec 2021 09:20:03 +0000
X-MC-Unique: -7c1WWoYN2uhy3DyISQqag-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 3 Dec 2021 09:20:02 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 3 Dec 2021 09:20:02 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 00/10] x86: Allocate AVX512 xstate ondemand
Thread-Topic: [RFC PATCH 00/10] x86: Allocate AVX512 xstate ondemand
Thread-Index: AQHX5+Ds8R196ucx3kmBJZhfmN/yXawgfKWg
Date:   Fri, 3 Dec 2021 09:20:01 +0000
Message-ID: <e332573f03ec441d9b357c7cfb6852ba@AcuMS.aculab.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
 <822ced92-f165-3c5a-e0bf-dafa6f808b76@intel.com>
 <27b6387f-fa93-484e-a56e-12452a82f069@www.fastmail.com>
 <d7be6ef4-f73e-923e-93b7-ef254bf347c0@intel.com>
In-Reply-To: <d7be6ef4-f73e-923e-93b7-ef254bf347c0@intel.com>
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

RnJvbTogRGF2ZSBIYW5zZW4NCj4gU2VudDogMDMgRGVjZW1iZXIgMjAyMSAwMDo1OQ0KPiANCj4g
T24gMTIvMi8yMSA0OjQ1IFBNLCBKaWF4dW4gWWFuZyB3cm90ZToNCj4gPiDlnKgyMDIx5bm0MTLm
nIgz5pel5Y2B5LqM5pyIIOS4iuWNiDEyOjQw77yMRGF2ZSBIYW5zZW7lhpnpgZPvvJoNCj4gPj4g
T24gMTIvMi8yMSA0OjM2IFBNLCBKaWF4dW4gWWFuZyB3cm90ZToNCj4gPj4+IEFsc28gd2UgYXJl
IGdvaW5nIHRvIGhhdmUgaGV0ZXJvZ2VuZW91cyBwcm9jZXNzb3JzIHRoYXQNCj4gPj4+IG9ubHkg
c29tZSBjb3JlcyBzdXBwb3J0IEFWWDUxMiwgaXQgY2FuIGJlIGhlbHBmdWwgd2hlbg0KPiA+Pj4g
ZGVhbGluZyB3aXRoIHN1Y2ggcHJvY2Vzc29ycy4NCj4gPj4gUmVhbGx5PyAgV2hpY2ggeDg2IHZl
bmRvciBpcyBkb2luZyB0aGF0Pw0KDQo+ID4gQ2xlYXIgbG93ZXIgdHdvIGJpdHMgb2YgTVNSIDB4
QUYgb24gQWxkZXIgTGFrZSBnaXZlIG1lIHNvbWUgc3VwcmlzZSA6LSkNCj4gDQo+IEkgaG9uZXN0
bHkgZG9uJ3Qga25vdyB3aGF0IHlvdSdyZSB0YWxraW5nIGFib3V0LiAgRG9lcyBwb2tpbmcgdGhh
dCBNU1INCj4gYWxsb3dpbmcgQVZYNTEyIGluc3RydWN0aW9ucyB0byBiZSBleGVjdXRlZCBvbiBj
b3JlcyB3aGVyZSBpdCB3YXMNCj4gb3RoZXJ3aXNlIGRpc2FibGVkPyAgVGhhdCdzIGVudGVydGFp
bmluZywgYnV0IGl0J3MgZmFyIGZyb20gInN1cHBvcnRlZCINCj4gb3IgZXZlbiBzdXBwb3J0KmFi
bGUqIGluIExpbnV4Lg0KDQpJIGNhbiBhbHNvIGltYWdpbmUgY2hpcHMgYmVpbmcgdGVzdGVkIGFu
ZCB0ZXN0ZWQgYW5kIG1hcmtlZA0KZGlmZmVyZW50bHkgZGVwZW5kaW5nIG9uIHdoYXQgd29ya3Mu
DQoNClNvIGEgcGFydCB3aXRoIGZhdWx0eSBBVlg1MTIgd2lsbCBiZSBtYXJrZWQgYXMgQklHK2xp
dHRsZSB3aXRoIEFWWDUxMiBkaXNhYmxlZC4NCkEgcGFydCB3aXRoIHdvcmtpbmcgQVZYNTEyIHdp
bGwgaGF2ZSB0aGUgJ2xpdHRsZScgY3B1IGRpc2FibGVkLg0KDQpBIGxvdCBvZiB0aGlzIGlzIGFj
dHVhbGx5IHNldHVwIGJ5IHRoZSBCSU9TIGNvZGUuDQpDaGVhdGluZyB3aWxsIGNhdXNlIGdyaWVm
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

