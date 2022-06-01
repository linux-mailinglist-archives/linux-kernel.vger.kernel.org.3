Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2012053A2AE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352086AbiFAKeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiFAKeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:34:20 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421197C148;
        Wed,  1 Jun 2022 03:34:14 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 97F875FD12;
        Wed,  1 Jun 2022 13:34:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1654079650;
        bh=gPmZS9gDQOs2UR/qozCVvNZkS/tEoN45jNdZfD1NEgk=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=mDEh6wKX6tvIlSZ9m67+8Xs7niE8iziFpa+gqV5iNm2iKOxmxsSazS5fEHKutz6Dk
         kzRXxTRgCIifqsy2SImjWPLn7RBwTxJjt7e7tkOXwEL+pe2BjJIGdaa/S40U1oGLvv
         QM24sRiILRV6m0+Fq7L7Evb10ISJdtD6NeZu7IzAX/UYRg4VOsp+36wIROxu/V3T6H
         Pa9x9HVT57ACGrdPl+6SyYUz0RsIdyvT0ZYXygHPBqIobIL/occM/K7HPRrYydlkgO
         gUV4gy4wgQ8VOXhTfR8+36M4ctuRHvkVUAS94hJ4igQPuwKLVONFCZuIKb1OWV/hQa
         N8z9H36ghXdPw==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed,  1 Jun 2022 13:34:01 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Topic: [PATCH v1] iio: trigger: warn about non-registered iio trigger
 getting attempt
Thread-Index: AQHYdRpaUrhZ5pf6gEC6S1oZ2DfDiK05JA2AgADoBACAAB2gAA==
Date:   Wed, 1 Jun 2022 10:33:46 +0000
Message-ID: <20220601103356.xlimabcihaay5jky@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220531181457.26034-1-ddrokosov@sberdevices.ru>
 <20220531185729.z6246gexteyo4xmd@CAB-WSD-L081021.sigma.sbrf.ru>
 <786db9cf74473caef10dcea79975716b5516f47e.camel@gmail.com>
In-Reply-To: <786db9cf74473caef10dcea79975716b5516f47e.camel@gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B9A7B81D8500942895A27785D25EBFB@sberdevices.ru>
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

SGkgTnVubywNCg0KVGhhbmsgeW91IGZvciBjb21tZW50cyENCg0KT24gV2VkLCBKdW4gMDEsIDIw
MjIgYXQgMTA6NDc6NTRBTSArMDIwMCwgTnVubyBTw6Egd3JvdGU6DQo+IE9uIFR1ZSwgMjAyMi0w
NS0zMSBhdCAxODo1NyArMDAwMCwgRG1pdHJ5IFJva29zb3Ygd3JvdGU6DQo+ID4gSGkgSm9uYXRo
YW4sDQo+ID4gDQo+ID4gSSBoYXZlIG9uZSBxdWVzdGlvbiBhYm91dCBhIGNhc2VzIHdoZW4gdHJp
Z2dlciBvd25lciBpcyBidWlsdGluDQo+ID4gbW9kdWxlLg0KPiA+IEluIHRoZSBzdWNoIGNhc2Vz
IHRyaWctPm93bmVyID09IG51bGwsIGJlY2F1c2UgVEhJU19NT0RVTEUgZXF1YWxzIHRvDQo+ID4g
bnVsbC4gSG93IGRvIHlvdSB0aGluaywgc2hvdWxkIHdlIHRha2UgaW50byBhY2NvdW50IHN1Y2gg
c2l0dWF0aW9ucz8NCj4gPiANCj4gPiBJTUhPIHdlIGhhdmUgdG8gdGFrZSBpbiBhbmQgc2F2ZSB0
aGlzIGluZm9ybWF0aW9uIHRvIHRyaWdfaW5mbyBkdXJpbmcNCj4gPiB0cmlnZ2VyIGFsbG9jYXRp
b24gY2FsbC4gRm9yIGV4YW1wbGUgd2UgY2FuIGNoZWNrIFRISVNfTU9EVUxFIGZyb20NCj4gPiB0
aGUNCj4gDQo+IEhtbW0sIElmIHdlIHdlcmUgdG8gZG8gc29tZXRoaW5nIGR1cmluZyBpaW9fdHJp
Z2dlcl9hbGxvYygpLCB3ZSB3b3VsZA0KPiByYXRoZXIgYXNzaWduIGFscmVhZHkgVEhJU19NT0RV
TEUgdG8gb3duZXIgYW5kIHdlIHdvdWxkIG5vdCBuZWVkIHRoaXMNCj4gV0FSTigpLiBJIG1lYW4s
IGlmIHNvbWVvbmUgY2FsbHMgaWlvX3RyaWdnZXJfZ2V0KCkgYmVmb3JlIGFsbG9jYXRpbmcNCj4g
aXQsIGl0IHdpbGwgaGF2ZSBiaWdnZXIgcHJvYmxlbXMgOikuDQo+IA0KDQpZb3UgYXJlIHJpZ2h0
LCBub24tYWxsb2NhdGVkIHBvaW50ZXIgZGVyZWZlcmVuY2UgaXMgbXVjaCBiaWdnZXIgcHJvYmxl
bSA6KQ0KDQo+IEkgdGhpbmsgdGhpcyBjb3VsZCBhY3R1YWxseSBiZSBzb21ldGhpbmcgcmVhc29u
YWJsZS4uLg0KDQpJIHRoaW5rIGl0IGNvdWxkIGJlIGEgZ29vZCBzb2x1dGlvbiwgYnV0IGl0J3Mg
cmVxdWlyZWQgYSBsb3Qgb2YgY2hhbmdlcw0KaW4gdGhlIElJTyBkcml2ZXJzIGNvZGUsIGJlY2F1
c2UgaWYgd2UgYXNzaWduIHRyaWctPm93bmVyIGZyb20NCmlpb190cmlnZ2VyX2FsbG9jKCksIHdl
IGRvIG5vdCBuZWVkIHRoaXNfbW9kIHBhcmFtZXRlciBpbiB0aGUNCmlpb190cmlnZ2VyX3JlZ2lz
dGVyKCkgaWZhY2UgYW5kIGl0cyB3cmFwcGVycy4NClNvIGl0IG1lYW5zIHRvIG1ha2UgaXQgd29y
a2FibGUgd2UgbXVzdDoNCiAgICAtIHJld29yayBpaW9fdHJpZ2dlcl9hbGxvYygpDQogICAgLSBy
ZWRlc2lnbiBpaW9fdHJpZ2dlcl9yZWdpc3RlcigpIGlmYWNlIGFuZCBpdHMgd3JhcHBlcnMNCiAg
ICAtIGNvcnJlY3QgaWlvX3RyaWdnZXJfcmVnaXN0ZXIoKSBjYWxsIGZyb20gYWxsIElJTyBkcml2
ZXJzDQoNCkkgc3VwcG9zZSB3ZSBuZWVkIHRvIHdhaXQgZm9yIEpvbmF0aGFuJ3MgY29tbWVudHMg
aGVyZS4uLg0KDQotLSANClRoYW5rIHlvdSwNCkRtaXRyeQ==
