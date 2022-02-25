Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0754E4C3C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiBYDLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBYDLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:11:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C50B42C032D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:10:44 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-11-gsizBZWLM-SoXgpS98dsAw-1; Fri, 25 Feb 2022 03:10:41 +0000
X-MC-Unique: gsizBZWLM-SoXgpS98dsAw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 25 Feb 2022 03:10:39 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 25 Feb 2022 03:10:39 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'bp@alien8.de'" <bp@alien8.de>,
        "'luto@kernel.org'" <luto@kernel.org>,
        "'peterz@infradead.org'" <peterz@infradead.org>
CC:     "'sathyanarayanan.kuppuswamy@linux.intel.com'" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "'aarcange@redhat.com'" <aarcange@redhat.com>,
        "'ak@linux.intel.com'" <ak@linux.intel.com>,
        "'dan.j.williams@intel.com'" <dan.j.williams@intel.com>,
        "'david@redhat.com'" <david@redhat.com>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'jgross@suse.com'" <jgross@suse.com>,
        "'jmattson@google.com'" <jmattson@google.com>,
        "'joro@8bytes.org'" <joro@8bytes.org>,
        "'jpoimboe@redhat.com'" <jpoimboe@redhat.com>,
        "'knsathya@kernel.org'" <knsathya@kernel.org>,
        "'pbonzini@redhat.com'" <pbonzini@redhat.com>,
        "'sdeep@vmware.com'" <sdeep@vmware.com>,
        "'seanjc@google.com'" <seanjc@google.com>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'wanpengli@tencent.com'" <wanpengli@tencent.com>,
        "'thomas.lendacky@amd.com'" <thomas.lendacky@amd.com>,
        "'brijesh.singh@amd.com'" <brijesh.singh@amd.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv4 11/30] x86/tdx: Handle in-kernel MMIO
Thread-Topic: [PATCHv4 11/30] x86/tdx: Handle in-kernel MMIO
Thread-Index: AQHYKbrRB70QltnCv0Of3lK/667WPqyjhr+AgAAP+sA=
Date:   Fri, 25 Feb 2022 03:10:39 +0000
Message-ID: <7c536496125844ccaca50aa0740c8585@AcuMS.aculab.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-12-kirill.shutemov@linux.intel.com>
 <af7df79f-02b8-3025-c9a3-929b7bdd33e0@intel.com>
 <45b6e0b6ceec46849754402c3da03fed@AcuMS.aculab.com>
