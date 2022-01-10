Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D110F4892A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 08:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbiAJHpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 02:45:55 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.184]:11168 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241319AbiAJHiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:38:00 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id EBAEDD7E5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:37:56 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id 6pFcn2Y6WqH056pFcngXwZ; Mon, 10 Jan 2022 01:37:56 -0600
X-Authority-Reason: nr=8
Received: from host-79-52-207-139.retail.telecomitalia.it ([79.52.207.139]:48376 helo=[10.0.0.71])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1n6pFc-003a54-7b; Mon, 10 Jan 2022 01:37:56 -0600
Message-ID: <b8c59498-8ee2-0049-e215-93ed082aef0f@kernel.org>
Date:   Mon, 10 Jan 2022 08:37:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] tracing/osnoise: Properly unhook events if
 start_per_cpu_kthreads() fails
Content-Language: en-US
To:     Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel@openvz.org
References: <20220109153459.3701773-1-nikita.yushchenko@virtuozzo.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220109153459.3701773-1-nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.52.207.139
X-Source-L: No
X-Exim-ID: 1n6pFc-003a54-7b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-52-207-139.retail.telecomitalia.it ([10.0.0.71]) [79.52.207.139]:48376
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/22 16:34, Nikita Yushchenko wrote:
> If start_per_cpu_kthreads() called from osnoise_workload_start() returns
> error, event hooks are left in broken state: unhook_irq_events() called
> but unhook_thread_events() and unhook_softirq_events() not called, and
> trace_osnoise_callback_enabled flag not cleared.
> 
> On the next tracer enable, hooks get not installed due to
> trace_osnoise_callback_enabled flag.
> 
> And on the further tracer disable an attempt to remove non-installed
> hooks happened, hitting a WARN_ON_ONCE() in tracepoint_remove_func().
> 
> Fix the error path by adding the missing part of cleanup.
> While at this, introduce osnoise_unhook_events() to avoid code
> duplication between this error path and normal tracer disable.
> 
> Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
> Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks Nikita!
-- Daniel
