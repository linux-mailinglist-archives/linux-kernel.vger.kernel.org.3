Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE84C9186
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbiCARay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiCARax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:30:53 -0500
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.145.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C571D315
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:30:11 -0800 (PST)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 1BD9282B304
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:30:11 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id P6KBnjh6Cb6UBP6KBnWoot; Tue, 01 Mar 2022 11:30:11 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:40034 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nP6KA-002ppM-Do; Tue, 01 Mar 2022 11:30:10 -0600
Message-ID: <a4fa8045-64f9-5550-7f03-b6819aeeb6c4@kernel.org>
Date:   Tue, 1 Mar 2022 18:30:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     paulmck@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, Nicolas Saenz Julienne <nsaenzju@redhat.com>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <20220228104523.01eda61a@gandalf.local.home>
 <6bd3b0083427c6cf1c860a021e097af9052cdd75.camel@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <6bd3b0083427c6cf1c860a021e097af9052cdd75.camel@redhat.com>
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
X-Exim-ID: 1nP6KA-002ppM-Do
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:40034
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
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

On 3/1/22 11:59, Nicolas Saenz Julienne wrote:
>> I wonder if this is similar to what we have in trace_benchmark(). Would
>> using: cond_resched_tasks_rcu_qs() work for you?
> IIUC this only affects tasks_rcu, and doesn't help with regular RCU. We already
> call cond_resched_tasks_rcu_qs() in osnoise when necesary, actually it was
> introduced by you. :)

I tried using cond_resched_tasks_rcu_qs() to solve the same problem before, it
did not work.

-- Daniel
