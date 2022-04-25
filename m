Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BD550E627
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbiDYQwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbiDYQwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:52:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A724969;
        Mon, 25 Apr 2022 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650905377; x=1682441377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x1VjlOLFf7+Iwtn5He+Gw098wHontYefP4lyjR1he+4=;
  b=b9bi1/SdNNCgm03qImb79kNc92BtVmgknXpIjjRJuDxvy4oDjCTtqueq
   gOBs0YVnAoorP14Igtzhn/qLLjuIKqG0fJnjx/u61CBaFAqtVw1o6zllf
   1LEm4Zzv4NWjfZ9vcwOC+H/mv6jhSRLRNlcb1ULIgc9H0v8IF/9/r48mS
   aH6mO9AT9N8/L2O+E/cOGtSkyszGaDrCGKORKKwAcyyK0+geK43PHoJ+Z
   XhYJHbY0xu0VV+t6nZpCFvEain3xhqvXgRMGGgXPnwuyn6Fv1uFSFr2JR
   Ul0E86yoKJxqAsGZnMqAsa/36nuPW/6jjAUL4ZDbjttyPBXULknzsSjRj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264822399"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="264822399"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="628115236"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2022 09:49:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 09:49:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 09:49:35 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Mon, 25 Apr 2022 09:49:35 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v4 09/10] trace: platform/x86/intel/ifs: Add trace point
 to track Intel IFS operations
Thread-Topic: [PATCH v4 09/10] trace: platform/x86/intel/ifs: Add trace point
 to track Intel IFS operations
Thread-Index: AQHYVoPmGcq84+Hs50ec7Nq4KoK2Oa0BMJaA//+oPOA=
Date:   Mon, 25 Apr 2022 16:49:35 +0000
Message-ID: <1752057af33e4eb28bcea0fd75e44048@intel.com>
References: <20220419163859.2228874-1-tony.luck@intel.com>
        <20220422200219.2843823-1-tony.luck@intel.com>
        <20220422200219.2843823-10-tony.luck@intel.com>
 <20220425105251.3f5e8021@gandalf.local.home>
In-Reply-To: <20220425105251.3f5e8021@gandalf.local.home>
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
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Add tracing support which may be useful for debugging systems that fail=
 to complete
> > In Field Scan tests.
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  MAINTAINERS                              |  1 +
> >  drivers/platform/x86/intel/ifs/runtest.c |  5 ++++
> >  include/trace/events/intel_ifs.h         | 38 ++++++++++++++++++++++++
>
> From the tracing POV:
>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Question for the future of this driver.  There are a couple more scan tools=
 coming
in the future. The interface is similar:

	WRMSR to start a scan
	RDMSR to get the results

For this first one, I made the trace code do some user friendly decoding of=
 the
WRMSR value to just show the two interesting fields (start & stop).

The future scan modes will have different fields.

I see two paths:

1) Create a new user friendly trace point for each new scan mode.
2) Just provide a generic one that dumps both the 64-bit WRMSR and RDMSR va=
lues.

Q: Are trace points "expensive" in some way ... so better to just have one =
than three?
     Or are the cheap enough that decoding for the user is an OK thing?

Thanks

-Tony


