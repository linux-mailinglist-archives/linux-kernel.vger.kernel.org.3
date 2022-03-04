Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3054CD65D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbiCDO3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbiCDO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:29:46 -0500
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.145.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B116B1B60BA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:28:58 -0800 (PST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 125DA501C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:28:58 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id Q8vRnY7eyXvvJQ8vSn23vL; Fri, 04 Mar 2022 08:28:58 -0600
X-Authority-Reason: nr=8
Received: from host-82-63-1-3.business.telecomitalia.it ([82.63.1.3]:40132 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nQ8vR-0046yN-AP; Fri, 04 Mar 2022 08:28:57 -0600
Message-ID: <78d798aa-388c-70bc-4227-985ba76c1d7e@kernel.org>
Date:   Fri, 4 Mar 2022 15:28:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, paulmck@kernel.org, rostedt@goodmis.org
References: <20220228141423.259691-1-nsaenzju@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220228141423.259691-1-nsaenzju@redhat.com>
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
X-Exim-ID: 1nQ8vR-0046yN-AP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-82-63-1-3.business.telecomitalia.it ([10.0.0.45]) [82.63.1.3]:40132
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

On 2/28/22 15:14, Nicolas Saenz Julienne wrote:
> At the moment running osnoise on an isolated CPU and a PREEMPT_RCU
> kernel might have the side effect of extending grace periods too much.
> This will eventually entice RCU to schedule a task on the isolated CPU
> to end the overly extended grace period, adding unwarranted noise to the
> CPU being traced in the process.
> 
> So, check if we're the only ones running on this isolated CPU and that
> we're on a PREEMPT_RCU setup. If so, let's force quiescent states in
> between measurements.
> 
> Non-PREEMPT_RCU setups don't need to worry about this as osnoise main
> loop's cond_resched() will go though a quiescent state for them.
> 
> Note that this same exact problem is what extended quiescent states were
> created for. But adapting them to this specific use-case isn't trivial
> as it'll imply reworking entry/exit and dynticks/context tracking code.

Hey Nicolas,

While testing this patch with rtla osnoise on the 5.17.0-rc6-rt10+, when I hit
^c on osnoise top, the system freezes :-/.

Could you try that on your system?

-- Daniel
