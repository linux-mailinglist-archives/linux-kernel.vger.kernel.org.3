Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0C52F247
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352483AbiETSNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352493AbiETSNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:13:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F7B18FF12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:13:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g12so11788411edq.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diEsMUAPJX4u0FJo9NkDwZ5Xz9iATJQSF3lAp/gYU1A=;
        b=I87RLcljCH0RuSbiTrRQexejctdo+oMuIRy59YA+r+nR+yZwS2t6yeUqhQNO3I0sho
         0kvV9fopy2diCllarPTabCkUVUGiHFwYWAYnpqsf7Pa7SmkSmgcM/rzj7catq+4TMWVq
         EOkLlq6rMWfkrLiGFfbgaoxEz78RbWy5Oc2a54iNQCB2Z21hIlbfiTzpkuWY21YUjOEi
         dmYO4mZ0+WM6qw5mmauUQf69pAkPy5b5D915wxqgN/EmALrVJq6ly76nBGi5VWw8gjcI
         4O3Ns1t1LgkRbhOcQmhON3hCYwT5gZGIJh2HAja7zlFXEjHIUtl5AWU9yAa2BjipS9x3
         BCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diEsMUAPJX4u0FJo9NkDwZ5Xz9iATJQSF3lAp/gYU1A=;
        b=NBp8YRJn3kAIp9yaAST1pozT0WAk0p5LCFHO7x6eela9qgo5D89cJF0wr+8h6LxB7z
         wmsTzV3QS8OtAtywMVRRcPYJGwVn7L/Km+BiacbXZE3QOISjqx1mwlaW0ZMvmXhoxyIc
         Eo6/kw38gNOmuYym97OFkPE2MnkE2nbgn2J2gvZIoCko8sACH0Pd6mvvnbaDgMcp4Ce8
         tQLIcl/uZXQG9xIi8zmHB2o+ozomThGAvmn+EEtHwddYSg3SBDBsIppuxG3Z6ZeQlNe5
         X4ubEiFSCsTWCP6OdQ2SF2mzBP0CU8ZXU8aDgeng34jz/QvcbY4SnSjGjWTApK/47GYa
         mkyw==
X-Gm-Message-State: AOAM532p0TNp0Mlq7b17nnHWHaN8MRMGJy98nRMfyMJDIdZKLnvyMAaV
        jNv3wP0icoQ761K8NP6zUwGHJKyqi1pdqeTun8mq3A==
X-Google-Smtp-Source: ABdhPJyJ9aD1+buOd6X23qPr2SUjHKZOvsxBvuzgTQCHrWKd4i4H+xLKXa2OUWjgWol3otPNS4gl1fDpDbZoTdNYgOc=
X-Received: by 2002:a05:6402:84a:b0:426:262d:967e with SMTP id
 b10-20020a056402084a00b00426262d967emr12527519edz.286.1653070410982; Fri, 20
 May 2022 11:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220519164512.3180360-1-dlatypov@google.com> <CABVgOSnooocLsy2=a8rm7Y_m3DpffKtDam5_uYou+Y2tUkumRw@mail.gmail.com>
In-Reply-To: <CABVgOSnooocLsy2=a8rm7Y_m3DpffKtDam5_uYou+Y2tUkumRw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 20 May 2022 11:13:19 -0700
Message-ID: <CAGS_qxrDYKKoWy3UAuVqebT+3jp-ux_uyfbwX3OnJqVbnzaiJg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: refactor internal kconfig handling, allow overriding
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 11:13 PM David Gow <davidgow@google.com> wrote:
>
> I like this, but do think there are a few gaps this doesn't handle
> properly. (Though exactly how we'd deal with them, I'm not yet sure.)
>
> In particular, it's not possible to disable a pair of options where
> one depends on the other: disabling the parent option will result in
> the child one not being present in the generated config. This will
> conflict both with "=y" and "=n/not set": we'd need a way to _remove_
> a kconfig option for that to work.

Do you have an example?
Because what you describe sounds like how we want it to work, but I'm
not sure if I'm misunderstanding the scenario you describe.

I was considering the case mentioned in the commit description.
I.e. we do --kunitconfig_add=CONFIG_KUNIT=n to the default kunitconfig.
That gives us complaints about these
 CONFIG_KUNIT_EXAMPLE_TEST=y, CONFIG_KUNIT_TEST=y,
 CONFIG_KUNIT_ALL_TESTS=y
options no longer being in the generated .config.
And I think that's exactly how it _should_ work, as this flag is a
low-level tool for tweaking individual options.

IMO, anything complicated should be done by editing the
kunitconfig/qemu_config files, in which case it's a lot less
cumbersome to disable multiple options by just deleting them.

Daniel
