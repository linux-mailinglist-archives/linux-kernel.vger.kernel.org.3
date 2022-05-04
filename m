Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A622519804
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345364AbiEDHZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345377AbiEDHZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:25:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13C2317F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:21:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso538328pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 00:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWCJbI4CGT2i31kMbhu+0FR5T+EOna1DU84vOLrzsmI=;
        b=qlAFA/71vDvjib7s4u5s/9fb9WhmNOa74bwXdUw569sClb3DOkNKgU0LG38S7loFYF
         i8zz7CEcGmD4sFS8CZvKH3YxwXSX92OOJ04rhqQzZdB3IAbiWjhkRgC6aXPMsGRW0dRy
         v7UWFf7x8wDQ8xN0tSJQk2YEdaWp4qWeT+ym12lhq8ZEVA/fvdDb9QazbKHUYD/JLmtS
         CLG0QbD33jzFgr5ZtivpApzPL2mxJOyHfT6J8v9F9GVt/lRG4ZtgocaH6ISdaYJiljCJ
         1m57cFJaOc+I6rkUNzsBinGdtwXOzUfeCspq2yKQ8X3HQHnlEwER8JPxubt6jMUBciqe
         egaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWCJbI4CGT2i31kMbhu+0FR5T+EOna1DU84vOLrzsmI=;
        b=rfihMhhoaBfXJfhUKIzR6O5KslF12N73V5Ln0Ob5FXQ5i2IXxpCtEApfhmdd8K7qsT
         8APf0HxiuuPW5h20fpZf6ClMLYsZy6IFYJd+FufnRIq/cJA6ade4f71YUB3tkVVtwqhr
         0E2aT8iQsMtcWt4mdDMCYS5w57n12eeNcudXq0eU8mY1OgP1ED6ZDoijbPX5+bt68QA9
         CQZ7RImBGiWORfseWQlpogZv+k7mKQuCWm988t6/qsf5VffwDop3+AB7xcA6BURK7/qA
         6aEdcPDRgEi+BlShb6zQHaAXWgbD3RCi6NimNmxWoX71dQD0lTdsgiZkULOHkKHdYnFK
         0O6Q==
X-Gm-Message-State: AOAM532LtZPGA9YQBa0vMa8f658uebWhtv0zpVfMKSJM4sA1sre6pL3L
        2hCXrP5U8TJ+fuo6yqtKHmozFCbLGL4LMNVoNslp7Q==
X-Google-Smtp-Source: ABdhPJxw1DoDKhe05oCD8505mnMKAIxbnxSdPRDLpH6njPy7/kkzjZZ07oYyjOT0XxJ73DnoPKi0bglyZR9oiRkgFhA=
X-Received: by 2002:a17:902:70cb:b0:158:424e:a657 with SMTP id
 l11-20020a17090270cb00b00158424ea657mr20146250plt.6.1651648917003; Wed, 04
 May 2022 00:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220502104144.91806-1-manivannan.sadhasivam@linaro.org> <20220502104144.91806-6-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20220502104144.91806-6-manivannan.sadhasivam@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 4 May 2022 09:21:20 +0200
Message-ID: <CAMZdPi_i60TqszUL+=ocMn-4veyoGRQoOGD_B4YiEpz_uWE+ZQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] bus: mhi: host: Remove redundant dma_wmb() before ctx
 wp update
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On Mon, 2 May 2022 at 12:42, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> The endpoint device will only read the context wp when the host rings
> the doorbell.

Are we sure about this statement? what if we update ctxt_wp while the
device is still processing the previous ring? is it going to continue
processing the new ctxt_wp or wait for a new doorbell interrupt? what
about burst mode in which we don't ring at all (ring_db is no-op)?

> And moreover the doorbell write is using writel(). This
> guarantess that the prior writes will be completed before ringing
> doorbell.

Yes but the barrier is to ensure that descriptor/ring content is
updated before we actually pass it to device ownership, it's not about
ordering with the doorbell write, but the memory coherent ones.

>
> So there is no need of an additional dma_wmb() to order the coherent
> memory writes w.r.t each other. Even if the writes gets reordered, it
> won't affect the endpoint device.
>
> Cc: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/bus/mhi/host/main.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 966ffc2458b9..6706a82d3aa8 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -138,11 +138,6 @@ void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
>
>         db = ring->iommu_base + (ring->wp - ring->base);
>
> -       /*
> -        * Writes to the new ring element must be visible to the hardware
> -        * before letting h/w know there is new element to fetch.
> -        */
> -       dma_wmb();
>         *ring->ctxt_wp = cpu_to_le64(db);
>
>         mhi_chan->db_cfg.ring_db(mhi_cntrl, &mhi_chan->db_cfg,
> --
> 2.25.1
>

Regards,
Loic
