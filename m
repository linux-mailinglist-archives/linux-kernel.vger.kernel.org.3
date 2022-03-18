Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2389B4DDA19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiCRNE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbiCRNEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:04:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D4EE26
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647608581; x=1679144581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y13Cjuw2H7tEE+1BWa6OiwOSaXllXsUoc+JlxP8YghY=;
  b=cNnaZvPmV9NHfT7kcqBlufn3tdQtjL4cUj+veDTTi8yW8+MLm1XqgFr7
   FnhOClRyC7QX1xljrdtrtAxXkJG3ELJz9rofiX46+YW3Va2MByz/AZ8b7
   ipz6xcb6NFg+YwO3OOnNDSaNzwB0fNje2y9nmbAAMv1c7MtGZdXFM1q7K
   nOSUqQSIKA92JWD24qw7yER4fXCosNP9WO5sFoxBZNLuw2xhQaKbZuPjR
   uEeiB8VTQArX2rAYsXVWSFgk9GqkUHaLMjqmpP9mMQZu81cZEn6pqG6DK
   wQJx5aM1FnHTbo9I981ZgIg8uMM5iH09sFN0IQQkTtztK9bl7QbC+V/yB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="244586024"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="244586024"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:03:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="822276642"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2022 06:02:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C806810E; Fri, 18 Mar 2022 15:03:13 +0200 (EET)
Date:   Fri, 18 Mar 2022 16:03:13 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
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
Subject: Re: [PATCHv6 07/30] x86/traps: Add #VE support for TDX guest
Message-ID: <20220318130313.tv7vecdahoakbetf@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-8-kirill.shutemov@linux.intel.com>
 <877d8t2ykp.ffs@tglx>
 <20220317173354.rqymufl37lcrtmjh@black.fi.intel.com>
 <20220317202141.GO8939@worktop.programming.kicks-ass.net>
 <5b3bece3-5956-3116-a07c-a0b6f380fac8@intel.com>
 <YjRlDytYjENcurpT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjRlDytYjENcurpT@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:55:11AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 17, 2022 at 01:32:07PM -0700, Dave Hansen wrote:
> 
> > The TDX rules are *much* nicer than SEV.  They're also a lot nicer on
> > TDX _now_ than they used to be.  There are a few stubborn people at
> > Intel who managed to add some drops of sanity to the architecture.
> 
> Right; that is saner than it used to be. I have definite memories that
> pages could be taken back by the TDX thing and would need
> re-authentication. A pool of 'fixed' pages was talked about. I'm glad to
> hear all that is gone.

Right, VMM can still pull memory form the guest at any point, but
reference of such memory from the guest would lead not to #VE as before,
but to TD termination.

-- 
 Kirill A. Shutemov
