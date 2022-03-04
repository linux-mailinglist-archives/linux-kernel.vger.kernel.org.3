Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAEB4CCC6C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 04:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiCDD5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 22:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiCDD5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 22:57:06 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6902B17F69B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 19:56:19 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2dc28791ecbso64523307b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 19:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWaUg3F2U/pqV4pUNEN0rbZ56FgB7s4AJGWpyLnfhDs=;
        b=SkmBUdUEyd63NnxIhL+W4NcqfVmv0lmT/KsSWbKNydkDgdnVzNhkgO/Jl/mz5gbai8
         sai1ueISHv3oMK895w1EBM+EpnVNVB2tUlNrqJoN9C9ZodmAnYnPp/HKmfMN+/9ZSW4c
         x6ZUE5nbrDPUKkH1UQ6eoLYug9x30Me29bmZTIcgowz30YZ4QTq9c1H78+EdGUJcOiyv
         SO9AzZ53KLxU7rhY90K8xskcb8hXaM7tx8m8RWS2MbH1Jpv+4X7AO4BFX0v01aYAnNIH
         pN7tT6+F3MSuMwGvu1Mg8qKhZW2m+TMZRtjWcDB3uDUh38VXNEUWf1qp++AKmTQKXdnw
         PG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWaUg3F2U/pqV4pUNEN0rbZ56FgB7s4AJGWpyLnfhDs=;
        b=HYGvtIuKH3kM2xrLetfGKjznDxasb7bnNsOCStWPGl1VNSJyJw1PYhv66XyEVnFW5j
         Mimv49vxvJhvIibkMmbMbfecLoBIwGpK0a+cu6jQlgNXUhJHsjbJLFtKdubiaOpzeQBN
         IkDjftuYd3CFaAD7ifNFnsHUvbMoS9/A/urJb6gN6MlILBJOhXIIkVNtVY17+a8oTQPh
         d3aXjTkv4q4aJHMhjGk9T/bHbS1FuIMQ22tu2QfCuMZWgDOzq24/BfF6DK1T6hwpscZ8
         vSTt24STnz5ePxGh3SXxwYecfnGHLqFJTT0Hxd5rOzhu8DLh4gjd4om+uuTMmGmBgFHJ
         uyvg==
X-Gm-Message-State: AOAM532GW6vQCglLf60ve6D0/npWW8bi2VE3IdaL8PpwLz7nG8WMFVIQ
        qSY0Za5z+xVG8rVwasca+J1J7GLRN1fSpa5Yr7FpKw==
X-Google-Smtp-Source: ABdhPJwl01qeEi8ZkR2ZWt/Skjjfeo98B9lD//Jjd3iSZCL0yiMftVqcI5jWOkyY+7MVgWkArnVIJHJ7dg75OMcJW2k=
X-Received: by 2002:a81:b49:0:b0:2db:f472:dfca with SMTP id
 70-20020a810b49000000b002dbf472dfcamr14681560ywl.455.1646366178426; Thu, 03
 Mar 2022 19:56:18 -0800 (PST)
MIME-Version: 1.0
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <CAGETcx_yDtX0m4gVKahABvKamUtGg2adL1+6=gwb4U=KEhwm7w@mail.gmail.com> <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
In-Reply-To: <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 3 Mar 2022 19:55:42 -0800
Message-ID: <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Daniels Umanovskis <du@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 1:17 AM Peter Rosin <peda@axentia.se> wrote:
>
> On 2022-03-03 04:02, Saravana Kannan wrote:
> > On Wed, Mar 2, 2022 at 4:29 PM Peter Rosin <peda@axentia.se> wrote:
> >>
> >> Hi!
> >>
> >> I'm seeing a weird problem, and I'd like some help with further
> >> things to try in order to track down what's going on. I have
> >> bisected the issue to
> >>
> >> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> >
> > I skimmed through your email and I'll read it more closely tomorrow,
> > but it wasn't clear if you see this on Linus's tip of the tree too.
> > Asking because of:
> > https://lore.kernel.org/lkml/20210930085714.2057460-1-yangyingliang@huawei.com/
> >
> > Also, a couple of other data points that _might_ help. Try kernel
> > command line option fw_devlink=permissive vs fw_devlink=on (I forget
> > if this was the default by 5.10) vs fw_devlink=off.
> >
> > I'm expecting "off" to fix the issue for you. But if permissive vs on
> > shows a difference driver issues would start becoming a real
> > possibility.
> >
> > -Saravana
>
> Thanks for the quick reply! I don't think I tested the very tip of
> Linus tree before, only latest rc or something like that, but now I
> have. I.e.
>
> 5859a2b19911 ("Merge branch 'ucount-rlimit-fixes-for-v5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")
>
> It would have been typical if an issue that existed for a couple of
> years had been fixed the last few weeks, but alas, no.
>
> On that kernel, and with whatever the default fw_devlink value is, the

