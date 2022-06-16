Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B3D54EBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378809AbiFPVAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiFPVAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:00:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98F7606C1;
        Thu, 16 Jun 2022 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mjWClmykFoP1P+NE+FHwPy2EeZJYzAdrJuiOYk2mq8A=; b=Bpe2zJD3VPzlHkuFdoWBx6AMC5
        aZqWclk6HsPV30RI9X+EyoXpwJ7U0TybFWXFe3bMQxMD3JYEahQ/LMb11Q/iziReIT9XIbXTW9b09
        h9sFynenOyJp9N2KT+ScMPPA5XKzszARDJB6idzEMEUSssXxkyUneT25zTOBrd4JiOyiqYnYPaR4r
        XPG4LfeVvPr5RIdo4mSt+YKHov3/Zd7osIHEHq5ndkY2J3WbMtKEE4ulC+plqEYYx+F8KT2Jk6dLZ
        buvGdNiNPM2kG2JOY8z3YU9+dH5O6oCEEPAYeODo07w4AU7Gc55HKYWDG7tHN7E3ToZCq3Q7JvSY6
        Yn+5eJKw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1wbE-008VuH-Bg; Thu, 16 Jun 2022 21:00:20 +0000
Message-ID: <4d975ef5-7e50-9241-1a3e-f0f9bad9c5b5@infradead.org>
Date:   Thu, 16 Jun 2022 14:00:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V4 09/20] rv/monitor: wip instrumentation and
 Makefile/Kconfig entries
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
 <9c05a95927c18bebcf0eb79bef15ec59667bc08c.1655368610.git.bristot@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <9c05a95927c18bebcf0eb79bef15ec59667bc08c.1655368610.git.bristot@kernel.org>
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



On 6/16/22 01:44, Daniel Bristot de Oliveira wrote:
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 1eafb5adcfcb..e9246b0bec9d 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -26,6 +26,13 @@ menuconfig RV
>  	  the system behavior.
>  
>  if RV
> +config RV_MON_WIP
> +	depends on PREEMPTIRQ_TRACEPOINTS
> +	select DA_MON_EVENTS_IMPLICIT
> +	bool "WIP monitor"

Does WIP mean work-in-progress?  (It does to me.)

If not, please explain what it means in the help text.

> +	help
> +	  Enable WIP sample monitor, this is a sample monitor that
> +	  illustrates the usage of per-cpu monitors.

thanks.
-- 
~Randy
