Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9478751B474
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbiEEAFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382746AbiEDXuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:50:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC2C220EE
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:47:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so3977268wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3PQkN+gf21RggCfRlbnzAg3Y0IDK9AvrHUeXDspmDA=;
        b=s8D0hdEErUtB/tOqqi5koPP1ObIltDHxJsF3vu7tUYKf+QVqE2BCZwe8TwmjVrWD/p
         tZYhf6h5cY5lziFt0dxJxyYtlSU3McdElqedVlwADKJdcMW3hEghSebK86BKQW5Gk1rb
         h5RLyhUpDnIbB+E5g3WraStYDvzpqQwqSxKw/FT08LqpZ21OKQdNbLlDufQWqebOYO6o
         RL8UdgO3Vne1Od0ianbjpjNNU5emYhQSEnSwmyU8z94ORg7Xfr45C6XXUIPg44vwPA+9
         HfwPApdY1k0FIIsOo8YZalDDuZ7z2+ZizWaJ+xN+YlhWvw0IZBOcBjYhbgdEwstQh2OK
         m1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3PQkN+gf21RggCfRlbnzAg3Y0IDK9AvrHUeXDspmDA=;
        b=u+2aNCZSM30ZLc6XvI5y7o53IXP5XPcfo7maR+C6D0ycutKZcQGO7YHukqdsMFuTxL
         bcL+yyLB47mCTMGvjAs7wo2fJQS7lhtfxTclNY3jEKX7+WxDsTs1Hfqlxx1XIaz8UvOv
         2b+9SPJzZTI0Yi5U3IJNeBdWcI63GE48+n/zDgCVhEhkes9Sv0QCSpTpDGmbpiab6zy0
         4BZa8ulZlWgcXnrP1KEYs3qvxVnuf8NgzLnnAflzGJbfCtoQ4PvjYpDHOD9TJuWkqysZ
         3Cx3e6Ciq0CeT7oxBTUZ7+TzqfJgPziBc6MK5eupCU4hHz6uNeM2EirI8S1eNAybKzPR
         bASA==
X-Gm-Message-State: AOAM533NhRvx4gahCxGjEnvj/bKwO4Uo+8cqBeOKCVd0C75HisskcV0R
        BqQGQt0BHNB0rx3RLobJdDFaTrJxq3GuSlDoMIdvlw==
X-Google-Smtp-Source: ABdhPJzN9nXRY0rWdpKSs9VMyqTX6gCV58pFw17JVL2dLkl7aPqx0Pb6NzKnucrrh1/uy2r/4hTaEa/rbvBUIDIILUQ=
X-Received: by 2002:a5d:6b0e:0:b0:20a:dd17:e452 with SMTP id
 v14-20020a5d6b0e000000b0020add17e452mr18161313wrw.501.1651708034493; Wed, 04
 May 2022 16:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220502093625.GA23225@kernel.org> <CAGS_qxoc=AnkzUtaFpJvF08Z_Z15h9sZxYNQT5-S9C7aM4poEg@mail.gmail.com>
 <CANiq72m70q+zviHVNSV_AEwOByVBiMuSQL5vyo2UMMpD-vd+_Q@mail.gmail.com>
 <CABVgOSmkZ9EXijBRx_pvS=Opizb1z2632B5rVsd1WRNOL5o8GA@mail.gmail.com> <CANiq72kVLzOu_3UjoUiSp5y+H0tA+SQYNQ=fsuhtg=i6MQe=Fg@mail.gmail.com>
In-Reply-To: <CANiq72kVLzOu_3UjoUiSp5y+H0tA+SQYNQ=fsuhtg=i6MQe=Fg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 5 May 2022 07:47:03 +0800
Message-ID: <CABVgOS=77WFFV1Xu5vQD6DPJODRr0f+qxJTRgJWS0qobv6vDaA@mail.gmail.com>
Subject: Re: [PATCH] kunit: take `kunit_assert` as `const`
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, May 5, 2022 at 3:26 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi David,
>
> On Wed, May 4, 2022 at 4:05 PM David Gow <davidgow@google.com> wrote:
> >
> > I definitely agree here -- I can't recall any particular plan that
> > would require this to be non-const, and we can always change it back
> > if we really need to.
>
> That is good to know, thanks! Out-of-tree users can always be a surprise... :)
>
> > Very exciting! I assume that's the PR here:
> > https://github.com/Rust-for-Linux/linux/pull/757
>
> Indeed! I hope you like it -- we are taking the documentation tests in
> Rust (which are a very lightweight way of writing examples which
> double as tests) and generating KUnit test cases on the fly. For the
> moment it is just for the `kernel` crate, but the idea is to
> generalize it for modules etc.
>
> By the way, since you saw the PR... do you know if KUnit relies (or
> will rely) on "stack-dumping" functions like `longjmp`?

I don't think so -- though there's no fundamental individual tests
couldn't use them if it made sense for them.

KUnit spins off a new kthread per test, and uses
kthread_complete_and_exit() to unwind when an assertion fails. See
lib/kunit/try-catch.c for the actual implementation. The only really
dodgy bit is the test timeout support, which attempts to stop a thread
with kthread_stop(), and IIRC has some problems.

Hope that helps!
-- David
