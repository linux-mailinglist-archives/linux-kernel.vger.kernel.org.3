Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AF94FCD57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbiDLD4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 23:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiDLD4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2AB388B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC9FD61756
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27236C385A1;
        Tue, 12 Apr 2022 03:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649735661;
        bh=BGvS5QVzIyiSDgSRuQVCljw3+GN8jAFk4L0lp3E94hs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=awZkCYqGgJKhYtEdrLt5NDWTLPsMwWhKne4/gXjYnkLcxJLTnmLmCthbK5OJjjIbx
         G2WtD9qukkk4gjEEvJBHmA3rtwL6hEWoLjhX87p5gzS3x9lIG4Ai74OdT1dfaePIbq
         2IQulkBNPn5nOAKm+gF3t7qjZR/iLeXW1KSBx2T3xmBb0+FFsd8L06NWoaqtyX4uBk
         IfXfRpdrFodxJSXbNAdUyVih0jtRIO3GAOeks1l85c0Lo6xNR+fhTdZfTDx32+93v+
         hzxXpiB5Zimo3zhgM/wPjfieJ5xnpkXjsL5QZ8Sg49r8dZErJGqakOu4MqKCboylwI
         hmIaqGjpMwZJw==
Message-ID: <1eee9abe-f468-ce32-cdb9-3a706404de2f@kernel.org>
Date:   Tue, 12 Apr 2022 11:54:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] f2fs: give priority to select unpinned section for
 foreground GC
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
References: <20220406152651.5142-1-chao@kernel.org>
 <YlSNjgQwoiENx5EK@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YlSNjgQwoiENx5EK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 4:20, Jaegeuk Kim wrote:
> On 04/06, Chao Yu wrote:
>> Previously, during foreground GC, if victims contain data of pinned file,
>> it will fail migration of the data, and meanwhile i_gc_failures of that
>> pinned file may increase, and when it exceeds threshold, GC will unpin
>> the file, result in breaking pinfile's semantics.
>>
>> In order to mitigate such condition, let's record and skip section which
>> has pinned file's data and give priority to select unpinned one.
>>
>> Signed-off-by: Chao Yu <chao.yu@oppo.com>
>> ---
>> v3:
>> - check pin status before pinning section in pin_section().
>>   fs/f2fs/gc.c      | 56 ++++++++++++++++++++++++++++++++++++++++++++---
>>   fs/f2fs/segment.c |  7 ++++++
>>   fs/f2fs/segment.h |  2 ++
>>   3 files changed, 62 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 6a7e4148ff9d..df23824ae3c2 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -646,6 +646,37 @@ static void release_victim_entry(struct f2fs_sb_info *sbi)
>>   	f2fs_bug_on(sbi, !list_empty(&am->victim_list));
>>   }
>>   
>> +static void pin_section(struct f2fs_sb_info *sbi, unsigned int segno)
> 
> Need f2fs_...?

Sure, I can add prefix...

It's a local function, it won't pollute global namespace w/o f2fs_ prefix
though.

