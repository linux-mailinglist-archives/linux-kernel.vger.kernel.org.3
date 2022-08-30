Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1935A6725
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiH3PTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiH3PTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:19:18 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDCA12F126
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:19:16 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id j6so5144718qvu.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ErE2h2ikUjwAJRF5YAn/TaVcrYYPG5rOmrWOYf792P4=;
        b=IISREbF5QCkVLzPD6id0uyWT7nQuP2AiStwjf9JsOXG6qwN/EjhxibFu74qYhvxBn7
         JunZ/q4tRwSp+IehXlWFP3BusgUhPzhdAGTnho580C6vi/PRanW0+PfnIwvk1fwEeTaV
         EMH757TakLmx7NugnHLdU4kp41oLDnvMUtpGmsPEhcYwoHSBtPh6ID2vfxhg82HKN8fW
         atTEHzRKvWfsWAgipGPzum4V3x79qCHBfVcOKVio1cd9pH6vcit04G2c6ItF7zZm+3Lg
         UAWRjv2HDTaaQl9uL7Ee6hRvSncwX6yYL/dqfcbe6EaIf8qo7u9rg94jODdxAh7ODey3
         viNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ErE2h2ikUjwAJRF5YAn/TaVcrYYPG5rOmrWOYf792P4=;
        b=e3YMeXUYRJ2vKTHD+0EiA34HrLG6gH1ta5q+dlAdN8FSViqCA8F04vmQhCxZ3xLWXb
         czjs5ZxY+h9/qQtn4POayjR3Y6vryvgfD2GkMDaNy6x5jBU4PEa5rpab838aFo8oHDVe
         sZ1V0+weqcXXPZK1N1n/rLZy+rOy81jOQYzDADmUEgTJGL8BQBoppUmNTodPGbJAo4zu
         vGMxAt1ItCwfNqGjiO8XoXwaybdy5bBhNIW7qFdT0fPAORVnKpMFuRWHHpmPSn8rEYgD
         xYkTQ3Kj6uAjlyZoGmcDG89Qlj0Ezdq+40nkrdY/sO9PJmX06fS8O0fwPT/FxL4PoWN7
         VaWA==
X-Gm-Message-State: ACgBeo0L+tBOGFUpH2VrSr7y2rioBn6qvYqnNac5EeUGx2bKDrA9tbSh
        uOMOUcOdSsrrC8HzMCJu4KJGXlVvJdKdmQa6LXbuYA==
X-Google-Smtp-Source: AA6agR5vGE17KQl+1Ck0odoXZc6vLKS3hHi5OU9lbY2g2p/76LqwDze52lEtE/3rTQ6q7SQ5uEzFEpHK8frbIHtwp2s=
X-Received: by 2002:a05:6214:1c07:b0:499:1927:7dc7 with SMTP id
 u7-20020a0562141c0700b0049919277dc7mr401112qvc.28.1661872755483; Tue, 30 Aug
 2022 08:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1650539846.git.robin.murphy@arm.com> <20220421141300.GC20492@lst.de>
 <665d2b46-c9e2-2543-cad5-9adf022e4bcb@arm.com> <CAMSo37XN3PC22JK4ot-B8gUxWOhK+UD-73Zb8LqvYpgPL1Bj6g@mail.gmail.com>
 <9ec5ba90-150a-c675-d95b-b13e3a4e9e10@arm.com>
In-Reply-To: <9ec5ba90-150a-c675-d95b-b13e3a4e9e10@arm.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Tue, 30 Aug 2022 23:19:04 +0800
Message-ID: <CAMSo37XmxGn4VJJXwOca=mjHfmgYoh-i4bOs_DpP2LdjaN87wA@mail.gmail.com>
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

Thanks for the kind reply!

On Tue, 30 Aug 2022 at 17:48, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-08-27 13:24, Yongqin Liu wrote:
> > Hi, Robin, Christoph
> >
> > With the changes landed in the mainline kernel,
> > one problem is exposed with our out of tree pvr module.
> > Like the source here[1], arm_dma_ops.sync_single_for_cpu is called in
> > the format like the following:
> >      arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
> > DMA_FROM_DEVICE);
> >
> > Not sure if you could give some suggestions on what I should do next
> > to make the pvr module work again.
>
> Wow, that driver reinvents so many standard APIs for no apparent reason
> it's not even funny.
>
> Anyway, from a brief look it seemingly already knows how to call the DMA
> API semi-correctly, so WTF that's doing behind an #ifdef, who knows?
> However it's still so completely wrong in general - fundamentally broken
> AArch64 set/way cache maintenance!? - that it looks largely beyond help.
> "Throw CONFIG_DMA_API_DEBUG at it and cry" is about the extent of
> support I'm prepared to provide for that mess.

For the moment, I do not care about the AArch64 lines, like if we only
say the following two lines:
    arm_dma_ops.sync_single_for_device(NULL, pStart, pEnd - pStart,
DMA_TO_DEVICE);
    arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
DMA_FROM_DEVICE);

Could you please give some suggestions for that?

Thanks,
Yongqin Liu


> > Thanks in advance!
> >
> > [1]: https://android-git.linaro.org/kernel/omap-modules.git/tree/pvr/se=
rvices4/srvkm/env/linux/osfunc.c?h=3Dandroid-mainline#n4615
> >
> > Thanks,
> > Yongqin Liu
> >
> > On Thu, 21 Apr 2022 at 22:35, Robin Murphy <robin.murphy@arm.com> wrote=
:
> >>
> >> On 2022-04-21 15:13, Christoph Hellwig wrote:
> >>> On Thu, Apr 21, 2022 at 12:36:56PM +0100, Robin Murphy wrote:
> >>>> Hi all,
> >>>>
> >>>> Thanks to Christoph's latest series, I'm reminded that, if we're goi=
ng
> >>>> to give the ARM DMA ops some cleanup this cycle, it's as good a time=
 as
> >>>> any to dust off these old patches and add them on top as well. I've
> >>>> based these on the arm-dma-direct branch which I assume matches the
> >>>> patches posted at [1].
> >>>
> >>> All these do look sensible to me.  But weren't you working on replaci=
ng
> >>> the ARM iommu dma_ops with dma-=D1=96ommu anyway?
> >>
> >> Yes, that's somewhat entangled with the IOMMU bus ops stuff, so I'll
> >> probably get to the point of having to revisit it in a couple of month=
s
> >> or so. These patches are off the bottom of that stack from my first
> >> attempt, where the aim was to make the current ops the same shape firs=
t
> >> so that the switch is then easier to reason about (particularly in ter=
ms
> >> of sounding out any issues with the hooking up of dev->dma_coherent,
> >> although your series will now be taking most of the load off there).
> >>
> >> Cheers,
> >> Robin.
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
