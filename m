Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0423D577A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 06:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiGRE7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 00:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiGRE7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 00:59:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264467645;
        Sun, 17 Jul 2022 21:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658120348; x=1689656348;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qeKJcinBB3mkIces9jI+jR3eKChoBKBK4dt6bT09gf4=;
  b=XlIL2k8ijMYy+zm/aHLaPoVwQjL0xcILU1ornPHCTCnfXoYuSd3pBplG
   gpWZSLETRboauHWULjqlvlZMeITMOwACccaVJRESWbuiYA7yFPdcl4mLL
   FaFrqBe+9cxfs1E19yZ9+VYLgyE4iss+B7HDXQojvEs/T/dB4jn5AdCXj
   m6saSYEqiGIUlvGIwMs5JbDQx/XdFgBoGhlhorICP3ZQGzGsG7dzGz44x
   3EdOc7L/dXpOFyfyWEcKos52mrIZIfkHF7pKVwUclJNjI4xGcrCbsJOtu
   3iKzXvv07aw3AnWQyY2wdSHqQb/4O6zR96rmDTW0c6PerpsrTeDbkNhhb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="286870193"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="286870193"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 21:59:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="594336499"
Received: from lananhtr-mobl3.ccr.corp.intel.com ([10.215.250.14])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 21:59:04 -0700
Message-ID: <aeb6a9d2447a8bbd7d386f88a7f72b33253776c7.camel@intel.com>
Subject: Re: [PATCH v3 2/4] thermal/core: Avoid calling ->get_trip_temp()
 unnecessarily
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Jul 2022 12:59:04 +0800
In-Reply-To: <20220715210911.714479-2-daniel.lezcano@linaro.org>
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
         <20220715210911.714479-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTE1IGF0IDIzOjA5ICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToK
PiBBcyB0aGUgdHJpcCB0ZW1wZXJhdHVyZSBpcyBhbHJlYWR5IGF2YWlsYWJsZSB3aGVuIGNhbGxp
bmcgdGhlCj4gZnVuY3Rpb24KPiBoYW5kbGVfY3JpdGljYWxfdHJpcHMoKSwgcGFzcyBpdCBhcyBh
IHBhcmFtZXRlciBpbnN0ZWFkIG9mIGhhdmluZwo+IHRoaXMKPiBmdW5jdGlvbiBjYWxsaW5nIHRo
ZSBvcHMgYWdhaW4gdG8gcmV0cmlldmUgdGhlIHNhbWUgZGF0YS4KPiAKPiBSZXZpZXdlZC1ieTog
THVrYXN6IEx1YmEgPGx1a2Fzei5sdWJhQGFybS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVs
IExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+Cj4gLS0tCj4gwqAgdjM6Cj4gwqDC
oCAtIE1hc3NhZ2VkIHRoZSBwYXRjaCB0aXRsZSBhbmQgdGhlIGRlc2NyaXB0aW9uCj4gLS0tCj4g
wqBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfCA4ICsrLS0tLS0tCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMKPiBiL2RyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX2NvcmUuYwo+IGluZGV4IGQ5Zjc3MWIxNWVkOC4uZjY2MDM2YjNkYWFlIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMvdGhlcm1h
bC90aGVybWFsX2NvcmUuYwo+IEBAIC0zNDAsMTIgKzM0MCw4IEBAIHZvaWQgdGhlcm1hbF96b25l
X2RldmljZV9jcml0aWNhbChzdHJ1Y3QKPiB0aGVybWFsX3pvbmVfZGV2aWNlICp0eikKPiDCoEVY
UE9SVF9TWU1CT0wodGhlcm1hbF96b25lX2RldmljZV9jcml0aWNhbCk7Cj4gwqAKPiDCoHN0YXRp
YyB2b2lkIGhhbmRsZV9jcml0aWNhbF90cmlwcyhzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAq
dHosCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaW50IHRyaXAsIGVudW0gdGhlcm1hbF90cmlwX3R5cGUKPiB0cmlwX3R5
cGUpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaW50IHRyaXAsIGludCB0cmlwX3RlbXAsIGVudW0KPiB0aGVybWFsX3Ry
aXBfdHlwZSB0cmlwX3R5cGUpCgpUaGlzIGluZGVudCBjbGVhbnVwIGJlbG9uZ3MgdG8gcGF0Y2gg
MS80LgpPdGhlciB0aGFuIHRoYXQsCgpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdA
aW50ZWwuY29tPgoKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBpbnQgdHJpcF90ZW1wOwo+IC0KPiAt
wqDCoMKgwqDCoMKgwqB0ei0+b3BzLT5nZXRfdHJpcF90ZW1wKHR6LCB0cmlwLCAmdHJpcF90ZW1w
KTsKPiAtCj4gwqDCoMKgwqDCoMKgwqDCoC8qIElmIHdlIGhhdmUgbm90IGNyb3NzZWQgdGhlIHRy
aXBfdGVtcCwgd2UgZG8gbm90IGNhcmUuICovCj4gwqDCoMKgwqDCoMKgwqDCoGlmICh0cmlwX3Rl
bXAgPD0gMCB8fCB0ei0+dGVtcGVyYXR1cmUgPCB0cmlwX3RlbXApCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4gQEAgLTM5NCw3ICszOTAsNyBAQCBzdGF0aWMgdm9p
ZCBoYW5kbGVfdGhlcm1hbF90cmlwKHN0cnVjdAo+IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6LCBp
bnQgdHJpcCkKPiDCoMKgwqDCoMKgwqDCoMKgaGFuZGxlX3RoZXJtYWxfdHJpcF9jcm9zc2VkKHR6
LCB0cmlwLCB0cmlwX3RlbXAsIGh5c3QsIHR5cGUpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGlm
ICh0eXBlID09IFRIRVJNQUxfVFJJUF9DUklUSUNBTCB8fCB0eXBlID09Cj4gVEhFUk1BTF9UUklQ
X0hPVCkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaGFuZGxlX2NyaXRpY2FsX3Ry
aXBzKHR6LCB0cmlwLCB0eXBlKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaGFu
ZGxlX2NyaXRpY2FsX3RyaXBzKHR6LCB0cmlwLCB0cmlwX3RlbXAsIHR5cGUpOwo+IMKgwqDCoMKg
wqDCoMKgwqBlbHNlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBoYW5kbGVfbm9u
X2NyaXRpY2FsX3RyaXBzKHR6LCB0cmlwKTsKPiDCoMKgwqDCoMKgwqDCoMKgLyoKCg==

