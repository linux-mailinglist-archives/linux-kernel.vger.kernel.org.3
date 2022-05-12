Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F26524F96
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355096AbiELOMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355102AbiELOMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:12:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5CD63526;
        Thu, 12 May 2022 07:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DFC8B82856;
        Thu, 12 May 2022 14:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7DCC385B8;
        Thu, 12 May 2022 14:12:31 +0000 (UTC)
Date:   Thu, 12 May 2022 10:12:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     mingo@redhat.com, linux@armlinux.org.uk, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] kernel: Ftrace seems to have functions to improve
 performance through optimization
Message-ID: <20220512101229.7886a798@gandalf.local.home>
In-Reply-To: <20220512063017.57412-1-kunyu@nfschina.com>
References: <20220512063017.57412-1-kunyu@nfschina.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 14:30:17 +0800
Li kunyu <kunyu@nfschina.com> wrote:

> At present, it is found that two functions could be optimized, and the
> performance may be improved.

"may be impoved"?

Have any numbers? This changes a very slow path. I do not think it is worth
it for the "optimized". Also it's a weak function. An arch may be added that
wants to return a value.

> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---


>  void ftrace_modify_all_code(int command)
> @@ -2804,12 +2802,7 @@ void __weak arch_ftrace_update_code(int command)
>  
>  static void ftrace_run_update_code(int command)
>  {
> -	int ret;
> -
> -	ret = ftrace_arch_code_modify_prepare();
> -	FTRACE_WARN_ON(ret);

Currently no arch returns anything but zero, but this was added in case
something wrong did happen, and the FTRACE_WARN_ON() is more than just a
WARN_ON(). It will also disable ftrace.

Now, I'm not totally against this change, but not for the rationale in the
change log. That is, there is no optimization here. But as a standard clean
up with something like "There is currently no version of
ftrace_arch_code_modify_prepare() that returns anything bug zero, so the
check is not needed" is a more appropriate reason for this change.

-- Steve


> -	if (ret)
> -		return;
> +	ftrace_arch_code_modify_prepare();
>  
>  	/*
>  	 * By default we use stop_machine() to modify the code.
> @@ -2819,8 +2812,7 @@ static void ftrace_run_update_code(int command)
>  	 */
>  	arch_ftrace_update_code(command);
>  
> -	ret = ftrace_arch_code_modify_post_process();
> -	FTRACE_WARN_ON(ret);
> +	ftrace_arch_code_modify_post_process();
>  }
>  
>  static void ftrace_run_modify_code(struct ftrace_ops *ops, int command,

