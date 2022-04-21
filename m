Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D545095F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 06:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384095AbiDUE3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 00:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiDUE33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 00:29:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B2212602;
        Wed, 20 Apr 2022 21:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650515201; x=1682051201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z7jdM6pq07KjbTcwuki1ZSctHuXY7XcN+eSmZWx0l0M=;
  b=cAfSDuCbf7xBSYDM0O40TAf1HQ6qGlpdbPgBD7WQm3UU1PB8INVICZJn
   AwZv8AXz2ESdGhdW++ayrWRzfh78/StXsj8uWAylPGKOYVCdf4lvJvRPQ
   8kk3k0bUQgOqKC0WQ53kHWhoqJ8zJOgiWPLms0Ud+vuudStbrbyf1/nrg
   zrQ+c31rp7fFtPV0vKMnjsQ40BUfxCH7cp4bFVpPyuWBv12gQYMZYoH2z
   wrNVW5+VUUQ1TJSXCzoncllW847OjHUEsWzIJt8Tt3fFJ5fJ4MAR1Of4D
   dB6DlAefyQYu8HPxxemPj+4Uub1rPY1CrdLkHgoIzIHjzGohNRQQHAvsG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324672494"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="324672494"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 21:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="727803522"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 20 Apr 2022 21:26:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 21:26:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 21:26:39 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Wed, 20 Apr 2022 21:26:39 -0700
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
Subject: RE: [PATCH v3 10/11] trace: platform/x86/intel/ifs: Add trace point
 to track Intel IFS operations
Thread-Topic: [PATCH v3 10/11] trace: platform/x86/intel/ifs: Add trace point
 to track Intel IFS operations
Thread-Index: AQHYVAv/GMu0aAF5oU2sc2NlODgUPKz57MaA///Yp0A=
Date:   Thu, 21 Apr 2022 04:26:39 +0000
Message-ID: <adc49af263e2464f86b20ccc2d8f184d@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
        <20220419163859.2228874-1-tony.luck@intel.com>
        <20220419163859.2228874-11-tony.luck@intel.com>
 <20220420193839.6e9d810b@gandalf.local.home>
In-Reply-To: <20220420193839.6e9d810b@gandalf.local.home>
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

>> +TRACE_EVENT(ifs_status,
>> +
>> +	TP_PROTO(union ifs_scan activate, union ifs_status status),
>
> Really, you want to pass the structure in by value, so that we have two
> copies? One to get to this function and then one to write to the ring
> buffer?

These "structures" are just bitfield helpers for a u64 that is passed into
WRMSR (in the case of activate) and received back from RDMSR in
the case of status.

So this is really just a pair of u64 arguments, with the compiler handling
the bit field extractions into the ring buffer.

Here are the definitions:

union ifs_scan {
        u64     data;
        struct {
                u32     start   :8;
                u32     stop    :8;
                u32     rsvd    :16;
                u32     delay   :31;
                u32     sigmce  :1;
        };
};

union ifs_status {
        u64     data;
        struct {
                u32     chunk_num               :8;
                u32     chunk_stop_index        :8;
                u32     rsvd1                   :16;
                u32     error_code              :8;
                u32     rsvd2                   :22;
                u32     control_error           :1;
                u32     signature_error         :1;
        };
};

Would it be better to do the bit extractions of the start/stop fields first=
?

-Tony


