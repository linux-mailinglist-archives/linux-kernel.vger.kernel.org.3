Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12142465DA8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 06:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhLBFKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 00:10:46 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28143 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhLBFKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 00:10:45 -0500
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J4P5M4KXgz1DJcy;
        Thu,  2 Dec 2021 13:04:39 +0800 (CST)
Received: from [10.174.179.2] (10.174.179.2) by canpemm500008.china.huawei.com
 (7.192.105.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 2 Dec
 2021 13:07:21 +0800
Subject: Re: [PATCH] md: Fix unexpected behaviour in is_mddev_idle
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <song@kernel.org>, <axboe@kernel.dk>, <hare@suse.de>,
        <jack@suse.cz>, <ming.lei@redhat.com>, <tj@kernel.org>,
        <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linfeilong@huawei.com>
References: <20211201032712.3684503-1-lijinlin3@huawei.com>
 <Yad9phRUdKF/giGD@bombadil.infradead.org>
From:   Li Jinlin <lijinlin3@huawei.com>
Message-ID: <cc737240-a6d2-2c12-d9c8-877c8018b505@huawei.com>
Date:   Thu, 2 Dec 2021 13:07:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yad9phRUdKF/giGD@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/2021 9:50 PM, Luis Chamberlain wrote:
> On Wed, Dec 01, 2021 at 11:27:12AM +0800, Li Jinlin wrote:
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 5111ed966947..f47035838c43 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8429,14 +8429,14 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>>  {
>>  	struct md_rdev *rdev;
>>  	int idle;
>> -	int curr_events;
>> +	long curr_events;
> 
>>  
>>  	idle = 1;
>>  	rcu_read_lock();
>>  	rdev_for_each_rcu(rdev, mddev) {
>>  		struct gendisk *disk = rdev->bdev->bd_disk;
>> -		curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
>> -			      atomic_read(&disk->sync_io);
>> +		curr_events = (long)part_stat_read_accum(disk->part0, sectors) -
>> +			      atomic64_read(&disk->sync_io);
> 
> And what makes you believe you might not have to go and change all other
> drivers to address this as well? 
The drdb driver also have same problem. I will resend this patch together with
the fix patch of drdb driver.

Thanks,
JinLin


> 
>>  static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>> index 74c410263113..efa7884de11b 100644
>> --- a/include/linux/genhd.h
>> +++ b/include/linux/genhd.h
>> @@ -150,7 +150,7 @@ struct gendisk {
>>  	struct list_head slave_bdevs;
>>  #endif
>>  	struct timer_rand_state *random;
>> -	atomic_t sync_io;		/* RAID */
>> +	atomic64_t sync_io;		/* RAID */
>>  	struct disk_events *ev;
>>  #ifdef  CONFIG_BLK_DEV_INTEGRITY
>>  	struct kobject integrity_kobj;
>> -- 
>> 2.31.1
> 
>   Luis
> .
> 
