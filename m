Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251E95A8362
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiHaQlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiHaQlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:41:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB6A6F253
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:41:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x5so11400860qtv.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=1G1xSWfmfr1YBvtDVKOBLCFkOKdgEIYTug4kna7QRCM=;
        b=yspNSuxqrCcgBFcHPcu+G2ZvubWMqNwOdB0mtes6i4pEsPHt0OgXzj5+XFkmh/bYY1
         4dlx36w6d18YMcT23GQw8+2kjSkLQdR47gWAe+9TjphwclQ4Lc4XMopCVG2h0UgGVoYg
         EoXtKN2dUPv2eE5eOX36ynWujAwH2p+Sg24R0OLDCQUeZYb5gru6QP1CWqZPddgSDezG
         vbBqtslphksBHa7sOs/nbLEj+ka/NU4YWmKOff9OdlS4Ya1fm1ScN8s3OEMlmnJOMdkb
         5iyi8axnuIKEH1NcKRrQzPxW4AkknwiBgfjfCHScBhf9tpitTUuXZFM1y4eJSi/L5F1Q
         OyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=1G1xSWfmfr1YBvtDVKOBLCFkOKdgEIYTug4kna7QRCM=;
        b=TgqSbcEjM4H92gvFSul5jb6R5R0rJAxv1JCWv87rLlTEuPEcHZZ2ltfC9ckLZ37Y9T
         Q2jKv6ylxrsX9KI8ujnOEJv9wWN8uJRxjp8dtnUpCxVzBl2lc2JtiuSmkM7Pbvayl0vK
         KtLNXBLTdpqFx710dQhLwaL0GU6wHWxFMHJ/NTnzwqldASpCAEzAiGNpfBbdLq6a8n/w
         oAD3xNNTVdFpQ/ihvErCL27H0BM8B6l2SMfIW+lj6P1HgldaC0zvRAXhgZRHv+UD7QHf
         zQbUUkG3AQwnpx7m0ZcbbDMB13aPjdzOYSHN6sTGkVXDqIfiC9L/cAfhngB/3BIUO3X6
         xP7A==
X-Gm-Message-State: ACgBeo3xzNpYd2f9a3jk1mzQx0yrPkIBcHxY/tkKPOs2KYLy1wfV/lgU
        NEYsJTh0McNFzjntxu4tqQoTNESIqoTFJdeXkdwS/Q==
X-Google-Smtp-Source: AA6agR5wd9JjWwb12m2Ng/8FvHwP3ObMSs/4YavfZo4YeehPCH/KClCWcrOHIOy6l2QSGWHqJ3JAUH5IPFDqJCnpPac=
X-Received: by 2002:a05:622a:206:b0:344:a554:e555 with SMTP id
 b6-20020a05622a020600b00344a554e555mr20456486qtx.187.1661964100951; Wed, 31
 Aug 2022 09:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1650539846.git.robin.murphy@arm.com> <20220421141300.GC20492@lst.de>
 <665d2b46-c9e2-2543-cad5-9adf022e4bcb@arm.com> <CAMSo37XN3PC22JK4ot-B8gUxWOhK+UD-73Zb8LqvYpgPL1Bj6g@mail.gmail.com>
 <9ec5ba90-150a-c675-d95b-b13e3a4e9e10@arm.com> <CAMSo37XmxGn4VJJXwOca=mjHfmgYoh-i4bOs_DpP2LdjaN87wA@mail.gmail.com>
 <5c617d66-f04b-df26-bf7a-7f479d081ac2@arm.com>
In-Reply-To: <5c617d66-f04b-df26-bf7a-7f479d081ac2@arm.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Thu, 1 Sep 2022 00:41:29 +0800
Message-ID: <CAMSo37UUXd9FT1coAqgxU4urXi0NeCkONesmWqFfyrdDi+03dA@mail.gmail.com>
Subject: Re: [PATCH 0/3] More ARM DMA ops cleanup
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        arnd@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Robin

