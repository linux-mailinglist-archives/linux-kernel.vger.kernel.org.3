Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B8E4C3BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbiBYCYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiBYCYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:24:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C02B1C74CA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:23:32 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-190-2jFGTaVFM_WwuUDWp3xhNw-1; Fri, 25 Feb 2022 02:23:29 +0000
X-MC-Unique: 2jFGTaVFM_WwuUDWp3xhNw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 25 Feb 2022 02:23:27 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 25 Feb 2022 02:23:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "knsathya@kernel.org" <knsathya@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "sdeep@vmware.com" <sdeep@vmware.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv4 11/30] x86/tdx: Handle in-kernel MMIO
Thread-Topic: [PATCHv4 11/30] x86/tdx: Handle in-kernel MMIO
Thread-Index: AQHYKbrRB70QltnCv0Of3lK/667WPqyjhr+A
Date:   Fri, 25 Feb 2022 02:23:27 +0000
Message-ID: <45b6e0b6ceec46849754402c3da03fed@AcuMS.aculab.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-12-kirill.shutemov@linux.intel.com>
 <af7df79f-02b8-3025-c9a3-929b7bdd33e0@intel.com>
In-Reply-To: <af7df79f-02b8-3025-c9a3-929b7bdd33e0@intel.com>
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

RnJvbTogRGF2ZSBIYW5zZW4NCj4gU2VudDogMjQgRmVicnVhcnkgMjAyMiAyMDoxMg0KLi4uDQo+
ID09PSBMaW1pdGF0aW9ucyBvZiB0aGlzIGFwcHJvYWNoID09PQ0KPiANCj4gPiBNTUlPIGFkZHJl
c3NlcyBjYW4gYmUgdXNlZCB3aXRoIGFueSBDUFUgaW5zdHJ1Y3Rpb24gdGhhdCBhY2Nlc3Nlcw0K
PiA+IG1lbW9yeS4gQWRkcmVzcyBvbmx5IE1NSU8gYWNjZXNzZXMgZG9uZSB2aWEgaW8uaCBoZWxw
ZXJzLCBzdWNoIGFzDQo+ID4gJ3JlYWRsKCknIG9yICd3cml0ZXEoKScuDQo+IA0KPiBBbnkgQ1BV
IGluc3RydWN0aW9uIHRoYXQgYWNjZXNzZXMgbWVtb3J5IGNhbiBhbHNvIGJlIHVzZWQgdG8gYWNj
ZXNzDQo+IE1NSU8uICBIb3dldmVyLCBieSBjb252ZW50aW9uLCBNTUlPIGFjY2VzcyBhcmUgdHlw
aWNhbGx5IHBlcmZvcm1lZCB2aWENCj4gaW8uaCBoZWxwZXJzIHN1Y2ggYXMgJ3JlYWRsKCknIG9y
ICd3cml0ZXEoKScuDQo+IA0KPiA+IHJlYWRYKCkvd3JpdGVYKCkgaGVscGVycyBsaW1pdCB0aGUg
cmFuZ2Ugb2YgaW5zdHJ1Y3Rpb25zIHdoaWNoIGNhbiB0cmlnZ2VyDQo+ID4gTU1JTy4gSXQgbWFr
ZXMgTU1JTyBpbnN0cnVjdGlvbiBlbXVsYXRpb24gZmVhc2libGUuIFJhdyBhY2Nlc3MgdG8gYSBN
TUlPDQo+ID4gcmVnaW9uIGFsbG93cyB0aGUgY29tcGlsZXIgdG8gZ2VuZXJhdGUgd2hhdGV2ZXIg
aW5zdHJ1Y3Rpb24gaXQgd2FudHMuDQo+ID4gU3VwcG9ydGluZyBhbGwgcG9zc2libGUgaW5zdHJ1
Y3Rpb25zIGlzIGEgdGFzayBvZiBhIGRpZmZlcmVudCBzY29wZS4NCj4gDQo+IFRoZSBpby5oIGhl
bHBlcnMgaW50ZW50aW9uYWxseSB1c2UgYSBsaW1pdGVkIHNldCBvZiBpbnN0cnVjdGlvbnMgd2hl
bg0KPiBhY2Nlc3NpbmcgTU1JTy4gIFRoaXMga25vd24sIGxpbWl0ZWQgc2V0IG9mIGluc3RydWN0
aW9ucyBtYWtlcyBNTUlPDQo+IGluc3RydWN0aW9uIGRlY29kaW5nIGFuZCBlbXVsYXRpb24gZmVh
c2libGUgaW4gS1ZNIGhvc3RzIGFuZCBTRVYgZ3Vlc3RzDQo+IHRvZGF5Lg0KPiANCj4gTU1JTyBh
Y2Nlc3NlcyBhcmUgcGVyZm9ybWVkIHdpdGhvdXQgdGhlIGlvLmggaGVscGVycyBhcmUgYXQgdGhl
IG1lcmN5IG9mDQo+IHRoZSBjb21waWxlci4gIENvbXBpbGVycyBjYW4gYW5kIHdpbGwgZ2VuZXJh
dGUgYSBtdWNoIG1vcmUgYnJvYWQgc2V0IG9mDQo+IGluc3RydWN0aW9ucyB3aGljaCBjYW4gbm90
IHByYWN0aWNhbGx5IGJlIGRlY29kZWQgYW5kIGVtdWxhdGVkLiAgVERYDQo+IGd1ZXN0cyB3aWxs
IG9vcHMgaWYgdGhleSBlbmNvdW50ZXIgb25lIG9mIHRoZXNlIGRlY29kaW5nIGZhaWx1cmVzLg0K
PiANCj4gVGhpcyBtZWFucyB0aGF0IFREWCBndWVzdHMgKm11c3QqIHVzZSB0aGUgaW8uaCBoZWxw
ZXJzIHRvIGFjY2VzcyBNTUlPLg0KPiANCj4gVGhpcyByZXF1aXJlbWVudCBpcyBub3QgbmV3LiAg
Qm90aCBLVk0gaG9zdHMgYW5kIEFNRCBTRVYgZ3Vlc3RzIGhhdmUgdGhlDQo+IHNhbWUgbGltaXRh
dGlvbnMgb24gTU1JTyBhY2Nlc3MuDQoNCkFtIEkgcmVhZGluZyB0aGUgbGFzdCBzZW50ZW5jZSBj
b3JyZWN0bHk/DQpOb3JtYWxseSAob24geDg2IGF0IGxlYXN0KSBhIGRyaXZlciBjYW4gbW1hcCgp
IFBDSWUgYWRkcmVzc2VzIGRpcmVjdGx5DQppbnRvIGEgdXNlciBwcm9jZXNzLg0KVGhpcyBsZXRz
IGEgdXNlciBwcm9jZXNzIGRpcmVjdGx5IGlzc3VlIFBDSWUgcmVhZC93cml0ZSBidXMgY3ljbGVz
Lg0KVGhlc2UgY2FuIGJlIGFueSBpbnN0cnVjdGlvbnMgYXQgYWxsLg0KSSBkb24ndCB0aGluayB3
ZSd2ZSBoYWQgYW55IGlzc3VlcyBkb2luZyB0aGF0IGluIG5vcm1hbCBWTXMuDQoNCk9yIGlzIHRo
aXMgZW11bGF0aW9uIG9ubHkgYXBwbHlpbmcgdG8gc3BlY2lmaWMgUENJZSBzbGF2ZXM/DQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

