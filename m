Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A2A55DB30
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiF0KD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiF0KDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80F0926DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656324203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i0BnrKQ4afs68lBNvA5gH+3OMZUZBKNoyUu9MbO28ME=;
        b=VBy4anRzMZQwlTq5qatD8mk1HEo+5VqZtjp3m0uq3wskL5V8RUh1eCXEuf+PKJ63ZkyGtp
        97rm3zYjgsXq9TnDSuzM5EjiN1KDpEi550IhXxAHRgUYTkXyvnyZUbd3zhI5e+y1bctigG
        K/Um/AfsIbHZi+4AY5CYg9M4L5IJDA8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-kIg89j9FMV2WNQoCe-zdZg-1; Mon, 27 Jun 2022 06:03:22 -0400
X-MC-Unique: kIg89j9FMV2WNQoCe-zdZg-1
Received: by mail-wm1-f71.google.com with SMTP id h125-20020a1c2183000000b003a03a8475c6so2870985wmh.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i0BnrKQ4afs68lBNvA5gH+3OMZUZBKNoyUu9MbO28ME=;
        b=v/B3OQ6/7zYb4bl58OaoGZ6QTekTmWrVt5tk0Qk7AmB2dv9SMz2PfGhEijvlCk/Fnv
         R49jxrd0i0jCmnGVTLU8BkeQHvLio8r69cXxlZzelm3Ry7HKLaqtv7hHKNmXIWJ4VPIs
         M9Ag+ruc+SnxNS14c+Rmai2BHPxmC7tWt2ToBx5osb+ou39vfvoVPNG/PZNTmGxCilw8
         kIKalN1RA0B2MUH8rjQblsL2iRMasAvTz6cwJ9IGrWc2vZjAmuoK0JFeZzUreriYnjvu
         86+P6V42Ol5LIxsbaavRcOnK4JuZ5KoRuYqmefr3rtCsrxcmrmrkAsvk+sq310MC/XdJ
         2FBA==
X-Gm-Message-State: AJIora8HQN+Lc4A14CHilCd2/EcTRCNqOcpL8HZNKSzMeX/n9zIhz9nT
        j6C6SFOorGeJ3ntjk0+GTKpaqIQXA5pJpd6vk3yhIC2ND00tSHsGt+qHZ61AWXzEXHyK+4bEbIg
        q8rQG+cX3Uofh7tcDEBCza6SY
X-Received: by 2002:a05:6000:3c6:b0:21b:9d00:db29 with SMTP id b6-20020a05600003c600b0021b9d00db29mr11779516wrg.338.1656324201192;
        Mon, 27 Jun 2022 03:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tSFWKQ6nV2POhQWU61As5gX5KUrfXdjC2eKrkkwEqDxvKAsrKrEMumDC/dCjeBlOm5AON8Zg==
X-Received: by 2002:a05:6000:3c6:b0:21b:9d00:db29 with SMTP id b6-20020a05600003c600b0021b9d00db29mr11779492wrg.338.1656324200981;
        Mon, 27 Jun 2022 03:03:20 -0700 (PDT)
Received: from redhat.com ([2.54.45.90])
        by smtp.gmail.com with ESMTPSA id id18-20020a05600ca19200b0039c871d3191sm8902341wmb.3.2022.06.27.03.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 03:03:20 -0700 (PDT)
Date:   Mon, 27 Jun 2022 06:03:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>, pankaj.gupta@amd.com
Subject: Re: [PATCH V2 2/2] virtio_pmem: set device ready in probe()
Message-ID: <20220627060312-mutt-send-email-mst@kernel.org>
References: <20220627062941.52057-1-jasowang@redhat.com>
 <20220627062941.52057-2-jasowang@redhat.com>
 <20220627035854-mutt-send-email-mst@kernel.org>
 <CACGkMEvvCR_rH6PYToG8+a4YuL=yd1DQNSfY8WFYATsnsOnE8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvvCR_rH6PYToG8+a4YuL=yd1DQNSfY8WFYATsnsOnE8w@mail.gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 04:34:07PM +0800, Jason Wang wrote:
> On Mon, Jun 27, 2022 at 4:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 02:29:41PM +0800, Jason Wang wrote:
> > > The NVDIMM region could be available before the virtio_device_ready()
> > > that is called by virtio_dev_probe(). This means the driver tries to
> > > use device before DRIVER_OK which violates the spec, fixing this by
> >
> > s/fixing this by/to fix this/
> >
> > > set device ready before the nvdimm_pmem_region_create().
> > >
> > > Note that this means the virtio_pmem_host_ack() could be triggered
> > > before the creation of the nd region, this is safe since the
> > > virtio_pmem_host_ack() since pmem_lock has been initialized and
> >
> > can't parse this sentence, since repeated twice confuses me
> 
> Should be a copy-paste error: how about:
> 
> Note that this means the virtio_pmem_host_ack() could be triggered
> before the creation of the nd region, this is safe since the pmem_lock
> has been initialized and whether or not any available buffer is added
> before is validated by virtio_pmem_host_ack().
> 
> Thanks

looks good

> >
> > > whether or not any available buffer is added before is validated.
> > >
> > > Fixes 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> > > Acked-by: Pankaj Gupta <pankaj.gupta@amd.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes since v1:
> > > - Remove some comments per Dan
> > > ---
> > >  drivers/nvdimm/virtio_pmem.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > > index 48f8327d0431..20da455d2ef6 100644
> > > --- a/drivers/nvdimm/virtio_pmem.c
> > > +++ b/drivers/nvdimm/virtio_pmem.c
> > > @@ -84,6 +84,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
> > >       ndr_desc.provider_data = vdev;
> > >       set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> > >       set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> > > +     /*
> > > +      * The NVDIMM region could be available before the
> > > +      * virtio_device_ready() that is called by
> > > +      * virtio_dev_probe(), so we set device ready here.
> > > +      */
> > > +     virtio_device_ready(vdev);
> > >       nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> > >       if (!nd_region) {
> > >               dev_err(&vdev->dev, "failed to create nvdimm region\n");
> > > @@ -92,6 +98,7 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
> > >       }
> > >       return 0;
> > >  out_nd:
> > > +     virtio_reset_device(vdev);
> > >       nvdimm_bus_unregister(vpmem->nvdimm_bus);
> > >  out_vq:
> > >       vdev->config->del_vqs(vdev);
> > > --
> > > 2.25.1
> >

