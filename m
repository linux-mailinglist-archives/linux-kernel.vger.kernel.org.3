Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D263D54039A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbiFGQRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiFGQRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:17:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA66642A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A393617D6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3800AC385A5;
        Tue,  7 Jun 2022 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654618663;
        bh=qy0o23vy7SOk5IrY1FQx+IgVqAw/BY7riA/gUKqGw8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hmIjAahue8dDHLcJd4Pqsv/glL4KqxFJTnYDnnpuYdKqokMh5QBJCgRySlbYdRZhr
         uO4L1zfkhdf3RMyGfKDy+ZyYASM9HhzNe5XzB0d5qQmd2dhXFHi6jEEPNlm4cIxleN
         rOFASbcs7D32Rhkxe/wbnh9AYZs6KMUk+K/3x+/zBIgigBeAUHlklwAefz6PWEzG2J
         ny/dDBXbuAm0u9v7E4t20OrE3LDXjPgVMy6bKb9SAND0kxRLtIFlEeOgWROQbXLYkX
         jvKWwV88nYsa6L5zloUGdGCfQqYCVwNfGzIn1BGvwMQnDPdypWHyJEjOfEvcQLD1OT
         YBaBuCAM99SrA==
Date:   Wed, 8 Jun 2022 01:17:39 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: Use KSYM_NAME_LEN for fprobe and kprobes
Message-Id: <20220608011739.4331f96f3354e05f23c26dde@kernel.org>
In-Reply-To: <1654594536-2915-1-git-send-email-yangtiezhu@loongson.cn>
References: <1654594536-2915-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jun 2022 17:35:36 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> It is better and enough to use KSYM_NAME_LEN for fprobe and kprobes
> in samples, no need to define and use the other values.
> 

This is good for kprobe and kretprobe examples because it will get
a single symbol name, but not good for the fprobe. It can take
several comma separated symbols.

-----
static int __init fprobe_init(void)
{
...
        /* Comma separated symbols */
        symbuf = kstrdup(symbol, GFP_KERNEL);
        if (!symbuf)
                return -ENOMEM;
        p = symbuf;
        count = 1;
        while ((p = strchr(++p, ',')) != NULL)
                count++;

        pr_info("%d symbols found\n", count);
-----

Can you drop the fprobe_example.c part?

Thank you,

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  samples/fprobe/fprobe_example.c     | 9 ++++-----
>  samples/kprobes/kprobe_example.c    | 5 ++---
>  samples/kprobes/kretprobe_example.c | 5 ++---
>  3 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
> index 24d3cf1..1ed1a69 100644
> --- a/samples/fprobe/fprobe_example.c
> +++ b/samples/fprobe/fprobe_example.c
> @@ -19,13 +19,12 @@
>  #include <linux/slab.h>
>  
>  #define BACKTRACE_DEPTH 16
> -#define MAX_SYMBOL_LEN 4096
>  struct fprobe sample_probe;
>  
> -static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
> -module_param_string(symbol, symbol, sizeof(symbol), 0644);
> -static char nosymbol[MAX_SYMBOL_LEN] = "";
> -module_param_string(nosymbol, nosymbol, sizeof(nosymbol), 0644);
> +static char symbol[KSYM_NAME_LEN] = "kernel_clone";
> +module_param_string(symbol, symbol, KSYM_NAME_LEN, 0644);
> +static char nosymbol[KSYM_NAME_LEN] = "";
> +module_param_string(nosymbol, nosymbol, KSYM_NAME_LEN, 0644);
>  static bool stackdump = true;
>  module_param(stackdump, bool, 0644);
>  
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index f991a66..fd346f5 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -16,9 +16,8 @@
>  #include <linux/module.h>
>  #include <linux/kprobes.h>
>  
> -#define MAX_SYMBOL_LEN	64
> -static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
> -module_param_string(symbol, symbol, sizeof(symbol), 0644);
> +static char symbol[KSYM_NAME_LEN] = "kernel_clone";
> +module_param_string(symbol, symbol, KSYM_NAME_LEN, 0644);
>  
>  /* For each probe you need to allocate a kprobe structure */
>  static struct kprobe kp = {
> diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
> index 228321e..cbf1654 100644
> --- a/samples/kprobes/kretprobe_example.c
> +++ b/samples/kprobes/kretprobe_example.c
> @@ -23,11 +23,10 @@
>  #include <linux/module.h>
>  #include <linux/kprobes.h>
>  #include <linux/ktime.h>
> -#include <linux/limits.h>
>  #include <linux/sched.h>
>  
> -static char func_name[NAME_MAX] = "kernel_clone";
> -module_param_string(func, func_name, NAME_MAX, S_IRUGO);
> +static char func_name[KSYM_NAME_LEN] = "kernel_clone";
> +module_param_string(func, func_name, KSYM_NAME_LEN, 0644);
>  MODULE_PARM_DESC(func, "Function to kretprobe; this module will report the"
>  			" function's execution time");
>  
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
