Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBEA46F273
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbhLIRv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:51:59 -0500
Received: from foss.arm.com ([217.140.110.172]:60262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241380AbhLIRvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:51:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89A86ED1;
        Thu,  9 Dec 2021 09:48:10 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA873F73B;
        Thu,  9 Dec 2021 09:48:09 -0800 (PST)
Message-ID: <ebfebc58-10b5-c12e-edbe-a22181721c2d@arm.com>
Date:   Thu, 9 Dec 2021 17:48:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] iommu/iova: wait 'fq_timer' handler to finish before
 destroying 'fq'
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     yaohongbo@huawei.com, huawei.libin@huawei.com
References: <1564219269-14346-1-git-send-email-wangxiongfeng2@huawei.com>
 <ef2c9b27-a644-928d-5bae-1ae4d2f2c099@arm.com>
In-Reply-To: <ef2c9b27-a644-928d-5bae-1ae4d2f2c099@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-09 13:17, Robin Murphy wrote:
> Sorry I missed this before...
> 
> On 2019-07-27 10:21, Xiongfeng Wang wrote:
>> Fix following crash that occurs when 'fq_flush_timeout()' access
>> 'fq->lock' while 'iovad->fq' has been cleared. This happens when the
>> 'fq_timer' handler is being executed and we call
>> 'free_iova_flush_queue()'. When the timer handler is being executed,
>> its pending state is cleared and it is detached. This patch use
>> 'del_timer_sync()' to wait for the timer handler 'fq_flush_timeout()' to
>> finish before destroying the flush queue.
> 
> So if I understand correctly, you shut down the device - which naturally 
> frees some DMA mappings into the FQ - then hotplug it out, such that 
> tearing down its group and default domain can end up racing with the 
> timeout firing on a different CPU? It would help if the commit message 
> actually explained that - I've just reverse-engineered it from the given 
> symptom - rather than focusing on details that aren't really important. 
> fq->lock is hardly significant, since *any* access to the FQ while it's 
> being destroyed is fundamentally unsound. I also spent way too long 
> trying to understand the significance of the full stack trace below 
> before realising that it is in fact just irrelevant - there's only one 
> way fq_flush_timeout() ever gets called, and it's the obvious one.
> 
> The fix itself seems reasonable - the kerneldoc for del_timer_sync() is 
> slightly scary, but since free_iova_flush_queue() doesn't touch any of 
> the locks and definitely shouldn't run in IRQ context I believe we're OK.
> 
> This will affect my IOVA refactoring series a little, so I'm happy to 
> help improve the writeup if you like - provided that my understanding is 
> actually correct - and include it in a v2 of that.

FWIW, this is what I came up with:

https://gitlab.arm.com/linux-arm/linux-rm/-/commit/ecea6835baca75b945bd8ecfaa636ff01dabcc1d

Let me know what you think.

Thanks,
Robin.
