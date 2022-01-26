Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C0F49CF40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbiAZQIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbiAZQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:08:17 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D07C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:08:16 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 9so117308iou.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DN8RvaHx5+77rk1/ysZjfhhFRASzKh3gGZwBlj41YRo=;
        b=nkLcw33OzZeDSgM/QdR+Uwjfl2uHPTsSuQARGXJ3DpzPJrZeFm9jTDuMOu+OGo6Mqo
         w60V3c73O+tVuA/TJlW7lMWrMUxiz3apgNPBHdp71o7RHa1/8SlQ3pnkj8zPUJxr05aC
         /DJlf9QXIck91Ui7drWLz++Sh0t55vLL+WIFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DN8RvaHx5+77rk1/ysZjfhhFRASzKh3gGZwBlj41YRo=;
        b=FBSDZX+tknUxh5mhbZyfP/GM2W7GxmITwEnlD7sVm4dVYI9d6eDrrleg3S8xiT+oVq
         3C9W3yf2NltNzTZEvUYObr8Ii4saMNM7Qzc/QQQUwBkmNAk+GSZ3vdnTBbZ1r0oAKODo
         0xGOkDISl9ifTm8cyJ/kpx5nuKrt1GGBE3CccHA3Vb6oxpZEznFA9MXJ8yqqY+YojC80
         D8pmFo2cvtkRkMPcQrUvXAp2DwhzzdTHMHMF65/7gY5VzRz8dwjh+bEOJR0locOPydEN
         YuEc5o8J50hy4L+xx9J0P2u8IkJOvkJCsqwF4DUDtMGiXzyJL6+OoVMYh7xD5dvSgUCC
         HBJw==
X-Gm-Message-State: AOAM532safWOgU4KGgnYu/rMZFazb63CtQVuEbybhFcyaFFiiBFk5gbq
        iAB/c3fvdd3zuBwTt4IThDD+vrTKewuCag==
X-Google-Smtp-Source: ABdhPJz15uMuCQhgrX9vUPulibi9qlqY+CVhgIlRLKtAQKPPNIq78XGWkaR2k9SAe1Hfb9u/YhnxHg==
X-Received: by 2002:a05:6602:1409:: with SMTP id t9mr14129760iov.166.1643213295520;
        Wed, 26 Jan 2022 08:08:15 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id g10sm1029246iov.22.2022.01.26.08.08.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 08:08:11 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id q204so78116iod.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:08:09 -0800 (PST)
X-Received: by 2002:a5e:de05:: with SMTP id e5mr1173380iok.136.1643213289315;
 Wed, 26 Jan 2022 08:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20220120064457.1.I337b8db7efaba8eb9c0ffd4da0d8c8133faf6f19@changeid>
 <CAD=FV=VEes8afsYDFT2z=AGeEPGqm93VzqK03aojePe=phH1BA@mail.gmail.com>
In-Reply-To: <CAD=FV=VEes8afsYDFT2z=AGeEPGqm93VzqK03aojePe=phH1BA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Jan 2022 08:07:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UQXr16pKphfTmJWe4hKqGZ2QzSA2FJvRoTF8pRk1KMkg@mail.gmail.com>
Message-ID: <CAD=FV=UQXr16pKphfTmJWe4hKqGZ2QzSA2FJvRoTF8pRk1KMkg@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: panel-edp: Add panels planned for sc7180-trogdor-pazquel
To:     Grace Mi <grace.mi@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 20, 2022 at 8:26 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jan 19, 2022 at 10:45 PM Grace Mi
> <grace.mi@ecs.corp-partner.google.com> wrote:
> >
> > From: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> >
> > We have added corresponding information:
> >     [BOE]NV116WHM-N45 use delay_200_500_e50
> >     [KDB]116N29-30NK-C007 use delay_200_500_e80_d50
> >     [STA]2081116HHD028001-51D use delay_100_500_e200
> > Add 3 panels & 2 delay.
> >
> > Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> > Signed-off-by: Grace Mi <grace.mi@ecs.corp-partner.google.com>
> > ---
> >
> >  drivers/gpu/drm/panel/panel-edp.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
>
> This looks good to me. I'll plan on landing it in drm-misc-next
> sometime next week unless there are objections.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

b889d89ad45f gpu: drm: panel-edp: Add panels planned for sc7180-trogdor-pazquel
