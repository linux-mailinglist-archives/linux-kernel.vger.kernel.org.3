Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67275927B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiHOCPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiHOCPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:15:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4823E01E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:15:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q16so5481629pgq.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=drKDgHDwSsoqTiwoI7S5BgD0RGHNdrXV8795qgs2B/o=;
        b=bjjWJkRUd3/swCCxlf/cU3JT61q9YwpoyGsTNyZqQbTYWgx5PBlvLzKlkZWNlfIr9C
         8upFOVZt+Y1n4S0zSufArf1B+FvGx8ST0cFgfIqN6HfeVQevncI8ryHgC0JDyGnkkxGL
         vw6i5kilRLaayg5FCf8X9icubSSW3FtbMoJ4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=drKDgHDwSsoqTiwoI7S5BgD0RGHNdrXV8795qgs2B/o=;
        b=zY37UmsMdi2qRxCPHO8YEh9DBN5EMLcQUZufG9YpaqsiZzXL9AveO3otdOD0EN2GVV
         99MGd3U5Jm++UzIfckhTpJtFjPgcirE27dzRvCjJG0/+K4pS+oWGXbtmCr3LBBrqmoym
         ZbNsvjq8gqE/nfML2D0sSn+W7I3NIzZG4MPNKp7/1mPo1Q5OuVl3lTXFZkN5OXLwDxfs
         xYI9wlzKO063hIf2MdZmprdHwgwAFl/4ItKfp8QTVM3QR/A9uRVdWKNJEkIj5uWKaP4Q
         qmXQcJpjutrF/s6oerELEt7wbEFnWqv+aQL/Qhwh5km5Ya6vgO4NSLGy1MUZ4svUsYPy
         /CKA==
X-Gm-Message-State: ACgBeo0Ry37BWGq9jFHFXKPSgoqIUMSUyxfiC6ODzglt1gXjpV790+ER
        mBnH8qpvJoTB3aV6xosAYkOlHzkEO8D9Bw==
X-Google-Smtp-Source: AA6agR6o2gDKdOMffjCeHU052YwRMO0bG01thlm1gbXjmX3fPbgwVta+aeOEff7zUFWjnsyMglM3qw==
X-Received: by 2002:a05:6a02:49:b0:41e:27a7:7252 with SMTP id az9-20020a056a02004900b0041e27a77252mr11876566pgb.209.1660529722197;
        Sun, 14 Aug 2022 19:15:22 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:110b:946c:84b2:7c95])
        by smtp.gmail.com with ESMTPSA id b6-20020aa79506000000b0052ffc9d4ceesm5719299pfp.69.2022.08.14.19.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 19:15:21 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:15:16 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk: Export log_buf_len to userland
Message-ID: <YvmsNEYPtdOUsaxy@google.com>
References: <a41b5ad3-d052-49b8-e038-b020c1dc6788@tuyoix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a41b5ad3-d052-49b8-e038-b020c1dc6788@tuyoix.net>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing John and Steven

On (22/08/10 14:25), Marc Aurèle La France wrote:
> 
> Make the kernel log's buffer size available to userland so it can be used with
> `dmesg -s`.

And what doesn't work now?

> This change is not eligible for stable@.
> 
> Please Reply-To-All.
> 
> Thanks and have a great day.
> 
> Marc.

These lines don't belong here. Please see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.0-rc1

> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
> 
> diff -aNpRruz -X /etc/diff.excludes linux-5.17.1/include/linux/printk.h devel-5.17.1/include/linux/printk.h
> --- linux-5.17.1/include/linux/printk.h	2022-03-28 02:03:22.000000000 -0600
> +++ devel-5.17.1/include/linux/printk.h	2022-03-28 07:14:10.803008293 -0600
> @@ -318,6 +337,7 @@ extern void __printk_cpu_unlock(void);
>  #endif /* CONFIG_SMP */
> 
>  extern int kptr_restrict;
> +extern u32 log_buf_len;
> 
>  /**
>   * pr_fmt - used by the pr_*() macros to generate the printk format string
> diff -aNpRruz -X /etc/diff.excludes linux-5.17.1/kernel/printk/printk.c devel-5.17.1/kernel/printk/printk.c
> --- linux-5.17.1/kernel/printk/printk.c	2022-03-28 02:03:22.000000000 -0600
> +++ devel-5.17.1/kernel/printk/printk.c	2022-03-28 07:14:10.803008293 -0600
> @@ -404,7 +404,7 @@ static struct latched_seq clear_seq = {
>  #define LOG_BUF_LEN_MAX (u32)(1 << 31)
>  static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
>  static char *log_buf = __log_buf;
> -static u32 log_buf_len = __LOG_BUF_LEN;
> +u32 log_buf_len = __LOG_BUF_LEN;
> 
>  /*
>   * Define the average message size. This only affects the number of
> diff -aNpRruz -X /etc/diff.excludes linux-5.17.1/kernel/printk/sysctl.c devel-5.17.1/kernel/printk/sysctl.c
> --- linux-5.17.1/kernel/printk/sysctl.c	2022-03-28 02:03:22.000000000 -0600
> +++ devel-5.17.1/kernel/printk/sysctl.c	2022-03-28 07:14:10.803008293 -0600
> @@ -22,6 +22,13 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
> 
>  static struct ctl_table printk_sysctls[] = {
>  	{
> +		.procname	= "log_buf_len",
> +		.data		= &log_buf_len,
> +		.maxlen		= sizeof(u32),
> +		.mode		= 0444,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{
>  		.procname	= "printk",
>  		.data		= &console_loglevel,
>  		.maxlen		= 4*sizeof(int),

