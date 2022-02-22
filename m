Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D84BEF67
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbiBVCLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:11:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiBVCLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:11:14 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF5124BE1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:10:50 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m22so3036272pja.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LkXCeMETVGrdnKNJuMO1AGVw8fBt1JlBhEXdXZ0UGeg=;
        b=F1bl4q0YkVSasyLLYUbnDjNAHs/HssWBpVQEixgFa3q0BbCDzl/adCunF5UgVrSYQu
         XjVcTc3q7J0PZ/5zBEaBN77+CRPd09VQ0/66UcbAaO116oMl5q16SMSstiaDP7LSyuhW
         ik8B+MXMdvmPbKwlRa0mJ/CnZINQD08mgtvVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LkXCeMETVGrdnKNJuMO1AGVw8fBt1JlBhEXdXZ0UGeg=;
        b=x1FJt+jJklGgxeTut34dMVK9IlWkNKsr4XM5HCTCDdTJiOt/gGFeKv/7sme+BAip2s
         FidroL9TwKImD1OS1QEJzq6UnhO9GD9/A2yG3DGOu4+LJJNsY2UFKl1h2vECrRcpMduM
         rHerxbQ0z8yIwyoujgghXLj4uXgV1K/wvY8uIndeN9feEiT+oonfdQhHUXc40tuKzYYj
         yl5xpMlMs1gdlwKsllIjzy+UIRVME985zZe1+O+gF31q5HAo4DuzUbjeE5RjFJ4DPU4I
         KuOvIRJrE94/1qiqCUYRYfLgb4HI97NBESSQEo2TRqvwy7QJpSc8vzsSwkqP0LiOy/f7
         MN+Q==
X-Gm-Message-State: AOAM533wAwHBAwn2R1tkLrkMx1BIbeUXUzTNzNCkeihrz3fhDlgeHCC2
        7ngCd1P47ut22OYJvJ8ZiV4Iag==
X-Google-Smtp-Source: ABdhPJzBoTpYA4xIPYn4nRsx4uCUz7FGK1VuOWdTQh+7zh+iK4IaxHROZF3z3ovfjZM5bo6h7DiI8g==
X-Received: by 2002:a17:902:7403:b0:14f:9f55:f9e6 with SMTP id g3-20020a170902740300b0014f9f55f9e6mr10531823pll.21.1645495849589;
        Mon, 21 Feb 2022 18:10:49 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3f16:2239:960e:24f])
        by smtp.gmail.com with ESMTPSA id p10sm15181086pfo.209.2022.02.21.18.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 18:10:49 -0800 (PST)
Date:   Tue, 22 Feb 2022 11:10:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, bhe@redhat.com, pmladek@suse.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <YhRGI51mOEy2EAZb@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhRFNKtxSE8Xrbfw@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial typo:

On (22/02/22 11:06), Sergey Senozhatsky wrote:
> @@ -286,6 +289,8 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> 
> 
> +	panic_print_sys_info(panic_print & ~PANIC_PRINT_ALL_PRINTK_MSG);
> 
> 
>  	kmsg_dump(KMSG_DUMP_PANIC);
>   
>  	/*
> @@ -316,7 +321,7 @@ void panic(const char *fmt, ...)
>  	debug_locks_off();
>  	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> 

+	panic_print_sys_info(panic_print & PANIC_PRINT_ALL_PRINTK_MSG);



I also wonder if we want to CONSOLE_FLUSH_PENDING when
PANIC_PRINT_ALL_PRINTK_MSG set.
