Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A944B78D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbiBOTTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:19:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiBOTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:19:00 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C2EDF04
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:18:49 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t14so28164984ljh.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urx4RhFz12ENplV8nHgIKk5JctorPTtGKlJ9HOaV/nw=;
        b=Q2E5MYhnb8RBb4LwHyKZoIEps9yKNhiyf0rkiJPeICpq2OliStVxizlnYkFn/rUro8
         uu7Nl/zSI4LMxk/v6ny3spI0NNViowMC0eY4Hlm2VAVxHVEsmHy8m2s0ef7THlCHmuA0
         FPi3avYRz6v4qElgc1KHF3bW+a1rL2/Sf/h75+maq2u2udKd2sEtrqnQVpHKE6cv5G5R
         OaNdsIUqvpaD5ZVi6H4CJFgt69C/9aTj6B9Z4gHiTgQ18tXCtI6vYvc2hP3SHLuuC+mP
         QxVt259jXwHgPjf6f7HDQaJQoK7/f8nWaOjHpZhyOGvbnhTqPZZ7Hr0KKSKyI+lHO92v
         eHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urx4RhFz12ENplV8nHgIKk5JctorPTtGKlJ9HOaV/nw=;
        b=EAbGEqlX/ncsGTBB2da5tLqDvnjs63exM24MESE+Xd44kTtO6EVv3CebA+to6xPmVe
         ko8TXFJAWozWycQY4c9AATlforArBee1NzznKAfx/k8i9i9PHskUvLqSwwBdSmtimzEA
         jpBA5BVPcUpi9xqZK/ecVSUOxUtvAHrqRYk6qcGsW/swfirDHAo1o+tYY/KfEY3HmdV+
         26pwYjS/zowOwlFceRerS27sPpVI/OrdZcRPZ1/Vjj0rHn0eIKjtasPMoNBHrsyDX+oF
         l76Dc/o5WI6gxd5qeBJP0fTAi4Rpdc38IbAhxbrEu3akxNe4BpjGk4Rdrba1csRN+JgV
         1LrQ==
X-Gm-Message-State: AOAM533zopLWIjY0DHW6LdQJ/fbiQUkuMlcG060DaRDKpYxyJlHlhZ2T
        rVFG+M8zfTVEbQBHm2Hef7TZRIQa82Wj6zx2iW8zlw==
X-Google-Smtp-Source: ABdhPJzkpWE8xmPf9OeeT7fllVXFvtGzScaOtRvZmNPsaWQYMNncqr/lsfwIrJBCh6Zm6uGgV/NUCvf0VP9qmr8qMz8=
X-Received: by 2002:a05:651c:1987:: with SMTP id bx7mr367363ljb.128.1644952727738;
 Tue, 15 Feb 2022 11:18:47 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtR+E52X-ucmvXYG5-9v0q2UEXQsML=nkQRnSf7TwXYqw@mail.gmail.com>
 <Ygp2wVo8JfWh5iOk@dev-arch.archlinux-ax161> <CAKwvOdmXvC-E_9PSOZVQDDx_UCSadxhF4d9c7qpJPmeFLY_JEA@mail.gmail.com>
In-Reply-To: <CAKwvOdmXvC-E_9PSOZVQDDx_UCSadxhF4d9c7qpJPmeFLY_JEA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Feb 2022 11:18:36 -0800
Message-ID: <CAKwvOdn3fRni0RVbvE-sft9ce0mNrxv+9cDYrhGWVb68SD1k3w@mail.gmail.com>
Subject: Re: arm64: clang-nightly: net/ipv4/tcp_input.c: clang: error: clang
 frontend command failed with exit code 139
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
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

On Tue, Feb 15, 2022 at 11:10 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Feb 14, 2022 at 7:35 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Naresh,
> >
> > On Mon, Feb 14, 2022 at 12:27:17PM +0530, Naresh Kamboju wrote:
> > > On Linux mainline master branch with arm64 clang-nightly build failed
> > > due to following errors and warnings.
> > >
> > > make --silent --keep-going --jobs=8
> > > O=/home/tuxbuild/.cache/tuxmake/builds/current LLVM=1 LLVM_IAS=1
> > > ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> > > CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- HOSTCC=clang CC=clang
>
> Thanks for the report. Thanks Nathan for submitting reverts.
>
> Naresh, as a heads up, the above command line can be simplified a
> little bit (particularly for newer kernel branches)
>
> LLVM_IAS=1 is implied by LLVM=1 as of v5.15-rc1 via
> commit f12b034afeb3 ("scripts/Makefile.clang: default to LLVM_IAS=1").
>
> CROSS_COMPILE is no longer necessary when building with LLVM=1 as of
> v5.15-rc1 via:
> commit 231ad7f409f1 ("Makefile: infer --target from ARCH for CC=clang")
>
> There is no need for CROSS_COMPILE_COMPAT as of v5.16-rc1 via
> commit 3e6f8d1fa184 ("arm64: vdso32: require CROSS_COMPILE_COMPAT for gcc+bfd")
> when LLVM=1 is set.
>
> HOSTCC and CC are implied by LLVM=1 as of
> commit a0d1c951ef08 ("kbuild: support LLVM=1 to switch the default
> tools to Clang/LLVM")
> v5.7-rc1.
>
> So the above make invocation could be trimmed down to simply:
>
> $ make --silent --keep-going --jobs=8 \
> O=/home/tuxbuild/.cache/tuxmake/builds/current LLVM=1
>
> We might need to discuss further with tuxbuild folks, since I think a
> few of those are set implicitly; I would prefer if they needed to be
> set explicitly in order to properly test them being _unspecified_ in
> our CI.

Filed: https://gitlab.com/Linaro/tuxsuite/-/issues/151

-- 
Thanks,
~Nick Desaulniers
