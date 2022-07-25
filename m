Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA30957FA53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiGYHgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiGYHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:36:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32D0562E2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:36:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-69-oYIuq9NKNZ2oDYXkhJf3Sw-1; Mon, 25 Jul 2022 08:35:58 +0100
X-MC-Unique: oYIuq9NKNZ2oDYXkhJf3Sw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 25 Jul 2022 08:35:55 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 25 Jul 2022 08:35:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Luck, Tony'" <tony.luck@intel.com>
CC:     "Sun, Yi" <yi.sun@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Su, Heng" <heng.su@intel.com>
Subject: RE: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Thread-Topic: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Thread-Index: AQHYnm+ODXPdzib5uU6pj7yBjiIw9q2OAAFwgAAUpoCAAJ8nQA==
Date:   Mon, 25 Jul 2022 07:35:55 +0000
Message-ID: <70ec475d45644c18b782d8bbe6a4e921@AcuMS.aculab.com>
References: <921078bc2a994d3ab6aba26d4654cb47@AcuMS.aculab.com>
 <75084D4E-80AC-4FE7-8CDD-2BFD30D23695@intel.com>
In-Reply-To: <75084D4E-80AC-4FE7-8CDD-2BFD30D23695@intel.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTHVjaywgVG9ueQ0KPiBTZW50OiAyNSBKdWx5IDIwMjIgMDA6MDANCj4gDQo+IFJEVFND
IGhhcyByZXR1cm5lZCB2YWx1ZXMgaW52YXJpYW50IG9mIGN1cnJlbnQgZnJlcXVlbmN5IHNpbmNl
IE5laGFsZW0gKG1vZHVsbyBhIGZldyBoaWNjb3VnaHMpLiBTbw0KPiBhbnkgQ1BVIHdpdGggWFNB
VkUvWFJFU1RPUiBzaG91bGQgYmUgc2FmZSB0byBtZWFzdXJlIHVzaW5nIFRTQy4NCg0KSW5kZWVk
IC0gdGhhdCBpdCBleGFjdGx5IHdoeSB5b3UgY2FuJ3QgdXNlIHRoZSBUU0MgdG8gbWVhc3VyZQ0K
aW5zdHJ1Y3Rpb24gbGF0ZW5jeSBhbnkgbW9yZS4NCllvdSBuZWVkIHRvIG1lYXN1cmUgbGF0ZW5j
eSBpbiBjbG9ja3MsIG5vdCB0aW1lLg0KDQpPbiBjcHUgd2hlcmUgYWxsIHRoZSBjb3JlcyBydW4g
YXQgdGhlIHNhbWUgZnJlcXVlbmN5IHlvdSBjYW4NCnNlZSB0aGUgZWZmZWN0IGJ5IHNwaW5uaW5n
IG9uZSBjb3JlIGluIHVzZXJzcGFjZS4NClJ1bm5pbmcgJ3doaWxlIDo7IGRvIDo7IGRvbmUnIGZy
b20gYSBzaGVsbCBwcm9tcHQgaXMgcHJldHR5DQplZmZlY3RpdmUgYXQgc3Bpbm5pbmcgaW4gdXNl
cnNwYWNlLg0KDQoJRGF2aWQNCg0KPiANCj4gU2VudCBmcm9tIG15IGlQaG9uZQ0KPiANCj4gPiBP
biBKdWwgMjQsIDIwMjIsIGF0IDE0OjE2LCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBhY3Vs
YWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IO+7v0Zyb206IFlpIFN1bg0KPiA+PiBTZW50OiAyMyBK
dWx5IDIwMjIgMDk6MzgNCj4gPj4NCj4gPj4gQ2FsY3VsYXRlIHRoZSBsYXRlbmN5IG9mIGluc3Ry
dWN0aW9ucyB4c2F2ZSBhbmQgeHJzdG9yIHdpdGggbmV3IHRyYWNlDQo+ID4+IHBvaW50cyB4ODZf
ZnB1X2xhdGVuY3lfeHNhdmUgYW5kIHg4Nl9mcHVfbGF0ZW5jeV94cnN0b3IuDQo+ID4+DQo+ID4+
IFRoZSBkZWx0YSBUU0MgY2FuIGJlIGNhbGN1bGF0ZWQgd2l0aGluIGEgc2luZ2xlIHRyYWNlIGV2
ZW50LiBBbm90aGVyDQo+ID4+IG9wdGlvbiBjb25zaWRlcmVkIHdhcyB0byBoYXZlIDIgc2VwYXJh
dGVkIHRyYWNlIGV2ZW50cyBtYXJraW5nIHRoZQ0KPiA+PiBzdGFydCBhbmQgZmluaXNoIG9mIHRo
ZSB4c2F2ZS94cnN0b3IgaW5zdHJ1Y3Rpb25zLiBUaGUgZGVsdGEgVFNDIHdhcw0KPiA+PiBjYWxj
dWxhdGVkIGZyb20gdGhlIDIgdHJhY2UgcG9pbnRzIGluIHVzZXIgc3BhY2UsIGJ1dCB0aGVyZSB3
YXMNCj4gPj4gc2lnbmlmaWNhbnQgb3ZlcmhlYWQgYWRkZWQgYnkgdGhlIHRyYWNlIGZ1bmN0aW9u
IGl0c2VsZi4NCj4gPj4NCj4gPj4gSW4gaW50ZXJuYWwgdGVzdGluZywgdGhlIHNpbmdsZSB0cmFj
ZSBwb2ludCBvcHRpb24gd2hpY2ggaXMNCj4gPj4gaW1wbGVtZW50ZWQgaGVyZSBwcm92ZWQgdG8g
YmUgbW9yZSBhY2N1cmF0ZS4NCj4gPiAuLi4NCj4gPg0KPiA+IEkndmUgZG9uZSBzb21lIGV4cGVy
aW1lbnRzIHRoYXQgbWVhc3VyZSBzaG9ydCBpbnN0cnVjdGlvbiBsYXRlbmNpZXMuDQo+ID4gQmFz
aWNhbGx5IEkgZm91bmQ6DQo+ID4gMSkgWW91IG5lZWQgYSBzdWl0YWJsZSBzZXJpYWxpc2luZyBp
bnN0cnVjdGlvbiBiZWZvcmUgYW5kIGFmdGVyDQo+ID4gICB0aGUgY29kZSBiZWluZyB0ZXN0ZWQg
LSBvdGhlcndpc2UgaXQgY2FuIG92ZXJsYXAgd2hhdGV2ZXINCj4gPiAgIHlvdSBhcmUgdXNpbmcg
Zm9yIHRpbWluZy4NCj4gPiAyKSBUaGUgb25seSByZWxpYWJsZSBjb3VudGVyIGlzIHRoZSBwZXJm
b3JtYW5jZSBtb25pdG9yIGNsb2NrDQo+ID4gICBjb3VudGVyIC0gZXZlcnl0aGluZyBlbHNlIGRl
cGVuZHMgb24gdGhlIGN1cnJlbnQgY3B1IGZyZXF1ZW5jeS4NCj4gPiAgIE9uIGludGVsIGNwdSB0
aGUgY3B1IGZyZXF1ZW5jeSBjYW4gY2hhbmdlIGFsbCB0aGUgdGltZS4NCj4gPiBBbGxvd2luZyBm
b3IgdGhhdCwgYW5kIHRoZW4gaWdub3JpbmcgY29tcGxldGUgb3V0bGllcnMsIEkgY291bGQNCj4g
PiBnZXQgY2xvY2stY291bnQgYWNjdXJhdGUgdmFsdWVzIGZvciBpdGVyYXRpb25zIG9mIHRoZSBJ
UCBjc3VtIGxvb3AuDQo+ID4NCj4gPiAgICBEYXZpZA0KPiA+DQo+ID4gLQ0KPiA+IFJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KPiA+IFJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo+
ID4NCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

