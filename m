Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF974ACADB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiBGVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiBGVHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:07:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC6C06173B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644268026; x=1675804026;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8gbY67ygTvd6iWc9uwdHH+xuMdIzgfcuSO4qL0gWlQQ=;
  b=iaVUPdUy1HROh+x+9YEXAiV0im7NbZITPVToIeYkbksOJhdwVFYR+cKR
   3/BDpNHaR5/GgtNS5LKC37R3Oas+po/z8EhgeTO0j5PsMdJsEYU6axJ2I
   c4m8qDvN4I974HH9S4Caxj/c2GWBYYo502TI53jeAt9kC6SvLxxLKqhOB
   IWlGMrb0K0wX28nupiWtjYQo5/VzWumflrvLyFEdAZVxGggbpHZsoBBPU
   Q1blUxFW566Aoe8SyxUaFa9CLGlK1WPKxLmEm8ltfVhk6qrgAQcyHVWtd
   4FY1OzFODJmOU7/S2mxvG6H+MSISbqOarsYE7d/jDpKogr9h1hnTz/lD6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229458532"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="229458532"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 13:07:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="567618908"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2022 13:07:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Feb 2022 13:07:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Feb 2022 13:07:05 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Mon, 7 Feb 2022 13:07:05 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Jue Wang <juew@google.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [RFC] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Thread-Topic: [RFC] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Thread-Index: AQHYG9xP0gqp+9MoaEye7S91lqAbGKyI9jkA//+C0wCAAJepgP//g7dQ
Date:   Mon, 7 Feb 2022 21:07:05 +0000
Message-ID: <be53997f26704089b941d33d9bf47bc6@intel.com>
References: <20220207043640.2829295-1-juew@google.com>
 <YgFqiJOU5tZsHbY6@zn.tnic> <YgFyBRIOIquMI2ng@agluck-desk2.amr.corp.intel.com>
 <YgGAv/aCVG+RDADI@zn.tnic>
In-Reply-To: <YgGAv/aCVG+RDADI@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJbiB0aGF0IGNhc2UsIHlvdSBjYW4ganVzdCBhcyB3ZWxsIHRlc3QgdGhlIE1TUiBiaXQgZGly
ZWN0bHkNCj4gTVNSX0lBMzJfTUlTQ19FTkFCTEVfRkFTVF9TVFJJTkdfQklULiBJZiBpdCBzZXQs
IHlvdSBjbGVhciBpdCwgZG9uZS4NCg0KWWVzLiBUaGF0IHdvdWxkIHdvcmsuIEl0J3MgYW4gZXh0
cmEgTVNSIHJlYWQgaW5zdGVhZCBvZiBhIG1lbW9yeSByZWFkLiBCdXQgdGhpcw0KaXNuJ3QgYSBw
ZXJmb3JtYW5jZSBwYXRoLg0KDQo+PiBNYXliZSB0aGlzIHdvdWxkIGJlIG1vcmUgaHVtYW4gZnJp
ZW5kbHk/DQo+PiANCj4+IAkJcHJfZXJyKCJDUFUlZDogUGVyZm9ybWFuY2Ugbm93IGRlZ3JhZGVk
IGFmdGVyIGFwcGx5aW5nIG1hY2hpbmUgY2hlY2sgd29ya2Fyb3VuZFxuIiwNCj4+IAkJCXNtcF9w
cm9jZXNzb3JfaWQoKSk7DQo+DQo+IFdlbGwsIGlzIHRoZXJlIGFuIGVycmF0dW0geW91IGNhbiBy
ZWZlciB0byBpbiBpdCBpbnN0ZWFkPw0KDQpUaGUgZXJyYXR1bSBoYXMgbWFkZSBpdHMgd2F5IHRo
cm91Z2ggdG8gdGhlIHB1YmxpYyBzcGVjaWZpY2F0aW9uIHVwZGF0ZSB5ZXQgOi0oDQoNCj4gRXhw
bGFpbmluZyB0aGUgd2hvbGUgZGVhbCBpbiBhIHNpbmdsZSBlcnJvciBtZXNzYWdlIGlzIGhhcmQg
YW5kIGFsbW9zdA0KPiBjZXJ0YWlubHkgaW5zdWZmaWNpZW50Lg0KDQpOb3QgaWRlYWwsIGJ1dCB0
aGUgbWVzc2FnZSBpcyBhIHNlYXJjaCB0b29sIHRvIGdldCB0byB0aGVzZSBlLW1haWwgZGlzY3Vz
c2lvbnMuDQoNCj4gQWxzbywgd2hhdCdzIHRoZSB1c2Ugb2YgdGhhdCBtZXNzYWdlIGlzc3Vpbmcg
b25jZSBvbiBldmVyeSBDUFU/IEluc3RlYWQNCj4gb2YgYmVpbmcgYSBfb25jZSgpIG1lc3NhZ2U/
DQoNCnByX2Vycl9vbmNlKCkgd291bGQgYmUgYmV0dGVyLg0KDQotVG9ueQ0K
