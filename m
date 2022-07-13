Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A040573DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiGMUmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiGMUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:42:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAD831232
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:42:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sz17so21916800ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qj46Expkx0Fdl04B5r2M/IKERzYmwL8GKHgYErVEHPU=;
        b=JHjdAbofUWwRVhvgVOiZ0qRn5y1paVSqD7wjLfExQOlWpAYCzmmWAhpXfp4DH25Pdr
         S/tTZ8eXCpU0d90H66vv6uX6XEeZwDh9ex84anB39Nz7x206N5/LYRYEGJ0Zj7Tqooc1
         T51wu8yoaY7wBIa8QoqJgSeDtn7JAEV6eEmjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qj46Expkx0Fdl04B5r2M/IKERzYmwL8GKHgYErVEHPU=;
        b=fYVT1v8S/a2BztGbcwLGP3Iw1rOQg/GtNLjRGo5fJxi25LrozB7x6QkBnamUqB5ksh
         6K8HWBcO4LapfNdfTMdy7gY9wrt1ibVEJIiOrFf6EXreseRZMTOSKdzO3rTOP5V3+vHQ
         3sg23Fx29ZodQbAr+f9v6ML2BSjRjea9aWpBCgXt70gpLJJEeCOdV2q8b30dLc9huHei
         nulEB8E1RdLjRWa97myGkGXZHfZwh+2QYzSsNpc7EjCJ2zHN8KH11Xw6MzYgk6yr2avG
         Tm4JJNXVvMagTcM06TbflD+I+zMuU9Ya68Qb6FWxOeNRpg0fWCAURAiVcqm7EcbIWkUF
         x7kg==
X-Gm-Message-State: AJIora9vbXfQGS6Uso4bZM/B8aexF199ZL4Ev+QGqJOiZi9rWVcFX0AR
        G7zA/HdU0jt90XaZIHD9fQni0lKMyHaCO6r2o0M=
X-Google-Smtp-Source: AGRyM1vB0RIuTLoqCq8KajenYUoi1yaHTzJQfEFnRKbuSLWquidV2NijemFg9a2DTSQhFUts6GuI4w==
X-Received: by 2002:a17:906:5305:b0:712:388c:2bf5 with SMTP id h5-20020a170906530500b00712388c2bf5mr5152582ejo.559.1657744954111;
        Wed, 13 Jul 2022 13:42:34 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id kz10-20020a17090777ca00b0072b40cb28a8sm4901415ejc.29.2022.07.13.13.42.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 13:42:32 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id z12so17116915wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:42:32 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr5060151wry.97.1657744951699; Wed, 13 Jul
 2022 13:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk> <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
In-Reply-To: <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jul 2022 13:42:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-SE=s+bJq_jwuQ6zfnifaAwYdXikpXo8iZ4JbbNph4Q@mail.gmail.com>
Message-ID: <CAHk-=wh-SE=s+bJq_jwuQ6zfnifaAwYdXikpXo8iZ4JbbNph4Q@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> That patch is (and has been) in linux-next for a long time,
> as commit d2ca1fd2bc70, and with the following tags.
>
>      Fixes: 7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
>      Reported-by: Guenter Roeck <linux@roeck-us.net>
>      Tested-by: Guenter Roeck <linux@roeck-us.net>
>      Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>      Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>
> So, yes, it fixes the problem. I don't know where it is pulled from, though.
> I thought that it is from Russell's tree, given his Signed-off-by:,
> but I never really checked.

Heh. Yeah, with that sign-off, I bet it's in Russell's queue, bit it
just ended up in the "for next release" branch. Russell?

                 Linus
