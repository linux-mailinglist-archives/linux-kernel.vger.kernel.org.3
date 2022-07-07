Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EC3569A6D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiGGGYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiGGGYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:24:14 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC4F633F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:24:13 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id C22AF1008B38C;
        Thu,  7 Jul 2022 14:24:09 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id AA519200A5E62;
        Thu,  7 Jul 2022 14:24:09 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zqcuLmg7dGjf; Thu,  7 Jul 2022 14:24:08 +0800 (CST)
Received: from [192.168.24.189] (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id EB9A8200A5E63;
        Thu,  7 Jul 2022 14:24:02 +0800 (CST)
Message-ID: <8a0ca3af-d7dd-9a98-1b08-8d861d25d368@sjtu.edu.cn>
Date:   Thu, 7 Jul 2022 14:24:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] virtio_test: use random length scatterlists to
 test descriptor chain
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
 <20220707024409.1869-4-qtxuning1999@sjtu.edu.cn>
 <20220707011015-mutt-send-email-mst@kernel.org>
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20220707011015-mutt-send-email-mst@kernel.org>
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

On 2022/7/7 13:16, Michael S. Tsirkin wrote:
> On Thu, Jul 07, 2022 at 10:44:08AM +0800, Guo Zhi wrote:
>> Prior implementation only use one descriptor for each io event, which
>> does't test code of descriptor chain. More importantly, one descriptor
>> will not use indirect feature even indirect feature is specified. Use
>> random length scatterlists here to test descriptor chain.
>>
>> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
>> ---
>>   tools/virtio/virtio_test.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>> index 1ecd64271..363695b33 100644
>> --- a/tools/virtio/virtio_test.c
>> +++ b/tools/virtio/virtio_test.c
>> @@ -20,6 +20,7 @@
>>   #include "../../drivers/vhost/test.h"
>>   
>>   #define RANDOM_BATCH -1
>> +#define MAX_SG_FRAGS 8UL
>>   #define ALIGN 4096
>>   #define RINGSIZE   256
>>   #define TEST_BUF_NUM 0x100000
>> @@ -172,7 +173,8 @@ static void wait_for_interrupt(struct vdev_info *dev)
>>   static void run_test(struct vdev_info *dev, struct vq_info *vq,
>>   		     bool delayed, int batch, int reset_n, int bufs)
>>   {
>> -	struct scatterlist sl;
>> +	struct scatterlist sg[MAX_SG_FRAGS];
>> +	int sg_size = 0;
>>   	long started = 0, completed = 0, next_reset = reset_n;
>>   	long completed_before, started_before;
>>   	int r, test = 1;
>> @@ -197,8 +199,11 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>>   
>>   			while (started < bufs &&
>>   			       (started - completed) < batch) {
>> -				sg_init_one(&sl, dev->buf, dev->buf_size);
>> -				r = virtqueue_add_outbuf(vq->vq, &sl, 1,
>> +				sg_size = random() % (MAX_SG_FRAGS - 1) + 1;
>> +				sg_init_table(sg, sg_size);
>> +				for (int i = 0; i < sg_size; ++i)
>> +					sg_set_buf(&sg[i], dev->buf + i, 0x1);
>> +				r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
>>   							 dev->buf + started,
>>   							 GFP_ATOMIC);
>>   				if (unlikely(r != 0)) {
> random on data path is pretty expensive.
> I would suggest get an array size from user (and maybe a seed?) and
> pregenerate some numbers, then reuse.
SGTM, I will prepare a random number array before add outbuf begin.
>
>> -- 
>> 2.17.1


