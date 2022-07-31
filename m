Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60889585FF3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiGaQrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGaQrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097DE011;
        Sun, 31 Jul 2022 09:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A57360F68;
        Sun, 31 Jul 2022 16:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F1AC433C1;
        Sun, 31 Jul 2022 16:47:36 +0000 (UTC)
Date:   Sun, 31 Jul 2022 12:47:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
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
Subject: Re: [PATCH V9 01/16] rv: Add Runtime Verification (RV) interface
Message-ID: <20220731124730.311c8207@rorschach.local.home>
In-Reply-To: <YuaadlzgSJLtzOUw@geo.homenetwork>
References: <cover.1659052063.git.bristot@kernel.org>
        <a4bfe038f50cb047bfb343ad0e12b0e646ab308b.1659052063.git.bristot@kernel.org>
        <YuU7TGxm5pzmBFTx@geo.homenetwork>
        <0197dd47-ea15-4d8b-5fc7-e466d8a501a7@kernel.org>
        <YuaadlzgSJLtzOUw@geo.homenetwork>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022 23:06:31 +0800
Tao Zhou <tao.zhou@linux.dev> wrote:

> > All things above are misled by the first interpretation but,,,  
> 
> Yeah, this is not that clear from my above words expression. I said the return
> value of da_monitor_init_*() will be 0, but it is not right. Global and per-cpu
> monitor will return 0, per-task monitor may return a positive value when the
> slot is equal or greater than RV_PER_TASK_MONITOR_INIT(how possible this will
> happen I do know yet). This is from reading the current code implementation.
> I just want to say that there may be a bug here.

Well, rv_get_monitor_slot() can currently only return 0 or negative.
This is because PER_TASK_MONITORS is just 1 and we can not return that
or greater.

> If rv_enable_monitor() return a positive value and the error happened(as above

With the current code this can not happen, as we only allow for a
single PER_TASK_MONITORS.

But in the future, if we increment this, then you are correct. We can
not just check retval, but need to check retval < 0.

This does need to be fixed. But because it currently isn't an issue
because we they can only return 0 or negative, I'm going to pull this
series in.

But Daniel, these checks do need to be updated. Please send patches on
top of this series to address it.

-- Steve


> said), user space will not know this is a error return value, but regard it as a
> right writing. Even if the return value(the slot value not in [0..RV_PER_TASK_MONITOR_INIT))
> is equal to count of charaters that are writen to the file(the string length of monitor name),
> it will still be not a right writing.
> 
