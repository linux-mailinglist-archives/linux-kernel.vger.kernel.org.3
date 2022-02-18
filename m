Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F4F4BB47E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiBRIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:43:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiBRInm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:43:42 -0500
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Feb 2022 00:43:24 PST
Received: from mg.sunplus.com (unknown [113.196.136.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E35F5298AD2;
        Fri, 18 Feb 2022 00:43:24 -0800 (PST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(59921:0:AUTH_RELAY)
        (envelope-from <edwin.chiu@sunplus.com>); Fri, 18 Feb 2022 16:36:12 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 18 Feb 2022 16:36:07 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 18 Feb 2022 16:36:07 +0800
From:   =?utf-8?B?RWR3aW4gQ2hpdSDpgrHlnoLls7A=?= <edwin.chiu@sunplus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Edwin Chiu <edwinchiu0505tw@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v4] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Thread-Topic: [PATCH v4] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Thread-Index: AQHYG/cOqjt4Bbqwy06Z29eKCBs1J6yIApeAgApaEBD//8HxAIAG4ruw//+EXgCAAIcboA==
Date:   Fri, 18 Feb 2022 08:36:07 +0000
Message-ID: <60a199e823d3496fb1c9e5d6e1073738@sphcmbx02.sunplus.com.tw>
References: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
 <957d882222d218b62fe3fb7a069e2f7952afc5be.1644218105.git.edwinchiu0505tw@gmail.com>
 <64f91b1a-93b9-941d-fdfa-271e198e1ab5@canonical.com>
 <0edae7bea1ae47cd9044cd223a989b81@sphcmbx02.sunplus.com.tw>
 <136f2087-10e7-c9e8-2292-3046711c8f68@canonical.com>
 <eca9b5a613c9417cacdcb90eef5b2235@sphcmbx02.sunplus.com.tw>
 <608800b4-2e56-d925-5db9-0ec40f98cbb5@canonical.com>
In-Reply-To: <608800b4-2e56-d925-5db9-0ec40f98cbb5@canonical.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBjYW5vbmljYWwuY29tPg0KPiBTZW50OiBGcmlkYXks
IEZlYnJ1YXJ5IDE4LCAyMDIyIDQ6MzEgUE0NCj4gVG86IEVkd2luIENoaXUg6YKx5Z6C5bOwIDxl
ZHdpbi5jaGl1QHN1bnBsdXMuY29tPjsgRWR3aW4gQ2hpdSA8ZWR3aW5jaGl1MDUwNXR3QGdtYWls
LmNvbT47DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJhZmFlbEBrZXJuZWwub3JnOw0KPiBkYW5p
ZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NF0gY3B1aWRsZTogc3VucGx1czogQ3JlYXRlIGNwdWlkbGUgZHJpdmVy
IGZvciBzdW5wbHVzIHNwNzAyMQ0KPiANCj4gT24gMTgvMDIvMjAyMiAwOToxMCwgRWR3aW4gQ2hp
dSDpgrHlnoLls7Agd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3ps
b3dza2lAY2Fub25pY2FsLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxNCwgMjAy
MiAyOjQ1IFBNDQo+ID4+IFRvOiBFZHdpbiBDaGl1IOmCseWeguWzsCA8ZWR3aW4uY2hpdUBzdW5w
bHVzLmNvbT47IEVkd2luIENoaXUNCj4gPj4gPGVkd2luY2hpdTA1MDV0d0BnbWFpbC5jb20+Ow0K
PiA+PiByb2JoK2R0QGtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+
PiByb2JoK2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJhZmFlbEBrZXJuZWwub3JnOw0K
PiA+PiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NF0gY3B1aWRsZTogc3VucGx1czogQ3JlYXRlIGNw
dWlkbGUgZHJpdmVyIGZvcg0KPiA+PiBzdW5wbHVzIHNwNzAyMQ0KPiA+Pg0KPiA+PiBPbiAxNC8w
Mi8yMDIyIDAzOjU1LCBFZHdpbiBDaGl1IOmCseWeguWzsCB3cm90ZToNCj4gPj4+IEhpIEtyenlz
enRvZjoNCj4gPj4+DQo+ID4+PiBQbGVhc2Ugc2VlIGJlbG93IGFuc3dlci4NCj4gPj4+DQo+ID4+
Pj4+ICtzdGF0aWMgc3RydWN0IGNwdWlkbGVfZHJpdmVyIHNwNzAyMV9pZGxlX2RyaXZlciA9IHsN
Cj4gPj4+Pj4gKwkubmFtZSA9ICJzcDcwMjFfaWRsZSIsDQo+ID4+Pj4+ICsJLm93bmVyID0gVEhJ
U19NT0RVTEUsDQo+ID4+Pj4+ICsJLyoNCj4gPj4+Pj4gKwkgKiBTdGF0ZSBhdCBpbmRleCAwIGlz
IHN0YW5kYnkgd2ZpIGFuZCBjb25zaWRlcmVkIHN0YW5kYXJkDQo+ID4+Pj4+ICsJICogb24gYWxs
IEFSTSBwbGF0Zm9ybXMuIElmIGluIHNvbWUgcGxhdGZvcm1zIHNpbXBsZSB3ZmkNCj4gPj4+Pj4g
KwkgKiBjYW4ndCBiZSB1c2VkIGFzICJzdGF0ZSAwIiwgRFQgYmluZGluZ3MgbXVzdCBiZSBpbXBs
ZW1lbnRlZA0KPiA+Pj4+PiArCSAqIHRvIHdvcmsgYXJvdW5kIHRoaXMgaXNzdWUgYW5kIGFsbG93
IGluc3RhbGxpbmcgYSBzcGVjaWFsDQo+ID4+Pj4+ICsJICogaGFuZGxlciBmb3IgaWRsZSBzdGF0
ZSBpbmRleCAwLg0KPiA+Pj4+PiArCSAqLw0KPiA+Pj4+PiArCS5zdGF0ZXNbMF0gPSB7DQo+ID4+
Pj4+ICsJCS5lbnRlciAgICAgICAgICAgICAgICAgID0gc3A3MDIxX2VudGVyX2lkbGVfc3RhdGUs
DQo+ID4+Pj4+ICsJCS5leGl0X2xhdGVuY3kgICAgICAgICAgID0gMSwNCj4gPj4+Pj4gKwkJLnRh
cmdldF9yZXNpZGVuY3kgICAgICAgPSAxLA0KPiA+Pj4+PiArCQkucG93ZXJfdXNhZ2UJCT0gVUlO
VF9NQVgsDQo+ID4+Pj4+ICsJCS5uYW1lICAgICAgICAgICAgICAgICAgID0gIldGSSIsDQo+ID4+
Pj4+ICsJCS5kZXNjICAgICAgICAgICAgICAgICAgID0gIkFSTSBXRkkiLA0KPiA+Pj4+DQo+ID4+
Pj4gSSBoYXZlIGltcHJlc3Npb24gdGhhdCB0aGVyZSBpcyBubyBwb2ludCBpbiBoYXZpbmcgY3Vz
dG9tIGRyaXZlciB3aXRoIFdGSS4uLg0KPiA+Pj4+DQo+ID4+Pj4gU3RpbGwgdGhlIG1haW4gcXVl
c3Rpb24gZnJvbSBEYW5pZWwgYW5kIFN1ZGVlcCBzdGF5czogd2h5IGRvIHlvdQ0KPiA+Pj4+IG5l
ZWQgdGhpcz8gWW91IGNvcGllZCBleGFjdGx5IGNwdWlsZGxlLWFybSBkcml2ZXIsIHRoZXJlIGlz
IG5vdGhpbmcNCj4gPj4+PiBkaWZmZXJlbnQgaGVyZS4gQXQgbGVhc3QgSSBjb3VsZCBub3Qgc3Bv
dCBkaWZmZXJlbmNlcy4gTWF5YmUgZXhjZXB0DQo+ID4+Pj4gdGhhdCB5b3UgdXNlIGNwdV92N19k
b19pZGxlDQo+ID4+IGV4cGxpY2l0bHkuDQo+ID4+Pj4NCj4gPj4+PiBVbmZvcnR1bmF0ZWx5IEkg
Y2Fubm90IHVuZGVyc3RhbmQgdGhlIGV4cGxhbmF0aW9uIGhlcmU6DQo+ID4+Pj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzA4MTJjNDRmNzc3ZDQwMjZiNzlkZjJlMzY5ODI5NGJlQHNwaGNt
Yg0KPiA+Pj4+IHgwIDIuc3VucGx1cy5jb20udHcvIFdoeSBleGFjdGx5IGNwdWlkbGUtYXJtIGRv
ZXMgbm90IHdvcmsgaW4geW91cg0KPiA+Pj4+IGNhc2U/DQo+ID4+Pj4NCj4gPj4+IEVkd2luPT4g
SSBtZWFuIGNwdWlkbGUtYXJtIGRyaXZlciBjYW4ndCBkaXJlY3RseSB1c2Ugd2l0aCBubyBtb2Rp
ZmllZC4NCj4gPj4+ICAgICAgICBJZiBzb21lb25lIHdhbnQgdG8gdXNlIGNwdWlkbGUtYXJtIGRy
aXZlciwgYmVsb3cgbW9kaWZpY2F0aW9uIHNlZW1zIG5lY2Vzc2FyeS4NCj4gPj4+DQo+ID4+IH5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fg0KPiA+PiB+fn5+fn5+fg0KPiA+Pj4gICAgICAgIFN0YXRpYyBpbnQgc3A3MDIx
X2NwdWlkbGVfc3VzcGVuZF9lbnRlcih1bnNpZ25lZCBsb25nIGluZGV4KSB7fn0NCj4gPj4+ICAg
ICAgICBTdGF0aWMgaW50IF9faW5pdCBzcDcwMjFfY3B1aWRsZV9pbml0KHN0cnVjdCBkZXZpY2Vf
bm9kZSAqY3B1X25vZGUsIGludCBjcHUpIHt+fQ0KPiA+Pj4gICAgICAgIFN0YXRpYyBjb25zdCBz
dHJ1Y3QgY3B1aWRsZV9vcHMgc2Nfc21wX29wcyBfX2luaXRjb25zdCA9IHsNCj4gPj4+ICAgICAg
ICAgICAgIC5zdXNwZW5kID0gc3A3MDIxX2NwdWlkbGVfc3VzcGVuZF9lbnRlciwNCj4gPj4+ICAg
ICAgICAgICAgIC5pbml0ID0gc3A3MDIxX2NwdWlkbGVfaW5pdCwNCj4gPj4+ICAgICAgICB9Ow0K
PiA+Pj4gICAgICAgIENQVUlETEVfTUVUSE9EX09GX0RFQ0xBUkUoc2Nfc21wLCAic3VucGx1cyxz
Yy1zbXAiLA0KPiA+Pj4gJnNjX3NtcF9vcHMpOyAvL2RlY2xhcmUNCj4gPj4gZW5hYmxlIG1ldGhv
ZA0KPiA+Pj4NCj4gPj4+IH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4+PiB+fg0KPiA+Pj4gfn5+fn5+fn5+fg0K
PiA+Pj4NCj4gPj4+ICAgICAgICBCdXQgY2hhbmdlIGNwdWlsZGUtYXJtLmMgZm9yIHN1bnBsdXMg
ZHJpdmVyIHNlZW1zIG5vdCByZWFzb25hYmxlLg0KPiA+Pj4gICAgICAgIFRoYXQgaXMgd2h5IEkg
d2FudCB0byBzdWJtaXQgY3B1aWRsZS1zdW5wbHVzLmMNCj4gPj4+ICAgICAgICBBbHRob3VnaHQg
c3VucGx1cyBjcHVpZGxlIG9ubHkgY29tZSBpbiBXRkksIGJ1dCBpdCBjYW4gY29tcGxldGUgdGhl
IGNwdWlkbGUgZnJhbWV3b3JrLg0KPiA+Pg0KPiA+PiBJIGRvbid0IHRoaW5rIGl0IGlzIGNvcnJl
Y3QuIFlvdSBjYW4gdXNlIGNwdWlkbGUtYXJtLCBiZWNhdXNlIGl0IGlzDQo+ID4+IGJlaW5nIGFs
d2F5cyBpbml0aWFsaXplZCB3aXRoIGRldmljZV9pbml0Y2FsbCgpLiBZb3UgZWl0aGVyIHVzZSBh
cHByb3ByaWF0ZSBjb21wYXRpYmxlIGluIERUIG9yIGFkZA0KPiB5b3VyIGNvbXBhdGlibGUgdG8g
Y3B1aWRsZS1hcm0uDQo+ID4+DQo+ID4+IEV2ZW4gaWYgdGhpcyBkaWQgbm90IHdvcmssIHRoZW4g
dGhlIHNvbHV0aW9uIGlzIHRvIHVzZSBjb21tb24gcGFydHMsIG5vdCB0byBkdXBsaWNhdGUgZW50
aXJlIGRyaXZlci4NCj4gPj4gRHVwbGljYXRpbmcgaXMgbm90IGFjY2VwdGFibGUuDQo+ID4+DQo+
ID4+IEJlc3QgcmVnYXJkcywNCj4gPj4gS3J6eXN6dG9mDQo+ID4NCj4gPg0KPiA+IEkgZG8gdXNl
ZCBjb21wYXRpYmxlID0gImFybSxpZGxlLXN0YXRlIiBpbiBEVCBhbmQgZW5hYmxlIGdlbmVyaWMg
YXJtIGNwdWlkbGUgZHJpdmVyIGluIG1lbnVjb25maWcuDQo+ID4gQnV0IHRoZXJlIGhhdmUgbW91
bnQgZHJpdmVyIGZhaWwgbWVzc2FnZSBkdWUgdG8gbm8gY3B1aWRsZV9vcHMgZnVuY3Rpb25zLg0K
PiA+IFRoYXQgaXMgd2h5IEkgbmVlZCBhZGRlZCBwYXRjaCBjb2RlIHRvIGNvbXBsZXRlIGNwdWlk
bGUgZHJpdmVyLg0KPiA+IEFjY29yZGluZyB5b3VyIGNvbW1lbnQsIEkgd2lsbCB0cnkgdG8gdXNl
IGNvbW1vbiBwYXJ0cyBhbmQgaG9vayBzb21lIGN1c3RvbSBjb2RlLCBsYXRlci4NCj4gDQo+IEkg
dGhpbmsgSSB1bmRlcnN0b29kIHRoZSBtb3RpdmF0aW9uIGJlaGluZCB5b3VyIGRyaXZlci4gVGhl
IGNwdWlkbGUtYXJtIHJlcXVpcmVzIGVuYWJsZS1tZXRob2QNCj4gcHJvcGVydHkgd2hpY2ggdXN1
YWxseSB1c2VzIGZvciBBUk12NyBDUFVfTUVUSE9EX09GX0RFQ0xBUkUoKS4gWW91IGRvbid0IGhh
dmUNCj4gQ1BVX01FVEhPRF9PRl9ERUNMQVJFKCkuDQo+IA0KPiBOb3cgdGhlIHF1ZXN0aW9uOiB3
aHkgY2FuJ3QgeW91IGRlZmluZSBDUFVfTUVUSE9EX09GX0RFQ0xBUkUoKSBqdXN0IGxpa2UgbWFu
eSBvdGhlciBBUk12Nw0KPiBwbGF0Zm9ybXMgZG8/DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0KDQoNClllcywgSSB3aWxsIHRyeSBpdCBpbiBuZXh0IHBhdGNoLg0KVGhhbmtzLg0K
DQoNCumCseWeguWzsCBFZHdpbkNoaXUNCuaZuuiDvemBi+eul+WwiOahiA0KVDogKzg4Ni0zLTU3
ODYwMDUgZXh0LjI1OTANCmVkd2luLmNoaXVAc3VucGx1cy5jb20NCjMwMCDmlrDnq7nnp5Hlrbjl
nJLljYDlibXmlrDkuIDot68xOeiZnw0KDQo=
