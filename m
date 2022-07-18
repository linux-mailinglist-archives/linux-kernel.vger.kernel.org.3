Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568A3577A34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 06:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiGRE6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 00:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiGRE6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 00:58:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877412AC3;
        Sun, 17 Jul 2022 21:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658120298; x=1689656298;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Tf6RP+3TW2VwpFfY2QBBHXXDIuJugJ+MQ70PeiCqSWs=;
  b=LAsRy+MbAqqqe55RmOooa+scf/HR/PlKJ1V+H+XLdnp/UsEh/+sfAGgP
   0SQizVtCQYOFjqnjFYSfuBiHMqp2pUsYhIXdQj0TYQl9cA/wHQ5JkBL9D
   JPWx+Ksstq8SSHjsbqTn53WoeXSA7YYl5qiZNE5vh95x2TkVVbMGoEd1K
   kGtlmveyylKsDze8FVmx6WFRjmGSvMI8ms5FMSv2du+pVwWjBIiruV+/S
   uTdAPHFilWsL6wR7WKbSyDFzpwwSzzvemwXlZryPZon8j4snF3vN5jTn6
   b10DsV+zL1dixZs/GmTyxPl5Xx4pOiX2j9hGv+6GT6sk9ANXUHML0C8pz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="347821121"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="347821121"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 21:58:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="547342170"
