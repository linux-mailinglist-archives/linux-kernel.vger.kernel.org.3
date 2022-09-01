Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8F65A8B2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiIACEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiIACEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:04:33 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20F5122BE4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:04:32 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r6so12417539qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=saPMMzuK3Ho4SUDDsCSKY8/njcHtrQrgxH2RFe9bLtY=;
        b=K9IDTvUvJFqhOsyyJMTui8J3nK54HCRWlFQ0E2R2CIXsDOGaEPoLRfixcVoGQ42Nai
         8fojjLOAuj6zDPY/I0YRch7xQz4Rjri5/GpCJhlQlouT66IK0PIxX3Md1KE64GytB5PJ
         NMw/7TQlKB78JKfav0Xn8sxyA/bNwKSndshAJd8S9Cv9sjTVDv6bYkuju2EuyZFFmWk6
         NVeNoS7u5cJ8d9Hug0VoEnXI3X1Le8ppuHPthxxjbSX+2mIBm3yUlxKNUeiHRKxPAmO4
         FIDZ0N5upArZ39fzCWiKhABpoEqStPHFtMLfTFP+Cr7hl7rIrf8hgb/uxkTzBGj2vRTe
         Pe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=saPMMzuK3Ho4SUDDsCSKY8/njcHtrQrgxH2RFe9bLtY=;
        b=oLYpUGRoUxe1RzBdMhqHt7VR6qPYdeP1tCE0ZdHf9caO8dD41rM3B401gU1ZxaR4gX
         v5XBuZIJIzGn5X45D45K+6Gv5g0pYLYPvXrUqyztVMh2hzhIPLnj99duSfwoqehuIgcp
         gHd/8DK1QSAF+RFsnbCvIfMH7WBnhJf2/yphmcItqAvQspvswQeW3+U+UQwPUv6zxDM0
         h4AzA2EevC1wxUebKmBLKIxIAuAOnKEy7BEo4Sl1IgWkuQRi34YWnPlKpJctutmjUy5p
         8a6eyXegWlKkg7775KvYwn6AlA1tGRB9ci2iZUeEGwiCytTjKNBZfh0OyfjRqAbDAKo0
         vf9A==
X-Gm-Message-State: ACgBeo3+5H8lsmPTq32LJQ6uBJ9D+YkY66rumhlOukj5UgsU1rsbsVq6
        iC/g0q8mu+Nd1rfeayIlQyPEYzvh2453k+mPSBj0hw==
X-Google-Smtp-Source: AA6agR6R6a9y6NVWlb8HXU/ybD+Q0Mnf5IJ7JiD8dpmIgIz7qgchladeggSJF9076AcPv4IxW6Y7O+QrOHrrGSgKZzw=
X-Received: by 2002:ac8:5853:0:b0:343:7b95:96ff with SMTP id
 h19-20020ac85853000000b003437b9596ffmr22411999qth.386.1661997872094; Wed, 31
 Aug 2022 19:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1650539846.git.robin.murphy@arm.com> <20220421141300.GC20492@lst.de>
 <665d2b46-c9e2-2543-cad5-9adf022e4bcb@arm.com> <CAMSo37XN3PC22JK4ot-B8gUxWOhK+UD-73Zb8LqvYpgPL1Bj6g@mail.gmail.com>
 <9ec5ba90-150a-c675-d95b-b13e3a4e9e10@arm.com> <CAMSo37XmxGn4VJJXwOca=mjHfmgYoh-i4bOs_DpP2LdjaN87wA@mail.gmail.com>
 <5c617d66-f04b-df26-bf7a-7f479d081ac2@arm.com> <CAMSo37UUXd9FT1coAqgxU4urXi0NeCkONesmWqFfyrdDi+03dA@mail.gmail.com>
 <6cc93088-981e-5c2d-a757-90508455aa42@arm.com>
