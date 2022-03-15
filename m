Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516024D9FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349937AbiCOQMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348623AbiCOQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:12:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A1C56743;
        Tue, 15 Mar 2022 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647360671; x=1678896671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=glOFaMsZQ3qIAkOB+ER/W8hoSjZuYOqUjaQuQNhbfuY=;
  b=U8dcUBtgGWu/TM8xZqUzpME1QZREue1vS21pkK568uO7/4n8tMud+Nju
   WwgpZVrmTSMeelfqa9hdmkbOUHbzvd7REXnEnA3NKqBOap3h+daK7b1Nv
   z18DLw7f715mE9yDZDDAYVHHTfWOx5qeDn0GrNCIhXbZmEb7jkAvCKceL
   mGnHHdktlAJQLaEzGpOvb7zx3mhedVjrRCrLAtdCkNRpIoNNGHqLL1Sap
   r6SgO1avJqT5SVx0oI+b/1Msx5Zt+oAoWqn2ZbxsfBiXpFy9dcfn8Ai+w
   a+/VoHRa+ol+ACDN0uJT5f8ShrBb9RgoI93hpDiQZCYE5WBNIrsdJsLbU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236292957"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="236292957"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="540498624"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2022 09:11:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 09:11:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 09:10:59 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Tue, 15 Mar 2022 09:10:59 -0700
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
Thread-Index: AQHYLaZcmKq0UuRYGU6xp1k7P7vRw6yre5AAgAABJQCAFBlxgIABAjIAgAAEKTCAAH+egP//kvKw
Date:   Tue, 15 Mar 2022 16:10:59 +0000
Message-ID: <de895b9617aa412e95fdd14fcad285fa@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <Yh59rOIH24X+6GyI@kroah.com> <Yh5+om/Nr06V0+Qj@kroah.com>
 <Yi/Lb5laEki0JHft@agluck-desk3.sc.intel.com> <YjBBmEjbIaqTbVt+@kroah.com>
 <c4af81bd788e43dda915a1052af0be55@intel.com> <YjCwI4N00reBuIqA@kroah.com>
In-Reply-To: <YjCwI4N00reBuIqA@kroah.com>
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
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Again, I have no idea what you are doing at all with this driver, nor
> what you want to do with it.
>
> Start over please.

TL;DR is that silicon ages and some things break that don't have parity/ECC=
 checks.
So systems start behaving erratically. If you are lucky they crash. If you =
are less lucky
they give incorrect results.

There's a paper (and even a movie 11 minutes) that describe the research by
Google on this.
https://sigops.org/s/conferences/hotos/2021/papers/hotos21-s01-hochschild.p=
df =20
(https://www.youtube.com/watch?v=3DQMF3rqhjYuM)   =20

> What is the hardware you have to support?

Feature first available in Sapphire Rapids (Xeon: coming later this year)

> What is the expectation from userspace with regards to using the
> hardware?

Expectation from users is that they can run these tests frequently (many ti=
mes
per day) to catch silicon that has developed faults quickly and take action=
 to
isolate the cores that have issues.

On HT enabled systems both threads that share a core need to be put into
test mode together. The current version of tests takes around 50 milli-seco=
nds
(so for many workloads doesn't need much prep ... those with high sensitivi=
ty
to latency would need to do some additional userspace task binding to make
sure those workloads were moved to another core while the h/w test runs).

There are three outcomes from running a test:

1) The test passes all stages.
2) The test did not complete (for a variety of reasons, e.g. power states)
3) The test indicates failure. Recommendation is to run one more time in ca=
se
    the failure was transient .. e.g. cause by a neutron/alpha strike.

-Tony
