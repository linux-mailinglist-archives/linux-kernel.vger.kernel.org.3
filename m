Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1138E4EB5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiC2WZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbiC2WZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:25:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B75165B8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:23:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m3so32687563lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Dqci59lOGmtJ083V8k97ZYbp+giAEnmUDvP8kvIUkQ=;
        b=VT+r9uwHTgcY2d+uPwopx2P2879A0JSJ2gtfFxXD746GNnk+z6kMC9bmyoI1CnXMDl
         NcVjvjzkleAw9ej5n9U29kxGsWaLtCwRJW1vgaE0d8bTR07Nj77+TxMI/kwQpYcYPvN1
         odJbyA0ON7CIneCs1/wSlaM0123GCIo/jGohw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Dqci59lOGmtJ083V8k97ZYbp+giAEnmUDvP8kvIUkQ=;
        b=GmATHoqdNIT7a+Rtweh7pEv+6OxmW106fdjf1hEBeG7Z9umR2TlWvnMv3h0BwkW4Lp
         UEVLgnX6ww1SldVWAwyKoD3owdkCKxKuHjo4XSgcoLBIKd9TZWjcug265tIzgUH/CJJT
         tLiLUSiFn3BuSrFdl0Xx1KKthG14FjAThbVYQ3VT+uWaOwzhVGJAetvmuqAoPbuo1kHp
         cjnpItdbxvhvFlRMnWhV90OigiIh3W8EMXWvBQuvil7Tv2WKJ9wIk5YxO3sxCJqd8U+4
         lVZgcGriGgk2JECVXiB8sV3/4YkxvVzY4VMxqukyAAkygosIf8WxyA83t9fVgS2tXnsD
         vg1Q==
X-Gm-Message-State: AOAM5335dylB/apbE4CWMrmOkETU8FOEoOaiLJ+NR0VA0+77hhmNk0xG
        1E8hO9cv3vK5UI1YqexgaLFipEd5oVDUwMqv
X-Google-Smtp-Source: ABdhPJxyqL3NiL2GK5wkIZNM00S8H/EJB80WfbHZQ4egEK+oQmuTc/rqqFQSjA4TrJqwdk+9bH4r7g==
X-Received: by 2002:a05:6512:3086:b0:44a:50c3:c9dd with SMTP id z6-20020a056512308600b0044a50c3c9ddmr4591902lfd.289.1648592608354;
        Tue, 29 Mar 2022 15:23:28 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h14-20020a05651c158e00b00247fda7844dsm2178633ljq.90.2022.03.29.15.23.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 15:23:27 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id g24so25305464lja.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:23:27 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr4407592lji.152.1648592606822; Tue, 29
 Mar 2022 15:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67> <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
 <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
In-Reply-To: <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 15:23:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsdDBmaD-sS5FSb3ngn820z3x=1Ny+36agbEXhDuGOsg@mail.gmail.com>
Message-ID: <CAHk-=wjsdDBmaD-sS5FSb3ngn820z3x=1Ny+36agbEXhDuGOsg@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     Fedor Pchelkin <aissur0002@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 3:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, applied as commit 1c24a186398f ("fs: fd tables have to be
> multiples of BITS_PER_LONG").

Oh, forgot to mention...

Christian - it strikes me that the whole "min(count, max_fds)" in
sane_fdtable_size() is a bit stupid.

A _smarter_ approach might be to pass in 'max_fds' to
count_open_files(), and simply not count past that value.

I didn't do that, because I wanted to keep the patch obvious. And it
probably doesn't matter, but it's kind of silly to possibly count a
lot of open files that we want to close anyway, when we already know
the place we should stop counting.

Whatever. I just wanted to mention it in case you decide you want to
clean that part up. This is mostly your code anyway.

               Linus
