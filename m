Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821B852F4D5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353599AbiETVNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353595AbiETVNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:13:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7D5F135A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:13:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n10so17754890ejk.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5tfmEi05Xxp6dAU46ufHV2sPoKhSLRcQSmdSLO82mmA=;
        b=bA/NyeZJkA1hcMARgGoi/q6CxSZb4tZNUCU2SXUH09N5rv135UYjG5RiL08e98QaZF
         NIDWP0MjQkSWnDPFpM2qKUjPHNuJ/ehR4zvL7ebrBnqYtQLo7zmft+h3vEqrGGwyMA74
         WQoSa3DGbkfxVg8lmGeuisHCLuaTOSzltsN2TrXtllC/61Mdk4tju1sfAu/xQeYNWZex
         tz6pRHj5vNRbN7Co6i7gV6+4+bZhcD2rBiCZsPemvHbDopbhwfCTKM98kKdnLEn1MgEy
         1zCcGxm8mF/uw0lXTWu5s0kVMnYdtZJe+y0i9Q3glQNlBQgqkM0bpfONpICjraYnMrGd
         KUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5tfmEi05Xxp6dAU46ufHV2sPoKhSLRcQSmdSLO82mmA=;
        b=t88jl9CP34k/w4/Mhq+X8MIZF+x807ss805rX6fv0L7J3TwLHV3eRZJyAv9rcWWDhP
         9hJLX/pXNLwDkuQ6MeaQ6VW6MZC3dtuf8j/fzrxRj4DEq1lwmUIuwtJM7YqnG6JvOSYe
         +fSR52dTlkNRz4rwcg0jMQXnlVkbr6ie8Ezwo5Hsx+iBzXB2/jzobGS1p+/mu79lQXBi
         g+2X+Vdoj102nxQ/z4dxQCHPCux7YQGjR0pzRnLxpWF69W2TLjRU1nuMW3oOtT/aQCqn
         lzDlYdAJx4qgv6gcy1fAq7aI7nwRqq5dMP9FZM5WW3FtroOADiy8mPMPHvtauZr2Fslr
         L6Jw==
X-Gm-Message-State: AOAM530IWYsTc0nH3oH57qhZrtlxbktYHqi7SsK5dRLAywXGs9t0xrSg
        +V9NOLVoqjunt4WHHE0VG6QlbEeee6Dty33nw0mGwQ==
X-Google-Smtp-Source: ABdhPJyFNfBP1soSSW+7t14vdrjq1IQP8RcJSq0V3+aYaQxEfVyt7JYMA4eZujIkkMiueV9zFTA+HtvtZUjGyJAAOV4=
X-Received: by 2002:a17:907:6e18:b0:6fe:324a:65c1 with SMTP id
 sd24-20020a1709076e1800b006fe324a65c1mr10678202ejc.368.1653081184534; Fri, 20
 May 2022 14:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220516171315.2400578-1-tjmercier@google.com>
 <175c5af3-9224-9c8e-0784-349dad9a2954@amd.com> <CABdmKX2GcgCs1xANYPBp8OEtk9qqH7AvCzpdppj9rHXvMqWSAw@mail.gmail.com>
 <0875fa95-3a25-a354-1433-201fca81ed3e@amd.com> <CABdmKX1+VYfdzyVYOS5MCsr4ptGTygmuUP9ikyh-vW6DgKk2kg@mail.gmail.com>
 <YoM9BAwybcjG7K/H@kroah.com> <d820893c-fa2e-3bac-88be-f39c06d89c01@amd.com>
 <CABdmKX2m1b1kdACKM19S+u9uR5RTy1UGMRgd+3QA_oAyCpeggg@mail.gmail.com>
 <7f895a99-adfa-bcbd-c130-a924c668b8af@amd.com> <CABdmKX0XLvRZvXyiN0P_B-fUACiF5xwQ07+u_gaR+hDhu_x_TA@mail.gmail.com>
 <953d4a2c-bf0c-9a92-9964-eae445a8f113@amd.com>
