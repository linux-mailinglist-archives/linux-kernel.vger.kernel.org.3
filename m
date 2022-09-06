Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD6E5ADE3F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbiIFD5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbiIFD4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:56:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1B03D583;
        Mon,  5 Sep 2022 20:55:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso1372649pjq.1;
        Mon, 05 Sep 2022 20:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xjBsYojmgzjD37eDqYXmxvRKEdSztZBYdUrIaGIIl10=;
        b=qksH03T7nCTUYXBzcBx0isjdScmAbtWT/mIv3l7Qonsi45G+SbkTJa/mBJz+SqF6XR
         XSN17hEK7Z33up0g8jzBG4jdNfClrED1tTzPhAAruzXFTjOUv+wzCZlPyBI3F7aFbf3I
         OH4zn+ktG4vbXq8lmjr5GCLrb2ocq0seKWLQEIg2WPkxa9sqAJxzNjyXRzqoohJaoerA
         WuLBgckjDxCkqtC48wXTc1vK8yeX5uT/Izerc0movLufNrdDnKY4qQHoh/OpNM4o1zpr
         4EsBu//D/7IJCIIrmzY/BcNPIoM2ra4bL+3zQAsGbEmbY61mJYfLt8oRxDYsBg+rHtTV
         UvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xjBsYojmgzjD37eDqYXmxvRKEdSztZBYdUrIaGIIl10=;
        b=yHJiPxbdguFnik34SQgANtCK98oe/7a7h8p68i0zJGLEVfWqYzO58+uCJNmtjrbT/I
         pFUG4lZ6ZoAcbh5C/i+/cOOptw0Q8n/MyqH3z28e06f/tdwl9yj8chT5OXvT88jAXWi4
         GxMPZj5OZCXXTrHlPj+a+DJMQKJljAAy79LHkQ8H+5v2emvLsf9XxUF1I1pStzMn2fCt
         LQb5q+75LYe3zkuUciYH6rzBimsdy1vLNLm6kFKqaEiXZeKLJXg7c3uObN4B7TIv+K+l
         l7bGTP27tMKto6PDAoU5OhBsWxutoVl8oE8ywwCsFWY8Jflwo485Z3ky60SsPFQjtlrS
         mGpQ==
X-Gm-Message-State: ACgBeo3j2c+A/Z2ux2hgE+VjV80Fv58VK6yI71elbTtSQqukSmCmYAcK
        GkwpMx1CuZsa/p6jkDQKCOPm+Vw9Trn8tXEBzbvkSubU/JI=
X-Google-Smtp-Source: AA6agR6H58hrOM2YTuRRZs4nXTxjZQ1XqTlHuSc0NMqGDQTIlURZrBfNQEnp4HdS16uVVzDTWphHj/1uVONismTwu/w=
X-Received: by 2002:a17:902:cf0e:b0:172:60b7:777c with SMTP id
 i14-20020a170902cf0e00b0017260b7777cmr52953406plg.132.1662436538233; Mon, 05
 Sep 2022 20:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20170613234513.7624-1-s-anna@ti.com> <20170613234513.7624-3-s-anna@ti.com>
 <20170625201545.GA26155@builder> <1ccd9273-0fde-4241-6d99-1d03be2f5b57@ti.com>
In-Reply-To: <1ccd9273-0fde-4241-6d99-1d03be2f5b57@ti.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon, 5 Sep 2022 20:55:27 -0700
Message-ID: <CAKdAkRTHCmyYFX1yy8M1mTtT9D_h66Yj=0UUdEEwjCq4ia4z4Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] remoteproc/keystone: Add a remoteproc driver for
 Keystone 2 DSPs
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sam Nelson <sam.nelson@ti.com>
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

Hi,

On Mon, Jun 26, 2017 at 8:55 AM Suman Anna <s-anna@ti.com> wrote:
>
> Hi Bjorn,
>
> On 06/25/2017 03:15 PM, Bjorn Andersson wrote:
> > On Tue 13 Jun 16:45 PDT 2017, Suman Anna wrote:
> >
> >> +static int keystone_rproc_start(struct rproc *rproc)
> >> +{
> >> +    struct keystone_rproc *ksproc = rproc->priv;
> >> +    int ret;
> >> +
> >> +    INIT_WORK(&ksproc->workqueue, handle_event);
> >> +
> >> +    ret = request_irq(ksproc->irq_ring, keystone_rproc_vring_interrupt, 0,
> >> +                      dev_name(ksproc->dev), ksproc);
> >> +    if (ret) {
> >> +            dev_err(ksproc->dev, "failed to enable vring interrupt, ret = %d\n",
> >> +                    ret);
> >> +            goto out;
> >> +    }
> >> +
> >> +    ret = request_irq(ksproc->irq_fault, keystone_rproc_exception_interrupt,
> >> +                      0, dev_name(ksproc->dev), ksproc);
> >> +    if (ret) {
> >> +            dev_err(ksproc->dev, "failed to enable exception interrupt, ret = %d\n",
> >> +                    ret);
> >> +            goto free_vring_irq;
> >> +    }
> >
> > I do prefer that your request any resources during probe() and
> > potentially enable/disable them here. If below concern about using a
> > GPIO driver is cleared already I'll take it as is though.
> >
> > [..]
> >> +static void keystone_rproc_kick(struct rproc *rproc, int vqid)
> >> +{
> >> +    struct keystone_rproc *ksproc = rproc->priv;
> >> +
> >> +    if (WARN_ON(ksproc->kick_gpio < 0))
> >> +            return;
> >> +
> >> +    gpio_set_value(ksproc->kick_gpio, 1);
> >> +}
> >> +
> >
> > This doesn't sound like a gpio-controller and the GPIO maintainer did
> > reject an attempt by me to use the GPIO framework to abstract a similar
> > thing. Do you already have this driver upstream or have you clarified
> > with the maintainer that the GPIO framework is an acceptable abstraction
> > for this?
>
> Yeah, this has been upstream since quite some time. See commit
> 2134cb997f2f ("gpio: syscon: reuse for keystone 2 socs").

Sorry for the thread necromancy, but was it intentional that the
driver only parses DT to find this "GPIO" but never requests/reserves
it? I would like to drop of_get_named_gpio_flags() in favor of a more
standard dev_get_gpiod().

Thanks.

-- 
Dmitry
