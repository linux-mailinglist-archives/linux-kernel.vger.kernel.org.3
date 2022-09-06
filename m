Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE08B5AEDEC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbiIFOnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbiIFOmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:42:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FFF9D8CA;
        Tue,  6 Sep 2022 07:03:06 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:414f:4149:b474:40e4] (unknown [IPv6:2a00:23c6:c311:3401:414f:4149:b474:40e4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 43E7D6601F20;
        Tue,  6 Sep 2022 15:01:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662472913;
        bh=Qrr7PGGV0pTVU6MwAhf7oXMb3V+hHN/UlRCB828kcVo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EYYlPk1QT0nPfxYgSuzYUjIraY8aePwXtC9amid/uXZklyMnPC1VrX+O5j+5OOVQ6
         PSrkMuwIW4dLmBJb93K29evStyYQmZEVhZNsTkIoaOrDCvH2zu+xSiUw6oCoHMOsDn
         j4yJYIZKXQRWsmHWtx15aVxgFBv3GzNbFd7eUGPYgTqYPbWPC20Y2oB8VHGmWyvbqw
         TNa4D3cU9RLqe0hbaWqiwyWbVR6i7yzaK06aMwO6VV6TYKfHR8yOZFS1wD76ZZC5Ay
         HD62FS4UvhcRwjYflKg5kGxtGZzvSW4K+sUFjGrDW7c4tSzTS72RFRlDFxpwYtEYit
         BhqwDinCy9zXg==
Message-ID: <a71dec127a2e188b1eb7df1e385f71410051acca.camel@collabora.com>
Subject: Re: [PATCH v2 5/5] gpio: pca953x: Add support for PCAL6534
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Sep 2022 15:01:51 +0100
In-Reply-To: <Yxc8GgUnHOuMIn4p@smile.fi.intel.com>
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
         <20220906082820.4030401-5-martyn.welch@collabora.co.uk>
         <Yxc8GgUnHOuMIn4p@smile.fi.intel.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA5LTA2IGF0IDE1OjI0ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gVHVlLCBTZXAgMDYsIDIwMjIgYXQgMDk6Mjg6MTlBTSArMDEwMCwgTWFydHluIFdlbGNo
IHdyb3RlOgo+ID4gRnJvbTogTWFydHluIFdlbGNoIDxtYXJ0eW4ud2VsY2hAY29sbGFib3JhLmNv
bT4KPiA+IAo+ID4gQWRkIHN1cHBvcnQgZm9yIHRoZSBOWFAgUENBTDY1MzQuIFRoaXMgZGV2aWNl
IGlzIGJyb2FkbHkgYSAzNC1iaXQKPiA+IHZlcnNpb24KPiA+IG9mIHRoZSBQQ0FMNjUyNC4gSG93
ZXZlciwgd2hpbHN0IHRoZSByZWdpc3RlcnMgYXJlIGJyb2FkbHkgd2hhdAo+ID4geW91J2QKPiA+
IGV4cGVjdCBmb3IgYSAzNC1iaXQgdmVyc2lvbiBvZiB0aGUgUENBTDY1MjQsIHRoZSBzcGFjaW5n
IG9mIHRoZQo+ID4gcmVnaXN0ZXJzCj4gPiBoYXMgYmVlbiBjb21wYWN0ZWQuIFRoaXMgaGFzIHRo
ZSB1bmZvcnR1bmF0ZSBlZmZlY3Qgb2YgYnJlYWtpbmcgdGhlCj4gPiBiaXQKPiA+IHNoaWZ0IGJh
c2VkIG1lY2hhbmlzbSB0aGF0IGlzIGVtcGxveWVkIHRvIHdvcmsgb3V0IHJlZ2lzdGVyCj4gPiBs
b2NhdGlvbnMgdXNlZAo+ID4gYnkgdGhlIG90aGVyIGNoaXBzIHN1cHBvcnRlZCBieSB0aGlzIGRy
aXZlci4gVG8gYWNjb21tb2RhdGUgdGhzLAo+ID4gY2FsbGJhY2sKPiA+IGZ1bmN0aW9ucyBoYXZl
IGJlZW4gYWRkZWQgdG8gYWxsb3cgYWx0ZXJhdGUgaW1wbGVtZW50YXRpb25zIG9mCj4gPiBwY2E5
NTN4X3JlY2FsY19hZGRyKCkgYW5kIHBjYTk1M3hfY2hlY2tfcmVnaXN0ZXIoKSBmb3IgdGhlCj4g
PiBQQ0FMNjUzNC4KPiAKPiAKPiBUaGlzIGxvb2tzIG11Y2ggY2xlYW5lciEKPiAKPiAuLi4KPiAK
PiA+IEBAIC0xMDcsNiArMTA5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lk
IHBjYTk1M3hfaWRbXQo+ID4gPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgeyAidGNhOTUzOSIsIDE2
IHwgUENBOTUzWF9UWVBFIHwgUENBX0lOVCwgfSwKPiA+IMKgwqDCoMKgwqDCoMKgwqB7ICJ0Y2E5
NTU0IiwgOMKgIHwgUENBOTUzWF9UWVBFIHwgUENBX0lOVCwgfSwKPiA+IMKgwqDCoMKgwqDCoMKg
wqB7ICJ4cmExMjAyIiwgOMKgIHwgUENBOTUzWF9UWVBFIH0sCj4gPiArCj4gPiDCoMKgwqDCoMKg
wqDCoMKgeyB9Cj4gCj4gTWlzc2VkIERpb2Rlcz8KPiAKCkRyb3BwZWQgYXMgaXQgaXMgZXhwZWN0
ZWQgZm9yIHRoZSBEVEJzIG9mIGRldmljZXMgd2l0aCBhIHBpNGlvZTV2NjUzNHEKYWxzbyBoYXZl
IGEgY29tcGF0aWJsZSBmb3IgcGNhbDY1MzQuIGhlbmNlIGl0J3Mgbm90IG5lZWRlZCBpbiB0aGUK
ZHJpdmVyIChhdCBsZWFzdCB1bnRpbCBzb21lb25lIGZpbmRzIGEgZGlmZmVyZW5jZSB3aGljaCBu
ZWVkcyB0byBiZQpleHBsaWNpdGx5IGhhbmRsZWQgZm9yIG9uZSBhbmQgbm90IHRoZSBvdGhlciku
Cgo+ID4gwqB9Owo+ID4gwqBNT0RVTEVfREVWSUNFX1RBQkxFKGkyYywgcGNhOTUzeF9pZCk7Cj4g
Cj4gLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqB1OCAoKnJlY2FsY19hZGRyKShzdHJ1Y3QgcGNh
OTUzeF9jaGlwICpjaGlwLCBpbnQgcmVnICwgaW50Cj4gPiBvZmYpOwo+ID4gK8KgwqDCoMKgwqDC
oMKgYm9vbCAoKmNoZWNrX3JlZykoc3RydWN0IHBjYTk1M3hfY2hpcCAqY2hpcCwgdW5zaWduZWQg
aW50Cj4gPiByZWcsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHUzMiBjaGVja2JhbmspOwo+IAo+IEkgd291bGQgdGhpbmsgb2Ygc3BsaXR0aW5n
IHRoaXMgY2hhbmdlLiBMaWtlIGluIGEgc2VwYXJhdGUgcGF0Y2ggeW91Cj4gc2ltcGx5Cj4gY3Jl
YXRlIHRoaXMgaW50ZXJmYWNlIGFuZCBvbmx5IGFkZCB3aGF0IHlvdSBuZWVkIGluIHRoZSBuZXh0
IG9uZS4KPiAKCkNhbiBkbywgdGhvdWdoIEkgZGlkbid0IGZlZWwgeW91IHdlcmUgcGFydGljdWxh
cmx5IGZ1c3NlZCBhYm91dCBtZQpoYXZpbmcgc3BsaXQgdGhhdCBvdXQuLi4KCj4gLi4uCj4gCj4g
PiArc3RhdGljIGJvb2wgcGNhbDY1MzRfY2hlY2tfcmVnaXN0ZXIoc3RydWN0IHBjYTk1M3hfY2hp
cCAqY2hpcCwKPiA+IHVuc2lnbmVkIGludCByZWcsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTMyIGNoZWNr
YmFuaykKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgYmFuazsKPiA+ICvCoMKgwqDCoMKg
wqDCoGludCBvZmZzZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmVnID4gMHgyZikg
ewo+IAo+IEkgZ3Vlc3MgY29kZSByZWFkIGFuZCBnZW5lcmF0aW9uIHdpc2UgdGhlCj4gCj4gwqDC
oMKgwqDCoMKgwqDCoGlmIChyZWcgPj0gMHgzMCkgewo+IAo+IGlzIHNsaWdodGx5IGJldHRlci4K
Ck9LLgoKPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFJlc2VydmVkIGJsb2NrIGJldHdlZW4gMTRoIGFu
ZCAyRmggZG9lcyBub3QKPiA+IGFsaWduIG9uCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogZXhwZWN0ZWQgYmFuayBib3VuZGFyaWVzIGxpa2Ugb3RoZXIgZGV2aWNlcy4KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpbnQgdGVtcCA9IHJlZyAtIDB4MzA7Cj4gPiArCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgYmFuayA9IHRlbXAgLyBOQkFOSyhjaGlwKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvZmZzZXQgPSB0ZW1wIC0gKGJhbmsgKiBOQkFOSyhj
aGlwKSk7Cj4gCj4gUGFyZW50aGVzZXMgYXJlIG5vdCBuZWVkZWQgZnVyIG11bHRpcGxpY2F0aW9u
LCBidXQgaWYgeW91IGluc2lzdC4uLgo+IAoKCgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGJhbmsgKz0gODsKPiAKPiA+ICvCoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAocmVnID4g
MHg1Mykgewo+IAo+IEluIHRoZSBzaW1pbGFyIHdheS4uLgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoC8qIEhhbmRsZSBsYWNrIG9mIHJlc2VydmVkIHJlZ2lzdGVycyBhZnRl
ciBvdXRwdXQKPiA+IHBvcnQKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBj
b25maWd1cmF0aW9uIHJlZ2lzdGVyIHRvIGZvcm0gYSBiYW5rLgo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqLwo+IAo+IENvbW1lbnQgc3R5bGUKPiAKPiAvKgo+IMKgKiBIYW5k
bGUuLi4KPiDCoCovCj4gCgphY2sKCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aW50IHRlbXAgPSByZWcgLSAweDU0Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGJhbmsgPSB0ZW1wIC8gTkJBTksoY2hpcCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgb2Zmc2V0ID0gdGVtcCAtIChiYW5rICogTkJBTksoY2hpcCkpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJhbmsgKz0gMTY7Cj4gPiArwqDCoMKgwqDCoMKg
wqB9IGVsc2Ugewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJhbmsgPSByZWcg
LyBOQkFOSyhjaGlwKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvZmZzZXQg
PSByZWcgLSAoYmFuayAqIE5CQU5LKGNoaXApKTsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICsK
PiA+ICvCoMKgwqDCoMKgwqDCoC8qIFJlZ2lzdGVyIGlzIG5vdCBpbiB0aGUgbWF0Y2hpbmcgYmFu
ay4gKi8KPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghKEJJVChiYW5rKSAmIGNoZWNrYmFuaykpCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGZhbHNlOwo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoMKgLyogUmVnaXN0ZXIgaXMgbm90IHdpdGhpbiBhbGxvd2VkIHJhbmdlIG9m
IGJhbmsuICovCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAob2Zmc2V0ID49IE5CQU5LKGNoaXApKQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBmYWxzZTsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoHJldHVybiB0cnVlOwo+ID4gK30KPiAKPiAuLi4KPiAKPiA+IC3CoMKg
wqDCoMKgwqDCoHU4IHJlZ2FkZHIgPSBwaW5jdHJsIHwgYWRkciB8IChvZmYgLyBCQU5LX1NaKTsK
PiA+IMKgCj4gPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gcmVnYWRkcjsKPiA+ICvCoMKgwqDCoMKg
wqDCoHJldHVybiBwaW5jdHJsIHwgYWRkciB8IChvZmYgLyBCQU5LX1NaKTsKPiAKPiBTdHJheSBj
aGFuZ2UsIG9yIGFueXRoaW5nIEkgaGF2ZSBtaXNzZWQ/Cj4gCgpZZWFoLCBjYW4gcmVtb3ZlIHRo
YXQgY2hhbmdlLi4uCgo+IC4uLgo+IAo+ID4gKy8qIFRoZSBQQ0FMNjUzNCBhbmQgY29tcGF0aWJs
ZSBjaGlwcyBoYXZlIGFsdGVyZWQgYmFuayBhbGlnbm1lbnQKPiA+IHRoYXQgZG9lc24ndAo+ID4g
KyAqIGZpdCB3aXRoaW4gdGhlIGJpdCBzaGlmdGluZyBzY2hlbWUgdXNlZCBmb3Igb3RoZXIgZGV2
aWNlcy4KPiA+ICsgKi8KPiAKPiBDb21tZW50IHN0eWxlLgo+IAo+IC4uLgo+IAo+ID4gQEAgLTEy
NDAsNiArMTMzNSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkCj4gPiBwY2E5
NTN4X2R0X2lkc1tdID0gewo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqB7IC5jb21wYXRpYmxl
ID0gIm54cCxwY2FsNjQxNiIsIC5kYXRhID0gT0ZfOTUzWCgxNiwKPiA+IFBDQV9MQVRDSF9JTlQp
LCB9LAo+ID4gwqDCoMKgwqDCoMKgwqDCoHsgLmNvbXBhdGlibGUgPSAibnhwLHBjYWw2NTI0Iiwg
LmRhdGEgPSBPRl85NTNYKDI0LAo+ID4gUENBX0xBVENIX0lOVCksIH0sCj4gPiArwqDCoMKgwqDC
oMKgwqB7IC5jb21wYXRpYmxlID0gIm54cCxwY2FsNjUzNCIsIC5kYXRhID0gT0ZfNjUzWCgzNCwK
PiA+IFBDQV9MQVRDSF9JTlQpLCB9LAo+ID4gwqDCoMKgwqDCoMKgwqDCoHsgLmNvbXBhdGlibGUg
PSAibnhwLHBjYWw5NTM1IiwgLmRhdGEgPSBPRl85NTNYKDE2LAo+ID4gUENBX0xBVENIX0lOVCks
IH0sCj4gPiDCoMKgwqDCoMKgwqDCoMKgeyAuY29tcGF0aWJsZSA9ICJueHAscGNhbDk1NTRiIiwg
LmRhdGEgPSBPRl85NTNYKCA4LAo+ID4gUENBX0xBVENIX0lOVCksIH0sCj4gPiDCoMKgwqDCoMKg
wqDCoMKgeyAuY29tcGF0aWJsZSA9ICJueHAscGNhbDk1NTVhIiwgLmRhdGEgPSBPRl85NTNYKDE2
LAo+ID4gUENBX0xBVENIX0lOVCksIH0sCj4gCj4gRG8geW91IGRlY2lkZSB0byBkcm9wIERpb2Rl
cyBjb21wYXRpYmxlIGZyb20gdGhlIGNvZGU/Cj4gCgo=

