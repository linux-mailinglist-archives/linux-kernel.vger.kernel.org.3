Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0100B4BC2A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 23:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbiBRWib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 17:38:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiBRWi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 17:38:28 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD0556C29
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645223891; x=1676759891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3U5CqholvR0447graRVIPJ8jfZ7zdarnpTpqBHx+y3M=;
  b=CmrXCULPdj05mj7/1Opdm8f+njfBPN+wMr9sC6Hcx4OqNTxSkXSCp02v
   /gRIoTvNnbIQn2yo5Jr1bl/TVmWWJuEF25E3sYAvLa/rM8prtdDUYXz1a
   Tyvux91dUHdBs1mq2y0c0wScamkanabNIEDW8hkIoyJTB+QkwaeUtHYZW
   ncWXOgmsMoOWxapwmHRppRm469/uvYzoX3Git39B1Nkrya7TDKHIlPNaM
   1w58Xi3WgeAt63GBqhgpJSwDzi5owgMe0wICZEQ5Syw4ZgQQG8Eo1KEy2
   GFm92UJLjTpFz/04boJpcs1g1MiVAO+1+V4nkosB7EDjAvV4GutKVfvBT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="234778407"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="234778407"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:38:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="489818207"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2022 14:38:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 14:38:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 14:38:10 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Fri, 18 Feb 2022 14:38:10 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Jue Wang <juew@google.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2] x86/mce: work around an erratum on fast string copy
 instructions.
Thread-Topic: [PATCH v2] x86/mce: work around an erratum on fast string copy
 instructions.
Thread-Index: AQHYJGdbPe82lm9eb0O/d1VFli+im6yZ77OAgAAPtwCAAAL5AIAAAh0AgAAPMwCAAAXxAIAASw2A//+CIBA=
Date:   Fri, 18 Feb 2022 22:38:10 +0000
Message-ID: <0de9b9b5800e4e4a879fddc74b67bfec@intel.com>
References: <Yg54nse5qNQO3sbW@zn.tnic>
 <20220218013209.2436006-1-juew@google.com> <Yg+2Hc78nfSRmh/j@zn.tnic>
 <CAPcxDJ4c3eGXTB9UPJmZ8dzyCNPW4Lv9s1QSeoCWq_LdNWTrJw@mail.gmail.com>
 <Yg/FyrvLWhZHB/UC@zn.tnic>
 <CAPcxDJ72dMOpbKXxyb__OeMaEyjYSPtsL_ubVsKOuRXefAQ3_w@mail.gmail.com>
 <Yg/UUHuVvd9AOJ94@zn.tnic>
 <CAPcxDJ7=hCz6KRih4OBVv-k8WLcBL4n+VSpeP_zky7Uunq89zg@mail.gmail.com>
 <YhAYQQ6f/XJjOI8A@zn.tnic>
In-Reply-To: <YhAYQQ6f/XJjOI8A@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBkbyB3ZSByZWFsbHkgbmVlZCB0aGF0IHByaW50ayBpbiB0aGVyZT8NCg0KSSB0aGluayB3ZSBk
by4gVGhhdCBDUFUgaXMgbm93IHJ1bm5pbmcgaW4gZGVncmFkZWQgbW9kZSAoZmFzdCBzdHJpbmdz
IGRpc2FibGVkKSAuLi4gc3lzYWRtaW5zIHdpbGwgd2FudCB0byBrbm93IHRoYXQuDQoNCj4gSWYg
c28sIHdlIGNhbiBzYW5kd2ljaCBhcm91bmQgaXQgd2l0aCBuc3RydW1lbnRhdGlvbl9iZWdpbigp
IGFuZCBfZW5kKCkuLi4NCg0KSSBndWVzcyBzbyAuLi4gdGhpcyBzdHVmZiBpcyBhbGwgR3JlZWsg
dG8gbWUuDQoNCi1Ub255DQo=
