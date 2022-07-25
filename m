Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009B158067A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbiGYV0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbiGYV0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:26:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE1D22BFB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658784365; x=1690320365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lMW7RJGDwcUJE3BQ84DAd4KiWzQgkK04O6Nj6mPZQk0=;
  b=Wo0xQIdI2oFFqRXtdwNlNfNJJ3c7Pbb+eleo4VGqGPK8LcvVjKg1fRWa
   rbeHEWcVbeMTNzbrRT46hgJi0GjBfHrZnK1Rv4Y6rCLyHH6s9WLehBFjh
   Kry6Efi4oQO6+oHTNuoexQvU3cuisYtdGnAFX9kuHYfzXaacISEi2eO3v
   WDDC/240a1sMnd8bAGuRgqtvaNx6LYWp83MOgqfyFVCcXLw+uzelWvdbi
   G4CaX++5/pss4LesR1mnaP7bVlk1tzMoMyw8cmc9R8m9ta9zfeiD6Nu5b
   lGVqMCUrWVN6ydxHTkcOdbumbcKvuPvpEO8o2AaAoT/sE74PIMXg665p0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="351793212"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="351793212"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 14:26:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="596806665"
Received: from spaletti-mobl1.amr.corp.intel.com (HELO [10.212.231.21]) ([10.212.231.21])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 14:26:04 -0700
Message-ID: <291808ee-d5ab-a7b2-33e2-62a449e90cbf@intel.com>
Date:   Mon, 25 Jul 2022 14:26:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [patch V4 09/65] x86/fpu: Sanitize xstateregs_set()
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
References: <20210623120127.327154589@linutronix.de>
 <20210623121452.214903673@linutronix.de>
 <CANaxB-wkcNKWjyNGFuMn6f6H2DQSGwwQjUgg1eATdUgmM-Kg+A@mail.gmail.com>
 <4812abd6-626c-67e4-7314-be282cd25a4a@intel.com>
 <CANaxB-w1+zCupiS5HyofGhVD7TKqZCoRjv9VZiegROiPkMY3NA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CANaxB-w1+zCupiS5HyofGhVD7TKqZCoRjv9VZiegROiPkMY3NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/22 10:57, Andrei Vagin wrote:
> On Mon, Jul 25, 2022 at 10:47 AM Dave Hansen <dave.hansen@intel.com> wrote:
>> On 7/13/22 21:04, Andrei Vagin wrote:
>>>> -       /*
>>>> -        * mxcsr reserved bits must be masked to zero for security reasons.
>>>> -        */
>>>> -       xsave->i387.mxcsr &= mxcsr_feature_mask;
>>>> -
>>>> -       /*
>>>> -        * In case of failure, mark all states as init:
>>>> -        */
>>>> -       if (ret)
>>>> -               fpstate_init(&fpu->state);
>>>> +       fpu__prepare_write(fpu);
>>>> +       ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
>>> This change breaks gVisor. Now, when we set a new fpu state without
>>> fp,sse and ymm via ptrace, mxcsr isn't reset to the default value.
>>> The issue is reproduced only on hosts without xsaves. On hosts with
>>> xsaves, it works as expected.
>> Is gVisor some out-of-tree kernel code or is it just an proprietary KVM
>> user?  In other words, is this an issue with the upstream kernel itself
>> or does it require kernel modification?
> This is on the upstream kernel without any modifications. And this is the case
> when gVisor uses ptrace to trap syscalls. KVM isn't used in this case.

Do you happen to have a quick reproducer for this, or at least the
contents of the buffer that you are trying to restore?

I'm struggling to if we broke a meaningful part of the ABI, or if this
is fallout from the kernel being more hesitant to zap the whole buffer
when it has problems.
