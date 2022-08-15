Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FEF592AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbiHOHqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiHOHqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:46:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A93B19C22
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zj05h5WRDNEGZav6WPXKYXJG05j6fxV7WuQD5K9sJhU=; b=gWvNvXFAZQwHSLQqVokC+YYD3w
        eATKHFNUy+tW3Af52pHa6L9VMtsSe1Q5SQZ2yQQmcQ4cGDrET+4PF/0X1EAuv5J3FYKNDEt9nKYXJ
        ZXf3jlL0Yvx7oKiZrSISO9obsoPC04g+wWaXOIYU4Pa9TJ0xfRyVQFZ4AcbFw0Mr26472GSjrS48e
        z3oaEeornlb1qGSuEAmz9eRzwI7z2kinaU16uS5rzqucSFgkTn8s86LRn8hsMFV3FA/gqvvmRBUjF
        8L8ysul8F8N6+6uDqdpKP3OgnRWxbwTMl/35VoO0CcImyZ1A2vvl+RrQfWREmINMiA6GeTU9EFvho
        ItPLZLIg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNUnU-002c6f-Me; Mon, 15 Aug 2022 07:46:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D9B7980264; Mon, 15 Aug 2022 09:46:04 +0200 (CEST)
Date:   Mon, 15 Aug 2022 09:46:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/5] x86/microcode/intel: Allow a late-load only if a min
 rev is specified
Message-ID: <Yvn5vBRNz9z8Y4A9@worktop.programming.kicks-ass.net>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-4-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220813223825.3164861-4-ashok.raj@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 10:38:23PM +0000, Ashok Raj wrote:

> The proposal here is an even simpler option. The criteria for a microcode to
> be a viable late-load candidate is that no CPUID or OS visible MSR features
> are removed with respect to an earlier version of the microcode.
> 
> Pseudocode for late-load is as follows:
> 
> if header.min_required_id == 0
> 	This is old format microcode, block late-load
> else if current_ucode_version < header.min_required_id
> 	Current version is too old, block late-load of this microcode.
> else
> 	OK to proceed with late-load.
> 
> Any microcode that removes a feature will set the min_version to itself.
> This will enforce this microcode is not suitable for late-loading.
> 
> The enforcement is not in hardware and limited to kernel loader enforcing
> the requirement. It is not required for early loading of microcode to
> enforce this requirement, since the new features are only
> evaluated after early loading in the boot process.
> 
> 
> Test cases covered:
> 
> 1. With new kernel, attempting to load an older format microcode with the
>    min_rev=0 should be blocked by kernel.
> 
>    [  210.541802] microcode: Header MUST specify min version for late-load
> 
> 2. New microcode with a non-zero min_rev in the header, but the specified
>    min_rev is greater than what is currently loaded in the CPU should be
>    blocked by kernel.
> 
>    245.139828] microcode: Current revision 0x8f685300 is too old to update,
> must be at 0xaa000050 version or higher
> 
> 3. New microcode with a min_rev < currently loaded should allow loading the
>    microcode
> 
> 4. Build initrd with microcode that has min_rev=0, or min_rev > currently
>    loaded should permit early loading microcode from initrd.

What if any validation do you have to ensure min_rev does as promised?
That is, ucode can very easily lie about the number and still remove an
MSR or CPUID enumerated feature.

