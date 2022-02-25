Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB94C3A83
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiBYAwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiBYAwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:52:12 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6B836142
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645750301; x=1677286301;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=4cGPwk8l49YmYXLRDTUg1zx2OXM9J1CydnuLKRxRXKw=;
  b=NL3iG6OjAQESCyAGj1HV35lA/inLdQJ4brPvyFwxMO+AiqVR6reI7NI6
   uDHwwwO01ucWAS8B0KMxOAgvKLE9orlBQLu9Hih3wiLvy75toqonHNPx5
   wNAMsAlfmXr2CkOzpuUjjGsezE9hp/yVK357jb9RfAdSlmmJFxLnVUqmx
   h/r0E4oWn8pPn6jj8kQ2TmISXdPMvTPQUc4l4+23Q3j7qOMSq8g67dBMv
   zqI+PGH4JIr2eHmQ3oY+d65Gcu07BltHWa5QEjeL9izRrf9OEp5xykfJY
   0caluWFny88rUBwJeP3Qiu9TCdsHfTw5veOgXzzm0qO7thZPRyH9WI/XK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239788361"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="239788361"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:51:26 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="639938894"
Received: from hthen-mobl2.amr.corp.intel.com (HELO [10.209.48.194]) ([10.209.48.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:51:25 -0800
Message-ID: <4940a38f-282b-7ce6-4d4c-2db1072ed3ca@intel.com>
Date:   Thu, 24 Feb 2022 16:51:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-6-kirill.shutemov@linux.intel.com>
 <d51dc9c2-61e5-c8dd-e358-e4ab3d5429ac@intel.com>
 <20220224235413.lrzczn7re4mfdkup@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 05/30] x86/tdx: Extend the confidential computing API to
 support TDX guests
In-Reply-To: <20220224235413.lrzczn7re4mfdkup@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 15:54, Kirill A. Shutemov wrote:
> 
>> Second, why have the global 'td_info' instead of just declaring it on
>> the stack.  It is only used within a single function.  Having it on the
>> stack is *REALLY* nice because the code ends up looking like:
>>
>> 	struct foo foo;
>> 	get_info(&foo);
>> 	cc_set_bar(foo.bar);
>>
>> The dependencies and scope are just stupidly obvious if you do that.
> Okay, I will rework it with plain gpa_width on stack and get_info(&gpa_width);
> Attributes will be needed after core enabling, so I will drop it from
> here.

I don't mind the 'struct tdx_info' if there's going to be more stuff in
it soon-ish.  Having a single member is fine for now.  Just make it
clear that the seamcall returns a bunch of stuff and only a subset of it
is used right now.
