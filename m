Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6E14FDFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352772AbiDLMId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353066AbiDLMDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:03:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702DADFB2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:04:24 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kd2sH56MbzdZmY;
        Tue, 12 Apr 2022 19:03:47 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 19:04:22 +0800
Received: from [10.174.177.235] (10.174.177.235) by
 dggpeml500009.china.huawei.com (7.185.36.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 19:04:22 +0800
Message-ID: <7c6a3d09-0215-cb7d-cf82-0c4fd801d998@huawei.com>
Date:   Tue, 12 Apr 2022 19:04:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [f2fs-dev] [PATCH 4/5] f2fs: get rid of stale fault injection
 code
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <",yuyufen"@huawei.com>
References: <20220401071909.505086-1-yuyufen@huawei.com>
 <20220401071909.505086-5-yuyufen@huawei.com>
 <0c134e0e-b2d0-0bc0-42fc-cd220ff77e72@kernel.org>
 <25a24259-3ac3-81ab-1c28-f2a4886888b5@huawei.com>
 <778b1f04-a71b-a226-f7a7-4833fc9bf7c2@kernel.org>
 <YlSbqay8y6oaCxR6@google.com>
From:   Yufen Yu <yuyufen@huawei.com>
In-Reply-To: <YlSbqay8y6oaCxR6@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.235]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/12 5:20, Jaegeuk Kim wrote:
> On 04/11, Chao Yu wrote:
>> On 2022/4/6 11:01, Yufen Yu via Linux-f2fs-devel wrote:
>>> Hi,
>>>
>>> On 2022/4/1 16:28, Chao Yu wrote:
>>>> On 2022/4/1 15:19, Yufen Yu via Linux-f2fs-devel wrote:
>>>>> Nowly, we can use new fault injection framework. Just delete the
>>>>> stale fault injection code.
>>>>>
>>>>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>>>>> ---
>>>>>    fs/f2fs/checkpoint.c |  2 +-
>>>>>    fs/f2fs/f2fs.h       | 51 ++----------------------------------------
>>>>>    fs/f2fs/super.c      | 53 --------------------------------------------
>>>>>    fs/f2fs/sysfs.c      | 23 -------------------
>>>>>    4 files changed, 3 insertions(+), 126 deletions(-)
>>>>>
>>>
>>> ...
>>>
>>>>>                break;
>>>>> @@ -1963,14 +1920,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>>>>        if (F2FS_IO_SIZE_BITS(sbi))
>>>>>            seq_printf(seq, ",io_bits=%u",
>>>>>                    F2FS_OPTION(sbi).write_io_size_bits);
>>>>> -#ifdef CONFIG_F2FS_FAULT_INJECTION
>>>>> -    if (test_opt(sbi, FAULT_INJECTION)) {
>>>>> -        seq_printf(seq, ",fault_injection=%u",
>>>>> -                F2FS_OPTION(sbi).fault_info.inject_rate);
>>>>> -        seq_printf(seq, ",fault_type=%u",
>>>>> -                F2FS_OPTION(sbi).fault_info.inject_type);
>>>>> -    }
>>>>> -#endif
>>>>
>>>> This will cause regression due to it breaks application usage w/ -o
>>>> fault_* mountoption..., I don't think this is the right way.
>>>
>>>
>>> Thanks for catching this. I admit it's a problem. But, IMO fault_* mount
>>> option are mostly been used in test, not in actual product. So, I think
>>> it may just affect some test applications. With the common fault injection
>>> framework, it can be more easy and flexible to do fault injection test.
>>> Therefore, I want to remove the two mount options directly.
>>>
>>> If you really worried about compatibility, how about just reserving the
>>> two inject_* options but without doing any thing for them. We actually
>>> configure fault injections by debugfs in this patch.
>>>
>>> Or do you have more better suggestion?
>>
>> Could you please consider to keep original logic of f2fs fault injection
>> if user use inject_* options, otherwise following common fault injection
>> framework?
>>
>> Thoughts?
> 
> I think it'd be useful to test roll-forward recovery flow by using those mount
> options, since runtime fault injection cannot enable it during mount.
> 

Yeah, I have not catch this point before.

> BTW, what is the real benefit to use the fault injection framework?
> 

I think fault injection framework can provide more easier and flexible
function than the current one. Furthermore, we can just following it and
don't need to maintain f2fs own fault injection cold.

Thanks,
Yufen
