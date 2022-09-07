Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005825AFB04
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIGEPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIGEPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:15:13 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133FB8274A;
        Tue,  6 Sep 2022 21:15:11 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2874Em80017335;
        Wed, 7 Sep 2022 13:14:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2874Em80017335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662524089;
        bh=0hTBLT8N18H/BI5SDUzZKCK5eLhcJNLu+ZRFya2Xhg8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jcefueL0JvqinQJe5NOVxG01SEwbq3bwWY/zq0BoaN7T6h+bC3QJoxNANDud3/YTC
         IvLjMt14vtpAhyrU9Ub/nmdn0VjYgg4MTpJxpxY4cXIfo5Uceyrryejza+bl/uyY/Q
         vX7qCduKcLcDA6kG3rh9L2+r3z4eqwneZNnP/9sWu6mfP9H29W2GywFC+VlPkxFb/d
         8P3Z+6MPXaxviL0KpGT7cwCvRGAEBnlJmYvUyFRIohXcygTo7JiTzeSIAGBkRwIgZi
         5xnPoxYk3L9WYXEqzE7yTlU4eIjC+NLEkjJb4SbTNS+0VP+FVzOPfPr6dcFN7+2jCe
         ywMd18PANee6A==
X-Nifty-SrcIP: [209.85.160.52]
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1225219ee46so33271572fac.2;
        Tue, 06 Sep 2022 21:14:49 -0700 (PDT)
X-Gm-Message-State: ACgBeo1QRjjTYSn1ZONMa1GOPs832aqKPhIJ7OpOOs7DepofoFThBayG
        gGLOyUzIHy71z+Y0AqxfjXJgKoJ0zpGw8pMU0fc=
X-Google-Smtp-Source: AA6agR4dMRG833gu29zjUBYVXOLf9kiGqLu3V7VD2BEjRI3GOvYDJ2evaD1DM7vJ7ecszrkPYMrJQcXRuxhD4RzH+sU=
X-Received: by 2002:a05:6808:90a:b0:34b:826c:6116 with SMTP id
 w10-20020a056808090a00b0034b826c6116mr5927986oih.194.1662524087917; Tue, 06
 Sep 2022 21:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220831184408.2778264-1-ndesaulniers@google.com>
 <20220831184408.2778264-3-ndesaulniers@google.com> <Yw+8QgtSbB2/3Eiq@dev-arch.thelio-3990X>
 <CAK7LNASQJ-B2kRGXea-dQt+1BgEsp_aLEPS_uJb1R6FSOj1Khg@mail.gmail.com> <YxdwbKA5ThYJcPBP@dev-arch.thelio-3990X>
In-Reply-To: <YxdwbKA5ThYJcPBP@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Sep 2022 13:14:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNASBAMRwGPH1gyt5JeBTVX3UkmC4DGkbjSxrwWFO+4+yEg@mail.gmail.com>
Message-ID: <CAK7LNASBAMRwGPH1gyt5JeBTVX3UkmC4DGkbjSxrwWFO+4+yEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] Makefile.compiler: Use KBUILD_AFLAGS for as-option
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Tom Rix <trix@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        X86 ML <x86@kernel.org>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 1:08 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Sep 05, 2022 at 06:09:28PM +0900, Masahiro Yamada wrote:
> > On Thu, Sep 1, 2022 at 4:53 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Wed, Aug 31, 2022 at 11:44:05AM -0700, Nick Desaulniers wrote:
> > > > as-instr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS.  This can
> > > > cause as-option to fail unexpectedly because clang will emit
> > > > -Werror,-Wunused-command-line-argument for various -m and -f flags for
> > > > assembler sources.
> > >
> > > Now that I am looking closer at it, where does that '-Werror' come from?
> >
> > The related commit is
> > c3f0d0bc5b01ad90c45276952802455750444b4f
> >
> > The previous discussion with Arnd is
> > https://lore.kernel.org/linux-kbuild/20170314213724.3836900-1-arnd@arndb.de/
>
> Right, although this is for cc-option, not as-option, no?



Sorry, I misunderstood your comments.
My reference is about -Werror in cc-option. It is unrelated to as-option.



You are right.
Currently, as-option takes KBUILD_CFLAGS instead of KBUILD_AFLAGS.

The '-Werror,' of -Werror,-Wunused-command-line-argument
presumably came from CONFIG_WERROR.





-- 
Best Regards
Masahiro Yamada
