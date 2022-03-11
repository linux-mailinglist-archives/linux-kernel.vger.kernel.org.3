Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428D94D5E90
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbiCKJh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiCKJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:37:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76E921BE0ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:36:25 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-403-ZL3QziLhO5mS-uJ3oK7saA-1; Fri, 11 Mar 2022 09:36:22 +0000
X-MC-Unique: ZL3QziLhO5mS-uJ3oK7saA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 11 Mar 2022 09:36:21 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 11 Mar 2022 09:36:21 +0000
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
Thread-Index: AQHYNHBEWuVw0etF4EmWwhK6DFJ++Ky4rWmQgAAmSACAAAWIEIAA046AgAAnczCAABLJgIAAAfUg
Date:   Fri, 11 Mar 2022 09:36:21 +0000
Message-ID: <6191fb9390a9458ca75b73798c3b6d74@AcuMS.aculab.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <699fb763ac054833bc8c29c9814c63b2@AcuMS.aculab.com>
 <286efdb9-7dbf-82f3-b172-29c575a3791b@intel.com>
 <f6212ddf70bc408a80d7eb690c46bccc@AcuMS.aculab.com>
 <de443f8b-8ce0-8664-65d6-daa767ba086b@amd.com>
 <15fb8774026b4350b2653ce119c85820@AcuMS.aculab.com>
 <363b91f7-a1d7-b5b5-de86-40bcf61ef818@amd.com>
In-Reply-To: <363b91f7-a1d7-b5b5-de86-40bcf61ef818@amd.com>
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

