Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093B6586043
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiGaRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGaRth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 13:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7998DB4A9;
        Sun, 31 Jul 2022 10:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C697260FEB;
        Sun, 31 Jul 2022 17:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7C1C433D6;
        Sun, 31 Jul 2022 17:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659289772;
        bh=3A75P4su/8E8y0yASTst8ObkOtAbAvd6xg9cUj4Lnl0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FP5onuuDGImR7EX5M/M6q1jONwRdIgLbCc3URSda8B83ujN+FuZUBt896XxObyGat
         Y3Zg0Oq/ZT4tKNn+DUDAfR37zHEtBtpCCnJI6xtdSRDQk8TdSIX9+tfwO9T6PM9ymw
         JXHw6d7/kQsGlsUE1nCLFNhzyUewU3aykapVm9bC2xBgUanobR1trQajZsc2yL3Kh9
         An/F1TQdq78gZw7YHPzIlFS8/V0CcdUSGkS+d4lmuc9subCB9j6Pyit9l3MXMNew/0
         hXgsyiLBEd7dKXrAZM6QKHUhGyJ8A/oLkP5UMfaJhSnZHaAInKYgL6Ws/LizpNvhJz
         E7aJzLObwjJQA==
Message-ID: <5431c5e4-a8b0-738c-5143-3976cb904b9a@kernel.org>
Date:   Sun, 31 Jul 2022 19:49:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V9 01/16] rv: Add Runtime Verification (RV) interface
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, Tao Zhou <tao.zhou@linux.dev>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1659052063.git.bristot@kernel.org>
 <a4bfe038f50cb047bfb343ad0e12b0e646ab308b.1659052063.git.bristot@kernel.org>
 <YuU7TGxm5pzmBFTx@geo.homenetwork>
 <0197dd47-ea15-4d8b-5fc7-e466d8a501a7@kernel.org>
 <YuaadlzgSJLtzOUw@geo.homenetwork>
 <20220731124730.311c8207@rorschach.local.home>
 <20220731130144.26576a6a@rorschach.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220731130144.26576a6a@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/22 19:01, Steven Rostedt wrote:
> static int da_monitor_init_##name(void)                                                         \
> {                                                                                               \
>         int slot;                                                                               \
>                                                                                                 \
>         slot = rv_get_task_monitor_slot();  <- if this returns positive, things break           \
>         if (slot < 0 || slot >= RV_PER_TASK_MONITOR_INIT)                                       \
> 
> And we probably need slot to be negative if it is greater or equal to RV_PER_TASK_MONITOR_INIT.
> 
>                 return slot;                                                                    \
>                                 

ok, there will be a problem when RV_PER_TASK_MONITOR_INIT changes to > 1. This will need to be patched to
return negative. So far we have only one because there is only one per task monitor.

-- Daniel
