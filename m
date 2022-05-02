Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50251735B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbiEBQCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbiEBQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:02:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2BDF44
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:58:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651507121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HJPfsguArwZ596yti4dAVW3XVwKfh1DhOc2Y4P/j3jA=;
        b=Oqr2TDYZHy8m3rVI4Q63176uq2NiTUlG62XwYY1hKEiLWB8ZpGM+1bVY4buVxM3u7QXBNt
        YIZ0NlJbfLpKbPr7YDo/StV5IDiZZtzw9DCexJlSP2T7OfVMzehxp3oBz+ZPFmhGVsg1lS
        NhL4qJnxKCFfGS4Xgzw6zpAA7dwdx89Ayt1KrTEZThUCsfndztE/ZLQzEzCE36agVrUOR7
        OLUTQ1slRv8D2SXCpXUQB25VxxIWL580oy3v2mUQV8YujyNiLOc7B3a7s34HXdIRYnBrv+
        JSgoIS5c9qlIqyEi7kkqVer4hDEb7kU9gfDcxifxlrtp9Zn3GsPuts9i1VlYwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651507121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HJPfsguArwZ596yti4dAVW3XVwKfh1DhOc2Y4P/j3jA=;
        b=00SRPYk7xO6OAsgIDnTxp6hC4Ht3gQUtm7oTsbGedXTuTsKy09GUKrvI1h2HHmusenx77f
        u/9nj8ksHDBjBgCQ==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
In-Reply-To: <Ym/sHqKqmLOJubgE@zn.tnic>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de> <Ym/sHqKqmLOJubgE@zn.tnic>
Date:   Mon, 02 May 2022 17:58:40 +0200
Message-ID: <87k0b4lydr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02 2022 at 16:35, Borislav Petkov wrote:
> On Sun, May 01, 2022 at 09:31:47PM +0200, Thomas Gleixner wrote:
>>  /**
>> + * fpregs_lock - Lock FPU state for maintenance operations
>
> "maintenance"?

I meant maintenance of user thread FPU state. Let me rephrase. 

>> + *
>> + * This protects against preemption, soft interrupts and in-kernel FPU
>> + * usage on both !RT and RT enabled kernels.
>> + *
>> + * !RT kernels use local_bh_disable() to prevent soft interrupt processing
>> + * and preemption.
>> + *
>> + * On RT kernels local_bh_disable() is not sufficient because it only
>> + * serializes soft interrupt related sections via a local lock, but stays
>> + * preemptible. Disabling preemption is the right choice here as bottom
>> + * half processing is always in thread context on RT kernels so it
>> + * implicitly prevents bottom half processing as well.
>> + */
>> +void fpregs_lock(void)
>> +{
>> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>> +		local_bh_disable();
>> +	else
>> +		preempt_disable();
>
> So I'm wondering: can we get rid of this distinction and simply do
> preempt_disable()?
> 
> Or can FPU be used in softirq processing too so we want to block that
> there?

Yes, FPU can be used legitimately in softirq processing context.

> But even if, fpu_in_use will already state that fact...

Right, though currently it's guaranteed that softirq processing context
can use the FPU. Quite some of the network crypto work runs in softirq
context, so this might cause a regression. If so, then this needs to be
an explicit commit on top which is easy to revert. Let me stare at it
some more.

>> @@ -410,10 +433,9 @@ void kernel_fpu_begin_mask(unsigned int
>>  {
>>  	preempt_disable();
>>  
>> -	WARN_ON_FPU(!kernel_fpu_usable());
>> -	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
>> +	WARN_ON_ONCE(!kernel_fpu_usable());
>>  
>> -	this_cpu_write(in_kernel_fpu, true);
>> +	this_cpu_write(fpu_in_use, true);
>
> This starts to look awfully similar to fpregs_lock()...

Similar, but not identical and we cannot use fpregs_lock() here as we
don't want to have local_bh_disable() when in hard interrupt context.

>>  	if (!(current->flags & PF_KTHREAD) &&
>>  	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
>> @@ -433,9 +455,9 @@ EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask)
>>  
>>  void kernel_fpu_end(void)
>>  {
>> -	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
>> +	WARN_ON_ONCE(!this_cpu_read(fpu_in_use));
>>  
>> -	this_cpu_write(in_kernel_fpu, false);
>> +	this_cpu_write(fpu_in_use, false);
>>  	preempt_enable();
>
> ... and this to fpregs_unlock().
>
> Can we use those here too instead of open-coding them mostly?

Not really, unless we drop the use FPU in softirq processing context
guarantee. See above.

Let me think about it.

Thanks,

        tglx
