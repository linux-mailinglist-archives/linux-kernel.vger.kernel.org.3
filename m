Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB34C525157
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355991AbiELPd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354821AbiELPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:33:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6605422A8B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:33:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-66-PftQrsdrOv2ZJM_NmJ7mQQ-1; Thu, 12 May 2022 16:33:53 +0100
X-MC-Unique: PftQrsdrOv2ZJM_NmJ7mQQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 12 May 2022 16:33:52 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 12 May 2022 16:33:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>
CC:     "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: Implement Linear Address Masking support
Thread-Topic: [PATCH] x86: Implement Linear Address Masking support
Thread-Index: AQHYZN7+/opgI73BZUKmGdIzOSRkmq0bNCgQgAAl446AAAZ9cA==
Date:   Thu, 12 May 2022 15:33:52 +0000
Message-ID: <bb5b14dd1b484a59b8b51517e6fa1101@AcuMS.aculab.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-2-kirill.shutemov@linux.intel.com>
 <fc54d360620d436f93785ae5e9f8a23f@AcuMS.aculab.com>
 <Yn0UmdTOdceX1g05@casper.infradead.org> <87v8uavlha.ffs@tglx>
In-Reply-To: <87v8uavlha.ffs@tglx>
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

RnJvbTogVGhvbWFzIEdsZWl4bmVyDQo+IFNlbnQ6IDEyIE1heSAyMDIyIDE2OjA3DQo+IA0KPiBP
biBUaHUsIE1heSAxMiAyMDIyIGF0IDE1OjA3LCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gPiBP
biBUaHUsIE1heSAxMiwgMjAyMiBhdCAwMTowMTowN1BNICswMDAwLCBEYXZpZCBMYWlnaHQgd3Jv
dGU6DQo+ID4+ID4gK3N0YXRpYyBpbmxpbmUgaW50NjRfdCBzaWduX2V4dGVuZDY0KHVpbnQ2NF90
IHZhbHVlLCBpbnQgaW5kZXgpDQo+ID4+ID4gK3sNCj4gPj4gPiArICAgIGludCBzaGlmdCA9IDYz
IC0gaW5kZXg7DQo+ID4+ID4gKyAgICByZXR1cm4gKGludDY0X3QpKHZhbHVlIDw8IHNoaWZ0KSA+
PiBzaGlmdDsNCj4gPj4gPiArfQ0KPiA+Pg0KPiA+PiBTaGlmdCBvZiBzaWduZWQgaW50ZWdlcnMg
YXJlIFVCLg0KPiA+DQo+ID4gQ2l0YXRpb24gbmVlZGVkLg0KPiANCj4gSSdsbCBiaXRlIDopDQo+
IA0KPiBDMTEvMTk6IDYuNS43IEJpdHdpc2Ugc2hpZnQgb3BlcmF0b3JzDQo+IA0KPiAgIDQgVGhl
IHJlc3VsdCBvZiBFMSA8PCBFMiBpcyBFMSBsZWZ0LXNoaWZ0ZWQgRTIgYml0IHBvc2l0aW9uczsg
dmFjYXRlZA0KPiAgICAgYml0cyBhcmUgZmlsbGVkIHdpdGggemVyb3MuIElmIEUxIGhhcyBhbiB1
bnNpZ25lZCB0eXBlLCB0aGUgdmFsdWUgb2YNCj4gICAgIHRoZSByZXN1bHQgaXMgRTEgw5cgMkUy
LCByZWR1Y2VkIG1vZHVsbyBvbmUgbW9yZSB0aGFuIHRoZSBtYXhpbXVtDQo+ICAgICB2YWx1ZSBy
ZXByZXNlbnRhYmxlIGluIHRoZSByZXN1bHQgdHlwZS4gSWYgRTEgaGFzIGEgc2lnbmVkIHR5cGUg
YW5kDQo+ICAgICBub25uZWdhdGl2ZSB2YWx1ZSwgYW5kIEUxIMOXIDJFMiBpcyByZXByZXNlbnRh
YmxlIGluIHRoZSByZXN1bHQgdHlwZSwNCj4gICAgIHRoZW4gdGhhdCBpcyB0aGUgcmVzdWx0aW5n
IHZhbHVlOyBvdGhlcndpc2UsIHRoZSBiZWhhdmlvciBpcw0KPiAgICAgdW5kZWZpbmVkLg0KPiAN
Cj4gVGhpcyBpcyBpcnJlbGV2YW50IGZvciB0aGUgY2FzZSBhYm92ZSBiZWNhdXNlIHRoZSBsZWZ0
IHNoaWZ0IGlzIG9uIGFuDQo+IHVuc2lnbmVkIGludGVnZXIuIFRoZSBpbnRlcmVzdGluZyBwYXJ0
IGlzIHRoaXM6DQo+IA0KPiAgIDUgVGhlIHJlc3VsdCBvZiBFMSA+PiBFMiBpcyBFMSByaWdodC1z
aGlmdGVkIEUyIGJpdCBwb3NpdGlvbnMuIElmIEUxDQo+ICAgICBoYXMgYW4gdW5zaWduZWQgdHlw
ZSBvciBpZiBFMSBoYXMgYSBzaWduZWQgdHlwZSBhbmQgYSBub25uZWdhdGl2ZQ0KPiAgICAgdmFs
dWUsIHRoZSB2YWx1ZSBvZiB0aGUgcmVzdWx0IGlzIHRoZSBpbnRlZ3JhbCBwYXJ0IG9mIHRoZSBx
dW90aWVudA0KPiAgICAgb2YgRTEvMkUyLiAgSWYgRTEgaGFzIGEgc2lnbmVkIHR5cGUgYW5kIGEg
bmVnYXRpdmUgdmFsdWUsIHRoZQ0KPiAgICAgcmVzdWx0aW5nIHZhbHVlIGlzIGltcGxlbWVudGF0
aW9uLWRlZmluZWQuDQo+IA0KPiBTbyBpdCdzIG5vdCBVQiwgaXQncyBpbXBsZW1lbnRhdGlvbiBk
ZWZpbmVkLiBUaGUgb2J2aW91cyBjaG9pY2UgaXMgdG8NCj4ga2VlcCBMU0Igc2V0LCBpLmUuIGFy
aXRobWV0aWMgc2hpZnQsIHdoYXQgYm90aCBHQ0MgYW5kIGNsYW5nIGRvLg0KDQpJJ20gc3VyZSBz
b21lb25lIHJlY2VudGx5IHNhaWQgb25lIG9mIHRoZSBzdGFuZGFyZHMgaGFkIG1hZGUgdGhlbSBV
Qi4NCg0KSW4gYW55IGNhc2UsIGdpdmVuIHRoZSBjYWxsZXIgc2VlbXMgdG8ga25vdyB3aGV0aGVy
IHRoZSB0b3AgYml0IGlzIHNldA0KKGFuZCBkb2VzIGEgZGlmZmVyZW50IGNhbGwpIHVzaW5nIHw9
IG9yICY9IGlzIGRpc3RpbmN0bHkgYmV0dGVyLg0KRXNwZWNpYWxseSBzaW5jZSB0aGUgcmVxdWly
ZWQgY29uc3RhbnQgY2FuIGJlIGNvbXB1dGVkIGluIGEgc2xvdyBwYXRoLg0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K

