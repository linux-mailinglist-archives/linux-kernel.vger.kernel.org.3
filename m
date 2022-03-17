Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227004DD044
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiCQVhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiCQVhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:37:01 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EDE1AFEA5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:35:43 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7F3102C0AE0;
        Thu, 17 Mar 2022 21:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647552939;
        bh=DlueJLxm9RcO/tRmC2VtXRzjrDErf+I1jJMg4aCB1kM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=2ePZXTRNg+QVavVMFpbvctvcLVPEh2KRYA49jE5V9UCnxaJtSlPk0ipUHAeXckQiq
         U2ixilxyPOxwg3XPkCGs9zjUFdI+7GqG3DFqcpw2USpL+CBSnkqBnITNhI1sHm+s37
         uFWE2nNq0v19j34KP5xWwT/1f3O4k6H8BR+wEEDVhikOboVjcXnHMiu0cUF2+BNvPt
         O1Cd2je+uY0tXBuVvxwaFVC5Urr8cNj53o+6AXthJmxnm2k6Z4mGi9TmYEtcGkDrNp
         xuzSU3v3ren7svVNGXLk0Rmc8J62hwCaxb+A/hg/hhi1bzFBepGVZcSoKCOPs4Gy2F
         5pxZ2vHn+KxEw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6233a9ab0001>; Fri, 18 Mar 2022 10:35:39 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 18 Mar 2022 10:35:39 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Fri, 18 Mar 2022 10:35:39 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (adt7475) Add support for pin configuration
Thread-Topic: [PATCH 2/2] hwmon: (adt7475) Add support for pin configuration
Thread-Index: AQHYOY9kLKbL3RzLBkeZC7t5/EMPlKzCuNeAgACH+gA=
Date:   Thu, 17 Mar 2022 21:35:38 +0000
Message-ID: <52a6f788-cba7-9823-76db-523e2e8c1f2e@alliedtelesis.co.nz>
References: <20220316234134.290492-1-chris.packham@alliedtelesis.co.nz>
 <20220316234134.290492-3-chris.packham@alliedtelesis.co.nz>
 <6aabb517-c46e-bcf8-c93d-b6fa1fe8eb3a@roeck-us.net>
