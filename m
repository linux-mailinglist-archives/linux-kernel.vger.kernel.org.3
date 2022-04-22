Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BA650B40E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446025AbiDVJbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446006AbiDVJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:31:02 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1753150E12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:28:10 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e604f712ecso8028483fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWymUxmdfVUMI3yqwCTohfwWtEzgJE9q82Iv6yHI3Dk=;
        b=Z3KEFqZXjDhSzFP2dp4vJLbJ5J2B3/2UH0LjLlnohDzSOlbVypNZRuHoEuyBuo7Ric
         NkMQ08JtuwJTSuz9ZnXXmNJouR1ktStfKbPYJ8uZbUGq/+yqUmOGZTE67nooEYVP/1CX
         HamdqjWG1rMzZ5nADL1zd+D2Bx1JIVrg4v2dIitChi7vmMCmOOdkIj6pWeq9BYd8EPsO
         KiX3tohQB/H4Y+Jg5qNMLHvcDfWKKiF3AtFCu7ljJth1zVr7XTCtNDpWEOBhbYVZKAX+
         54GwH30dosTpccZ196Xeay9xEHhcY0sExVbcqC1d8Ftx8LUbk6ADNKQpVUYEplsTbdxd
         O0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWymUxmdfVUMI3yqwCTohfwWtEzgJE9q82Iv6yHI3Dk=;
        b=X+SXmKjCJESHPbmno5DxmMkYqCVtsh0b4TNV34LUIRh7wyouhzD5cRbCEovsEf3XLE
         hIDErG0jVvUB69BXVjBvdvl6JWQRmr15jX+JWgf4DI6u60MecZJ3cOqR+agPKZUVoEsY
         pZPPzB8a8PnGOfYj2KFP/nr0sOXch6lV/fJsq/vMrKEW8o0w7v/65mEPyytnOmSazisY
         DZuUCsRnxAznCEgUT5A9dx+Lc1oEt+CzfjI+1shxxTipumSyxRJMYDVf+EDTAgvgMm8/
         GDCbLAW2tKJSq5eYw9UFd9SdklM1c6QbxcHKxaVVpVw2nu9D2HcJs6fshFWxeoxLuhG5
         VhQw==
X-Gm-Message-State: AOAM533B8dLnKPPo2yyL8SB73VidrE0LszPqsoeQr4kHVaVQDd+yS5bg
        RMKZJncja209gKvpdJmmU64qqd+3EQwZFdqzvJ0+5xZqWkdVEzPd
X-Google-Smtp-Source: ABdhPJwQwv95Tim4BghgBPfhGc4r5xx/cqfC4D+i/BuvPAg6M6EG8WslgQVigxw6+anCXXJUop6RCgfHjaT/KciEHjo=
X-Received: by 2002:a05:6870:468b:b0:e6:7f11:523f with SMTP id
 a11-20020a056870468b00b000e67f11523fmr1478203oap.163.1650619689161; Fri, 22
 Apr 2022 02:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220414025925.2423818-1-qiang1.zhang@intel.com> <20220421150746.627e0f62363485d65c857010@linux-foundation.org>
In-Reply-To: <20220421150746.627e0f62363485d65c857010@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Apr 2022 11:27:58 +0200
Message-ID: <CACT4Y+b6+MpuWGPhKZx19tLtP0WHsgiuV7XPKqj+yMBs2Tnd0w@mail.gmail.com>
Subject: Re: [PATCH] kasan: Prevent cpu_quarantine corruption when CPU offline
 and cache shrink occur at same time
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, ryabinin.a.a@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 00:07, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 14 Apr 2022 10:59:25 +0800 Zqiang <qiang1.zhang@intel.com> wrote:
>
> > The kasan_quarantine_remove_cache() is called in kmem_cache_shrink()/
> > destroy(), the kasan_quarantine_remove_cache() call is protected by
> > cpuslock in kmem_cache_destroy(), can ensure serialization with
> > kasan_cpu_offline(). however the kasan_quarantine_remove_cache() call
> > is not protected by cpuslock in kmem_cache_shrink(), when CPU going
> > offline and cache shrink occur at same time, the cpu_quarantine may be
> > corrupted by interrupt(per_cpu_remove_cache operation). so add
> > cpu_quarantine offline flags check in per_cpu_remove_cache().
> >
> > ...
> >
>
> Could we please have some reviewer input here?

This is very tricky, I think can follow this:

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

If q->offline is set, then kasan_cpu_offline() will or has already
removed everything from cpu_quarantine and freed, so we can return
early in per_cpu_remove_cache().
If kasan_cpu_offline() hasn't yet removed everything from
cpu_quarantine already, it's actually problematic for the
kmem_cache_destroy() case. But since both kmem_cache_destroy() and
kasan_cpu_offline() are serialized by cpus lock, this case must not
happen.




> > --- a/mm/kasan/quarantine.c
> > +++ b/mm/kasan/quarantine.c
> > @@ -330,6 +330,8 @@ static void per_cpu_remove_cache(void *arg)
> >       struct cpu_shrink_qlist *sq;
> >  #endif
> >       q = this_cpu_ptr(&cpu_quarantine);
> > +     if (READ_ONCE(q->offline))
> > +             return;
> >  #ifndef CONFIG_PREEMPT_RT
> >       qlist_move_cache(q, &to_free, cache);
> >       qlist_free_all(&to_free, cache);
>
> It might be helpful to have a little comment which explains why we're
> doing this?
