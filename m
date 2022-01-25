Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C44349BB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiAYSsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiAYSrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:47:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF220C06173D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:47:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u24so19004371eds.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uo+vCG3Ml8SK02zUHmttXklj/h/GWPjRaG6auH+OtyU=;
        b=lmBZygBlggBGp5CARgDMs+T/0lc8uiiRV+DyC15Xjyuw1zivr0P+uzPfHHTpyv+WV+
         xNCGrSfnogVVV/yOSQI6exabKLIaqWOS/SvQCeguWrqy5LhZQcRSanvGZnsqPTcoigJw
         5gyQuK/zo1OClHE85S6WZUNbtWokHlnn9Gd7HuYD+LT8JQuTYPtheiEy3VlxJiYM1CMs
         dos+2kQpvjJltM9r+rfB+HUWBCHT+SyPyQC79kU1nAD6WMbAL00UvUstGOsYiemWX10K
         Z0Y+4/gJKtAI9leWKjYzFzqyHPPk0NJOF26Cf/6cKQF326Vh/800H8YF0NVPuneWB9XG
         autg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uo+vCG3Ml8SK02zUHmttXklj/h/GWPjRaG6auH+OtyU=;
        b=Bc3CzmH3vz1V4QbJNNLmqbgvIkMyHndOvYyeBabAAwtQ4P9/pwL7VVdtzguhFzhKDY
         Yyh55XoZrzDTt6p5zR2a7HFrhSPnlP/Jr916E4d/9rGFbVLXCa8A4SyCqZNMKtwrnPAl
         Hk4FKPlZjmhwJ3aloyvwOxPkx9K/IMjw5ALyFdjmMy06UjtDoU+lIMHFw5EoGaqsLMUx
         J3lZ1za/I9rztqyFNuK0xaHxn+0+IFhTGGCUppgxmzar+1B0InKRNTbBS7ao/jDpttvT
         yLoAQ3aVnTU9RM1HjraOU7617gWhSee+XxzX+f7Pd0Y7v6A+mZ2x+k0e1sPY7rEfA3Ew
         4ADA==
X-Gm-Message-State: AOAM530ZjJRW84XZ1QbYiXRubX6Y226MyJcRbLP9I1rsDEx1weYgYOJM
        lw2UoQXFD6qPOzxQzp5WLXjmSs4hM+qm/vF3gmOtRQ==
X-Google-Smtp-Source: ABdhPJw6TadSADBrMgWhQ86GN//sE7Pa07DOEUvazOlQK6ZSBxxnv6RcquqP7oVRETGx/lRADU6zfq6YgNtssHJvEWU=
X-Received: by 2002:a05:6402:1d50:: with SMTP id dz16mr11584952edb.108.1643136466485;
 Tue, 25 Jan 2022 10:47:46 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0RDZpLtWjMEU1QVWSjOoqRAH6QxQ+ZQnJc8LwaV7m+JQ@mail.gmail.com>
 <7e480da8-0d54-2d62-0a8e-184901c974b6@gmail.com> <ee2c92da-030c-b92f-0f41-1fdbbeed47c7@gmail.com>
 <CAOesGMgx99GJ3gQmdgauSs3aF8xr4FgcgsELRz4HSVXmujHJnQ@mail.gmail.com>
 <CAK8P3a3sBADt4Cu=LGbjHQpQ32O-BtFk1aQFwhL8Ar=M_gj6Xw@mail.gmail.com> <CAOesGMjArmB1J7KasjHZRTNXoZvtUXkTOQAyg5yd29qC8PeS9g@mail.gmail.com>
In-Reply-To: <CAOesGMjArmB1J7KasjHZRTNXoZvtUXkTOQAyg5yd29qC8PeS9g@mail.gmail.com>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Tue, 25 Jan 2022 12:47:35 -0600
Message-ID: <CAOCOHw43DC5P0p0U+C57JHo1YCicWA37y+gbEMEuJwsZB0NC=Q@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] SoC changes for 5.17
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:34 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Tue, Jan 4, 2022 at 5:40 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Jan 4, 2022 at 7:40 PM Olof Johansson <olof@lixom.net> wrote:
> > > On Tue, Jan 4, 2022 at 1:58 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > > > On 12/24/21 9:11 AM, Florian Fainelli wrote:
> > > > >
> > > > > Should I resend or fix something in those? Thanks!
> > > >
> > > >
> > > > Arnd, Olof, do I need to resend the 3 pull requests mentioned above?
> > > > Thanks and happy new year.
> > >
> > > I'm about to make a pass of merges, likely tomorrow -- I had to get my
> > > Honeycomb working again since it hosts all the trees and mailboxes for
> > > me.
> > >
> > > No need to resend at this time.
> >
> > It's possible that I had accidentally merged them in the end but tagged
> > the branch without those merge commits, so have a look if it's in there.
>
> Yeah, it looks like there were a few merges not part of the pull
> request (Linus just merged them, so these showed up in
> regen-contents). I'll fold them into arm/late.
>

It seems these (at the last the qcom ones) didn't make it into v5.17-rc1?

Are you planning to pick up the qcom patches for v5.18 or should I
just carry them and include them as I send my next PR?

Regards,
Bjorn

> arm/defconfig
>         broadcom/defconfig [sign: Y Arnd Bergmann <arnd@arndb.de>]
>                 https://github.com/Broadcom/stblinux
> tags/arm-soc/for-5.17/defconfig
>         broadcom/defconfig64 [sign: Y Arnd Bergmann <arnd@arndb.de>]
>                 https://github.com/Broadcom/stblinux
> tags/arm-soc/for-5.17/defconfig-arm64
>         qcom/defconfig [sign: N ]
>
> git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux
> tags/qcom-arm64-defconfig-for-5.17
>         patch
>                 ARM: multi_v7_defconfig: Enable drivers for
> DragonBoard 410c [sign: N ]
>
>
> -Olof
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
