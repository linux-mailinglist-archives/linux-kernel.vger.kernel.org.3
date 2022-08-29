Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C15A5490
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiH2TbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2Ta6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:30:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E361B3C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:30:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y1so7102802plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=1CsC/FWb8WgaluJDmDm40y1bvBnIW2XutzXzMERabjA=;
        b=VbNLqqeZg2KuvsdyYDHVh5IfEHGACO5jS28RmaEKdp/aEsNFKK11/UqlCTrJPEdxt/
         uqup/asJB8IzRjRJ4yjBJIuIY8NbLSOSdMAaEWLU09RSS581WMrGhZwr07PmBcxQPR2O
         8Tc4/JPGvhGSWFypB/Wn32txLcD9p5xbydeIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1CsC/FWb8WgaluJDmDm40y1bvBnIW2XutzXzMERabjA=;
        b=g6gb1Xs5PXUH9xafFJsPFMWr8GkpOlUprKt2DGjDWmj6Se7Gv8bPTaMclBMz386f6u
         jRoGaiH3zUF7CtLsLGEI2N0TvRPaoUDVgQuwpybGgtvNFa6XKsGLOrcvXgmMMfPPLJB9
         8vkPt19QJepPnl15uP+WCId/dRs0s6UNFtYSWMATo/M8KcL0VlZg8IDhYHkhKPH35mM1
         L02eNZBzAIZCcDLOuOJgBaat8uSUfLQjopu3ZxzHqJwfJtj9Qkl3jkUfRmVpTm9hGltM
         wZarecpGvUq8zffNnN2WJBvCWwew6/Hu+8hsCTpoWhsRyFOnLJzCKthaWkQSWHkiNnqs
         h5vA==
X-Gm-Message-State: ACgBeo2d9hsEWEpo7cEXG3/zNKxowiiqIaV+sZUKDhpLCyko/tD2hqzW
        uosbRMAzTxRTBo67UH5NhFELmQ==
X-Google-Smtp-Source: AA6agR6ZY0XFQI9kLTHH3909B7ADgzB1l5MAaAD/tvGmRA3N5OBnCZU4vsd4XAY0N1LMNkcfCTo4hg==
X-Received: by 2002:a17:90b:4a82:b0:1fd:9c58:daff with SMTP id lp2-20020a17090b4a8200b001fd9c58daffmr11716679pjb.48.1661801455123;
        Mon, 29 Aug 2022 12:30:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p124-20020a622982000000b0052e7f103138sm7644099pfp.38.2022.08.29.12.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:30:54 -0700 (PDT)
Date:   Mon, 29 Aug 2022 12:30:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Isabella Basso <isabbasso@riseup.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sander Vanheule <sander@svanheule.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 2/2] overflow, tracing: Define the is_signed_type() macro
 once
Message-ID: <202208291230.CE410DCBE7@keescook>
References: <20220826162116.1050972-1-bvanassche@acm.org>
 <20220826162116.1050972-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826162116.1050972-3-bvanassche@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 09:21:16AM -0700, Bart Van Assche wrote:
> There are two definitions of the is_signed_type() macro: one in
> <linux/overflow.h> and a second definition in <linux/trace_events.h>.
> 
> As suggested by Linus Torvalds, move the definition of the
> is_signed_type() macro into the <linux/compiler.h> header file. Change
> the definition of the is_signed_type() macro to make sure that it does
> not trigger any sparse warnings with future versions of sparse for
> bitwise types. See also:
> https://lore.kernel.org/all/CAHk-=whjH6p+qzwUdx5SOVVHjS3WvzJQr6mDUwhEyTf6pJWzaQ@mail.gmail.com/
> https://lore.kernel.org/all/CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com/
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Isabella Basso <isabbasso@riseup.net>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Sander Vanheule <sander@svanheule.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/compiler.h     | 6 ++++++
>  include/linux/overflow.h     | 1 -
>  include/linux/trace_events.h | 2 --
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 01ce94b58b42..7713d7bcdaea 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -239,6 +239,12 @@ static inline void *offset_to_ptr(const int *off)
>  /* &a[0] degrades to a pointer: a different type from an array */
>  #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>  
> +/*
> + * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
> + * bool and also pointer types.
> + */
> +#define is_signed_type(type) (((type)(-1)) < (__force type)1)
> +
>  /*
>   * This is needed in functions which generate the stack canary, see
>   * arch/x86/kernel/smpboot.c::start_secondary() for an example.
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index f1221d11f8e5..0eb3b192f07a 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -30,7 +30,6 @@
>   * https://mail-index.netbsd.org/tech-misc/2007/02/05/0000.html -
>   * credit to Christian Biere.
>   */
> -#define is_signed_type(type)       (((type)(-1)) < (type)1)
>  #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
>  #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
>  #define type_min(T) ((T)((T)-type_max(T)-(T)1))
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index b18759a673c6..8401dec93c15 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -814,8 +814,6 @@ extern int trace_add_event_call(struct trace_event_call *call);
>  extern int trace_remove_event_call(struct trace_event_call *call);
>  extern int trace_event_get_offsets(struct trace_event_call *call);
>  
> -#define is_signed_type(type)	(((type)(-1)) < (type)1)
> -
>  int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
>  int trace_set_clr_event(const char *system, const char *event, int set);
>  int trace_array_set_clr_event(struct trace_array *tr, const char *system,

Yeah, this looks good. I'll take these as part of the hardening tree
since it's touching overflow.h, unless I hear otherwise. :)

-- 
Kees Cook
