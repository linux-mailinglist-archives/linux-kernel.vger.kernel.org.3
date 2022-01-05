Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA6485B67
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244838AbiAEWMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:12:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50520 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244836AbiAEWLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:11:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CD30617D2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 22:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED233C36AEB;
        Wed,  5 Jan 2022 22:11:13 +0000 (UTC)
Date:   Wed, 5 Jan 2022 17:11:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     xkernel.wang@foxmail.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing: check the return value of kstrndup()
Message-ID: <20220105171112.337844b9@gandalf.local.home>
In-Reply-To: <tencent_4D6E270731456EB88712ED7F13883C334906@qq.com>
References: <tencent_4D6E270731456EB88712ED7F13883C334906@qq.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami, can you ack this?

-- Steve


On Tue, 14 Dec 2021 10:26:46 +0800
xkernel.wang@foxmail.com wrote:

> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kstrndup() is a memory allocation-related function, it returns NULL when
> some internal memory errors happen. It is better to check the return
> value of it so to catch the memory error in time.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  kernel/trace/trace_probe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 3ed2a3f..bb4605b 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -356,6 +356,8 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
>  		return -EINVAL;
>  	}
>  	*pbuf = kstrndup(str, len - 1, GFP_KERNEL);
> +	if (!*pbuf)
> +		return -ENOMEM;
>  	return 0;
>  }
>  

