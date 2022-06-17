Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E5254FDBA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiFQTeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241748AbiFQTeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:34:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D97E57B31;
        Fri, 17 Jun 2022 12:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC4C6CE2CE5;
        Fri, 17 Jun 2022 19:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9133AC3411B;
        Fri, 17 Jun 2022 19:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655494444;
        bh=iGbceJbT8v7gImOkGLsLLbOe6rqxDg6MXNzjf6wMTlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tr+mboi+5Q+1X6yERhmLUcPCoKaCo2o6pwAJtIXvNbyRKoH1Mod1CV/k3UuHSbkZN
         01Ba15USpGkIWGRvKxhJ+uMDiOi99sn/Kue56xTqG75aGZCUQ/cToelqXwODW3X97a
         cBlpvobQr+WUDkIQzx1+UDWNWZ+w2I4ssLbOZu2ExfQTS4+ft2ONW3AiZnOJ5QzEqS
         zrZxyEo2qgO5l4Hannpw80+3uFH09mROeN1NoQrt57yxi/foSc02I3dFtngtGFrHXu
         br2oUouVBfjvg2ifOBWoyd22GXPsUkcZKeDqRMs/aqa0tvEa/vr+MFhWN3EVLnx43F
         FLqHMWGpnrPbw==
Date:   Fri, 17 Jun 2022 12:34:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
Message-ID: <YqzXKaaWRNP9C4b0@dev-arch.thelio-3990X>
References: <20220616104541.16289-1-jslaby@suse.cz>
 <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
 <CA+icZUV6bM2_jxyROK5B4XRid6fv8oX6YYNEdHUX8e_1OAdQYA@mail.gmail.com>
 <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com>
 <CAKwvOdmb5xdF70TzNp=4STCpzkGh16FnuKE1KbdzDhHt=OuRFA@mail.gmail.com>
 <CA+icZUWZKGEQ_VbnRL03SRAicEMi4r4J0dLRgXJgHvRg7DBM7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUWZKGEQ_VbnRL03SRAicEMi4r4J0dLRgXJgHvRg7DBM7A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 07:50:58PM +0200, Sedat Dilek wrote:
> On Fri, Jun 17, 2022 at 6:32 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Jun 17, 2022 at 3:35 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Fri, Jun 17, 2022 at 12:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 16, 2022 at 4:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wrote:
> > > > > >
> > > > > > Until the link-vmlinux.sh split (cf. the commit below), the linker was
> > > > > > run with jobserver set in MAKEFLAGS. After the split, the command in
> > > > > > Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
> > > > > > is lost.
> > > > > >
> > > > > > Restore it as linkers working in parallel (esp. the LTO ones) make a use
> > > > > > of it.
> >
> > TBH, I agree with Masahiro. I didn't understand this comment "esp. the
> > LTO ones."  Jiri, can you clarify what you mean here?
> >
> > > [ CC Nathan and Sami ]
> > >
> > > I re-checked as my build-time takes approx. 15mins more than usual
> > > with Linux v5.17.
> > >
> > > [ Perf - seconds time elapsed ]
> > > v5.17: approx. 12500
> > > v5.19: approx. 13500
> > >
> > > +1.000 secs = +16,67mins

So roughly 7.5% increase if I did my math correctly?

> > Does this patch make a difference?
> > https://lore.kernel.org/linux-kbuild/20220616195759.3214538-1-samitolvanen@google.com/
> >
> 
> Running a new build...

I did a quick benchmark with Fedora's clang 14.0.0 and I didn't see an
increase of that proportion with your configuration (only about 1%,
which I would expect would be within the noise for new drivers and
such):

Benchmark 1: 5.17
  Time (abs ≡):        287.744 s               [User: 23497.818 s, System: 4444.602 s]

Benchmark 2: 5.19-rc2
  Time (abs ≡):        290.027 s               [User: 24567.290 s, System: 4834.458 s]

Summary
  '5.17' ran
    1.01 times faster than '5.19-rc2'

Not to say that there is not an issue but it might be more visible with
slower hardware.

Cheers,
Nathan
