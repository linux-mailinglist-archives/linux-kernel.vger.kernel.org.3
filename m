Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21847570349
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiGKMst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiGKMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:48:42 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C265E0AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:48:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 145so4616141pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJocOm+WQm8JeoaTDLF9QVAn6Yxo6as7VtmcJ5sIzIg=;
        b=lVrLbWT8SKQjAOicPujVtFIM7vw3vlUdViH8lqPwlF4T6FLdTUxvkt+hJ2QNC/PSWC
         lFdIxksoH+pGTCrg2JGNoAdDPdMbjcpl1ZCio5G1XLLvv85sGXj3NSDXj5cyl0OOmS3f
         XIfv74LfoxC766Q7JmSsBdVSC2Pz28OzBocM4rSPt8GRbgB1gIDp5+fqGENHptIJr1sn
         HfEZTlywqD4nPBA4Yp884WGj5ZAGCqUGpLfHuhQ0LmfPwoP+0ojb4/j9xatz6GV1KoNe
         QBLMXiNG8ronkh8pEfwmx4fo4861OiFyURFC+4zEMnmGDbbNvPgpN+gY3WsuQSE2oHrr
         lIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJocOm+WQm8JeoaTDLF9QVAn6Yxo6as7VtmcJ5sIzIg=;
        b=sEyJZFFdvYitmoIGtv2adPgt0E0eWNCbX/euHcMmEAte6rKVgIQILatpFxuOj8BDXE
         Tr0XBVLZymldAQou3IG/+17R/HogBIPiJSxMmk1NHvOEdW0TmAb0+j4R+BxjZGquM5LD
         6p6skenSBnruCjoLhykV359ZeML4EB6YsEtBH9Z5f9R2ojkC/1TDqn+B7DYo0YQQAB+J
         1G5sBMZVHDBFWbpYfHc97/C5mysOWbwas0cvSE2/uhdT1GXbuM1gGhN2HAxG73SB/vy8
         zSTgdMxxJiJCp9eXqxqF7FkmjrwV7ujcWjpLduAzCc1Xna3TlHCkHHTyBJMK4ZYYLrEr
         ukYQ==
X-Gm-Message-State: AJIora+z+iJtoW/qXGGvwLbPJRATnyO8y+mGXmKXdEbQ6WsQj0al3w/c
        8DfNL/DppQYm+HMSqH/WWUXjKPzYslo1rTALaZjbsw==
X-Google-Smtp-Source: AGRyM1tHEvkhScpSf4EDIQX5WvCWKxCPMiY/TD3iFu5r3C8Uikk8R+vTBwI73vjenBQ8dn3otzcV49NF5Y7iq6wI3II=
X-Received: by 2002:a05:6a00:1701:b0:525:9f20:a78a with SMTP id
 h1-20020a056a00170100b005259f20a78amr18735285pfc.2.1657543720577; Mon, 11 Jul
 2022 05:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220511060521.465744-1-sumit.garg@linaro.org>
 <CAD=FV=WXoDvWuH=yjzCcqOZ5CeUtYun7C8zrtrBP4FC409GkqA@mail.gmail.com> <20220708163134.GB6286@willie-the-truck>
In-Reply-To: <20220708163134.GB6286@willie-the-truck>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 11 Jul 2022 18:18:29 +0530
Message-ID: <CAFA6WYNu=rJ=Vbs7TFFXzOh57ezum5FqFomCV8fLvAB02dxLug@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64: Fix pending single-step debugging issues
To:     Will Deacon <will@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, 8 Jul 2022 at 22:01, Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jul 01, 2022 at 03:14:16PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, May 10, 2022 at 11:05 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > This patch-set reworks pending fixes from Wei's series [1] to make
> > > single-step debugging via kgdb/kdb on arm64 work as expected. There was
> > > a prior discussion on ML [2] regarding if we should keep the interrupts
> > > enabled during single-stepping. So patch #1 follows suggestion from Will
> > > [3] to not disable interrupts during single stepping but rather skip
> > > single stepping within interrupt handler.
> > >
> > > [1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
> > > [2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
> > > [3] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/
> > >
> > > Changes in v3:
> > > - Reword commit descriptions as per Daniel's suggestions.
> > >
> > > Changes in v2:
> > > - Replace patch #1 to rather follow Will's suggestion.
> > >
> > > Sumit Garg (2):
> > >   arm64: entry: Skip single stepping into interrupt handlers
> > >   arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
> > >
> > >  arch/arm64/include/asm/debug-monitors.h |  1 +
> > >  arch/arm64/kernel/debug-monitors.c      |  5 +++++
> > >  arch/arm64/kernel/entry-common.c        | 18 +++++++++++++++++-
> > >  arch/arm64/kernel/kgdb.c                |  2 ++
> > >  4 files changed, 25 insertions(+), 1 deletion(-)
> >
> > Sorry it took so long for me to respond. I kept dreaming that I'd find
> > the time to really dig deep into this to understand it fully and I'm
> > finally giving up on it. I'm going to hope that Will and/or Catalin
> > knows this area of the code well and can give it a good review. If not
> > then I'll strive harder to make the time...
>
> So the good news is that I spent a couple of days on this last week.
>

Thanks for spending time to review this.

> The bad news is that I'm nowhere done and about to disappear on holiday
> for a week!
>
> But anyway, I might be able to give this a review when I'm back. Failing
> that, I wonder if enough of us have a little bit of time each that we
> could hack on an agreed design together which covers the debug exception
> behaviour beyond kgdb?

Sure I will be happy to contribute to improving overall debug
exception behaviour. I look forward to any further
comments/suggestions.

-Sumit

>
> Will
