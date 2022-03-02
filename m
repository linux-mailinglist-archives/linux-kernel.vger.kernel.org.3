Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21434C9ECD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbiCBIBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiCBIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:01:15 -0500
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.47.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD810B6D08
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:00:32 -0800 (PST)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id DCCD013DD4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:00:31 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id PJuQnHwPldx86PJuRnZRCn; Wed, 02 Mar 2022 02:00:31 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:40076 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nPJuQ-000ywp-8X; Wed, 02 Mar 2022 02:00:30 -0600
Message-ID: <fc5793b2-e4f7-8639-3bbb-c934cd909c5c@kernel.org>
Date:   Wed, 2 Mar 2022 09:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/histogram: Fix sorting on old "cpu" value
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
References: <20220301225728.100f17af@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220301225728.100f17af@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.232.30.176
X-Source-L: No
X-Exim-ID: 1nPJuQ-000ywp-8X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:40076
X-Source-Auth: kernel@bristot.me
X-Email-Count: 4
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 04:57, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> When trying to add a histogram against an event with the "cpu" field, it
> was impossible due to "cpu" being a keyword to key off of the running CPU.
> So to fix this, it was changed to "common_cpu" to match the other generic
> fields (like "common_pid"). But since some scripts used "cpu" for keying
> off of the CPU (for events that did not have "cpu" as a field, which is
> most of them), a backward compatibility trick was added such that if "cpu"
> was used as a key, and the event did not have "cpu" as a field name, then
> it would fallback and switch over to "common_cpu".
> 
> This fix has a couple of subtle bugs. One was that when switching over to
> "common_cpu", it did not change the field name, it just set a flag. But
> the code still found a "cpu" field. The "cpu" field is used for filtering
> and is returned when the event does not have a "cpu" field.
> 
> This was found by:
> 
>   # cd /sys/kernel/tracing
>   # echo hist:key=cpu,pid:sort=cpu > events/sched/sched_wakeup/trigger
>   # cat events/sched/sched_wakeup/hist
> 
> Which showed the histogram unsorted:
> 
> { cpu:         19, pid:       1175 } hitcount:          1
> { cpu:          6, pid:        239 } hitcount:          2
> { cpu:         23, pid:       1186 } hitcount:         14
> { cpu:         12, pid:        249 } hitcount:          2
> { cpu:          3, pid:        994 } hitcount:          5
> 
> Instead of hard coding the "cpu" checks, take advantage of the fact that
> trace_event_field_field() returns a special field for "cpu" and "CPU" if
> the event does not have "cpu" as a field. This special field has the
> "filter_type" of "FILTER_CPU". Check that to test if the returned field is
> of the CPU type instead of doing the string compare.
> 
> Also, fix the sorting bug by testing for the hist_field flag of
> HIST_FIELD_FL_CPU when setting up the sort routine. Otherwise it will use
> the special CPU field to know what compare routine to use, and since that
> special field does not have a size, it returns tracing_map_cmp_none.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1e3bac71c505 ("tracing/histogram: Rename "cpu" to "common_cpu"")
> Reported-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

It works!

Tested-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel
