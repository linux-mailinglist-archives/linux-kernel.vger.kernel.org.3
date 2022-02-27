Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426B24C5AAA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiB0Ljm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiB0Ljj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:39:39 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC1F22B2D;
        Sun, 27 Feb 2022 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1645961942; x=1677497942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A0u9r67Xv86vDPaYoZYYNpSu33vEfgVLUOgNVbmQ9Ks=;
  b=UytEsWfdFzH01kTrHD4rK/p+GBjPaoStKEEn3c0Ma2s3Zjxl99UyXsQu
   z11K17QEIUFj0BeyhZzK1mAIy/c/z+ea37CEuX5CJyu6YT27Da/qLfSRi
   9/qYStgBufqqsEnTBQHe+8z3kPps42sTdmXACmpxvL38PLv8IqDnbHq5i
   0=;
X-IronPort-AV: E=Sophos;i="5.90,141,1643673600"; 
   d="scan'208";a="178640483"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 27 Feb 2022 11:38:47 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com (Postfix) with ESMTPS id 3A1EBA08F6;
        Sun, 27 Feb 2022 11:38:46 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sun, 27 Feb 2022 11:38:46 +0000
Received: from [0.0.0.0] (10.43.162.43) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.28; Sun, 27 Feb
 2022 11:38:43 +0000
Message-ID: <b023481d-7a25-2343-63d9-0a34874f2ba8@amazon.com>
Date:   Sun, 27 Feb 2022 12:38:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
To:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220226220639.1173594-1-Jason@zx2c4.com>
 <20220226220639.1173594-3-Jason@zx2c4.com>
 <CAMj1kXGRjdjbedQTU8ab+Q4jJPnN7nxc8_4QNiG3R7JE=zk-wA@mail.gmail.com>
 <CAHmME9rPd8Nu8Q0+R6B4Bz-caKpq5SSvLaiKdwXcyNHY8Ebfqg@mail.gmail.com>
 <CAMj1kXEwsyPcoTvK6PZyA5L3q9u_dd_wXUiyHw7TtPM5LecP7g@mail.gmail.com>
 <CAMj1kXHAeqrPjMZi_VD6fYWXatV5UUy5N3ZbtZf=SaDpN3GPVQ@mail.gmail.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <CAMj1kXHAeqrPjMZi_VD6fYWXatV5UUy5N3ZbtZf=SaDpN3GPVQ@mail.gmail.com>
