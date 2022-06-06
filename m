Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE153E682
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiFFMW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiFFMW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:22:26 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D56AF49
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:22:23 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id EB42F2E3867;
        Mon,  6 Jun 2022 14:22:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654518141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41cOmjUQznkHBnwiDd1+mU0+REiKRXZZIKk0DyS9JpI=;
        b=pnEP+bkmAqfZssxxG58/48rGq3jaRrFFNicmNlVJZxZaQQB7ZzYItrwN2tJrM8a7NSnVAn
        YVYcjKr/r9xOI6yYDTRtssQsK0ai+5PcPyt6+UmAgoLNKcREQlK1/7ES3VACqw0/xonxYu
        BNjdCP4Pg4OJMSFQ/87Yx7xaiRcLhEtF6M6JJVtYfGSBHEGWhEi0SX+kUbh+tKjdaAK8Jo
        S9lpmDfvpoqOBCiacb9NprMjULavEQw/rBX6Z3tZOyrGo3V6FQm6PImjroodXD2qMQg1zA
        gv/mMImIqppddbTuUgqSyBCn0XEAiA/pAUmXBsY7ThyHsIuSQFrL3ROp/iS5lQ==
Message-ID: <cc144daceeca2c67a62f85b386fe64eb3e88fa28.camel@svanheule.net>
Subject: Re: [PATCH v3 2/4] lib/test: Introduce cpumask KUnit test suite
From:   Sander Vanheule <sander@svanheule.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Date:   Mon, 06 Jun 2022 14:22:18 +0200
In-Reply-To: <Yp3YvnaFIPxlPVqU@smile.fi.intel.com>
References: <cover.1654410109.git.sander@svanheule.net>
         <8b60c0d5add21b43dd75e92d48f2df011f63c6bf.1654410109.git.sander@svanheule.net>
         <Yp3YvnaFIPxlPVqU@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwKCk9uIE1vbiwgMjAyMi0wNi0wNiBhdCAxMzozNiArMDMwMCwgQW5keSBTaGV2Y2hl
bmtvIHdyb3RlOgo+IE9uIFN1biwgSnVuIDA1LCAyMDIyIGF0IDA4OjIyOjM5QU0gKzAyMDAsIFNh
bmRlciBWYW5oZXVsZSB3cm90ZToKPiA+IEFkZCBhIGJhc2ljIHN1aXRlIG9mIHRlc3RzIGZvciBj
cHVtYXNrLCBwcm92aWRpbmcgc29tZSB0ZXN0cyBmb3IgZW1wdHkKPiA+IGFuZCBjb21wbGV0ZWx5
IGZpbGxlZCBjcHVtYXNrcy4KPiAKPiBBbHdheXMgaW4gZmF2b3VyIG9mIGEgbmV3IHRlc3QhCj4g
UmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50
ZWwuY29tPgoKVGhhbmtzIQoKPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFNhbmRlciBWYW5oZXVsZSA8
c2FuZGVyQHN2YW5oZXVsZS5uZXQ+Cj4gPiAtLS0KPiA+IAo+ID4gKyNkZWZpbmUgRVhQRUNUX0ZP
Ul9FQUNIX0NQVV9CVUlMVElOX0VRKHRlc3QsIG5hbWUpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBcCj4gPiArwqDCoMKgwqDCoMKgwqBkbyB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29u
c3QgY3B1bWFza190ICptID0gY3B1XyMjbmFtZSMjX21hc2s7wqDCoMKgwqDCoMKgwqDCoMKgXAo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludCBtYXNrX3dlaWdodCA9IGNwdW1h
c2tfd2VpZ2h0KG0pO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwKCkdpdmVuIHRoZSBkb2N1bWVu
dGF0aW9uIGZvciBudW1fb25saW5lX2NwdXMoKSwgSSd2ZSByZXBsYWNlZCB0aGlzIHdpdGgKCglp
bnQgbWFza193ZWlnaHQgPSBudW1fIyNuYW1lIyNfY3B1cygpOwoKYW5kIGFkZGVkIGd1YXJkcyBh
cm91bmQgdGhlIHRlc3QgZm9yIHRoZSBkeW5hbWljIGJ1aWx0aW4gbWFza3MuCgo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludCBjcHUsIGl0ZXIgPSAwO8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmb3JfZWFjaF8jI25hbWUjI19jcHUoY3B1KcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpdGVyKys7wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEtVTklUX0VYUEVDVF9FUSgodGVzdCksIG1h
c2tfd2VpZ2h0LCBpdGVyKTvCoMKgwqDCoMKgXAo+ID4gK8KgwqDCoMKgwqDCoMKgfSB3aGlsZSAo
MCkKPiA+IAoKCj4gPiArc3RhdGljIHZvaWQgdGVzdF9jcHVtYXNrX2l0ZXJhdG9yc19idWlsdGlu
KHN0cnVjdCBrdW5pdCAqdGVzdCkKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBFWFBFQ1RfRk9S
X0VBQ0hfQ1BVX0JVSUxUSU5fRVEodGVzdCwgcG9zc2libGUpOwoKCWNwdV9ob3RwbHVnX2Rpc2Fi
bGUoKTsKCj4gPiArwqDCoMKgwqDCoMKgwqBFWFBFQ1RfRk9SX0VBQ0hfQ1BVX0JVSUxUSU5fRVEo
dGVzdCwgb25saW5lKTsKPiA+ICvCoMKgwqDCoMKgwqDCoEVYUEVDVF9GT1JfRUFDSF9DUFVfQlVJ
TFRJTl9FUSh0ZXN0LCBwcmVzZW50KTsKCgljcHVfaG90cGx1Z19lbmFibGUoKTsKCj4gPiArfQoK
VGhpcyBzaG91bGQgZW5zdXJlIHRoZSB0ZXN0cyB3aWxsIG5vdCByYW5kb21seSBmYWlsLCBpZiB0
aGV5IGhhcHBlbiB0byBydW4gd2hpbGUgYSBDUFUgaXMgZ29pbmcKb25saW5lL29mZmxpbmUuCgpC
ZXN0LApTYW5kZXIK

