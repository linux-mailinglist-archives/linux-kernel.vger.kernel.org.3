Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362A14D5D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiCKIRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiCKIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:17:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE04212220F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:15:56 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-5-eW6bvoBZPHeqSlfdNPCSeQ-1; Fri, 11 Mar 2022 08:15:54 +0000
X-MC-Unique: eW6bvoBZPHeqSlfdNPCSeQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 11 Mar 2022 08:15:52 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 11 Mar 2022 08:15:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bharata B Rao' <bharata@amd.com>,
        'Dave Hansen' <dave.hansen@intel.com>,
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
Subject: RE: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Thread-Topic: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Thread-Index: AQHYNHBEWuVw0etF4EmWwhK6DFJ++Ky4rWmQgAAmSACAAAWIEIAA046AgAAnczA=
Date:   Fri, 11 Mar 2022 08:15:52 +0000
Message-ID: <15fb8774026b4350b2653ce119c85820@AcuMS.aculab.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <699fb763ac054833bc8c29c9814c63b2@AcuMS.aculab.com>
 <286efdb9-7dbf-82f3-b172-29c575a3791b@intel.com>
 <f6212ddf70bc408a80d7eb690c46bccc@AcuMS.aculab.com>
 <de443f8b-8ce0-8664-65d6-daa767ba086b@amd.com>
In-Reply-To: <de443f8b-8ce0-8664-65d6-daa767ba086b@amd.com>
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

