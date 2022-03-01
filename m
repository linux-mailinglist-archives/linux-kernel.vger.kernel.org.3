Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFFD4C937B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiCASqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbiCASpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:45:52 -0500
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AECB6A06F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:44:43 -0800 (PST)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id B25D211B400
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:44:42 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id P7UIn3tVVHnotP7UInejSJ; Tue, 01 Mar 2022 12:44:42 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:40042 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nP7UI-004D9R-1S; Tue, 01 Mar 2022 12:44:42 -0600
Message-ID: <c3cf7c0c-27fe-4dfa-4249-a7e1747237a5@kernel.org>
Date:   Tue, 1 Mar 2022 19:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     paulmck@kernel.org, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <137d3573-051f-5374-70d6-cc99b44d00da@kernel.org>
 <b604526d3186f6cd3da189abb70bd1ad9a6105c5.camel@redhat.com>
 <69e92bc6-0917-17e9-1b61-d884d30ba42c@kernel.org>
 <20220301180509.GQ4285@paulmck-ThinkPad-P17-Gen-1>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220301180509.GQ4285@paulmck-ThinkPad-P17-Gen-1>
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
X-Exim-ID: 1nP7UI-004D9R-1S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:40042
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

On 3/1/22 19:05, Paul E. McKenney wrote:
>> I see, as long as it costs < 1 us, I am ok. If it gets > 1us in a reasonably
>> fast machine, we start see HW noise where it does not exist, and that would
>> reduce the resolution of osnoise. AFAICS, it is not causing that problem, but we
>> need to make it as lightweight as possible.
> In the common case, it is atomically incrementing a local per-CPU counter
> and doing a store.  This should be quite cheap.
> 
> The uncommon case is when the osnoise process was preempted or otherwise
> interfered with during a recent RCU read-side critical section and
> preemption was disabled around that critical section's outermost
> rcu_read_unlock().  This can be quite expensive.  But I would expect
> you to just not do this.  ;-)

Getting the expensive call after a preemption is not a problem, it is a side
effect of the most costly preemption.

It this case, we should "ping rcu" before reading the time to account the
overhead for the previous preemption which caused it.

like (using the current code as example):

------------------------- %< -------------------------------
static u64
set_int_safe_time(struct osnoise_variables *osn_var, u64 *time)
{
        u64 int_counter;

        do {
                int_counter = local_read(&osn_var->int_counter);

		------------> HERE <-------------------------------------

                /* synchronize with interrupts */
                barrier();

                *time = time_get();

                /* synchronize with interrupts */
                barrier();
        } while (int_counter != local_read(&osn_var->int_counter));

        return int_counter;
}
------------------------- >% -------------------------------

In this way anything that happens before this *time is accounted before it is
get. If anything happens while this loop is running, it will run again, so it is
safe to point to the previous case.

We would have to make a copy of this function, and only use the copy for the
run_osnoise() case. A good name would be something in the lines of
set_int_safe_time_rcu().

(Unless the expensive is < than 1us.)

-- Daniel

