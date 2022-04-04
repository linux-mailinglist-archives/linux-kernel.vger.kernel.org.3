Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415494F1304
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357230AbiDDKVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351111AbiDDKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:21:49 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85AF21E3C;
        Mon,  4 Apr 2022 03:19:52 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id cs16so1318389qvb.8;
        Mon, 04 Apr 2022 03:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0WumEk3/5swSrnfM7ptK2Xb+Nf3xe4k1omZOmmtKb0=;
        b=1egaTx4waAR/DDV5IzdbJxFdAxB26YoB6lDEs1qDyjH0XQhkXl4j9NXxqFL+01EAq0
         AEvIpmTa1rDuIae+GVMMjLUrNluQfxChvzGXKIT4I1Qy3TGv+VGULqDvEBAWoD+uxY3Z
         A7P8sM1y3TA4hrPJzhos5mVL9WpbnYjC2WoQQw6Bm/ous5wgiuxkhB0YD7dfInwZvbGQ
         PS3EOAWFsfhF2i1giHp1Qe/0hNGA0FilLe9THTwwHe1XJAWZPHbWizF9uHzuX2w5/8Wv
         LHQL82ugeI5wep0fgiRtrKB2Svi8n6ErL0f/OJSp3pTUanp0zMIR/nLavmAoXmfSsKzd
         v8sw==
X-Gm-Message-State: AOAM530ArM00Y4vefDuTcvqweaItIT2V5NyCUIkKLbC4KlP7hCj521Ec
        tzvG1pVBDOufL85v4p7GSuUrTIW8B/NTLQ==
X-Google-Smtp-Source: ABdhPJyDjmot1XG5QUnI1vB2vxwifVDQc6DC9bFoa8gR6RnoHLlb9qZvv+nZpvgoPadSRHQSi0NJDw==
X-Received: by 2002:a05:6214:3015:b0:443:c252:b9a6 with SMTP id ke21-20020a056214301500b00443c252b9a6mr7206292qvb.11.1649067591671;
        Mon, 04 Apr 2022 03:19:51 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id d3-20020a05622a15c300b002eb9af4c945sm8734803qty.3.2022.04.04.03.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 03:19:51 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2eb3db5b172so47307477b3.6;
        Mon, 04 Apr 2022 03:19:51 -0700 (PDT)
X-Received: by 2002:a0d:e743:0:b0:2eb:3106:9b32 with SMTP id
 q64-20020a0de743000000b002eb31069b32mr11995528ywe.512.1649067591056; Mon, 04
 Apr 2022 03:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404074734.1092959-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
 <20220404092655.GR1544202@dread.disaster.area>
In-Reply-To: <20220404092655.GR1544202@dread.disaster.area>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Apr 2022 12:19:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWgqdR1o3wT9pjB=w8z=2xaDFv5DJX58-HPHOFRm3Tr8Q@mail.gmail.com>
Message-ID: <CAMuHMdWgqdR1o3wT9pjB=w8z=2xaDFv5DJX58-HPHOFRm3Tr8Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.18-rc1
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
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

Hi Dave

CC Arnd

On Mon, Apr 4, 2022 at 11:27 AM Dave Chinner <david@fromorbit.com> wrote:
> On Mon, Apr 04, 2022 at 10:16:08AM +0200, Geert Uytterhoeven wrote:
> > On Mon, 4 Apr 2022, Geert Uytterhoeven wrote:
> > > Below is the list of build error/warning regressions/improvements in
> > > v5.18-rc1[1] compared to v5.17[2].
> > >
> > > Summarized:
> > >  - build errors: +36/-15
> > >  - build warnings: +5/-38
> > >
> > > Happy fixing! ;-)
>
> Well....
>
> > >  + /kisskb/src/fs/xfs/xfs_buf.h: error: initializer element is not constant:  => 46:23
>
> Looking at:
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/14714961/
>
> The build error is:
>
> /kisskb/src/fs/xfs/./xfs_trace.h:432:2: note: in expansion of macro 'TP_printk'
>   TP_printk("dev %d:%d daddr 0x%llx bbcount 0x%x hold %d pincount %d "
>   ^
> /kisskb/src/fs/xfs/./xfs_trace.h:440:5: note: in expansion of macro '__print_flags'
>      __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
>      ^
> /kisskb/src/fs/xfs/xfs_buf.h:67:4: note: in expansion of macro 'XBF_UNMAPPED'
>   { XBF_UNMAPPED,  "UNMAPPED" }
>     ^
> /kisskb/src/fs/xfs/./xfs_trace.h:440:40: note: in expansion of macro 'XFS_BUF_FLAGS'
>      __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
>                                         ^
> /kisskb/src/fs/xfs/./xfs_trace.h: In function 'trace_raw_output_xfs_buf_flags_class':
> /kisskb/src/fs/xfs/xfs_buf.h:46:23: error: initializer element is not constant
>  #define XBF_UNMAPPED  (1 << 31)/* do not map the buffer */
>
> This doesn't make a whole lotta sense to me. It's blown up in a
> tracepoint macro in XFS that was not changed at all in 5.18-rc1, nor
> was any of the surrounding XFS code or contexts.  Perhaps something
> outside XFS changed to cause this on these platforms?

Upon closer look, all builds showing this issue are using gcc-5...

> Can you bisect this, please?

Fortunately I still have gcc-5 installed on an older machine,
and I could reproduce the issue on amd64 with
"make allmodconfig fs/xfs/xfs_trace.o".

Bisection points to commit e8c07082a810fbb9 ("Kbuild: move to
-std=gnu11").

[1] gcc version 5.5.0 20171010 (Ubuntu 5.5.0-12ubuntu1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
