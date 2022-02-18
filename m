Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36114BBEDB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiBRR7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:59:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiBRR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:59:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929A41023
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645207130; x=1676743130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ZZ8b31Er7R5CNT7Q792VI7QvRSKMZXQ4IsgRjHYIS0=;
  b=N6T0Uu3ZvDM1HJaEicicba26ZOi/QxQPaw3otRV4uxVSkP2bnHm2Rfpj
   kNq5I6ZvhpFuskU9+loswKkTRAjgerijxWj1rouu4nLegyOOnC61FnKCB
   GoHm7iWHapFbc3HjGqQvofsiyZtdpsCAMlPssz00A7LOkNc8QucmfzB29
   OJ3ntmkzMQluUHdlujUnFpDGePdfixE61if+0+NoF4T36N0id6beN9zdv
   cVtZWd7q8MfwVd3SAE44BPtfknjm9ga/re8dKIiSye7l/UBlWbPEji1AV
   O613gfeDmP3yGwyzAJbWuaqwQhGw+g0vQuM/RIVcNjS2SkRPzLYzW8BMJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="251377682"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="251377682"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 09:58:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="682576532"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2022 09:58:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 09:58:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 09:58:42 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Fri, 18 Feb 2022 09:58:42 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Jue Wang <juew@google.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2] x86/mce: work around an erratum on fast string copy
 instructions.
Thread-Topic: [PATCH v2] x86/mce: work around an erratum on fast string copy
 instructions.
Thread-Index: AQHYJGdbPe82lm9eb0O/d1VFli+im6yZ77OA//+pYdA=
Date:   Fri, 18 Feb 2022 17:58:42 +0000
Message-ID: <dca14efd34294fe1b58d21a230fe6f11@intel.com>
References: <Yg54nse5qNQO3sbW@zn.tnic>
 <20220218013209.2436006-1-juew@google.com> <Yg+2Hc78nfSRmh/j@zn.tnic>
In-Reply-To: <Yg+2Hc78nfSRmh/j@zn.tnic>
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
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBbHNvLCBUb255LCBJIHRoaW5rIHRoZSBjbGVhcmluZyBvZiBNQ0dfU1RBVFVTIHNob3VsZCBo
YXBwZW4gbGFzdC4NCg0KWWVzLiBUaGVyZSdzIGEgcmFjZSBpZiBhbm90aGVyICNNQyBjb21lcyBp
biBhZnRlciBNQ0lQIGlzIGNsZWFyZWQsIGJ1dCBiZWZvcmUgd2UgZ2V0DQpvZmYgdGhlIG1hY2hp
bmUgY2hlY2sgc3RhY2suIFNob3VsZCBtYWtlIHRoYXQgd2luZG93IGFzIHNtYWxsIGFzIHBvc3Np
YmxlLg0KDQotVG9ueQ0K
