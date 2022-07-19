Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9996A578F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiGSBHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbiGSBHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:07:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A2D1183D;
        Mon, 18 Jul 2022 18:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658192822; x=1689728822;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xvWlsHi150ZObwwbHbVESUt2dAgbWc4I4gwhOB0n8uM=;
  b=EvXDZ6SoJ5+ocUVb86rZlBanx7EkF0psYEH8W7/ljWGvTCyFsYYo1rHp
   Oryflt7CVBjV4eaGZ0Z6xNBx3xcmasfKHgrPGj/mHg7tltO36Yu/yXi0s
   awjexp0M4ck0rojrk0lqAnKDPBX2QOTOHEGPgDbECeK80gjHPu89zdNJ0
   1Hy0KpPDi19RNSDXHzoRxJ1DsbcmVGvjsEpBI9kFsMyXgBzvzRM0wX4pZ
   s4Dw1KgRZ6a6VQiRuRgThTbdVcVlNKJPONovpCFu9DeFE7597oW8RHdgD
   RCa6qkJAMeYmseATwSnVk7a9IiKebStpPaVirGyni6qJbnIAzAHqBxu0k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="312042304"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="312042304"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:07:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="665224839"
Received: from dukechan-mobl.gar.corp.intel.com ([10.215.250.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:06:59 -0700
Message-ID: <b83d6630bb133b2c02b4a4e5e7777ad27f8fe159.camel@intel.com>
Subject: Re: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes
 for the trip points
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Jul 2022 09:07:01 +0800
In-Reply-To: <387c126a-0106-2227-4b4a-db284965b6ca@linaro.org>
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
         <20220715210911.714479-3-daniel.lezcano@linaro.org>
         <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
         <387c126a-0106-2227-4b4a-db284965b6ca@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA3LTE4IGF0IDE2OjMyICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToK
PiBPbiAxOC8wNy8yMDIyIDA3OjI4LCBaaGFuZyBSdWkgd3JvdGU6Cj4gPiBPbiBGcmksIDIwMjIt
MDctMTUgYXQgMjM6MDkgKzAyMDAsIERhbmllbCBMZXpjYW5vIHdyb3RlOgo+ID4gPiBCeSBjb252
ZW50aW9uIHRoZSB0cmlwcyBwb2ludHMgYXJlIGRlY2xhcmVkIGluIHRoZSBhc2NlbmRpbmcKPiA+
ID4gdGVtcGVyYXR1cmUgb3JkZXIuIEhvd2V2ZXIsIG5vIHNwZWNpZmljYXRpb24gZm9yIHRoZSBk
ZXZpY2UgdHJlZSwKPiA+ID4gQUNQSQo+ID4gPiBvciBkb2N1bWVudGF0aW9uIHRlbGxzIHRoZSB0
cmlwIHBvaW50cyBtdXN0IGJlIG9yZGVyZWQgdGhpcyB3YXkuCj4gPiA+IAo+ID4gPiBJbiB0aGUg
b3RoZXIgaGFuZCwgd2UgbmVlZCB0aG9zZSB0byBiZSBvcmRlcmVkIHRvIGJyb3dzZSB0aGVtIGF0
Cj4gPiA+IHRoZQo+ID4gPiB0aGVybWFsIGV2ZW50cy4gQnV0IGlmIHdlIGFzc3VtZSB0aGV5IGFy
ZSBvcmRlcmVkIGFuZCBjaGFuZ2UgdGhlCj4gPiA+IGNvZGUKPiA+ID4gYmFzZWQgb24gdGhpcyBh
c3N1bXB0aW9uLCBhbnkgcGxhdGZvcm0gd2l0aCBzaHVmZmxlZCB0cmlwIHBvaW50cwo+ID4gPiBk
ZXNjcmlwdGlvbiB3aWxsIGJlIGJyb2tlbiAoaWYgdGhleSBleGlzdCkuCj4gPiA+IAo+ID4gPiBJ
bnN0ZWFkIG9mIHRha2luZyB0aGUgcmlzayBvZiBicmVha2luZyB0aGUgZXhpc3RpbmcgcGxhdGZv
cm1zLAo+ID4gPiB1c2UgYW4KPiA+ID4gYXJyYXkgb2YgdGVtcGVyYXR1cmUgb3JkZXJlZCB0cmlw
IGlkZW50aWZpZXJzIGFuZCBtYWtlIGl0Cj4gPiA+IGF2YWlsYWJsZQo+ID4gPiBmb3IgdGhlIGNv
ZGUgbmVlZGluZyB0byBicm93c2UgdGhlIHRyaXAgcG9pbnRzIGluIGFuIG9yZGVyZWQgd2F5Lgo+
ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5v
QGxpbmFyby5vcmc+Cj4gCj4gWyAuLi4gXQo+IAo+ID4gPiArc3RhdGljIHZvaWQgc29ydF90cmlw
c19pbmRleGVzKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eikKPiA+ID4gK3sKPiA+ID4g
K8KgwqDCoMKgwqDCoMKgaW50IGksIGo7Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgZm9y
IChpID0gMDsgaSA8IHR6LT50cmlwczsgaSsrKQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgdHotPnRyaXBzX2luZGV4ZXNbaV0gPSBpOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoGZvciAoaSA9IDA7IGkgPCB0ei0+dHJpcHM7IGkrKykgewo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZm9yIChqID0gaSArIDE7IGogPCB0ei0+dHJpcHM7IGorKykg
ewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlu
dCB0MSwgdDI7Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB0ei0+b3BzLT5nZXRfdHJpcF90ZW1wKHR6LCB0ei0KPiA+ID4gPiB0cmlw
c19pbmRleGVzW2ldLCAmdDEpOwo+ID4gCj4gPiBUaGlzIGxpbmUgY2FuIGJlIG1vdmVkIHRvIHRo
ZSB1cHBlciBsb29wLgo+ID4gCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgdHotPm9wcy0+Z2V0X3RyaXBfdGVtcCh0eiwgdHotCj4gPiA+ID4gdHJp
cHNfaW5kZXhlc1tqXSwgJnQyKTsKPiAKPiAKPiBBY3R1YWxseSwgd2UgY2FuIG5vdCBtb3ZlIHRo
ZSBsaW5lIHVwIGJlY2F1c2Ugb2YgdGhlIHN3YXAgYmVsb3cKCk9oLCByaWdodC4KCkJ1dCBJIHN0
aWxsIHRoaW5rIHRoYXQgd2Ugc2hvdWxkIGNoZWNrIHRoZSBkaXNhYmxlZCB0cmlwcyBhcyB3ZWxs
IGFzCnRoZSAuZ2V0X3RyaXBfdGVtcCgpIHJldHVybiB2YWx1ZSBoZXJlLCBvciBlbHNlLCB3ZSBt
YXkgY29tcGFyaW5nIHNvbWUKcmFuZG9tIHRyaXBfdGVtcCB2YWx1ZSBoZXJlLgoKdGhhbmtzLApy
dWkKCj4gCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKHQxID4gdDIpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN3YXAodHotPnRyaXBzX2luZGV4ZXNbaV0sIHR6
LQo+ID4gPiA+IHRyaXBzX2luZGV4ZXNbal0pOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfQo+ID4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ICt9Cj4gCj4gCj4gCj4gCgo=

