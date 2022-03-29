Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925224EA5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiC2DF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiC2DFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:05:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063AC208C31
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F5AE61316
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC64AC340ED;
        Tue, 29 Mar 2022 03:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648523052;
        bh=OMBV8b/XH53FXt/14a/2cNIo9THLs/ZF/h22zBqZ2ks=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Yt4miJHUJO3BaSfYOXmWuICIA8z8S9t10fc3CyJja0VjYJeIircQghekEHje/F7eR
         UVKLbz4W0fu3c7W7Rrnhr9Ovq7sbuTRWBAaFqaW2AOjwPbfmSwzyhca0LrcaZGjXrt
         DpvD8MEwrtJF8P3O5lok/PC0fJgOrOj39JC7G8VW4FPkyxgDgzU9brhNNqNuvOgsv1
         ul+h7dbhKueeiXHGXGuNsWPROMdIuLUbccLoiBsLLJphF9bRE1csvR/5saRjsln597
         h6IjmqGPcnjDXB8ES3eqVT2FJd6TMx1j5Xi/WdzUbZbYO7VEOPggc7Hkw3nkM2gp9K
         EIPIeZKhHHgPg==
Message-ID: <3b20d122-1716-4225-9f47-7b5ba21c05db@kernel.org>
Date:   Tue, 29 Mar 2022 11:04:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce data read/write showing
 path info
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220321223315.3228326-1-jaegeuk@kernel.org>
 <YjkUvRKhyX8AUoTm@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YjkUvRKhyX8AUoTm@google.com>
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

On 2022/3/22 8:13, Jaegeuk Kim wrote:
> This was used in Android for a long time. Let's upstream it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
>   Change log from v1:
>    - remove unnecessary path lookup
> 
>   fs/f2fs/file.c              | 48 ++++++++++++++++---
>   include/trace/events/f2fs.h | 94 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 135 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 68ddf4c7ca64..19bc916c1eb7 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4329,17 +4329,34 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   {
>   	struct inode *inode = file_inode(iocb->ki_filp);
> +	const loff_t pos = iocb->ki_pos;
>   	ssize_t ret;
>   
>   	if (!f2fs_is_compress_backend_ready(inode))
>   		return -EOPNOTSUPP;
>   
> -	if (f2fs_should_use_dio(inode, iocb, to))
> -		return f2fs_dio_read_iter(iocb, to);
> +	if (trace_f2fs_dataread_start_enabled()) {
> +		char *path, *p = kmalloc(PATH_MAX, GFP_KERNEL);

f2fs_kmalloc();

> +		if (!p)
> +			goto skip_read_trace;
> +
> +		path = dentry_path_raw(file_dentry(iocb->ki_filp), p, PATH_MAX);
> +		if (IS_ERR(path))

kfree();

> +			goto skip_read_trace;
>   
> -	ret = filemap_read(iocb, to, 0);
> -	if (ret > 0)
> -		f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_READ_IO, ret);
> +		trace_f2fs_dataread_start(inode, pos, iov_iter_count(to),
> +					current->pid, path, current->comm);
> +		kfree(p);
> +	}
> +skip_read_trace:
> +	if (f2fs_should_use_dio(inode, iocb, to)) {
> +		ret = f2fs_dio_read_iter(iocb, to);
> +	} else {
> +		ret = filemap_read(iocb, to, 0);
> +		if (ret > 0)
> +			f2fs_update_iostat(F2FS_I_SB(inode), APP_BUFFERED_READ_IO, ret);
> +	}

if (trace_f2fs_dataread_end_enabled())

Thanks,

