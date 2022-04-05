Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653B54F2397
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiDEGt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiDEGtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:49:51 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FF065D34;
        Mon,  4 Apr 2022 23:47:53 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id kc20so9345834qvb.3;
        Mon, 04 Apr 2022 23:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1fOL/166fikmH7uX2rZtUmlwmKDUvQ+HD9q8zNW/kM=;
        b=LGC17qPN2DTZd9LED2aXK0ffSxgkk+mKdSxrc82NCHiHcm/S3VaChsvuP+lyod/2Ro
         yTT4RzbGtySEokF5A14CH3fMAvH+P9wG73UTRl2n64ZUpGO5hMAU/iiClHf8dB3c+ilR
         lBq+o9YCgRTSVS6dwrpwv66fIGHH+4lr6MNO6nmdbEEczJJ0JHUhAHQh+NxkgTpFdzlZ
         nbOJ2vpEs1ReElgJqZhqrJhMMpUihwNc7Cd3y+Ne9Aw7+v+xAUy5MeeKt/QcnaLNQg/5
         HgkgB4bmBGXEnOq7ZRtumejEuj4Ux45S4BsSkcN3I98HrM7lNCrAYMh3KamcFrY8/PlE
         sDbQ==
X-Gm-Message-State: AOAM530D6fbTGHJ9ZQo/Y84hsqEi84gQEjBVz0Hf8qyMGczFq5T7kYpr
        8jXu7IJkXshKO6UNCtcSXblLA+s99feRSg==
X-Google-Smtp-Source: ABdhPJxqUS6Pw7wAQQ+YkofO7XRIpAPfbdC/NQ+LtaNsNmRgWc5kc9NrNTy/nQXRCYN1xGpwNiHsnA==
X-Received: by 2002:ad4:5dc8:0:b0:441:651c:2d25 with SMTP id m8-20020ad45dc8000000b00441651c2d25mr1511953qvh.89.1649141272590;
        Mon, 04 Apr 2022 23:47:52 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id w1-20020ac857c1000000b002e1e899badesm9610250qta.72.2022.04.04.23.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 23:47:52 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id j2so21799245ybu.0;
        Mon, 04 Apr 2022 23:47:52 -0700 (PDT)
X-Received: by 2002:a25:c049:0:b0:634:6751:e8d2 with SMTP id
 c70-20020a25c049000000b006346751e8d2mr1506294ybf.6.1649141271808; Mon, 04 Apr
 2022 23:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404074734.1092959-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
 <20220404092655.GR1544202@dread.disaster.area> <CAMuHMdWgqdR1o3wT9pjB=w8z=2xaDFv5DJX58-HPHOFRm3Tr8Q@mail.gmail.com>
 <CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com> <20220404221605.GS1544202@dread.disaster.area>
In-Reply-To: <20220404221605.GS1544202@dread.disaster.area>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Apr 2022 08:47:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWak-zarKA_eCxWm5uhejWAXi0XkAuekfpAKRczLfhq3g@mail.gmail.com>
Message-ID: <CAMuHMdWak-zarKA_eCxWm5uhejWAXi0XkAuekfpAKRczLfhq3g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.18-rc1
To:     Dave Chinner <david@fromorbit.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
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

Hi Dave,

On Tue, Apr 5, 2022 at 12:16 AM Dave Chinner <david@fromorbit.com> wrote:
> On Mon, Apr 04, 2022 at 01:45:05PM +0200, Arnd Bergmann wrote:
> > On Mon, Apr 4, 2022 at 12:19 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > /kisskb/src/fs/xfs/./xfs_trace.h:432:2: note: in expansion of macro 'TP_printk'
> > > >   TP_printk("dev %d:%d daddr 0x%llx bbcount 0x%x hold %d pincount %d "
> > > >   ^
> > > > /kisskb/src/fs/xfs/./xfs_trace.h:440:5: note: in expansion of macro '__print_flags'
> > > >      __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
> > > >      ^
> > > > /kisskb/src/fs/xfs/xfs_buf.h:67:4: note: in expansion of macro 'XBF_UNMAPPED'
> > > >   { XBF_UNMAPPED,  "UNMAPPED" }
> > > >     ^
> > > > /kisskb/src/fs/xfs/./xfs_trace.h:440:40: note: in expansion of macro 'XFS_BUF_FLAGS'
> > > >      __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
> > > >                                         ^
> > > > /kisskb/src/fs/xfs/./xfs_trace.h: In function 'trace_raw_output_xfs_buf_flags_class':
> > > > /kisskb/src/fs/xfs/xfs_buf.h:46:23: error: initializer element is not constant
> > > >  #define XBF_UNMAPPED  (1 << 31)/* do not map the buffer */
> > > >
> > > > This doesn't make a whole lotta sense to me. It's blown up in a
> > > > tracepoint macro in XFS that was not changed at all in 5.18-rc1, nor
> > > > was any of the surrounding XFS code or contexts.  Perhaps something
> > > > outside XFS changed to cause this on these platforms?
> > >
> > > Upon closer look, all builds showing this issue are using gcc-5...
> > >
> > > > Can you bisect this, please?
> > >
> > > Fortunately I still have gcc-5 installed on an older machine,
> > > and I could reproduce the issue on amd64 with
> > > "make allmodconfig fs/xfs/xfs_trace.o".
> > >
> > > Bisection points to commit e8c07082a810fbb9 ("Kbuild: move to
> > > -std=gnu11").
> > >
> > > [1] gcc version 5.5.0 20171010 (Ubuntu 5.5.0-12ubuntu1
> >
> > Thanks for the report. I've produced it and can see that the problem
> > is assigning
> > the value of "(1 << 31)" to an 'unsigned long' struct member. Since this is
> > a signed integer overflow, the result is technically undefined behavior,
> > which gcc-5 does not accept as an integer constant.
> >
> > The patch below fixes it for me, but I have not checked if there are any
> > other instances. This could also be done using the 'BIT()' macro if the
> > XFS maintainers prefer:
>
> So XFS only uses these flags in unsigned int fields that are
> typed via:
>
> typedef unsigned int xfs_buf_flags_t;
>
> So on the surface, declaring the flag values as ULONG and then writing
> them into a UINT field is not a nice thing to be doing.
>
> I really don't want to change the xfs_buf_flags_t type to an
> unsigned long, because that changes the packing of the first
> cacheline of the struct xfs_buf and the contents of that cacheline
> are performance critical for the lookup fastpath....

Hence just use "1u << n" instead of "1ul << n"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
