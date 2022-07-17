Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DD35775F9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiGQLdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 07:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGQLdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 07:33:51 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDA8DD0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 04:33:49 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id 286C01008B388;
        Sun, 17 Jul 2022 19:33:45 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 1729A2007EB67;
        Sun, 17 Jul 2022 19:33:45 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id seTJFmOmQv6T; Sun, 17 Jul 2022 19:33:45 +0800 (CST)
Received: from [192.168.24.189] (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 3768B200BFDA8;
        Sun, 17 Jul 2022 19:33:37 +0800 (CST)
Message-ID: <47372b7c-15bf-ba9f-083c-e16bd4d1df04@sjtu.edu.cn>
Date:   Sun, 17 Jul 2022 19:33:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/4] virtio_test: use random length scatterlists to
 test descriptor chain
Content-Language: en-US
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <20220709022745.21020-1-qtxuning1999@sjtu.edu.cn>
 <20220709022745.21020-3-qtxuning1999@sjtu.edu.cn>
 <CAJaqyWcFbxSSyY81_O_0AaTmw0e7_f+S_6F2Tjs1AHSbv-0jfg@mail.gmail.com>
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
In-Reply-To: <CAJaqyWcFbxSSyY81_O_0AaTmw0e7_f+S_6F2Tjs1AHSbv-0jfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/11 23:35, Eugenio Perez Martin wrote:
> On Sat, Jul 9, 2022 at 4:28 AM Guo Zhi <qtxuning1999@sjtu.edu.cn> wrote:
>> Prior implementation only use one descriptor for each io event, which
>> does't test code of descriptor chain. More importantly, one descriptor
>> will not use indirect feature even indirect feature is specified. Use
>> random length scatterlists here to test descriptor chain.
>>
>> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
>> ---
>> v3:
>> - drop fda270fcd virtio_test: move magic number in code as defined constant
>> ---
>>   tools/virtio/virtio_test.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>> index 95f78b311..1408a4a20 100644
>> --- a/tools/virtio/virtio_test.c
>> +++ b/tools/virtio/virtio_test.c
>> @@ -20,6 +20,7 @@
>>   #include "../../drivers/vhost/test.h"
>>
>>   #define RANDOM_BATCH -1
>> +#define MAX_SG_FRAGS 8UL
>>
>>   /* Unused */
>>   void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
>> @@ -169,7 +170,8 @@ static void wait_for_interrupt(struct vdev_info *dev)
>>   static void run_test(struct vdev_info *dev, struct vq_info *vq,
>>                       bool delayed, int batch, int reset_n, int bufs)
>>   {
>> -       struct scatterlist sl;
>> +       struct scatterlist sg[MAX_SG_FRAGS];
>> +       int sg_size = 0;
>>          long started = 0, completed = 0, next_reset = reset_n;
>>          long completed_before, started_before;
>>          int r, test = 1;
>> @@ -194,8 +196,11 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>>
>>                          while (started < bufs &&
>>                                 (started - completed) < batch) {
>> -                               sg_init_one(&sl, dev->buf, dev->buf_size);
>> -                               r = virtqueue_add_outbuf(vq->vq, &sl, 1,
>> +                               sg_size = random() % (MAX_SG_FRAGS - 1) + 1;
> I'm wondering if it would be simpler to reuse batch randomness here,
> and make sg_size = MIN(started - completed, MAX_SG_FRAGS). Vhost test
> should go faster because the longer chains, and I guess we should hit
> a good range of chain lengths with the batch tail anyway.
>
> Thanks!

IMHO, if we reuse batch randomness here, the random length of 
scatterlist only appears when --batch=random selected.

Otherwise, when we have to specify the batch size(eg, 256), the 
scatterlist( as well as the descriptor chain len) will not be randomed. 
So I propose decouple the randomness of batch size and descriptor chain 
length.

If we have to achive better performance for vhost_test, just enlarge the 
MAX_SG_FRAGS is ok.

>> +                               sg_init_table(sg, sg_size);
>> +                               for (int i = 0; i < sg_size; ++i)
>> +                                       sg_set_buf(&sg[i], dev->buf + i, 0x1);
>> +                               r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
>>                                                           dev->buf + started,
>>                                                           GFP_ATOMIC);
>>                                  if (unlikely(r != 0)) {
>> --
>> 2.17.1
>>

