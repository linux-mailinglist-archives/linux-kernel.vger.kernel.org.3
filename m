Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0769E4AB354
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 03:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348698AbiBGCXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 21:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243784AbiBGCXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 21:23:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A953C061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 18:23:50 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id da4so4800689edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 18:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXI9E5PqGftIGHtK1JkXN0appM4C/3QrmDsDh/lkZPk=;
        b=KK/F6zNdWbcBaIgLDRZRgidluicwG6eK7um5snteDQceN1jf2D0WMZal9w1cQx/qIo
         U5T+Pby/YUe/5k5W+jyu6+wERUPNCSYg7HVoTfyf6VGRr19/RqFmB161Yq9KXd1OjPrs
         pW4dzwuq4tDTswTZ3RyBpy0LGIzGoFEh/z4oWsK4Mb42KFZQ03y4PNNgEC7xXArNzWgR
         AnFrsBzeOBf/gq1LgMWoXS9X4pZd2iNnEmKKpkMRCY2b2Ps/l+Pay/d65hYegooytKZ+
         SPqVeB/R2nxpG4jHpWuY39gH1Pzqvr88hS7BE3UMQ+/mUS+XabFMIUHilpDzNORLvqZQ
         Gtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXI9E5PqGftIGHtK1JkXN0appM4C/3QrmDsDh/lkZPk=;
        b=bZinEd2mmAzB1s1s8DXqEOtlHEJNtSqRxmpWa6V1Qy2VPp0R33kNhUO7Uff6YUkYzc
         QY2GzT9auupG6i6Yd8ZURxOaGbtpzEXTbRWUjmqi+LUmsaYiSU0doe2GfYAo2H2VsHYN
         U4TzWpR4mMkwkQq5KT6ULgdOZp/2a0iisLDt127QwAMJGKhxmHZL66N7tWOcKXZWVHuj
         A3AE7wvNurggVQeDcHgm6lBQrf1eZLMRvJVk8QuN+5J3rps6PbZuHkY+RylXq7ohG1xf
         tN+VS2mi/POz48HDGEi5Z9HCB/Gk8EhB8Os5EXzLLIYCcI8EOe316WGXCcLm5eJ6d4L6
         Jeuw==
X-Gm-Message-State: AOAM533kEIHA/7YRcuezKd/C+w8VUc7ZxFvCbRFoD59nESI2z0QuyCzm
        HJKxqRLo8nyQGRKapAfZzUZNwXxvVr2aU0MH2Sw=
X-Google-Smtp-Source: ABdhPJxoGUls4CJ5ZMogIj6HXRZaIRkx9splvmohCgDRWVtxYqJGQYDsmc0PjKxl5wlN9seajpjLvuhjG7cLWkaHbv8=
X-Received: by 2002:a05:6402:1d4b:: with SMTP id dz11mr11728728edb.202.1644200628947;
 Sun, 06 Feb 2022 18:23:48 -0800 (PST)
MIME-Version: 1.0
References: <20220117194836.vj2rxr3wocrtdx7k@treble> <20220117202751.bmwvfsnqxokob6d2@treble>
 <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com>
 <20220118175239.lqxi2ycgeusk5pxl@treble> <CAPDLWs_mirot76g==TPRZDsB6Qn99kxw2N5V=PaDYqBLf=ZSCQ@mail.gmail.com>
 <20220119212126.aydgx62abbngumwy@treble> <20220119234303.tmebbcrg2vpnri4s@treble>
 <CAPDLWs-DM64k6z3G7qgYwYm=F8piehYhLfaaXc3fDtnBBQiu=Q@mail.gmail.com>
 <20220120171751.gibauc4zovoskjns@treble> <CAPDLWs_28zYabLjsyT2gq-o6vEzidWB4mpGuUGdiYr0qb6YFWQ@mail.gmail.com>
 <20220206202859.butmvavyw3tce4hs@treble>
In-Reply-To: <20220206202859.butmvavyw3tce4hs@treble>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Mon, 7 Feb 2022 07:53:32 +0530
Message-ID: <CAPDLWs88HXMW_yPH4zC=XFz6p6aTJs55BoZCXYYPSmDwRBbdRg@mail.gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
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

On Mon, Feb 7, 2022 at 1:59 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Jan 21, 2022 at 01:35:13AM +0530, Kaiwan N Billimoria wrote:
> > > Try this one?
> >
> > Definitely better !
> > This is the o/p i now get:
> >
> > $ <...>linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko
> > do_the_work.cold+0x68/0x126
> > do_the_work.cold+0x68/0x126:
> > delay_sec at <...>/oops_tryv2/../../convenient.h:279
> > $
> >
> > The source file+line-no doesn't show up here though... (as it's a foo.cold()?).
> > (I'm unsure why the line delay_sec at <...>convenient.h:279   shows up
> > ; i don't call this delay_sec() func directly... anyway, that's my
> > problem.)
>
> Hm... do you get the same result with addr2line?

addr2line works correctly.
And, so does the patched faddr2line, when i tried it out now on
another VM! Lemme check some more and get back, thanks.
- Kaiwan.
>
>
> --
> Josh
>
