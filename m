Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E2D4DCF60
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiCQUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiCQUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:33:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619ED18C0D6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647549138; x=1679085138;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=AEXJne/EhKcc7HM5kihV88ieb+qIyyW31oeTAwzgR+U=;
  b=XnKUaNbk8wUPzTxiyjmEs9YhH9RNuAS0hJQKeNHyjjOWdd3Rtc2zjb7Z
   2YgoP7j+OYyEA9AS/4Yewv0XZzpGAsU3pz9hAkgiXzvTCdPxGOzY4uaXE
   UXAKeHrgLK0t+9gn5W0AkTrf/vINKzIOjgiG1REAPIQtNEVE8w5a6dk6l
   rlVV+aszmeadwbt1tlxdQVxlI8rCii0hMsAN24O5GJNj+zZ972LP4mYTm
   6O9cLYuNY+HgiQ59vGD1kja7PBUiMx5O4Tl2dLcexYf8pDOhRs4s4mKGZ
   GOLxQnc2/lLQ8gRTT9o0bQupuR/BQHR29nbOfFA4lDBw1VFEMx9bc+WdW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254532509"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="254532509"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:32:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="516914989"
Received: from dstanfie-mobl2.amr.corp.intel.com (HELO [10.212.178.19]) ([10.212.178.19])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:32:15 -0700
Message-ID: <5b3bece3-5956-3116-a07c-a0b6f380fac8@intel.com>
Date:   Thu, 17 Mar 2022 13:32:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, luto@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-8-kirill.shutemov@linux.intel.com>
 <877d8t2ykp.ffs@tglx> <20220317173354.rqymufl37lcrtmjh@black.fi.intel.com>
 <20220317202141.GO8939@worktop.programming.kicks-ass.net>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv6 07/30] x86/traps: Add #VE support for TDX guest
In-Reply-To: <20220317202141.GO8939@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 13:21, Peter Zijlstra wrote:
> From vague memories #VE can be raised on any memop, loading the stack
> address in the syscall-gap is a memop. What makes that special? Can we
> get a comment _there_ to explain how this is safe such that we can keep
> it so?

#GP and #PF can be raised from any memop too.  But, we know that if we
only touch normal, valid kernel mappings, we don't have to worry about them.

The memop rules to avoid #VE are basically the same, except they also
include "TD-shared" memory.  But, "normal" kernel memory isn't ever
shared because it's under the control of the untrusted hypervisor.  The
kernel trusts shared memory like it trusts userspace-mapped memory.

The kernel would be insane to, for instance, put its stack in
userspace-writable memory.  The same goes for TD-shared memory.

In the end, I'm asserting that we don't really have to be any more
careful to avoid a #VE on a memory access than we are to avoid #GP and #PF.

The TDX rules are *much* nicer than SEV.  They're also a lot nicer on
TDX _now_ than they used to be.  There are a few stubborn people at
Intel who managed to add some drops of sanity to the architecture.
