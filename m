Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DC04D6A10
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiCKWwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiCKWwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:52:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9AF1409D0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647037844; x=1678573844;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=rCFdGeOoGSRoO6cqnYj1xlhLSbsmex/R1MQnhd4g/08=;
  b=jg8y5cmTl1wwieyISJTwlswXFVrJj7kRE8y1KbzcHbAUwbrSPTBnSRxq
   3bjQUd9dQ44FqA+HjPp5Zcm+JJXwGAq+5XH9pM5vY+F+lYMFTV5x8eeg4
   0tJTZcvYVYxcUG+CxqgzC6dORL3SHjZ4TapfxiDNsM5EA6Z/ew1XQbVmD
   WllvGJL8vUmLjpyC9jidFoED9DmtWEqfUgLk2ZEo5HYwNeblnyB3kvtJC
   fMRYRh7WkYDx7eMhWR88eGPpgIOyhf+elR2DrEexnijWWmcBCo5UsULuz
   ccocd1H9bURjOL8FQM/BYIRfAL3+F8zODuXXqLlWDAuV/U2l/HV04XkLF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255604311"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="255604311"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 13:23:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="645060406"
Received: from cpeirce-mobl1.amr.corp.intel.com (HELO [10.212.128.243]) ([10.212.128.243])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 13:23:32 -0800
Message-ID: <103853ef-3afb-bb94-5ffd-8318d1a1d1a0@intel.com>
Date:   Fri, 11 Mar 2022 13:23:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20220311190749.338281-1-namit@vmware.com>
 <20220311190749.338281-3-namit@vmware.com>
 <a2a43395-b848-a4f9-4065-109387680701@intel.com>
 <AC8D21EA-CD32-4F9F-B5C1-ED8804EC76FF@vmware.com>
 <70e08bd5-187a-daee-2822-1d9a437a9cff@intel.com>
 <E46E0DA7-6427-4733-9D43-6CC1107194D6@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RESEND PATCH v3 2/5] x86/mm: check exec permissions on fault
In-Reply-To: <E46E0DA7-6427-4733-9D43-6CC1107194D6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 13:16, Nadav Amit wrote:
>> This is really about checking the sanity of the "hardware"-provided
>> error code.  Let's just do it in  handle_page_fault(), maybe hidden in a
>> function like:
>>
>> void check_error_code_sanity(unsigned long error_code)
>> {
>> 	WARN_ON_ONCE(...);
>> }
>>
>> You can leave the X86_PF_PK check in place for now.  It's probably going
>> away soon anyway.
> Done. Thanks. But note that removing the check from access_error() means
> that if the assertion is broken, userspace might crash inadvertently
> (in contrast to the version I sent, which would have potentially led to
> infinite stream of page-faults). I don’t know which behavior is better,
> so let’s go with your version and just hope it doesn’t happen.

Actually, crashing sounds much nicer to me than infinite page faults.
It's a lot easier to debug, *especially* with a warning on dmesg.

