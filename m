Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE7D46854A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385185AbhLDOUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:20:07 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.252]:20871 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1385174AbhLDOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:20:06 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 8AE2FEFC9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 08:16:38 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id tVqAmbEaklpqdtVqAmHW5Z; Sat, 04 Dec 2021 08:16:38 -0600
X-Authority-Reason: nr=8
Received: from host-79-34-250-122.business.telecomitalia.it ([79.34.250.122]:59996 helo=[10.0.0.166])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mtVq9-0022Oy-3q; Sat, 04 Dec 2021 08:16:37 -0600
Message-ID: <858068da-0b2c-36f0-3ac0-9d223863ea28@kernel.org>
Date:   Sat, 4 Dec 2021 15:16:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V8 00/14] RTLA: An interface for osnoise/timerlat tracers
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
 <YatsNcmqxnMZ5ONS@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YatsNcmqxnMZ5ONS@geo.homenetwork>
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
X-Exim-ID: 1mtVq9-0022Oy-3q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-34-250-122.business.telecomitalia.it ([10.0.0.166]) [79.34.250.122]:59996
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/21 14:25, Tao Zhou wrote:
> On Mon, Nov 29, 2021 at 12:07:38PM +0100, Daniel Bristot de Oliveira wrote:
> 
>> The rtla(1) is a meta-tool that includes a set of commands that
>> aims to analyze the real-time properties of Linux. But instead of
>> testing Linux as a black box, rtla leverages kernel tracing
>> capabilities to provide precise information about the properties
>> and root causes of unexpected results.
>>
>> To start, it presents an interface to the osnoise and timerlat tracers.
>> In the future, it will also serve as home to the rtsl [1] and other
>> latency/noise tracers.
>>
>> If you just want to run it, you can download the tarball here:
>>   - https://bristot.me/files/rtla/tarball/rtla-0.4.tar.bz2
>>
>> To compile rtla on fedora you need:
>>   $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git
>>   $ cd libtraceevent/
>>   $ make
>>   $ sudo make install
>>   $ cd ..
>>   $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git
>>   $ cd libtracefs/
>>   $ make
>>   $ sudo make install
>>   $ cd ..
>>   $ sudo dnf install python3-docutils procps-devel
>>   $ cd $rtla_src
>>   $ make
>>   $ sudo make install
> 
> Set osnoise/x to DEADLINE, the return is not success. see:
> 
> tao@geo ~/opensource/rtla-0.4 $ sudo rtla osnoise top -P d:100us:1ms -c 0-3 -r 900000 -d 1M -q
> boost_with_deadline failed to boost pid 4766: Operation not permitted
> Failed to set sched parameters

Did you disable the admission control?

e.g.,

  $ sudo sysctl -w kernel.sched_rt_runtime_us=-1

-- Daniel
