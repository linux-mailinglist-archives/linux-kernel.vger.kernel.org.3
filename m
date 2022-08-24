Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9087A59F4DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiHXIRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiHXIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:17:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777DD7FF89
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:16:59 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-99-VjYIZqc7OMC0qgo4WoO8vA-1; Wed, 24 Aug 2022 09:16:56 +0100
X-MC-Unique: VjYIZqc7OMC0qgo4WoO8vA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Wed, 24 Aug 2022 09:16:54 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Wed, 24 Aug 2022 09:16:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Baoquan He <bhe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Thread-Topic: [PATCH v2 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Thread-Index: AQHYtCxluEXLt15y9kSkQpSsai/RVK26d60AgAEsPgCAAFTlgIAApOwAgAADPgCAARm6UA==
Date:   Wed, 24 Aug 2022 08:16:54 +0000
Message-ID: <b193efbff3a74343839c3dee1702f73c@AcuMS.aculab.com>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-2-bhe@redhat.com>
 <d5272f42-f3e3-b2a8-428e-bd7815cf7518@csgroup.eu>
 <YwQdRg/IS0+3tbNu@MiWiFi-R3L-srv>
 <a4a9ba6f-9891-cc4c-e512-d221141d998f@csgroup.eu>
 <YwTu1kzcIUxsTL4j@MiWiFi-R3L-srv>
 <429cb367-923f-bb3d-ccf0-57dce0c7f35b@csgroup.eu>
In-Reply-To: <429cb367-923f-bb3d-ccf0-57dce0c7f35b@csgroup.eu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAyMyBBdWd1c3QgMjAyMiAxNjoyNg0KPiAN
Cj4gTGUgMjMvMDgvMjAyMiDDoCAxNzoxNCwgQmFvcXVhbiBIZSBhIMOpY3JpdMKgOg0KPiA+IE9u
IDA4LzIzLzIyIGF0IDA1OjI0YW0sIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+ID4+DQo+ID4+
DQo+ID4+IExlIDIzLzA4LzIwMjIgw6AgMDI6MjAsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4g
Pj4+IE9uIDA4LzIyLzIyIGF0IDA2OjI1YW0sIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+ID4+
Pj4NCj4gPj4+Pg0KPiA+Pj4+IExlIDIwLzA4LzIwMjIgw6AgMDI6MzEsIEJhb3F1YW4gSGUgYSDD
qWNyaXTCoDoNCj4gPj4+Pj4gSW4gc29tZSBhcmNoaXRlY3R1cmVzLCB0aGVyZSBhcmUgQVJDSCBz
cGVjaWZpY2kgaW8gYWRkcmVzcyBtYXBwaW5nDQo+ID4+Pj4+IGhhbmRsaW5nIHdoZW4gY2FsbGlu
ZyBpb3JlbWFwKCkgb3IgaW9yZW1hcF9wcm90KCksIGUuZywgYXJjLCBpYTY0LA0KPiA+Pj4+PiBv
cGVucmlzYywgczM5MCwgc2guDQo+ID4+Pj4+DQo+ID4+Pj4+IEluIG9kZXIgdG8gY29udmVydCB0
aGVtIHRvIHRha2UgR0VORVJJQ19JT1JFTUFQIG1ldGhvZCwgd2UgbmVlZCBjaGFuZ2UNCj4gPj4+
Pj4gdGhlIHJldHVybiB2YWx1ZSBvZiBob29rIGlvcmVtYXBfYWxsb3dlZCgpIGFuZCBpb3VubWFw
X2FsbG93ZWQoKS4NCj4gPj4+Pj4gTWVhbndoaWxlLCByZW5hbWUgdGhlbSB0byBhcmNoX2lvcmVt
YXAoKSBhbmQgYXJjaF9pb3VubWFwKCkgdG8gcmVmbGVjdA0KPiA+Pj4+PiB0aGVpciBjdXJyZW50
IGJlaGF2aW91ci4NCj4gPj4+DQo+ID4+PiBUaGFua3MgZm9yIHJldmlld2luZy4NCj4gPj4+DQo+
ID4+Pj4NCj4gPj4+PiBQbGVhc2UgZG9uJ3QganVzdCBzYXkgeW91IG5lZWQgdG8gY2hhbmdlIHRo
ZSByZXR1cm4gdmFsdWUuIEV4cGxhaW4gd2h5Lg0KPiA+Pj4NCj4gPj4+IFRoZSAxc3QgcGFyYWdy
YXBoIGFuZCB0aGUgc2VudGVuY2UgJ0luIG9kZXIgdG8gY29udmVydCB0aGVtIHRvIHRha2UNCj4g
Pj4+IEdFTkVSSUNfSU9SRU1BUCBtZXRob2QnIHRlbGwgdGhlIHJlYXNvbiwgbm8/DQo+ID4+DQo+
ID4+IFdoYXQgSSB3b3VsZCBsaWtlIHRvIHJlYWQgaXMgX3doeV8geW91IG5lZWQgdG8gY2hhbmdl
IHRoZSByZXR1cm4gdmFsdWUNCj4gPj4gaW4gb3JkZXIgdG8gY29udmVydCB0byBHRU5FUklDX0lP
UkVNQVANCj4gPg0KPiA+IEkgcmVwaHJhc2UgdGhlIGxvZyBhcyBiZWxvdywgaXQncyBPSyB0byB5
b3U/IE9yIHBsZWFzZSBoZWxwIGNoZWNrIGFuZA0KPiA+IHRlbGwgd2hhdCBJIG5lZWQgdG8gaW1w
cm92ZSB0byBiZXR0ZXIgZXhwbGFpbiB0aGUgcmVhc29uLg0KPiA+DQo+ID4gPT09PQ0KPiA+IFRo
ZSBjdXJyZW50IGlvW3JlfHVuXW1hcF9hbGxvd2VkKCkgaG9va3MgYXJlIHVzZWQgdG8gY2hlY2sg
aWYgdGhlDQo+ID4gaW9bcmV8dW5dbWFwKCkgYWN0aW9ucyBhcmUgcXVhbGlmaWVkIHRvIHByb2Nl
ZWQgd2hlbiB0YWtpbmcNCj4gPiBHRU5FUklDX0lPUkVNQVAgd2F5IHRvIGRvIGlvcmVtYXAoKS9p
b3VubWFwKCkuIE90aGVyd2lzZSBpb1tyZXx1bl1tYXAoKQ0KPiA+IHdpbGwgcmV0dXJuIE5VTEwu
DQo+ID4NCj4gPiBPbiBzb21lIGFyY2hpdGVjdHVyZXMgbGlrZSBhcmMsIGlhNjQsIG9wZW5yaXMs
IHMzOTAsIHNoLCB0aGVyZSBhcmUNCj4gPiBBUkNIIHNwZWNpZmljIGlvIGFkZHJlc3MgbWFwcGlu
ZyB0byB0cmFuc2xhdGUgdGhlIHBhc3NlZCBpbiBwaHlzaWNhbA0KPiA+IGFkZHJlc3MgdG8gaW8g
YWRkcmVzcyB3aGVuIGNhbGxpbmcgaW9yZW1hcCgpLiBJbiBvcmRlciB0byBjb252ZXJ0DQo+ID4g
dGhlc2UgYXJjaGl0ZWN0dXJlcyB0byB0YWtlIEdFTkVSSUNfSU9SRU1BUCB3YXkgdG8gaW9yZW1h
cCgpLCB3ZSBuZWVkDQo+ID4gY2hhbmdlIHRoZSByZXR1cm4gdmFsdWUgb2YgaG9vayBpb3JlbWFw
X2FsbG93ZWQoKSBhbmQgaW91bm1hcF9hbGxvd2VkKCkuDQo+ID4gV2l0aCB0aGUgY2hhbmdlLCB3
ZSBjYW4gbW92ZSB0aGUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGlvIGFkZHJlc3MNCj4gPiBtYXBw
aW5nIGludG8gaW9yZW1hcF9hbGxvd2VkKCkgaG9vaywgYW5kIGdpdmUgdGhlIG1hcHBlZCBpbyBh
ZGRyZXNzDQo+ID4gb3V0IHRvIGxldCBpb3JlbWFwX3Byb3QoKSByZXR1cm4gaXQuIFdoaWxlIGF0
IGl0LCByZW5hbWUgdGhlIGhvb2tzIHRvDQo+ID4gYXJjaF9pb3JlbWFwKCkgYW5kIGFyY2hfaW91
bm1hcCgpIHRvIHJlZmxlY3QgdGhlaXIgbmV3IGJlaGF2aW91ci4NCj4gPiA9PT09DQo+ID4NCj4g
DQo+IFRoYXQgbG9va3MgbW9yZSBpbiBsaW5lIHdpdGggdGhlIHR5cGUgb2YgZXhwbGFuYXRpb24g
SSBmb3Jlc2VlIGluIHRoZQ0KPiBjb21taXQgbWVzc2FnZSwgdGhhbmtzLg0KDQpJIHRoaW5rIHlv
dSBhbHNvIG5lZWQgdG8gc3VtbWFyaXNlIHRoZSBjaGFuZ2UgaXRzZWxmLg0KSWYgdGhlIHN1Y2Nl
c3MvZmFpbCByZXR1cm4gYWN0dWFsbHkgY2hhbmdlcyB0aGVuIHlvdSByZWFsbHkNCm5lZWQgdG8g
Y2hhbmdlIHNvbWV0aGluZyBzbyB0aGUgY29tcGlsZXIgZXJyb3JzIHVuY2hhbmdlZCBjb2RlLg0K
T3RoZXJ3aXNlIGl0IGlzIGEgY29tcGxldGUgcmVjaXBlIGZvciBkaXNhc3Rlci4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

