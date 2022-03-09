Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F78B4D25FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiCIBPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiCIBNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:13:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00DF15878F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:56:16 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k24so661919wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wbAfhbFyUGwe2Q5HZ4gVH7hz+BJKhZp/1dIJkpLWrYg=;
        b=oPAjcdMKk2cbLSR0NXJPl2YEmIHZ9WRBbKIrDfh1EAFvaUhr+N8XmHO6RLfSQ4jZIB
         HH32lTtvocQ3aFw0+L1BvytAwA00qmSTIRhPgYDW5bvxvuSckOReH75dbn6+SKgCti5W
         6LF0obtutW0ITI/xSxNCKm5Gt3nBWGqCujHICGD7c/dmBCY4nzn1nk6PbTBurljXT0NE
         WSuPGbUUGMW1XNsH+d5yNCdaFYBwn+X9XzNrAA8gSYwhbV5P1vbpukFZh6s3Zhx/OJkQ
         9AF2wYbYahKsOk8Xj+r1EUjiSfBvGdUh9E5s/TodiCnl4b2GW1PhAWSzW0p4RrC+Ehy2
         +/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbAfhbFyUGwe2Q5HZ4gVH7hz+BJKhZp/1dIJkpLWrYg=;
        b=2yG9Z0ODf+lU0o+3IKHSK6vg1cQSigBM0k5NL0BYC0me+bVaARTDEeSK5pSm4wwygO
         CkykCF+avG9R1y9v3gCFqKi/1MOcUVUqHcr23YJSkNOkaY542XqZB/4hmOMKBQ2UbAok
         3SchGHKzfRVCTEsudVOiZ6t43v3VC1rguUxYkdYLCzL2DXnsIg7mB6PP6ul2g2pVe/Mf
         qBYLKYiOB0CJrXMOhbWLi6EaqyzYSezoGh0kYfqCkB6zOGBBlb54TSpkdRe3hx1+4Edb
         aUBpisfaAzf3fsH0LhdgMrn9mdMsTyRKXxu7F3DGW63LofdXI9dqK9cWH0i99Noda4n+
         vlUw==
X-Gm-Message-State: AOAM530ou+ubRqRjI2iWPuRAMGWJZkruxxEB9mcuL4kiCiI1FAKsxSYx
        sqEgCtZ4ARvqhiMF7FlCSkgmY5WDllMZBbRzb6eLKCJZ
X-Google-Smtp-Source: ABdhPJxfgZD8CgR/7M44RNEKX6Cd7Bp3Q9o+CLYddiReGvJz3GUsWhptZe9HM1Nrq5JSZmuGN0pej2+BoxLRYImgyD8=
X-Received: by 2002:a5d:6344:0:b0:1f0:21ee:9705 with SMTP id
 b4-20020a5d6344000000b001f021ee9705mr13938132wrw.93.1646787375187; Tue, 08
 Mar 2022 16:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <CAF6AEGt=aVJ9nR+Wv+bJEFZrn-cNOSNXG1TaJr=Cx-FTgutwKA@mail.gmail.com>
 <d2290971-ea22-8203-631e-b896c76a994b@collabora.com> <CAF6AEGuR8B6z+z=VFQ6y01wbboYS_qpkghD1GYdLES_RZOW1wA@mail.gmail.com>
 <42facae5-8f2c-9c1f-5144-4ebb99c798bd@collabora.com>
In-Reply-To: <42facae5-8f2c-9c1f-5144-4ebb99c798bd@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 8 Mar 2022 16:56:43 -0800
Message-ID: <CAF6AEGtebAbWhkvrxzi4UBLdv2LJPQVPBzH-sXcACs7cxznQ8A@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rob Clark <robdclark@chromium.org>
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

On Tue, Mar 8, 2022 at 3:36 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 3/9/22 01:24, Rob Clark wrote:
> > On Tue, Mar 8, 2022 at 11:28 AM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> On 3/8/22 19:29, Rob Clark wrote:
> >>> On Tue, Mar 8, 2022 at 5:17 AM Dmitry Osipenko
> >>> <dmitry.osipenko@collabora.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> This patchset introduces memory shrinker for the VirtIO-GPU DRM driver.
> >>>> During OOM, the shrinker will release BOs that are marked as "not needed"
> >>>> by userspace using the new madvise IOCTL. The userspace in this case is
> >>>> the Mesa VirGL driver, it will mark the cached BOs as "not needed",
> >>>> allowing kernel driver to release memory of the cached shmem BOs on lowmem
> >>>> situations, preventing OOM kills.
> >>>
> >>> Will host memory pressure already trigger shrinker in guest?
> >>
> >> The host memory pressure won't trigger shrinker in guest here. This
> >> series will help only with the memory pressure within the guest using a
> >> usual "virgl context".
> >>
> >> Having a host shrinker in a case of "virgl contexts" should be a
> >> difficult problem to solve.
> >
> > Hmm, I think we just need the balloon driver to trigger the shrinker
> > in the guest kernel?  I suppose a driver like drm/virtio might want to
> > differentiate between host and guest pressure (ie. consider only
> > objects that have host vs guest storage), but even without that,
> > freeing up memory in the guest when host is under memory pressure
> > seems worthwhile.  Maybe I'm over-simplifying?
>
> Might be the opposite, i.e. me over-complicating :) The variant with
> memory ballooning actually could be good and will work for all kinds of
> virtio contexts universally. There will be some back-n-forth between
> host and guest, but perhaps it will work okay. Thank you for the suggestion.
>
> >>> This is
> >>> something I'm quite interested in for "virtgpu native contexts" (ie.
> >>> native guest driver with new context type sitting on top of virtgpu),
> >>
> >> In a case of "native contexts" it should be doable, at least I can't see
> >> any obvious problems. The madvise invocations could be passed to the
> >> host using a new virtio-gpu command by the guest's madvise IOCTL
> >> handler, instead-of/in-addition-to handling madvise in the guest's
> >> kernel, and that's it.
> >
> > I think we don't want to do that, because MADV:WILLNEED would be by
> > far the most frequent guest<->host synchronous round trip.  So from
> > that perspective tracking madvise state in guest kernel seems quite
> > attractive.
>
> This is a valid concern. I'd assume that the overhead should be
> tolerable, but I don't have any actual perf numbers.

jfwiw, MADV:WILLNEED is a *very* hot path for gl drivers, based on
some measurements I did a while back with various apps/benchmarks..
easily more than 10x the next most frequent ioctl (for MADV:WONTNEED
and MADV:WILLNEED each, so more than 20x combined.. but MADV:WONTNEED
can be async).

But if the balloon triggering shrinker approach works out, that would
be pretty great.. it seems like the easy option and doesn't require
adding new host kernel uabi :-)

BR,
-R

> > If we really can't track madvise state in the guest for dealing with
> > host memory pressure, I think the better option is to introduce
> > MADV:WILLNEED_REPLACE, ie. something to tell the host kernel that the
> > buffer is needed but the previous contents are not (as long as the GPU
> > VA remains the same).  With this the host could allocate new pages if
> > needed, and the guest would not need to wait for a reply from host.
>
> If variant with the memory ballooning will work, then it will be
> possible to track the state within guest-only. Let's consider the
> simplest variant for now.
>
> I'll try to implement the balloon driver support in the v2 and will get
> back to you.
>
> >>> since that isn't using host storage
> >>
> >> s/host/guest ?
> >
> > Yes, sorry, I meant that it is not using guest storage.
>
> Thank you for the clarification.
