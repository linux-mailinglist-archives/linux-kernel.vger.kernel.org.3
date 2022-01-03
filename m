Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BD74836BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiACSWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:22:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:37016 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiACSWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:22:09 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 023D720B7179;
        Mon,  3 Jan 2022 10:22:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 023D720B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641234129;
        bh=Y+cSm587R0Ox6HqvSX7e0ba9yBSjtSdXhWvTVqKzIfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jy5q7R2gV5aFnshM/qmMNgEbjOorRrrax8Bn3o4DwRcwQBTOl0QYK3UWQtl/JwUPB
         h58sKRynSIjpaQWAD+E5yAcAJttjARzuecNdISvfNUxiE0dpeqhRu3TNDKNUby6Pmx
         On9RCI5dj1P1sgdwWNXQl4UeBSIJJDKfufd8W0Qk=
Date:   Mon, 3 Jan 2022 10:22:04 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/12] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20220103182204.GA15459@kbox>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
 <20211216173511.10390-2-beaub@linux.microsoft.com>
 <20211222001637.4d45b40ce99737ba213ae2b4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222001637.4d45b40ce99737ba213ae2b4@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 12:16:37AM +0900, Masami Hiramatsu wrote:
> Hi Beau,
> 
> On Thu, 16 Dec 2021 09:35:00 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Minimal support for interacting with dynamic events, trace_event and
> > ftrace.
> 
> Since the cover mail is merged, could you describe what is
> the user_events here? :)
> 

Yeah, would this basically be what I have in the cover letter without
the history tracking?

> I have some comments below, but not so much.
> 
> > Core outline of flow between user process, ioctl and trace_event
> > APIs.
> > 
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---
> >  include/uapi/linux/user_events.h |   71 ++
> >  kernel/trace/Kconfig             |   14 +
> >  kernel/trace/Makefile            |    1 +
> >  kernel/trace/trace_events_user.c | 1188 ++++++++++++++++++++++++++++++
> >  4 files changed, 1274 insertions(+)
> >  create mode 100644 include/uapi/linux/user_events.h
> >  create mode 100644 kernel/trace/trace_events_user.c
> > 
> > diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
> > new file mode 100644
> > index 000000000000..f97db05e00c9
> > --- /dev/null
> > +++ b/include/uapi/linux/user_events.h
> > @@ -0,0 +1,71 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Copyright (c) 2021, Microsoft Corporation.
> > + *
> > + * Authors:
> > + *   Beau Belgrave <beaub@linux.microsoft.com>
> > + */
> > +#ifndef _UAPI_LINUX_USER_EVENTS_H
> > +#define _UAPI_LINUX_USER_EVENTS_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/ioctl.h>
> > +
> > +#ifdef __KERNEL__
> > +#include <linux/uio.h>
> > +#else
> > +#include <sys/uio.h>
> > +#endif
> > +
> > +#define USER_EVENTS_SYSTEM "user_events"
> > +#define USER_EVENTS_PREFIX "u:"
> > +
> > +/* Bits 0-6 are for known probe types, Bit 7 is for unknown probes */
> > +#define EVENT_BIT_FTRACE 0
> > +#define EVENT_BIT_PERF 1
> > +#define EVENT_BIT_OTHER 7
> > +
> > +#define EVENT_STATUS_FTRACE (1 << EVENT_BIT_FTRACE)
> > +#define EVENT_STATUS_PERF (1 << EVENT_BIT_PERF)
> > +#define EVENT_STATUS_OTHER (1 << EVENT_BIT_OTHER)
> > +
> > +/* Create dynamic location entry within a 32-bit value */
> > +#define DYN_LOC(offset, size) ((size) << 16 | (offset))
> > +
> > +/* Use raw iterator for attached BPF program(s), no affect on ftrace/perf */
> > +#define FLAG_BPF_ITER (1 << 0)
> > +
> 
> Can you add a description of the user_reg (and each field) here?
> 

Sure thing.

> > +struct user_reg {
> > +	__u32 size;
> > +	__u64 name_args;
> 
> BTW, this field name is a bit strange. It is indeed "name and arguments",
> but actually, it is the definition of the event, isn't it?
> 

It also includes flags, which are not part of the definition. I expect
the number of flags to increase in the future. For example, enabling
auto-deregistering of the event upon close if it's the last ref, etc.

> > +	__u32 status_index;
> > +	__u32 write_index;
> > +};
> > +
> > +#define DIAG_IOC_MAGIC '*'
> > +#define DIAG_IOCSREG _IOWR(DIAG_IOC_MAGIC, 0, struct user_reg*)
> > +#define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char*)
> > +
> > +enum {
> > +	USER_BPF_DATA_KERNEL,
> > +	USER_BPF_DATA_USER,
> > +	USER_BPF_DATA_ITER,
> > +};
> > +
> > +struct user_bpf_iter {
> > +	__u32 iov_offset;
> > +	__u32 nr_segs;
> > +	const struct iovec *iov;
> > +};
> > +
> > +struct user_bpf_context {
> > +	__u32 data_type;
> > +	__u32 data_len;
> > +	union {
> > +		void *kdata;
> > +		void *udata;
> > +		struct user_bpf_iter *iter;
> > +	};
> > +};
> 
> Are those bpf related data structures passed from/to user?
> 