RnJvbTogQmhhcmF0YSBCIFJhbw0KPiBTZW50OiAxMSBNYXJjaCAyMDIyIDA1OjQzDQo+IE9uIDMv
MTAvMjAyMiAxMDo0OSBQTSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEZyb206IERhdmUgSGFu
c2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+DQo+ID4+IFNlbnQ6IDEwIE1hcmNoIDIwMjIgMTY6
NDYNCj4gPj4NCj4gPj4gT24gMy8xMC8yMiAwNjozMiwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+
Pj4+IFVBSSBhbGxvd3Mgc29mdHdhcmUgdG8gc3RvcmUgYSB0YWcgaW4gdGhlIHVwcGVyIDcgYml0
cyBvZiBhIGxvZ2ljYWwNCj4gPj4+PiBhZGRyZXNzIFs2Mzo1N10uIFdoZW4gZW5hYmxlZCwgdGhl
IHByb2Nlc3NvciB3aWxsIHN1cHByZXNzIHRoZQ0KPiA+Pj4+IHRyYWRpdGlvbmFsIGNhbm9uaWNh
bCBhZGRyZXNzIGNoZWNrcyBvbiB0aGUgYWRkcmVzc2VzLiBNb3JlIGluZm9ybWF0aW9uDQo+ID4+
Pj4gYWJvdXQgVUFJIGNhbiBiZSBmb3VuZCBpbiBzZWN0aW9uIDUuMTAgb2YgJ0FNRDY0IEFyY2hp
dGVjdHVyZQ0KPiA+Pj4+IFByb2dyYW1tZXIncyBNYW51YWwsIFZvbCAyOiBTeXN0ZW0gUHJvZ3Jh
bW1pbmcnIHdoaWNoIGlzIGF2YWlsYWJsZSBmcm9tDQo+ID4+Pj4NCiwsLA0KPiA+Pj4gSXMgdGhh
dCByZWFsbHkgYWxsb3dpbmcgYml0IDYzIHRvIGJlIHVzZWQ/DQo+ID4+PiBUaGF0IGlzIG5vcm1h
bGx5IHRoZSB1c2VyLWtlcm5lbCBiaXQuDQo+ID4+PiBJIGNhbid0IGhlbHAgZmVlbGluZyB0aGF0
IHdpbGwganVzdCBiYWRseSBicmVhayB0aGluZ3MuDQo+ID4+DQo+ID4+IFllYWgsIHRoaXMgZG9l
cyBzZWVtIHdvcnJpc29tZS4gIFRoZSBMQU0gYXBwcm9hY2hbMV0gcmV0YWlucw0KPiA+PiBjYW5v
bmljYWxpdHkgY2hlY2tpbmcgZm9yIGJpdCA2My4NCj4gPg0KPiA+IEFjdHVhbGx5IGl0IGlzIHJh
dGhlciB3b3JzZSB0aGFuICd3b3JyaXNvbWUnLg0KPiA+IEFsbG93aW5nIHRoZSB1c2VyIGFsbCBh
ZGRyZXNzIHVwdG8gdGhlIGJhc2Ugb2YgdGhlIHZhbGlkDQo+ID4ga2VybmVsIGFkZHJlc3NlcyAo
cHJvYmFibHkgdGFncyB0byAzZSwgYnV0IG5vdCAzZikNCj4gPiBtZWFucyB0aGF0IHlvdSBjYW4n
dCB1c2UgYSBmYXN0IGFkZHJlc3MgY2hlY2sgaW4gYWNjZXNzX29rKCkuDQo+ID4gWW91IGFyZSBm
b3JjZWQgdG8gdXNlIHRoZSBzdHJpY3QgdGVzdCB0aGF0IDMyYml0IGtlcm5lbHMgdXNlLg0KPiAN
Cj4gRnJvbSB3aGF0IEkgc2VlLCB0aGVyZSBpcyBhIHNpbmdsZSBpbXBsZW1lbnRhdGlvbiBvZiBh
Y2Nlc3Nfb2soKQ0KPiBpbiBhcmNoL3g4Ni9hc20vaW5jbHVkZS91YWNjZXNzLmggdGhhdCBkb2Vz
IGNoZWNrIGlmIHRoZSB1c2VyDQo+IGFkZHJlc3Mrc2l6ZSBleGNlZWRzIHRoZSBsaW1pdC4NCj4g
DQo+IEd1ZXNzIEkgYW0gbWlzc2luZyBzb21ldGhpbmcsIGJ1dCBjYW4geW91IHBsZWFzZSBwb2lu
dCBtZSB0byB0aGUgZmFzdA0KPiBpbXBsZW1lbnRhdGlvbih0aGF0IGJlbmVmaXRzIGZyb20gYml0
IDYzIGJlaW5nIHVzZXIva2VybmVsIGFkZHJlc3MNCj4gZGlzYW1iaWd1YXRpb24gYml0KSBhbmQg
dGhlIHN0cmljdCBjaGVja2luZyBpbiAzMmJpdCBrZXJuZWxzIHRoYXQNCj4gYXJlIHlvdSBhcmUg
cmVmZXJyaW5nIHRvPw0KDQpZb3UgY2FuIGp1c3QgY2hlY2sgKChhZGRyZXNzIHwgc2l6ZSkgPj4g
NjIpIG9uIDY0Yml0IGFyY2ggdGhhdA0KdXNlIGJpdCA2MyB0byBzZWxlY3QgdXNlci9rZXJuZWwg
YW5kIGhhdmUgYSBtYXNzaXZlIGFkZHJlc3MNCmhvbGUgbmVhciB0aGUgYm91bmRhcnkuDQpUaGUg
Y29tcGlsZXIgb3B0aW1pc2VzIG91dCBjb25zdGFudCBzaXplIGZyb20gdGhhdCBjYWxjdWxhdGlv
bi4NCk9uIHg4Ni02NCBub24tY2Fub25pY2FsIGFkZHJlc3NlcyBnaXZlIGEgZGlmZmVyZW50IGZh
dWx0DQp0byAncGFnZSBub3QgcHJlc2VudCcgLSBidXQgdGhhdCBjYW4gYmUgaGFuZGxlZC4NCg0K
SW4gcHJhY3RpY2UgeW91IGNhbiAocHJvYmFibHkpIGV2ZW4gY29tcGxldGVseSBpZ25vcmUgdGhl
ICdzaXplJw0KYW5kIGp1c3QgZXJyb3IgaWYgdGhlIHRvcCBiaXQgb2YgdGhlIGFkZHJlc3MgaXMg
c2V0Lg0KV2hpbGUgYWNjZXNzZXMgbWlnaHQgbm90IGJlIGNvbXBsZXRlbHkgc2VxdWVudGlhbCB0
aGV5IGFyZW4ndA0KZ29pbmcgdG8ganVtcCBvdmVyIHRoZSBub24tY2Fub25pY2FsIGFkZHJlc3Nl
cy4NCg0KPiBBbHNvIEkgd29uZGVyIGhlcmUgd2h5IEFSTTY0IFRCSSB3aGljaCBhbHNvIHVzZXMg
dGhlIGZ1bGwgdXBwZXIgYnl0ZQ0KPiAoaW5jbHVkaW5nIGJpdCA2MykgZm9yIHN0b3JpbmcgdGFn
L21ldGFkYXRhIGRvZXNuJ3Qgc3VmZmVyIGZyb20NCj4gdGhpcyBzYW1lIHByb2JsZW0/DQoNClRo
ZSB1c2VyLWtlcm5lbCBiaXQgaXMgbG93ZXIgZG93biAoc29tZXRoaW5nIGxpa2UgYml0IDUzKSBz
byB0aGUNCnRhZ3MgYXJlIHVzaW5nIHNlcGFyYXRlIGJpdHMuDQpBbHRob3VnaCB0aGF0IGNob2lj
ZSBvZiB1c2VyL2tlcm5lbCBiaXQgbWFrZXMgbGlmZSBoYXJkIGVsc2V3aGVyZS4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

