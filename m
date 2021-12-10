Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E96A47082E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245152AbhLJSQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:16:51 -0500
Received: from foss.arm.com ([217.140.110.172]:45808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238333AbhLJSQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:16:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70F0212FC;
        Fri, 10 Dec 2021 10:13:15 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3668E3F73D;
        Fri, 10 Dec 2021 10:13:14 -0800 (PST)
Message-ID: <80145652-b9ca-57b5-ad95-ca12d6a25eea@arm.com>
Date:   Fri, 10 Dec 2021 18:13:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 01/11] iommu/iova: Fix race between FQ timeout and
 teardown
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <ecea6835baca75b945bd8ecfaa636ff01dabcc1d.1639157090.git.robin.murphy@arm.com>
 <03cbd9c4-0f11-895b-8eb5-1b75bb74d37c@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <03cbd9c4-0f11-895b-8eb5-1b75bb74d37c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-10 18:04, John Garry via iommu wrote:
> On 10/12/2021 17:54, Robin Murphy wrote:
>> From: Xiongfeng Wang<wangxiongfeng2@huawei.com>
>>
>> It turns out to be possible for hotplugging out a device to reach the
>> stage of tearing down the device's group and default domain before the
>> domain's flush queue has drained naturally. At this point, it is then
>> possible for the timeout to expire just*before*  the del_timer() call
> 
> super nit: "just*before*  the" - needs a whitespace before "before" :)

Weird... the original patch file here and the copy received by lore via 
linux-iommu look fine, gremlins in your MUA or delivery path perhaps?

>> from free_iova_flush_queue(), such that we then proceed to free the FQ
>> resources while fq_flush_timeout() is still accessing them on another
>> CPU. Crashes due to this have been observed in the wild while removing
>> NVMe devices.
>>
>> Close the race window by using del_timer_sync() to safely wait for any
>> active timeout handler to finish before we start to free things. We
>> already avoid any locking in free_iova_flush_queue() since the FQ is
>> supposed to be inactive anyway, so the potential deadlock scenario does
>> not apply.
>>
>> Fixes: 9a005a800ae8 ("iommu/iova: Add flush timer")
>> Signed-off-by: Xiongfeng Wang<wangxiongfeng2@huawei.com>
>> [ rm: rewrite commit message ]
>> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> 
> FWIW,
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks John!

Robin.
