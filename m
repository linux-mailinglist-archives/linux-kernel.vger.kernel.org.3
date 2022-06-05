Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D151853DA65
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 08:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiFEGVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 02:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiFEGVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 02:21:40 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3124C4E380
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 23:21:39 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id D17A52E2D9E;
        Sun,  5 Jun 2022 08:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654410097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lgzKAOGGgcNpW6bt0b+KeVm5ykT1IjAT6JsZxBHwQEM=;
        b=vD/OEj1ts6LzO0FtXZbmXeeXee05Y/hZ2mT2S+1HNYDy1nvu3mohJfOUws93+CgFT6g6sW
        BFcspXrsBUUidNAkyvYY5sy/CQlxHKc7HT86gEJ5ZNc3/j/dYLfMnUMPwrO1fFbGiBUuHp
        ZSoS40BM3cpHjXohQGpMf3RNRqFmRs6SVRoSziiwe4jiFUxO55ybZgB1K5V6PYpFR3Azum
        XEf6UJG99DobS19uI9ixVEnmwijeIAG7BIrl7Wv4aAehZD4jwvq1zzApTNkvQeP23+GL9x
        4UuMVRJnG/t/Sy5pnqmX0Y3cJ1vqzLBgnBSfolPzOWIOcTjHWF1e3avvYZx6WA==
Message-ID: <5bfcbc7aeb3963c3672534513c64fbec5c31e83d.camel@svanheule.net>
Subject: Re: [PATCH v2 1/4] lib/test: Introduce cpumask KUnit test suite
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Sun, 05 Jun 2022 08:21:35 +0200
In-Reply-To: <YpuzKLQdToIwBrSm@yury-laptop>
References: <cover.1654362935.git.sander@svanheule.net>
         <5a55f41812dc18fccf66f8130682ff8e669e0c80.1654362935.git.sander@svanheule.net>
         <YpuzKLQdToIwBrSm@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWXVyeSwKCk9uIFNhdCwgMjAyMi0wNi0wNCBhdCAxMjozMSAtMDcwMCwgWXVyeSBOb3JvdiB3
cm90ZToKPiBPbiBTYXQsIEp1biAwNCwgMjAyMiBhdCAwNzoxNTo1NlBNICswMjAwLCBTYW5kZXIg
VmFuaGV1bGUgd3JvdGU6Cj4gPiBBZGQgYSBiYXNpYyBzdWl0ZSBvZiB0ZXN0cyBmb3IgY3B1bWFz
aywgcHJvdmlkaW5nIHNvbWUgdGVzdHMgZm9yIGVtcHR5Cj4gPiBhbmQgY29tcGxldGVseSBmaWxs
ZWQgY3B1bWFza3MuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFNhbmRlciBWYW5oZXVsZSA8c2Fu
ZGVyQHN2YW5oZXVsZS5uZXQ+Cj4gCj4gVGhlIHRlc3QgbXVzdCBnbyBhZnRlciBmaXgsIHNvIHRo
YXQgaXQncyBkb2Vzbid0IGNhdXNlIHJlZ3Jlc3Npb25zCj4gd2hpbGUgYmlzZWN0aW5nLgoKT0ss
IEknbGwgY2hhbmdlIHRoZSBvcmRlciBvZiB0aGUgcGF0Y2hlcy4KCj4gCj4gPiAtLS0KPiA+IMKg
bGliL0tjb25maWcuZGVidWfCoCB8wqDCoCA5ICsrKysKPiA+IMKgbGliL01ha2VmaWxlwqDCoMKg
wqDCoMKgIHzCoMKgIDEgKwo+ID4gwqBsaWIvdGVzdF9jcHVtYXNrLmMgfCAxMTUgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiDCoDMgZmlsZXMgY2hhbmdl
ZCwgMTI1IGluc2VydGlvbnMoKykKPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi90ZXN0X2Nw
dW1hc2suYwo+IAo+IFsuLl0KPiAKPiA+ICsjZGVmaW5lIEZPUl9FQUNIX0lURVJfRVEoX3Rlc3Qs
IF9pdGVyLCBfZXhwZWN0LCBfbG9vcCnCoMKgwqDCoMKgwqDCoMKgwqBcCj4gPiArwqDCoMKgwqDC
oMKgwqBkbyB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBc
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKF9pdGVyKSA9IDA7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9sb29wwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoChfaXRlcikrKzvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgS1VOSVRfRVhQRUNUX0VRKChfdGVzdCksIChfZXhwZWN0KSwgKF9pdGVyKSk7wqDC
oMKgXAo+ID4gK8KgwqDCoMKgwqDCoMKgfSB3aGlsZSAoMCkKPiAKPiBUaGlzIG9uZSBpcyBoYXJk
ZXIgdG8gdXNlIHRoYW4gaXQgc2hvdWxkIGJlLgoKUGVyaGFwcyBJIHRyaWVkIHRvIGhhcmQgdG8g
bWFrZSBvbmUgbWFjcm8gdG8gY292ZXIgYWxsIHRoZSBjYXNlcy4KCj4gIE1heWJlIGxpa2UgdGhp
cz8gKG5vdCB0ZXN0ZWQsCj4ganVzdCBhbiBpZGVhKQo+IAo+ICNkZWZpbmUgVEVTVF9GT1JfRUFD
SF9DUFVfRVEodGVzdCwgbWFzaynCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gwqDCoMKgwqDCoMKgwqDCoGRvIHvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1bWFza190ICptID0gKG1hc2spO8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBcCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBpdGVyID0gMCwg
Y3B1O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGZvcl9lYWNoX2NwdShjcHUsIG0pwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaXRlcisrO8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEtVTklUX0VYUEVDVF9FUSgo
dGVzdCksIGNwdW1hc2tfd2VpZ2h0KG0pLCBpdGVyKTvCoMKgwqDCoMKgwqDCoFwKPiDCoMKgwqDC
oMKgwqDCoMKgfSB3aGlsZSAoMCkKPiAKPiBzdGF0aWMgdm9pZCB0ZXN0X2NwdW1hc2tfaXRlcmF0
b3JzKHN0cnVjdCBrdW5pdCAqdGVzdCkKPiB7Cj4gwqDCoMKgwqDCoMKgwqAgVEVTVF9GT1JfRUFD
SF9DUFUodGVzdCwgJm1hc2tfZW1wdHkpOwo+IMKgwqDCoMKgwqDCoMKgIC4uLgo+IH0KPiDCoAo+
IFNpbWlsYXJseSBmb3IgTk9UIGFuZCBXUkFQLgoKVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiwg
SSBmb3Jnb3Qgd2UgZG9uJ3QgaGF2ZSB0byBkZWNsYXJlIGFsbCB2YXJpYWJsZXMgYXQgdGhlIHN0
YXJ0IG9mIHRoZQpmdW5jdGlvbi4gSSdsbCBzZW5kIGFuIHVwZGF0ZSB3aXRoIGEgZmV3IG1vcmUg
c3BlY2lmaWMgbWFjcm9zLgoKQmVzdCwKU2FuZGVyCg==

