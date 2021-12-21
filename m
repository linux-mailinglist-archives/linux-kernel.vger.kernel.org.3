Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D713F47C296
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhLUPQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhLUPQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:16:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D567C061574;
        Tue, 21 Dec 2021 07:16:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1161B8168A;
        Tue, 21 Dec 2021 15:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8E3C36AE9;
        Tue, 21 Dec 2021 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640099800;
        bh=TQQPmZNvRn9ESBfprDKzVPgHnt6touO9bUo0b6HJ1K8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jd71xbUIGzCtRVR5K9hFY8QjLNlZBDEi5WjKWbgMR6ycXuuPVzIx3BFx5PNl3zAo9
         ePlkpU11+GVwbAcFF2qzs2sqrqMY7Gfiu/nyr+urT633GWhXcFAVjMWcbSPU0S2Ehe
         rI/G/gE/x+0uE0ktJEPXISfmyV9SEUWteu76j/8nsu1vtBxFWEmyLFGaac3IRQfJwS
         VYgAu7thlfTxdIUxrzQfSppe6yZ72LHdKAIX8tJWpWZSjOBEaiXqprU3PqI6bOFKP0
         nks2ZCH4WVyXWn0nMW+zdRzBSizAYTunGxapYyGu1SH6nXz1J5SyEBtqUomAwXfbey
         vewYqe/to3c7w==
Date:   Wed, 22 Dec 2021 00:16:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/12] user_events: Add minimal support for
 trace_event into ftrace
Message-Id: <20211222001637.4d45b40ce99737ba213ae2b4@kernel.org>
In-Reply-To: <20211216173511.10390-2-beaub@linux.microsoft.com>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
        <20211216173511.10390-2-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beau,

On Thu, 16 Dec 2021 09:35:00 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Minimal support for interacting with dynamic events, trace_event and
> ftrace.

Since the cover mail is merged, could you describe what is
the user_events here? :)

I have some comments below, but not so much.

> Core outline of flow between user process, ioctl and trace_event
> APIs.
> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  include/uapi/linux/user_events.h |   71 ++
>  kernel/trace/Kconfig             |   14 +
>  kernel/trace/Makefile            |    1 +
>  kernel/trace/trace_events_user.c | 1188 ++++++++++++++++++++++++++++++
>  4 files changed, 1274 insertions(+)
>  create mode 100644 include/uapi/linux/user_events.h
>  create mode 100644 kernel/trace/trace_events_user.c
> 
> diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
> new file mode 100644
> index 000000000000..f97db05e00c9
> --- /dev/null
> +++ b/include/uapi/linux/user_events.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2021, Microsoft Corporation.
> + *
> + * Authors:
> + *   Beau Belgrave <beaub@linux.microsoft.com>
> + */
> +#ifndef _UAPI_LINUX_USER_EVENTS_H
> +#define _UAPI_LINUX_USER_EVENTS_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#ifdef __KERNEL__
> +#include <linux/uio.h>
> +#else
> +#include <sys/uio.h>
> +#endif
> +
> +#define USER_EVENTS_SYSTEM "user_events"
> +#define USER_EVENTS_PREFIX "u:"
> +
> +/* Bits 0-6 are for known probe types, Bit 7 is for unknown probes */
> +#define EVENT_BIT_FTRACE 0
> +#define EVENT_BIT_PERF 1
> +#define EVENT_BIT_OTHER 7
> +
> +#define EVENT_STATUS_FTRACE (1 << EVENT_BIT_FTRACE)
> +#define EVENT_STATUS_PERF (1 << EVENT_BIT_PERF)
> +#define EVENT_STATUS_OTHER (1 << EVENT_BIT_OTHER)
> +
> +/* Create dynamic location entry within a 32-bit value */
> +#define DYN_LOC(offset, size) ((size) << 16 | (offset))
> +
> +/* Use raw iterator for attached BPF program(s), no affect on ftrace/perf */
> +#define FLAG_BPF_ITER (1 << 0)
> +

