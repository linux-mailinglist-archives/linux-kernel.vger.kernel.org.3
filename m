Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD066571A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiGLMvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiGLMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:51:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CB84D15C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D04DB81865
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8DBC385A2;
        Tue, 12 Jul 2022 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657630268;
        bh=gf3Kh9mGjGhhDRkCSjil3HxV2z0Hza6K7hRiT1t8UU0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eICNQS0eU6+uLjgcbP0KlGBORCgUlRVgfXxIqlvx9aunc2ermkOqca6ZEGo/u20DZ
         h/v/s7zMewE8b4/YXDmX2qFt8jNfPXAUHozEtGhDtg9Kbk/zFmNCJ/u1kw48nhI+XN
         89FmgjoZBM2njZdtglGmjm8xxSOq+c+yqvMhJAMJ1AW80MzO4V3qSsdufxDEh0EbFg
         9RjhETP0qv+HL9EtYW+TrWMpuAiVU/yA9NO8NrZU+nazgbStMbH0ZYei1JXG32dVZ0
         pZjGnCbB4j6Q+XIzgVe+KFP9//lv08FB6Rz2ZKt6Q83zTmcgb8BrAVvP35MvhojOk4
         p0GBbQ/MxfdbA==
Message-ID: <c49403fb-119c-f363-8a67-a5f1f535bb1c@kernel.org>
Date:   Tue, 12 Jul 2022 20:51:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] f2fs: add some sysfs nodes for segment
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Guowei Du <duguoweisz@gmail.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
References: <20220706020615.29938-1-duguoweisz@gmail.com>
 <YszRrHHqLk4My3vO@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YszRrHHqLk4My3vO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/12 9:43, Jaegeuk Kim wrote:
> On 07/06, Guowei Du wrote:
>> From: duguowei <duguowei@xiaomi.com>
>>
>> There are two ways to show meta segment information,
>> one is by dump.f2fs, another is by sysfs node. But,
>> sometimes dump needs root privilege,So adding a
>> few sysfs nodes.

If this is used for debug, how about checking /sys/kernel/debug/f2fs/status?

Thanks,

>>
>> The generic permission of node is 0444(S_IRUGO).
>>
>> $ cd /sys/fs/f2fs/DEVICE/...
>> $ ls -l
>> ...
>> -r--r--r-- 1 root root 4096 7月   5 23:21 reserved_segments
>> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count
>> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_ckpt
>> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_main
>> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_nat
>> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_sit
>> -r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_ssa
>> ...
>>
>> $ sudo dump.f2fs -d 1 DEVICE
>> ...
>> Super block
>> segment_count                           [0x      26 : 38]
>> segment_count_ckpt                      [0x       2 : 2]
>> segment_count_sit                       [0x       2 : 2]
>> segment_count_nat                       [0x       2 : 2]
>> segment_count_ssa                       [0x       1 : 1]
>> segment_count_main                      [0x      1f : 31]
>> ...
>> Checkpoint
>> rsvd_segment_count                      [0x       e : 14]
>> ...
>>
>> Signed-off-by: duguowei <duguowei@xiaomi.com>
>> ---
>>   fs/f2fs/sysfs.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index 4c50aedd5144..05350bba2c83 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -697,6 +697,55 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
>>   	return sprintf(buf, "unsupported\n");
>>   }
>>   
>> +static ssize_t segment_count_show(struct f2fs_attr *a,
>> +		struct f2fs_sb_info *sbi, char *buf)
>> +{
>> +	return sprintf(buf, "%llu\n",
>> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count));
>> +}
>> +
>> +static ssize_t segment_count_ckpt_show(struct f2fs_attr *a,
>> +		struct f2fs_sb_info *sbi, char *buf)
>> +{
>> +	return sprintf(buf, "%llu\n",
>> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_ckpt));
>> +}
>> +
>> +static ssize_t segment_count_sit_show(struct f2fs_attr *a,
>> +		struct f2fs_sb_info *sbi, char *buf)
>> +{
>> +	return sprintf(buf, "%llu\n",
>> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_sit));
>> +}
>> +
>> +static ssize_t segment_count_nat_show(struct f2fs_attr *a,
>> +		struct f2fs_sb_info *sbi, char *buf)
>> +{
>> +	return sprintf(buf, "%llu\n",
>> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_nat));
>> +}
>> +
>> +static ssize_t segment_count_ssa_show(struct f2fs_attr *a,
>> +		struct f2fs_sb_info *sbi, char *buf)
>> +{
>> +	return sprintf(buf, "%llu\n",
>> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_ssa));
>> +}
>> +
>> +static ssize_t segment_count_main_show(struct f2fs_attr *a,
>> +		struct f2fs_sb_info *sbi, char *buf)
>> +{
>> +	return sprintf(buf, "%llu\n",
>> +			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_main));
>> +}
>> +
>> +static ssize_t reserved_segments_show(struct f2fs_attr *a,
>> +		struct f2fs_sb_info *sbi, char *buf)
>> +{
>> +	return sprintf(buf, "%llu\n",
>> +			(unsigned long long)(reserved_segments(sbi)));
>> +}
> 
> Can we create a macro to do the above functions?
> 
>> +
>>   #define F2FS_SB_FEATURE_RO_ATTR(_name, _feat)			\
>>   static struct f2fs_attr f2fs_attr_sb_##_name = {		\
>>   	.attr = {.name = __stringify(_name), .mode = 0444 },	\
>> @@ -801,6 +850,13 @@ F2FS_GENERAL_RO_ATTR(moved_blocks_background);
>>   F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
>>   F2FS_GENERAL_RO_ATTR(avg_vblocks);
>>   #endif
>> +F2FS_GENERAL_RO_ATTR(segment_count);
>> +F2FS_GENERAL_RO_ATTR(segment_count_ckpt);
>> +F2FS_GENERAL_RO_ATTR(segment_count_sit);
>> +F2FS_GENERAL_RO_ATTR(segment_count_nat);
>> +F2FS_GENERAL_RO_ATTR(segment_count_ssa);
>> +F2FS_GENERAL_RO_ATTR(segment_count_main);
>> +F2FS_GENERAL_RO_ATTR(reserved_segments);
>>   
>>   #ifdef CONFIG_FS_ENCRYPTION
>>   F2FS_FEATURE_RO_ATTR(encryption);
>> @@ -934,6 +990,13 @@ static struct attribute *f2fs_attrs[] = {
>>   	ATTR_LIST(gc_reclaimed_segments),
>>   	ATTR_LIST(max_fragment_chunk),
>>   	ATTR_LIST(max_fragment_hole),
>> +	ATTR_LIST(segment_count),
>> +	ATTR_LIST(segment_count_ckpt),
>> +	ATTR_LIST(segment_count_sit),
>> +	ATTR_LIST(segment_count_nat),
>> +	ATTR_LIST(segment_count_ssa),
>> +	ATTR_LIST(segment_count_main),
>> +	ATTR_LIST(reserved_segments),
>>   	NULL,
>>   };
>>   ATTRIBUTE_GROUPS(f2fs);
>> -- 
>> 2.36.1
