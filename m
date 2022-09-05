Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2738B5ACF41
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbiIEJya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbiIEJy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:54:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63230C63;
        Mon,  5 Sep 2022 02:54:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so6609466wmk.1;
        Mon, 05 Sep 2022 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=MV2yVYWQa/VSrYQcP1/auWjWA4tf381Y8eSWdMP1o3M=;
        b=jBbb6UUEguRWkGOUZqXUuTWj2WO/U32hJ8rNaaOxApdB1f3aXJR5LpwwV5ETk5b/V+
         8Wa1D8yzFQGXULu2RuBgDuQAHW1AT4uD32q12Q5Ye9zX0qY79nTsNpFWvdXpd98W2gtf
         gJbCS5d4LWxsebUO1XT1AuQHVcmS0ix1Wwx3HpAvy0j1/vCq4rOh8fpMI8WmT+3yEX4z
         q9O+PuxZ9SQQYRYgTFyr2Hw78yBMA4usVjRDeSE5TMHFHKRCeJ7kfgjOFdtECKa6w5D8
         sBxx3eq+CQOw4o/e3aj13169xrg7JLBlRBt0rWupTSkEX8FecM6/2flLwj9oqVn2Awi2
         xtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MV2yVYWQa/VSrYQcP1/auWjWA4tf381Y8eSWdMP1o3M=;
        b=E0f/H5hjHhCA2SjXvEfyw93ELtXo4idFCKkIdpV8RZO0yTdWStJLJiTI1pBLXtQ1/O
         QeMW1TsphAJn75ebjwNkl6bVBaLjo2cfWJlz1+MG+8+gs7hWXSKHvYcNjrBiI9WR1BnN
         dno7S/GzPaztHbnd8XCnn/csKbDwoP/W1Cj2bN9k1fAPQDpT5OkAq54e3QOdklodsGlF
         dhCArjLwL77SPLYSzwJj0X69uj5RRUIU67syP65KUX3i+F6/auZ+3vbjoSCmDnv901Xb
         vcs/eaE4L9YaK0iHCAjDJYqndJzu+1AsZWPXlo5NoHdZTOk3TvqPQt79SPnME2Rpp51E
         Woeg==
X-Gm-Message-State: ACgBeo1W6wt8CBHKz7XYVCIj8U4W+LNPZZAn5rIMBzh5CJs74X5qNRFC
        lzCPlVqYTaPhC4A6eyoWpSmn6o9o3aY=
X-Google-Smtp-Source: AA6agR4wi642iZWrZbWE75w3/OrRgTl0FFOnaKGWR//tV+j5u8opEPTAytoYZJ7fG+rvFwHZczEO2g==
X-Received: by 2002:a05:600c:6025:b0:3a6:ff6:de7e with SMTP id az37-20020a05600c602500b003a60ff6de7emr10025027wmb.173.1662371662913;
        Mon, 05 Sep 2022 02:54:22 -0700 (PDT)
Received: from gmail.com (1F2EF41B.nat.pool.telekom.hu. [31.46.244.27])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b003a84375d0d1sm18183891wmq.44.2022.09.05.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 02:54:22 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 5 Sep 2022 11:54:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] x86/config: Make the x86 defconfigs a bit more usable
Message-ID: <YxXHTMl/7PhVRSA9@gmail.com>
References: <YjsCpoRK7W4l6tSh@zn.tnic>
 <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
 <YjwsUT/6PkRPjnHE@gmail.com>
 <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
 <YkC08gKqJOUM7CA8@gmail.com>
 <YkHXQTKImf7Wr+Sk@dev-arch.thelio-3990X>
 <YxHD1MkulyL3yB9y@gmail.com>
 <CAK7LNASyp8SzO3G+th5RgmRNBM_ryKuy0XzaMrdUdo8Sd6RR0A@mail.gmail.com>
 <YxR0UlS0Jpz9uqb7@gmail.com>
 <CAK7LNATnGO3LHZ7VvJRziDqz50gRq7MUJPOJLMfcv=pCiA=-mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATnGO3LHZ7VvJRziDqz50gRq7MUJPOJLMfcv=pCiA=-mg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <masahiroy@kernel.org> wrote:

> On Sun, Sep 4, 2022 at 6:48 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > > > Unfortunately, even without the ARCH=i386 'make savedefconfig' doesn't
> > > > seem to be doing the right thing & is dropping the '# CONFIG_64BIT is
> > > > not set' line:
> > >
> > >
> > > Oh, really?
> > >
> > > Without ARCH=i386, it works correctly for me.
> > >
> > >
> > >
> > > masahiro@zoe:~/ref/linux$ make i386_defconfig savedefconfig
> > > #
> > > # No change to .config
> > > #
> > > masahiro@zoe:~/ref/linux$ grep CONFIG_64BIT defconfig
> > > # CONFIG_64BIT is not set
> >
> > Yeah, so why do these two seemingly identical commands produce two
> > different .config's:
> >
> >   $ make ARCH=i386 defconfig
> >   *** Default configuration is based on 'i386_defconfig'
> >
> >   $ make i386_defconfig
> >
> > ?
> 
> 
> 
> As Nathan explained in this thread,
> the prompt of CONFIG_64BIT is hidden
> when ARCH=i386.

Yeah, so my 'why' question was more about why we'd tolerate the UI 
inconsistency in seemingly similar commands generating subtly different 
.config's.

In other words, what should we modify in this Kconfig block, or in other 
parts of the kernel:

> config 64BIT
>         bool "64-bit kernel" if "$(ARCH)" = "x86"
>         default "$(ARCH)" != "i386"
>         help
>           Say yes to build a 64-bit kernel - formerly known as x86_64
>           Say no to build a 32-bit kernel - formerly known as i386

... to not have this Kconfig UI quirk/bug/inconsistency?

I hope we agree that the status quo is not ideal.

Thanks,

	Ingo
