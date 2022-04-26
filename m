Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6750FC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349664AbiDZLw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244202AbiDZLw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:52:26 -0400
Received: from spam2.hygon.cn (unknown [110.188.70.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CFA38DB8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:49:17 -0700 (PDT)
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id 23QBjhUM002405;
        Tue, 26 Apr 2022 19:45:43 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id 23QBjavX089615;
        Tue, 26 Apr 2022 19:45:36 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn (172.23.18.10) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 19:45:32 +0800
Received: from cncheex01.Hygon.cn ([172.23.18.10]) by cncheex01.Hygon.cn
 ([172.23.18.10]) with mapi id 15.01.2375.024; Tue, 26 Apr 2022 19:45:32 +0800
From:   Wen Pu <puwen@hygon.cn>
To:     Sandipan Das <sandipan.das@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "like.xu.linux@gmail.com" <like.xu.linux@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
        "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
        "santosh.shukla@amd.com" <santosh.shukla@amd.com>
Subject: Re: [PATCH v2 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Thread-Topic: [PATCH v2 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Thread-Index: AQHYWHxbGifZsj53i0W4Cl6nd1FFc60BVJgAgAAG9ICAADOjAA==
Date:   Tue, 26 Apr 2022 11:45:32 +0000
Message-ID: <25e89d27-d7da-2dea-dd20-0a9d8dcdee83@hygon.cn>
References: <cover.1650515382.git.sandipan.das@amd.com>
 <54bc7fe4cadf6bdef823bab1fba43d4891d2e1a9.1650515382.git.sandipan.das@amd.com>
 <20220426081550.GO2731@worktop.programming.kicks-ass.net>
 <9e6d14a0-a658-195c-c7a3-7d2687a61544@amd.com>
In-Reply-To: <9e6d14a0-a658-195c-c7a3-7d2687a61544@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.18.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3FFCC354D999045906CD0C0BD9713BF@Hygon.cn>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: spam2.hygon.cn 23QBjhUM002405
X-DNSRBL: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi80LzI2IDE2OjQwLCBTYW5kaXBhbiBEYXMgd3JvdGU6DQo+IEhpIFBldGVyLA0KPiAN
Cj4gT24gNC8yNi8yMDIyIDE6NDUgUE0sIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4gT24gVGh1
LCBBcHIgMjEsIDIwMjIgYXQgMTE6MTY6NTlBTSArMDUzMCwgU2FuZGlwYW4gRGFzIHdyb3RlOg0K
Pj4+IE9uIHNvbWUgeDg2IHByb2Nlc3NvcnMsIENQVUlEIGxlYWYgMHhBIHByb3ZpZGVzIGluZm9y
bWF0aW9uDQo+Pj4gb24gQXJjaGl0ZWN0dXJhbCBQZXJmb3JtYW5jZSBNb25pdG9yaW5nIGZlYXR1
cmVzLiBJdA0KPj4+IGFkdmVydGlzZXMgYSBQTVUgdmVyc2lvbiB3aGljaCBRZW11IHVzZXMgdG8g
ZGV0ZXJtaW5lIHRoZQ0KPj4+IGF2YWlsYWJpbGl0eSBvZiBhZGRpdGlvbmFsIE1TUnMgdG8gbWFu
YWdlIHRoZSBQTUNzLg0KPj4+DQo+Pj4gVXBvbiByZWNlaXZpbmcgYSBLVk1fR0VUX1NVUFBPUlRF
RF9DUFVJRCBpb2N0bCByZXF1ZXN0IGZvcg0KPj4+IHRoZSBzYW1lLCB0aGUga2VybmVsIGNvbnN0
cnVjdHMgcmV0dXJuIHZhbHVlcyBiYXNlZCBvbiB0aGUNCj4+PiB4ODZfcG11X2NhcGFiaWxpdHkg
aXJyZXNwZWN0aXZlIG9mIHRoZSB2ZW5kb3IuDQo+Pj4NCj4+PiBUaGlzIGxlYWYgYW5kIHRoZSBh
ZGRpdGlvbmFsIE1TUnMgYXJlIG5vdCBzdXBwb3J0ZWQgb24gQU1EDQo+Pj4gcHJvY2Vzc29ycy4g
SWYgUGVyZk1vblYyIGlzIGRldGVjdGVkLCB0aGUgUE1VIHZlcnNpb24gaXMNCj4+PiBzZXQgdG8g
MiBhbmQgZ3Vlc3Qgc3RhcnR1cCBicmVha3MgYmVjYXVzZSBvZiBhbiBhdHRlbXB0IHRvDQo+Pj4g
YWNjZXNzIGEgbm9uLWV4aXN0ZW50IE1TUi4gUmV0dXJuIHplcm9zIHRvIGF2b2lkIHRoaXMuDQo+
Pj4NCj4+PiBGaXhlczogYTZjMDZlZDFhNjBhICgiS1ZNOiBFeHBvc2UgdGhlIGFyY2hpdGVjdHVy
YWwgcGVyZm9ybWFuY2UgbW9uaXRvcmluZyBDUFVJRCBsZWFmIikNCj4+PiBSZXBvcnRlZC1ieTog
VmFzYW50IEhlZ2RlIDx2YXNhbnQuaGVnZGVAYW1kLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBT
YW5kaXBhbiBEYXMgPHNhbmRpcGFuLmRhc0BhbWQuY29tPg0KPj4+IC0tLQ0KPj4+ICAgYXJjaC94
ODYva3ZtL2NwdWlkLmMgfCA1ICsrKysrDQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL2NwdWlkLmMgYi9hcmNo
L3g4Ni9rdm0vY3B1aWQuYw0KPj4+IGluZGV4IDRiNjJkODBiYjIyZi4uNmJkNjVjYWQ3NWVmIDEw
MDY0NA0KPj4+IC0tLSBhL2FyY2gveDg2L2t2bS9jcHVpZC5jDQo+Pj4gKysrIGIvYXJjaC94ODYv
a3ZtL2NwdWlkLmMNCj4+PiBAQCAtODcyLDYgKzg3MiwxMSBAQCBzdGF0aWMgaW5saW5lIGludCBf
X2RvX2NwdWlkX2Z1bmMoc3RydWN0IGt2bV9jcHVpZF9hcnJheSAqYXJyYXksIHUzMiBmdW5jdGlv
bikNCj4+PiAgIAkJdW5pb24gY3B1aWQxMF9lYXggZWF4Ow0KPj4+ICAgCQl1bmlvbiBjcHVpZDEw
X2VkeCBlZHg7DQo+Pj4gICANCj4+PiArCQlpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09
IFg4Nl9WRU5ET1JfQU1EKSB7DQo+Pg0KPj4gVGhpcyBpcyB0aGUgb2JsaWdhdG9yeSBxdWVzdGlv
biBhYm91dCBIWUdPTjsgc2hvdWxkIHRoZXkgYmUgaW5jbHVkZWQNCj4+IGhlcmU/DQo+Pg0KPj4g
eDg2IGlzIGdldHRpbmcgYSBudW1iZXIgb2YgbWUtdG9vIHBhdGNoZXMgZnJvbSBib3RoIHNpZGVz
LCB3aGVyZQ0KPj4gYmVoYXZpb3VyIGhhcyBkaXZlcmdlZCBmb3Igbm8gcmFpc2luIGFuZCB0aGVu
IG5lZWRzIHRvIGJlIGZpeGVkIHVwDQo+PiBhZ2Fpbi4NCj4+DQo+IA0KPiAgRnJvbSB3aGF0IEkg
dW5kZXJzdGFuZCwgSHlnb24gcHJvY2Vzc29ycyBhbHNvIGRvIG5vdCBzdXBwb3J0IHRoaXMgbGVh
Zi4NCj4gQ29weWluZyBQdSBXZW4gZm9yIGNvbmZpcm1hdGlvbi4NCg0KSGkgUGV0ZXIsIFNhbmRp
cGFu77yaDQoNCkkgaGF2ZSBjb25maXJtZWQgdGhhdCBIeWdvbiBwcm9jZXNzb3JzIGRvIG5vdCBz
dXBwb3J0IENQVUlEIGxlYWYgMHhBLg0KU2FuZGlwYW4sIGNvdWxkIHlvdSBwbGVhc2UgYWxzbyBh
ZGQgWDg2X1ZFTkRPUl9IWUdPTiBpbiB0aGUgaWYNCmNvbmRpdGlvbmFsPw0KDQotLSANClJlZ2Fy
ZHMsDQpQdSBXZW4NCg0KPiAtIFNhbmRpcGFuDQo+IA0KPj4+ICsJCQllbnRyeS0+ZWF4ID0gZW50
cnktPmVieCA9IGVudHJ5LT5lY3ggPSBlbnRyeS0+ZWR4ID0gMDsNCj4+PiArCQkJYnJlYWs7DQo+
Pj4gKwkJfQ0KPj4+ICsNCj4+PiAgIAkJcGVyZl9nZXRfeDg2X3BtdV9jYXBhYmlsaXR5KCZjYXAp
Ow0KPj4+ICAgDQo+Pj4gICAJCS8qDQo+Pj4gLS0gDQo+Pj4gMi4zMi4wDQo+Pj4=