> +	trace_f2fs_dataread_end(inode, pos, ret);
>   	return ret;
>   }
>   
> @@ -4637,14 +4654,31 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	/* Possibly preallocate the blocks for the write. */
>   	target_size = iocb->ki_pos + iov_iter_count(from);
>   	preallocated = f2fs_preallocate_blocks(iocb, from, dio);
> -	if (preallocated < 0)
> +	if (preallocated < 0) {
>   		ret = preallocated;
> -	else
> +	} else {
> +		if (trace_f2fs_datawrite_start_enabled()) {
> +			char *path, *p = kmalloc(PATH_MAX, GFP_KERNEL);

f2fs_kmalloc()

> +			if (!p)
> +				goto skip_write_trace;
> +			path = dentry_path_raw(file_dentry(iocb->ki_filp),
> +								p, PATH_MAX);
> +			if (IS_ERR(path))

kfree();

> +				goto skip_write_trace;
> +			trace_f2fs_datawrite_start(inode, orig_pos, orig_count,
> +					current->pid, path, current->comm);
> +			kfree(p);
> +		}
> +skip_write_trace:
>   		/* Do the actual write. */
>   		ret = dio ?
>   			f2fs_dio_write_iter(iocb, from, &may_need_sync):
>   			f2fs_buffered_write_iter(iocb, from);
>   
> +		if (trace_f2fs_datawrite_end_enabled())
> +			trace_f2fs_datawrite_end(inode, orig_pos, ret);
> +	}
> +
>   	/* Don't leave any preallocated blocks around past i_size. */
>   	if (preallocated && i_size_read(inode) < target_size) {
>   		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index f701bb23f83c..11f6b7147be2 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -2068,6 +2068,100 @@ TRACE_EVENT(f2fs_fiemap,
>   		__entry->ret)
>   );
>   
> +DECLARE_EVENT_CLASS(f2fs__rw_start,
> +
> +	TP_PROTO(struct inode *inode, loff_t offset, int bytes,
> +			pid_t pid, char *pathname, char *command),
> +
> +	TP_ARGS(inode, offset, bytes, pid, pathname, command),
> +
> +	TP_STRUCT__entry(
> +		__string(pathbuf, pathname)
> +		__field(loff_t, offset)
> +		__field(int, bytes)
> +		__field(loff_t, i_size)
> +		__string(cmdline, command)
> +		__field(pid_t, pid)
> +		__field(ino_t, ino)
> +	),
> +
> +	TP_fast_assign(
> +		/*
> +		 * Replace the spaces in filenames and cmdlines
> +		 * because this screws up the tooling that parses
> +		 * the traces.
> +		 */
> +		__assign_str(pathbuf, pathname);
> +		(void)strreplace(__get_str(pathbuf), ' ', '_');
> +		__entry->offset = offset;
> +		__entry->bytes = bytes;
> +		__entry->i_size = i_size_read(inode);
> +		__assign_str(cmdline, command);
> +		(void)strreplace(__get_str(cmdline), ' ', '_');
> +		__entry->pid = pid;
> +		__entry->ino = inode->i_ino;
> +	),
> +
> +	TP_printk("entry_name %s, offset %llu, bytes %d, cmdline %s,"
> +		" pid %d, i_size %llu, ino %lu",
> +		__get_str(pathbuf), __entry->offset, __entry->bytes,
> +		__get_str(cmdline), __entry->pid, __entry->i_size,
> +		(unsigned long) __entry->ino)
> +);
> +
> +DECLARE_EVENT_CLASS(f2fs__rw_end,
> +
> +	TP_PROTO(struct inode *inode, loff_t offset, int bytes),
> +
> +	TP_ARGS(inode, offset, bytes),
> +
> +	TP_STRUCT__entry(
> +		__field(ino_t,	ino)
> +		__field(loff_t,	offset)
> +		__field(int,	bytes)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->ino		= inode->i_ino;
> +		__entry->offset		= offset;
> +		__entry->bytes		= bytes;
> +	),
> +
> +	TP_printk("ino %lu, offset %llu, bytes %d",
> +		(unsigned long) __entry->ino,
> +		__entry->offset, __entry->bytes)
> +);
> +
> +DEFINE_EVENT(f2fs__rw_start, f2fs_dataread_start,
> +
> +	TP_PROTO(struct inode *inode, loff_t offset, int bytes,
> +		pid_t pid, char *pathname, char *command),
> +
> +	TP_ARGS(inode, offset, bytes, pid, pathname, command)
> +);
> +
> +DEFINE_EVENT(f2fs__rw_end, f2fs_dataread_end,
> +
> +	TP_PROTO(struct inode *inode, loff_t offset, int bytes),
> +
> +	TP_ARGS(inode, offset, bytes)
> +);
> +
> +DEFINE_EVENT(f2fs__rw_start, f2fs_datawrite_start,
> +
> +	TP_PROTO(struct inode *inode, loff_t offset, int bytes,
> +		pid_t pid, char *pathname, char *command),
> +
> +	TP_ARGS(inode, offset, bytes, pid, pathname, command)
> +);
> +
> +DEFINE_EVENT(f2fs__rw_end, f2fs_datawrite_end,
> +
> +	TP_PROTO(struct inode *inode, loff_t offset, int bytes),
> +
> +	TP_ARGS(inode, offset, bytes)
> +);
> +
>   #endif /* _TRACE_F2FS_H */
>   
>    /* This part must be outside protection */
