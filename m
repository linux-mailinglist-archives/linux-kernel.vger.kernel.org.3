Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA05803A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiGYRrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiGYRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:47:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D00BF64
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658771270; x=1690307270;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RKZxIpJJdH3+qRQjiSjkogmOvwQsvbzd1L2k96VoxZg=;
  b=hWk3z1/aIrh5M9wtB3WTlegg/0GjyUwBjlEQ26wYvmp52lLZM7ZcSJ0N
   BXK4fHWHkG0Xh4JvK1zMY4bBkrEb5WwrJbWEpYrLc2rAtRNVhODBLJn24
   wCruJFW6THaXLWd6BGLVgb1SEQZEdbutx9mngaq9e8nM0WAyfaw9xSc5f
   XPCT0fOJEiG0TgLBxv7poz8FCfZYb5U0e3p7MMm5zqR3FgYYkj0e1KoNV
   o0Pi6Hp7n9jCM1xAx+6iC6Qe9QNsSqj/moX5vpdOgP/6MTr45R72p5F3s
   L6OE9/HNgo+lJRDidrzPeKaAyvxunebDn58HydfAZVkzno4IuwK7fZLWK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="351752837"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="351752837"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 10:47:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="596751386"
Received: from spaletti-mobl1.amr.corp.intel.com (HELO [10.212.231.21]) ([10.212.231.21])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 10:47:49 -0700
Message-ID: <4812abd6-626c-67e4-7314-be282cd25a4a@intel.com>
Date:   Mon, 25 Jul 2022 10:47:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [patch V4 09/65] x86/fpu: Sanitize xstateregs_set()
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CANaxB-wkcNKWjyNGFuMn6f6H2DQSGwwQjUgg1eATdUgmM-Kg+A@mail.gmail.com>
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

On 7/13/22 21:04, Andrei Vagin wrote:
>> -       /*
>> -        * mxcsr reserved bits must be masked to zero for security reasons.
>> -        */
>> -       xsave->i387.mxcsr &= mxcsr_feature_mask;
>> -
>> -       /*
>> -        * In case of failure, mark all states as init:
>> -        */
>> -       if (ret)
>> -               fpstate_init(&fpu->state);
>> +       fpu__prepare_write(fpu);
>> +       ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
> This change breaks gVisor. Now, when we set a new fpu state without 
> fp,sse and ymm via ptrace, mxcsr isn't reset to the default value.
> The issue is reproduced only on hosts without xsaves. On hosts with
> xsaves, it works as expected.
Is gVisor some out-of-tree kernel code or is it just an proprietary KVM
user?  In other words, is this an issue with the upstream kernel itself
or does it require kernel modification?
