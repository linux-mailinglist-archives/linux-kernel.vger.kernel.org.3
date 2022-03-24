Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D44E6AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355560AbiCXWzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiCXWzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:55:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F02416F4AF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:54:08 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-231-THU0TZx9N2OyJfewrvht5w-1; Thu, 24 Mar 2022 22:54:05 +0000
X-MC-Unique: THU0TZx9N2OyJfewrvht5w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 24 Mar 2022 22:54:05 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 24 Mar 2022 22:54:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>
CC:     Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: RE: clang memcpy calls
Thread-Topic: clang memcpy calls
Thread-Index: AQHYP68jFJQQj1SZ3U2APgeueTpytqzPHokA
Date:   Thu, 24 Mar 2022 22:54:04 +0000
Message-ID: <7c95cb9c9255448bb74d1f1f694abffb@AcuMS.aculab.com>
References: <YjxTt3pFIcV3lt8I@zn.tnic>
 <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
In-Reply-To: <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
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

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAyNCBNYXJjaCAyMDIyIDE4OjQ0DQo+IA0K
PiBPbiBUaHUsIE1hciAyNCwgMjAyMiBhdCA0OjE5IEFNIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxp
ZW44LmRlPiB3cm90ZToNCj4gPg0KPiA+IEhpIGZvbGtzLA0KPiA+DQo+ID4gc28gSSd2ZSBiZWVu
IGxvb2tpbmcgYXQgYSByZWNlbnQgb2JqdG9vbCBub2luc3RyIHdhcm5pbmcgZnJvbSBjbGFuZw0K
PiA+IGJ1aWxkczoNCj4gPg0KPiA+IHZtbGludXgubzogd2FybmluZzogb2JqdG9vbDogc3luY19y
ZWdzKCkrMHgyMDogY2FsbCB0byBtZW1jcHkoKSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9u
DQo+ID4NCj4gPiBUaGUgaXNzdWUgaXMgdGhhdCBjbGFuZyBnZW5lcmF0ZXMgYSBtZW1jcHkoKSBj
YWxsIHdoZW4gYSBzdHJ1Y3QgY29weQ0KPiA+IGhhcHBlbnM6DQo+ID4NCj4gPiAgICAgICAgIGlm
IChyZWdzICE9IGVyZWdzKQ0KPiA+ICAgICAgICAgICAgICAgICAqcmVncyA9ICplcmVnczsNCj4g
DQo+IFNwZWNpZmljYWxseSwgdGhpcyBpcyBjb3B5aW5nIG9uZSBzdHJ1Y3QgcHRfcmVncyB0byBh
bm90aGVyLiBJdCBsb29rcw0KPiBsaWtlIHRoZSBzaXplb2Ygc3RydWN0IHB0X3JlZ3MgaXMganVz
dCBsYXJnZSBlbm91Z2ggdG8gaGF2ZSBjbGFuZyBlbWl0DQo+IHRoZSBsaWJjYWxsLg0KPiBodHRw
czovL2dvZGJvbHQub3JnL3ovc2N4NmFhOGpxDQo+IE90aGVyd2lzZSBjbGFuZyB3aWxsIGFsc28g
dXNlIHJlcDsgbW92c3E7IHdoZW4gLW1uby1zc2UgLU8yIGlzIHNldCBhbmQNCj4gdGhlIHN0cnVj
dHMgYXJlIGJlbG93IEFSQklUUkFSWV9USFJFU0hPTEQuICBTaG91bGQgQVJCSVRSQVJZX1RIUkVT
SE9MRA0KPiBiZSByYWlzZWQgc28gdGhhdCB3ZSBjb250aW51ZSB0byBpbmxpbmUgdGhlIG1lbWNw
eT8gKnNocnVnKg0KDQpJJ3ZlIGp1c3QgbG9va2VkIGF0IHNvbWUgaW5zdHJ1Y3Rpb24gdGltaW5n
cy4NCkZvciAzMiBieXRlIGFsaWduZWQgY29waWVzIGl0IGFjdHVhbGx5IGxvb2tzIGxpa2UgJ3Jl
cCBtb3ZzJw0KKHByb2JhYmx5IG1vdnNxKSBpcyBhY3R1YWxseSByZWFzb25hYmxlIGZvciBsYXJn
ZSBidWZmZXJzDQpvbiBhbGwgbWFpbnN0cmVhbSBJbnRlbCBjcHUgc2luY2Ugc2FuZHkgYnJpZ2Uu
DQpPbiB0aGUgbW9yZSByZWNlbnQgb25lcyBpdCBydW5zIGF0IDMyIGJ5dGVzL2Nsb2NrLg0KSXQg
bWF5IG5vdCBiZSB0aGF0IGJhZCBmb3Igc2hvcnRlciBhbmQgbm9uIDMyIGJ5dGUgYWxpZ25lZA0K
YnVmZmVycyBhcyB3ZWxsLg0KDQpDZXJ0YWlubHkgSSBjYW4ndCBzZWUgYSByZWFzb24gZm9yIGNh
bGxpbmcgbWVtY3B5KCkgZm9yDQpsYXJnZSBjb3BpZXMhDQoNCkF0IGxlYXN0IG5vIG9uZSB1c2Vz
IFA0IGFueSBtb3JlLCBzZXR1cCBsYXRlbmN5IHdhcyBzb21ldGhpbmcNCmxpa2UgMTg2IGNsb2Nr
cyENCg0KSSB3YXMgdGhpbmtpbmcgdGhhdCAncmVwIG1vdnNxJyBvbmx5IG1hZGUgYW55IHNlbnNl
IHdpdGggLU9zLg0KQnV0IGl0IHNlZW1zIHRvIGJlIGJldHRlciB0aGFuIEkgdGhvdWdodC4NCihJ
IG1pZ2h0IGV2ZW4gaGF2ZSBtZWFzdXJlZCBpdCBydW5uaW5nICdmYXN0JyBvbiBJdnkgYnJpZGdl
LikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

