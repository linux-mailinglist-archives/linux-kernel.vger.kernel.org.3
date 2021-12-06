Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C746A68F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349173AbhLFUOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:14:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4218 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhLFUOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:14:16 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J7DwB2Wmtz688JQ;
        Tue,  7 Dec 2021 04:06:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 21:10:38 +0100
Received: from [10.47.82.161] (10.47.82.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 20:10:37 +0000
Subject: Re: [PATCH v2 3/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for
 shared tags
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <kashyap.desai@broadcom.com>, <hare@suse.de>
References: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
 <1638794990-137490-4-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <549f1b24-b333-da7a-b598-bab7a070b52e@huawei.com>
Date:   Mon, 6 Dec 2021 20:10:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1638794990-137490-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.161]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 12:49, John Garry wrote:
> Kashyap reports high CPU usage in blk_mq_queue_tag_busy_iter() and callees
> using megaraid SAS RAID card since moving to shared tags [0].
> 
> Previously, when shared tags was shared sbitmap, this function was less
> than optimum since we would iter through all tags for all hctx's,
> yet only ever match upto tagset depth number of rqs.
> 
> Since the change to shared tags, things are even less efficient if we have
> parallel callers of blk_mq_queue_tag_busy_iter(). This is because in
> bt_iter() -> blk_mq_find_and_get_req() there would be more contention on
> accessing each request ref and tags->lock since they are now shared among
> all HW queues.
> 
> Optimise by having separate calls to bt_for_each() for when we're using
> shared tags. In this case no longer pass a hctx, as it is no longer
> relevant, and teach bt_iter() about this.
> 
> Ming suggested something along the lines of this change, apart from a
> different implementation.
> 
> [0]https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/
> 

Fixes: e155b0c238b2 ("blk-mq: Use shared tags for shared sbitmap support")

> Signed-off-by: John Garry<john.garry@huawei.com>
> Reviewed-by: Hannes Reinecke<hare@suse.de>
> Reviewed-by: Ming Lei<ming.lei@redhat.com>
> Reported-and-tested-by: Kashyap Desai<kashyap.desai@broadcom.com>

