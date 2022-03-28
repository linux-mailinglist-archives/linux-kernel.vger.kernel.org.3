Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7064E90D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbiC1JPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiC1JPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:15:03 -0400
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A94CE5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:13:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V8QUIIa_1648458797;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0V8QUIIa_1648458797)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 17:13:18 +0800
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq call in vring hot
 path
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220324073340.632656-1-xianting.tian@linux.alibaba.com>
 <20220328090503.wk5idknhwsbunkjs@sgarzare-redhat>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <7d0d6b08-321e-2e09-3ced-add916e6f07d@linux.alibaba.com>
Date:   Mon, 28 Mar 2022 17:13:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220328090503.wk5idknhwsbunkjs@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/3/28 下午5:05, Stefano Garzarella 写道:

> On Thu, Mar 24, 2022 at 03:33:40PM +0800, Xianting Tian wrote:
>> It passes '_vq' to virtqueue_use_indirect(), which still calls
>> to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
>> unnecessary call of to_vvq in hot path.
>
> It seems reasonable to me.
>
>>
>> Other tiny optimization:
>> Add unlikely to "if (vq->vq.num_free < descs_used).
>
> Better to do this change in another patch.
Thanks for the reply, I will send the patchset, which contains the two 
patches, soon.
>
> Thanks,
> Stefano
>
>>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>> drivers/virtio/virtio_ring.c | 10 ++++------
>> 1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 962f1477b1fa..ab6d5f0cb579 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -205,11 +205,9 @@ struct vring_virtqueue {
>>
>> #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>>
>> -static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
>> +static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>>                       unsigned int total_sg)
>> {
>> -    struct vring_virtqueue *vq = to_vvq(_vq);
>> -
>>     /*
>>      * If the host supports indirect descriptor tables, and we have 
>> multiple
>>      * buffers, then go indirect. FIXME: tune this threshold
>> @@ -507,7 +505,7 @@ static inline int virtqueue_add_split(struct 
>> virtqueue *_vq,
>>
>>     head = vq->free_head;
>>
>> -    if (virtqueue_use_indirect(_vq, total_sg))
>> +    if (virtqueue_use_indirect(vq, total_sg))
>>         desc = alloc_indirect_split(_vq, total_sg, gfp);
>>     else {
>>         desc = NULL;
>> @@ -527,7 +525,7 @@ static inline int virtqueue_add_split(struct 
>> virtqueue *_vq,
>>         descs_used = total_sg;
>>     }
>>
>> -    if (vq->vq.num_free < descs_used) {
>> +    if (unlikely(vq->vq.num_free < descs_used)) {
>>         pr_debug("Can't add buf len %i - avail = %i\n",
>>              descs_used, vq->vq.num_free);
>>         /* FIXME: for historical reasons, we force a notify here if
>> @@ -1194,7 +1192,7 @@ static inline int virtqueue_add_packed(struct 
>> virtqueue *_vq,
>>
>>     BUG_ON(total_sg == 0);
>>
>> -    if (virtqueue_use_indirect(_vq, total_sg)) {
>> +    if (virtqueue_use_indirect(vq, total_sg)) {
>>         err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
>>                             in_sgs, data, gfp);
>>         if (err != -ENOMEM) {
>> -- 
>> 2.17.1
>>
