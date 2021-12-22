Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0ED547DA00
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 00:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbhLVXSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 18:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243957AbhLVXSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:18:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C6FC061395;
        Wed, 22 Dec 2021 15:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2749C61D39;
        Wed, 22 Dec 2021 23:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4503CC36AE8;
        Wed, 22 Dec 2021 23:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640215098;
        bh=XL2F2sIMNd3mEbXg4dyXDlA3WIZvGQ21ponLFx80OCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WKebl9A1kBsJYUZIKPLD8z1wMtz24RCXKjWTNcf7+/Zm4JQm0Y2+aGw9FHYotJVdX
         2i+GzPGBdkO/OrC9orqNKMLXpfZrTkz5kM6MqwpnnF5TM8p3YzYWRWfuRzyintkU8p
         TXSuNh0XBtOqGsTwcVg9X9qaAMsbrmmnsoY6M2b+eXou5Z1hq5+2sSJMQoSt/JRBZ0
         DB68cpPjw6sak6SAx3THQiZyB2KiEWXA7rfyLhlmjaeYIDLM06w7GZb2x/w686G2Sw
         mX83wlZq1Cod4nAnbM0Fwz0OxgBmTvLmUkUf4pyxRCTTj475EcZdChXYHNIG9XvsgC
         ACXQJi7cXm9Qg==
Date:   Thu, 23 Dec 2021 08:18:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/12] user_events: Add sample code for typical usage
Message-Id: <20211223081814.1ca544cdf18e29a93f60c597@kernel.org>
In-Reply-To: <20211216173511.10390-11-beaub@linux.microsoft.com>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
        <20211216173511.10390-11-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 09:35:09 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Add sample code for user_events typical usage to show how to register
> and monitor status, as well as to write out data.

Ah, here is the sample code. OK.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  samples/user_events/Makefile  |  5 ++
>  samples/user_events/example.c | 91 +++++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+)
>  create mode 100644 samples/user_events/Makefile
>  create mode 100644 samples/user_events/example.c
> 
> diff --git a/samples/user_events/Makefile b/samples/user_events/Makefile
> new file mode 100644
> index 000000000000..7252b589db57
> --- /dev/null
> +++ b/samples/user_events/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -Wl,-no-as-needed -Wall -I../../usr/include
> +
> +example: example.o
> +example.o: example.c
> diff --git a/samples/user_events/example.c b/samples/user_events/example.c
> new file mode 100644
> index 000000000000..4f5778e441c0
> --- /dev/null
> +++ b/samples/user_events/example.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, Microsoft Corporation.
> + *
> + * Authors:
> + *   Beau Belgrave <beaub@linux.microsoft.com>
> + */
> +
> +#include <errno.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <linux/user_events.h>
> +
> +/* Assumes debugfs is mounted */
> +const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
> +const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
> +
> +static int event_status(char **status)
> +{
> +	int fd = open(status_file, O_RDONLY);
> +
> +	*status = mmap(NULL, sysconf(_SC_PAGESIZE), PROT_READ,
> +		       MAP_SHARED, fd, 0);
> +
> +	close(fd);
> +
> +	if (*status == MAP_FAILED)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int event_reg(int fd, const char *command, int *status, int *write)
> +{
> +	struct user_reg reg = {0};
> +
> +	reg.size = sizeof(reg);
> +	reg.name_args = (__u64)command;
> +
> +	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
> +		return -1;
> +
> +	*status = reg.status_index;
> +	*write = reg.write_index;
> +
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int data_fd, status, write;
> +	char *status_page;
> +	struct iovec io[2];
> +	__u32 count = 0;
> +
> +	if (event_status(&status_page) == -1)
> +		return errno;
> +
> +	data_fd = open(data_file, O_RDWR);
> +
> +	if (event_reg(data_fd, "test u32 count", &status, &write) == -1)
> +		return errno;
> +
> +	/* Setup iovec */
> +	io[0].iov_base = &write;
> +	io[0].iov_len = sizeof(write);
> +	io[1].iov_base = &count;
> +	io[1].iov_len = sizeof(count);
> +
> +ask:
> +	printf("Press enter to check status...\n");
> +	getchar();
> +
> +	/* Check if anyone is listening */
> +	if (status_page[status]) {
> +		/* Yep, trace out our data */
> +		writev(data_fd, (const struct iovec *)io, 2);
> +
> +		/* Increase the count */
> +		count++;
> +
> +		printf("Something was attached, wrote data\n");
> +	}
> +
> +	goto ask;
> +
> +	return 0;
> +}
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
