Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE69053657C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbiE0P6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354031AbiE0P5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:57:24 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366E1E15D4;
        Fri, 27 May 2022 08:57:11 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24RFuqOk028702;
        Sat, 28 May 2022 00:56:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24RFuqOk028702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653667013;
        bh=PA6XyD/D6HG8M6irseqU8qzIX5vvd3VEI+LGWM7fjiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kSOCR3gCFab/jTHmTELXTDXk+hGIuZptGJR+5pX1I/A0NThoIE4FDEMrlzijbmwly
         YUbo5AUSJyMBCZE5HJHZsuadQ6t7k9Se1/nDZlPYKAk4ODE2/GQRTZyAT6IruVLv4b
         oIpnTF7vY4/HcK0Ddpboj87+0IeNxq+H9+GFprhUO52I29OXaUHYLK4j5NsAUNqzXS
         7pnDjwyv4XRf6788QVKIaC4Tr9jaDlg6sckk+KFqEBiz79uN7IM3GHtZbGXixDout9
         TOJN20m+85FwmJT0sdsdHK+tO7+u6zm0r2hX2mIp3vrRntRLLMYJJGTHQZ7M7qZMWO
         w/mMgFAYfaVAQ==
X-Nifty-SrcIP: [209.85.216.54]
Received: by mail-pj1-f54.google.com with SMTP id qe5-20020a17090b4f8500b001e26126abccso2689657pjb.0;
        Fri, 27 May 2022 08:56:52 -0700 (PDT)
X-Gm-Message-State: AOAM531d+97GMMYerrc7Rk9VAin5P82P+a4atmWFgmrq/QDT5eOxRRAy
        3/8SUAm4rWTyR+xLtINJeVdDWXfv4pldRcs+PcA=
X-Google-Smtp-Source: ABdhPJyzgbwKouLhue0pWOSkA4y536KbEctvagZNS0aJMMSJDL2D422HSRK7IZlnsKLwOTFSJDRTZS25B630WBPZWaw=
X-Received: by 2002:a17:902:f68f:b0:162:23c6:e61b with SMTP id
 l15-20020a170902f68f00b0016223c6e61bmr26055413plg.136.1653667012039; Fri, 27
 May 2022 08:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220527143931.2161635-1-masahiroy@kernel.org> <133bcb8b-2321-6acb-ea2d-3ab82af19dcb@gmx.de>
In-Reply-To: <133bcb8b-2321-6acb-ea2d-3ab82af19dcb@gmx.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 28 May 2022 00:55:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNATYbNzfZSOMz02ToE-dN1Bcck0qGWTHHcB-ask49JnAgA@mail.gmail.com>
Message-ID: <CAK7LNATYbNzfZSOMz02ToE-dN1Bcck0qGWTHHcB-ask49JnAgA@mail.gmail.com>
Subject: Re: [PATCH] parisc: fix the exit status of arch/parisc/nm
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 12:32 AM Helge Deller <deller@gmx.de> wrote:
>
> On 5/27/22 16:39, Masahiro Yamada wrote:
> > Parisc overrides 'nm' with a shell script. I was hit by a false-positive
> > error of $(NM) because this script returns the exit code of grep instead
> > of ${CROSS_COMPILE}nm. (grep exits with 1 if no lines were selected)
> >
> > I tried to fix it, but in the code review, Helge suggested to remove it
> > entirely. [1]
> >
> > This script was added in 2003. [2]
> >
> > Presumably, it was a workaround for old toolchains (but even the parisc
> > maintainer does not know the detail any more).
> >
> > Hopefully recent tools should work fine.
> >
> > [1]: https://lore.kernel.org/all/1c12cd26-d8aa-4498-f4c0-29478b9578fe@gmx.de/
> > [2]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=36eaa6e4c0e0b6950136b956b72fd08155b92ca3
> >
> > Suggested-by: Helge Deller <deller@gmx.de>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Acked-by: Helge Deller <deller@gmx.de>
>
> Thank you!
> Helge
>


I just forgot to change the patch subject.

I changed it to

"parisc: remove arch/parisc/nm"

Applied to linux-kbuild.
Thanks for the ack.



-- 
Best Regards
Masahiro Yamada
