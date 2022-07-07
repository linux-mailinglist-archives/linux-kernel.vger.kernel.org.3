Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF556A1CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiGGMPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiGGMPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:15:18 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C2516593
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:15:16 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id 31A9C1008B388;
        Thu,  7 Jul 2022 20:15:13 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 1B7ED204904CA;
        Thu,  7 Jul 2022 20:15:13 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZRNcqXYDscP8; Thu,  7 Jul 2022 20:15:13 +0800 (CST)
Received: from [192.168.24.189] (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 6A192204904BF;
        Thu,  7 Jul 2022 20:15:00 +0800 (CST)
Message-ID: <c8b82458-51e8-e460-9caa-0db9f8615d85@sjtu.edu.cn>
Date:   Thu, 7 Jul 2022 20:15:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] virtio_test: move magic number in code as defined
 constant
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
 <20220707024409.1869-3-qtxuning1999@sjtu.edu.cn>
 <20220707010036-mutt-send-email-mst@kernel.org>
 <8c15f97f-df6d-9ec5-b9d3-c42350cde887@sjtu.edu.cn>
 <20220707033233-mutt-send-email-mst@kernel.org>
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20220707033233-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/7 15:36, Michael S. Tsirkin wrote:
> On Thu, Jul 07, 2022 at 02:17:19PM +0800, Guo Zhi wrote:
>> On 2022/7/7 13:09, Michael S. Tsirkin wrote:
>>> On Thu, Jul 07, 2022 at 10:44:07AM +0800, Guo Zhi wrote:
>>>> We should avoid using magic numbers directly.
>>> Not necessarily. For repeated values - I guess.
>>> But this kind of thing:
>>>
>>> 	#define BUF_SIZE 1024
>>> 	int buf_size = BUF_SIZE;
>>>
>>> brings no benefit IMHO.
>>>
>>> And this has cost - values are now removed from code.
>> Firstly, as a test, user will have to change the config to test virtio and
>> vhost frequently. If these magic number are put together like these, change
>> will be more easier.
> If tweaking these is useful for users we should add a command line flags
> as opposed to asking users to tweak code.
>
>> Secondly, many configs will be repeated, such as MAX_SG_FRAGS, even if some
>> varibale only appear once, subsequent upgrade of virtio_test will use these
>> variable in other place. For example, in this series of patch, patch 4/4
>> will use RINGSIZE to set INDIRECTS_BUF_SIZE.
>>
>>>> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> Isn't there some way to use the size we get as 1st parameter of kmalloc?

__kmalloc_fake has also been used in other place(vringh_test.c). which 
also use it to force allocate a specified user addr.

And it is actually hard to use 1st parameter of kmalloc to calculate the 
address of the target addr, which also impact vringh_test if the 
semantic of __kmalloc_fake changes.

>
>>>> ---
>>>>    tools/virtio/virtio_test.c | 18 +++++++++++-------
>>>>    1 file changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>>>> index 95f78b311..1ecd64271 100644
>>>> --- a/tools/virtio/virtio_test.c
>>>> +++ b/tools/virtio/virtio_test.c
>>>> @@ -20,7 +20,10 @@
>>>>    #include "../../drivers/vhost/test.h"
>>>>    #define RANDOM_BATCH -1
>>>> -
>>>> +#define ALIGN 4096
>>>> +#define RINGSIZE   256
>>>> +#define TEST_BUF_NUM 0x100000
>>>> +#define BUF_SIZE   1024
>>>>    /* Unused */
>>>>    void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
>>>> @@ -100,8 +103,8 @@ static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
>>>>    	if (info->vq)
>>>>    		vring_del_virtqueue(info->vq);
>>>> -	memset(info->ring, 0, vring_size(num, 4096));
>>>> -	vring_init(&info->vring, num, info->ring, 4096);
>>>> +	memset(info->ring, 0, vring_size(num, ALIGN));
>>>> +	vring_init(&info->vring, num, info->ring, ALIGN);
>>>>    	info->vq = __vring_new_virtqueue(info->idx, info->vring, vdev, true,
>>>>    					 false, vq_notify, vq_callback, "test");
>>>>    	assert(info->vq);
>>>> @@ -115,7 +118,7 @@ static void vq_info_add(struct vdev_info *dev, int num)
>>>>    	info->idx = dev->nvqs;
>>>>    	info->kick = eventfd(0, EFD_NONBLOCK);
>>>>    	info->call = eventfd(0, EFD_NONBLOCK);
>>>> -	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
>>>> +	r = posix_memalign(&info->ring, PAGE_SIZE, vring_size(num, ALIGN));
>>>>    	assert(r >= 0);
>>>>    	vq_reset(info, num, &dev->vdev);
>>>>    	vhost_vq_setup(dev, info);
>>> This is actually doing more than what commit log says.
>>>
>>>> @@ -131,7 +134,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>>>>    	dev->vdev.features = features;
>>>>    	INIT_LIST_HEAD(&dev->vdev.vqs);
>>>>    	spin_lock_init(&dev->vdev.vqs_list_lock);
>>>> -	dev->buf_size = 1024;
>>>> +	dev->buf_size = BUF_SIZE;
>>>>
>>>>
>>>> This seems to have zero added value.
>>>>
>> Since the reason above and other magic number have been set as a defined
>> constant, change here for simplicity and consistency.
>>>>    	dev->buf = malloc(dev->buf_size);
>>>>    	assert(dev->buf);
>>>>            dev->control = open("/dev/vhost-test", O_RDWR);
>>>> @@ -396,7 +399,8 @@ int main(int argc, char **argv)
>>>>    done:
>>>>    	vdev_info_init(&dev, features);
>>>> -	vq_info_add(&dev, 256);
>>>> -	run_test(&dev, &dev.vqs[0], delayed, batch, reset, 0x100000);
>>>> +	vq_info_add(&dev, RINGSIZE);
>>>> +
>>>> +	run_test(&dev, &dev.vqs[0], delayed, batch, reset, TEST_BUF_NUM);
>>>>    	return 0;
>>> This replacement does not buy us anything either.
>> RINGSIZE will be used in other place in subsequent modification.
>>>>    }
>>>> -- 
>>>> 2.17.1