> 
>> +{
>> +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>> +	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
>> +
>> +	if (test_bit(secno, dirty_i->pinned_secmap))
>> +		return;
>> +	set_bit(secno, dirty_i->pinned_secmap);
>> +	dirty_i->pinned_secmap_cnt++;
>> +}
>> +
>> +static bool pinned_section_exists(struct dirty_seglist_info *dirty_i)
>> +{
>> +	return dirty_i->pinned_secmap_cnt;
>> +}
>> +
>> +static bool section_is_pinned(struct dirty_seglist_info *dirty_i,
>> +						unsigned int secno)
>> +{
>> +	return pinned_section_exists(dirty_i) &&
>> +			test_bit(secno, dirty_i->pinned_secmap);
>> +}
>> +
>> +static void unpin_all_sections(struct f2fs_sb_info *sbi)
>> +{
>> +	unsigned int bitmap_size = f2fs_bitmap_size(MAIN_SECS(sbi));
>> +
>> +	memset(DIRTY_I(sbi)->pinned_secmap, 0, bitmap_size);
>> +	DIRTY_I(sbi)->pinned_secmap_cnt = 0;
>> +}
>> +
>>   /*
>>    * This function is called from two paths.
>>    * One is garbage collection and the other is SSR segment selection.
>> @@ -787,6 +818,9 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>>   		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
>>   			goto next;
>>   
>> +		if (gc_type == FG_GC && section_is_pinned(dirty_i, secno))
>> +			goto next;
>> +
>>   		if (is_atgc) {
>>   			add_victim_entry(sbi, &p, segno);
>>   			goto next;
>> @@ -1202,8 +1236,10 @@ static int move_data_block(struct inode *inode, block_t bidx,
>>   	}
>>   
>>   	if (f2fs_is_pinned_file(inode)) {
>> -		if (gc_type == FG_GC)
>> +		if (gc_type == FG_GC) {
>>   			f2fs_pin_file_control(inode, true);
>> +			pin_section(F2FS_I_SB(inode), segno);
> 
> Do we need to check unpinning the inode?
> 			if (!f2fs_pin_file_control())
> 				f2fs_set_pin_section();

I'm thinking that it needs to avoid increasing GC_FAILURE_PIN AMAP,
so could you please check below logic:

 From 7cb1ee0df32ede44b17c503b81930dae25d287eb Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Wed, 6 Apr 2022 23:26:51 +0800
Subject: [PATCH v4] f2fs: give priority to select unpinned section for
  foreground GC

Previously, during foreground GC, if victims contain data of pinned file,
it will fail migration of the data, and meanwhile i_gc_failures of that
pinned file may increase, and when it exceeds threshold, GC will unpin
the file, result in breaking pinfile's semantics.

In order to mitigate such condition, let's record and skip section which
has pinned file's data and give priority to select unpinned one.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
v4:
- add f2fs_ prefix for newly introduced functions
- add bool type variable for functionality switch
- increase GC_FAILURE_PIN only if it disable pinning section
  fs/f2fs/gc.c      | 66 ++++++++++++++++++++++++++++++++++++++++++-----
  fs/f2fs/segment.c |  8 ++++++
  fs/f2fs/segment.h |  3 +++
  3 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6a7e4148ff9d..296b31e28d3d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -646,6 +646,41 @@ static void release_victim_entry(struct f2fs_sb_info *sbi)
  	f2fs_bug_on(sbi, !list_empty(&am->victim_list));
  }

+static bool f2fs_pin_section(struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
+
+	if (!dirty_i->enable_pin_section)
+		return false;
+	if (test_bit(secno, dirty_i->pinned_secmap))
+		return true;
+	set_bit(secno, dirty_i->pinned_secmap);
+	dirty_i->pinned_secmap_cnt++;
+	return true;
+}
+
+static bool f2fs_pinned_section_exists(struct dirty_seglist_info *dirty_i)
+{
+	return dirty_i->enable_pin_section && dirty_i->pinned_secmap_cnt;
+}
+
+static bool f2fs_section_is_pinned(struct dirty_seglist_info *dirty_i,
+						unsigned int secno)
+{
+	return f2fs_pinned_section_exists(dirty_i) &&
+			test_bit(secno, dirty_i->pinned_secmap);
+}
+
+static void f2fs_unpin_all_sections(struct f2fs_sb_info *sbi, bool enable)
+{
+	unsigned int bitmap_size = f2fs_bitmap_size(MAIN_SECS(sbi));
+
+	memset(DIRTY_I(sbi)->pinned_secmap, 0, bitmap_size);
+	DIRTY_I(sbi)->pinned_secmap_cnt = 0;
+	DIRTY_I(sbi)->enable_pin_section = enable;
+}
+
  /*
   * This function is called from two paths.
   * One is garbage collection and the other is SSR segment selection.
@@ -787,6 +822,9 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
  		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
  			goto next;

+		if (gc_type == FG_GC && f2fs_section_is_pinned(dirty_i, secno))
+			goto next;
+
  		if (is_atgc) {
  			add_victim_entry(sbi, &p, segno);
  			goto next;
@@ -1202,8 +1240,10 @@ static int move_data_block(struct inode *inode, block_t bidx,
  	}

  	if (f2fs_is_pinned_file(inode)) {
-		if (gc_type == FG_GC)
-			f2fs_pin_file_control(inode, true);
+		if (gc_type == FG_GC) {
+			if (!f2fs_pin_section(F2FS_I_SB(inode), segno))
+				f2fs_pin_file_control(inode, true);
+		}
  		err = -EAGAIN;
  		goto out;
  	}
@@ -1352,8 +1392,10 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
  		goto out;
  	}
  	if (f2fs_is_pinned_file(inode)) {
-		if (gc_type == FG_GC)
-			f2fs_pin_file_control(inode, true);
+		if (gc_type == FG_GC) {
+			if (!f2fs_pin_section(F2FS_I_SB(inode), segno))
+				f2fs_pin_file_control(inode, true);
+		}
  		err = -EAGAIN;
  		goto out;
  	}
@@ -1483,7 +1525,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,

  			if (is_inode_flag_set(inode, FI_PIN_FILE) &&
  							gc_type == FG_GC) {
-				f2fs_pin_file_control(inode, true);
+				if (!f2fs_pin_section(sbi, segno))
+					f2fs_pin_file_control(inode, true);
  				iput(inode);
  				return submitted;
  			}
@@ -1766,9 +1809,17 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
  		ret = -EINVAL;
  		goto stop;
  	}
+retry:
  	ret = __get_victim(sbi, &segno, gc_type);
-	if (ret)
+	if (ret) {
+		/* allow to search victim from sections has pinned data */
+		if (ret == -ENODATA && gc_type == FG_GC &&
+				f2fs_pinned_section_exists(DIRTY_I(sbi))) {
+			f2fs_unpin_all_sections(sbi, false);
+			goto retry;
+		}
  		goto stop;