Can you add a description of the user_reg (and each field) here?

> +struct user_reg {
> +	__u32 size;
> +	__u64 name_args;

BTW, this field name is a bit strange. It is indeed "name and arguments",
but actually, it is the definition of the event, isn't it?

> +	__u32 status_index;
> +	__u32 write_index;
> +};
> +
> +#define DIAG_IOC_MAGIC '*'
> +#define DIAG_IOCSREG _IOWR(DIAG_IOC_MAGIC, 0, struct user_reg*)
> +#define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char*)
> +
> +enum {
> +	USER_BPF_DATA_KERNEL,
> +	USER_BPF_DATA_USER,
> +	USER_BPF_DATA_ITER,
> +};
> +
> +struct user_bpf_iter {
> +	__u32 iov_offset;
> +	__u32 nr_segs;
> +	const struct iovec *iov;
> +};
> +
> +struct user_bpf_context {
> +	__u32 data_type;
> +	__u32 data_len;
> +	union {
> +		void *kdata;
> +		void *udata;
> +		struct user_bpf_iter *iter;
> +	};
> +};

Are those bpf related data structures passed from/to user?

[...]
> +/*
> + * Parses a register command for user_events
> + * Format: event_name[:FLAG1[,FLAG2...]] [field1[;field2...]]
> + *
> + * Example event named test with a 20 char msg field with a unsigned int after:

Please quote the words in the example, like 

Example event named 'test' with a 20 char 'msg' field with an 'unsigned int id' after:

(is that correct?)

> + * test char[20] msg;unsigned int id
> + *
> + * NOTE: Offsets are from the user data perspective, they are not from the
> + * trace_entry/buffer perspective. We automatically add the common properties
> + * sizes to the offset for the user.
> + */
> +static int user_event_parse_cmd(char *raw_command, struct user_event **newuser)
> +{
> +	char *name = raw_command;
> +	char *args = strpbrk(name, " ");
> +	char *flags;
> +
> +	if (args)
> +		*args++ = 0;
> +
> +	flags = strpbrk(name, ":");
> +
> +	if (flags)
> +		*flags++ = 0;
> +

Just a nitpick. What about using strsep()?

args = raw_command;
flags = strsep(&args, " ");
name = strsep(&flags, ":");

> +	return user_event_parse(name, args, flags, newuser);
> +}
> +

[...]

> +
> +static ssize_t user_status_read(struct file *file, char __user *ubuf,
> +				size_t count, loff_t *ppos)
> +{
> +	/*
> +	 * Delay allocation of seq data until requested, most callers
> +	 * will never read the status file. They will only mmap.
> +	 */

I think you don't need to do this optimization since this is not
a hot path. And it causes strange behaviors. See below;

> +	if (file->private_data == NULL) {
> +		int ret;
> +
> +		if (*ppos != 0)
> +			return -EINVAL;
> +
> +		ret = single_open(file, user_status_show, NULL);
> +
> +		if (ret)
> +			return ret;

This seems strange returning failure of open(2) from read(2).

> +	}
> +
> +	return seq_read(file, ubuf, count, ppos);
> +}
> +
> +static loff_t user_status_seek(struct file *file, loff_t offset, int whence)
> +{
> +	if (file->private_data == NULL)

For example, this means unless start reading we can not do seek.
So, please make the code as usually that is, unless any special reason.


> +		return 0;
> +
> +	return seq_lseek(file, offset, whence);
> +}
> +
> +static int user_status_release(struct inode *node, struct file *file)
> +{
> +	if (file->private_data == NULL)
> +		return 0;
> +
> +	return single_release(node, file);
> +}
> +
> +static const struct file_operations user_status_fops = {
> +	.mmap = user_status_mmap,
> +	.read = user_status_read,
> +	.llseek  = user_status_seek,
> +	.release = user_status_release,
> +};

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
