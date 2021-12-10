Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA4446FF0E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhLJK42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbhLJK41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:56:27 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E8C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 02:52:52 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z8so13119547ljz.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 02:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gP5LX24JpNxF7vefAawP3DdSvjq7cPhknhcSfIgmH8w=;
        b=zs7riFHYxHEzGURQ+r0ytvbDAslJaYbMSSopoc7pM0D1mRAmY6iXnUuS+1upMax0uW
         VVvwO1UVlrQZOV0gskZLXSGTiJdWC3SBcNd+f6NWxZ9baP8z3zFAUDNefACD7G8WLmfQ
         p3JuNSr6Db4eRnBfRO36pYTNyAxYEm9kePQ6glbnc+8OUFvEXSuJWygtlw5Tewp5hUJc
         w/Y8/74SpKTpABKNCUzV1SGRG6pkZzVp1R1kCHQw1YUtey6cf6b30Vy5nd3J948bEEaf
         YLn6eBaf3joPoGXrqC+iPvUmQpbXhjR+dH8lXo4NeFu4i93bmGuUw6GsJH8G72jIPTN5
         bqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gP5LX24JpNxF7vefAawP3DdSvjq7cPhknhcSfIgmH8w=;
        b=oI+T8pBqRSstewy6db9Dl9b76NItgEf51smFo8sSMvRVE5cLFDq13Cs/hjoFuaBGwo
         o2uKrzNDCvMvlnbA9NAY593HrpF5dBw2ofOmjIhNeyVDGk619AxuEdlj1ueocMHGcabv
         RhamVJVGEoUk3hhtzagUZrQxoRkiC/B9vowvrsrRnTfpbOLaCdv9lTorgTfqMsIzCD+U
         w2iGnu1Mf8imn5v2Uq+If8ca1U+9L5/hXmrjppGibHVg5eRsVIxvz5z+7fQhMTLNdolL
         h/3YvDF3foXfF1fY8JxeIT0xqSMyJxSZ/x+0kr5THkBWP2Uldir0XxauMUyrSpHbHn4R
         yafw==
X-Gm-Message-State: AOAM530cq7+uHWbdrIvVxmrLtEbfODjCq2rn3eU+FnKGUkGOnLelU5a8
        hMVATv+AG68VEzkj2wh+CbJewGvoXN0laemE/Wr30Dm6azLqzA==
X-Google-Smtp-Source: ABdhPJzmfNDbl3yXVHrUz1V4xk3chxF0QGAKQPEsbtMBT/Cv8wMVZaj8epVzpGtZONgXvGSm7HgkPvGmqIMcgLWEW6A=
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr12057553lje.383.1639133570672;
 Fri, 10 Dec 2021 02:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20211129191156.29322-1-cristian.marussi@arm.com> <20211129191156.29322-17-cristian.marussi@arm.com>
