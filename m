Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E964B839F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiBPJEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:04:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiBPJEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:04:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B375C2AD675
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:04:40 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-195-EET2GjE8Oq-6f4xc2vJeNw-1; Wed, 16 Feb 2022 09:04:37 +0000
X-MC-Unique: EET2GjE8Oq-6f4xc2vJeNw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 16 Feb 2022 09:04:35 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 16 Feb 2022 09:04:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jue Wang' <juew@google.com>, Tony Luck <tony.luck@intel.com>,
        "Borislav Petkov" <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] x86/mce: work around an erratum on fast string copy
 instructions.
Thread-Topic: [PATCH] x86/mce: work around an erratum on fast string copy
 instructions.
Thread-Index: AQHYIvoCSX/7pRzFAkuhPX3tNobqJqyV4VTQ
Date:   Wed, 16 Feb 2022 09:04:35 +0000
Message-ID: <3288f39e32f04d67a875775414dd1c14@AcuMS.aculab.com>
References: <CAPcxDJ6bDctjErv4ggtBiJsmPJb2e-3ng12f+hMuJ7SLN-SXOg@mail.gmail.com>
 <20220216055629.1542654-1-juew@google.com>
In-Reply-To: <20220216055629.1542654-1-juew@google.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSnVlIFdhbmcNCj4gU2VudDogMTYgRmVicnVhcnkgMjAyMiAwNTo1Ng0KPiANCj4gVGhl
IGZhc3Qgc3RyaW5nIGNvcHkgaW5zdHJ1Y3Rpb25zICgiUkVQOyBNT1ZTKiIpIGNvdWxkIGNvbnN1
bWUgYW4NCj4gdW5jb3JyZWN0YWJsZSBtZW1vcnkgZXJyb3IgaW4gdGhlIGNhY2hlIGxpbmUgX3Jp
Z2h0IGFmdGVyXyB0aGUNCj4gZGVzaXJlZCByZWdpb24gdG8gY29weSBhbmQgcmFpc2UgYW4gTUNF
Lg0KDQpzL2NvbnN1bWUvdHJhcCBkdWUgdG8vDQoNCklzbid0IHRoaXMganVzdCBwdXR0aW5nIG9m
ZiB0aGUgaW5ldml0YWJsZSBwYW5pYyB3aGVuIHRoZQ0KZm9sbG93aW5nIGNhY2hlIGxpbmUgaXMg
YWNjZXNzZXMgZm9yIHJlYWw/DQoNCk9yIGlzIHRoaXMgYWxsIGR1ZSB0byB0aGF0IHBzZXVkbyBk
eW5hbWljIG1lbW9yeSAoeHBvaW50PykgdGhhdCBpcw0KYnl0ZSBhZGRyZXNzYWJsZSBidXQgb25s
eSByZWFsbHkgaGFzIHRoZSBxdWFsaXR5IG9mIGEgZGlhaz8NCkl0IHdoaWNoIGNhc2UgSSB0aG91
Z2h0IGl0IHdhc24ndCBhY3R1YWxseSB1c2FibGUgZm9yDQpub3JtYWwgbWVtb3J5IGFueXdheSAt
IHNvIHRoZSBjb3BpZXMgYXJlIGFsbCBvbmVzIHdoaWNoIGNhbiBmYXVsdC4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

