Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D073510F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357375AbiD0DKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357362AbiD0DJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:09:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBD35DC8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:06:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j6so693997ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pUdY4DuhndvUjRCdZpuhyNHEEZPCX6wjZH7Y0BBjOs=;
        b=MMzKYlNTUYW6BDIRK8K13taSCkVye8khVNBJGeE9UsfetHvXRw2ROzem+96mVFCZN7
         b5LWUcoeCd2yM+yq0dJb7zMfvK/wlsIYSeqnQiW1y15LcVd63/goFL/WOf2OEG5cB+pm
         86JnyL1PFwTSMhYQb6rr1aM5oR3HtVSNMcCGzwYjMCZco3bBKcdHaF6eQF0tY8s2FUO9
         epSGkQoT9TnG4+Gf941Qyc30HgUsrhaIc57yj+57cadLLUTIt0lcNubLzaXPzL0/cd9Y
         bISfSkPCVFFgnYCyTqZgOrgYJUFPkSet1WHiONHpCa8oMzeuV3ey1PWpoU7eLvjkrg6d
         A1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pUdY4DuhndvUjRCdZpuhyNHEEZPCX6wjZH7Y0BBjOs=;
        b=1pn3dVIEjK3w3ElkTSS189a3VgXZLiZaoP0A9C42PHypSGc1xnF4mHoaoyFFUjMUXf
         FrGp7uKPuqNbpsLODkDHUN2/JVdVY61io2/XqYxx3czYNccupINhXx/KQElsH4te6lkW
         4NDI2zQMy6NANpVerMMspnCQ4QVMMjfsQV42p9orEsxexTm4R9PNlAwDe4tyRT0AfQvR
         k/QKsk96sqOY7+1Spd+Qi9NeVWUaBbzuZxpz/7zj+3/e8c5pKvEiUXNUYWFH5cNz7jnH
         oiLMMcNGSx6GehIsRaHbD5FJAWx2iKN9ItEHz756W2FtP9/HnKzgAtIXOKsGqDKu0CXk
         bx5A==
X-Gm-Message-State: AOAM532Qh8GDKIYpnS6YHfyL2wMSdiVu3zHRNgAZvp9JIhV1i6CdSP05
        AhR8JrPIdLvxWVYqcjpTMPVL1QjJ69qLcv0SzNLkzc9qbII=
X-Google-Smtp-Source: ABdhPJyEXCuSN1HclOa7UelXGrhp+PaWiRDicL+m2sYepa12vT+aKEZLSjwZ6Kd/41ciQ06EOuYLgEs6KrVCNPXG9ao=
X-Received: by 2002:a17:906:314e:b0:6f0:659:963 with SMTP id
 e14-20020a170906314e00b006f006590963mr24850096eje.358.1651028807135; Tue, 26
 Apr 2022 20:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220426181925.3940286-1-dlatypov@google.com> <20220426181925.3940286-2-dlatypov@google.com>
 <CABVgOSkqymYzwaQ68AdEC5yake9VT8HkQmqbyi+9-bg1Jk1UAQ@mail.gmail.com>
In-Reply-To: <CABVgOSkqymYzwaQ68AdEC5yake9VT8HkQmqbyi+9-bg1Jk1UAQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 26 Apr 2022 22:06:35 -0500
Message-ID: <CAGS_qxrowBiRBBhNmo+RyQSR6NQphkzx1k3HZ7KqXUNDZFZDzw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: add ability to specify suite-level init and
 exit functions
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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

On Tue, Apr 26, 2022 at 8:56 PM David Gow <davidgow@google.com> wrote:
> >
> >  static size_t kunit_suite_counter = 1;
> >
> > -static void kunit_print_suite_end(struct kunit_suite *suite)
> > +static void kunit_print_suite_end(struct kunit_suite *suite, int init_err)
>
> A part of me feels that it'd be nicer to have the init_err be part of
> struct kunit_suite, and have kunit_suite_has_succeeded() take it into
> account. It could go either way, though -- WDYT?

Yeah, passing it around as a parameter felt a bit icky.
But I think adding it in as a field feels worse.

Another thought: perhaps have this function take a `kunit_status`
parameter instead?
Moving the ?: expression below out into the caller isn't that bad, imo.

>
>
> >  {
> > +       enum kunit_status status =
> > +               init_err ? KUNIT_FAILURE : kunit_suite_has_succeeded(suite);
> > +
