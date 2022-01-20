Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161F0494824
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358992AbiATHQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358963AbiATHQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:16:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 23:16:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c66so9960704wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 23:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsD3k1h/nXxoPdyVVpQ8b0kr7k1JbcCpQdORRhv5nNk=;
        b=Pd9MXqHzmjLqLXrq8pGttPV02KvMxPcm0E6IecpykLhy9Qt2a9LDE6mj46syCuR2R5
         hP/tkpERNch28OfoU6o6fDZIAHGmtp0yw0VBVfzeIVB3X1gO8exiiNB8NkSdf3lHv9gQ
         B8X5zFcv4aJvHnnMbEHGDQ96Or2C0sWCA4+aUfHKUPEeH1efJ3VOZrv7fYndF3pn9BQm
         nSCAYepJlbmc2F6myG0VcUAM37BVvJWz3wtXpotv+hNS3XsWYtsYZRWeorJWwoQ8tNTg
         svU9EpimKH77lhZTTIAgv+0VV7edhg+pM2sukeJjb1XZFlGnxhASM+pN45huiD+L/q7p
         vJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsD3k1h/nXxoPdyVVpQ8b0kr7k1JbcCpQdORRhv5nNk=;
        b=UTyLh4hvrZpScmSaAyvlul20uUvAIwe5RrdomWYGCWX0qVFbMMRCZi/ArDpKnQ0dfJ
         ZI827LeQctQ2ca7BBOVWfKVtrBUbURlLRJguE5Ab15/LAiy9ZckBMJJgLFADc2HsY95X
         gJ0mZ1NdK+WzcTSFXfPm1vZ0MG401otEBISiLMdDL8S3DoBrfKSoT4AI45+YLZ6AQ1EX
         QKymeZ79V3fq0BMgnVoIGwljZC7e5u7OlF6LLDLiPTByH4Eu3CdCQJzyKNjSYD0PsIbZ
         OGQcXRjWBFu3J48RlX5iZ85B6pCyBagr6fQrtGeaRyAPyVmXQRmyx4XRXdvKGY1Ijwxc
         SeMw==
X-Gm-Message-State: AOAM531LFUI/YC+dxETszkWRc3+w1b3Zl1SuaCWGHiBnDYX3scYVi6U5
        7DIi8cJU2u/9OPm5na6ck/SPBfaxkkCDa7soXKQPbg==
X-Google-Smtp-Source: ABdhPJx5U4jr9wAtr1IWKyENq8OQEH+vZKcHFKhhWeMXvMi0q0I6HjNIdQdtUrzjKwdjSMNs8qU/ByGePsAqjXbO30c=
X-Received: by 2002:a05:6000:1146:: with SMTP id d6mr31052507wrx.497.1642663011221;
 Wed, 19 Jan 2022 23:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20220119080736.2940906-1-jens.wiklander@linaro.org> <bf3c1583f8d7466a96bab8feb462bb36@AcuMS.aculab.com>
In-Reply-To: <bf3c1583f8d7466a96bab8feb462bb36@AcuMS.aculab.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 20 Jan 2022 08:16:40 +0100
Message-ID: <CAHUa44EYeRy-xzmCvp5g276s4CT+wGBPR_cGDDBtjuzeeERSfw@mail.gmail.com>
Subject: Re: [PATCH] optee: add error checks in optee_ffa_do_call_with_arg()
To:     David Laight <david.laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 3:18 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jens Wiklander
> > Sent: 19 January 2022 08:08
> >
> > Adds error checking in optee_ffa_do_call_with_arg() for correctness.
> >
> > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/ffa_abi.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index d8c8683863aa..d88bd2e41572 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -619,9 +619,18 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
> >               .data2 = (u32)(shm->sec_world_id >> 32),
> >               .data3 = shm->offset,
> >       };
> > -     struct optee_msg_arg *arg = tee_shm_get_va(shm, 0);
> > -     unsigned int rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> > -     struct optee_msg_arg *rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
> > +     struct optee_msg_arg *arg;
> > +     unsigned int rpc_arg_offs;
> > +     struct optee_msg_arg *rpc_arg;
> > +
> > +     arg = tee_shm_get_va(shm, 0);
> > +     if (IS_ERR(arg))
> > +             return PTR_ERR(arg);
> > +
> > +     rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> > +     rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
> > +     if (IS_ERR(arg))
> > +             return PTR_ERR(arg);
>
> What's this duplicate test for?

Oh, that's a copy & paste error, I should have tested rpc_arg here.
I'll fix it in the V2.

Thanks,
Jens

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
