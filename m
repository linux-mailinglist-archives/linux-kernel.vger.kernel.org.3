Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25B94B1BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347168AbiBKCMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:12:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242403AbiBKCMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:12:01 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4D5FAE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:12:01 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id l14so7583752qtp.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06aBiVvbhWkfXru/N9K7na0D6XrgIVuslgTLZxvkDek=;
        b=WIcP552qomNEjdcOHaTSCGKmebrYHEM6VQ3xlCShI8mAoL9/+yUJ4p6Qa2rPVKvpP6
         XBPO1lzNE69XEFzLhdauJbuaQ/V+IzD49npN6nQh1i0bO1tdr0KM9eZ8xJJXGlaWzi6q
         Pve7GDkdE8luCalDrM/R3j+1rkDOyQHcXHCxw414yuTrDFnuRabFOeRExMPZL2zOB3t3
         JqQ2/8sd5USAJz7DEUqHuzQ3928MUlLqR7O0EcVsaqxu/rASzGBpb8kthUBAEmUlkcCk
         wjU19iPeylMGo0RYEmGkkuY5rFfc7r3Dpff+K8Uqb/PCUjy4wMm4+L93QWT6Dc1R7ntf
         WlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06aBiVvbhWkfXru/N9K7na0D6XrgIVuslgTLZxvkDek=;
        b=0MVpo3vfIGeJSKINlMDR1NhZVKljR5AJcpD7g3eqUHx1cuHhbN64OsC+9ERN+E4dFi
         2Hc0lIIx1itFli4KcQWnVs2CsOy/zdv3mR1UMREion9CyDAQqPd7NDnx174lKTLxqzle
         2B80z+m0YVVE8rDToJEuRgevSD3r/Y4MY8QGOps1OCwGmYjeh/j/LehsKIN6+3euljKv
         cyL/6JwahbIvVKWVzdalSjU4Bhvm+VEfNWuKWq1LZdkvhoXPwleZyoxvQN8JdPgankM9
         BdHEsGzsQKKWcIKgNTSFI76WAvt4ZXqEjzziybOhJsyoDBQrGic5hmcmoXbKFp6F1ett
         9x9w==
X-Gm-Message-State: AOAM530n5FmN2Kpxl8IploW+VZbly0Rc/M8eli8XIM9Vml9DbMOj/dKa
        ZztGzosIW2UmZK/NZzSpx2yTy6LXb8qqZFI0ZiOHag==
X-Google-Smtp-Source: ABdhPJwK7HH5Z3aPWfCQnRO7fXOlintpSX7+Wo3G/7vTfUrJgjQl/zb43Or4bBKvloZZ6EymgcbVxJMJZKXipywum74=
X-Received: by 2002:a05:622a:4d:: with SMTP id y13mr7092687qtw.629.1644545520212;
 Thu, 10 Feb 2022 18:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20220210224933.379149-1-yury.norov@gmail.com> <20220210224933.379149-9-yury.norov@gmail.com>
In-Reply-To: <20220210224933.379149-9-yury.norov@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 11 Feb 2022 05:11:45 +0300
Message-ID: <CAA8EJpqwtQ6JF5+Zhx89LhObue8D5c_OK1yqarQXmOBzpAbtGQ@mail.gmail.com>
Subject: Re: [PATCH 08/49] drm: replace bitmap_weight with bitmap_empty where appropriate
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
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

On Fri, 11 Feb 2022 at 02:09, Yury Norov <yury.norov@gmail.com> wrote:
>
> smp_request_block() in drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c calls
> bitmap_weight() to check if any bit of a given bitmap is set. It's
> better to use bitmap_empty() in that case because bitmap_empty() stops
> traversing the bitmap as soon as it finds first set bit, while
> bitmap_weight() counts all bits unconditionally.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
> index d7fa2c49e741..56a3063545ec 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
> @@ -68,7 +68,7 @@ static int smp_request_block(struct mdp5_smp *smp,
>         uint8_t reserved;
>
>         /* we shouldn't be requesting blocks for an in-use client: */
> -       WARN_ON(bitmap_weight(cs, cnt) > 0);
> +       WARN_ON(!bitmap_empty(cs, cnt));

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
>         reserved = smp->reserved[cid];
>
> --
> 2.32.0
>


-- 
With best wishes
Dmitry
