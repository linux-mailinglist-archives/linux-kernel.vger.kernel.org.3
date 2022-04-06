Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BE24F6877
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbiDFRnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbiDFRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:42:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348BC33B01F;
        Wed,  6 Apr 2022 08:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E7D61CF5;
        Wed,  6 Apr 2022 15:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308D0C385AC;
        Wed,  6 Apr 2022 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649260337;
        bh=tAGDiffASCPLzAGh0QMeMOX8y+VFM4qhhes4PoMGJPk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PVSieYNeih4eKJw7FsmLdj4sc9BCMwSz+NKreIZNs3emrlljOYXXGwVKSbmuKx2dL
         TwBw8JGiPpBs7fWbrFSwgVvEHPqQzCrHGyOgrU8Rewpsbh1ZfWRSeXG7zM3Czut2d6
         tOOg+ssu440PGPHy8TZcU3EbQmtPDAliAJGJs2UvpP0Xc/YxtRenAw7LRYyb9TBLHx
         17fOzQbOY6LwtOHydQMbfcRyTYwiF0578/fI1T+qkrwF85N6JM83MgrEeuUN4Qp2Th
         84gyIYUWs8jXRB68nbzIWG2+JtplKIDKa0q1K4KVQBH5zUzTrtvu9kHEWl/wdPaUPK
         czdiRbVN5a/mA==
Received: by mail-wr1-f44.google.com with SMTP id j12so3894714wrb.5;
        Wed, 06 Apr 2022 08:52:17 -0700 (PDT)
X-Gm-Message-State: AOAM532n5S4U6qBzPgcs4G/nQ+gMUEVASbvyD8Z8RnZLVl3uQ35LZ0TK
        GhW76dcc3w+VncMRIjURLWxtE1ayUStxKifgcjc=
X-Google-Smtp-Source: ABdhPJxuQVZDOXTwHfHUhN6rYr9chzDHoRUTmEEWMvLzUT41VlgfbbHjcXqIC5wmAwO16H4vhKyYXMITJkCMs99y5Hg=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr7309154wrh.407.1649260335398; Wed, 06
 Apr 2022 08:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220316183708.1505846-1-arnd@kernel.org> <20220316183708.1505846-2-arnd@kernel.org>
 <Yk2TwyteFgeqkZE1@orome>
In-Reply-To: <Yk2TwyteFgeqkZE1@orome>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 6 Apr 2022 17:51:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3AdgMbAtf9SmrjXo61j=bAB3jxytJ6TALRid+ykdRtPw@mail.gmail.com>
Message-ID: <CAK8P3a3AdgMbAtf9SmrjXo61j=bAB3jxytJ6TALRid+ykdRtPw@mail.gmail.com>
Subject: Re: [PATCH] drm/tegra: vic: fix unused-function warnings
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 3:21 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Wed, Mar 16, 2022 at 07:36:47PM +0100, Arnd Bergmann wrote:
> >  static const struct dev_pm_ops vic_pm_ops = {
> > -     SET_RUNTIME_PM_OPS(vic_runtime_suspend, vic_runtime_resume, NULL)
> > -     SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > -                             pm_runtime_force_resume)
> > +     RUNTIME_PM_OPS(vic_runtime_suspend, vic_runtime_resume, NULL)
> > +     SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> >  };
> >
> >  struct platform_driver tegra_vic_driver = {
>
> Hi Arnd,
>
> is this a replacement for __maybe_unused annotations that we would
> typically use to address these? Is the ternary operator in PTR_IF enough
> to eliminate the warning? Does that work the same way for structure
> definitions as it does for conditionals where we use IS_ENABLED() to use
> the compiler's DCE for improved coverage?

Yes to all three.

> It looks like it, but just making sure because there's another patch
> that fixes this warning by adding __maybe_unused.

I sent a lot of patches in the past to add __maybe_unused, but this was
mainly because we could never come up with a good replacement.
Paul Cercueil has finally come up with a good solution, so this is how
we should do it from now on.

        Arnd
