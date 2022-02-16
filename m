Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FCF4B830C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiBPIjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:39:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiBPIjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:39:33 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CE810B201
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:39:21 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id s1so1307880iob.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJXMODhdBkf6vc06+F5pCVIh6APP23M3j8CKu88q15Q=;
        b=lbe3CEMY4Ub6K+wUXjtSitO/K59lr9Uwcr3f2MOly1/EFqOcdg9hh6zgANZJMnKb5t
         V0kqoetuywmUQaekwAvi9m9/9QFqN0hdHOU7Mw7h0i2/HgZ+zm+dI9cCWkwJBQZiqbRL
         e8DC14oGb66dR2Sg2M4m9CoXPiUV1p1EKAPNsHb9Qs9bVQOvzdV3p3Mn0AdMqDR7Qenm
         NjBRQUispRluhY2+I9XNvnNZ+PLbtHB7Tk0H88qMXvQzksmcbKuCCLGsxnY3ocE0U72W
         KOY35PYY2qMF/1MOnkfNHnz2hWVP5oy76EFp1eb3SVVS2dFP69GygTzMRJkQn7ACIm6m
         drXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJXMODhdBkf6vc06+F5pCVIh6APP23M3j8CKu88q15Q=;
        b=QPap2JNT90oP5bQbNSYyr53b10vO9P1KhoFOr2QRr4RtWDK6F8/o7KtsRGYXPsISpa
         zoV6DElii4SPbfa1y5QAr9Df9uHtI0d8q4jtDL3hoEHrfKvU+kr5rlQZc+mP3E4DYFKq
         3jvzTm8AqWtSFhnMw0GfEo+fR12LGy11OIhhqHERyY3S+ytFXkAnNTYCGcmMP5itYWwN
         Mric9NRTy6XRJmheCSW2rCUbYq/ZoZoAhUl9MAItWVTsAlsvgH6mZnxIng61LchEOIxq
         j4VKKEKLwwn625IVIaBM574pH3Wvk8/h3n6o+NeXsWXsMIo8EaZibuSh19YKHz5dtoBt
         nX5A==
X-Gm-Message-State: AOAM531t3bVYLNob5mE0FWAtf+XO1I62+/QdanntGj25V7TK26o4eZGq
        YwnomcGPYy0znJXocYZ2KJXne4FOJAHOPf9rdR8=
X-Google-Smtp-Source: ABdhPJzsgi7vs4zYUQ1swAAlrRQXus7Yogb4FnBlstHft4Vp4wbVq460y3slrxK9XiJLK3Tu1TfnHv5zSql+Sm8rqrs=
X-Received: by 2002:a02:a190:0:b0:314:ed7:c072 with SMTP id
 n16-20020a02a190000000b003140ed7c072mr1086474jah.130.1645000760419; Wed, 16
 Feb 2022 00:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
 <20220111161937.56272-3-pankaj.gupta.linux@gmail.com> <CAPcyv4gM99M8Waw9uEZefvpK0BsTkjGznLxUOMcMkGpk6SuHyA@mail.gmail.com>
In-Reply-To: <CAPcyv4gM99M8Waw9uEZefvpK0BsTkjGznLxUOMcMkGpk6SuHyA@mail.gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 16 Feb 2022 09:39:09 +0100
Message-ID: <CAM9Jb+iYXn+Diq-vou+_hXdxXLR9rEXm6GOsd2tZpAg9zXn1Fw@mail.gmail.com>
Subject: Re: [RFC v3 2/2] pmem: enable pmem_submit_bio for asynchronous flush
To:     Dan Williams <dan.j.williams@intel.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Return from "pmem_submit_bio" when asynchronous flush is
> > still in progress in other context.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> > ---
> >  drivers/nvdimm/pmem.c        | 15 ++++++++++++---
> >  drivers/nvdimm/region_devs.c |  4 +++-
> >  2 files changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index fe7ece1534e1..f20e30277a68 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -201,8 +201,12 @@ static void pmem_submit_bio(struct bio *bio)
> >         struct pmem_device *pmem = bio->bi_bdev->bd_disk->private_data;
> >         struct nd_region *nd_region = to_region(pmem);
> >
> > -       if (bio->bi_opf & REQ_PREFLUSH)
> > +       if (bio->bi_opf & REQ_PREFLUSH) {
> >                 ret = nvdimm_flush(nd_region, bio);
> > +               /* asynchronous flush completes in other context */
>
> I think a negative error code is a confusing way to capture the case
> of "bio successfully coalesced to previously pending flush request.
> Perhaps reserve negative codes for failure, 0 for synchronously
> completed, and > 0 for coalesced flush request.

Yes. I implemented this way previously, will revert it to. Thanks!

>
> > +               if (ret == -EINPROGRESS)
> > +                       return;
> > +       }
> >
> >         do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
> >         if (do_acct)
> > @@ -222,13 +226,18 @@ static void pmem_submit_bio(struct bio *bio)
> >         if (do_acct)
> >                 bio_end_io_acct(bio, start);
> >
> > -       if (bio->bi_opf & REQ_FUA)
> > +       if (bio->bi_opf & REQ_FUA) {
> >                 ret = nvdimm_flush(nd_region, bio);
> > +               /* asynchronous flush completes in other context */
> > +               if (ret == -EINPROGRESS)
> > +                       return;
> > +       }
> >
> >         if (ret)
> >                 bio->bi_status = errno_to_blk_status(ret);
> >
> > -       bio_endio(bio);
> > +       if (bio)
> > +               bio_endio(bio);
> >  }
> >
> >  static int pmem_rw_page(struct block_device *bdev, sector_t sector,
> > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> > index 9ccf3d608799..8512d2eaed4e 100644
> > --- a/drivers/nvdimm/region_devs.c
> > +++ b/drivers/nvdimm/region_devs.c
> > @@ -1190,7 +1190,9 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
> >         if (!nd_region->flush)
> >                 rc = generic_nvdimm_flush(nd_region);
> >         else {
> > -               if (nd_region->flush(nd_region, bio))
> > +               rc = nd_region->flush(nd_region, bio);
> > +               /* ongoing flush in other context */
> > +               if (rc && rc != -EINPROGRESS)
> >                         rc = -EIO;
>
> Why change this to -EIO vs just let the error code through untranslated?

The reason was to be generic error code instead of returning host side
return codes to guest?

Thanks!
Pankaj
>
> >         }
> >
> > --
> > 2.25.1
> >
> >
