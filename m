Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E75A4E45B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbiCVSJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiCVSI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:08:59 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A369727
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:07:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 17so25105999lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfOuUBo85WR0ru+OZ9vCbVy6pqMJNH141NsoPZ9iuzU=;
        b=CMulEQgOmYp7vegEsV0YqllOAJc/0EN/MM1/NaiwpHzfLRazS7VZwqTu86PQodXmRH
         27Dp+NKvW82SedQ0AiFEk8k6KtsoqvVc2Ktkj+vBPo+rOxpog7Czlfd42FkV+TEMZR2e
         lHh7eeAHJozDHcNvI2t7CbOouFS/QKkgnYpbkOVDm2etwVjH8vNvN3ijCwAPdCN9CgAL
         jKfBxWyx5pLq2PH9UBLyS9IQwObqQqi3auuQRZAirTmGwfdEym62AJmgmggBbtGePp1W
         vN/jmkjpAIEFytgWImTpPalrKwRYtRh1N2DiU+12PLGpjblMpU1ou/PerroTB7VlSXvZ
         22rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfOuUBo85WR0ru+OZ9vCbVy6pqMJNH141NsoPZ9iuzU=;
        b=XIvnvcMAq0T5q/wrhJ2uJVqoZkrTmRDq+xaf+tmytx/vMAC/cY8ph8gER4+gQkGnCT
         /AAmxAiEE+7fTIBVh54V4Sa0jz+4iNu3gOyVkSxez+VJe2Z8qPchaXuIaB/1WUHb1ceP
         66itgiJOK++cJ5HvOTm1gILIpkau7WUZ5d7R0Czj3WAx5/uMGLM4ti+IoRfJshDPOvyS
         qpvLwjbslrtPfdXYDUFc4Pzk0ZMjL2hlOoXfVQ2f9NWW1PHCPptOXDdrA11bYxanSgAn
         tURi5zi9jsgVztTDsNCD6ksu9yTfp/Xs34yOPoYCC4n6g6E5zsetNndn9tfVGpSTtdUG
         amlQ==
X-Gm-Message-State: AOAM531ZpXmGyvxH1cp644WwCL14Vnp7EthkMPdQijKWeRgvC8p/G7n2
        GbjvNQbZEamByHns1FWBZ9GeC+O2Nb2qivVg7VJNjg==
X-Google-Smtp-Source: ABdhPJzZtMmIKpcAsTy1AEu98Zzs8vVyBVsxshLo15ayhRFMzjm0Fhtnzr+4KvTUzMrwGoRbfL/7ds3WWEPCw+QAQmk=
X-Received: by 2002:a2e:3004:0:b0:223:c126:5d1a with SMTP id
 w4-20020a2e3004000000b00223c1265d1amr19404530ljw.408.1647972449253; Tue, 22
 Mar 2022 11:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-3-ammarfaizi2@gnuweeb.org> <CAKwvOdkEwkzT0uf9a5SokCScDTY4gbhNFZ+fLxsti9innaEZRQ@mail.gmail.com>
 <20220322172550.GL10306@1wt.eu> <CAKwvOdmr6u-zNynUDAg4pmwerQFUkG+eD0QhpzDED9eg+U2pfA@mail.gmail.com>
 <20220322175816.GN10306@1wt.eu>
In-Reply-To: <20220322175816.GN10306@1wt.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Mar 2022 11:07:17 -0700
Message-ID: <CAKwvOd=LvBL4NTUWMc0rJ-3K+MU5rv-p+j2pfbuseGdiA2ccJw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/8] tools/nolibc: Remove .global _start from the
 entry point code
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:58 AM Willy Tarreau <w@1wt.eu> wrote:
>
> On Tue, Mar 22, 2022 at 10:30:53AM -0700, Nick Desaulniers wrote:
> > On Tue, Mar 22, 2022 at 10:25 AM Willy Tarreau <w@1wt.eu> wrote:
> > > The purpose is clearly *not* to implement a libc, but to have
> > > something very lightweight that allows to compile trivial programs. A good
> > > example of this is tools/testing/selftests/rcutorture/bin/mkinitrd.sh. I'm
> > > personally using a tiny pre-init shell that I always package with my
> > > kernels and that builds with them [1]. It will never do big things but
> > > the balance between ease of use and coding effort is pretty good in my
> > > experience. And I'm also careful not to make it complicated to use nor
> > > to maintain, pragmatism is important and the effort should remain on the
> > > program developer if some arbitration is needed.
> >
> > Neat, I bet that helps generate very small initrd! Got any quick size
> > measurements?
>
> Yep:
>
> First, the usual static printf("hello world!\n"):
>
>   $ ll hello-*libc
>   -rwxrwxr-x 1 willy dev 719232 Mar 22 18:50 hello-glibc*
>   -rwxrwxr-x 1 willy dev   1248 Mar 22 18:51 hello-nolibc*

! What! Are those both statically linked?

> This one supports ~30-40 simple commands (mount/unmount, mknod, ls, ln),
> a tar extractor, multi-level braces, and boolean expression evaluation,
> variable expansion, and a config file parser to script all this. The code
> is 20 years old and is really ugly (even uglier than you think). But that
> gives an idea. 20 years ago the init was much simpler and 800 bytes (my
> constraint was for single floppies containing kernel+rootfs) and strings
> were manually merged by tails and put in .text to drop .rodata.

Oh, so nolibc has been around for a while then?

ld.lld will do string merging in that fashion at -O2 (the linker can
accept and optimization level).  I did have a kernel patch for that
somewhere, need to update it for CC_OPTIMIZE_FOR_SIZE...

I guess the tradeoff with strings in .text is that now the strings
themselves are r+x and not just r?

>
> You'll also note that there's 0 data segment above. That used to be
> convenient to further shrink programs, but these days given how linkers
> arrange segments by permissions that doesn't save as much as it used to,
> and it's likely that at some points I'll assume that there must be some
> variables by default (errno, environ, etc) and that we'll accept to invest
> a few extra tens of bytes by default for more convenience.

Thanks for the measurements.
-- 
Thanks,
~Nick Desaulniers
