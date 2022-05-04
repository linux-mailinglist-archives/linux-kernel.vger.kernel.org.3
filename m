Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1931851A38A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352103AbiEDPVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352074AbiEDPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:21:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1424C36E26
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:17:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x33so2918678lfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 08:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ON3l4VmfZTG6tfwh+lXTECz7xGtbdAVvVE9pqJrPtBU=;
        b=J2SSXllFqS1rJDj7D1UO39D19e0lq8vqwXrRiHfahcSGqgbVPU0EW3OLFTSV0kZyw4
         n4wRz06XtabBNEHttqGQyC/+ZbbXMbv3ml2MaaPbP0Hjy7f3gy+C/yPNc97VFn5oTvxr
         uNhfKBUqXoNR4nI9ktONtligR2UzOGlgTKfJFFT59eHZND01Hm6OFtxK7SCs9N1NJPe9
         RY1qXdckssbDIO8n9IOurAWo+9zlCdGRwb4IDboOTWSr6iBBCQPg9g2im/cRpr9BHH/1
         jWzxLeBK+I0PXma6RoK3U9+ySNujPb+4j8KNW/eHJFaZK/NAuG1BHYNSxrX7ccd51jY4
         SJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ON3l4VmfZTG6tfwh+lXTECz7xGtbdAVvVE9pqJrPtBU=;
        b=SQ5ogo4aeg6215sL4F088HWzhdtzRdPSYu0q6K7bqkDf3Stk3H5hvi+EvuO+fuSQMh
         ha8/QK45oFIOotmO8A1LxIGQZzTjSzReB2D8IqLijMcubvQltUz6+Y4IUyn9BrERGN/o
         v+SiHx1Q6Hwo59/7U+tUMIv8ccmgaKWtbJkGtMjuGRlTpUga35myqUXQo9+3fZebGhIj
         FYF+yca/qr79BFFdUpmH9eM29BXFCf6UbMN6h6ia5ufBz7mAZlVIgfASIbX54683sr0s
         ppaCYh3shL9EzaLkDLLSw9AunpfSzTa0QO6BH7uIfLqRzEa9JUOKphsz6UvmUY0wZ//3
         BW9A==
X-Gm-Message-State: AOAM5321S9Xf9T5IUtVu4x0VhOG2ILnO2wpEpaTXVjNo8nTEnFNIAff7
        b1vw4u5nWkDFWBfGk2ZNZbgozegewKuy7RC+3R9uGA==
X-Google-Smtp-Source: ABdhPJwVVFpZrp63qehiOaApGMb7R3PSPk3Y0CqHNyMQMAWHboLPGnr21On/mQGhundTtGQK1k6X5wdFojmyk8m8nNA=
X-Received: by 2002:a05:6512:3b87:b0:473:9e36:5f0d with SMTP id
 g7-20020a0565123b8700b004739e365f0dmr8663687lfv.424.1651677448063; Wed, 04
 May 2022 08:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <d62431af-5ce4-3d8f-542f-df8e7a7faaf1@leemhuis.info>
 <CAHRSSEw5CBnCpXcowKKG5KzOoazecC6jDn+4_fd0Gp3+e9Yixw@mail.gmail.com> <f42e91ae-a22d-b664-003a-e1698dc021aa@leemhuis.info>
In-Reply-To: <f42e91ae-a22d-b664-003a-e1698dc021aa@leemhuis.info>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 4 May 2022 08:17:16 -0700
Message-ID: <CAHRSSEyVc0pNwp23Tu2SH3ti0aKfTw+XRrHTuSkMjoCe7huHyA@mail.gmail.com>
Subject: Re: Regression in BinderFS: Kernel bug at binder.c:2352
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "quackdoctech@gmail.com" <quackdoctech@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 4, 2022 at 3:47 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
>
>
> On 08.04.22 17:28, Todd Kjos wrote:
> > On Fri, Apr 8, 2022 at 3:27 AM Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >>
> >> Hi, this is your Linux kernel regression tracker.
> >>
> >> Todd, seems there is a regression that is caused by one of your Linux
> >> kernel changes:
> >
> > Yes, it was reported a few days ago by the ChromeOS team. Already
> > looking into it.
>
> What happen to this? It looks like it has fallen through the cracks. Or
> was progress made and it just didn't link to the ticket or mention the
> reporter?

