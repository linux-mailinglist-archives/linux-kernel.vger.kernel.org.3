Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E5D4B5B71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiBNUtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:49:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiBNUtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:49:05 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4390F1275FF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:48:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f37so6711918lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAGH315FsgjXdEGosIxU9yIWVg26bgKxObDK7qxcQ9o=;
        b=EU778RaLDa/8FhJux3O09PvW3/LCZKPXp2DEFIoy3E0/73tubhMvN6FLWVL/0bcIJW
         kmCnl5Rc6b20E+xTOO/KCGrPDECOpDCo/nXmeIOuENhZ10zOy0IF3Ph387b1C8fJzq5D
         +WjvseaeLKZ8mgXil65+h1q2t7pc8gvHirSGUwM9w31eIQ4CFgJL4tlDfb98dwjLGGaI
         oKjbNkxktCSCXTv4prlhEbo9s9sT7DZTHxj6OpsP3QwYf4mqyLx0SJJnVML5/95sQgyb
         lYEW9dTjF6nZxRSHVkN/BN9o2g2BHt5B8QNM0gL8UjDYHW8ypcP+fBvoFUxYojQxDjSt
         GgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAGH315FsgjXdEGosIxU9yIWVg26bgKxObDK7qxcQ9o=;
        b=FgbtObHAM6Ru9BIw3Oy2X71RUgUbMfo3/vZuXURhlJIxFVnWNKWGx4okPOGvZ7inlQ
         zhJNrV2Xr9QTXzWqd98B42R5pZOkNv9t7et0CNcYbqDmB2KIUgJWgU8grumtZIZP0xKl
         oAYnV8tQACSztHTAJ/1ZxSYU716j6KlZH0XJiaG5Ob1aZ8PF7siIpTNcWILzMSVZGDz9
         WYTmfsMEU6Y5UFte2V/08byjVCECh8pUJr09XOqlUSNzcu6RBZumyNHDTqIp9R08A84y
         0OcLDzqrMCx3kXtOVEH1spGONLAOlYu7aS8OFyKLEzScQgP6M//vaxCPqbJpDLhrR/Se
         fMuA==
X-Gm-Message-State: AOAM531JgUJU5DR7ArvVJo08cATX32mcBP17Wj07mw3AFyNIi8MSpdCJ
        glWxtP07eSVEsXKOR5ATFPNbRo8G0NEfaT2xLcKGYUZQvm2TYQ==
X-Google-Smtp-Source: ABdhPJybrY+AtUQHWjp3j2rvRJhBPEQOOF5VWwSAKp+0WfViYgyz3tPMp/imOig+wlvQ20J5Rfsw3M7JV5CsRYOdaJU=
X-Received: by 2002:a05:6512:4012:: with SMTP id br18mr536955lfb.533.1644871042491;
 Mon, 14 Feb 2022 12:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20220211161831.3493782-1-tjmercier@google.com>
 <20220211161831.3493782-7-tjmercier@google.com> <Ygdfe3XSvN8iFuUc@kroah.com>
 <CAHRSSEwoJ67Sr_=gtSaP91cbpjJjZdOo57cfAhv3r-ye0da7PA@mail.gmail.com>
 <CAJuCfpHf=Ewm0e9kguY3MEGVHU_cyviVXByi0oQtq7kTtOOD=A@mail.gmail.com> <CAHRSSEzsn-EVKXTRfmpbPR9u0wNpdvdZoX64Tm_mB1DQMRSUPQ@mail.gmail.com>
In-Reply-To: <CAHRSSEzsn-EVKXTRfmpbPR9u0wNpdvdZoX64Tm_mB1DQMRSUPQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 14 Feb 2022 12:37:11 -0800
Message-ID: <CALAqxLVeLsv9ESCL2EoZQ8-tRgp0V+tmdYbkyakFetf=ewTH+A@mail.gmail.com>
Subject: Re: [RFC v2 6/6] android: binder: Add a buffer flag to relinquish
 ownership of fds
To:     Todd Kjos <tkjos@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "T.J. Mercier" <tjmercier@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:19 PM Todd Kjos <tkjos@google.com> wrote:
> On Mon, Feb 14, 2022 at 11:29 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > On Mon, Feb 14, 2022 at 10:33 AM Todd Kjos <tkjos@google.com> wrote:
> > >
> > > Since we are creating a new gpu cgroup abstraction, couldn't this
> > > "transfer" be done in userspace by the target instead of in the kernel
> > > driver? Then this patch would reduce to just a flag on the buffer
> > > object.
> >
> > Are you suggesting to have a userspace accessible cgroup interface for
> > transferring buffer charges and the target process to use that
> > interface for requesting the buffer to be charged to its cgroup?
>
> Well, I'm asking why we need to do these cgroup-ish actions in the
> kernel when it seems more natural to do it in userspace.
>

In case its useful, some additional context from some of the Linux
Plumber's discussions last fall:

Daniel Stone outlines some concerns with the cgroup userland handling
for accounting:
  https://youtu.be/3OqllZONTiQ?t=3430

And the binder ownership transfer bit was suggested here by Daniel Vetter:
  https://youtu.be/3OqllZONTiQ?t=3730

thanks
-john
