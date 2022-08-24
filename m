Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58135A03C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbiHXWIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiHXWH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B931F78BEF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661378876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGOw6yHuwLPSrg4cYvLL/LCKRkSmjdSEjyzIqaqf654=;
        b=EPUBgHTDmovdwoVAHq2wqyS5dcZa9MjG+GIhb6M6kJlHcotjbCJ/MgfupO1rtCkVFh3sgK
        0abIsi8eGI4lV4+RbJXRXUFnYEtmwEmA0pcfwErS0IMmeItR9b8diOzv+AhoFKnN+LaWD0
        1gl7RcpKGc4VMF46vql5SPxPt0d9LHY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-151-aBzZcAybPUy1wbHGL_IYxQ-1; Wed, 24 Aug 2022 18:07:53 -0400
X-MC-Unique: aBzZcAybPUy1wbHGL_IYxQ-1
Received: by mail-qt1-f200.google.com with SMTP id k9-20020ac80749000000b0034302b53c6cso14015366qth.22
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=IGOw6yHuwLPSrg4cYvLL/LCKRkSmjdSEjyzIqaqf654=;
        b=5y1atMmw6b8aS+Iv9WSbdDTvenkqlvwtpoIxqt8p9kudPdMQB2xB9rhbrZTTXCVjU5
         4BGYpWIXhklZet3L26CIMM8MPnHJ0YYy3xUy1wxOiMGltLrBmVRlnY3Xp6UIAF1VkdR2
         6LkDXnXtFj/H2/h9eYJZQZCX3JV2/hZcCxZnLy/ztTH7QwS1Ru1SLsyBIsrmnvKm8StQ
         rjwk+r03gNFP3arU3RcLo4OE3DUycFdug6OJ2FJppJrfU/ZVsCTWfnDDFqeJ79VEUYVT
         HZblufF7j6AMGvp2lGGX0e9hiXo4+PxyL20SnkcG4IlpzMSzm/X0a+jH2jW3XqNKJcDa
         X5Eg==
X-Gm-Message-State: ACgBeo2GrPfm6X6H2yvQJRnx6xXNGzYRUoQ+k504jYFPxOgWb8WhanhV
        IPNauqKQjKpNnNZHqZUsGjXsw30uhCxY3AvSJpvS92kZjIi7KF71EAhXfnkwHwoTERZjbjpLmFX
        Qo1pYHCKmkCWM5KcSOD3I4FVf
X-Received: by 2002:a05:6214:20ac:b0:497:ba:1794 with SMTP id 12-20020a05621420ac00b0049700ba1794mr1141855qvd.70.1661378873223;
        Wed, 24 Aug 2022 15:07:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4oLphmGtsx7ZGFDXs4wrjtumTOHJUPE+v4ohRZCr1d1q742enBAgLJWxYeeb/TD5WlPOSRrQ==
X-Received: by 2002:a05:6214:20ac:b0:497:ba:1794 with SMTP id 12-20020a05621420ac00b0049700ba1794mr1141841qvd.70.1661378872948;
        Wed, 24 Aug 2022 15:07:52 -0700 (PDT)
