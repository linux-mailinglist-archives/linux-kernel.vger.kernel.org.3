Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8604F51A4B3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352935AbiEDQAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiEDQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:00:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DFA6542
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:57:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ba17so2208338edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/V8aOCPUs9sOYmfOrlEFkCOFP4EK6WXgi3jd0LGRss=;
        b=Qxlyl1Tnw5TvdB4QRBWT4DfEdeoYpm/oKtJ8HuDfRYzzjA1h4LVzxxloPoSOy8Dfd0
         NkYnRpdIkiHjPGHppAIpu7pqZD8UZylKrKn8uLbQ33P90BUZsegZi6iQU8pTYZEhNb6J
         UTXpR4ZKkaQ3iLFtnjFnF9cyR08BxLx/t8oEJPv2o81MPLuDH9CQRWqnXPit22SB3Mkt
         4kIYbH62MiqAPPOJvVtkLWB62uK/UIQPC/+9R8RjJAlDypb2l1uyNYlzg+fAh2umvQeo
         biNgkz9uSLVhyk51kpn5RVyCVwpQD2cNhzh54DYIS77p2JvZdMraxj71IpVBW9WlGy5v
         DgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/V8aOCPUs9sOYmfOrlEFkCOFP4EK6WXgi3jd0LGRss=;
        b=KTO6Z6+t4pW4F3Wo6vzM68Wtv1+OZoLBSjAUgHrui1UT1IkkhMjErJh6swP5rnh877
         8DEacinF0k00hqHcFODlSfj/n52W0TmpfuQcTjwQy+Rc3YALYYNNQs3O/7Ke6LKgl0+m
         xa67V30iJOgNJQOxcRLVEGzGu/ig+2+dRvCl39qQ/mh4MNDP89TjJLpRTRNIZnXCG+Ed
         8p5/LwsLmNtLOjzGKHHT+9ITSAI0P/NBvJB54NqiLEXNtMmhjOalJ5g1hNofTyADAaYo
         bPisnf9AkMeka5/SsrKO/gGJlhYjJWKH0a4KkbQwQop1Fx/Lnu5VUwj8E8kyPzsUy4kk
         6Jfw==
X-Gm-Message-State: AOAM5303//ULt4YV+o0PRJZbyvJGud+GEzmMMFJY298YcUB/IScpA85S
        SNB67b9yjY6lq30LMgO2eOjkaojTcjJBDxSOYGxjGg==
X-Google-Smtp-Source: ABdhPJwFI3D94MO9NuWyaCMalvWbXm1pX6H3FK24206DmyVh6yRTQ+FnIm72uE3TkO+4rKl0TsQMcBrSgYMwbttYvWo=
X-Received: by 2002:a05:6402:3490:b0:427:b471:9e1e with SMTP id
 v16-20020a056402349000b00427b4719e1emr19515336edc.36.1651679819093; Wed, 04
 May 2022 08:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220504070941.2798233-1-elver@google.com> <CABVgOSnkROn18i62+M9ZfRVLO=E28Eiv7oF_RJV+14Ld73axLw@mail.gmail.com>
 <CANpmjNPKyGUV4fXui5hEwc9+4y70kP_XgSnHbPObWBGyDeccYA@mail.gmail.com> <CABVgOSkLGryZeWVXdfBDkQKWvSkYTk2LWx+yC9J+4FYQpn2bpQ@mail.gmail.com>
In-Reply-To: <CABVgOSkLGryZeWVXdfBDkQKWvSkYTk2LWx+yC9J+4FYQpn2bpQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 4 May 2022 10:56:48 -0500
Message-ID: <CAGS_qxqY89wOweJwzGB83_mHsFBzzbvbtRyY2qT69Dbrm1ZZkQ@mail.gmail.com>
Subject: Re: [PATCH -kselftest/kunit] kcsan: test: use new suite_{init,exit} support
To:     David Gow <davidgow@google.com>
Cc:     Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
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

On Wed, May 4, 2022 at 8:54 AM David Gow <davidgow@google.com> wrote:
>
> On Wed, May 4, 2022 at 9:48 PM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 4 May 2022 at 15:43, David Gow <davidgow@google.com> wrote:
> > >
> > > On Wed, May 4, 2022 at 3:09 PM Marco Elver <elver@google.com> wrote:
> > > >
> > > > Use the newly added suite_{init,exit} support for suite-wide init and
> > > > cleanup. This avoids the unsupported method by which the test used to do
> > > > suite-wide init and cleanup (avoiding issues such as missing TAP
> > > > headers, and possible future conflicts).
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > > This patch should go on the -kselftest/kunit branch, where this new
> > > > support currently lives, including a similar change to the KFENCE test.
> > > > ---
> > >
> > > Thanks! This is working for me. I ran it as a builtin using kunit_tool
> > > under (I had to add an x86_64-smp architecture), then use:
> > > ./tools/testing/kunit/kunit.py run --arch=x86_64-smp
> > > --kconfig_add=CONFIG_KCSAN=y --kconfig_add=CONFIG_DEBUG_KERNEL=y
> > > --timeout 900 'kcsan'
> > >
> > > To add the x86_64 smp architecture, I added a file
> > > ./tools/testing/kunit/qemu_configs/x86_64-smp.py, which was a copy of
> > > x86_64.py but with 'CONFIG_SMP=y' added to XXXX and '-smp 16' added to
> > > YYYY.
>
> (Whoops, forgot to copy this in properly: XXXX was 'kconfig' and YYYY
> was 'extra_qemu_params'.)
>
> The x86_64-smp.py file ends up looking like this:
> ---8<---
> from ..qemu_config import QemuArchParams
>
> QEMU_ARCH = QemuArchParams(linux_arch='x86_64',
>                           kconfig='''
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SMP=y
>                           ''',
>                           qemu_arch='x86_64',
>                           kernel_path='arch/x86/boot/bzImage',
>                           kernel_command_line='console=ttyS0',
>                           extra_qemu_params=['-smp 16'])

You'd want ['-smp', '16'].
Otherwise this config will be broken by
https://lore.kernel.org/linux-kselftest/20220420203020.1412886-1-dlatypov@google.com/
