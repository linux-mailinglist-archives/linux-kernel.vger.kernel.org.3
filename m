Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97669470810
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbhLJSI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:08:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4247 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbhLJSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:08:57 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J9f0G3hr0z67mFG;
        Sat, 11 Dec 2021 02:03:26 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 19:05:20 +0100
Received: from [10.47.93.58] (10.47.93.58) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 18:05:19 +0000
Subject: Re: [PATCH v2 01/11] iommu/iova: Fix race between FQ timeout and
 teardown
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <suravee.suthikulpanit@amd.com>, <baolu.lu@linux.intel.com>,
        <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Xiongfeng Wang <wangxiongfeng2@huawei.com>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <ecea6835baca75b945bd8ecfaa636ff01dabcc1d.1639157090.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <03cbd9c4-0f11-895b-8eb5-1b75bb74d37c@huawei.com>
Date:   Fri, 10 Dec 2021 18:04:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <ecea6835baca75b945bd8ecfaa636ff01dabcc1d.1639157090.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.58]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 17:54, Robin Murphy wrote:
> From: Xiongfeng Wang<wangxiongfeng2@huawei.com>
> 
> It turns out to be possible for hotplugging out a device to reach the
> stage of tearing down the device's group and default domain before the
> domain's flush queue has drained naturally. At this point, it is then
> possible for the timeout to expire just*before*  the del_timer() call

super nit: "just*before*  the" - needs a whitespace before "before" :)

> from free_iova_flush_queue(), such that we then proceed to free the FQ
> resources while fq_flush_timeout() is still accessing them on another
> CPU. Crashes due to this have been observed in the wild while removing
> NVMe devices.
> 
> Close the race window by using del_timer_sync() to safely wait for any
> active timeout handler to finish before we start to free things. We
> already avoid any locking in free_iova_flush_queue() since the FQ is
> supposed to be inactive anyway, so the potential deadlock scenario does
> not apply.
> 
> Fixes: 9a005a800ae8 ("iommu/iova: Add flush timer")
> Signed-off-by: Xiongfeng Wang<wangxiongfeng2@huawei.com>
> [ rm: rewrite commit message ]
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

FWIW,

Reviewed-by: John Garry <john.garry@huawei.com>
