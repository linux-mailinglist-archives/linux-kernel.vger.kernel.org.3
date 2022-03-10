Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ADA4D5395
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343948AbiCJV1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbiCJV07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:26:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043F9FABEA;
        Thu, 10 Mar 2022 13:25:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3336B8260F;
        Thu, 10 Mar 2022 21:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C220C340E8;
        Thu, 10 Mar 2022 21:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646947555;
        bh=aQHOi6FRKkQh4P31wSdh/kllgm7OKQc1lDwJe2OaUxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jT6hsRYDbnLY1G0pl88mdmseYjpm4ziEa8oK8IiA2bhoI1H4X34pSKYxJ5D3Rdjbs
         5GGhFWzG0uJlmTzRwmhLEKc6naLezje8QM/sntLeIzsHZszHD07c5f58PKOUD1dpH4
         Ars/PUSaiPC5w/PyahXKsIDaFPos3ls/LuuZ7/NTEzLQpjZI6OSP8y/30Z62vGl6A/
         n21jwg96Wre/lkWckDzrUG6H9bRKMEeP05b/HrTcI4zuqQISKtZBkPDiwySX59EXo7
         hSTdteyXNUqN69y55094NISV+RJQbTKHeq0V2N+Aaj6KQZHkLzkprQ3xhKsQM1plmP
         /dukaZtNbqmrA==
Received: by mail-yb1-f171.google.com with SMTP id e186so13445684ybc.7;
        Thu, 10 Mar 2022 13:25:55 -0800 (PST)
X-Gm-Message-State: AOAM533ReMelvUFORhN3N79EBADK/8YNLEbLg+rJBxUmZqf3M7AqLbKs
        5OcMk6vYkr8JJGUZ9z0NyL19B5+j9q2ea/6s0us=
X-Google-Smtp-Source: ABdhPJz5dhgB7I2T/rTqe0LB+NsrdtwQw3K1wAfEV+Q2g4N/buwPuu6M/47E3ScKxIEZ/riltTYuZmyQuLrajQ/wINY=
X-Received: by 2002:a25:8405:0:b0:629:3a9e:31ec with SMTP id
 u5-20020a258405000000b006293a9e31ecmr5699208ybk.224.1646947554568; Thu, 10
 Mar 2022 13:25:54 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com>
 <YijCkHHhpleeADAO@shell.armlinux.org.uk> <CA+G9fYtjrAMg8TykZdRyZEfRthyqom_73x87F-60C_QFeEL8Bg@mail.gmail.com>
 <YijfzAhWAgfGGqCO@shell.armlinux.org.uk> <CAMj1kXFvjawvOzeTb2m1H=P-_aXgW-ozvaOK1FtjBv7G0sCDFA@mail.gmail.com>
 <Yij2cZVKwPexGsTf@shell.armlinux.org.uk> <CAMj1kXE02HH7vRUjF3iKAL+1idKTy-oOYyGnBd3g90m6eObBxg@mail.gmail.com>
 <YikByJteDEtKi4Xv@shell.armlinux.org.uk> <CAMj1kXGnwbe=YYWaRxaXioEfTJOdXg9JYcNddO8iifpWLRZCWg@mail.gmail.com>
 <Yinwq3Z9l0selLLS@shell.armlinux.org.uk> <Yin2jQqW+pUWJZ7E@shell.armlinux.org.uk>
 <CAMj1kXGkUJ=-4oA4GvBZNK94A1MrZ7UwKDN_tJRgwq8KF06VmA@mail.gmail.com> <CA+G9fYvEANOMekjvtu7agdVYQ_b8OMtxQdyAV2JT_vMdBU3VRA@mail.gmail.com>
In-Reply-To: <CA+G9fYvEANOMekjvtu7agdVYQ_b8OMtxQdyAV2JT_vMdBU3VRA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Mar 2022 22:25:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEVVZTKX_86bbTfLpFuDriV0-uwCMgSKDP+dzcD1L4XCw@mail.gmail.com>
Message-ID: <CAMj1kXEVVZTKX_86bbTfLpFuDriV0-uwCMgSKDP+dzcD1L4XCw@mail.gmail.com>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 at 22:18, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi Ard and Russell,
>
> The boot test pass on linux next-20220310 tag with  KASAN=y on BeagleBoard x15
> device. but LTP cve tests reproduced the reported kernel crash  [1].
> From the available historical data I can confirm that this is an
> intermittent issue on
> BeagleBoard x15 devices.
>
> OTOH, the kernel crash is always reproducible on qemu-arm with KASAN=y
> while booting which has been known to fail for a long time.
>
> From the Ardb tree I have boot tested qemu-arm with KASAN=y the reported
> kernel crash is always reproducible.
>
> The build steps [3] and extra Kconfigs.
>
> - Naresh
> [1] https://lkft.validation.linaro.org/scheduler/job/4701310
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/
> [3] https://builds.tuxbuild.com/2661dIAPUjE2DMJvye91He2gus0/tuxmake_reproducer.sh

Thanks Naresh. I'm having trouble to make sense of this, though. The
linked output log appears to be from a build that lacks my 'ARM:
entry: fix unwinder problems caused by IRQ stacks' patch, as it
doesn't show any occurrences of call_with_stack() on any of the call
stacks.

Do you have a link to the vmlinux and zImage files for this build?