Received: from [192.168.1.52] (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id n1-20020ac86741000000b0031eebfcb369sm12935896qtp.97.2022.08.24.15.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:07:52 -0700 (PDT)
Message-ID: <f59ea139533f37991e786cd8cf4a0d591133d92c.camel@redhat.com>
Subject: Re: [PATCH] dmaengine: idxd: Set workqueue state to disabled before
 trying to re-enable
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Date:   Wed, 24 Aug 2022 15:07:51 -0700
In-Reply-To: <d0dbdd27-a890-1eea-63b5-ab6aaa27583e@intel.com>
References: <20220824192913.2425634-1-jsnitsel@redhat.com>
         <1417f4ce-2573-5c88-6c92-fda5c57ebceb@intel.com>
         <20220824211625.mfcyefi5yvasdt4r@cantor>
         <d0dbdd27-a890-1eea-63b5-ab6aaa27583e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTI0IGF0IDE0OjU5IC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOgo+IAo+
IE9uIDgvMjQvMjAyMiAyOjE2IFBNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+ID4gT24gV2Vk
LCBBdWcgMjQsIDIwMjIgYXQgMDE6Mjk6MDNQTSAtMDcwMCwgRGF2ZSBKaWFuZyB3cm90ZToKPiA+
ID4gT24gOC8yNC8yMDIyIDEyOjI5IFBNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+ID4gPiA+
IEZvciBhIHNvZnR3YXJlIHJlc2V0IGlkeGRfZGV2aWNlX3JlaW5pdCgpIGlzIGNhbGxlZCwgd2hp
Y2ggd2lsbAo+ID4gPiA+IHdhbGsKPiA+ID4gPiB0aGUgZGV2aWNlIHdvcmtxdWV1ZXMgdG8gc2Vl
IHdoaWNoIG9uZXMgd2VyZSBlbmFibGVkLCBhbmQgdHJ5Cj4gPiA+ID4gdG8KPiA+ID4gPiByZS1l
bmFibGUgdGhlbS4gSXQga2V5cyBvZmYgd3EtPnN0YXRlIGJlaW5nIGlEWERfV1FfRU5BQkxFRCwK
PiA+ID4gPiBidXQgdGhlCj4gPiA+ID4gZmlyc3QgdGhpbmcgaWR4ZF9lbmFibGVfd3EoKSB3aWxs
IGRvIGlzIHNlZSB0aGF0IHRoZSBzdGF0ZSBvZgo+ID4gPiA+IHRoZQo+ID4gPiA+IHdvcmtxdWV1
ZSBpcyBlbmFibGVkLCBhbmQgcmV0dXJuIDAgaW5zdGVhZCBvZiBhdHRlbXB0aW5nIHRvCj4gPiA+
ID4gaXNzdWUKPiA+ID4gPiBhIGNvbW1hbmQgdG8gZW5hYmxlIHRoZSB3b3JrcXVldWUuCj4gPiA+
ID4gCj4gPiA+ID4gU28gb25jZSBhIHdvcmtxdWV1ZSBpcyBmb3VuZCB0aGF0IG5lZWRzIHRvIGJl
IHJlLWVuYWJsZWQsCj4gPiA+ID4gc2V0IHRoZSBzdGF0ZSB0byBkaXNhYmxlZCBwcmlvciB0byBj
YWxsaW5nIGlkeGRfZW5hYmxlX3dxKCkuCj4gPiA+ID4gVGhpcyB3b3VsZCBhY2N1cmF0ZWx5IHJl
ZmxlY3QgdGhlIHN0YXRlIGlmIHRoZSBlbmFibGUgZmFpbHMKPiA+ID4gPiBhcyB3ZWxsLgo+ID4g
PiA+IAo+ID4gPiA+IENjOiBGZW5naHVhIFl1IDxmZW5naHVhLnl1QGludGVsLmNvbT4KPiA+ID4g
PiBDYzogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+Cj4gPiA+ID4gQ2M6IFZpbm9k
IEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+Cj4gPiA+ID4gQ2M6IGRtYWVuZ2luZUB2Z2VyLmtlcm5l
bC5vcmcKPiA+ID4gPiBGaXhlczogYmZlMWQ1NjA5MWMxICgiZG1hZW5naW5lOiBpZHhkOiBJbml0
IGFuZCBwcm9iZSBmb3IgSW50ZWwKPiA+ID4gPiBkYXRhIGFjY2VsZXJhdG9ycyIpCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogSmVycnkgU25pdHNlbGFhciA8anNuaXRzZWxAcmVkaGF0LmNvbT4KPiA+
ID4gPiAtLS0KPiA+ID4gPiDCoMKgIGRyaXZlcnMvZG1hL2lkeGQvaXJxLmMgfCAxICsKPiA+ID4g
PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4gPiA+IAo+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pZHhkL2lycS5jIGIvZHJpdmVycy9kbWEvaWR4ZC9pcnEu
Ywo+ID4gPiA+IGluZGV4IDc0M2VhZDVlYmM1Ny4uNzIzZWViNTMyOGQ2IDEwMDY0NAo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvZG1hL2lkeGQvaXJxLmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL2RtYS9p
ZHhkL2lycS5jCj4gPiA+ID4gQEAgLTUyLDYgKzUyLDcgQEAgc3RhdGljIHZvaWQgaWR4ZF9kZXZp
Y2VfcmVpbml0KHN0cnVjdAo+ID4gPiA+IHdvcmtfc3RydWN0ICp3b3JrKQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGlkeGRfd3EgKndxID0gaWR4ZC0+d3Fz
W2ldOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHdxLT5zdGF0
ZSA9PSBJRFhEX1dRX0VOQUJMRUQpIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHdxLT5zdGF0ZSA9IElEWERfV1FfRElTQUJMRUQ7Cj4gPiA+
IE1pZ2h0IGJlIGJldHRlciBvZmYgdG8gaW5zZXJ0IHRoaXMgbGluZSBpbgo+ID4gPiBpZHhkX3dx
X2Rpc2FibGVfY2xlYW51cCgpLiBJCj4gPiA+IHRoaW5rIHRoYXQgc2hvdWxkIHB1dCBpdCBpbiBz
YW5lIHN0YXRlLgo+ID4gSSBkb24ndCB0aGluayB0aGF0IGlzIGNhbGxlZCBpbiB0aGUgY29kZSBw
YXRoIHRoYXQgSSB3YXMgbG9va25nIGF0Lgo+ID4gSSd2ZSBiZWVuCj4gPiBsb29raW5nIGF0IHRo
aXMgYml0IG9mIHByb2Nlc3NfbWlzY19pbnRlcnJ1cHRzKCk6Cj4gPiAKPiA+IGhhbHQ6Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgZ2Vuc3RzLmJpdHMgPSBpb3JlYWQzMihpZHhkLT5yZWdfYmFzZSArCj4g
PiBJRFhEX0dFTlNUQVRTX09GRlNFVCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGdlbnN0cy5z
dGF0ZSA9PSBJRFhEX0RFVklDRV9TVEFURV9IQUxUKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlkeGQtPnN0YXRlID0gSURYRF9ERVZfSEFMVEVEOwo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZ2Vuc3RzLnJlc2V0X3R5cGUgPT0KPiA+IElEWERf
REVWSUNFX1JFU0VUX1NPRlRXQVJFKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogSWYgd2UgbmVlZCBhIHNvZnR3YXJlIHJlc2V0LCB3ZSB3aWxs
Cj4gPiB0aHJvdyB0aGUgd29yawo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogb24gYSBzeXN0ZW0gd29ya3F1ZXVlIGluIG9yZGVyIHRvIGFsbG93
Cj4gPiBpbnRlcnJ1cHRzCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKiBmb3IgdGhlIGRldmljZSBjb21tYW5kIGNvbXBsZXRpb25zLgo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBJTklUX1dPUksoJmlk
eGQtPndvcmssIGlkeGRfZGV2aWNlX3JlaW5pdCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBxdWV1ZV93b3JrKGlkeGQtPndxLCAmaWR4ZC0+d29y
ayk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZHhkLT5zdGF0ZSA9
IElEWERfREVWX0hBTFRFRDsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlkeGRfd3FzX3F1aWVzY2UoaWR4ZCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZHhkX3dxc191bm1hcF9wb3J0YWwoaWR4
ZCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBz
cGluX2xvY2soJmlkeGQtPmRldl9sb2NrKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlkeGRfZGV2aWNlX2NsZWFyX3N0YXRlKGlkeGQpOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2Vycigm
aWR4ZC0+cGRldi0+ZGV2LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJpZHhkIGhhbHRlZCwgbmVlZCAlcy5cbiIsCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZ2Vuc3RzLnJlc2V0X3R5cGUgPT0KPiA+IElEWERfREVWSUNFX1JFU0VUX0ZMUiA/
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIkZMUiIgOiAic3lzdGVtIHJlc2V0Iik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcGluX3VubG9jaygmaWR4ZC0+ZGV2X2xv
Y2spOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FTlhJTzsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4g
wqDCoMKgwqDCoMKgwqDCoH0KPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ID4g
fQo+ID4gCj4gPiBTbyBpdCBzZWVzIHRoYXQgdGhlIGRldmljZSBpcyBoYWx0ZWQsIGFuZCBzdGlj
a3MKPiA+IGlkeGRfZGV2aWNlX3JlaW5pbnQoKSBvbiB0aGF0Cj4gPiB3b3JrcXVldWUuIFRoZSBp
ZHhkX2RldmljZV9yZWluaXQoKSBoYXMgdGhpcyBsb29wIHRvIHJlLWVuYWJsZSB0aGUKPiA+IGlk
eGQgd3FzOgo+IAo+IGlkeGRfZGV2aWNlX3JlaW5pdCgpIHNob3VsZCBjYWxsZWQgaWR4ZF9kZXZp
Y2VfcmVzZXQoKSBmaXJzdC4gQW5kCj4gdGhhdCAKPiBzaG91bGQgYXQgc29tZSBwb2ludCBjYWxs
IGlkeGRfd3FfZGlzYWJsZV9jbGVhbnVwKCkgYW5kIGNsZWFuIHVwIHRoZQo+IHN0YXRlcy4KPiAK
PiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4wLXJjMi9zb3VyY2UvZHJpdmVy
cy9kbWEvaWR4ZC9pcnEuYyNMNDIKPiAKPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC92Ni4wLXJjMi9zb3VyY2UvZHJpdmVycy9kbWEvaWR4ZC9kZXZpY2UuYyNMNzI1Cj4gCj4gaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMC1yYzIvc291cmNlL2RyaXZlcnMvZG1h
L2lkeGQvZGV2aWNlLmMjTDcxMQo+IAo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y2LjAtcmMyL3NvdXJjZS9kcml2ZXJzL2RtYS9pZHhkL2RldmljZS5jI0wzNzYKPiAKPiBTbyBp
ZiB3ZSBzdGljayB0aGUgd3Egc3RhdGUgcmVzZXQgaW4gdGhlcmUsIGl0IHNob3VsZCBzaG93IHVw
IGFzIAo+ICJkaXNhYmxlZCIgYnkgdGhlIHRpbWUgd2UgdHJ5IHRvIGVuYWJsZSB0aGUgV1FzIGFn
YWluLiBEb2VzIHRoYXQgbG9vawo+IHJlYXNvbmFibGU/Cj4gCgpBaCwgeWVhaCBJIHNlZSB0aGF0
IG5vdy4gU28sIGlmIGl0IGRvZXMgc2V0IHRoZSBzdGF0ZSB0byBkaXNhYmxlZCBpbgppZHhkX3dx
X2Rpc2FibGVfY2xlYW51cCgpLCBkb2VzIGl0IGhhdmUgYW5vdGhlciBtZWFucyB0byB0cmFjayB3
aGljaAp3cXMgbmVlZCB0byBiZSByZS1lbmFibGVkIGZvciB0aGF0IGxvb3AgdGhhdCBoYXBwZW5z
IGFmdGVyIHRoZQppZHhkX2RldmljZV9yZXNldCgpIGNhbGw/Cgo+IAo+ID4gCj4gPiDCoMKgwqDC
oMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IGlkeGQtPm1heF93cXM7IGkrKykgewo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWR4ZF93cSAqd3EgPSBpZHhkLT53cXNb
aV07Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHdxLT5zdGF0
ZSA9PSBJRFhEX1dRX0VOQUJMRUQpIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHdxLT5zdGF0ZSA9IElEWERfV1FfRElTQUJMRUQ7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IGlkeGRfd3Ff
ZW5hYmxlKHdxKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmIChyYyA8IDApIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfd2FybihkZXYsICJVbmFibGUgdG8g
cmUtZW5hYmxlCj4gPiB3cSAlc1xuIiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9u
YW1lKHdxX2NvbmZkZXYod3EpKSk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0K
PiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiAKPiA+IE9uY2UgeW91IGdvIGludG8gaWR4ZF93cV9l
bmFibGUoKSB0aG91Z2ggeW91IGdldCB0aGlzIGNoZWNrIGF0IHRoZQo+ID4gYmVnaW5uaW5nOgo+
ID4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHdxLT5zdGF0ZSA9PSBJRFhEX1dRX0VOQUJMRUQp
IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2RiZyhkZXYsICJXUSAl
ZCBhbHJlYWR5IGVuYWJsZWRcbiIsIHdxLT5pZCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAwOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IAo+ID4gU28gSUlV
QyBpdCBzZWVzIHRoZSBkZXZpY2UgaXMgaGFsdGVkLCBnb2VzIHRvIHJlc2V0IGl0LCBmaWd1cmVz
IG91dAo+ID4gYSB3cQo+ID4gc2hvdWxkIGJlIHJlLWVuYWJsZWQsIGNhbGxzIGlkeGRfd3FfZW5h
YmxlKCkgd2hpY2ggaGl0cyB0aGUgY2hlY2ssCj4gPiByZXR1cm5zCj4gPiAwIGFuZCB0aGUgd3Eg
aXMgbmV2ZXIgcmVhbGx5IHJlLWVuYWJsZWQsIHRob3VnaCBpdCB3aWxsIHN0aWxsIGhhdmUKPiA+
IHdxIHN0YXRlCj4gPiBzZXQgdG8gSURYRF9XUV9FTkFCTEVELgo+ID4gCj4gPiBPciBhbSBJIG1p
c3Npbmcgc29tZXRoaW5nPwo+ID4gCj4gPiBSZWdhcmRzLAo+ID4gSmVycnkKPiA+IAo+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJjID0gaWR4
ZF93cV9lbmFibGUod3EpOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChyYyA8IDApIHsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X3dhcm4oZGV2
LCAiVW5hYmxlIHRvIHJlLQo+ID4gPiA+IGVuYWJsZSB3cSAlc1xuIiwKPiAKCg==

