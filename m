Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CE8567256
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiGEPTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGEPTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:19:05 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DA239D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:19:03 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id ay10so14089392qtb.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mOvx1LHO+r0HBiq3jN+NAgJzGM4J0XRgiHur4Meacw=;
        b=Co6D/94rkaLdYKQAAcSvKaa80Rjbx4cUiRaZ8364CIDfRz3UCNSWdu2dg9lfuiJ/kP
         +YIU7em6SgEWsq0nw+S7swSf4M2SbaIwZyt4ngKGk5izJYpbxjXlb5teKyikYHmEjBdd
         YiJxaO77YEgjM84iu9LW2u0a3l0z4ub6ovW5C9BYW+RGUagru47B0NPwERbZa+V+Zgv/
         eLkmQT0yZ6OVj8jZnp2MziWeCGtLcFKZhOlPKO+L4XoEfKqBwE1PruhCDXExMmLmF1sM
         703iYcXzy36no++1BvoZPjRdp5VJOJfC6NaGcnINNMeXq+El3ZqhND9KvuHUSxnogqYG
         g4QA==
X-Gm-Message-State: AJIora9OeVwbAzBAKyX2AEtq9aVx2IJuKnd046sYNU99BfmcqQrSAIgO
        mUDuxJV+t/m8JZewR8+2PTkCBk+PzMP4pQ==
X-Google-Smtp-Source: AGRyM1sudm64wrPy8hZUSrjAbnL5PZEQxXs9sfVtN0h1D3sQBtwUplDoGZLYQvnjRNApLY8taghS7w==
X-Received: by 2002:a05:6214:62a:b0:472:eac1:7565 with SMTP id a10-20020a056214062a00b00472eac17565mr12663969qvx.71.1657034342625;
        Tue, 05 Jul 2022 08:19:02 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id q15-20020ac8450f000000b003177f0fb61esm21592877qtn.75.2022.07.05.08.19.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 08:19:02 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31cac89d8d6so42620867b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:19:02 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr40017641ywd.283.1657034342075; Tue, 05
 Jul 2022 08:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220615021059.862643-1-imran.f.khan@oracle.com>
 <20220615021059.862643-3-imran.f.khan@oracle.com> <CGME20220701112210eucas1p2d2db45881086f41b73527f7536537aa5@eucas1p2.samsung.com>
 <270b640d-d5e8-b775-9a16-5d5d07f959ff@samsung.com> <9e95f138-9ec5-90fc-7ea9-cf8cff8bf180@oracle.com>
 <ad06d3c3-7878-9106-e118-f89e2de91a1f@samsung.com>
In-Reply-To: <ad06d3c3-7878-9106-e118-f89e2de91a1f@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Jul 2022 17:18:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWN=yQCdfJQW+dg7uOc7QbGNXp_AtdR-hJttenu3sm7Xw@mail.gmail.com>
Message-ID: <CAMuHMdWN=yQCdfJQW+dg7uOc7QbGNXp_AtdR-hJttenu3sm7Xw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] kernfs: Change kernfs_notify_list to llist.
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Imran Khan <imran.f.khan@oracle.com>, Tejun Heo <tj@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Fri, Jul 1, 2022 at 2:51 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> On 01.07.2022 14:20, Imran Khan wrote:
> > On 1/7/22 9:22 pm, Marek Szyprowski wrote:
> >> On 15.06.2022 04:10, Imran Khan wrote:
> >>> At present kernfs_notify_list is implemented as a singly linked
> >>> list of kernfs_node(s), where last element points to itself and
> >>> value of ->attr.next tells if node is present on the list or not.
> >>> Both addition and deletion to list happen under kernfs_notify_lock.
> >>>
> >>> Change kernfs_notify_list to llist so that addition to list can heppen
> >>> locklessly.
> >>>
> >>> Suggested by: Al Viro <viro@zeniv.linux.org.uk>
> >>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> >>> Acked-by: Tejun Heo <tj@kernel.org>
> >> This patch landed in linux next-20220630 as commit b8f35fa1188b
> >> ("kernfs: Change kernfs_notify_list to llist."). Unfortunately, it
> >> causes serious regression on my test systems. It can be easily noticed
> >> in the logs by the following warning:
> >>
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 1 PID: 34 at fs/kernfs/dir.c:531 kernfs_put.part.0+0x1a4/0x1d8
> >> kernfs_put: console/active: released with incorrect active_ref 0
> >> Modules linked in:
> >> CPU: 1 PID: 34 Comm: kworker/1:4 Not tainted
> >> 5.19.0-rc4-05465-g5732b42edfd1 #12317
> >> Hardware name: Samsung Exynos (Flattened Device Tree)
> >> Workqueue: events kernfs_notify_workfn
> >>    unwind_backtrace from show_stack+0x10/0x14
> >>    show_stack from dump_stack_lvl+0x40/0x4c
> >>    dump_stack_lvl from __warn+0xc8/0x13c
> >>    __warn from warn_slowpath_fmt+0x90/0xb4
> >>    warn_slowpath_fmt from kernfs_put.part.0+0x1a4/0x1d8
> >>    kernfs_put.part.0 from kernfs_notify_workfn+0x1a0/0x1d0
> >>    kernfs_notify_workfn from process_one_work+0x1ec/0x4cc
> >>    process_one_work from worker_thread+0x58/0x54c
> >>    worker_thread from kthread+0xd0/0xec
> >>    kthread from ret_from_fork+0x14/0x2c
> >> Exception stack(0xf099dfb0 to 0xf099dff8)
> >> ...
> >> ---[ end trace 0000000000000000 ]---
> >>
> > Thanks for reporting this issue. It has been reported earlier in [1] as well. I
> > am unable to reproduce it locally. Could you please test with following patch on
> > top of linux next-20220630 and let me know if it helps:
>
> Yes, this fixes the issue. Feel free to add:
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Maybe it is related to the fact, that I have earlycon enabled on those
> machines?

Probably.
I see the issue on
  - rbtx4927 (CONFIG_EARLY_PRINTK=y),
  - SiPEED MAiXBiT (chosen/bootargs = "earlycon console=ttySIF0",
     chosen/stdout-path = "serial0:115200n8")
  - Litex/VexRiscV (chosen/bootargs = "console=liteuart earlycon=sbi").

It doesn't happen on the boards that just provide chosen/stdout-path
in DT.

Reverting commit b8f35fa1188b8403 ("kernfs: Change kernfs_notify_list
to llist.") fixes the issue.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
