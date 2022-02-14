Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8474B4176
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbiBNFrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:47:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiBNFrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:47:10 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46854F9C4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:47:02 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebfe.dynamic.kabel-deutschland.de [95.90.235.254])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E6AEB61EA1924;
        Mon, 14 Feb 2022 06:46:59 +0100 (CET)
Message-ID: <bd2a0eb7-2b0b-bb45-3c58-bfce3049bb94@molgen.mpg.de>
Date:   Mon, 14 Feb 2022 06:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 0/3] tick: Fix softirq related warnings
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220208161635.544701-1-frederic@kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220208161635.544701-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Frederic,


Am 08.02.22 um 17:16 schrieb Frederic Weisbecker:
> Some cleanups and debug rework.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	timers/core
> 
> HEAD: 18b00369d58da4c73946d5f8ebed8e8c7ade89e2
> 
> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (3):
>        tick/rcu: Remove obsolete rcu_needs_cpu() parameters
>        tick/rcu: Stop allowing RCU_SOFTIRQ in idle
>        lib/irq_poll: Declare IRQ_POLL softirq vector as ksoftirqd-parking safe
> 
> 
>   include/linux/interrupt.h | 11 ++++++++-
>   include/linux/rcutiny.h   |  3 +--
>   include/linux/rcutree.h   |  2 +-
>   kernel/rcu/tree.c         |  3 +--
>   kernel/time/tick-sched.c  | 60 ++++++++++++++++++++++++++++++++++-------------
>   5 files changed, 57 insertions(+), 22 deletions(-)

I tested this series on the IBM S822LC with Ubuntu 20.10 and rcu/dev 
(commit 0ba8896d2fd7 (lib/irq_poll: Declare IRQ_POLL softirq vector as 
ksoftirqd-parking safe)). Running `sudo ppc64_cpu --smt=off` the 
warnings are gone.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
