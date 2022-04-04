Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDAF4F1803
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378459AbiDDPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378580AbiDDPNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:13:17 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294331263C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:11:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V9D7SET_1649085076;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0V9D7SET_1649085076)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 04 Apr 2022 23:11:18 +0800
Subject: Re: [PATCH 2/2] virtio_ring: add unlikely annotation for free descs
 check
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
 <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
 <20220329075024.eoajm5ufrcfytug4@sgarzare-redhat>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <073dc28b-1707-cd04-daba-13aa4fac5a85@linux.alibaba.com>
Date:   Mon, 4 Apr 2022 23:11:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220329075024.eoajm5ufrcfytug4@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can't find it in next branch, will you apply this patch?

在 2022/3/29 下午3:50, Stefano Garzarella 写道:
> On Mon, Mar 28, 2022 at 06:58:17PM +0800, Xianting Tian wrote:
>> The 'if (vq->vq.num_free < descs_used)' check will almost always be 
>> false.
>>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>> drivers/virtio/virtio_ring.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index d597fc0874ec..ab6d5f0cb579 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -525,7 +525,7 @@ static inline int virtqueue_add_split(struct 
>> virtqueue *_vq,
>>         descs_used = total_sg;
>>     }
>>
>> -    if (vq->vq.num_free < descs_used) {
>> +    if (unlikely(vq->vq.num_free < descs_used)) {
>>         pr_debug("Can't add buf len %i - avail = %i\n",
>>              descs_used, vq->vq.num_free);
>>         /* FIXME: for historical reasons, we force a notify here if
>> -- 
>> 2.17.1
>>