Received: from lananhtr-mobl3.ccr.corp.intel.com ([10.215.250.14])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 21:58:07 -0700
Message-ID: <77906f0518ea8c56d8967455b7315c150d443ec9.camel@intel.com>
Subject: Re: [PATCH v3 1/4] thermal/core: Encapsulate the trip point crossed
 function
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Jul 2022 12:58:04 +0800
In-Reply-To: <20220715210911.714479-1-daniel.lezcano@linaro.org>
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTE1IGF0IDIzOjA5ICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToK
PiBUaGUgcm91dGluZSB3aGVyZSB0aGUgdHJpcCBwb2ludCBjcm9zc2VkIGlzIGRldGVjdGVkIGlz
IGEgc3RyYXRlZ2ljCj4gcGxhY2Ugd2hlcmUgZGlmZmVyZW50IHByb2Nlc3Npbmcgd2lsbCBoYXBw
ZW4uIEVuY2Fwc3VsYXRlIHRoZSBjb2RlIGluCj4gYSBmdW5jdGlvbiwgc28gYWxsIHNwZWNpZmlj
IGFjdGlvbnMgcmVsYXRlZCB3aXRoIGEgdHJpcCBwb2ludCBjcm9zc2VkCj4gY2FuIGJlIGdyb3Vw
ZWQuCj4gCj4gUmV2aWV3ZWQtYnk6IEx1a2FzeiBMdWJhIDxsdWthc3oubHViYUBhcm0uY29tPgo+
IFNpZ25lZC1vZmYtYnk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3Jn
PgoKUmV2aWV3ZWQgYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KCj4gLS0tCj4g
wqBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfCAzMCArKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMCBkZWxl
dGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5j
Cj4gYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMKPiBpbmRleCBjZGMwNTUyZThjNDIu
LmQ5Zjc3MWIxNWVkOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3Jl
LmMKPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMKPiBAQCAtMzU4LDYgKzM1
OCwyNSBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfY3JpdGljYWxfdHJpcHMoc3RydWN0Cj4gdGhlcm1h
bF96b25lX2RldmljZSAqdHosCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0ei0+
b3BzLT5jcml0aWNhbCh0eik7Cj4gwqB9Cj4gwqAKPiArc3RhdGljIHZvaWQgaGFuZGxlX3RoZXJt
YWxfdHJpcF9jcm9zc2VkKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlCj4gKnR6LCBpbnQgdHJp
cCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50IHRyaXBfdGVtcCwgaW50IHRyaXBfaHlzdCwK
PiBlbnVtIHRoZXJtYWxfdHJpcF90eXBlIHRyaXBfdHlwZSkKPiArewo+ICvCoMKgwqDCoMKgwqDC
oGlmICh0ei0+bGFzdF90ZW1wZXJhdHVyZSA9PSBUSEVSTUFMX1RFTVBfSU5WQUxJRCkKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBp
ZiAodHotPmxhc3RfdGVtcGVyYXR1cmUgPCB0cmlwX3RlbXAgJiYKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdHotPnRlbXBlcmF0dXJlID49IHRyaXBfdGVtcCkgewo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB0aGVybWFsX25vdGlmeV90el90cmlwX3VwKHR6LT5pZCwgdHJpcCwKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHotPnRlbXBlcmF0dXJlKTsKPiArwqDCoMKgwqDCoMKg
wqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmICh0ei0+bGFzdF90ZW1wZXJhdHVyZSA+PSB0cmlw
X3RlbXAgJiYKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHotPnRlbXBlcmF0dXJlIDwgKHRyaXBf
dGVtcCAtIHRyaXBfaHlzdCkpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGhl
cm1hbF9ub3RpZnlfdHpfdHJpcF9kb3duKHR6LT5pZCwgdHJpcCwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHR6LT50ZW1wZXJhdHVyZSk7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICt9Cj4g
Kwo+IMKgc3RhdGljIHZvaWQgaGFuZGxlX3RoZXJtYWxfdHJpcChzdHJ1Y3QgdGhlcm1hbF96b25l
X2RldmljZSAqdHosIGludAo+IHRyaXApCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoGVudW0gdGhl
cm1hbF90cmlwX3R5cGUgdHlwZTsKPiBAQCAtMzcyLDE2ICszOTEsNyBAQCBzdGF0aWMgdm9pZCBo
YW5kbGVfdGhlcm1hbF90cmlwKHN0cnVjdAo+IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6LCBpbnQg
dHJpcCkKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHR6LT5vcHMtPmdldF90cmlwX2h5c3QpCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0ei0+b3BzLT5nZXRfdHJpcF9oeXN0KHR6LCB0
cmlwLCAmaHlzdCk7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBpZiAodHotPmxhc3RfdGVtcGVyYXR1
cmUgIT0gVEhFUk1BTF9URU1QX0lOVkFMSUQpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKHR6LT5sYXN0X3RlbXBlcmF0dXJlIDwgdHJpcF90ZW1wICYmCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0ei0+dGVtcGVyYXR1cmUgPj0gdHJpcF90ZW1w
KQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGhlcm1h
bF9ub3RpZnlfdHpfdHJpcF91cCh0ei0+aWQsIHRyaXAsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0ei0+dGVtcGVyYXR1cmUpOwo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAodHotPmxhc3RfdGVtcGVyYXR1cmUgPj0gdHJpcF90ZW1wICYmCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0ei0+dGVtcGVyYXR1cmUgPCAo
dHJpcF90ZW1wIC0gaHlzdCkpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB0aGVybWFsX25vdGlmeV90el90cmlwX2Rvd24odHotPmlkLCB0cmlwLAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR6LT50ZW1wZXJhdHVy
ZSk7Cj4gLcKgwqDCoMKgwqDCoMKgfQo+ICvCoMKgwqDCoMKgwqDCoGhhbmRsZV90aGVybWFsX3Ry
aXBfY3Jvc3NlZCh0eiwgdHJpcCwgdHJpcF90ZW1wLCBoeXN0LCB0eXBlKTsKPiDCoAo+IMKgwqDC
oMKgwqDCoMKgwqBpZiAodHlwZSA9PSBUSEVSTUFMX1RSSVBfQ1JJVElDQUwgfHwgdHlwZSA9PQo+
IFRIRVJNQUxfVFJJUF9IT1QpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBoYW5k
bGVfY3JpdGljYWxfdHJpcHModHosIHRyaXAsIHR5cGUpOwoK

