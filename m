Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2F4D9E46
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349536AbiCOPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349545AbiCOPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:00:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8C32655F;
        Tue, 15 Mar 2022 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647356346; x=1678892346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GyNyfKahJzTHsEIBBRJIhFWT/tnEv+2kPDiw/r6E+k4=;
  b=HQLlDw9qtrAfxhh7fFJY3uga7lyOQJf7GrhSSKj1r86OqsEGXdsXuWpj
   mCKkk5bE+X3p/zEf9LhvwLrqmo/Y8CVZb5kBJBLdHUNvpoWhK0MrCpqBP
   jTcrMH2VFFwJe7sdrE789dutF7l1BC5ud4SOv+GZ3+gQWBJmDj0dRCCpA
   AQs4O36GnYFy4mHak25NoxKYJwyGBwgzQY5+viwiKR15n9GHtw2Q5VXto
   6CE3CVeegHf7DUXGT9O/WhlWueB7vVwanaAdu09yKIBDEv4unl+ZyJZBp
   IUL6uwunywTC1h14xcOrt26gOsHk1mkOOvSdcl1NtKPWsXd+RdIudJoSE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236929303"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="236929303"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 07:59:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="644286209"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 15 Mar 2022 07:59:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 07:59:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 07:59:04 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Tue, 15 Mar 2022 07:59:04 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [RFC 00/10] Introduce In Field Scan driver
Thread-Topic: [RFC 00/10] Introduce In Field Scan driver
Thread-Index: AQHYLaZcmKq0UuRYGU6xp1k7P7vRw6yre5AAgAABJQCAFBlxgIABAjIAgAAEKTA=
Date:   Tue, 15 Mar 2022 14:59:03 +0000
Message-ID: <c4af81bd788e43dda915a1052af0be55@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <Yh59rOIH24X+6GyI@kroah.com> <Yh5+om/Nr06V0+Qj@kroah.com>
 <Yi/Lb5laEki0JHft@agluck-desk3.sc.intel.com> <YjBBmEjbIaqTbVt+@kroah.com>
In-Reply-To: <YjBBmEjbIaqTbVt+@kroah.com>
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
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> This seems a novel use of uevent ... is it OK, or is is abuse?
>
> Don't create "novel" uses of uevents.  They are there to express a
> change in state of a device so that userspace can then go and do
> something with that information.  If that pattern fits here, wonderful.

Maybe Dan will chime in here to better explain his idea. I think for
the case where the core test fails, there is a good match with uevent.
The device (one CPU core) has changed state from "working" to
"untrustworthy". Userspace can do things like: take the logical CPUs
on that core offline, initiate a service call, or in a VMM cluster environm=
ent
migrate work to a different node.

> I doubt you can report "test results" via a uevent in a way that the
> current uevent states and messages would properly convey, but hey, maybe
> I'm wrong.

But here things get a bit sketchy. Reporting "pass", or "didn't complete th=
e test"
isn't a state change.  But it seems like a poor interface if there is no fe=
edback
that the test was run. Using different methods to report pass/fail/incomple=
te
also seems user hostile.

> good luck!
Thanks ... we may need it :-)

-Tony

