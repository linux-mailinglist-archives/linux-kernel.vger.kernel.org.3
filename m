Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B32569A39
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiGGGFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGGGFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:05:23 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9233D224
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:05:22 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id 630991008B388;
        Thu,  7 Jul 2022 14:05:20 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 2511F2008B691;
        Thu,  7 Jul 2022 14:05:20 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gInKtoODPw0H; Thu,  7 Jul 2022 14:05:20 +0800 (CST)
Received: from [192.168.24.189] (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 77D42200C91EE;
        Thu,  7 Jul 2022 14:05:11 +0800 (CST)
Message-ID: <6a993072-eef9-74f1-bd39-0323e8af81eb@sjtu.edu.cn>
Date:   Thu, 7 Jul 2022 14:05:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] virtio_test: enable indirection feature
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
 <20220707024409.1869-5-qtxuning1999@sjtu.edu.cn>
 <20220707005311-mutt-send-email-mst@kernel.org>
 <2ff418ad-0ab8-1474-4308-2d163c1e6652@sjtu.edu.cn>
 <20220707015717-mutt-send-email-mst@kernel.org>
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20220707015717-mutt-send-email-mst@kernel.org>
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

On 2022/7/7 13:59, Michael S. Tsirkin wrote:
> On Thu, Jul 07, 2022 at 01:56:37PM +0800, Guo Zhi wrote:
>> On 2022/7/7 12:59, Michael S. Tsirkin wrote:
>>> On Thu, Jul 07, 2022 at 10:44:09AM +0800, Guo Zhi wrote:
>>>> Prior implementation don't use indirection feature because there is only
>>>> one descriptor for every io event, actually prior implementation don't
>>>> support indirection because vhost can't translate and find the indirect
>>>> descriptors. This commit enable virtio_test malloc indirect descriptors
>>>> in a indirect buffer and map this buffer to vhost, thus resolve this
>>>> problem.
>>>>
>>>> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
>>>> ---
>>>>    tools/virtio/virtio_test.c | 50 ++++++++++++++++++++++++++++++++------
>>>>    1 file changed, 42 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>>>> index 363695b33..dca408a5c 100644
>>>> --- a/tools/virtio/virtio_test.c
>>>> +++ b/tools/virtio/virtio_test.c
>>>> @@ -25,7 +25,7 @@
>>>>    #define RINGSIZE   256
>>>>    #define TEST_BUF_NUM 0x100000
>>>>    #define BUF_SIZE   1024
>>>> -/* Unused */
>>>> +#define INDIRECTS_SIZE   (RINGSIZE * sizeof(struct vring_desc) * 8)
>>>>    void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
>>>>    struct vq_info {
>>>> @@ -47,6 +47,8 @@ struct vdev_info {
>>>>    	int nvqs;
>>>>    	void *buf;
>>>>    	size_t buf_size;
>>>> +	void *indirects;
>>>> +	size_t indirects_size;
>>> What are these exactly?
>> The buffer is used to put indirect descriptors, and the buffer will be added
>> in the vhost iotlb through VHOST_SET_MEM_TABLE, so that vhost can translate
>> the descriptors in user mode correctly.
> Pls come up with a better name. indirect_buf and indirect_buf_size?
> And add a comment.
Will be modified in next version batch.
>
>>>>    	struct vhost_memory *mem;
>>>>    };
>>>> @@ -131,6 +133,8 @@ static void vq_info_add(struct vdev_info *dev, int num)
>>>>    static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>>>>    {
>>>>    	int r;
>>>> +	int nregions = 2;
>>>> +
>>>>    	memset(dev, 0, sizeof *dev);
>>>>    	dev->vdev.features = features;
>>>>    	INIT_LIST_HEAD(&dev->vdev.vqs);
>>>> @@ -138,19 +142,25 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>>>>    	dev->buf_size = BUF_SIZE;
>>>>    	dev->buf = malloc(dev->buf_size);
>>>>    	assert(dev->buf);
>>>> -        dev->control = open("/dev/vhost-test", O_RDWR);
>>>> +	dev->indirects_size = INDIRECTS_SIZE;
>>>> +	dev->indirects = malloc(dev->indirects_size);
>>>> +	assert(dev->indirects);
>>>> +	dev->control = open("/dev/vhost-test", O_RDWR);
>>>>    	assert(dev->control >= 0);
>>>>    	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
>>>>    	assert(r >= 0);
>>>>    	dev->mem = malloc(offsetof(struct vhost_memory, regions) +
>>>> -			  sizeof dev->mem->regions[0]);
>>>> +			(sizeof(dev->mem->regions[0])) * nregions);
>>>>    	assert(dev->mem);
>>>>    	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
>>>> -                          sizeof dev->mem->regions[0]);
>>>> -	dev->mem->nregions = 1;
>>>> +			(sizeof(dev->mem->regions[0])) * nregions);
>>>> +	dev->mem->nregions = nregions;
>>>>    	dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
>>>>    	dev->mem->regions[0].userspace_addr = (long)dev->buf;
>>>>    	dev->mem->regions[0].memory_size = dev->buf_size;
>>>> +	dev->mem->regions[1].guest_phys_addr = (long)dev->indirects;
>>>> +	dev->mem->regions[1].userspace_addr = (long)dev->indirects;
>>>> +	dev->mem->regions[1].memory_size = dev->indirects_size;
>>>>    	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
>>>>    	assert(r >= 0);
>>>>    }
>>>> @@ -170,6 +180,19 @@ static void wait_for_interrupt(struct vdev_info *dev)
>>>>    		}
>>>>    }
>>>> +static int test_virtqueue_add_outbuf(struct virtqueue *vq,
>>>> +				     struct scatterlist *sg, unsigned int num,
>>>> +				     void *data, void *indirects)
>>>> +{
>>>> +	int r;
>>>> +
>>>> +	__kmalloc_fake = indirects;
>>>> +	r = virtqueue_add_outbuf(vq, sg, num, data,
>>>> +				 GFP_ATOMIC);
>>>> +	__kmalloc_fake = NULL;
>>>> +	return r;
>>>> +}
>>>> +
>>> Quite a hack. Please add comments with documentation. Also - no way to
>>> avoid hacks?
>> The __kmalloc_fake is refered from vringh_test.
>>
>> If not using __kmalloc_fake here, the vhost doesn't know how to translate
>> the indirects descriptors(user address).
>>
>> We may could register a single region as large as the whole virtual space in
>> the vhost iotlb using 1:1 mapping.
>>
>> But since they are tests, IMHO, better here to use VHOST_SET_MEM_TABLE with
>> more regions.
> But why do we need to do this on each buffer add?
Because kmalloc in virtio_test will return address __kmalloc_fake. Since 
there are many descriptors batched here, It will be erase existed unused 
descriptors' indirect descriptors if using the same area for every 
buffer add.
>
>>>>    static void run_test(struct vdev_info *dev, struct vq_info *vq,
>>>>    		     bool delayed, int batch, int reset_n, int bufs)
>>>>    {
>>>> @@ -181,6 +204,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>>>>    	unsigned len;
>>>>    	long long spurious = 0;
>>>>    	const bool random_batch = batch == RANDOM_BATCH;
>>>> +	void *indirects;
>>>>    	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
>>>>    	assert(r >= 0);
>>>> @@ -188,10 +212,15 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>>>>    		next_reset = INT_MAX;
>>>>    	}
>>>> +	/* Don't kfree indirects. */
>>>> +	__kfree_ignore_start = dev->indirects;
>>>> +	__kfree_ignore_end = dev->indirects + dev->indirects_size;
>>>> +
>>>>    	for (;;) {
>>>>    		virtqueue_disable_cb(vq->vq);
>>>>    		completed_before = completed;
>>>>    		started_before = started;
>>>> +		indirects = dev->indirects;
>>>>    		do {
>>>>    			const bool reset = completed > next_reset;
>>>>    			if (random_batch)
>>>> @@ -203,9 +232,13 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>>>>    				sg_init_table(sg, sg_size);
>>>>    				for (int i = 0; i < sg_size; ++i)
>>>>    					sg_set_buf(&sg[i], dev->buf + i, 0x1);
>>>> -				r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
>>>> -							 dev->buf + started,
>>>> -							 GFP_ATOMIC);
>>>> +
>>>> +				// use indirects buffer repeatedly
>>> C style comments please.
>> It will be modified.
>>>> +				if (indirects + sg_size * sizeof(struct vring_desc) >
>>>> +						dev->indirects + dev->indirects_size)
>>>> +					indirects = dev->indirects;
>>>> +				r = test_virtqueue_add_outbuf(vq->vq, sg, sg_size,
>>>> +							      dev->buf + started, indirects);
>>>>    				if (unlikely(r != 0)) {
>>>>    					if (r == -ENOSPC &&
>>>>    					    started > started_before)
>>>> @@ -216,6 +249,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>>>>    				}
>>>>    				++started;
>>>> +				indirects += sg_size * sizeof(struct vring_desc);
>>>>    			}
>>>>    			if (unlikely(!virtqueue_kick(vq->vq))) {
>>>>    				r = -1;
>>>> -- 
>>>> 2.17.1


