Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC449C705
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiAZKDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiAZKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:03:14 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D43C06161C;
        Wed, 26 Jan 2022 02:03:14 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a18so68006258edj.7;
        Wed, 26 Jan 2022 02:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88bX5phc4QD5WEP/ZiuDpl6z06FPpsvQ8tmIbTmmvfM=;
        b=JOOHPlvVkJI+l+SLmq8YHGPbVPhSP3jpctav1+zJyTBAuPq51FLOHTC6iu25uqbpk1
         gZ8UPPYNfw73crMI36sEKutbnpdbV1g61rwjWNBVY9SZ5PRXhNz2IMQqIcUw4mOIaHCh
         mwiQbl8mGpViRBfEgExjk48q+7kftZCnX5g4JrcCwTk4KwDkiv5ZN+RoSdz0xCCFTivp
         WTxX/fc1xqEDI6EXkK8niYFj0CUFtj9xsSS0vYAWk7c7FC9FpOJ0g8e2ZVQWwnMO+80a
         GC0uDztgNMPagLsCnlVtvAWVXh/fsxIS3JswqES6Y1jwWtcAc/HuwC7Iarha0ZnNGrKo
         3mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88bX5phc4QD5WEP/ZiuDpl6z06FPpsvQ8tmIbTmmvfM=;
        b=ZiqJ3T4sFtb3o4/ehgpLNnbNy9La/dfI5Sd+TiBlLLpfVEjQrIpBpazp2PaBXIlUPf
         sWjy0R7fCtNNkox9gj3wwnyDx/Nt9cHvI+i8FhDS7pwS51Nt+wqL1AWcuXgVIEDuctUI
         p/XRgcuPs0UXfTSl1CabnvzaG5ggaRzYT1zVOjS70ucCfjrcLlagiSquuRtWTau7fbN7
         RIlj1rkGTUPdmo3kyJYMoZpnAEoG9dnqPyU2z5hg4FAWxgSeY4mayXJ0wf2OPqCyfXpI
         NyRsLYdQqi34ygl/3H49x4OfQpb6j/HYn5c22jkzCQggg5Q06PbZjCsvhf9GlcwaK1WN
         jzOA==
X-Gm-Message-State: AOAM533n0wbLzisAZpI0vwagz4wm5UbR07saGMJVm4RjCldYlZMPIav9
        M4WXZ/xFxCEMnzIiNu08fgGIvAYtLoW5g72QB7o=
X-Google-Smtp-Source: ABdhPJw72+G5oWbFGdfMsLrwcGS/NyTH58SB7avPo0MWV7s1x0/JTHE5M0LGJ1I+tXGIVrnFSz5eE4YPZHT8G6BfGm0=
X-Received: by 2002:aa7:cf0e:: with SMTP id a14mr24216028edy.296.1643191392761;
 Wed, 26 Jan 2022 02:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com> <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
In-Reply-To: <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Jan 2022 12:02:36 +0200
Message-ID: <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Carlis <zhangxuezhi1@yulong.com>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:52 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 25.01.22 um 21:21 schrieb Andy Shevchenko:
> > Since we got a maintainer for fbdev, I would like to
> > unorphan fbtft (with the idea of sending PRs to Helge)
> > and move it out of staging since there is no more clean
> > up work expected and no more drivers either.
> >
> > Thoughts?

Thanks for sharing yours, my answers below.

> But why? We already have DRM drivers for some of these devices.

No, we do not (only a few are available).

> Porting
> the others to DRM is such a better long-term plan.  OTOH, as no one has
> shown up and converted them, maybe they should be left dead or removed
> entirely.

As I mentioned above there are devices that nobody will take time to
port to a way too complex DRM subsystem. But the devices are cheap and
quite widespread in the embedded world. I'm in possession of 3 or 4
different models and only 1 is supported by tiny DRM.

On top of that the subtle fact people forgot about FBTFT is that it
does support parallel interface (yes, I know that it's not performant,
but one of the displays I have is with that type of interface).

P.S. For the record, I will personally NAK any attempts to remove that
driver from the kernel. And this is another point why it's better not
to be under the staging.

-- 
With Best Regards,
Andy Shevchenko
