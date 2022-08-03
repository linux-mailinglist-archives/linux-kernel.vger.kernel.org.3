Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC824588B6E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbiHCLkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 07:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiHCLkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 07:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 541A31054C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659526804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JwfvYO99TCB9FiKX3BYcocI/S5+Oq3USCEZauc8Ysww=;
        b=Y9K08+BU22N8Am63BEFKxuUhvTwgsssPilFl65hI9xdNNnCTkUWWZsOCYleTN3+OZfb7Ng
        PAB5ZitGAPBnwWZ0TkRYjYjonqTUAuQdixTweULcokrZTJCcuN8M2fpXEP0ifPeRjBXNi2
        IAeeqGTVjUk8vMHP7z4ExdAAwu7wvNc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-_abjqHj5NZWB3OuLR3Qyag-1; Wed, 03 Aug 2022 07:40:03 -0400
X-MC-Unique: _abjqHj5NZWB3OuLR3Qyag-1
Received: by mail-wr1-f71.google.com with SMTP id w22-20020adf8bd6000000b002206311fb96so2261245wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 04:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=JwfvYO99TCB9FiKX3BYcocI/S5+Oq3USCEZauc8Ysww=;
        b=mLr/xSRobVn5rhVXvvPuocVlu/YRU4XIPJ2xSX5kJ9WkxS6TtbdPhWgOLO29AJr8q8
         P6ur/YCTsgMG7Dmh5ttc4JuFp968W1/BgJWl5S2o+KPkCpijBAP2phwXU9fMyv+76k1u
         AUKEbo0ac38063Rxmp5Ne7ClpQ6Oz/c1VSE0BqaF1Ou5lA9/jX/U0UWWZNuMyITHaBNr
         EL00KdV62jCqNzaXJwcnOox4FcGD7f2Eg4+hbjZyfBpCaY8rZ5ITlDqkPlifD2GjDDSQ
         py1ogKBrmXdaxDSUMzSjUHkqYRngrN/4Apbjbcifc/3fAWcdwGzV37HYjRHnPeGRO8tW
         3eMQ==
X-Gm-Message-State: ACgBeo3xOofONrcCT4N98ps5Ps4s1pOVWcZPJVPSHGf+VgOpTPBbZk++
        eW4CCxvAu91AdXYIgan+2D+a5d/Ij3m0nGfJaBPCBHnt8BojvoIaa4gb6HOAiJDwP4DLYSJcKo2
        PWpnkGZPJnTFye1MFxy/mzzXY
X-Received: by 2002:a05:600c:5029:b0:3a3:7308:6a43 with SMTP id n41-20020a05600c502900b003a373086a43mr2482222wmr.99.1659526801885;
        Wed, 03 Aug 2022 04:40:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Rj/RNdfFfFtzgtWn3I7gaknofBvNO8dT4fRFSg4D4OhE4MQPKh3aT/w+L1QYSSL2Mvr0VaA==
X-Received: by 2002:a05:600c:5029:b0:3a3:7308:6a43 with SMTP id n41-20020a05600c502900b003a373086a43mr2482207wmr.99.1659526801602;
        Wed, 03 Aug 2022 04:40:01 -0700 (PDT)
Received: from redhat.com ([2.54.191.86])
        by smtp.gmail.com with ESMTPSA id a1-20020adfe5c1000000b0021e491fd250sm11957635wrn.89.2022.08.03.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 04:40:01 -0700 (PDT)
Date:   Wed, 3 Aug 2022 07:39:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
        amit@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>,
        virtualization@lists.linux-foundation.org,
        Dmitriy Vyukov <dvyukov@google.com>, rusty@rustcorp.com.au,
        akong@redhat.com, Alexander Potapenko <glider@google.com>,
        linux-crypto@vger.kernel.org,
        Mauricio De Carvalho <Mauricio.DeCarvalho@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>
Subject: Re: [PATCH v2 4/4] hwrng: virtio - always add a pending request
Message-ID: <20220803073243-mutt-send-email-mst@kernel.org>
References: <20211028101111.128049-1-lvivier@redhat.com>
 <20211028101111.128049-5-lvivier@redhat.com>
 <7e64ce61-89b1-40aa-8295-00ca42b9a959@arm.com>
 <2c1198c4-77aa-5cb8-6bb4-b974850651be@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c1198c4-77aa-5cb8-6bb4-b974850651be@arm.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:57:35AM +0100, Vladimir Murzin wrote:
