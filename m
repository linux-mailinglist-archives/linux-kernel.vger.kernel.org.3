Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273604D53BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245656AbiCJVnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiCJVnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:43:07 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A694192CB8;
        Thu, 10 Mar 2022 13:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646948526; x=1678484526;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wu9xQh13qOE2SQCUN+y0wm4du69ScDsFeOiJ0FkDQCg=;
  b=hu5I3kLUlNxdMCRcYV9cnVBayhOR06Nxg62cf/odlqFUTxua12rU2iHE
   ah5uJko2e+wzA+HWmz9tQW1lrTX/Od/Xenm9Y8EgQKMlo8dnSn6WIa4MT
   E1oeemwQp1Nku5xIknUrljMj9R3QmMzEUsMiACbXahJ60cPKYM7CjC4Ka
   7pZm/iLK/5BaHMCu8GeTuXCmk6ra4Tmxj+GwtEusQLyDnbFh8X9aHISK+
   L68RMiwhAOksG2tldnN0aezPmzoRG9Zro5FH/JZM22HQRoaJSaId+qXwx
   7w/m9hiEOfdziZVtKeOXvPiWVBx6lL75tVteYUTPrf4HsWVtH19i4vTII
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="235338638"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="235338638"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 13:42:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="596833491"
Received: from dhrumil1-mobl1.amr.corp.intel.com (HELO [10.209.77.231]) ([10.209.77.231])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 13:42:03 -0800
Message-ID: <4062bb5c-1e9c-5e1f-5b27-2a4a8fb58078@intel.com>
Date:   Thu, 10 Mar 2022 13:42:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC 07/10] platform/x86/intel/ifs: Create kthreads for online
 cpus for scan test
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <20220301195457.21152-8-jithu.joseph@intel.com>
 <09b5b05018a8600ca8fab896790ab16827c80e4e.camel@intel.com>
 <e282377b-8ee4-99fc-432f-2aa3441b2989@intel.com>
 <CAPcyv4gcfMZu38EAGBq59A-RPUmR3fFiamRiR6QaP=D1gPS+6A@mail.gmail.com>
 <1503c7940a7149679025173a46dd0daf@intel.com>
From:   "Kok, Auke" <auke-jan.h.kok@intel.com>
In-Reply-To: <1503c7940a7149679025173a46dd0daf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/7/22 09:46, Luck, Tony wrote:
>>> These are software(driver) defined error codes. Rest of the error codes are supplied by
>>> the hardware. Software defined error codes were kept at the other end to provide ample space
>>> in case (future) hardware decides to provide extend error codes.
>> Why put them in the same number space? Separate software results from
>> the raw hardware results and have a separate mechanism to convey each.
> We wanted to include in the "details" file, which is otherwise a direct copy of
> the SCAN_STATUS MSR. Making sure the software error codes didn't overlap
> with any h/w generated codes seemed like a good idea.
>
> But maybe we should have done this with additional string values in the status
> file:
>
> Current:
>
> pass
> untested
> fail
>
> Add a couple of new options for the s/w cases:
>
> sw_timeout
> sw_retries_exceeded


We've made a userspace implementation for this API already as part of 
opendcdiag that uses it:

https://github.com/opendcdiag/opendcdiag/commit/0cbfcee30e0666b0f79a2e452d7f8167d2a0cb90

What I really like is that with this proposed API, we can unambiguously 
determine whether "the core failed" or "everything is fine, for now" by 
reading a single file. I hate to see this file become unusable because 
its content changes from "pass" to "sw_timeout" or, even worse, it 
changes from "fail" to "sw_timeout". That would render it useless for 
the purpose that I think our users will be looking at it.

So, my preference would be to keep this file functioning as-is in this 
patch series.

I would think that some sort of expandable "statistics" file would be a 
better way to output various metrics:

```

sw_timeout: 0

sw_retries_exceeded: 2

runs: 42

first_run: 1405529347

last_run: 1646948140

<etc..>

```

just as a suggested alternative for more/incompatble output values or a 
complex, dynamic format.

I don't have any use in opendcdiag for these values and data. If someone 
does, they should want to chime in perhaps.


Auke

