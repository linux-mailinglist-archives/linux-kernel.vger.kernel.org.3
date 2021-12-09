Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E008846E3E2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhLIIQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhLIIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:16:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4DEC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 00:13:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639037599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UsOJNwKmhXSBB0U8D3ufuMxmFz4ZFGFz1+SJ7OxFjKI=;
        b=eUl9Unym8+X4Zr4jaqVnB8j/DP4JAWhUL/D6KOW9eRXfF89EnyT1VKgKP4gKQyWplTlh54
        adeXPkPhiDLuefEyIXET2RxQ7gCdZW8HTFpMhjiJpBjaIHedqr2ie/47yvDISpY7h/PJQv
        u1B874iJSJDgPe+VjWwbpcH4zXdv+ecqixIn3nOHXmMZtuVdIikRzpirpzEhVbVEbprPZg
        3ZLSrI0gL0VA60givbjnNUvJIt+gqMrEcaKhGdksT+Dqb+q7MDlF7DeffjXELcM9oIX+VO
        bq9XSccDZNtiZwX/9nOh0ZXhPQGGnzSXUinUxV5/xOUmZQ/x8sqdOVDAujr4kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639037599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UsOJNwKmhXSBB0U8D3ufuMxmFz4ZFGFz1+SJ7OxFjKI=;
        b=DcOWHHSYqZ0UFF1a/4A9eCj5StOZP4GKRbvpGR7x/EC87IjB4pd4PTL59ovBa0C3YZ5wJQ
        Av4sXn4LK/Z2/nBQ==
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
Date:   Thu, 09 Dec 2021 09:13:18 +0100
Message-ID: <87v8zyyz4x.ffs@tglx>
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

Yes, right before the sigaltstack_lock() invocation.

Thanks,

        tglx
