Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445F74DAA77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353814AbiCPGLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbiCPGLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:11:08 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E7351E4A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 23:09:54 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id t11so2602038ybi.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kP0LyTf+EiQY7fo4NN9fTawSgavBYcmQCB65qo3H3i8=;
        b=gWIFxN086BRLC08wt0RLKOoxxVt9OkQj3kIwI8jgVTjmMdVxCvAawkZ9mYjNcd7neI
         bA90gANRFYdD6d4kt/3S9EnuD6gvJjt3onlvvv9sx34rf/TOfPpgMq3C84eVZTvdVfMe
         yicsqqr5BFbBFuvNSsN3M8Qaxuy+oc0UDmPck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kP0LyTf+EiQY7fo4NN9fTawSgavBYcmQCB65qo3H3i8=;
        b=pcABFc5cphllyad+AVuObmARNBV17oQ9JQjoAryU3n7mjmWnOisHPrUoPafUkGwV5E
         V2VutXGzEb1Mvqw8yKwxsYIYpSa/2LVzBlqPH8ht4OgDwlfM9FyoiQkSi2Hpj3c1calm
         VVgxuh0TvoISAbWlFhZzYznn9IBTXPoBBeTzaYEd72vT0e9Y4d+6EXNzbz0ZGvpx4zy9
         B07RSP7teyhQESONrmx7I2T6BeWaI/NiOd+6+eCr2lKQVGG0OtQvPimCOpksKtpzYf/1
         Xt8DXydc8IoUKbfbUhX/I/coFmu84YHy6RE4wtzp/qBoY49Swx0DYd8CRnd/I9Q5fQzn
         lRxg==
X-Gm-Message-State: AOAM530RuSsymruFDauJsIk+uTFEbl73VhO2zAXH6kQ6nwoZAF57yhS7
        CEq57pPCjmqUNje3ByB0nsZo+5RL8lcsjgC6sa8YMg==
X-Google-Smtp-Source: ABdhPJzIGIFjLlDvvMTOWTCB9hIFczSOzUaQIahpV9y3ceIotV+ooWK3mFsz44hE5i2Mp0jREIT4vTJRATclSB5PsO4=
X-Received: by 2002:a25:32c2:0:b0:628:86af:da05 with SMTP id
 y185-20020a2532c2000000b0062886afda05mr27569966yby.278.1647410993824; Tue, 15
 Mar 2022 23:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220301042225.1540019-1-wenst@chromium.org> <CAGXv+5F-Nir_OHbenYntDhOVFviLP1n-dZcaw07GohSc=YK6SA@mail.gmail.com>
 <CAAEAJfCdj1fbvt1Aj2SiH8HN=UoG8_F+TY99xVWDcZy2xnS8ew@mail.gmail.com>
In-Reply-To: <CAAEAJfCdj1fbvt1Aj2SiH8HN=UoG8_F+TY99xVWDcZy2xnS8ew@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 16 Mar 2022 14:09:42 +0800
Message-ID: <CAGXv+5HcpbvUEfgYQv0iEPBF=u-p+dk8=-vegf5D8D3rkEs6EQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: hantro: Implement support for encoder commands
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 2:38 AM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> On Mon, Mar 14, 2022 at 3:59 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > Hi Ezequiel,
> >
> > On Tue, Mar 1, 2022 at 12:22 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
> > >
> > > The V4L2 stateful encoder uAPI specification requires that drivers
> > > support the ENCODER_CMD ioctl to allow draining of buffers. This
> > > however was not implemented, and causes issues for some userspace
> > > applications.
> > >
> > > Implement support for the ENCODER_CMD ioctl using v4l2-mem2mem helpers.
> > > This is entirely based on existing code found in the vicodec test
> > > driver.
> > >
> > > Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >
> > Gentle ping on this patch. Any comments?
> >
>
> Pong. I have been a tad busy the past weeks and haven't been able
> to review this yet. Sorry about that.

Got it.

> Meanwhile, and given how delicate this code path is in our experience,
> have you guys run regressions tests with this patch, in particular with decode?

We landed it downstream two weeks ago [1], and so far nothing has failed.

However, given that the driver doesn't support decoder commands either, the
new code might not be exercised in the way you assumed? At least no failures
indicates there aren't any incorrect code paths, i.e. decoder ending up in
the encoder path or vice versa.


Regards
ChenYu

[1] crrev.com/c/3456042
