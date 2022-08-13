Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7723591C15
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 19:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbiHMRHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 13:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiHMRH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 13:07:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F040C9FF2;
        Sat, 13 Aug 2022 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660410448; x=1691946448;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8JIR55KVpVczeMSzI16rkRrK4N4LiEJhYkeeglEzVXE=;
  b=nKooIKfOUD9+PPhPQs//eLz8HdSPRpuBABAtQjcSP38yorOWrxS7Ky3q
   NnYc+aMQjpMdhFpahh5z6Fezc3QmzcZ/pR6buE38UJvFJCK0DV7088ue6
   sqyVgriq8EXocP1IFpJm+vquB8X0D7GYQwNL1IlL6O9itchfNOEroX0Lv
   UsvZLaSmT9DVlaTOW6QiWiUJxFrfBBmFDFUvKzApeRxpE8z2GU/sbBWno
   VXbsFSCceJrzt0s32jgwvNi5ahJibwoCkqh+YZ+xz+KW7jIzS1XnMj5ca
   5OcXb5Smu1CRzou+YZ8G+g5/S17ctfCZ5cAjZ7aSWgUIic2pyeqxgXTr+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="290519314"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="290519314"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 10:07:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="635006249"
Received: from zhenghwe-mobl.gar.corp.intel.com ([10.214.145.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 10:07:22 -0700
Message-ID: <e5a8d07eda23baf07a89ebf54b70d1cfab183837.camel@intel.com>
Subject: Re: [PATCH 3/7] hwmon/coretemp: Handle large core id value
From:   Zhang Rui <rui.zhang@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Date:   Sun, 14 Aug 2022 01:07:14 +0800
In-Reply-To: <YveBgsVINyKjXW9g@gmail.com>
References: <20220812164144.30829-1-rui.zhang@intel.com>
         <20220812164144.30829-4-rui.zhang@intel.com> <YveBgsVINyKjXW9g@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIyLTA4LTEzIGF0IDEyOjQ4ICswMjAwLCBJbmdvIE1vbG5hciB3cm90ZToKPiAK
PiAqIFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4gd3JvdGU6Cj4gCj4gPiBUaGUgY29y
ZXRlbXAgZHJpdmVyIHN1cHBvcnRzIHVwIHRvIGEgaGFyZC1jb2RlZCBsaW1pdCBvZiAxMjggY29y
ZXMuCj4gPiAKPiA+IFRvZGF5LCB0aGUgZHJpdmVyIGNhbiBub3Qgc3VwcG9ydCBhIGNvcmUgd2l0
aCBhbiBpZCBhYm92ZSB0aGF0Cj4gPiBsaW1pdC4KPiA+IFlldCwgdGhlIGVuY29kaW5nIG9mIGNv
cmVfaWQncyBpcyBhcmJpdHJhcnkgKEJJT1MgQVBJQy1pZCkgYW5kIHNvCj4gPiB0aGV5Cj4gPiBt
YXkgYmUgc3BhcnNlIGFuZCB0aGV5IG1heSBiZSBsYXJnZS4KPiA+IAo+ID4gVXBkYXRlIHRoZSBk
cml2ZXIgdG8gbWFwIGFyYml0cmFyeSBjb3JlX2lkIG51bWJlcnMgaW50byBhcHByb3ByaWF0ZQo+
ID4gYXJyYXkgaW5kZXhlcyBzbyB0aGF0IDEyOCBjb3JlcyBjYW4gYmUgc3VwcG9ydGVkLCBubyBt
YXR0ZXIgdGhlCj4gPiBlbmNvZGluZwo+ID4gb2YgY29yZV9pZHMncy4KPiAKPiBQbGVhc2UgY2Fw
aXRhbGl6ZSAnSUQnIGNvbnNpc3RlbnRseSB0aHJvdWdob3V0IHRoZSBzZXJpZXMuCj4gCj4gPiAt
wqDCoMKgwqDCoMKgwqBhdHRyX25vID0gcGtnX2ZsYWcgPyBQS0dfU1lTRlNfQVRUUl9OTyA6IFRP
X0FUVFJfTk8oY3B1KTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChwa2dfZmxhZykKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhdHRyX25vID0gUEtHX1NZU0ZTX0FUVFJfTk87Cj4g
PiArwqDCoMKgwqDCoMKgwqBlbHNlIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpbmRleCA9IGlkYV9hbGxvYygmcGRhdGEtPmlkYSwgR0ZQX0tFUk5FTCk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGluZGV4IDwgMCkKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGluZGV4Owo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBkYXRhLT5jcHVfbWFwW2luZGV4XSA9IHRvcG9sb2d5
X2NvcmVfaWQoY3B1KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhdHRyX25v
ID0gaW5kZXggKyBCQVNFX1NZU0ZTX0FUVFJfTk87Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gCj4g
VW5iYWxhbmNlZCBjdXJseSBicmFjZXMuCgpTdXJlLCB3aWxsIGZpeCB0aGVzZSB0d28gaXNzdWVz
IGluIG5leHQgdmVyc2lvbi4KCj4gCj4gPiAtwqDCoMKgwqDCoMKgwqBpbnQgZXJyLCBhdHRyX25v
Owo+ID4gK8KgwqDCoMKgwqDCoMKgaW50IGVyciwgaW5kZXgsIGF0dHJfbm87Cj4gCj4gU28gaXQn
cyAnaW5kZXgnIGhlcmUuCj4gCj4gPiBAQCAtNTI0LDYgKzUzOCw4IEBAIHN0YXRpYyB2b2lkIGNv
cmV0ZW1wX3JlbW92ZV9jb3JlKHN0cnVjdAo+ID4gcGxhdGZvcm1fZGF0YSAqcGRhdGEsIGludCBp
bmR4KQo+IAo+IEJ1dCAnaW5keCcgaGVyZS4KPiAKPiA+IC3CoMKgwqDCoMKgwqDCoGludCBpbmR4
LCB0YXJnZXQ7Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgaSwgaW5keCA9IC0xLCB0YXJnZXQ7Cj4g
Cj4gQW5kICdpbmR4JyBhZ2Fpbi4gRGlkIHdlIHJ1biBvdXQgb2YgdGhlIGxldHRlciAnZSc/IEVp
dGhlciB1c2UKPiAnaW5kZXgnIAo+IG5hbWluZyBjb25zaXN0ZW50bHksIG9yICdpZHgnIGlmIGl0
IGhhcyB0byBiZSBhYmJyZXZpYXRlZC4KCkknZCBwcmVmZXIgJ2luZGV4JywgYnV0IGhlcmUsIHRo
aXMgJ2luZHgnIGlzIGZyb20gcHJldmlvdXMgY29kZSBhbmQKdGhpcyBwYXRjaCBqdXN0IGluaXRp
YWxpemVzIGl0IHRvIC0xLgoKdGhhbmtzLApydWkKPiAKPiBUaGFua3MsCj4gCj4gwqDCoMKgwqDC
oMKgwqDCoEluZ28KCg==

