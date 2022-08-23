Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7020A59D222
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbiHWH3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbiHWH3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:29:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630DBF7F
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:29:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso13751883pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6rjKjGvWfH7qaw/ThpAgdUKhPt+rDOn01TCeIlQWtMc=;
        b=igzpi2isTqn0rnLieyXZehZ9y9gWabYQpEXz/VME7rt6M9Upzet8DvOxHa+/y3tN1Q
         VtbtWpC02+1jMXLZwsEThVobeCOo+nH+jFW6xlyVm6AUgiEqCcB/FQ2JZwiuEPXhNYIK
         6m13CW79f7kYvP7gZMLIJOegwKvu93/97B4ZQ26ZR4afr18/a183hYFCmtsupE8InmUX
         IscICRzaDAYREWw18jTlvShCQXN7iSc1eJcd6DCcqU4SGt4yOmYwZ2MdEWhWI1mHXB4r
         r9j+Hu//FFIhRBdypWnY8XB2vNkmw1ZYj56tBgNA8iCaOrSiLlLBr4wTKTv1hDItpMBQ
         3WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6rjKjGvWfH7qaw/ThpAgdUKhPt+rDOn01TCeIlQWtMc=;
        b=DQgI9CYgTAmxaKKPCvu4ieTN4FOiuXe2L4KyK7bbj9/HYQC7h6sFiErzBQH5BPVu/t
         ae0ORbH+IMlemgllpgJcMGhaP0NqJUHln7uRoNM/zpAcD2oc+8+3ibNc3SV9B+uZrD4Y
         XBpNORjyEmzEzFvEZh+fan2KxYSh2uDZc6z3Fb9q8CW0vM51cdCm3A1XUVCRo0qdaqN/
         SXAb27szs7Auxw5nLixm4jF69m6WbEILVUzdOSMT+165/pa5oc6FFn8stBONo5UxsA6z
         hLuFmXLdBKx4UlBnQXQ8bgk4agH6auiL/LYs8sF9HWRzs/guYIay/kHe9Cbu/8A/vXIF
         Ki4A==
X-Gm-Message-State: ACgBeo1N75rILSy+KvW+RU++0QGrUx69oiFIkHY//gzBrPI5o57rP13i
        FRQKjrd8jG2Rqmwtr6xIeyJ0bn+DNA==
X-Google-Smtp-Source: AA6agR6sZGbcyq2RGcimTyVnDjXZPFOs//AbCSv0fe5nKjuBhCK9Q7MfHhtJfYI8o6wz19AjBO+Ltw==
X-Received: by 2002:a17:902:c40e:b0:172:dee4:882e with SMTP id k14-20020a170902c40e00b00172dee4882emr10868781plk.11.1661239749861;
        Tue, 23 Aug 2022 00:29:09 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b0016be527753bsm1728502plg.264.2022.08.23.00.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:29:09 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:29:01 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [RFC 07/10] lib/cpumask: Introduce cpumask_not_dying_but()
Message-ID: <YwSBvQtxjy8I7bp9@piliu.users.ipa.redhat.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
 <20220822021520.6996-8-kernelfans@gmail.com>
 <YwOPkc1cpoD/hs2D@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwOPkc1cpoD/hs2D@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 07:15:45AM -0700, Yury Norov wrote:
> On Mon, Aug 22, 2022 at 10:15:17AM +0800, Pingfan Liu wrote:
> > During cpu hot-removing, the dying cpus are still in cpu_online_mask.
> > On the other hand, A subsystem will migrate its broker from the dying
> > cpu to a online cpu in its teardown cpuhp_step.
> > 
> > After enabling the teardown of cpus in parallel, cpu_online_mask can not
> > tell those dying from the real online.
> > 
> > Introducing a function cpumask_not_dying_but() to pick a real online
> > cpu.
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Steven Price <steven.price@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > To: linux-kernel@vger.kernel.org
> > ---
> >  include/linux/cpumask.h |  3 +++
> >  kernel/cpu.c            |  3 +++
> >  lib/cpumask.c           | 18 ++++++++++++++++++
> >  3 files changed, 24 insertions(+)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index 0d435d0edbcb..d2033a239a07 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -317,6 +317,9 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
> >  	return i;
> >  }
> >  
> > +/* for parallel kexec reboot */
> > +int cpumask_not_dying_but(const struct cpumask *mask, unsigned int cpu);
> > +
> >  #define CPU_BITS_NONE						\
> >  {								\
> >  	[0 ... BITS_TO_LONGS(NR_CPUS)-1] = 0UL			\
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 90debbe28e85..771e344f8ff9 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1282,6 +1282,9 @@ static void cpus_down_no_rollback(struct cpumask *cpus)
> >  	struct cpuhp_cpu_state *st;
> >  	unsigned int cpu;
> >  
> > +	for_each_cpu(cpu, cpus)
> > +		set_cpu_dying(cpu, true);
> > +
> >  	/* launch ap work one by one, but not wait for completion */
> >  	for_each_cpu(cpu, cpus) {
> >  		st = per_cpu_ptr(&cpuhp_state, cpu);
> > diff --git a/lib/cpumask.c b/lib/cpumask.c
> > index 8baeb37e23d3..6474f07ed87a 100644
> > --- a/lib/cpumask.c
> > +++ b/lib/cpumask.c
> > @@ -7,6 +7,24 @@
> >  #include <linux/memblock.h>
> >  #include <linux/numa.h>
> >  
> > +/* Used in parallel kexec-reboot cpuhp callbacks */
> > +int cpumask_not_dying_but(const struct cpumask *mask,
> > +					   unsigned int cpu)
> > +{
> > +	unsigned int i;
> > +
> > +	if (CONFIG_SHUTDOWN_NONBOOT_CPUS) {
> 
> Hmm... Would it even work? Anyways, the documentation says:
> Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
> symbol into a C boolean expression, and use it in a normal C conditional:
> 
> .. code-block:: c
> 
>         if (IS_ENABLED(CONFIG_SOMETHING)) {
>                 ...
>         }
> 

Yes, it shall be like you pointed out.

I changed the code from "#ifdef" style to "if (IS_ENABLED()" style just
before sending out the series. Sorry for the haste without compiling
check again.

> 
> > +		cpumask_check(cpu);
> > +		for_each_cpu(i, mask)
> > +			if (i != cpu && !cpumask_test_cpu(i, cpu_dying_mask))
> > +				break;
> > +		return i;
> > +	} else {
> > +		return cpumask_any_but(mask, cpu);
> > +	}
> > +}
> > +EXPORT_SYMBOL(cpumask_not_dying_but);
> 
> I don't like how you create a dedicated function for a random
> mask. Dying mask is nothing special, right? What you really

Yes, I agree.

> need is probably this:
>         cpumask_andnot_any_but(mask, cpu_dying_mask, cpu);
> 

That is it.

> Now, if you still think it's worth that, you can add a trivial wrapper
> for cpu_dying_mask. (But please pick some other name, because
> 'not dying but' sounds like a hangover description. :) )
> 

I think that since even if !IS_ENABLED(CONFIG_SHUTDOWN_NONBOOT_CPUS),
cpumask_andnot_any_but(mask, cpu_dying_mask, cpu) can work properly,
so replacing the callsite with "cpumask_andnot() + cpumask_any_but()"
will be a choice.

Appreciate for your help.


Thanks,

	Pingfan

> Thanks,
> Yury
> 
> > +
> >  /**
> >   * cpumask_next_wrap - helper to implement for_each_cpu_wrap
> >   * @n: the cpu prior to the place to search
> > -- 
> > 2.31.1