In-Reply-To: <20211129191156.29322-17-cristian.marussi@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 10 Dec 2021 11:52:39 +0100
Message-ID: <CAKfTPtCDostniAStK2zNnFa+dtd1mHJ8zywyGXX9HZYf4u6z+w@mail.gmail.com>
Subject: Re: [PATCH v7 16/16] clk: scmi: Support atomic clock enable/disable API
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        jonathan.cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, Souvik.Chakravarty@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On Mon, 29 Nov 2021 at 20:13, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> Support also atomic enable/disable clk_ops beside the bare non-atomic one
> (prepare/unprepare) when the underlying SCMI transport is configured to
> support atomic transactions for synchronous commands.
>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> V5 --> V6
> - add concurrent availability of atomic and non atomic reqs
> ---
>  drivers/clk/clk-scmi.c | 56 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 1e357d364ca2..50033d873dde 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -88,21 +88,53 @@ static void scmi_clk_disable(struct clk_hw *hw)
>         scmi_proto_clk_ops->disable(clk->ph, clk->id);
>  }
>
> +static int scmi_clk_atomic_enable(struct clk_hw *hw)
> +{
> +       struct scmi_clk *clk = to_scmi_clk(hw);
> +
> +       return scmi_proto_clk_ops->enable_atomic(clk->ph, clk->id);
> +}
> +
> +static void scmi_clk_atomic_disable(struct clk_hw *hw)
> +{
> +       struct scmi_clk *clk = to_scmi_clk(hw);
> +
> +       scmi_proto_clk_ops->disable_atomic(clk->ph, clk->id);
> +}
> +
> +/*
> + * We can provide enable/disable atomic callbacks only if the underlying SCMI
> + * transport for an SCMI instance is configured to handle SCMI commands in an
> + * atomic manner.
> + *
> + * When no SCMI atomic transport support is available we instead provide only
> + * the prepare/unprepare API, as allowed by the clock framework when atomic
> + * calls are not available.
> + *
> + * Two distinct sets of clk_ops are provided since we could have multiple SCMI
> + * instances with different underlying transport quality, so they cannot be
> + * shared.
> + */
>  static const struct clk_ops scmi_clk_ops = {
>         .recalc_rate = scmi_clk_recalc_rate,
>         .round_rate = scmi_clk_round_rate,
>         .set_rate = scmi_clk_set_rate,
> -       /*
> -        * We can't provide enable/disable callback as we can't perform the same
> -        * in atomic context. Since the clock framework provides standard API
> -        * clk_prepare_enable that helps cases using clk_enable in non-atomic
> -        * context, it should be fine providing prepare/unprepare.
> -        */
>         .prepare = scmi_clk_enable,
>         .unprepare = scmi_clk_disable,
>  };
>
> -static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
> +static const struct clk_ops scmi_atomic_clk_ops = {
> +       .recalc_rate = scmi_clk_recalc_rate,
> +       .round_rate = scmi_clk_round_rate,
> +       .set_rate = scmi_clk_set_rate,
> +       .prepare = scmi_clk_enable,
> +       .unprepare = scmi_clk_disable,
> +       .enable = scmi_clk_atomic_enable,

For  each clock, we have to start with  clk_prepare and then clk_enable
this means that for scmi clk we will do
scmi_clk_enable
then
scmi_clk_atomic_enable

scmi_clk_enable and scmi_clk_atomic_enable ends up doing the same
thing: scmi_clock_config_set but the atomic version doesn't sleep

So you will set enable twice the clock.

This is confirmed when testing your series with virtio scmi backend as
I can see to consecutive scmi clk set enable request for the same
clock

In case of atomic mode, the clk_prepare should  be a nop

> +       .disable = scmi_clk_atomic_disable,
> +};
> +
> +static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
> +                            const struct clk_ops *scmi_ops)
>  {
>         int ret;
>         unsigned long min_rate, max_rate;
> @@ -110,7 +142,7 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
>         struct clk_init_data init = {
>                 .flags = CLK_GET_RATE_NOCACHE,
>                 .num_parents = 0,
> -               .ops = &scmi_clk_ops,
> +               .ops = scmi_ops,
>                 .name = sclk->info->name,
>         };
>
> @@ -145,6 +177,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
>         struct device_node *np = dev->of_node;
>         const struct scmi_handle *handle = sdev->handle;
>         struct scmi_protocol_handle *ph;
> +       const struct clk_ops *scmi_ops;
>
>         if (!handle)
>                 return -ENODEV;
> @@ -168,6 +201,11 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
>         clk_data->num = count;
>         hws = clk_data->hws;
>
> +       if (handle->is_transport_atomic(handle))
> +               scmi_ops = &scmi_atomic_clk_ops;
> +       else
> +               scmi_ops = &scmi_clk_ops;
> +
>         for (idx = 0; idx < count; idx++) {
>                 struct scmi_clk *sclk;
>
> @@ -184,7 +222,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
>                 sclk->id = idx;
>                 sclk->ph = ph;
>
> -               err = scmi_clk_ops_init(dev, sclk);
> +               err = scmi_clk_ops_init(dev, sclk, scmi_ops);
>                 if (err) {
>                         dev_err(dev, "failed to register clock %d\n", idx);
>                         devm_kfree(dev, sclk);
> --
> 2.17.1
>
