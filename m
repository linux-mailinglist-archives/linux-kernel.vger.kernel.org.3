Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C944D7B30
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiCNHFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiCNHFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:05:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184E10FDB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647241446; x=1678777446;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ZNQQbWtwZdlcGaOwYgxLMUCbM4F4zJI+ljHGsNI3jQI=;
  b=bh4zc1zqUEY1Ps060HD3OEi9x8wouopYEosmgZ6BARJQSdumIwL3IRFB
   JlTW8Uj+8b8jJBFQraKFOhMklewVIzPsIq7pgEKcPd56RUuyqWy/w8UGx
   CQdfmjNDAiMu6IFGdsoIHfAO0iodqN7pygqLDm05HtTrMgjKUmrrEuCHM
   euuzfE0JYPlt3ZAW04e0COnhpaTtA4KxrvDtQBe/TUfGH/tau6IpnChAG
   0Fi3rOgWvb3H3X0wFwLOEoMx3HoWAM8VS1RA9lGn6iBovxqfx5ypwX+h1
   J8tx3vBDoB14RQQW0O11zOlri5rqHej3ZFyD78jGjsJ+kuNd/Tk+Cn9T2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="280710149"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="280710149"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 00:04:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="515301871"
Received: from zborja-mobl1.amr.corp.intel.com (HELO [10.212.239.199]) ([10.212.239.199])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 00:04:06 -0700
Message-ID: <1a8ffb1a-d948-0a02-33d5-c332d3e2c228@intel.com>
Date:   Mon, 14 Mar 2022 00:03:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, x86@kernel.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        oleg@redhat.com, ananth.narayan@amd.com
References: <20220310111545.10852-1-bharata@amd.com>
 <81b6f618-05bc-f7d0-5461-4c3f0ca42d3f@intel.com>
 <57338b2a-291c-c7e7-57d5-86a8468b619f@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
In-Reply-To: <57338b2a-291c-c7e7-57d5-86a8468b619f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/22 22:00, Bharata B Rao wrote:
> On 3/10/2022 8:46 PM, Dave Hansen wrote:> 1. While Intel LAM provides two LAM widths (15 and 6 bits wide), AMD UAI
> has a fixed tag width of 7 bits. This results in following differences
> in the implementation:
>    - Two threadinfo flags (TIF_LAM_57 and TIF_LAM_48) in Intel LAM vs
>      single flag TIF_TAGGED_ADDR(like in ARM64) in AMD UAI.
>    - Untagging needs to be aware of 2 widths in Intel LAM as against
>      a single width in AMD UAI.

I'd be perfectly happy with an initial version of this stuff that only
comprehends UAI and LAM_57.  As long as the ABI can be used for all
three cases, adding the two most similar ones initially would make a lot
of sense.

>    - Requirement of making LAM_U48 and mappings above 47bits mutually
>      exclusive is required for Intel LAM only.
> 
> 2. The enablement bit is part of CR3 in Intel LAM which brings in
> additional complexity of updating the CR3 with right LAM mode on every
> MM switch and associated tlbstate changes. In AMD UAI, enablement bit
> is part of EFER MSR and it is a single time enablement with no MM switch
> time changes.

Hold on a sec.  The context-switching is a *policy*.  A _kernel_ policy.
If we wanted the LAM settings to be static and system wide, we'd just
have a single:

	if (cpu_feature_enabled(LAM))
		cr3 |= LAM_MASK;

in build_cr3().  That's not exactly complicated.

You know what's a heck of a lot more complicated than that?  Adding
context-switching for EFER.

I can't imagine a world where we want this tagging to be system-wide.
There *ARE* going to be apps that break with this pointer tagging stuff.
 Normal, user apps.  Apps in containers.  With a system-wide setting,
they have zero recourse when things break.  All a user can do is reboot
the kernel.

As-is, it seems like it would be awful to even develop apps that use
tagging.  You always want to test them with tagging on and off.  With
this, you need to reboot to test either way.

Also, the prctl() in Kirill's version actually enables and disables the
hardware feature in addition to the in-kernel tag/untag operations.
This series takes the same ABI and doesn't change the hardware feature
state.  That will need to be rectified at some point.

Speaking of which, it's also really worrying that kernel behavior is
affected by _EFER_UAI.  When tagging is "disabled" in the prctl(),
_EFER_UAI is still set.  The kernel can go merrily dereferencing both
kernel and userspace pointers with no canonical checks.  That seems
scary.  LAM's supervisor separation makes things a lot less scary.
