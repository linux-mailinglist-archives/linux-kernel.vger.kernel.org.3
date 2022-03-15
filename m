Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA434D9E60
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245416AbiCOPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiCOPM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:12:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE0D13F10;
        Tue, 15 Mar 2022 08:11:14 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KHxdZ2s5nz67ww1;
        Tue, 15 Mar 2022 23:09:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 15 Mar 2022 16:11:11 +0100
Received: from [10.47.84.96] (10.47.84.96) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 15 Mar
 2022 15:11:10 +0000
Message-ID: <88ec9cac-f2ad-4728-6ce0-eb4358846463@huawei.com>
Date:   Tue, 15 Mar 2022 15:11:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] scsi: core: Fix sbitmap depth in
 scsi_realloc_sdev_budget_map()
To:     Bart Van Assche <bvanassche@acm.org>,
        <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>, <hch@lst.de>,
        <hare@suse.de>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <martin.wilck@suse.com>
References: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
 <1647340746-17600-2-git-send-email-john.garry@huawei.com>
 <51c2d9da-a0c5-8ae5-5c22-ceb56c7f5a27@acm.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <51c2d9da-a0c5-8ae5-5c22-ceb56c7f5a27@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.84.96]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2022 14:33, Bart Van Assche wrote:
>> sbitmap sb_backup;
>> +    depth = min_t(unsigned int, depth, 
>> scsi_device_max_queue_depth(sdev));
>> +
>>       /*
>>        * realloc if new shift is calculated, which is caused by setting
>>        * up one new default queue depth after calling ->slave_configure
>> @@ -245,6 +247,9 @@ static int scsi_realloc_sdev_budget_map(struct 
>> scsi_device *sdev,
>>                   scsi_device_max_queue_depth(sdev),
>>                   new_shift, GFP_KERNEL,
>>                   sdev->request_queue->node, false, true);
>> +    if (!ret)
>> +        sbitmap_resize(&sdev->budget_map, depth);
> 
> Hmm ... why to call both sbitmap_init_node() and sbitmap_resize() 
> instead of combining both calls into a single call with the proper depth?

Hi Bart,

Is the user wants to change the queue depth later via sysfs we do not 
reallocate the sbitmap then. So we need to ensure that the size we 
reallocate here will satisfy the scsi device max depth. I'm referencing 
scsi_change_queue_depth() for this.

Thanks,
John
