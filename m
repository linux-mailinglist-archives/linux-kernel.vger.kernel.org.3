Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BED5468F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbiFJPBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiFJPBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:01:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B71EE1C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:01:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w27so35597670edl.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OggQGH3JFL5ahsTo7JoWuxdxGSf5+8oOFLpQy3dNZQ8=;
        b=7lpFSL12bsBNaRh7q0pTG9aeYANeTQiHYeDDBIbKVvHfNiupsRv6sSyeTL1ED3TRTm
         fD4DScMlcz1E0oO4sOKKOm2UnK/j/Q07MWRzG5WqJGe78trRMEXD3IlGiReRdVDRgY+Q
         q88onBuV8uBffs7Q2Undhja9z7r58hmz1Iam4zYH/x8Wpw9c7QNW9Gyo5bk/SYnrXJYk
         1hhc3d1yXfTKi9nhtn6o1yiDg1LHyEc0wZ9Ev/nkONRf/W3j3nCwJ5JQX4DZsd1LWoWC
         hTfs0Og5+uHgmKkdd6RhpiS5s6ptg5vZbBLpZw5WczvJnlMUN6ZzOE+X+SueGBJiLkAy
         pJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OggQGH3JFL5ahsTo7JoWuxdxGSf5+8oOFLpQy3dNZQ8=;
        b=P646wy2uYF9/c7tUzXGJeU+WBEMsb+2ZyraORGU6ZQm0/lekfAKGza4JuOG/6e+3xe
         ymvYAE0CkQWgsUR5ht9WW/vU4t/EOtpbwhxsrJ47+6fd8vohbrHcmq524sSPs3ynfqX3
         ZIa/qwObDE2PdG7sj2ekPJySGb1tq+cVgqwbtMssHd4vUAeMma/Z5ZtqLq4+vNEgHcdR
         be9u2bsR3//F9wQvSSlckWWpUa2gzkFYlTyZuHLW0KJlRhwf7s/FlDyWbeglK+D0Ljp5
         KT4gI0yQ1ig6q59z9bBiRl5WqMy0gsdqvSqMB3d5vr65fppcW9ddvbou978+wHemxKtm
         m6Pg==
X-Gm-Message-State: AOAM531Ner084cL4p35MlFIZDS9Mjgud7rclkeUDkcfFW7ZJ0dU/UUxz
        T+IGA8iOErFzg0mhMv9fmERI9cfGtY43TLfKzLmRwQ==
X-Google-Smtp-Source: ABdhPJyHMm+/l9sH3f1xDzionQtAY8B4EnWdmrPlKZ1BS7nTmX/iJBt4fOyzp+FvReB5TwqwrUlmgtmbusNNM3xIHG0=
X-Received: by 2002:aa7:d14c:0:b0:42d:bbab:43d6 with SMTP id
 r12-20020aa7d14c000000b0042dbbab43d6mr52168093edo.15.1654873273595; Fri, 10
 Jun 2022 08:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com> <20220610125215.240539-5-nicolas.dufresne@collabora.com>
In-Reply-To: <20220610125215.240539-5-nicolas.dufresne@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 10 Jun 2022 12:01:02 -0300
Message-ID: <CAAEAJfAdPt59oCi4wPybwn0a4zHq_3x66L5mRSQ54yQezz+ZZA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] media: rkvdec: Re-enable H.264 error detection
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Great stuff! See below for some ideas how to expose errors.

On Fri, Jun 10, 2022 at 9:52 AM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> This re-enables H.264 error detection, but using the other error mode.
> In that mode, the decoder will skip over the error macro-block or
> slices and complete the decoding. As a side effect, the error status
> is not set in the interrupt status register, and instead errors are
> detected per format. Using this mode workaround the issue that the
> HW get stuck in error stated and allow reporting that some corruption
> may be present in the buffer returned to userland.
>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 23 +++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index 55596ce6bb6e..60a89918e2c1 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -1175,14 +1175,15 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
>
>         schedule_delayed_work(&rkvdec->watchdog_work, msecs_to_jiffies(2000));
>
> -       writel(0, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> -       writel(0, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
> +       writel(0xffffffff, rkvdec->regs + RKVDEC_REG_STRMD_ERR_EN);
> +       writel(0xffffffff, rkvdec->regs + RKVDEC_REG_H264_ERR_E);
>         writel(1, rkvdec->regs + RKVDEC_REG_PREF_LUMA_CACHE_COMMAND);
>         writel(1, rkvdec->regs + RKVDEC_REG_PREF_CHR_CACHE_COMMAND);
>
>         /* Start decoding! */
>         writel(RKVDEC_INTERRUPT_DEC_E | RKVDEC_CONFIG_DEC_CLK_GATE_E |
> -              RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E,
> +              RKVDEC_TIMEOUT_E | RKVDEC_BUF_EMPTY_E |
> +              RKVDEC_H264ORVP9_ERR_MODE,
>                rkvdec->regs + RKVDEC_REG_INTERRUPT);
>
>         return 0;
> @@ -1196,10 +1197,26 @@ static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
>         return 0;
>  }
>
> +static int rkvdec_h264_check_error_info(struct rkvdec_ctx *ctx)
> +{
> +       struct rkvdec_dev *rkvdec = ctx->dev;
> +       int err;
> +
> +       err = readl(rkvdec->regs + RKVDEC_REG_H264_ERRINFO_NUM);
> +       if (err & RKVDEC_STRMD_DECT_ERR_FLAG) {
> +               pr_debug("Decoded picture have %i/%i slices with errors.\n",
> +                        RKVDEC_ERR_PKT_NUM(err), RKVDEC_SLICEDEC_NUM(err));

It's more useful friendly to just keep a counter somewhere. In the past,
we've created a user control, which has the advantage of leveraging
an existing mechanism, and already being per-fd.

See:

commit b2d3bef1aa7858b2ae5e0d01adb214121ba00b9f
"media: coda: Add a V4L2 user for control error macroblocks count".

I would drop the pr_debug, or if you think it's really useful for users
and developers, go with v4l2_dbg. In which case, how do you ensure
a corrupted stream won't flood the logs?

Thanks,
Ezequiel


> +               return VB2_BUF_STATE_ERROR;
> +       }
> +
> +       return VB2_BUF_STATE_DONE;
> +}
> +
>  const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops = {
>         .adjust_fmt = rkvdec_h264_adjust_fmt,
>         .start = rkvdec_h264_start,
>         .stop = rkvdec_h264_stop,
>         .run = rkvdec_h264_run,
>         .try_ctrl = rkvdec_h264_try_ctrl,
> +       .check_error_info = rkvdec_h264_check_error_info,
>  };
> --
> 2.36.1
>
