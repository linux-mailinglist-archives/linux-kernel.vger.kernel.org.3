Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602DA485DB8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbiAFAzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:55:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33342 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344128AbiAFAxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:53:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88F83617CC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 00:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97126C36AEB;
        Thu,  6 Jan 2022 00:53:29 +0000 (UTC)
Date:   Wed, 5 Jan 2022 19:53:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     fuyufan <835863489@qq.com>
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, xuhuijie <xuhujie2@huawei.com>,
        xuhuijie <xuhujie2@gmail.com>
Subject: Re: [RFC][PATCH v5 3/4] trace/objtrace: Add testcases for objtrace
 trigger parsing
Message-ID: <20220105195327.5eac3a45@rorschach.local.home>
In-Reply-To: <tencent_CA3FD88F43A620435A6D24163EDD41AD7B07@qq.com>
References: <20211113120632.94754-1-xuhujie2@gmail.com>
        <tencent_CA3FD88F43A620435A6D24163EDD41AD7B07@qq.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jan 2022 00:02:53 +0000
fuyufan <835863489@qq.com> wrote:

> From: xuhuijie <xuhujie2@huawei.com>

Needs a change log.

-- Steve

> 
> Signed-off-by: xuhuijie <xuhujie2@huawei.com>
> ---
>  .../ftrace/test.d/trigger/trigger-objtrace.tc | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> new file mode 100644
> index 000000000000..4efcd7eee694
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test objtrace-trigger
> +# requires: kprobe_events
> +
> +fail() { #msg
> +    echo $1
> +    exit_fail
> +}
> +
> +echo 'p bio_add_page arg1=$arg1' > kprobe_events
> +
> +FEATURE=`grep objtrace events/kprobes/p_bio_add_page_0/trigger`
> +if [ -z "$FEATURE" ]; then
> +    echo "objtrace trigger is not supported"
> +    exit_unsupported
> +fi
> +
> +echo "Test objtrace trigger"
> +echo 'objtrace:add:0x28(arg1):u32:1 if comm == "cat"' > \
> +	events/kprobes/p_bio_add_page_0/trigger
> +if [ -z $? ]; then
> +	fail "objtrace trigger syntax error"
> +fi
> +
> +echo "Test objtrace semantic errors"
> +
> +# Being lack of type size
> +! echo 'objtrace:add:0x28(arg1):1' > events/kprobes/p_bio_add_page_0/trigger
> +# Being lack of objtrace command
> +! echo 'objtrace:0x28(arg1):u32:1' > events/kprobes/p_bio_add_page_0/trigger
> +# Bad parameter name
> +! echo 'objtrace:add:argx:u32:1' > events/kprobes/p_bio_add_page_0/trigger
> +
> +echo "reset objtrace trigger"
> +
> +echo '!objtrace:add:0x28(arg1):u32' > \
> +	events/kprobes/p_bio_add_page_0/trigger
> +echo '-:p_bio_add_page_0' >> ./kprobe_events
> +
> +exit 0

