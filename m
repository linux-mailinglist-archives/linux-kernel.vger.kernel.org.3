Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC45580E16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbiGZHls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiGZHla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:41:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34F7A25E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:41:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-117-Nb8URzkWP6GuxQBT3N9TeA-1; Tue, 26 Jul 2022 08:41:04 +0100
X-MC-Unique: Nb8URzkWP6GuxQBT3N9TeA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 26 Jul 2022 08:41:03 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 26 Jul 2022 08:41:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>, 'Yi Sun' <yi.sun@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "heng.su@intel.com" <heng.su@intel.com>
Subject: RE: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Thread-Topic: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Thread-Index: AQHYnm+ODXPdzib5uU6pj7yBjiIw9q2OAAFwgAFOtoCAAPilIA==
Date:   Tue, 26 Jul 2022 07:41:03 +0000
Message-ID: <d1e21252869c4132a4527ac61a7d0819@AcuMS.aculab.com>
References: <20220723083800.824442-1-yi.sun@intel.com>
 <20220723083800.824442-2-yi.sun@intel.com>
 <921078bc2a994d3ab6aba26d4654cb47@AcuMS.aculab.com>
 <f2a0e0e0-79f2-1b5c-2bcd-b6037d479d4e@intel.com>
In-Reply-To: <f2a0e0e0-79f2-1b5c-2bcd-b6037d479d4e@intel.com>
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

RnJvbTogRGF2ZSBIYW5zZW4NCj4gU2VudDogMjUgSnVseSAyMDIyIDE4OjQ0DQo+IA0KPiBPbiA3
LzI0LzIyIDEzOjU0LCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gSSd2ZSBkb25lIHNvbWUgZXhw
ZXJpbWVudHMgdGhhdCBtZWFzdXJlIHNob3J0IGluc3RydWN0aW9uIGxhdGVuY2llcy4NCj4gPiBC
YXNpY2FsbHkgSSBmb3VuZDoNCj4gDQo+IFNob3J0PyAgVGhlIGluc3RydWN0aW9ucyBpbiBxdWVz
dGlvbiBjYW4gd3JpdGUgdXAgdG8gYWJvdXQgMTJrIG9mIGRhdGEuDQo+ICBUaGF0J3Mgbm90ICJz
aG9ydCIgYnkgYW55IG1lYW5zLg0KPiANCj4gSSdtIGFsc28gbm90IHN1cmUgcHJlY2lzaW9uIGhl
cmUgaXMgYWxsIHRoYXQgaW1wb3J0YW50LiAgVGhlIG1haW4gdGhpbmdzDQo+IHdlIHdhbnQgdG8g
a25vdyBoZXJlIHdoZW4gYW5kIHdoZXJlIHRoZSBpbml0IGFuZCBtb2RpZmllZCBvcHRpbWl6YXRp
b25zDQo+IGFyZSBjb21pbmcgaW50byBwbGF5LiAgSW4gb3RoZXIgd29yZHMsIGhvdyBvZnRlbiBp
cyB0aGVyZSBhY3R1YWwgZGF0YQ0KPiB0aGF0ICpuZWVkcyogdG8gYmUgc2F2ZWQgYW5kIHJlc3Rv
cmVkIGFuZCBjYW4ndCBiZSBvcHRpbWl6ZWQgYXdheS4NCj4gDQo+IFNvLCBzdXJlLCBpZiB3ZSB3
ZXJlIG1lYXN1cmluZyBhIGRvemVuIGN5Y2xlcyBoZXJlLCB5b3UgY291bGQgbWFrZSBhbg0KPiBh
cmd1bWVudCB0aGF0IHRoaXMgX21pZ2h0XyBiZSBwcm9ibGVtYXRpYy4NCj4gDQo+IEJ1dCwgaW4g
dGhpcyBjYXNlLCB3ZSByZWFsbHkganVzdCB3YW50IHRvIGJlIGFibGUgdG8gdGVsbCB3aGVuDQo+
IFhTQVZFL1hSU1RPUiBhcmUgZ2V0dGluZyBtb3JlIG9yIGxlc3MgZXhwZW5zaXZlIGFuZCBhbHNv
IGdldCBvdXQgYQ0KPiBtaW5pbWFsIGFtb3VudCBvZiBkYXRhIChSRkJNL1hJTlVTRSkgdG8gbWFr
ZSBhIGd1ZXNzIHdoeSB0aGF0IG1pZ2h0IGJlLg0KPiANCj4gSXMgaXQgKlJFQUxMWSogd29ydGgg
dGhyb3dpbmcgc2VyaWFsaXppbmcgaW5zdHJ1Y3Rpb25zIGluIGFuZCBtb3ZpbmcNCj4gY2xvY2sg
c291cmNlcyB0byBkbyB0aGF0PyAgSXMgdGhlIGFkZGVkIHByZWNpc2lvbiB3b3J0aCBpdD8NCg0K
SSBzdXNwZWN0IHRoYXQgaWYgeW91IHJ1biB5b3VyIHRlc3QgaW4gYSBsb29wIHRoZSBjcHUgd2ls
bA0KYmUgcnVubmluZyBhdCA4MDBNSHogZm9yIHRoZSBmaXJzdCBpdGVyYXRpb24gYnV0IHdpbGwg
c29vbg0KYmUgcnVubmluZyBhdCAzR0h6Lg0KVGhhdCBpcyBhIDQtZm9sZCBjaGFuZ2UgaW4gZXhl
Y3V0aW9uIHRpbWUgaWYgeW91IHVzZSB0aGUgVFNDLg0KDQpJSVJDIFJEVFNDIGlzIGEgc2VyaWFs
aXNpbmcgaW5zdHJ1Y3Rpb24gKG9mIHNvbWUgZm9ybSksIFhTQVZFDQphbmQgWFJTVE9SIG1heSBh
bHNvIGJlIC0gc28geW91IHByb2JhYmx5IGFyZSB3YWl0aW5nIGZvciB0aGUNCmluc3RydWN0aW9u
IHRvIGZpbmlzaC4NCkJ1dCB5b3UgZG8gYWN0dWFsbHkgbmVlZCB0byBlbnN1cmUgdGhhdCBpcyBo
YXBwZW5pbmcuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

