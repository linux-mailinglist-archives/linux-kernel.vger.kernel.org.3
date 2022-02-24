Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920FB4C21E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiBXCxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiBXCxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:53:22 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CAF1662D7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:52:54 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z4so543668pgh.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q3TGm28B6O/EdXXho5YF6aTQecDJdHdeGkzGFf9YLIc=;
        b=nxQ4aJE+vqbCAJSYhBXr4dUljBatSkC8lk+Xt7/dM7NULoBoPsmdryGQEp9kP4CJCr
         9we7cKz1LopYUEehfnYzyzcv2DG9lrnTEi+La3rxkaKorRC9CKPGrScJHsCkE6WR5BID
         Ua4KFzX65o/hcjRDeFA2Pgb7m8HnfqVBsRFx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q3TGm28B6O/EdXXho5YF6aTQecDJdHdeGkzGFf9YLIc=;
        b=bDMxK2pLlp6zjvre0Wnh3APnLHmHGsmZm3oIa/nHnJ4OkAk1Za6e6qQgEAONT4MIc1
         w20G6ZZxiFyo9wKsGN4ATE19/UD7j99earMoJEkNPK1c5zXg9wFkrrceA8lCEu1YxIi0
         fCjNfsfIetgnsxTAkPgQX0pNfq5cuZUfUqkeGUbNTcjAuCWJUkQH9HdgpSjAjVvYbqiF
         F2WNMealPwX4MFAnBoo9prPvXOrVKjwBy4ZdSWRIqSOheYKQx3VWUDcPyeqaQQvllLt1
         oYfyN+DZ0V/vnpTsBkneSM7/GKwrSxZ4a4pedTLYcefvtPg39Y6XU/vWplv9G0MXr8QO
         cOvQ==
X-Gm-Message-State: AOAM531J4Y+wF+0lJUfiNX9O35njdkH/2cVZNR31ijBNQRqW8lwWrqI8
        TnKuHTXno15rlKzbYNCLmkoIFA==
X-Google-Smtp-Source: ABdhPJxz+HP1w4TsYKr5g2QkrdSVIlF3ksWZu/mGdodQvCuIM9nuuFQ2gUjIwmCbdWf68kuzDfVvhw==
X-Received: by 2002:a05:6a00:15c6:b0:4f0:fc4d:35d1 with SMTP id o6-20020a056a0015c600b004f0fc4d35d1mr540080pfu.23.1645671173550;
        Wed, 23 Feb 2022 18:52:53 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:50f1:f5eb:bd04:8bb0])
        by smtp.gmail.com with ESMTPSA id on14sm778927pjb.34.2022.02.23.18.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 18:52:52 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:52:46 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, bhe@redhat.com, pmladek@suse.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <Yhby/n4P+E15zjKj@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com>
 <5eeba935-d73a-5539-4eb1-298fb6ee0578@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eeba935-d73a-5539-4eb1-298fb6ee0578@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (22/02/23 10:15), Guilherme G. Piccoli wrote:
> On 22/02/2022 22:27, Sergey Senozhatsky wrote:
> > [...]
> > Hmm. Yeah, well, that's a bit of a tricky interface now
> > 
> > 	panic()
> > 		// everything (if corresponding bits set), no console flush
> > 		panic_print_sys_info(false)
> > 		...
> > 		// console flush only if corresponding bit set
> > 		panic_print_sys_info(true)
> > 
> > 
> > 
> > If everyone is fine then OK.
> > 
> > But I _personally_ would look into changing this to something like this:
> > 
> > 	#define EARLY_PANIC_MASK (PANIC_PRINT_FOO | PANIC_PRINT_BAR | ...)
> > 	#define LATE_PANIC_MASK (PANIC_PRINT_ALL_PRINTK_MSG)
> > 	panic()
> > 		panic_print_sys_info(panic_print & EARLY_PANIC_MASK)
> > 		...
> > 		panic_print_sys_info(panic_print & LATE_PANIC_MASK)
> 
> Hi Sergey, notice that panic_print_sys_info() currently doesn't have a
> parameter! The prototype (without this patch) is:

Correct.

> static void panic_print_sys_info(void);
>
> So, it consumes the "panic_print" global variable (which matches the
> command-line parameter / sysctl), hence to implement your suggestion
> either we need a refactor in panic_print_sys_info(), adding a parameter

Correct. That's the idea. Since you are already adding a parameter,
what I'm talking is turning that parameter from true/false to something
more verbose.

> (more or less what the patch is already doing, but with a bit more
> changes) or we override the global variable twice in panic(), before the
> function calls.

We don't need to overwrite the global var. We pass "permitted bits at
this stage of panic" mask to panic_print_sys_info(). The global var
stays intact.

> As you said, it's possible and a matter of personal coding style. I'd be
> fine if more people ask that, but if everyone is fine with the current
> implementation, I'd rather get this patch merged as is, since we need it
> and couldn't even make it for 5.17 heh

Sure, works for me.
