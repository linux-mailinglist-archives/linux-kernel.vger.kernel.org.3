Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0E14701A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbhLJNeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhLJNd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:33:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6CC061746;
        Fri, 10 Dec 2021 05:30:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC6BEB82800;
        Fri, 10 Dec 2021 13:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB88C341C6;
        Fri, 10 Dec 2021 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639143020;
        bh=rY4GvZhp3QslJI/lvWWQnXm3amakuvqiH8kePmTJYmk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gx0+TWOK2Q52LdIxE8K+qQ0CG7KDnHAJwdjS9+JcUgO9fy/A0v3mEQHtl8QHLVO5U
         fFKGmoYluIMoonXGhASDWwufAoj+WNlhjxbaO6g5oy9eqWFWRllGllxbCeK3E+x2Tk
         OCTl0mRpfM9oSgZJe82W+6g1swCZgUfa3g86kOoDmMp+yg+XrYvTHfOh0QuGSstiC5
         S+7s83tThUO+NNyvfKKGVW6Q9KtAWp2pIOB9e3zGB3YI74nUgbT5Rj0+Wasum7AD7x
         VahlDWd0xOu9kSxL+iFoOGH9L3IfKeDoPIUfy5r4zREw0bz7wy1K4Z7WzyOsW51HY2
         4nb2N6/MdAIfg==
Date:   Fri, 10 Dec 2021 22:30:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/13] user_events: Add UABI header for user access
 to user_events
Message-Id: <20211210223017.2f9254f056e8e1b5404bc409@kernel.org>
In-Reply-To: <20211209223210.1818-2-beaub@linux.microsoft.com>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
        <20211209223210.1818-2-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Dec 2021 14:31:58 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Define the basic structs and ioctl commands that allow user processes to
> interact with user_events.
> 

IMHO, a basic part of this should be integrated with the [2/13] and
other parts are incrementaly added with the patch which actually
use that data structure or definition, so that it can be bisected
cleanly.
(because there is no reason to introduce only this header.)

Thank you,

> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  include/uapi/linux/user_events.h | 68 ++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 include/uapi/linux/user_events.h
> 
> diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
> new file mode 100644
> index 000000000000..5bff99418deb
> --- /dev/null
> +++ b/include/uapi/linux/user_events.h
> @@ -0,0 +1,68 @@
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
> +/* Use raw iterator for attached BPF program(s), no affect on ftrace/perf */
> +#define FLAG_BPF_ITER (1 << 0)
> +
> +struct user_reg {
> +	__u32 size;
> +	__u64 name_args;
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
> +
> +#endif /* _UAPI_LINUX_USER_EVENTS_H */
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