X-Originating-IP: [10.43.162.43]
X-ClientProxiedBy: EX13D34UWA001.ant.amazon.com (10.43.160.173) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDI3LjAyLjIyIDExOjQ3LCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiBPbiBTdW4sIDI3IEZl
YiAyMDIyIGF0IDExOjMwLCBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPiB3cm90ZToK
Pj4gT24gU3VuLCAyNyBGZWIgMjAyMiBhdCAxMTowMywgSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNv
bkB6eDJjNC5jb20+IHdyb3RlOgo+Pj4gT24gMi8yNy8yMiwgQXJkIEJpZXNoZXV2ZWwgPGFyZGJA
a2VybmVsLm9yZz4gd3JvdGU6Cj4+Pj4gT24gU2F0LCAyNiBGZWIgMjAyMiBhdCAyMzowNywgSmFz
b24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+IHdyb3RlOgo+Pj4+PiBGcm9tOiBBbGV4
YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgo+Pj4+Pgo+Pj4+IFBsZWFzZSBkb24ndCBpbnZl
bnQgcGF0Y2ggYXV0aG9ycyBsaWtlIHRoYXQuIEFsZXgncyBwYXRjaCB0aGF0IHN0YXJ0ZWQKPj4+
PiB0aGlzIGRpc2N1c3Npb24gd2FzIGNvbXBsZXRlbHkgZGlmZmVyZW50Lgo+Pj4gQ29uc2lkZXJp
bmcgdGhlIGludmVzdGlnYXRpdmUgc2lkZSAoIndoeSB3b24ndCB0aGUgX0NJRCBtYXRjaD8iKSBh
bmQKPj4+IG1vc3QgdGhlIGNvbW1pdCBtZXNzYWdlIHdlcmUgQWxleCdzLCBhbmQgdGhhdCB0aG9z
ZSB0aGluZ3MgY29tcHJpc2UKPj4+IDk1JSBvZiB3aGF0IHRoaXMgcGF0Y2ggaXMsIGFuZCB0aGF0
IHRoZSBjb2RlIGNoYW5nZSBpdHNlbGYgaXNuJ3QgZXZlbgo+Pj4gcGFydCBvZiBhbnl0aGluZyBU
dXJpbmcgY29tcGxldGUsIEkgbW9zdCBjZXJ0YWlubHkgZGlkIG5vdCBmZWVsCj4+PiBjb21mb3J0
YWJsZSBzdHJpcHBpbmcgQWxleCdzIGF1dGhvcnNoaXAuIEluc3RlYWQgSSBhZGRlZCBteXNlbGYg
YXMgYQo+Pj4gY28tYXV0aG9yIGF0IHRoZSBib3R0b20uIFdoZW4gaW4gZG91YnQsIGVyciBvbiB0
aGUgc2lkZSBvZiBjcmVkaXRpbmcKPj4+IG90aGVycy4gQWxleCBhbHNvIHRvb2sgYSBsb29rIGF0
IHRoaXMgcGF0Y2gsIEkgYW0gdW5kZXIgdGhlIGltcHJlc3Npb24KPj4+IG9mIGF0IGxlYXN0LCBi
ZWZvcmUgaXQgd2VudCBvdXQuIExldCdzIG1pbmltaXplIHRoZSBwYXBlcndvcmsKPj4+IHBvbGlj
aW5nLCBva2F5PyBJIHRoaW5rIGl0J2QgbWFrZSBmb3IgYSBtdWNoIG1vcmUgcGxlYXNhbnQgc3Bh
Y2UgaGVyZS4KPiAuLi4KPj4gUGxlYXNlIHN0b3Agd2l0aCB0aGUgYWQgaG9taW5lbXMgaW4gcmVz
cG9uc2UgdG8gY3JpdGljaXNtIG9uIGZhY3R1YWwKPj4gYXNwZWN0cyBvZiB5b3VyIGNvZGUuIFB1
dHRpbmcgc29tZW9uZSBlbHNlJ3MgYXV0aG9yc2hpcCBvbiBjb2RlIHRoZXkKPj4gZGlkIG5vdCB3
cml0ZSBpcyBub3QgY29vbCwgYW5kIHBvaW50aW5nIHRoYXQgb3V0IGlzICpub3QqIHdoYXQgaXMK
Pj4gbWFraW5nIHRoaXMgc3BhY2UgdW5wbGVhc2FudC4KPj4gQW5kICdwYXBlcndvcmsgcG9saWNp
bmcnIGlzIHNhZGx5IGFuIGltcG9ydGFudCBhc3BlY3Qgb2YgYSBoaWdoCj4+IHByb2ZpbGUgb3Bl
biBzb3VyY2UgcHJvamVjdCBzdWNoIGFzIExpbnV4Lgo+Pgo+IEkgdHlwZWQgdGhpcyBiZWZvcmUg
cmVhZGluZyB5b3VyIG1lc3NhZ2Ugb24gSVJDLCB3aGljaCByZWFkczoKPgo+ICJBbGV4IGxvb2tl
ZCBhdCB0aGF0IHBhdGNoIGJlZm9yZSBpIHNlbnQgaXQgb3V0IGFuZCBkaWQgbm90IG9iamVjdCB0
bwo+IG1lIGtlZXBpbmcgaGlzIGF1dGhvcnNoaXAuIEkgd291bGRuJ3QgaGF2ZSBzZW50IGl0IG91
dCBvdGhlcndpc2UuIgo+Cj4gYW5kIHNvIEkgc3RhbmQgY29ycmVjdGVkIGlmIHRoaXMgaXMgdHJ1
ZS4gQnV0IHBsZWFzZSwgbmV4dCB0aW1lLAo+IHBsZWFzZSBiZSBtb3JlIGNsZWFyIGFib3V0IHRo
ZXNlIHRoaW5ncy4KCgpZZXMsIGhlIGRpZCByZWFjaCBvdXQgdG8gbWUgb24gYSBzZXBhcmF0ZSBj
aGFubmVsIGFuZCBJIHRvbGQgaGltIHRvIGdvIApmb3IgaXQgOikuIFNvcnJ5IGlmIEkgY3JlYXRl
ZCBzb21lIGNvbmZ1c2lvbiB3aXRoIHRoYXQuCgoKVGhhbmtzLAoKQWxleAoKCgoKCkFtYXpvbiBE
ZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxp
bgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNz
CkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkx
NzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

