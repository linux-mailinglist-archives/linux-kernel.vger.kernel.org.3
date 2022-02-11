Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D114B302C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353965AbiBKWKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:10:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbiBKWKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:10:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A44F8CF9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:10:02 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-234-heNkNE9MNiONtRLfW4EdGw-1; Fri, 11 Feb 2022 22:09:59 +0000
X-MC-Unique: heNkNE9MNiONtRLfW4EdGw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 11 Feb 2022 22:09:58 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 11 Feb 2022 22:09:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bill Wendling' <morbo@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] x86: use builtins to read eflags
Thread-Topic: [PATCH v4] x86: use builtins to read eflags
Thread-Index: AQHYHs4TBErQZHLpBUiy6+9ZW5FRHqyOjNCAgAAv2wCAACoDUA==
Date:   Fri, 11 Feb 2022 22:09:58 +0000
Message-ID: <6b83fa302b974f749c60fc6c456e055f@AcuMS.aculab.com>
References: <20220204005742.1222997-1-morbo@google.com>
 <20220210223134.233757-1-morbo@google.com>
 <cb2ff5da9b704a9792549a9433dc0ac8@AcuMS.aculab.com>
 <CAGG=3QXvSt=d94iqSV-Y9JVNc+pt-WOZGpSeW--fp=w2ttMvUA@mail.gmail.com>
In-Reply-To: <CAGG=3QXvSt=d94iqSV-Y9JVNc+pt-WOZGpSeW--fp=w2ttMvUA@mail.gmail.com>
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