> On 8/2/22 13:49, Vladimir Murzin wrote:
> > Hi Laurent,
> > 
> > On 10/28/21 11:11, Laurent Vivier wrote:
> >> If we ensure we have already some data available by enqueuing
> >> again the buffer once data are exhausted, we can return what we
> >> have without waiting for the device answer.
> >>
> >> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >> ---
> >>  drivers/char/hw_random/virtio-rng.c | 26 ++++++++++++--------------
> >>  1 file changed, 12 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> >> index 8ba97cf4ca8f..0a7dde135db1 100644
> >> --- a/drivers/char/hw_random/virtio-rng.c
> >> +++ b/drivers/char/hw_random/virtio-rng.c
> >> @@ -20,7 +20,6 @@ struct virtrng_info {
> >>  	struct virtqueue *vq;
> >>  	char name[25];
> >>  	int index;
> >> -	bool busy;
> >>  	bool hwrng_register_done;
> >>  	bool hwrng_removed;
> >>  	/* data transfer */
> >> @@ -44,16 +43,18 @@ static void random_recv_done(struct virtqueue *vq)
> >>  		return;
> >>  
> >>  	vi->data_idx = 0;
> >> -	vi->busy = false;
> >>  
> >>  	complete(&vi->have_data);
> >>  }
> >>  
> >> -/* The host will fill any buffer we give it with sweet, sweet randomness. */
> >> -static void register_buffer(struct virtrng_info *vi)
> >> +static void request_entropy(struct virtrng_info *vi)
> >>  {
> >>  	struct scatterlist sg;
> >>  
> >> +	reinit_completion(&vi->have_data);
> >> +	vi->data_avail = 0;
> >> +	vi->data_idx = 0;
> >> +
> >>  	sg_init_one(&sg, vi->data, sizeof(vi->data));
> >>  
> >>  	/* There should always be room for one buffer. */
> >> @@ -69,6 +70,8 @@ static unsigned int copy_data(struct virtrng_info *vi, void *buf,
> >>  	memcpy(buf, vi->data + vi->data_idx, size);
> >>  	vi->data_idx += size;
> >>  	vi->data_avail -= size;
> >> +	if (vi->data_avail == 0)
> >> +		request_entropy(vi);
> >>  	return size;
> >>  }
> >>  
> >> @@ -98,13 +101,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
> >>  	 * so either size is 0 or data_avail is 0
> >>  	 */
> >>  	while (size != 0) {
> >> -		/* data_avail is 0 */
> >> -		if (!vi->busy) {
> >> -			/* no pending request, ask for more */
> >> -			vi->busy = true;
> >> -			reinit_completion(&vi->have_data);
> >> -			register_buffer(vi);
> >> -		}
> >> +		/* data_avail is 0 but a request is pending */
> >>  		ret = wait_for_completion_killable(&vi->have_data);
> >>  		if (ret < 0)
> >>  			return ret;
> >> @@ -126,8 +123,7 @@ static void virtio_cleanup(struct hwrng *rng)
> >>  {
> >>  	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
> >>  
> >> -	if (vi->busy)
> >> -		complete(&vi->have_data);
> >> +	complete(&vi->have_data);
> >>  }
> >>  
> >>  static int probe_common(struct virtio_device *vdev)
> >> @@ -163,6 +159,9 @@ static int probe_common(struct virtio_device *vdev)
> >>  		goto err_find;
> >>  	}
> >>  
> >> +	/* we always have a pending entropy request */
> >> +	request_entropy(vi);
> >> +
> >>  	return 0;
> >>  
> >>  err_find:
> >> @@ -181,7 +180,6 @@ static void remove_common(struct virtio_device *vdev)
> >>  	vi->data_idx = 0;
> >>  	complete(&vi->have_data);
> >>  	vdev->config->reset(vdev);
> >> -	vi->busy = false;
> >>  	if (vi->hwrng_register_done)
> >>  		hwrng_unregister(&vi->hwrng);
> >>  	vdev->config->del_vqs(vdev);
> > 
> > We observed that after this commit virtio-rng implementation in FVP doesn't
> > work
> > 
> > INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVICE
> > INFO: bp.virtio_rng: Using seed value: 0x5674bba8
> > Error: FVP_Base_AEMvA: bp.virtio_rng: <vq0-requestq> Found invalid descriptor index
> > In file: (unknown):0
> > In process: FVP_Base_AEMvA.thread_p_12 @ 935500020 ns
> > Info: FVP_Base_AEMvA: bp.virtio_rng: Could not extract buffer
> > 
> > while basic baremetal test works as expected
> > 
> > INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVICE
> > INFO: bp.virtio_rng: Using seed value: 0x541c142e
> > Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0x4b098991ceb377e6
> > Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0xbdcbe3f765ba62f7
> > 
> > We are trying to get an idea what is missing and where, yet none of us familiar
> > with the driver :(
> > 
> > I'm looping Kevin who originally reported that and Mauricio who is looking form
> > the FVP side. 
> 
> With the following diff FVP works agin
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index a6f3a8a2ac..042503ad6c 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -54,6 +54,7 @@ static void request_entropy(struct virtrng_info *vi)
>         reinit_completion(&vi->have_data);
>         vi->data_avail = 0;
>         vi->data_idx = 0;
> +       smp_mb();
>  
>         sg_init_one(&sg, vi->data, sizeof(vi->data));
>  
> 
> What do you reckon?
> 
> Cheers
> Vladimir

Thanks for debugging this!

OK, interesting.

data_idx and data_avail are accessed from virtio_read.

Which as far as I can tell is invoked just with reading_mutex.


But, request_entropy is called from probe when device is registered
this time without locks
so it can trigger while another thread is calling virtio_read.

Second request_entropy is called from a callback random_recv_done
also without locks.

So it's great that smp_mb helped here but I suspect in fact we
need locking. Laurent?

-- 
MST

