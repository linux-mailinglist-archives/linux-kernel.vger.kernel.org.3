Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC844BB1B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 06:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiBRF7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 00:59:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiBRF7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:59:02 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6DB244D93;
        Thu, 17 Feb 2022 21:58:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lw4so12464371ejb.12;
        Thu, 17 Feb 2022 21:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftCA005k+4z4Pn/cUNHF1sxE8voYgrk7CLJx5080AHg=;
        b=has8hS/+PxIq9gZ9azBn8lAqLaGNbBTw+3kG/ay+bRFzjrsSX1+dxzojOD8C1IutQI
         WlKVqz03hmJXhMu03pgLQ+byWNnJVZgKnTZnigU2EXdWAX2M4O2ZoqDAtmDQDCf4VSYA
         6paFdr9UIn7DsDbvr+rp3gVYWzKXoQP7/M7QLNlSfLYR42ys5ohoSlco2jPw81tuIYcv
         UknO/Zn7sGECGk76H+NbChGZ7yrJlN7/Mow1FP5Xe1KUG56u53CkFrqrFeTAi9jLeRHX
         CV8GxmqzfZnRyT6CQsivv6SeU5uvDqW/wRoAv4YxWktV40iEPeXqcaG7B27ofUzrFmCb
         Hrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftCA005k+4z4Pn/cUNHF1sxE8voYgrk7CLJx5080AHg=;
        b=ozmgkaOphsF+SnMMsqVrxh+l5lX8wHCwdIpe6NQ7Uk66NnEpYfIV/VYXR//99UvBFg
         32vHNBJauHpOjj+9+3d20e/2ZCm/xxfje0XE5s7cW5DIm1F5dIi+RsDArN2nD5A7eRsG
         kKSzNox4MeFesaMw3niU9BvXtm0OICg5dyTbmJLCYBJd2VcJ9xMfwsFgL8HNVfJsEoBv
         WysSWWaBZWKSYtDMwgsVCzQ1tYQiQpFywYZVG7CjYtAClS18HpDrkQBNSoYUat4O0iJp
         /88HLvRCCtT8AZ38vNUkXGNutQ0zJX1oFiJUwQtnUyKaCaOewzfQJkTrkt0yI3n2HaZ0
         GkWg==
X-Gm-Message-State: AOAM532uMKMc9Y7V36+C1SI+KcpZMu//VtO7IflA2HXnskguuj7ZI6/i
        02QuUr1kR3W2KhmDrmXb9qWxHnLXL27Sp17Xnj4=
X-Google-Smtp-Source: ABdhPJzo4P+2LEgz43AVcTOMFNy5xfrae0+6zjPu4ek3PLOD5/UjpNLUAW0XRLQ7VvE8k184El0It+Pcv4nTUN0wGWQ=
X-Received: by 2002:a17:906:b157:b0:6d0:9f3b:a6aa with SMTP id
 bt23-20020a170906b15700b006d09f3ba6aamr1017283ejb.365.1645163922367; Thu, 17
 Feb 2022 21:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20220217043950.749343-1-dzm91@hust.edu.cn> <b452f7a7-99fa-e023-9120-639b4110de73@xs4all.nl>
In-Reply-To: <b452f7a7-99fa-e023-9120-639b4110de73@xs4all.nl>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 18 Feb 2022 13:58:16 +0800
Message-ID: <CAD-N9QXyU+yGU15yJnnU=JOjKGFDfjY03xk70pHgx88BcBPASA@mail.gmail.com>
Subject: Re: [PATCH] media: hdpvr: call flush_work only if initialized
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-media@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Feb 17, 2022 at 8:05 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 17/02/2022 05:39, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > flush_work will throw one WARN if worker->func is NULL. So we should always
> > initialize one worker before calling flush_work. When hdpvr_probe does not
> > initialize its worker, the hdpvr_disconnect will encounter one WARN. The
> > stack trace is in the following:
> >
> >  hdpvr_disconnect+0xb8/0xf2 drivers/media/usb/hdpvr/hdpvr-core.c:425
> >  usb_unbind_interface+0xbf/0x3a0 drivers/usb/core/driver.c:458
> >  __device_release_driver drivers/base/dd.c:1206 [inline]
> >  device_release_driver_internal+0x22a/0x230 drivers/base/dd.c:1237
> >  bus_remove_device+0x108/0x160 drivers/base/bus.c:529
> >  device_del+0x1fe/0x510 drivers/base/core.c:3592
> >  usb_disable_device+0xd1/0x1d0 drivers/usb/core/message.c:1419
> >  usb_disconnect+0x109/0x330 drivers/usb/core/hub.c:2228
> >
> > Fix this by adding a sanity check of the worker before flush_work.
> >
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/media/usb/hdpvr/hdpvr-core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/hdpvr/hdpvr-core.c b/drivers/media/usb/hdpvr/hdpvr-core.c
> > index 52e05a69c46e..d102b459d45d 100644
> > --- a/drivers/media/usb/hdpvr/hdpvr-core.c
> > +++ b/drivers/media/usb/hdpvr/hdpvr-core.c
> > @@ -422,7 +422,8 @@ static void hdpvr_disconnect(struct usb_interface *interface)
> >       mutex_unlock(&dev->io_mutex);
> >       v4l2_device_disconnect(&dev->v4l2_dev);
> >       msleep(100);
> > -     flush_work(&dev->worker);
> > +     if (dev->worker.func)
> > +             flush_work(&dev->worker);
>
> I don't think this is the right fix. Instead, move the INIT_WORK line from
> hdpvr_start_streaming() to hdpvr_register_videodev(). That should initialize
> the worker struct from the start instead of only when you start streaming,
> as is the case today.

I see your point.

One small question: if we initialize worker at the beginning of
hdpvr_register_videodev, but without schedule_work, will flush_work at
hdpvr_disconnect lead to some issues?

Or we need to verify if the work is pending or running at hdpvr_disconnect?

>
> Can you try that?


>
> Regards,
>
>         Hans
>
> >       mutex_lock(&dev->io_mutex);
> >       hdpvr_cancel_queue(dev);
> >       mutex_unlock(&dev->io_mutex);
>