RnJvbTogQmlsbCBXZW5kbGluZyA+IFNlbnQ6IDExIEZlYnJ1YXJ5IDIwMjIgMTk6MjYNCj4gDQo+
IE9uIEZyaSwgRmViIDExLCAyMDIyIGF0IDg6NDAgQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4gRnJvbTogQmlsbCBXZW5kbGluZw0KPiA+ID4gU2Vu
dDogMTAgRmVicnVhcnkgMjAyMiAyMjozMg0KPiA+ID4NCj4gPiA+IEdDQyBhbmQgQ2xhbmcgYm90
aCBoYXZlIGJ1aWx0aW5zIHRvIHJlYWQgYW5kIHdyaXRlIHRoZSBFRkxBR1MgcmVnaXN0ZXIuDQo+
ID4gPiBUaGlzIGFsbG93cyB0aGUgY29tcGlsZXIgdG8gZGV0ZXJtaW5lIHRoZSBiZXN0IHdheSB0
byBnZW5lcmF0ZSB0aGlzDQo+ID4gPiBjb2RlLCB3aGljaCBjYW4gaW1wcm92ZSBjb2RlIGdlbmVy
YXRpb24uDQo+ID4gPg0KPiA+ID4gVGhpcyBpc3N1ZSBhcm9zZSBkdWUgdG8gQ2xhbmcncyBpc3N1
ZSB3aXRoIHRoZSAiPXJtIiBjb25zdHJhaW50LiAgQ2xhbmcNCj4gPiA+IGNob29zZXMgdG8gYmUg
Y29uc2VydmF0aXZlIGluIHRoZXNlIHNpdHVhdGlvbnMsIGFuZCBzbyB1c2VzIG1lbW9yeQ0KPiA+
ID4gaW5zdGVhZCBvZiByZWdpc3RlcnMuIFRoaXMgaXMgYSBrbm93biBpc3N1ZSwgd2hpY2ggaXMg
Y3VycmVudGx5IGJlaW5nDQo+ID4gPiBhZGRyZXNzZWQuDQo+ID4gPg0KPiA+ID4gSG93ZXZlciwg
dXNpbmcgYnVpbHRpbnMgaXMgYmVuZWZpY2lhbCBpbiBnZW5lcmFsLCBiZWNhdXNlIGl0IHJlbW92
ZXMgdGhlDQo+ID4gPiBidXJkZW4gb2YgZGV0ZXJtaW5pbmcgd2hhdCdzIHRoZSB3YXkgdG8gcmVh
ZCB0aGUgZmxhZ3MgcmVnaXN0ZXIgZnJvbSB0aGUNCj4gPiA+IHByb2dyYW1tZXIgYW5kIHBsYWNl
cyBpdCBvbiB0byB0aGUgY29tcGlsZXIsIHdoaWNoIGhhcyB0aGUgaW5mb3JtYXRpb24NCj4gPiA+
IG5lZWRlZCB0byBtYWtlIHRoYXQgZGVjaXNpb24uDQo+ID4NCj4gPiBFeGNlcHQgdGhhdCBuZWl0
aGVyIGdjYyBub3IgY2xhbmcgYXR0ZW1wdCB0byBtYWtlIHRoYXQgZGVjaXNpb24uDQo+ID4gVGhl
eSBhbHdheXMgZG8gcHVzaGY7IHBvcCBheDsNCj4gPg0KPiBJdCBsb29rcyBsaWtlIGJvdGggR0ND
IGFuZCBDbGFuZyBwb3AgaW50byB2aXJ0dWFsIHJlZ2lzdGVycy4gVGhlDQo+IHJlZ2lzdGVyIGFs
bG9jYXRvciBpcyB0aGVuIGFibGUgdG8gZGV0ZXJtaW5lIGlmIGl0IGNhbiBhbGxvY2F0ZSBhDQo+
IHBoeXNpY2FsIHJlZ2lzdGVyIG9yIGlmIGEgc3RhY2sgc2xvdCBpcyByZXF1aXJlZC4NCg0KRG9p
bmc6DQoJaW50IGZsOw0KCXZvaWQgZih2b2lkKSB7IGZsID0gX19idWlsdGluX2lhMzJfcmVhZGVm
bGFnc191NjQoKTsgfQ0KU2VlbXMgdG8gdXNlIHJlZ2lzdGVyLg0KSWYgaXQgcG9wcyB0byBhIHZp
cnR1YWwgcmVnaXN0ZXIgaXQgd2lsbCBwcm9iYWJseSBuZXZlciBwb3ANCmludG8gYSByZWFsIHRh
cmdldCBsb2NhdGlvbi4NCg0KU2VlIGh0dHBzOi8vZ29kYm9sdC5vcmcvei84YVk4bzhyaGUNCg0K
QnV0IHBlcmZvcm1hbmNlIHdpc2UgdGhlIHBvcCttb3YgaXMganVzdCBvbmUgYnl0ZSBsb25nZXIu
DQpJbnN0cnVjdGlvbiBkZWNvZGUgdGltZSBtaWdodCBiZSBoaWdoZXIgZm9yIHR3byBpbnN0cnVj
dGlvbiwgYnV0IHNpbmNlDQoncG9wIG1lbScgZ2VuZXJhdGVzIDIgdW9wcyAoaW50ZWwpIGl0IG1h
eSBiZSBjb25zdHJhaW5lZCB0byB0aGUgZmlyc3QNCmRlY29kZXIgKEkgY2FuJ3QgcmVtZW1iZXJ0
aGUgZXhhY3QgZGV0YWlscyksIGJ1dCB0aGUgc2VwYXJhdGUgcG9wK21vdg0KY2FuIGJlIGRlY29k
ZWQgaW4gcGFyYWxsZWwgLSBzbyBjb3VsZCBlbmQgdXAgZmFzdGVyLg0KDQpBY3R1YWwgZXhlY3V0
aW9uIHRpbWUgKGlmIHRoYXQgbWFrZXMgYW55IHNlbnNlKSBpcyByZWFsbHkgdGhlIHNhbWUuDQpU
d28gb3BlcmF0aW9ucywgb25lIHBvcCBhbmQgb25lIG1lbW9yeSB3cml0ZS4NCg0KSSBiZXQgeW91
J2QgYmUgaGFyZCBwcmVzc2VkIHRvIGZpbmQgYSBwaWVjZSBvZiBjb2RlIHdoZXJlIGl0IGV2ZW4g
bWFkZQ0KYSBjb25zaXN0ZW50IGRpZmZlcmVuY2UuDQoNCj4gPiAuLi4NCj4gPiA+IHY0OiAtIENs
YW5nIG5vdyBubyBsb25nZXIgZ2VuZXJhdGVzIHN0YWNrIGZyYW1lcyB3aGVuIHVzaW5nIHRoZXNl
IGJ1aWx0aW5zLg0KPiA+ID4gICAgIC0gQ29ycmVjdGVkIG1pc3NwZWxsaW5ncy4NCj4gPg0KPiA+
IFdoaWxlIGNsYW5nICdoZWFkJyBoYXMgYmVlbiBmaXhlZCwgaXQgc2VlbXMgYSBiaXQgcHJlbWF0
dXJlIHRvIHNheQ0KPiA+IGl0IGlzICdmaXhlZCcgZW5vdWdoIGZvciBhbGwgY2xhbmcgYnVpbGRz
IHRvIHVzZSB0aGUgYnVpbHRpbi4NCj4gPg0KPiBUcnVlLCBidXQgaXQncyBiZWVuIGNoZXJyeS1w
aWNrZWQgaW50byB0aGUgY2xhbmcgMTQuMC4wIGJyYW5jaCwgd2hpY2gNCj4gaXMgc2NoZWR1bGVk
IGZvciByZWxlYXNlIGluIE1hcmNoLg0KPiANCj4gPiBTZWVtcyBiZXR0ZXIgdG8gY2hhbmdlIGl0
IChiYWNrKSB0byAiPXIiIGFuZCBjb21tZW50IHRoYXQgdGhpcw0KPiA+IGlzIGN1cnJlbnRseSBh
cyBnb29kIGFzIF9fYnVpbHRpbl9pYTMyX3JlYWRlZmxhZ3NfdTY0KCkgYW5kIHRoYXQNCj4gPiBj
bGFuZyBtYWtlcyBhICdwaWdzIGJyZWFrZmFzdCcgb2YgIj1ybSIgLSB3aGljaCBoYXMgb25seSBt
YXJnaW5hbA0KPiA+IGJlbmVmaXQuDQo+ID4NCj4gVGhhdCB3b3VsZCBiZSBva2F5IGFzIGZhciBh
cyBjb2RlIGdlbmVyYXRpb24gaXMgY29uY2VybmVkLCBidXQgaXQgZG9lcw0KPiBwbGFjZSB0aGUg
YnVyZGVuIG9mIGNvcnJlY3RuZXNzIGJhY2sgb24gdGhlIHByb2dyYW1tZXIuIEFsc28sIGl0IHdh
cw0KPiB0aGF0IGF0IHNvbWUgcG9pbnQsIGJ1dCB3YXMgY2hhbmdlZCB0byAiPXJtIiBoZXJlLiA6
LSkNCg0KQXMgSSBzYWlkLCBhIGNvbW1lbnQgc2hvdWxkIHN0b3AgdGhlIGJvdW5jZS4NCg0KLi4u
DQo+IEkgd2FzIGFibGUgdG8gY29tZSB1cCB3aXRoIGFuIGV4YW1wbGUgd2hlcmUgR0NDIGdlbmVy
YXRlcyAicHVzaGYgOyBwb3AgbWVtIjoNCj4gDQo+ICAgaHR0cHM6Ly9nb2Rib2x0Lm9yZy96Lzly
b2NqZG9hSw0KPiANCj4gKENsYW5nIGdlbmVyYXRlcyBhIHZhcmlhdGlvbiBvZiAicG9wIG1lbSwi
IGFuZCBpcyBob3JyaWJsZSBjb2RlLCBidXQNCj4gaXQncyBtZWFudCBmb3IgZGVtb25zdHJhdGlv
biBwdXJwb3NlcyBvbmx5LikgT25lIGludGVyZXN0aW5nIHRoaW5nDQo+IGFib3V0IHRoZSB1c2Ug
b2YgdGhlIGJ1aWx0aW5zIGlzIHRoYXQgaWYgYXQgYWxsIHBvc3NpYmxlLCB0aGUgInBvcCINCj4g
aW5zdHJ1Y3Rpb24gbWF5IGJlIG1vdmVkIGF3YXkgZnJvbSB0aGUgInB1c2hmIiBpZiBpdCdzIHNh
ZmUgYW5kIHdvdWxkDQo+IHJlZHVjZSByZWdpc3RlciBwcmVzc3VyZS4NCg0KSSB3b3VsZG4ndCB0
cnVzdCB0aGUgY29tcGlsZXIgdG8gZ2V0IHN0YWNrIHBvaW50ZXIgcmVsYXRpdmUgYWNjZXNzZXMN
CnJpZ2h0IGlmIGl0IGRvZXMgbW92ZSB0aGVtIGFwYXJ0Lg0KRGVmaW5pdGVseSBzY29wZSBmb3Ig
aG9ycmlkIGJ1Z3MgOy0pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

