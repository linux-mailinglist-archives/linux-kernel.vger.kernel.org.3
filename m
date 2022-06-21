Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C756D552E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346968AbiFUJQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiFUJQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:16:24 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BE512D05
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:16:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d17so3566369pfq.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0wG6MAXSgpsYHVwdLTnIOIj0m6q8i0sT8yR5gRvMp6Y=;
        b=S4748r1BfaiQYiaeN2DZ7ZrOvBbUI6nz98a1fvleMcEvEVrsKA4WbfWPaFz3tQ/W17
         ap/40lJtGhvJNLAiNPSw+rkuWsUuEec/LodIVjYykMKRkTmD+hX5zC6l/C62puK8Ytyz
         uzP08QHaOkfzAyQCdHQFB5iCWaRu709H1DFSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0wG6MAXSgpsYHVwdLTnIOIj0m6q8i0sT8yR5gRvMp6Y=;
        b=DdN4ffCAQHU+FCfyr75Ayp4utgAj2tbeXi2wyFaCqBvfgka7yNWhxwK2K1WBXgVy5+
         W4cEx/g7i+E1hH6mGllRFypDVkZDtX7NTz3oPKkE4eEv99PN7o89mRJOjKhqae9gFZ11
         HjgUcBE89cZPyO5rAUAS4g4vLpCIqTFUp7hkVRFSr2dkdFw/wZppDjbGhecIcIBfj5qi
         I81aJBm7+pKGR6tcvOS2hPa/UKZkmzk+Hdb61uU/JpKOT/gLTzkQcJ7luMJU+16WpQ8H
         NL3YV5uYhBfJ3AeYYeDbpm0atvFau91E+BxqvHa58vPcGG2thSsuDASpUTZD9hrrxvxv
         ztvQ==
X-Gm-Message-State: AJIora/jmlM/gyrIHRPHG3aNx8m59Qw6nMZ7DTO2Bj+tIkCeQQjEC8SS
        VJ14zPSHs0gy+lLiFBsuUlJuGg==
X-Google-Smtp-Source: AGRyM1vIaF6FdtD9LERuY11XqxVkuFMeFkdzTBUqAdmL/TkA54uSgy+jTZMe8CJaIeQlS8P/SYV6BA==
X-Received: by 2002:a05:6a00:150a:b0:525:3030:fe41 with SMTP id q10-20020a056a00150a00b005253030fe41mr5582203pfu.37.1655802983683;
        Tue, 21 Jun 2022 02:16:23 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f227:a4c6:596:a12c])
        by smtp.gmail.com with ESMTPSA id d21-20020a056a0010d500b005251c3e7ac5sm4689597pfu.166.2022.06.21.02.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 02:16:22 -0700 (PDT)
Date:   Tue, 21 Jun 2022 18:16:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] printk/console: Enable console kthreads only when
 there is no boot console left
Message-ID: <YrGMYk0LsbKewzPU@google.com>
References: <20220621090900.GB7891@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220621090900.GB7891@pathway.suse.cz>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/21 11:09), Petr Mladek wrote:
> Threaded console printing does not take into consideration that boot
> consoles may be accessing the same hardware as normal consoles and thus
> must not be called in parallel.
> 
> Since it is currently not possible to identify which consoles are
> accessing the same hardware, delay threaded console printing activation
> until it is known that there are no boot consoles registered.
> 
> Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
> Link: https://lore.kernel.org/r/2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com
> Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
> Reported-by: Marek Behún <kabel@kernel.org>
> [john.ogness@linutronix.de: Better description of the problem.]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

[..]
> +static int __init printk_activate_kthreads(void)
> +{
> +	struct console *con;
> +
> +	console_lock();
> +	printk_kthreads_available = true;
> +	for_each_console(con)
> +		printk_start_kthread(con);
> +	console_unlock();
> +
> +	return 0;
> +}
> +
>  /*
>   * Some boot consoles access data that is in the init section and which will
>   * be discarded after the initcalls have been run. To make sure that no code
> @@ -3567,6 +3580,7 @@ void __init console_init(void)
>   */
>  static int __init printk_late_init(void)
>  {
> +	bool no_bootcon = true;
>  	struct console *con;
>  	int ret;
>  
> @@ -3588,7 +3602,10 @@ static int __init printk_late_init(void)
>  			pr_warn("bootconsole [%s%d] uses init memory and must be disabled even before the real one is ready\n",
>  				con->name, con->index);
>  			unregister_console(con);
> +			continue;
>  		}
> +
> +		no_bootcon = false;
>  	}
>  	ret = cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", NULL,
>  					console_cpu_notify);
> @@ -3597,23 +3614,19 @@ static int __init printk_late_init(void)
>  					console_cpu_notify, NULL);
>  	WARN_ON(ret < 0);
>  	printk_sysctl_init();
> -	return 0;
> -}
> -late_initcall(printk_late_init);
> -
> -static int __init printk_activate_kthreads(void)
> -{
> -	struct console *con;
>  
> -	console_lock();
> -	printk_kthreads_available = true;
> -	for_each_console(con)
> -		printk_start_kthread(con);
> -	console_unlock();
> +	/*
> +	 * Boot consoles may be accessing the same hardware as normal
> +	 * consoles and thus must not be called in parallel. Therefore
> +	 * only activate threaded console printing if it is known that
> +	 * there are no boot consoles registered.
> +	 */
> +	if (no_bootcon)
> +		printk_activate_kthreads();

A quick question. Here we still can have bootcon which can unregistered
later, right? Do you think it'll make sense to check if printing kthreads
can be safely started and start them if so (if no CON_BOOT found and kthreads
are not already created) at the end of unregister_console()?
