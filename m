Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778EB50625D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbiDSC7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345778AbiDSC7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:59:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C8726570
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 402B260EC8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAB9C385A7;
        Tue, 19 Apr 2022 02:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650336982;
        bh=ZB1kIJDd9rKP0zmC2YwLqe3ENzZ5SL9YXQYi5U2ZSIQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vIuPv+gHAisg2jyl9g0xvmdCp/pW6YAiMViNMaxEkdORXSvaQKMDqHa265gglfYRU
         noWM850x4IDTOGc2x/dnfnGzLlaHqL0mMQm9y+zpoEJGk9SJijdp6LEPaJ5PkMbQCp
         wkz1dGnFkqWY7FOj8e8N9MpZFpfhGdZumTB5EWs7JZDOGOBoWy/BdilSLq6ca0AEmj
         KPN2KuuuNdZVWI2ykv8GbY1EQiEuUS1nyIzUanz6yrs2CDEzzVFeGAJx9FYT/9FzaC
         40y2LW+0pYf7T9SNtEtb188nrmp4h2xqz5ir4eZzwgdoTOQJImc36VTDDYU49urCQ0
         Cwy3IrcRRjnQw==
Message-ID: <752a79ff-aaf5-d2a8-02a7-1ec63ca954e0@kernel.org>
Date:   Tue, 19 Apr 2022 10:56:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [f2fs-dev] [PATCH 4/5] f2fs: get rid of stale fault injection
 code
Content-Language: en-US
To:     Yufen Yu <yuyufen@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220401071909.505086-1-yuyufen@huawei.com>
 <20220401071909.505086-5-yuyufen@huawei.com>
 <0c134e0e-b2d0-0bc0-42fc-cd220ff77e72@kernel.org>
 <25a24259-3ac3-81ab-1c28-f2a4886888b5@huawei.com>
 <778b1f04-a71b-a226-f7a7-4833fc9bf7c2@kernel.org>
 <YlSbqay8y6oaCxR6@google.com>
 <7c6a3d09-0215-cb7d-cf82-0c4fd801d998@huawei.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <7c6a3d09-0215-cb7d-cf82-0c4fd801d998@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 19:04, Yufen Yu via Linux-f2fs-devel wrote:
> 
> 
> On 2022/4/12 5:20, Jaegeuk Kim wrote:
>> On 04/11, Chao Yu wrote:
>>> On 2022/4/6 11:01, Yufen Yu via Linux-f2fs-devel wrote:
>>>> Hi,
>>>>
>>>> On 2022/4/1 16:28, Chao Yu wrote:
>>>>> On 2022/4/1 15:19, Yufen Yu via Linux-f2fs-devel wrote:
>>>>>> Nowly, we can use new fault injection framework. Just delete the
>>>>>> stale fault injection code.
>>>>>>
>>>>>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>>>>>> ---
>>>>>>    fs/f2fs/checkpoint.c |  2 +-
>>>>>>    fs/f2fs/f2fs.h       | 51 ++----------------------------------------
>>>>>>    fs/f2fs/super.c      | 53 --------------------------------------------
>>>>>>    fs/f2fs/sysfs.c      | 23 -------------------
>>>>>>    4 files changed, 3 insertions(+), 126 deletions(-)
>>>>>>
>>>>
>>>> ...
>>>>
>>>>>>                break;
>>>>>> @@ -1963,14 +1920,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>>>>>        if (F2FS_IO_SIZE_BITS(sbi))
>>>>>>            seq_printf(seq, ",io_bits=%u",
>>>>>>                    F2FS_OPTION(sbi).write_io_size_bits);
>>>>>> -#ifdef CONFIG_F2FS_FAULT_INJECTION
>>>>>> -    if (test_opt(sbi, FAULT_INJECTION)) {
>>>>>> -        seq_printf(seq, ",fault_injection=%u",
>>>>>> -                F2FS_OPTION(sbi).fault_info.inject_rate);
>>>>>> -        seq_printf(seq, ",fault_type=%u",
>>>>>> -                F2FS_OPTION(sbi).fault_info.inject_type);
>>>>>> -    }
>>>>>> -#endif
>>>>>
>>>>> This will cause regression due to it breaks application usage w/ -o
>>>>> fault_* mountoption..., I don't think this is the right way.
>>>>
>>>>
>>>> Thanks for catching this. I admit it's a problem. But, IMO fault_* mount
>>>> option are mostly been used in test, not in actual product. So, I think
>>>> it may just affect some test applications. With the common fault injection
>>>> framework, it can be more easy and flexible to do fault injection test.
>>>> Therefore, I want to remove the two mount options directly.
>>>>
>>>> If you really worried about compatibility, how about just reserving the
>>>> two inject_* options but without doing any thing for them. We actually
>>>> configure fault injections by debugfs in this patch.
>>>>
>>>> Or do you have more better suggestion?
>>>
>>> Could you please consider to keep original logic of f2fs fault injection
>>> if user use inject_* options, otherwise following common fault injection
>>> framework?
>>>
>>> Thoughts?
>>
>> I think it'd be useful to test roll-forward recovery flow by using those mount
>> options, since runtime fault injection cannot enable it during mount.
>>
> 
> Yeah, I have not catch this point before.
> 
>> BTW, what is the real benefit to use the fault injection framework?
>>
> 
> I think fault injection framework can provide more easier and flexible
> function than the current one. Furthermore, we can just following it and
> don't need to maintain f2fs own fault injection cold.

Yufen,

As Jaegeuk mentioned, it needs to keep original f2fs fault injection
framework code in order to cover test during mount(). IIUC.

IMO, one way to add this framework is making those two framework
compatible, but before that, could you please explain the details
of benefit for adapting the common framework?

Thanks,

> 
> Thanks,
> Yufen
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
