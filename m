Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2B557FC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiGYJgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiGYJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:36:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 760A29FF3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:36:40 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-172-GO85KoGYOjODgFAl2lFN8g-1; Mon, 25 Jul 2022 10:36:37 +0100
X-MC-Unique: GO85KoGYOjODgFAl2lFN8g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 25 Jul 2022 10:36:34 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 25 Jul 2022 10:36:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        Borislav Petkov <bp@suse.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Will Deacon <will@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Subject: RE: [PATCH v3] random: handle archrandom with multiple longs
Thread-Topic: [PATCH v3] random: handle archrandom with multiple longs
Thread-Index: AQHYoAilymPUWo/DTE6/vTfbMGZrFK2O06Jg
Date:   Mon, 25 Jul 2022 09:36:34 +0000
Message-ID: <10561a841a7342c882aabb0fbdbfc762@AcuMS.aculab.com>
References: <CAHmME9qTA90=GEr6h1GZh0CjS+6tpe5uuqkYoJVv79h0zd0w1w@mail.gmail.com>
 <20220719130207.147536-1-Jason@zx2c4.com> <Yt5gBZe9F1BE0MVF@zn.tnic>
 <Yt5hwxC1xgvA8Asw@zx2c4.com>
In-Reply-To: <Yt5hwxC1xgvA8Asw@zx2c4.com>
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

Li4uDQo+IE1vcmUgZGlyZWN0bHksIHRoZSByZWFzb24gd2UgZG9uJ3Qgd2FudCB0byBlcnJvciBp
cyBiZWNhdXNlIHRoZSB1c2UgY2FzZQ0KPiBoYXMgZmFsbGJhY2tzIG1lYW50IHRvIGhhbmRsZSBl
cnJvcnMuIFRoZSBjYXNjYWRlIGxvb2tzIGxpa2UgdGhpcw0KPiAocXVvdGluZyBmcm9tIHRoZSBv
dGhlciBlbWFpbCk6DQo+IA0KPiAgICAgdW5zaWduZWQgbG9uZyBhcnJheVt3aGF0ZXZlcl07DQo+
ICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShhcnJheSk7KSB7DQo+ICAgICAgICAgbG9u
Z3MgPSBhcmNoX2dldF9yYW5kb21fc2VlZF9sb25ncygmYXJyYXlbaV0sIEFSUkFZX1NJWkUoYXJy
YXkpIC0gaSk7DQo+ICAgICAgICAgaWYgKGxvbmdzKSB7DQo+ICAgICAgICAgICAgIGkgKz0gbG9u
Z3M7DQo+ICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAgICAgICAgIH0NCj4gICAgICAgICBsb25n
cyA9IGFyY2hfZ2V0X3JhbmRvbV9sb25ncygmYXJyYXlbaV0sIEFSUkFZX1NJWkUoYXJyYXkpIC0g
aSk7DQo+ICAgICAgICAgaWYgKGxvbmdzKSB7DQo+ICAgICAgICAgICAgIGkgKz0gbG9uZ3M7DQo+
ICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAgICAgICAgIH0NCj4gICAgICAgICBhcnJheVtpKytd
ID0gcmFuZG9tX2dldF9lbnRyb3B5KCk7DQo+ICAgICB9DQo+IA0KPiBJdCB0cmllcyB0byBnZXQg
dGhlIGJlc3QgdGhhdCBpdCBjYW4gYXMgbXVjaCBhcyBpdCBjYW4sIGJ1dCBpc24ndCBnb2luZw0K
PiB0byBibG9jayBvciBkbyBhbnl0aGluZyB0b28gbnV0cyBmb3IgdGhhdC4NCg0KRG8geW91IHJl
YWxseSB3YW50IHRvIHJldHJ5IHRoZSBlYXJsaWVyIGNhbGxzIHRoYXQgcmV0dXJuZWQgbm8gZGF0
YT8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

