Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA455405E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355990AbiFVCHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFVCHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:07:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415830F54
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFBB2B80F63
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400FBC3411C;
        Wed, 22 Jun 2022 02:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655863623;
        bh=OXkI+Y3ACw9rL792ik2Ukzt4EMax3yvVetAu+tTRfR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pq8NPvLimKNdXKMDLmHptp5BwZwiNacaYPqJr3LQ7hrl/I0adOh5STROXBTLJwNrT
         MfLZaybCui5QzqEbDWIsZWw4MGjh+ZVs4YIWjJQ4a9lb7QgyPBvaT2PssJp6dLog2D
         0gKlHHN+7BHwr0IMx3GhP2f9V7k/gcjOic02uSe5WHxZY47UoDAaeCE/LNUgl6tlL7
         qHHVa2G5wzca8mD+jllPuOwqQIXCHg2kb2oADB3jDJ4aZw6T101CO0gUZ+mGoyO/Rs
         WEgbAobtJFN3bT42iz2UgJ4mM9ogrTKfAPADbCUYb8EdtJ2pOh0menpAv03N3DAZc5
         kIdKU43kkTR9Q==
Date:   Wed, 22 Jun 2022 11:06:59 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] samples: Use KSYM_NAME_LEN for kprobes
Message-Id: <20220622110659.74a269678bc7c37e15cdebaf@kernel.org>
In-Reply-To: <1654651402-21552-1-git-send-email-yangtiezhu@loongson.cn>
References: <1654651402-21552-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed,  8 Jun 2022 09:23:22 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> It is better and enough to use KSYM_NAME_LEN for kprobes
> in samples, no need to define and use the other values.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  samples/kprobes/kprobe_example.c    | 5 ++---
>  samples/kprobes/kretprobe_example.c | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
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
