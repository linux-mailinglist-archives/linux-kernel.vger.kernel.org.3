Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61CA54EBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378771AbiFPU6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378764AbiFPU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:57:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E041A390;
        Thu, 16 Jun 2022 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=PFkZtmLsuxj6bFObgpPU6iJZEmrUQykuqBIHQOpbhl4=; b=cuX/SlokYz6n6ygd+FK3a+KLZl
        6eSamUGtmBtIJ90sI7e5gZb1TzmkOGAlYjR72r+YIxYReWXZPK5+a+sjn/2pIU39me3XJcxkvjhU+
        cWfgFNAJ2m+/oLXStROeiJ5aUO+NwyXTS1r9qnnDuG3JSCB7YpzXPQnv8SWhF0CiTVc3T95ameoLS
        6ry08EDrIdN57xShRHdNb13StyXqX8qlDeDWI9GzViN2l2sSKBHFbvsaItzywqXFwhZKfhjju6TVT
        jcs0q3TGBjLxjV+f6716pwUvsMIat5iFBAItAEAI9LNTPavd5G5SPieFqwMAU4/Ot7RjdP98j7R18
        6smoYBzQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1wYE-008Vqk-0r; Thu, 16 Jun 2022 20:57:14 +0000
Message-ID: <2a54bec4-5902-b22a-13f2-2237f4b10164@infradead.org>
Date:   Thu, 16 Jun 2022 13:57:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V4 18/20] rv/monitor: Add safe watchdog monitor
Content-Language: en-US
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <6366fdc89d65b8d9b14ccd1e42fa0d793fbe9f73.1655368610.git.bristot@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6366fdc89d65b8d9b14ccd1e42fa0d793fbe9f73.1655368610.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/16/22 01:45, Daniel Bristot de Oliveira wrote:
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 21f03fb3101a..b14ae63e792b 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -45,6 +45,16 @@ config RV_MON_WWNR
>  	  illustrates the usage of per-task monitor. The model is
>  	  broken on purpose: it serves to test reactors.
>  
> +config RV_MON_SAFE_WTD
> +	select DA_MON_EVENTS_IMPLICIT
> +	bool "Safety watchdog"
> +	help
> +	  Enable safe_wtd, this monitor observes the interaction
> +	  between a user-space safety monitor and a watchdog device.
> +
> +	  For futher information see:
> +	    Documentation/trace/rv/safety-monitor.rst

I'm curious about what "WTD" means.

I see lots of WDT in drivers/watchdog/Kconfig
(where it means WatchDog Timer AFAIK).

thanks.
-- 
~Randy
