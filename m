Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB3F4F996F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiDHPaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbiDHPaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:30:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B8110C53D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:28:15 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 17so11970711lji.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K2IauWY4j4S877ahR/vQIQuOqpMFWHocXV+o9eQuTEk=;
        b=lqZITmKiT+C/NLCwnMmEETtXUsHoMvUrXEgjGe1trko++PcRtcP2x71ZWngk3A9qVJ
         GtxEA4vc/tTyYTybakjMhq5p+QQhdu/EBN2rPjR7kB+ndIJbUsKXD71UQU1gXHu7d2nk
         oujm0ANKW+j7/Jmcs3AqJ5bbw+5VJpXXX7s3D23yzGvdRTgaULE5xh4viLRTdVsd8uTk
         ft87kvLAOlsAGYAw13SnImPmFsGm2mxHDCyX0z1V8QjOIy/TLbQr47jwODS+FFOg1Svl
         GJe6kERzsBFoPQS19xfJjtpWr1TBWxigdYtMPXIh4VeQzXJY/NCt2ucApxmnU5JBeUOW
         pOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K2IauWY4j4S877ahR/vQIQuOqpMFWHocXV+o9eQuTEk=;
        b=LqD8vk4gy+l3cQYDW5AADdtQSqsfNFatLWZ/X5FTB8gSVOHOOFYmI1YFZhZOSKwYfU
         EODCAJdlPC4tbeLVuhCA2fj8JpcB/3XBBYiB4Ct92Rrp84Iyg+cYrL7p7sQ9bBbMjSw8
         BL6UdJ8z/UkAjX3StMwi3K7TM0mTju3aDcfL9BI6tLIeNmdoa78EhIK+YzyoxObZtFbl
         pan94BosQDAuyVGqsp/EtaY+Xwf1ta3AxE4FyxitcLcySY3Uzzjjoo3lIgGTyOYDWa67
         s0fh9DJmiPXIC0AZDE5Me8a5ReUmn2aRevsFDBYBTepKP1N3jk7CrCqv5NNclU+GTj0a
         +VWQ==
X-Gm-Message-State: AOAM533YBfu7kWnW4VyLg2JNGA1eLu8OwtqAPc2ZmOAvpvUAUVFL2ugd
        katyk8MJa2u7N2gI5IYxtWdGQ3/GNiWT7wj4pj9vGrZaefY=
X-Google-Smtp-Source: ABdhPJwEhFCWnJxbnX9f/VLAvYTGBsLP+bArtXUb6d5gUexHwlJqrgPl7y1bXLPYlQbzPKdb7ZLkBg5KPR4+1SFyegI=
X-Received: by 2002:a2e:a7c1:0:b0:24b:51eb:e432 with SMTP id
 x1-20020a2ea7c1000000b0024b51ebe432mr1549163ljp.238.1649431693395; Fri, 08
 Apr 2022 08:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <d62431af-5ce4-3d8f-542f-df8e7a7faaf1@leemhuis.info>
In-Reply-To: <d62431af-5ce4-3d8f-542f-df8e7a7faaf1@leemhuis.info>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 8 Apr 2022 08:28:00 -0700
Message-ID: <CAHRSSEw5CBnCpXcowKKG5KzOoazecC6jDn+4_fd0Gp3+e9Yixw@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 3:27 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker.
>
> Todd, seems there is a regression that is caused by one of your Linux
> kernel changes:

Yes, it was reported a few days ago by the ChromeOS team. Already
looking into it.

>
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and all people that seemed to be relevant
> here. To quote from https://bugzilla.kernel.org/show_bug.cgi?id=3D215795 =
:
>
> >  quackdoctech@gmail.com 2022-04-02 19:56:29 UTC
> >
> > Created attachment 300686 [details]
> > Dmesg output cut to error
> >
> > Apologies if this should have been reported under Drivers where the sou=
rce is, selftests has it listed under filesystems so I chose here. Using Wa=
ydroid which is android run via LXC, on android 10 the bug comes when tryin=
g to use video playback. I know of issues on android 11 but have not yet ha=
d the chance to get the logs from it. the issue does not occur in Linux ker=
nel 5.16 series. but does occur on linux 5.17. the issue is confirmed on bo=
th Arch's linux-zen 5.17.1.zen1-1 kernel as well as some users reporting a =
fedora kernel with the issue.
> >
> > [reply] [=E2=88=92] Comment 1 quackdoctech@gmail.com 2022-04-03 19:38:3=
7 UTC
> >
> > I've narrowed down the issue to this patch series.
> >
> > https://lore.kernel.org/all/20211130185152.437403-1-tkjos@google.com/
> >
>
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?
>
> Anyway, to get this tracked:
>
> #regzbot introduced: v5.16..v5.17
> #regzbot from: quackdoctech@gmail.com <quackdoctech@gmail.com>
> #regzbot title: BinderFS: Kernel bug at binder.c:2352
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215795
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
>
> --
> Additional information about regzbot:
>
> If you want to know more about regzbot, check out its web-interface, the
> getting start guide, and the references documentation:
>
> https://linux-regtracking.leemhuis.info/regzbot/
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
>
> The last two documents will explain how you can interact with regzbot
> yourself if your want to.
>
> Hint for reporters: when reporting a regression it's in your interest to
> CC the regression list and tell regzbot about the issue, as that ensures
> the regression makes it onto the radar of the Linux kernel's regression
> tracker -- that's in your interest, as it ensures your report won't fall
> through the cracks unnoticed.
>
> Hint for developers: you normally don't need to care about regzbot once
> it's involved. Fix the issue as you normally would, just remember to
> include 'Link:' tag in the patch descriptions pointing to all reports
> about the issue. This has been expected from developers even before
> regzbot showed up for reasons explained in
> 'Documentation/process/submitting-patches.rst' and
> 'Documentation/process/5.Posting.rst'.
