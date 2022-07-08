Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9256BF80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbiGHQoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbiGHQoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:44:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E51E005
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:44:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y4so14157487edc.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dL+vZj8mZxlz+YJk30etzqurukOsDjVsMP7TniTfED4=;
        b=DiTY8LvFLkKbw7nF8Oernoz2oFyfF2cwrOrbnr7BMJbtgvs/GXRIg+mRuSv8faM61M
         D/G+Imrxv+cKLW84NOPfmMPLZLs6R/l0hPdnLoWtmHQjw1Qrk4NoyI5Uj6VHTQaONL+j
         d3jjqcAo1smNH2sriBLo7GDF/HwYYUtMEHjnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dL+vZj8mZxlz+YJk30etzqurukOsDjVsMP7TniTfED4=;
        b=O41XqIqtxvFasBXzhxClTiHQE26fHKfVSro7a7tyTVsbiWO9UiyPz/jT5Q6uLaNW9K
         uuucZaYwypgsaTj/oIfLqsTGj+rJOjXw2xVAxpgotwxSNSbzs7cm0WJdAED7V+7Hompf
         83B5iifuRCof3pTr0UseZE1qYIpYORMNmSINBds7z6pmTM2QdK0ZFJyKmxe9qSN3L3Ph
         agUyaUQPkBAgzvym+RTV1d8eS5/PBh62jMfd1ZJbuY/o6/67KrCcPypyZHJuwferE3A/
         HKIn9ND8Xuwg9hUK2NhAsg0EC1GUWnqULfzWMnFzzERIZhbzSInQh+RokVBwdecN+6dk
         r5tQ==
X-Gm-Message-State: AJIora/pv2xf+NcA525umKVKrjLWJDIyaSP326qFi6TpE0/VbCC9sGVp
        S8oLsAQZpeb1ljxDwkwQTqmO+poIRF68UV/S
X-Google-Smtp-Source: AGRyM1vEjHyJmQcLjVfw55TV+sAoO9rr1xP+O9ybNJ10xxcAcWy29VgapE9UXkSFkJ+10QeOP1JxsA==
X-Received: by 2002:a50:fa91:0:b0:43a:4f13:4767 with SMTP id w17-20020a50fa91000000b0043a4f134767mr6015846edr.10.1657298661529;
        Fri, 08 Jul 2022 09:44:21 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id j8-20020aa7c0c8000000b0043a9144d8ecsm4973144edp.71.2022.07.08.09.44.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 09:44:20 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id o4so31300705wrh.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 09:44:20 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr4255799wrr.617.1657298660044; Fri, 08
 Jul 2022 09:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220511060521.465744-1-sumit.garg@linaro.org>
 <CAD=FV=WXoDvWuH=yjzCcqOZ5CeUtYun7C8zrtrBP4FC409GkqA@mail.gmail.com> <20220708163134.GB6286@willie-the-truck>
In-Reply-To: <20220708163134.GB6286@willie-the-truck>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 8 Jul 2022 09:44:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UNEwP2FLOxW-OBJ0cQq9D+wr3AAERsOXBu-W7P6tYocQ@mail.gmail.com>
Message-ID: <CAD=FV=UNEwP2FLOxW-OBJ0cQq9D+wr3AAERsOXBu-W7P6tYocQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64: Fix pending single-step debugging issues
To:     Will Deacon <will@kernel.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 8, 2022 at 9:31 AM Will Deacon <will@kernel.org> wrote:
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

Excellent, thanks!


> The bad news is that I'm nowhere done and about to disappear on holiday
> for a week!

No worries. It's been broken for so many years and isn't the most
urgent thing, but it's also one of those things that I do eventually
want to get fixed so I just want to make sure it doesn't get put off
indefinitely...


> But anyway, I might be able to give this a review when I'm back. Failing
> that, I wonder if enough of us have a little bit of time each that we
> could hack on an agreed design together which covers the debug exception
> behaviour beyond kgdb?

If it will unblock this then I can figure out how to make time for it.
Definitely my biggest utility would be in testing, but I'm also happy
to knock around ideas. ...and as per above if the way to move forward
is to block off a day or two to learn more about all the status bits
and how they interact in the kernel then I can do that too. Barring
unforeseen circumstances I'll also be in Dublin in September if that's
somehow useful. ;-)

-Doug
