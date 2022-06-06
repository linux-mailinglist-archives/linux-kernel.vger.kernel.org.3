Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4992653EF97
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiFFUbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiFFUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:31:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4D82F037
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:30:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id v1so20477747ejg.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjlupzUpssQ/zXPtSpKMZWj3HluXgdG+Y/6lVpRKYVE=;
        b=jc7C1tatqDAwbmm4LtwxcZKUU4YS1aHlJAk16DJLh6iid4pPV6KnFvBqqryAGu4hpT
         gBOLwzgiy8mJ/KhKV+72Ub5FrPj9vR4NcxRr+2XWTWoRdkjQ5EIOVAWuZVDOa6dhCLeY
         CnIDgfMOqKU4Yf0R1TXwOkwAyXUWaZcjXVZ94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjlupzUpssQ/zXPtSpKMZWj3HluXgdG+Y/6lVpRKYVE=;
        b=SaxL8OOTzDEjndc6h0Uav3ejj+W1W0n6e5S9JZU8XpIS3Wyi0+92qWOSNSOj6HUsp5
         RWfwdrnulPDl8L2wiU/YwNeedick/BUyqz+rjiLidzFLlisdbe9laKvls/axjspqe6uQ
         4aNLFTFrY/ybUZ84UAFiBeVJB4PqB9uKWw1N4Rx70TaeHHPaXB7DDwa/cKBlkedta3FC
         uqPUJ5YorRPE+06nXBe4osmNy6KxI8GLN0+x+ZJb/54Yqzg3beaJRdwaIlh+ha602P6o
         VofzSNuq/xGX15An3hs4sEuvbGl7Pq4ur9o/6WGrXmCK0yrXSXxN8FM/OqhBVG1zgbOX
         vQKQ==
X-Gm-Message-State: AOAM533XUGrbgyi9whbHTTQoxwaTaPWjVgCEb2VI5o10tW9Qn5m2XWus
        PNB+qkTva/X9RCc9PQ2G+aNVmso4WoeoMa5iw1s=
X-Google-Smtp-Source: ABdhPJy8y/FAopujf3SeN2paIf8Ch1b10kfWw/pvxyCoiWxZsZ6jFa1fzdMXpvpzubq1xCmae/F0kg==
X-Received: by 2002:a17:906:4356:b0:711:cd0d:b205 with SMTP id z22-20020a170906435600b00711cd0db205mr7326984ejm.240.1654547420724;
        Mon, 06 Jun 2022 13:30:20 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id z11-20020a05640240cb00b0042e17781fc5sm7735495edb.49.2022.06.06.13.30.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 13:30:18 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso8460648wmr.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:30:18 -0700 (PDT)
X-Received: by 2002:a05:600c:591:b0:39c:4544:b814 with SMTP id
 o17-20020a05600c059100b0039c4544b814mr14738745wmd.118.1654547418071; Mon, 06
 Jun 2022 13:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220228202532.869740-1-briannorris@chromium.org>
 <CA+ASDXNSThy7usMKkN22VBq2iyej7sCJ8CAmgnNvxDgZiMbukA@mail.gmail.com>
 <CA+ASDXMW14GqJUAogQ0=dVdamhTTGDzcMRv-8Cx-TaXShHxj+A@mail.gmail.com>
 <CAOw6vb+myB0gB1kPvwuL+T1Ka10gDN5rGS2hW+UG+-+K2NGz_w@mail.gmail.com> <CAD=FV=X1F61nDcoQz4w1pJX_=Zzt6sLH8bcsGrxxTpGs6=yZ4w@mail.gmail.com>
In-Reply-To: <CAD=FV=X1F61nDcoQz4w1pJX_=Zzt6sLH8bcsGrxxTpGs6=yZ4w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jun 2022 13:30:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=URUUEtLfJprO72s307Op4Y9CQw0Uk3TUPBq8XAokhCsg@mail.gmail.com>
Message-ID: <CAD=FV=URUUEtLfJprO72s307Op4Y9CQw0Uk3TUPBq8XAokhCsg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: analogix_dp: Self-refresh state
 machine fixes
To:     Sean Paul <seanpaul@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Liu Ying <victor.liu@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 3, 2022 at 8:17 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jun 3, 2022 at 8:11 AM Sean Paul <seanpaul@chromium.org> wrote:
> >
> > On Mon, May 23, 2022 at 5:51 PM Brian Norris <briannorris@chromium.org> wrote:
> > >
> > > On Thu, Mar 10, 2022 at 3:50 PM Brian Norris <briannorris@chromium.org> wrote:
> > > > On Mon, Feb 28, 2022 at 12:25 PM Brian Norris <briannorris@chromium.org> wrote:
> > >
> > > > Ping for review? Sean, perhaps? (You already reviewed this on the
> > > > Chromium tracker.)
> > >
> > > Ping
> >
> > Apologies for the delay. Please in future ping on irc/chat if you're
> > waiting for review from me, my inbox is often neglected.
> >
> > The set still looks good to me,
> >
> > Reviewed-by: Sean Paul <seanpaul@chromium.org>
>
> Unless someone yells, I'll plan to apply both patches to
> drm-misc-fixes early next week, possibly Monday. Seems like if someone
> was going to object to these they've had plenty of time up until now.

As promised, I pushed these to drm-misc-fixes:

e54a4424925a drm/atomic: Force bridge self-refresh-exit on CRTC switch
ca871659ec16 drm/bridge: analogix_dp: Support PSR-exit to disable transition

-Doug