In-Reply-To: <953d4a2c-bf0c-9a92-9964-eae445a8f113@amd.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 20 May 2022 14:12:53 -0700
Message-ID: <CABdmKX2dNYhgOYdrrJU6-jt6F=LjCidbKhR6t4F7yaa0SPr+-A@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: Move sysfs work out of DMA-BUF export path
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Minchan Kim <minchan@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        John Stultz <jstultz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:03 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 20.05.22 um 00:58 schrieb T.J. Mercier:
> > [SNIP]
> >>> Is there some other
> >>> solution to the problem of exports getting blocked that you would
> >>> suggest here?
> >> Well pretty much the same as Greg outlined as well. Go back to your
> >> drawing board and come back with a solution which does not need such
> >> workarounds.
> >>
> >> Alternatively you can give me a full overview of the design and explai=
n
> >> why exactly that interface here is necessary in exactly that form.
> >>
> > We ended up here because we could not use debugfs.
>
> [SNIP]
>
> > Another idea was adding per-buffer stats to procfs, but that was not
> > an option since per-buffer stats are not process specific.
> >
> > So it seemed like sysfs was an appropriate solution at the time. It
> > comes with a stable interface as a bonus, but with the limitation of 1
> > value per file this leads to creating lots of files in sysfs for all
> > dma buffers. This leads to increased kernfs lock contention, and
> > unfortunately we try to take the lock on the hot path.
>
> That's what I totally agree on about. debugfs is for debugging and not
> for production use.
>
> So either sysfs or procfs or something completely different seems to be
> the right direction for the solution of the problem.
>
> > With the description and links to the userspace code which actually
> > uses the feature I feel like that's a complete picture of what's
> > currently happening with this interface. If you could explain what
> > information is missing I'll do my best to provide it.
>
> Yeah, I've realized that I didn't made it clear what my concerns are
> here. So let me try once more from the beginning:
>
> DMA-buf is a framework for sharing device buffers and their handles
> between different userspace processes and kernel device. It's based
> around the concept of representing those buffers as files which can then
> be mmap(), referenced with a file descriptor, etc....
>
> Those abilities come with a certain overhead, using inode numbers,
> reference counters, creating virtual files for tracking (both debugfs,
> sysfs, procfs) etc... So what both drivers and userspace implementing
> DMA-buf is doing is that they share buffers using this framework only
> when they have to.
>
> In other words for upstream graphics drivers 99.9% of the buffers are
> *not* shared using DMA-buf. And this is perfectly intentional because of
> the additional overhead. Only the 3 or 4 buffers which are shared per
> process between the client and server in a display environment are
> actually exported and imported as DMA-buf.
>
> What the recent patches suggest is that this is not the case on Android.
> So for example overrunning a 32bit inode number means that you manage to
> created and destroy over 4 billion DMA-bufs. Same for this sysfs based
> accounting, this only makes sense when you really export *everything* as
> DMA-buf.
>
> So if that is correct, then that would be a pretty clear design issue in
> Android. Now, if you want to keep this design then that is perfectly
> fine with the kernel, but it also means that you need to deal with any
> arising problems by yourself.
>
> Pushing patches upstream indicates that you want to share your work with
> others. And in this case it suggests that you want to encourage others
> to follow the Android design and that is something I would pretty
> clearly reject.
>
Ok thank you, this is clear and I understand your position. Yes
Android does things a little differently. My team is actually hoping
to create a presentation on this topic explaining why things are the
way they are because these differences keep coming up in discussions.

The inode number rollover happened after running for two weeks, but
that's still around 300M a day which is extraordinary, so I think they
must have been stress testing. But yes the Android graphics stack does
make much more use of DMA-bufs than other users.

> >> Yeah and to be honest I have the strong feeling now that this was
> >> absolutely not well thought through.
> > I'm open to working on a replacement for this if we can't find an
> > acceptable solution here, but I would appreciate some direction on
> > what would be acceptable. For example Greg's idea sounds workable, but
> > the question is if it mergeable?
>
> Well one possibility would be to use cgroups. That framework needs to do
> accounting as well, just with an additional limitation to it.
>
> And there are already some proposed cgroup patches for device driver
> memory. While reviewing those both Daniel and I already made it pretty
> clear that it must be separated from DMA-buf, exactly because of the
> reason that we probably don't want every buffer exported.
>
Cgroups definitely would help out with per-application accounting.
Much nicer than parsing through procfs. For our use case this requires
associating the exporter name with the cgroup resource, which is part
of the data that comes from sysfs now. I have some patches which do
this, but this naming component is a point of contention at the
moment. Maybe it would be better to focus efforts on the problem of
how to categorize and aggregate (or not aggregate) graphics resources
for accounting with cgroups in a way that suits everyone's needs.

Thanks,
T.J.


> But to work on a full blown solution I need a better understanding of
> how your userspace components do.
>
> Regards,
> Christian.
