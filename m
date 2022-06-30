Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACFB5622F8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbiF3TUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiF3TT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28EE239B91
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656616796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E1fZREo5G1zyL3E99cNxpPu+YKfPtwYvUWsVzF1rbzA=;
        b=T6Z/vzjbDsGbhUb8mPNieWFD26zBJ2/N7Zj/f0+zIq8pbW5v2ERlLlbLPY4m22jrHlOdLm
        MNIXmRTB9Sr7H4v68oK5W90RzRoQQseYCuWS2iCAHQuSddjgZQ7S9qNZspMXxyB5JS02tv
        7aeYBWn0Ts7S1O6C/tImnkLOwy834t0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-CDZFeqy2MP2tbX91PJxycQ-1; Thu, 30 Jun 2022 15:19:54 -0400
X-MC-Unique: CDZFeqy2MP2tbX91PJxycQ-1
Received: by mail-wm1-f72.google.com with SMTP id j35-20020a05600c1c2300b003a167dfa0ecso99291wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E1fZREo5G1zyL3E99cNxpPu+YKfPtwYvUWsVzF1rbzA=;
        b=eSajlrsSuGCM7FaJLDkKsZxmIbMuHsW/xEsMKH9El4cYW6ivFYP5VAVIFdFI28mwz4
         AdYpckLW3/ggGQhr96E1bqhfCChLsk0SE11vAW+NbEpFU78eZ7zkEZRYjD7CatFrHw/3
         RYWtiVumw4Coe29NF7An9BOSB+YaTvRiH3GHK5bmT3OGLWScGF0rVUvgaCR52/Rrl6WK
         ewqSsc2Kg5iPWJ48CecYcGF4ZEyAXIgn0GRx3AhaTFR+D4LU+P0FWt2qvy3qJIaffmQb
         z7krbUeXgCfLEJnTEq4LLJz83aGRAbTZ4K6OSViQt1fcO/crFWwxswZwWgQMBvofuNCZ
         vGww==
X-Gm-Message-State: AJIora9sXvXwwZ1Cp0UgNZ5bWKpfU4QZ4cjzlk4LfgGUjbPGw8MXUakX
        3myfgnHJNRJFsprO4t9wz/2DtqEBnhT+qfWB6rUvGqdRU42OCLs8kIaDnT2DE+UEues47E4LM5t
        kLWfl7yaKMkhQzr6m/ccpSY67
X-Received: by 2002:a5d:584e:0:b0:21c:ea0c:3746 with SMTP id i14-20020a5d584e000000b0021cea0c3746mr9888862wrf.199.1656616793164;
        Thu, 30 Jun 2022 12:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tFgR4cJXhagHebOa3Tkr9MG8bSTYaTEMzhiZL3sAi2iRr5iiRShZDs06DbeLuQn1vJeahc0g==
X-Received: by 2002:a5d:584e:0:b0:21c:ea0c:3746 with SMTP id i14-20020a5d584e000000b0021cea0c3746mr9888843wrf.199.1656616792927;
        Thu, 30 Jun 2022 12:19:52 -0700 (PDT)
Received: from redhat.com ([2.55.35.209])
        by smtp.gmail.com with ESMTPSA id c8-20020a7bc848000000b0039c457cea21sm7279586wml.34.2022.06.30.12.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:19:52 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:19:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-remoteproc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
Message-ID: <20220630151716-mutt-send-email-mst@kernel.org>
References: <20220608171334.730739-1-apatel@ventanamicro.com>
 <20220629174318.GB2018382@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629174318.GB2018382@p14s>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 11:43:18AM -0600, Mathieu Poirier wrote:
> Hi Anup,
> 
> On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> > The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> > fails due to both virtqueues (Rx and Tx) marked as broken by the
> > __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> > (which unbreaks queues) should be called before virtqueue_add_inbuf().
> > 
> > Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index 905ac7910c98..71a64d2c7644 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >  	/* and half is dedicated for TX */
> >  	vrp->sbufs = bufs_va + total_buf_space / 2;
> >  
> > +	/* From this point on, we can notify and get callbacks. */
> > +	virtio_device_ready(vdev);
> > +
> 
> Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
> potentially be called (by way of rpmsg_recv_done()), which will race with
> virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
> rpmsg_recv_done() will fail, potentially breaking remote processors' state
> machines that don't expect their initial name service to fail when the "device"
> has been marked as ready.

When you say available I am guessing you really need used.

With a non broken device you won't get a callback
until some buffers have been used.

Or, if no used buffers are present then you will get another
callback down the road.


> 
> What does make me curious though is that nobody on the remoteproc mailing list
> has complained about commit 8b4ec69d7e09 breaking their environment... By now,
> i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
> their rig?
> 
> Thanks,
> Mathieu
> 
> >  	/* set up the receive buffers */
> >  	for (i = 0; i < vrp->num_bufs / 2; i++) {
> >  		struct scatterlist sg;
> > @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >  	 */
> >  	notify = virtqueue_kick_prepare(vrp->rvq);
> >  
> > -	/* From this point on, we can notify and get callbacks. */
> > -	virtio_device_ready(vdev);
> > -
> >  	/* tell the remote processor it can start sending messages */
> >  	/*
> >  	 * this might be concurrent with callbacks, but we are only
> > -- 
> > 2.34.1
> > 
> 

