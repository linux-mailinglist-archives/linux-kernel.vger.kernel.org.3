Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E914CD80D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbiCDPiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiCDPiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:38:18 -0500
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.143.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C832821A1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:37:29 -0800 (PST)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id EA73022D0D7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:37:28 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id Q9zknZmGWXvvJQ9zkn3bvR; Fri, 04 Mar 2022 09:37:28 -0600
X-Authority-Reason: nr=8
Received: from host-82-63-1-3.business.telecomitalia.it ([82.63.1.3]:40142 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nQ9zk-001CZJ-0l; Fri, 04 Mar 2022 09:37:28 -0600
Message-ID: <bc048c18-0ba7-1cb9-90a0-0bc049997c23@kernel.org>
Date:   Fri, 4 Mar 2022 16:37:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, paulmck@kernel.org, rostedt@goodmis.org,
        Juri Lelli <juri.lelli@redhat.com>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <78d798aa-388c-70bc-4227-985ba76c1d7e@kernel.org>
 <b5e1f0d14a48c0815863af623cedbdc8c1bc255f.camel@redhat.com>
 <abb789c3-0d1a-28e9-3b8d-e4a68e3f57f5@kernel.org>
 <2b47679c6248a0d113b556ed6118e8ed72c74b29.camel@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <2b47679c6248a0d113b556ed6118e8ed72c74b29.camel@redhat.com>
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
X-Exim-ID: 1nQ9zk-001CZJ-0l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-82-63-1-3.business.telecomitalia.it ([10.0.0.45]) [82.63.1.3]:40142
X-Source-Auth: kernel@bristot.me
X-Email-Count: 5
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 16:28, Nicolas Saenz Julienne wrote:
> Some comments:
>  - You're not exiting/entering EQS on IRQ/NMI entry/exit. See
>    irqentry_{enter,exit}() and irqentry_nmi_{enter,exit}().

hummm, right!

>  - See this series[1], if we ever pursue this approach, it's important we got
>    through context tracking, instead of poking at RCU directly.

I had a test patch with context_tracking as well... entering and leaving using
it. Lemme find it.... but it basically works in the same way as for RCU (or
pretend to work).

> 
> [1] https://lore.kernel.org/lkml/20220302154810.42308-1-frederic@kernel.org/T/#t

