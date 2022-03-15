Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ECB4D9C94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344575AbiCONsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348845AbiCONsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:48:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87B52E68;
        Tue, 15 Mar 2022 06:46:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a8so41434475ejc.8;
        Tue, 15 Mar 2022 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52KupTNckoTiW8mqVp3XaNIUEo5xHI2O53gUBo/w4bY=;
        b=QV37BBlCAFf8+y0GnPcl7xfC72mhwaTLyyn3UdPWnY/QgD3M6YXFlsTox+8Sr0aM50
         YKF8p/nicNpsxb16CkJ/Rgj/ZcVBDmz552ZTRZXKVtJX6Y1+JNZ3VesqXLUsmrIifYPE
         RCfaipaUkL8a4RODT7XzcMQRJVLZ8Om4tHUpKeiPf1spDLP0QX9u9gsHEKJfCzgurpIi
         EpLmEG7ztqvdwNX3HtwZ/I8yrE+13OqzXC5dFqYJQpC+pPMYvbbfsNxDK1eJ/CEuJWUz
         bn0vMJtpOL3Cwcp0E/e7RpYoG80dZwvmuKYthDYqVbVXiRDAdhaztY13RmCrX+HCk0Hf
         V9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52KupTNckoTiW8mqVp3XaNIUEo5xHI2O53gUBo/w4bY=;
        b=203r7F0SJGSGpvNAj7PzgaiDnFKn+3YOdr92DNaq7JWrZVxCgflWTXh9gGMnq70zvw
         tJGysimPzPIXfIfqvFAnO5GFAqwHiX2+liX7KbylJwmn2yKDxOGAo6WdsqOh/v2vl4n4
         IkCWn/PpGCCMeMZfq1yJr+L09q2Usp2/KwRz8QcHcYnGG9kL7zUMSKevcbPwjPqtUn0M
         AFrF2rX6LWsXRIVL4CZlO1Fq9mv05gYPABJvpmp8P5MR7guVF2tcs4nzO0xlwOuMHf+7
         UvMvzdiot9icer8wbnbAiOZi7HthyN7aJJT4io+NrmjroRo68Zccxhob+guz/WTRLRxO
         x9rw==
X-Gm-Message-State: AOAM53037+Ep8I+Vv3Hv1HfEdwCwojj0fmh5l5czKdzPVM9RaCFD/vLC
        9F2R12jYnq2VtHEE6nnHTCgqveAFsAJj64tVEJqV4poG3b8=
X-Google-Smtp-Source: ABdhPJx74T1WC4KSLoavOvF2J087dYXRj2sBoADsQZx4rR3MZwKXVin3AJ8oFLeTGhdwdWC7AmRRqGC45z63osz7Blo=
X-Received: by 2002:a17:907:e93:b0:6df:10b3:4fc0 with SMTP id
 ho19-20020a1709070e9300b006df10b34fc0mr1821009ejc.44.1647352012953; Tue, 15
 Mar 2022 06:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220315103813.84407-1-shreeya.patel@collabora.com>
 <CAHp75VdoN+iSu1GLnxWW9BtL-p9uF1sfAw3ZxkFWNpoo44+bZg@mail.gmail.com> <b22cea07-aa2e-f5b5-d5aa-071e1084f00b@collabora.com>
In-Reply-To: <b22cea07-aa2e-f5b5-d5aa-071e1084f00b@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Mar 2022 15:45:39 +0200
Message-ID: <CAHp75VfsenJ64tTMdAG=CRFkwWjxf5hKpWWSa4hRxkF4ReQdHg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: Restrict usage of gc irq members before initialization
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, krisman@collabora.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
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

On Tue, Mar 15, 2022 at 2:32 PM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
> On 15/03/22 4:30 pm, Andy Shevchenko wrote:
> > On Tue, Mar 15, 2022 at 12:38 PM Shreeya Patel
> > <shreeya.patel@collabora.com> wrote:
> >
> > Thanks for the update, my comments below.
> >
> >> gc irq members are exposed before they could be completely
> > gc --> GPIO chip
> >
> >> initialized and this leads to race conditions.
> > Any example here. like ~3-4 lines of the Oops in question?
> >
> >> One such issue was observed for the gc->irq.domain variable which
> >> was accessed through the I2C interface in gpiochip_to_irq() before
> >> it could be initialized by gpiochip_add_irqchip(). This resulted in
> >> Kernel NULL pointer dereference.
> >>
> >> To avoid such scenarios, restrict usage of gc irq members before
> > gc --> GPIO chip
> >
> >> they are completely initialized.
> > ...
> >
> >> +       /*
> >> +        * Using barrier() here to prevent compiler from reordering
> >> +        * gc->irq.gc_irq_initialized before initialization of above
> >> +        * gc irq members.
> >> +        */
> >> +       barrier();
> >> +
> >> +       gc->irq.gc_irq_initialized = true;
> > There are too many duplications. Why not simply call it 'initialized'?
> >
> >> -       if (gc->to_irq) {
> >> +       if (gc->to_irq && gc->irq.gc_irq_initialized) {
> > Why can't this check be added into gpiochip_to_irq() ?
> >
> >      if (!gc->irq.initialized)
> >          return -ENXIO;
> >
> > ...
>
>
> Because we don't want to return -ENXIO in case of race condition.
>
> It should return -EPROBE_DEFER similar to how we are doing when gc->to_irq
> is NULL.

> So in this case when both gc->to_irq = NULL and gc->irq.initialized = FALSE,
> we will be returning -EPROBE_DEFER.

This is not true. The return code relies on an IRQ chip which may be
assigned (not NULL).

> This will make sure that devices
> like touchscreen
> do not become fatal due to returning -ENXIO.

So, then you need to move it to to_irq() and return there deferred
probe with a good comment in the code.

> >> +       bool gc_irq_initialized;
> > Can you move it closer to .init_hw so it will be weakly grouped by
> > logic similarities?
> > Also see above.
>
> Thanks for your comments, I'll make the necessary changes and send a v3.

-- 
With Best Regards,
Andy Shevchenko
