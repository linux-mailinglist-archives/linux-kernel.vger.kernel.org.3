Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3D50DB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiDYIoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiDYIoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:44:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B617CDC0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:40:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u15so28116392ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yo7vm9yRg/QAt1cNLA0IMYEFR0QnFkwTlujuFxJ6tig=;
        b=Yj5v2QNu+40yHuj9V96wK5Lk2PRlgVVxr+SlafzZ7eT6mKUsJEGiQPF9w+B+5CX7oH
         LoXOZtHd1okc62V7YZhvvG0vy6cbqi0Nxx7zPn2IhK4P8HppahbIB3U4Np3NxBkP1N81
         HkdlYhhE9SpupA1RSfERLDb5m+NekQwnEyTKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yo7vm9yRg/QAt1cNLA0IMYEFR0QnFkwTlujuFxJ6tig=;
        b=IwMzRHqua4EndDzZ5lBpo1nUZOfRY6UbtPQ11MQzWsleORm3HrTUgoGUP1Ulyry4ek
         YlG9vTEYwuQXvNdxzr9Pqu/H51MZmVAYKz16hQsSS85+NdwJ/RyfOtNtLEgleZOQ8rad
         jxK9PI93BhEYG7H7d78JdT/q+NPvjfAcvUgOeo6c1nJT1rLVs6PL+uavZEm9VCMG0vYp
         S5/0WWNs4bqXH2Q3fTUj4+rGWr2XI+mCsLQ9NGntg3w3kp8ZY4FwJhySvLo0E/J4hDo7
         06dL3bMG2uou5NUcx0wBlw6JcRlXRDLLwqtNlZbemluVsyVjBr2U3Qgtp/47dY4iFl8u
         W3wA==
X-Gm-Message-State: AOAM5339LGPAS9xHh5CgS1F/IPlodKryJ2JAcPnKvIlPNvvGeQlFJfoV
        6m46bv1HWE3+JZo3R6onD6GbcIAJkg2ug+bPFrTOVw==
X-Google-Smtp-Source: ABdhPJzrHXhPirdz/qLVLB8fMpWlNTSB58OH+GuOBLRSDrrxcvhyz9FXzX0JJ7wK3nskKjTkUX8GTQUVo6vroLyDu74=
X-Received: by 2002:a17:906:8982:b0:6f3:95f4:4adf with SMTP id
 gg2-20020a170906898200b006f395f44adfmr3637776ejc.524.1650876057869; Mon, 25
 Apr 2022 01:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220408061809.12324-1-dharamhans87@gmail.com>
 <20220408061809.12324-2-dharamhans87@gmail.com> <CAJfpegvU+y+WRhWrgWfc_7O5BdVi=N+3RUuVdBFFoyYVr9MDeg@mail.gmail.com>
 <CACUYsyGiNgbyoxWWdXm0z73B7QfnPGU2gYanDNSQqmq5_rnrhw@mail.gmail.com>
 <CAJfpegsZF4D-sshMK0C=jSECskyQRAgA_1hKD9ytsHKvmXoBeA@mail.gmail.com> <2c8e61de-54da-44da-3a7b-b95eabfb29f2@ddn.com>
In-Reply-To: <2c8e61de-54da-44da-3a7b-b95eabfb29f2@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Apr 2022 10:40:46 +0200
Message-ID: <CAJfpegtsTiO8tJ5yP0tonh3zu4125JXaJ0cOY-e_B5dDxmfSug@mail.gmail.com>
Subject: Re: [PATCH 1/1] FUSE: Allow parallel direct writes on the same file
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Dharmendra Hans <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 17:20, Bernd Schubert <bschubert@ddn.com> wrote:
>
>
>
> On 4/22/22 16:48, Miklos Szeredi wrote:
> > On Fri, 22 Apr 2022 at 16:30, Dharmendra Hans <dharamhans87@gmail.com> wrote:
> >>
> >> On Thu, Apr 21, 2022 at 8:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >>>
> >>> On Fri, 8 Apr 2022 at 08:18, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> >>>>
> >
> > That's true, but I still worry...  Does your workload include
> > non-append extending writes?  Seems to me making those run in parallel
> > is asking for trouble.
>
> Our main use case is MPIIO for now and I don't think it first sets the
> file size and would then write to these sparse files. Fixing all the
> different MPI implementations including closed source stacks is probably
> out of question.

Okay.

> Given that MPIIO also supports direct calls into its stack we also do
> support that for some MPIs, but not all stacks. Direct calls bypassing
> the vfs also haas  it's own issues, including security. So it would be
> really great if we could find a way to avoid the inode lock.
>
> Would you mind to share what you worry about in detail?

I worry about breaking the assumption about i_size does not change if
inode lock is held (exclusive of shared).

Maybe that's not an issue, but we'd need to look very carefully.

Thanks,
Miklos
