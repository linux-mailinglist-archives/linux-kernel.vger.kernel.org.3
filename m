Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA0D4D068D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244796AbiCGSaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiCGSav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:30:51 -0500
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.145.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D922FFD8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:29:56 -0800 (PST)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 644E523A2C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:29:53 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id RI7Fnw3uWHnotRI7FnNHUj; Mon, 07 Mar 2022 12:29:53 -0600
X-Authority-Reason: nr=8
Received: from host-82-63-1-3.business.telecomitalia.it ([82.63.1.3]:49480 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nRI7E-000kJQ-K0; Mon, 07 Mar 2022 12:29:52 -0600
Message-ID: <9132fe3d-8248-909d-9b6e-16fe9018dfd1@kernel.org>
Date:   Mon, 7 Mar 2022 19:29:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     rostedt@goodmis.org, paulmck@kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, mtosatti@redhat.com
References: <20220307180740.577607-1-nsaenzju@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220307180740.577607-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 82.63.1.3
X-Source-L: No
X-Exim-ID: 1nRI7E-000kJQ-K0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-82-63-1-3.business.telecomitalia.it ([10.0.0.45]) [82.63.1.3]:49480
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
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

On 3/7/22 19:07, Nicolas Saenz Julienne wrote:
> At the moment running osnoise on a nohz_full CPU or uncontested FIFO
> priority and a PREEMPT_RCU kernel might have the side effect of
> extending grace periods too much. This will entice RCU to force a
> context switch on the wayward CPU to end the grace period, all while
> introducing unwarranted noise into the tracer. This behaviour is
> unavoidable as overly extending grace periods might exhaust the system's
> memory.
> 
> This same exact problem is what extended quiescent states (EQS) were
> created for, conversely, rcu_momentary_dyntick_idle() emulates them by
> performing a zero duration EQS. So let's make use of it.
> 
> In the common case rcu_momentary_dyntick_idle() is fairly inexpensive:
> atomically incrementing a local per-CPU counter and doing a store. So it
> shouldn't affect osnoise's measurements (which has a 1us granularity),
> so we'll call it unanimously.
> 
> The uncommon case involve calling rcu_momentary_dyntick_idle() after
> having the osnoise process:
> 
>  - Receive an expedited quiescent state IPI with preemption disabled or
>    during an RCU critical section. (activates rdp->cpu_no_qs.b.exp
>    code-path).
> 
>  - Being preempted within in an RCU critical section and having the
>    subsequent outermost rcu_read_unlock() called with interrupts
>    disabled. (t->rcu_read_unlock_special.b.blocked code-path).
> 
> Neither of those are possible at the moment, and are unlikely to be in
> the future given the osnoise's loop design. On top of this, the noise
> generated by the situations described above is unavoidable, and if not
> exposed by rcu_momentary_dyntick_idle() will be eventually seen in
> subsequent rcu_read_unlock() calls or schedule operations.
> 
> Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

I've been running a preliminary version of this patch over the weekend, and it
provides the desired behavior.

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
