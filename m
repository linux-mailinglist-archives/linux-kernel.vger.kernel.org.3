Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC22257CE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiGUOqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGUOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:46:31 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D296D9DB;
        Thu, 21 Jul 2022 07:46:30 -0700 (PDT)
Date:   Thu, 21 Jul 2022 22:46:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658414788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LZnrhTW0Fqj+gV1iEGOju+ZSnDl7pKjgf6K7E8bIcz8=;
        b=D4yelCpm2fyujnx6Wu3TMrwsEHCJ1zhM8vfCiRrX+f1zKcZixf8h767as8kaFyvN+bWx6E
        ebbE5kvn0INXrsPDyDSKRRETbJzuEn503qshdDuA4SHITokWVT2ZiDSCN8JU6uR9yemMHt
        3aXpmZa9Yzf2cq2rB8W0mlP0dESyav0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V6 02/16] rv: Add runtime reactors interface
Message-ID: <Ytlmu9xYkXXwIhip@geo.homenetwork>
References: <cover.1658244826.git.bristot@kernel.org>
 <4b5f93e3186b067073c1692d4c2b50d0b42101d5.1658244826.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b5f93e3186b067073c1692d4c2b50d0b42101d5.1658244826.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 07:27:07PM +0200, Daniel Bristot de Oliveira wrote:

> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index b6bcdb4888e6..4f5b70eee557 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -7,6 +7,12 @@
>  #ifndef _LINUX_RV_H
>  #define _LINUX_RV_H
>  
> +struct rv_reactor {
> +	char			*name;
> +	char			*description;
> +	void			(*react)(char *msg);
> +};

Like the definition of name and description in structure rv_monitor,
use `const char *` for name and description.

> +#ifdef CONFIG_RV_REACTORS
> +struct rv_reactor_def {
> +	struct list_head	list;
> +	struct rv_reactor	*reactor;
> +	/* protected by the monitor interface lock */
> +	int			counter;

Not see the `counter` be used(inc/dec).

> +};
> +#endif
