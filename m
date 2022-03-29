Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4024EB372
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbiC2Sim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiC2Sik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:38:40 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEE618A788
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:36:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id x4so22061975iop.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZahETGQ5QFUGU9cdr5iIBFtuwsgQ6vA8xk/koQJqNS8=;
        b=hIo45tQdIyHSPqQxFA7cSGVqQAnnccWCcVxAPl+j61kcrTdvGs9L6Z7QfGblvZHskW
         /ZH26jVAGveFN3wqlh6mHLHWhTwxdwvTUpk7zKHOKHFw3WMnlBqLm8UVaxSt2JlujyDm
         wyATLvxsF6/pkIk4aBMtp+n9UZHgMCj4czzC8IONRr7cYeN1nxDL5Llqib9rAvl+eFXm
         bGOLbAsfBsQE4U4GVjXueGWhWegCAub+RhffcZF/FUlxuyCsgZBX9ZynT5LhrSqg+Qi6
         40IqGBWNbKtEUnsLc052T7BhOiD0DtGVm6I9C72hjuJrArU9PpnkE4TJFmW9PFYxTHbC
         qu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZahETGQ5QFUGU9cdr5iIBFtuwsgQ6vA8xk/koQJqNS8=;
        b=EdFcmlNvbisV3jNDlMHhK+JQTh1VlogYGuaqpABhK5Y6CcnhxBERFlyeJpsdbsWgHG
         pMaRR668ELNkuoAxlgk5hl6O5tmqSCvWwxSuPlGQxLkq90ktedA0ZKONym/eRZ27Inyg
         8D4wu+ue8deZvJuazbypy0QYrAOQL3iSI2uQ9IJhKa7EJ1LtElKMQswz3N/A/OLUrGoR
         77MtC/jdlGLH5wdgPq79hQzeqI+siqA2rPtEsjORCydp8XE8Ot/TrkGIqQmuu8CjFmmh
         bz0sXaDMkDa83Zl6ivn2AYt/Fx1psYaxQb09J9HhwamZuvqaoPdF0SKHk1K9Dal9AeI2
         DSeg==
X-Gm-Message-State: AOAM532vQ3itEDwVjtUGSQexSDUyeMJ/DKg5JdRC/42imp+C5GjHYA9y
        ULjBjpJ1W4Tr1nWBgi1Uy1LFe4h8xCmAFgo9x5U=
X-Google-Smtp-Source: ABdhPJyTRLtj5DQrHa/sg1LvTsPlKL0Wwps0PgPiKlJMJ5rQa8tTrMo9X1HvP2LSo3ty04jqtHTK/85LvaB4Az2iRj8=
X-Received: by 2002:a05:6602:3c5:b0:64c:727d:6e95 with SMTP id
 g5-20020a05660203c500b0064c727d6e95mr6978541iov.118.1648579017088; Tue, 29
 Mar 2022 11:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648049113.git.andreyknvl@google.com> <7027b9b6b0cae2921ff65739582ae499bf61470c.1648049113.git.andreyknvl@google.com>
 <CANpmjNPJkFOMn1pL-=gx+x_YHgg72QH5iqe561+Geiy3JoOg1w@mail.gmail.com>
In-Reply-To: <CANpmjNPJkFOMn1pL-=gx+x_YHgg72QH5iqe561+Geiy3JoOg1w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 29 Mar 2022 20:36:46 +0200
Message-ID: <CA+fCnZfOGRh67SUNxQ2cyZLK8JV56GV_sa8AnNeURcgHif5Yzg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kasan: use stack_trace_save_shadow
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 2:49 PM Marco Elver <elver@google.com> wrote:
>
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index d9079ec11f31..8d9d35c6562b 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -33,10 +33,13 @@
> >  depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
> >  {
> >         unsigned long entries[KASAN_STACK_DEPTH];
> > -       unsigned int nr_entries;
> > +       unsigned int size;
>
> Why did this variable name change?

So the lines below fit within one line. It won't be needed with the
other change you suggested.

> > -       nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> > -       return __stack_depot_save(entries, nr_entries, flags, can_alloc);
> > +       if (IS_ENABLED(CONFIG_HAVE_SHADOW_STACKTRACE))
>
> Would it be more reliable to check the return-code? I.e. do:
>
>   int size;
>
>   size = stack_trace_save_shadow(...)
>   if (size < 0)
>     size = stack_trace_save(...);

Sounds good, will do in v3.

Thanks!
