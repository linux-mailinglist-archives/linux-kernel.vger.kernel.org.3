Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A453AC6E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356066AbiFASDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiFASDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:03:36 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC8B9C2FA;
        Wed,  1 Jun 2022 11:03:33 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 3D5835FD02;
        Wed,  1 Jun 2022 21:03:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654106611;
        bh=jwjcenm4v2FpMajJm2PZiHzbOon/1npcFDzjh9aQFGw=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=peagLzJJcjcF6Y0YrnxtbTcgHnzW+TWcqUepE2DGYH+hlTNYEv1XK3Y2F09guziqn
         i81pPVjbKoCI5zbaxOk0h801khCye6yhF9JY5jY/TwkGUAbuD9iB7UNUZXWcG3x21Q
         31blWHmQn5WUoRtfneajaU9/eg/ekfJSTwWKyGGgpkRhuWA5ZcchxMdyFeis8i7cpE
         n3hqV+7A6hj5T4rsrXTPD8NyvV+v46vdh9UQjh+GXsy+DN7bIogacBjy8yY72pLAw8
         Q2nwcUwhDtIQkzdsfJd/4XpMSFpF5DZm3E/AjNRrrK1cFzcWcnx/Mf/JEjOnS90vKP
         r6S1LI2XsXLtQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed,  1 Jun 2022 21:03:30 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Topic: [PATCH v1] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Index: AQHYdRpaUrhZ5pf6gEC6S1oZ2DfDiK05JA2AgADoBACAAB2gAIAAK1eAgABSQAA=
Date:   Wed, 1 Jun 2022 18:03:15 +0000
Message-ID: <20220601180326.3b6v4joykv5dryzm@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220531181457.26034-1-ddrokosov@sberdevices.ru>
 <20220531185729.z6246gexteyo4xmd@CAB-WSD-L081021.sigma.sbrf.ru>
 <786db9cf74473caef10dcea79975716b5516f47e.camel@gmail.com>
 <20220601103356.xlimabcihaay5jky@CAB-WSD-L081021.sigma.sbrf.ru>
 <5b808f06ba7532bbfd9c2745420aedfa9464a297.camel@gmail.com>
