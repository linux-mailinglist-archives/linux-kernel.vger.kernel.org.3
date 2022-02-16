Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263D24B8DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiBPQXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:23:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiBPQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:23:44 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D588021FC43
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:23:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m7so2917953pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0HINq0/oRgYesXUSAlumWGA0q6P8NqHQhhmtUR68N4=;
        b=J9YwKXa69Vx93oiJ1A6rlmnGuFdnsxujdFBTp7p5n2AVfGclIZJedCzdp3JuNllZ5p
         /4DwwtInokF0YaJpFjG8OP4VoaXb54xKiINkKTUf3s8lKp/It+QnvmSoKoX6hk37yxbP
         20FWPOBPewVz6VIBvoDV0nV1jdNJYCrl1VTskEJko/ycBtHwRMwS3ssIUlbbPEKnd+fU
         n8ksrm06t4LoVbQUj+bwgem0q8NM+siAqj7OIJx6NGoi37N1LcGxVogf7FK448AFAjpW
         GV9NydPog9US56VH9Z092ZEsZuPf4nAxDvCl2YzJuNt+IDG9OCIl0WUf4o8rLdgOW/Qm
         t6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0HINq0/oRgYesXUSAlumWGA0q6P8NqHQhhmtUR68N4=;
        b=TRbwNMt0ZNOwz//4FLaknOx4HDuJsUIyOO2P7UGI7PiPBfqxMVMwNlkOzjzBn7MUe7
         a73Orpcs4VS/o1xluLaspJnQIrN4L58IHxiXkWTeWolCcQN5UQxd+N7tgcbFnXMOsV7N
         WBVRyXkmQzcQS/kfZwSEXKX0Xhd4PEwcDZ57JPy0WID0QnV2m5aF8X9lv86+rIdEb3IG
         OhDZAtyHDmBpEp4+r4koxIIUdmVLCsd7jSI69jQ4KFBNgFMjLWx3HEeMl94UPHU6Cvbg
         UnMK2Bp4NvC+/vO4YBrwjMTgX38uLctlo+3nySVbHll3VT/bsoppucPRb6K0ppF0fFMC
         R/iw==
X-Gm-Message-State: AOAM531RKcHRxinfFfIWNiHVHJPDJHR1ZRXlRj2fdcy3eDoUWgw/mmGl
        pf7NOxHc83LaK6wegvPzLztD7ewW4ZB9GVJQwK+deg==
X-Google-Smtp-Source: ABdhPJxe/5E4aU9afUfIgArHENgQctMJhdSdorYTvJU7ovSC4TrhiVgmB6dk+evKsAK0xdx0h9QkI7DI7MpfI+ufsbE=
X-Received: by 2002:a17:90a:d901:b0:1b8:a92c:34fe with SMTP id
 c1-20020a17090ad90100b001b8a92c34femr2642696pjv.8.1645028611229; Wed, 16 Feb
 2022 08:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
 <20220111161937.56272-2-pankaj.gupta.linux@gmail.com> <CAPcyv4jrVJ_B0N_-vtqgXaOMovUgnSLCNj228nWMRhGAC5PDhA@mail.gmail.com>
 <CAM9Jb+i0B2jZ0uCEDyiz8ujuMkioFgOA0r7Lz9wDK026Vq1Hxg@mail.gmail.com>
In-Reply-To: <CAM9Jb+i0B2jZ0uCEDyiz8ujuMkioFgOA0r7Lz9wDK026Vq1Hxg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Feb 2022 08:23:19 -0800
Message-ID: <CAPcyv4gJGB8+acXKXbpEpMck_y=XBMR0B0c255MaSyLsH4+eZA@mail.gmail.com>
Subject: Re: [RFC v3 1/2] virtio-pmem: Async virtio-pmem flush
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

On Wed, Feb 16, 2022 at 12:47 AM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> > >
> > > Enable asynchronous flush for virtio pmem using work queue. Also,
> > > coalesce the flush requests when a flush is already in process.
> > > This functionality is copied from md/RAID code.
> > >
> > > When a flush is already in process, new flush requests wait till
> > > previous flush completes in another context (work queue). For all
> > > the requests come between ongoing flush and new flush start time, only
> > > single flush executes, thus adhers to flush coalscing logic. This is
> >
> > s/adhers/adheres/
> >
> > s/coalscing/coalescing/
> >
> > > important for maintaining the flush request order with request coalscing.
> >
> > s/coalscing/coalescing/
>
> o.k. Sorry for the spelling mistakes.
>
> >
> > >
> > > Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> > > ---
> > >  drivers/nvdimm/nd_virtio.c   | 74 +++++++++++++++++++++++++++---------
> > >  drivers/nvdimm/virtio_pmem.c | 10 +++++
> > >  drivers/nvdimm/virtio_pmem.h | 16 ++++++++
> > >  3 files changed, 83 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > > index 10351d5b49fa..179ea7a73338 100644
> > > --- a/drivers/nvdimm/nd_virtio.c
> > > +++ b/drivers/nvdimm/nd_virtio.c
> > > @@ -100,26 +100,66 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
> > >  /* The asynchronous flush callback function */
> > >  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> > >  {
> > > -       /*
> > > -        * Create child bio for asynchronous flush and chain with
> > > -        * parent bio. Otherwise directly call nd_region flush.
> > > +       /* queue asynchronous flush and coalesce the flush requests */
> > > +       struct virtio_device *vdev = nd_region->provider_data;
> > > +       struct virtio_pmem *vpmem  = vdev->priv;
> > > +       ktime_t req_start = ktime_get_boottime();
> > > +       int ret = -EINPROGRESS;
> > > +
> > > +       spin_lock_irq(&vpmem->lock);
> >
> > Why a new lock and not continue to use ->pmem_lock?
>
> This spinlock is to protect entry in 'wait_event_lock_irq'
> and the Other spinlock is to protect virtio queue data.

Understood, but md shares the mddev->lock for both purposes, so I
would ask that you either document what motivates the locking split,
or just reuse the lock until a strong reason to split them arises.