In-Reply-To: <6aabb517-c46e-bcf8-c93d-b6fa1fe8eb3a@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6A5DA8C65BEE047A726C46EBBE6D2B4@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=r7lCqylzDVdJZBd3QE4A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxOC8wMy8yMiAwMjoyOCwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gT24gMy8xNi8yMiAx
Njo0MSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IFRoZSBhZHQ3NDczLCBhZHQ3NDc1LCBhZHQ3
NDc2IGFuZCBhZHQ3NDkwIGhhdmUgcGlucyB0aGF0IGNhbiBiZSB1c2VkIGZvcg0KPj4gZGlmZmVy
ZW50IGZ1bmN0aW9ucy4gT24gdGhlIGFkdDc0NzMgYW5kwqAgYWR0NzQ3NSB0aGlzIGlzIHBpbnMg
NSBhbmQgOS4NCj4+IE9uIHRoZSBhZHQ3NDc2IGFuZCBhZHQ3NDkwIHRoaXMgaXMgcGlucyAxMCBh
bmQgMTQuDQo+Pg0KPj4gVGhlIGZpcnN0IHBpbiBjYW4gZWl0aGVyIGJlIFBXTTIoZGVmYXVsdCkg
b3IgU01CQUxFUlQjLiBUaGUgc2Vjb25kIHBpbg0KPj4gY2FuIGJlIFRBQ0g0KGRlZmF1bHQpLCBU
SEVSTSMsIFNNQkFMRVJUIyBvciBHUElPLg0KPj4NCj4+IFRoZSBhZHQ3NDc1IGRyaXZlciBoYXMg
YWx3YXlzIGJlZW4gYWJsZSB0byBkZXRlY3QgdGhlIGNvbmZpZ3VyYXRpb24gaWYNCj4+IGl0IGhh
ZCBiZWVuIGRvbmUgYnkgYW4gZWFybGllciBib290IHN0YWdlLiBBZGQgc3VwcG9ydCBmb3IgY29u
ZmlndXJpbmcNCj4+IHRoZSBwaW5zIGJhc2VkIG9uIHRoZSBoYXJkd2FyZSBkZXNjcmlwdGlvbiBp
biB0aGUgZGV2aWNlIHRyZWUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8
Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJz
L2h3bW9uL2FkdDc0NzUuYyB8IDk1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL2FkdDc0NzUuYyBiL2RyaXZlcnMvaHdtb24vYWR0NzQ3
NS5jDQo+PiBpbmRleCA5ZDViMDE5NjUxZjIuLmFkNWU1YTdhODQ0YiAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvaHdtb24vYWR0NzQ3NS5jDQo+PiArKysgYi9kcml2ZXJzL2h3bW9uL2FkdDc0NzUu
Yw0KPj4gQEAgLTExMiw2ICsxMTIsOCBAQA0KPj4gwqAgI2RlZmluZSBDT05GSUczX1RIRVJNwqDC
oMKgwqDCoMKgwqAgMHgwMg0KPj4gwqAgwqAgI2RlZmluZSBDT05GSUc0X1BJTkZVTkPCoMKgwqDC
oMKgwqDCoCAweDAzDQo+PiArI2RlZmluZSBDT05GSUc0X1RIRVJNwqDCoMKgwqDCoMKgwqAgMHgw
MQ0KPj4gKyNkZWZpbmUgQ09ORklHNF9TTUJBTEVSVMKgwqDCoCAweDAyDQo+PiDCoCAjZGVmaW5l
IENPTkZJRzRfTUFYRFVUWcKgwqDCoMKgwqDCoMKgIDB4MDgNCj4+IMKgICNkZWZpbmUgQ09ORklH
NF9BVFROX0lOMTDCoMKgwqAgMHgzMA0KPj4gwqAgI2RlZmluZSBDT05GSUc0X0FUVE5fSU40M8Kg
wqDCoCAweEMwDQo+PiBAQCAtMTQ2MCw2ICsxNDYyLDk1IEBAIHN0YXRpYyBpbnQgYWR0NzQ3NV91
cGRhdGVfbGltaXRzKHN0cnVjdCANCj4+IGkyY19jbGllbnQgKmNsaWVudCkNCj4+IMKgwqDCoMKg
wqAgcmV0dXJuIDA7DQo+PiDCoCB9DQo+PiDCoCArc3RhdGljIGludCBsb2FkX3BpbjEwX2NvbmZp
Zyhjb25zdCBzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LCANCj4+IGNvbnN0IGNoYXIgKnByb3Bu
YW1lKQ0KPj4gK3sNCj4NCj4gQSBiZXR0ZXIgZnVuY3Rpb24gbmFtZSB3b3VsZCBwcm9iYWJseSBi
ZSBsb2FkX2NvbmZpZzMoKSBvciBzaW1pbGFyLg0KDQpZZXAgdGhhdCdkIGJlIGEgYmV0dGVyIG5h
bWUuDQoNCj4NCj4+ICvCoMKgwqAgY29uc3QgY2hhciAqZnVuY3Rpb247DQo+PiArwqDCoMKgIHU4
IGNvbmZpZzM7DQo+PiArwqDCoMKgIGludCBlcnI7DQo+PiArDQo+PiArwqDCoMKgIGVyciA9IG9m
X3Byb3BlcnR5X3JlYWRfc3RyaW5nKGNsaWVudC0+ZGV2Lm9mX25vZGUsIHByb3BuYW1lLCANCj4+
ICZmdW5jdGlvbik7DQo+PiArwqDCoMKgIGlmICghZXJyKSB7DQo+PiArwqDCoMKgwqDCoMKgwqAg
Y29uZmlnMyA9IGFkdDc0NzVfcmVhZChSRUdfQ09ORklHMyk7DQo+DQo+IGVycm9yIGNoZWNrIG1p
c3NpbmcgKEkgc2VlIHRoZSBkcml2ZXIgaXMgbm90b3Jpb3VzIGZvciB0aGF0LCBidXQgdGhhdCAN
Cj4gaXMgbm90DQo+IGEgcmVhc29uIHRvIGtlZXAgZG9pbmcgaXQpLg0KDQpJa2VnYW1pLXNhbiBh
bmQgRGFuIGRpZCB0byBzb21lIGdvb2Qgd29yayB0byBhZGRyZXNzIHNvbWUgb2YgdGhhdC4gVGhl
IA0KcHJvYmUgZnVuY3Rpb24gaXMgc3RpbGwgcXVpdGUgY2FyZWxlc3MuDQoNCkknbGwgc2VlIHdo
YXQgSSBjYW4gZG8gdG8gbWFrZSBzdXJlIG15IGFkZGl0aW9ucyBkb24ndCBtYWtlIGl0IHdvcnNl
Lg0KPg0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghc3RyY21wKCJwd20yIiwgZnVuY3Rp
b24pKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uZmlnMyAmPSB+Q09ORklHM19TTUJB
TEVSVDsNCj4+ICvCoMKgwqDCoMKgwqDCoCBlbHNlIGlmICghc3RyY21wKCJzbWJhbGVydCMiLCBm
dW5jdGlvbikpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25maWczIHw9IENPTkZJRzNf
U01CQUxFUlQ7DQo+PiArwqDCoMKgwqDCoMKgwqAgZWxzZQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGky
Y19zbWJ1c193cml0ZV9ieXRlX2RhdGEoY2xpZW50LCBSRUdfQ09ORklHMywgY29uZmlnMyk7DQo+
PiArwqDCoMKgIH0NCj4+ICsNCj4+ICvCoMKgwqAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4g
K3N0YXRpYyBpbnQgbG9hZF9waW4xNF9jb25maWcoY29uc3Qgc3RydWN0IGkyY19jbGllbnQgKmNs
aWVudCwgY29uc3QgDQo+PiBjaGFyICpwcm9wbmFtZSkNCj4+ICt7DQo+DQo+IGxvYWRfY29uZmln
NCgpID8NCj4NCj4+ICvCoMKgwqAgY29uc3QgY2hhciAqZnVuY3Rpb247DQo+PiArwqDCoMKgIHU4
IGNvbmZpZzQ7DQo+PiArwqDCoMKgIGludCBlcnI7DQo+PiArDQo+PiArwqDCoMKgIGVyciA9IG9m
X3Byb3BlcnR5X3JlYWRfc3RyaW5nKGNsaWVudC0+ZGV2Lm9mX25vZGUsIHByb3BuYW1lLCANCj4+
ICZmdW5jdGlvbik7DQo+PiArwqDCoMKgIGlmICghZXJyKSB7DQo+PiArwqDCoMKgwqDCoMKgwqAg
Y29uZmlnNCA9IGFkdDc0NzVfcmVhZChSRUdfQ09ORklHNCk7DQo+DQo+IGVycm9yIGNoZWNrDQo+
DQo+PiArwqDCoMKgwqDCoMKgwqAgY29uZmlnNCAmPSB+Q09ORklHNF9QSU5GVU5DOw0KPj4gKw0K
Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghc3RyY21wKCJ0YWNoNCIsIGZ1bmN0aW9uKSkNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDsNCj4+ICvCoMKgwqDCoMKgwqDCoCBlbHNlIGlmICghc3Ry
Y21wKCJ0aGVybSMiLCBmdW5jdGlvbikpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25m
aWc0IHw9IENPTkZJRzRfVEhFUk07DQo+PiArwqDCoMKgwqDCoMKgwqAgZWxzZSBpZiAoIXN0cmNt
cCgic21iYWxlcnQjIiwgZnVuY3Rpb24pKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29u
ZmlnNCB8PSBDT05GSUc0X1NNQkFMRVJUOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UgaWYgKCFz
dHJjbXAoImdwaW8iLCBmdW5jdGlvbikpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25m
aWc0IHw9IENPTkZJRzRfUElORlVOQzsNCj4+ICvCoMKgwqDCoMKgwqDCoCBlbHNlDQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICvCoMKgwqDCoMKg
wqDCoCByZXR1cm4gaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YShjbGllbnQsIFJFR19DT05GSUc0
LCBjb25maWc0KTsNCj4+ICvCoMKgwqAgfQ0KPj4gKw0KPj4gK8KgwqDCoCByZXR1cm4gMDsNCj4+
ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBsb2FkX2NvbmZpZyhjb25zdCBzdHJ1Y3QgaTJjX2Ns
aWVudCAqY2xpZW50LCBpbnQgY2hpcCkNCj4+ICt7DQo+PiArwqDCoMKgIGludCBlcnI7DQo+PiAr
wqDCoMKgIGNvbnN0IGNoYXIgKmNvbmZfcHJvcDEsICpjb25mX3Byb3AyOw0KPg0KPiBjb25mXyBw
cmVmaXggaXMgdW5uZWNlc3NhcnkuDQo+DQo+PiArDQo+PiArwqDCoMKgIHN3aXRjaCAoY2hpcCkg
ew0KPj4gK8KgwqDCoCBjYXNlIGFkdDc0NzM6DQo+PiArwqDCoMKgIGNhc2UgYWR0NzQ3NToNCj4+
ICvCoMKgwqDCoMKgwqDCoCBjb25mX3Byb3AxID0gImFkaSxwaW41LWZ1bmN0aW9uIjsNCj4+ICvC
oMKgwqDCoMKgwqDCoCBjb25mX3Byb3AyID0gImFkaSxwaW45LWZ1bmN0aW9uIjsNCj4+ICvCoMKg
wqDCoMKgwqDCoCBicmVhazsNCj4+ICvCoMKgwqAgY2FzZSBhZHQ3NDc2Og0KPj4gK8KgwqDCoCBj
YXNlIGFkdDc0OTA6DQo+PiArwqDCoMKgwqDCoMKgwqAgY29uZl9wcm9wMSA9ICJhZGkscGluMTAt
ZnVuY3Rpb24iOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGNvbmZfcHJvcDIgPSAiYWRpLHBpbjE0LWZ1
bmN0aW9uIjsNCj4+ICvCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4+ICvCoMKgwqAgZGVmYXVsdDoN
Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsNCj4NCj4gSXQgZG9lc24ndCBzZWVt
IHJpZ2h0IHRvIHJldHVybiAtRUlOVkFMIGhlcmUuDQo+DQpIYXZlIHlvdSBnb3QgYSBiZXR0ZXIg
c3VnZ2VzdGlvbj8gSSB3YXMgdHJ5aW5nIHRvIGF2b2lkIHNvbWVvbmUgDQpzcGVjaWZ5aW5nIGNv
bXBhdGlibGUgPSAiYWRpLGFkdDc0NzYiIHdpdGggImFkaSxwaW41LWZ1bmN0aW9uIi4gSXMgeW91
ciANCmNvbmNlcm4gdGhhdCBJIHNob3VsZCB1c2UgLUVOT0RFViBvciB0aGF0IEkgc2hvdWxkIGp1
c3QgcGljayBtb3JlIA0KZ2VuZXJpYyBuYW1lcyBmb3IgdGhlIGNvbmZpZ3VyYWJsZSBwaW5zIChu
YW1pbmcgdGhpbmdzIGlzIGhhcmQpLg0KDQpPciBwZXJoYXBzIGp1c3QgZGV2X3dhcm4oKSBhbmQg
cmV0dXJuIDA/DQoNCj4+ICvCoMKgwqAgfQ0KPj4gKw0KPj4gK8KgwqDCoCBpZiAoY2hpcCAhPSBh
ZHQ3NDc2ICYmIGNoaXAgIT0gYWR0NzQ5MCkNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsN
Cj4+ICsNCj4NCj4gV2h5IG5vdCBjaGVjayB0aGlzIGZpcnN0LCBhbmQgd2hhdCBpcyB0aGUgcG9p
bnQgb2YgYXNzaWduaW5nIHZhbHVlcyB0bw0KPiBjb25mX3Byb3AxIGFuZCBjb25mX3Byb3AyIGZv
ciB0aGUgb3RoZXIgY2hpcHMgaW4gdGhlIGNhc2Ugc3RhdGVtZW50IGFib3ZlDQo+IG9ubHkgdG8g
cmV0dXJuIDAgaGVyZSA/IEl0IHdvdWxkIGJlIG11Y2ggc2ltcGxlciB0byBkcm9wIHRoZSBvdGhl
ciBjaGlwcw0KPiBmcm9tIHRoZSBjYXNlIHN0YXRlbWVudCBhbmQgaGF2ZSBkZWZhdWx0OiByZXR1
cm4gMC4NCj4NClNvcnJ5IHRoYXQgaXMgb2xkLiBJIGluaXRpYWxseSB3YXMgdW5kZXIgdGhlIGlt
cHJlc3Npb24gdGhhdCBvbmx5IHRoZXNlIA0KMiBoYWQgY29uZmlndXJhYmxlIHBpbnMgYnV0IHRo
ZW4gSSByZWFkIHRoZSBvdGhlciBkYXRhc2hlZXRzIG1vcmUgY2xvc2VseS4NCj4+ICvCoMKgwqAg
ZXJyID0gbG9hZF9waW4xMF9jb25maWcoY2xpZW50LCBjb25mX3Byb3AxKTsNCj4+ICvCoMKgwqAg
aWYgKGVycikgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGRldl9lcnIoJmNsaWVudC0+ZGV2LCAiZmFp
bGVkIHRvIGNvbmZpZ3VyZSBQSU4xMFxuIik7DQo+DQo+IFRoZSBtZXNzYWdlcyBhcmUgbWlzbGVh
ZGluZy4gVGhpcyBpc24ndCBhbHdheXMgcGluIDEwLzE0Lg0KPg0KTm93IEkndmUgZ290IHRoZSBw
cm9wIG5hbWVzIEkgY2FuIHVzZSB0aGF0IGluc3RlYWQuDQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIGVycjsNCj4+ICvCoMKgwqAgfQ0KPj4gKw0KPj4gK8KgwqDCoCBlcnIgPSBsb2FkX3BpbjE0
X2NvbmZpZyhjbGllbnQsIGNvbmZfcHJvcDIpOw0KPj4gK8KgwqDCoCBpZiAoZXJyKSB7DQo+PiAr
wqDCoMKgwqDCoMKgwqAgZGV2X2VycigmY2xpZW50LT5kZXYsICJmYWlsZWQgdG8gY29uZmlndXJl
IFBJTjE0XG4iKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZXJyOw0KPj4gK8KgwqDCoCB9
DQo+PiArDQo+PiArwqDCoMKgIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+IMKgIHN0YXRpYyBp
bnQgc2V0X3Byb3BlcnR5X2JpdChjb25zdCBzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LCBjaGFy
IA0KPj4gKnByb3BlcnR5LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
OCAqY29uZmlnLCB1OCBiaXRfaW5kZXgpDQo+PiDCoCB7DQo+PiBAQCAtMTU4NSw2ICsxNjc2LDEw
IEBAIHN0YXRpYyBpbnQgYWR0NzQ3NV9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCANCj4+ICpjbGll
bnQpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV2aXNpb24gPSBhZHQ3NDc1X3JlYWQoUkVHX0RF
VklEMikgJiAweDA3Ow0KPj4gwqDCoMKgwqDCoCB9DQo+PiDCoCArwqDCoMKgIHJldCA9IGxvYWRf
Y29uZmlnKGNsaWVudCwgY2hpcCk7DQo+PiArwqDCoMKgIGlmIChyZXQpDQo+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIHJldDsNCj4+ICsNCj4+IMKgwqDCoMKgwqAgY29uZmlnMyA9IGFkdDc0NzVf
cmVhZChSRUdfQ09ORklHMyk7DQo+PiDCoMKgwqDCoMKgIC8qIFBpbiBQV00yIG1heSBhbHRlcm5h
dGl2ZWx5IGJlIHVzZWQgZm9yIEFMRVJUIG91dHB1dCAqLw0KPj4gwqDCoMKgwqDCoCBpZiAoIShj
b25maWczICYgQ09ORklHM19TTUJBTEVSVCkpDQo+
