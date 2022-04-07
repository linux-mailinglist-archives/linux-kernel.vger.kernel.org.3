Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3313A4F722B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiDGCmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiDGCmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:42:09 -0400
X-Greylist: delayed 924 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 19:40:09 PDT
Received: from spam2.hygon.cn (unknown [110.188.70.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1332A220EC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:40:08 -0700 (PDT)
Received: from spam2.hygon.cn (localhost [127.0.0.2] (may be forged))
        by spam2.hygon.cn with ESMTP id 2372Oc4M016374
        for <linux-kernel@vger.kernel.org>; Thu, 7 Apr 2022 10:24:38 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id 2372JkUG015975;
        Thu, 7 Apr 2022 10:19:46 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex02.Hygon.cn ([172.23.18.12])
        by MK-DB.hygon.cn with ESMTP id 2372Jo1R063189;
        Thu, 7 Apr 2022 10:19:50 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn (172.23.18.10) by cncheex02.Hygon.cn
 (172.23.18.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 10:19:28 +0800
Received: from cncheex01.Hygon.cn ([172.23.18.10]) by cncheex01.Hygon.cn
 ([172.23.18.10]) with mapi id 15.01.2375.024; Thu, 7 Apr 2022 10:19:28 +0800
From:   Wen Pu <puwen@hygon.cn>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Wyes Karny <wyes.karny@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lewis.Carroll@amd.com" <Lewis.Carroll@amd.com>,
        "Mario.Limonciello@amd.com" <Mario.Limonciello@amd.com>,
        "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
        "Ananth.Narayan@amd.com" <Ananth.Narayan@amd.com>,
        "bharata@amd.com" <bharata@amd.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "metze@samba.org" <metze@samba.org>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Thread-Topic: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Thread-Index: AQHYSPZ2i5fvSUiei0GnFDYbI7mXuKzjM8cA
Date:   Thu, 7 Apr 2022 02:19:28 +0000
Message-ID: <5c57dae3-966a-b579-c971-e346b14a8695@hygon.cn>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
In-Reply-To: <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.18.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4053828FB938304D86CAE8649A34B29D@Hygon.cn>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: spam2.hygon.cn 2372Oc4M016374
X-DNSRBL: 
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RDNS_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMDIyLzQvNSAyMjowNywgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIFR1ZSwgQXBy
IDA1LCAyMDIyIGF0IDA2OjMwOjIxUE0gKzA1MzAsIFd5ZXMgS2Fybnkgd3JvdGU6DQo+PiArc3Rh
dGljIGlubGluZSBib29sIGVhcmx5X213YWl0X3N1cHBvcnRlZChjb25zdCBzdHJ1Y3QgY3B1aW5m
b194ODYgKmMpDQo+PiArew0KPj4gKwlpZiAoYy0+eDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX0lO
VEVMKQ0KPj4gKwkJcmV0dXJuIHRydWU7DQo+PiArDQo+PiArCWlmIChjLT54ODZfdmVuZG9yID09
IFg4Nl9WRU5ET1JfQU1EICYmIGNwdV9oYXMoYywgWDg2X0ZFQVRVUkVfWkVOKSkNCj4gDQo+IFdo
YXQgYWJvdXQgSHlnb24/IEZvciBzb21lIHJlYXNvbiB5b3UgZ3V5cyBkb24ndCBjby1vcmRpbmF0
ZSBhbmQgd2UgZW5kDQo+IHVwIGdldHRpbmcgZW5kbGVzcyAnbWFrZS1zYW1lJyBwYXRjaGVzLCBz
b21ldGltZXMgc2VwYXJhdGVkIGJ5IHllYXJzIDovDQoNCg0KSHlnb24gQ1BVIHN1cHBvcnRzIE1X
QUlULCBzbyB0aGlzIHBhdGNoIGFsc28gbWFrZSBzZW5zZSBmb3IgSHlnb24gOikNCkFzIERhdmUg
SGFuc2VuIGFuZCBMZXdpcyBDYXJvbGwgbWVudGlvbmVkIGluIHRoZSBmb2xsb3dpbmcgdGhyZWFk
cywNCkh5Z29uIGhhcyBhbHJlYWR5IHNldCB0aGUgWDg2X0ZFQVRVUkVfWkVOIGZsYWcsIHNvIGl0
J3MgYmV0dGVyIHRvDQp1c2UgWDg2X0ZFQVRVUkVfWkVOIGZvciBhbGwgWmVuIHVhcmNoIENQVXMu
DQoNCj4+ICsJCXJldHVybiB0cnVlOw0KPj4gKw0KPj4gKwlyZXR1cm4gZmFsc2U7DQo+PiArfQ0K
DQotLSANClJlZ2FyZHMsDQpQdSBXZW4=
