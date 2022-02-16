Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2D4B8DED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiBPQ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:26:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiBPQ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:26:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD229E94E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:26:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v4so2897227pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhaYDK+1Xr6t09RUwH9LeVyAOy0Iet12ql37UN6Cqhc=;
        b=huC9bfgtZYgR0waRD90zBZ7prMLMTt7FD+a2+9d2+TIBXgL2AW3c8Y015ZUo7lcaXB
         TdSot7kLqIIuKZjQh+E13tmxNcXdqTYm6+1xOabpaFwjOoMi+SwtASpEIrhbbYvbbDVR
         yNbiB2oA1/1UW936CyPSH6+nfK4N90eCDArpC70C06QsB64ySwEGaIJlTtq0z5zG9d0v
         f2d6KdwQObESSeE6YyI+i9sfl9ThC0In8Nab6u7HeGkN60np51jogEsJAksc8ocI3XTT
         qGOcdd7kwIGhFU75ArDBjllyGIdC8A02ZUw3cYiEHL0iMXQYYLgjMlmhFM0s1AL/HZ87
         0sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhaYDK+1Xr6t09RUwH9LeVyAOy0Iet12ql37UN6Cqhc=;
        b=eBWtzzGmtPKDabiNfzk6o58ooEGxV88sd+H2E6lc0PN/TMH4jeW9U0RoEuInbDLrqe
         UipUps52h8lSdrdmIRZDOnSTeXY/KLmiy2+/WTnpuLIH1JhAodw2Tu7LiJlFNIxvceaj
         CHCLDD58l8mAep/yQfT2tZNd8FdHGZeFjSycJvNq4N0eyCZwotZ3E093EvCF6CFpZ65W
         1BZKLt/Kd9MQjpBkRVA2JAuThKSjnLcTZcDL528iyeYdVIpNCHNCFbtoUs0KpQNtn6ET
         kyBOUictjYJ9MFeCOfYI6xBoW4GIarlJ1rosUGBTJ9vEJnviMoAEO1degxY1bMH1jFl1
         wm8A==
X-Gm-Message-State: AOAM533ndcmITDZHr0pDQf3FhpS6aAkHrKAbCa02u44HY/edGW1y30kT
        QPJU+RPa5vZou+m2nD1cTpRNalvMaQtmu6e395YZdQ==
X-Google-Smtp-Source: ABdhPJyFUOkJTyrN8eu8zcICrEiE34OEQNOcRXQ+qA8yo+FR28x8Y4H92pXGSQhwBQsV7Fb99hRe47pP0GdnEaG91iQ=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr3589396pll.132.1645028760530; Wed, 16
 Feb 2022 08:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
 <20220111161937.56272-3-pankaj.gupta.linux@gmail.com> <CAPcyv4gM99M8Waw9uEZefvpK0BsTkjGznLxUOMcMkGpk6SuHyA@mail.gmail.com>
 <CAM9Jb+iYXn+Diq-vou+_hXdxXLR9rEXm6GOsd2tZpAg9zXn1Fw@mail.gmail.com>
In-Reply-To: <CAM9Jb+iYXn+Diq-vou+_hXdxXLR9rEXm6GOsd2tZpAg9zXn1Fw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Feb 2022 08:25:48 -0800
Message-ID: <CAPcyv4iPhtbhAfpjCtbt9RGFOXuGCj-q3Gm_y7zaNk44Z7uq9Q@mail.gmail.com>
Subject: Re: [RFC v3 2/2] pmem: enable pmem_submit_bio for asynchronous flush
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jmoyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Pankaj Gupta <pankaj.gupta@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 12:39 AM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> > >
> > > Return from "pmem_submit_bio" when asynchronous flush is
> > > still in progress in other context.
> > >
> > > Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> > > ---
> > >  drivers/nvdimm/pmem.c        | 15 ++++++++++++---
> > >  drivers/nvdimm/region_devs.c |  4 +++-
> > >  2 files changed, 15 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > > index fe7ece1534e1..f20e30277a68 100644
> > > --- a/drivers/nvdimm/pmem.c
> > > +++ b/drivers/nvdimm/pmem.c
> > > @@ -201,8 +201,12 @@ static void pmem_submit_bio(struct bio *bio)
> > >         struct pmem_device *pmem = bio->bi_bdev->bd_disk->private_data;
> > >         struct nd_region *nd_region = to_region(pmem);
> > >
> > > -       if (bio->bi_opf & REQ_PREFLUSH)
> > > +       if (bio->bi_opf & REQ_PREFLUSH) {
> > >                 ret = nvdimm_flush(nd_region, bio);
> > > +               /* asynchronous flush completes in other context */
> >
> > I think a negative error code is a confusing way to capture the case
> > of "bio successfully coalesced to previously pending flush request.
> > Perhaps reserve negative codes for failure, 0 for synchronously
> > completed, and > 0 for coalesced flush request.
>
> Yes. I implemented this way previously, will revert it to. Thanks!
>
> >
> > > +               if (ret == -EINPROGRESS)
> > > +                       return;
> > > +       }
> > >
> > >         do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
> > >         if (do_acct)
> > > @@ -222,13 +226,18 @@ static void pmem_submit_bio(struct bio *bio)
> > >         if (do_acct)
> > >                 bio_end_io_acct(bio, start);
> > >
> > > -       if (bio->bi_opf & REQ_FUA)
> > > +       if (bio->bi_opf & REQ_FUA) {
> > >                 ret = nvdimm_flush(nd_region, bio);
> > > +               /* asynchronous flush completes in other context */
> > > +               if (ret == -EINPROGRESS)
> > > +                       return;
> > > +       }
> > >
> > >         if (ret)
> > >                 bio->bi_status = errno_to_blk_status(ret);
> > >
> > > -       bio_endio(bio);
> > > +       if (bio)
> > > +               bio_endio(bio);
> > >  }
> > >
> > >  static int pmem_rw_page(struct block_device *bdev, sector_t sector,
> > > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> > > index 9ccf3d608799..8512d2eaed4e 100644
> > > --- a/drivers/nvdimm/region_devs.c
> > > +++ b/drivers/nvdimm/region_devs.c
> > > @@ -1190,7 +1190,9 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
> > >         if (!nd_region->flush)
> > >                 rc = generic_nvdimm_flush(nd_region);
> > >         else {
> > > -               if (nd_region->flush(nd_region, bio))
> > > +               rc = nd_region->flush(nd_region, bio);
> > > +               /* ongoing flush in other context */
> > > +               if (rc && rc != -EINPROGRESS)
> > >                         rc = -EIO;
> >
> > Why change this to -EIO vs just let the error code through untranslated?
>
> The reason was to be generic error code instead of returning host side
> return codes to guest?

Ok, maybe a comment to indicate the need to avoid exposing these error
codes toa guest so someone does not ask the same question in the
future?