In-Reply-To: <5b808f06ba7532bbfd9c2745420aedfa9464a297.camel@gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <62A8C0C629BF304C825EDE739B3E04CF@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/01 07:23:00 #19635587
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9uYXRoYW4sIE51bm8sDQoNCkkndmUgc2VudCBSRkMgcGF0Y2ggd2l0aCB0cmlnLT5vd25lciBw
b2ludGVyIGluaXRpYWxpemF0aW9uIG1vdmFsIGZyb20NCnJlZ2lzdGVyKCkgdG8gYWxsb2NhdGUo
KSBzdGFnZSBhcyBOdW5vIHN1Z2dlc3RlZCBiZWZvcmU6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWlpby8yMDIyMDYwMTE3NDgzNy4yMDI5Mi0xLWRkcm9rb3NvdkBzYmVyZGV2aWNl
cy5ydS8NCg0KUGxlYXNlIHJldmlldyBpZiBwb3NzaWJsZSBhbmQgc2hhcmUgeW91ciB0aG91Z2h0
cy4NCg0KT24gV2VkLCBKdW4gMDEsIDIwMjIgYXQgMDM6MDk6MDNQTSArMDIwMCwgTnVubyBTw6Eg
d3JvdGU6DQo+IE9uIFdlZCwgMjAyMi0wNi0wMSBhdCAxMDozMyArMDAwMCwgRG1pdHJ5IFJva29z
b3Ygd3JvdGU6DQo+ID4gSGkgTnVubywNCj4gPiANCj4gPiBUaGFuayB5b3UgZm9yIGNvbW1lbnRz
IQ0KPiA+IA0KPiA+IE9uIFdlZCwgSnVuIDAxLCAyMDIyIGF0IDEwOjQ3OjU0QU0gKzAyMDAsIE51
bm8gU8OhIHdyb3RlOg0KPiA+ID4gT24gVHVlLCAyMDIyLTA1LTMxIGF0IDE4OjU3ICswMDAwLCBE
bWl0cnkgUm9rb3NvdiB3cm90ZToNCj4gPiA+ID4gSGkgSm9uYXRoYW4sDQo+ID4gPiA+IA0KPiA+
ID4gPiBJIGhhdmUgb25lIHF1ZXN0aW9uIGFib3V0IGEgY2FzZXMgd2hlbiB0cmlnZ2VyIG93bmVy
IGlzIGJ1aWx0aW4NCj4gPiA+ID4gbW9kdWxlLg0KPiA+ID4gPiBJbiB0aGUgc3VjaCBjYXNlcyB0
cmlnLT5vd25lciA9PSBudWxsLCBiZWNhdXNlIFRISVNfTU9EVUxFIGVxdWFscw0KPiA+ID4gPiB0
bw0KPiA+ID4gPiBudWxsLiBIb3cgZG8geW91IHRoaW5rLCBzaG91bGQgd2UgdGFrZSBpbnRvIGFj
Y291bnQgc3VjaA0KPiA+ID4gPiBzaXR1YXRpb25zPw0KPiA+ID4gPiANCj4gPiA+ID4gSU1ITyB3
ZSBoYXZlIHRvIHRha2UgaW4gYW5kIHNhdmUgdGhpcyBpbmZvcm1hdGlvbiB0byB0cmlnX2luZm8N
Cj4gPiA+ID4gZHVyaW5nDQo+ID4gPiA+IHRyaWdnZXIgYWxsb2NhdGlvbiBjYWxsLiBGb3IgZXhh
bXBsZSB3ZSBjYW4gY2hlY2sgVEhJU19NT0RVTEUNCj4gPiA+ID4gZnJvbQ0KPiA+ID4gPiB0aGUN
Cj4gPiA+IA0KPiA+ID4gSG1tbSwgSWYgd2Ugd2VyZSB0byBkbyBzb21ldGhpbmcgZHVyaW5nIGlp
b190cmlnZ2VyX2FsbG9jKCksIHdlDQo+ID4gPiB3b3VsZA0KPiA+ID4gcmF0aGVyIGFzc2lnbiBh
bHJlYWR5IFRISVNfTU9EVUxFIHRvIG93bmVyIGFuZCB3ZSB3b3VsZCBub3QgbmVlZA0KPiA+ID4g
dGhpcw0KPiA+ID4gV0FSTigpLiBJIG1lYW4sIGlmIHNvbWVvbmUgY2FsbHMgaWlvX3RyaWdnZXJf
Z2V0KCkgYmVmb3JlDQo+ID4gPiBhbGxvY2F0aW5nDQo+ID4gPiBpdCwgaXQgd2lsbCBoYXZlIGJp
Z2dlciBwcm9ibGVtcyA6KS4NCj4gPiA+IA0KPiA+IA0KPiA+IFlvdSBhcmUgcmlnaHQsIG5vbi1h
bGxvY2F0ZWQgcG9pbnRlciBkZXJlZmVyZW5jZSBpcyBtdWNoIGJpZ2dlcg0KPiA+IHByb2JsZW0g
OikNCj4gPiANCj4gPiA+IEkgdGhpbmsgdGhpcyBjb3VsZCBhY3R1YWxseSBiZSBzb21ldGhpbmcg
cmVhc29uYWJsZS4uLg0KPiA+IA0KPiA+IEkgdGhpbmsgaXQgY291bGQgYmUgYSBnb29kIHNvbHV0
aW9uLCBidXQgaXQncyByZXF1aXJlZCBhIGxvdCBvZg0KPiA+IGNoYW5nZXMNCj4gPiBpbiB0aGUg
SUlPIGRyaXZlcnMgY29kZSwgYmVjYXVzZSBpZiB3ZSBhc3NpZ24gdHJpZy0+b3duZXIgZnJvbQ0K
PiA+IGlpb190cmlnZ2VyX2FsbG9jKCksIHdlIGRvIG5vdCBuZWVkIHRoaXNfbW9kIHBhcmFtZXRl
ciBpbiB0aGUNCj4gPiBpaW9fdHJpZ2dlcl9yZWdpc3RlcigpIGlmYWNlIGFuZCBpdHMgd3JhcHBl
cnMuDQo+ID4gU28gaXQgbWVhbnMgdG8gbWFrZSBpdCB3b3JrYWJsZSB3ZSBtdXN0Og0KPiA+IMKg
wqDCoCAtIHJld29yayBpaW9fdHJpZ2dlcl9hbGxvYygpDQo+ID4gwqDCoMKgIC0gcmVkZXNpZ24g
aWlvX3RyaWdnZXJfcmVnaXN0ZXIoKSBpZmFjZSBhbmQgaXRzIHdyYXBwZXJzDQo+ID4gwqDCoMKg
IC0gY29ycmVjdCBpaW9fdHJpZ2dlcl9yZWdpc3RlcigpIGNhbGwgZnJvbSBhbGwgSUlPIGRyaXZl
cnMNCj4gPiANCj4gPiBJIHN1cHBvc2Ugd2UgbmVlZCB0byB3YWl0IGZvciBKb25hdGhhbidzIGNv
bW1lbnRzIGhlcmUuLi4NCj4gPiANCj4gDQo+IEkgdGhpbmsgd2UgY291bGQgYWN0dWFsbHkgZ2V0
IHRoaXMgZG9uZSB3aXRob3V0IGhhdmluZyB0byBjaGFuZ2UgYWxsDQo+IHRoZSBkcml2ZXJzLiBO
b3RlIG9uIGhvdyBpaW9fdHJpZ2dlcl9yZWdpc3RlcigpIHBhc3NlcyBUSElTX01PRFVMRSB0bw0K
PiB0aGUgaW50ZXJuYWwgQVBJLiBXZSBjb3VsZCBhbHNvIHVzZSBtYWNyb3MgaW4gdGhlIGFsbG9j
IGZ1bmN0aW9uIGluIGENCj4gd2F5IHRoYXQgb25seSBpbnRlcm5hbCBmdW5jdGlvbnMgd291bGQg
bmVlZCB0byBiZSBjaGFuZ2VkLiBCdXQgaXQgYWxsDQo+IGRlcGVuZHMgb24gd2hldGhlciBvciBu
b3QgSm9uYXRoYW4gd2FudHMgdGhpcyBtb3ZlZC4uLg0KPiANCj4gLSBOdW5vIFPDoQ0KDQotLSAN
ClRoYW5rIHlvdSwNCkRtaXRyeQ==
