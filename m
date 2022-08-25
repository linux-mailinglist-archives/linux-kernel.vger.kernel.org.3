Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417C95A1AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243443AbiHYVRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiHYVRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:17:14 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E4B6D2A;
        Thu, 25 Aug 2022 14:17:10 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 979285FD03;
        Fri, 26 Aug 2022 00:17:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1661462227;
        bh=NdYu6S8So3OlWwAWfrtI2SZFnmdWOENE4S4SPr1oh5w=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=NmW7QyOl+uzyY404KQ2ScjrkTm2xWbVJrA2qMvcRuELRU5gp3g6qWbrjOSuSJ1WrU
         z2GRLiSdjA18RyctCXoj9Y/OYF6HS7mquekj+QqCfaxTI+VOUYdjq47pFoN88LcUm8
         8gPQZczixoZvqNTp/el/r9qh95nZqJaBxZOPiRX66LJ/Vx2nP6OHB/a99H0a8ytBce
         1AZgcPqUkO6PRD7+rJ5Swf7I4lOVg3OEK6mTqO8sUUMDnCrVlTsrHkj6zI5yQqmKUF
         piMrHDkyDzgUjLgS+VMqiSm7EuyZTlnHKXOnlMgGCG/waYdrw2u4crBjYtpihkXhjG
         fZiOwG8gax2EA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 26 Aug 2022 00:17:06 +0300 (MSK)
From:   Martin Kurbanov <MMKurbanov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Pavel Machek <pavel@ucw.cz>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] leds: trigger: pattern: notify userpace if pattern
 finished
Thread-Topic: [PATCH v1] leds: trigger: pattern: notify userpace if pattern
 finished
Thread-Index: AQHYt6+SAK0reQB1UU+HPUIqOWYrVa2+AQyAgAHtWAA=
Date:   Thu, 25 Aug 2022 21:16:42 +0000
Message-ID: <a8af665d-8248-4315-fe03-0ac91a1f4230@sberdevices.ru>
References: <20220824114927.79231-1-mmkurbanov@sberdevices.ru>
 <CAHp75VeQX_8niAu4uORW1YEfjxhLJFWsnm_JccECfAOAzAh32A@mail.gmail.com>
In-Reply-To: <CAHp75VeQX_8niAu4uORW1YEfjxhLJFWsnm_JccECfAOAzAh32A@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <22BC21E6A2F1164D8497786E5B649B53@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/25 17:43:00 #20154524
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkuIFRoYW5rIHlvdSBmb3IgcXVpY2sgcmVwbHkuDQoNCk9uIDIwMjItMDgtMjQgMTg6NTEsIEFu
ZHkgU2hldmNoZW5rbyB3cm90ZToNCi4uLg0KPj4gK3N0YXRpYyB2b2lkIHBhdHRlcm5fdHJpZ19y
ZW1vdmVfcGF0dGVybl9lbmRlZChzdHJ1Y3QgbGVkX2NsYXNzZGV2ICpsZWRfY2RldikNCj4+ICt7
DQo+PiArICAgICAgIHN0cnVjdCBwYXR0ZXJuX3RyaWdfZGF0YSAqZGF0YSA9IGxlZF9nZXRfdHJp
Z2dlcl9kYXRhKGxlZF9jZGV2KTsNCj4+ICsNCj4+ICsgICAgICAgc3lzZnNfcHV0KGRhdGEtPnBh
dHRlcm5fZW5kZWQpOw0KPj4gKyAgICAgICBkZXZpY2VfcmVtb3ZlX2ZpbGUobGVkX2NkZXYtPmRl
diwgJmRldl9hdHRyX3BhdHRlcm5fZW5kZWQpOw0KPj4gK30NCj4gDQo+IEknbSB3b25kZXJpbmcg
aWYgeW91IGNhbiBhbHdheXMgaGF2ZSBhIGZpbGUgYW5kIGluc3RlYWQgcHJvdmlkZSBhDQo+IHZh
bHVlIHRoZXJlLCBzbyB1c2VyIHNwYWNlIG1heSB1c2UgZXBvbGwoKSBtZWNoYW5pc20gb24gdGhh
dC4gSXQgd2lsbA0KPiBzaW1wbGlmeSB5b3VyIGNvZGUgaGVyZS4NCj4gDQpEbyB5b3UgbWVhbiB0
byBhZGQgJ2Rldl9hdHRyX3BhdHRlcm5fZW5kZWQnIHRvICdwYXR0ZXJuX3RyaWdfYXR0cnMnLA0K
YW5kIHVzZSAnc3lzZnNfbm90aWZ5JyBpbnN0ZWFkIG9mICdzeXNmc19ub3RpZnlfZGlyZW50JyBj
YWxsJz8NCg0KLS0gDQpCZXN0IFJlZ2FyZHMsDQpLdXJiYW5vdiBNYXJ0aW4NCg0K