+	}

  	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type, force);
  	if (gc_type == FG_GC &&
@@ -1811,6 +1862,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
  	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
  	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = init_segno;

+	if (gc_type == FG_GC && f2fs_pinned_section_exists(DIRTY_I(sbi)))
+		f2fs_unpin_all_sections(sbi, true);
+
  	trace_f2fs_gc_end(sbi->sb, ret, total_freed, sec_freed,
  				get_pages(sbi, F2FS_DIRTY_NODES),
  				get_pages(sbi, F2FS_DIRTY_DENTS),
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 22dfeb991529..93c7bae57a25 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4734,6 +4734,13 @@ static int init_victim_secmap(struct f2fs_sb_info *sbi)
  	dirty_i->victim_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
  	if (!dirty_i->victim_secmap)
  		return -ENOMEM;
+
+	dirty_i->pinned_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
+	if (!dirty_i->pinned_secmap)
+		return -ENOMEM;
+
+	dirty_i->pinned_secmap_cnt = 0;
+	dirty_i->enable_pin_section = true;
  	return 0;
  }

@@ -5322,6 +5329,7 @@ static void destroy_victim_secmap(struct f2fs_sb_info *sbi)
  {
  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);

+	kvfree(dirty_i->pinned_secmap);
  	kvfree(dirty_i->victim_secmap);
  }

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5c94caf0c0a1..8a591455d796 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -294,6 +294,9 @@ struct dirty_seglist_info {
  	struct mutex seglist_lock;		/* lock for segment bitmaps */
  	int nr_dirty[NR_DIRTY_TYPE];		/* # of dirty segments */
  	unsigned long *victim_secmap;		/* background GC victims */
+	unsigned long *pinned_secmap;		/* pinned victims from foreground GC */
+	unsigned int pinned_secmap_cnt;		/* count of victims which has pinned data */
+	bool enable_pin_section;		/* enable pinning section */
  };

  /* victim selection function for cleaning and SSR */
