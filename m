Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681DB587CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbiHBMtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiHBMtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:49:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FA9963BE;
        Tue,  2 Aug 2022 05:49:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E4BE13D5;
        Tue,  2 Aug 2022 05:49:28 -0700 (PDT)
Received: from [10.1.35.143] (e121487-lin.cambridge.arm.com [10.1.35.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2823F67D;
        Tue,  2 Aug 2022 05:49:24 -0700 (PDT)
Message-ID: <7e64ce61-89b1-40aa-8295-00ca42b9a959@arm.com>
Date:   Tue, 2 Aug 2022 13:49:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] hwrng: virtio - always add a pending request
Content-Language: en-US
To:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc:     amit@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>,
        virtualization@lists.linux-foundation.org,
        Dmitriy Vyukov <dvyukov@google.com>, rusty@rustcorp.com.au,
        akong@redhat.com, Alexander Potapenko <glider@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-crypto@vger.kernel.org,
        Mauricio De Carvalho <Mauricio.DeCarvalho@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Vladimir Murzin <Vladimir.Murzin@arm.com>
References: <20211028101111.128049-1-lvivier@redhat.com>
 <20211028101111.128049-5-lvivier@redhat.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20211028101111.128049-5-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 10/28/21 11:11, Laurent Vivier wrote:
> If we ensure we have already some data available by enqueuing
> again the buffer once data are exhausted, we can return what we
> have without waiting for the device answer.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/char/hw_random/virtio-rng.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index 8ba97cf4ca8f..0a7dde135db1 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -20,7 +20,6 @@ struct virtrng_info {
>  	struct virtqueue *vq;
>  	char name[25];
>  	int index;
> -	bool busy;
>  	bool hwrng_register_done;
>  	bool hwrng_removed;
>  	/* data transfer */
> @@ -44,16 +43,18 @@ static void random_recv_done(struct virtqueue *vq)
>  		return;
>  
>  	vi->data_idx = 0;
> -	vi->busy = false;
>  
>  	complete(&vi->have_data);
>  }
>  
> -/* The host will fill any buffer we give it with sweet, sweet randomness. */
> -static void register_buffer(struct virtrng_info *vi)
> +static void request_entropy(struct virtrng_info *vi)
>  {
>  	struct scatterlist sg;
>  
> +	reinit_completion(&vi->have_data);
> +	vi->data_avail = 0;
> +	vi->data_idx = 0;
> +
>  	sg_init_one(&sg, vi->data, sizeof(vi->data));
>  
>  	/* There should always be room for one buffer. */
> @@ -69,6 +70,8 @@ static unsigned int copy_data(struct virtrng_info *vi, void *buf,
>  	memcpy(buf, vi->data + vi->data_idx, size);
>  	vi->data_idx += size;
>  	vi->data_avail -= size;
> +	if (vi->data_avail == 0)
> +		request_entropy(vi);
>  	return size;
>  }
>  
> @@ -98,13 +101,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
>  	 * so either size is 0 or data_avail is 0
>  	 */
>  	while (size != 0) {
> -		/* data_avail is 0 */
> -		if (!vi->busy) {
> -			/* no pending request, ask for more */
> -			vi->busy = true;
> -			reinit_completion(&vi->have_data);
> -			register_buffer(vi);
> -		}
> +		/* data_avail is 0 but a request is pending */
>  		ret = wait_for_completion_killable(&vi->have_data);
>  		if (ret < 0)
>  			return ret;
> @@ -126,8 +123,7 @@ static void virtio_cleanup(struct hwrng *rng)
>  {
>  	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
>  
> -	if (vi->busy)
> -		complete(&vi->have_data);
> +	complete(&vi->have_data);
>  }
>  
>  static int probe_common(struct virtio_device *vdev)
> @@ -163,6 +159,9 @@ static int probe_common(struct virtio_device *vdev)
>  		goto err_find;
>  	}
>  
> +	/* we always have a pending entropy request */
> +	request_entropy(vi);
> +
>  	return 0;
>  
>  err_find:
> @@ -181,7 +180,6 @@ static void remove_common(struct virtio_device *vdev)
>  	vi->data_idx = 0;
>  	complete(&vi->have_data);
>  	vdev->config->reset(vdev);
> -	vi->busy = false;
>  	if (vi->hwrng_register_done)
>  		hwrng_unregister(&vi->hwrng);
>  	vdev->config->del_vqs(vdev);

We observed that after this commit virtio-rng implementation in FVP doesn't
work

INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVICE
INFO: bp.virtio_rng: Using seed value: 0x5674bba8
Error: FVP_Base_AEMvA: bp.virtio_rng: <vq0-requestq> Found invalid descriptor index
In file: (unknown):0
In process: FVP_Base_AEMvA.thread_p_12 @ 935500020 ns
Info: FVP_Base_AEMvA: bp.virtio_rng: Could not extract buffer

while basic baremetal test works as expected

INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVICE
INFO: bp.virtio_rng: Using seed value: 0x541c142e
Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0x4b098991ceb377e6
Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0xbdcbe3f765ba62f7

We are trying to get an idea what is missing and where, yet none of us familiar
with the driver :(

I'm looping Kevin who originally reported that and Mauricio who is looking form
the FVP side. 

Cheers
Vladimir
