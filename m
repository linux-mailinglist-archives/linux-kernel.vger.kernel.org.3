Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5140D4BA02C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiBQMa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:30:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbiBQMax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:30:53 -0500
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CFE2AE287;
        Thu, 17 Feb 2022 04:30:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V4kNBr3_1645101032;
Received: from 30.225.28.137(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V4kNBr3_1645101032)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 20:30:33 +0800
Message-ID: <1a8f724b-e136-51fd-c523-e4c5f2410338@linux.alibaba.com>
Date:   Thu, 17 Feb 2022 20:30:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] uio: add ioctl to uio
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Guixin Liu <kanie@linux.alibaba.com>
Cc:     bostroesser@gmail.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xlpang@linux.alibaba.com
References: <1645064962-94123-1-git-send-email-kanie@linux.alibaba.com>
 <Yg3nmK7iWp7FuoOa@kroah.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
In-Reply-To: <Yg3nmK7iWp7FuoOa@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

> On Thu, Feb 17, 2022 at 10:29:21AM +0800, Guixin Liu wrote:
>> In TCMU, if backstore holds its own userspace buffer, for read cmd, the
>> data needs to be copied from userspace buffer to tcmu data area first,
>> and then needs to be copied from tcmu data area to scsi sgl pages again.
>>
>> To solve this problem, add ioctl to uio to let userspace backstore can
>> copy data between scsi sgl pages and its own buffer directly.
>>
>> Reviewed-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/uio/uio.c          | 22 ++++++++++++++++++++++
>>   include/linux/uio_driver.h |  1 +
> No, sorry, thie uio driver will not be adding ioctls to them.  If you
> need an ioctl, then you should not be using the UIO api but rather use a
> custom character driver instead.
I found that early in 2015, there was developer trying to add ioctl 
interface
to uio framework: 
https://lore.kernel.org/lkml/20151005080149.GB1747@kroah.com/

Some of my customers use tcm_loop & tcmu to simulate block devices, it's 
tcmu
driver that uses uio framework. There maybe more extra work if we tries 
to replace
uio with a new character driver.

Currently tcmu has performance bottleneck, Guixin's patch uses ioctl 
interface
to bypass tcmu data area. I also have implemented a tcmu zero-copy 
feature that
allows tcmu driver map io request sgl's pages to user space, which uses 
ioctl
to do this mapping work, similar to network 
getsockopt(TCP_ZEROCOPY_RECEIVE).

I also understand your concerns about ioctl interface. Except that replacing
uio with a new character driver in tcmu, are there any less complicated 
methods
to complete our needs? Thanks.

Regards,
Xiaoguang Wang
>
> thanks,
>
> greg k-h

