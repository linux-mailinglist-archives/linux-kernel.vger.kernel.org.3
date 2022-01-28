Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF7E49F0F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbiA1CaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbiA1CaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:30:12 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E26EC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:30:12 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g14so14311251ybs.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DamQHfcfzoASoILm7XiX5cq6CR5MirC/axqcdaKZru8=;
        b=i5pCtfIMsiigWJD7tXVJjlFvSir95TsPd2f/wfNZ7UnizIAK8p5N5YfX4mSoLL9Fv+
         KEZKqGLZqCqMkvBwGwiIctxvFmeycsC9C76WOUWE9cFU6XUPjT6Ew+a39kOQsUGK92+i
         zKYIsg1VZAI5D1BO3EFzncW8LNNKkTF+eSebbVxje6vbgI8q3YYmZOakQ9CCoAP2MDn7
         b0yiR2VHCgKJp0Q3TGnQfQFoDNqEUMBhGPo3WPavflTE/eqyyPiICe5GAdI3X6e/i525
         Q4OlcMbYMr/31ZdmcQEcF/G4B+21Yn+sfP4B7gO5mK3LaOnp2DKsr8gLgaN9hWTXHT/W
         Qj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DamQHfcfzoASoILm7XiX5cq6CR5MirC/axqcdaKZru8=;
        b=zkiJgi3lhazrU5dC/xFRIwO4dtSeBkjgziW74xqeBqCTpb0GGbH8INWQy8X+809cIs
         pCTE+WdRfcmvlM43CPyVKHf4/nRmGvG8fyQsIXd1joQ2BomOJX9ukDZ3iEaOezQ0/plE
         cSrk1oW7U4bU60leU9BfE0E8vUV03fls91x78dnWiFlczrTiITP0oRy8Japgeu7rgj7q
         Joo/+u4MBmZ8PW8OT/Yuvre9FkakZxWzkJykfoMZ6HUiRJJ2RbvX4M8QJWpmiofWv3Ie
         oB6Ffjn7ATdlNHjPyQFxA5/5d050fLaPoIuvZMcWJuCpVx5NnHhVjrHjUIPFuc7vF+44
         7gXA==
X-Gm-Message-State: AOAM531W522G/PeYPi6EvoUmaj8WIMSXCCiRJmKkei9hjeFIKYAVlk0H
        Ri9ZN1Ctt4xE41dXENa9ZrxnPgEZQUBZHzXiKKuvIQ==
X-Google-Smtp-Source: ABdhPJx0WDYGuW8NyYrZWYUmYbRLJ4MjGYQsafMXy/Rgq/znTvBWVgE/qBEVbn9LpIURHoLqG50QlQwxWh1y7xcftxo=
X-Received: by 2002:a25:d80f:: with SMTP id p15mr10098925ybg.753.1643337011182;
 Thu, 27 Jan 2022 18:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20220128014303.2334568-1-jannh@google.com> <CANn89iKWaERfs1iW8jVyRZT8K1LwWM9efiRsx8E1U3CDT39dyw@mail.gmail.com>
 <CAG48ez0sXEjePefCthFdhDskCFhgcnrecEn2jFfteaqa2qwDnQ@mail.gmail.com>
 <20220127182219.1da582f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CANn89i+k4tiyQtb6fh8USDjhZGVwdx1puh8cr9NcDQECbvJvdg@mail.gmail.com> <CAG48ez3rhgWhELfeuTiTVNk5GP2hbzWZE2SE+-jmHPZxxg1hJQ@mail.gmail.com>
In-Reply-To: <CAG48ez3rhgWhELfeuTiTVNk5GP2hbzWZE2SE+-jmHPZxxg1hJQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Jan 2022 18:30:00 -0800
Message-ID: <CANn89i+h-eQtPH=6dObjXO+k6WLc8vNo3MCjzmE4+4LLj2NYzw@mail.gmail.com>
Subject: Re: [PATCH net] net: dev: Detect dev_hold() after netdev_wait_allrefs()
To:     Jann Horn <jannh@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 6:27 PM Jann Horn <jannh@google.com> wrote:
>
> I like that idea... but this_cpu_dec()/this_cpu_inc() use GS-relative
> addressing, at least on X86-64, so NULL might make things worse, I
> think? /proc/kallsyms on my machine starts with:
>
> 0000000000000000 A fixed_percpu_data
> 0000000000000000 A __per_cpu_start
> 0000000000001000 A cpu_debug_store
> 0000000000002000 A irq_stack_backing_store
> 0000000000006000 A cpu_tss_rw
> 000000000000b000 A gdt_page
> 000000000000c000 A exception_stacks
> 0000000000010000 A entry_stack_storage
> 0000000000011000 A espfix_waddr
>
> So we'd probably need some different placeholder instead of NULL to
> actually crash...

Orthogonal problem, maybe we should make sure the first page of
per-cpu data is un-mapped.
