Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D4508EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381354AbiDTR7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbiDTR7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:59:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71EF4477D;
        Wed, 20 Apr 2022 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650477427; x=1682013427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NEh9iB5JfPPqjjEsQjcgin93qCXOmz1GRjuBdLqZtTo=;
  b=UPDtlvGd15flw6G8Xp09IO8HzoRZP322IfO3vCNVGyLf4KFzyPSGu38i
   SnEzJ3s6Po+rjvNimF/ZfxGC+TpQN+KfiS62qTJK+IsXWx0pxOMResv5i
   akdbFL3IxikDnwvU+Ax0ipfQMImZpLrDbiqoGKSBSIlxBmqj7XKzoLpYk
   F1Izp4BA7k05HI2gRTBouQnSckIXLX1RMTdGGOkFe7edPknU9/1bgR/sO
   GPYrUCoItIJgDBnTXp6TMd81FrQCepQVkhkGL5rtwZAuEIqpEn42zSRTS
   BboTekdvhIJsqcg6XmCj7agg11OGZFMjIBQ09m+cdrE0D5Xm7pDS/TbET
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324552007"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="324552007"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:57:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="555324482"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2022 10:57:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 10:57:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 10:57:04 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Wed, 20 Apr 2022 10:57:04 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v3 03/11] platform/x86/intel/ifs: Create device for Intel
 IFS (In Field Scan)
Thread-Topic: [PATCH v3 03/11] platform/x86/intel/ifs: Create device for Intel
 IFS (In Field Scan)
Thread-Index: AQHYVAv92LA3gQ6+7UWRqBVIgiQr06z355WAgAAWzYCAAOUNAIAACuQAgACb+YD//4u7sA==
Date:   Wed, 20 Apr 2022 17:57:04 +0000
Message-ID: <578be5d8874f4942a58adf5f64c4e817@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-4-tony.luck@intel.com> <Yl7npfrVTPFEIivC@kroah.com>
 <CAPcyv4jzscs3Dg4QN0+XHRYdekBeqy1=dRX-mWCj1OXo8jS2vQ@mail.gmail.com>
 <Yl+66oyQhI0AkEDC@kroah.com> <YmAmebezoc8m6n2E@agluck-desk3.sc.intel.com>
 <YmBG44t4dYsUl4Aa@kroah.com>
In-Reply-To: <YmBG44t4dYsUl4Aa@kroah.com>
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
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	ifs_class =3D class_create(THIS_MODULE, "intel_ifs");
>
> Why do you need a class?  Why not just use a misc device?  Saves you
> loads of boilerplate code that is sometimes tricky to get correct.

It didn't feel like a "ton" of boiler plate. Just class_create()/class_dest=
roy()
for the class itself. And

	class_for_each_device(ifs_class, NULL, NULL, ifs_device_unregister);

to clean up devices on exit (or error cleanup in init()).


I thought I needed a class to make a directory for my per-test directories =
to live in:

$ ls -l /sys/devices/virtual/intel_ifs
total 0
drwxr-xr-x 3 root root 0 Apr 20 13:36 ifs0
drwxr-xr-x 3 root root 0 Apr 20 13:36 ifs1

Can I do that with a misc device?

Or is it ok for them all to sit at the top level of /sys/devices/virtual?

-Tony
