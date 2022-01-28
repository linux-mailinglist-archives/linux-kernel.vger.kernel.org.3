Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2512F49F0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345337AbiA1C1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbiA1C1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:27:30 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA10C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:27:29 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o12so8864325lfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSuQ1RdxCpd5e9ddFi6SY1yf2lvzQ/d2JUW3rgqOe0Y=;
        b=X9nkUCdx4/F/CMEM9KLDs220OqebzHDeQsl5Eyakq5Sl6/R0uJ1mUKtuyH/PJlmZkn
         HowgjnDd8xqmX1SgUF03rMRmzU+Qi7P2M8mTKi2QXBvjA6ZAluEySB8GB3Cqtdz6uZtH
         UCbPJsjVZyVMxzO4nZQNSI8za7QVkEoIH3p346juBY83XslAkuXyWJmk1w2Jw38VHQ++
         QPtu9GkmnYj9io0bOU2xLYFldMbOBqefYgt+NQ7FbgkRJEcJIeSMqIz5vx3OYK1J4U6I
         pzBvVZP0eGd4rRzsuDel6kL023lYw3EsHO/n3hb1GMmYJFu+k2XKVW8phRZlPGfuKCx1
         Zgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSuQ1RdxCpd5e9ddFi6SY1yf2lvzQ/d2JUW3rgqOe0Y=;
        b=jW0ppjVPHS3frQ5g8uHwr5dqcqq+1gAUJ/XzWh80x6C15Mq5YGUJ7pXK62pyhMUgdp
         OXiZEdN33UyQ2wAz5+ElqsucvNJLNJciLWreiO1Whtmjk0ake6EYqt5Ul8eVdhbi3vCJ
         B1PCuzSQBD48WY217TnFbFeg3tgHP06+8lGstANMcY4zrxc5KHIk4q20nq4nUki+6/0s
         rqDRL9X87KPWUEJZqUXCQskzbhVNVsmGtiLqGcrGEVD2/ZtbSsnRwRF8sQ3JDtg+zMX6
         lPuCe3ABZay/E6n+ZkXLFCRbd80v51Q3Vbwq3NgR6tBRuNCvWE8aqRvEWs1z2VXDTZxS
         3pqA==
X-Gm-Message-State: AOAM5335kbArCfKxWm7uTqZfMGYw001MsiMcUR3VWapw5hSSpOTr+hDm
        VJC9SUZqyYubhTUve/a1jtIwy1wTzNnaiiIDLYhk2j9u2LH0dA==
X-Google-Smtp-Source: ABdhPJzaWxqcg8LsrS7TslM1R3QutH4w2RdVQ5a/blzlnCswpNI+wldOWG/CCP8da5iET9Dcc4TAm/ukp3rWooIxjkE=
X-Received: by 2002:a05:6512:1114:: with SMTP id l20mr4467066lfg.237.1643336847888;
 Thu, 27 Jan 2022 18:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20220128014303.2334568-1-jannh@google.com> <CANn89iKWaERfs1iW8jVyRZT8K1LwWM9efiRsx8E1U3CDT39dyw@mail.gmail.com>
 <CAG48ez0sXEjePefCthFdhDskCFhgcnrecEn2jFfteaqa2qwDnQ@mail.gmail.com>
 <20220127182219.1da582f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <CANn89i+k4tiyQtb6fh8USDjhZGVwdx1puh8cr9NcDQECbvJvdg@mail.gmail.com>
In-Reply-To: <CANn89i+k4tiyQtb6fh8USDjhZGVwdx1puh8cr9NcDQECbvJvdg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Jan 2022 03:27:01 +0100
Message-ID: <CAG48ez3rhgWhELfeuTiTVNk5GP2hbzWZE2SE+-jmHPZxxg1hJQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dev: Detect dev_hold() after netdev_wait_allrefs()
To:     Eric Dumazet <edumazet@google.com>
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

On Fri, Jan 28, 2022 at 3:23 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Jan 27, 2022 at 6:22 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Fri, 28 Jan 2022 03:14:14 +0100 Jann Horn wrote:
> > > Oh. Whoops. That's what I get for only testing without CONFIG_PCPU_DEV_REFCNT...
> > >
> > > I guess a better place to put the new check would be directly after
> > > checking for "dev->reg_state == NETREG_UNREGISTERING"? Like this?
> >
> > Possibly a very silly suggestion but perhaps we should set
> > the pointer to NULL for the pcpu case and let it crash?

I like that idea... but this_cpu_dec()/this_cpu_inc() use GS-relative
addressing, at least on X86-64, so NULL might make things worse, I
think? /proc/kallsyms on my machine starts with:

0000000000000000 A fixed_percpu_data
0000000000000000 A __per_cpu_start
0000000000001000 A cpu_debug_store
0000000000002000 A irq_stack_backing_store
0000000000006000 A cpu_tss_rw
000000000000b000 A gdt_page
000000000000c000 A exception_stacks
0000000000010000 A entry_stack_storage
0000000000011000 A espfix_waddr

So we'd probably need some different placeholder instead of NULL to
actually crash...

> It is already set to 0

I think he meant do it already in netdev_run_todo(), not just in free_netdev()?
