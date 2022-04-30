Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1324E515B0A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 09:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382308AbiD3HlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiD3HlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 03:41:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD0B13DEC
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:37:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i19so19147040eja.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCobWo69+jIm4fH75WU4L/jzWPNIEpuFjehqElCC5hI=;
        b=Dt+JwlV6xwioPpmPFMYxhvzDAUkL4hvfM3WzEELy87oI73/HySdA/AkT7r1I/CCkZC
         BFBEoipQ+FSsjhGITTcarutg7aCHIucAbRqzS1/4rM4CVKWCpll34gflzQ9OtMp3Ef2v
         Ap7qBmbqRj9IkP9hb45B1ce+R82pF2F0Wcbs3CLZvbTD6LCwrxeM2N4118ogucr45tCz
         AiLAXjEiTkWh9n6meceQqywlnYai6ogPGEh0S3kam6jKNretYw8TXDzYgKsqF9uEqL5x
         hY4zyvhiV85C9DylSrZc18DM4+vZ8H7Sx7oCdlBkCdgEeVtGRKLDRI7h8XqjhTDn6bFu
         29/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCobWo69+jIm4fH75WU4L/jzWPNIEpuFjehqElCC5hI=;
        b=RzMb6GH6rcF6cBrUMHiU6DIovgg9t7qFCXkAbcFfaBjaiv31URXkq5zO+JUDBZ28xY
         w8ij5XFCv0fmVv5ijZCTtUlDzvz2uG636n53ScjeZN5xLO0CG3x2ZTn58mYKWxT18SbE
         Vvsyqbw08RI6h9MmX+xpFxdZ4luWBXBPwdL+uRWgfRdgv9Os6q+H3CldaidQXLJg71iE
         8A+q7HaBRmorTlv5AsVTsU37cDAjFccj5ZwqyYXz1oLrBzhG9brq6CxH+Jt0Li8pz4lg
         9CiTbaAwoFqFr3tVJWE0iAWlYSkNVSI3HwF2fZIHvmAfuw9RJm1Sbt6/M4XfoHD4p6qX
         owSw==
X-Gm-Message-State: AOAM530YZpUzks9w49wOUaB45++WAozAjdp1SuwhTYT67ELF+MPTcIVk
        dLUDWMqkM8YivB6PLiOXvRDLgJNLsyKFgRFoC+hoGQ==
X-Google-Smtp-Source: ABdhPJwm29VJPmR9TrgD15lFfCp6e/1B/nAXV/3OQUy9LzxA7phk0dqo3thETOqtZ+EkvNHlwBKiEbC3aZ3gYUTpYYI=
X-Received: by 2002:a17:907:33c2:b0:6f3:9aff:d532 with SMTP id
 zk2-20020a17090733c200b006f39affd532mr2897407ejb.394.1651304257717; Sat, 30
 Apr 2022 00:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220429181259.622060-1-dlatypov@google.com> <20220429181259.622060-2-dlatypov@google.com>
In-Reply-To: <20220429181259.622060-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sat, 30 Apr 2022 03:37:26 -0400
Message-ID: <CAFd5g45aOYErmW2sGgRxpSCPftrzbWnc9Ug8-bTRdgW1-hAvpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kunit: add ability to specify suite-level init and
 exit functions
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Fri, Apr 29, 2022 at 2:13 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> KUnit has support for setup/cleanup logic for each test case in a suite.
> But it lacks the ability to specify setup/cleanup for the entire suite
> itself.
>
> This can be used to do setup that is too expensive or cumbersome to do
> for each test.
> Or it can be used to do simpler things like log debug information after
> the suite completes.
> It's a fairly common feature, so the lack of it is noticeable.
>
> Some examples in other frameworks and languages:
> * https://docs.python.org/3/library/unittest.html#setupclass-and-teardownclass
> * https://google.github.io/googletest/reference/testing.html#Test::SetUpTestSuite
>
> Meta:
> This is very similar to this patch here: https://lore.kernel.org/linux-kselftest/20210805043503.20252-3-bvanassche@acm.org/
> The changes from that patch:
> * pass in `struct kunit *` so users can do stuff like
>   `kunit_info(suite, "debug message")`
> * makes sure the init failure is bubbled up as a failure
> * updates kunit-example-test.c to use a suite init
> * Updates kunit/usage.rst to mention the new support
> * some minor cosmetic things
>   * use `suite_{init,exit}` instead of `{init/exit}_suite`
>   * make suite init error message more consistent w/ test init
>   * etc.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
