Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE72497E56
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiAXLzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiAXLzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:55:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7E3C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 03:55:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id f17so13089373wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 03:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPFbfrHJ6YrXapqN6K+le3Ltd/e6LaT+IHt+F0E8NmE=;
        b=qJ+dcUMbd6zqqDcRVuIf2EzIHMBdWtsgv0Yso0AiNQkIbV5IUPQOAV9dJY19FXq0cG
         FOUk24NOyTdb5c7Of+bfsr+LAQ9ZFZo7xULqrKSryYBobwOw+Gp25HwmLeHFy6r6vZ2n
         h0Xr6OgIMob8SVm9IHIjUg+dFqtEjSL0ctSzRi7JPOaa/8d+kZxCBm24xwoAtnEl73+K
         QMIp17ggV/oTnByqlJdZxNoMR4302aWnDnrE55o5omgGwUgSIbO9v5MAOWIQtDXx553q
         lGr4NIHI2lyIEZuHB9IPghxeOUZhi8uFtD/y/Ey3yrDg08R4cgy8GPdaM+3zK9Unjezy
         +tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPFbfrHJ6YrXapqN6K+le3Ltd/e6LaT+IHt+F0E8NmE=;
        b=otZg+C84ZyGAL5canrheDFL2U0fXwLpGy+0b8b4KEddXR0Sa3r4mrZP2E0tJSu7c3X
         /ukqrhsQICu3XZpTq9f3Con+RcFKIYdXurT3v4qXHYxGmGZMskUIHBGpQhq884Z2a7dQ
         Zys2qqnXdvjUZRjDMlD6zkkwdpX+b2NamzSS7gM6FN1Xel1RvjDMpTHRJvARuggvWt43
         Qgd7rOh2qu1dVGhmlMQMJwRtYkJ12zD1TwSLnhMNXWD1+MlptXes9gMie/QDUeSbQdoc
         X+X0BvpyOgzLqa0+SKsSOXnM8dUuna6lzQju52KVrLleV8UshDM38pobk0WxmdjHqhYq
         HOKg==
X-Gm-Message-State: AOAM532ZtPod9s+UkI18dB/pf4wgZgjj+Ajz+ULi8tI5Gn1F/yrglm2N
        sFuD7D41DT5rNsfAtmnUpUgE0cvTJAFJkJi8i5c9gAC4zGc=
X-Google-Smtp-Source: ABdhPJygh4ndxuIUIDoHBPdynyoouvtJaW1vhxFPfdQK9E08zK4F3+ACis9LGr+K5s5V09OwuUMZXHpCZ4eNNpBcisc=
X-Received: by 2002:adf:c843:: with SMTP id e3mr14327737wrh.38.1643025306645;
 Mon, 24 Jan 2022 03:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20220120074232.1084967-1-jens.wiklander@linaro.org> <CAFA6WYO=9Rw7R+QEgunjtdM=63L1AzYxx26452=+uj7SuPiE7Q@mail.gmail.com>
In-Reply-To: <CAFA6WYO=9Rw7R+QEgunjtdM=63L1AzYxx26452=+uj7SuPiE7Q@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 24 Jan 2022 12:54:56 +0100
Message-ID: <CAHUa44Gtwwx4+8QS9UiVGp+2FnZuPjFnZaZ+_Tt8VJnq308gQA@mail.gmail.com>
Subject: Re: [PATCH v2] optee: add error checks in optee_ffa_do_call_with_arg()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        David Laight <david.laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:18 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 20 Jan 2022 at 13:12, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Adds error checking in optee_ffa_do_call_with_arg() for correctness.
> >
> > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/ffa_abi.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index 20a1b1a3d965..0775759a29c0 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -619,9 +619,18 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
> >                 .data2 = (u32)(shm->sec_world_id >> 32),
> >                 .data3 = shm->offset,
> >         };
> > -       struct optee_msg_arg *arg = tee_shm_get_va(shm, 0);
> > -       unsigned int rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> > -       struct optee_msg_arg *rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
> > +       struct optee_msg_arg *arg;
> > +       unsigned int rpc_arg_offs;
> > +       struct optee_msg_arg *rpc_arg;
> > +
> > +       arg = tee_shm_get_va(shm, 0);
> > +       if (IS_ERR(arg))
> > +               return PTR_ERR(arg);
> > +
> > +       rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> > +       rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
> > +       if (IS_ERR(rpc_arg))
> > +               return PTR_ERR(rpc_arg);
> >
> >         return optee_ffa_yielding_call(ctx, &data, rpc_arg);
> >  }
> > --
> > 2.31.1
> >
