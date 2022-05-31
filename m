Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC2353996B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348354AbiEaWTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbiEaWTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:19:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8579CF58;
        Tue, 31 May 2022 15:19:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso2021550wma.0;
        Tue, 31 May 2022 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hg0Ilti18FAQE7cSSj65kaiJUUDYw0qPslbA3HQQNKk=;
        b=pk+7v8jwxc9qnUvijU0Bs2W142w7XcrD6mmGUUoIB2zJqfw/FLDe0qCku2APYiQsBh
         rHZS7M3SLTqcI74mnTo0pnYyPbyceYuIwYIpXM2KKE63i+ElxZrKSGZt0HAgb3LG2Sfl
         VEaTTKgdCrqF/AE7/RjdOauoCGLA2h+nvQnYAnlQMUomBB12RUT5SnAZ36uXx4DPpBb0
         9zvZ5npnBKue8wa2GiJn2WEq+ZcH1M7MaWs53s0hR6RsY9xKy05n9SMuFIH5iO42RsIJ
         Mw02aOJ8jd/IA/gBLGx8U3hOk9sjdQz95ookzg+NT+l4Qh+CiJmyLjIHJZdAUDuSvhhp
         42Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hg0Ilti18FAQE7cSSj65kaiJUUDYw0qPslbA3HQQNKk=;
        b=4iFTZmn8hlRzz3tYja1WzkLnXAYOlTqm2pBCjVkh7sNXR75tN9m/wuaLPHSD1bD76A
         SmiWFXMyNArNx1qaegf/Yuk72ni5mpH5AxKKsm8wmMz6m5m9+9zxmkwJN+R+aaFpB/Xh
         OyheW0WShn9VRYPfCDRfVwlrnoBsHbg9uxf//iK9ikcIDjupqNrAZvFmzQN+eTS86Mw1
         r2bgI6A6eaxDWQXDlBn6fI1Pn86+bWT1mE3+ghRLMo0G5M9qMTk4DDTn9sQkSOh3l1Gr
         qe/Lr31Gu+04ohKbDVWYO0v2SI0/A8mOXo3iMfQv5840LC+E+JmRci92hfYIHRhjAMji
         fo3Q==
X-Gm-Message-State: AOAM533NAaFow51lcIhvxbhU32nDh+CF7t/Q87aYhsmY3t0Xr9a0EDdP
        c9obO0jOOvU2k0mGUNAcooFkb89j2gYZkw1Ov4o=
X-Google-Smtp-Source: ABdhPJw+pyjdZqhWopEnK7PgvgXcc+sdJo0v04GaqsNX69HfALfqNi2CQOn3upMxMB+y4fWzvrpat4zC3W3e7STVlkk=
X-Received: by 2002:a05:600c:6011:b0:398:fa3:c02d with SMTP id
 az17-20020a05600c601100b003980fa3c02dmr19146556wmb.183.1654035584709; Tue, 31
 May 2022 15:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220531215106.192271-1-robdclark@gmail.com> <39d1fa65-8e82-721c-171e-ef36bda1c561@arm.com>
In-Reply-To: <39d1fa65-8e82-721c-171e-ef36bda1c561@arm.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 31 May 2022 15:19:45 -0700
Message-ID: <CAF6AEGuMN23hxe1+PES-F0rgXDnxi48OfbdHKasPGVnbFvQ8rw@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: Make things less spammy under memory pressure
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
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

On Tue, May 31, 2022 at 3:00 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-05-31 22:51, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Ratelimit the error msg to avoid flooding the console.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   kernel/dma/debug.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > index f8ff598596b8..683966f0247b 100644
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -564,7 +564,7 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
> >
> >       rc = active_cacheline_insert(entry);
> >       if (rc == -ENOMEM) {
> > -             pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
> > +             pr_err_ratelimited("cacheline tracking ENOMEM, dma-debug disabled\n");
> >               global_disable = true;
>
> Given that it's supposed to disable itself entirely if it ever gets
> here, just how spammy is it exactly?

um, quite..  tbf that was in the context of a WIP igt test for
shrinker which was trying to cycle thru ~2x RAM size worth of GEM
buffers on something like 72 threads.  So it could just be threads
that had gotten past the dma_debug_disabled() check already before
global_disable was set to true?

I guess this could be pr_err_once() instead, then?

BR,
-R

> Thanks,
> Robin.
>
> >       } else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> >               err_printk(entry->dev, entry,
