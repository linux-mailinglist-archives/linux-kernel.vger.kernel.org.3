Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA7F565132
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiGDJpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiGDJpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:45:22 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA1DA2;
        Mon,  4 Jul 2022 02:45:20 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2647XWfK017146;
        Mon, 4 Jul 2022 11:44:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=C56sT1EYqKnoTOHY4Oh/vNRyQP4FcjnkkZI7zPqMwy4=;
 b=zRhf1/uWiStbjWoDb8So3aSXnZLzFxDV6z/a5+9ysVBRvdIPKa/8zyOipP7W6MBjd0Ky
 yGaPZSa/J/FHL/HgalMRq8etqY+tutQ43HDIm35M7Ya3rsxghId0ltttxmWh1xYMn6dL
 o+vaLNIjnzesMAKNclJTjyLzUhu/g26YW/ZWCHaGj2EDHLNs/Vy+w5mWpOdA8twehKCW
 uh/IcR7Yk+HLTSqPjSZoDET1Wf0RTFoJdpVr4Fz6JQb7jmMr49jIVfCQ9qi68vgfRol7
 OFsO5xqIiGZmaFSf0F+k8MHzr17tcGzubbz87PsfQdwaxhFL+A2MULpcfCTnw9V7Rjug 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h2dc209n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 11:44:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 63853100038;
        Mon,  4 Jul 2022 11:44:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 545392171D3;
        Mon,  4 Jul 2022 11:44:53 +0200 (CEST)
Received: from [10.252.4.55] (10.75.127.46) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 4 Jul
 2022 11:44:50 +0200
Message-ID: <66323a79-48a7-853e-1c44-9e62fcc5b775@foss.st.com>
Date:   Mon, 4 Jul 2022 11:44:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        <linux-remoteproc@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
References: <20220608171334.730739-1-apatel@ventanamicro.com>
 <20220629174318.GB2018382@p14s>
 <bf87a50c-6d92-8657-72a9-75af81d2489f@foss.st.com>
 <CANLsYkzHZMV3eVUn3Xpk0eiAexyr9HC5__K9xfAwfm23nuQj=A@mail.gmail.com>
 <20220630152003-mutt-send-email-mst@kernel.org>
 <CACGkMEtHuoHT6meHacsie8M87yjUX3jGEvP7BuU_Vrb3yqkDWw@mail.gmail.com>
 <20220701021536-mutt-send-email-mst@kernel.org>
 <CACGkMEtkVmq2+NtDpp-XWZFD_WO6Dzm4=pcVwg-aKmStAqJCVg@mail.gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <CACGkMEtkVmq2+NtDpp-XWZFD_WO6Dzm4=pcVwg-aKmStAqJCVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_08,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jason,

