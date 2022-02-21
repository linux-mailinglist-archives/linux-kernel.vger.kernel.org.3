Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA714BDDAB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbiBUPLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:11:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbiBUPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:11:19 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD119C35
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:10:56 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso13571866ooi.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FqzR6oBnVyWZpVXgExBeDkEEQMX3dcNeKkRrhE7ZC80=;
        b=LNjjOp0y/DzBP7YGsctUql22u4XZlAESbuc0iHz7luW9tdh8isYj00WZyuHU836EyK
         G/UwG1ZYQNSQUPnsgxNQGTZkqtbJESxgVqVDL+Mq/JHzRjlo41sXbd2Zh0EhlAbztZDA
         z1aEKBR9LI/knQ5lWHlFtOeWTSURmYjFInnbnLDvrl6GqwBS2k9JolFPH0aeG+qDl9N6
         HdOdES1p8ccuf79PxKMlNyX6p07MkL6tsgN9MQG+DiYY/cW9osDnXKmjSBmo+tLr7WjW
         Ir/0tq9t+l55QEVrnPQ8doJ+W60yBkAJ+OKNjvJQHU0OJEvIvddwvM+knfnSgHTm8G4Z
         vEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FqzR6oBnVyWZpVXgExBeDkEEQMX3dcNeKkRrhE7ZC80=;
        b=AbZlDOgmHLsXU/xxaVuBB1+hHvwlsO8flM2KWXtwjwYAvkDNamDNWcExFLz/iMz/VX
         semMKcbhsHLIkm81gK6Y6/86RYKwPSlXfiXY/xz2VgTqt8vysYul89by3AoeYbMuz2/k
         sHWPWXfr8YfQ6QLCfQFinwmRoGSyov3y9WjQ9YfEQuxbaAOq67YZVJJb+S3MscG+NrDM
         JC/L+Dy6WjuzH9VIOsSKORDrkLelECdKKPEbG1QLJUgAQaP4xezUGAL1v7jtZveEV6I4
         d+tHEiBZn2YUIAYDqCFVdfOk+kmQn47M+LIw+fkrpH0igjJIp8ejmHJicdhL/ZiK8wG+
         xCVQ==
X-Gm-Message-State: AOAM531F/hZU5n2HzqI3VHNMnbpMCIAyLxUKxBqvvpGte6wuhOmRb7Ql
        6ilkvSnS3k6V9ERT3ZgNKO5lbWSGciaeEp9LEEY=
X-Google-Smtp-Source: ABdhPJzGX0vF7yY1Dvoaf5ST+HkhACiDWK1f4xCVMLXmD0PTjt37HfUJM4Q+DbV4ceG9R4VQjoRBqmd9c2wxV7Rk9JE=
X-Received: by 2002:a05:6870:912c:b0:d3:44be:7256 with SMTP id
 o44-20020a056870912c00b000d344be7256mr8315333oae.73.1645456255486; Mon, 21
 Feb 2022 07:10:55 -0800 (PST)
MIME-Version: 1.0
References: <978944b7-4e71-475a-2fe6-c414d3e8f64e@leemhuis.info>
In-Reply-To: <978944b7-4e71-475a-2fe6-c414d3e8f64e@leemhuis.info>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Feb 2022 10:10:44 -0500
Message-ID: <CADnq5_OS2jT1eRjjMf_c1OkeEEd1CJa7_T+yBoOtNKrLnWduZw@mail.gmail.com>
Subject: Re: Bug 215600 - Radeon - *ERROR* Failed waiting for UVD message
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 3:30 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker.
>
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and all the relevant people. To quote
> https://bugzilla.kernel.org/show_bug.cgi?id=3D215600 :
>
> >  Richard Herbert 2022-02-12 22:13:07 UTC
> >
> > Created attachment 300445 [details]
> > Details
> >
> > When attempting to play some types of videos with VLC 3.0.16 (eg. *.flv=
, *.mp4), when running kernels 5.17-rc1 to 5.17-rc3, only the audio portion=
 is heard and the VLC video screen remains black. Meanwhile, many of these =
entries are written per second to /var/log/syslog:
> >
> > 2/12/22 3:41 PM       starbug kernel  [drm:radeon_uvd_cs_parse [radeon]=
] *ERROR* Failed waiting for UVD message (-1)!
> > 2/12/22 3:41 PM       starbug kernel  [drm:radeon_cs_ioctl [radeon]] *E=
RROR* Invalid command stream !
> > 2/12/22 3:41 PM       starbug kernel  [drm:radeon_uvd_cs_parse [radeon]=
] *ERROR* Failed waiting for UVD message (-1)!
> > 2/12/22 3:41 PM       starbug kernel  [drm:radeon_cs_ioctl [radeon]] *E=
RROR* Invalid command stream !
> > 2/12/22 3:41 PM       starbug kernel  [drm:radeon_uvd_cs_parse [radeon]=
] *ERROR* Failed waiting for UVD message (-1)!
> > 2/12/22 3:41 PM       starbug kernel  [drm:radeon_cs_ioctl [radeon]] *E=
RROR* Invalid command stream !
> >
> >
> > The problem doesn't occur in kernels of the 5.16 series.  It may have b=
een introduced here:
> >
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff=
/drivers/gpu/drm/radeon/radeon_uvd.c?id=3Dv5.16&id2=3Dv5.17-rc1
> >
> >
> > Thanks!
>
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?

This is a fix on the bug report.

Alex


>
> Anyway, to get this tracked:
>
> #regzbot introduced: v5.16..v5.17-rc1
> #regzbot from:  Richard Herbert <rherbert@sympatico.ca>
> #regzbot title: drm: radeon: no sound on video, *ERROR* Failed waiting
> for UVD message
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215600
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
