Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94594518948
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbiECQIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbiECQIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:08:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EFF193FB;
        Tue,  3 May 2022 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651593889; x=1683129889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TOqujW17h1b62Lml6AZoxLlPLfSYjHro3qzoD1t/Ztk=;
  b=S4Vu9SyzFWlVh/wbYWrpI5CyddnLCViOmRwrshlyPG5QuWgZm7XsFtcI
   vNxQ38yGGr46Q8h6bcizlZuiItdCWlftExDVox1kmeKiYQmeP0gmRclFU
   E40WikHDgmeC1LvycfKyU5Q5Kz1uOyWJRPWHk60U5z+dYW8bj5rNIGtRc
   kV4PrT/iSz1v1nebTMB9FnbzxC6DgtQu/Kj3J9+xilUAuvryaYSeIHIzG
   nG5HQSFnW0E6pLVJ1dq0PYfpCG+37UmYqw3lOzOc/kOjEmLCVOJ6EORLf
   uDnF1sN78NI/RHTxUZonlP4e55Se7OhV+5+CqlTeregnAchC9vn86s2Fn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="266357701"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="266357701"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 09:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="547666816"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2022 09:04:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 3 May 2022 09:04:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 3 May 2022 09:04:40 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Tue, 3 May 2022 09:04:40 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>
CC:     "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v5 00/10] Introduce In Field Scan driver
Thread-Topic: [PATCH v5 00/10] Introduce In Field Scan driver
Thread-Index: AQHYWxYVdsKdZt61BUSHj1qB1cqAT60MLiKAgAGW8wD//5MXcA==
Date:   Tue, 3 May 2022 16:04:40 +0000
Message-ID: <c30f82f1d4544ebb8a15da1f6fc033ac@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <13054c5c-ed48-b7a2-a800-25b9b1b1ab0d@redhat.com> <YnFK+gXFx0jQB1dz@zn.tnic>
In-Reply-To: <YnFK+gXFx0jQB1dz@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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

PiBIbW0sIHNvIGxvb2tpbmcgYXQgdGhlIGRpZmZzdGF0IC0gdGhlIG1ham9yaXR5IG9mIHRoYXQg
aXMNCj4gZHJpdmVycy9wbGF0Zm9ybS94ODYvIHNvIEkgZ3Vlc3MgeW91ciB0cmVlIHdvdWxkIGJl
IGJldHRlciBzdWl0ZWQgZm9yDQo+IGl0Li4uDQoNCkNhbiB5b3UgY2hlY2sgdGhhdCBJIGZpeGVk
IHRoZSBpc3N1ZXMgaW4gcGFydCAwMS8xMCB0aGF0IHlvdSByZXBvcnRlZCBpbiB2MyBvZiB0aGlz
DQpzZXJpZXMgYW5kIGdpdmUgYW4gQWNrIHRvIEhhbnM/DQoNCi1Ub255DQo=
