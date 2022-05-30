Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B9453763F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiE3IKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiE3IKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:10:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD9F075205
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:10:01 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-37-Q1IaZgzkNfy3MLvifs1jIQ-1; Mon, 30 May 2022 09:09:59 +0100
X-MC-Unique: Q1IaZgzkNfy3MLvifs1jIQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 30 May 2022 09:09:57 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 30 May 2022 09:09:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yu-Jen Chang' <arthurchang09@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "jdike@linux.intel.com" <jdike@linux.intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>
Subject: RE: [PATCH 1/2] x86/lib: Optimize memchr()
Thread-Topic: [PATCH 1/2] x86/lib: Optimize memchr()
Thread-Index: AQHYcmroNJne+UgOCEK2wOYbJvL5k603Dq9w
Date:   Mon, 30 May 2022 08:09:57 +0000
Message-ID: <8b480c85f53c4f3b88bf99ba585e8768@AcuMS.aculab.com>
References: <20220528081236.3020-1-arthurchang09@gmail.com>
 <20220528081236.3020-2-arthurchang09@gmail.com>
In-Reply-To: <20220528081236.3020-2-arthurchang09@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWXUtSmVuIENoYW5nDQo+IFNlbnQ6IDI4IE1heSAyMDIyIDA5OjEzDQo+IA0KPiBUaGUg
b3JpZ2luYWwgYXNzZW1ibHkgdmVyc2lvbiBvZiBtZW1jaHIoKSBpcyBpbXBsZW1lbnRlZCB3aXRo
DQo+IHRoZSBieXRlLXdpc2UgY29tcGFyaW5nIHRlY2huaXF1ZSwgd2hpY2ggZG9lcyBub3QgZnVs
bHkNCj4gdXNlIDY0LWJpdHMgcmVnaXN0ZXJzIGluIHg4Nl82NCBDUFUuIFdlIHVzZSB3b3JkLXdp
ZGUNCj4gY29tcGFyaW5nIHNvIHRoYXQgOCBjaGFyYWN0ZXJzIGNhbiBiZSBjb21wYXJlZCBhdCB0
aGUgc2FtZSB0aW1lDQo+IG9uIHg4Nl82NCBDUFUuIEZpcnN0IHdlIGFsaWduIHRoZSBpbnB1dCBh
bmQgdGhlbiB1c2Ugd29yZC13aXNlDQo+IGNvbXBhcmluZyB0byBmaW5kIHRoZSBmaXJzdCA2NC1i
aXQgd29yZCB0aGF0IGNvbnRhaW4gdGhlIHRhcmdldC4NCj4gU2Vjb25kbHksIHdlIGNvbXBhcmUg
ZXZlcnkgYnl0ZSBpbiB0aGUgd29yZCBhbmQgZ2V0IHRoZSBvdXRwdXQuDQo+IA0KPiBXZSBjcmVh
dGUgdHdvIGZpbGVzIHRvIG1lYXN1cmUgdGhlIHBlcmZvcm1hbmNlLiBUaGUgZmlyc3QgZmlsZQ0K
PiBjb250YWlucyBvbiBhdmVyYWdlIDEwIGNoYXJhY3RlcnMgYWhlYWQgdGhlIHRhcmdldCBjaGFy
YWN0ZXIuDQo+IFRoZSBzZWNvbmQgZmlsZSBjb250YWlucyBhdCBsZWFzdCAxMDAwIGNoYXJhY3Rl
cnMgYWhlYWQgdGhlDQo+IHRhcmdldCBjaGFyYWN0ZXIuIE91ciBpbXBsZW1lbnRhdGlvbiBvZiDi
gJxtZW1jaHIoKeKAnSBpcyBzbGlnaHRseQ0KPiBiZXR0ZXIgaW4gdGhlIGZpcnN0IHRlc3QgYW5k
IG5lYXJseSA0eCBmYXN0ZXIgdGhhbiB0aGUgb3JnaW5hbA0KPiBpbXBsZW1lbnRhdGlvbiBpbiB0
aGUgc2Vjb25kIHRlc3QuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdS1KZW4gQ2hhbmcgPGFydGh1
cmNoYW5nMDlAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGluZy1DaHVuIChKaW0pIEh1
YW5nIDxqc2VydkBjY25zLm5ja3UuZWR1LnR3Pg0KPiAtLS0NCj4gIGFyY2gveDg2L2luY2x1ZGUv
YXNtL3N0cmluZ182NC5oIHwgIDMgKysNCj4gIGFyY2gveDg2L2xpYi9NYWtlZmlsZSAgICAgICAg
ICAgIHwgIDEgKw0KPiAgYXJjaC94ODYvbGliL3N0cmluZ182NC5jICAgICAgICAgfCA3OCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA4MiBpbnNl
cnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYvbGliL3N0cmluZ182NC5j
DQo+IA0KLi4uDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9saWIvc3RyaW5nXzY0LmMgYi9hcmNo
L3g4Ni9saWIvc3RyaW5nXzY0LmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAw
MDAwMDAwLi40ZTA2N2Q1YmUNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL3g4Ni9saWIv
c3RyaW5nXzY0LmMNCj4gQEAgLTAsMCArMSw3OCBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjANCj4gKyNpbmNsdWRlIDxsaW51eC9zdHJpbmcuaD4NCj4gKyNpbmNsdWRl
IDxsaW51eC9leHBvcnQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9hbGlnbi5oPg0KPiArDQo+ICsv
KiBIb3cgbWFueSBieXRlcyBhcmUgbG9hZGVkIGVhY2ggaXRlcmF0aW9uIG9mIHRoZSB3b3JkIGNv
cHkgbG9vcCAqLw0KPiArI2RlZmluZSBMQkxPQ0tTSVpFIChzaXplb2YobG9uZykpDQo+ICsNCj4g
KyNpZmRlZiBfX0hBVkVfQVJDSF9NRU1DSFINCj4gKw0KPiArdm9pZCAqbWVtY2hyKGNvbnN0IHZv
aWQgKmNzLCBpbnQgYywgc2l6ZV90IGxlbmd0aCkNCj4gK3sNCj4gKwljb25zdCB1bnNpZ25lZCBj
aGFyICpzcmMgPSAoY29uc3QgdW5zaWduZWQgY2hhciAqKWNzLCBkID0gYzsNCg0KWW91IGRvbid0
IG5lZWQgdGhlIGNhc3QuDQoNCj4gKw0KPiArCXdoaWxlICghSVNfQUxJR05FRCgobG9uZylzcmMs
IHNpemVvZihsb25nKSkpIHsNCj4gKwkJaWYgKCFsZW5ndGgtLSkNCj4gKwkJCXJldHVybiBOVUxM
Ow0KPiArCQlpZiAoKnNyYyA9PSBkKQ0KPiArCQkJcmV0dXJuICh2b2lkICopc3JjOw0KPiArCQlz
cmMrKzsNCj4gKwl9DQoNClRoZXJlIGlzIG5vIHBvaW50IGFsaWduaW5nIHRoZSBhZGRyZXNzLg0K
T24gdGVzdHMgSSd2ZSBkb25lIG1pc2FsaWduZWQgcmVhZHMgZG9uJ3QgZXZlbiB0YWtlIGFuIGV4
dHJhDQpjbG9jayAtIGV2ZW4gaWYgeW91IGdldCB0aGUgY3B1IGRvaW5nIHR3byByZWFkcy9jbG9j
ay4NCkV2ZW4gaWYgdGhleSBkaWQgdGhlIGNvZGUgaXNuJ3QgbWVtb3J5IGxpbWl0ZWQuDQoNCj4g
KwlpZiAobGVuZ3RoID49IExCTE9DS1NJWkUpIHsNCj4gKwkJdW5zaWduZWQgbG9uZyBtYXNrID0g
ZCA8PCA4IHwgZDsNCj4gKwkJdW5zaWduZWQgaW50IGkgPSAzMjsNCj4gKwkJbG9uZyB4b3IsIGRh
dGE7DQo+ICsJCWNvbnN0IGxvbmcgY29uc3RhID0gMHhGRUZFRkVGRUZFRkVGRUZGLA0KPiArCQkJ
ICAgY29uc3RiID0gMHg4MDgwODA4MDgwODA4MDgwOw0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIENy
ZWF0ZSBhIDgtYnl0ZXMgbWFzayBmb3Igd29yZC13aXNlIGNvbXBhcmluZy4NCj4gKwkJICogRm9y
IGV4YW1wbGUsIGEgbWFzayBmb3IgJ2EnIGlzIDB4NjE2MTYxNjE2MTYxNjE2MS4NCj4gKwkJICov
DQo+ICsNCj4gKwkJbWFzayB8PSBtYXNrIDw8IDE2Ow0KPiArCQlmb3IgKGkgPSAzMjsgaSA8IExC
TE9DS1NJWkUgKiA4OyBpIDw8PSAxKQ0KPiArCQkJbWFzayB8PSBtYXNrIDw8IGk7DQoNCkdpdmVu
IHRoYXQgY29uc3RhL2Igb25seSBzdXBwb3J0IDY0IGJpdCB3aHkgdGhlIGxvb3AuDQpKdXN0IGRv
IG1hc2sgfD0gbWFzayA8PCAzMi4NCkknZCBhbHNvIHB1dCBhbGwgMyBjYWxjdWxhdGlvbnMgdG9n
ZXRoZXIgLSBub3QgaGlkZSBvbmUNCmluIHRoZSBpbml0aWFsaXNlci4NCg0KPiArCQkvKg0KPiAr
CQkgKiBXZSBwZXJmb3JtIHdvcmQtd2lzZSBjb21wYXJpbmcgd2l0aCBmb2xsb3dpbmcgb3BlcmF0
aW9uOg0KPiArCQkgKgkxLiBQZXJmb3JtIHhvciBvbiB0aGUgbG9uZyB3b3JkIEBzcmMgYW5kIEBt
YXNrDQo+ICsJCSAqCSAgIGFuZCBwdXQgaW50byBAeG9yLg0KPiArCQkgKgkyLiBBZGQgQHhvciB3
aXRoIEBjb25zdGEuDQo+ICsJCSAqCTMuIH5AeG9yICYgQGNvbnN0Yi4NCj4gKwkJICoJNC4gUGVy
Zm9ybSAmIHdpdGggdGhlIHJlc3VsdCBvZiBzdGVwIDIgYW5kIDMuDQo+ICsJCSAqDQo+ICsJCSAq
IFN0ZXAgMSBjcmVhdGVzIGEgYnl0ZSB3aGljaCBpcyAwIGluIHRoZSBsb25nIHdvcmQgaWYNCj4g
KwkJICogdGhlcmUgaXMgYXQgbGVhc3Qgb25lIHRhcmdldCBieXRlIGluIGl0Lg0KPiArCQkgKg0K
PiArCQkgKiBTdGVwIDIgdG8gU3RlcCA0IGZpbmQgaWYgdGhlcmUgaXMgYSBieXRlIHdpdGggMCBp
bg0KPiArCQkgKiB0aGUgbG9uZyB3b3JkLg0KPiArCQkgKi8NCj4gKwkJYXNtIHZvbGF0aWxlKCIx
OlxuXHQiDQo+ICsJCQkgICAgICJtb3ZxICglMCksJTFcblx0Ig0KPiArCQkJICAgICAieG9ycSAl
NiwlMVxuXHQiDQo+ICsJCQkgICAgICJsZWEgKCUxLCU0KSwgJTJcblx0Ig0KPiArCQkJICAgICAi
bm90cSAlMVxuXHQiDQo+ICsJCQkgICAgICJhbmRxICU1LCUxXG5cdCINCj4gKwkJCSAgICAgInRl
c3RxICUxLCUyXG5cdCINCj4gKwkJCSAgICAgImpuZSAyZlxuXHQiDQo+ICsJCQkgICAgICJhZGQg
JDgsJTBcblx0Ig0KPiArCQkJICAgICAic3ViICQ4LCUzXG5cdCINCj4gKwkJCSAgICAgImNtcCAk
NywlM1xuXHQiDQo+ICsJCQkgICAgICJqYSAxYlxuXHQiDQo+ICsJCQkgICAgICIyOlxuXHQiDQo+
ICsJCQkgICAgIDogIj1EIihzcmMpLCAiPXIiKHhvciksICI9ciIoZGF0YSksICI9ciIobGVuZ3Ro
KQ0KDQpXaHkgY29uc3RyYWluIHNyYyB0byAlcmRpPw0KDQo+ICsJCQkgICAgIDogInIiKGNvbnN0
YSksICJyIihjb25zdGIpLCAiciIobWFzayksICIwIihzcmMpLA0KPiArCQkJICAgICAgICIxIih4
b3IpLCAiMiIoZGF0YSksICIzIihsZW5ndGgpDQoNClVzZSAiK3IiIGluIHRoZSBvdXRwdXRzIGlu
c3RlYWQgb2YgcmVzcGVjaWZ5aW5nIHRoZSBhcmdzLg0KSSdkIGFsc28gc3VnZ2VzdCB1c2luZyBu
YW1lZCBhcmd1bWVudHMgLSBtdWNoIGVhc2llciB0byByZWFkLg0KDQo+ICsJCQkgICAgIDogIm1l
bW9yeSIsICJjYyIpOw0KDQpEb2Vzbid0IHRoZSBjb21waWxlciBnZW5lcmF0ZSBtdWNoIHRoZSBz
YW1lIGNvZGU/DQpZb3Ugc2hvdWxkIGFsc28gYmUgYWJsZSB0byBjb2RlIHdpdGhvdXQgbmVlZGlu
ZyBhZGQsIHN1YiBhbmQgY21wDQphdCB0aGUgZW5kIG9mIHRoZSBsb29wLg0KSWYgeW91IHVzZSBu
ZWdhdGl2ZSBvZmZzZXRzIGZyb20gdGhlIGVuZCBvZiB0aGUgYnVmZmVyDQp0aGUgbG9vcCBjYW4g
YmUgYSBzaW5nbGUgYWRkIGFuZCBqbnouDQoNCglEYXZpZA0KDQo+ICsJfQ0KPiArDQo+ICsJd2hp
bGUgKGxlbmd0aC0tKSB7DQo+ICsJCWlmICgqc3JjID09IGQpDQo+ICsJCQlyZXR1cm4gKHZvaWQg
KilzcmM7DQo+ICsJCXNyYysrOw0KPiArCX0NCj4gKwlyZXR1cm4gTlVMTDsNCj4gK30NCj4gK0VY
UE9SVF9TWU1CT0wobWVtY2hyKTsNCj4gKyNlbmRpZg0KPiAtLQ0KPiAyLjI1LjENCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

