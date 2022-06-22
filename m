Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4009B554C19
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357856AbiFVOCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357879AbiFVOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:02:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FED37BD1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87412B81F30
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC39C34114;
        Wed, 22 Jun 2022 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655906552;
        bh=KEOm3rqgaJaCmSIo+v3zlFCOBXMloNPUc4mYcPiUjvs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YsKY7PMMvAMkQcB6CXNeZ7Dxe7ZU63lsuH14tVjVBSMHEoe4IkDbDAaxcAmuguGMN
         XMdnBBWgBAGYVfSduxSeMx+zkEjLBZcRNvkpTgQRVRV/oJ9pe3OXTqeCJ+n4wb4VBl
         ovSsGH076r3gb8iriy1hGUl4aeYFYOMRR/5MuI28gbkXEDvCYMlP3DSPGz+UF4X7VM
         R0hmn+xGyV1GIeRaljyF/yFrlexeO3/YhffbJVkuqnfvEohQEvCZtgfrQp8dE36GwW
         Bsy69qhxnpyhaHkDU13KLPMdWVRgTE87ArWEP6xgh3VOaYjVlPN2eQViDix1NTYab2
         c3wd6fgimRg7w==
Message-ID: <27138a10-a6b2-edad-1985-687a95b9039b@kernel.org>
Date:   Wed, 22 Jun 2022 22:02:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: run GCs synchronously given user
 requests
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220617223106.3517374-1-jaegeuk@kernel.org>
 <20220617223106.3517374-2-jaegeuk@kernel.org>
 <c45a9c8b-c73a-76bc-6725-5d7e48e7a3f2@kernel.org>
 <Yq+kiXPyBsXgdYb2@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Yq+kiXPyBsXgdYb2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/20 6:34, Jaegeuk Kim wrote:
> On 06/19, Chao Yu wrote:
>> On 2022/6/18 6:31, Jaegeuk Kim wrote:
>>> When users set GC_URGENT or GC_MID, they expected to do GCs right away.
>>> But, there's a condition to bypass it. Let's indicate we need to do now
>>> in the thread.
>>
>> .should_migrate_blocks is used to force migrating blocks in full
>> section, so what is the condition here? GC should not never select
>> a full section, right?
> 
> I think it'll move a full section given .victim_segno is not NULL_SEGNO,
> as __get_victim will give a dirty segment all the time. wdyt?

However, in gc_thread_fun() victim_segno is NULL_SEGNO all the time.

I guess .should_migrate_blocks should only be set to true for
F2FS_IOC_FLUSH_DEVICE/F2FS_IOC_RESIZE_FS case? rather than GC_URGENT or GC_MID
case? See commit 7dede88659df ("f2fs: fix to allow migrating fully valid segment").

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/gc.c | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index d5fb426e0747..f4aa3c88118b 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -37,7 +37,6 @@ static int gc_thread_func(void *data)
>>>    	unsigned int wait_ms;
>>>    	struct f2fs_gc_control gc_control = {
>>>    		.victim_segno = NULL_SEGNO,
>>> -		.should_migrate_blocks = false,
>>>    		.err_gc_skipped = false };
>>>    	wait_ms = gc_th->min_sleep_time;
>>> @@ -113,7 +112,10 @@ static int gc_thread_func(void *data)
>>>    				sbi->gc_mode == GC_URGENT_MID) {
>>>    			wait_ms = gc_th->urgent_sleep_time;
>>>    			f2fs_down_write(&sbi->gc_lock);
>>> +			gc_control.should_migrate_blocks = true;
>>>    			goto do_gc;
>>> +		} else {
>>> +			gc_control.should_migrate_blocks = false;
>>>    		}
>>>    		if (foreground) {
>>> @@ -139,7 +141,9 @@ static int gc_thread_func(void *data)
>>>    		if (!foreground)
>>>    			stat_inc_bggc_count(sbi->stat_info);
>>> -		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
>>> +		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC ||
>>> +				sbi->gc_mode == GC_URGENT_HIGH ||
>>> +				sbi->gc_mode == GC_URGENT_MID;
>>>    		/* foreground GC was been triggered via f2fs_balance_fs() */
>>>    		if (foreground)
