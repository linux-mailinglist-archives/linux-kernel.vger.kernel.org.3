Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66984CD694
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiCDOl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiCDOly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:41:54 -0500
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.50.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9464C1BD043
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:41:07 -0800 (PST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 00C9BA472D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:41:07 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id Q95Gnu2ub22u3Q95GnmMIj; Fri, 04 Mar 2022 08:39:06 -0600
X-Authority-Reason: nr=8
Received: from host-82-63-1-3.business.telecomitalia.it ([82.63.1.3]:40134 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nQ95G-004JWf-54; Fri, 04 Mar 2022 08:39:06 -0600
Message-ID: <9befaa4d-b032-0b26-761e-9e2e06b1a64b@kernel.org>
Date:   Fri, 4 Mar 2022 15:39:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, paulmck@kernel.org, rostedt@goodmis.org
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <78d798aa-388c-70bc-4227-985ba76c1d7e@kernel.org>
 <b5e1f0d14a48c0815863af623cedbdc8c1bc255f.camel@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <b5e1f0d14a48c0815863af623cedbdc8c1bc255f.camel@redhat.com>
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
X-Exim-ID: 1nQ95G-004JWf-54
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-82-63-1-3.business.telecomitalia.it ([10.0.0.45]) [82.63.1.3]:40134
X-Source-Auth: kernel@bristot.me
X-Email-Count: 10
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 15:36, Nicolas Saenz Julienne wrote:
>> Hey Nicolas,
>>
>> While testing this patch with rtla osnoise on the 5.17.0-rc6-rt10+, when I hit
>> ^c on osnoise top, the system freezes :-/.
>>
>> Could you try that on your system?
> Yes of course, I'll get a build going.
> 
> Were you using nohz_full?

Yep!

mce=off tsc=nowatchdog nohz=on intel_pstate=disable nosoftlockup isolcpus=11-23
nohz_full=11-23 rcu_nocbs=11-23

(I know what people thing about isolcpus, I am just lazy).

-- Daniel