RnJvbTogQmhhcmF0YSBCIFJhbw0KPiBTZW50OiAxMSBNYXJjaCAyMDIyIDA5OjExDQo+IA0KPiBP
biAzLzExLzIwMjIgMTo0NSBQTSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEZyb206IEJoYXJh
dGEgQiBSYW8NCj4gPj4gU2VudDogMTEgTWFyY2ggMjAyMiAwNTo0Mw0KPiA+PiBPbiAzLzEwLzIw
MjIgMTA6NDkgUE0sIERhdmlkIExhaWdodCB3cm90ZToNCj4gPj4+IEZyb206IERhdmUgSGFuc2Vu
IDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+DQo+ID4+Pj4gU2VudDogMTAgTWFyY2ggMjAyMiAxNjo0
Ng0KPiA+Pj4+DQo+ID4+Pj4gT24gMy8xMC8yMiAwNjozMiwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0K
PiA+Pj4+Pj4gVUFJIGFsbG93cyBzb2Z0d2FyZSB0byBzdG9yZSBhIHRhZyBpbiB0aGUgdXBwZXIg
NyBiaXRzIG9mIGEgbG9naWNhbA0KPiA+Pj4+Pj4gYWRkcmVzcyBbNjM6NTddLiBXaGVuIGVuYWJs
ZWQsIHRoZSBwcm9jZXNzb3Igd2lsbCBzdXBwcmVzcyB0aGUNCj4gPj4+Pj4+IHRyYWRpdGlvbmFs
IGNhbm9uaWNhbCBhZGRyZXNzIGNoZWNrcyBvbiB0aGUgYWRkcmVzc2VzLiBNb3JlIGluZm9ybWF0
aW9uDQo+ID4+Pj4+PiBhYm91dCBVQUkgY2FuIGJlIGZvdW5kIGluIHNlY3Rpb24gNS4xMCBvZiAn
QU1ENjQgQXJjaGl0ZWN0dXJlDQo+ID4+Pj4+PiBQcm9ncmFtbWVyJ3MgTWFudWFsLCBWb2wgMjog
U3lzdGVtIFByb2dyYW1taW5nJyB3aGljaCBpcyBhdmFpbGFibGUgZnJvbQ0KPiA+Pj4+Pj4NCj4g
PiAsLCwNCj4gPj4+Pj4gSXMgdGhhdCByZWFsbHkgYWxsb3dpbmcgYml0IDYzIHRvIGJlIHVzZWQ/
DQo+ID4+Pj4+IFRoYXQgaXMgbm9ybWFsbHkgdGhlIHVzZXIta2VybmVsIGJpdC4NCj4gPj4+Pj4g
SSBjYW4ndCBoZWxwIGZlZWxpbmcgdGhhdCB3aWxsIGp1c3QgYmFkbHkgYnJlYWsgdGhpbmdzLg0K
PiA+Pj4+DQo+ID4+Pj4gWWVhaCwgdGhpcyBkb2VzIHNlZW0gd29ycmlzb21lLiAgVGhlIExBTSBh
cHByb2FjaFsxXSByZXRhaW5zDQo+ID4+Pj4gY2Fub25pY2FsaXR5IGNoZWNraW5nIGZvciBiaXQg
NjMuDQo+ID4+Pg0KPiA+Pj4gQWN0dWFsbHkgaXQgaXMgcmF0aGVyIHdvcnNlIHRoYW4gJ3dvcnJp
c29tZScuDQo+ID4+PiBBbGxvd2luZyB0aGUgdXNlciBhbGwgYWRkcmVzcyB1cHRvIHRoZSBiYXNl
IG9mIHRoZSB2YWxpZA0KPiA+Pj4ga2VybmVsIGFkZHJlc3NlcyAocHJvYmFibHkgdGFncyB0byAz
ZSwgYnV0IG5vdCAzZikNCj4gPj4+IG1lYW5zIHRoYXQgeW91IGNhbid0IHVzZSBhIGZhc3QgYWRk
cmVzcyBjaGVjayBpbiBhY2Nlc3Nfb2soKS4NCj4gPj4+IFlvdSBhcmUgZm9yY2VkIHRvIHVzZSB0
aGUgc3RyaWN0IHRlc3QgdGhhdCAzMmJpdCBrZXJuZWxzIHVzZS4NCj4gPj4NCj4gPj4gRnJvbSB3
aGF0IEkgc2VlLCB0aGVyZSBpcyBhIHNpbmdsZSBpbXBsZW1lbnRhdGlvbiBvZiBhY2Nlc3Nfb2so
KQ0KPiA+PiBpbiBhcmNoL3g4Ni9hc20vaW5jbHVkZS91YWNjZXNzLmggdGhhdCBkb2VzIGNoZWNr
IGlmIHRoZSB1c2VyDQo+ID4+IGFkZHJlc3Mrc2l6ZSBleGNlZWRzIHRoZSBsaW1pdC4NCj4gPj4N
Cj4gPj4gR3Vlc3MgSSBhbSBtaXNzaW5nIHNvbWV0aGluZywgYnV0IGNhbiB5b3UgcGxlYXNlIHBv
aW50IG1lIHRvIHRoZSBmYXN0DQo+ID4+IGltcGxlbWVudGF0aW9uKHRoYXQgYmVuZWZpdHMgZnJv
bSBiaXQgNjMgYmVpbmcgdXNlci9rZXJuZWwgYWRkcmVzcw0KPiA+PiBkaXNhbWJpZ3VhdGlvbiBi
aXQpIGFuZCB0aGUgc3RyaWN0IGNoZWNraW5nIGluIDMyYml0IGtlcm5lbHMgdGhhdA0KPiA+PiBh
cmUgeW91IGFyZSByZWZlcnJpbmcgdG8/DQo+ID4NCj4gPiBZb3UgY2FuIGp1c3QgY2hlY2sgKChh
ZGRyZXNzIHwgc2l6ZSkgPj4gNjIpIG9uIDY0Yml0IGFyY2ggdGhhdA0KPiA+IHVzZSBiaXQgNjMg
dG8gc2VsZWN0IHVzZXIva2VybmVsIGFuZCBoYXZlIGEgbWFzc2l2ZSBhZGRyZXNzDQo+ID4gaG9s
ZSBuZWFyIHRoZSBib3VuZGFyeS4NCj4gPiBUaGUgY29tcGlsZXIgb3B0aW1pc2VzIG91dCBjb25z
dGFudCBzaXplIGZyb20gdGhhdCBjYWxjdWxhdGlvbi4NCj4gPiBPbiB4ODYtNjQgbm9uLWNhbm9u
aWNhbCBhZGRyZXNzZXMgZ2l2ZSBhIGRpZmZlcmVudCBmYXVsdA0KPiA+IHRvICdwYWdlIG5vdCBw
cmVzZW50JyAtIGJ1dCB0aGF0IGNhbiBiZSBoYW5kbGVkLg0KPiANCj4gT2ssIHNvIGFyZSB5b3Ug
bWVudGlvbmluZyBhYm91dCBhIGZ1dHVyZSBvcHRpbWl6YXRpb24gdG8gYWNjZXNzX29rKCkNCj4g
dGhhdCBjb3VsZCBiZW5lZml0IGJ5IHJldGFpbmluZyBiaXQgNjMgYXMga2VybmVsL3VzZXIgYml0
Pw0KPiANCj4gU2luY2UgeW91IHNhaWQgdXNpbmcgYml0IDYzIHRvIHN0b3JlIG1ldGFkYXRhIHdp
bGwgYnJlYWsgdGhpbmdzLA0KPiBJIHdhcyB0cnlpbmcgdG8gdW5kZXJzdGFuZCBob3cgYW5kIHdo
ZXJlIGRvZXMgaXQgYnJlYWsuDQoNCktlcm5lbCBhZGRyZXNzZXMgc3RhcnQgYXQgMHhmZnh4eCAo
Zm9yIDU3Yml0LCA1IGxldmVsIHBhZ2UgdGFibGVzKS4NCihNYXliZSB0aGUgdmFsaWQgb25lcyBh
cmUgc3RpbGwgMHhmZmZmOHh4eC4pDQpzbyB5b3UgcmVhbGx5IGRvbid0IHdhbnQgdXNlcnNwYWNl
IHVzaW5nIHRob3NlIHRvIGFsaWFzIHZhbGlkIHVzZXINCmFkZHJlc3Nlcy4NCg0KSSdtIG5vdCBl
bnRpcmVseSBzdXJlIHdoYXQgZW5hYmxpbmcgVUFJIGRvZXMuDQpCdXQgdGhlIHVzZXIgcGFnZSB0
YWJsZXMgaGF2ZSB0byBjb250YWluIG1hcHBpbmdzIGZvciBzb21lIGtlcm5lbA0KYWRkcmVzc2Vz
IChldmVuIHdpdGggcGFnZSB0YWJsZSBzZXBhcmF0aW9uKS4NCkFsc28geW91IHJlYWxseSBkb24n
dCB3YW50IHRvIGhhdmUgdG8gbWFzayBvZmYgdGhlIGhpZ2ggYWRkcmVzcw0KYml0cyBiZWZvcmUg
YSBrZXJuZWwgYWNjZXNzIHRvIHRoZSB1c2UgYnVmZmVyLg0KU28gaXQgaXNuJ3QgcmVhbGx5IG9i
dmlvdXMgaG93IGFkZHJlc3NlcyB0aGF0IHN0YXJ0IDB4ZmYgY2FuIGJlIHVzZWQuDQphbmQgdGhh
dCByYXRoZXIgaW1wbGllcyB5b3UgY2FuIHVzZSBiaXQgNjMgYXQgYWxsICh3aXRob3V0IGhvcnJp
ZA0KbG9naWMgaW4gc29tZSAocHJvYmFibHkpIHZlcnkgY3JpdGljYWwgaGFyZHdhcmUgdGltaW5n
IHBhdGhzLg0KDQpXaWtpcGVkaWEgYWxzbyBub3RlczoNCiAgICBJbnRlbCBoYXMgaW1wbGVtZW50
ZWQgYSBzY2hlbWUgd2l0aCBhIDUtbGV2ZWwgcGFnZSB0YWJsZSwgd2hpY2ggYWxsb3dzDQogICAg
SW50ZWwgNjQgcHJvY2Vzc29ycyB0byBzdXBwb3J0IGEgNTctYml0IHZpcnR1YWwgYWRkcmVzcyBz
cGFjZS4NCiAgICBGdXJ0aGVyIGV4dGVuc2lvbnMgbWF5IGFsbG93IGZ1bGwgNjQtYml0IHZpcnR1
YWwgYWRkcmVzcyBzcGFjZSBhbmQNCiAgICBwaHlzaWNhbCBtZW1vcnkgYnkgZXhwYW5kaW5nIHRo
ZSBwYWdlIHRhYmxlIGVudHJ5IHNpemUgdG8gMTI4LWJpdCwNCiAgICBhbmQgcmVkdWNlIHBhZ2Ug
d2Fsa3MgaW4gdGhlIDUtbGV2ZWwgaGllcmFyY2h5IGJ5IHVzaW5nIGEgbGFyZ2VyIDY0IEtpQg0K
ICAgIHBhZ2UgYWxsb2NhdGlvbiBzaXplIHRoYXQgc3RpbGwgc3VwcG9ydHMgNCBLaUIgcGFnZSBv
cGVyYXRpb25zIGZvcg0KICAgIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkuDQpJZiB0aGV5IGltcGxl
bWVudCA2NEsgcGFnZXMgdGhlbiB5b3UgbG9zZSB0aGUgZXh0cmEgYml0cy4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