It's fw_devlink=on by default from at least 5.12-rc4 or so.

> issue is there. It's a bit hard to tell if the incident probability
> is the same when trying fw_devlink arguments, but roughly so, and I
> do not have to wait for long to get a bad hash with the first
> reproducer
>
>    while :; do cat testfile | sha256sum; done
>
> The output is typical:
> 78464c59faa203413aceb5f75de85bbf4cde64f21b2d0449a2d72cd2aadac2a3  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> e03c5524ac6d16622b6c43f917aae730bc0793643f461253c4646b860c1a7215  -
> 1b8db6218f481cb8e4316c26118918359e764cc2c29393fd9ef4f2730274bb00  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> 7d60bf848911d3b919d26941be33c928c666e9e5666f392d905af2d62d400570  -
> 212e1fe02c24134857ffb098f1834a2d87c655e0e5b9e08d4929f49a070be97c  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> 7e33e751eb99a0f63b4f7d64b0a24f3306ffaf7c4bc4b27b82e5886c8ea31bc3  -
> d7a1f08aa9d0374d46d828fc3582f5927e076ff229b38c28089007cd0599c645  -
> 4fc963b7c7b14df9d669500f7c062bf378ff2751f705bb91eecd20d2f896f6fe  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> 9360d886046c12d983b8bc73dd22302c57b0aafe58215700604fa977b4715fbe  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>
> Setting fw_devlink=off makes no difference, AFAICT.

By this, I'm assuming you set fw_devlink=off in the kernel command
line and you still saw the corruption.

If that's the case, I can't see how this could possibly have anything
to do with:
f9aa460672c9 ("driver core: Refactor fw_devlink feature")

If you look at fw_devlink_link_device(), you'll see that the function
is NOP if fw_devlink=off (the !fw_devlink_flags check). And from
there, the rest of the code in the series doesn't run because more
fields wouldn't get set, etc. That pretty much disables ALL the code
in the entire series. The only remaining diff would be header file
changes where I add/remove fields. But that's unlikely to cause any
issues here because I'm either deleting fields that aren't used or
adding fields that won't be used (with fw_devlink=off). I think the
patch was just causing enough timing changes that it's masking the
real issue.

IIRC (it's been more than a year), the series [1] that brings in this
patch has a few reverts. Those reverts undo subtle device probe
ordering changes brought in by a bunch of earlier patches. You could
go back to before those patches were added and see if you still see
this corruption and then start bisecting from there. Basically try
going to a point before:
42926ac3cd50 ("driver core: Move code to the right part of the file")

TL;DR: is that since you are reproducing this with fw_devlink=off, I'm
pretty sure the problem is not actually because of my changes or any
changes related to fw_devlink.

-Saravana
[1] - https://lore.kernel.org/all/20201121020232.908850-1-saravanak@google.com/

>
> So, just to double-check I went back to 5.11.22 with the two
> mentioned patches reverted [1], plus an added backport of
>
> c73960bb0a43 ("gpiolib: allow line names from device props to override driver names")
>
> in order to make userspace behave as similarly as possible.
> I left that running for an hour or so with 350-ish hashes
> calculated correctly. Which is no proof that there is no latent
> issue of course, but at the very least a great deal more stable
> than later kernels.
>
> Cheers,
> Peter
>
> [1]
> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> 2d09e6eb4a6f ("driver core: Delete pointless parameter in fwnode_operations.add_links")
>
