Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7F24F5ECA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiDFNDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiDFNCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:02:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B14725BED21
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:27:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-eHuEyMOaOeqDmfbYcncWLQ-1; Wed, 06 Apr 2022 10:23:40 +0100
X-MC-Unique: eHuEyMOaOeqDmfbYcncWLQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 6 Apr 2022 10:23:38 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 6 Apr 2022 10:23:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/11] treewide: Fix a bunch of shift overflows
Thread-Topic: [PATCH 00/11] treewide: Fix a bunch of shift overflows
Thread-Index: AQHYSUP0CefNvAXd5kC8AbgGV9iuxqzim78A
Date:   Wed, 6 Apr 2022 09:23:38 +0000
Message-ID: <4d8265050e2446e295ac60e5c0e4bcee@AcuMS.aculab.com>
References: <20220405151517.29753-1-bp@alien8.de>
In-Reply-To: <20220405151517.29753-1-bp@alien8.de>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDA1IEFwcmlsIDIwMjIgMTY6MTUNCi4uLg0K
PiBEdWUgdG8gc29tZSByZWNlbnQgY2hhbmdlcyB3aGljaCBhZGRlZCAtZnNhbml0aXplLXNoaWZ0
IHRvIHRoZSBidWlsZA0KPiBvcHRpb25zIG9mIGFuIGFsbG1vZGNvbmZpZywgaXQgc3RhcnRlZCBm
YWlsaW5nIGhlcmUgd2l0aCBhbiBvbGQgZ2NjDQo+IGJlY2F1c2UgZ2V0dGluZyBhbiBvdmVyZmxv
dyB3aGlsZSBzaGlmdGluZyBpcyB1bmRlZmluZWQgQzk5IGJlaGF2aW9yLg0KDQpBbm5veWluZ2x5
IGl0IGlzIGV4dHJlbWVseSB1bmxpa2VseSB0aGF0IGEgMnMgY29tcGxpbWVudA0Kc3lzdGVtIHdv
dWxkIGV2ZXIgZ2VuZXJhdGUgYW55dGhpbmcgb3RoZXIgdGhhbiB0aGUgZXhwZWN0ZWQNCnZhbHVl
IC0gaWUgdGhlIHZhbHVlIG9idGFpbmVkIGJ5IGRvaW5nIHRoZSBjYWxjdWxhdGlvbg0Kd2l0aCB1
bnNpZ25lZCB2YWx1ZXMgYW5kIHRoZW4gZ2V0dGluZyB0aGUgcmVzdWx0IGNhc3QgYmFjaw0KdG8g
c2lnbmVkICh3aGljaCBpcyBJSVJDIGltcGxlbWVudGF0aW9uIGRlZmluZWQpLg0KDQpJdCBpc24n
dCBhcyB0aG91Z2ggdGhlcmUgYXJlIG1hbnkgMXMgY29tcGxpbWVudCBzeXN0ZW1zIG91dA0KdGhl
cmUsIGFuZCBwcm9iYWJseSBldmVuIGZld2VyICdzaWduIG92ZXJwdW5jaCcgb25lcy4NCk5ldmVy
IG1pbmQgdHJ5aW5nIHRvIGZpbmQgYSB3b3JraW5nIEMgY29tcGlsZXIgZm9yIHRoZW0uDQoNCldo
YXQgc29ydCBvZiBjcmFjayBhcmUgdGhlIEMgc3RhbmRhcmRzIGJvZHkgYW5kIGNvbXBpbGVyDQpw
ZW9wbGUgYWN0dWFsbHkgc21va2luZz8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

