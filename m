Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3465658F211
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiHJSBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiHJSBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:01:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A5111A2F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660154489; x=1691690489;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3rTmOyYZVT0I5124ROCzwftBtAV5MQs3DeNu/klIUxI=;
  b=F4kjhcXRK1SETFg3KgRfKkfeGVU5j2trtX1sR1K8Vp0kTn6XxycmgAto
   sOlw5+Fqw1rLcRuaWWIh76wYTvWctaB1kqzZeTUZ8GH0uElXjTi2qAUFq
   44MsjR6gQsYhuYO1TC89jU6c/KsJt6tMqKVSctg1EqI4UuKlzCoXLVuIK
   i8ld3o3g1Lp8TwBXLwtB3qDpg+mHVBnXSzMIOCgXfjyz6FFbd+pKpMkul
   Ba/TuAvgT1M4rFrh9fCTshSQOFc3l/5cEr09rnLziC84NZX4sJv0DNKKk
   7kn4+ucpIbkg5qqx3BYznE0J8X5wb5qbX8m5XNLrXd89Y4gdbEIJVtAdU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="288723059"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="288723059"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 11:01:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="781317211"
Received: from snedunga-mobl2.amr.corp.intel.com (HELO [10.212.234.47]) ([10.212.234.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 11:01:28 -0700
Message-ID: <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
Date:   Wed, 10 Aug 2022 11:01:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
Content-Language: en-US
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 16:40, Daniel Sneddon wrote:
> The APIC supports two modes, legacy APIC (or xAPIC), and Extended APIC
> (or x2APIC).  X2APIC mode is mostly compatible with legacy APIC, but
> it disables the memory-mapped APIC interface in favor of one that uses
> MSRs.  The APIC mode is controlled by the EXT bit in the APIC MSR.
> 
> Introduce support for a new feature that will allow the BIOS to lock
> the APIC in x2APIC mode.  If the APIC is locked in x2APIC mode and the
> kernel tries to disable the APIC or revert to legacy APIC mode a GP
> fault will occur.
> 
> Introduce support for a new MSR (IA32_XAPIC_DISABLE_STATUS) and handle the
> new locked mode when the LEGACY_XAPIC_DISABLED bit is set.
> 
> If the LEGACY_XAPIC_DISABLED is set, prevent the kernel
> from trying to disable it.

Let's also not obscure the fact that the MMIO/xAPIC interface is
troublesome and there are real-world, practical reasons a piece of
hardware might not want to implement it.  First on the list is:

	https://aepicleak.com/

Second on the list is TDX.  The TDX module spec currently just dictates
that TDX guests must use x2APIC.  If this (IA32_XAPIC_DISABLE_STATUS)
mechanism was enumerated to TDX guests, they could use this instead of
crashing in burning in whatever horrid way they are now if someone
disables x2APIC on the command line.

It would also be nice to know roughly when this feature is showing up.
If it's going to show up as a part of a microcode update for my laptop
next week or next month, this might warrant a backport.  Intel would
presumably *want* a backport to happen there, too.

If it's going to be on one server CPU that's coming out in ten years,
then we can hold off.

It might also help to link to the documentation, even if it's below a
"--" in the changelog since these URLs aren't very stable.

> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/cpuid-enumeration-and-architectural-msrs.html

or at least mention what the status of the documentation is.

The code looks OK to me, but I'm far from impartial because this isn't
my first look at it.  In any case:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
