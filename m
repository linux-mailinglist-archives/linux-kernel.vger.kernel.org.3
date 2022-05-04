Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD39C51A574
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353423AbiEDQ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiEDQ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:28:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F146675;
        Wed,  4 May 2022 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651681492; x=1683217492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lIZS8L9hUURotYWnPIQEjJsG5uiWV1waq7GDXPVIqcc=;
  b=gExUBy8e2Cihm/6XjCUMw7vxfEqmclF77qKJoR3k0GbAblzfMm/VX3tV
   /19mYH11fGepyzx0wbCkvWVz5xyctii3eWJRWkPexTyqaQ+bRuB3I3myr
   c8qCIvrF/joHyr83Dp2czBNZi7aFDdIL97M+z70Sd/kpflcfYqP4N8dvz
   5u/lUA5aL3ZnbNNW5iMSrdr5+Q6ny72G4RLl7tU/viLk8YWYTmj9+vmNm
   2O/4dn6QpnfD/JgsfHSzUWCyzSFc4cnUfRaSW8L9+57c09WNGsg6V+ROn
   uMNCF/8nOPidkU69grdbB7RPngkIzbZoINEfsmkt171pb/mPVFAS4VofM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293004702"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="293004702"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 09:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="599597736"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2022 09:24:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 4 May 2022 09:24:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 4 May 2022 09:24:50 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Wed, 4 May 2022 09:24:50 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
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
Subject: RE: [PATCH v5 03/10] platform/x86/intel/ifs: Add stub driver for
 In-Field Scan
Thread-Topic: [PATCH v5 03/10] platform/x86/intel/ifs: Add stub driver for
 In-Field Scan
Thread-Index: AQHYWxYWmJjf7gsCY0aglBAPDxFRY60PBIYA///pJDA=
Date:   Wed, 4 May 2022 16:24:50 +0000
Message-ID: <eedc3fa9ec47494590be66ad66f90bb7@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <20220428153849.295779-4-tony.luck@intel.com> <87zgjxk2kt.ffs@tglx>
In-Reply-To: <87zgjxk2kt.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

>> +static const struct x86_cpu_id ifs_cpu_ids[] __initconst =3D {
>> +	X86_MATCH(SAPPHIRERAPIDS_X),
>
> Why do we need a model match here? The core capabilities MSR is only
> available when X86_FEATURE_CORE_CAPABILITIES is set:
>
>    "If CPUID.(EAX=3D07H, ECX=3D0):EDX[30] =3D 1.
>     This MSR provides an architectural enumeration
>     function for model-specific behavior."
>
> So checking for Intel Fam6 ANYMODEL and X86_FEATURE_CORE_CAPABILITIES is
> sufficient, no?

IA32_CORE_CAPABILITES is a nightmare. Although it is an architectural
register, the bits inside it are model specific.

In particular bit 2 (which we check here for the existence of the INTEGRITY
MSR) has been assigned for other use on other models. See SDM volume 4
table 2-45 where bit 2 means FUSA supported on 06_8C and 06_8D (Tigerlake
mobile and desktop). Ditto in table 2-46 (Alderlake and Raptorlake).

> We really don't need more match id tables with gazillions of CPU models.

Sadly we do :-(

-Tony
