Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6C252210C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347307AbiEJQYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347283AbiEJQX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:23:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A92A28DF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:19:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a11so15350041pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9+Df9lfV5BwTT/sLBioPDv57rZs72h8hdScRQUqmfRs=;
        b=DbTNnQANFcOXKwYHrReNWPiVuWl37/eCn4xpzxdHqJGhGuDe4NiGluHjLalIKfeceQ
         alveLnONa7r6tMV6vwpk/x2irD0RL1pBt++semHssHPj+E0dC5AwNOvBOEzK1KFqzsoL
         ZpRW0OsU6syK+H/xXU4Gg5J8fATjoQZiJ0V5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9+Df9lfV5BwTT/sLBioPDv57rZs72h8hdScRQUqmfRs=;
        b=PF0L62kWf7LNlFIvk6AD5d7GbNodCFjFGrJ3wLJnctfVIX0QgIVeWYj9mBQSAeFbsq
         ZHSQZ7S+XbTKHy78qnRCiquz9a7/tLdyC7DBdscc3xszoPmRq6ZG9UjQyrMBXhqiu2MH
         lNk6nXAFuWLPywdaPzTkdDnGdgWr4J+bokmFvHMqtdRHChoghGPxJm2pJpLcTVVyLbqC
         Znk3Hy4emgo6Z5zMKdH8LeWXtXLXbBqZ1KAS/d8mJB15+oAe3PgcEMSUvsoQgBXkZ8Ms
         Jnejo0tMaMbL3EU++tSMwxgEOrf12acAj13XG99kPJ5Ph3rgf8XFNPJ/HC6W/EiEQ98A
         Bc0A==
X-Gm-Message-State: AOAM531hO0L4GuGigbJAYdYmQhrimSD+KB8prEBvnnyTG452bGt+Mct/
        ptdbQzDAzL7zAYd7AG7+MygcmA==
X-Google-Smtp-Source: ABdhPJwzS6y0yYlhwv0j5NGUmmES9XNaWWTJ+WEmYXv9m0JkzXUvVE28UhT6GLMK52JLwaAtdFpfew==
X-Received: by 2002:a65:63d9:0:b0:374:6b38:c6b3 with SMTP id n25-20020a6563d9000000b003746b38c6b3mr17713801pgv.195.1652199597370;
        Tue, 10 May 2022 09:19:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b0015ea3a491a1sm2332544plg.191.2022.05.10.09.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:19:56 -0700 (PDT)
Date:   Tue, 10 May 2022 09:19:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     benh@kernel.crashing.org, christophe.leroy@csgroup.eu,
        mark.rutland@arm.com, mpe@ellerman.id.au, paulus@samba.org,
        tglx@linutronix.de, Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next] powerpc: add support for syscall stack
 randomization
Message-ID: <202205100917.5480D91@keescook>
References: <20220505111932.228814-1-xiujianfeng@huawei.com>
 <1652173338.7bltwybi0c.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652173338.7bltwybi0c.astroid@bobo.none>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 07:23:46PM +1000, Nicholas Piggin wrote:
> Excerpts from Xiu Jianfeng's message of May 5, 2022 9:19 pm:
> > Add support for adding a random offset to the stack while handling
> > syscalls. This patch uses mftb() instead of get_random_int() for better
> > performance.
> 
> Hey, very nice.

Agreed! :)

> > [...]
> > @@ -82,6 +83,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
> >  
> >  	kuap_lock();
> >  
> > +	add_random_kstack_offset();
> >  	regs->orig_gpr3 = r3;
> >  
> >  	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
> 
> This looks like the right place. I wonder why other interrupts don't
> get the same treatment. Userspace can induce the kernel to take a 
> synchronous interrupt, or wait for async ones. Smaller surface area 
> maybe but certain instruction emulation for example could result in
> significant logic that depends on user state. Anyway that's for
> hardening gurus to ponder.

I welcome it being used for any userspace controllable entry to the
kernel! :)

Also, related, have you validated the result using the LKDTM test?
See tools/testing/selftests/lkdtm/stack-entropy.sh

> 
> > @@ -405,6 +407,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
> >  
> >  	/* Restore user access locks last */
> >  	kuap_user_restore(regs);
> > +	choose_random_kstack_offset(mftb() & 0xFF);
> >  
> >  	return ret;
> >  }
> 
> So this seems to be what x86 and s390 do, but why are we choosing a
> new offset for every interrupt when it's only used on a syscall?
> I would rather you do what arm64 does and just choose the offset
> at the end of system_call_exception.
> 
> I wonder why the choose is separated from the add? I guess it's to
> avoid a data dependency for stack access on an expensive random
> function, so that makes sense (a comment would be nice in the
> generic code).

How does this read? I can send a "real" patch if it looks good:


diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 1468caf001c0..ad3e80275c74 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -40,8 +40,11 @@ DECLARE_PER_CPU(u32, kstack_offset);
  */
 #define KSTACK_OFFSET_MAX(x)	((x) & 0x3FF)
 
-/*
- * These macros must be used during syscall entry when interrupts and
+/**
+ * add_random_kstack_offset - Increase stack utilization by previously
+ *			      chosen random offset
+ *
+ * This should be used in the syscall entry path when interrupts and
  * preempt are disabled, and after user registers have been stored to
  * the stack.
  */
@@ -55,6 +58,24 @@ DECLARE_PER_CPU(u32, kstack_offset);
 	}								\
 } while (0)
 
+/**
+ * choose_random_kstack_offset - Choose the random offsset for the next
+ *				 add_random_kstack_offset()
+ *
+ * This should only be used during syscall exit when interrupts and
+ * preempt are disabled, and before user registers have been restored
+ * from the stack. This is done to frustrate attack attempts from
+ * userspace to learn the offset:
+ * - Maximize the timing uncertainty visible from userspace: if the
+ *   the offset is chosen at syscall entry, userspace has much more
+ *   control over the timing between chosen offsets. "How long will we
+ *   be in kernel mode?" tends to be more difficult to know than "how
+ *   long will be be in user mode?"
+ * - Reduce the lifetime of the new offset sitting in memory during
+ *   kernel mode execution. Exposures of "thread-local" (e.g. current,
+ *   percpu, etc) memory contents tends to be easier than arbitrary
+ *   location memory exposures.
+ */
 #define choose_random_kstack_offset(rand) do {				\
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\


-- 
Kees Cook
