Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48D953723E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 20:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiE2Stg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiE2Stb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:49:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190D228E14
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 11:49:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h19so2938688edj.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7uJutVFI9zbN32EkS//6xvmPFfWw/D4Up53DrHq1CM=;
        b=CuUNmJmeEcc7EUv/S/oXFJLA5BF7DKv5c6FRlFokkO7Y4XA1peTaUnp4Mu/xyX00Ty
         /jil6AFEDcU6L5vUu9ZQQ99gG0SdcA0wl6aPrT86gJt8GiVF6RGhbPxHuQbRkDaD+Iw7
         Qf1WkP3H65VB31BI51A/konuu0cDCJ2twJKK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7uJutVFI9zbN32EkS//6xvmPFfWw/D4Up53DrHq1CM=;
        b=KkL/3Bt9kx7ZXn3DI+H/nQS8xIXkfQAobb7pyEKbJbpV8cyp1OFRsPu20z5ZVdXA03
         hkhX1uZ5oVblnWCCc3Y8xLPFm9lTb8Z5Xs3gZYpj9JOoj7PBFlqRewxp2cBchD0SumNb
         ApZ42GbZY+3akXDg0m/MWW2J5QYOr3KqFP++Qv+lq1JrxFP1HSIoXAHdhzDNbmfhEPIw
         hvLFa1nULxuU73ZF78oM1s0K0uXGeBXsoPWnjgFN9I5bn8l0bnwDfai6UNwV+EUxtsyM
         SKiUWpByunMyioeLP4Eg9qoE4rFTG0XXo5FDUMrDSw3ThL7oOC9P5Lg5TowBapqT6Xo/
         BdiQ==
X-Gm-Message-State: AOAM532JHuofBbjF63tarN/X7bpDdNcKGNb6569A0O6lngrEIjh1J4Mt
        RQahIjXkK8HqEjykCbpJ/dEfApzx/tJDmS/lqOw=
X-Google-Smtp-Source: ABdhPJzhcaVeScTYY10jhjb6OblIc9R27NZJJ84BXH+HXb20dJhrb5x9DDpqpGzPc+zcTyXzgQNB5w==
X-Received: by 2002:a05:6402:750:b0:42d:a765:8637 with SMTP id p16-20020a056402075000b0042da7658637mr8384755edy.342.1653850167449;
        Sun, 29 May 2022 11:49:27 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id r27-20020a50aadb000000b0042dc6e250e3sm2018975edc.81.2022.05.29.11.49.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 11:49:26 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so5351313wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 11:49:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0e:b0:397:6b94:7469 with SMTP id
 l14-20020a05600c4f0e00b003976b947469mr15983870wmq.145.1653850165767; Sun, 29
 May 2022 11:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <YpOyb40/g5gIYigF@matsya>
In-Reply-To: <YpOyb40/g5gIYigF@matsya>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 May 2022 11:49:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZtj6A7ggq7Ak5ZFwnLriGwU52NzC_3db5u+yLGJDJfA@mail.gmail.com>
Message-ID: <CAHk-=wgZtj6A7ggq7Ak5ZFwnLriGwU52NzC_3db5u+yLGJDJfA@mail.gmail.com>
Subject: Re: [GIT PULL]: dmaengine updates for v5.19-rc1
To:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 10:50 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> Please pull to receive the dmaengine updates for this cycle. Nothing
> special, this includes a couple of new device support and new driver
> support and bunch of driver updates.

Vinod, _please_ report it when it turns out that there are semantic
merge issues in linux-next.

The whole point of linux-next is to report and find problems, but that
also means that if the issues found in linux-next are then completely
ignored, the _point_ of being in linux-next goes away.

In particular, there was a semantic drivers/dma/idxd/device.c that git
was perfectly happy to merge one way, but that needed manual
intervention to get the locking right. See

   https://lore.kernel.org/all/a6df0b8a-dc42-51e4-4b7b-62d1d11c7800@intel.com/

and this is exactly the kind of thing that should be mentioned in the
pull request, because no, I do not track every single merge issue in
linux-next.

I only catch them when something makes me go "Hmm", and in this case
it was a different conflict near-by that just happened to make me look
closer (the same one that Stephen had noted).

Stephen makes this clear in his notifications:

 "This is now fixed as far as linux-next is concerned, but any non
  trivial conflicts should be mentioned to your upstream maintainer when
  your tree is submitted for merging"

and yes, the original merge was indeed trivial and wouldn't have
needed any further mention had it _stayed_ that way.

But it didn't actually stay that way, as pointed out by Dave Jiang in
that thread.

The fact that I caught it this time doesn't mean that I will catch
things like this in general. I'm pretty good at merging, but there
really is a reason linux-next exists.

                      Linus
