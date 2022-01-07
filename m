Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070E748708B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345462AbiAGCgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:36:52 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:33129 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344793AbiAGCgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:36:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V18E5FX_1641523008;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0V18E5FX_1641523008)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Jan 2022 10:36:49 +0800
Subject: Re: [PATCH] virtio-pci: fix memory leak of vp_dev
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220106083123.4064853-1-xianting.tian@linux.alibaba.com>
 <CACGkMEuW5po+v-fFPNH6wtVVXD84Bx0UWhe86sHFYXQM39OKRA@mail.gmail.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <9589357f-8d23-5a48-c5f6-ba17eb79cf57@linux.alibaba.com>
Date:   Fri, 7 Jan 2022 10:36:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CACGkMEuW5po+v-fFPNH6wtVVXD84Bx0UWhe86sHFYXQM39OKRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I checked this before your reply, it is not a bug,

Sorry for the inconvenience caused.

在 2022/1/7 上午10:34, Jason Wang 写道:
> On Thu, Jan 6, 2022 at 4:31 PM Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>> In virtio_pci_probe(), vp_dev will not be freed if it goes to
>> "err_register" branch. fix it
>>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> So we had this:
>
> commit 33635bd976fb4c3ccf0cfbb81a8d29bb87760607
> Author: weiping zhang <zhangweiping@didichuxing.com>
> Date:   Thu Dec 21 20:40:24 2017 +0800
>
>      virtio_pci: don't kfree device on register failure
>
>      As mentioned at drivers/base/core.c:
>      /*
>       * NOTE: _Never_ directly free @dev after calling this function, even
>       * if it returned an error! Always use put_device() to give up the
>       * reference initialized in this function instead.
>       */
>      so we don't free vp_dev until vp_dev->vdev.dev.release be called.
>
>      Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>      Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> Any reason that the above fix is wrong?
>
> Thanks
>
>> ---
>>   drivers/virtio/virtio_pci_common.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> index fdbde1db5..48b5ac15e 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -602,8 +602,7 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>>   err_enable_device:
>>          if (reg_dev)
>>                  put_device(&vp_dev->vdev.dev);
>> -       else
>> -               kfree(vp_dev);
>> +       kfree(vp_dev);
>>          return rc;
>>   }
>>
>> --
>> 2.17.1
>>
