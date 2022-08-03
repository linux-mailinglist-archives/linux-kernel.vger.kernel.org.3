Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD96588BF6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiHCMZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiHCMZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:25:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E4536468;
        Wed,  3 Aug 2022 05:25:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B443C11FB;
        Wed,  3 Aug 2022 05:25:27 -0700 (PDT)
Received: from [10.1.28.148] (e121487-lin.cambridge.arm.com [10.1.28.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70F163F67D;
        Wed,  3 Aug 2022 05:25:24 -0700 (PDT)
Message-ID: <33f0f429-491c-49da-bd2e-bf9f62cb3efb@arm.com>
Date:   Wed, 3 Aug 2022 13:25:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] hwrng: virtio - always add a pending request
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
        amit@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>,
        virtualization@lists.linux-foundation.org,
        Dmitriy Vyukov <dvyukov@google.com>, rusty@rustcorp.com.au,
        akong@redhat.com, Alexander Potapenko <glider@google.com>,
        linux-crypto@vger.kernel.org,
        Mauricio De Carvalho <Mauricio.DeCarvalho@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>
References: <20211028101111.128049-1-lvivier@redhat.com>
 <20211028101111.128049-5-lvivier@redhat.com>
 <7e64ce61-89b1-40aa-8295-00ca42b9a959@arm.com>
 <2c1198c4-77aa-5cb8-6bb4-b974850651be@arm.com>
 <20220803073243-mutt-send-email-mst@kernel.org>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20220803073243-mutt-send-email-mst@kernel.org>
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

On 8/3/22 12:39, Michael S. Tsirkin wrote:
> On Wed, Aug 03, 2022 at 09:57:35AM +0100, Vladimir Murzin wrote:
>> On 8/2/22 13:49, Vladimir Murzin wrote:
>>> Hi Laurent,
>>>
>>> On 10/28/21 11:11, Laurent Vivier wrote:
>>>> If we ensure we have already some data available by enqueuing
>>>> again the buffer once data are exhausted, we can return what we
>>>> have without waiting for the device answer.
>>>>
>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>> ---
>>>>  drivers/char/hw_random/virtio-rng.c | 26 ++++++++++++--------------
>>>>  1 file changed, 12 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
>>>> index 8ba97cf4ca8f..0a7dde135db1 100644
>>>> --- a/drivers/char/hw_random/virtio-rng.c
>>>> +++ b/drivers/char/hw_random/virtio-rng.c
>>>> @@ -20,7 +20,6 @@ struct virtrng_info {
>>>>  	struct virtqueue *vq;
>>>>  	char name[25];
>>>>  	int index;
>>>> -	bool busy;
>>>>  	bool hwrng_register_done;
>>>>  	bool hwrng_removed;
>>>>  	/* data transfer */
>>>> @@ -44,16 +43,18 @@ static void random_recv_done(struct virtqueue *vq)
>>>>  		return;
>>>>  
>>>>  	vi->data_idx = 0;
>>>> -	vi->busy = false;
>>>>  
>>>>  	complete(&vi->have_data);
>>>>  }
>>>>  
>>>> -/* The host will fill any buffer we give it with sweet, sweet randomness. */
>>>> -static void register_buffer(struct virtrng_info *vi)
>>>> +static void request_entropy(struct virtrng_info *vi)
>>>>  {
>>>>  	struct scatterlist sg;
>>>>  
>>>> +	reinit_completion(&vi->have_data);
>>>> +	vi->data_avail = 0;
>>>> +	vi->data_idx = 0;
>>>> +
>>>>  	sg_init_one(&sg, vi->data, sizeof(vi->data));
>>>>  
>>>>  	/* There should always be room for one buffer. */
>>>> @@ -69,6 +70,8 @@ static unsigned int copy_data(struct virtrng_info *vi, void *buf,
>>>>  	memcpy(buf, vi->data + vi->data_idx, size);
>>>>  	vi->data_idx += size;
>>>>  	vi->data_avail -= size;
>>>> +	if (vi->data_avail == 0)
>>>> +		request_entropy(vi);
>>>>  	return size;
>>>>  }
>>>>  
>>>> @@ -98,13 +101,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
>>>>  	 * so either size is 0 or data_avail is 0
>>>>  	 */
>>>>  	while (size != 0) {
>>>> -		/* data_avail is 0 */
>>>> -		if (!vi->busy) {
>>>> -			/* no pending request, ask for more */
>>>> -			vi->busy = true;
>>>> -			reinit_completion(&vi->have_data);
>>>> -			register_buffer(vi);
>>>> -		}
>>>> +		/* data_avail is 0 but a request is pending */
>>>>  		ret = wait_for_completion_killable(&vi->have_data);
>>>>  		if (ret < 0)
>>>>  			return ret;
>>>> @@ -126,8 +123,7 @@ static void virtio_cleanup(struct hwrng *rng)
>>>>  {
>>>>  	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
>>>>  
>>>> -	if (vi->busy)
>>>> -		complete(&vi->have_data);
>>>> +	complete(&vi->have_data);
>>>>  }
>>>>  
>>>>  static int probe_common(struct virtio_device *vdev)
>>>> @@ -163,6 +159,9 @@ static int probe_common(struct virtio_device *vdev)
>>>>  		goto err_find;
>>>>  	}
>>>>  
>>>> +	/* we always have a pending entropy request */
>>>> +	request_entropy(vi);
>>>> +
>>>>  	return 0;
>>>>  
>>>>  err_find:
>>>> @@ -181,7 +180,6 @@ static void remove_common(struct virtio_device *vdev)
>>>>  	vi->data_idx = 0;
>>>>  	complete(&vi->have_data);
>>>>  	vdev->config->reset(vdev);
>>>> -	vi->busy = false;
>>>>  	if (vi->hwrng_register_done)
>>>>  		hwrng_unregister(&vi->hwrng);
>>>>  	vdev->config->del_vqs(vdev);
>>>
>>> We observed that after this commit virtio-rng implementation in FVP doesn't
>>> work
>>>
>>> INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVICE
>>> INFO: bp.virtio_rng: Using seed value: 0x5674bba8
>>> Error: FVP_Base_AEMvA: bp.virtio_rng: <vq0-requestq> Found invalid descriptor index
>>> In file: (unknown):0
>>> In process: FVP_Base_AEMvA.thread_p_12 @ 935500020 ns
>>> Info: FVP_Base_AEMvA: bp.virtio_rng: Could not extract buffer
>>>
>>> while basic baremetal test works as expected
>>>
>>> INFO: bp.virtio_rng: Selected Random Generator Device: XORSHIFT DEVICE
>>> INFO: bp.virtio_rng: Using seed value: 0x541c142e
>>> Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0x4b098991ceb377e6
>>> Info: FVP_Base_AEMv8A: bp.virtio_rng: Generated Number: 0xbdcbe3f765ba62f7
>>>
>>> We are trying to get an idea what is missing and where, yet none of us familiar
>>> with the driver :(
>>>
>>> I'm looping Kevin who originally reported that and Mauricio who is looking form
>>> the FVP side. 
>>
>> With the following diff FVP works agin
>>
>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
>> index a6f3a8a2ac..042503ad6c 100644
>> --- a/drivers/char/hw_random/virtio-rng.c
>> +++ b/drivers/char/hw_random/virtio-rng.c
>> @@ -54,6 +54,7 @@ static void request_entropy(struct virtrng_info *vi)
>>         reinit_completion(&vi->have_data);
>>         vi->data_avail = 0;
>>         vi->data_idx = 0;
>> +       smp_mb();
>>  
>>         sg_init_one(&sg, vi->data, sizeof(vi->data));
>>  
>>
>> What do you reckon?
>>
>> Cheers
>> Vladimir
> 
> Thanks for debugging this!
> 
> OK, interesting.
> 
> data_idx and data_avail are accessed from virtio_read.
> 
> Which as far as I can tell is invoked just with reading_mutex.
> 
> 
> But, request_entropy is called from probe when device is registered
> this time without locks
> so it can trigger while another thread is calling virtio_read.
> 
> Second request_entropy is called from a callback random_recv_done
> also without locks.
> 
> So it's great that smp_mb helped here but I suspect in fact we
> need locking. Laurent?
> 

I'm sorry for the noise, but it looks like I'm seeing issue for some different reasons.
I manage to reproduce issue even with smb_mb() in place. The reason I though it helped
is because I changed both environment and added smb_mb().

Anyway, thank you for your time!

Cheers
Vladimir


