Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5BE494C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiATLMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiATLMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:12:40 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903F4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:12:40 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id p7so2930223uao.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=kMjIpt1c5UKX7PMhTqHhaYPV9fI4F7FYowL5GOMYs44=;
        b=tvhKKbhfRUYInyIiGIV5u/96f/Zn6BZyUGMKxGENe8EXBb4F2V7wMUCXY5jgTU0YIr
         KGZiRSDEIYO7pVT7CnUvWo2FhVG83bdHOaLv5KPi+LqPCXz4hiUiqNfv+zYRCjVbUqu6
         tUEqPEdRxAaknOe1O78vlXUR483l0JYosJNUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=kMjIpt1c5UKX7PMhTqHhaYPV9fI4F7FYowL5GOMYs44=;
        b=uIkaVB2NBZy6FjXrjY6cPcQV9TThNJnTx3fGz+uKiLlMG2VIUJPt1EiSzdV5DoKuW1
         Eehb6UfGFuOmO1iZleqjZ+AjQdwCGf7v7KTpFwEePXWU2nj/l5RRog2JJnNyWKCDQtyr
         lrDsDJITqxmGQZdKbnjZLb7eAhuM3ISfjfKv6lPbEBROklnitSo96BwkySrocI+pWa1A
         OP7LiN3aasOIbW9qleqe6fFiC1aNllfGgFNIkFmnC32/nPbgDGYJYgEAUcCuXLjk46KF
         hmOuW+jLz+iv8agDIpfnHTJfBVzuK1ylvAxIly6Z1+dwYqtT54v/nBIqav8YobKLFzDn
         o1OA==
X-Gm-Message-State: AOAM531GE4dCqbJhRAgCY43C0NfoObJsqE3faKxj06v+r6EeOOql7hQz
        G+fOQ5Tq9GuasDOuYXEgdUgsVwYl7Hu9x3KUgF5cJ3F8hQpDtNRn
X-Google-Smtp-Source: ABdhPJxPvd0PThfv03SEpUww64Zb4UBGpIXRyKp92BrZVZyTlM5MOR6vAhcFdFjhNi7v17pf6fH0w6ae5M564YvMyP0=
X-Received: by 2002:ab0:6f90:: with SMTP id f16mr6800254uav.113.1642677159660;
 Thu, 20 Jan 2022 03:12:39 -0800 (PST)
MIME-Version: 1.0
References: <CAFr9PXnig9YfnwSzMg5UPm3UtAsEAQT_xVheBbLppiU45mc_QQ@mail.gmail.com>
 <Yeg8mi0S2ACy9q8O@phenom.ffwll.local>
In-Reply-To: <Yeg8mi0S2ACy9q8O@phenom.ffwll.local>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 20 Jan 2022 20:15:40 +0900
Message-ID: <CAFr9PXkUwfyZ9yJgNYHX5_jo_SFfDU9wKA3Ldf+hbVL23faqKQ@mail.gmail.com>
Subject: Re: [RFC] How to add hardware rotation, scaling etc to a DRM/KMS driver
To:     Daniel Palmer <daniel@0x0f.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, 20 Jan 2022 at 01:30, Daniel Vetter <daniel@ffwll.ch> wrote:
> > I got the feeling that maybe I should just provide an interface to the
> > blitter from userspace and userspace should be doing the rotation. I'd
> > like to do it in the kernel so stuff like SDL1 apps just work but
> > maybe that isn't possible?
>
> panel orientation property is for that stuff:
> fbcon will head this and rotate in sw,

This is working. On boot I get Tux rotated correctly etc.

> as should any competent compositor
> in userspace (but some might not, it depends).

That's the problem I guess. I don't have one. SDL1 apps like prboom
use the fbdev emulation as-is so they render upside down[0].
I have 16MB of local storage and 128MB of RAM so I don't think I'll
manage to get the standard userland bits onto it.

I wanted to do the rotation in the kernel so I didn't have to hack up SDL1.

Cheers,

Daniel

0 - https://twitter.com/linux_chenxing/status/1479801511274491909