It was found and fixed independently by Alessandro Astone in
https://lore.kernel.org/lkml/20220415120015.52684-2-ales.astone@gmail.com/

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
>
> #regzbot poke
>
> >> I noticed a regression report in bugzilla.kernel.org that afaics nobod=
y
> >> acted upon since it was reported about a week ago, that's why I decide=
d
> >> to forward it to the lists and all people that seemed to be relevant
> >> here. To quote from https://bugzilla.kernel.org/show_bug.cgi?id=3D2157=
95 :
> >>
> >>>  quackdoctech@gmail.com 2022-04-02 19:56:29 UTC
> >>>
> >>> Created attachment 300686 [details]
> >>> Dmesg output cut to error
> >>>
> >>> Apologies if this should have been reported under Drivers where the s=
ource is, selftests has it listed under filesystems so I chose here. Using =
Waydroid which is android run via LXC, on android 10 the bug comes when try=
ing to use video playback. I know of issues on android 11 but have not yet =
had the chance to get the logs from it. the issue does not occur in Linux k=
ernel 5.16 series. but does occur on linux 5.17. the issue is confirmed on =
both Arch's linux-zen 5.17.1.zen1-1 kernel as well as some users reporting =
a fedora kernel with the issue.
> >>>
> >>> [reply] [=E2=88=92] Comment 1 quackdoctech@gmail.com 2022-04-03 19:38=
:37 UTC
> >>>
> >>> I've narrowed down the issue to this patch series.
> >>>
> >>> https://lore.kernel.org/all/20211130185152.437403-1-tkjos@google.com/
> >>>
> >>
> >> Could somebody take a look into this? Or was this discussed somewhere
> >> else already? Or even fixed?
> >>
> >> Anyway, to get this tracked:
> >>
> >> #regzbot introduced: v5.16..v5.17
> >> #regzbot from: quackdoctech@gmail.com <quackdoctech@gmail.com>
> >> #regzbot title: BinderFS: Kernel bug at binder.c:2352
> >> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215795
> >>
> >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' ha=
t)
> >>
> >> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> >> reports on my table. I can only look briefly into most of them and lac=
k
> >> knowledge about most of the areas they concern. I thus unfortunately
> >> will sometimes get things wrong or miss something important. I hope
> >> that's not the case here; if you think it is, don't hesitate to tell m=
e
> >> in a public reply, it's in everyone's interest to set the public recor=
d
> >> straight.
> >>
> >> --
> >> Additional information about regzbot:
> >>
> >> If you want to know more about regzbot, check out its web-interface, t=
he
> >> getting start guide, and the references documentation:
> >>
> >> https://linux-regtracking.leemhuis.info/regzbot/
> >> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
> >> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
> >>
> >> The last two documents will explain how you can interact with regzbot
> >> yourself if your want to.
> >>
> >> Hint for reporters: when reporting a regression it's in your interest =
to
> >> CC the regression list and tell regzbot about the issue, as that ensur=
es
> >> the regression makes it onto the radar of the Linux kernel's regressio=
n
> >> tracker -- that's in your interest, as it ensures your report won't fa=
ll
> >> through the cracks unnoticed.
> >>
> >> Hint for developers: you normally don't need to care about regzbot onc=
e
> >> it's involved. Fix the issue as you normally would, just remember to
> >> include 'Link:' tag in the patch descriptions pointing to all reports
> >> about the issue. This has been expected from developers even before
> >> regzbot showed up for reasons explained in
> >> 'Documentation/process/submitting-patches.rst' and
> >> 'Documentation/process/5.Posting.rst'.
> >
> >
