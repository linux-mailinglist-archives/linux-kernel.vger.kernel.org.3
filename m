Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D3646DBDD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhLHTSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:18:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhLHTSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:18:12 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638990879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=badhGGC3H+4GwJIwS5GPlqrZLkXL90Xg2ZKSrj4phbI=;
        b=eDG0iSkVDDUGrv2wvF0QmEJDB3sl3yZQIz+tb/dGWRqG1SjWz2qfF5yfUYXdp85GXwn+yi
        ibDbcrUxUHbNY3Oj3CmgRmYoiS9co8He9apLKN6R7lKZQRqT7/rNW9xQzm2KDaj/5BspfL
        Kzu0oi3X8iQaYOZlx651g/KjGH0w/R8dwZ5wLgYJ1QI2Y2n66apzEVW6Ju9ah19OidzEAb
        Ms2sSHYg5djkmn11KS+IGOKh/w4ukmZ0Kh/xJ7PBxw04KO+w/g2Kn4xssbIkp15e37/Vb7
        vYmHVYwemtKetqofruKNGu9tuc1/PJ/TWk7paFTF3QTEvLqqFA5e3b1UsJkKdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638990879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=badhGGC3H+4GwJIwS5GPlqrZLkXL90Xg2ZKSrj4phbI=;
        b=882aCz1N1zdxg9VrKw2NNzLIdA9BqrkdAc7mIRHWOgPrllDz8Y9vHWG4zbNWrqkgnXJxgY
        q79woSsCc10oTtAg==
To:     Dave Hansen <dave.hansen@intel.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "Sang, Oliver" <oliver.sang@intel.com>,
        Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [x86/signal] 3aac3ebea0: will-it-scale.per_thread_ops -11.9%
 regression
In-Reply-To: <c94b8394-08cd-8273-2cd5-1ee5880d4c36@intel.com>
References: <20211207012128.GA16074@xsang-OptiPlex-9020>
 <bbc24579-b6ee-37cb-4bbf-10e3476537e0@intel.com>
 <DF832BC5-AB0F-44AD-83C3-E0108176F945@intel.com>
 <c94b8394-08cd-8273-2cd5-1ee5880d4c36@intel.com>
Date:   Wed, 08 Dec 2021 20:14:38 +0100
Message-ID: <874k7i29k1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08 2021 at 10:20, Dave Hansen wrote:
> On 12/8/21 10:00 AM, Bae, Chang Seok wrote:
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index a629b11bf3e0..8194d2f38bf1 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -4224,6 +4224,11 @@ int restore_altstack(const stack_t __user *uss)
>>         stack_t new;
>>         if (copy_from_user(&new, uss, sizeof(stack_t)))
>>                 return -EFAULT;
>> +       if (current->sas_ss_sp == (unsigned long) new.ss_sp &&
>> +           current->sas_ss_size == new.ss_size &&
>> +           current->sas_ss_flags == new.ss_flags)
>> +               return 0;
>> +
>>         (void)do_sigaltstack(&new, NULL, current_user_stack_pointer(),
>>                              MINSIGSTKSZ);
>>         /* squash all but EFAULT for now */
>
> This seems like a generally good optimization that could go in
> do_sigaltstack() itself, no?
>
> Either way, it seems like 0day botched this a bit.  '3aac3ebea0' wasn't
> the actual culprit, it was the patch before.

The patch it pointed to was the one which enabled that config switch.
