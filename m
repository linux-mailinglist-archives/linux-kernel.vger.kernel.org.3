Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E05751DC9B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443209AbiEFP5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391204AbiEFP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:57:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFB868F93;
        Fri,  6 May 2022 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651852439; x=1683388439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b8YvVwwiHGF9H0n+2KLSOuiyjG1C33LqDP8DdORMsgM=;
  b=Dfv4058Dm0bIA9jdRy2EAvB3cr1I/kr4GR52QjVqxj+EBOInarRrjnoY
   kVBdxMGWW0wy+ZxmH671XXDFG3n1TFxNTx4VDYRW+A/5DpuWMxR/lCO7z
   jM9H6ThHteUzDzWZqc7xr0UX4Erv3RXbSnOx0JfdyZLxdBsVhnLX123fL
   CJIJ7Q4ScK1V1Ajjf2oBrOG62F+yc/lobvku7KVFPxhzc0s6/NtLbYiZ+
   VpR4EZ+ONlE4NTHYjPw8w3TO69TXSCy/h81K9ZHpn5vpYQPMivpbRecwt
   wHDYh8Q2tFSyK8q+gyX6Ob8wRbgoOxUczDvdaqlyLRnRo02TpjSQhYwBs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="331492319"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="331492319"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="549916619"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2022 08:53:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 08:53:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 08:53:57 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Fri, 6 May 2022 08:53:57 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, Borislav Petkov <bp@alien8.de>
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
Thread-Index: AQHYWxYVdsKdZt61BUSHj1qB1cqAT60MLiKAgAGW8wCABKLQAP//o/BA
Date:   Fri, 6 May 2022 15:53:56 +0000
Message-ID: <15cca88b82cd46a3a2a98b7cf336a6ed@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <13054c5c-ed48-b7a2-a800-25b9b1b1ab0d@redhat.com> <YnFK+gXFx0jQB1dz@zn.tnic>
 <b18234d7-a1f4-d5a4-e59b-f5439c38c2d0@redhat.com>
In-Reply-To: <b18234d7-a1f4-d5a4-e59b-f5439c38c2d0@redhat.com>
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

PiBJJ2xsIGdpdmUgaXQgc29tZSBtb3JlIHRpbWUgZm9yIHJldmlldyBmb3IgdjYgYW5kIHRoZW4g
cGljayB1cCB2Ng0KPiAob3IgdjcgaWYgcmV2aWV3IGxlYWRzIHRvIG1vcmUgY2hhbmdlcykuDQoN
CkhhbnMsDQoNClRob21hcyBoYXMgZm91bmQgb25lIHN1YnN0YW50aXZlIHByb2JsZW0sIGFuZCBh
IGZldyBtaW5vciB0aGluZ3MgKHNvIGZhciAuLi4gaGUNCnN0aWxsIHNlZW1zIHRvIGJlIHdvcmtp
bmcgdGhyb3VnaCB2NikuIA0KDQpTbyB0aGVyZSB3aWxsIGJlIGEgdjcuIExpa2VseSBlYXJseSBu
ZXh0IHdlZWsuIElzIHRoYXQgT0s/IERvIHlvdSBzdGlsbCB0YWtlIHBhdGNoZXMgYWZ0ZXIgLXJj
Nj8NCg0KLVRvbnkNCg==
