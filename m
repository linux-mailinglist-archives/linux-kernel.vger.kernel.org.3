Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3092D5A7112
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiH3Wqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiH3WqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:46:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946AA3E744
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67A8B604EF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9016C433D6;
        Tue, 30 Aug 2022 22:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661899488;
        bh=cyRVqocYikABXBEFjBEpFUrn8ly9LlwBG3w4/jaRINg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WljNquIlEza3oah5WIlJjNp1TVa+5HdDoJXRWjS8aoBN5hi1u0q7ttH6DmPmLWawM
         qnKOyOgJg7hKpovyX9urrbFCKrf+XKWNB4POT2yIWyDltTRDwG56j/szI473FPJBp5
         30/khFQdQVSjG2iJYydbJVc5onQQ03Actqmq2aeRkjn7Trec6lnLGGVglXbh6E1Clf
         75lV1xJsbry4tXTM1olwe8YPQZFzMqAKNTw8PMM7reoNFI1xj8nqG2NBfxa8bRBXcR
         9vEESjFFNl3iyJsNtwiRzjdo/KjVtYcWpPQhN7phXd2ohpZ56CiKIWDccdI8EAiC0D
         uymJ/BNa7XBNQ==
Message-ID: <b1c74dc1-8d01-9041-9469-036273c5618d@kernel.org>
Date:   Wed, 31 Aug 2022 06:44:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] f2fs: fix to disallow getting inner inode via f2fs_iget()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
References: <20220830103625.79034-1-chao@kernel.org>
 <Yw5SdK5ItK9P/NUj@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Yw5SdK5ItK9P/NUj@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/31 2:09, Jaegeuk Kim wrote:
> On 08/30, Chao Yu wrote:
>> From: Chao Yu <chao.yu@oppo.com>
>>
>> Introduce f2fs_iget_inner() for f2fs_fill_super() to get inner inode:
>> meta inode, node inode or compressed inode, and add f2fs_check_nid_range()
>> in f2fs_iget() to avoid getting inner inode from external interfaces.
>>
>> Signed-off-by: Chao Yu <chao.yu@oppo.com>
>> ---
>>   fs/f2fs/compress.c |  2 +-
>>   fs/f2fs/f2fs.h     |  1 +
>>   fs/f2fs/inode.c    | 10 +++++++++-
>>   fs/f2fs/super.c    |  4 ++--
>>   4 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 730256732a9e..c38b22bb6432 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -1947,7 +1947,7 @@ int f2fs_init_compress_inode(struct f2fs_sb_info *sbi)
>>   	if (!test_opt(sbi, COMPRESS_CACHE))
>>   		return 0;
>>   
>> -	inode = f2fs_iget(sbi->sb, F2FS_COMPRESS_INO(sbi));
>> +	inode = f2fs_iget_inner(sbi->sb, F2FS_COMPRESS_INO(sbi));
>>   	if (IS_ERR(inode))
>>   		return PTR_ERR(inode);
>>   	sbi->compress_inode = inode;
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 408d8034ed74..35f9e1a6a1bf 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3467,6 +3467,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc);
>>   void f2fs_set_inode_flags(struct inode *inode);
>>   bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page);
>>   void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page);
>> +struct inode *f2fs_iget_inner(struct super_block *sb, unsigned long ino);
>>   struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
>>   struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
>>   int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index 6d11c365d7b4..0ab3ae9b2110 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -480,7 +480,7 @@ static int do_read_inode(struct inode *inode)
>>   	return 0;
>>   }
>>   
>> -struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>> +struct inode *f2fs_iget_inner(struct super_block *sb, unsigned long ino)
>>   {
>>   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>>   	struct inode *inode;
>> @@ -568,6 +568,14 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>>   	return ERR_PTR(ret);
>>   }
>>   
>> +struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>> +{
>> +	if (f2fs_check_nid_range(F2FS_SB(sb), ino))
>> +		return -EINVAL;
> 
> EINVAL or EFSCORRUPTED used in f2fs_check_nid_range?

Oh, I guess returning EFSCORRUPTED will be better.

> Do we have a report on this before?

Not yet, but I guess it is possible in a fuzzed image like below paths, due to
we will not check ino before pass it to f2fs_iget(), and then f2fs_iget() will
find/return a hashed internal inode to caller, which should be avoided.

case #1
recover_dentry()

	de = __f2fs_find_entry(dir, &fname, &page);
	if (de && inode->i_ino == le32_to_cpu(de->ino))
		goto out_put;

	if (de) {
		einode = f2fs_iget_retry(inode->i_sb, le32_to_cpu(de->ino));
		if (IS_ERR(einode)) {
			WARN_ON(1);
			err = PTR_ERR(einode);
			if (err == -ENOENT)
				err = -EEXIST;
			goto out_put;
		}

case #2
static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
{
	struct inode *inode;
	struct node_info ni;
	int err;

	inode = f2fs_iget_retry(sbi->sb, ino);

Thanks,

> 
>> +
>> +	return f2fs_iget_inner(sb, ino);
>> +}
>> +
>>   struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
>>   {
>>   	struct inode *inode;
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index b8e5fe244596..a5f5e7483791 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -4157,7 +4157,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>   		goto free_xattr_cache;
>>   
>>   	/* get an inode for meta space */
>> -	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
>> +	sbi->meta_inode = f2fs_iget_inner(sb, F2FS_META_INO(sbi));
>>   	if (IS_ERR(sbi->meta_inode)) {
>>   		f2fs_err(sbi, "Failed to read F2FS meta data inode");
>>   		err = PTR_ERR(sbi->meta_inode);
>> @@ -4265,7 +4265,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>   		goto free_nm;
>>   
>>   	/* get an inode for node space */
>> -	sbi->node_inode = f2fs_iget(sb, F2FS_NODE_INO(sbi));
>> +	sbi->node_inode = f2fs_iget_inner(sb, F2FS_NODE_INO(sbi));
>>   	if (IS_ERR(sbi->node_inode)) {
>>   		f2fs_err(sbi, "Failed to read node inode");
>>   		err = PTR_ERR(sbi->node_inode);
>> -- 
>> 2.25.1