In-Reply-To: <45b6e0b6ceec46849754402c3da03fed@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDI1IEZlYnJ1YXJ5IDIwMjIgMDI6MjMNCj4gDQo+
IEZyb206IERhdmUgSGFuc2VuDQo+ID4gU2VudDogMjQgRmVicnVhcnkgMjAyMiAyMDoxMg0KPiAu
Li4NCj4gPiA9PT0gTGltaXRhdGlvbnMgb2YgdGhpcyBhcHByb2FjaCA9PT0NCj4gPg0KPiA+ID4g
TU1JTyBhZGRyZXNzZXMgY2FuIGJlIHVzZWQgd2l0aCBhbnkgQ1BVIGluc3RydWN0aW9uIHRoYXQg
YWNjZXNzZXMNCj4gPiA+IG1lbW9yeS4gQWRkcmVzcyBvbmx5IE1NSU8gYWNjZXNzZXMgZG9uZSB2
aWEgaW8uaCBoZWxwZXJzLCBzdWNoIGFzDQo+ID4gPiAncmVhZGwoKScgb3IgJ3dyaXRlcSgpJy4N
Cj4gPg0KPiA+IEFueSBDUFUgaW5zdHJ1Y3Rpb24gdGhhdCBhY2Nlc3NlcyBtZW1vcnkgY2FuIGFs
c28gYmUgdXNlZCB0byBhY2Nlc3MNCj4gPiBNTUlPLiAgSG93ZXZlciwgYnkgY29udmVudGlvbiwg
TU1JTyBhY2Nlc3MgYXJlIHR5cGljYWxseSBwZXJmb3JtZWQgdmlhDQo+ID4gaW8uaCBoZWxwZXJz
IHN1Y2ggYXMgJ3JlYWRsKCknIG9yICd3cml0ZXEoKScuDQo+ID4NCj4gPiA+IHJlYWRYKCkvd3Jp
dGVYKCkgaGVscGVycyBsaW1pdCB0aGUgcmFuZ2Ugb2YgaW5zdHJ1Y3Rpb25zIHdoaWNoIGNhbiB0
cmlnZ2VyDQo+ID4gPiBNTUlPLiBJdCBtYWtlcyBNTUlPIGluc3RydWN0aW9uIGVtdWxhdGlvbiBm
ZWFzaWJsZS4gUmF3IGFjY2VzcyB0byBhIE1NSU8NCj4gPiA+IHJlZ2lvbiBhbGxvd3MgdGhlIGNv
bXBpbGVyIHRvIGdlbmVyYXRlIHdoYXRldmVyIGluc3RydWN0aW9uIGl0IHdhbnRzLg0KPiA+ID4g
U3VwcG9ydGluZyBhbGwgcG9zc2libGUgaW5zdHJ1Y3Rpb25zIGlzIGEgdGFzayBvZiBhIGRpZmZl
cmVudCBzY29wZS4NCj4gPg0KPiA+IFRoZSBpby5oIGhlbHBlcnMgaW50ZW50aW9uYWxseSB1c2Ug
YSBsaW1pdGVkIHNldCBvZiBpbnN0cnVjdGlvbnMgd2hlbg0KPiA+IGFjY2Vzc2luZyBNTUlPLiAg
VGhpcyBrbm93biwgbGltaXRlZCBzZXQgb2YgaW5zdHJ1Y3Rpb25zIG1ha2VzIE1NSU8NCj4gPiBp
bnN0cnVjdGlvbiBkZWNvZGluZyBhbmQgZW11bGF0aW9uIGZlYXNpYmxlIGluIEtWTSBob3N0cyBh
bmQgU0VWIGd1ZXN0cw0KPiA+IHRvZGF5Lg0KPiA+DQo+ID4gTU1JTyBhY2Nlc3NlcyBhcmUgcGVy
Zm9ybWVkIHdpdGhvdXQgdGhlIGlvLmggaGVscGVycyBhcmUgYXQgdGhlIG1lcmN5IG9mDQo+ID4g
dGhlIGNvbXBpbGVyLiAgQ29tcGlsZXJzIGNhbiBhbmQgd2lsbCBnZW5lcmF0ZSBhIG11Y2ggbW9y
ZSBicm9hZCBzZXQgb2YNCj4gPiBpbnN0cnVjdGlvbnMgd2hpY2ggY2FuIG5vdCBwcmFjdGljYWxs
eSBiZSBkZWNvZGVkIGFuZCBlbXVsYXRlZC4gIFREWA0KPiA+IGd1ZXN0cyB3aWxsIG9vcHMgaWYg
dGhleSBlbmNvdW50ZXIgb25lIG9mIHRoZXNlIGRlY29kaW5nIGZhaWx1cmVzLg0KPiA+DQo+ID4g
VGhpcyBtZWFucyB0aGF0IFREWCBndWVzdHMgKm11c3QqIHVzZSB0aGUgaW8uaCBoZWxwZXJzIHRv
IGFjY2VzcyBNTUlPLg0KPiA+DQo+ID4gVGhpcyByZXF1aXJlbWVudCBpcyBub3QgbmV3LiAgQm90
aCBLVk0gaG9zdHMgYW5kIEFNRCBTRVYgZ3Vlc3RzIGhhdmUgdGhlDQo+ID4gc2FtZSBsaW1pdGF0
aW9ucyBvbiBNTUlPIGFjY2Vzcy4NCj4gDQo+IEFtIEkgcmVhZGluZyB0aGUgbGFzdCBzZW50ZW5j
ZSBjb3JyZWN0bHk/DQo+IE5vcm1hbGx5IChvbiB4ODYgYXQgbGVhc3QpIGEgZHJpdmVyIGNhbiBt
bWFwKCkgUENJZSBhZGRyZXNzZXMgZGlyZWN0bHkNCj4gaW50byBhIHVzZXIgcHJvY2Vzcy4NCj4g
VGhpcyBsZXRzIGEgdXNlciBwcm9jZXNzIGRpcmVjdGx5IGlzc3VlIFBDSWUgcmVhZC93cml0ZSBi
dXMgY3ljbGVzLg0KPiBUaGVzZSBjYW4gYmUgYW55IGluc3RydWN0aW9ucyBhdCBhbGwuDQo+IEkg
ZG9uJ3QgdGhpbmsgd2UndmUgaGFkIGFueSBpc3N1ZXMgZG9pbmcgdGhhdCBpbiBub3JtYWwgVk1z
Lg0KDQpBY3R1YWxseSB3ZSB3b24ndCBoYXZlIGJlZW4gZXhwb3NpbmcgUENJZSBkZXZpY2VzIHRv
IFZNcy4NCg0KPiBPciBpcyB0aGlzIGVtdWxhdGlvbiBvbmx5IGFwcGx5aW5nIHRvIHNwZWNpZmlj
IFBDSWUgc2xhdmVzPw0KPiANCj4gCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

