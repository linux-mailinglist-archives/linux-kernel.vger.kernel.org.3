Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812EE55228B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbiFTQ6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiFTQ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:58:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48DB25F2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:58:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 74D7F21C13;
        Mon, 20 Jun 2022 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655744294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TAv4YEq/p6G6u7vZ5YxPkQL+CPFIpwK4cxHfo1ilDGo=;
        b=mtBXUebwbZNIPXuzNjvIkGoPvlWFlXKRq6FBhg6F58bwUTWScMc0eqYPIOogjnrxh9R/jd
        8sLN8TmxCG3su0y1y8vdLmvvd7jjff9eYURJ4AZHulIeTrHCpj+iZxY8TTeNCmRZQr4lRP
        h6nlcqHAD7dhlaaRqJrEtcVEGlxDhX8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2D70F2C142;
        Mon, 20 Jun 2022 16:58:14 +0000 (UTC)
Date:   Mon, 20 Jun 2022 18:58:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3] printk: allow direct console printing to be enabled
 always
Message-ID: <YrCnJTIB/7MexV3K@alley>
References: <Yq+xGcBO06ILMUFy@zx2c4.com>
 <20220619233302.601092-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619233302.601092-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-06-20 01:33:02, Jason A. Donenfeld wrote:
> In 5.19, there are some changes in printk message ordering /
> interleaving which leads to confusion. The most obvious (and benign)
> example appears on system boot, in which the "Run /init as init process"
> message gets intermixed with the messages that init actually writes() to
> stdout. For example, here's a snippet from build.wireguard.com:
> 
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -35,6 +35,18 @@ config PRINTK_CALLER
>  	  no option to enable/disable at the kernel command line parameter or
>  	  sysfs interface.
>  
> +config PRINTK_DIRECT
> +	bool "Attempt to flush printk output immediately"
> +	depends on PRINTK
> +	help
> +	  Rather than using kthreads for printk output, always attempt to write
> +	  to the console immediately. This has performance implications, but
> +	  will result in a more faithful ordering and interleaving with other
> +	  processes writing to the console.
> +
> +	  Say N here unless you really need this. This may also be controlled
> +	  at boot time with printk.direct=0/1.
> +

I am fine with the patch except for the config option. Is there
any particular reason why we need it, please?

We should be careful to add new build options in general because they
make building the kernel more complicated. People need to understand
what each option is about and what they want.

Kernel parameters are less intrusive. People need to care about
it only when they need some special behavior. And everyone has
its own default command line anyway. For example, I always use
ignore_loglevel.

Best Regards,
Petr
