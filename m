Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B3467A5C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381822AbhLCPiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:38:19 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.125]:30016 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245142AbhLCPiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:38:18 -0500
X-Greylist: delayed 1488 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2021 10:38:18 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id B175F41221
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 09:08:48 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id t9vpm3oyCT9yft9vpm3ZcR; Fri, 03 Dec 2021 08:53:02 -0600
X-Authority-Reason: nr=8
Received: from host-79-34-250-122.business.telecomitalia.it ([79.34.250.122]:47264 helo=[10.0.0.165])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mt9vo-002vgX-Ag; Fri, 03 Dec 2021 08:53:00 -0600
Message-ID: <97ede09d-0317-d25d-419e-967c57e289c1@kernel.org>
Date:   Fri, 3 Dec 2021 15:52:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V8 02/14] rtla: Helper functions for rtla
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1638182284.git.bristot@kernel.org>
 <8fbb0e5ab5b39ba3c981fc97a3f93471d291cffc.1638182284.git.bristot@kernel.org>
 <YaneZTnR+leNRzNN@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YaneZTnR+leNRzNN@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.34.250.122
X-Source-L: No
X-Exim-ID: 1mt9vo-002vgX-Ag
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-34-250-122.business.telecomitalia.it ([10.0.0.165]) [79.34.250.122]:47264
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 10:07, Tao Zhou wrote:
> On Mon, Nov 29, 2021 at 12:07:40PM +0100,
> Daniel Bristot de Oliveira wrote:
> 
>> +/*
>> + * enable_tracer_by_name - enable a tracer on the given instance
>> + */
>> +int enable_tracer_by_name(struct tracefs_instance *inst, const char *tracer)
>> +{ 
>> +	enum tracefs_tracers t;
>> +	int retval;
>> +
>> +	t = TRACEFS_TRACER_CUSTOM;
>> +
>> +	debug_msg("enabling %s tracer\n", tracer);
>> +
>> +	retval = tracefs_tracer_set(inst, t, tracer);
> The comment of parameters used for tracefs_tracer_set() says:
> 
> '
>  * tracefs_set_tracer - function to set the tracer
>  * @instance: ftrace instance, can be NULL for top tracing instance
>  * @tracer: The tracer enum that defines the tracer to be set
>  * @t: A tracer name if TRACEFS_TRACER_CUSTOM is passed in for @tracer
> '
> 
> tracefs_tracer_set(inst, tracer, t); @tracer is enum and @t is tracer
> name. this is not important.
> 

cosmetics.

Anyway: s/tracer/tracer_name/ ; s/t/tracer/

-- Daniel


