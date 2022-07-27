Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB85582A41
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiG0QGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiG0QGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:06:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FFC22515;
        Wed, 27 Jul 2022 09:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7144AB821B2;
        Wed, 27 Jul 2022 16:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA74DC433C1;
        Wed, 27 Jul 2022 16:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658937997;
        bh=5XHQir5HRajZVkwdA1nsiY7rF0CyIi1tGP/Ej1MXlVc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SR4njLkGCtRQJ3ftmswRAWHh/ViyPNjAZRf1LECfzlX9vwebRSx2YzVnz2Yt5geJm
         UVmHLIeM/aqdmfPOtMOrnPAhflq8YJ6ilQ3F49cId+mxj0xMzWKgnWkKgQ4X+yxtgV
         jY3iTRmqxjfP4j3x3roONUwhqbSPCLIjp0euEsOEDMlDzprcEbSBXfL01AUqSrnq1A
         dFpxkO1+z0ugV6PdgTLOtTGPbWn4ZYBqk+a/qov2ElVa+VDFSFwEmJXohuNMNsU+//
         dq/1YffRTAyX95u7lXCVJZLVafPCFucN+4T0SleIK94cbf4vd0vTyM2t7GWpMabnnP
         l4IrbSwNK1TUw==
Message-ID: <973f6718-bb88-724b-0900-5c8eb0c24d78@kernel.org>
Date:   Wed, 27 Jul 2022 18:06:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V7 04/16] rv/include: Add deterministic automata monitor
 definition via C macros
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
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
        linux-trace-devel@vger.kernel.org
References: <cover.1658778484.git.bristot@kernel.org>
 <75d14829c5234c2ff43aff744ac41f246b970ed8.1658778484.git.bristot@kernel.org>
 <YuFZ2scVb658mhoq@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YuFZ2scVb658mhoq@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 17:29, Tao Zhou wrote:
>> +/*
>> + * Handle event for implicit monitor: da_get_monitor_##name() will figure out
>> + * the monitor.
>> + */
>> +#define DECLARE_DA_MON_MONITOR_HANDLER_IMPLICIT(name, type)					\
>> +												\
>> +static inline void __da_handle_event_##name(struct da_monitor *da_mon,				\
>> +					    enum events_##name event)				\
>> +{												\
>> +	int retval;										\
>> +												\
>> +	retval = da_monitor_handling_event_##name(da_mon);					\
>> +	if (!retval)										\
>> +		return;										\
> I checked the callers of __da_handle_event_##name():
> da_handle_event_##name() for all cases need the above check.
> da_handle_start_event_##name() for all cases may not need this check.
> (this function checked the enable first and the da_monitoring later and if
> it is not monitoring it will start monitoring and return, the later event
> handler will not be called. Otherwise enable is enabled, da_monitoring is
> monitoring)
> da_handle_start_run_event_##name() for implicit case may not need this check.
> (almost the same with the above, the difference is if da-monitor is not
> monitoring, it will start monitoring and not return and do the event handler,
> here enable is enabled and da_monitoring is monitoring, if I am not wrong)
> So after another(v7) looking at this patch, I realized that this check can
> be omited in two cases(all three cases). Just in fuction da_handle_event_##name()
> we need to do da_monitor_handling_event_##name().
> So I'd write like this:
> static inline void __da_handle_event_##name(struct da_monitor *da_mon,				\
> 					    enum events_##name event)				\
> {												\
> 	int retval;										\
>                                                     \
>     retval = da_event_##name(da_mon, event);						\
>     if (!retval)										\
>         da_monitor_reset_##name(da_mon);						\
> }												\
> 
> static inline void da_handle_event_##name(enum events_##name event)				\
> {												\
>     struct da_monitor *da_mon = da_get_monitor_##name();					\
> 	int retval;										\
>                                                     \
>     retval = da_monitor_handling_event_##name(da_mon);					\
>     if (!retval)										\
>         return;										\
>                                                     \
>     __da_handle_event_##name(da_mon, event);						\
> 
> }												\
> 

IOW,

The code is checking twice if the monitor is enabled in these two cases:
	- da_handle_start_run_event_##name()
	- da_handle_start_event_##name()

Because it is checking in these functions first and then again in __da_handle_event_##name().

The function da_handle_event_##name() is not checking if the monitors are enabled because
__da_handle_event_##name() does it.

By adding the check on da_handle_event_##name(), we can remove it in
__da_handle_event_##name(). Making the check run only once for all cases.

This is an optimization, and it makes sense.

(changed return value to bool)

-- Daniel
