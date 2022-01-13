Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07F748D64E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiAMLID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiAMLIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:08:01 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12909C061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 03:08:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m3so4152420lfu.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 03:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHTsUg3HEau620/3Kt1gAirKaZRBvN3yED5BHth3EE8=;
        b=dAGW/+aPFYxzL5NwBWOLkEHowvoffuEhYijSaiZkmNoQ7tuOanFh14QMD1SolHX+Od
         ZcQGJCoWKfare85WMgR9oIfvWZRXuXjz3JN/hl2iXKThx6a7qflq5E+NjfIWKHYvVMnJ
         0L23TtFXT1C33VTjgoMo5ehRQnuCZL1YbCxvF4lV0i8UWUx6MOouRyFUypddAC1MK1c7
         sl0ID7467dkjgodXqgUhP1qHr9sjR15RC2lnPV4sknEKUu3H8/MDtGh5HT3skdCRu1d4
         FkjJgtrnEkOa5XbAr8Vs2+79TeXdJ6w99SGIbEt+kaxRJZ9c6z6NglWMO3XiJvM1/T3c
         flZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHTsUg3HEau620/3Kt1gAirKaZRBvN3yED5BHth3EE8=;
        b=q+PtFckUsq7s7RownIEUUASAugsyWJxl4xWYp1oLDKOoiwIwNdSTbX1m16fx8iCmvM
         X5veXEIdF2OwQ7MxWmeBXHZuZ6OoCOEGaK4xvkEY5dLrJa0IJhSP7GVJPvzI2xrY+ikv
         mRKeL8RZOqvR3YKCfrtvz0dUAto1Sds1uj6uDdpTtQr7CebyuGmmJYpHUw6QZbnBOy/K
         1HpD78fZjzjUvp81B3NgbBOY3tVynsSBDcbaFz5JXy0C2JzrkhZmjzQNtSNDM0cSUsi8
         hY9fJOSBpbqYV+IO7+tLb8N3rWJ3boC0wFoPx+gr12urYSyU/LUpjiMuLGgySFuZKy7K
         +OwA==
X-Gm-Message-State: AOAM532BDW3s0lFTTDDDiZs+GzvPRZMiz7D6qeRCH2bMPRaQ/rJqJuF4
        UD592IKzZB69e1FBgY6HRVFV58sKiviWoemtB8gCIQ==
X-Google-Smtp-Source: ABdhPJyRSSwu/fXZpwOWb9PbbQDN2SucJ/Z3pJ3GPSqtm5fyS7O/knAwPvWu/fu3VvtFCd2Fz4E2+/3NTNhYY5/F8U0=
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr2661168ljh.63.1642072079166;
 Thu, 13 Jan 2022 03:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20220104073545.124244-1-o451686892@gmail.com> <CALAqxLVSaZywOOnF=67X+gu9eo+ZmKQmW3wUOOKEM0rUZ4K5gg@mail.gmail.com>
In-Reply-To: <CALAqxLVSaZywOOnF=67X+gu9eo+ZmKQmW3wUOOKEM0rUZ4K5gg@mail.gmail.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 13 Jan 2022 16:37:47 +0530
Message-ID: <CAO_48GHsoixQ8kpdMTnKy--jC+vphLEmf7L_1eDivRV=tdwZog@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: cma_heap: Fix mutex locking section
To:     John Stultz <john.stultz@linaro.org>
Cc:     Weizhao Ouyang <o451686892@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        christian.koenig@amd.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Weizhao,

On Tue, 4 Jan 2022 at 13:13, John Stultz <john.stultz@linaro.org> wrote:
>
> On Mon, Jan 3, 2022 at 11:36 PM Weizhao Ouyang <o451686892@gmail.com> wrote:
> >
> > Fix cma_heap_buffer mutex locking critical section to protect vmap_cnt
> > and vaddr.
> >
> > Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the cma_heap implementation")
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>
> Looks good to me!  Thanks so much for sending this in!
Thanks for the patch; it's merged to drm-misc-fixes.
>
> Acked-by: John Stultz <john.stultz@linaro.org>
>
> thanks again
> -john


Best,
Sumit.