On Tue, 30 Aug 2022 at 23:37, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-08-30 16:19, Yongqin Liu wrote:
> > Hi, Robin
> >
> > Thanks for the kind reply!
> >
> > On Tue, 30 Aug 2022 at 17:48, Robin Murphy <robin.murphy@arm.com> wrote=
:
> >>
> >> On 2022-08-27 13:24, Yongqin Liu wrote:
> >>> Hi, Robin, Christoph
> >>>
> >>> With the changes landed in the mainline kernel,
> >>> one problem is exposed with our out of tree pvr module.
> >>> Like the source here[1], arm_dma_ops.sync_single_for_cpu is called in
> >>> the format like the following:
> >>>       arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
> >>> DMA_FROM_DEVICE);
> >>>
> >>> Not sure if you could give some suggestions on what I should do next
> >>> to make the pvr module work again.
> >>
> >> Wow, that driver reinvents so many standard APIs for no apparent reaso=
n
> >> it's not even funny.
> >>
> >> Anyway, from a brief look it seemingly already knows how to call the D=
MA
> >> API semi-correctly, so WTF that's doing behind an #ifdef, who knows?
> >> However it's still so completely wrong in general - fundamentally brok=
en
> >> AArch64 set/way cache maintenance!? - that it looks largely beyond hel=
p.
> >> "Throw CONFIG_DMA_API_DEBUG at it and cry" is about the extent of
> >> support I'm prepared to provide for that mess.
> >
> > For the moment, I do not care about the AArch64 lines, like if we only
> > say the following two lines:
> >      arm_dma_ops.sync_single_for_device(NULL, pStart, pEnd - pStart,
> > DMA_TO_DEVICE);
> >      arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
> > DMA_FROM_DEVICE);
> >
> > Could you please give some suggestions for that?
>
> Remove them. Then remove the #ifdef __arch64__ too, since the code under
> there is doing a passable impression of generic DMA API usage, as long
> as one ignores the bigger picture.

I tried with this method, and found that if I only update for the
pvr_flush_range
and the pvr_clean_range functions, the build still could boot to the
home screen.

but if I update all the pvr_flush_range, pvr_clean_range and
pvr_invalidate_range
functions with this method(remove the arm_dma_ops lines and the #ifdef
__arch64__ lines),
then a "Unable to handle kernel NULL pointer dereference at virtual
address 0000003c"
error is reported like here: http://ix.io/49gu

Not sure if you have any idea from the log, or could you please give
some suggestions
on how to debug it.

> arm64 already uses dma-direct. To say you don't care about the arm64
> code when asking how to deal with ARM having now been converted to use
> dma-direct as well is supremely missing the point.

Sorry for that, I am not familiar with the dma part, and just know
"dma-direct" from here,
will check how "dma-direct" should be used next, and check if there is
something wrong in
the pvr source code.
It would be appreciated if you could suggest some links on
"dma-direct" I can study with.

Thanks,
Yongqin Liu
> >
> >
> >>> Thanks in advance!
> >>>
> >>> [1]: https://android-git.linaro.org/kernel/omap-modules.git/tree/pvr/=
services4/srvkm/env/linux/osfunc.c?h=3Dandroid-mainline#n4615
> >>>
> >>> Thanks,
> >>> Yongqin Liu
> >>>
> >>> On Thu, 21 Apr 2022 at 22:35, Robin Murphy <robin.murphy@arm.com> wro=
te:
> >>>>
> >>>> On 2022-04-21 15:13, Christoph Hellwig wrote:
> >>>>> On Thu, Apr 21, 2022 at 12:36:56PM +0100, Robin Murphy wrote:
> >>>>>> Hi all,
> >>>>>>
> >>>>>> Thanks to Christoph's latest series, I'm reminded that, if we're g=
oing
> >>>>>> to give the ARM DMA ops some cleanup this cycle, it's as good a ti=
me as
> >>>>>> any to dust off these old patches and add them on top as well. I'v=
e
> >>>>>> based these on the arm-dma-direct branch which I assume matches th=
e
> >>>>>> patches posted at [1].
> >>>>>
> >>>>> All these do look sensible to me.  But weren't you working on repla=
cing
> >>>>> the ARM iommu dma_ops with dma-=D1=96ommu anyway?
> >>>>
> >>>> Yes, that's somewhat entangled with the IOMMU bus ops stuff, so I'll
> >>>> probably get to the point of having to revisit it in a couple of mon=
ths
> >>>> or so. These patches are off the bottom of that stack from my first
> >>>> attempt, where the aim was to make the current ops the same shape fi=
rst
> >>>> so that the switch is then easier to reason about (particularly in t=
erms
> >>>> of sounding out any issues with the hooking up of dev->dma_coherent,
> >>>> although your series will now be taking most of the load off there).
> >>>>
> >>>> Cheers,
> >>>> Robin.
> >>>
> >>>
> >>>
> >
> >
> >



--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