They are passed to the BPF program, which requires to know their
definitions when compiling in places such as libbpf. The owner of the
structure in memory is always the kernel. The data the context points to
can either be from the kernel or user. The data_type tells you which is
the case so your BPF program can probe correctly.

> [...]
> > +/*
> > + * Parses a register command for user_events
> > + * Format: event_name[:FLAG1[,FLAG2...]] [field1[;field2...]]
> > + *
> > + * Example event named test with a 20 char msg field with a unsigned int after:
> 
> Please quote the words in the example, like 
> 
> Example event named 'test' with a 20 char 'msg' field with an 'unsigned int id' after:
> 
> (is that correct?)
> 

Think so, seems like unsigned int 'id' would be more appropriate here,
the rest look accurate. I'll change it.

> > + * test char[20] msg;unsigned int id
> > + *
> > + * NOTE: Offsets are from the user data perspective, they are not from the
> > + * trace_entry/buffer perspective. We automatically add the common properties
> > + * sizes to the offset for the user.
> > + */
> > +static int user_event_parse_cmd(char *raw_command, struct user_event **newuser)
> > +{
> > +	char *name = raw_command;
> > +	char *args = strpbrk(name, " ");
> > +	char *flags;
> > +
> > +	if (args)
> > +		*args++ = 0;
> > +
> > +	flags = strpbrk(name, ":");
> > +
> > +	if (flags)
> > +		*flags++ = 0;
> > +
> 
> Just a nitpick. What about using strsep()?
> 

strsep() has a side effect of setting the first parameter to NULL if the
delimiter is not found. This can lead to unintentional errors.

> args = raw_command;
> flags = strsep(&args, " ");
> name = strsep(&flags, ":");
> 

For example, if there wasn't a space then args would now be null. Where
as before only args would be null and name would be valid.

> > +	return user_event_parse(name, args, flags, newuser);
> > +}
> > +
> 
> [...]
> 
> > +
> > +static ssize_t user_status_read(struct file *file, char __user *ubuf,
> > +				size_t count, loff_t *ppos)
> > +{
> > +	/*
> > +	 * Delay allocation of seq data until requested, most callers
> > +	 * will never read the status file. They will only mmap.
> > +	 */
> 
> I think you don't need to do this optimization since this is not
> a hot path. And it causes strange behaviors. See below;
> 

In all of our usage we won't read the file, we simply mmap in. It felt
wasteful for the 99% case to allocate a seq_buf to just never be used.
If the file is closed after mmap from the user side then the seq_buf is
allocated but then freed, so not as big of a deal.

I'll try to see if the normal mmap pattern we use leaves allocations
around. If not, then I'm fine having this optimization removed.

> > +	if (file->private_data == NULL) {
> > +		int ret;
> > +
> > +		if (*ppos != 0)
> > +			return -EINVAL;
> > +
> > +		ret = single_open(file, user_status_show, NULL);
> > +
> > +		if (ret)
> > +			return ret;
> 
> This seems strange returning failure of open(2) from read(2).
> 

Yeah, too bad there wasn't a better place for it if we don't want extra
memory per-status file.

> > +	}
> > +
> > +	return seq_read(file, ubuf, count, ppos);
> > +}
> > +
> > +static loff_t user_status_seek(struct file *file, loff_t offset, int whence)
> > +{
> > +	if (file->private_data == NULL)
> 
> For example, this means unless start reading we can not do seek.
> So, please make the code as usually that is, unless any special reason.
> 

Sure, see above, I'll see if I can get this cleaned up.

> 
> > +		return 0;
> > +
> > +	return seq_lseek(file, offset, whence);
> > +}
> > +
> > +static int user_status_release(struct inode *node, struct file *file)
> > +{
> > +	if (file->private_data == NULL)
> > +		return 0;
> > +
> > +	return single_release(node, file);
> > +}
> > +
> > +static const struct file_operations user_status_fops = {
> > +	.mmap = user_status_mmap,
> > +	.read = user_status_read,
> > +	.llseek  = user_status_seek,
> > +	.release = user_status_release,
> > +};
> 
> Thank you,
> 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks,
-Beau
