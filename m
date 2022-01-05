Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD20485181
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbiAEK4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:56:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4347 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiAEK4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:56:39 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTRD40y1Cz67bNC;
        Wed,  5 Jan 2022 18:53:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 11:56:37 +0100
Received: from [10.47.27.56] (10.47.27.56) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 10:56:37 +0000
Subject: Re: [PATCH -next V2] blk-mq: fix tag_get wait task can't be awakened
To:     Laibin Qiu <qiulaibin@huawei.com>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220105035644.3311480-1-qiulaibin@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ddb3c319-65f3-6045-d0ac-764c7dcc84c2@huawei.com>
Date:   Wed, 5 Jan 2022 10:56:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220105035644.3311480-1-qiulaibin@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.56]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2022 03:56, Laibin Qiu wrote:
> +
>   /*
>    * If a previously inactive queue goes active, bump the active user count.
>    * We need to do this before try to allocate driver tag, then even if fail
> @@ -23,10 +38,16 @@
>    */
>   bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>   {
> +	unsigned int users;
> +
>   	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
> -	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> +	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {
>   		atomic_inc(&hctx->tags->active_queues);
>   
> +		users = atomic_read(&hctx->tags->active_queues);
> +		blk_mq_update_wake_batch(hctx->tags, users);
> +	}
> +
>   	return true;
>   }
>   

This code looks old to me. Which baseline is used here?

Thanks,
John
