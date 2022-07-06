Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6A3568E43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiGFPvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiGFPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:50:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF4B2AC47
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:46:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x10so12460297edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArRN4vS4WYW+UtwDVjBQYC/h4Qpd9mKoSxm/dzHairI=;
        b=YNHJF3tZQJmC1EOhWUuvBhdzyOOfUsgXwnl6A41GdSylj/q8oVNeC+uxHedNpTMhL4
         4jDkvSi1ok7oL7zW7TWR/b8oSxoMmbyaLBY8kLBbVjJ1nMzAAnLOFhljvdZ0zSFIgQGv
         hjlUiAolFD8Ftc9ta1v86i1gHs3S7Y2DhGo+xRzXf6Awp5tc09rWb0XzkJgzaa3lh6Xs
         9cZhWOcARl5wiKfsaFHoBYxeoVf1Yt7VrO6D4l+LBaLAtmQKsLlF50Bh8LifyrH6bXWM
         cRUv5/bXV4DpG07PGZbqphIoNudeoOn0WZWMGhNicse2p9cFAbjBb5cIH3vkfganXhc/
         bjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArRN4vS4WYW+UtwDVjBQYC/h4Qpd9mKoSxm/dzHairI=;
        b=UUQ1dbmRXIjNWaF1mxJJ9IIp4FyRvdMApW/hzmlPsDuKc+XeAscOEyON3MS53cAX2v
         hp+Orxxhvti2xQaRsXkHyGyMJWQKdwkdDGMp5GUVwpjku0/Ybuv7RY97qcyfiWCmRy92
         aOTvng2pN1yx1HoSokq/dT4aqPTZrGgliXD2wn1odL2yhXIhL0FUOkcBCekjjGbRMrK4
         Af99IpvxwSjdkO+731nZDb6MNxltwmk2kWJiKtHtaMkVqz9gjz5rAIV1uq40fRrSqE97
         b4gHm0WQrnYoOEoH7ai6aePKGg2m+VNiH2rTtRcNclFuHXKy0GfWg8JUiwCAvi3wfq+6
         Zz4w==
X-Gm-Message-State: AJIora8MLHn7rHW1JrrqzAE1jekVHyJhN8/JMe30WD6wiT9NkxaIlM0O
        0hpwrUYKMJC1PrQY3/xExp+w634GieDkmySQuqA=
X-Google-Smtp-Source: AGRyM1t9mV36ZGcyklfBPmx0k1p5IWGVDwhcEUPZu7CLUml/Uv87cpi4zXtiKznLR5ejct/uBVvXSE8mtn3iVtfOReI=
X-Received: by 2002:aa7:cd64:0:b0:43a:4d43:7077 with SMTP id
 ca4-20020aa7cd64000000b0043a4d437077mr24358556edb.302.1657122399092; Wed, 06
 Jul 2022 08:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220411221536.283312-1-dmitry.osipenko@collabora.com>
 <a78343c8-2a6d-b223-4219-6b6b0a4fcb1f@arm.com> <CAK4VdL2hCEoshWZbCh5mkHuS6wYMiPFR3v4MWTnrEKM9zyv6Mw@mail.gmail.com>
 <ef88ec2c-77b5-fa0d-49d1-fdd2451713b7@collabora.com> <573fae0d-c9ab-98b0-c6f1-5b0d4e52dd01@amd.com>
 <a33ab7b9-738f-db91-f6ba-78a9641365e8@amd.com> <b05f9861-1966-72f5-132b-aebb4b6e0c6b@collabora.com>
 <107fe968-8311-0511-cc31-22feb994a6d7@collabora.com> <3e07a8d0-2cbc-8f3e-8f9f-5b73fb82028b@amd.com>
In-Reply-To: <3e07a8d0-2cbc-8f3e-8f9f-5b73fb82028b@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Jul 2022 11:46:27 -0400
Message-ID: <CADnq5_MMmeWkiMxjYfrG7pip8BEkbkRc8ADUDLEi++kRF76sqg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/scheduler: Don't kill jobs in interrupt context
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 9:49 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> On 2022-07-06 03:07, Dmitry Osipenko wrote:
>
> > Hello Andrey,
> >
> > On 5/17/22 17:48, Dmitry Osipenko wrote:
> >> On 5/17/22 17:13, Andrey Grodzovsky wrote:
> >>> Done.
> >>>
> >>> Andrey
> >> Awesome, thank you!
> >>
> > Given that this drm-scheduler issue needs to be fixed in the 5.19-RC and
> > earlier, shouldn't it be in the drm-fixes and not in drm-next?
>
>
> I pushed it into drm-misc from where it got into drm-next. I don't have
> permission for drm-fixes.

The -fixes branch of drm-misc.

Alex


>
> Andrey
>
>
> >
