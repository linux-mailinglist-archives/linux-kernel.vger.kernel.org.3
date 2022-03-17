Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE25A4DD0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiCQWnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCQWnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:43:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0422B4A5C;
        Thu, 17 Mar 2022 15:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C41C8B81E99;
        Thu, 17 Mar 2022 22:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F146C340F3;
        Thu, 17 Mar 2022 22:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647556904;
        bh=FHVVvG1Rr6KduhKbxfSM1ZOboRLahcePm/noojFXJbU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UXZ2FtRTaiQZA1h8vkSKLcMqTegt8/jWtJ3IMK+Z93VsCTwOzDrvBVi3IdVugxdF8
         ZzfGG4Y6CIJ7PRys9bTsp/kmB361qPyfdC0iJalrzm7G4lkPWpdgtS3oDjIek7BCpM
         z6BM3qopcNGP52kPfupvo/3XOtCwVaPBdzxhi0Ofd4au4+arMzKQZsvnvV6EqqV1Nt
         EZz18u2vQp9bj3A3SsvSGDqJTA3ocAlvNIkT4oY/riYVlfSofl7rU+xGgylRsUpGER
         yjkenM9/uBPfDaCoYc+r23XdG/rT6mvazd89Pe632iD4p82twwfdwcAWk9hgHVh2Gm
         7e5nkxw9BQomQ==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2e59939b862so74204607b3.10;
        Thu, 17 Mar 2022 15:41:44 -0700 (PDT)
X-Gm-Message-State: AOAM530BZH8cPD2w4K+4ikCrVbicJWJbgKk+X394awycwgojF6lw3UwL
        o7Jm0Og8c8r1MiSiZ5qHaoWOEKGlTvXE5/K90Hg=
X-Google-Smtp-Source: ABdhPJwpLpgB9cyDboA5jfZvS5jXDt66IJFw/EavZfuqNUhe2jURYyPKbWxa2uUWdQZzL78EydR6lsVRhRMCnr+SzWU=
X-Received: by 2002:a81:79d5:0:b0:2e5:9d33:82ab with SMTP id
 u204-20020a8179d5000000b002e59d3382abmr8352505ywc.460.1647556903176; Thu, 17
 Mar 2022 15:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <53e7de78-4d27-5089-f159-0d443b354666@leemhuis.info>
 <35bafd68-b340-dfaa-dd5f-d45843104f91@leemhuis.info> <CAPhsuW44tX0rBpy5c63HgTtRSF=UAAsgv8ZuYE_QTLhi6syXaA@mail.gmail.com>
 <Yh/nbZYmYD6SpZV9@sakura.greysector.net> <CAPhsuW4otwSDcOr8NWFhmecM4AfKim5jQ8aoZO-CY4KkwDFCgg@mail.gmail.com>
 <254dc1fb-cda7-6249-35e5-a0c584c41206@leemhuis.info>
In-Reply-To: <254dc1fb-cda7-6249-35e5-a0c584c41206@leemhuis.info>
From:   Song Liu <song@kernel.org>
Date:   Thu, 17 Mar 2022 15:41:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5vn7gepzFSn3a1p6SqzFHdvf0N7-U7EoAC7YTnF8wiFQ@mail.gmail.com>
Message-ID: <CAPhsuW5vn7gepzFSn3a1p6SqzFHdvf0N7-U7EoAC7YTnF8wiFQ@mail.gmail.com>
Subject: Re: Bug 215605 - [5.14 regression] BUG: unable to handle page fault
 while running badblocks (fsck.ext4 -c) on a raid5 md array
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Dominik Mierzejewski <dominik@greysector.net>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 6:14 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker. Top-posting for once,
> to make this easily accessible to everyone.
>
> Song, two weeks ago you said you would try to reproduce this. Any
> success? Or was the discussion moved somewhere else and I just missed it?
>

I haven't got luck to reproduce the issue yet. I will keep trying and
update when
there is progress.

Thanks,
Song

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
>
