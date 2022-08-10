Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB8158F259
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiHJSaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiHJSaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:30:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9CA120B1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660156218; x=1691692218;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=eRIfxMriTtGaH/iXtP4gPBPyX9bBYd/FuKldl09xlak=;
  b=PjIPB7V96ZNu4fD8QZXCjvvDrvE+r+FA3F1A0C/+mA3D20zzyc9sKMQE
   CNp9Q5Mdxby1z2T5L/eGogy4Bq9TsPR/s5+r/HWDcSDQCWmya+XM1YthH
   MAtbnLGm4RK46jhbswom5RTkenjtQlR7xb9Nd55FEsBucfmdYz3AlSSpj
   sjWZxuSniDCdVxEsQfrt4Cdl990h0ewPu5jhqMc9XwPpojnw38jimWgIi
   hcTA1awur3D/pnc1rBRKISXSd9Wi2wzZMNQL3sDCwTFCBre9qLWcAU/Zq
   oAcDmg8cXSCIZdy4hJZX4mxUgRF5Y50jHPhQQPFwh1sP2DLRBX6ON1Y9F
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="289916927"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="289916927"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 11:30:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="708323735"
Received: from vietnamv-mobl1.amr.corp.intel.com (HELO [10.254.67.219]) ([10.254.67.219])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 11:30:16 -0700
Message-ID: <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
Date:   Wed, 10 Aug 2022 11:30:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
 <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
From:   Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
In-Reply-To: <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 11:01, Dave Hansen wrote:
> On 8/9/22 16:40, Daniel Sneddon wrote:
>> The APIC supports two modes, legacy APIC (or xAPIC), and Extended APIC
>> (or x2APIC).  X2APIC mode is mostly compatible with legacy APIC, but
>> it disables the memory-mapped APIC interface in favor of one that uses
>> MSRs.  The APIC mode is controlled by the EXT bit in the APIC MSR.
>>
>> Introduce support for a new feature that will allow the BIOS to lock
>> the APIC in x2APIC mode.  If the APIC is locked in x2APIC mode and the
>> kernel tries to disable the APIC or revert to legacy APIC mode a GP
>> fault will occur.
>>
>> Introduce support for a new MSR (IA32_XAPIC_DISABLE_STATUS) and handle the
>> new locked mode when the LEGACY_XAPIC_DISABLED bit is set.
>>
>> If the LEGACY_XAPIC_DISABLED is set, prevent the kernel
>> from trying to disable it.
> 
> Let's also not obscure the fact that the MMIO/xAPIC interface is
> troublesome and there are real-world, practical reasons a piece of
> hardware might not want to implement it.  First on the list is:
> 
> 	https://aepicleak.com/
> 
Great point.  Since the problem with that interface wasn't public when I wrote
this patch I didn't have anything like that to link against.  Would you like me
to add the above link to the commit message?  I can certainly add more about the
SGX leak associated with APIC.

> Second on the list is TDX.  The TDX module spec currently just dictates
> that TDX guests must use x2APIC.  If this (IA32_XAPIC_DISABLE_STATUS)
> mechanism was enumerated to TDX guests, they could use this instead of
> crashing in burning in whatever horrid way they are now if someone
> disables x2APIC on the command line.
> 
> It would also be nice to know roughly when this feature is showing up.
> If it's going to show up as a part of a microcode update for my laptop
> next week or next month, this might warrant a backport.  Intel would
> presumably *want* a backport to happen there, too.
> 
I've been told that this will only be on Sapphire Rapids and newer.

> If it's going to be on one server CPU that's coming out in ten years,
> then we can hold off.
SPR will certainly be sooner than 10 years, and with distros running on LTS
kernels, it is probably worth backporting.  Since this isn't a bug fix (not a sw
bug anyway), is this something I can just CC stable or is there a better way to
say "Yes, this is a new feature, BUT, you really want it anyway"?

> 
> It might also help to link to the documentation, even if it's below a
> "--" in the changelog since these URLs aren't very stable.
> 
>> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/cpuid-enumeration-and-architectural-msrs.html
> 
> or at least mention what the status of the documentation is.
> 
> The code looks OK to me, but I'm far from impartial because this isn't
> my first look at it.  In any case:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks!

