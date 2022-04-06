Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CF04F5809
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbiDFIec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359317AbiDFId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:33:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509CB18B30
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:01:26 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KY8PS4LtzzQjJN;
        Wed,  6 Apr 2022 10:59:40 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 11:01:24 +0800
Received: from [10.174.177.235] (10.174.177.235) by
 dggpeml500009.china.huawei.com (7.185.36.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 11:01:24 +0800
Message-ID: <25a24259-3ac3-81ab-1c28-f2a4886888b5@huawei.com>
Date:   Wed, 6 Apr 2022 11:01:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [f2fs-dev] [PATCH 4/5] f2fs: get rid of stale fault injection
 code
Content-Language: en-US
To:     Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20220401071909.505086-1-yuyufen@huawei.com>
 <20220401071909.505086-5-yuyufen@huawei.com>
 <0c134e0e-b2d0-0bc0-42fc-cd220ff77e72@kernel.org>
From:   Yufen Yu <yuyufen@huawei.com>
In-Reply-To: <0c134e0e-b2d0-0bc0-42fc-cd220ff77e72@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.235]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/4/1 16:28, Chao Yu wrote:
> On 2022/4/1 15:19, Yufen Yu via Linux-f2fs-devel wrote:
>> Nowly, we can use new fault injection framework. Just delete the
>> stale fault injection code.
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   fs/f2fs/checkpoint.c |  2 +-
>>   fs/f2fs/f2fs.h       | 51 ++----------------------------------------
>>   fs/f2fs/super.c      | 53 --------------------------------------------
>>   fs/f2fs/sysfs.c      | 23 -------------------
>>   4 files changed, 3 insertions(+), 126 deletions(-)
>>

...

>>               break;
>> @@ -1963,14 +1920,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>       if (F2FS_IO_SIZE_BITS(sbi))
>>           seq_printf(seq, ",io_bits=%u",
>>                   F2FS_OPTION(sbi).write_io_size_bits);
>> -#ifdef CONFIG_F2FS_FAULT_INJECTION
>> -    if (test_opt(sbi, FAULT_INJECTION)) {
>> -        seq_printf(seq, ",fault_injection=%u",
>> -                F2FS_OPTION(sbi).fault_info.inject_rate);
>> -        seq_printf(seq, ",fault_type=%u",
>> -                F2FS_OPTION(sbi).fault_info.inject_type);
>> -    }
>> -#endif
> 
> This will cause regression due to it breaks application usage w/ -o
> fault_* mountoption..., I don't think this is the right way.


Thanks for catching this. I admit it's a problem. But, IMO fault_* mount
option are mostly been used in test, not in actual product. So, I think
it may just affect some test applications. With the common fault injection
framework, it can be more easy and flexible to do fault injection test.
Therefore, I want to remove the two mount options directly.

If you really worried about compatibility, how about just reserving the
two inject_* options but without doing any thing for them. We actually
configure fault injections by debugfs in this patch.

Or do you have more better suggestion?

Thanks,
Yufen






