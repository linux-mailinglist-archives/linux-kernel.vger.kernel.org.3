Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385EF562F55
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiGAJBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiGAJBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:01:00 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943931A044;
        Fri,  1 Jul 2022 02:00:58 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2618nIIr006335;
        Fri, 1 Jul 2022 11:00:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=dS0i6nF8Q1U5P/B+vYrDbTJU229kwXvuHE4jdYsIFyA=;
 b=HY0p0LuMjqvzG716l9VvTJxWnIU/jCzk4zcu90/Et03ee6IAUo/uESVZ3oPg5mnztjdR
 h1sJ+JuWf35Som2UTLuMiQydp28wZSheeXowXXlyhNUQcx36OLhthYp5LuvP8FH6XWN2
 WniXHCZq9QF3oMYOwoj0R2O6vh251ikmdo6EM4adD873XSQbiudMI8Fp7AiWhhSEqSwq
 mDfybIP/EWNqROfsDk2YXkynxRsqSUd10SQDQ66/Bt3dyDvle36QfA341pU7PdI2YV4m
 chJIr5sVpZQNFgeBL3NwVw8HfdlCxOxqsJvA5Q6oJKcHVhqZLfYGBFQjYt+GSydXHdfO bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h1areq1mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 11:00:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 46B3C10002A;
        Fri,  1 Jul 2022 11:00:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EC8B2132C7;
        Fri,  1 Jul 2022 11:00:31 +0200 (CEST)
Received: from [10.252.12.175] (10.75.127.46) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 1 Jul
 2022 11:00:29 +0200
Message-ID: <65d972ed-31b4-5636-86a3-dabd5f25a3be@foss.st.com>
Date:   Fri, 1 Jul 2022 11:00:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Anup Patel <apatel@ventanamicro.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        <linux-remoteproc@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220608171334.730739-1-apatel@ventanamicro.com>
 <20220629174318.GB2018382@p14s>
 <20220630151716-mutt-send-email-mst@kernel.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220630151716-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_05,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 6/30/22 21:19, Michael S. Tsirkin wrote:
> On Wed, Jun 29, 2022 at 11:43:18AM -0600, Mathieu Poirier wrote:
>> Hi Anup,
>>
>> On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
>>> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
>>> fails due to both virtqueues (Rx and Tx) marked as broken by the
>>> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
>>> (which unbreaks queues) should be called before virtqueue_add_inbuf().
>>>
>>> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>> ---
>>>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>>> index 905ac7910c98..71a64d2c7644 100644
>>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>>> @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>>  	/* and half is dedicated for TX */
>>>  	vrp->sbufs = bufs_va + total_buf_space / 2;
>>>  
>>> +	/* From this point on, we can notify and get callbacks. */
>>> +	virtio_device_ready(vdev);
>>> +
>>
>> Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
>> potentially be called (by way of rpmsg_recv_done()), which will race with
>> virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
>> rpmsg_recv_done() will fail, potentially breaking remote processors' state
>> machines that don't expect their initial name service to fail when the "device"
>> has been marked as ready.
> 
> When you say available I am guessing you really need used.
> 
> With a non broken device you won't get a callback
> until some buffers have been used.
> 
> Or, if no used buffers are present then you will get another
> callback down the road.

In current implementation the Linux rpmsg_virtio driver allocates the
virtio buffers for the coprocessor rpmsg virtio device transmission and
then updates the virtio device status in shared memory to inform the
coprocessor that it is ready for inter-processor communication.

So from coprocessor perspective, when the virtio device is ready
(set to VIRTIO_CONFIG_S_DRIVER_OK), it can
start to get available buffers and send virtio buffers to the Linux.

With the patch proposed, the virtio is set to VIRTIO_CONFIG_S_DRIVER_OK
while no buffer are available for the coprocessor transmission.

I'm agree that, if the Linux rpmsg_virtio driver has not allocated the
buffer, the coprocessor will fail to get available virtio buffer for
communication and so has "just" to wait that some buffers are available
in the virtqueue.

But this change the behavior and can lead to an unexpected error case
for some legacy coprocessor firmware...
Should we take the risk that this legacy is no longer compatible?


That said regarding the virtio spec 1.1 chapter 3.1.1 [1], I also wonder
if the introduction of the virqueue broken flag is compliant with the
spec? 
But i guess this is probably a matter of interpretation...

" 
The driver MUST follow this sequence to initialize a device:
[...]
7. Perform device-specific setup, including discovery of virtqueues for
the device, optional per-bus setup, reading and possibly writing the
device’s virtio configuration space, and population of virtqueues.
8. Set the DRIVER_OK status bit. At this point the device is “live”.
"

My question is what means in point 7. "and population of virtqueues"?

In my interpretation the call of "virtqueue_add_inbuf()" populates the
RX virtqueue.
That would mean that calling virtqueue_add_inbuf before calling 
virtio_device_ready() should be possible.

Thanks,
Arnaud 

[1]https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-920001


> 
> 
>>
>> What does make me curious though is that nobody on the remoteproc mailing list
>> has complained about commit 8b4ec69d7e09 breaking their environment... By now,
>> i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
>> their rig?
>>
>> Thanks,
>> Mathieu
>>
>>>  	/* set up the receive buffers */
>>>  	for (i = 0; i < vrp->num_bufs / 2; i++) {
>>>  		struct scatterlist sg;
>>> @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>>  	 */
>>>  	notify = virtqueue_kick_prepare(vrp->rvq);
>>>  
>>> -	/* From this point on, we can notify and get callbacks. */
>>> -	virtio_device_ready(vdev);
>>> -
>>>  	/* tell the remote processor it can start sending messages */
>>>  	/*
>>>  	 * this might be concurrent with callbacks, but we are only
>>> -- 
>>> 2.34.1
>>>
>>
> 
