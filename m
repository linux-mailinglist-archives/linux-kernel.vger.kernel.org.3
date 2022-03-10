Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19AE4D54AF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344383AbiCJWii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiCJWig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:38:36 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B05E53B45
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:37:34 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-267-5rxcuN6XPMuO1eF-qzLctA-1; Thu, 10 Mar 2022 22:37:32 +0000
X-MC-Unique: 5rxcuN6XPMuO1eF-qzLctA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 10 Mar 2022 22:37:30 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 10 Mar 2022 22:37:30 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Cooper' <Andrew.Cooper3@citrix.com>,
        Bharata B Rao <bharata@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>
Subject: RE: [RFC PATCH v0 3/6] x86: Enable Upper Address Ignore(UAI) feature
Thread-Topic: [RFC PATCH v0 3/6] x86: Enable Upper Address Ignore(UAI) feature
Thread-Index: AQHYNLebTUcnJFmJckKqzLkQmpfxI6y5M6Ug
Date:   Thu, 10 Mar 2022 22:37:30 +0000
Message-ID: <bcd71ac6539e48359e8a80cb74115964@AcuMS.aculab.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <20220310111545.10852-4-bharata@amd.com>
 <7fccb7f2-fc88-993e-e1b2-919448844112@citrix.com>
In-Reply-To: <7fccb7f2-fc88-993e-e1b2-919448844112@citrix.com>
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

RnJvbTogQW5kcmV3IENvb3Blcg0KPiBTZW50OiAxMCBNYXJjaCAyMDIyIDE5OjQ3DQo+IA0KPiBP
biAxMC8wMy8yMDIyIDExOjE1LCBCaGFyYXRhIEIgUmFvIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYyBiL2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jDQo+ID4g
aW5kZXggZjdhMTMyZWI3OTRkLi4xMjYxNWIxYjRhZjUgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94
ODYva2VybmVsL3NldHVwLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYw0KPiA+
IEBAIC03NDAsNiArNzQwLDEyIEBAIGR1bXBfa2VybmVsX29mZnNldChzdHJ1Y3Qgbm90aWZpZXJf
YmxvY2sgKnNlbGYsIHVuc2lnbmVkIGxvbmcgdiwgdm9pZCAqcCkNCj4gPiAgCXJldHVybiAwOw0K
PiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGlubGluZSB2b2lkIF9faW5pdCB1YWlfZW5hYmxlKHZv
aWQpDQo+ID4gK3sNCj4gPiArCWlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfVUFJKSkNCj4g
PiArCQltc3Jfc2V0X2JpdChNU1JfRUZFUiwgX0VGRVJfVUFJKTsNCj4gPiArfQ0KPiA+ICsNCj4g
PiAgLyoNCj4gPiAgICogRGV0ZXJtaW5lIGlmIHdlIHdlcmUgbG9hZGVkIGJ5IGFuIEVGSSBsb2Fk
ZXIuICBJZiBzbywgdGhlbiB3ZSBoYXZlIGFsc28gYmVlbg0KPiA+ICAgKiBwYXNzZWQgdGhlIGVm
aSBtZW1tYXAsIHN5c3RhYiwgZXRjLiwgc28gd2Ugc2hvdWxkIHVzZSB0aGVzZSBkYXRhIHN0cnVj
dHVyZXMNCj4gPiBAQCAtMTE0Niw2ICsxMTUyLDggQEAgdm9pZCBfX2luaXQgc2V0dXBfYXJjaChj
aGFyICoqY21kbGluZV9wKQ0KPiA+DQo+ID4gIAl4ODZfaW5pdC5wYWdpbmcucGFnZXRhYmxlX2lu
aXQoKTsNCj4gPg0KPiA+ICsJdWFpX2VuYWJsZSgpOw0KPiANCj4gSSB3b3VsZCB0aGluayBpbmNy
ZWRpYmx5IGNhcmVmdWxseSBiZWZvcmUgZW5hYmxpbmcgVUFJIGJ5IGRlZmF1bHQuDQo+IA0KPiBT
dWZmaWNlIGl0IHRvIHNheSB0aGF0IEludGVsIHdlcmUgdGFsa2VkIGRvd24gZnJvbSA3IGJpdHMg
dG8gNiwgYW5kDQo+IGFwcGFyZW50bHkgQU1EIGRpZG4ndCBnZXQgdGhlIHNhbWUgbWVtbyBmcm9t
IHRoZSBvcmlnaW5hbCByZXF1ZXN0ZXJzLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCBVQUkg
KyBMQTU3IG1lYW5zIHRoYXQgYWxsIHRoZSBwb2lzb24gcG9pbnRlcnMgY2Vhc2UNCj4gZnVuY3Rp
b25pbmcgYXMgYSBkZWZlbmNlLWluLWRlcHRoIG1lY2hhbmlzbSwgYW5kIGJlY29tZSBsZWdhbCBw
b2ludGVycw0KPiBwb2ludGluZyBhdCByYW5kb20gcG9zaXRpb25zIGluIHVzZXIgb3Iga2VybmVs
IHNwYWNlLg0KDQpJc24ndCB0aGF0IHRydWUgcmVnYXJkbGVzcyBvZiBob3cgbWFueSBiaXRzIGFy
ZSAnaWdub3JlZCcuDQpBRkFJQ1QgdGhlIG9ubHkgc2FuZSB0aGluZyB3b3VsZCBiZSB0byBoYXZl
IHNvbWV0aGluZyBpbiB0aGUgY3B1DQp0aGF0IHZlcmlmaWVzIHRoZSAnaWdub3JlZCcgYml0cyBt
YXRjaCB2YWx1ZXMgc2V0IGluIHRoZSBQVEUuDQpUaGF0IGNvdWxkIGJlIHVzZWQgdG8gZW5zdXJl
ICh3ZWxsIG1ha2UgaXQgbW9yZSBsaWtlbHkpIHRoYXQgc3RhY2sNCmFjY2VzcyBzdGF5IGluIHRo
ZSBzdGFjayBhbmQgcG9pbnRlcnMgdG8gbW1hcCgpZWQgZGF0YSBzdGF5DQpwb2ludGluZyB0byB0
aGUgY29ycmVjdCBwYWdlcy4NCg0KSnVzdCBsZXR0aW5nIHVzZXIgYWRkcmVzcyBzcGFjZSBiZSBh
bGlhc2VkIGEgbG90IG9mIHRpbWVzIGRvZXNuJ3QNCnNlZW0gbGlrZSBhIHNlY3VyaXR5IGZlYXR1
cmUgdG8gbWUuDQpJdCBtdXN0IGhhdmUgc29tZSBzdHJhbmdlIHVzZSBjYXNlLg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

