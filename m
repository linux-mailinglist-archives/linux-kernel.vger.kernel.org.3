Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A934B7EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbiBPDes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:34:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBPDer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:34:47 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA6FFFF8C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:34:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id p23so994293pgj.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNEQbX7Cj1rLSUqainzZr7y+UqvteHBg1pncfSDBI3k=;
        b=caJo9iQpPyQndEH8t/TtZgVuvQs22W8ChZtpwz4wZ3RAkyQTwRiJJabOoIsohB6wiQ
         0DNIGiie+oouidsCrrJbAsT+gbJhOve1QLyxQ23wQ+1ehTetEFomDe8jrVh4lPsmPU1k
         zDSb1AWpLqGL5KRx42diDUkQZXncQytm8MdeXia6uPexwMxq22luAg60sMefZvz7WJxA
         1RGLQxxbJ0A11J9UPbqvTGB2/zu+yz7T04+ze4aGeyODubIGEri5xS4vhqdTrOZlwBZ1
         9FYdZI8vkBsVmLQLya4lm+l782oJOZZP5a5HoqeMXM74NYgbW/ZI5ssG5WxFcfWvj/Tc
         LBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNEQbX7Cj1rLSUqainzZr7y+UqvteHBg1pncfSDBI3k=;
        b=orXgQBlx1ld/bfNHbt2jFQKivc5UT3or7wHYgfIgs6u+BB54E8nmoKKVtbgyZvtdCX
         iXs3H5ZANwJIlUkY61TyXUBZYtKixfnWt+9CTIglyUvQA+Lr2gbEh8HXCC2UFOFFjz8P
         d7gv2wmRJG0A3HVy2stVFglUumG7pj4qDcSfROBN/Chdu3RKxI6MDdWdI41geaviOGvg
         gebL6KGDmyYhcSId1aWZa6acSBkMT5zLr4ZZow36dZuQzyq2DgY3vTMaXzJ+3lYyZqa1
         fm36+Vrx5VcF0puVU0mjlA3o6MZEL4EcTa3QUbyScJQUmWMQjDMvux2oVqsdHL22UeKA
         ITbg==
X-Gm-Message-State: AOAM5323/81tt9ZXEw9UMB5mllLmjcRc2hGiVGHviF14IebcblqwFwdD
        9oScv5RBdTgNl7dGASvK6T1gjLVksiysGdNcX7DvDtbeQZA=
X-Google-Smtp-Source: ABdhPJyW5VadiIqwRQ3iKfUXmEC5cECaeAdHWWepcPZds282RWLRRT48Qng+4A1cZK9GKSDl7THuSiMwL+NG5Ttwo/o=
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id
 s10-20020a056a0008ca00b004e02ed35630mr1067520pfu.3.1644982475928; Tue, 15 Feb
 2022 19:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com> <20220111161937.56272-3-pankaj.gupta.linux@gmail.com>
In-Reply-To: <20220111161937.56272-3-pankaj.gupta.linux@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 19:34:24 -0800
Message-ID: <CAPcyv4gM99M8Waw9uEZefvpK0BsTkjGznLxUOMcMkGpk6SuHyA@mail.gmail.com>
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

On Tue, Jan 11, 2022 at 8:21 AM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> Return from "pmem_submit_bio" when asynchronous flush is
> still in progress in other context.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> ---
>  drivers/nvdimm/pmem.c        | 15 ++++++++++++---
>  drivers/nvdimm/region_devs.c |  4 +++-
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index fe7ece1534e1..f20e30277a68 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -201,8 +201,12 @@ static void pmem_submit_bio(struct bio *bio)
>         struct pmem_device *pmem = bio->bi_bdev->bd_disk->private_data;
>         struct nd_region *nd_region = to_region(pmem);
>
> -       if (bio->bi_opf & REQ_PREFLUSH)
> +       if (bio->bi_opf & REQ_PREFLUSH) {
>                 ret = nvdimm_flush(nd_region, bio);
> +               /* asynchronous flush completes in other context */

I think a negative error code is a confusing way to capture the case
of "bio successfully coalesced to previously pending flush request.
Perhaps reserve negative codes for failure, 0 for synchronously
completed, and > 0 for coalesced flush request.

> +               if (ret == -EINPROGRESS)
> +                       return;
> +       }
>
>         do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
>         if (do_acct)
> @@ -222,13 +226,18 @@ static void pmem_submit_bio(struct bio *bio)
>         if (do_acct)
>                 bio_end_io_acct(bio, start);
>
> -       if (bio->bi_opf & REQ_FUA)
> +       if (bio->bi_opf & REQ_FUA) {
>                 ret = nvdimm_flush(nd_region, bio);
> +               /* asynchronous flush completes in other context */
> +               if (ret == -EINPROGRESS)
> +                       return;
> +       }
>
>         if (ret)
>                 bio->bi_status = errno_to_blk_status(ret);
>
> -       bio_endio(bio);
> +       if (bio)
> +               bio_endio(bio);
>  }
>
>  static int pmem_rw_page(struct block_device *bdev, sector_t sector,
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 9ccf3d608799..8512d2eaed4e 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1190,7 +1190,9 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
>         if (!nd_region->flush)
>                 rc = generic_nvdimm_flush(nd_region);
>         else {
> -               if (nd_region->flush(nd_region, bio))
> +               rc = nd_region->flush(nd_region, bio);
> +               /* ongoing flush in other context */
> +               if (rc && rc != -EINPROGRESS)
>                         rc = -EIO;

Why change this to -EIO vs just let the error code through untranslated?

>         }
>
> --
> 2.25.1
>
>
