Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B89546F8D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhLJB7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:59:35 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15715 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhLJB7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:59:35 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J9DSf2zBkzZdSk;
        Fri, 10 Dec 2021 09:53:06 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 09:55:59 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 09:55:58 +0800
Subject: Re: [PATCH] iommu/iova: wait 'fq_timer' handler to finish before
 destroying 'fq'
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <yaohongbo@huawei.com>, <huawei.libin@huawei.com>
References: <1564219269-14346-1-git-send-email-wangxiongfeng2@huawei.com>
 <ef2c9b27-a644-928d-5bae-1ae4d2f2c099@arm.com>
 <ebfebc58-10b5-c12e-edbe-a22181721c2d@arm.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <c414965e-16cf-32a4-14c3-4f3793086695@huawei.com>
Date:   Fri, 10 Dec 2021 09:55:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ebfebc58-10b5-c12e-edbe-a22181721c2d@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/10 1:48, Robin Murphy wrote:
> On 2021-12-09 13:17, Robin Murphy wrote:
>> Sorry I missed this before...
>>
>> On 2019-07-27 10:21, Xiongfeng Wang wrote:
>>> Fix following crash that occurs when 'fq_flush_timeout()' access
>>> 'fq->lock' while 'iovad->fq' has been cleared. This happens when the
>>> 'fq_timer' handler is being executed and we call
>>> 'free_iova_flush_queue()'. When the timer handler is being executed,
>>> its pending state is cleared and it is detached. This patch use
>>> 'del_timer_sync()' to wait for the timer handler 'fq_flush_timeout()' to
>>> finish before destroying the flush queue.
>>
>> So if I understand correctly, you shut down the device - which naturally frees
>> some DMA mappings into the FQ - then hotplug it out, such that tearing down
>> its group and default domain can end up racing with the timeout firing on a
>> different CPU? It would help if the commit message actually explained that -
>> I've just reverse-engineered it from the given symptom - rather than focusing
>> on details that aren't really important. fq->lock is hardly significant, since
>> *any* access to the FQ while it's being destroyed is fundamentally unsound. I
>> also spent way too long trying to understand the significance of the full
>> stack trace below before realising that it is in fact just irrelevant -
>> there's only one way fq_flush_timeout() ever gets called, and it's the obvious
>> one.
>>
>> The fix itself seems reasonable - the kerneldoc for del_timer_sync() is
>> slightly scary, but since free_iova_flush_queue() doesn't touch any of the
>> locks and definitely shouldn't run in IRQ context I believe we're OK.

Our internal version has merged this modification for about two years and didn't
cause any problems. So I think we're OK.

>>
>> This will affect my IOVA refactoring series a little, so I'm happy to help
>> improve the writeup if you like - provided that my understanding is actually
>> correct - and include it in a v2 of that.
> 
> FWIW, this is what I came up with:
> 
> https://gitlab.arm.com/linux-arm/linux-rm/-/commit/ecea6835baca75b945bd8ecfaa636ff01dabcc1d
> 
> 
> Let me know what you think.

Thanks for the writeup. It is exactly the situation I came across.

Thanks,
Xiongfeng

> 
> Thanks,
> Robin.
> .
