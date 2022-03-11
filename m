Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84E14D58B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345577AbiCKDME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiCKDMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:12:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF7D14006
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:10:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10F28B829B2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC34C340E8;
        Fri, 11 Mar 2022 03:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646968254;
        bh=zlGhTl9/YkiUSMl74eSzNJcDmU9fpb9Qv0PH5mitNac=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=NI0JTVBOsR8mkwEzChAHX9DF7OSp6G6powR5W6Txde4/5nJ5blAb6g0vB0fa45ucr
         Q7xysFapfaeD+TrQpUsSft3xOf0dq8IlM2+wxsjnnk3xQws9N0VnITAQgqou57if7M
         Kox5NObpSlTloQG0Zk/1QKxrYjL9NPSPGL01WKJkRZrfFw9DEzcqPXuk8Ot2In71Xp
         M2nBjsB5uqSu1PbudsubPhZ8359aCr8O7g59/WDhCJOVPyRqKfuy38XShztaWPtzTZ
         09Zl6TfcVDqAm4XP+tcFgCJMy05BwtKicuVi1V0UcSFLpEfciMeqwV8ER4N04X4iCE
         6aFTFVQOhfAqQ==
Message-ID: <a475c925-cfe4-abf7-f909-0d883df391a2@kernel.org>
Date:   Fri, 11 Mar 2022 11:10:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: evict inode cache for frozen fs
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220309214834.3408741-1-jaegeuk@kernel.org>
 <2a5564bb-463e-d163-0042-34fad42e2e46@kernel.org>
In-Reply-To: <2a5564bb-463e-d163-0042-34fad42e2e46@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

Could you please send v2 patch to mailing list? as I saw the revised
one has been merged in dev branch.

Otherwise, I've no idea where I should reply "Reviewed-by" tag to...

Thanks,

On 2022/3/10 9:53, Chao Yu wrote:
> On 2022/3/10 5:48, Jaegeuk Kim wrote:
>> Let's purge inode cache in order to avoid the below deadlock.
>>
>> [freeze test]                         shrinkder
>> freeze_super
>>   - pwercpu_down_write(SB_FREEZE_FS)
>>                                         - super_cache_scan
>>                                           - down_read(&sb->s_umount)
>>                                             - prune_icache_sb
>>                                              - dispose_list
>>                                               - evict
>>                                                - f2fs_evict_inode
>> thaw_super
>>   - down_write(&sb->s_umount);
>>                                                - __percpu_down_read(SB_FREEZE_FS)
> 
> Ah, finally we catch this. :)
> 
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>   fs/f2fs/debug.c | 1 +
>>   fs/f2fs/f2fs.h  | 1 +
>>   fs/f2fs/inode.c | 6 ++++--
>>   fs/f2fs/super.c | 4 ++++
>>   4 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
>> index 9a13902c7702..cba5eab24595 100644
>> --- a/fs/f2fs/debug.c
>> +++ b/fs/f2fs/debug.c
>> @@ -338,6 +338,7 @@ static char *s_flag[] = {
>>       [SBI_QUOTA_SKIP_FLUSH]    = " quota_skip_flush",
>>       [SBI_QUOTA_NEED_REPAIR]    = " quota_need_repair",
>>       [SBI_IS_RESIZEFS]    = " resizefs",
>> +    [SBI_IS_FREEZING]    = " freezefs",
> 
> Could you please update description of "sb_status" entry in
> Documentation/ABI/testing/sysfs-fs-f2fs as well?
> 
> Thanks,
> 
>>   };
>>   static int stat_show(struct seq_file *s, void *v)
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 68d791ec8b27..da729f53daa8 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1293,6 +1293,7 @@ enum {
>>       SBI_QUOTA_SKIP_FLUSH,            /* skip flushing quota in current CP */
>>       SBI_QUOTA_NEED_REPAIR,            /* quota file may be corrupted */
>>       SBI_IS_RESIZEFS,            /* resizefs is in process */
>> +    SBI_IS_FREEZING,            /* freezefs is in process */
>>   };
>>   enum {
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index ab8e0c06c78c..71f232dcf3c2 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -778,7 +778,8 @@ void f2fs_evict_inode(struct inode *inode)
>>       f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
>>       f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
>> -    sb_start_intwrite(inode->i_sb);
>> +    if (!is_sbi_flag_set(sbi, SBI_IS_FREEZING))
>> +        sb_start_intwrite(inode->i_sb);
>>       set_inode_flag(inode, FI_NO_ALLOC);
>>       i_size_write(inode, 0);
>>   retry:
>> @@ -809,7 +810,8 @@ void f2fs_evict_inode(struct inode *inode)
>>           if (dquot_initialize_needed(inode))
>>               set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>       }
>> -    sb_end_intwrite(inode->i_sb);
>> +    if (!is_sbi_flag_set(sbi, SBI_IS_FREEZING))
>> +        sb_end_intwrite(inode->i_sb);
>>   no_delete:
>>       dquot_drop(inode);
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 8e3840973077..4b570b5c2674 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1663,11 +1663,15 @@ static int f2fs_freeze(struct super_block *sb)
>>       /* ensure no checkpoint required */
>>       if (!llist_empty(&F2FS_SB(sb)->cprc_info.issue_list))
>>           return -EINVAL;
>> +
>> +    /* to avoid deadlock on f2fs_evict_inode->SB_FREEZE_FS */
>> +    set_sbi_flag(F2FS_SB(sb), SBI_IS_FREEZING);
>>       return 0;
>>   }
>>   static int f2fs_unfreeze(struct super_block *sb)
>>   {
>> +    clear_sbi_flag(F2FS_SB(sb), SBI_IS_FREEZING);
>>       return 0;
>>   }
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
