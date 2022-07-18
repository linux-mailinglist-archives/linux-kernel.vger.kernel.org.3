Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36B577CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiGRHy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiGRHy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0051D112F;
        Mon, 18 Jul 2022 00:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E96061366;
        Mon, 18 Jul 2022 07:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418BCC341C0;
        Mon, 18 Jul 2022 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658130865;
        bh=tWt1vYWDaTVxwRFLqeGhQ6xsXw83LhS7SS6nHo2L++A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PGd1WO1dR1rdIH2fiN+CBoHkIbKQMUkLabEOE/zWsuFuZ6UuEGL7rkfudlsSYo1Jj
         gaG92VUCo+9XH9rhN5pikSlXD9kiu9dStrvLRufQfQYcgBzYIlZ07PvGRhkSKaUc/A
         6OWULNC8ouxJIWUgNVDMwi0v+Fuje0GdSEtdzIUXWbFKpUQaKO85DgKp/ZkffoYctk
         J8dbil1nRSO99qGsF9sOuI8glmcDOTqmtnN5Ag7tu9AlJa2pKnmZoe85rvXbom5ezf
         nnhyXIVyrmGdsy3e3UFjGmzTSQHV9f3wRQO/8CPy+ZQPHdhCNKhvu/5AdIBknHs4og
         oJgIcck1Nyhvg==
Message-ID: <26677d42-337c-8786-f10a-0d87a14ae15c@kernel.org>
Date:   Mon, 18 Jul 2022 09:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V5 04/16] rv/include: Add deterministic automata monitor
 definition via C macros
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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
References: <cover.1657745645.git.bristot@kernel.org>
 <5e0447aa9d114c52fd2bc335de036c61d9625f1c.1657745645.git.bristot@kernel.org>
 <YtQoYMLHgvTV0lea@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YtQoYMLHgvTV0lea@geo.homenetwork>
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

On 7/17/22 17:18, Tao Zhou wrote:
>> +static int task_mon_slot_##name = RV_PER_TASK_MONITOR_INIT;			\
> In patch1, RV_PER_TASK_MONITOR_INIT is defined as:
> 
> #define RV_PER_TASK_MONITORS           1
> #define RV_PER_TASK_MONITOR_INIT	  (RV_PER_TASK_MONITORS)
> 
> RV_PER_TASK_MONITOR_INIT is 1 now, seems not the index of the first only
> element in vector. Now no map here, one task has one monitor though if I
> am not wrong.
> So task_mon_slot_##name must be defined to the index of first element.
> Modify the macro definition of RV_PER_TASK_MONITOR_INIT to the index of
> first element in vector.
> 
> #define RV_PER_TASK_MONITOR_INIT	  (RV_PER_TASK_MONITORS) - 1

nop, (RV_PER_TASK_MONITORS) is an invalid vector value, so we can detect things like:
disabling a disabled monitor.

(I forgot to reset it when disabling a monitor... added)

-- Daniel