In-Reply-To: <6cc93088-981e-5c2d-a757-90508455aa42@arm.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Thu, 1 Sep 2022 10:04:21 +0800
Message-ID: <CAMSo37Xszek-45WSEr3xtv0vWF8aB9rFNsStWHiXjKmc7p6VGg@mail.gmail.com>
Subject: Re: [PATCH 0/3] More ARM DMA ops cleanup
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        arnd@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 1 Sept 2022 at 01:10, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-08-31 17:41, Yongqin Liu wrote:
> > Hi, Robin
> >
> > On Tue, 30 Aug 2022 at 23:37, Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2022-08-30 16:19, Yongqin Liu wrote:
> >>> Hi, Robin
> >>>
> >>> Thanks for the kind reply!
> >>>
> >>> On Tue, 30 Aug 2022 at 17:48, Robin Murphy <robin.murphy@arm.com> wrote:
> >>>>
> >>>> On 2022-08-27 13:24, Yongqin Liu wrote:
> >>>>> Hi, Robin, Christoph
> >>>>>
> >>>>> With the changes landed in the mainline kernel,
> >>>>> one problem is exposed with our out of tree pvr module.
> >>>>> Like the source here[1], arm_dma_ops.sync_single_for_cpu is called in
> >>>>> the format like the following:
> >>>>>        arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
> >>>>> DMA_FROM_DEVICE);
> >>>>>
> >>>>> Not sure if you could give some suggestions on what I should do next
> >>>>> to make the pvr module work again.
> >>>>
> >>>> Wow, that driver reinvents so many standard APIs for no apparent reason
> >>>> it's not even funny.
> >>>>
> >>>> Anyway, from a brief look it seemingly already knows how to call the DMA
> >>>> API semi-correctly, so WTF that's doing behind an #ifdef, who knows?
> >>>> However it's still so completely wrong in general - fundamentally broken
> >>>> AArch64 set/way cache maintenance!? - that it looks largely beyond help.
> >>>> "Throw CONFIG_DMA_API_DEBUG at it and cry" is about the extent of
> >>>> support I'm prepared to provide for that mess.
> >>>
> >>> For the moment, I do not care about the AArch64 lines, like if we only
> >>> say the following two lines:
> >>>       arm_dma_ops.sync_single_for_device(NULL, pStart, pEnd - pStart,
> >>> DMA_TO_DEVICE);
> >>>       arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
> >>> DMA_FROM_DEVICE);
> >>>
> >>> Could you please give some suggestions for that?
> >>
> >> Remove them. Then remove the #ifdef __arch64__ too, since the code under
> >> there is doing a passable impression of generic DMA API usage, as long
> >> as one ignores the bigger picture.
> >
> > I tried with this method, and found that if I only update for the
> > pvr_flush_range
> > and the pvr_clean_range functions, the build still could boot to the
> > home screen.
> >
> > but if I update all the pvr_flush_range, pvr_clean_range and
> > pvr_invalidate_range
> > functions with this method(remove the arm_dma_ops lines and the #ifdef
> > __arch64__ lines),
> > then a "Unable to handle kernel NULL pointer dereference at virtual
> > address 0000003c"
> > error is reported like here: http://ix.io/49gu
> >
> > Not sure if you have any idea from the log, or could you please give
> > some suggestions
> > on how to debug it.
>
> Obviously there's almost certainly going to be more work to do on top to
> make the newly-exposed codepath actually behave as expected - I was
> simply making a general suggestion for a starting point based on looking
> at half a dozen lines of code in isolation.
>
> To restate the point yet again in the hope that it's clear this time,
> the DMA ops on ARM are now effectively the same as the DMA ops on arm64,
> and will behave the same way.
Thanks for confirming again here!

> Assuming the driver already works on
> arm64, then the aim should be to unify all the ARM and arm64 codepaths
> for things that involve the DMA API.

Thanks for the suggestion here, I will try to see if I could find
anything there.

> If you don't understand the code
> well enough to do that, please contact Imagination; I don't support
> their driver.
Will try to contact the maintainer of the PVR source, but as you could guess,
it might take quite a long time before it's fixed in the perfect way,
and before that
I need to have the build continue even with various workarounds based
on my limited undersanding:(

Thanks again for all the kind help and suggestions!


-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
