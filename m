Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EBA5067F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbiDSJp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbiDSJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:45:09 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D7B19016;
        Tue, 19 Apr 2022 02:42:27 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id n11so12745756qvl.0;
        Tue, 19 Apr 2022 02:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKA9OdpVAxszLmhE22toGS/7VP7U4z/nzrtw9SumhDU=;
        b=fbodEKP9lT212pX7fFgrAjNBNLyJqR++z/uk0Vhs8OVo/6GEJlOWTWC4GxdAIcj9ur
         faHmiRp/7ALh1RITuAmFivYHYkgRUiC/OqJpgrA5xwszlQIxVyGprQB8CT2HozulFnV8
         BtHixaaxA86WxP6LQH0Dr16gTmSR++UN/x6QGh9LrUJPfLs6mywZ7doIdcApTVXs7Z8P
         dAx5xjbGdwVNINvpBgRfESarm7QJRMwTCzfnJM/9Yta8HKT9hQF7is/3T5t04AcIIf1f
         AAYGGjSIGS5EOMFjco7o+p4+3OrVNtMvJdYbLKP5P2zn4qE0TDgUf3Q2s+3so3PQJEZl
         rDGg==
X-Gm-Message-State: AOAM533N45/JyiEQ9A13C+US/uTVk7T+7aouZL0u74e4S171oXpY95y9
        crTSg1f/ksrRVihZ/9mVote4YM5UkV3JDA==
X-Google-Smtp-Source: ABdhPJxxCsOLiwmWOVaTS6Y3isjoTFD1/C8+bko4CHQ+tFMt4LKWDFowFuGbpAlpw3HeLspIqkpb6g==
X-Received: by 2002:a05:6214:2627:b0:446:6577:6ef8 with SMTP id gv7-20020a056214262700b0044665776ef8mr4606923qvb.85.1650361346310;
        Tue, 19 Apr 2022 02:42:26 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 21-20020ac85715000000b002e1ce9605ffsm9187148qtw.65.2022.04.19.02.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 02:42:25 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id d19so1597711ybc.5;
        Tue, 19 Apr 2022 02:42:25 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr13915294ybq.342.1650361345280; Tue, 19
 Apr 2022 02:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220414081257.1487499-1-vincent.whitchurch@axis.com> <76a7b33d-6f8b-e660-c64d-027b1bc8e308@landley.net>
In-Reply-To: <76a7b33d-6f8b-e660-c64d-027b1bc8e308@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Apr 2022 11:42:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-8HaQip+DT5W2Owq8M8kbYwHsf8_Zd-5rRfSjSjK0=g@mail.gmail.com>
Message-ID: <CAMuHMdW-8HaQip+DT5W2Owq8M8kbYwHsf8_Zd-5rRfSjSjK0=g@mail.gmail.com>
Subject: Re: [PATCH] sh: make !MMU iounmap an inline function
To:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, kernel@axis.com,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Landley <rob@landley.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rich, Sato-san,

On Sat, Apr 16, 2022 at 12:01 AM Rob Landley <rob@landley.net> wrote:
> On 4/14/22 03:12, Vincent Whitchurch wrote:
> > The current definition of sh's !MMU iounmap makes it unusable in certain
> > kinds of code, such as this instance caught by 0day on a patch posted to
> > the mailing lists:
> >
> >  In file included from include/linux/io.h:13,
> >                   from drivers/mtd/devices/phram.c:21:
> >  drivers/mtd/devices/phram.c: In function 'register_device':
> >  arch/sh/include/asm/io.h:274:33: error: expected expression before 'do'
> >    274 | #define iounmap(addr)           do { } while (0)
> >        |                                 ^~
> >  drivers/mtd/devices/phram.c:150:44: note: in expansion of macro 'iounmap'
> >    150 |         cached ? memunmap(new->mtd.priv) : iounmap(new->mtd.priv);
> >        |                                            ^~~~~~~
> >
> > Make it an inline function as it was earlier.
> >
> > Link: https://lore.kernel.org/lkml/202204131446.omJ5mC54-lkp@intel.com/
> > Fixes: 13f1fc870dd747131 ("sh: move the ioremap implementation out of line")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>
> Tested-by: Rob Landley <rob@landley.net>
>
> Worked For Me.

Can we please get any of [1], [2], [3], or [4] applied and sent
upstream, so people can stop wasting time on recreating and
resubmitting similar patches all the time?

Thank you!

[1] PATCH] sh: Fix set but not used warnings with !CONFIG_MMU
    https://lore.kernel.org/r/20201208182117.163642-2-sam@ravnborg.org
[2] [PATCH] sh: make iounmap() a static inline again
    https://lore.kernel.org/r/20220105085746.1116726-1-mkl@pengutronix.de
[3] [PATCH] sh: Convert nommu io{re,un}map() to static inline functions
    https://lore.kernel.org/r/4ed0a7a0d3fa912a5b44c451884818f2c138ef42.1644914600.git.geert+renesas@glider.be/
[4] [PATCH] sh: make !MMU iounmap an inline function
    https://lore.kernel.org/r/20220414081257.1487499-1-vincent.whitchurch@axis.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