-- 
2.25.1

Thanks,

> 
>> +		}
>>   		err = -EAGAIN;
>>   		goto out;
>>   	}
>> @@ -1352,8 +1388,10 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>   		goto out;
>>   	}
>>   	if (f2fs_is_pinned_file(inode)) {
>> -		if (gc_type == FG_GC)
>> +		if (gc_type == FG_GC) {
>>   			f2fs_pin_file_control(inode, true);
>> +			pin_section(F2FS_I_SB(inode), segno);
>> +		}
>>   		err = -EAGAIN;
>>   		goto out;
>>   	}
>> @@ -1485,6 +1523,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>   							gc_type == FG_GC) {
>>   				f2fs_pin_file_control(inode, true);
>>   				iput(inode);
>> +				pin_section(sbi, segno);
> 
> We don't have this code.
> 
>>   				return submitted;
>>   			}
>>   
>> @@ -1766,9 +1805,17 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>   		ret = -EINVAL;
>>   		goto stop;
>>   	}
>> +retry:
>>   	ret = __get_victim(sbi, &segno, gc_type);
>> -	if (ret)
>> +	if (ret) {
>> +		/* allow to search victim from sections has pinned data */
>> +		if (ret == -ENODATA && gc_type == FG_GC &&
>> +				pinned_section_exists(DIRTY_I(sbi))) {
>> +			unpin_all_sections(sbi);
>> +			goto retry;
>> +		}
>>   		goto stop;
>> +	}
>>   
>>   	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type, force);
>>   	if (gc_type == FG_GC &&
>> @@ -1811,6 +1858,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>   	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
>>   	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = init_segno;
>>   
>> +	if (gc_type == FG_GC && pinned_section_exists(DIRTY_I(sbi)))
>> +		unpin_all_sections(sbi);
>> +
>>   	trace_f2fs_gc_end(sbi->sb, ret, total_freed, sec_freed,
>>   				get_pages(sbi, F2FS_DIRTY_NODES),
>>   				get_pages(sbi, F2FS_DIRTY_DENTS),
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 012524db7437..1c20d7c9eca3 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -4736,6 +4736,12 @@ static int init_victim_secmap(struct f2fs_sb_info *sbi)
>>   	dirty_i->victim_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
>>   	if (!dirty_i->victim_secmap)
>>   		return -ENOMEM;
>> +
>> +	dirty_i->pinned_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
>> +	if (!dirty_i->pinned_secmap)
>> +		return -ENOMEM;
>> +
>> +	dirty_i->pinned_secmap_cnt = 0;
>>   	return 0;
>>   }
>>   
>> @@ -5324,6 +5330,7 @@ static void destroy_victim_secmap(struct f2fs_sb_info *sbi)
>>   {
>>   	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>>   
>> +	kvfree(dirty_i->pinned_secmap);
>>   	kvfree(dirty_i->victim_secmap);
>>   }
>>   
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index 5c94caf0c0a1..fd6f246e649c 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -294,6 +294,8 @@ struct dirty_seglist_info {
>>   	struct mutex seglist_lock;		/* lock for segment bitmaps */
>>   	int nr_dirty[NR_DIRTY_TYPE];		/* # of dirty segments */
>>   	unsigned long *victim_secmap;		/* background GC victims */
>> +	unsigned long *pinned_secmap;		/* pinned victims from foreground GC */
>> +	unsigned int pinned_secmap_cnt;		/* count of victims which has pinned data */
>>   };
>>   
>>   /* victim selection function for cleaning and SSR */
>> -- 
>> 2.32.0
