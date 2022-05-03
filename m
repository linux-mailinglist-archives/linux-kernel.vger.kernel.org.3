Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D045189D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbiECQaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbiECQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:29:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB21A25C79;
        Tue,  3 May 2022 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651595186; x=1683131186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MQ85w7Epamx1hF9B682F4eoCXfpBJrXR4QrzZ3a76lg=;
  b=Kps7qH2/5WhItb6RzR0InxnBYzawSnafuy8pD3iegVUb6IPtf4jFYfhu
   h/eK4ygzw42SgQuubLOAXO/nbEnzEdQ0ConFfG0qs8uUYUab1j0MSx1ub
   s5EIQaynFdrqcMSLAHTs1dHF7YOd7puabvK0C/zdAXCVQX9b0aQln/4CW
   WloJn0Yfwnu/4nWEF6GAIVzzSMqgQFsPX5D4AUGzOpKnGqoFfMSR/2oxJ
   k7I5GL+UDtzQwljRoWd+9Ns5Urt8+2gHUsx4GcXUbHwZxjMNrOWw4iB19
   Vgbttxd5tIx1j5QfVDqfJ2ZPcrI0H1OVsSvgNZpe1Fz/FvDv4yWj2fL8c
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="292710795"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="292710795"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 09:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="562277407"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 03 May 2022 09:26:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 3 May 2022 09:26:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 3 May 2022 09:26:21 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Tue, 3 May 2022 09:26:21 -0700
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
Thread-Index: AQHYWxYVdsKdZt61BUSHj1qB1cqAT60MLiKAgAGW8wD//5MXcIAABnSA
Date:   Tue, 3 May 2022 16:26:21 +0000
Message-ID: <ed069ff97fc5413795b43a00d88b7f8a@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <13054c5c-ed48-b7a2-a800-25b9b1b1ab0d@redhat.com> <YnFK+gXFx0jQB1dz@zn.tnic>
 <c30f82f1d4544ebb8a15da1f6fc033ac@intel.com>
In-Reply-To: <c30f82f1d4544ebb8a15da1f6fc033ac@intel.com>
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBDYW4geW91IGNoZWNrIHRoYXQgSSBmaXhlZCB0aGUgaXNzdWVzIGluIHBhcnQgMDEvMTAgdGhh
dCB5b3UgcmVwb3J0ZWQgaW4gdjMgb2YgdGhpcw0KPiBzZXJpZXMgYW5kIGdpdmUgYW4gQWNrIHRv
IEhhbnM/DQoNCk9vcHMgLi4uIHJlYWRpbmcgZS1tYWlsIG91dCBvZiBvcmRlciAuLi4gSSBzZWUg
dGhhdCB5b3UgYWxyZWFkeSBnYXZlIHRoZSBBY2suICBUaGFua3MhDQoNCi1Ub255DQo=
