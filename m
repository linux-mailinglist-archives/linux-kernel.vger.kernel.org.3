Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE757F5C3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiGXP0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiGXP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:26:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BFA2620
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F514B80D85
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 15:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE021C3411E;
        Sun, 24 Jul 2022 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658676369;
        bh=XawCLPtmZ4fqG7HmHG8DgJxtknVXOhtaMBHOKKVA+a4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TDphJYBgBVXs11PiEkP7SR+Eg8zcMq7InckjTEKmMzSLYPAp3El/IssQZyFeBDrX4
         NpCdJR6xquDs9+vRBQ0W6xo/MaBgSu6m/B7F1LRJCgMVLhqIV+X8Ta52Rtss5dB7Yt
         jeR97CMISQVZF4BkYl0fWZ8+B4PpM/6AmFpyD5It62fklcrTdeiL3y74Mpv+QudklR
         HWzdfaSgl/8sFcANuprXTZBYiX56Jxp5NjjzBmAAAHwoy2YDqCYkyrVZcFtEq3otOy
         Pa9aE8DL/hI6FakHLFPOgb1EVh9lwyJPucxYmKLEZNjSwU69J4lSSBHZv5g1Cpwzi+
         9gfXIYBisGy8g==
Message-ID: <8eaad9d0-1d59-3ecb-bab4-904ed22385f4@kernel.org>
Date:   Sun, 24 Jul 2022 23:26:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] f2fs: modify task name prefix
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Guowei Du <duguoweisz@gmail.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
References: <20220718081038.2279-1-duguoweisz@gmail.com>
 <YtoOxTyWPFUpw/Y0@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YtoOxTyWPFUpw/Y0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/22 10:43, Jaegeuk Kim wrote:
> On 07/18, Guowei Du wrote:
>> From: duguowei <duguowei@xiaomi.com>
>>
>> If there are more than one f2fs sbi, there will be more
>> discard threads. But the comm is too long to show dev
>> minor. So, change the default prefix of thread from
>> "f2fs_discard" to "f2fs_dcd".
> 
> That looks quite unreadable. What about unmap?

FYI,

With commit d6986ce24fc0 ("kthread: dynamically allocate memory to store
kthread's full name"), it has chance to show full name of kthread when
it's not in low memory scenario.

Thanks,

> 
>>
>> Before:
>> $ ps -e | grep f2fs
>> 1628 ?        00:00:00 f2fs_ckpt-7:10
>> 1629 ?        00:00:00 f2fs_flush-7:10
>> 1630 ?        00:00:00 f2fs_discard-7:
>> 1631 ?        00:00:00 f2fs_gc-7:10
>> 2030 ?        00:00:00 f2fs_ckpt-7:27
>> 2031 ?        00:00:00 f2fs_flush-7:27
>> 2032 ?        00:00:00 f2fs_discard-7:
>> 2033 ?        00:00:00 f2fs_gc-7:27
>>
>> After:
>> $ ps -e | grep f2fs
>> 1628 ?        00:00:00 f2fs_ckpt-7:10
>> 1629 ?        00:00:00 f2fs_flush-7:10
>> 1630 ?        00:00:00 f2fs_dcd-7:10
>> 1631 ?        00:00:00 f2fs_gc-7:10
>> 2030 ?        00:00:00 f2fs_ckpt-7:27
>> 2031 ?        00:00:00 f2fs_flush-7:27
>> 2032 ?        00:00:00 f2fs_dcd-7:27
>> 2033 ?        00:00:00 f2fs_gc-7:27
>>
>> Signed-off-by: duguowei <duguowei@xiaomi.com>
>> ---
>>   fs/f2fs/segment.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 874c1b9c41a2..2eeefcbe62db 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2018,7 +2018,7 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
>>   		return 0;
>>   
>>   	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
>> -				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
>> +				"f2fs_dcd-%u:%u", MAJOR(dev), MINOR(dev));
>>   	if (IS_ERR(dcc->f2fs_issue_discard))
>>   		err = PTR_ERR(dcc->f2fs_issue_discard);
>>   
>> -- 
>> 2.36.1