On 7/4/22 06:35, Jason Wang wrote:
> On Fri, Jul 1, 2022 at 2:16 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Fri, Jul 01, 2022 at 09:22:15AM +0800, Jason Wang wrote:
>>> On Fri, Jul 1, 2022 at 3:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Thu, Jun 30, 2022 at 11:51:30AM -0600, Mathieu Poirier wrote:
>>>>> + virtualization@lists.linux-foundation.org
>>>>> + jasowang@redhat.com
>>>>> + mst@redhat.com
>>>>>
>>>>> On Thu, 30 Jun 2022 at 10:20, Arnaud POULIQUEN
>>>>> <arnaud.pouliquen@foss.st.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 6/29/22 19:43, Mathieu Poirier wrote:
>>>>>>> Hi Anup,
>>>>>>>
>>>>>>> On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
>>>>>>>> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
>>>>>>>> fails due to both virtqueues (Rx and Tx) marked as broken by the
>>>>>>>> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
>>>>>>>> (which unbreaks queues) should be called before virtqueue_add_inbuf().
>>>>>>>>
>>>>>>>> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
>>>>>>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>>>>>>> ---
>>>>>>>>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
>>>>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>>>>> index 905ac7910c98..71a64d2c7644 100644
>>>>>>>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>>>>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>>>>>> @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>>>>>>>      /* and half is dedicated for TX */
>>>>>>>>      vrp->sbufs = bufs_va + total_buf_space / 2;
>>>>>>>>
>>>>>>>> +    /* From this point on, we can notify and get callbacks. */
>>>>>>>> +    virtio_device_ready(vdev);
>>>>>>>> +
>>>>>>>
>>>>>>> Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
>>>>>>> potentially be called (by way of rpmsg_recv_done()), which will race with
>>>>>>> virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
>>>>>>> rpmsg_recv_done() will fail, potentially breaking remote processors' state
>>>>>>> machines that don't expect their initial name service to fail when the "device"
>>>>>>> has been marked as ready.
>>>>>>>
>>>>>>> What does make me curious though is that nobody on the remoteproc mailing list
>>>>>>> has complained about commit 8b4ec69d7e09 breaking their environment... By now,
>>>>>>> i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
>>>>>>> their rig?
>>>>>>
>>>>>> I tested on STm32mp1 board using tag v5.19-rc4(03c765b0e3b4)
>>>>>> I confirm the issue!
>>>>>>
>>>>>> Concerning the solution, I share Mathieu's concern. This could break legacy.
>>>>>> I made a short test and I would suggest to use __virtio_unbreak_device instead, tounbreak the virtqueues without changing the init sequence.
>>>>>>
>>>>>> I this case the patch would be:
>>>>>>
>>>>>> +       /*
>>>>>> +        * Unbreak the virtqueues to allow to add buffers before setting the vdev status
>>>>>> +        * to ready
>>>>>> +        */
>>>>>> +       __virtio_unbreak_device(vdev);
>>>>>> +
>>>>>>
>>>>>>         /* set up the receive buffers */
>>>>>>         for (i = 0; i < vrp->num_bufs / 2; i++) {
>>>>>>                 struct scatterlist sg;
>>>>>>                 void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
>>>>>
>>>>> This will indeed fix the problem.  On the flip side the kernel
>>>>> documentation for __virtio_unbreak_device() puzzles me...
>>>>> It clearly states that it should be used for probing and restoring but
>>>>> _not_ directly by the driver.  Function rpmsg_probe() is part of
>>>>> probing but also the entry point to a driver.
>>>>>
>>>>> Michael and virtualisation folks, is this the right way to move forward?
>>>>
>>>> I don't think it is, __virtio_unbreak_device is intended for core use.
>>>
>>> Can we fill the rx after virtio_device_ready() in this case?
>>>
>>> Btw, the driver set driver ok after registering, we probably get a svq
>>> kick before DRIVER_OK?

By "registering" you mean calling rpmsg_virtio_add_ctrl_dev and 
rpmsg_ns_register_device?

The rpmsg_ns_register_device has to be called before. Because it has to be
probed to handle the first message coming from the remote side to create
associated rpmsg local device. It doesn't send message.

The risk could be for the rpmsg_ctrl device. Registering it
after the virtio_device_ready(vdev) call could make sense...

>>>
>>> Thanks
>>
>> Is this an ack for the original patch?
> 
> Nope, I meant, instead of moving virtio_device_ready() a little bit
> earlier, can we only move the rvq filling after virtio_device_ready().
> 
> Thanks

Please find some concerns about this inversion here:
https://lore.kernel.org/lkml/20220701053813-mutt-send-email-mst@kernel.org/

Regarding __virtio_unbreak_device. The pending virtio_break_device is
used by some virtio driver.
Could we consider that it makes sense to also have a
virtio_unbreak_device interface?


I do not well understand the reason of the commit:
8b4ec69d7e09 ("virtio: harden vring IRQ", 2022-05-27)
So following alternative is probably pretty naive:
Is the use of virtqueue_disable_cb could be an alternative to the
vq->broken usage allowing to register buffer while preventing virtqueue IRQ?

Thanks,
Arnaud

> 
>>
>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Arnaud
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Mathieu
>>>>>>>
>>>>>>>>      /* set up the receive buffers */
>>>>>>>>      for (i = 0; i < vrp->num_bufs / 2; i++) {
>>>>>>>>              struct scatterlist sg;
>>>>>>>> @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>>>>>>>       */
>>>>>>>>      notify = virtqueue_kick_prepare(vrp->rvq);
>>>>>>>>
>>>>>>>> -    /* From this point on, we can notify and get callbacks. */
>>>>>>>> -    virtio_device_ready(vdev);
>>>>>>>> -
>>>>>>>>      /* tell the remote processor it can start sending messages */
>>>>>>>>      /*
>>>>>>>>       * this might be concurrent with callbacks, but we are only
>>>>>>>> --
>>>>>>>> 2.34.1
>>>>>>>>
>>>>
>>
> 
