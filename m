Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE4452F5B8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353392AbiETWf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiETWf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:35:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7AA178563
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:35:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eg11so12392282edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hc2DTzkdvmY5/H2+h1fYLqdWLOpbPYQU4WUrtguKfK8=;
        b=YcQ0Hu0u3oUtOd9K6qAjIrCzfi7ako/V39ndwIxJG58KfcKA6mHEbr02iQKhS+icJ7
         AWTF2PJV9YsGtctpG00VQ2dF159kSsPOUXUfYAgkjXoXbsftFK+R0lncDH8FpSfgueC+
         7RzlTU+Diyl/K6STYoJjnz/brTfG73icT2DNlhlm+lmO827D6BhSScD//biiZGRO05QL
         q3RnvLZwT6mcTsisMw8lRJ7Epy1rFcyBbvwAnyHXaGG2Yn/MikvesKpcqYFXNKUh/3QK
         RcGUiDblIarbhgeIP7M/68tM41h18GHneABwFEDjCDltu8G3/5wCeHdcVOkSrsvu+uB6
         +cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hc2DTzkdvmY5/H2+h1fYLqdWLOpbPYQU4WUrtguKfK8=;
        b=QZxm/odjlM/r5ge9k5vCctsEXzrtK7NKz2aIki5pkTS4yFxMOVYoGbxfnMZ2n3z3W/
         FXD54IVgw6UeZjFMny6IJtSGzZC1UI1Q+KkGRL3qIj55nEXzpElYrBTK6yXjvRYfro2z
         0RSbr7IQ7sEDaKvnYImUDDa0eX8aGJQVbj5rLF+O73lFUKPBrlGmunp8eIgfZhtALwYw
         yKIJuTeSMUQ8/0+ah/Wtr3ejsb8mgcWNjPPS2L+d0lFKrreSidbAwF3wSQ5L7DRKYLiS
         uToyH1L7OJ2H6UK6YhNvtloqXKqCwV9ohIV0Tr/J/IuHAJEX6ZLOO0Qiq1BJ8Lx1rSaI
         F2CQ==
X-Gm-Message-State: AOAM533ktd1n5eBIg4PWE5nxjZoeqSB+AIUt2Cz1m/EWll7dU9sJWNEe
        JwuDzXNqFbkwSelSPSvON7LeVwv8KKc8GbWGLz9Qlw==
X-Google-Smtp-Source: ABdhPJz7+9WUFMLkPO5qjQRZ4cQTpghpM2BlJvmMqQmZrSUEytXCmKRqFwOg9PAc+vapCevWMtNPVvcpFn9X9SbxdiM=
X-Received: by 2002:a05:6402:3047:b0:42a:fbe9:4509 with SMTP id
 bs7-20020a056402304700b0042afbe94509mr11941788edb.159.1653086125167; Fri, 20
 May 2022 15:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220519164512.3180360-1-dlatypov@google.com> <CABVgOSnooocLsy2=a8rm7Y_m3DpffKtDam5_uYou+Y2tUkumRw@mail.gmail.com>
 <CAGS_qxrDYKKoWy3UAuVqebT+3jp-ux_uyfbwX3OnJqVbnzaiJg@mail.gmail.com> <CAGS_qxrvR+xxfmzz92rYYW=VzG1kyycn1EuaJxdNSMd_L5afFQ@mail.gmail.com>
In-Reply-To: <CAGS_qxrvR+xxfmzz92rYYW=VzG1kyycn1EuaJxdNSMd_L5afFQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 20 May 2022 15:35:13 -0700
Message-ID: <CAGS_qxpF338dvbB+6QW1n8_agddeS10+nkTQNmT+0UcvoE1gBw@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 3:13 PM Daniel Latypov <dlatypov@google.com> wrote:
> Talking offline with David, we've come up with a small example.
>
> If we add this kconfig somewhere
> +config X
> +       bool "X"
> +       default y
> +
> +config Y
> +       bool "Y"
> +       default y
> +       depends on X
> +
>
> Then running this will fail
> $ ./tools/testing/kunit/kunit.py config --kunitconfig xy_kunitconfig
> --kconfig_add=CONFIG_X=n --kconfig_add=CONFIG_Y=n
>
> It will fail with this
> This is probably due to unsatisfied dependencies.
> Missing: # CONFIG_Y is not set
>
> The problem is that kunit.py is looking for an explicit line saying
> CONFIG_Y is not set.
> But CONFIG_Y's dependencies are not met, so Kconfig doesn't write it out.
>
> I assume we can treat the absence of it in the file as proof that it's not set.
> I.e. the bug lies in the is_subset() logic we have in kunit.py?

Ah no, this is just me trying to be clever and avoid a call to this logic.
I tried to use set_diff() and check if that's empty as an alternative.
But the set_diff() logic is not aware of how to treat the absence of
options properly.

I'll send a v2 w/ a fix.
