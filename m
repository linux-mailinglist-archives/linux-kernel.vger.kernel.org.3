Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E225954E8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiFPRc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiFPRcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:32:52 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE0B9E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:32:51 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2ef5380669cso20494127b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55Cn1sEgSzXcQdM8QrLwAm9bELIxP5xfzUniTUdbstU=;
        b=HH6FOscTmQ7MBP31vrErimU/eo4KKSffaXGDeed4hNDrAKFeKAIQ1raAD1WAvvwMp/
         bc0m9RKAD1+XHhQ7WfmPgTD8FKCrczYw6lBKkD2r9ONy2hXuUCE9ak7mcHoHJy3ctBE7
         WO5WMr7v59yvfoGdax11rMai9J/qux/jNHmz1oa5eiC+0SKkaB3kJEJ9blPQGOlCfdE8
         aBU4Ro5Wstq7yemMAwgjwT4O3CAehJSUjQukGj94B7ysxrPoPt2R9moPZacISQq6vAlq
         jwGc6MkDf2b9lLFZEGMXzUOvMBld+h/57R5UgDiQJx6ciAAXH6PsjHeAnJZaN3bVEF5T
         0Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55Cn1sEgSzXcQdM8QrLwAm9bELIxP5xfzUniTUdbstU=;
        b=dYfaC35e8mUmAZLFVjDJIqcBipoVZ2Vv3+Xw1IiJIkcDTmkn1s1seYr04f5flGx2Au
         4NZ0UC/LXZxTaf8lgS6zogpmtXFTokQ97VMzPWnAG44/oHuGlhq/msdkgn+baYujvI7I
         g9hrnJIMe6DIEvodKyP80Bjk5qvplybdiFzD0UUaIKz/GuecaIeegnZuO5/BZnkE1SFH
         eOdY11CDGUwg+2MFvVD0Xotookq5Z7m4xSCbd2P+w+9h8PXcYQArg714Y13nAy/+Vouz
         DuLutzV6RmFrjUAVJo3I8DVHo/QLhZJfoZrxaGm5TF73JyEXZHdu1UNZdHcvVt19Ow2Q
         T82Q==
X-Gm-Message-State: AJIora+r36987uvxW3sCiVV7CjiuZAAZd/AbIjHwvjaKAABKlT3wEUlo
        l93TD6UF1vJGMACky+XAEesu4X3EDuGugZrDc2SB/A==
X-Google-Smtp-Source: AGRyM1tTdpKuPdJcXoffkkKOJK/nvenMrG6oAb6SqfL0kfxu1KAA+GrGfr+7rpz+rRM/re9AiuFoQ8RFg/7Ku3DwxFQ=
X-Received: by 2002:a81:574c:0:b0:317:7c3a:45be with SMTP id
 l73-20020a81574c000000b003177c3a45bemr1023782ywb.316.1655400770724; Thu, 16
 Jun 2022 10:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <202206160411.v3iL3YC0-lkp@intel.com> <20220615204039.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220615211717.GA972937@paulmck-ThinkPad-P17-Gen-1> <CANpmjNMswUJhqfttxZGbkfN7X5d5FLiS1yPXzzGDivLtWDB9=g@mail.gmail.com>
 <20220616134021.GP1790663@paulmck-ThinkPad-P17-Gen-1> <20220616164416.GA2130702@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220616164416.GA2130702@paulmck-ThinkPad-P17-Gen-1>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Jun 2022 19:32:14 +0200
Message-ID: <CANpmjNPhfGnO8qebvPd2pEqO37qTAa8pUAOTy2MXqT4R+iZ8QA@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/pmladek.2022.06.15a 133/140]
 vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to __kasan_check_read()
 leaves .noinstr.text section
To:     paulmck@kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 at 18:44, Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > > > > > >> vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to __kasan_check_read() leaves .noinstr.text section
> > > > > > >> vmlinux.o: warning: objtool: __ct_user_enter+0x7f: call to __kasan_check_read() leaves .noinstr.text section
[...]
> > > It's due to the atomic_read()s within the noinstr function. Within
> > > noinstr you can use arch_atomic_read() to avoid the instrumentation.
> >
> > Thank you, will fix!
>
> And please see below for an alleged fix.

Looks good, if this made the above warnings go away.

Btw, it's not just KASAN, but arch_atomic_read() also disables KCSAN
checking. A similar warning would have been generated in a KCSAN
config.

Reviewed-by: Marco Elver <elver@google.com>

>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 81e24ca26ee9933bcacf67a61e3f6ae41a025442
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Jun 16 09:30:37 2022 -0700
>
>     context_tracking: Use arch_atomic_read() in __ct_state for KASAN
>
>     Context tracking's __ct_state() function can be invoked from noinstr state
>     where RCU is not watching.  This means that its use of atomic_read()
>     causes KASAN to invoke the non-noinstr __kasan_check_read() function
>     from the noinstr function __ct_state().  This is problematic because
>     someone tracing the __kasan_check_read() function could get a nasty
>     surprise because of RCU not watching.
>
>     This commit therefore replaces the __ct_state() function's use of
>     atomic_read() with arch_atomic_read(), which KASAN does not attempt to
>     add instrumention to.
>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Frederic Weisbecker <frederic@kernel.org>
>     Cc: Marco Elver <elver@google.com>
>
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index 0aecc07fb4f50..81c51e5f03143 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -49,7 +49,7 @@ DECLARE_PER_CPU(struct context_tracking, context_tracking);
>
>  static __always_inline int __ct_state(void)
>  {
> -       return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
> +       return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
>  }
>  #endif
>
