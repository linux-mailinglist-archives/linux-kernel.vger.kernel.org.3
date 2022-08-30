Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D355A5D13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiH3HhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiH3HhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:37:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580A6BC812
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:36:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso17066510pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mW0Ka0BY8O9KwOHEGKvdoQs1XCAF6flhw+El+K+1goY=;
        b=cPxrekHtixkCW7rsobHtN/up2/yx+UckIYflRTNPufG9p3vLSUbFzBJS0YTNDoSQPO
         sx4uYsTBnSdLTwIt3e68ztYDYVCWWkZssCfhLhxOcCE5PhRCWsDPscM4YL2pd9pydPsE
         l4aolK5F6lm8ywsN01CX/uhbcy5T7cpEaBloDNqF44vK5L0xkXLrRoValUA11xegbMRF
         7dQdUaB5svhaIM4qiVkTV05kYcqHNuKUscTl2TCkijeGFUQqAGdKeDL0JEKKC9fcnbDY
         zDjqdnHgMzPNj/xROZamnyjTl+uFaNGjc2J3iawdAT8ZxAC3WderXbWLKd62ySNvBYm+
         Z/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mW0Ka0BY8O9KwOHEGKvdoQs1XCAF6flhw+El+K+1goY=;
        b=r/m7ikLbCRbAMHmnOEA75EaTaGkOJiWk6UAmuCIESrH4Dc+1j1mUI3ExMjKgwm+S3H
         zkYm8QItBoquw2iBs9UNNECxqTteoAKeE9cfbmbHIB0kLx2Pt7Hc38PCRJ3MsBhRUwrc
         JHSin61OKawW6RTMnWUdDCZNAO4eVMVms2ZQandJvhpvch4rrI0jkz4yrdbClhkKxXFw
         ID8O1oHx4DAUCQaK7xknw4HB2JlYmCmhzE9y8EoNZtCcMwuwegHe87naouQ/6rE2bl77
         BVE6vtDiF95Xcoxg36tG89d/HVNEcX3CQpe+Z9+AZAP1duTfnZW3tnR/yvp3w1nqARn2
         EdZQ==
X-Gm-Message-State: ACgBeo2V5wlzVBdsJknbUiQV19QjaYu1Xbd25uRk1Iv4jhoxD73m4j37
        aF93Wb7WEtLe4bjfv0H0+myJw7PyTmw9Gi/k3A==
X-Google-Smtp-Source: AA6agR6AktxFKg4sYEz+T2ZcPFmq/8NnPqYEz8hav2t453LIvDiMGEJ//Bin3+mAW3vHW4491Gs4SD3q8r/5RJsDNFo=
X-Received: by 2002:a17:90b:3b41:b0:1fb:5376:fb06 with SMTP id
 ot1-20020a17090b3b4100b001fb5376fb06mr22210009pjb.240.1661845018775; Tue, 30
 Aug 2022 00:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220716081304.2762135-1-zheyuma97@gmail.com> <CAG3jFytOyhy_es2cULpp0TCdp70HTcqKo1hd-ZxVaC4O-vi-3w@mail.gmail.com>
In-Reply-To: <CAG3jFytOyhy_es2cULpp0TCdp70HTcqKo1hd-ZxVaC4O-vi-3w@mail.gmail.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Tue, 30 Aug 2022 15:36:47 +0800
Message-ID: <CAMhUBj=8a2w5HcACB96wxyjja_kaUg8ZtCNwWv8cqGQsG814Fg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: megachips: Fix a null pointer dereference bug
To:     Robert Foss <robert.foss@linaro.org>
Cc:     peter.senna@gmail.com, martin.donnelly@ge.com,
        martyn.welch@collabora.co.uk, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,


On Mon, Aug 29, 2022 at 11:03 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> On Sat, 16 Jul 2022 at 10:13, Zheyu Ma <zheyuma97@gmail.com> wrote:
> >
> > When removing the module we will get the following warning:
> >
> > [   31.911505] i2c-core: driver [stdp2690-ge-b850v3-fw] unregistered
> > [   31.912484] general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> > [   31.913338] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> > [   31.915280] RIP: 0010:drm_bridge_remove+0x97/0x130
> > [   31.921825] Call Trace:
> > [   31.922533]  stdp4028_ge_b850v3_fw_remove+0x34/0x60 [megachips_stdpxxxx_ge_b850v3_fw]
> > [   31.923139]  i2c_device_remove+0x181/0x1f0
> >
> > The two bridges (stdp2690, stdp4028) do not probe at the same time, so
> > the driver does not call ge_b850v3_resgiter() when probing, causing the
> > driver to try to remove the object that has not been initialized.
> >
> > Fix this by checking whether both the bridges are probed.
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > index cce98bf2a4e7..c68a4cdf4625 100644
> > --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > @@ -296,7 +296,9 @@ static void ge_b850v3_lvds_remove(void)
> >          * This check is to avoid both the drivers
> >          * removing the bridge in their remove() function
> >          */
> > -       if (!ge_b850v3_lvds_ptr)
> > +       if (!ge_b850v3_lvds_ptr ||
> > +               !ge_b850v3_lvds_ptr->stdp2690_i2c ||
> > +               !ge_b850v3_lvds_ptr->stdp4028_i2c)
>
> This chunk fails checkpatch --strict.
>
> Alignment should match open parenthesis
> #39: FILE: drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c:300:

Thanks for your suggestion, I've sent the version 2 patch.

Regards,

Zheyu Ma
