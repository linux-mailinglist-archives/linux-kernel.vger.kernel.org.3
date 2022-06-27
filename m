Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86E955DBCD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiF0Ie0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiF0IeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67D085FF5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656318862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ba0dlHiyiiqZYNyYZRp/YOPV+CIztWSeAQmxbjkqJ6o=;
        b=N4q6a/VZOD97MaxQZGLXK4/3tYDvC3nKuFNo1idqViny7VI/V0lpKSBHM8eAiqR3x7BRIW
        jaPEqKMWFdOwwfTLyC2+r+qx72Bqudv3NCvmOnOWNtjE159zAWo6PtVzny/+q/XYQylSwX
        So7w43/D6hmKReKFuyIEO2bxxqnnSKg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-si2fvJsmNTG176vydHK8Kg-1; Mon, 27 Jun 2022 04:34:20 -0400
X-MC-Unique: si2fvJsmNTG176vydHK8Kg-1
Received: by mail-lf1-f72.google.com with SMTP id y35-20020a0565123f2300b0047f70612402so4385011lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ba0dlHiyiiqZYNyYZRp/YOPV+CIztWSeAQmxbjkqJ6o=;
        b=kZvvRdRMse+M72wvwYotBk2B9459o+tfBRPblnXnvaPPisRGcDLhJueyfLiUj6Y0kt
         YVr2Efg5O5Gop1TSUyvjYCIM5X0uFkwcjM3BHZz7Z+rm+56j4b+PfmF7dAS8HrCi9Lm4
         HFefFY1ln+CDl0y2pv2xPkQ9C+kTAaEnFj8asOkv3CbtqezcJ54C3VHzmlOD8PupwOhZ
         B6gFoWYMAAV8saiGtXdMZJdw/0ewl7JKZpsf7PTAx/n0C4g5EtOkhs3oxV3alQ/RjUo5
         3TQfGrQsd+7cRYlTFsQsg4mz7P/8Mp0Og9TqQdJxlDeYFgN+cgit+J7NYjYVzohyWTQx
         78Zg==
X-Gm-Message-State: AJIora9916zbWYo8hzj8NeXoxYjS//dq6Zv5acLzgMccIaKflXVub1PQ
        AESpnRHh1CW3sA8EeIsWGz54jTZxaYfJ3kllXrrcWxNQvwP4/e5lj+wcZbUBKG6vgjm3inrTGZ5
        vSiEcCSK0tFhVgcBcuTjVSUWoPTgbPLFRVc9Y9Y8y
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id g3-20020a05651222c300b0047f704b3820mr7488516lfu.411.1656318858559;
        Mon, 27 Jun 2022 01:34:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uVASIFfeGulBKy+F9VDJcwQSZfcmHSg7/Mi80UUit2TT3P9+6R9xwL2uDQCfUmFoJnb8yemPftTjokkvUOW7U=
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr7488501lfu.411.1656318858379; Mon, 27
 Jun 2022 01:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220627062941.52057-1-jasowang@redhat.com> <20220627062941.52057-2-jasowang@redhat.com>
 <20220627035854-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220627035854-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 27 Jun 2022 16:34:07 +0800
Message-ID: <CACGkMEvvCR_rH6PYToG8+a4YuL=yd1DQNSfY8WFYATsnsOnE8w@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] virtio_pmem: set device ready in probe()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>, pankaj.gupta@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 4:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 27, 2022 at 02:29:41PM +0800, Jason Wang wrote:
> > The NVDIMM region could be available before the virtio_device_ready()
> > that is called by virtio_dev_probe(). This means the driver tries to
> > use device before DRIVER_OK which violates the spec, fixing this by
>
> s/fixing this by/to fix this/
>
> > set device ready before the nvdimm_pmem_region_create().
> >
> > Note that this means the virtio_pmem_host_ack() could be triggered
> > before the creation of the nd region, this is safe since the
> > virtio_pmem_host_ack() since pmem_lock has been initialized and
>
> can't parse this sentence, since repeated twice confuses me

Should be a copy-paste error: how about:

Note that this means the virtio_pmem_host_ack() could be triggered
before the creation of the nd region, this is safe since the pmem_lock
has been initialized and whether or not any available buffer is added
before is validated by virtio_pmem_host_ack().

Thanks

>
> > whether or not any available buffer is added before is validated.
> >
> > Fixes 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> > Acked-by: Pankaj Gupta <pankaj.gupta@amd.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since v1:
> > - Remove some comments per Dan
> > ---
> >  drivers/nvdimm/virtio_pmem.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > index 48f8327d0431..20da455d2ef6 100644
> > --- a/drivers/nvdimm/virtio_pmem.c
> > +++ b/drivers/nvdimm/virtio_pmem.c
> > @@ -84,6 +84,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
> >       ndr_desc.provider_data = vdev;
> >       set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> >       set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> > +     /*
> > +      * The NVDIMM region could be available before the
> > +      * virtio_device_ready() that is called by
> > +      * virtio_dev_probe(), so we set device ready here.
> > +      */
> > +     virtio_device_ready(vdev);
> >       nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> >       if (!nd_region) {
> >               dev_err(&vdev->dev, "failed to create nvdimm region\n");
> > @@ -92,6 +98,7 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
> >       }
> >       return 0;
> >  out_nd:
> > +     virtio_reset_device(vdev);
> >       nvdimm_bus_unregister(vpmem->nvdimm_bus);
> >  out_vq:
> >       vdev->config->del_vqs(vdev);
> > --
> > 2.25.1
>

