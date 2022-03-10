Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45A4D5017
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243991AbiCJRUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbiCJRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:20:49 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D33F518DABD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:19:47 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-220-GAll5PICOlaorzjpFG4RBw-1; Thu, 10 Mar 2022 17:19:42 +0000
X-MC-Unique: GAll5PICOlaorzjpFG4RBw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 10 Mar 2022 17:19:40 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 10 Mar 2022 17:19:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        'Bharata B Rao' <bharata@amd.com>,
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
Thread-Index: AQHYNHBEWuVw0etF4EmWwhK6DFJ++Ky4rWmQgAAmSACAAAWIEA==
Date:   Thu, 10 Mar 2022 17:19:40 +0000
Message-ID: <f6212ddf70bc408a80d7eb690c46bccc@AcuMS.aculab.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <699fb763ac054833bc8c29c9814c63b2@AcuMS.aculab.com>
 <286efdb9-7dbf-82f3-b172-29c575a3791b@intel.com>
In-Reply-To: <286efdb9-7dbf-82f3-b172-29c575a3791b@intel.com>
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

RnJvbTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU2VudDogMTAgTWFy
Y2ggMjAyMiAxNjo0Ng0KPiANCj4gT24gMy8xMC8yMiAwNjozMiwgRGF2aWQgTGFpZ2h0IHdyb3Rl
Og0KPiA+PiBVQUkgYWxsb3dzIHNvZnR3YXJlIHRvIHN0b3JlIGEgdGFnIGluIHRoZSB1cHBlciA3
IGJpdHMgb2YgYSBsb2dpY2FsDQo+ID4+IGFkZHJlc3MgWzYzOjU3XS4gV2hlbiBlbmFibGVkLCB0
aGUgcHJvY2Vzc29yIHdpbGwgc3VwcHJlc3MgdGhlDQo+ID4+IHRyYWRpdGlvbmFsIGNhbm9uaWNh
bCBhZGRyZXNzIGNoZWNrcyBvbiB0aGUgYWRkcmVzc2VzLiBNb3JlIGluZm9ybWF0aW9uDQo+ID4+
IGFib3V0IFVBSSBjYW4gYmUgZm91bmQgaW4gc2VjdGlvbiA1LjEwIG9mICdBTUQ2NCBBcmNoaXRl
Y3R1cmUNCj4gPj4gUHJvZ3JhbW1lcidzIE1hbnVhbCwgVm9sIDI6IFN5c3RlbSBQcm9ncmFtbWlu
Zycgd2hpY2ggaXMgYXZhaWxhYmxlIGZyb20NCj4gPj4NCj4gPj4gaHR0cHM6Ly9idWd6aWxsYS5r
ZXJuZWwub3JnL2F0dGFjaG1lbnQuY2dpP2lkPTMwMDU0OQ0KPiA+IElzIHRoYXQgcmVhbGx5IGFs
bG93aW5nIGJpdCA2MyB0byBiZSB1c2VkPw0KPiA+IFRoYXQgaXMgbm9ybWFsbHkgdGhlIHVzZXIt
a2VybmVsIGJpdC4NCj4gPiBJIGNhbid0IGhlbHAgZmVlbGluZyB0aGF0IHdpbGwganVzdCBiYWRs
eSBicmVhayB0aGluZ3MuDQo+IA0KPiBZZWFoLCB0aGlzIGRvZXMgc2VlbSB3b3JyaXNvbWUuICBU
aGUgTEFNIGFwcHJvYWNoWzFdIHJldGFpbnMNCj4gY2Fub25pY2FsaXR5IGNoZWNraW5nIGZvciBi
aXQgNjMuDQoNCkFjdHVhbGx5IGl0IGlzIHJhdGhlciB3b3JzZSB0aGFuICd3b3JyaXNvbWUnLg0K
QWxsb3dpbmcgdGhlIHVzZXIgYWxsIGFkZHJlc3MgdXB0byB0aGUgYmFzZSBvZiB0aGUgdmFsaWQN
Cmtlcm5lbCBhZGRyZXNzZXMgKHByb2JhYmx5IHRhZ3MgdG8gM2UsIGJ1dCBub3QgM2YpDQptZWFu
cyB0aGF0IHlvdSBjYW4ndCB1c2UgYSBmYXN0IGFkZHJlc3MgY2hlY2sgaW4gYWNjZXNzX29rKCku
DQpZb3UgYXJlIGZvcmNlZCB0byB1c2UgdGhlIHN0cmljdCB0ZXN0IHRoYXQgMzJiaXQga2VybmVs
cyB1c2UuDQoNCk90aGVyd2lzZSBmb3IgNjRiaXQgYWNjZXNzX29rKCkgbmVlZCBvbmx5IHRlc3Qg
YWRkcmVzcyA8IDANCmFuZCByZWx5IG9uIGtlcm5lbCBjb2RlIHJlYWRpbmcgc29tZXRoaW5nIGJl
bG93IHRoZSAoYmlnKQ0Kb2Zmc2V0IHRvIHZhbGlkIGtlcm5lbCBhZGRyZXNzZXMuDQpObyByZWFs
IG5lZWQgdG8gaW5jbHVkZSB0aGUgbGVuZ3RoIGF0IGFsbC4NCg0KSWYgdGhlIGhhcmR3YXJlIGlz
IGp1c3QgaWdub3JpbmcgdGhlIGhpZ2ggYWRkcmVzcyBiaXRzDQp0aGVuIHRoZSBzaG91bGQgYmUg
bm8gbmVlZCB0byBtYXNrIHRoZW0gaW4ga2VybmVsLg0KVGhlIHJlcXVpcmVkIGtlcm5lbCBhY2Nl
c3NlcyB0byB1c2VyIG1lbW9yeSBzaG91bGQgJ2p1c3Qgd29yaycuDQoNCk9mIGNvdXJzZSwgdGhl
IGJpdCB0byBlbmFibGUgdGhpcyAod2hlcmV2ZXIgaXQgaXMpIG5lZWRzDQp0byBiZSByZXN0b3Jl
ZCBvbiBldmVyeSBwcm9jZXNzIHN3aXRjaC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

